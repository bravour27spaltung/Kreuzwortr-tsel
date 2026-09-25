#!/usr/bin/env python3
"""Kontext-Features pro Wortform (case-sensitive) aus Leipzig-Satzdateien.

CLI:  extract_features.py <sentences.txt> <out.tsv>
API:  extract(iterable_of_lines) -> {form: [zaehler ...]}   (Spalten siehe COLUMNS)

Spalten (alle Zaehler ueber das gesamte Korpus):
  total      Vorkommen der Wortform
  nonstart   Vorkommen nicht am Satzanfang (dort ist Grossschreibung uninformativ)
  det_prev   nonstart-Vorkommen direkt nach Artikel/Possessiv/Praeposition+Artikel
  num_prev   nonstart-Vorkommen direkt nach Zahl/Zahlwort ("5 Euro", "zwei Wochen")
  dot_mid    Vorkommen mit direkt folgendem Punkt, aber NICHT am Satzende ("Std. 3")
  dot_any    Vorkommen mit direkt folgendem Punkt (auch Satzende)
  prev_cap   nonstart-Vorkommen nach grossgeschriebenem Wort
  prev_title nonstart-Vorkommen nach Titel/Anrede (Herr, Frau, Dr, Prof ...)
  next_cap   Vorkommen mit grossgeschriebenem Folgewort (z. B. "Tina Turner")
  en_nb      Vorkommen mit englischem Funktionswort als direktem Nachbarn
  loc_prev   nonstart-Vorkommen direkt nach in/nach/aus/bei/bis/gen (Ortsangaben: "in Weimar")

Bindestrich-Komposita werden wie in den Leipzig-Wortlisten in Teile zerlegt; Modifikator-Teile
(alle ausser dem letzten) erhalten keine Artikel-/Zahl-Evidenz.
"""
import re, sys, collections

VERSION = '3'   # bei Aenderung der Zaehl-Logik erhoehen (invalidiert den Cache)
COLUMNS = ['total', 'nonstart', 'det_prev', 'num_prev', 'dot_mid', 'dot_any',
           'prev_cap', 'prev_title', 'next_cap', 'en_nb', 'loc_prev']
I = {c: i for i, c in enumerate(COLUMNS)}

DET = set("""der die das den dem des ein eine einen einem einer eines kein keine keinen keinem keiner keines
mein meine meinen meinem meiner meines dein deine deinen deinem deiner sein seine seinen seinem seiner seines
ihr ihre ihren ihrem ihrer ihres unser unsere unseren unserem unserer euer eure euren
dieser diese dieses diesen diesem jeder jede jedes jeden jedem jener jene jenes jenen welche welcher welches
manche mancher manches solche solcher solches alle aller allen allem viele vielen vieler einige einiger einigen
mehrere mehreren wenige wenigen beide beiden im am vom zum zur beim ins ans aufs ums fürs durchs
etwas nichts viel mehr genug""".split())
NUMW = set("""zwei drei vier fünf sechs sieben acht neun zehn elf zwölf zwanzig dreißig vierzig fünfzig sechzig siebzig
achtzig neunzig hundert tausend million millionen milliarde milliarden dutzend paar weitere weiteren weiterer zahlreiche
zahlreichen verschiedene verschiedenen zig unzählige""".split())
LOC = set("in nach aus bei bis gen unweit nahe".split())
TITLE = set("herr herrn frau frl dr prof präsident minister kanzler bürgermeister pfarrer pastor trainer coach sänger sängerin schauspieler schauspielerin".split())
EN_FW = set("the and of to is are for that with you this it be not but from they we at by have your my our his her their which would can".split())
ALPHA = re.compile(r"^[A-Za-zÄÖÜäöüß]+$")
HASDIGIT = re.compile(r"\d")
STRIP = '.,;:!?"“”„‚‘’\'()[]{}«»–—-…/'


def extract(lines):
    F = collections.defaultdict(lambda: [0] * len(COLUMNS))
    nsent = 0
    for line in lines:
        parts = line.rstrip('\n').split('\t', 1)
        text = parts[1] if len(parts) == 2 else parts[0]
        toks = []  # (Teilwort, Punkt_folgt, ist_Modifikator)
        for t in text.split():
            core = t.strip(STRIP)
            if not core:
                continue
            sub = core.split('-')
            for j, p in enumerate(sub):
                last = j == len(sub) - 1
                toks.append((p, last and t.endswith('.') and not t.endswith('..'), not last))
        if not toks:
            continue
        nsent += 1
        lows = [t[0].lower() for t in toks]
        n = len(toks)
        for i, (w, dot, is_mod) in enumerate(toks):
            if not ALPHA.match(w):
                continue
            f = F[w]
            f[0] += 1
            if dot:
                f[I['dot_any']] += 1
                if i < n - 1:
                    f[I['dot_mid']] += 1
            if (i > 0 and lows[i - 1] in EN_FW) or (i < n - 1 and lows[i + 1] in EN_FW):
                f[I['en_nb']] += 1
            if i < n - 1:
                nw = toks[i + 1][0]
                if nw[:1].isupper() and ALPHA.match(nw):
                    f[I['next_cap']] += 1
            if i == 0:
                continue
            f[1] += 1
            pw, pl = toks[i - 1][0], lows[i - 1]
            # Nicht-letzte Teile von Bindestrich-Komposita ("der Eon-Konzern") sind Modifikatoren:
            # der Artikel gehoert zum Kopf-Nomen, nicht zu diesem Wort -> keine Nomen-Evidenz.
            if not is_mod:
                if pl in DET:
                    f[I['det_prev']] += 1
                if pl in NUMW or HASDIGIT.search(pw):
                    f[I['num_prev']] += 1
            if pl in TITLE:
                f[I['prev_title']] += 1
            if pl in LOC:
                f[I['loc_prev']] += 1
            if pw[:1].isupper() and ALPHA.match(pw):
                f[I['prev_cap']] += 1
    return F, nsent


def write_tsv(F, out_file):
    with open(out_file, 'w', encoding='utf-8') as o:
        o.write('form\t' + '\t'.join(COLUMNS) + '\n')
        for w, f in F.items():
            o.write(w + '\t' + '\t'.join(map(str, f)) + '\n')


def read_tsv(path):
    F = {}
    with open(path, encoding='utf-8') as fh:
        next(fh)
        for line in fh:
            p = line.rstrip('\n').split('\t')
            F[p[0]] = [int(x) for x in p[1:]]
    return F


def merge(paths):
    tot = collections.defaultdict(lambda: [0] * len(COLUMNS))
    for p in paths:
        for w, v in read_tsv(p).items():
            t = tot[w]
            for i, x in enumerate(v):
                t[i] += x
    return tot


if __name__ == '__main__':
    if sys.argv[1] == 'merge':          # extract_features.py merge out.tsv teil1.tsv teil2.tsv ...
        write_tsv(merge(sys.argv[3:]), sys.argv[2])
    else:                               # extract_features.py sentences.txt out.tsv
        F, n = extract(open(sys.argv[1], encoding='utf-8'))
        write_tsv(F, sys.argv[2])
        print('sentences', n, 'forms', len(F))
