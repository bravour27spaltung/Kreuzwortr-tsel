#!/usr/bin/env python3
"""Phase 5 – Rätsel-Generator: Rastervorlagen + Fragen -> fertige Schwedenrätsel.

Ablauf je Vorlage und Seed:
  1. Vorlage als Skelett an den Füll-Solver (tools/solver/fill_solver.cpp) geben, Wortpool = nur Wörter mit Frage.
  2. Lösung unabhängig prüfen (Wort im Pool, Länge, keine Doppelten, Kreuzungen, alle weißen Zellen belegt).
  3. Frage je Wort wählen, Qualitätsprüfung (zu viele Funktionswörter, doppelte Fragetexte) -> Status 'veroeffentlicht'
     oder 'entwurf' (mit --nur-veroeffentlichbare werden solche Rätsel verworfen und weitere Seeds probiert).
  Funktionswörter (tools/generator/funktionswoerter.txt) bekommen für die Wortwahl eine gedeckelte Häufigkeit,
  damit die häufigkeitsgewichtete Suche nicht bevorzugt DIE/DER/ICH einsetzt.
  4. Ausgabe als JSON für die App (public/raetsel/) und als SQL-Seed für Supabase (supabase/seed/raetsel_seed.sql).

Aufruf (im Repo-Wurzelverzeichnis):
  g++ -O2 -std=c++17 -o /tmp/fill_solver tools/solver/fill_solver.cpp
  python3 tools/generator/generate_raetsel.py --solver /tmp/fill_solver --pro-vorlage 3 --nur-veroeffentlichbare

Für wiederkehrende Läufe, die den Bestand ergänzen statt ihn zu ersetzen (z. B. den wöchentlichen
GitHub-Actions-Job, siehe .github/workflows/generate-raetsel.yml): --anhaengen zusätzlich angeben.
Dann enthält --sql nur die NEU erzeugten Rätsel (zum direkten Einspielen), während public/raetsel/index.json
den vollständigen, kumulativen Bestand bekommt.
"""
import argparse, csv, json, os, random, re, subprocess, sys, tempfile
from collections import Counter

MAX_FUNKTIONSWOERTER = 3   # mehr Artikel/Pronomen/Zahl-/Fragewörter pro Rätsel -> Entwurf
SCHWIERIGKEIT_TEXT = {1: 'leicht', 2: 'mittel', 3: 'schwer'}


def lade_fragen(pfad):
    fragen = {}
    with open(pfad, encoding='utf-8') as f:
        for r in csv.DictReader(f, delimiter='\t'):
            fragen.setdefault(r['wort'], []).append(
                {'frage': r['frage'], 'schwierigkeit': int(r['schwierigkeit']),
                 'haeufigkeit': r['haeufigkeit'], 'laenge': r['laenge'], 'rang': int(r['rang'])})
    return fragen


def lade_funktionswoerter(pfad):
    return {l.strip() for l in open(pfad, encoding='utf-8') if l.strip() and not l.startswith('#')}


def zellen(e):
    return [(e['r'] + (i if e['dir'] == 'D' else 0), e['c'] + (i if e['dir'] == 'A' else 0)) for i in range(e['len'])]


def skelett(v):
    w = v['spalten']
    zeilen = [f"S {v['zeilen'] * w} {len(v['eintraege'])}"]
    for e in v['eintraege']:
        z = zellen(e)
        zeilen.append(str(len(z)) + ' ' + ' '.join(str(r * w + c) for r, c in z))
    return '\n'.join(zeilen) + '\n'


def loese(solver, pool, v, seed, sekunden, tmp):
    sk = os.path.join(tmp, 'sk.txt'); sol = os.path.join(tmp, 'sol.txt')
    open(sk, 'w').write(skelett(v))
    if os.path.exists(sol):
        os.remove(sol)
    env = dict(os.environ, SOLFILE=sol)
    out = subprocess.run([solver, pool, sk, str(sekunden), 'val=freq', 'alpha=8', 'restart=3000', 'var=wdeg', f'seed={seed}'],
                         capture_output=True, text=True, env=env).stdout
    if ' ok ' not in out or not os.path.exists(sol):
        return None
    teile = open(sol).read().split()
    return teile[1:]  # erstes Feld = Index der Vorlage


def pruefe_loesung(v, woerter, pool_woerter):
    """Unabhängige Prüfung; gibt Liste von Fehlern zurück (leer = ok)."""
    fehler = []
    E = v['eintraege']
    if len(woerter) != len(E):
        return ['Anzahl Wörter passt nicht']
    if len(set(woerter)) != len(woerter):
        fehler.append('doppelte Wörter')
    belegung = {}
    for e, w in zip(E, woerter):
        if w not in pool_woerter:
            fehler.append(f'{w} nicht im Pool')
        if len(w) != e['len']:
            fehler.append(f'{w} hat falsche Länge')
        for (r, c), ch in zip(zellen(e), w):
            if belegung.setdefault((r, c), ch) != ch:
                fehler.append(f'Kreuzungskonflikt bei {r},{c}')
    dunkel = {tuple(x) for x in v['dunkle_zellen']}
    weiss = {(r, c) for r in range(v['zeilen']) for c in range(v['spalten'])} - dunkel
    if set(belegung) != weiss:
        fehler.append('nicht alle weißen Zellen belegt')
    return fehler


def baue_raetsel(v, woerter, fragen, rng, funktionswoerter):
    eintraege, hinweise = [], []
    for e, w in zip(v['eintraege'], woerter):
        f = rng.choice(fragen[w])
        eintraege.append({'dir': e['dir'], 'r': e['r'], 'c': e['c'], 'len': e['len'],
                          'clueR': e['clueR'], 'clueC': e['clueC'], 'wort': w,
                          'clue': f['frage'], 'schwierigkeit': f['schwierigkeit']})
    fw = sum(1 for e in eintraege if e['wort'] in funktionswoerter)
    if fw > MAX_FUNKTIONSWOERTER:
        hinweise.append(f'{fw} Funktionswörter (Artikel/Pronomen/Zahl/Fragewort)')
    doppelt = [t for t, n in Counter(e['clue'] for e in eintraege).items() if n > 1]
    if doppelt:
        hinweise.append('gleicher Fragetext mehrfach: ' + ', '.join(doppelt))
    # Schwellenwerte statt round(): ein einfaches round() auf den Mittelwert der Wort-Schwierigkeiten
    # (1..3) landet wegen der vielen kurzen, zwangsläufig gebräuchlichen Füllwörter (ALS, IHR, INS, ...)
    # so gut wie nie bei 3 – selbst wenn viele seltene Wörter enthalten sind. Werte anhand von 78 Testrätseln
    # kalibriert (siehe phase5-anbindung.md): ergibt eine plausible Verteilung leicht/mittel/schwer.
    schnitt = sum(e['schwierigkeit'] for e in eintraege) / len(eintraege)
    schw = 1 if schnitt < 1.55 else (2 if schnitt < 1.85 else 3)
    return eintraege, hinweise, schw


def woerter_aus_datei(pfad):
    """Rekonstruiert die Lösungswörter eines gespeicherten Rätsels (als_puzzle() speichert nur clue/Position, kein Wort)."""
    d = json.load(open(pfad, encoding='utf-8'))
    p = d['puzzle']; sol = p['solution']
    return [''.join(sol[f'{r},{c}'] for r, c in zellen(e)) for e in p['entries']]


def als_puzzle(v, eintraege):
    loesung = {}
    for e in eintraege:
        for (r, c), ch in zip(zellen(e), e['wort']):
            loesung[f'{r},{c}'] = ch
    return {'rows': v['zeilen'], 'cols': v['spalten'], 'solution': loesung,
            'entries': [{k: e[k] for k in ('dir', 'r', 'c', 'len', 'clueR', 'clueC', 'clue')} for e in eintraege]}


def q(s):
    return "'" + str(s).replace("'", "''") + "'"


def sql_raetsel(r):
    status = r['status']
    kopf = (f"-- {r['slug']}" + (f"  (Entwurf: {'; '.join(r['pruefhinweise'])})" if r['pruefhinweise'] else '') + '\n')
    werte = ',\n'.join(f"    ({q(e['wort'])}, {q(e['clue'])}, {q(e['dir'])}, {e['r']}, {e['c']}, {e['len']})" for e in r['eintraege'])
    return (kopf +
            "with neu as (\n"
            "  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)\n"
            f"  select {q(r['slug'])}, {q(r['titel'])}, g.id, {q(status)}, {r['schwierigkeit']}, "
            f"{'now()' if status == 'veroeffentlicht' else 'null'}\n"
            f"  from gitter g where g.name = {q(r['vorlage'])} order by g.id limit 1\n"
            "  on conflict (slug) do nothing\n"
            "  returning id\n"
            ")\n"
            "insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)\n"
            "select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len\n"
            "from neu cross join (values\n" + werte + "\n  ) as v(wort, frage, dir, r, c, len)\n"
            "join woerter w on w.wort = v.wort\n"
            "left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;\n\n")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--solver', required=True)
    ap.add_argument('--vorlagen', default='data/gitter/vorlagen.json')
    ap.add_argument('--fragen', default='data/fragen/fragen.tsv')
    ap.add_argument('--pro-vorlage', type=int, default=3)
    ap.add_argument('--sekunden', type=float, default=4)
    ap.add_argument('--max-versuche', type=int, default=30, help='Seeds pro Vorlage, bis genug Rätsel gefunden sind')
    ap.add_argument('--nur-veroeffentlichbare', action='store_true',
                    help='Rätsel mit Prüfhinweisen verwerfen statt als Entwurf speichern')
    ap.add_argument('--seed', type=int, default=1)
    ap.add_argument('--abwechslung', type=float, default=3,
                    help='Abwertung bereits verwendeter Wörter: Häufigkeit / (1 + x·Anzahl bisheriger Verwendungen); 0 = aus')
    ap.add_argument('--hart-anteil', type=float, default=1 / 3,
                    help='Anteil der Versuche mit umgekehrter (seltenheits-basierter) Wortgewichtung, '
                         'damit auch "schwer" eingestufte Rätsel entstehen (0 = aus). Zufällig je Versuch statt '
                         'positionsbasiert, damit es auch bei --pro-vorlage 1 eine Mischung ergibt.')
    ap.add_argument('--anhaengen', action='store_true',
                    help='An bestehende public/raetsel/index.json anhängen statt zu überschreiben: Rätsel-Nummerierung, '
                         'bereits verwendete Wörter (für --abwechslung) und Wort-Kombinationen (Duplikatsprüfung) werden '
                         'aus den vorhandenen Dateien fortgeführt, statt bei 0 neu anzufangen. Für wiederkehrende Läufe '
                         '(z. B. wöchentlich per GitHub Actions), die den bestehenden Rätselbestand ergänzen.')
    ap.add_argument('--funktionswoerter', default='tools/generator/funktionswoerter.txt')
    ap.add_argument('--funktionswort-haeufigkeit', type=int, default=30,
                    help='Korpushäufigkeit, auf die Funktionswörter für die Wortwahl gedeckelt werden (0 = aus)')
    ap.add_argument('--json-dir', default='public/raetsel')
    ap.add_argument('--sql', default='supabase/seed/raetsel_seed.sql')
    a = ap.parse_args()

    V = json.load(open(a.vorlagen, encoding='utf-8'))
    fragen = lade_fragen(a.fragen)
    funktionswoerter = lade_funktionswoerter(a.funktionswoerter)
    rng = random.Random(a.seed)
    os.makedirs(a.json_dir, exist_ok=True)
    tmp = tempfile.mkdtemp()
    pool = os.path.join(tmp, 'pool.tsv')
    verwendet = Counter()   # wie oft ein Wort in bereits erzeugten Rätseln vorkommt

    def schreibe_pool(modus='normal'):
        # Häufigkeit steuert die Wortwahl des Solvers (Gewicht ~ ln(h)^8). Funktionswörter werden gedeckelt,
        # bereits verwendete Wörter abgewertet, damit sich die Rätsel nicht ständig wiederholen (EHE, TEE, SEE ...).
        # modus='hart': Gewicht kommt aus dem Häufigkeits-RANG statt der Häufigkeit selbst, also umgekehrt –
        # seltene Wörter (hoher Rang) werden bevorzugt, damit überhaupt "schwere" Rätsel entstehen können.
        with open(pool, 'w', encoding='utf-8') as f:
            f.write('wort\tlaenge\thaeufigkeit\tschreibweise\n')
            for w, fl in fragen.items():
                h = int(fl[0]['rang']) if modus == 'hart' else int(fl[0]['haeufigkeit'])
                if w in funktionswoerter and a.funktionswort_haeufigkeit:
                    h = min(h, a.funktionswort_haeufigkeit)
                if a.abwechslung and verwendet[w]:
                    h = max(2, int(h / (1 + a.abwechslung * verwendet[w])))
                f.write(f"{w}\t{fl[0]['laenge']}\t{h}\t{w}\n")

    alle, gesehen, statistik = [], set(), Counter()
    nr = 0
    alt_index = []
    if a.anhaengen:
        alt_index_pfad = os.path.join(a.json_dir, 'index.json')
        if os.path.exists(alt_index_pfad):
            alt_index = json.load(open(alt_index_pfad, encoding='utf-8'))
        for eintrag in alt_index:
            m = re.match(r'r(\d+)-(.+)$', eintrag['id'])
            if not m:
                continue
            nr = max(nr, int(m.group(1)))
            vorlage_name = m.group(2)
            pfad = os.path.join(a.json_dir, eintrag['id'] + '.json')
            if not os.path.exists(pfad):
                continue
            woerter_alt = woerter_aus_datei(pfad)
            verwendet.update(woerter_alt)
            gesehen.add((vorlage_name, frozenset(woerter_alt)))
        print(f'--anhaengen: {len(alt_index)} bestehende Rätsel geladen, nr startet bei {nr + 1}, '
              f'{len(verwendet)} bereits verwendete Wörter', file=sys.stderr)
    for v in V:
        if not v.get('validiert', True):
            continue
        gefunden = 0
        for s in range(a.seed, a.seed + a.max_versuche):
            if gefunden >= a.pro_vorlage:
                break
            modus = 'hart' if a.hart_anteil and rng.random() < a.hart_anteil else 'normal'
            schreibe_pool(modus)
            woerter = loese(a.solver, pool, v, s, a.sekunden, tmp)
            statistik['versuche'] += 1
            if woerter is None:
                statistik['ohne_loesung'] += 1; continue
            fehler = pruefe_loesung(v, woerter, fragen)
            if fehler:
                statistik['pruefung_fehlgeschlagen'] += 1
                print('VERWORFEN', v['name'], s, fehler[:3], file=sys.stderr); continue
            fp = (v['name'], frozenset(woerter))
            if fp in gesehen:
                statistik['duplikat'] += 1; continue
            gesehen.add(fp)
            eintraege, hinweise, schw = baue_raetsel(v, woerter, fragen, rng, funktionswoerter)
            if hinweise and a.nur_veroeffentlichbare:
                statistik['verworfen_qualitaet'] += 1; continue
            nr += 1; gefunden += 1
            r = {'slug': f"r{nr:03d}-{v['name']}", 'titel': f"Rätsel {nr} · {v['zeilen']}×{v['spalten']}",
                 'vorlage': v['name'], 'status': 'entwurf' if hinweise else 'veroeffentlicht',
                 'pruefhinweise': hinweise, 'schwierigkeit': schw, 'eintraege': eintraege}
            alle.append(r)
            verwendet.update(woerter)
            statistik[r['status']] += 1
            with open(os.path.join(a.json_dir, r['slug'] + '.json'), 'w', encoding='utf-8') as f:
                json.dump({'id': r['slug'], 'titel': r['titel'], 'status': r['status'], 'schwierigkeit': schw,
                           'pruefhinweise': hinweise, 'puzzle': als_puzzle(v, eintraege)}, f, ensure_ascii=False)

    index_neu = [{'id': r['slug'], 'titel': r['titel'], 'rows': next(v['zeilen'] for v in V if v['name'] == r['vorlage']),
                  'cols': next(v['spalten'] for v in V if v['name'] == r['vorlage']), 'schwierigkeit': r['schwierigkeit'],
                  'status': r['status']} for r in alle]
    index = alt_index + index_neu if a.anhaengen else index_neu
    with open(os.path.join(a.json_dir, 'index.json'), 'w', encoding='utf-8') as f:
        json.dump(index, f, ensure_ascii=False, indent=1)
    with open(a.sql, 'w', encoding='utf-8') as f:
        f.write('-- Automatisch erzeugt von tools/generator/generate_raetsel.py – nicht von Hand bearbeiten.\n'
                '-- Voraussetzung: Migrationen, gitter_vorlagen.sql, woerter_seed.sql, fragen_varianten_seed.sql eingespielt.\n'
                '-- Idempotent über raetsel.slug. Rätsel mit Prüfhinweisen werden als Entwurf angelegt.\n\nbegin;\n\n')
        for r in alle:
            f.write(sql_raetsel(r))
        f.write('commit;\n')
    print(json.dumps(dict(statistik), ensure_ascii=False), '| Rätsel:', len(alle))
    print('verschiedene Wörter:', len(verwendet), '| häufigste:', verwendet.most_common(5))
    print('Schwierigkeit:', dict(Counter(SCHWIERIGKEIT_TEXT[r['schwierigkeit']] for r in alle)))


if __name__ == '__main__':
    main()
