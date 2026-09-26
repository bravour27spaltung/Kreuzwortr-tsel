-- Phase 6: Login und Fortschritt
-- Die Tabelle nutzer_fortschritt und ihre RLS-Policies existieren bereits seit der ersten
-- Migration. Hier kommen die Rechte für die "authenticated"-Rolle (RLS filtert weiterhin auf
-- Zeilenebene) sowie eine Übersichtsfunktion für die Startseite dazu.

-- 1. Tabellenrechte für eingeloggte Nutzer -----------------------------------------------
-- Ohne diese Grants dürfen selbst durch RLS erlaubte Zeilen nicht gelesen/geschrieben werden.
grant select, insert, update, delete on nutzer_fortschritt to authenticated;
-- Für die "generated always as identity"-Spalte "id": Postgres ruft beim Insert intern
-- nextval() auf, das braucht USAGE auf der Sequenz.
grant usage, select on sequence nutzer_fortschritt_id_seq to authenticated;

-- 2. Übersicht "meine Rätsel" für die Startseite -----------------------------------------
-- security definer, aber intern auf auth.uid() gefiltert: liefert ausschließlich die eigenen
-- Zeilen des aufrufenden Nutzers, kein Leck anderer Nutzerdaten.
create or replace function fortschritt_liste()
returns table (
  raetsel_id bigint,
  titel text,
  slug text,
  zeilen int,
  spalten int,
  schwierigkeit smallint,
  fertig boolean,
  aktualisiert_am timestamptz,
  anzahl_eintraege bigint,
  anzahl_ausgefuellt int
)
language sql stable security definer set search_path = public as $$
  select
    r.id, r.titel, r.slug, g.zeilen, g.spalten, r.schwierigkeit,
    nf.fertig, nf.aktualisiert_am,
    (select count(*) from fragen f where f.raetsel_id = r.id) as anzahl_eintraege,
    (select count(*) from jsonb_object_keys(nf.eingaben)) as anzahl_ausgefuellt
  from nutzer_fortschritt nf
  join raetsel r on r.id = nf.raetsel_id
  join gitter g on g.id = r.gitter_id
  where nf.nutzer_id = auth.uid()
  order by nf.aktualisiert_am desc;
$$;

revoke all on function fortschritt_liste() from public;
grant execute on function fortschritt_liste() to authenticated;
