#!/usr/bin/env python3
"""Erzeugt supabase/seed/woerter_seed.sql aus data/wortliste/woerter_gefiltert.tsv (Liste B).
Aufruf im Repo-Wurzelverzeichnis: python3 tools/generator/woerter_seed.py"""
import csv
QUELLE = 'leipzig-b'  # Leipzig Corpora (mixed 2011 1M + wikipedia 2021 300K), gefilterte Liste B
rows = list(csv.DictReader(open('data/wortliste/woerter_gefiltert.tsv', encoding='utf-8'), delimiter='\t'))
with open('supabase/seed/woerter_seed.sql', 'w', encoding='utf-8') as f:
    f.write(f'-- {len(rows)} Wörter aus data/wortliste/woerter_gefiltert.tsv. Idempotent (on conflict do nothing).\nbegin;\n')
    for i in range(0, len(rows), 2000):
        chunk = rows[i:i + 2000]
        f.write('insert into woerter (wort, haeufigkeit, quelle) values\n')
        f.write(',\n'.join(f"('{r['wort']}', {int(r['haeufigkeit'])}, '{QUELLE}')" for r in chunk))
        f.write('\non conflict (wort) do nothing;\n')
    f.write('commit;\n')
print(len(rows), 'Wörter')
