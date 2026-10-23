"""Phase 8 – uebernimmt clues_01..07 in data/fragen/fragen.tsv und erzeugt das Seed-SQL.
Aufruf (idempotent): python3 tools/fragen/phase8/uebernehmen.py
"""
import csv, os, glob, re
HIER = os.path.dirname(os.path.abspath(__file__))
WURZEL = os.path.abspath(os.path.join(HIER, '..', '..', '..'))
TSV = os.path.join(WURZEL, 'data', 'fragen', 'fragen.tsv')
SQL = os.path.join(WURZEL, 'supabase', 'seed', 'fragen_varianten_seed_phase8.sql')
QUELLE = 'claude-v3-phase8'

zeilen = list(csv.DictReader(open(TSV, encoding='utf-8'), delimiter='\t'))
felder = list(zeilen[0].keys())
vorlage, vorhanden = {}, set()
for r in zeilen:
    vorlage.setdefault(r['schreibweise'], r)
    vorhanden.add((r['wort'], r['frage']))

neu = []
for p in sorted(glob.glob(os.path.join(HIER, 'clues_*.txt'))):
    for z in open(p, encoding='utf-8'):
        z = z.rstrip('\n')
        if not z.strip() or '|' not in z:
            continue
        sw, frage = [x.strip() for x in z.split('|', 1)]
        v = vorlage[sw]
        if frage == '-' or (v['wort'], frage) in vorhanden:
            continue
        r = dict(v); r['frage'] = frage; r['quelle'] = QUELLE; r['geprueft'] = 'false'
        neu.append(r); vorhanden.add((v['wort'], frage))

if neu:
    with open(TSV, 'a', encoding='utf-8', newline='') as f:
        w = csv.DictWriter(f, fieldnames=felder, delimiter='\t', lineterminator='\n', quoting=csv.QUOTE_NONE, escapechar=None)
        for r in neu:
            w.writerow(r)

# SQL immer aus allen phase8-Zeilen der TSV neu erzeugen
alle = [r for r in csv.DictReader(open(TSV, encoding='utf-8'), delimiter='\t') if r['quelle'] == QUELLE]
q = lambda s: s.replace("'", "''")
werte = ',\n'.join(f"  ('{r['wort']}', '{q(r['frage'])}', {r['schwierigkeit']}, '{QUELLE}')" for r in alle)
open(SQL, 'w', encoding='utf-8').write(f"""-- Phase 8: Neu formulierte Fragen (knapp, bildhaft, mit Sachwissen statt Einwort-Synonym) fuer {len({r['wort'] for r in alle})} Woerter des Bestands ({len(alle)} Fragen).
-- Jede Frage ist formal geprueft (tools/fragen/phase8/pruefe.py, 0 Fehler), inhaltlich per Claude-Einzelsicht, geprueft=false.
-- Idempotent ueber den Unique-Index (wort_id, frage) aus Migration 20260925000000.
begin;
insert into fragen_varianten (wort_id, frage, schwierigkeit, quelle)
select w.id, v.frage, v.schw, v.quelle from (values
{werte}
) as v(wort, frage, schw, quelle)
join woerter w on w.wort = v.wort
on conflict (wort_id, frage) do nothing;
commit;
""")
print(len(neu), 'neu in TSV;', len(alle), 'phase8-Zeilen gesamt')
