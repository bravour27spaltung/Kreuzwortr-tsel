-- Phase 7: Asynchrone Duelle (1:1, zeitversetzt, per Einladungscode)
--
-- Ablauf: A legt ein Duell an und schickt B den Code/Link. Beim Beitritt wird ein Rätsel gewählt,
-- das keiner von beiden bisher bearbeitet hat. Jeder startet für sich (Serverzeit), das Gitter wird
-- beim Abgeben serverseitig geprüft. Wertung: Netto-Zeit = Dauer + Strafsekunden (Tipps, Prüfen mit Fehlern).
-- Den Gegner sieht man erst nach der eigenen Abgabe (bzw. wenn das Duell beendet ist).
--
-- Zugriff wie bei fortschritt_liste(): alle Tabellen sind für anon/authenticated gesperrt (RLS an, keine Policies,
-- keine Rechte); die App spricht ausschließlich die security-definer-Funktionen unten an, die intern auf
-- auth.uid() filtern. Fristen werden "lazy" ausgewertet: jede Funktion, die ein Duell anfasst, schließt es
-- vorher ab, wenn die Frist verstrichen ist. Ein Cron-Job ist nicht nötig.
--
-- Fehler, die die App erwartet, kommen als Exception mit kurzem Code als Nachricht (z.B. 'duell_nicht_laufend').
-- Falsche Einladungscodes werden dagegen als jsonb {ok:false, fehler:...} zurückgegeben, damit der Fehlversuch
-- für die Begrenzung mitgezählt werden kann (eine Exception würde den Eintrag zurückrollen).

-- 1. Regeln an EINER Stelle (Startwerte, siehe Konzept – nach den ersten Duellen anpassen) --------------------------
create or replace function _duell_sek_pro_tipp()         returns int      language sql immutable as $$ select 20 $$;
create or replace function _duell_sek_pro_fehlpruefung() returns int      language sql immutable as $$ select 15 $$;
create or replace function _duell_spielfrist()           returns interval language sql immutable as $$ select interval '7 days' $$;
create or replace function _duell_einladungsfrist()      returns interval language sql immutable as $$ select interval '14 days' $$;
create or replace function _duell_max_offene()           returns int      language sql immutable as $$ select 5 $$;

-- 2. Tabellen ---------------------------------------------------------------------------------------------------------
create table if not exists profile (
  nutzer_id      uuid primary key references auth.users (id) on delete cascade,
  anzeigename    text not null check (char_length(anzeigename) between 2 and 24 and anzeigename = btrim(anzeigename)),
  aktualisiert_am timestamptz not null default now()
);

create table if not exists duelle (
  id                   bigint generated always as identity primary key,
  code                 text not null unique,            -- 8 Zeichen, ohne 0/O/1/I
  ersteller_id         uuid not null references auth.users (id) on delete cascade,
  gegner_id            uuid references auth.users (id) on delete cascade,
  raetsel_id           bigint references raetsel (id),  -- erst beim Beitritt gesetzt
  wunsch_schwierigkeit smallint check (wunsch_schwierigkeit between 1 and 3),
  wunsch_groesse       text check (wunsch_groesse in ('klein', 'mittel', 'gross')),
  status               text not null default 'offen' check (status in ('offen', 'laufend', 'beendet', 'abgelaufen')),
  ende_grund           text check (ende_grund in ('zeit', 'aufgabe', 'frist', 'ohne_ergebnis', 'nicht_beigetreten')),
  erstellt_am          timestamptz not null default now(),
  beigetreten_am       timestamptz,
  frist_am             timestamptz not null default (now() + _duell_einladungsfrist()),
  beendet_am           timestamptz,
  gewinner_id          uuid references auth.users (id) on delete set null,
  revanche_von         bigint references duelle (id) on delete set null,
  constraint duelle_nicht_selbst check (gegner_id is null or gegner_id <> ersteller_id)
);
create index if not exists idx_duelle_ersteller on duelle (ersteller_id);
create index if not exists idx_duelle_gegner    on duelle (gegner_id);
-- Zu jedem Duell gibt es höchstens eine Revanche.
create unique index if not exists duelle_revanche_von_key on duelle (revanche_von) where revanche_von is not null;

create table if not exists duell_teilnahme (
  duell_id              bigint not null references duelle (id) on delete cascade,
  nutzer_id             uuid   not null references auth.users (id) on delete cascade,
  gestartet_am          timestamptz,
  abgegeben_am          timestamptz,
  aufgegeben            boolean not null default false,
  tipps_buchstaben      int not null default 0 check (tipps_buchstaben >= 0),
  pruefungen_mit_fehler int not null default 0 check (pruefungen_mit_fehler >= 0),
  strafsekunden         int not null default 0,
  netto_sekunden        numeric(12, 3),
  zell_eingaben         jsonb not null default '{}'::jsonb,
  aktualisiert_am       timestamptz not null default now(),
  primary key (duell_id, nutzer_id)
);
create index if not exists idx_duell_teilnahme_nutzer on duell_teilnahme (nutzer_id);

-- Fehlversuche bei Einladungscodes (Begrenzung gegen Raten)
create table if not exists duell_versuche (
  nutzer_id uuid not null references auth.users (id) on delete cascade,
  zeit      timestamptz not null default now()
);
create index if not exists idx_duell_versuche on duell_versuche (nutzer_id, zeit);

alter table profile         enable row level security;
alter table duelle          enable row level security;
alter table duell_teilnahme enable row level security;
alter table duell_versuche  enable row level security;
-- Keine Policies und keine Rechte: Zugriff nur über die Funktionen unten.
revoke all on profile, duelle, duell_teilnahme, duell_versuche from anon, authenticated;

-- 3. Interne Hilfsfunktionen (für niemanden ausführbar, nur aus den security-definer-Funktionen) ------------------------
create or replace function _duell_nutzer() returns uuid
language plpgsql stable set search_path = public as $$
declare v_id uuid := auth.uid();
begin
  if v_id is null then raise exception 'nicht_angemeldet'; end if;
  return v_id;
end $$;

-- 8 Zeichen aus 32 Symbolen (40 Bit) aus dem CSPRNG-gestützten gen_random_uuid(); die Bytes 6 und 8 (Version/Variante) werden ausgelassen.
create or replace function _duell_code() returns text
language plpgsql volatile set search_path = public as $$
declare
  v_alphabet constant text := 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  v_bytes bytea := decode(replace(gen_random_uuid()::text, '-', ''), 'hex');
  v_pos int[] := array[0, 1, 2, 3, 4, 5, 9, 10];
  v_code text := '';
  i int;
begin
  foreach i in array v_pos loop
    v_code := v_code || substr(v_alphabet, (get_byte(v_bytes, i) % 32) + 1, 1);
  end loop;
  return v_code;
end $$;

create or replace function _duell_code_normalisieren(p_code text) returns text
language sql immutable as $$ select upper(regexp_replace(coalesce(p_code, ''), '[^A-Za-z0-9]', '', 'g')) $$;

create or replace function _duell_groesse_passt(p_zeilen int, p_spalten int, p_klasse text) returns boolean
language sql immutable as $$
  select case p_klasse
    when 'klein'  then p_zeilen * p_spalten < 100
    when 'mittel' then p_zeilen * p_spalten between 100 and 149
    else               p_zeilen * p_spalten >= 150
  end
$$;

-- Die Regeln, wie sie die App anzeigt und für die Live-Uhr braucht (einzige Quelle: die Funktionen oben).
create or replace function _duell_regeln() returns jsonb
language sql immutable as $$
  select jsonb_build_object('sek_pro_tipp', _duell_sek_pro_tipp(), 'sek_pro_fehlpruefung', _duell_sek_pro_fehlpruefung())
$$;

create or replace function _duell_strafe(p_tipps int, p_pruefungen int) returns int
language sql immutable as $$ select p_tipps * _duell_sek_pro_tipp() + p_pruefungen * _duell_sek_pro_fehlpruefung() $$;

-- Hat einer der beiden das Rätsel schon bearbeitet (Fortschritt angelegt) oder in einem anderen Duell gespielt?
create or replace function _duell_gespielt(p_raetsel bigint, p_a uuid, p_b uuid) returns boolean
language sql stable set search_path = public as $$
  select exists (select 1 from nutzer_fortschritt nf where nf.raetsel_id = p_raetsel and nf.nutzer_id in (p_a, p_b))
      or exists (select 1 from duell_teilnahme t join duelle d on d.id = t.duell_id
                 where d.raetsel_id = p_raetsel and t.nutzer_id in (p_a, p_b));
$$;

-- Zufälliges veröffentlichtes Rätsel, das beide noch nicht gespielt haben. Erst mit den Wünschen, sonst ohne.
create or replace function _duell_raetsel_waehlen(p_a uuid, p_b uuid, p_schwierigkeit smallint, p_groesse text) returns bigint
language plpgsql volatile set search_path = public as $$
declare v_id bigint;
begin
  select r.id into v_id
  from raetsel r join gitter g on g.id = r.gitter_id
  where r.status = 'veroeffentlicht'
    and not _duell_gespielt(r.id, p_a, p_b)
    and (p_schwierigkeit is null or r.schwierigkeit = p_schwierigkeit)
    and (p_groesse is null or _duell_groesse_passt(g.zeilen, g.spalten, p_groesse))
  order by random() limit 1;
  if v_id is null and (p_schwierigkeit is not null or p_groesse is not null) then
    select r.id into v_id
    from raetsel r
    where r.status = 'veroeffentlicht' and not _duell_gespielt(r.id, p_a, p_b)
    order by random() limit 1;
  end if;
  return v_id;
end $$;

-- Stimmt das eingereichte Gitter in jeder Zelle mit der Lösung überein? (Position: erstes Buchstabenfeld, wie in fragen.)
create or replace function _duell_loesung_ok(p_raetsel bigint, p_eingaben jsonb) returns boolean
language sql stable set search_path = public as $$
  with zellen as (
    select case f.richtung when 'A' then f.start_zeile else f.start_zeile + i - 1 end as r,
           case f.richtung when 'A' then f.start_spalte + i - 1 else f.start_spalte end as c,
           substr(w.wort, i, 1) as buchstabe
    from fragen f
    join woerter w on w.id = f.wort_id
    cross join lateral generate_series(1, f.laenge) as i
    where f.raetsel_id = p_raetsel
  )
  select exists (select 1 from zellen)
     and not exists (
       select 1 from zellen z
       where upper(coalesce(p_eingaben ->> (z.r || ',' || z.c), '')) <> upper(z.buchstabe)
     );
$$;

-- Schließt ein Duell ab, wenn seine Frist verstrichen ist. Liefert die (ggf. aktualisierte) Zeile.
create or replace function _duell_frist_anwenden(p_duell duelle) returns duelle
language plpgsql volatile set search_path = public as $$
declare
  v_duell duelle := p_duell;
  v_anzahl int;
  v_sieger uuid;
begin
  if v_duell.status not in ('offen', 'laufend') or v_duell.frist_am >= now() then
    return v_duell;
  end if;
  select * into v_duell from duelle where id = p_duell.id for update;   -- neu lesen: ein anderer Aufruf war evtl. schneller
  if v_duell.status not in ('offen', 'laufend') or v_duell.frist_am >= now() then
    return v_duell;
  end if;

  if v_duell.status = 'offen' then
    update duelle set status = 'abgelaufen', ende_grund = 'nicht_beigetreten', beendet_am = frist_am
    where id = v_duell.id returning * into v_duell;
    return v_duell;
  end if;

  select count(*) into v_anzahl from duell_teilnahme where duell_id = v_duell.id and abgegeben_am is not null;
  if v_anzahl = 1 then
    select nutzer_id into v_sieger from duell_teilnahme where duell_id = v_duell.id and abgegeben_am is not null;
    update duelle set status = 'beendet', ende_grund = 'frist', gewinner_id = v_sieger, beendet_am = frist_am
    where id = v_duell.id returning * into v_duell;
  else
    update duelle set status = 'abgelaufen', ende_grund = 'ohne_ergebnis', beendet_am = frist_am
    where id = v_duell.id returning * into v_duell;
  end if;
  return v_duell;
end $$;

-- Duell sperren, Teilnahme des Aufrufers prüfen, Frist anwenden.
create or replace function _duell_holen(p_id bigint, p_nutzer uuid) returns duelle
language plpgsql volatile set search_path = public as $$
declare v_duell duelle;
begin
  select * into v_duell from duelle where id = p_id for update;
  if not found or (v_duell.ersteller_id <> p_nutzer and v_duell.gegner_id is distinct from p_nutzer) then
    raise exception 'duell_unbekannt';
  end if;
  return _duell_frist_anwenden(v_duell);
end $$;

-- Ergebnis-/Statusansicht für einen Teilnehmer. Regel: Angaben des Gegners (Zeit, Tipps, ...) nur, wenn man selbst
-- abgegeben/aufgegeben hat oder das Duell beendet ist. Die Zelleingaben des Gegners werden nie herausgegeben.
create or replace function _duell_ansicht(p_duell duelle, p_ich uuid) returns jsonb
language plpgsql volatile set search_path = public as $$
declare
  v_gegner_id uuid := case when p_duell.ersteller_id = p_ich then p_duell.gegner_id else p_duell.ersteller_id end;
  v_ich duell_teilnahme;
  v_geg duell_teilnahme;
  v_sichtbar boolean;
  v_geg_fertig boolean;
begin
  select * into v_ich from duell_teilnahme where duell_id = p_duell.id and nutzer_id = p_ich;
  select * into v_geg from duell_teilnahme where duell_id = p_duell.id and nutzer_id = v_gegner_id;
  v_sichtbar := v_ich.abgegeben_am is not null or coalesce(v_ich.aufgegeben, false) or p_duell.status in ('beendet', 'abgelaufen');
  v_geg_fertig := v_sichtbar and v_geg.abgegeben_am is not null;

  return jsonb_build_object(
    'duell_id', p_duell.id,
    'status', p_duell.status,
    'ende_grund', p_duell.ende_grund,
    'jetzt', now(),
    'frist_am', p_duell.frist_am,
    'raetsel_id', p_duell.raetsel_id,
    'regeln', _duell_regeln(),
    'revanche', p_duell.revanche_von is not null,
    'revanche_id', (select id from duelle where revanche_von = p_duell.id),
    'gewinner', case
                  when p_duell.status <> 'beendet' then null
                  when p_duell.gewinner_id is null then 'unentschieden'
                  when p_duell.gewinner_id = p_ich then 'ich'
                  else 'gegner' end,
    'ich', jsonb_build_object(
      'name', (select anzeigename from profile where nutzer_id = p_ich),
      'gestartet_am', v_ich.gestartet_am,
      'abgegeben_am', v_ich.abgegeben_am,
      'aufgegeben', coalesce(v_ich.aufgegeben, false),
      'tipps', v_ich.tipps_buchstaben,
      'pruefungen', v_ich.pruefungen_mit_fehler,
      'strafsekunden', v_ich.strafsekunden,
      'dauer_sekunden', case when v_ich.abgegeben_am is not null then round(extract(epoch from v_ich.abgegeben_am - v_ich.gestartet_am), 3) end,
      'netto_sekunden', v_ich.netto_sekunden),
    'gegner', case when v_gegner_id is null then null else jsonb_build_object(
      'name', (select anzeigename from profile where nutzer_id = v_gegner_id),
      'abgegeben', case when v_sichtbar then v_geg.abgegeben_am is not null end,
      'aufgegeben', case when v_sichtbar then coalesce(v_geg.aufgegeben, false) end,
      'tipps', case when v_geg_fertig then v_geg.tipps_buchstaben end,
      'pruefungen', case when v_geg_fertig then v_geg.pruefungen_mit_fehler end,
      'strafsekunden', case when v_geg_fertig then v_geg.strafsekunden end,
      'dauer_sekunden', case when v_geg_fertig then round(extract(epoch from v_geg.abgegeben_am - v_geg.gestartet_am), 3) end,
      'netto_sekunden', case when v_geg_fertig then v_geg.netto_sekunden end) end
  );
end $$;

revoke all on function _duell_sek_pro_tipp(), _duell_sek_pro_fehlpruefung(), _duell_spielfrist(), _duell_einladungsfrist(),
  _duell_max_offene(), _duell_regeln(), _duell_nutzer(), _duell_code(), _duell_code_normalisieren(text), _duell_groesse_passt(int, int, text),
  _duell_strafe(int, int), _duell_gespielt(bigint, uuid, uuid), _duell_raetsel_waehlen(uuid, uuid, smallint, text),
  _duell_loesung_ok(bigint, jsonb), _duell_frist_anwenden(duelle), _duell_holen(bigint, uuid), _duell_ansicht(duelle, uuid)
  from public, anon, authenticated;
-- (Supabase vergibt neue Funktionen im Schema public per Default-Rechte ausdrücklich an anon/authenticated – "from public" allein reicht nicht.)

-- 4. Öffentliche Funktionen (nur für eingeloggte Nutzer) -----------------------------------------------------------------

-- Eigenes Profil: {anzeigename} oder null
create or replace function profil_laden() returns jsonb
language plpgsql volatile security definer set search_path = public as $$
declare v_me uuid := _duell_nutzer();
begin
  return (select jsonb_build_object('anzeigename', anzeigename) from profile where nutzer_id = v_me);
end $$;

create or replace function profil_setzen(p_name text) returns jsonb
language plpgsql volatile security definer set search_path = public as $$
declare
  v_me uuid := _duell_nutzer();
  v_name text := btrim(coalesce(p_name, ''));
begin
  if char_length(v_name) < 2 or char_length(v_name) > 24 or v_name ~ '[[:cntrl:]]' then
    raise exception 'name_ungueltig';
  end if;
  insert into profile (nutzer_id, anzeigename) values (v_me, v_name)
  on conflict (nutzer_id) do update set anzeigename = excluded.anzeigename, aktualisiert_am = now();
  return jsonb_build_object('anzeigename', v_name);
end $$;

create or replace function duell_erstellen(p_schwierigkeit smallint default null, p_groesse text default null) returns jsonb
language plpgsql volatile security definer set search_path = public as $$
declare
  v_me uuid := _duell_nutzer();
  v_id bigint;
  v_code text;
  v_versuch int := 0;
begin
  if p_schwierigkeit is not null and p_schwierigkeit not between 1 and 3 then raise exception 'ungueltige_angabe'; end if;
  if p_groesse is not null and p_groesse not in ('klein', 'mittel', 'gross') then raise exception 'ungueltige_angabe'; end if;
  if not exists (select 1 from profile where nutzer_id = v_me) then raise exception 'profil_fehlt'; end if;

  -- Abgelaufene Einladungen zuerst abschließen, dann zählen
  perform _duell_frist_anwenden(d) from duelle d where d.ersteller_id = v_me and d.status = 'offen' and d.frist_am < now();
  if (select count(*) from duelle where ersteller_id = v_me and status = 'offen') >= _duell_max_offene() then
    raise exception 'zu_viele_offene_duelle';
  end if;

  loop
    v_versuch := v_versuch + 1;
    v_code := _duell_code();
    begin
      insert into duelle (code, ersteller_id, wunsch_schwierigkeit, wunsch_groesse)
      values (v_code, v_me, p_schwierigkeit, p_groesse) returning id into v_id;
      exit;
    exception when unique_violation then
      if v_versuch >= 5 then raise; end if;
    end;
  end loop;
  insert into duell_teilnahme (duell_id, nutzer_id) values (v_id, v_me);
  return jsonb_build_object('duell_id', v_id, 'code', v_code);
end $$;

-- Wer lädt mich ein? Vorschau vor dem Annehmen (ohne etwas zu ändern).
create or replace function duell_einladung(p_code text) returns jsonb
language plpgsql volatile security definer set search_path = public as $$
declare
  v_me uuid := _duell_nutzer();
  v_code text := _duell_code_normalisieren(p_code);
  v_duell duelle;
begin
  if (select count(*) from duell_versuche where nutzer_id = v_me and zeit > now() - interval '10 minutes') >= 10 then
    return jsonb_build_object('ok', false, 'fehler', 'zu_viele_versuche');
  end if;
  select * into v_duell from duelle where code = v_code;
  if not found then
    insert into duell_versuche (nutzer_id) values (v_me);
    delete from duell_versuche where nutzer_id = v_me and zeit < now() - interval '1 day';
    return jsonb_build_object('ok', false, 'fehler', 'code_unbekannt');
  end if;
  v_duell := _duell_frist_anwenden(v_duell);
  if v_duell.ersteller_id = v_me or v_duell.gegner_id = v_me then
    return jsonb_build_object('ok', true, 'duell_id', v_duell.id, 'bereits_dabei', true, 'eigenes', v_duell.ersteller_id = v_me,
      'ersteller_name', (select anzeigename from profile where nutzer_id = v_duell.ersteller_id));
  end if;
  if v_duell.status = 'abgelaufen' then return jsonb_build_object('ok', false, 'fehler', 'abgelaufen'); end if;
  if v_duell.status <> 'offen' then return jsonb_build_object('ok', false, 'fehler', 'nicht_mehr_offen'); end if;
  return jsonb_build_object('ok', true, 'duell_id', v_duell.id, 'bereits_dabei', false, 'eigenes', false,
    'ersteller_name', (select anzeigename from profile where nutzer_id = v_duell.ersteller_id));
end $$;

create or replace function duell_beitreten(p_code text) returns jsonb
language plpgsql volatile security definer set search_path = public as $$
declare
  v_me uuid := _duell_nutzer();
  v_code text := _duell_code_normalisieren(p_code);
  v_duell duelle;
  v_raetsel bigint;
begin
  if (select count(*) from duell_versuche where nutzer_id = v_me and zeit > now() - interval '10 minutes') >= 10 then
    return jsonb_build_object('ok', false, 'fehler', 'zu_viele_versuche');
  end if;
  select * into v_duell from duelle where code = v_code for update;
  if not found then
    insert into duell_versuche (nutzer_id) values (v_me);
    delete from duell_versuche where nutzer_id = v_me and zeit < now() - interval '1 day';
    return jsonb_build_object('ok', false, 'fehler', 'code_unbekannt');
  end if;
  v_duell := _duell_frist_anwenden(v_duell);

  if v_duell.gegner_id = v_me then return jsonb_build_object('ok', true, 'duell_id', v_duell.id); end if;   -- schon beigetreten
  if v_duell.ersteller_id = v_me then return jsonb_build_object('ok', false, 'fehler', 'eigenes_duell'); end if;
  if v_duell.status = 'abgelaufen' then return jsonb_build_object('ok', false, 'fehler', 'abgelaufen'); end if;
  if v_duell.status <> 'offen' then return jsonb_build_object('ok', false, 'fehler', 'nicht_mehr_offen'); end if;
  if not exists (select 1 from profile where nutzer_id = v_me) then raise exception 'profil_fehlt'; end if;

  v_raetsel := _duell_raetsel_waehlen(v_duell.ersteller_id, v_me, v_duell.wunsch_schwierigkeit, v_duell.wunsch_groesse);
  if v_raetsel is null then return jsonb_build_object('ok', false, 'fehler', 'kein_raetsel'); end if;

  update duelle set gegner_id = v_me, raetsel_id = v_raetsel, status = 'laufend',
                    beigetreten_am = now(), frist_am = now() + _duell_spielfrist()
  where id = v_duell.id;
  insert into duell_teilnahme (duell_id, nutzer_id) values (v_duell.id, v_me);
  return jsonb_build_object('ok', true, 'duell_id', v_duell.id);
end $$;

-- Meine Runde starten bzw. wieder aufnehmen (idempotent: die Startzeit wird nur beim ersten Aufruf gesetzt).
create or replace function duell_starten(p_duell_id bigint) returns jsonb
language plpgsql volatile security definer set search_path = public as $$
declare
  v_me uuid := _duell_nutzer();
  v_duell duelle := _duell_holen(p_duell_id, v_me);
  v_teil duell_teilnahme;
begin
  if v_duell.status <> 'laufend' then raise exception 'duell_nicht_laufend'; end if;
  select * into v_teil from duell_teilnahme where duell_id = v_duell.id and nutzer_id = v_me;
  if v_teil.abgegeben_am is not null or v_teil.aufgegeben then raise exception 'bereits_beendet'; end if;
  if v_teil.gestartet_am is null then
    update duell_teilnahme set gestartet_am = now(), aktualisiert_am = now()
    where duell_id = v_duell.id and nutzer_id = v_me returning * into v_teil;
  end if;
  return jsonb_build_object(
    'raetsel_id', v_duell.raetsel_id,
    'gestartet_am', v_teil.gestartet_am,
    'jetzt', now(),
    'frist_am', v_duell.frist_am,
    'regeln', _duell_regeln(),
    'eingaben', v_teil.zell_eingaben,
    'tipps', v_teil.tipps_buchstaben,
    'pruefungen', v_teil.pruefungen_mit_fehler);
end $$;

-- Zwischenstand sichern (Autosave). Zähler gehen nur aufwärts.
create or replace function duell_speichern(p_duell_id bigint, p_eingaben jsonb, p_tipps int, p_pruefungen int) returns jsonb
language plpgsql volatile security definer set search_path = public as $$
declare
  v_me uuid := _duell_nutzer();
  v_duell duelle := _duell_holen(p_duell_id, v_me);
  v_teil duell_teilnahme;
begin
  if v_duell.status <> 'laufend' then raise exception 'duell_nicht_laufend'; end if;
  if jsonb_typeof(p_eingaben) is distinct from 'object' or length(p_eingaben::text) > 20000
     or p_tipps is null or p_pruefungen is null or p_tipps not between 0 and 1000 or p_pruefungen not between 0 and 1000 then
    raise exception 'ungueltige_angabe';
  end if;
  select * into v_teil from duell_teilnahme where duell_id = v_duell.id and nutzer_id = v_me;
  if v_teil.gestartet_am is null then raise exception 'nicht_gestartet'; end if;
  if v_teil.abgegeben_am is not null or v_teil.aufgegeben then raise exception 'bereits_beendet'; end if;

  update duell_teilnahme
     set zell_eingaben = p_eingaben,
         tipps_buchstaben = greatest(tipps_buchstaben, p_tipps),
         pruefungen_mit_fehler = greatest(pruefungen_mit_fehler, p_pruefungen),
         aktualisiert_am = now()
   where duell_id = v_duell.id and nutzer_id = v_me returning * into v_teil;
  update duell_teilnahme
     set strafsekunden = _duell_strafe(tipps_buchstaben, pruefungen_mit_fehler)
   where duell_id = v_duell.id and nutzer_id = v_me returning * into v_teil;
  return jsonb_build_object('jetzt', now(), 'strafsekunden', v_teil.strafsekunden,
                            'tipps', v_teil.tipps_buchstaben, 'pruefungen', v_teil.pruefungen_mit_fehler);
end $$;

-- Lösung abgeben: prüft das Gitter serverseitig, stoppt die Zeit und entscheidet ggf. das Duell.
create or replace function duell_abgeben(p_duell_id bigint, p_eingaben jsonb, p_tipps int, p_pruefungen int) returns jsonb
language plpgsql volatile security definer set search_path = public as $$
declare
  v_me uuid := _duell_nutzer();
  v_duell duelle := _duell_holen(p_duell_id, v_me);
  v_teil duell_teilnahme;
  v_geg duell_teilnahme;
  v_gegner_id uuid;
  v_strafe int;
  v_netto numeric;
  v_sieger uuid;
begin
  if v_duell.status <> 'laufend' then raise exception 'duell_nicht_laufend'; end if;
  if jsonb_typeof(p_eingaben) is distinct from 'object' or length(p_eingaben::text) > 20000
     or p_tipps is null or p_pruefungen is null or p_tipps not between 0 and 1000 or p_pruefungen not between 0 and 1000 then
    raise exception 'ungueltige_angabe';
  end if;
  select * into v_teil from duell_teilnahme where duell_id = v_duell.id and nutzer_id = v_me;
  if v_teil.gestartet_am is null then raise exception 'nicht_gestartet'; end if;
  if v_teil.abgegeben_am is not null or v_teil.aufgegeben then raise exception 'bereits_beendet'; end if;
  if not _duell_loesung_ok(v_duell.raetsel_id, p_eingaben) then raise exception 'loesung_falsch'; end if;

  v_strafe := _duell_strafe(greatest(v_teil.tipps_buchstaben, p_tipps), greatest(v_teil.pruefungen_mit_fehler, p_pruefungen));
  v_netto := round(extract(epoch from now() - v_teil.gestartet_am)::numeric, 3) + v_strafe;
  update duell_teilnahme
     set abgegeben_am = now(), zell_eingaben = p_eingaben,
         tipps_buchstaben = greatest(tipps_buchstaben, p_tipps),
         pruefungen_mit_fehler = greatest(pruefungen_mit_fehler, p_pruefungen),
         strafsekunden = v_strafe, netto_sekunden = v_netto, aktualisiert_am = now()
   where duell_id = v_duell.id and nutzer_id = v_me;

  v_gegner_id := case when v_duell.ersteller_id = v_me then v_duell.gegner_id else v_duell.ersteller_id end;
  select * into v_geg from duell_teilnahme where duell_id = v_duell.id and nutzer_id = v_gegner_id;
  if v_geg.abgegeben_am is not null then
    v_sieger := case when v_netto < v_geg.netto_sekunden then v_me
                     when v_netto > v_geg.netto_sekunden then v_gegner_id end;   -- null = unentschieden
    update duelle set status = 'beendet', ende_grund = 'zeit', gewinner_id = v_sieger, beendet_am = now()
     where id = v_duell.id returning * into v_duell;
  end if;
  return _duell_ansicht(v_duell, v_me);
end $$;

-- Aufgeben: das Duell endet sofort, der Gegner gewinnt.
create or replace function duell_aufgeben(p_duell_id bigint) returns jsonb
language plpgsql volatile security definer set search_path = public as $$
declare
  v_me uuid := _duell_nutzer();
  v_duell duelle := _duell_holen(p_duell_id, v_me);
  v_teil duell_teilnahme;
begin
  if v_duell.status <> 'laufend' then raise exception 'duell_nicht_laufend'; end if;
  select * into v_teil from duell_teilnahme where duell_id = v_duell.id and nutzer_id = v_me;
  if v_teil.abgegeben_am is not null or v_teil.aufgegeben then raise exception 'bereits_beendet'; end if;
  update duell_teilnahme set aufgegeben = true, aktualisiert_am = now() where duell_id = v_duell.id and nutzer_id = v_me;
  update duelle set status = 'beendet', ende_grund = 'aufgabe', beendet_am = now(),
                    gewinner_id = case when ersteller_id = v_me then gegner_id else ersteller_id end
   where id = v_duell.id returning * into v_duell;
  return _duell_ansicht(v_duell, v_me);
end $$;

-- Eine noch offene Einladung zurückziehen.
create or replace function duell_zurueckziehen(p_duell_id bigint) returns void
language plpgsql volatile security definer set search_path = public as $$
declare
  v_me uuid := _duell_nutzer();
  v_duell duelle := _duell_holen(p_duell_id, v_me);
begin
  if v_duell.status <> 'offen' or v_duell.ersteller_id <> v_me then raise exception 'duell_nicht_offen'; end if;
  delete from duelle where id = v_duell.id;
end $$;

create or replace function duell_ergebnis(p_duell_id bigint) returns jsonb
language plpgsql volatile security definer set search_path = public as $$
declare
  v_me uuid := _duell_nutzer();
  v_duell duelle := _duell_holen(p_duell_id, v_me);
begin
  return _duell_ansicht(v_duell, v_me);
end $$;

-- Revanche: neues Duell mit denselben zwei Spielern und einem neuen Rätsel (höchstens eine je Duell).
create or replace function duell_revanche(p_duell_id bigint) returns jsonb
language plpgsql volatile security definer set search_path = public as $$
declare
  v_me uuid := _duell_nutzer();
  v_alt duelle := _duell_holen(p_duell_id, v_me);
  v_bestehend bigint;
  v_gegner_id uuid;
  v_raetsel bigint;
  v_id bigint;
  v_code text;
  v_versuch int := 0;
begin
  if v_alt.status <> 'beendet' then raise exception 'duell_nicht_beendet'; end if;
  select id into v_bestehend from duelle where revanche_von = v_alt.id;
  if v_bestehend is not null then return jsonb_build_object('ok', true, 'duell_id', v_bestehend); end if;

  v_gegner_id := case when v_alt.ersteller_id = v_me then v_alt.gegner_id else v_alt.ersteller_id end;
  v_raetsel := _duell_raetsel_waehlen(v_me, v_gegner_id, v_alt.wunsch_schwierigkeit, v_alt.wunsch_groesse);
  if v_raetsel is null then return jsonb_build_object('ok', false, 'fehler', 'kein_raetsel'); end if;

  loop
    v_versuch := v_versuch + 1;
    v_code := _duell_code();
    begin
      insert into duelle (code, ersteller_id, gegner_id, raetsel_id, wunsch_schwierigkeit, wunsch_groesse,
                          status, beigetreten_am, frist_am, revanche_von)
      values (v_code, v_me, v_gegner_id, v_raetsel, v_alt.wunsch_schwierigkeit, v_alt.wunsch_groesse,
              'laufend', now(), now() + _duell_spielfrist(), v_alt.id) returning id into v_id;
      exit;
    exception when unique_violation then
      if v_versuch >= 5 then raise; end if;
    end;
  end loop;
  insert into duell_teilnahme (duell_id, nutzer_id) values (v_id, v_me), (v_id, v_gegner_id);
  return jsonb_build_object('ok', true, 'duell_id', v_id);
end $$;

-- Meine Duelle für die Startseite (neueste zuerst, höchstens 50).
create or replace function duelle_liste() returns jsonb
language plpgsql volatile security definer set search_path = public as $$
declare
  v_me uuid := _duell_nutzer();
  v_duell duelle;
  v_ids bigint[];
  v_id bigint;
  v_ergebnis jsonb := '[]'::jsonb;
  v_gegner_id uuid;
begin
  select coalesce(array_agg(id order by erstellt_am desc), '{}') into v_ids
  from (select id, erstellt_am from duelle where ersteller_id = v_me or gegner_id = v_me order by erstellt_am desc limit 50) x;

  foreach v_id in array v_ids loop
    select * into v_duell from duelle where id = v_id;
    v_duell := _duell_frist_anwenden(v_duell);
    v_gegner_id := case when v_duell.ersteller_id = v_me then v_duell.gegner_id else v_duell.ersteller_id end;
    v_ergebnis := v_ergebnis || jsonb_build_array(jsonb_build_object(
      'id', v_duell.id,
      'status', v_duell.status,
      'ende_grund', v_duell.ende_grund,
      'code', case when v_duell.status = 'offen' and v_duell.ersteller_id = v_me then v_duell.code end,
      'ich_ersteller', v_duell.ersteller_id = v_me,
      'gegner_name', (select anzeigename from profile where nutzer_id = v_gegner_id),
      'erstellt_am', v_duell.erstellt_am,
      'frist_am', v_duell.frist_am,
      'revanche', v_duell.revanche_von is not null,
      'revanche_id', (select id from duelle where revanche_von = v_duell.id),
      'wunsch_schwierigkeit', v_duell.wunsch_schwierigkeit,
      'wunsch_groesse', v_duell.wunsch_groesse,
      'raetsel', (select jsonb_build_object('titel', r.titel, 'zeilen', g.zeilen, 'spalten', g.spalten, 'schwierigkeit', r.schwierigkeit)
                  from raetsel r join gitter g on g.id = r.gitter_id where r.id = v_duell.raetsel_id),
      'mein_zustand', (select case when t.aufgegeben then 'aufgegeben'
                                   when t.abgegeben_am is not null then 'abgegeben'
                                   when t.gestartet_am is not null then 'laeuft'
                                   else 'nicht_gestartet' end
                       from duell_teilnahme t where t.duell_id = v_duell.id and t.nutzer_id = v_me),
      'gewinner', case when v_duell.status <> 'beendet' then null
                       when v_duell.gewinner_id is null then 'unentschieden'
                       when v_duell.gewinner_id = v_me then 'ich'
                       else 'gegner' end,
      'meine_netto_sekunden', (select t.netto_sekunden from duell_teilnahme t where t.duell_id = v_duell.id and t.nutzer_id = v_me)
    ));
  end loop;
  return v_ergebnis;
end $$;

revoke all on function profil_laden(), profil_setzen(text), duell_erstellen(smallint, text), duell_einladung(text),
  duell_beitreten(text), duell_starten(bigint), duell_speichern(bigint, jsonb, int, int), duell_abgeben(bigint, jsonb, int, int),
  duell_aufgeben(bigint), duell_zurueckziehen(bigint), duell_ergebnis(bigint), duell_revanche(bigint), duelle_liste()
  from public, anon;
grant execute on function profil_laden(), profil_setzen(text), duell_erstellen(smallint, text), duell_einladung(text),
  duell_beitreten(text), duell_starten(bigint), duell_speichern(bigint, jsonb, int, int), duell_abgeben(bigint, jsonb, int, int),
  duell_aufgeben(bigint), duell_zurueckziehen(bigint), duell_ergebnis(bigint), duell_revanche(bigint), duelle_liste()
  to authenticated;
