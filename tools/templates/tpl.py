"""Rastervorlagen: Erzeugung, Strukturpruefung und Kennzahlen fuer geschlossene Schwedenraetsel-Skelette.
Konvention: dark[r][c] True = dunkle Zelle. Zeile 0 und Spalte 0 sind komplett dunkel (Rand-Reservierung).
Ein Eintrag ist eine zusammenhaengende weisse Folge der Laenge >= 2 (waagerecht/senkrecht); erlaubt sind Laengen minlen..maxl.
Frage-Zelle eines Eintrags = die dunkle Zelle direkt davor."""
import random, collections

def runs(dark, h, w):
    R = []
    for r in range(h):
        c = 0
        while c < w:
            if not dark[r][c]:
                s = c
                while c < w and not dark[r][c]: c += 1
                R.append(('A', [(r, x) for x in range(s, c)]))
            else: c += 1
    for c in range(w):
        r = 0
        while r < h:
            if not dark[r][c]:
                s = r
                while r < h and not dark[r][c]: r += 1
                R.append(('D', [(y, c) for y in range(s, r)]))
            else: r += 1
    return R

def make(h, w, minlen, maxl, p0, rng):
    dark = [[(r == 0 or c == 0 or rng.random() < p0) for c in range(w)] for r in range(h)]
    for _ in range(400):
        changed = False
        R = runs(dark, h, w); rng.shuffle(R)
        for d, run in R:
            if any(dark[r][c] for r, c in run): continue
            L = len(run)
            if L == 1: continue
            if L < minlen:
                r, c = rng.choice(run); dark[r][c] = True; changed = True
            elif L > maxl:
                lo, hi = minlen, L - minlen - 1
                if hi < lo: return None
                r, c = run[rng.randint(lo, hi)]; dark[r][c] = True; changed = True
        cov = {cell for d, run in runs(dark, h, w) if len(run) >= 2 for cell in run}
        for r in range(h):
            for c in range(w):
                if not dark[r][c] and (r, c) not in cov: dark[r][c] = True; changed = True
        if not changed: break
    else: return None
    if any(len(run) >= 2 and not (minlen <= len(run) <= maxl) for d, run in runs(dark, h, w)): return None
    return dark

def entries(dark, h, w):
    return [(d, run) for d, run in runs(dark, h, w) if len(run) >= 2]

def metrics(dark, h, w):
    E = entries(dark, h, w)
    lens = [len(r) for d, r in E]
    white = [(r, c) for r in range(h) for c in range(w) if not dark[r][c]]
    ws = set(white)
    # Zusammenhang der weissen Zellen
    seen = set(); stack = [white[0]] if white else []
    while stack:
        x = stack.pop()
        if x in seen: continue
        seen.add(x)
        for dr, dc in ((1,0),(-1,0),(0,1),(0,-1)):
            y = (x[0]+dr, x[1]+dc)
            if y in ws and y not in seen: stack.append(y)
    connected = len(seen) == len(ws)
    # Frage-Zellen
    clue = collections.defaultdict(list)
    for d, run in E:
        r, c = run[0]
        cr, cc = (r, c-1) if d == 'A' else (r-1, c)
        clue[(cr, cc)].append(d)
    ndark = h*w - len(white)
    waste = sum(1 for r in range(h) for c in range(w) if dark[r][c] and (r, c) != (0, 0) and (r, c) not in clue)
    # 2x2-Bloecke dunkler Zellen im Innern (r,c >= 1)
    blocks = sum(1 for r in range(1, h-1) for c in range(1, w-1) if dark[r][c] and dark[r+1][c] and dark[r][c+1] and dark[r+1][c+1])
    cnt = collections.Counter(); 
    for d, run in E:
        for cell in run: cnt[cell] += 1
    crossed = sum(1 for cell in white if cnt[cell] >= 2) / len(white)
    L = collections.Counter(lens)
    return dict(h=h, w=w, entries=len(E), density=ndark/(h*w), connected=connected, waste=waste, ndark=ndark,
                blocks=blocks, crossed=crossed, lens=dict(sorted(L.items())), share3=L[3]/len(E), meanlen=sum(lens)/len(lens),
                maxlen=max(lens), n_ge6=sum(1 for x in lens if x >= 6), n_ge7=sum(1 for x in lens if x >= 7))

def write_skel(f, dark, h, w):
    E = entries(dark, h, w)
    f.write(f'S {h*w} {len(E)}\n')
    for d, run in E: f.write(str(len(run)) + ' ' + ' '.join(str(r*w+c) for r, c in run) + '\n')
