#!/usr/bin/env python3
"""Exportiert gewaehlte Vorlagen: vorlagen.json (mit Eintraegen/Fragezellen) und seed_gitter.sql (passend zur Tabelle gitter).
Aufruf: export_templates.py <selected.json> <outdir>   (validiert=true nur fuer Vorlagen, die validate_templates.py bestanden haben)"""
import json, sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import tpl

def build(sel, validated):
    out = []
    for m in sel:
        h, w = m['h'], m['w']; dark = [[False] * w for _ in range(h)]
        for r, c in m['dark']: dark[r][c] = True
        E = []
        for d, run in tpl.entries(dark, h, w):
            r, c = run[0]; cr, cc = (r, c - 1) if d == 'A' else (r - 1, c)
            E.append(dict(dir=d, r=r, c=c, len=len(run), clueR=cr, clueC=cc))
        out.append(dict(name=m['name'], zeilen=h, spalten=w, dunkle_zellen=m['dark'], dichte=round(m['density'], 4),
                        validiert=m['name'] in validated, eintraege=E,
                        kennzahlen={k: m[k] for k in ('entries', 'lens', 'share3', 'meanlen', 'maxlen', 'waste', 'crossed', 'density') if k in m},
                        loesbarkeit={k: m[k] for k in m if k.startswith('test_')}))
    return out

def sql(V):
    L = ["-- Rastervorlagen (geschlossene Raster, Rand Zeile 0/Spalte 0 komplett dunkel). dunkle_zellen enthaelt ALLE dunklen Zellen",
         "-- einschliesslich des reservierten Rands; jede nicht gelistete Zelle ist eine weisse Buchstabenzelle.",
         "insert into gitter (name, zeilen, spalten, dunkle_zellen, dichte, validiert) values"]
    rows = []
    for v in V:
        rows.append("  ('%s', %d, %d, '%s'::jsonb, %s, %s)" % (v['name'], v['zeilen'], v['spalten'], json.dumps(v['dunkle_zellen'], separators=(',', ':')),
                                                                v['dichte'], 'true' if v['validiert'] else 'false'))
    return '\n'.join(L) + '\n' + ',\n'.join(rows) + '\non conflict (name) do nothing;\n'

if __name__ == '__main__':
    sel = json.load(open(sys.argv[1])); outdir = sys.argv[2]; os.makedirs(outdir, exist_ok=True)
    validated = set(json.load(open(os.path.join(outdir, 'validated_names.json')))) if os.path.exists(os.path.join(outdir, 'validated_names.json')) else set()
    V = build(sel, validated)
    json.dump(V, open(os.path.join(outdir, 'vorlagen.json'), 'w'), ensure_ascii=False, indent=1)
    open(os.path.join(outdir, 'seed_gitter.sql'), 'w').write(sql(V))
    print(len(V), 'Vorlagen exportiert,', sum(v['validiert'] for v in V), 'validiert')
