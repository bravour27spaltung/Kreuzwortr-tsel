#!/usr/bin/env python3
"""Regressionstest: Wie oft laesst sich ein geschlossenes Raster mit einer Wortliste befuellen?
Aufruf: solver_test.py <liste.tsv-Praefix|baseline> <hoehe> <breite> <n_skelette> <zeitlimit_s> [seed]
Liste: 'baseline' = alles >=5; 'filtered:<minfreq>:<minfreq_short>' = gefilterte Liste mit Haeufigkeitsgrenzen."""
import sys, csv, random, time, collections, os
MINLEN = int(os.environ.get('MINLEN', '3')); PDARK = float(os.environ.get('PDARK', '0.22'))

def load(spec, prefix):
    kept = list(csv.DictReader(open(prefix + '_gefiltert.tsv'), delimiter='\t'))
    exc = list(csv.DictReader(open(prefix + '_ausgeschlossen.tsv'), delimiter='\t'))
    if spec == 'final':
        ws = {r['wort'] for r in kept}
    elif spec == 'baseline':
        ws = {r['wort'] for r in kept} | {r['wort'] for r in exc}
    else:
        _, mf, mfs = spec.split(':'); mf, mfs = int(mf), int(mfs)
        rows = kept + [r for r in exc if r['grund'] == 'zu_selten']   # gefiltert, aber ohne Haeufigkeitsgrenze
        ws = {r['wort'] for r in rows if int(r['haeufigkeit']) >= (mfs if int(r['laenge']) <= 4 else mf)}
    byl = collections.defaultdict(list)
    for w in ws: byl[len(w)].append(w)
    return byl

def skeleton(h, w, p, rng, maxL=11):
    while True:
        dark = [[(r == 0 or c == 0 or rng.random() < p) for c in range(w)] for r in range(h)]
        ents = []
        for r in range(h):                       # waagerecht
            c = 0
            while c < w:
                if not dark[r][c]:
                    s = c
                    while c < w and not dark[r][c]: c += 1
                    if c - s >= 2: ents.append([(r, x) for x in range(s, c)])
                else: c += 1
        for c in range(w):                       # senkrecht
            r = 0
            while r < h:
                if not dark[r][c]:
                    s = r
                    while r < h and not dark[r][c]: r += 1
                    if r - s >= 2: ents.append([(y, c) for y in range(s, r)])
                else: r += 1
        if any(len(e) < MINLEN or len(e) > maxL for e in ents): continue
        cov = {cell for e in ents for cell in e}
        if any((not dark[r][c]) and (r, c) not in cov for r in range(h) for c in range(w)): continue
        if len(ents) < 6: continue
        return ents

def solve(ents, byl, tlimit, rng):
    idx = {L: [collections.defaultdict(set) for _ in range(L)] for L in byl}
    for L, ws in byl.items():
        for wd in ws:
            for i, ch in enumerate(wd): idx[L][i][ch].add(wd)
    allw = {L: set(ws) for L, ws in byl.items()}
    grid = {}
    used = set(); assigned = [None] * len(ents); nodes = 0; t0 = time.time()
    cells = collections.defaultdict(list)
    for k, e in enumerate(ents):
        for i, cell in enumerate(e): cells[cell].append((k, i))
    def cands(k):
        e = ents[k]; L = len(e)
        if L not in allw: return set()
        sets = [idx[L][i][grid[c]] for i, c in enumerate(e) if c in grid]
        if not sets: return allw[L] - used
        sets.sort(key=len); s = set(sets[0])
        for o in sets[1:]:
            s &= o
            if not s: return s
        return s - used
    def rec():
        nonlocal nodes
        if time.time() - t0 > tlimit: raise TimeoutError
        free = [k for k in range(len(ents)) if assigned[k] is None]
        if not free: return True
        best = None; bc = None
        for k in free:
            c = cands(k)
            if not c: return False
            if bc is None or len(c) < len(bc): best, bc = k, c
        vals = list(bc); rng.shuffle(vals)
        e = ents[best]
        for wd in vals:
            nodes += 1
            newc = [c for c in e if c not in grid]
            for i, c in enumerate(e): grid[c] = wd[i]
            assigned[best] = wd; used.add(wd)
            if rec(): return True
            for c in newc: del grid[c]
            assigned[best] = None; used.discard(wd)
        return False
    try:
        ok = rec()
    except TimeoutError:
        return 'timeout', nodes, time.time() - t0
    return ('ok' if ok else 'unsat'), nodes, time.time() - t0

if __name__ == '__main__':
    spec, h, w, n, tl = sys.argv[1], int(sys.argv[2]), int(sys.argv[3]), int(sys.argv[4]), float(sys.argv[5])
    seed = int(sys.argv[6]) if len(sys.argv) > 6 else 1
    byl = load(spec, sys.argv[7] if len(sys.argv) > 7 else 'out/v3')
    res = collections.Counter(); tm = []
    for s in range(n):
        ents = skeleton(h, w, PDARK, random.Random(1000 * h + 10 * w + s + seed * 7919))
        r, nodes, t = solve(ents, byl, tl, random.Random(s))
        res[r] += 1; tm.append(t)
    print(f'{spec:22} {h}x{w} minlen={MINLEN}: ok={res["ok"]:>2} unsat={res["unsat"]:>2} timeout={res["timeout"]:>2} von {n}  (Median {sorted(tm)[len(tm)//2]:.2f}s)')
