# Wortlisten-Pipeline (Phase 1: Qualität)

Baut aus Leipzig-Korpora (`*-words.txt` + `*-sentences.txt`) eine gefilterte Wortliste für die Rätselerzeugung und
protokolliert für jedes ausgeschlossene Wort den Grund.

```bash
python3 tools/wordlist/build_wordlist.py \
    --corpus ~/Downloads/deu_mixed-typical_2011_1M.tar \
    --corpus ~/Downloads/deu_wikipedia_2021_300K.tar \
    --keep-places \
    --out data/wortliste/woerter
# -> data/wortliste/woerter_gefiltert.tsv       (wort, laenge, haeufigkeit, schreibweise)
# -> data/wortliste/woerter_ausgeschlossen.tsv  (… + grund, evidenz)
```

Nur Python 3 (Standardbibliothek). Erster Lauf ca. 30 s (Cloud) bis einige Minuten (Laptop), danach durch Cache schnell.
`--explain Tina,Berlin,Haus` zeigt Entscheidung und Evidenz einzelner Wörter. Weitere Korpora: zusätzliche `--corpus`-Angaben.
Ergebnis ist deterministisch (frischer Cache → identische Ausgabe).

## Regeln (Reihenfolge = Priorität, erster Treffer bestimmt den Grund)

| Grund | Erkennung | Beispiele |
|---|---|---|
| `abk_grossschreibung` | ≥ 60 % der Vorkommen in Versalien | BASF, ADAC, DJK |
| `abk_mischschreibung` | Binnenversalien oder Versalien + Plural-s | kWh, VfB, AGBs |
| `abk_ohne_vokal` | kein Vokal | STD, FDP |
| `abk_punkt` | steht überwiegend vor Abkürzungspunkt | Mio., bzw., Tel. |
| `abk_roemisch` | römische Zahl | VIII |
| `fremd_kontext` | ≥ 25 % direkt neben englischen Funktionswörtern | Welcome, Enjoy |
| `fremd_funktionswort` | Funktionswort einer anderen Sprache (`lexika/fremd_stopwoerter.txt`) | and, for, van |
| `fremd_englisch` | englische Basisform, < 50 % Kleinschreibung, < 10 % Artikel-/Zahlkontext, Häufigkeit < 300 | Just, Good, Time |
| `eigenname` / `ortsname` | überwiegend großgeschrieben **und** selten nach Artikel/Zahlwort (Quote q; q < 0,08 → Name; 0,08–0,25 → Name nur mit Zusatzindiz; ≥ 0,25 → Nomen). Ortspräposition ≥ 25 % → `ortsname` | Tina, Straw, Merkel / Leipzig, Weimar |
| `manuell_ausgeschlossen` | `manual_drop.txt` | Max, Dax, Xbox |
| `zu_selten` | nur für sonst behaltene Wörter: Häufigkeit < 10 (≤ 4 Buchstaben: < 20); bei starkem Beleg (Nomen mit q ≥ 0,25 oder ≥ 90 % Kleinschreibung) < 5 (≤ 4 Buchstaben: < 10) | Whistler, Longlist |

Kontext-Signale stammen aus den Sätzen (`extract_features.py`): Artikel-/Possessiv-/Zahlwort direkt davor, Punkt danach,
großgeschriebene Nachbarn, Titel davor, Ortspräposition davor. Nicht-letzte Teile von Bindestrich-Komposita
(„der Eon-Konzern“) zählen nicht als Nomen-Beleg. `--keep-places` lässt Ortsnamen zu (sie unterliegen weiter der Häufigkeitsgrenze; vor der Korrektur vom 24.09. umging die Option die Grenze fälschlich); `manual_keep.txt` hebt Regeln einzeln auf.

## Ergebnis (Mixed 1M + Wikipedia 300K, Standardeinstellung)

Baseline 56.267 Wörter (Länge 3–11, Häufigkeit ≥ 5) → **41.385** behalten (mit `--keep-places`; ohne die Option 40.586).

| Länge | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 |
|---|---|---|---|---|---|---|---|---|---|
| Stand vorher (nur Mixed, ungefiltert) | 780 | 1.600 | 2.806 | 4.204 | 4.778 | 5.368 | 5.873 | 6.009 | 5.509 |
| gefiltert, beide Korpora, mit Ortsnamen | 189 | 836 | 2.496 | 4.095 | 5.096 | 6.213 | 7.283 | 7.764 | 7.413 |

Ab 7 Buchstaben ist der Pool trotz Filter größer als vorher (zweites Korpus). Bei 3–4 Buchstaben ist er kleiner, weil
dort der größte Teil des alten Bestands Abkürzungen, Namen und Fremdwörter waren. **Kurze Wörter bleiben der Engpass.**

## Validierung und ihre Grenzen

Alle Bewertungen stammen von **einem** Rater (Claude, gleichzeitig Autor der Regeln) – keine unabhängige Zweitbewertung.

* **Testset** (`eval/gold.py`, 209 bekannte Namen/Marken/Fremdwörter/Abkürzungen, 247 Alltagswörter; vom Autor aus dem Kopf
  zusammengestellt, eher „leichte“ Fälle): 95,7 % des Junks ausgeschlossen (200/209, ohne manuelle Listen), 98,4 % der
  Alltagswörter behalten (243/247). Durchgerutscht: Marken mit Artikel (Adidas, Audi, Ebay, Lufthansa, Telekom), Hello,
  Corporate, World, Rehhagel. Fälschlich entfernt: Delfin, Erdgas, Wolf, Wespe.
* **Zufallsstichprobe der Endliste** (n = 300): ca. 3,3 % Junk (10/300; 95-%-Konfidenzintervall ca. 1,9–5,9 %).
  Typisch: Character, Marines, Touring, Expressway, Wizards, Hesketh, Aristoteles.
* **Kurze Wörter**: Vor der manuellen Vollprüfung (Zwischenstand) lag der Junk-Anteil bei 3 Buchstaben bei ca. 17 %
  (34/200) und bei 4 Buchstaben bei ca. 6 % (6/100). Längen 3 und 4 wurden danach vollständig durchgesehen; die
  Restfehler stehen in `manual_drop.txt`. Der Restanteil ist nicht unabhängig gemessen.
* **Häufigkeitsgrenze**: Bei 5–9 Vorkommen ca. 24 % Junk (Länge 5–8, n = 50), bei 10–19 ca. 5 %, bei 20–49 ca. 4 %, ab 50
  keiner in der Stichprobe. Deshalb evidenzabhängige Untergrenze (s. Tabelle); neu zugelassene Wörter mit starkem Beleg
  (Länge 5–8) haben ca. 8 % Junk (n = 100), Länge ≤ 4 ca. 34 % (n = 176, vollständig geprüft, Rest in `manual_drop.txt`).
* **Solver-Regressionstest** (`eval/solver_test.py`): geschlossene Zufallsraster mit reserviertem Rand, je 20 identische
  Raster pro Größe, 4 s Limit, einfacher Backtracking-Solver (Forward-Checking, „most constrained“, zufällige Wortwahl).
  Erfolgsquote 8×8 / 9×9 / 10×10 / 11×11: Baseline 15 / 6 / 7 / 3 von 20; gefiltert ohne Häufigkeitsgrenze 12 / 3 / 3 / –;
  Endliste 8 / 3 / 2 / 1. Es gab **keinen** bewiesen unlösbaren Fall, alle Fehlschläge sind Zeitlimits. Die Filterung kostet
  also Suchaufwand (vor allem wegen der kleineren Kurzwort-Pools), keine Lösbarkeit; Ergebnis ist eine untere Schranke
  für einen besseren Solver (Phase 2).

## Bekannte Schwächen

* Marken/Firmen mit Artikel („die Telekom“) und Massennomen ohne Artikel (Erdgas, Metall, „IG Metall“) sind kontextuell
  nicht sicher unterscheidbar; seltene konkrete Nomen ohne Artikel-Beleg fallen heraus.
* Flexionsformen werden nicht auf Grundformen zurückgeführt (befand, scherzte, Kommentars). Für Phase 4 (Fragen) ist
  ein Lemma-Filter sinnvoll; hier nicht Teil des Auftrags.
* Eingedeutschte Lehnwörter (Job, Team, Deal, Show) bleiben bewusst erhalten; englische Titelwörter mit hohem Artikelkontext
  (World) ebenfalls.
* Ortsnamen sind ohne `--keep-places` ausgeschlossen (1.589 Wörter, Grund `ortsname`); mit der Option kommen 799 zurück, 790 bleiben
  wegen der Häufigkeitsgrenze draußen (Grund `zu_selten`, Evidenz `ortsname`). Flüsse/Länder mit Artikelkontext (Elbe, Iran)
  sind teilweise ohnehin drin.

## Lizenzen

* Leipzig Corpora Collection (Uni Leipzig): Namensnennung erforderlich; die Lizenz des Wikipedia-Korpus vor einer
  Veröffentlichung von Wortlisten auf der Leipzig-Seite prüfen (Wikipedia-Texte sind CC BY-SA).
* `lexika/en_US.words.txt`: aus SCOWL/Hunspell en_US, permissive Lizenz, Hinweis in `lexika/README.md`.
