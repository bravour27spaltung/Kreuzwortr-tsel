"""Exportiert die Phase-4-Fragen als TSV und SQL.
Eingabe: clues/bNN.txt (schreibweise|frage, '-' = bewusst ohne Frage), top10000.json (Wortliste-Auszug).
Ausgabe: export/fragen.tsv, export/ohne_frage.tsv, export/fragen_varianten_seed.sql
"""
import json, glob, csv
words = json.load(open('top10000.json'))
by_sw = {w['schreibweise']: (i + 1, w) for i, w in enumerate(words)}
rows, skipped = [], []
for p in sorted(glob.glob('clues/b*.txt')):
    for l in open(p, encoding='utf-8'):
        sw, c = l.rstrip('\n').split('|', 1)
        rang, w = by_sw[sw]
        if c == '-':
            skipped.append((w['wort'], sw, rang)); continue
        schw = 1 if rang <= 3000 else (2 if rang <= 7000 else 3)
        rows.append((w['wort'], sw, c, int(w['laenge']), int(w['haeufigkeit']), rang, schw))
with open('export/fragen.tsv', 'w', encoding='utf-8', newline='') as f:
    t = csv.writer(f, delimiter='\t', lineterminator='\n')
    t.writerow(['wort', 'schreibweise', 'frage', 'laenge', 'haeufigkeit', 'rang', 'schwierigkeit', 'quelle', 'geprueft'])
    for r in rows:
        t.writerow(list(r) + ['claude-entwurf', 'false'])
with open('export/ohne_frage.tsv', 'w', encoding='utf-8', newline='') as f:
    t = csv.writer(f, delimiter='\t', lineterminator='\n')
    t.writerow(['wort', 'schreibweise', 'rang', 'grund'])
    for w, sw, r in skipped:
        t.writerow([w, sw, r, 'keine gute Kurzfrage / Fremdwort / Eigenname / heikles Wort'])
def q(s): return "'" + s.replace("'", "''") + "'"
with open('export/fragen_varianten_seed.sql', 'w', encoding='utf-8') as f:
    f.write('-- Phase 4: Fragen-Entwürfe (Claude, Einzelprüfung), Stand 2026-09-24\n')
    f.write('-- Verknüpfung über woerter.wort (Großbuchstaben, AE/OE/UE/SS). Wörter, die noch nicht in woerter stehen, werden übersprungen.\n-- Idempotent über den Unique-Index (wort_id, frage) aus Migration 20260925000000.\n')
    f.write('begin;\n')
    for i in range(0, len(rows), 500):
        chunk = rows[i:i + 500]
        f.write('insert into fragen_varianten (wort_id, frage, schwierigkeit, quelle)\nselect w.id, v.frage, v.schw, v.quelle from (values\n')
        f.write(',\n'.join(f"  ({q(r[0])}, {q(r[2])}, {r[6]}, 'claude-entwurf')" for r in chunk))
        f.write('\n) as v(wort, frage, schw, quelle)\njoin woerter w on w.wort = v.wort\non conflict (wort_id, frage) do nothing;\n')
    f.write('commit;\n')
print(len(rows), 'Fragen,', len(skipped), 'ohne Frage')
from collections import Counter
print('Längen:', sorted(Counter(r[3] for r in rows).items()))
print('Schwierigkeit:', sorted(Counter(r[6] for r in rows).items()))
L = [len(r[2]) for r in rows]; W = [len(r[2].split()) for r in rows]
print('Zeichen Median/max:', sorted(L)[len(L)//2], max(L), ' Wörter:', sorted(Counter(W).items()))
print('Anteil Lückentext:', sum('...' in r[2] for r in rows))
