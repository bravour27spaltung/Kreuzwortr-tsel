#!/usr/bin/env python3
"""Unabhängige Prüfung eines Rätselbestands (public/raetsel): Lösungswörter im Fragenpool, Frage gehört zum Wort, Einträge/Zellen
passen zur Vorlage, keine doppelten Wörter und keine Stamm-Kollisionen im Rätsel; dazu Wort- und Schwierigkeitsstatistik.
Aufruf: python3 tools/generator/pruefe_bestand.py [--dir public/raetsel]"""
import argparse, csv, glob, json, os, sys
from collections import Counter, defaultdict
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import staemme

ap = argparse.ArgumentParser()
ap.add_argument('--dir', default='public/raetsel'); ap.add_argument('--vorlagen', default='data/gitter/vorlagen.json')
ap.add_argument('--fragen', default='data/fragen/fragen.tsv'); ap.add_argument('--funktionswoerter', default='tools/generator/funktionswoerter.txt')
a = ap.parse_args()
V = {v['name']: v for v in json.load(open(a.vorlagen, encoding='utf-8'))}
F = defaultdict(set)
for r in csv.DictReader(open(a.fragen, encoding='utf-8'), delimiter='\t'): F[r['wort']].add(r['frage'])
fw = {l.strip() for l in open(a.funktionswoerter, encoding='utf-8') if l.strip() and not l.startswith('#')}
grp = staemme.gruppen(F.keys())
fehler, verw, slugs, schw, nfw = [], Counter(), set(), Counter(), []
dateien = sorted(glob.glob(os.path.join(a.dir, 'r*.json')))
idx = json.load(open(os.path.join(a.dir, 'index.json'), encoding='utf-8'))
if sorted(e['id'] for e in idx) != [os.path.basename(f)[:-5] for f in dateien]: fehler.append('index.json passt nicht zu den Dateien')
for f in dateien:
    d = json.load(open(f, encoding='utf-8')); p = d['puzzle']; sl = d['id']; slugs.add(sl)
    name = sl.split('-', 1)[1]; v = V[name]; S = p['solution']
    if d['status'] != 'veroeffentlicht' or d['pruefhinweise']: fehler.append(f'{sl}: Status/Hinweise {d["status"]} {d["pruefhinweise"]}')
    if (p['rows'], p['cols']) != (v['zeilen'], v['spalten']): fehler.append(f'{sl}: Größe')
    if len(p['entries']) != len(v['eintraege']): fehler.append(f'{sl}: Eintragszahl')
    ws = []
    for e, ve in zip(p['entries'], v['eintraege']):
        if {k: e[k] for k in ('dir', 'r', 'c', 'len')} != {k: ve[k] for k in ('dir', 'r', 'c', 'len')}: fehler.append(f'{sl}: Eintrag weicht von Vorlage ab {e}')
        dr, dc = (1, 0) if e['dir'] == 'D' else (0, 1)
        w = ''.join(S[f"{e['r'] + i * dr},{e['c'] + i * dc}"] for i in range(e['len'])); ws.append(w)
        if w not in F: fehler.append(f'{sl}: {w} nicht im Fragenpool')
        elif e['clue'] not in F[w]: fehler.append(f'{sl}: Frage "{e["clue"]}" gehört nicht zu {w}')
    if len(set(ws)) != len(ws): fehler.append(f'{sl}: doppelte Wörter')
    n, k = staemme.kollisionen(ws, grp)
    if n: fehler.append(f'{sl}: Stamm-Kollision {list(k.values())}')
    dunkel = {tuple(x) for x in v['dunkle_zellen']}
    weiss = {f'{r},{c}' for r in range(v['zeilen']) for c in range(v['spalten']) if (r, c) not in dunkel}
    if set(S) != weiss: fehler.append(f'{sl}: belegte Zellen != weiße Zellen')
    cl = [e['clue'] for e in p['entries']]
    if len(set(cl)) != len(cl): fehler.append(f'{sl}: doppelter Fragetext')
    nfw.append(sum(w in fw for w in ws)); verw.update(ws); schw[d['schwierigkeit']] += 1
n = len(dateien); tot = sum(verw.values())
print(f'{n} Rätsel, {tot} Einträge, {len(verw)} verschiedene Wörter, davon {sum(1 for c in verw.values() if c == 1)} nur einmal; Fehler: {len(fehler)}')
print('häufigste Wörter:', ', '.join(f'{w} {c} ({100 * c / n:.1f} %)' for w, c in verw.most_common(8)))
print('Wörter über Limit 15:', {w: c for w, c in verw.items() if c > 15})
print('Schwierigkeit (1 leicht/2 mittel/3 schwer):', dict(sorted(schw.items())), '| Funktionswörter je Rätsel: Ø %.2f, max %d' % (sum(nfw) / n, max(nfw)))
for x in fehler[:25]: print('FEHLER', x)
sys.exit(1 if fehler else 0)
