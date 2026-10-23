"""Phase 8 – stellt die Fragetexte bestehender Raetsel (public/raetsel/r*.json) auf die neuen Phase-8-Fragen um
und erzeugt dazu ein SQL, das fragen.frage_varianten_id der bereits eingespielten Raetsel umhaengt
(Fortschritt der Spieler bleibt erhalten: es aendert sich nur der Fragetext, nicht Zeile/Zelle/Loesung).
Aufruf: python3 tools/fragen/phase8/bestand_aktualisieren.py [--dir public/raetsel] [--sql supabase/seed/fragen_phase8_bestand.sql]
Idempotent: bei erneutem Lauf wird nichts mehr geaendert (bereits Phase-8-Fragen bleiben stehen).
"""
import argparse, csv, glob, json, os, random
from collections import defaultdict

ap = argparse.ArgumentParser()
ap.add_argument('--dir', default='public/raetsel')
ap.add_argument('--fragen', default='data/fragen/fragen.tsv')
ap.add_argument('--sql', default='supabase/seed/fragen_phase8_bestand.sql')
a = ap.parse_args()
QUELLE = 'claude-v3-phase8'

neu = defaultdict(list); alle = defaultdict(set)
for r in csv.DictReader(open(a.fragen, encoding='utf-8'), delimiter='\t'):
    alle[r['wort']].add(r['frage'])
    if r['quelle'] == QUELLE:
        neu[r['wort']].append(r['frage'])

q = lambda s: "'" + str(s).replace("'", "''") + "'"
zeilen, geaendert, dateien_n = [], 0, 0
for pfad in sorted(glob.glob(os.path.join(a.dir, 'r*.json'))):
    d = json.load(open(pfad, encoding='utf-8')); p = d['puzzle']; sol = p['solution']; slug = d['id']
    rng = random.Random(slug); benutzt = {e['clue'] for e in p['entries']}; neuer_text = False
    for e in p['entries']:
        dr, dc = (1, 0) if e['dir'] == 'D' else (0, 1)
        w = ''.join(sol[f"{e['r'] + i * dr},{e['c'] + i * dc}"] for i in range(e['len']))
        if e['clue'] in neu[w] or not neu[w]:
            continue
        kand = [f for f in neu[w] if f not in benutzt]
        if not kand:
            continue
        f = rng.choice(kand); benutzt.discard(e['clue']); benutzt.add(f)
        e['clue'] = f; neuer_text = True; geaendert += 1
        zeilen.append(f"    ({q(slug)}, {q(w)}, {q(f)}, {q(e['dir'])}, {e['r']}, {e['c']})")
    if neuer_text:
        json.dump(d, open(pfad, 'w', encoding='utf-8'), ensure_ascii=False)
        dateien_n += 1
if zeilen:
    open(a.sql, 'w', encoding='utf-8').write(
        "-- Phase 8: Fragetexte bereits eingespielter Raetsel auf die neuen Phase-8-Fragen umhaengen.\n"
        "-- Voraussetzung: fragen_varianten_seed_phase8.sql eingespielt. Aendert nur fragen.frage_varianten_id;\n"
        "-- Zellen, Loesungen und Spielerfortschritt bleiben unberuehrt. Idempotent.\nbegin;\n"
        "update fragen f set frage_varianten_id = fv.id\nfrom (values\n" + ',\n'.join(zeilen) + "\n) as v(slug, wort, frage, richtung, r, c)\n"
        "join raetsel ra on ra.slug = v.slug\njoin woerter w on w.wort = v.wort\n"
        "join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage\n"
        "where f.raetsel_id = ra.id and f.wort_id = w.id and f.richtung = v.richtung\n"
        "  and f.start_zeile = v.r and f.start_spalte = v.c\n  and f.frage_varianten_id is distinct from fv.id;\ncommit;\n")
print(geaendert, 'Fragen in', dateien_n, 'Dateien umgestellt')
