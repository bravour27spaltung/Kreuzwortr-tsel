import sys, random
# Aufruf: gen_skel3.py <h> <w> <n> <minlen> <maxlen> <pdark0> <seed> <out>
h,w,n,minlen,maxl,p0,seed,out = int(sys.argv[1]),int(sys.argv[2]),int(sys.argv[3]),int(sys.argv[4]),int(sys.argv[5]),float(sys.argv[6]),int(sys.argv[7]),sys.argv[8]
def runs(dark):
    R=[]
    for r in range(h):
        c=0
        while c<w:
            if not dark[r][c]:
                s=c
                while c<w and not dark[r][c]: c+=1
                R.append([(r,x) for x in range(s,c)])
            else: c+=1
    for c in range(w):
        r=0
        while r<h:
            if not dark[r][c]:
                s=r
                while r<h and not dark[r][c]: r+=1
                R.append([(y,c) for y in range(s,r)])
            else: r+=1
    return R
def make(rng):
    dark=[[(r==0 or c==0 or rng.random()<p0) for c in range(w)] for r in range(h)]
    for it in range(400):
        changed=False
        R=runs(dark); rng.shuffle(R)
        for run in R:
            if any(dark[r][c] for r,c in run): continue   # already changed this pass
            L=len(run)
            if L==1: continue
            if L<minlen:
                r,c=rng.choice(run); dark[r][c]=True; changed=True
            elif L>maxl:
                lo=minlen; hi=L-minlen-1     # Position der Trennzelle, beide Teile >= minlen
                i=rng.randint(lo,hi); r,c=run[i]; dark[r][c]=True; changed=True
        # Abdeckung
        R=runs(dark); cov={cell for run in R if len(run)>=2 for cell in run}
        for r in range(h):
            for c in range(w):
                if not dark[r][c] and (r,c) not in cov: dark[r][c]=True; changed=True
        if not changed: break
    else: return None
    R=[x for x in runs(dark) if len(x)>=2]
    if any(len(x)<minlen or len(x)>maxl for x in R) or len(R)<6: return None
    return dark,R
rng=random.Random(seed); ok=0; dens=[]
with open(out,'w') as f:
    while ok<n:
        m=make(rng)
        if not m: continue
        dark,R=m; ok+=1; dens.append(sum(map(sum,dark))/(h*w))
        f.write(f'S {h*w} {len(R)}\n')
        for e in R: f.write(str(len(e))+' '+' '.join(str(r*w+c) for r,c in e)+'\n')
print(out,'n',n,'Dichte mean',round(sum(dens)/len(dens),3))
