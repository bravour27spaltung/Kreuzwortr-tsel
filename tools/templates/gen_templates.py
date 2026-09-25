#!/usr/bin/env python3
"""Erzeugt Kandidaten fuer Rastervorlagen einer Groesse, filtert nach Struktur-/Qualitaetsregeln und schreibt
<out>.skel (Solver-Format) und <out>.json (Kennzahlen + dunkle Zellen).
Aufruf: gen_templates.py <h> <w> <n_versuche> <seed> <out>"""
import sys, json, random
sys.path.insert(0, __file__.rsplit('/', 1)[0] if '/' in __file__ else '.')
import tpl

def accept(m, h, w):
    if not m['connected'] or m['blocks'] > 0: return False
    if m['maxlen'] > min(8, min(h, w) - 2): return False
    if m['waste'] > (0.25 if min(h, w) >= 9 else 0.30) * m['ndark']: return False
    if m['crossed'] < 0.75: return False
    big = min(h, w) >= 10
    if m['share3'] > (0.35 if big else 0.55): return False
    if big and m['meanlen'] < 4.0: return False
    if not (0.26 <= m['density'] <= (0.42 if min(h, w) >= 9 else 0.48)): return False
    if m['n_ge6'] < (2 if big else 0): return False
    return True

def canon(dark, h, w):
    a = tuple(tuple(r) for r in dark)
    t = tuple(tuple(dark[r][c] for r in range(h)) for c in range(w)) if h == w else None
    return min(a, t) if t else a

def main():
    h, w, n, seed, out = int(sys.argv[1]), int(sys.argv[2]), int(sys.argv[3]), int(sys.argv[4]), sys.argv[5]
    rng = random.Random(seed); seen = set(); keep = []
    for i in range(n):
        p0 = rng.choice([0.0, 0.02, 0.04, 0.06, 0.08])
        d = tpl.make(h, w, 3, min(8, min(h, w) - 2), p0, rng)
        if not d: continue
        m = tpl.metrics(d, h, w)
        if not accept(m, h, w): continue
        k = canon(d, h, w)
        if k in seen: continue
        seen.add(k); keep.append((d, m))
    with open(out + '.skel', 'w') as f:
        for d, m in keep: tpl.write_skel(f, d, h, w)
    json.dump([dict(m, dark=[[r, c] for r in range(h) for c in range(w) if d[r][c]]) for d, m in keep], open(out + '.json', 'w'))
    print(f'{h}x{w}: {len(keep)} akzeptiert von {n} Versuchen')

if __name__ == '__main__': main()
