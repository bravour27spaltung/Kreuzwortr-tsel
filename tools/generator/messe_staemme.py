#!/usr/bin/env python3
"""Zählt Stamm-Kollisionen je Rätsel im Bestand (public/raetsel). Aufruf: python3 tools/generator/messe_staemme.py [--min-komp N] [--top N]"""
import argparse, csv, glob, json, os, sys
from collections import Counter
sys.path.insert(0, os.path.dirname(__file__))
import staemme


def woerter(pfad):
    p = json.load(open(pfad, encoding='utf-8'))['puzzle']; s = p['solution']
    out = []
    for e in p['entries']:
        dr, dc = (1, 0) if e['dir'] == 'D' else (0, 1)
        out.append(''.join(s[f"{e['r'] + i * dr},{e['c'] + i * dc}"] for i in range(e['len'])))
    return out


ap = argparse.ArgumentParser()
ap.add_argument('--dir', default='public/raetsel'); ap.add_argument('--fragen', default='data/fragen/fragen.tsv')
ap.add_argument('--min-komp', type=int, default=0); ap.add_argument('--top', type=int, default=15)
a = ap.parse_args()
pool = {r['wort'] for r in csv.DictReader(open(a.fragen, encoding='utf-8'), delimiter='\t')}
grp = staemme.gruppen(pool, a.min_komp)
gs = Counter(grp.values())
print(f'Pool: {len(pool)} Wörter, {len(gs)} Gruppen, davon {sum(1 for n in gs.values() if n > 1)} mit >1 Wort, größte: {gs.most_common(5)}')
dateien = sorted(f for f in glob.glob(os.path.join(a.dir, 'r*.json')))
tot = 0; mit = 0; paare = Counter(); n = 0
for f in dateien:
    ws = woerter(f); extra, k = staemme.kollisionen(ws, grp); n += 1
    tot += extra; mit += extra > 0
    for ws_ in k.values(): paare[tuple(sorted(ws_))] += 1
print(f'{n} Rätsel: {mit} ({100 * mit / n:.0f} %) mit mind. einer Stamm-Kollision, {tot} überzählige Wörter insgesamt, {tot / n:.2f} je Rätsel')
print('häufigste Kollisionen:'); [print('  ', p, c) for p, c in paare.most_common(a.top)]
