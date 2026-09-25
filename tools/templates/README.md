# Rastervorlagen (Phase 3)

Werkzeuge zum Erzeugen, Auswählen, Prüfen und Exportieren geschlossener Rastervorlagen für die Tabelle `gitter`.
Ergebnisse und Methodik: `phase3-rastervorlagen.md` im Projekt. Fertige Vorlagen: `data/gitter/vorlagen.json`,
SQL: `supabase/seed/gitter_vorlagen.sql`.

Konvention: Zeile 0 und Spalte 0 sind komplett dunkel (Rand-Reservierung). `dunkle_zellen` enthält **alle** dunklen Zellen
einschließlich des Rands als `[zeile, spalte]`; jede nicht gelistete Zelle ist weiß. Frage-Zelle eines Eintrags = die dunkle Zelle
direkt davor (bei waagerecht links, bei senkrecht darüber); eine dunkle Zelle kann zwei Fragen tragen (eine waagerechte, eine senkrechte).

Ablauf (Skripte erwarten das Arbeitsverzeichnis mit `cand/`, `res/`, `sel/`, `lists/`; Solver siehe `tools/solver/`):

1. `gen_templates.py <h> <w> <versuche> <seed> cand/c<h>x<w>` – erzeugt Kandidaten (Reparatur-Generator aus `tpl.py`), filtert nach
   Struktur/Qualität (zusammenhängend, keine dunklen 2×2-Blöcke im Innern, Einträge 3 bis min(8, Größe−2) Buchstaben, höchstens 25 % ungenutzte
   dunkle Zellen, ≥ 75 % der weißen Zellen gekreuzt, 3-Buchstaben-Anteil ≤ 35 %, Dichte 26–42 %) und entfernt Duplikate (auch transponierte).
2. Lösbarkeitstest mit dem Solver (`tools/solver/fill_solver.cpp`) gegen die Gesamtliste und Teilpools (häufigste 10.000/20.000 Wörter),
   mehrere Seeds; `select_templates.py` wählt je Größe die robustesten und unterschiedlichsten Vorlagen.
3. `export_templates.py <selected.json> <outdir>` – schreibt `vorlagen.json` und `seed_gitter.sql`.
4. `validate_templates.py <vorlagen.json>` – unabhängige Strukturprüfung (rechnet aus `dunkle_zellen` alles neu); nur bestandene Vorlagen
   bekommen `validiert = true` (Export danach erneut ausführen).
5. `verify_fill.py <vorlagen.json> <wortliste.tsv> <loesung.sol> …` – prüft vom Solver geschriebene Lösungen (Wort in der Liste, keine Doppelten,
   Kreuzungen konsistent).
