# Füll-Solver für geschlossene Raster (Phase 2)

Experimenteller, schneller Solver in C++17 (Bitset-Index je Länge/Position/Buchstabe, Forward-Checking, engste Variable zuerst)
mit Neustarts, Konfliktgewichtung und häufigkeitsgewichteter Wortreihenfolge. Ergebnisse und Messmethodik:
`phase2-solver-und-wortlistengrenzen.md` im Projekt.

```bash
g++ -O2 -std=c++17 -o solver tools/solver/fill_solver.cpp
# Skelette: h w n minlen maxlen p_dunkel seed out   (Rand reserviert, Einträge <= maxlen)
python3 tools/solver/gen_skeletons.py 12 12 30 3 8 0.0 5 skelette.txt
# Füllen: <Wortliste.tsv> <Skelette> <Sekunden pro Raster> [Optionen]
SOLFILE=loesungen.txt ./solver data/wortliste/woerter_gefiltert.tsv skelette.txt 10 val=freq alpha=8 restart=3000 var=wdeg
```

Optionen: `val=random|freq`, `alpha=<Exponent>`, `var=mrv|wdeg`, `restart=<Wortversuche>`, `seed=<n>`.
Ausgabe je Raster: `Index Status Knoten Sekunden mittlere_lnHäufigkeit min_Häufigkeit Neustarts` (Status ok/unsat/timeout).
`SOLFILE` schreibt die gefundenen Lösungswörter je Raster. `verify_solutions.py` prüft Lösungen unabhängig (Wort in der Liste,
keine Doppelten, Kreuzungen konsistent); die Pfade im Skript sind auf die Phase-2-Verzeichnisstruktur (`res/`, `sk/`, `out/`) zugeschnitten.

Bekannte Einschränkungen: `wdeg` ist eine vereinfachte Variante (Gewicht je Eintrag); Doppelte Wörter werden erst bei der Wortwahl
ausgeschlossen; "timeout" bedeutet nicht "unlösbar".
