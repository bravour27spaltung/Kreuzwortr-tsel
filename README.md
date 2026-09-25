# Kreuzworträtsel-App

Web-App für Kreuzworträtsel im **Schwedenrätsel-Format**: Fragen stecken direkt als
schattierte Feld(er) im Gitter (mit Pfeil für die Richtung), es gibt keine separate
Fragenliste.

Die Rätsel werden automatisch erzeugt (Rastervorlagen + Fragen-Datenbank, siehe
„Rätsel erzeugen“). Die App lädt sie aus Supabase; ist Supabase nicht eingerichtet oder
leer, nimmt sie die mitgelieferten Rätsel aus `public/raetsel/`. Die App läuft also auch
ohne Datenbank.

## Stack

- React 18 + TypeScript (strict) + Vite 5
- Tailwind CSS
- Supabase (Postgres + Auth) — Schema liegt als Migration unter `supabase/migrations/`

## Lokal einrichten

### 1. Abhängigkeiten installieren

```bash
npm install
```

> **Hinweis:** Dieser Schritt braucht Zugriff auf die npm-Registry. Führe ihn in deinem
> eigenen Terminal aus (nicht über Claude) — die Sandbox, in der Claude bei der Erstellung
> dieses Projekts gearbeitet hat, hat keinen Internetzugriff.

### 2. Supabase-Projekt anlegen

1. Auf [supabase.com](https://supabase.com) ein neues Projekt erstellen (kostenloser
   Free-Tier reicht für den Start).
2. Unter **Project Settings → API** die **Project URL** und den **anon public key**
   kopieren.
3. `.env.example` nach `.env` kopieren und die beiden Werte eintragen:

   ```bash
   cp .env.example .env
   ```

   ```
   VITE_SUPABASE_URL=https://dein-projekt.supabase.co
   VITE_SUPABASE_ANON_KEY=dein-anon-key
   ```

### 3. Datenbank einrichten

Im **Supabase-Dashboard → SQL Editor** nacheinander ausführen (oder mit `psql "<Connection-String>" -f <Datei>`):

| # | Datei | Inhalt |
|---|---|---|
| 1 | `supabase/migrations/20260919000000_create_kreuzwortraetsel_tables.sql` | Tabellen |
| 2 | `supabase/migrations/20260925000000_raetsel_laden.sql` | Row-Level-Security, Lesefunktionen `raetsel_liste()` / `raetsel_laden(id)`, Eindeutigkeiten |
| 3 | `supabase/seed/gitter_vorlagen.sql` | 26 Rastervorlagen |
| 4 | `supabase/seed/woerter_seed.sql` | 41.385 Wörter (1,3 MB – im SQL-Editor ggf. mit psql einspielen) |
| 5 | `supabase/seed/fragen_varianten_seed.sql` | 9.674 Fragen |
| 6 | `supabase/seed/raetsel_seed.sql` | erzeugte Rätsel |

Alle Seeds sind wiederholbar (bereits vorhandene Zeilen werden übersprungen).
Die App liest ausschließlich über die beiden Funktionen und sieht nur Rätsel mit
`status = 'veroeffentlicht'`; alle Tabellen sind für `anon` gesperrt.

### 4. Entwicklungsserver starten

```bash
npm run dev
```

Die App läuft danach unter `http://localhost:5173`.

## Rätsel erzeugen

```bash
g++ -O2 -std=c++17 -o /tmp/fill_solver tools/solver/fill_solver.cpp
python3 tools/generator/generate_raetsel.py --solver /tmp/fill_solver --pro-vorlage 3 --nur-veroeffentlichbare
```

Schreibt `public/raetsel/*.json` (für die App ohne Datenbank) und
`supabase/seed/raetsel_seed.sql`. Jede Lösung wird vor dem Speichern unabhängig geprüft.
Rätsel mit mehr als 3 Funktionswörtern oder doppelten Fragetexten werden verworfen
(ohne `--nur-veroeffentlichbare`: als Entwurf gespeichert). Optionen: `--help`.
`woerter_seed.sql` neu erzeugen: `python3 tools/generator/woerter_seed.py`.

## Weitere Skripte

```bash
npm run build       # Produktionsbuild
npm run preview     # Produktionsbuild lokal ansehen
npm run lint         # ESLint
npm run typecheck   # TypeScript-Prüfung ohne Build
```

## Projektstruktur

```
src/
  components/
    CrosswordPlayer.tsx   # Die eigentliche Rätsel-Spiellogik (Gitter, Eingabe, Prüfen/Lösen)
  lib/
    supabase.ts           # Supabase-Client (null, wenn .env fehlt)
    puzzleSource.ts       # Rätselliste/Rätsel laden: Supabase-RPC oder public/raetsel/, Strukturprüfung
    seedPuzzle.ts         # Beispielrätsel (Notfall, wenn nichts geladen werden kann)
  types.ts                # Gemeinsame Typen (Puzzle, PuzzleEntry, Direction)
  App.tsx
  main.tsx
public/raetsel/            # erzeugte Rätsel als JSON (index.json + je Rätsel eine Datei)
supabase/
  migrations/              # SQL-Migrationen
  seed/                    # Vorlagen, Wörter, Fragen, Rätsel
tools/
  generator/               # Rätsel-Generator, Wörter-Seed
  solver/, templates/, wordlist/, fragen/   # Werkzeuge der Phasen 1–4
data/                      # Wortliste, Vorlagen, Fragen
```

## Offene nächste Schritte

- Wortwiederholung verringern: Kurzwörter wie IST/TEE/EHE/SIE kommen in bis zu 26 der
  78 Rätsel vor (nur 163 dreibuchstabige Wörter mit Frage bei entsprechend vielen
  3-Buchstaben-Feldern in den Vorlagen). Ließe sich durch mehr kurze Wörter mit Frage
  und/oder eine noch stärkere `--abwechslung`-Gewichtung im Generator verbessern.
- Nutzer-Login (Supabase Auth) und Fortschritt speichern über `nutzer_fortschritt`
  (Tabelle und RLS-Policies existieren, die App nutzt sie noch nicht).
