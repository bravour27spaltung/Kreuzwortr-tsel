-- Phase 5: Rätsel aus der Datenbank laden
-- 1. Zusatzspalten und Eindeutigkeit für idempotente Seeds
-- 2. Row-Level-Security für alle Inhaltstabellen (vorher offen: mit dem anon-Key wären alle Tabellen les- UND schreibbar gewesen)
-- 3. Lesezugriff für die App ausschließlich über zwei Funktionen, die nur veröffentlichte Rätsel liefern

-- 1. Spalten / Eindeutigkeit ------------------------------------------------------------
alter table raetsel add column if not exists slug text;
alter table raetsel add column if not exists schwierigkeit smallint;  -- 1 leicht, 2 mittel, 3 schwer
create unique index if not exists raetsel_slug_key on raetsel (slug);

create unique index if not exists fragen_varianten_wort_frage_key on fragen_varianten (wort_id, frage);
-- Vorlagen über ihren Namen eindeutig (gitter_vorlagen.sql ist damit wiederholbar).
-- Schlägt fehl, falls gitter_vorlagen.sql früher schon doppelt eingespielt wurde: dann Duplikate vorher entfernen.
create unique index if not exists gitter_name_key on gitter (name);
create index if not exists idx_raetsel_status on raetsel (status);

-- 2. Row-Level-Security ---------------------------------------------------------------
-- Ohne Policy darf mit anon/authenticated nichts gelesen oder geschrieben werden.
-- Seeds und der Generator laufen als Datenbank-Owner (SQL-Editor / psql) und sind davon nicht betroffen.
alter table woerter          enable row level security;
alter table fragen_varianten enable row level security;
alter table gitter           enable row level security;
alter table raetsel          enable row level security;
alter table fragen           enable row level security;

-- 3. Lesefunktionen ---------------------------------------------------------------------
create or replace function raetsel_liste()
returns table (id bigint, slug text, titel text, zeilen int, spalten int, schwierigkeit smallint)
language sql stable security definer set search_path = public as $$
  select r.id, r.slug, r.titel, g.zeilen, g.spalten, r.schwierigkeit
  from raetsel r join gitter g on g.id = r.gitter_id
  where r.status = 'veroeffentlicht'
  order by r.id;
$$;

-- Ein Rätsel mit allen Einträgen. Gibt null zurück, wenn es nicht existiert oder nicht veröffentlicht ist.
-- Die Lösungswörter werden mitgeliefert, weil die App „Prüfen“ und „Tipps“ im Browser auswertet.
create or replace function raetsel_laden(p_id bigint)
returns jsonb
language sql stable security definer set search_path = public as $$
  select jsonb_build_object(
    'id', r.id,
    'slug', r.slug,
    'titel', r.titel,
    'zeilen', g.zeilen,
    'spalten', g.spalten,
    'schwierigkeit', r.schwierigkeit,
    'eintraege', coalesce((
      select jsonb_agg(jsonb_build_object(
               'dir', f.richtung, 'r', f.start_zeile, 'c', f.start_spalte, 'len', f.laenge,
               'wort', w.wort, 'frage', fv.frage)
             order by f.id)
      from fragen f
      join woerter w on w.id = f.wort_id
      left join fragen_varianten fv on fv.id = f.frage_varianten_id
      where f.raetsel_id = r.id), '[]'::jsonb)
  )
  from raetsel r join gitter g on g.id = r.gitter_id
  where r.id = p_id and r.status = 'veroeffentlicht';
$$;

revoke all on function raetsel_liste() from public;
revoke all on function raetsel_laden(bigint) from public;
grant execute on function raetsel_liste() to anon, authenticated;
grant execute on function raetsel_laden(bigint) to anon, authenticated;
