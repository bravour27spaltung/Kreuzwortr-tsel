-- Kreuzworträtsel-App: Basis-Datenmodell
-- Siehe Projektdokument "Geschlossenes Raster und Generierungsstrategie" für Hintergrund.

-- Wörter-Pool: Grundlage für die automatische Rätselbefüllung
create table if not exists woerter (
  id bigint generated always as identity primary key,
  wort text not null,
  laenge int not null generated always as (char_length(wort)) stored,
  haeufigkeit numeric,              -- z.B. relative Häufigkeit aus einem Korpus (zur Qualitätsgewichtung)
  quelle text,                      -- z.B. 'leipzig-corpora', 'openthesaurus', 'manuell'
  erstellt_am timestamptz not null default now(),
  constraint woerter_wort_key unique (wort)
);
create index if not exists idx_woerter_laenge on woerter (laenge);

-- Fragen/Hinweise zu einem Wort (mehrere Varianten pro Wort möglich)
create table if not exists fragen_varianten (
  id bigint generated always as identity primary key,
  wort_id bigint not null references woerter (id) on delete cascade,
  frage text not null,
  schwierigkeit smallint default 1,  -- 1=leicht ... 5=schwer
  quelle text,
  erstellt_am timestamptz not null default now()
);
create index if not exists idx_fragen_varianten_wort_id on fragen_varianten (wort_id);

-- Rastervorlagen (validierte, geschlossene Grid-Skelette; unabhängig von konkreten Wörtern)
create table if not exists gitter (
  id bigint generated always as identity primary key,
  name text,
  zeilen int not null,
  spalten int not null,
  -- Interior-Zellen (dunkle Frage-Zellen), als JSON-Array von [row, col]-Paaren
  dunkle_zellen jsonb not null,
  dichte numeric,                    -- Anteil dunkler Zellen (Debug/Qualitätsmetrik)
  validiert boolean not null default false,
  erstellt_am timestamptz not null default now()
);

-- Ein konkretes, veröffentlichtes Rätsel (Gitter + Wortbelegung)
create table if not exists raetsel (
  id bigint generated always as identity primary key,
  titel text,
  gitter_id bigint not null references gitter (id),
  status text not null default 'entwurf',  -- 'entwurf' | 'veroeffentlicht' | 'archiviert'
  erstellt_am timestamptz not null default now(),
  veroeffentlicht_am timestamptz
);

-- Die konkreten Einträge (Wort + Position + Richtung + gewählte Frage) eines Rätsels
create table if not exists fragen (
  id bigint generated always as identity primary key,
  raetsel_id bigint not null references raetsel (id) on delete cascade,
  wort_id bigint not null references woerter (id),
  frage_varianten_id bigint references fragen_varianten (id),
  richtung text not null check (richtung in ('A', 'D')),  -- A = across/waagerecht, D = down/senkrecht
  start_zeile int not null,
  start_spalte int not null,
  laenge int not null
);
create index if not exists idx_fragen_raetsel_id on fragen (raetsel_id);

-- Fortschritt eines Nutzers an einem Rätsel
create table if not exists nutzer_fortschritt (
  id bigint generated always as identity primary key,
  nutzer_id uuid not null references auth.users (id) on delete cascade,
  raetsel_id bigint not null references raetsel (id) on delete cascade,
  eingaben jsonb not null default '{}'::jsonb,  -- { "r,c": "A", ... }
  fertig boolean not null default false,
  aktualisiert_am timestamptz not null default now(),
  constraint nutzer_fortschritt_unique unique (nutzer_id, raetsel_id)
);

alter table nutzer_fortschritt enable row level security;

create policy "Nutzer sehen nur ihren eigenen Fortschritt"
  on nutzer_fortschritt for select
  using (auth.uid() = nutzer_id);

create policy "Nutzer legen nur eigenen Fortschritt an"
  on nutzer_fortschritt for insert
  with check (auth.uid() = nutzer_id);

create policy "Nutzer aktualisieren nur eigenen Fortschritt"
  on nutzer_fortschritt for update
  using (auth.uid() = nutzer_id)
  with check (auth.uid() = nutzer_id);

create policy "Nutzer loeschen nur eigenen Fortschritt"
  on nutzer_fortschritt for delete
  using (auth.uid() = nutzer_id);
