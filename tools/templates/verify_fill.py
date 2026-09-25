#!/usr/bin/env python3
"""Prueft Loesungsdateien des Solvers (SOLFILE) gegen vorlagen.json und eine Wortliste.
Aufruf: verify_fill.py <vorlagen.json> <wortliste.tsv> <loesung1.sol> [...]
Pro Zeile: '<Index der Vorlage> <Wort je Eintrag in der Reihenfolge von vorlagen.json/eintraege>'.
Geprueft: Wort in der Liste, Laenge passt, keine Doppelten, Buchstaben an Kreuzungen identisch."""
import json, sys, csv
V = json.load(open(sys.argv[1])); W = {r['wort'] for r in csv.DictReader(open(sys.argv[2]), delimiter='\t')}
tot = bad = 0; why = {}
for f in sys.argv[3:]:
    for line in open(f):
        p = line.split()
        if not p: continue
        v = V[int(p[0])]; ws = p[1:]; E = v['eintraege']; ok = len(ws) == len(E) and len(set(ws)) == len(ws); cell = {}
        for e, w in zip(E, ws):
            if len(w) != e['len'] or w not in W: ok = False
            for i, ch in enumerate(w):
                pos = (e['r'], e['c'] + i) if e['dir'] == 'A' else (e['r'] + i, e['c'])
                if cell.setdefault(pos, ch) != ch: ok = False
        white = {(r, c) for r in range(v['zeilen']) for c in range(v['spalten'])} - {tuple(x) for x in v['dunkle_zellen']}
        if set(cell) != white: ok = False
        tot += 1; bad += (not ok)
print('Loesungen geprueft:', tot, 'fehlerhaft:', bad)
