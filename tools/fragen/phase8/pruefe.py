"""Phase 8 – Formale Prüfung der neuen Fragen.
Aufruf: python3 pruefe.py clues_01.txt [...]   (Zeilenformat: schreibweise|frage, '-' = keine neue Frage)
Prüft wie tools/fragen/check.py (E3 Länge, E4 Stamm in Frage, W1 langes Wort, W2 Sammelfrage) und zusätzlich:
  E5 Wort unbekannt / doppelt / fehlt gegenüber batch_NN.txt
  E6 neue Frage identisch mit einer vorhandenen Frage des Worts
  E7 Frage leer
"""
import sys, os, csv, re, collections
HIER = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HIER, '..'))
import check  # tools/fragen/check.py

fragen = collections.defaultdict(list)
sw2wort = {}
for r in csv.DictReader(open(os.path.join(HIER, '..', '..', '..', 'data', 'fragen', 'fragen.tsv'), encoding='utf-8'), delimiter='\t'):
    fragen[r['wort']].append(r['frage'])
    sw2wort[r['schreibweise']] = r['wort']

def pruefe(pfad):
    nr = re.search(r'clues_(\d+)', pfad).group(1)
    batch = open(os.path.join(HIER, f'batch_{nr}.txt'), encoding='utf-8').read().split()
    errs, warns, ok, gesehen = [], [], [], set()
    for n, zeile in enumerate(open(pfad, encoding='utf-8'), 1):
        zeile = zeile.rstrip('\n')
        if not zeile.strip():
            continue
        if '|' not in zeile:
            errs.append(f'{n}: kein Trenner: {zeile}'); continue
        sw, c = [x.strip() for x in zeile.split('|', 1)]
        w = sw2wort.get(sw)
        if w is None or w not in batch:
            errs.append(f'E5 {sw}: unbekannt/nicht im Batch'); continue
        if w in gesehen:
            errs.append(f'E5 {sw}: doppelt')
        gesehen.add(w)
        if not c:
            errs.append(f'E7 {sw}: leer'); continue
        if c == '-':
            continue
        woerter = c.split()
        if len(c) > 22 or len(woerter) > 3:
            errs.append(f'E3 {sw}: zu lang ({len(c)} Z., {len(woerter)} W.): {c}')
        if w not in check.OVERRIDE and check.stem_hit(check.norm(w), c):
            errs.append(f'E4 {sw}: Lösung/Stamm in Frage: {c}')
        if c in fragen[w]:
            errs.append(f'E6 {sw}: Frage schon vorhanden: {c}')
        for x in woerter:
            if len(re.sub(r'[^\wÄÖÜäöüß]', '', x)) > 12:
                warns.append(f'W1 {sw}: langes Wort {x!r}')
        ok.append((w, c))
    for w in batch:
        if w not in gesehen:
            errs.append(f'E5 {w}: fehlt')
    return errs, warns, ok

if __name__ == '__main__':
    alle = collections.defaultdict(list); fehler = 0
    for p in sys.argv[1:]:
        errs, warns, ok = pruefe(p)
        for w, c in ok: alle[c].append(w)
        print(f'== {p}: {len(ok)} neue Fragen, {len(errs)} Fehler, {len(warns)} Warnungen')
        for e in errs + warns: print('  ', e)
        fehler += len(errs)
    for c, ws in sorted(alle.items(), key=lambda x: -len(x[1])):
        if len(ws) > 3: print(f"W2 '{c}' bei {len(ws)} Lösungen: {' '.join(ws[:8])}")
    sys.exit(1 if fehler else 0)
