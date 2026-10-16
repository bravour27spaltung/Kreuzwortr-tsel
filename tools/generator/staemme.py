#!/usr/bin/env python3
"""Wortstamm-Gruppen für den Rätsel-Generator.

Ziel: In einem Rätsel sollen keine Wörter mit demselben Stamm vorkommen (ENDE / ENDEN / ENDET, TRENNE / TRENNT).
Der Solver blockiert bisher nur *identische* Wörter. Hier wird jedem Wort eine Gruppen-ID zugeordnet; der Solver
(tools/solver/fill_solver.cpp, 5. Pool-Spalte "gruppe") lässt pro Rätsel höchstens ein Wort je Gruppe zu.

Das ist eine regelbasierte Näherung ohne Lemmatisierer (kein Wortart-Tagger, keine Wörterbuchdaten):
  1. Flexionsendung abtrennen (längste passende zuerst, Rest mindestens 3 Buchstaben) -> gleicher Schlüssel = gleiche Gruppe.
  2. Optional (min_komp > 0, Standard AUS): Komposita – ist der Schlüssel eines Worts (mindestens min_komp Buchstaben) Anfang des
     Schlüssels eines längeren Worts, werden beide zusammengelegt (SCHNEE / SCHNEEMANN). Im Bestand von 104 Rätseln fand die Regel
     keine einzige zusätzliche Kollision, bildet aber Fehlgruppen (min_komp=5: STREI = STREIT/STREIK/STREICHEN ... 12 Wörter), daher aus.
Folgen: Fehlgruppierungen (z. B. KATER/KATE) schränken den Pool nur minimal ein; echte Verwandte mit Ablaut
(GEHEN/GING) werden NICHT erkannt.
"""
import bisect
from collections import defaultdict

SUFFIXE = sorted(['ETEN', 'ETET', 'ETE', 'TEN', 'TET', 'EST', 'EN', 'ER', 'ES', 'EM', 'ET', 'TE', 'ST', 'E', 'N', 'S', 'T'],
                 key=lambda s: -len(s))


def schluessel(w):
    for s in SUFFIXE:
        rest = len(w) - len(s)
        # Bei nur 3 Buchstaben Rest nur Endungen mit E (ENDE/ENDEN/ENDET, ENG/ENGE) bzw. -S/-EN (OMA/OMAS, EHE/EHEN); sonst wären LAS/LAST, SEI/SEIT 'verwandt'.
        if w.endswith(s) and (rest >= 4 or (rest == 3 and (s.startswith('E') or s == 'S' or (s == 'N' and w[-2] == 'E')))):
            return w[:-len(s)]
    return w


def gruppen(woerter, min_komp=0):
    """woerter: Iterable[str] -> dict wort -> Gruppen-ID (str, = kleinster Schlüssel der Gruppe)."""
    woerter = sorted(set(woerter))
    key = {w: schluessel(w) for w in woerter}
    parent = {}

    def find(x):
        parent.setdefault(x, x)
        while parent[x] != x:
            parent[x] = parent[parent[x]]
            x = parent[x]
        return x

    def union(a, b):
        ra, rb = find(a), find(b)
        if ra != rb:
            parent[max(ra, rb)] = min(ra, rb)

    keys = sorted(set(key.values()))
    for k in keys:
        find(k)
    if min_komp:
        for k in keys:
            if len(k) < min_komp:
                continue
            i = bisect.bisect_right(keys, k)
            while i < len(keys) and keys[i].startswith(k):
                union(k, keys[i]); i += 1
    return {w: find(key[w]) for w in woerter}


def kollisionen(woerter, grp):
    """Anzahl überzähliger Wörter in gleicher Gruppe + die betroffenen Gruppen {gruppe: [wörter]}."""
    d = defaultdict(list)
    for w in woerter:
        d[grp.get(w) or schluessel(w)].append(w)
    k = {g: ws for g, ws in d.items() if len(ws) > 1}
    return sum(len(ws) - 1 for ws in k.values()), k
