import csv,glob,re,sys
def sk(name):
    lines=open(f'sk/{name}.txt').read().split('\n'); i=0; out=[]
    while i<len(lines):
        if lines[i].startswith('S'):
            ne=int(lines[i].split()[2]); out.append([list(map(int,l.split()[1:])) for l in lines[i+1:i+1+ne]]); i+=1+ne
        else: i+=1
    return out
tot=bad=0
for f in sorted(glob.glob('res/lsol_*.txt')+glob.glob('res/sol_*.txt')):
    m=re.match(r'res/lsol_(\w+?)_(all|a8|a14)_(big_\d+_\d)\.txt',f)
    if m: L,S=m.group(1),m.group(3)
    else:
        m=re.match(r'res/sol_(c7|big_\d+_\d)\.txt',f)
        if not m: continue
        L,S='B','c7_10' if m.group(1)=='c7' else m.group(1)
    W={r['wort'] for r in csv.DictReader(open(f'out/{L}_gefiltert.tsv'),delimiter='\t')}
    K=sk(S)
    for line in open(f):
        p=line.split(); ents=K[int(p[0])]; ws=p[1:]; ok=len(ws)==len(ents) and len(set(ws))==len(ws); cell={}
        for e,w in zip(ents,ws):
            if len(e)!=len(w) or w not in W: ok=False
            for c,ch in zip(e,w):
                if cell.setdefault(c,ch)!=ch: ok=False
        tot+=1; bad+=(not ok)
print('Loesungen geprueft:',tot,'fehlerhaft:',bad)
