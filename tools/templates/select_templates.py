#!/usr/bin/env python3
"""Endauswahl der Vorlagen. Rangfolge je Groesse: (1) Erfolge gegen den Pool der 10.000 haeufigsten Woerter, (2) Erfolge gegen 20.000,
(3) Strukturqualitaet; dazu Mindestabstand (>= 15 % der Zellen unterscheiden sich) zwischen gewaehlten Vorlagen.
Quellen: Stufe 3 (res/st3_*, T20000), Stufe 3b (res/st3b_*, T10000), Bestaetigung 13x13/15x15 (res/conf_*)."""
import json, glob, collections, os
QUOTA = {'8x8': 3, '9x9': 3, '9x13': 3, '10x10': 4, '11x11': 3, '12x12': 4, '13x13': 3, '15x15': 3}
def quality(m): return m['crossed'] - 0.5 * m['waste'] / m['ndark'] - abs(m['share3'] - 0.30)
def tally(pattern, n):
    ok = collections.Counter(); tot = collections.Counter()
    for f in glob.glob(pattern):
        for l in open(f):
            p = l.split()
            if p: tot[int(p[0])] += 1; ok[int(p[0])] += (p[1] == 'ok')
    return ok, tot
out = []
for size, k in QUOTA.items():
    if size in ('13x13', '15x15'):
        C = json.load(open(f'cand/w{size}.json'))
        o10, t10 = tally(f'res/conf_{size}_T10000_*.txt', len(C)); o20, t20 = tally(f'res/conf_{size}_T20000_*.txt', len(C))
    else:
        C = json.load(open(f'cand/t{size}.json'))                       # alle im 2-s-Test loesbaren Kandidaten
        o20, t20 = tally(f'res/st3_{size}_*.txt', len(C))
        o10 = collections.Counter(); t10 = collections.Counter()
        if os.path.exists(f'cand/u{size}.json'):                        # nur T20000-robuste wurden gegen T10000 getestet
            U = json.load(open(f'cand/u{size}.json')); key = {tuple(map(tuple, m['dark'])): i for i, m in enumerate(C)}
            ob, tb = tally(f'res/st3b_{size}_*.txt', len(U))
            for j, m in enumerate(U):
                i = key[tuple(map(tuple, m['dark']))]; o10[i] = ob[j]; t10[i] = tb[j]
    def score(i): return (o10[i] / t10[i] if t10[i] else -1, o20[i] / t20[i] if t20[i] else 0, quality(C[i]))
    order = sorted(range(len(C)), key=lambda i: score(i), reverse=True); chosen = []
    for i in order:
        cells = {tuple(x) for x in C[i]['dark']}
        if all(len(cells ^ {tuple(x) for x in C[j]['dark']}) >= 0.15 * C[i]['h'] * C[i]['w'] for j in chosen): chosen.append(i)
        if len(chosen) == k: break
    for r, i in enumerate(chosen, 1):
        m = dict(C[i]); m['name'] = f'{size}-{r:02d}'; out.append(m)
    print(size, 'gewaehlt (T10000, T20000):', [(f'{o10[i]}/{t10[i]}', f'{o20[i]}/{t20[i]}') for i in chosen])
os.makedirs('sel', exist_ok=True); json.dump(out, open('sel/selected.json', 'w'))
