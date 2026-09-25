# Phase 4 – Fragen (Entwurf, Stand 2026-09-24)

## Inhalt

| Datei | Inhalt |
|---|---|
| `fragen.tsv` | 9.674 Fragen: `wort` (AE/OE/UE/SS), `schreibweise`, `frage`, `laenge`, `haeufigkeit`, `rang`, `schwierigkeit`, `quelle` (`claude-entwurf`), `geprueft` (`false`) |
| `ohne_frage.tsv` | 326 Wörter, zu denen bewusst keine Frage geschrieben wurde |
| `fragen_varianten_seed.sql` | Insert in `fragen_varianten`, verknüpft über `woerter.wort` |
| `pruefbericht_formal.txt` | Ausgabe der automatischen Prüfung |
| `stichprobe_logik.tsv` | 300 zufällig gezogene Fragen mit Urteil |
| `tools/` | `check.py` (Prüfung), `export.py` (Export), `overrides.txt` (begründete Ausnahmen) |

## Umfang

Die 10.000 häufigsten Wörter der Liste B mit 3 bis 8 Buchstaben (Mindesthäufigkeit dadurch 22). Die Rastervorlagen haben nur Einträge bis 8 Buchstaben.

Fragen je Länge: 3 → 163, 4 → 690, 5 → 1.412, 6 → 2.221, 7 → 2.457, 8 → 2.731.

## Stilregeln

1. **Kurz:** höchstens 3 Wörter und 22 Zeichen (harte Grenze). Einzelwörter möglichst höchstens 12 Buchstaben, damit die Frage im Feld lesbar bleibt (siehe `player-feedback-runde1.md`). Ergebnis: 89 % der Fragen bestehen aus einem Wort, der Median liegt bei 8 Zeichen.
2. **Die Lösung darf nicht in der Frage stecken:** weder das Wort selbst noch sein Stamm (HAUS ≠ „Haustier“, Tag ≠ „täglich“).
3. **Die Form muss passen:** Plural zu Plural, gleiche Person und Zeit beim Verb, gleiche Endung beim Adjektiv („großen“ → „riesigen“).
4. **Die Frage muss sachlich stimmen.** Synonyme, Oberbegriffe („Laubbaum“) und Lückentexte mit „...“ sind erlaubt („Wohl des ...“ → KINDES). Beispiele als Frage nur mit Kennzeichnung („etwa Müller“).
5. **Fremdwörter, Eigennamen und Firmennamen** (World, Adidas, Nintendo …) sowie heikle Wörter (z. B. Nazis, Suizid, Gestapo, Schimpfwörter, Begriffe zu sexueller Orientierung) bekommen keine Frage.

Für Artikel, Pronomen, Zahlen und Fragewörter gelten die im Schwedenrätsel üblichen Sammelfragen („Artikel“, „Pronomen“, „Zahl“, „Fragewort“). Sie sind absichtlich unspezifisch; eindeutig wird die Lösung erst über die Kreuzungen.

## Prüfung

**Automatisch (`check.py`, alle 10.000 Einträge):**

- vollständig, keine doppelten Einträge
- Länge der Frage (E3)
- Stamm der Lösung in der Frage (E4, mit Toleranz für gängige Endungen; 29 begründete Ausnahmen in `overrides.txt`)
- lange Einzelwörter (W1)
- Sammelfragen, die zu oft vorkommen (W2)

Endstand: **0 Fehler**, 23 Warnungen für Wörter mit 13–15 Buchstaben (z. B. „Kopfbedeckung“). Beim ersten Durchlauf fielen pro 500er-Paket 13–33 Fragen durch, vor allem wegen Stammgleichheit. Alle wurden umformuliert.

**Heuristik Wortart:** Kleingeschriebene Lösungen mit großgeschriebener Ein-Wort-Frage und umgekehrt wurden durchgesehen (72 bzw. 186 Treffer). Übrig blieben nur zulässige Fälle, etwa Sammelfragen oder Satzanfänge wie „Deshalb|darum“.

**Logik (manuell):** Alle 20 Pakete wurden nach dem Schreiben einzeln durchgesehen und korrigiert; etwa 40–60 Änderungen pro Paket (z. B. „Baum|Eiche“ → „Gehölz“, „Zucker|Süßstoff“ → „Saccharose“, „Moos|Flechte“ → „Geld (ugs.)“). Danach eine **Zufallsstichprobe von 300 Fragen**:

- sachlich falsch: 0 von 300 (95-%-KI 0–1,2 %)
- unscharf: 8 von 300 = 2,7 % (95-%-KI ca. 1,2–5,2 %), z. B. „Kakao|Schokolade“, „Türken|Osmanen“, „Schotten|Highlander“; alle 8 korrigiert

**Grenze:** Geschrieben und geprüft hat beides dieselbe Person (Claude). Eine unabhängige zweite Prüfung fehlt. Sie ist vor der Veröffentlichung nötig (`geprueft = false`).

## Bekannte Schwächen

- Einige Fragen sind absichtlich weit (Oberbegriffe wie „Organ“, „Andenstaat“, „Ruhrstadt“). Das ist Schwedenrätsel-üblich, macht aber einzelne Rätsel schwerer.
- Flexionsformen (z. B. „Jahren“, „Kindes“) werden über Lückentexte oder passend gebeugte Synonyme gelöst. Ein Lemma-Filter wurde nicht angewendet.
- `schwierigkeit` richtet sich allein nach dem Häufigkeitsrang (1: Rang ≤ 3.000, 2: ≤ 7.000, 3: Rest), nicht nach der Frage.
- Regional gefärbte Begriffe (z. B. „Reisecars“, „Bussen“) sind nicht markiert.

## Import

```
psql … -f fragen_varianten_seed.sql   # setzt voraus, dass woerter gefüllt ist (Spalte wort)
```

Die Spalte `woerter.wort` ist eine Annahme aus dem Konzeptentwurf. Vor dem Import bitte in der Migration prüfen.
