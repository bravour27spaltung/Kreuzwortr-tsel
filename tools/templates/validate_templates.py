#!/usr/bin/env python3
"""Unabhaengige Strukturpruefung der exportierten Vorlagen (rechnet alles aus dunkle_zellen neu, ohne tpl.py).
Aufruf: validate_templates.py <vorlagen.json>  -> schreibt validated_names.json neben die Eingabedatei"""
import json, sys, os, collections
V = json.load(open(sys.argv[1])); ok_names = []; problems = collections.defaultdict(list)
for v in V:
    h, w = v['zeilen'], v['spalten']; D = {tuple(x) for x in v['dunkle_zellen']}; P = problems[v['name']]
    if len(D) != len(v['dunkle_zellen']): P.append('doppelte Zellen')
    if any(not (0 <= r < h and 0 <= c < w) for r, c in D): P.append('Zelle ausserhalb')
    if any((0, c) not in D for c in range(w)) or any((r, 0) not in D for r in range(h)): P.append('Rand nicht dunkel')
    white = {(r, c) for r in range(h) for c in range(w)} - D
    if abs(len(D) / (h * w) - v['dichte']) > 1e-3: P.append('Dichte falsch')
    # Eintraege neu berechnen
    def scan(cells_lines, d):
        for line in cells_lines:
            cur = []
            for cell in line + [None]:
                if cell is not None and cell in white: cur.append(cell)
                else:
                    if len(cur) >= 2: runs.append((d, cur))
                    cur = []
    runs = []
    scan([[(r, c) for c in range(w)] for r in range(h)], 'A'); scan([[(r, c) for r in range(h)] for c in range(w)], 'D')
    covered = {c for d, run in runs for c in run}
    if covered != white: P.append('weisse Zellen ohne Eintrag: %d' % len(white - covered))
    for d, run in runs:
        if not (3 <= len(run) <= 8): P.append('Eintragslaenge %d' % len(run))
        r, c = run[0]; cell = (r, c - 1) if d == 'A' else (r - 1, c)
        if cell not in D: P.append('Fragezelle fehlt')
    # exportierte Eintraege == berechnete
    mine = sorted((d, run[0][0], run[0][1], len(run)) for d, run in runs)
    theirs = sorted((e['dir'], e['r'], e['c'], e['len']) for e in v['eintraege'])
    if mine != theirs: P.append('Eintragsliste weicht ab')
    for e in v['eintraege']:
        exp = (e['r'], e['c'] - 1) if e['dir'] == 'A' else (e['r'] - 1, e['c'])
        if (e['clueR'], e['clueC']) != exp: P.append('clue-Zelle falsch')
    # Zusammenhang
    seen = set(); st = [next(iter(white))]
    while st:
        x = st.pop()
        if x in seen: continue
        seen.add(x)
        for dr, dc in ((1, 0), (-1, 0), (0, 1), (0, -1)):
            y = (x[0] + dr, x[1] + dc)
            if y in white and y not in seen: st.append(y)
    if seen != white: P.append('nicht zusammenhaengend')
    if any((r, c) in D and (r + 1, c) in D and (r, c + 1) in D and (r + 1, c + 1) in D for r in range(1, h - 1) for c in range(1, w - 1)): P.append('2x2-Block dunkel')
    if not P: ok_names.append(v['name'])
bad = {k: p for k, p in problems.items() if p}
json.dump(ok_names, open(os.path.join(os.path.dirname(os.path.abspath(sys.argv[1])), 'validated_names.json'), 'w'))
print(len(ok_names), 'von', len(V), 'Vorlagen bestehen die Strukturpruefung'); print(bad if bad else 'keine Beanstandungen')
