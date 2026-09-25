#!/usr/bin/env python3
"""Baut die gefilterte Kreuzwortraetsel-Wortliste aus einem oder mehreren Leipzig-Korpora.

Beispiel:
  python3 tools/wordlist/build_wordlist.py \
      --corpus ~/Downloads/deu_mixed-typical_2011_1M.tar \
      --corpus ~/Downloads/deu_wikipedia_2021_300K.tar \
      --out data/wortliste/woerter        # -> woerter_gefiltert.tsv, woerter_ausgeschlossen.tsv

Weitere Korpora: einfach zusaetzliche --corpus-Angaben (Haeufigkeiten und Kontextzaehler werden addiert).
Die Kontextdaten werden pro Korpus einmalig berechnet und in --cache abgelegt (versioniert).

Stufen (jede Stufe protokolliert den Ausschlussgrund):
  0  Baseline: nur Buchstaben, Umlaute normalisiert (AE/OE/UE/SS), Laenge 3-11, Haeufigkeit >= --base-freq (5)
  1  abk_grossschreibung : Wortform ueberwiegend VERSALIEN (BASF, ADAC, TSV)
  2  abk_mischschreibung : Binnenversalien (kWh, VfB, PCs, GmbH)
  3  abk_ohne_vokal      : kein Vokal (STD, DJK, FDP)
  4  abk_punkt           : steht ueberwiegend vor Abkuerzungspunkt (Mio., bzw., Tel.)
  5  abk_roemisch        : roemische Zahl (VIII, XXX)
  6  fremd_kontext       : ueberwiegend direkt neben englischen Funktionswoertern (Welcome, Enjoy)
  6b fremd_englisch      : englische Basisform (lexika/en_US.words.txt, +Plural-s), Kleinschreibungs-Anteil < 50 %
                           (deutsche Adjektive/Verben sind klein), kaum Artikel-/Zahlkontext (< 10 %), Haeufigkeit < 300
                           (Just, Good, Time, People; deutsche Lehnwoerter mit Artikelkontext wie Job/Team bleiben)
  7  eigenname / ortsname: ueberwiegend grossgeschrieben (auch mitten im Satz) UND selten nach
                           Artikel/Zahlwort. Quote q = (Artikel+Zahlwort-Kontext)/Nicht-Satzanfang-Vorkommen
                             q <  noun_low (0.08)            -> Name
                             noun_low <= q < noun_high (0.25) -> Name nur bei Zusatzindiz
                                (Vorname: Folgewort gross >= 30 %, Nachname: Wort davor gross >= 50 %,
                                 Titel davor >= 3 %, Ortspraeposition davor >= 25 %)
                             q >= noun_high                   -> Nomen (behalten)
                           Ortspraeposition (in/nach/aus/bei/bis/gen) >= 25 % => Grund 'ortsname'
                           (mit --keep-places wieder zugelassen), sonst 'eigenname' (Personen/Marken/Fremdwort)
  6c fremd_funktionswort : Funktionswort einer anderen Sprache (lexika/fremd_stopwoerter.txt: and, for, van, cum ...)
  9  zu_selten           : nur fuer sonst behaltene Woerter: Haeufigkeit < --min-freq (Laenge > --short-len)
                           bzw. < --min-freq-short (Laenge <= --short-len); bei starkem Beleg (Nomen mit >= 25 % Artikel-/
                           Zahlkontext oder >= 90 % Kleinschreibung) gelten die niedrigeren --min-freq-strong/-short-strong. Begruendung: Stichproben zeigen
                           bei kurzen/seltenen Woertern 25-85 % Junk (Details: tools/wordlist/README.md)
  8  manuelle Listen     : manual_drop.txt (immer ausschliessen), manual_keep.txt (hebt Stufe 1-7 auf)
"""
import argparse, collections, io, math, os, re, sys, tarfile

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import extract_features as ef

TR = str.maketrans({'Ä': 'AE', 'Ö': 'OE', 'Ü': 'UE', 'ß': 'SS', 'ä': 'AE', 'ö': 'OE', 'ü': 'UE'})
ALPHA = re.compile(r'^[A-Za-zÄÖÜäöüß]+$')
ROMAN = re.compile(r'^[IVXLCDM]{3,}$')
PLURAL_ABK = re.compile(r'^[A-ZÄÖÜ]{2,}s$')
MIXED = re.compile(r'[a-zäöüß][A-ZÄÖÜ]')
VOWELS = set('AEIOUYÄÖÜaeiouyäöü')


def load_en(here):
    p = os.path.join(here, 'lexika', 'en_US.words.txt')
    en = set()
    if os.path.exists(p):
        for l in open(p, encoding='utf-8'):
            w = l.strip()
            if w:
                en.add(w)
                en.add(w + 's')
    return en


def load_stop(here):
    p = os.path.join(here, 'lexika', 'fremd_stopwoerter.txt')
    out = set()
    if os.path.exists(p):
        for line in open(p, encoding='utf-8'):
            if line.startswith('#'):
                continue
            out.update(t.upper() for t in line.split() if t.isalpha())
    return out


def norm(w):
    return w.translate(TR).upper()


def kind(s):
    if len(s) >= 2 and s.isupper():
        return 'ALL'
    return 'CAP' if s[0].isupper() else 'LOW'


# ---------------------------------------------------------------- Korpus-Zugriff
def corpus_lines(path, suffix):
    """Liefert Zeilen der Datei '*<suffix>' aus Tar (auch .tar.gz) oder entpacktem Ordner."""
    if os.path.isdir(path):
        for root, _, files in os.walk(path):
            for f in files:
                if f.endswith(suffix):
                    with open(os.path.join(root, f), encoding='utf-8') as fh:
                        yield from fh
                    return
        raise FileNotFoundError(suffix + ' in ' + path)
    with tarfile.open(path) as tf:
        for m in tf:
            if m.name.endswith(suffix):
                yield from io.TextIOWrapper(tf.extractfile(m), encoding='utf-8')
                return
    raise FileNotFoundError(suffix + ' in ' + path)


def corpus_name(path):
    b = os.path.basename(path.rstrip('/'))
    return re.sub(r'\.(tar\.gz|tgz|tar)$', '', b)


def load_corpus(path, cache):
    """-> (wortformen {surface: count}, features {surface: [..]})"""
    words = collections.Counter()
    for line in corpus_lines(path, '-words.txt'):
        p = line.rstrip('\n').split('\t')
        if len(p) >= 3 and ALPHA.match(p[1]):
            words[p[1]] += int(p[2])
    fpath = os.path.join(cache, f'{corpus_name(path)}.features-v{ef.VERSION}.tsv')
    if os.path.exists(fpath):
        feats = ef.read_tsv(fpath)
    else:
        feats, n = ef.extract(corpus_lines(path, '-sentences.txt'))
        os.makedirs(cache, exist_ok=True)
        ef.write_tsv(feats, fpath)
        print(f'  Features fuer {corpus_name(path)} berechnet ({n} Saetze)', file=sys.stderr)
    return words, feats


# ---------------------------------------------------------------- Gruppierung
def build_groups(corpora, min_freq, lo=3, hi=11):
    words = collections.Counter()
    feats = collections.defaultdict(lambda: [0] * len(ef.COLUMNS))
    for w, f in corpora:
        words.update(w)
        for s, v in f.items():
            t = feats[s]
            for i, x in enumerate(v):
                t[i] += x
    groups = {}
    for s, c in words.items():
        n = norm(s)
        if not (lo <= len(n) <= hi) or not n.isalpha() or not n.isascii():
            continue
        g = groups.setdefault(n, {'surf': {}, 'freq': 0})
        g['surf'][s] = c
        g['freq'] += c
    groups = {n: g for n, g in groups.items() if g['freq'] >= min_freq}
    C = ef.I
    for n, g in groups.items():
        fr = {'ALL': 0, 'CAP': 0, 'LOW': 0}
        ns = {'CAP': 0, 'LOW': 0, 'ALL': 0}
        nctx = {'CAP': 0, 'LOW': 0, 'ALL': 0}
        tot = dot_mid = dot_any = en_nb = next_cap = prev_title = 0
        cap = {'total': 0, 'prev_cap': 0, 'next_cap': 0, 'prev_title': 0, 'loc_prev': 0}
        for s, c in g['surf'].items():
            k = kind(s)
            fr[k] += c
            f = feats.get(s)
            if f:
                if k == 'CAP':
                    for key in cap:
                        cap[key] += f[C[key]]
                ns[k] += f[C['nonstart']]
                nctx[k] += f[C['det_prev']] + f[C['num_prev']]
                tot += f[C['total']]
                dot_mid += f[C['dot_mid']]
                dot_any += f[C['dot_any']]
                en_nb += f[C['en_nb']]
                next_cap += f[C['next_cap']]
                prev_title += f[C['prev_title']]
        g.update(cap=cap, fr=fr, ns=ns, nctx=nctx, tot=tot, dot_mid=dot_mid, dot_any=dot_any,
                 en_nb=en_nb, next_cap=next_cap, prev_title=prev_title,
                 top=max(g['surf'], key=g['surf'].get))
    return groups


# ---------------------------------------------------------------- Regeln
def classify(n, g, P, EN=frozenset(), STOP=frozenset()):
    """-> (grund, evidenz) oder None wenn behalten."""
    fr, ns, tot = g['fr'], g['ns'], g['tot']
    freq = g['freq']
    if fr['ALL'] / freq >= P['allcaps_share']:
        return 'abk_grossschreibung', f"ALL={fr['ALL']}/{freq}"
    top = g['top']
    if MIXED.search(top) and g['surf'][top] / freq >= 0.5:
        return 'abk_mischschreibung', top
    if PLURAL_ABK.match(top):
        return 'abk_mischschreibung', top
    if n in STOP:
        return 'fremd_funktionswort', n
    if not any(ch in VOWELS for ch in top):
        return 'abk_ohne_vokal', top
    if tot >= 5 and g['dot_mid'] / tot >= P['dot_mid_ratio']:
        return 'abk_punkt', f"dot_mid={g['dot_mid']}/{tot}"
    if (tot >= 10 and len(n) <= 4 and top[0].islower() and g['dot_any'] / tot >= 0.9):
        return 'abk_punkt', f"dot_any={g['dot_any']}/{tot}"
    if ROMAN.match(n) and fr['LOW'] == 0:
        return 'abk_roemisch', n
    if tot >= 5 and g['en_nb'] / tot >= P['en_nb_ratio']:
        return 'fremd_kontext', f"en_nb={g['en_nb']}/{tot}"
    nsum = ns['CAP'] + ns['LOW'] + ns['ALL']
    if (EN and n.lower() in EN and freq < P['en_maxfreq'] and nsum >= 3
            and ns['LOW'] / nsum < P['en_lowshare']
            and (g['nctx']['CAP'] + g['nctx']['LOW'] + g['nctx']['ALL']) / nsum < P['en_q']):
        return 'fremd_englisch', f"q={g['nctx']['CAP'] + g['nctx']['LOW'] + g['nctx']['ALL']}/{nsum} low={ns['LOW']}/{nsum}"
    a, b = ns['CAP'], ns['LOW']
    if a + b > 0 and a / (a + b) >= P['cap_share'] and a >= P['min_nonstart']:
        c = g['cap']
        q = g['nctx']['CAP'] / a
        loc = c['loc_prev'] / a
        indiz = (c['next_cap'] / max(c['total'], 1) >= 0.3 or c['prev_cap'] / a >= 0.5
                 or c['prev_title'] / a >= 0.03 or loc >= P['loc_band'])
        if q < P['noun_low'] or (q < P['noun_high'] and indiz):
            ev = (f"q={g['nctx']['CAP']}/{a} next_cap={c['next_cap']}/{c['total']} "
                  f"prev_cap={c['prev_cap']}/{a} titel={c['prev_title']} ort={c['loc_prev']}/{a}")
            return ('ortsname' if loc >= 0.25 else 'eigenname'), ev
    short = len(n) <= P['short_len']
    floor = P['min_freq_short'] if short else P['min_freq']
    starke = starker_beleg(g, P)
    if starke:
        floor = P['min_freq_short_strong'] if short else P['min_freq_strong']
    if freq < floor:
        return 'zu_selten', f"freq={freq}<{floor}{' (starker Beleg)' if starke else ''}"
    return None


def starker_beleg(g, P):
    """Klarer Hinweis auf ein gewoehnliches deutsches Wort: (a) Nomen: grossgeschrieben, >= 5 Vorkommen im Satz und
    Artikel-/Zahlquote >= noun_high; (b) Verb/Adjektiv/Adverb: >= 90 % kleingeschrieben mitten im Satz (>= 5 Vorkommen)."""
    ns = g['ns']
    a, b = ns['CAP'], ns['LOW']
    if a + b + ns['ALL'] < 5:
        return False
    if a / max(a + b, 1) >= P['cap_share']:
        return a >= 5 and g['nctx']['CAP'] / a >= P['noun_high']
    return b / max(a + b, 1) >= 0.9


def read_list(path):
    out = set()
    if os.path.exists(path):
        for line in open(path, encoding='utf-8'):
            line = line.split('#')[0].strip()
            for tok in line.split():
                out.add(norm(tok))
    return out


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('--corpus', action='append', required=True, help='Leipzig-.tar oder entpackter Ordner (mehrfach moeglich)')
    ap.add_argument('--out', required=True, help='Ausgabe-Praefix, z. B. data/wortliste')
    ap.add_argument('--cache', default=os.path.join(os.path.expanduser('~'), '.cache', 'kwr-wordlist'))
    ap.add_argument('--base-freq', type=int, default=5, help='Baseline-Untergrenze (Stufe 0, wie Abschnitt 4b)')
    ap.add_argument('--min-freq', type=int, default=10, help='Mindesthaeufigkeit fuer Woerter > --short-len Buchstaben')
    ap.add_argument('--min-freq-strong', type=int, default=5, help='Untergrenze (Laenge > --short-len) bei starkem Nomen-/Kleinschreibungs-Beleg')
    ap.add_argument('--min-freq-short-strong', type=int, default=10, help='dito fuer Laenge <= --short-len')
    ap.add_argument('--min-freq-short', type=int, default=20, help='Mindesthaeufigkeit fuer Woerter <= --short-len Buchstaben')
    ap.add_argument('--short-len', type=int, default=4)
    ap.add_argument('--allcaps-share', type=float, default=0.6)
    ap.add_argument('--dot-mid-ratio', type=float, default=0.2)
    ap.add_argument('--en-nb-ratio', type=float, default=0.25)
    ap.add_argument('--cap-share', type=float, default=0.9)
    ap.add_argument('--noun-low', type=float, default=0.08, help='unter dieser Artikel-/Zahlquote: Name')
    ap.add_argument('--noun-high', type=float, default=0.25, help='ab dieser Artikel-/Zahlquote: Nomen; dazwischen entscheiden Zusatzindizien')
    ap.add_argument('--en-q', type=float, default=0.10, help='fremd_englisch: max. Artikel-/Zahlquote')
    ap.add_argument('--en-maxfreq', type=int, default=300, help='fremd_englisch: nur Woerter unterhalb dieser Haeufigkeit')
    ap.add_argument('--en-lowshare', type=float, default=0.5, help='fremd_englisch: nur wenn Kleinschreibungs-Anteil darunter liegt')
    ap.add_argument('--loc-band', type=float, default=0.4, help='Ortspraeposition-Indiz im Grenzbereich (Schwelle)')
    ap.add_argument('--keep-places', action='store_true', help='Ortsnamen (Grund ortsname) zulassen; sie unterliegen der normalen Haeufigkeitsgrenze')
    ap.add_argument('--min-nonstart', type=int, default=3)
    ap.add_argument('--explain', default='', help='Kommagetrennte Woerter: Entscheidung + Evidenz ausgeben')
    a = ap.parse_args()
    P = dict(allcaps_share=a.allcaps_share, dot_mid_ratio=a.dot_mid_ratio, en_nb_ratio=a.en_nb_ratio,
             cap_share=a.cap_share, noun_low=a.noun_low, noun_high=a.noun_high, min_nonstart=a.min_nonstart, min_freq=a.min_freq,
             min_freq_short=a.min_freq_short, short_len=a.short_len,
             min_freq_strong=a.min_freq_strong, min_freq_short_strong=a.min_freq_short_strong,
             en_q=a.en_q, en_maxfreq=a.en_maxfreq, loc_band=a.loc_band, en_lowshare=a.en_lowshare)

    here = os.path.dirname(os.path.abspath(__file__))
    EN = load_en(here)
    STOP = load_stop(here)
    corpora = [load_corpus(p, a.cache) for p in a.corpus]
    groups = build_groups(corpora, a.base_freq)
    keep_m, drop_m = read_list(os.path.join(here, 'manual_keep.txt')), read_list(os.path.join(here, 'manual_drop.txt'))

    kept, dropped = [], []
    for n, g in sorted(groups.items()):
        r = classify(n, g, P, EN, STOP)
        if n in drop_m:
            r = ('manuell_ausgeschlossen', '')
        elif r and n in keep_m:
            r = None
        elif r and a.keep_places and r[0] == 'ortsname':
            # Ortsnamen werden zugelassen, unterliegen aber der normalen Haeufigkeitsgrenze
            # (ohne "starken Beleg": Ortsnamen haben per Definition kaum Artikel-/Zahlkontext).
            floor = a.min_freq_short if len(n) <= a.short_len else a.min_freq
            r = ('zu_selten', 'ortsname') if g['freq'] < floor else None
        (dropped if r else kept).append((n, g, r))

    os.makedirs(os.path.dirname(os.path.abspath(a.out)) or '.', exist_ok=True)
    with open(a.out + '_gefiltert.tsv', 'w', encoding='utf-8') as o:
        o.write('wort\tlaenge\thaeufigkeit\tschreibweise\n')
        for n, g, _ in sorted(kept, key=lambda x: (-x[1]['freq'], x[0])):
            o.write(f"{n}\t{len(n)}\t{g['freq']}\t{g['top']}\n")
    with open(a.out + '_ausgeschlossen.tsv', 'w', encoding='utf-8') as o:
        o.write('wort\tlaenge\thaeufigkeit\tschreibweise\tgrund\tevidenz\n')
        for n, g, r in sorted(dropped, key=lambda x: (x[2][0], -x[1]['freq'], x[0])):
            o.write(f"{n}\t{len(n)}\t{g['freq']}\t{g['top']}\t{r[0]}\t{r[1]}\n")

    # Kurzbericht
    print(f"Korpora: {[corpus_name(p) for p in a.corpus]}  base_freq={a.base_freq} min_freq={a.min_freq} min_freq_short(<= {a.short_len})={a.min_freq_short}")
    print(f"Baseline {len(groups)} -> behalten {len(kept)} ({len(dropped)} ausgeschlossen)")
    reasons = collections.Counter(r[0] for _, _, r in dropped)
    print('Ausschlussgruende:', dict(reasons.most_common()))
    bl = collections.Counter(len(n) for n in groups)
    kl = collections.Counter(len(n) for n, _, _ in kept)
    print('Laenge  Baseline  behalten   Anteil')
    for L in range(3, 12):
        print(f'{L:>6} {bl[L]:>9} {kl[L]:>9} {kl[L] / max(bl[L], 1):>8.1%}')
    for w in filter(None, (x.strip() for x in a.explain.split(','))):
        n = norm(w)
        g = groups.get(n)
        if not g:
            print(f'{w}: nicht in Baseline'); continue
        r = classify(n, g, P, EN, STOP)
        print(f"{w}: {'BEHALTEN' if not r else 'AUS ' + r[0] + ' ' + r[1]}  freq={g['freq']} fr={g['fr']} ns={g['ns']} nctx={g['nctx']} tot={g['tot']}")


if __name__ == '__main__':
    main()
