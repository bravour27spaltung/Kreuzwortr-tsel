-- Automatisch erzeugt von tools/generator/generate_raetsel.py – nicht von Hand bearbeiten.
-- Voraussetzung: Migrationen, gitter_vorlagen.sql, woerter_seed.sql, fragen_varianten_seed.sql und fragen_varianten_seed_phase6.sql eingespielt.
-- Idempotent über raetsel.slug. Rätsel mit Prüfhinweisen werden als Entwurf angelegt.
-- Bestand ERSETZT (Stamm-Sperre, siehe tools/generator/staemme.py): vorher einmalig supabase/seed/bestand_archivieren_stammsperre.sql einspielen,
-- sonst überspringt 'on conflict (slug) do nothing' alle Rätsel, deren Slug schon in der Datenbank existiert.

begin;

-- r001-8x8-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r001-8x8-01', 'Rätsel 1 · 8×8', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '8x8-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('GAGE', 'Honorar', 'A', 1, 1, 4),
    ('ALASKA', 'Staat am Yukon', 'A', 2, 1, 6),
    ('BAUERN', 'Landwirte', 'A', 3, 1, 6),
    ('LAST', 'Bürde', 'A', 4, 4, 4),
    ('OMA', 'Omi', 'A', 5, 1, 3),
    ('GAR', 'völlig', 'A', 5, 5, 3),
    ('LUEGE', 'Unwahrheit', 'A', 6, 3, 5),
    ('LOT', 'Senkblei', 'A', 7, 1, 3),
    ('NEU', 'frisch', 'A', 7, 5, 3),
    ('GAB', 'reichte', 'D', 1, 1, 3),
    ('OEL', 'Schmierstoff', 'D', 5, 1, 3),
    ('ALARM', 'Warnsignal', 'D', 1, 2, 5),
    ('GAU', 'Landesteil', 'D', 1, 3, 3),
    ('ALT', 'betagt', 'D', 5, 3, 3),
    ('ESEL', 'Dickkopf', 'D', 1, 4, 4),
    ('KRAGEN', 'Halsbund', 'D', 2, 5, 6),
    ('ANSAGE', 'Durchsage', 'D', 2, 6, 6),
    ('TREU', 'loyal', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r002-8x8-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r002-8x8-02', 'Rätsel 2 · 8×8', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '8x8-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('IRAN', 'Persien', 'A', 1, 4, 4),
    ('FAUNA', 'Tierwelt', 'A', 2, 1, 5),
    ('RENNT', 'läuft', 'A', 3, 1, 5),
    ('ARGE', 'schlimme', 'A', 4, 1, 4),
    ('ARMUT', 'Not', 'A', 5, 3, 5),
    ('REALE', 'wirkliche', 'A', 6, 3, 5),
    ('NUN', 'inzwischen', 'A', 7, 1, 3),
    ('NIE', 'nimmer', 'A', 7, 5, 3),
    ('FRAUEN', 'Damen', 'D', 2, 1, 6),
    ('BAER', 'Raubtier', 'D', 1, 2, 4),
    ('UNGARN', 'Magyaren', 'D', 2, 3, 6),
    ('INNERE', 'interne', 'D', 1, 4, 6),
    ('RAT', 'Gremium', 'D', 1, 5, 3),
    ('MAN', 'jemand', 'D', 5, 5, 3),
    ('JULI', '7. Monat', 'D', 4, 6, 4),
    ('NUR', 'bloß', 'D', 1, 7, 3),
    ('TEE', 'Aufguss', 'D', 5, 7, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r003-8x8-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r003-8x8-03', 'Rätsel 3 · 8×8', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '8x8-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('KANSAS', 'Staat um Wichita', 'A', 1, 1, 6),
    ('RIEGEL', 'Schieber', 'A', 2, 2, 6),
    ('STEHEN', 'ausharren', 'A', 3, 1, 6),
    ('ENDE', 'Schluss', 'A', 4, 4, 4),
    ('GAU', 'Landstrich', 'A', 5, 1, 3),
    ('DEN', 'Artikel (Akkusativ)', 'A', 5, 5, 3),
    ('TUN', 'verrichten', 'A', 6, 1, 3),
    ('ARG', 'übel', 'A', 6, 5, 3),
    ('ESSE', 'speise', 'A', 7, 1, 4),
    ('SAGTE', 'äußerte', 'D', 3, 1, 5),
    ('ART', 'Sorte', 'D', 1, 2, 3),
    ('AUS', 'vorbei', 'D', 5, 2, 3),
    ('NIE', 'zu keiner Zeit', 'D', 1, 3, 3),
    ('UNS', 'Akk./Dat. von wir', 'D', 5, 3, 3),
    ('SEHE', 'erblicke', 'D', 1, 4, 4),
    ('AGENDA', 'Tagesordnung', 'D', 1, 5, 6),
    ('SENDER', 'Kanal', 'D', 1, 6, 6),
    ('ENGE', 'schmale', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r004-9x9-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r004-9x9-01', 'Rätsel 4 · 9×9', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x9-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('WACH', 'munter', 'A', 1, 1, 4),
    ('OHR', 'Lauscher', 'A', 1, 6, 3),
    ('AULA', 'Versammlungssaal', 'A', 2, 1, 4),
    ('FEE', 'Elfe', 'A', 2, 6, 3),
    ('EGAL', 'einerlei', 'A', 3, 1, 4),
    ('TUN', 'verrichten', 'A', 3, 6, 3),
    ('CENT', 'Hundertstel Euro', 'A', 4, 1, 4),
    ('FETT', 'Schmalz', 'A', 5, 5, 4),
    ('SOMALIA', 'Staat in Ostafrika', 'A', 6, 1, 7),
    ('TRAUUNG', 'Hochzeit', 'A', 7, 1, 7),
    ('TIERES', 'Name des ...', 'A', 8, 2, 6),
    ('WAECHST', 'gedeiht', 'D', 1, 1, 7),
    ('AUGE', 'Pupille', 'D', 1, 2, 4),
    ('ORT', 'Platz', 'D', 6, 2, 3),
    ('CLAN', 'Sippe', 'D', 1, 3, 4),
    ('MAI', 'Wonnemonat', 'D', 6, 3, 3),
    ('HALT', 'eben', 'D', 1, 4, 4),
    ('AUE', 'Wiesenland', 'D', 6, 4, 3),
    ('FLUR', 'Diele', 'D', 5, 5, 4),
    ('OFT', 'des Öfteren', 'D', 1, 6, 3),
    ('EINE', 'unbest. Artikel (w.)', 'D', 5, 6, 4),
    ('HEU', 'Viehfutter', 'D', 1, 7, 3),
    ('TAGS', 'am nächsten ...', 'D', 5, 7, 4),
    ('RENNT', 'läuft', 'D', 1, 8, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r005-9x9-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r005-9x9-02', 'Rätsel 5 · 9×9', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x9-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ZOOS', 'Tierparks', 'A', 1, 1, 4),
    ('AST', 'Zweig', 'A', 1, 6, 3),
    ('OPFER', 'Geschädigter', 'A', 2, 1, 5),
    ('GATTUNG', 'Art', 'A', 3, 1, 7),
    ('NOTE', 'Zensur', 'A', 4, 5, 4),
    ('GEREDE', 'Geschwätz', 'A', 5, 1, 6),
    ('EHER', 'lieber', 'A', 6, 1, 4),
    ('TEE', 'Heißgetränk', 'A', 6, 6, 3),
    ('IRIS', 'Regenbogenhaut', 'A', 7, 1, 4),
    ('IHR', 'Pronomen (2. Pl.)', 'A', 7, 6, 3),
    ('LEST', 'schmökert', 'A', 8, 1, 4),
    ('GEN', 'nach', 'A', 8, 6, 3),
    ('ZOG', 'riss', 'D', 1, 1, 3),
    ('GEIL', 'toll (ugs.)', 'D', 5, 1, 4),
    ('OPA', 'Großvater', 'D', 1, 2, 3),
    ('EHRE', 'Prestige', 'D', 5, 2, 4),
    ('OFT', 'des Öfteren', 'D', 1, 3, 3),
    ('REIS', 'Getreideart', 'D', 5, 3, 4),
    ('SET', 'Satz', 'D', 1, 4, 3),
    ('ERST', 'zunächst', 'D', 5, 4, 4),
    ('RUND', 'ungefähr', 'D', 2, 5, 4),
    ('NOETIG', 'erforderlich', 'D', 3, 6, 6),
    ('SAGT', 'äußert', 'D', 1, 7, 4),
    ('EHE', 'Vermählung', 'D', 6, 7, 3),
    ('EIERN', 'schwanken', 'D', 4, 8, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r006-9x9-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r006-9x9-03', 'Rätsel 6 · 9×9', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '9x9-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('OBEN', 'in der Höhe', 'A', 1, 1, 4),
    ('UHR', 'Chronometer', 'A', 1, 6, 3),
    ('EINE', 'unbest. Artikel (w.)', 'A', 2, 1, 4),
    ('RIO', 'Stadt in Brasilien', 'A', 2, 6, 3),
    ('LEGT', 'deponiert', 'A', 3, 1, 4),
    ('SET', 'Ausstattung', 'A', 3, 6, 3),
    ('ZWAR', 'Konjunktionaladverb', 'A', 4, 4, 4),
    ('REICHT', 'genügt', 'A', 5, 3, 6),
    ('AUE', 'Talwiese', 'A', 6, 1, 3),
    ('EHER', 'vielmehr', 'A', 6, 5, 4),
    ('INS', 'in das', 'A', 7, 1, 3),
    ('GERA', 'Stadt in Thüringen', 'A', 7, 5, 4),
    ('SITZT', 'hockt', 'A', 8, 1, 5),
    ('OEL', 'Rohstoff', 'D', 1, 1, 3),
    ('MAIS', 'Kukuruz', 'D', 5, 1, 4),
    ('BIER', 'Gerstensaft', 'D', 1, 2, 4),
    ('UNI', 'Hochschule', 'D', 6, 2, 3),
    ('ENG', 'knapp', 'D', 1, 3, 3),
    ('REST', 'Überbleibsel', 'D', 5, 3, 4),
    ('NETZE', 'Geflechte', 'D', 1, 4, 5),
    ('WIEGT', 'schaukelt', 'D', 4, 5, 5),
    ('URSACHE', 'Grund', 'D', 1, 6, 7),
    ('HIERHER', 'herbei', 'D', 1, 7, 7),
    ('ROT', 'purpurn', 'D', 1, 8, 3),
    ('TRAT', 'stapfte', 'D', 5, 8, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r007-9x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r007-9x13-01', 'Rätsel 7 · 9×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '9x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ERBE', 'Nachlass', 'A', 1, 1, 4),
    ('SKEPSIS', 'Zweifel', 'A', 1, 6, 7),
    ('BAUS', 'Ende des ...', 'A', 2, 1, 4),
    ('BIENE', 'Imme', 'A', 2, 8, 5),
    ('ENGSTE', 'schmalste', 'A', 3, 1, 6),
    ('BEINE', 'Gliedmaßen', 'A', 3, 8, 5),
    ('SIEBTER', 'nach dem Sechsten', 'A', 4, 3, 7),
    ('GUTE', 'prima', 'A', 5, 4, 4),
    ('LAS', 'entzifferte', 'A', 6, 1, 3),
    ('FEST', 'stabil', 'A', 6, 5, 4),
    ('OFT', 'des Öfteren', 'A', 6, 10, 3),
    ('UNI', 'Hochschule', 'A', 7, 1, 3),
    ('ENTE', 'Wasservogel', 'A', 7, 5, 4),
    ('HEU', 'Trockengras', 'A', 7, 10, 3),
    ('DUELL', 'Zweikampf', 'A', 8, 1, 5),
    ('SEGLER', 'Skipper', 'A', 8, 7, 6),
    ('EBEN', 'just', 'D', 1, 1, 4),
    ('LUD', 'packte auf', 'D', 6, 1, 3),
    ('RAN', 'hinzu', 'D', 1, 2, 3),
    ('KANU', 'Paddelboot', 'D', 5, 2, 4),
    ('BUGS', 'Fehler', 'D', 1, 3, 4),
    ('SIE', 'Anrede', 'D', 6, 3, 3),
    ('ESSIG', 'Würzmittel', 'D', 1, 4, 5),
    ('TEUFEL', 'Satan', 'D', 3, 5, 6),
    ('SIEBTEN', 'am ... Juli', 'D', 1, 6, 7),
    ('TESTS', 'Prüfungen', 'D', 4, 7, 5),
    ('EBBE', 'Niedrigwasser', 'D', 1, 8, 4),
    ('TEE', 'Heißgetränk', 'D', 6, 8, 3),
    ('PIER', 'Anleger', 'D', 1, 9, 4),
    ('SEI', 'existiere', 'D', 1, 10, 3),
    ('WOHL', 'vermutlich', 'D', 5, 10, 4),
    ('INNE', 'Verbpartikel', 'D', 1, 11, 4),
    ('FEE', 'Zauberin', 'D', 6, 11, 3),
    ('SEE', 'Gewässer', 'D', 1, 12, 3),
    ('STUR', 'unnachgiebig', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r008-9x13-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r008-9x13-02', 'Rätsel 8 · 9×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '9x13-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('KUR', 'Erholung', 'A', 1, 1, 3),
    ('HIT', 'Schlager', 'A', 1, 6, 3),
    ('HEU', 'Trockengras', 'A', 1, 10, 3),
    ('OMA', 'Omi', 'A', 2, 1, 3),
    ('OEDE', 'langweilig', 'A', 2, 5, 4),
    ('OHR', 'Lauscher', 'A', 2, 10, 3),
    ('ESEL', 'Dickkopf', 'A', 3, 1, 4),
    ('REISSEN', 'zerren', 'A', 3, 6, 7),
    ('NOTE', 'Tonzeichen', 'A', 4, 1, 4),
    ('RAGTE', 'erhob sich', 'A', 4, 6, 5),
    ('IGEL', 'Stacheltier', 'A', 5, 4, 4),
    ('GASSEN', 'Wege', 'A', 6, 1, 6),
    ('LEHEN', 'Pfründe', 'A', 6, 8, 5),
    ('SEEN', 'Gewässer', 'A', 7, 2, 4),
    ('KABINE', 'Kajüte', 'A', 7, 7, 6),
    ('OSTSEE', 'Baltisches Meer', 'A', 8, 1, 6),
    ('GENAU', 'exakt', 'A', 8, 8, 5),
    ('KOENIG', 'Monarch', 'D', 1, 1, 6),
    ('UMSO', 'Konjunktionaladverb', 'D', 1, 2, 4),
    ('ASS', 'verspeiste', 'D', 6, 2, 3),
    ('RAET', 'tippt', 'D', 1, 3, 4),
    ('SET', 'Satz', 'D', 6, 3, 3),
    ('LEISES', 'gedämpftes', 'D', 3, 4, 6),
    ('GENE', 'Erbanlagen', 'D', 5, 5, 4),
    ('HERREN', 'Männer', 'D', 1, 6, 6),
    ('IDEAL', 'Leitbild', 'D', 1, 7, 5),
    ('TEIG', 'Masse', 'D', 1, 8, 4),
    ('LAG', 'ruhte', 'D', 6, 8, 3),
    ('STREBE', 'trachte', 'D', 3, 9, 6),
    ('HOSE', 'Beinkleid', 'D', 1, 10, 4),
    ('HIN', 'fort', 'D', 6, 10, 3),
    ('EHE', 'Bund fürs Leben', 'D', 1, 11, 3),
    ('JENA', 'Saalestadt', 'D', 5, 11, 4),
    ('URNE', 'Wahlbehälter', 'D', 1, 12, 4),
    ('NEU', 'frisch', 'D', 6, 12, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r009-9x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r009-9x13-03', 'Rätsel 9 · 9×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('SPOT', 'Werbeclip', 'A', 1, 1, 4),
    ('NEULAND', 'Terra incognita', 'A', 1, 6, 7),
    ('EUROPA', 'Erdteil', 'A', 2, 1, 6),
    ('FOLIE', 'Film', 'A', 2, 8, 5),
    ('ERTRAG', 'Gewinn', 'A', 3, 1, 6),
    ('ESSEN', 'Mahlzeit', 'A', 3, 8, 5),
    ('SEHR', 'überaus', 'A', 4, 5, 4),
    ('OSLO', 'Friedenspreis-Stadt', 'A', 5, 4, 4),
    ('LUST', 'Verlangen', 'A', 5, 9, 4),
    ('ATOME', 'Teilchen', 'A', 6, 1, 5),
    ('HAETTE', 'besäße', 'A', 6, 7, 6),
    ('NAMEN', 'Benennungen', 'A', 7, 1, 5),
    ('BAUS', 'Ende des ...', 'A', 7, 9, 4),
    ('STANDEN', 'stockten', 'A', 8, 1, 7),
    ('EHRT', 'zollt Respekt', 'A', 8, 9, 4),
    ('SEE', 'Gewässer', 'D', 1, 1, 3),
    ('FANS', 'Anhänger', 'D', 5, 1, 4),
    ('PUR', 'unverfälscht', 'D', 1, 2, 3),
    ('TAT', 'Werk', 'D', 6, 2, 3),
    ('ORTE', 'Plätze', 'D', 1, 3, 4),
    ('OMA', 'Großmutter', 'D', 6, 3, 3),
    ('TOR', 'Treffer', 'D', 1, 4, 3),
    ('OMEN', 'Vorbote', 'D', 5, 4, 4),
    ('PASSEND', 'geeignet', 'D', 2, 5, 7),
    ('NAGEL', 'Stift', 'D', 1, 6, 5),
    ('HOHEN', 'großen', 'D', 4, 7, 5),
    ('UFER', 'Küste', 'D', 1, 8, 4),
    ('LOS', 'ledig', 'D', 1, 9, 3),
    ('LEBE', 'existiere', 'D', 5, 9, 4),
    ('ALS', 'da, während', 'D', 1, 10, 3),
    ('UTAH', 'Salzsee-Staat', 'D', 5, 10, 4),
    ('NIE', 'zu keiner Zeit', 'D', 1, 11, 3),
    ('STUR', 'starrsinnig', 'D', 5, 11, 4),
    ('DEN', 'Artikel (Akkusativ)', 'D', 1, 12, 3),
    ('TEST', 'Klausur', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r010-10x10-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r010-10x10-01', 'Rätsel 10 · 10×10', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '10x10-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('GAB', 'reichte', 'A', 1, 1, 3),
    ('LOKS', 'Triebwagen', 'A', 1, 6, 4),
    ('ALLEN', 'sämtlichen', 'A', 2, 1, 5),
    ('HAI', 'Meeresräuber', 'A', 2, 7, 3),
    ('STAR', 'Berühmtheit', 'A', 3, 1, 4),
    ('ARME', 'Mittellose', 'A', 3, 6, 4),
    ('TEURER', 'kostbarer', 'A', 4, 1, 6),
    ('EIGENE', 'persönliche', 'A', 5, 4, 6),
    ('JUNGS', 'Knaben', 'A', 6, 1, 5),
    ('BEI', 'nahe an', 'A', 6, 7, 3),
    ('ETAT', 'Finanzplan', 'A', 7, 1, 4),
    ('NEIN', 'Ablehnung', 'A', 7, 6, 4),
    ('DAME', 'Frau', 'A', 8, 1, 4),
    ('ENGE', 'knappe', 'A', 8, 6, 4),
    ('EHE', 'Bund fürs Leben', 'A', 9, 1, 3),
    ('QUEEN', 'Königin', 'A', 9, 5, 5),
    ('GAST', 'Besucher', 'D', 1, 1, 4),
    ('JEDE', 'alle', 'D', 6, 1, 4),
    ('ALTE', 'greise', 'D', 1, 2, 4),
    ('UTAH', 'Mormonenstaat', 'D', 6, 2, 4),
    ('BLAU', 'betrunken', 'D', 1, 3, 4),
    ('NAME', 'Bezeichnung', 'D', 6, 3, 4),
    ('ERREGTE', 'weckte', 'D', 2, 4, 7),
    ('EIS', 'Gefrorenes', 'D', 4, 5, 3),
    ('ARG', 'schlimm', 'D', 3, 6, 3),
    ('NEU', 'aktuell', 'D', 7, 6, 3),
    ('OHR', 'Hörorgan', 'D', 1, 7, 3),
    ('EBENE', 'Fläche', 'D', 5, 7, 5),
    ('KAM', 'traf ein', 'D', 1, 8, 3),
    ('NEIGE', 'zur ... gehen', 'D', 5, 8, 5),
    ('SIE', 'Anrede', 'D', 1, 9, 3),
    ('EINEN', 'unbest. Art. (Akk.)', 'D', 5, 9, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r011-10x10-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r011-10x10-02', 'Rätsel 11 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('LOS', 'frei', 'A', 1, 1, 3),
    ('STARS', 'Prominente', 'A', 1, 5, 5),
    ('ARENA', 'Kolosseum', 'A', 2, 1, 5),
    ('HAI', 'Meeresräuber', 'A', 2, 7, 3),
    ('STIEG', 'kletterte', 'A', 3, 1, 5),
    ('NUN', 'jetzt', 'A', 3, 7, 3),
    ('UEBTEN', 'trainierten', 'A', 4, 4, 6),
    ('PFANNE', 'Bratgerät', 'A', 5, 1, 6),
    ('ALT', 'ergraut', 'A', 6, 1, 3),
    ('TRIO', 'Dreiergruppe', 'A', 6, 6, 4),
    ('NAH', 'dicht', 'A', 7, 1, 3),
    ('WEIDE', 'Wiese', 'A', 7, 5, 5),
    ('NIE', 'nimmer', 'A', 8, 1, 3),
    ('INSEL', 'Eiland', 'A', 8, 5, 5),
    ('ERNTE', 'Lese', 'A', 9, 1, 5),
    ('SEE', 'Gewässer', 'A', 9, 7, 3),
    ('LAS', 'entzifferte', 'D', 1, 1, 3),
    ('PANNE', 'Defekt', 'D', 5, 1, 5),
    ('ORT', 'Platz', 'D', 1, 2, 3),
    ('FLAIR', 'Ambiente', 'D', 5, 2, 5),
    ('SEI', 'existiere', 'D', 1, 3, 3),
    ('ATHEN', 'griech. Hauptstadt', 'D', 5, 3, 5),
    ('NEUN', 'Zahl (3×3)', 'D', 2, 4, 4),
    ('SAGEN', 'äußern', 'D', 1, 5, 5),
    ('WIE', 'gleich', 'D', 7, 5, 3),
    ('BETEN', 'flehen', 'D', 4, 6, 5),
    ('AHNT', 'spürt', 'D', 1, 7, 4),
    ('RISS', 'zerrte', 'D', 6, 7, 4),
    ('RAUE', 'grobe', 'D', 1, 8, 4),
    ('IDEE', 'Gedanke', 'D', 6, 8, 4),
    ('SINN', 'Bedeutung', 'D', 1, 9, 4),
    ('OELE', 'Fette', 'D', 6, 9, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r012-10x10-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r012-10x10-03', 'Rätsel 12 · 10×10', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '10x10-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ASIEN', 'Erdteil', 'A', 1, 1, 5),
    ('ART', 'Spezies', 'A', 1, 7, 3),
    ('DANN', 'anschließend', 'A', 2, 1, 4),
    ('HEU', 'Viehfutter', 'A', 2, 7, 3),
    ('LAST', 'Bürde', 'A', 3, 1, 4),
    ('ENDE', 'Finale', 'A', 3, 6, 4),
    ('ELEGANTE', 'schicke', 'A', 4, 1, 8),
    ('RELIKT', 'Überbleibsel', 'A', 5, 1, 6),
    ('NUESSE', 'Kerne', 'A', 6, 4, 6),
    ('BEUGT', 'krümmt', 'A', 7, 1, 5),
    ('TAL', 'Senke', 'A', 7, 7, 3),
    ('IHN', 'Akkusativ von er', 'A', 8, 1, 3),
    ('EWIGE', 'endlose', 'A', 8, 5, 5),
    ('NEIN', 'Absage', 'A', 9, 1, 4),
    ('LAG', 'befand sich', 'A', 9, 7, 3),
    ('ADLER', 'Greifvogel', 'D', 1, 1, 5),
    ('BIN', 'Verbform', 'D', 7, 1, 3),
    ('SAALE', 'Fluss durch Halle', 'D', 1, 2, 5),
    ('EHE', 'Vermählung', 'D', 7, 2, 3),
    ('INSEL', 'Eiland', 'D', 1, 3, 5),
    ('UNI', 'Alma Mater', 'D', 7, 3, 3),
    ('ENTGING', 'entkam', 'D', 1, 4, 7),
    ('AKUTE', 'dringende', 'D', 4, 5, 5),
    ('ENTE', 'Falschmeldung', 'D', 3, 6, 4),
    ('AHNT', 'vermutet', 'D', 1, 7, 4),
    ('STIL', 'Machart', 'D', 6, 7, 4),
    ('REDE', 'Ansprache', 'D', 1, 8, 4),
    ('SAGA', 'Heldensage', 'D', 6, 8, 4),
    ('TUE', 'verrichte', 'D', 1, 9, 3),
    ('BELEG', 'Quittung', 'D', 5, 9, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r013-10x10-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r013-10x10-04', 'Rätsel 13 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('PFAD', 'Weg', 'A', 1, 1, 4),
    ('WERK', 'Fabrik', 'A', 1, 6, 4),
    ('ALT', 'ergraut', 'A', 2, 1, 3),
    ('KAMEN', 'trafen ein', 'A', 2, 5, 5),
    ('KOMA', 'tiefe Ohnmacht', 'A', 3, 1, 4),
    ('SAGA', 'Heldensage', 'A', 3, 6, 4),
    ('TREU', 'anhänglich', 'A', 4, 1, 4),
    ('SIEB', 'Filter', 'A', 4, 6, 4),
    ('ANSTELLE', 'statt', 'A', 5, 2, 8),
    ('BAR', 'Theke', 'A', 6, 4, 3),
    ('IDEAL', 'Leitbild', 'A', 7, 1, 5),
    ('AST', 'Zweig', 'A', 7, 7, 3),
    ('MENUE', 'Speisenfolge', 'A', 8, 1, 5),
    ('RIO', 'Stadt in Brasilien', 'A', 8, 7, 3),
    ('ARG', 'übel', 'A', 9, 1, 3),
    ('ROTEN', 'purpurnen', 'A', 9, 5, 5),
    ('PAKT', 'Bündnis', 'D', 1, 1, 4),
    ('LIMA', 'peruan. Hauptstadt', 'D', 6, 1, 4),
    ('FLORA', 'Pflanzenwelt', 'D', 1, 2, 5),
    ('DER', 'Artikel (männl.)', 'D', 7, 2, 3),
    ('ATMEN', 'Luft holen', 'D', 1, 3, 5),
    ('ENG', 'knapp', 'D', 7, 3, 3),
    ('AUSBAU', 'Erweiterung', 'D', 3, 4, 6),
    ('TALER', 'alte Münze', 'D', 5, 5, 5),
    ('WASSER', 'H2O', 'D', 1, 6, 6),
    ('EMAIL', 'digitale Post', 'D', 1, 7, 5),
    ('ART', 'Spezies', 'D', 7, 7, 3),
    ('REGEL', 'Norm', 'D', 1, 8, 5),
    ('SIE', 'Anrede', 'D', 7, 8, 3),
    ('KNABE', 'Junge', 'D', 1, 9, 5),
    ('TON', 'Lehm', 'D', 7, 9, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r014-11x11-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r014-11x11-01', 'Rätsel 14 · 11×11', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '11x11-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('EDEL', 'vornehm', 'A', 1, 1, 4),
    ('BIRGT', 'enthält', 'A', 1, 6, 5),
    ('REH', 'Waldtier', 'A', 2, 1, 3),
    ('AUE', 'Talwiese', 'A', 2, 8, 3),
    ('ZIEHEN', 'zerren', 'A', 3, 1, 6),
    ('UNS', 'Akk./Dat. von wir', 'A', 3, 8, 3),
    ('PEST', 'Seuche', 'A', 4, 7, 4),
    ('ZELLE', 'Kammer', 'A', 5, 1, 5),
    ('ORTE', 'Plätze', 'A', 5, 7, 4),
    ('OBIGE', 'erwähnte', 'A', 6, 3, 5),
    ('ECK', 'Winkel', 'A', 7, 1, 3),
    ('DESTO', 'umso', 'A', 7, 5, 5),
    ('CHAT', 'Plauderei', 'A', 8, 1, 4),
    ('HIESS', 'nannte sich', 'A', 8, 6, 5),
    ('KILO', '1000 Gramm', 'A', 9, 1, 4),
    ('SEILE', 'Taue', 'A', 9, 6, 5),
    ('SPERRT', 'blockiert', 'A', 10, 1, 6),
    ('LOT', 'Senkrechte', 'A', 10, 8, 3),
    ('ERZ', 'Bodenschatz', 'D', 1, 1, 3),
    ('ZWECKS', 'für', 'D', 5, 1, 6),
    ('DEINE', 'Possessiv (du)', 'D', 1, 2, 5),
    ('CHIP', 'Halbleiter', 'D', 7, 2, 4),
    ('EHE', 'Bund fürs Leben', 'D', 1, 3, 3),
    ('LOKALE', 'örtliche', 'D', 5, 3, 6),
    ('HALB', 'zur Hälfte', 'D', 3, 4, 4),
    ('TOR', 'Dummkopf', 'D', 8, 4, 3),
    ('EID', 'Gelöbnis', 'D', 5, 5, 3),
    ('BIN', 'Verbform', 'D', 1, 6, 3),
    ('GEHST', 'läufst', 'D', 6, 6, 5),
    ('POESIE', 'Dichtkunst', 'D', 4, 7, 6),
    ('RAUER', 'grober', 'D', 1, 8, 5),
    ('TEIL', 'Fragment', 'D', 7, 8, 4),
    ('GUNST', 'Wohlwollen', 'D', 1, 9, 5),
    ('OSLO', 'Friedenspreis-Stadt', 'D', 7, 9, 4),
    ('TESTET', 'prüft', 'D', 1, 10, 6),
    ('SET', 'Ausstattung', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r015-11x11-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r015-11x11-02', 'Rätsel 15 · 11×11', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '11x11-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ASS', 'speiste', 'A', 1, 1, 3),
    ('SCHULE', 'Penne', 'A', 1, 5, 6),
    ('UTAH', 'Mormonenstaat', 'A', 2, 1, 4),
    ('HINAB', 'hinunter', 'A', 2, 6, 5),
    ('TAG', '24 Stunden', 'A', 3, 1, 3),
    ('EINIGE', 'diverse', 'A', 3, 5, 6),
    ('ORT', 'Stelle', 'A', 4, 1, 3),
    ('PAAR', 'einige', 'A', 5, 4, 4),
    ('UEBER', 'Präposition', 'A', 6, 1, 5),
    ('EHRE', 'Würde', 'A', 6, 7, 4),
    ('ARMENIEN', 'Land am Ararat', 'A', 7, 3, 8),
    ('BAU', 'Gebäude', 'A', 8, 1, 3),
    ('ERNEUT', 'wieder', 'A', 8, 5, 6),
    ('AUCH', 'ebenso', 'A', 9, 1, 4),
    ('BESTE', 'optimale', 'A', 9, 6, 5),
    ('REH', 'Waldbewohner', 'A', 10, 1, 3),
    ('VERSEN', 'Reimen', 'A', 10, 5, 6),
    ('AUTO', 'Wagen', 'D', 1, 1, 4),
    ('BAR', 'Theke', 'D', 8, 1, 3),
    ('STARKE', 'kräftige', 'D', 1, 2, 6),
    ('AUE', 'Wiesenland', 'D', 8, 2, 3),
    ('SAGT', 'äußert', 'D', 1, 3, 4),
    ('BAUCH', 'Wanst', 'D', 6, 3, 5),
    ('PER', 'via', 'D', 5, 4, 3),
    ('ARME', 'Mittellose', 'D', 5, 5, 4),
    ('CHINA', 'Reich der Mitte', 'D', 1, 6, 5),
    ('ERBE', 'Nachlass', 'D', 7, 6, 4),
    ('HIN', 'fort', 'D', 1, 7, 3),
    ('RENNER', 'Bestseller', 'D', 5, 7, 6),
    ('UNIS', 'Hochschulen', 'D', 1, 8, 4),
    ('HIESS', 'nannte sich', 'D', 6, 8, 5),
    ('LAG', 'befand sich', 'D', 1, 9, 3),
    ('FREUTE', 'beglückte', 'D', 5, 9, 6),
    ('EBEN', 'just', 'D', 1, 10, 4),
    ('ENTEN', 'Wasservögel', 'D', 6, 10, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r016-11x11-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r016-11x11-03', 'Rätsel 16 · 11×11', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '11x11-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('EDEL', 'wertvoll', 'A', 1, 1, 4),
    ('AKKU', 'Batterie', 'A', 1, 7, 4),
    ('NAH', 'unweit', 'A', 2, 1, 3),
    ('PILLEN', 'Tabletten', 'A', 2, 5, 6),
    ('DREH', 'Kniff', 'A', 3, 1, 4),
    ('STARS', 'Prominente', 'A', 3, 6, 5),
    ('ESSENZ', 'Kern', 'A', 4, 4, 6),
    ('SKRIPT', 'Drehbuch', 'A', 5, 1, 6),
    ('GEN', 'nach', 'A', 5, 8, 3),
    ('AULA', 'Versammlungssaal', 'A', 6, 2, 4),
    ('SEE', 'Weiher', 'A', 7, 1, 3),
    ('LOT', 'Senkblei', 'A', 7, 5, 3),
    ('HUB', 'Hebung', 'A', 8, 1, 3),
    ('TRIBUT', 'Abgabe', 'A', 8, 5, 6),
    ('OFEN', 'Wärmequelle', 'A', 9, 1, 4),
    ('TEUFE', 'Tiefe (Bergbau)', 'A', 9, 6, 5),
    ('WER', 'Fragewort (Person)', 'A', 10, 1, 3),
    ('ERBTE', 'übernahm', 'A', 10, 6, 5),
    ('ENDES', 'letzten ...', 'D', 1, 1, 5),
    ('SHOW', 'Vorstellung', 'D', 7, 1, 4),
    ('DAR', 'Verbvorsilbe', 'D', 1, 2, 3),
    ('KAEUFE', 'Erwerbe', 'D', 5, 2, 6),
    ('EHE', 'Bund fürs Leben', 'D', 1, 3, 3),
    ('RUEBER', 'hinüber', 'D', 5, 3, 6),
    ('HEIL', 'Wohl', 'D', 3, 4, 4),
    ('SPALT', 'Ritze', 'D', 4, 5, 5),
    ('ISST', 'verzehrt', 'D', 2, 6, 4),
    ('ORTE', 'Stellen', 'D', 7, 6, 4),
    ('ALTE', 'betagte', 'D', 1, 7, 4),
    ('STIER', 'Sternzeichen', 'D', 6, 7, 5),
    ('KLANG', 'Ton', 'D', 1, 8, 5),
    ('BUB', 'Junge', 'D', 8, 8, 3),
    ('KERZE', 'Licht', 'D', 1, 9, 5),
    ('RUFT', 'schreit', 'D', 7, 9, 4),
    ('UNS', 'Akk./Dat. von wir', 'D', 1, 10, 3),
    ('TEE', 'Heißgetränk', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r017-12x12-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r017-12x12-01', 'Rätsel 17 · 12×12', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '12x12-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ASS', 'verspeiste', 'A', 1, 1, 3),
    ('HASS', 'Abscheu', 'A', 1, 8, 4),
    ('BEAMTE', 'Staatsdiener', 'A', 2, 1, 6),
    ('ORTE', 'Stellen', 'A', 2, 8, 4),
    ('REH', 'Waldbewohner', 'A', 3, 1, 3),
    ('VERMAG', 'kann', 'A', 3, 6, 6),
    ('INNERE', 'inwendige', 'A', 4, 6, 6),
    ('FUSSWEG', 'Gehweg', 'A', 5, 1, 7),
    ('NATUR', 'Umwelt', 'A', 6, 2, 5),
    ('EINER', 'unbest. Art. (w.)', 'A', 7, 1, 5),
    ('GRUEN', 'unreif', 'A', 7, 7, 5),
    ('INS', 'in das', 'A', 8, 3, 3),
    ('HEFTE', 'Broschüren', 'A', 8, 7, 5),
    ('EHE', 'Vermählung', 'A', 9, 1, 3),
    ('TRAUERT', 'klagt', 'A', 9, 5, 7),
    ('NERV', 'Reizleiter', 'A', 10, 1, 4),
    ('ANTRAT', 'begann', 'A', 10, 6, 6),
    ('TUT', 'macht', 'A', 11, 1, 3),
    ('RAENGE', 'Tribünen', 'A', 11, 6, 6),
    ('ABRUF', 'Anforderung', 'D', 1, 1, 5),
    ('EVENT', 'Ereignis', 'D', 7, 1, 5),
    ('SEE', 'Weiher', 'D', 1, 2, 3),
    ('UNI', 'Hochschule', 'D', 5, 2, 3),
    ('HEU', 'Trockengras', 'D', 9, 2, 3),
    ('SAH', 'blickte', 'D', 1, 3, 3),
    ('SANIERT', 'renoviert', 'D', 5, 3, 7),
    ('OSTEN', 'Richtung O', 'D', 4, 4, 5),
    ('WURST', 'Aufschnitt', 'D', 5, 5, 5),
    ('REVIER', 'Bezirk', 'D', 1, 6, 6),
    ('RAR', 'selten', 'D', 9, 6, 3),
    ('ENG', 'knapp', 'D', 3, 7, 3),
    ('GHANA', 'Staat in Westafrika', 'D', 7, 7, 5),
    ('HORN', 'Hupe', 'D', 1, 8, 4),
    ('FREUTE', 'beglückte', 'D', 6, 8, 6),
    ('ARMEE', 'Heer', 'D', 1, 9, 5),
    ('UFERN', 'Gestaden', 'D', 7, 9, 5),
    ('STAR', 'Berühmtheit', 'D', 1, 10, 4),
    ('BETRAG', 'Summe', 'D', 6, 10, 6),
    ('SEGEL', 'Tuch am Mast', 'D', 1, 11, 5),
    ('NETTE', 'freundliche', 'D', 7, 11, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r018-12x12-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r018-12x12-02', 'Rätsel 18 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ERST', 'anfangs', 'A', 1, 1, 4),
    ('OEDE', 'langweilig', 'A', 1, 8, 4),
    ('VITA', 'Lebenslauf', 'A', 2, 1, 4),
    ('OBEREN', 'höher gelegenen', 'A', 2, 6, 6),
    ('ETAGEN', 'Stockwerke', 'A', 3, 1, 6),
    ('LOBT', 'preist', 'A', 3, 8, 4),
    ('NUR', 'lediglich', 'A', 4, 1, 3),
    ('TUE', 'mache', 'A', 4, 9, 3),
    ('TAKT', 'Rhythmus', 'A', 5, 1, 4),
    ('REGIE', 'Spielleitung', 'A', 5, 6, 5),
    ('LEUTE', 'Personen', 'A', 6, 2, 5),
    ('AKTE', 'Vorgang', 'A', 6, 8, 4),
    ('WERTET', 'beurteilt', 'A', 7, 1, 6),
    ('ERZ', 'Gestein', 'A', 8, 7, 3),
    ('GASE', 'Dämpfe', 'A', 9, 1, 4),
    ('TABU', 'verboten', 'A', 9, 8, 4),
    ('EBENSO', 'gleichfalls', 'A', 10, 1, 6),
    ('EHEN', 'Bündnisse', 'A', 10, 8, 4),
    ('STEG', 'Bootsanleger', 'A', 11, 1, 4),
    ('SONNIG', 'heiter', 'A', 11, 6, 6),
    ('EVENT', 'Ereignis', 'D', 1, 1, 5),
    ('WEGES', 'Rand des ...', 'D', 7, 1, 5),
    ('RITUALE', 'Zeremonien', 'D', 1, 2, 7),
    ('ABT', 'Ordensoberer', 'D', 9, 2, 3),
    ('STARKER', 'kräftiger', 'D', 1, 3, 7),
    ('SEE', 'Weiher', 'D', 9, 3, 3),
    ('TAG', 'Kalenderblatt', 'D', 1, 4, 3),
    ('TUT', 'verrichtet', 'D', 5, 4, 3),
    ('ENG', 'knapp', 'D', 9, 4, 3),
    ('TEE', 'Heißgetränk', 'D', 6, 5, 3),
    ('KONKRET', 'greifbar', 'D', 1, 6, 7),
    ('LOS', 'frei', 'D', 9, 6, 3),
    ('OEL', 'Schmierstoff', 'D', 1, 8, 3),
    ('GAERTEN', 'Grünflächen', 'D', 5, 8, 7),
    ('EROTIK', 'Sinnlichkeit', 'D', 1, 9, 6),
    ('ZAHN', 'Beißer', 'D', 8, 9, 4),
    ('DEBUET', 'Erstauftritt', 'D', 1, 10, 6),
    ('BEI', 'nahe an', 'D', 9, 10, 3),
    ('ENTE', 'Falschmeldung', 'D', 1, 11, 4),
    ('ENDUNG', 'Suffix', 'D', 6, 11, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r019-12x12-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r019-12x12-03', 'Rätsel 19 · 12×12', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '12x12-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('TABAK', 'Rauchkraut', 'A', 1, 1, 5),
    ('VORNE', 'an der Spitze', 'A', 1, 7, 5),
    ('ANALOGE', 'ähnliche', 'A', 2, 1, 7),
    ('OEL', 'Schmierstoff', 'A', 2, 9, 3),
    ('GRUBE', 'Mine', 'A', 3, 1, 5),
    ('MUT', 'Tapferkeit', 'A', 3, 9, 3),
    ('SEE', 'Weiher', 'A', 4, 1, 3),
    ('LESE', 'studiere', 'A', 4, 5, 4),
    ('NIE', 'zu keiner Zeit', 'A', 5, 5, 3),
    ('KUR', 'Heilaufenthalt', 'A', 5, 9, 3),
    ('LEER', 'vakant', 'A', 6, 1, 4),
    ('PERSER', 'Iraner', 'A', 7, 5, 6),
    ('BAT', 'flehte', 'A', 8, 1, 3),
    ('EROSION', 'Abtragung', 'A', 8, 5, 7),
    ('EURER', 'Possessiv (ihr)', 'A', 9, 1, 5),
    ('HELME', 'Kopfschutz', 'A', 9, 7, 5),
    ('TRAILER', 'Vorschau', 'A', 10, 1, 7),
    ('TAT', 'Werk', 'A', 10, 9, 3),
    ('TASSE', 'Becher', 'A', 11, 1, 5),
    ('CENT', 'Hundertstel Euro', 'A', 11, 8, 4),
    ('TAGS', '... darauf', 'D', 1, 1, 4),
    ('BETT', 'Schlafstätte', 'D', 8, 1, 4),
    ('ANREDE', 'Begrüßung', 'D', 1, 2, 6),
    ('AURA', 'Ausstrahlung', 'D', 8, 2, 4),
    ('BAUE', 'errichte', 'D', 1, 3, 4),
    ('EXTRAS', 'Zusätze', 'D', 6, 3, 6),
    ('ALB', 'Schwäbische ...', 'D', 1, 4, 3),
    ('EIS', 'Sorbet', 'D', 9, 4, 3),
    ('KOELN', 'Domstadt', 'D', 1, 5, 5),
    ('PERLE', 'Juwel', 'D', 7, 5, 5),
    ('EIFER', 'Emsigkeit', 'D', 4, 6, 5),
    ('VERSE', 'Reime', 'D', 1, 7, 5),
    ('ROHR', 'Leitung', 'D', 7, 7, 4),
    ('ESSE', 'speise', 'D', 6, 8, 4),
    ('ROM', 'Hauptstadt Italiens', 'D', 1, 9, 3),
    ('EILTE', 'hastete', 'D', 7, 9, 5),
    ('NEU', 'aktuell', 'D', 1, 10, 3),
    ('ROMAN', 'Erzählung', 'D', 7, 10, 5),
    ('ELTERN', 'Vater und Mutter', 'D', 1, 11, 6),
    ('NETT', 'freundlich', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r020-12x12-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r020-12x12-04', 'Rätsel 20 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ABSENDER', 'Aufgeber', 'A', 1, 1, 8),
    ('RIESE', 'Hüne', 'A', 2, 1, 5),
    ('RAD', 'Velo', 'A', 2, 7, 3),
    ('GEIST', 'Gespenst', 'A', 3, 1, 5),
    ('ZUEGE', 'Bahnen', 'A', 3, 7, 5),
    ('ENDET', 'hört auf', 'A', 4, 1, 5),
    ('EBEN', 'just', 'A', 4, 8, 4),
    ('NEUERUNG', 'Innovation', 'A', 5, 4, 8),
    ('EIS', 'Sorbet', 'A', 6, 9, 3),
    ('DER', 'Artikel (männl.)', 'A', 7, 2, 3),
    ('ELFTE', 'nach der zehnten', 'A', 7, 6, 5),
    ('GALA', 'Festabend', 'A', 8, 1, 4),
    ('NEU', 'aktuell', 'A', 8, 6, 3),
    ('EROTIK', 'Sinnlichkeit', 'A', 9, 1, 6),
    ('NASE', 'Riechorgan', 'A', 9, 8, 4),
    ('HAB', 'Besitz', 'A', 10, 1, 3),
    ('KUER', 'freies Programm', 'A', 10, 8, 4),
    ('ENTE', 'Wasservogel', 'A', 11, 1, 4),
    ('LIEFEN', 'rannten', 'A', 11, 6, 6),
    ('ARGE', 'schlimme', 'D', 1, 1, 4),
    ('GEHE', 'laufe', 'D', 8, 1, 4),
    ('BIENE', 'Imme', 'D', 1, 2, 5),
    ('DARAN', 'an dem', 'D', 7, 2, 5),
    ('SEID', 'existiert', 'D', 1, 3, 4),
    ('GELOBT', 'gepriesen', 'D', 6, 3, 6),
    ('ESSEN', 'Mahlzeit', 'D', 1, 4, 5),
    ('RAT', 'Tipp', 'D', 7, 4, 3),
    ('NETTES', 'freundliches', 'D', 1, 5, 6),
    ('ENKEL', 'Kindeskind', 'D', 7, 6, 5),
    ('ERZ', 'Gestein', 'D', 1, 7, 3),
    ('EILE', 'Hektik', 'D', 5, 7, 4),
    ('RAUER', 'grober', 'D', 1, 8, 5),
    ('FUNKE', 'Glimmen', 'D', 7, 8, 5),
    ('DEBUET', 'Erstauftritt', 'D', 2, 9, 6),
    ('AUF', 'offen', 'D', 9, 9, 3),
    ('GENIE', 'Talent', 'D', 3, 10, 5),
    ('SEE', 'Gewässer', 'D', 9, 10, 3),
    ('LAENGS', 'entlang', 'D', 1, 11, 6),
    ('BERN', 'Schweizer Hauptstadt', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r021-13x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r021-13x13-01', 'Rätsel 21 · 13×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '13x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('APP', 'Anwendung', 'A', 1, 1, 3),
    ('BAT', 'ersuchte', 'A', 1, 5, 3),
    ('ARIE', 'Opernlied', 'A', 1, 9, 4),
    ('RAUS', 'hinweg', 'A', 2, 1, 4),
    ('KEHLE', 'Gurgel', 'A', 2, 6, 5),
    ('GEBIETS', 'Grenze des ...', 'A', 3, 1, 7),
    ('BLOG', 'Webjournal', 'A', 3, 9, 4),
    ('ELITE', 'Auslese', 'A', 4, 4, 5),
    ('EHE', 'Vermählung', 'A', 5, 1, 3),
    ('BEENDETE', 'schloss ab', 'A', 5, 5, 8),
    ('STILE', 'Machart', 'A', 6, 1, 5),
    ('TORF', 'Moorboden', 'A', 6, 7, 4),
    ('SEE', 'Gewässer', 'A', 7, 1, 3),
    ('RASEN', 'Grünfläche', 'A', 7, 8, 5),
    ('IRRT', 'liegt falsch', 'A', 8, 1, 4),
    ('LAMM', 'Schäfchen', 'A', 8, 6, 4),
    ('AUGE', 'Sehorgan', 'A', 9, 9, 4),
    ('RUESSEL', 'Tiernase', 'A', 10, 2, 7),
    ('REH', 'Waldbewohner', 'A', 10, 10, 3),
    ('WAHRES', 'echtes', 'A', 11, 1, 6),
    ('IHR', 'Pronomen (2. Pl.)', 'A', 11, 10, 3),
    ('TRETE', 'kicke', 'A', 12, 2, 5),
    ('BUNTE', 'farbige', 'A', 12, 8, 5),
    ('ARG', 'übel', 'D', 1, 1, 3),
    ('ESSIG', 'Würzmittel', 'D', 5, 1, 5),
    ('PAECHTER', 'Mieter', 'D', 1, 2, 8),
    ('RAT', 'Gremium', 'D', 10, 2, 3),
    ('PUB', 'Wirtshaus', 'D', 1, 3, 3),
    ('EIER', 'Gelege', 'D', 5, 3, 4),
    ('UHR', 'Zeitmesser', 'D', 10, 3, 3),
    ('SIE', 'Anrede', 'D', 2, 4, 3),
    ('TUERE', 'Pforte', 'D', 8, 4, 5),
    ('ELBE', 'Strom durch Dresden', 'D', 3, 5, 4),
    ('SET', 'Satz', 'D', 10, 5, 3),
    ('AKTIE', 'Wertpapier', 'D', 1, 6, 5),
    ('BLOSSE', 'reine', 'D', 7, 6, 6),
    ('TESTET', 'prüft', 'D', 1, 7, 6),
    ('ENORM', 'gewaltig', 'D', 4, 8, 5),
    ('LOB', 'Kompliment', 'D', 10, 8, 3),
    ('ALB', 'Schwäbische ...', 'D', 1, 9, 3),
    ('DRAMA', 'Schauspiel', 'D', 5, 9, 5),
    ('RELIEFS', 'Flachbilder', 'D', 1, 10, 7),
    ('URIN', 'Harn', 'D', 9, 10, 4),
    ('ERGEHT', 'widerfährt', 'D', 7, 11, 6),
    ('ENG', 'knapp', 'D', 1, 12, 3),
    ('EIN', 'unbest. Artikel', 'D', 5, 12, 3),
    ('EHRE', 'Würde', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r022-13x13-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r022-13x13-02', 'Rätsel 22 · 13×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '13x13-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ERSTMALS', 'initial', 'A', 1, 1, 8),
    ('WEH', 'wund', 'A', 1, 10, 3),
    ('TRAGE', 'schleppe', 'A', 2, 3, 5),
    ('VITA', 'Lebenslauf', 'A', 2, 9, 4),
    ('RELIEF', 'Flachbild', 'A', 3, 3, 6),
    ('LAG', 'befand sich', 'A', 3, 10, 3),
    ('SEES', 'Fläche des ...', 'A', 4, 1, 4),
    ('EREILTE', 'traf', 'A', 4, 6, 7),
    ('OHIO', 'Buckeye-Staat', 'A', 5, 1, 4),
    ('REIN', 'sauber', 'A', 5, 6, 4),
    ('DEKRET', 'Erlass', 'A', 6, 1, 6),
    ('ENG', 'knapp', 'A', 6, 8, 3),
    ('BREITE', 'Weite', 'A', 7, 7, 6),
    ('BEAT', 'Rhythmus', 'A', 8, 3, 4),
    ('FLAMMEN', 'Feuer', 'A', 9, 1, 7),
    ('PAPA', 'Vater', 'A', 9, 9, 4),
    ('RAUPEN', 'Larven', 'A', 10, 1, 6),
    ('TIROL', 'Alpenland', 'A', 10, 8, 5),
    ('AUTONOM', 'unabhängig', 'A', 11, 1, 7),
    ('ERST', 'anfangs', 'A', 11, 9, 4),
    ('UFER', 'Gestade', 'A', 12, 1, 4),
    ('TRETE', 'kicke', 'A', 12, 8, 5),
    ('EPISODE', 'Folge', 'D', 1, 1, 7),
    ('FRAU', 'Dame', 'D', 9, 1, 4),
    ('EHE', 'Vermählung', 'D', 4, 2, 3),
    ('LAUF', 'Rennen', 'D', 9, 2, 4),
    ('STREIK', 'Ausstand', 'D', 1, 3, 6),
    ('BAUTE', 'errichtete', 'D', 8, 3, 5),
    ('TRESOR', 'Safe', 'D', 1, 4, 6),
    ('EMPOR', 'hinauf', 'D', 8, 4, 5),
    ('MAL', 'einst', 'D', 1, 5, 3),
    ('EXAMEN', 'Prüfung', 'D', 6, 5, 6),
    ('AGIERT', 'handelt', 'D', 1, 6, 6),
    ('TENOR', 'Sängerstimme', 'D', 8, 6, 5),
    ('LEERE', 'Öde', 'D', 1, 7, 5),
    ('FEIERT', 'zelebriert', 'D', 3, 8, 6),
    ('INNE', 'Verbpartikel', 'D', 4, 9, 4),
    ('PIER', 'Anleger', 'D', 9, 9, 4),
    ('WILL', 'Verbform', 'D', 1, 10, 4),
    ('GITARRE', 'Klampfe', 'D', 6, 10, 7),
    ('ETAT', 'Finanzplan', 'D', 1, 11, 4),
    ('POST', 'Briefe', 'D', 9, 11, 4),
    ('HAGELTE', 'prasselte', 'D', 1, 12, 7),
    ('ALTE', 'greise', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r023-13x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r023-13x13-03', 'Rätsel 23 · 13×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '13x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('OPER', 'Musiktheater', 'A', 1, 1, 4),
    ('BOT', 'offerierte', 'A', 1, 6, 3),
    ('SAH', 'erblickte', 'A', 1, 10, 3),
    ('MIR', 'Dat. (1. Pers.)', 'A', 2, 1, 3),
    ('GEMUET', 'Gefühlsleben', 'A', 2, 5, 6),
    ('ANHOEREN', 'lauschen', 'A', 3, 1, 8),
    ('ARM', 'Extremität', 'A', 3, 10, 3),
    ('KAPLAN', 'Vikar', 'A', 4, 2, 6),
    ('TEAM', 'Mannschaft', 'A', 4, 9, 4),
    ('LADE', 'packe auf', 'A', 5, 3, 4),
    ('TUE', 'mache', 'A', 5, 10, 3),
    ('ABT', 'Ordensoberer', 'A', 6, 1, 3),
    ('THEATER', 'Bühne', 'A', 6, 6, 7),
    ('NAEHE', 'Umgebung', 'A', 7, 1, 5),
    ('IRREN', 'sich täuschen', 'A', 7, 7, 5),
    ('AUTO', 'Wagen', 'A', 8, 1, 4),
    ('BERG', 'Anhöhe', 'A', 8, 6, 4),
    ('SAEURE', 'Gegenteil von Base', 'A', 9, 7, 6),
    ('ENGE', 'schmale', 'A', 10, 1, 4),
    ('FIT', 'sportlich', 'A', 10, 6, 3),
    ('FIX', 'schnell', 'A', 10, 10, 3),
    ('REALE', 'echte', 'A', 11, 1, 5),
    ('GEHEGE', 'Käfig', 'A', 11, 7, 6),
    ('NUSS', 'Kern', 'A', 12, 1, 4),
    ('YEN', 'Währung Japans', 'A', 12, 6, 3),
    ('RAN', 'hinzu', 'A', 12, 10, 3),
    ('OMA', 'Großmutter', 'D', 1, 1, 3),
    ('MANAGERN', 'Chefs', 'D', 5, 1, 8),
    ('PINK', 'Rosa', 'D', 1, 2, 4),
    ('BAU', 'Konstruktion', 'D', 6, 2, 3),
    ('NEU', 'frisch', 'D', 10, 2, 3),
    ('ERHALTET', 'bekommt', 'D', 1, 3, 8),
    ('GAS', 'Treibstoff', 'D', 10, 3, 3),
    ('OPA', 'Opi', 'D', 3, 4, 3),
    ('HOTELS', 'Herbergen', 'D', 7, 4, 6),
    ('GELD', 'Moneten', 'D', 2, 5, 4),
    ('BERAET', 'hilft', 'D', 1, 6, 6),
    ('OMEN', 'Vorzeichen', 'D', 1, 7, 4),
    ('HIESIGE', 'örtliche', 'D', 6, 7, 7),
    ('TUN', 'machen', 'D', 1, 8, 3),
    ('VERRATEN', 'verpfeifen', 'D', 5, 8, 8),
    ('ARGE', 'schlimme', 'D', 6, 9, 4),
    ('STAETTE', 'Ort', 'D', 1, 10, 7),
    ('UFER', 'Gestade', 'D', 9, 10, 4),
    ('RAUEN', 'groben', 'D', 3, 11, 5),
    ('RIGA', 'lett. Hauptstadt', 'D', 9, 11, 4),
    ('HAMMER', 'Werkzeug', 'D', 1, 12, 6),
    ('HEXEN', 'Zauberinnen', 'D', 8, 12, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r024-15x15-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r024-15x15-01', 'Rätsel 24 · 15×15', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '15x15-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('SOLO', 'allein', 'A', 1, 1, 4),
    ('HAB', '... und Gut', 'A', 1, 6, 3),
    ('MESSE', 'Gottesdienst', 'A', 1, 10, 5),
    ('PRAEGEN', 'formen', 'A', 2, 1, 7),
    ('LIMA', 'peruan. Hauptstadt', 'A', 2, 9, 4),
    ('ADEL', 'blaues Blut', 'A', 3, 1, 4),
    ('IST', 'befindet sich', 'A', 3, 6, 3),
    ('NARBE', 'Wundmal', 'A', 3, 10, 5),
    ('GEHEIM', 'verborgen', 'A', 4, 1, 6),
    ('EIGEN', 'seltsam', 'A', 4, 10, 5),
    ('ARM', 'Extremität', 'A', 5, 1, 3),
    ('NETTO', 'ohne Steuern', 'A', 5, 5, 5),
    ('HOB', 'stemmte', 'A', 6, 12, 3),
    ('INTIME', 'vertraute', 'A', 7, 2, 6),
    ('GARAGE', 'Wagenhalle', 'A', 7, 9, 6),
    ('ARG', 'übel', 'A', 8, 1, 3),
    ('ZAUBEREI', 'Magie', 'A', 8, 5, 8),
    ('WEG', 'Route', 'A', 9, 4, 3),
    ('NAH', 'dicht', 'A', 9, 9, 3),
    ('STAUS', 'Blechlawinen', 'A', 10, 1, 5),
    ('FORT', 'weg', 'A', 10, 7, 4),
    ('PURE', 'reine', 'A', 11, 1, 4),
    ('LESE', 'schmökere', 'A', 11, 6, 4),
    ('WADE', 'Beinmuskel', 'A', 11, 11, 4),
    ('AMTSZEIT', 'Legislatur', 'A', 12, 1, 8),
    ('GEBET', 'Andacht', 'A', 12, 10, 5),
    ('TOENE', 'Klänge', 'A', 13, 4, 5),
    ('AROMA', 'Geschmack', 'A', 13, 10, 5),
    ('TOT', 'verstorben', 'A', 14, 1, 3),
    ('ORDNER', 'Mappe', 'A', 14, 5, 6),
    ('ROT', 'knallig', 'A', 14, 12, 3),
    ('SPAGAT', 'Balanceakt', 'D', 1, 1, 6),
    ('SPAET', 'nicht früh', 'D', 10, 1, 5),
    ('ORDER', 'Auftrag', 'D', 1, 2, 5),
    ('IRRTUM', 'Fehler', 'D', 7, 2, 6),
    ('LAEHMUNG', 'Stillstand', 'D', 1, 3, 8),
    ('ART', 'Sorte', 'D', 10, 3, 3),
    ('OELE', 'Fette', 'D', 1, 4, 4),
    ('WUEST', 'öde', 'D', 9, 4, 5),
    ('INDIZES', 'Kennzahlen', 'D', 4, 5, 7),
    ('ZOO', 'Tiergarten', 'D', 12, 5, 3),
    ('HEIME', 'Anstalten', 'D', 1, 6, 5),
    ('MAG', 'hat gern', 'D', 7, 6, 3),
    ('LEER', 'vakant', 'D', 11, 6, 4),
    ('ANS', 'an das', 'D', 1, 7, 3),
    ('TREU', 'loyal', 'D', 5, 7, 4),
    ('FEIND', 'Gegner', 'D', 10, 7, 5),
    ('TUT', 'macht', 'D', 3, 8, 3),
    ('OSTEN', 'Richtung O', 'D', 10, 8, 5),
    ('GENRE', 'Gattung', 'D', 7, 9, 5),
    ('MINE', 'Bergwerk', 'D', 1, 10, 4),
    ('PARAT', 'bereit', 'D', 6, 10, 5),
    ('GAR', 'durchgekocht', 'D', 12, 10, 3),
    ('EMAIL', 'digitale Post', 'D', 1, 11, 5),
    ('REH', 'Waldtier', 'D', 7, 11, 3),
    ('WER', 'Fragewort (Person)', 'D', 11, 11, 3),
    ('SARG', 'Totenschrein', 'D', 1, 12, 4),
    ('HAI', 'Raubfisch', 'D', 6, 12, 3),
    ('LABOR', 'Versuchsraum', 'D', 10, 12, 5),
    ('BEZOG', 'erhielt', 'D', 3, 13, 5),
    ('DEMO', 'Kundgebung', 'D', 11, 13, 4),
    ('EHEN', 'Bündnisse', 'D', 1, 14, 4),
    ('BEIN', 'Stelze', 'D', 6, 14, 4),
    ('ETAT', 'Finanzplan', 'D', 11, 14, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r025-15x15-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r025-15x15-02', 'Rätsel 25 · 15×15', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '15x15-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('OBERE', 'höhere', 'A', 1, 1, 5),
    ('STAAT', 'Nation', 'A', 1, 10, 5),
    ('PUR', 'rein', 'A', 2, 1, 3),
    ('RIGA', 'lett. Hauptstadt', 'A', 2, 5, 4),
    ('PORTO', 'Postgebühr', 'A', 2, 10, 5),
    ('ESSEN', 'Mahlzeit', 'A', 3, 1, 5),
    ('INMITTEN', 'zwischen', 'A', 3, 7, 8),
    ('TITELS', 'Gewinn des ...', 'A', 4, 3, 6),
    ('LEID', 'Weh', 'A', 5, 4, 4),
    ('PLAN', 'Absicht', 'A', 5, 9, 4),
    ('SEHT', 'schaut', 'A', 6, 1, 4),
    ('NEU', 'aktuell', 'A', 6, 6, 3),
    ('SAGE', 'Legende', 'A', 6, 11, 4),
    ('TEE', 'Heißgetränk', 'A', 7, 1, 3),
    ('SCHAM', 'Peinlichkeit', 'A', 7, 10, 5),
    ('ALL', 'Weltraum', 'A', 8, 1, 3),
    ('STAND', 'stockte', 'A', 8, 5, 5),
    ('HEU', 'Trockengras', 'A', 8, 11, 3),
    ('HEMMT', 'bremst', 'A', 9, 1, 5),
    ('ERDE', 'Heimatplanet', 'A', 9, 8, 4),
    ('AURA', 'Ausstrahlung', 'A', 10, 4, 4),
    ('KAM', 'traf ein', 'A', 10, 12, 3),
    ('PANDEMIE', 'Seuche', 'A', 11, 2, 8),
    ('FARM', 'Bauernhof', 'A', 11, 11, 4),
    ('WEH', 'schmerzhaft', 'A', 12, 1, 3),
    ('IST', 'befindet sich', 'A', 12, 5, 3),
    ('ARME', 'Bedürftige', 'A', 12, 11, 4),
    ('ERNEUTE', 'wiederholte', 'A', 13, 1, 7),
    ('KOSTEN', 'Ausgaben', 'A', 13, 9, 6),
    ('GUT', 'brauchbar', 'A', 14, 1, 3),
    ('SET', 'Ausstattung', 'A', 14, 7, 3),
    ('SEES', 'Fläche des ...', 'A', 14, 11, 4),
    ('OPER', 'Musiktheater', 'D', 1, 1, 4),
    ('STAHL', 'legiertes Eisen', 'D', 6, 1, 5),
    ('WEG', 'Route', 'D', 12, 1, 3),
    ('BUS', 'Nahverkehrsmittel', 'D', 1, 2, 3),
    ('SEELE', 'Psyche', 'D', 5, 2, 5),
    ('PERU', 'Machu-Picchu-Land', 'D', 11, 2, 4),
    ('ERST', 'anfangs', 'D', 1, 3, 4),
    ('HELM', 'Kopfschutz', 'D', 6, 3, 4),
    ('AHNT', 'vermutet', 'D', 11, 3, 4),
    ('EILT', 'hastet', 'D', 3, 4, 4),
    ('MAN', 'jemand', 'D', 9, 4, 3),
    ('ERNTE', 'Lese', 'D', 1, 5, 5),
    ('STUDIUM', 'Hochschulzeit', 'D', 8, 5, 7),
    ('EINST', 'früher', 'D', 4, 6, 5),
    ('REST', 'Überbleibsel', 'D', 10, 6, 4),
    ('GILDE', 'Zunft', 'D', 2, 7, 5),
    ('AMTES', 'Ende des ...', 'D', 10, 7, 5),
    ('FANS', 'Anhänger', 'D', 1, 8, 4),
    ('URNE', 'Wahlbehälter', 'D', 6, 8, 4),
    ('DRUECKT', 'presst', 'D', 8, 9, 7),
    ('SPIEL', 'Partie', 'D', 1, 10, 5),
    ('TOT', 'leblos', 'D', 1, 11, 3),
    ('ASCHE', 'Glutrest', 'D', 5, 11, 5),
    ('FASS', 'Tonne', 'D', 11, 11, 4),
    ('ART', 'Spezies', 'D', 1, 12, 3),
    ('NAHE', 'benachbart', 'D', 5, 12, 4),
    ('KARTE', 'Ticket', 'D', 10, 12, 5),
    ('ATEM', 'Luft', 'D', 1, 13, 4),
    ('GAU', 'Landstrich', 'D', 6, 13, 3),
    ('ARMEE', 'Heer', 'D', 10, 13, 5),
    ('TON', 'Lehm', 'D', 1, 14, 3),
    ('WEM', 'Fragewort (Dativ)', 'D', 5, 14, 3),
    ('IMMENS', 'riesig', 'D', 9, 14, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r026-15x15-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r026-15x15-03', 'Rätsel 26 · 15×15', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '15x15-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('LIEGT', 'ruht', 'A', 1, 1, 5),
    ('GOETTERN', 'Himmlischen', 'A', 1, 7, 8),
    ('ERBE', 'Thronfolger', 'A', 2, 1, 4),
    ('DIES', 'das hier', 'A', 2, 6, 4),
    ('IREN', 'Gälen', 'A', 3, 1, 4),
    ('ALLE', 'sämtliche', 'A', 3, 6, 4),
    ('GRAT', 'Kamm', 'A', 3, 11, 4),
    ('BENANNT', 'getauft', 'A', 4, 1, 7),
    ('ALT', 'betagt', 'A', 4, 12, 3),
    ('LEGE', 'platziere', 'A', 5, 11, 4),
    ('OBEN', 'in der Höhe', 'A', 6, 1, 4),
    ('BOX', 'Schachtel', 'A', 6, 6, 3),
    ('METER', 'Basiseinheit der Länge', 'A', 6, 10, 5),
    ('HALTBAR', 'beständig', 'A', 7, 1, 7),
    ('GABEN', 'reichten', 'A', 7, 9, 5),
    ('RUF', 'Leumund', 'A', 8, 1, 3),
    ('ERTOENT', 'erklingt', 'A', 8, 5, 7),
    ('ERST', 'zunächst', 'A', 9, 11, 4),
    ('SEKTE', 'Kult', 'A', 10, 1, 5),
    ('UHR', 'Zeitmesser', 'A', 10, 7, 3),
    ('NOCH', 'bislang', 'A', 10, 11, 4),
    ('PRO', 'je', 'A', 11, 1, 3),
    ('GENIAL', 'brillant', 'A', 11, 5, 6),
    ('EHE', 'Vermählung', 'A', 11, 12, 3),
    ('ARMEN', 'Mittellosen', 'A', 12, 1, 5),
    ('TEE', 'Heißgetränk', 'A', 12, 7, 3),
    ('OMEN', 'Vorzeichen', 'A', 12, 11, 4),
    ('MIETERN', 'Bewohnern', 'A', 13, 3, 7),
    ('PER', 'mittels', 'A', 13, 11, 3),
    ('SOEST', 'Stadt in Westfalen', 'A', 14, 1, 5),
    ('KLARER', 'deutlicher', 'A', 14, 9, 6),
    ('LEIB', 'Körper', 'D', 1, 1, 4),
    ('OHR', 'Hörorgan', 'D', 6, 1, 3),
    ('SPASS', 'Vergnügen', 'D', 10, 1, 5),
    ('IRRE', 'Verrückte', 'D', 1, 2, 4),
    ('BAUHERR', 'Auftraggeber', 'D', 6, 2, 7),
    ('EBEN', 'just', 'D', 1, 3, 4),
    ('ELF', 'Zahl (10+1)', 'D', 6, 3, 3),
    ('KOMME', 'ich ... an', 'D', 10, 3, 5),
    ('GENANNT', 'erwähnt', 'D', 1, 4, 7),
    ('EIS', 'Gefrorenes', 'D', 12, 4, 3),
    ('BEGEGNET', 'getroffen', 'D', 7, 5, 8),
    ('DANKBAR', 'erkenntlich', 'D', 2, 6, 7),
    ('GILT', 'zählt', 'D', 1, 7, 4),
    ('ORT', 'Platz', 'D', 6, 7, 3),
    ('UNTER', 'inmitten', 'D', 10, 7, 5),
    ('OEL', 'Rohstoff', 'D', 1, 8, 3),
    ('HIER', 'an diesem Ort', 'D', 10, 8, 4),
    ('ESEL', 'Dickkopf', 'D', 1, 9, 4),
    ('GETRAENK', 'Trunk', 'D', 7, 9, 8),
    ('MAN', 'Pronomen', 'D', 6, 10, 3),
    ('TAG', 'Kalenderblatt', 'D', 1, 11, 3),
    ('LEBTEN', 'existierten', 'D', 5, 11, 6),
    ('OPA', 'Opi', 'D', 12, 11, 3),
    ('RAETE', 'Ausschüsse', 'D', 3, 12, 5),
    ('ROEMER', 'Latiner', 'D', 9, 12, 6),
    ('ALGEN', 'Tang', 'D', 3, 13, 5),
    ('SCHERE', 'Schneidgerät', 'D', 9, 13, 6),
    ('NETTER', 'freundlicher', 'D', 1, 14, 6),
    ('ATHEN', 'griech. Hauptstadt', 'D', 8, 14, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r027-8x8-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r027-8x8-01', 'Rätsel 27 · 8×8', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '8x8-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AKUT', 'dringend', 'A', 1, 1, 4),
    ('KANADA', 'Ahornland', 'A', 2, 1, 6),
    ('TEILEN', 'zu gleichen ...', 'A', 3, 1, 6),
    ('SAGE', 'Legende', 'A', 4, 4, 4),
    ('SEI', 'existiere', 'A', 5, 1, 3),
    ('LOB', 'Kompliment', 'A', 5, 5, 3),
    ('SAELE', 'Hallen', 'A', 6, 3, 5),
    ('HIT', 'Schlager', 'A', 7, 1, 3),
    ('RAN', 'heran', 'A', 7, 5, 3),
    ('AKT', 'Nacktgemälde', 'D', 1, 1, 3),
    ('SAH', 'erblickte', 'D', 5, 1, 3),
    ('KAESE', 'Milchprodukt', 'D', 1, 2, 5),
    ('UNI', 'Alma Mater', 'D', 1, 3, 3),
    ('IST', 'befindet sich', 'D', 5, 3, 3),
    ('TALS', 'Grund des ...', 'D', 1, 4, 4),
    ('DEALER', 'Händler', 'D', 2, 5, 6),
    ('ANGOLA', 'Staat in Afrika', 'D', 2, 6, 6),
    ('EBEN', 'flach', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r028-8x8-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r028-8x8-02', 'Rätsel 28 · 8×8', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '8x8-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('FAST', 'beinahe', 'A', 1, 4, 4),
    ('ANBAU', 'Erweiterung', 'A', 2, 1, 5),
    ('BIETE', 'offeriere', 'A', 3, 1, 5),
    ('GERA', 'Stadt in Thüringen', 'A', 4, 1, 4),
    ('GLIED', 'Kettenteil', 'A', 5, 3, 5),
    ('AESTE', 'Zweige', 'A', 6, 3, 5),
    ('GAB', 'reichte', 'A', 7, 1, 3),
    ('TON', 'Klang', 'A', 7, 5, 3),
    ('ABGANG', 'Abtritt', 'D', 2, 1, 6),
    ('KNIE', 'Scharniergelenk', 'D', 1, 2, 4),
    ('BERGAB', 'abwärts', 'D', 2, 3, 6),
    ('FATALE', 'unheilvolle', 'D', 1, 4, 6),
    ('AUE', 'Wiesenland', 'D', 1, 5, 3),
    ('IST', 'befindet sich', 'D', 5, 5, 3),
    ('VETO', 'Einspruch', 'D', 4, 6, 4),
    ('TYP', 'Exemplar', 'D', 1, 7, 3),
    ('DEN', 'Artikel (Akkusativ)', 'D', 5, 7, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r029-8x8-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r029-8x8-03', 'Rätsel 29 · 8×8', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '8x8-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('SOVIEL', 'so weit', 'A', 1, 1, 6),
    ('EINBAU', 'Montage', 'A', 2, 2, 6),
    ('PLANEN', 'vorhaben', 'A', 3, 1, 6),
    ('ENGE', 'knappe', 'A', 4, 4, 4),
    ('UNI', 'Hochschule', 'A', 5, 1, 3),
    ('SET', 'Ausstattung', 'A', 5, 5, 3),
    ('SAH', 'blickte', 'A', 6, 1, 3),
    ('OMA', 'Großmutter', 'A', 6, 5, 3),
    ('EHRT', 'zollt Respekt', 'A', 7, 1, 4),
    ('PAUSE', 'Rast', 'D', 3, 1, 5),
    ('OEL', 'Rohstoff', 'D', 1, 2, 3),
    ('NAH', 'unweit', 'D', 5, 2, 3),
    ('VIA', 'über', 'D', 1, 3, 3),
    ('IHR', 'Pronomen (2. Pl.)', 'D', 5, 3, 3),
    ('INNE', '... halten', 'D', 1, 4, 4),
    ('EBENSO', 'gleichfalls', 'D', 1, 5, 6),
    ('LANGEM', 'seit ...', 'D', 1, 6, 6),
    ('ETAT', 'Budget', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r030-9x9-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r030-9x9-01', 'Rätsel 30 · 9×9', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '9x9-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('EGAL', 'einerlei', 'A', 1, 1, 4),
    ('ABT', 'Klosterchef', 'A', 1, 6, 3),
    ('REDE', 'Vortrag', 'A', 2, 1, 4),
    ('MAI', '5. Monat', 'A', 2, 6, 3),
    ('LIEB', 'nett', 'A', 3, 1, 4),
    ('TUT', 'verrichtet', 'A', 3, 6, 3),
    ('ALLE', 'Pronomen', 'A', 4, 1, 4),
    ('KAHL', 'glatzköpfig', 'A', 5, 5, 4),
    ('BITTERE', 'herbe', 'A', 6, 1, 7),
    ('THEORIE', 'Lehre', 'A', 7, 1, 7),
    ('REDNER', 'Sprecher', 'A', 8, 2, 6),
    ('ERLAUBT', 'gestattet', 'D', 1, 1, 7),
    ('GEIL', 'toll (ugs.)', 'D', 1, 2, 4),
    ('IHR', 'Pronomen (2. Pl.)', 'D', 6, 2, 3),
    ('ADEL', 'Aristokratie', 'D', 1, 3, 4),
    ('TEE', 'Heißgetränk', 'D', 6, 3, 3),
    ('LEBE', 'existiere', 'D', 1, 4, 4),
    ('TOD', 'Ableben', 'D', 6, 4, 3),
    ('KERN', 'Mittelpunkt', 'D', 5, 5, 4),
    ('AMT', 'Dienststelle', 'D', 1, 6, 3),
    ('ARIE', 'Opernlied', 'D', 5, 6, 4),
    ('BAU', 'Konstruktion', 'D', 1, 7, 3),
    ('HEER', 'Armee', 'D', 5, 7, 4),
    ('TITEL', 'Rang', 'D', 1, 8, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r031-9x9-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r031-9x9-02', 'Rätsel 31 · 9×9', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x9-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('KUBA', 'Karibikinsel', 'A', 1, 1, 4),
    ('RAR', 'kostbar', 'A', 1, 6, 3),
    ('ANIME', 'jap. Zeichentrick', 'A', 2, 1, 5),
    ('MITTLER', 'Makler', 'A', 3, 1, 7),
    ('BRAV', 'artig', 'A', 4, 5, 4),
    ('SCHIEF', 'krumm', 'A', 5, 1, 6),
    ('EHEN', 'Bündnisse', 'A', 6, 1, 4),
    ('AST', 'Zweig', 'A', 6, 6, 3),
    ('HORN', 'Hupe', 'A', 7, 1, 4),
    ('NEU', 'aktuell', 'A', 7, 6, 3),
    ('ERDE', 'Welt', 'A', 8, 1, 4),
    ('DEM', 'Artikel (Dativ)', 'A', 8, 6, 3),
    ('KAM', 'nahte', 'D', 1, 1, 3),
    ('SEHE', 'schaue', 'D', 5, 1, 4),
    ('UNI', 'Hochschule', 'D', 1, 2, 3),
    ('CHOR', 'Singgruppe', 'D', 5, 2, 4),
    ('BIT', 'Dualziffer', 'D', 1, 3, 3),
    ('HERD', 'Kochstelle', 'D', 5, 3, 4),
    ('AMT', 'Dienststelle', 'D', 1, 4, 3),
    ('INNE', 'Verbpartikel', 'D', 5, 4, 4),
    ('ELBE', 'Strom durch Hamburg', 'D', 2, 5, 4),
    ('ERFAND', 'ersann', 'D', 3, 6, 6),
    ('AERA', 'Epoche', 'D', 1, 7, 4),
    ('SEE', 'Weiher', 'D', 6, 7, 3),
    ('VOTUM', 'Stimme', 'D', 4, 8, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r032-9x9-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r032-9x9-03', 'Rätsel 32 · 9×9', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '9x9-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AERA', 'Epoche', 'A', 1, 1, 4),
    ('PRO', 'per', 'A', 1, 6, 3),
    ('STAB', 'Stock', 'A', 2, 1, 4),
    ('FEE', 'Elfe', 'A', 2, 6, 3),
    ('SATT', 'gesättigt', 'A', 3, 1, 4),
    ('ALL', 'Kosmos', 'A', 3, 6, 3),
    ('EHRE', 'Würde', 'A', 4, 4, 4),
    ('HIERAN', 'daran', 'A', 5, 3, 6),
    ('MAI', '5. Monat', 'A', 6, 1, 3),
    ('LESE', 'studiere', 'A', 6, 5, 4),
    ('TUE', 'mache', 'A', 7, 1, 3),
    ('MIES', 'schlecht', 'A', 7, 5, 4),
    ('SERIE', 'Reihe', 'A', 8, 1, 5),
    ('ASS', 'verspeiste', 'D', 1, 1, 3),
    ('AMTS', 'hoheitlich', 'D', 5, 1, 4),
    ('ETAT', 'Budget', 'D', 1, 2, 4),
    ('AUE', 'Wiesenland', 'D', 6, 2, 3),
    ('RAT', 'Tipp', 'D', 1, 3, 3),
    ('HIER', 'an diesem Ort', 'D', 5, 3, 4),
    ('ABTEI', 'Kloster', 'D', 1, 4, 5),
    ('HELME', 'Kopfschutz', 'D', 4, 5, 5),
    ('PFARREI', 'Sprengel', 'D', 1, 6, 7),
    ('RELEASE', 'Erscheinen', 'D', 1, 7, 7),
    ('OEL', 'Rohstoff', 'D', 1, 8, 3),
    ('NEST', 'Horst', 'D', 5, 8, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r033-9x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r033-9x13-01', 'Rätsel 33 · 9×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('CHEF', 'Boss', 'A', 1, 1, 4),
    ('STAMMES', 'Häuptling des ...', 'A', 1, 6, 7),
    ('HOHE', 'große', 'A', 2, 1, 4),
    ('FAIRE', 'gerechte', 'A', 2, 8, 5),
    ('AFRIKA', 'Erdteil', 'A', 3, 1, 6),
    ('FIRST', 'Dachkante', 'A', 3, 8, 5),
    ('ENORMEN', 'gewaltigen', 'A', 4, 3, 7),
    ('ECKE', 'Winkel', 'A', 5, 4, 4),
    ('OEL', 'Rohstoff', 'A', 6, 1, 3),
    ('HELD', 'Recke', 'A', 6, 5, 4),
    ('UNI', 'Hochschule', 'A', 6, 10, 3),
    ('PRO', 'je', 'A', 7, 1, 3),
    ('ENDE', 'Schluss', 'A', 7, 5, 4),
    ('GUT', 'brauchbar', 'A', 7, 10, 3),
    ('ASSEN', 'speisten', 'A', 8, 1, 5),
    ('ESSENZ', 'Kern', 'A', 8, 7, 6),
    ('CHAT', 'Plauderei', 'D', 1, 1, 4),
    ('OPA', 'Großvater', 'D', 6, 1, 3),
    ('HOF', 'Grundstück', 'D', 1, 2, 3),
    ('VERS', 'Reim', 'D', 5, 2, 4),
    ('EHRE', 'Würde', 'D', 1, 3, 4),
    ('LOS', 'ledig', 'D', 6, 3, 3),
    ('FEINE', 'zarte', 'D', 1, 4, 5),
    ('KOCHEN', 'Zubereiten', 'D', 3, 5, 6),
    ('STARKEN', 'kräftigen', 'D', 1, 6, 7),
    ('MELDE', 'zeige an', 'D', 4, 7, 5),
    ('AFFE', 'Schimpanse', 'D', 1, 8, 4),
    ('DES', 'Artikel (Genitiv)', 'D', 6, 8, 3),
    ('MAIN', 'Fluss in Hessen', 'D', 1, 9, 4),
    ('MIR', 'Dat. (1. Pers.)', 'D', 1, 10, 3),
    ('AUGE', 'Pupille', 'D', 5, 10, 4),
    ('ERST', 'anfangs', 'D', 1, 11, 4),
    ('NUN', 'jetzt', 'D', 6, 11, 3),
    ('SET', 'Satz', 'D', 1, 12, 3),
    ('SITZ', 'Stuhl', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r034-9x13-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r034-9x13-02', 'Rätsel 34 · 9×13', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '9x13-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('NUR', 'lediglich', 'A', 1, 1, 3),
    ('RAD', 'Kreisscheibe', 'A', 1, 6, 3),
    ('ENG', 'knapp', 'A', 1, 10, 3),
    ('OMA', 'Großmutter', 'A', 2, 1, 3),
    ('WEGE', 'Routen', 'A', 2, 5, 4),
    ('BAU', 'Gebäude', 'A', 2, 10, 3),
    ('ESEL', 'Dickkopf', 'A', 3, 1, 4),
    ('GENAEHT', 'geschneidert', 'A', 3, 6, 7),
    ('TOTE', 'Verstorbene', 'A', 4, 1, 4),
    ('INNEN', 'intern', 'A', 4, 6, 5),
    ('BROT', 'Laib', 'A', 5, 4, 4),
    ('GARTEN', 'Grünfläche', 'A', 6, 1, 6),
    ('STAAT', 'Nation', 'A', 6, 8, 5),
    ('LIED', 'Song', 'A', 7, 2, 4),
    ('ZIELTE', 'visierte', 'A', 7, 7, 6),
    ('KLONEN', 'Kopieren', 'A', 8, 1, 6),
    ('ERSTE', 'anfängliche', 'A', 8, 8, 5),
    ('NOETIG', 'erforderlich', 'D', 1, 1, 6),
    ('UMSO', 'Konjunktionaladverb', 'D', 1, 2, 4),
    ('ALL', 'Kosmos', 'D', 6, 2, 3),
    ('RAET', 'tippt', 'D', 1, 3, 4),
    ('RIO', 'Zuckerhut-Stadt', 'D', 6, 3, 3),
    ('LEBTEN', 'existierten', 'D', 3, 4, 6),
    ('REDE', 'Ansprache', 'D', 5, 5, 4),
    ('REGION', 'Gegend', 'D', 1, 6, 6),
    ('AGENT', 'Spion', 'D', 1, 7, 5),
    ('DENN', 'Konjunktion', 'D', 1, 8, 4),
    ('SIE', 'Anrede', 'D', 6, 8, 3),
    ('AELTER', 'betagter', 'D', 3, 9, 6),
    ('EBEN', 'just', 'D', 1, 10, 4),
    ('ALS', 'da, während', 'D', 6, 10, 3),
    ('NAH', 'unweit', 'D', 1, 11, 3),
    ('MATT', 'Schachende', 'D', 5, 11, 4),
    ('GUTE', 'anständige', 'D', 1, 12, 4),
    ('TEE', 'Heißgetränk', 'D', 6, 12, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r035-9x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r035-9x13-03', 'Rätsel 35 · 9×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('INNE', 'Verbpartikel', 'A', 1, 1, 4),
    ('STUDIOS', 'Ateliers', 'A', 1, 6, 7),
    ('SUENDE', 'Frevel', 'A', 2, 1, 6),
    ('FAHRE', 'reise', 'A', 2, 8, 5),
    ('TRUGEN', 'schleppten', 'A', 3, 1, 6),
    ('ERNTE', 'Lese', 'A', 3, 8, 5),
    ('PAAR', 'einige', 'A', 4, 5, 4),
    ('BOTE', 'Kurier', 'A', 5, 4, 4),
    ('FASS', 'Tonne', 'A', 5, 9, 4),
    ('ERBEN', 'Nachkommen', 'A', 6, 1, 5),
    ('SOLLTE', 'Verbform', 'A', 6, 7, 6),
    ('HAITI', 'Karibikstaat', 'A', 7, 1, 5),
    ('UTAH', 'Mormonenstaat', 'A', 7, 9, 4),
    ('ERSTERE', 'Vorgenannte', 'A', 8, 1, 7),
    ('REUE', 'Zerknirschung', 'A', 8, 9, 4),
    ('IST', 'befindet sich', 'D', 1, 1, 3),
    ('GEHE', 'laufe', 'D', 5, 1, 4),
    ('NUR', 'lediglich', 'D', 1, 2, 3),
    ('RAR', 'kostbar', 'D', 6, 2, 3),
    ('NEUE', 'frische', 'D', 1, 3, 4),
    ('BIS', 'nicht später als', 'D', 6, 3, 3),
    ('ENG', 'schmal', 'D', 1, 4, 3),
    ('BETT', 'Schlafstätte', 'D', 5, 4, 4),
    ('DEPONIE', 'Müllplatz', 'D', 2, 5, 7),
    ('SENAT', 'Ältestenrat', 'D', 1, 6, 5),
    ('AESTE', 'Zweige', 'D', 4, 7, 5),
    ('UFER', 'Küste', 'D', 1, 8, 4),
    ('DAR', 'stellt ... (zeigt)', 'D', 1, 9, 3),
    ('FLUR', 'Diele', 'D', 5, 9, 4),
    ('IHN', 'Akkusativ von er', 'D', 1, 10, 3),
    ('ALTE', 'betagte', 'D', 5, 10, 4),
    ('ORT', 'Platz', 'D', 1, 11, 3),
    ('STAU', 'Blechlawine', 'D', 5, 11, 4),
    ('SEE', 'Weiher', 'D', 1, 12, 3),
    ('SEHE', 'schaue', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r036-10x10-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r036-10x10-01', 'Rätsel 36 · 10×10', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '10x10-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('GUT', 'brauchbar', 'A', 1, 1, 3),
    ('MOND', 'Erdtrabant', 'A', 1, 6, 4),
    ('LEUTE', 'Personen', 'A', 2, 1, 5),
    ('RIO', 'Zuckerhut-Stadt', 'A', 2, 7, 3),
    ('ABER', 'jedoch', 'A', 3, 1, 4),
    ('ATEM', 'Luft', 'A', 3, 6, 4),
    ('STRESS', 'Hektik', 'A', 4, 1, 6),
    ('FESTEN', 'stabilen', 'A', 5, 4, 6),
    ('WAFFE', 'Kampfmittel', 'A', 6, 1, 5),
    ('UNI', 'Alma Mater', 'A', 6, 7, 3),
    ('EURE', 'Possessiv (ihr)', 'A', 7, 1, 4),
    ('ERDE', 'Heimatplanet', 'A', 7, 6, 4),
    ('IRAN', 'Golfstaat', 'A', 8, 1, 4),
    ('HIER', 'an diesem Ort', 'A', 8, 6, 4),
    ('BAU', 'Gebäude', 'A', 9, 1, 3),
    ('KENNE', 'weiß', 'A', 9, 5, 5),
    ('GLAS', 'Trinkgefäß', 'D', 1, 1, 4),
    ('WEIB', 'Frau (veraltet)', 'D', 6, 1, 4),
    ('UEBT', 'trainiert', 'D', 1, 2, 4),
    ('AURA', 'Ausstrahlung', 'D', 6, 2, 4),
    ('TUER', 'Eingang', 'D', 1, 3, 4),
    ('FRAU', 'Gemahlin', 'D', 6, 3, 4),
    ('TREFFEN', 'begegnen', 'D', 2, 4, 7),
    ('SEE', 'Gewässer', 'D', 4, 5, 3),
    ('ASS', 'speiste', 'D', 3, 6, 3),
    ('EHE', 'Vermählung', 'D', 7, 6, 3),
    ('ORT', 'Stelle', 'D', 1, 7, 3),
    ('TURIN', 'Stadt am Po', 'D', 5, 7, 5),
    ('NIE', 'zu keiner Zeit', 'D', 1, 8, 3),
    ('ENDEN', 'aufhören', 'D', 5, 8, 5),
    ('DOM', 'Münster', 'D', 1, 9, 3),
    ('NIERE', 'Organ', 'D', 5, 9, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r037-10x10-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r037-10x10-02', 'Rätsel 37 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('OMA', 'Omi', 'A', 1, 1, 3),
    ('WAGTE', 'riskierte', 'A', 1, 5, 5),
    ('PALME', 'tropischer Baum', 'A', 2, 1, 5),
    ('RAN', 'heran', 'A', 2, 7, 3),
    ('ALTAR', 'Opfertisch', 'A', 3, 1, 5),
    ('AXT', 'Tomahawk', 'A', 3, 7, 3),
    ('STUDIE', 'Untersuchung', 'A', 4, 4, 6),
    ('PHASEN', 'Abschnitte', 'A', 5, 1, 6),
    ('ROM', 'Ewige Stadt', 'A', 6, 1, 3),
    ('TEIG', 'Masse', 'A', 6, 6, 4),
    ('OFT', 'des Öfteren', 'A', 7, 1, 3),
    ('BEIGE', 'sandfarben', 'A', 7, 5, 5),
    ('SEE', 'Weiher', 'A', 8, 1, 3),
    ('INNEN', 'intern', 'A', 8, 5, 5),
    ('ASSEN', 'speisten', 'A', 9, 1, 5),
    ('ELF', 'Zahl (10+1)', 'A', 9, 7, 3),
    ('OPA', 'Großvater', 'D', 1, 1, 3),
    ('PROSA', 'Erzähltext', 'D', 5, 1, 5),
    ('MAL', 'Zeichen ×', 'D', 1, 2, 3),
    ('HOFES', 'Mitte des ...', 'D', 5, 2, 5),
    ('ALT', 'betagt', 'D', 1, 3, 3),
    ('AMTES', 'Ende des ...', 'D', 5, 3, 5),
    ('MASS', 'Größe', 'D', 2, 4, 4),
    ('WERTE', 'Normen', 'D', 1, 5, 5),
    ('BIN', 'existiere', 'D', 7, 5, 3),
    ('UNTEN', 'am Grund', 'D', 4, 6, 5),
    ('GRAD', 'Stufe', 'D', 1, 7, 4),
    ('EINE', 'unbest. Artikel (w.)', 'D', 6, 7, 4),
    ('TAXI', 'Droschke', 'D', 1, 8, 4),
    ('IGEL', 'Winterschläfer', 'D', 6, 8, 4),
    ('ENTE', 'Wasservogel', 'D', 1, 9, 4),
    ('GENF', 'Stadt am Léman', 'D', 6, 9, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r038-10x10-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r038-10x10-03', 'Rätsel 38 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ASIEN', 'Erdteil', 'A', 1, 1, 5),
    ('ART', 'Sorte', 'A', 1, 7, 3),
    ('DANN', 'daraufhin', 'A', 2, 1, 4),
    ('HEU', 'Viehfutter', 'A', 2, 7, 3),
    ('LAST', 'Bürde', 'A', 3, 1, 4),
    ('ENDE', 'Finale', 'A', 3, 6, 4),
    ('ELEGANTE', 'schicke', 'A', 4, 1, 8),
    ('RELIKT', 'Überbleibsel', 'A', 5, 1, 6),
    ('NUESSE', 'Kerne', 'A', 6, 4, 6),
    ('SINGT', 'trällert', 'A', 7, 1, 5),
    ('TAL', 'Senke', 'A', 7, 7, 3),
    ('EHE', 'Bund fürs Leben', 'A', 8, 1, 3),
    ('EWIGE', 'endlose', 'A', 8, 5, 5),
    ('TRUG', 'hatte an', 'A', 9, 1, 4),
    ('LAG', 'befand sich', 'A', 9, 7, 3),
    ('ADLER', 'Greifvogel', 'D', 1, 1, 5),
    ('SET', 'Satz', 'D', 7, 1, 3),
    ('SAALE', 'Fluss durch Halle', 'D', 1, 2, 5),
    ('IHR', 'Pronomen (2. Pl.)', 'D', 7, 2, 3),
    ('INSEL', 'Eiland', 'D', 1, 3, 5),
    ('NEU', 'frisch', 'D', 7, 3, 3),
    ('ENTGING', 'entkam', 'D', 1, 4, 7),
    ('AKUTE', 'dringende', 'D', 4, 5, 5),
    ('ENTE', 'Falschmeldung', 'D', 3, 6, 4),
    ('AHNT', 'vermutet', 'D', 1, 7, 4),
    ('STIL', 'Machart', 'D', 6, 7, 4),
    ('REDE', 'Vortrag', 'D', 1, 8, 4),
    ('SAGA', 'Heldensage', 'D', 6, 8, 4),
    ('TUE', 'verrichte', 'D', 1, 9, 3),
    ('BELEG', 'Quittung', 'D', 5, 9, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r039-10x10-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r039-10x10-04', 'Rätsel 39 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ETAT', 'Finanzplan', 'A', 1, 1, 4),
    ('LAGE', 'Position', 'A', 1, 6, 4),
    ('GAB', 'schenkte', 'A', 2, 1, 3),
    ('MALEN', 'pinseln', 'A', 2, 5, 5),
    ('ALTE', 'betagte', 'A', 3, 1, 4),
    ('GILT', 'ist gültig', 'A', 3, 6, 4),
    ('LEER', 'hohl', 'A', 4, 1, 4),
    ('EBBE', 'Gegenteil der Flut', 'A', 4, 6, 4),
    ('SIBIRIEN', 'Region in Russland', 'A', 5, 2, 8),
    ('AMT', 'Dienststelle', 'A', 6, 4, 3),
    ('ALBUM', 'Tonträger', 'A', 7, 1, 5),
    ('HAT', 'besitzt', 'A', 7, 7, 3),
    ('LAUTE', 'Töne', 'A', 8, 1, 5),
    ('AUE', 'Wiesenland', 'A', 8, 7, 3),
    ('ASS', 'speiste', 'A', 9, 1, 3),
    ('REISE', 'Fahrt', 'A', 9, 5, 5),
    ('EGAL', 'einerlei', 'D', 1, 1, 4),
    ('GALA', 'Festabend', 'D', 6, 1, 4),
    ('TALES', 'Grund des ...', 'D', 1, 2, 5),
    ('LAS', 'entzifferte', 'D', 7, 2, 3),
    ('ABTEI', 'Kloster', 'D', 1, 3, 5),
    ('BUS', 'Car (schweiz.)', 'D', 7, 3, 3),
    ('ERBAUT', 'errichtet', 'D', 3, 4, 6),
    ('IMMER', 'ständig', 'D', 5, 5, 5),
    ('LAGERT', 'ruht', 'D', 1, 6, 6),
    ('ALIBI', 'Entlastung', 'D', 1, 7, 5),
    ('HAI', 'Meeresräuber', 'D', 7, 7, 3),
    ('GELBE', 'die ... Karte', 'D', 1, 8, 5),
    ('AUS', 'vorbei', 'D', 7, 8, 3),
    ('ENTEN', 'Wasservögel', 'D', 1, 9, 5),
    ('TEE', 'Aufguss', 'D', 7, 9, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r040-11x11-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r040-11x11-01', 'Rätsel 40 · 11×11', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '11x11-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ABER', 'jedoch', 'A', 1, 1, 4),
    ('SUPER', 'toll', 'A', 1, 6, 5),
    ('REH', 'Waldtier', 'A', 2, 1, 3),
    ('OMA', 'Großmutter', 'A', 2, 8, 3),
    ('MUEHLE', 'Mahlwerk', 'A', 3, 1, 6),
    ('RAD', 'Velo', 'A', 3, 8, 3),
    ('STIL', 'Machart', 'A', 4, 7, 4),
    ('STARB', 'erlag', 'A', 5, 1, 5),
    ('POLE', 'Slawe', 'A', 5, 7, 4),
    ('KRIMI', 'Thriller', 'A', 6, 3, 5),
    ('ART', 'Spezies', 'A', 7, 1, 3),
    ('SETUP', 'Einrichtung', 'A', 7, 5, 5),
    ('TEIG', 'Masse', 'A', 8, 1, 4),
    ('RATES', 'Mitglied des ...', 'A', 8, 6, 5),
    ('IDEE', 'Einfall', 'A', 9, 1, 4),
    ('KLARE', 'deutliche', 'A', 9, 6, 5),
    ('KENNST', 'weißt', 'A', 10, 1, 6),
    ('HUT', 'Vorsicht', 'A', 10, 8, 3),
    ('ARM', 'Gliedmaße', 'D', 1, 1, 3),
    ('STATIK', 'Baulehre', 'D', 5, 1, 6),
    ('BEUGT', 'krümmt', 'D', 1, 2, 5),
    ('REDE', 'Ansprache', 'D', 7, 2, 4),
    ('EHE', 'Vermählung', 'D', 1, 3, 3),
    ('AKTIEN', 'Wertpapiere', 'D', 5, 3, 6),
    ('HERR', 'Gebieter', 'D', 3, 4, 4),
    ('GEN', 'Erbanlage', 'D', 8, 4, 3),
    ('BIS', 'nicht später als', 'D', 5, 5, 3),
    ('SIE', 'Anrede', 'D', 1, 6, 3),
    ('MERKT', 'spürt', 'D', 6, 6, 5),
    ('SPITAL', 'Krankenhaus', 'D', 4, 7, 6),
    ('PORTO', 'Postgebühr', 'D', 1, 8, 5),
    ('UTAH', 'Mormonenstaat', 'D', 7, 8, 4),
    ('EMAIL', 'digitale Post', 'D', 1, 9, 5),
    ('PERU', 'Andenstaat', 'D', 7, 9, 4),
    ('RADLER', 'Biker', 'D', 1, 10, 6),
    ('SET', 'Ausstattung', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r041-11x11-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r041-11x11-02', 'Rätsel 41 · 11×11', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '11x11-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('LUD', 'forderte auf', 'A', 1, 1, 3),
    ('GELEGE', 'Eier', 'A', 1, 5, 6),
    ('IRAK', 'Land am Tigris', 'A', 2, 1, 4),
    ('TOTEN', 'Verstorbenen', 'A', 2, 6, 5),
    ('LAS', 'entzifferte', 'A', 3, 1, 3),
    ('VAKANT', 'frei', 'A', 3, 5, 6),
    ('ALS', 'da, während', 'A', 4, 1, 3),
    ('MIES', 'schlecht', 'A', 5, 4, 4),
    ('BELAG', 'Überzug', 'A', 6, 1, 5),
    ('PINK', 'Rosa', 'A', 6, 7, 4),
    ('ELEGANTE', 'schicke', 'A', 7, 3, 8),
    ('OHR', 'Hörorgan', 'A', 8, 1, 3),
    ('LAEDEN', 'Geschäfte', 'A', 8, 5, 6),
    ('MUND', 'Maul', 'A', 9, 1, 4),
    ('STERN', 'Gestirn', 'A', 9, 6, 5),
    ('ABT', 'Ordensoberer', 'A', 10, 1, 3),
    ('STERNE', 'Gestirne', 'A', 10, 5, 6),
    ('LILA', 'Violett', 'D', 1, 1, 4),
    ('OMA', 'Omi', 'D', 8, 1, 3),
    ('URALTE', 'steinalte', 'D', 1, 2, 6),
    ('HUB', 'Kolbenweg', 'D', 8, 2, 3),
    ('DASS', 'Konjunktion', 'D', 1, 3, 4),
    ('LERNT', 'paukt', 'D', 6, 3, 5),
    ('MAL', 'Zeichen ×', 'D', 5, 4, 3),
    ('IGEL', 'Stacheltier', 'D', 5, 5, 4),
    ('ETAGE', 'Stockwerk', 'D', 1, 6, 5),
    ('GAST', 'Besucher', 'D', 7, 6, 4),
    ('LOK', 'Triebwagen', 'D', 1, 7, 3),
    ('SPAETE', 'vorgerückte', 'D', 5, 7, 6),
    ('ETAT', 'Finanzplan', 'D', 1, 8, 4),
    ('INDER', 'Asiate', 'D', 6, 8, 5),
    ('GEN', 'Erbanlage', 'D', 1, 9, 3),
    ('INTERN', 'innen', 'D', 5, 9, 6),
    ('ENTE', 'Falschmeldung', 'D', 1, 10, 4),
    ('KENNE', 'weiß', 'D', 6, 10, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r042-11x11-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r042-11x11-03', 'Rätsel 42 · 11×11', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '11x11-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('IRAK', 'Land am Tigris', 'A', 1, 1, 4),
    ('BASS', 'tiefe Stimme', 'A', 1, 7, 4),
    ('NIX', 'nichts', 'A', 2, 1, 3),
    ('VIERTE', 'nach der dritten', 'A', 2, 5, 6),
    ('FOTO', 'Schnappschuss', 'A', 3, 1, 4),
    ('DAMIT', 'Konjunktion', 'A', 3, 6, 5),
    ('VAETER', 'Papas', 'A', 4, 4, 6),
    ('SCHAFE', 'Herdentiere', 'A', 5, 1, 6),
    ('ENG', 'schmal', 'A', 5, 8, 3),
    ('HALF', 'stand bei', 'A', 6, 2, 4),
    ('WER', 'Fragewort (Person)', 'A', 7, 1, 3),
    ('ERZ', 'Bodenschatz', 'A', 7, 5, 3),
    ('OFT', 'des Öfteren', 'A', 8, 1, 3),
    ('NOETIG', 'erforderlich', 'A', 8, 5, 6),
    ('ZIEL', 'Absicht', 'A', 9, 1, 4),
    ('SAALE', 'Fluss durch Halle', 'A', 9, 6, 5),
    ('UNS', 'Akk./Dat. von wir', 'A', 10, 1, 3),
    ('ENTEN', 'Wasservögel', 'A', 10, 6, 5),
    ('INFOS', 'Auskünfte', 'D', 1, 1, 5),
    ('WOZU', 'Fragewort (Zweck)', 'D', 7, 1, 4),
    ('RIO', 'Zuckerhut-Stadt', 'D', 1, 2, 3),
    ('CHEFIN', 'Leiterin', 'D', 5, 2, 6),
    ('AXT', 'Tomahawk', 'D', 1, 3, 3),
    ('HARTES', 'festes', 'D', 5, 3, 6),
    ('OVAL', 'eiförmig', 'D', 3, 4, 4),
    ('AFFEN', 'Primaten', 'D', 4, 5, 5),
    ('IDEE', 'Einfall', 'D', 2, 6, 4),
    ('ROSE', 'Blume mit Dornen', 'D', 7, 6, 4),
    ('BEAT', 'Rhythmus', 'D', 1, 7, 4),
    ('OZEAN', 'Weltmeer', 'D', 6, 7, 5),
    ('ARMEE', 'Heer', 'D', 1, 8, 5),
    ('TAT', 'Handlung', 'D', 8, 8, 3),
    ('STIRN', 'die ... bieten', 'D', 1, 9, 5),
    ('EILE', 'Hektik', 'D', 7, 9, 4),
    ('SET', 'Ausstattung', 'D', 1, 10, 3),
    ('GEN', 'nach', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r043-12x12-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r043-12x12-01', 'Rätsel 43 · 12×12', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '12x12-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ARG', 'schlimm', 'A', 1, 1, 3),
    ('STIL', 'Machart', 'A', 1, 8, 4),
    ('LIEBTE', 'verehrte', 'A', 2, 1, 6),
    ('AERA', 'Epoche', 'A', 2, 8, 4),
    ('TON', 'Klang', 'A', 3, 1, 3),
    ('MENUES', 'Gänge', 'A', 3, 6, 6),
    ('EIGENS', 'extra', 'A', 4, 6, 6),
    ('MALERIN', 'Künstlerin', 'A', 5, 1, 7),
    ('LEGEN', 'platzieren', 'A', 6, 2, 5),
    ('ALGEN', 'Tang', 'A', 7, 1, 5),
    ('GRAUE', 'trübe', 'A', 7, 7, 5),
    ('IST', 'befindet sich', 'A', 8, 3, 3),
    ('RAGEN', 'aufsteigen', 'A', 8, 7, 5),
    ('LOT', 'Senkblei', 'A', 9, 1, 3),
    ('EROBERT', 'eingenommen', 'A', 9, 5, 7),
    ('ZEIT', 'Dauer', 'A', 10, 1, 4),
    ('ABENDE', 'Soireen', 'A', 10, 6, 6),
    ('ULM', 'Einstein-Geburtsstadt', 'A', 11, 1, 3),
    ('RESTEN', 'Abfällen', 'A', 11, 6, 6),
    ('ALTEM', 'betagtem', 'D', 1, 1, 5),
    ('ALLZU', 'übermäßig', 'D', 7, 1, 5),
    ('RIO', 'Zuckerhut-Stadt', 'D', 1, 2, 3),
    ('ALL', 'Weltraum', 'D', 5, 2, 3),
    ('OEL', 'Schmierstoff', 'D', 9, 2, 3),
    ('GEN', 'Erbanlage', 'D', 1, 3, 3),
    ('LEGITIM', 'rechtmäßig', 'D', 5, 3, 7),
    ('REGES', 'lebhaftes', 'D', 4, 4, 5),
    ('RENTE', 'Pension', 'D', 5, 5, 5),
    ('GEMEIN', 'fies', 'D', 1, 6, 6),
    ('RAR', 'kostbar', 'D', 9, 6, 3),
    ('EIN', 'unbest. Artikel', 'D', 3, 7, 3),
    ('GROBE', 'raue', 'D', 7, 7, 5),
    ('SANG', 'trällerte', 'D', 1, 8, 4),
    ('GRABES', 'Stille des ...', 'D', 6, 8, 6),
    ('TEUER', 'kostspielig', 'D', 1, 9, 5),
    ('AGENT', 'Geheimdienstler', 'D', 7, 9, 5),
    ('IREN', 'Gälen', 'D', 1, 10, 4),
    ('HUERDE', 'Hindernis', 'D', 6, 10, 6),
    ('LASST', 'erlaubt', 'D', 1, 11, 5),
    ('ENTEN', 'Schwimmvögel', 'D', 7, 11, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r044-12x12-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r044-12x12-02', 'Rätsel 44 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('FETT', 'Schmalz', 'A', 1, 1, 4),
    ('UEBT', 'trainiert', 'A', 1, 8, 4),
    ('IRRE', 'Verrückte', 'A', 2, 1, 4),
    ('AEMTER', 'Behörden', 'A', 2, 6, 6),
    ('NEUERE', 'Jüngere', 'A', 3, 1, 6),
    ('SAFE', 'Tresor', 'A', 3, 8, 4),
    ('DIE', 'Artikel (weibl.)', 'A', 4, 1, 3),
    ('GAU', 'Landstrich', 'A', 4, 9, 3),
    ('ELBE', 'Strom durch Dresden', 'A', 5, 1, 4),
    ('GEBEN', 'reichen', 'A', 5, 6, 5),
    ('TEILE', 'Stücke', 'A', 6, 2, 5),
    ('ENDE', 'Schluss', 'A', 6, 8, 4),
    ('SENSOR', 'Fühler', 'A', 7, 1, 6),
    ('ASS', 'speiste', 'A', 8, 7, 3),
    ('IDOL', 'Star', 'A', 9, 1, 4),
    ('ETAT', 'Finanzplan', 'A', 9, 8, 4),
    ('EUROPA', 'Erdteil', 'A', 10, 1, 6),
    ('REUE', 'Zerknirschung', 'A', 10, 8, 4),
    ('GOTT', 'Schöpfer', 'A', 11, 1, 4),
    ('SIEGER', 'Gewinner', 'A', 11, 6, 6),
    ('FINDE', 'entdecke', 'D', 1, 1, 5),
    ('STIEG', 'kletterte', 'D', 7, 1, 5),
    ('EREILTE', 'traf', 'D', 1, 2, 7),
    ('DUO', 'Tandem', 'D', 9, 2, 3),
    ('TRUEBEN', 'verdunkeln', 'D', 1, 3, 7),
    ('ORT', 'Stelle', 'D', 9, 3, 3),
    ('TEE', 'Aufguss', 'D', 1, 4, 3),
    ('EIS', 'Sorbet', 'D', 5, 4, 3),
    ('LOT', 'Senkblei', 'D', 9, 4, 3),
    ('LOK', 'Triebwagen', 'D', 6, 5, 3),
    ('SAENGER', 'Vokalist', 'D', 1, 6, 7),
    ('GAS', 'Treibstoff', 'D', 9, 6, 3),
    ('UMS', 'um das', 'D', 1, 8, 3),
    ('BESSERE', 'überlegene', 'D', 5, 8, 7),
    ('ETAGEN', 'Stockwerke', 'D', 1, 9, 6),
    ('STEG', 'Brücklein', 'D', 8, 9, 4),
    ('BEFAND', 'urteilte', 'D', 1, 10, 6),
    ('AUE', 'Talwiese', 'D', 9, 10, 3),
    ('TREU', 'loyal', 'D', 1, 11, 4),
    ('ERSTER', 'anfänglicher', 'D', 6, 11, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r045-12x12-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r045-12x12-03', 'Rätsel 45 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ISLAM', 'Weltreligion', 'A', 1, 1, 5),
    ('IMAGE', 'Ansehen', 'A', 1, 7, 5),
    ('STEUERN', 'Abgaben', 'A', 2, 1, 7),
    ('MAI', 'Wonnemonat', 'A', 2, 9, 3),
    ('SEGEN', 'Gnade', 'A', 3, 1, 5),
    ('TUN', 'verrichten', 'A', 3, 9, 3),
    ('TUT', 'macht', 'A', 4, 1, 3),
    ('STEG', 'Brücklein', 'A', 4, 5, 4),
    ('ARM', 'Gliedmaße', 'A', 5, 5, 3),
    ('VIA', 'durch', 'A', 5, 9, 3),
    ('ARGE', 'schlimme', 'A', 6, 1, 4),
    ('STRESS', 'Hektik', 'A', 7, 5, 6),
    ('JOB', 'Anstellung', 'A', 8, 1, 3),
    ('ITALIEN', 'Stiefelland', 'A', 8, 5, 7),
    ('ADERN', 'Venen', 'A', 9, 1, 5),
    ('STEHE', 'ich ... auf', 'A', 9, 7, 5),
    ('GETANZT', 'geschwoft', 'A', 10, 1, 7),
    ('HEU', 'Viehfutter', 'A', 10, 9, 3),
    ('TRETE', 'kicke', 'A', 11, 1, 5),
    ('JENE', 'selbige', 'A', 11, 8, 4),
    ('ISST', 'speist', 'D', 1, 1, 4),
    ('JAGT', 'verfolgt', 'D', 8, 1, 4),
    ('STEUER', 'Abgabe', 'D', 1, 2, 6),
    ('ODER', 'bzw.', 'D', 8, 2, 4),
    ('LEGT', 'deponiert', 'D', 1, 3, 4),
    ('GEBETE', 'Andachten', 'D', 6, 3, 6),
    ('AUE', 'Wiesenland', 'D', 1, 4, 3),
    ('RAT', 'Gremium', 'D', 9, 4, 3),
    ('MENSA', 'Kantine', 'D', 1, 5, 5),
    ('SINNE', 'im ... von', 'D', 7, 5, 5),
    ('TRITT', 'kickt', 'D', 4, 6, 5),
    ('INDEM', 'dadurch dass', 'D', 1, 7, 5),
    ('RAST', 'jagt', 'D', 7, 7, 4),
    ('WELT', 'Erde', 'D', 6, 8, 4),
    ('AMT', 'Dienststelle', 'D', 1, 9, 3),
    ('SIEHE', 'vgl.', 'D', 7, 9, 5),
    ('GAU', 'Landesteil', 'D', 1, 10, 3),
    ('SEHEN', 'erkennen', 'D', 7, 10, 5),
    ('EINMAL', 'früher', 'D', 1, 11, 6),
    ('NEUE', 'frische', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r046-12x12-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r046-12x12-04', 'Rätsel 46 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ABSEHBAR', 'voraussagbar', 'A', 1, 1, 8),
    ('LEINE', 'Seil', 'A', 2, 1, 5),
    ('SET', 'Ausstattung', 'A', 2, 7, 3),
    ('LIEGE', 'ruhe', 'A', 3, 1, 5),
    ('TIROL', 'Alpenland', 'A', 3, 7, 5),
    ('ENGER', 'schmaler', 'A', 4, 1, 5),
    ('ZAHL', 'Nummer', 'A', 4, 8, 4),
    ('LETZTERE', 'die Zweite', 'A', 5, 4, 8),
    ('GEN', 'Erbanlage', 'A', 6, 9, 3),
    ('ZOG', 'zerrte', 'A', 7, 2, 3),
    ('REDEN', 'sprechen', 'A', 7, 6, 5),
    ('ROSA', 'Pink', 'A', 8, 1, 4),
    ('EHE', 'Vermählung', 'A', 8, 6, 3),
    ('ANTRAG', 'Gesuch', 'A', 9, 1, 6),
    ('NASE', 'Riechorgan', 'A', 9, 8, 4),
    ('TEE', 'Heißgetränk', 'A', 10, 1, 3),
    ('KUER', 'freies Programm', 'A', 10, 8, 4),
    ('ENTE', 'Falschmeldung', 'A', 11, 1, 4),
    ('LATEIN', 'alte Sprache', 'A', 11, 6, 6),
    ('ALLE', 'sämtliche', 'D', 1, 1, 4),
    ('RATE', 'Quote', 'D', 8, 1, 4),
    ('BEINE', 'Gliedmaßen', 'D', 1, 2, 5),
    ('ZONEN', 'Bereiche', 'D', 7, 2, 5),
    ('SIEG', 'Triumph', 'D', 1, 3, 4),
    ('KOSTET', 'probiert', 'D', 6, 3, 6),
    ('ENGEL', 'Himmelsbote', 'D', 1, 4, 5),
    ('GAR', 'durchgekocht', 'D', 7, 4, 3),
    ('HEERES', 'Führung des ...', 'D', 1, 5, 6),
    ('REGEL', 'Norm', 'D', 7, 6, 5),
    ('AST', 'Knorren', 'D', 1, 7, 3),
    ('ZAEH', 'hartnäckig', 'D', 5, 7, 4),
    ('REIZT', 'lockt', 'D', 1, 8, 5),
    ('DENKT', 'meint', 'D', 7, 8, 5),
    ('TRAEGE', 'faul', 'D', 2, 9, 6),
    ('AUE', 'Talwiese', 'D', 9, 9, 3),
    ('OHREN', 'Hörorgane', 'D', 3, 10, 5),
    ('SEI', 'existiere', 'D', 9, 10, 3),
    ('SOLLEN', 'müssen', 'D', 1, 11, 6),
    ('GERN', 'mit Freude', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r047-13x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r047-13x13-01', 'Rätsel 47 · 13×13', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '13x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ART', 'Spezies', 'A', 1, 1, 3),
    ('APP', 'Handyprogramm', 'A', 1, 5, 3),
    ('EWIG', 'unaufhörlich', 'A', 1, 9, 4),
    ('NEUN', 'Zahl (3×3)', 'A', 2, 1, 4),
    ('REIHE', 'Serie', 'A', 2, 6, 5),
    ('SENATOR', 'Ratsherr', 'A', 3, 1, 7),
    ('EBEN', 'just', 'A', 3, 9, 4),
    ('HASSE', 'verabscheue', 'A', 4, 4, 5),
    ('SET', 'Satz', 'A', 5, 1, 3),
    ('NAEMLICH', 'und zwar', 'A', 5, 5, 8),
    ('TROTZ', 'Eigensinn', 'A', 6, 1, 5),
    ('RAET', 'empfiehlt', 'A', 6, 7, 4),
    ('OEL', 'Schmierstoff', 'A', 7, 1, 3),
    ('IDEEN', 'Konzepte', 'A', 7, 8, 5),
    ('FILM', 'Movie', 'A', 8, 1, 4),
    ('ALLE', 'sämtliche', 'A', 8, 6, 4),
    ('RABE', 'Unglücksvogel', 'A', 9, 9, 4),
    ('SYSTEMS', 'Teil des ...', 'A', 10, 2, 7),
    ('RAN', 'hinzu', 'A', 10, 10, 3),
    ('DIESER', 'Pronomen', 'A', 11, 1, 6),
    ('ZUG', 'Sog', 'A', 11, 10, 3),
    ('ENTEN', 'Schwimmvögel', 'A', 12, 2, 5),
    ('HATTE', 'Verbform', 'A', 12, 8, 5),
    ('ANS', 'an das', 'D', 1, 1, 3),
    ('STOFF', 'Gewebe', 'D', 5, 1, 5),
    ('REEDEREI', 'Frachtfirma', 'D', 1, 2, 8),
    ('SIE', 'Anrede', 'D', 10, 2, 3),
    ('TUN', 'verrichten', 'D', 1, 3, 3),
    ('TOLL', 'großartig', 'D', 5, 3, 4),
    ('YEN', 'Währung Japans', 'D', 10, 3, 3),
    ('NAH', 'dicht', 'D', 2, 4, 3),
    ('MISST', 'ermittelt', 'D', 8, 4, 5),
    ('TANZ', 'Ball', 'D', 3, 5, 4),
    ('TEE', 'Heißgetränk', 'D', 10, 5, 3),
    ('PROSA', 'Erzähltext', 'D', 1, 6, 5),
    ('DAUERN', 'währen', 'D', 7, 6, 6),
    ('PERSER', 'Iraner', 'D', 1, 7, 6),
    ('EMAIL', 'digitale Post', 'D', 4, 8, 5),
    ('SAH', 'erblickte', 'D', 10, 8, 3),
    ('EHE', 'Vermählung', 'D', 1, 9, 3),
    ('LEDER', 'Tierhaut', 'D', 5, 9, 5),
    ('WEBSITE', 'Homepage', 'D', 1, 10, 7),
    ('ARZT', 'Mediziner', 'D', 9, 10, 4),
    ('ERBAUT', 'errichtet', 'D', 7, 11, 6),
    ('GEN', 'nach', 'D', 1, 12, 3),
    ('HIN', 'fort', 'D', 5, 12, 3),
    ('ENGE', 'schmale', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r048-13x13-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r048-13x13-02', 'Rätsel 48 · 13×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '13x13-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('GEAHNDET', 'bestraft', 'A', 1, 1, 8),
    ('DIR', 'Dat. (2. Pers.)', 'A', 1, 10, 3),
    ('NEUEN', 'frischen', 'A', 2, 3, 5),
    ('IRRE', 'Verrückte', 'A', 2, 9, 4),
    ('WINKTE', 'grüßte', 'A', 3, 3, 6),
    ('ERZ', 'Gestein', 'A', 3, 10, 3),
    ('PAAR', 'einige', 'A', 4, 1, 4),
    ('RENDITE', 'Ertrag', 'A', 4, 6, 7),
    ('AULA', 'Festsaal', 'A', 5, 1, 4),
    ('ENDE', 'Finale', 'A', 5, 6, 4),
    ('RETTET', 'birgt', 'A', 6, 1, 6),
    ('LAS', 'schmökerte', 'A', 6, 8, 3),
    ('SOLCHE', 'derartige', 'A', 7, 7, 6),
    ('FEST', 'solide', 'A', 8, 3, 4),
    ('TRAKTOR', 'Schlepper', 'A', 9, 1, 7),
    ('TRAF', 'kreuzte', 'A', 9, 9, 4),
    ('ROLLER', 'Scooter', 'A', 10, 1, 6),
    ('FAIRE', 'gerechte', 'A', 10, 8, 5),
    ('ATLANTA', 'Stadt in Georgia', 'A', 11, 1, 7),
    ('GEIL', 'toll (ugs.)', 'A', 11, 9, 4),
    ('TEST', 'Klausur', 'A', 12, 1, 4),
    ('HEBEL', 'Griff', 'A', 12, 8, 5),
    ('GESPART', 'zurückgelegt', 'D', 1, 1, 7),
    ('TRAT', 'stapfte', 'D', 9, 1, 4),
    ('AUE', 'Talwiese', 'D', 4, 2, 3),
    ('ROTE', 'purpurne', 'D', 9, 2, 4),
    ('ANWALT', 'Jurist', 'D', 1, 3, 6),
    ('FALLS', 'wenn', 'D', 8, 3, 5),
    ('HEIRAT', 'Hochzeit', 'D', 1, 4, 6),
    ('EKLAT', 'Skandal', 'D', 8, 4, 5),
    ('NUN', 'jetzt', 'D', 1, 5, 3),
    ('ERSTEN', 'führenden', 'D', 6, 5, 6),
    ('DEKRET', 'Erlass', 'D', 1, 6, 6),
    ('TORTE', 'Kuchen', 'D', 8, 6, 5),
    ('ENTEN', 'Wasservögel', 'D', 1, 7, 5),
    ('ENDLOS', 'ewig', 'D', 3, 8, 6),
    ('DEAL', 'Abmachung', 'D', 4, 9, 4),
    ('TAGE', 'je 24 Stunden', 'D', 9, 9, 4),
    ('DREI', 'Zahl (2+1)', 'D', 1, 10, 4),
    ('SCHRIEB', 'verfasste', 'D', 6, 10, 7),
    ('IRRT', 'täuscht sich', 'D', 1, 11, 4),
    ('ARIE', 'Sologesang', 'D', 9, 11, 4),
    ('REZEPTE', 'Verordnungen', 'D', 1, 12, 7),
    ('FELL', 'Pelz', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r049-13x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r049-13x13-03', 'Rätsel 49 · 13×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '13x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('TOBT', 'wütet', 'A', 1, 1, 4),
    ('LOT', 'Senkblei', 'A', 1, 6, 3),
    ('APP', 'Anwendung', 'A', 1, 10, 3),
    ('OPA', 'Großvater', 'A', 2, 1, 3),
    ('LABORS', 'Prüfstätten', 'A', 2, 5, 6),
    ('DESWEGEN', 'daher', 'A', 3, 1, 8),
    ('PRO', 'je', 'A', 3, 10, 3),
    ('RIESEN', 'Hünen', 'A', 4, 2, 6),
    ('CHOR', 'Singgruppe', 'A', 4, 9, 4),
    ('EHER', 'lieber', 'A', 5, 3, 4),
    ('ALT', 'ergraut', 'A', 5, 10, 3),
    ('UHR', 'Chronometer', 'A', 6, 1, 3),
    ('STAELLE', 'Viehhäuser', 'A', 6, 6, 7),
    ('TOTAL', 'völlig', 'A', 7, 1, 5),
    ('ERSTE', 'anfängliche', 'A', 7, 7, 5),
    ('OFEN', 'Wärmequelle', 'A', 8, 1, 4),
    ('ERDE', 'Welt', 'A', 8, 6, 4),
    ('MILDER', 'sanfter', 'A', 9, 7, 6),
    ('ORTE', 'Plätze', 'A', 10, 1, 4),
    ('BIN', 'Verbform', 'A', 10, 6, 3),
    ('RIO', 'Stadt in Brasilien', 'A', 10, 10, 3),
    ('MEERE', 'Ozeane', 'A', 11, 1, 5),
    ('NAMENS', 'mit Namen', 'A', 11, 7, 6),
    ('EHEN', 'Bündnisse', 'A', 12, 1, 4),
    ('OEL', 'Schmierstoff', 'A', 12, 6, 3),
    ('IST', 'befindet sich', 'A', 12, 10, 3),
    ('TOD', 'Ableben', 'D', 1, 1, 3),
    ('AUTONOME', 'unabhängige', 'D', 5, 1, 8),
    ('OPER', 'Musiktheater', 'D', 1, 2, 4),
    ('HOF', 'Grundstück', 'D', 6, 2, 3),
    ('REH', 'Waldbewohner', 'D', 10, 2, 3),
    ('BASIERTE', 'beruhte', 'D', 1, 3, 8),
    ('TEE', 'Heißgetränk', 'D', 10, 3, 3),
    ('WEH', 'schmerzhaft', 'D', 3, 4, 3),
    ('ANDERN', 'übrigen', 'D', 7, 4, 6),
    ('LESE', 'studiere', 'D', 2, 5, 4),
    ('LAGERS', 'Leiter des ...', 'D', 1, 6, 6),
    ('OBEN', 'in der Höhe', 'D', 1, 7, 4),
    ('TERMINE', 'Treffen', 'D', 6, 7, 7),
    ('TON', 'Lehm', 'D', 1, 8, 3),
    ('KARDINAL', 'Kirchenfürst', 'D', 5, 8, 8),
    ('ESEL', 'Grautier', 'D', 6, 9, 4),
    ('ASPHALT', 'Straßenbelag', 'D', 1, 10, 7),
    ('DREI', 'Zahl (2+1)', 'D', 9, 10, 4),
    ('ROLLE', 'Part', 'D', 3, 11, 5),
    ('EINS', 'Zahl (2−1)', 'D', 9, 11, 4),
    ('PFORTE', 'Tor', 'D', 1, 12, 6),
    ('TROST', 'Zuspruch', 'D', 8, 12, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r050-15x15-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r050-15x15-01', 'Rätsel 50 · 15×15', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '15x15-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('GANG', 'Flur', 'A', 1, 1, 4),
    ('ENG', 'knapp', 'A', 1, 6, 3),
    ('HALLE', 'Saal', 'A', 1, 10, 5),
    ('EREILTE', 'traf', 'A', 2, 1, 7),
    ('HOLE', 'besorge', 'A', 2, 9, 4),
    ('REUE', 'Zerknirschung', 'A', 3, 1, 4),
    ('AUF', 'offen', 'A', 3, 6, 3),
    ('LIEBE', 'Zuneigung', 'A', 3, 10, 5),
    ('ANTRAG', 'Gesuch', 'A', 4, 1, 6),
    ('ZAREN', 'russ. Kaiser', 'A', 4, 10, 5),
    ('DAR', 'stellt ... (zeigt)', 'A', 5, 1, 3),
    ('LEBTE', 'existierte', 'A', 5, 5, 5),
    ('HOB', 'wuchtete', 'A', 6, 12, 3),
    ('BLUETE', 'Blume', 'A', 7, 2, 6),
    ('BRAUNE', 'brünette', 'A', 7, 9, 6),
    ('FEE', 'Elfe', 'A', 8, 1, 3),
    ('MARKIERT', 'angestrichen', 'A', 8, 5, 8),
    ('MAG', 'hat gern', 'A', 9, 4, 3),
    ('BUG', 'Programmfehler', 'A', 9, 9, 3),
    ('STIEL', 'Griff', 'A', 10, 1, 5),
    ('KIEZ', 'Viertel', 'A', 10, 7, 4),
    ('PEST', 'Seuche', 'A', 11, 1, 4),
    ('KAHL', 'glatzköpfig', 'A', 11, 6, 4),
    ('REDE', 'Ansprache', 'A', 11, 11, 4),
    ('INTERNER', 'innerer', 'A', 12, 1, 8),
    ('DABEI', 'hierbei', 'A', 12, 10, 5),
    ('REISE', 'Fahrt', 'A', 13, 4, 5),
    ('ATOME', 'Teilchen', 'A', 13, 10, 5),
    ('LOB', 'Anerkennung', 'A', 14, 1, 3),
    ('HEERES', 'Führung des ...', 'A', 14, 5, 6),
    ('TOR', 'Treffer', 'A', 14, 12, 3),
    ('GERADE', 'eben', 'D', 1, 1, 6),
    ('SPIEL', 'Match', 'D', 10, 1, 5),
    ('ARENA', 'Kolosseum', 'D', 1, 2, 5),
    ('BESTEN', 'optimalen', 'D', 7, 2, 6),
    ('NEUTRALE', 'objektive', 'D', 1, 3, 8),
    ('IST', 'befindet sich', 'D', 10, 3, 3),
    ('GIER', 'Habsucht', 'D', 1, 4, 4),
    ('METER', 'Längenmaß', 'D', 9, 4, 5),
    ('ALLEMAL', 'sicher', 'D', 4, 5, 7),
    ('REH', 'Waldbewohner', 'D', 12, 5, 3),
    ('ETAGE', 'Stockwerk', 'D', 1, 6, 5),
    ('TAG', 'Kalenderblatt', 'D', 7, 6, 3),
    ('KNIE', 'Gelenk', 'D', 11, 6, 4),
    ('NEU', 'frisch', 'D', 1, 7, 3),
    ('BIER', 'Gerstensaft', 'D', 5, 7, 4),
    ('KAESE', 'Milchprodukt', 'D', 10, 7, 5),
    ('FIT', 'sportlich', 'D', 3, 8, 3),
    ('IHRER', 'seiner', 'D', 10, 8, 5),
    ('BIBEL', 'Heilige Schrift', 'D', 7, 9, 5),
    ('HOLZ', 'Werkstoff', 'D', 1, 10, 4),
    ('KREUZ', 'Rücken', 'D', 6, 10, 5),
    ('DAS', 'Artikel (sächl.)', 'D', 12, 10, 3),
    ('ALIAS', 'auch genannt', 'D', 1, 11, 5),
    ('ARG', 'schlimm', 'D', 7, 11, 3),
    ('RAT', 'Gremium', 'D', 11, 11, 3),
    ('LEER', 'hohl', 'D', 1, 12, 4),
    ('HUT', 'Vorsicht', 'D', 6, 12, 3),
    ('GEBOT', 'Weisung', 'D', 10, 12, 5),
    ('BETON', 'Baustoff', 'D', 3, 13, 5),
    ('DEMO', 'Kundgebung', 'D', 11, 13, 4),
    ('EBEN', 'just', 'D', 1, 14, 4),
    ('BERG', 'Gipfel', 'D', 6, 14, 4),
    ('EIER', 'Gelege', 'D', 11, 14, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r051-15x15-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r051-15x15-02', 'Rätsel 51 · 15×15', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '15x15-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('LOGOS', 'Embleme', 'A', 1, 1, 5),
    ('ABZUG', 'Rückzug', 'A', 1, 10, 5),
    ('UHR', 'Chronometer', 'A', 2, 1, 3),
    ('TEST', 'Klausur', 'A', 2, 5, 4),
    ('KAUFE', 'erwerbe', 'A', 2, 10, 5),
    ('FRAGE', 'Erkundigung', 'A', 3, 1, 5),
    ('KULTUREN', 'Lebensweisen', 'A', 3, 7, 8),
    ('DOLLAR', 'US-Währung', 'A', 4, 3, 6),
    ('TEIL', 'Fragment', 'A', 5, 4, 4),
    ('UNIS', 'Bildungsstätten', 'A', 5, 9, 4),
    ('SAMT', 'inklusive', 'A', 6, 1, 4),
    ('GAB', 'reichte', 'A', 6, 6, 3),
    ('KORN', 'Getreide', 'A', 6, 11, 4),
    ('TUE', 'verrichte', 'A', 7, 1, 3),
    ('HOFES', 'Mitte des ...', 'A', 7, 10, 5),
    ('ACH', 'Seufzer', 'A', 8, 1, 3),
    ('ENGER', 'schmaler', 'A', 8, 5, 5),
    ('NAH', 'unweit', 'A', 8, 11, 3),
    ('HERAN', 'herbei', 'A', 9, 1, 5),
    ('ROTE', 'purpurne', 'A', 9, 8, 4),
    ('BOSS', 'Chef', 'A', 10, 4, 4),
    ('PRO', 'per', 'A', 10, 12, 3),
    ('BETRAEGT', 'macht aus', 'A', 11, 2, 8),
    ('GLAS', 'Trinkgefäß', 'A', 11, 11, 4),
    ('ALB', 'Schwäbische ...', 'A', 12, 1, 3),
    ('MAN', 'Pronomen', 'A', 12, 5, 3),
    ('RAST', 'jagt', 'A', 12, 11, 4),
    ('MAEDELS', 'Girls', 'A', 13, 1, 7),
    ('CHANCE', 'Gelegenheit', 'A', 13, 9, 6),
    ('TUN', 'machen', 'A', 14, 1, 3),
    ('ECK', 'Winkel', 'A', 14, 7, 3),
    ('SEHR', 'überaus', 'A', 14, 11, 4),
    ('LUFT', 'Atmosphäre', 'D', 1, 1, 4),
    ('STAHL', 'legiertes Eisen', 'D', 6, 1, 5),
    ('AMT', 'Behörde', 'D', 12, 1, 3),
    ('OHR', 'Lauscher', 'D', 1, 2, 3),
    ('SAUCE', 'Soße', 'D', 5, 2, 5),
    ('BLAU', 'himmelfarben', 'D', 11, 2, 4),
    ('GRAD', 'Stufe', 'D', 1, 3, 4),
    ('MEHR', 'obendrein', 'D', 6, 3, 4),
    ('EBEN', 'just', 'D', 11, 3, 4),
    ('GOTT', 'Schöpfer', 'D', 3, 4, 4),
    ('ABT', 'Klosterchef', 'D', 9, 4, 3),
    ('STELE', 'Gedenkstein', 'D', 1, 5, 5),
    ('ENORMES', 'gewaltiges', 'D', 8, 5, 7),
    ('LIGEN', 'Spielklassen', 'D', 4, 6, 5),
    ('SAAL', 'Halle', 'D', 10, 6, 4),
    ('SKALA', 'Stufenleiter', 'D', 2, 7, 5),
    ('SENSE', 'Mähwerkzeug', 'D', 10, 7, 5),
    ('STUR', 'unnachgiebig', 'D', 1, 8, 4),
    ('BAER', 'Raubtier', 'D', 6, 8, 4),
    ('ROSTOCK', 'Hansestadt', 'D', 8, 9, 7),
    ('AKTEN', 'Dokumente', 'D', 1, 10, 5),
    ('BAU', 'Konstruktion', 'D', 1, 11, 3),
    ('IKONE', 'Heiligenbild', 'D', 5, 11, 5),
    ('GRAS', 'Rasen', 'D', 11, 11, 4),
    ('ZUR', 'zu der', 'D', 1, 12, 3),
    ('SOFA', 'Couch', 'D', 5, 12, 4),
    ('PLANE', 'beabsichtige', 'D', 10, 12, 5),
    ('UFER', 'Küste', 'D', 1, 13, 4),
    ('REH', 'Waldbewohner', 'D', 6, 13, 3),
    ('RASCH', 'schnell', 'D', 10, 13, 5),
    ('GEN', 'nach', 'D', 1, 14, 3),
    ('INS', 'in das', 'D', 5, 14, 3),
    ('POSTER', 'Plakat', 'D', 9, 14, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r052-15x15-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r052-15x15-03', 'Rätsel 52 · 15×15', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '15x15-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('EICHE', 'Laubbaum', 'A', 1, 1, 5),
    ('BRETTERN', 'Planken', 'A', 1, 7, 8),
    ('BREI', 'Mus', 'A', 2, 1, 4),
    ('MAUS', 'Nager', 'A', 2, 6, 4),
    ('BANN', 'Zauber', 'A', 3, 1, 4),
    ('AUFS', 'auf das', 'A', 3, 6, 4),
    ('PATE', 'Taufzeuge', 'A', 3, 11, 4),
    ('ENTGELT', 'Vergütung', 'A', 4, 1, 7),
    ('DES', 'Artikel (Genitiv)', 'A', 4, 12, 3),
    ('REIS', 'Sushi-Zutat', 'A', 5, 11, 4),
    ('STAB', 'Stock', 'A', 6, 1, 4),
    ('RIO', 'Stadt in Brasilien', 'A', 6, 6, 3),
    ('HELLE', 'lichte', 'A', 6, 10, 5),
    ('ERLEBEN', 'erfahren', 'A', 7, 1, 7),
    ('GASSE', 'Durchgang', 'A', 7, 9, 5),
    ('TAL', 'Niederung', 'A', 8, 1, 3),
    ('EISZEIT', 'Glazial', 'A', 8, 5, 7),
    ('EDLE', 'noble', 'A', 9, 11, 4),
    ('DESTO', 'umso', 'A', 10, 1, 5),
    ('KUH', 'Milchlieferantin', 'A', 10, 7, 3),
    ('NEID', 'Missgunst', 'A', 10, 11, 4),
    ('ORT', 'Platz', 'A', 11, 1, 3),
    ('MALERS', 'Pinsel des ...', 'A', 11, 5, 6),
    ('FEE', 'Elfe', 'A', 11, 12, 3),
    ('STURM', 'Orkan', 'A', 12, 1, 5),
    ('ABT', 'Klosterchef', 'A', 12, 7, 3),
    ('GEBT', 'reicht', 'A', 12, 11, 4),
    ('BESAGTE', 'erwähnte', 'A', 13, 3, 7),
    ('AKT', 'Nacktgemälde', 'A', 13, 11, 3),
    ('SIEHT', 'gewahrt', 'A', 14, 1, 5),
    ('RASTEN', 'ruhen', 'A', 14, 9, 6),
    ('EBBE', 'Niedrigwasser', 'D', 1, 1, 4),
    ('SET', 'Satz', 'D', 6, 1, 3),
    ('DOSIS', 'Menge', 'D', 10, 1, 5),
    ('IRAN', 'Golfstaat', 'D', 1, 2, 4),
    ('TRAUERT', 'klagt', 'D', 6, 2, 7),
    ('CENT', 'Hundertstel Euro', 'D', 1, 3, 4),
    ('ALL', 'Weltraum', 'D', 6, 3, 3),
    ('STUBE', 'Zimmer', 'D', 10, 3, 5),
    ('HINGABE', 'Aufopferung', 'D', 1, 4, 7),
    ('REH', 'Waldbewohner', 'D', 12, 4, 3),
    ('BEKOMMST', 'erhältst', 'D', 7, 5, 8),
    ('MALEREI', 'Kunst', 'D', 2, 6, 7),
    ('BAUT', 'errichtet', 'D', 1, 7, 4),
    ('INS', 'in das', 'D', 6, 7, 3),
    ('KLAGE', 'Beschwerde', 'D', 10, 7, 5),
    ('RUF', 'Leumund', 'D', 1, 8, 3),
    ('UEBT', 'trainiert', 'D', 10, 8, 4),
    ('ESSE', 'speise', 'D', 1, 9, 4),
    ('GEEHRTER', 'werter', 'D', 7, 9, 8),
    ('HAI', 'Raubfisch', 'D', 6, 10, 3),
    ('TYP', 'Exemplar', 'D', 1, 11, 3),
    ('RESTEN', 'Abfällen', 'D', 5, 11, 6),
    ('GAS', 'Brennstoff', 'D', 12, 11, 3),
    ('ADELS', 'Titel des ...', 'D', 3, 12, 5),
    ('DEFEKT', 'Schaden', 'D', 9, 12, 6),
    ('TEILE', 'Stücke', 'D', 3, 13, 5),
    ('LIEBTE', 'verehrte', 'D', 9, 13, 6),
    ('NUESSE', 'Kerne', 'D', 1, 14, 6),
    ('REDET', 'spricht', 'D', 8, 14, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r053-8x8-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r053-8x8-01', 'Rätsel 53 · 8×8', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '8x8-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('OPER', 'Musiktheater', 'A', 1, 1, 4),
    ('EINIGE', 'diverse', 'A', 2, 1, 6),
    ('LAGERN', 'Depots', 'A', 3, 1, 6),
    ('TAGE', 'je 24 Stunden', 'A', 4, 4, 4),
    ('WOG', 'schwankte', 'A', 5, 1, 3),
    ('BEI', 'nahe an', 'A', 5, 5, 3),
    ('ADERN', 'Venen', 'A', 6, 3, 5),
    ('EIS', 'Gefrorenes', 'A', 7, 1, 3),
    ('SEE', 'Gewässer', 'A', 7, 5, 3),
    ('OEL', 'Rohstoff', 'D', 1, 1, 3),
    ('WIE', 'gleich', 'D', 5, 1, 3),
    ('PIANO', 'Klavier', 'D', 1, 2, 5),
    ('ENG', 'knapp', 'D', 1, 3, 3),
    ('GAS', 'Brennstoff', 'D', 5, 3, 3),
    ('RIET', 'empfahl', 'D', 1, 4, 4),
    ('GRABES', 'Stille des ...', 'D', 2, 5, 6),
    ('ENGERE', 'schmalere', 'D', 2, 6, 6),
    ('EINE', 'unbest. Artikel (w.)', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r054-8x8-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r054-8x8-02', 'Rätsel 54 · 8×8', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '8x8-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('TYPS', 'Art des ...', 'A', 1, 4, 4),
    ('PAARE', 'Duos', 'A', 2, 1, 5),
    ('AHNEN', 'vermuten', 'A', 3, 1, 5),
    ('NETT', 'freundlich', 'A', 4, 1, 4),
    ('REMIS', 'Gleichstand', 'A', 5, 3, 5),
    ('ANIME', 'jap. Zeichentrick', 'A', 6, 3, 5),
    ('WEG', 'Route', 'A', 7, 1, 3),
    ('TAT', 'Handlung', 'A', 7, 5, 3),
    ('PANKOW', 'Berliner Bezirk', 'D', 2, 1, 6),
    ('NAHE', 'benachbart', 'D', 1, 2, 4),
    ('ANTRAG', 'Gesuch', 'D', 2, 3, 6),
    ('TRETEN', 'kicken', 'D', 1, 4, 6),
    ('YEN', 'Nippon-Währung', 'D', 1, 5, 3),
    ('MIT', 'samt', 'D', 5, 5, 3),
    ('LIMA', 'peruan. Hauptstadt', 'D', 4, 6, 4),
    ('SEX', 'Geschlecht', 'D', 1, 7, 3),
    ('SET', 'Ausstattung', 'D', 5, 7, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r055-8x8-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r055-8x8-03', 'Rätsel 55 · 8×8', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '8x8-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('BOOTES', 'Rumpf des ...', 'A', 1, 1, 6),
    ('PROBEN', 'Muster', 'A', 2, 2, 6),
    ('HATTEN', 'besaßen', 'A', 3, 1, 6),
    ('ENDE', 'Finale', 'A', 4, 4, 4),
    ('UND', 'sowie', 'A', 5, 1, 3),
    ('DEN', 'Artikel (Akkusativ)', 'A', 5, 5, 3),
    ('TUE', 'verrichte', 'A', 6, 1, 3),
    ('ARG', 'schlimm', 'A', 6, 5, 3),
    ('ERST', 'anfangs', 'A', 7, 1, 4),
    ('HEUTE', 'an diesem Tag', 'D', 3, 1, 5),
    ('OPA', 'Opi', 'D', 1, 2, 3),
    ('NUR', 'bloß', 'D', 5, 2, 3),
    ('ORT', 'Stelle', 'D', 1, 3, 3),
    ('DES', 'Artikel (Genitiv)', 'D', 5, 3, 3),
    ('TOTE', 'Verstorbene', 'D', 1, 4, 4),
    ('EBENDA', 'an selber Stelle', 'D', 1, 5, 6),
    ('SENDER', 'Kanal', 'D', 1, 6, 6),
    ('ENGE', 'schmale', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r056-9x9-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r056-9x9-01', 'Rätsel 56 · 9×9', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '9x9-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('EWIG', 'unaufhörlich', 'A', 1, 1, 4),
    ('LOS', 'frei', 'A', 1, 6, 3),
    ('REGE', 'geschäftig', 'A', 2, 1, 4),
    ('AMT', 'Behörde', 'A', 2, 6, 3),
    ('LIEB', 'nett', 'A', 3, 1, 4),
    ('GAR', 'völlig', 'A', 3, 6, 3),
    ('ALLE', 'Pronomen', 'A', 4, 1, 4),
    ('KAMM', 'Grat', 'A', 5, 5, 4),
    ('BITTERE', 'herbe', 'A', 6, 1, 7),
    ('THEORIE', 'Lehre', 'A', 7, 1, 7),
    ('REDNER', 'Sprecher', 'A', 8, 2, 6),
    ('ERLAUBT', 'gestattet', 'D', 1, 1, 7),
    ('WEIL', 'da', 'D', 1, 2, 4),
    ('IHR', 'Pronomen (2. Pl.)', 'D', 6, 2, 3),
    ('IGEL', 'Stacheltier', 'D', 1, 3, 4),
    ('TEE', 'Heißgetränk', 'D', 6, 3, 3),
    ('GEBE', 'reiche', 'D', 1, 4, 4),
    ('TOD', 'Ableben', 'D', 6, 4, 3),
    ('KERN', 'Mittelpunkt', 'D', 5, 5, 4),
    ('LAG', 'befand sich', 'D', 1, 6, 3),
    ('ARIE', 'Opernlied', 'D', 5, 6, 4),
    ('OMA', 'Omi', 'D', 1, 7, 3),
    ('MEER', 'See', 'D', 5, 7, 4),
    ('STROM', 'Fluss', 'D', 1, 8, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r057-9x9-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r057-9x9-02', 'Rätsel 57 · 9×9', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x9-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('KUBA', 'Karibikinsel', 'A', 1, 1, 4),
    ('AKT', 'Nacktgemälde', 'A', 1, 6, 3),
    ('ANIME', 'jap. Zeichentrick', 'A', 2, 1, 5),
    ('MITTLER', 'Makler', 'A', 3, 1, 7),
    ('BIST', 'existierst', 'A', 4, 5, 4),
    ('SEITEN', 'Flanken', 'A', 5, 1, 6),
    ('AUGE', 'Pupille', 'A', 6, 1, 4),
    ('BUS', 'Nahverkehrsmittel', 'A', 6, 6, 3),
    ('FREI', 'ungebunden', 'A', 7, 1, 4),
    ('ALT', 'ergraut', 'A', 7, 6, 3),
    ('TOLL', 'großartig', 'A', 8, 1, 4),
    ('UMS', 'um das', 'A', 8, 6, 3),
    ('KAM', 'traf ein', 'D', 1, 1, 3),
    ('SAFT', 'Most', 'D', 5, 1, 4),
    ('UNI', 'Hochschule', 'D', 1, 2, 3),
    ('EURO', 'EU-Zahlungsmittel', 'D', 5, 2, 4),
    ('BIT', 'Dualziffer', 'D', 1, 3, 3),
    ('IGEL', 'Stacheltier', 'D', 5, 3, 4),
    ('AMT', 'Behörde', 'D', 1, 4, 3),
    ('TEIL', 'Stück', 'D', 5, 4, 4),
    ('ELBE', 'Strom durch Dresden', 'D', 2, 5, 4),
    ('EINBAU', 'Montage', 'D', 3, 6, 6),
    ('KURS', 'Richtung', 'D', 1, 7, 4),
    ('ULM', 'Münsterstadt', 'D', 6, 7, 3),
    ('TESTS', 'Prüfungen', 'D', 4, 8, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r058-9x9-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r058-9x9-03', 'Rätsel 58 · 9×9', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '9x9-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('IRAK', 'Land am Tigris', 'A', 1, 1, 4),
    ('ALB', 'Schwäbische ...', 'A', 1, 6, 3),
    ('HERR', 'Gebieter', 'A', 2, 1, 4),
    ('BEI', 'nahe an', 'A', 2, 6, 3),
    ('RIGA', 'lett. Hauptstadt', 'A', 3, 1, 4),
    ('HIT', 'Chartstürmer', 'A', 3, 6, 3),
    ('FLOP', 'Reinfall', 'A', 4, 4, 4),
    ('STOLZE', 'hochmütige', 'A', 5, 3, 6),
    ('AUE', 'Wiesenland', 'A', 6, 1, 3),
    ('SEID', 'existiert', 'A', 6, 5, 4),
    ('UNI', 'Hochschule', 'A', 7, 1, 3),
    ('ENGE', 'schmale', 'A', 7, 5, 4),
    ('EDLEN', 'vornehmen', 'A', 8, 1, 5),
    ('IHR', 'Pronomen (2. Pl.)', 'D', 1, 1, 3),
    ('RAUE', 'grobe', 'D', 5, 1, 4),
    ('REIF', 'erntefertig', 'D', 1, 2, 4),
    ('UND', 'sowie', 'D', 6, 2, 3),
    ('ARG', 'übel', 'D', 1, 3, 3),
    ('SEIL', 'Tau', 'D', 5, 3, 4),
    ('KRAFT', 'Stärke', 'D', 1, 4, 5),
    ('LOSEN', 'lockeren', 'D', 4, 5, 5),
    ('ABHOLEN', 'mitnehmen', 'D', 1, 6, 7),
    ('LEIPZIG', 'Messestadt', 'D', 1, 7, 7),
    ('BIT', 'Dualziffer', 'D', 1, 8, 3),
    ('EDEL', 'wertvoll', 'D', 5, 8, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r059-9x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r059-9x13-01', 'Rätsel 59 · 9×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '9x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('DIAS', 'Lichtbilder', 'A', 1, 1, 4),
    ('REIBUNG', 'Friktion', 'A', 1, 6, 7),
    ('ECHT', 'authentisch', 'A', 2, 1, 4),
    ('HANAU', 'Stadt am Main', 'A', 2, 8, 5),
    ('AHNUNG', 'Vorgefühl', 'A', 3, 1, 6),
    ('REIST', 'tourt', 'A', 3, 8, 5),
    ('THEATER', 'Bühne', 'A', 4, 3, 7),
    ('LILA', 'Violett', 'A', 5, 4, 4),
    ('ARM', 'Gliedmaße', 'A', 6, 1, 3),
    ('GENF', 'Stadt am Léman', 'A', 6, 5, 4),
    ('AST', 'Zweig', 'A', 6, 10, 3),
    ('MAI', '5. Monat', 'A', 7, 1, 3),
    ('ENGE', 'schmale', 'A', 7, 5, 4),
    ('HEU', 'Viehfutter', 'A', 7, 10, 3),
    ('TURIN', 'Stadt am Po', 'A', 8, 1, 5),
    ('OEFTER', 'häufiger', 'A', 8, 7, 6),
    ('DEAL', 'Abmachung', 'D', 1, 1, 4),
    ('AMT', 'Behörde', 'D', 6, 1, 3),
    ('ICH', 'Pronomen (1. Sg.)', 'D', 1, 2, 3),
    ('FRAU', 'Gemahlin', 'D', 5, 2, 4),
    ('AHNT', 'spürt', 'D', 1, 3, 4),
    ('MIR', 'Dat. (1. Pers.)', 'D', 6, 3, 3),
    ('STUHL', 'Sitz', 'D', 1, 4, 5),
    ('NEIGEN', 'tendieren', 'D', 3, 5, 6),
    ('REGALEN', 'Borden', 'D', 1, 6, 7),
    ('TANGO', 'argent. Tanz', 'D', 4, 7, 5),
    ('IHRE', 'seine', 'D', 1, 8, 4),
    ('FEE', 'Elfe', 'D', 6, 8, 3),
    ('BAER', 'Petz', 'D', 1, 9, 4),
    ('UNI', 'Hochschule', 'D', 1, 10, 3),
    ('NAHT', 'kommt näher', 'D', 5, 10, 4),
    ('NASS', 'feucht', 'D', 1, 11, 4),
    ('SEE', 'Gewässer', 'D', 6, 11, 3),
    ('GUT', 'brauchbar', 'D', 1, 12, 3),
    ('STUR', 'unnachgiebig', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r060-9x13-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r060-9x13-02', 'Rätsel 60 · 9×13', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '9x13-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('OHR', 'Lauscher', 'A', 1, 1, 3),
    ('KAM', 'nahte', 'A', 1, 6, 3),
    ('OMA', 'Großmutter', 'A', 1, 10, 3),
    ('BAU', 'Konstruktion', 'A', 2, 1, 3),
    ('LOSE', 'locker', 'A', 2, 5, 4),
    ('BAR', 'Theke', 'A', 2, 10, 3),
    ('WAHL', 'Abstimmung', 'A', 3, 1, 4),
    ('SCHWEIZ', 'Helvetia', 'A', 3, 6, 7),
    ('ORTE', 'Plätze', 'A', 4, 1, 4),
    ('THRON', 'Königssitz', 'A', 4, 6, 5),
    ('IDEE', 'Einfall', 'A', 5, 4, 4),
    ('LONDON', 'Themsestadt', 'A', 6, 1, 6),
    ('ALARM', 'Warnsignal', 'A', 6, 8, 5),
    ('PIER', 'Anleger', 'A', 7, 2, 4),
    ('AUFBAU', 'Struktur', 'A', 7, 7, 6),
    ('HAETTE', 'besäße', 'A', 8, 1, 6),
    ('SETZT', 'stellt', 'A', 8, 8, 5),
    ('OBWOHL', 'wenngleich', 'D', 1, 1, 6),
    ('HAAR', 'Strähne', 'D', 1, 2, 4),
    ('OPA', 'Großvater', 'D', 6, 2, 3),
    ('RUHT', 'rastet', 'D', 1, 3, 4),
    ('NIE', 'zu keiner Zeit', 'D', 6, 3, 3),
    ('LEIDET', 'duldet', 'D', 3, 4, 6),
    ('DORT', 'an jenem Ort', 'D', 5, 5, 4),
    ('KOSTEN', 'Auslagen', 'D', 1, 6, 6),
    ('ASCHE', 'Glutrest', 'D', 1, 7, 5),
    ('MEHR', 'zusätzlich', 'D', 1, 8, 4),
    ('AUS', 'vorbei', 'D', 6, 8, 3),
    ('WOELFE', 'Rudeltiere', 'D', 3, 9, 6),
    ('OBEN', 'in der Höhe', 'D', 1, 10, 4),
    ('ABT', 'Klosterchef', 'D', 6, 10, 3),
    ('MAI', '5. Monat', 'D', 1, 11, 3),
    ('GRAZ', 'Murstadt', 'D', 5, 11, 4),
    ('ARZT', 'Doktor', 'D', 1, 12, 4),
    ('MUT', 'Tapferkeit', 'D', 6, 12, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r061-9x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r061-9x13-03', 'Rätsel 61 · 9×13', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '9x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('OPER', 'Musiktheater', 'A', 1, 1, 4),
    ('SYMPTOM', 'Anzeichen', 'A', 1, 6, 7),
    ('REGALE', 'Borde', 'A', 2, 1, 6),
    ('AROMA', 'Geschmack', 'A', 2, 8, 5),
    ('TRATEN', 'schritten', 'A', 3, 1, 6),
    ('TOTAL', 'völlig', 'A', 3, 8, 5),
    ('GAST', 'Besucher', 'A', 4, 5, 4),
    ('BETT', 'Schlafstätte', 'A', 5, 4, 4),
    ('EBBE', 'Niedrigwasser', 'A', 5, 9, 4),
    ('ATHEN', 'griech. Hauptstadt', 'A', 6, 1, 5),
    ('AKTIEN', 'Wertpapiere', 'A', 6, 7, 6),
    ('BOARD', 'Gremium', 'A', 7, 1, 5),
    ('WEIT', 'fern', 'A', 7, 9, 4),
    ('ENTGELT', 'Vergütung', 'A', 8, 1, 7),
    ('ARME', 'Mittellose', 'A', 8, 9, 4),
    ('ORT', 'Stelle', 'D', 1, 1, 3),
    ('GABE', 'Geschenk', 'D', 5, 1, 4),
    ('PER', 'mittels', 'D', 1, 2, 3),
    ('TON', 'Lehm', 'D', 6, 2, 3),
    ('EGAL', 'gleichgültig', 'D', 1, 3, 4),
    ('HAT', 'besitzt', 'D', 6, 3, 3),
    ('RAT', 'Tipp', 'D', 1, 4, 3),
    ('BERG', 'Anhöhe', 'D', 5, 4, 4),
    ('LEGENDE', 'Sage', 'D', 2, 5, 7),
    ('SENAT', 'Stadtregierung', 'D', 1, 6, 5),
    ('STADT', 'Metropole', 'D', 4, 7, 5),
    ('MATT', 'Schachende', 'D', 1, 8, 4),
    ('PRO', 'per', 'D', 1, 9, 3),
    ('ETWA', 'ungefähr', 'D', 5, 9, 4),
    ('TOT', 'verstorben', 'D', 1, 10, 3),
    ('BIER', 'Gerstensaft', 'D', 5, 10, 4),
    ('OMA', 'Großmutter', 'D', 1, 11, 3),
    ('BEIM', 'bei dem', 'D', 5, 11, 4),
    ('MAL', 'Zeichen ×', 'D', 1, 12, 3),
    ('ENTE', 'Wasservogel', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r062-10x10-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r062-10x10-01', 'Rätsel 62 · 10×10', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '10x10-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ACH', 'Ausruf', 'A', 1, 1, 3),
    ('LIST', 'Trick', 'A', 1, 6, 4),
    ('LOEST', 'klärt', 'A', 2, 1, 5),
    ('HEU', 'Trockengras', 'A', 2, 7, 3),
    ('LOGE', 'Theaterrang', 'A', 3, 1, 4),
    ('URIN', 'Harn', 'A', 3, 6, 4),
    ('ELTERN', 'Vater und Mutter', 'A', 4, 1, 6),
    ('MODULE', 'Bausteine', 'A', 5, 4, 6),
    ('EKLAT', 'Skandal', 'A', 6, 1, 5),
    ('MAN', 'Pronomen', 'A', 6, 7, 3),
    ('RUIN', 'Untergang', 'A', 7, 1, 4),
    ('OBST', 'Früchte', 'A', 7, 6, 4),
    ('DENN', 'Konjunktion', 'A', 8, 1, 4),
    ('HASE', 'Meister Lampe', 'A', 8, 6, 4),
    ('ERZ', 'Gestein', 'A', 9, 1, 3),
    ('GRUEN', 'unreif', 'A', 9, 5, 5),
    ('ALLE', 'sämtliche', 'D', 1, 1, 4),
    ('ERDE', 'Welt', 'D', 6, 1, 4),
    ('COOL', 'lässig', 'D', 1, 2, 4),
    ('KUER', 'freies Programm', 'D', 6, 2, 4),
    ('HEGT', 'pflegt', 'D', 1, 3, 4),
    ('LINZ', 'Hauptstadt OÖ', 'D', 6, 3, 4),
    ('SEEMANN', 'Matrose', 'D', 2, 4, 7),
    ('ROT', 'purpurn', 'D', 4, 5, 3),
    ('UND', 'sowie', 'D', 3, 6, 3),
    ('OHR', 'Hörorgan', 'D', 7, 6, 3),
    ('IHR', 'Pronomen (2. Pl.)', 'D', 1, 7, 3),
    ('UMBAU', 'Renovierung', 'D', 5, 7, 5),
    ('SEI', 'existiere', 'D', 1, 8, 3),
    ('LASSE', 'erlaube', 'D', 5, 8, 5),
    ('TUN', 'machen', 'D', 1, 9, 3),
    ('ENTEN', 'Wasservögel', 'D', 5, 9, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r063-10x10-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r063-10x10-02', 'Rätsel 63 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('IHM', 'Dativ von er', 'A', 1, 1, 3),
    ('WOBEI', 'während', 'A', 1, 5, 5),
    ('SAITE', 'Draht', 'A', 2, 1, 5),
    ('ACH', 'Seufzer', 'A', 2, 7, 3),
    ('TIROL', 'Alpenland', 'A', 3, 1, 5),
    ('UHR', 'Chronometer', 'A', 3, 7, 3),
    ('BLUETE', 'Blume', 'A', 4, 4, 6),
    ('ELSTER', 'Rabenvogel', 'A', 5, 1, 6),
    ('VIA', 'durch', 'A', 6, 1, 3),
    ('NETT', 'sympathisch', 'A', 6, 6, 4),
    ('ENG', 'schmal', 'A', 7, 1, 3),
    ('KENIA', 'Staat in Ostafrika', 'A', 7, 5, 5),
    ('NIE', 'zu keiner Zeit', 'A', 8, 1, 3),
    ('UNTEN', 'am Grund', 'A', 8, 5, 5),
    ('TENOR', 'Sängerstimme', 'A', 9, 1, 5),
    ('ERZ', 'Bodenschatz', 'A', 9, 7, 3),
    ('IST', 'befindet sich', 'D', 1, 1, 3),
    ('EVENT', 'Ereignis', 'D', 5, 1, 5),
    ('HAI', 'Raubfisch', 'D', 1, 2, 3),
    ('LINIE', 'Strich', 'D', 5, 2, 5),
    ('MIR', 'Dat. (1. Pers.)', 'D', 1, 3, 3),
    ('SAGEN', 'äußern', 'D', 5, 3, 5),
    ('TOBT', 'wütet', 'D', 2, 4, 4),
    ('WELLE', 'Woge', 'D', 1, 5, 5),
    ('KUR', 'Heilaufenthalt', 'D', 7, 5, 3),
    ('URNEN', 'Aschengefäße', 'D', 4, 6, 5),
    ('BAUE', 'errichte', 'D', 1, 7, 4),
    ('ENTE', 'Falschmeldung', 'D', 6, 7, 4),
    ('ECHT', 'authentisch', 'D', 1, 8, 4),
    ('TIER', 'Lebewesen', 'D', 6, 8, 4),
    ('IHRE', 'seine', 'D', 1, 9, 4),
    ('TANZ', 'Ball', 'D', 6, 9, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r064-10x10-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r064-10x10-03', 'Rätsel 64 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('BREAK', 'Pause', 'A', 1, 1, 5),
    ('BEI', 'nahe an', 'A', 1, 7, 3),
    ('LAND', 'Nation', 'A', 2, 1, 4),
    ('EIS', 'Sorbet', 'A', 2, 7, 3),
    ('AUGE', 'Pupille', 'A', 3, 1, 4),
    ('GALT', 'zählte', 'A', 3, 6, 4),
    ('SEELEUTE', 'Matrosen', 'A', 4, 1, 8),
    ('ERLITT', 'erduldete', 'A', 5, 1, 6),
    ('GAESTE', 'Besucher', 'A', 6, 4, 6),
    ('UMWEG', 'Abstecher', 'A', 7, 1, 5),
    ('OEL', 'Rohstoff', 'A', 7, 7, 3),
    ('HAI', 'Meeresräuber', 'A', 8, 1, 3),
    ('EKLAT', 'Skandal', 'A', 8, 5, 5),
    ('RIEF', 'schrie', 'A', 9, 1, 4),
    ('OMA', 'Omi', 'A', 9, 7, 3),
    ('BLASE', 'Clique (ugs.)', 'D', 1, 1, 5),
    ('UHR', 'Zeitmesser', 'D', 7, 1, 3),
    ('RAUER', 'grober', 'D', 1, 2, 5),
    ('MAI', 'Wonnemonat', 'D', 7, 2, 3),
    ('ENGEL', 'Himmelsbote', 'D', 1, 3, 5),
    ('WIE', 'gleich', 'D', 7, 3, 3),
    ('ADELIGE', 'Edelfrau', 'D', 1, 4, 7),
    ('ETAGE', 'Stockwerk', 'D', 4, 5, 5),
    ('GUTE', 'anständige', 'D', 3, 6, 4),
    ('BEAT', 'Rhythmus', 'D', 1, 7, 4),
    ('SOLO', 'allein', 'D', 6, 7, 4),
    ('EILE', 'Hast', 'D', 1, 8, 4),
    ('TEAM', 'Crew', 'D', 6, 8, 4),
    ('IST', 'befindet sich', 'D', 1, 9, 3),
    ('DELTA', 'Mündung', 'D', 5, 9, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r065-10x10-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r065-10x10-04', 'Rätsel 65 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('LEST', 'studiert', 'A', 1, 1, 4),
    ('STIL', 'Machart', 'A', 1, 6, 4),
    ('ORT', 'Platz', 'A', 2, 1, 3),
    ('MORDE', 'Tötungen', 'A', 2, 5, 5),
    ('KLUG', 'gescheit', 'A', 3, 1, 4),
    ('FUER', 'zugunsten', 'A', 3, 6, 4),
    ('SAFE', 'Panzerschrank', 'A', 4, 1, 4),
    ('EHEN', 'Bündnisse', 'A', 4, 6, 4),
    ('GEBORENE', 'gebürtige', 'A', 5, 2, 8),
    ('IHN', 'Akkusativ von er', 'A', 6, 4, 3),
    ('UNTER', 'Präposition', 'A', 7, 1, 5),
    ('DUO', 'Paar', 'A', 7, 7, 3),
    ('HEUTE', 'an diesem Tag', 'A', 8, 1, 5),
    ('ELF', 'Zahl (10+1)', 'A', 8, 7, 3),
    ('NUN', 'jetzt', 'A', 9, 1, 3),
    ('NIMMT', 'greift', 'A', 9, 5, 5),
    ('LOKS', 'Triebwagen', 'D', 1, 1, 4),
    ('HUHN', 'Henne', 'D', 6, 1, 4),
    ('ERLAG', 'starb an', 'D', 1, 2, 5),
    ('NEU', 'aktuell', 'D', 7, 2, 3),
    ('STUFE', 'Tritt', 'D', 1, 3, 5),
    ('TUN', 'machen', 'D', 7, 3, 3),
    ('GEBIET', 'Region', 'D', 3, 4, 6),
    ('OHREN', 'Hörorgane', 'D', 5, 5, 5),
    ('SOFERN', 'falls', 'D', 1, 6, 6),
    ('TRUHE', 'Kiste', 'D', 1, 7, 5),
    ('DEM', 'Artikel (Dativ)', 'D', 7, 7, 3),
    ('IDEEN', 'Einfälle', 'D', 1, 8, 5),
    ('ULM', 'Einstein-Geburtsstadt', 'D', 7, 8, 3),
    ('LERNE', 'pauke', 'D', 1, 9, 5),
    ('OFT', 'des Öfteren', 'D', 7, 9, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r066-11x11-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r066-11x11-01', 'Rätsel 66 · 11×11', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '11x11-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ODER', 'bzw.', 'A', 1, 1, 4),
    ('TIPPS', 'Ratschläge', 'A', 1, 6, 5),
    ('HAI', 'Meeresräuber', 'A', 2, 1, 3),
    ('ART', 'Sorte', 'A', 2, 8, 3),
    ('RUNDET', 'ergänzt', 'A', 3, 1, 6),
    ('TOR', 'Treffer', 'A', 3, 8, 3),
    ('LESE', 'schmökere', 'A', 4, 7, 4),
    ('AROMA', 'Geschmack', 'A', 5, 1, 5),
    ('IRAN', 'Persien', 'A', 5, 7, 4),
    ('ROSEN', 'Dornblumen', 'A', 6, 3, 5),
    ('TOD', 'Ableben', 'A', 7, 1, 3),
    ('SIEGE', 'Triumphe', 'A', 7, 5, 5),
    ('EHEN', 'Verbindungen', 'A', 8, 1, 4),
    ('NAEHE', 'Umgebung', 'A', 8, 6, 5),
    ('INNE', '... halten', 'A', 9, 1, 4),
    ('IRREN', 'sich täuschen', 'A', 9, 6, 5),
    ('LESUNG', 'Vortrag', 'A', 10, 1, 6),
    ('ARG', 'übel', 'A', 10, 8, 3),
    ('OHR', 'Hörorgan', 'D', 1, 1, 3),
    ('ANTEIL', 'Quote', 'D', 5, 1, 6),
    ('DAUER', 'Zeitspanne', 'D', 1, 2, 5),
    ('OHNE', 'abzüglich', 'D', 7, 2, 4),
    ('EIN', 'unbest. Artikel', 'D', 1, 3, 3),
    ('ORDENS', 'Mitglied des ...', 'D', 5, 3, 6),
    ('DEMO', 'Kundgebung', 'D', 3, 4, 4),
    ('NEU', 'aktuell', 'D', 8, 4, 3),
    ('ASS', 'speiste', 'D', 5, 5, 3),
    ('TOT', 'leblos', 'D', 1, 6, 3),
    ('EINIG', 'konform', 'D', 6, 6, 5),
    ('LINEAR', 'geradlinig', 'D', 4, 7, 6),
    ('PATER', 'Mönch', 'D', 1, 8, 5),
    ('GERA', 'Stadt in Thüringen', 'D', 7, 8, 4),
    ('PROSA', 'Erzähltext', 'D', 1, 9, 5),
    ('EHER', 'vielmehr', 'D', 7, 9, 4),
    ('STRENG', 'rigoros', 'D', 1, 10, 6),
    ('ENG', 'knapp', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r067-11x11-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r067-11x11-02', 'Rätsel 67 · 11×11', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '11x11-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('BIN', 'Verbform', 'A', 1, 1, 3),
    ('PFLEGE', 'Fürsorge', 'A', 1, 5, 6),
    ('ESEL', 'Dickkopf', 'A', 2, 1, 4),
    ('RATEN', 'empfehlen', 'A', 2, 6, 5),
    ('ART', 'Spezies', 'A', 3, 1, 3),
    ('ZUGANG', 'Zufahrt', 'A', 3, 5, 6),
    ('TAT', 'Handlung', 'A', 4, 1, 3),
    ('ECHO', 'Widerhall', 'A', 5, 4, 4),
    ('BLECH', 'Metallplatte', 'A', 6, 1, 5),
    ('BAND', 'Fessel', 'A', 6, 7, 4),
    ('SKELETTE', 'Gerippe', 'A', 7, 3, 8),
    ('INS', 'in das', 'A', 8, 1, 3),
    ('FIRMEN', 'Betriebe', 'A', 8, 5, 6),
    ('HEER', 'Armee', 'A', 9, 1, 4),
    ('LEERE', 'Öde', 'A', 9, 6, 5),
    ('NUN', 'inzwischen', 'A', 10, 1, 3),
    ('KANTEN', 'Ränder', 'A', 10, 5, 6),
    ('BEAT', 'Rhythmus', 'D', 1, 1, 4),
    ('IHN', 'Akkusativ von er', 'D', 8, 1, 3),
    ('ISRAEL', 'Nahoststaat', 'D', 1, 2, 6),
    ('NEU', 'frisch', 'D', 8, 2, 3),
    ('NETT', 'freundlich', 'D', 1, 3, 4),
    ('ESSEN', 'Ruhrgebietsstadt', 'D', 6, 3, 5),
    ('ECK', 'Kante', 'D', 5, 4, 3),
    ('CHEF', 'Boss', 'D', 5, 5, 4),
    ('FRUEH', 'zeitig', 'D', 1, 6, 5),
    ('LILA', 'Violett', 'D', 7, 6, 4),
    ('LAG', 'ruhte', 'D', 1, 7, 3),
    ('OBEREN', 'höher gelegenen', 'D', 5, 7, 6),
    ('ETAT', 'Budget', 'D', 1, 8, 4),
    ('ATMET', 'holt Luft', 'D', 6, 8, 5),
    ('GEN', 'nach', 'D', 1, 9, 3),
    ('UNTERE', 'tiefere', 'D', 5, 9, 6),
    ('ENGE', 'knappe', 'D', 1, 10, 4),
    ('DENEN', 'Relativ (Dat. Pl.)', 'D', 6, 10, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r068-11x11-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r068-11x11-03', 'Rätsel 68 · 11×11', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '11x11-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ETAT', 'Budget', 'A', 1, 1, 4),
    ('HARZ', 'Baumsaft', 'A', 1, 7, 4),
    ('BOX', 'Schachtel', 'A', 2, 1, 3),
    ('KRAKAU', 'Stadt in Polen', 'A', 2, 5, 6),
    ('ENTE', 'Wasservogel', 'A', 3, 1, 4),
    ('ALTEM', 'betagtem', 'A', 3, 6, 5),
    ('BITTET', 'ersucht', 'A', 4, 4, 6),
    ('EIGENE', 'individuelle', 'A', 5, 1, 6),
    ('NEU', 'aktuell', 'A', 5, 8, 3),
    ('RAND', 'Kante', 'A', 6, 2, 4),
    ('LOS', 'ledig', 'A', 7, 1, 3),
    ('ERZ', 'Bodenschatz', 'A', 7, 5, 3),
    ('INS', 'in das', 'A', 8, 1, 3),
    ('MOEBEL', 'Einrichtung', 'A', 8, 5, 6),
    ('EIER', 'Gelege', 'A', 9, 1, 4),
    ('SAUNA', 'Schwitzbad', 'A', 9, 6, 5),
    ('DEN', 'Artikel (Akkusativ)', 'A', 10, 1, 3),
    ('ENGES', 'schmales', 'A', 10, 6, 5),
    ('EBENE', 'Flachland', 'D', 1, 1, 5),
    ('LIED', 'Song', 'D', 7, 1, 4),
    ('TON', 'Klang', 'D', 1, 2, 3),
    ('IRONIE', 'Spott', 'D', 5, 2, 6),
    ('AXT', 'Tomahawk', 'D', 1, 3, 3),
    ('GASSEN', 'Wege', 'D', 5, 3, 6),
    ('EBEN', 'just', 'D', 3, 4, 4),
    ('INDEM', 'dadurch dass', 'D', 4, 5, 5),
    ('RATE', 'Quote', 'D', 2, 6, 4),
    ('ROSE', 'Blume mit Dornen', 'D', 7, 6, 4),
    ('HALT', 'eben', 'D', 1, 7, 4),
    ('OZEAN', 'Weltmeer', 'D', 6, 7, 5),
    ('AKTEN', 'Dokumente', 'D', 1, 8, 5),
    ('BUG', 'Programmfehler', 'D', 8, 8, 3),
    ('RAETE', 'Ausschüsse', 'D', 1, 9, 5),
    ('JENE', 'selbige', 'D', 7, 9, 4),
    ('ZUM', 'zu dem', 'D', 1, 10, 3),
    ('LAS', 'entzifferte', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r069-12x12-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r069-12x12-01', 'Rätsel 69 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('PRO', 'per', 'A', 1, 1, 3),
    ('STEG', 'Bootsanleger', 'A', 1, 8, 4),
    ('LARVEN', 'Masken', 'A', 2, 1, 6),
    ('ARIE', 'Opernlied', 'A', 2, 8, 4),
    ('ART', 'Spezies', 'A', 3, 1, 3),
    ('ANGELN', 'Fischen', 'A', 3, 6, 6),
    ('BUTTER', 'Streichfett', 'A', 4, 6, 6),
    ('ZWEITEN', 'nächsten', 'A', 5, 1, 7),
    ('URNEN', 'Aschengefäße', 'A', 6, 2, 5),
    ('ETWAS', 'ein wenig', 'A', 7, 1, 5),
    ('SUDAN', 'Staat am Nil', 'A', 7, 7, 5),
    ('ABT', 'Klosterchef', 'A', 8, 3, 3),
    ('TRAGE', 'schleppe', 'A', 8, 7, 5),
    ('NUR', 'bloß', 'A', 9, 1, 3),
    ('STIFTEN', 'spenden', 'A', 9, 5, 7),
    ('ENTE', 'Wasservogel', 'A', 10, 1, 4),
    ('ALTERN', 'Reifen', 'A', 10, 6, 6),
    ('SIE', 'Anrede', 'A', 11, 1, 3),
    ('GLEISE', 'Schienen', 'A', 11, 6, 6),
    ('PLATZ', 'Areal', 'D', 1, 1, 5),
    ('EINES', 'unbest. Art. (Gen.)', 'D', 7, 1, 5),
    ('RAR', 'selten', 'D', 1, 2, 3),
    ('WUT', 'Zorn', 'D', 5, 2, 3),
    ('UNI', 'Hochschule', 'D', 9, 2, 3),
    ('ORT', 'Stelle', 'D', 1, 3, 3),
    ('ERWARTE', 'erhoffe', 'D', 5, 3, 7),
    ('HINAB', 'hinunter', 'D', 4, 4, 5),
    ('TESTS', 'Kontrollen', 'D', 5, 5, 5),
    ('KNABEN', 'Jungen', 'D', 1, 6, 6),
    ('TAG', 'Kalenderblatt', 'D', 9, 6, 3),
    ('NUN', 'jetzt', 'D', 3, 7, 3),
    ('STILL', 'ruhig', 'D', 7, 7, 5),
    ('SAGT', 'äußert', 'D', 1, 8, 4),
    ('DURFTE', 'konnte', 'D', 6, 8, 6),
    ('TRETE', 'kicke', 'D', 1, 9, 5),
    ('DATEI', 'Dokument', 'D', 7, 9, 5),
    ('EILE', 'Hektik', 'D', 1, 10, 4),
    ('LAGERS', 'Leiter des ...', 'D', 6, 10, 6),
    ('GENRE', 'Stilrichtung', 'D', 1, 11, 5),
    ('NENNE', 'bezeichne', 'D', 7, 11, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r070-12x12-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r070-12x12-02', 'Rätsel 70 · 12×12', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '12x12-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ABER', 'jedoch', 'A', 1, 1, 4),
    ('BAUM', 'Gehölz', 'A', 1, 8, 4),
    ('KILO', '1000 Gramm', 'A', 2, 1, 4),
    ('ENORME', 'gewaltige', 'A', 2, 6, 6),
    ('KLEMME', 'Zwickmühle', 'A', 3, 1, 6),
    ('TAGE', 'je 24 Stunden', 'A', 3, 8, 4),
    ('ULM', 'Münsterstadt', 'A', 4, 1, 3),
    ('BAR', 'Lokal', 'A', 4, 9, 3),
    ('SIEG', 'Triumph', 'A', 5, 1, 4),
    ('DEREN', 'Pronomen', 'A', 5, 6, 5),
    ('GNADE', 'Erbarmen', 'A', 6, 2, 5),
    ('ARGE', 'schlimme', 'A', 6, 8, 4),
    ('BETRAT', 'ging hinein', 'A', 7, 1, 6),
    ('ICH', 'Pronomen (1. Sg.)', 'A', 8, 7, 3),
    ('SPUR', 'Fährte', 'A', 9, 1, 4),
    ('HUFE', 'Pferdefüße', 'A', 9, 8, 4),
    ('SENATS', 'Sitzung des ...', 'A', 10, 1, 6),
    ('EHER', 'vielmehr', 'A', 10, 8, 4),
    ('ERST', 'anfangs', 'A', 11, 1, 4),
    ('TONNEN', 'Fässer', 'A', 11, 6, 6),
    ('AKKUS', 'Batterien', 'D', 1, 1, 5),
    ('BUSSE', 'Reisecars', 'D', 7, 1, 5),
    ('BILLIGE', 'preiswerte', 'D', 1, 2, 7),
    ('PER', 'via', 'D', 9, 2, 3),
    ('ELEMENT', 'Bestandteil', 'D', 1, 3, 7),
    ('UNS', 'Akk./Dat. von wir', 'D', 9, 3, 3),
    ('ROM', 'Ewige Stadt', 'D', 1, 4, 3),
    ('GAR', 'völlig', 'D', 5, 4, 3),
    ('RAT', 'Gremium', 'D', 9, 4, 3),
    ('DAR', 'stellt ... (zeigt)', 'D', 6, 5, 3),
    ('BEENDET', 'erledigt', 'D', 1, 6, 7),
    ('AST', 'Zweig', 'D', 9, 6, 3),
    ('BOT', 'unterbreitete', 'D', 1, 8, 3),
    ('RAUCHEN', 'Qualmen', 'D', 5, 8, 7),
    ('ARABER', 'Pferderasse', 'D', 1, 9, 6),
    ('HUHN', 'Henne', 'D', 8, 9, 4),
    ('UMGANG', 'Verkehr', 'D', 1, 10, 6),
    ('FEE', 'Elfe', 'D', 9, 10, 3),
    ('MEER', 'See', 'D', 1, 11, 4),
    ('ELTERN', 'Vater und Mutter', 'D', 6, 11, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r071-12x12-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r071-12x12-03', 'Rätsel 71 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('SECHS', 'Zahl (2×3)', 'A', 1, 1, 5),
    ('STUHL', 'Sitz', 'A', 1, 7, 5),
    ('ERHOEHT', 'gesteigert', 'A', 2, 1, 7),
    ('NIE', 'zu keiner Zeit', 'A', 2, 9, 3),
    ('KRAFT', 'Stärke', 'A', 3, 1, 5),
    ('INS', 'in das', 'A', 3, 9, 3),
    ('TAT', 'Handlung', 'A', 4, 1, 3),
    ('ZELT', 'Pavillon', 'A', 4, 5, 4),
    ('ERZ', 'Gestein', 'A', 5, 5, 3),
    ('OMA', 'Omi', 'A', 5, 9, 3),
    ('EGAL', 'einerlei', 'A', 6, 1, 4),
    ('KOPFES', 'Inhalt des ...', 'A', 7, 5, 6),
    ('TOD', 'Exitus', 'A', 8, 1, 3),
    ('ABLEBEN', 'Tod', 'A', 8, 5, 7),
    ('ADERN', 'Venen', 'A', 9, 1, 5),
    ('ARENA', 'Stadion', 'A', 9, 7, 5),
    ('GERATEN', 'angezeigt', 'A', 10, 1, 7),
    ('NAH', 'dicht', 'A', 10, 9, 3),
    ('ERSTE', 'anfängliche', 'A', 11, 1, 5),
    ('FETT', 'Schmalz', 'A', 11, 8, 4),
    ('SEKT', 'Schaumwein', 'D', 1, 1, 4),
    ('TAGE', 'je 24 Stunden', 'D', 8, 1, 4),
    ('ERRANG', 'gewann', 'D', 1, 2, 6),
    ('ODER', 'bzw.', 'D', 8, 2, 4),
    ('CHAT', 'Plauderei', 'D', 1, 3, 4),
    ('ANDERS', 'abweichend', 'D', 6, 3, 6),
    ('HOF', 'Grundstück', 'D', 1, 4, 3),
    ('RAT', 'Gremium', 'D', 9, 4, 3),
    ('SETZE', 'stelle', 'D', 1, 5, 5),
    ('KANTE', 'Rand', 'D', 7, 5, 5),
    ('ERHOB', 'stemmte', 'D', 4, 6, 5),
    ('STOLZ', 'hochmütig', 'D', 1, 7, 5),
    ('PLAN', 'Absicht', 'D', 7, 7, 4),
    ('UFER', 'Gestade', 'D', 6, 8, 4),
    ('UNI', 'Hochschule', 'D', 1, 9, 3),
    ('EBENE', 'Flachland', 'D', 7, 9, 5),
    ('HIN', '... und her', 'D', 1, 10, 3),
    ('SENAT', 'Ältestenrat', 'D', 7, 10, 5),
    ('LESBAR', 'entzifferbar', 'D', 1, 11, 6),
    ('NAHT', 'kommt näher', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r072-12x12-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r072-12x12-04', 'Rätsel 72 · 12×12', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '12x12-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('MATERIAL', 'Stoff', 'A', 1, 1, 8),
    ('ARENA', 'Stadion', 'A', 2, 1, 5),
    ('NAH', 'unweit', 'A', 2, 7, 3),
    ('NEIGT', 'tendiert', 'A', 3, 1, 5),
    ('SEITE', 'Blatt', 'A', 3, 7, 5),
    ('NAGEL', 'Stift', 'A', 4, 1, 5),
    ('GERN', 'mit Freude', 'A', 4, 8, 4),
    ('MOLKEREI', 'Milchbetrieb', 'A', 5, 4, 8),
    ('ZUG', 'Bahn', 'A', 6, 9, 3),
    ('RAT', 'Tipp', 'A', 7, 2, 3),
    ('FREUE', 'juble', 'A', 7, 6, 5),
    ('GERA', 'Stadt in Thüringen', 'A', 8, 1, 4),
    ('AST', 'Zweig', 'A', 8, 6, 3),
    ('LANGER', 'ausgedehnter', 'A', 9, 1, 6),
    ('WAND', 'Mauer', 'A', 9, 8, 4),
    ('ALT', 'ergraut', 'A', 10, 1, 3),
    ('ARIE', 'Opernlied', 'A', 10, 8, 4),
    ('SEEN', 'Gewässer', 'A', 11, 1, 4),
    ('ERSTER', 'anfänglicher', 'A', 11, 6, 6),
    ('MANN', 'Gemahl', 'D', 1, 1, 4),
    ('GLAS', 'Trinkgefäß', 'D', 8, 1, 4),
    ('AREAL', 'Gelände', 'D', 1, 2, 5),
    ('REALE', 'echte', 'D', 7, 2, 5),
    ('TEIG', 'Masse', 'D', 1, 3, 4),
    ('WARNTE', 'mahnte', 'D', 6, 3, 6),
    ('ENGEM', 'schmalem', 'D', 1, 4, 5),
    ('TAG', '24 Stunden', 'D', 7, 4, 3),
    ('RATLOS', 'hilflos', 'D', 1, 5, 6),
    ('FARBE', 'Kolorit', 'D', 7, 6, 5),
    ('ANS', 'an das', 'D', 1, 7, 3),
    ('KURS', 'Richtung', 'D', 5, 7, 4),
    ('LAEGE', 'ruhte', 'D', 1, 8, 5),
    ('ETWAS', 'ein wenig', 'D', 7, 8, 5),
    ('HIERZU', 'dazu', 'D', 2, 9, 6),
    ('ART', 'Spezies', 'D', 9, 9, 3),
    ('TREUE', 'Loyalität', 'D', 3, 10, 5),
    ('NIE', 'nimmer', 'D', 9, 10, 3),
    ('KOENIG', 'Monarch', 'D', 1, 11, 6),
    ('ODER', 'bzw.', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r073-13x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r073-13x13-01', 'Rätsel 73 · 13×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '13x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ALB', 'Schwäbische ...', 'A', 1, 1, 3),
    ('PUR', 'unverfälscht', 'A', 1, 5, 3),
    ('BLUT', 'Lebenssaft', 'A', 1, 9, 4),
    ('RAUB', 'Diebstahl', 'A', 2, 1, 4),
    ('MAFIA', 'Cosa Nostra', 'A', 2, 6, 5),
    ('GEBUCHT', 'reserviert', 'A', 3, 1, 7),
    ('TEXT', 'Wortlaut', 'A', 3, 9, 4),
    ('SOEST', 'Stadt in Westfalen', 'A', 4, 4, 5),
    ('OHR', 'Lauscher', 'A', 5, 1, 3),
    ('DRAENGEN', 'schieben', 'A', 5, 5, 8),
    ('ZEUGE', 'Beobachter', 'A', 6, 1, 5),
    ('MIES', 'schlecht', 'A', 6, 7, 4),
    ('ELF', 'Zahl (10+1)', 'A', 7, 1, 3),
    ('LITER', 'Hohlmaß', 'A', 7, 8, 5),
    ('ATEM', 'Odem', 'A', 8, 1, 4),
    ('SIEG', 'Triumph', 'A', 8, 6, 4),
    ('EDLE', 'noble', 'A', 9, 9, 4),
    ('HANDELT', 'agiert', 'A', 10, 2, 7),
    ('RAN', 'hinzu', 'A', 10, 10, 3),
    ('GALGEN', 'Richtstätte', 'A', 11, 1, 6),
    ('IST', 'befindet sich', 'A', 11, 10, 3),
    ('BLASS', 'bleich', 'A', 12, 2, 5),
    ('LINSE', 'Objektiv', 'A', 12, 8, 5),
    ('ARG', 'schlimm', 'D', 1, 1, 3),
    ('OZEAN', 'Weltmeer', 'D', 5, 1, 5),
    ('LAECHELT', 'schmunzelt', 'D', 1, 2, 8),
    ('HAB', 'Besitz', 'D', 10, 2, 3),
    ('BUB', 'Knabe', 'D', 1, 3, 3),
    ('RUFE', 'Schreie', 'D', 5, 3, 4),
    ('ALL', 'Kosmos', 'D', 10, 3, 3),
    ('BUS', 'Car (schweiz.)', 'D', 2, 4, 3),
    ('MANGA', 'jap. Comic', 'D', 8, 4, 5),
    ('CODE', 'Kennung', 'D', 3, 5, 4),
    ('DES', 'Artikel (Genitiv)', 'D', 10, 5, 3),
    ('UMHER', 'herum', 'D', 1, 6, 5),
    ('OSTENS', 'Völker des ...', 'D', 7, 6, 6),
    ('RATSAM', 'klug', 'D', 1, 7, 6),
    ('TEILE', 'Stücke', 'D', 4, 8, 5),
    ('TAL', 'Niederung', 'D', 10, 8, 3),
    ('BIT', 'Dualziffer', 'D', 1, 9, 3),
    ('NEIGE', 'zur ... gehen', 'D', 5, 9, 5),
    ('LAENGST', 'seit jeher', 'D', 1, 10, 7),
    ('DRIN', 'innen', 'D', 9, 10, 4),
    ('ERLASS', 'Verordnung', 'D', 7, 11, 6),
    ('TOT', 'leblos', 'D', 1, 12, 3),
    ('NUR', 'bloß', 'D', 5, 12, 3),
    ('ENTE', 'Falschmeldung', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r074-13x13-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r074-13x13-02', 'Rätsel 74 · 13×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '13x13-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('KOSTBARE', 'wertvolle', 'A', 1, 1, 8),
    ('ERZ', 'Bodenschatz', 'A', 1, 10, 3),
    ('PROBE', 'Test', 'A', 2, 3, 5),
    ('STAU', 'Blechlawine', 'A', 2, 9, 4),
    ('RATSAM', 'klug', 'A', 3, 3, 6),
    ('WUT', 'Zorn', 'A', 3, 10, 3),
    ('NEUE', 'frische', 'A', 4, 1, 4),
    ('ALABAMA', 'Südstaat', 'A', 4, 6, 7),
    ('GING', 'wandelte', 'A', 5, 1, 4),
    ('GENE', 'Erbanlagen', 'A', 5, 6, 4),
    ('ENGERE', 'schmalere', 'A', 6, 1, 6),
    ('NIE', 'nimmer', 'A', 6, 8, 3),
    ('NENNEN', 'bezeichnen', 'A', 7, 7, 6),
    ('BIER', 'Gerstensaft', 'A', 8, 3, 4),
    ('ABENDEN', 'an lauen ...', 'A', 9, 1, 7),
    ('BLAU', 'betrunken', 'A', 9, 9, 4),
    ('RASSEN', 'Zuchtlinien', 'A', 10, 1, 6),
    ('DRAUF', 'darauf', 'A', 10, 8, 5),
    ('INTERNE', 'innere', 'A', 11, 1, 7),
    ('ENGE', 'knappe', 'A', 11, 9, 4),
    ('EDEL', 'vornehm', 'A', 12, 1, 4),
    ('WIDER', 'gegen', 'A', 12, 8, 5),
    ('KLINGEN', 'tönen', 'D', 1, 1, 7),
    ('ARIE', 'Opernlied', 'D', 9, 1, 4),
    ('EIN', 'unbest. Artikel', 'D', 4, 2, 3),
    ('BAND', 'Musikgruppe', 'D', 9, 2, 4),
    ('SPRUNG', 'Satz', 'D', 1, 3, 6),
    ('BESTE', 'optimale', 'D', 8, 3, 5),
    ('TRAEGE', 'faul', 'D', 1, 4, 6),
    ('INSEL', 'Eiland', 'D', 8, 4, 5),
    ('BOT', 'offerierte', 'D', 1, 5, 3),
    ('RAEDER', 'Reifen', 'D', 6, 5, 6),
    ('ABSAGE', 'Ablehnung', 'D', 1, 6, 6),
    ('RENNT', 'läuft', 'D', 8, 6, 5),
    ('REALE', 'wirkliche', 'D', 1, 7, 5),
    ('MANNES', 'Name des ...', 'D', 3, 8, 6),
    ('BEIN', 'Stelze', 'D', 4, 9, 4),
    ('BREI', 'Mus', 'D', 9, 9, 4),
    ('ETWA', 'ungefähr', 'D', 1, 10, 4),
    ('ENGLAND', 'Albion', 'D', 6, 10, 7),
    ('RAUM', 'Zimmer', 'D', 1, 11, 4),
    ('AUGE', 'Pupille', 'D', 9, 11, 4),
    ('ZUTATEN', 'Ingredienzen', 'D', 1, 12, 7),
    ('UFER', 'Küste', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r075-13x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r075-13x13-03', 'Rätsel 75 · 13×13', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '13x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ELBE', 'Strom durch Hamburg', 'A', 1, 1, 4),
    ('ZOG', 'riss', 'A', 1, 6, 3),
    ('SAH', 'erblickte', 'A', 1, 10, 3),
    ('NIE', 'nimmer', 'A', 2, 1, 3),
    ('GEBURT', 'Entbindung', 'A', 2, 5, 6),
    ('GESPENST', 'Geist', 'A', 3, 1, 8),
    ('RAR', 'kostbar', 'A', 3, 10, 3),
    ('DIENST', 'Arbeit', 'A', 4, 2, 6),
    ('HAST', 'besitzt', 'A', 4, 9, 4),
    ('TREU', 'anhänglich', 'A', 5, 3, 4),
    ('SIE', 'Anrede', 'A', 5, 10, 3),
    ('ERZ', 'Gestein', 'A', 6, 1, 3),
    ('STOSSEN', 'schubsen', 'A', 6, 6, 7),
    ('TIEFE', 'Abgrund', 'A', 7, 1, 5),
    ('SEIEN', 'Verbform', 'A', 7, 7, 5),
    ('ZONE', 'Bereich', 'A', 8, 1, 4),
    ('HUHN', 'Henne', 'A', 8, 6, 4),
    ('NENNEN', 'bezeichnen', 'A', 9, 7, 6),
    ('EGAL', 'gleichgültig', 'A', 10, 1, 4),
    ('WAR', 'existierte', 'A', 10, 6, 3),
    ('UND', 'sowie', 'A', 10, 10, 3),
    ('RAUEN', 'groben', 'A', 11, 1, 5),
    ('MEISTE', 'größte Teil', 'A', 11, 7, 6),
    ('EBEN', 'flach', 'A', 12, 1, 4),
    ('HIN', '... und her', 'A', 12, 6, 3),
    ('SEX', 'Geschlecht', 'A', 12, 10, 3),
    ('ENG', 'knapp', 'D', 1, 1, 3),
    ('LETZTERE', 'die Zweite', 'D', 5, 1, 8),
    ('LIED', 'Song', 'D', 1, 2, 4),
    ('RIO', 'Zuckerhut-Stadt', 'D', 6, 2, 3),
    ('GAB', 'reichte', 'D', 10, 2, 3),
    ('BESITZEN', 'haben', 'D', 1, 3, 8),
    ('AUE', 'Talwiese', 'D', 10, 3, 3),
    ('PER', 'via', 'D', 3, 4, 3),
    ('FEHLEN', 'mangeln', 'D', 7, 4, 6),
    ('GENE', 'Erbanlagen', 'D', 2, 5, 4),
    ('ZENSUS', 'Volkszählung', 'D', 1, 6, 6),
    ('OBST', 'Früchte', 'D', 1, 7, 4),
    ('TSUNAMI', 'Flutwelle', 'D', 6, 7, 7),
    ('GUT', 'prima', 'D', 1, 8, 3),
    ('HOEHEREN', 'größeren', 'D', 5, 8, 8),
    ('SINN', 'Verstand', 'D', 6, 9, 4),
    ('STRASSE', 'Fahrweg', 'D', 1, 10, 7),
    ('NUSS', 'Kern', 'D', 9, 10, 4),
    ('ASIEN', 'Erdteil', 'D', 3, 11, 5),
    ('ENTE', 'Falschmeldung', 'D', 9, 11, 4),
    ('HARTEN', 'festen', 'D', 1, 12, 6),
    ('INDEX', 'Verzeichnis', 'D', 8, 12, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r076-15x15-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r076-15x15-01', 'Rätsel 76 · 15×15', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '15x15-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('SAGA', 'Heldensage', 'A', 1, 1, 4),
    ('HIT', 'Chartstürmer', 'A', 1, 6, 3),
    ('KRIMI', 'Thriller', 'A', 1, 10, 5),
    ('ABRUFEN', 'laden', 'A', 2, 1, 7),
    ('YUAN', 'chin. Währung', 'A', 2, 9, 4),
    ('STAR', 'Berühmtheit', 'A', 3, 1, 4),
    ('IST', 'befindet sich', 'A', 3, 6, 3),
    ('SENKE', 'Mulde', 'A', 3, 10, 5),
    ('SENATS', 'Sitzung des ...', 'A', 4, 1, 6),
    ('STERN', 'Gestirn', 'A', 4, 10, 5),
    ('EID', 'Gelöbnis', 'A', 5, 1, 3),
    ('ASSEN', 'verzehrten', 'A', 5, 5, 5),
    ('NIE', 'zu keiner Zeit', 'A', 6, 12, 3),
    ('SOLCHE', 'derartige', 'A', 7, 2, 6),
    ('AUGUST', 'Spätsommermonat', 'A', 7, 9, 6),
    ('LOS', 'ledig', 'A', 8, 1, 3),
    ('HEBELTEN', 'stemmten', 'A', 8, 5, 8),
    ('NEU', 'aktuell', 'A', 9, 4, 3),
    ('TON', 'Klang', 'A', 9, 9, 3),
    ('OEFEN', 'Herde', 'A', 10, 1, 5),
    ('HEER', 'Armee', 'A', 10, 7, 4),
    ('VIEH', 'Nutztiere', 'A', 11, 1, 4),
    ('KEIM', 'Erreger', 'A', 11, 6, 4),
    ('SATT', 'gesättigt', 'A', 11, 11, 4),
    ('ATEMLUFT', 'Sauerstoff', 'A', 12, 1, 8),
    ('WAHRE', 'echte', 'A', 12, 10, 5),
    ('TOBTE', 'wütete', 'A', 13, 4, 5),
    ('IHRES', 'seines', 'A', 13, 10, 5),
    ('ECK', 'Kante', 'A', 14, 1, 3),
    ('KAELTE', 'Frost', 'A', 14, 5, 6),
    ('TUT', 'verrichtet', 'A', 14, 12, 3),
    ('SASSEN', 'hockten', 'D', 1, 1, 6),
    ('OVALE', 'eiförmige', 'D', 10, 1, 5),
    ('ABTEI', 'Kloster', 'D', 1, 2, 5),
    ('SOWEIT', 'insofern', 'D', 7, 2, 6),
    ('GRANDIOS', 'großartig', 'D', 1, 3, 8),
    ('FEE', 'Zauberin', 'D', 10, 3, 3),
    ('AURA', 'Ausstrahlung', 'D', 1, 4, 4),
    ('NEHMT', 'greift', 'D', 9, 4, 5),
    ('TASCHEN', 'Beutel', 'D', 4, 5, 7),
    ('LOK', 'Zugmaschine', 'D', 12, 5, 3),
    ('HEISS', 'glühend', 'D', 1, 6, 5),
    ('HEU', 'Viehfutter', 'D', 7, 6, 3),
    ('KUBA', 'Karibikinsel', 'D', 11, 6, 4),
    ('INS', 'in das', 'D', 1, 7, 3),
    ('SIEB', 'Filter', 'D', 5, 7, 4),
    ('HEFTE', 'Broschüren', 'D', 10, 7, 5),
    ('TUE', 'verrichte', 'D', 3, 8, 3),
    ('EITEL', 'gefallsüchtig', 'D', 10, 8, 5),
    ('ALTEM', 'betagtem', 'D', 7, 9, 5),
    ('KUSS', 'Busserl', 'D', 1, 10, 4),
    ('AUTOR', 'Verfasser', 'D', 6, 10, 5),
    ('WIE', 'gleich', 'D', 12, 10, 3),
    ('RAETE', 'Gremien', 'D', 1, 11, 5),
    ('GEN', 'Erbanlage', 'D', 7, 11, 3),
    ('SAH', 'blickte', 'D', 11, 11, 3),
    ('INNE', 'Verbpartikel', 'D', 1, 12, 4),
    ('NUN', 'jetzt', 'D', 6, 12, 3),
    ('FAHRT', 'Reise', 'D', 10, 12, 5),
    ('KREIS', 'Zirkel', 'D', 3, 13, 5),
    ('TREU', 'anhänglich', 'D', 11, 13, 4),
    ('IREN', 'Gälen', 'D', 1, 14, 4),
    ('ETWA', 'ungefähr', 'D', 6, 14, 4),
    ('TEST', 'Prüfung', 'D', 11, 14, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r077-15x15-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r077-15x15-02', 'Rätsel 77 · 15×15', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '15x15-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('LOSEN', 'lockeren', 'A', 1, 1, 5),
    ('LABOR', 'Versuchsraum', 'A', 1, 10, 5),
    ('APP', 'Anwendung', 'A', 2, 1, 3),
    ('EGAL', 'gleichgültig', 'A', 2, 5, 4),
    ('AROMA', 'Geschmack', 'A', 2, 10, 5),
    ('HAUPT', 'Kopf', 'A', 3, 1, 5),
    ('RAEUMTEN', 'leerten', 'A', 3, 7, 8),
    ('KATZEN', 'Miezen', 'A', 4, 3, 6),
    ('REIN', 'sauber', 'A', 5, 4, 4),
    ('SEKT', 'Schaumwein', 'A', 5, 9, 4),
    ('PAKT', 'Bündnis', 'A', 6, 1, 4),
    ('TAL', 'Niederung', 'A', 6, 6, 3),
    ('RABE', 'Unglücksvogel', 'A', 6, 11, 4),
    ('AUE', 'Wiesenland', 'A', 7, 1, 3),
    ('TEXAS', 'Staat um Houston', 'A', 7, 10, 5),
    ('UNI', 'Hochschule', 'A', 8, 1, 3),
    ('STAUB', 'Schmutz', 'A', 8, 5, 5),
    ('MIT', 'samt', 'A', 8, 11, 3),
    ('SALAT', 'Durcheinander', 'A', 9, 1, 5),
    ('BIEL', 'Bienne', 'A', 9, 8, 4),
    ('SAAT', 'Samen', 'A', 10, 4, 4),
    ('ZOO', 'Tierpark', 'A', 10, 12, 3),
    ('ASTEROID', 'Kleinplanet', 'A', 11, 2, 8),
    ('KURZ', 'knackig', 'A', 11, 11, 4),
    ('HUT', 'Kopfbedeckung', 'A', 12, 1, 3),
    ('DIE', 'Artikel (weibl.)', 'A', 12, 5, 3),
    ('ENTE', 'Falschmeldung', 'A', 12, 11, 4),
    ('URALTEN', 'steinalten', 'A', 13, 1, 7),
    ('NEIGEN', 'tendieren', 'A', 13, 9, 6),
    ('BAU', 'Gebäude', 'A', 14, 1, 3),
    ('EID', 'Schwur', 'A', 14, 7, 3),
    ('NEST', 'Horst', 'A', 14, 11, 4),
    ('LAHM', 'träge', 'D', 1, 1, 4),
    ('PAUSE', 'Rast', 'D', 6, 1, 5),
    ('HUB', 'Hebung', 'D', 12, 1, 3),
    ('OPA', 'Opi', 'D', 1, 2, 3),
    ('SAUNA', 'Schwitzbad', 'D', 5, 2, 5),
    ('AURA', 'Fluidum', 'D', 11, 2, 4),
    ('SPUK', 'Geisterei', 'D', 1, 3, 4),
    ('KEIL', 'Dreieckklotz', 'D', 6, 3, 4),
    ('STAU', 'Blechlawine', 'D', 11, 3, 4),
    ('PART', 'Rolle', 'D', 3, 4, 4),
    ('AST', 'Zweig', 'D', 9, 4, 3),
    ('NETTE', 'freundliche', 'D', 1, 5, 5),
    ('STAEDTE', 'Kommunen', 'D', 8, 5, 7),
    ('ZITAT', 'Ausspruch', 'D', 4, 6, 5),
    ('ARIE', 'Opernlied', 'D', 10, 6, 4),
    ('ARENA', 'Kolosseum', 'D', 2, 7, 5),
    ('TOENE', 'Klänge', 'D', 10, 7, 5),
    ('CLAN', 'Sippe', 'D', 1, 8, 4),
    ('LAUB', 'Blätter', 'D', 6, 8, 4),
    ('BINDEND', 'zwingend', 'D', 8, 9, 7),
    ('LAUNE', 'Stimmung', 'D', 1, 10, 5),
    ('ARM', 'Extremität', 'D', 1, 11, 3),
    ('KREML', 'Moskauer Burg', 'D', 5, 11, 5),
    ('KEIN', 'nicht ein', 'D', 11, 11, 4),
    ('BOT', 'unterbreitete', 'D', 1, 12, 3),
    ('TAXI', 'Droschke', 'D', 5, 12, 4),
    ('ZUNGE', 'Schmeckorgan', 'D', 10, 12, 5),
    ('OMEN', 'Vorzeichen', 'D', 1, 13, 4),
    ('BAT', 'ersuchte', 'D', 6, 13, 3),
    ('ORTES', 'Name des ...', 'D', 10, 13, 5),
    ('RAN', 'hinzu', 'D', 1, 14, 3),
    ('DES', 'Artikel (Genitiv)', 'D', 5, 14, 3),
    ('DOZENT', 'Lehrender', 'D', 9, 14, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r078-15x15-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r078-15x15-03', 'Rätsel 78 · 15×15', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '15x15-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('GENEN', 'Erbanlagen', 'A', 1, 1, 5),
    ('FRIEDHOF', 'Gottesacker', 'A', 1, 7, 8),
    ('EHER', 'vielmehr', 'A', 2, 1, 4),
    ('HAAR', 'Strähne', 'A', 2, 6, 4),
    ('REIZ', 'Charme', 'A', 3, 1, 4),
    ('IRRE', 'Wahnsinnige', 'A', 3, 6, 4),
    ('ESSE', 'verspeise', 'A', 3, 11, 4),
    ('ANDEREM', 'unter ...', 'A', 4, 1, 7),
    ('TON', 'Lehm', 'A', 4, 12, 3),
    ('DING', 'Sache', 'A', 5, 11, 4),
    ('PRAG', 'Moldau-Stadt', 'A', 6, 1, 4),
    ('VIA', 'durch', 'A', 6, 6, 3),
    ('FUEGT', 'setzt', 'A', 6, 10, 5),
    ('RESTLOS', 'völlig', 'A', 7, 1, 7),
    ('DEALS', 'Geschäfte', 'A', 7, 9, 5),
    ('OFT', 'des Öfteren', 'A', 8, 1, 3),
    ('ENTFIEL', 'entglitt', 'A', 8, 5, 7),
    ('ENDE', 'Schluss', 'A', 9, 11, 4),
    ('PREIS', 'Tarif', 'A', 10, 1, 5),
    ('PUB', 'Kneipe', 'A', 10, 7, 3),
    ('NORM', 'Regel', 'A', 10, 11, 4),
    ('FAX', 'Telekopie', 'A', 11, 1, 3),
    ('TRATEN', 'schritten', 'A', 11, 5, 6),
    ('RIO', 'Stadt in Brasilien', 'A', 11, 12, 3),
    ('ETAGE', 'Stockwerk', 'A', 12, 1, 5),
    ('TAT', 'Handlung', 'A', 12, 7, 3),
    ('AMTS', 'im ... sein', 'A', 12, 11, 4),
    ('KUTSCHE', 'Pferdewagen', 'A', 13, 3, 7),
    ('RAT', 'Tipp', 'A', 13, 11, 3),
    ('LATTE', 'Leiste', 'A', 14, 1, 5),
    ('SEGLER', 'Skipper', 'A', 14, 9, 6),
    ('GERA', 'Stadt in Thüringen', 'D', 1, 1, 4),
    ('PRO', 'je', 'D', 6, 1, 3),
    ('PFEIL', 'Geschoss', 'D', 10, 1, 5),
    ('EHEN', 'Verbindungen', 'D', 1, 2, 4),
    ('REFERAT', 'Vortrag', 'D', 6, 2, 7),
    ('NEID', 'Eifersucht', 'D', 1, 3, 4),
    ('AST', 'Zweig', 'D', 6, 3, 3),
    ('EXAKT', 'genau', 'D', 10, 3, 5),
    ('ERZEUGT', 'hergestellt', 'D', 1, 4, 7),
    ('GUT', 'prima', 'D', 12, 4, 3),
    ('LEISTETE', 'vollbrachte', 'D', 7, 5, 8),
    ('HIERVON', 'davon', 'D', 2, 6, 7),
    ('FARM', 'Bauernhof', 'D', 1, 7, 4),
    ('IST', 'befindet sich', 'D', 6, 7, 3),
    ('PATCH', 'Flicken', 'D', 10, 7, 5),
    ('RAR', 'selten', 'D', 1, 8, 3),
    ('UTAH', 'Mormonenstaat', 'D', 10, 8, 4),
    ('IREN', 'Gälen', 'D', 1, 9, 4),
    ('DIABETES', 'Zuckerleiden', 'D', 7, 9, 8),
    ('FEE', 'Elfe', 'D', 6, 10, 3),
    ('DIE', 'Artikel (weibl.)', 'D', 1, 11, 3),
    ('DUALEN', 'zweifachen', 'D', 5, 11, 6),
    ('ARG', 'übel', 'D', 12, 11, 3),
    ('STIEL', 'Griff', 'D', 3, 12, 5),
    ('NORMAL', 'üblich', 'D', 9, 12, 6),
    ('SONGS', 'Lieder', 'D', 3, 13, 5),
    ('DRITTE', 'nach der zweiten', 'D', 9, 13, 6),
    ('FAENGT', 'erwischt', 'D', 1, 14, 6),
    ('DEMOS', 'Kundgebungen', 'D', 8, 14, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r079-8x8-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r079-8x8-01', 'Rätsel 79 · 8×8', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '8x8-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('RABE', 'Krähenvogel', 'A', 1, 1, 4),
    ('ALASKA', 'Staat am Yukon', 'A', 2, 1, 6),
    ('DAUERN', 'währen', 'A', 3, 1, 6),
    ('LAGE', 'Position', 'A', 4, 4, 4),
    ('UMS', 'um das', 'A', 5, 1, 3),
    ('TOR', 'Dummkopf', 'A', 5, 5, 3),
    ('ADELS', 'Titel des ...', 'A', 6, 3, 5),
    ('REH', 'Waldtier', 'A', 7, 1, 3),
    ('RAT', 'Tipp', 'A', 7, 5, 3),
    ('RAD', 'Kreisscheibe', 'D', 1, 1, 3),
    ('UHR', 'Zeitmesser', 'D', 5, 1, 3),
    ('ALARM', 'Warnsignal', 'D', 1, 2, 5),
    ('BAU', 'Konstruktion', 'D', 1, 3, 3),
    ('SAH', 'erblickte', 'D', 5, 3, 3),
    ('ESEL', 'Dickkopf', 'D', 1, 4, 4),
    ('KRATER', 'Trichter', 'D', 2, 5, 6),
    ('ANGOLA', 'Staat in Afrika', 'D', 2, 6, 6),
    ('ERST', 'zunächst', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r080-8x8-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r080-8x8-02', 'Rätsel 80 · 8×8', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '8x8-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('HART', 'fest', 'A', 1, 4, 4),
    ('UNSER', 'Possessiv (wir)', 'A', 2, 1, 5),
    ('NICKT', 'stimmt zu', 'A', 3, 1, 5),
    ('WEHT', 'bläst', 'A', 4, 1, 4),
    ('MAJOR', 'Dienstgrad', 'A', 5, 3, 5),
    ('AROMA', 'Geschmack', 'A', 6, 3, 5),
    ('TAL', 'Niederung', 'A', 7, 1, 3),
    ('BAR', 'Theke', 'A', 7, 5, 3),
    ('UNWEIT', 'nahe', 'D', 2, 1, 6),
    ('KNIE', 'Scharniergelenk', 'D', 1, 2, 4),
    ('SCHMAL', 'eng', 'D', 2, 3, 6),
    ('HEKTAR', 'Flächenmaß', 'D', 1, 4, 6),
    ('ART', 'Spezies', 'D', 1, 5, 3),
    ('JOB', 'Beruf', 'D', 5, 5, 3),
    ('KOMA', 'tiefe Ohnmacht', 'D', 4, 6, 4),
    ('TYP', 'Exemplar', 'D', 1, 7, 3),
    ('RAR', 'kostbar', 'D', 5, 7, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r081-8x8-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r081-8x8-03', 'Rätsel 81 · 8×8', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '8x8-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('SOWOHL', '... als auch', 'A', 1, 1, 6),
    ('HEROIN', 'Rauschgift', 'A', 2, 2, 6),
    ('ERNTEN', 'Lesen', 'A', 3, 1, 6),
    ('ERDE', 'Heimatplanet', 'A', 4, 4, 4),
    ('HAI', 'Raubfisch', 'A', 5, 1, 3),
    ('SAH', 'blickte', 'A', 5, 5, 3),
    ('TUN', 'verrichten', 'A', 6, 1, 3),
    ('TUE', 'mache', 'A', 6, 5, 3),
    ('ESSE', 'verspeise', 'A', 7, 1, 4),
    ('ECHTE', 'authentische', 'D', 3, 1, 5),
    ('OHR', 'Lauscher', 'D', 1, 2, 3),
    ('AUS', 'vorbei', 'D', 5, 2, 3),
    ('WEN', 'Fragewort (Akk.)', 'D', 1, 3, 3),
    ('INS', 'in das', 'D', 5, 3, 3),
    ('ORTE', 'Plätze', 'D', 1, 4, 4),
    ('HOERST', 'lauschst', 'D', 1, 5, 6),
    ('LINDAU', 'Inselstadt', 'D', 1, 6, 6),
    ('EHEN', 'Bündnisse', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r082-9x9-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r082-9x9-01', 'Rätsel 82 · 9×9', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '9x9-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('GASE', 'Dämpfe', 'A', 1, 1, 4),
    ('ARG', 'schlimm', 'A', 1, 6, 3),
    ('EUER', 'Possessiv (ihr)', 'A', 2, 1, 4),
    ('SIE', 'Anrede', 'A', 2, 6, 3),
    ('IRIS', 'Regenbogenhaut', 'A', 3, 1, 4),
    ('TON', 'Klang', 'A', 3, 6, 3),
    ('MALT', 'pinselt', 'A', 4, 1, 4),
    ('LIMA', 'peruan. Hauptstadt', 'A', 5, 5, 4),
    ('FLORIDA', 'Staat um Miami', 'A', 6, 1, 7),
    ('TOMATEN', 'Paradeiser', 'A', 7, 1, 7),
    ('KARTEN', 'Tickets', 'A', 8, 2, 6),
    ('GEIMPFT', 'immunisiert', 'D', 1, 1, 7),
    ('AURA', 'Ausstrahlung', 'D', 1, 2, 4),
    ('LOK', 'Zugmaschine', 'D', 6, 2, 3),
    ('SEIL', 'Tau', 'D', 1, 3, 4),
    ('OMA', 'Großmutter', 'D', 6, 3, 3),
    ('ERST', 'anfangs', 'D', 1, 4, 4),
    ('RAR', 'kostbar', 'D', 6, 4, 3),
    ('LITT', 'duldete', 'D', 5, 5, 4),
    ('AST', 'Knorren', 'D', 1, 6, 3),
    ('IDEE', 'Gedanke', 'D', 5, 6, 4),
    ('RIO', 'Stadt in Brasilien', 'D', 1, 7, 3),
    ('MANN', 'Gemahl', 'D', 5, 7, 4),
    ('GENUA', 'Hafenstadt Italiens', 'D', 1, 8, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r083-9x9-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r083-9x9-02', 'Rätsel 83 · 9×9', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '9x9-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('WAHR', 'zutreffend', 'A', 1, 1, 4),
    ('OFT', 'des Öfteren', 'A', 1, 6, 3),
    ('AREAL', 'Gelände', 'A', 2, 1, 5),
    ('STUDIEN', 'Analysen', 'A', 3, 1, 7),
    ('ERST', 'anfangs', 'A', 4, 5, 4),
    ('SCHIFF', 'Dampfer', 'A', 5, 1, 6),
    ('EHEN', 'Verbindungen', 'A', 6, 1, 4),
    ('AST', 'Knorren', 'A', 6, 6, 3),
    ('HORN', 'Hupe', 'A', 7, 1, 4),
    ('NIE', 'zu keiner Zeit', 'A', 7, 6, 3),
    ('ERDE', 'Heimatplanet', 'A', 8, 1, 4),
    ('DEN', 'Artikel (Akkusativ)', 'A', 8, 6, 3),
    ('WAS', 'Fragewort (Sache)', 'D', 1, 1, 3),
    ('SEHE', 'schaue', 'D', 5, 1, 4),
    ('ART', 'Sorte', 'D', 1, 2, 3),
    ('CHOR', 'Singgruppe', 'D', 5, 2, 4),
    ('HEU', 'Trockengras', 'D', 1, 3, 3),
    ('HERD', 'Kochstelle', 'D', 5, 3, 4),
    ('RAD', 'Velo', 'D', 1, 4, 3),
    ('INNE', 'Verbpartikel', 'D', 5, 4, 4),
    ('LIEF', 'rannte', 'D', 2, 5, 4),
    ('ERFAND', 'ersann', 'D', 3, 6, 6),
    ('FANS', 'Anhänger', 'D', 1, 7, 4),
    ('SIE', 'Anrede', 'D', 6, 7, 3),
    ('TATEN', 'Handlungen', 'D', 4, 8, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r084-9x9-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r084-9x9-03', 'Rätsel 84 · 9×9', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '9x9-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('RING', 'Reif', 'A', 1, 1, 4),
    ('AKT', 'Aufzug', 'A', 1, 6, 3),
    ('ARIE', 'Opernlied', 'A', 2, 1, 4),
    ('GAU', 'Landstrich', 'A', 2, 6, 3),
    ('TAXI', 'Droschke', 'A', 3, 1, 4),
    ('EIN', 'unbest. Artikel', 'A', 3, 6, 3),
    ('GANS', 'Federvieh', 'A', 4, 4, 4),
    ('KELTEN', 'Gallier', 'A', 5, 3, 6),
    ('SEI', 'existiere', 'A', 6, 1, 3),
    ('PURE', 'reine', 'A', 6, 5, 4),
    ('SIE', 'Anrede', 'A', 7, 1, 3),
    ('ERST', 'anfangs', 'A', 7, 5, 4),
    ('EDLEN', 'vornehmen', 'A', 8, 1, 5),
    ('RAT', 'Gremium', 'D', 1, 1, 3),
    ('ESSE', 'speise', 'D', 5, 1, 4),
    ('IRAK', 'Land am Tigris', 'D', 1, 2, 4),
    ('EID', 'Gelöbnis', 'D', 6, 2, 3),
    ('NIX', 'gar nichts', 'D', 1, 3, 3),
    ('KIEL', 'Förde-Stadt', 'D', 5, 3, 4),
    ('GEIGE', 'Violine', 'D', 1, 4, 5),
    ('ALPEN', 'Hochgebirge', 'D', 4, 5, 5),
    ('AGENTUR', 'Vermittlung', 'D', 1, 6, 7),
    ('KAISERS', 'Bart des ...', 'D', 1, 7, 7),
    ('TUN', 'machen', 'D', 1, 8, 3),
    ('NETZ', 'Geflecht', 'D', 5, 8, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r085-9x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r085-9x13-01', 'Rätsel 85 · 9×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '9x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('FORT', 'weg', 'A', 1, 1, 4),
    ('STAMMTE', 'rührte her', 'A', 1, 6, 7),
    ('EHER', 'vielmehr', 'A', 2, 1, 4),
    ('RAUEN', 'groben', 'A', 2, 8, 5),
    ('TRIEBE', 'Sprosse', 'A', 3, 1, 6),
    ('MUTIG', 'tapfer', 'A', 3, 8, 5),
    ('ZUENDET', 'entflammt', 'A', 4, 3, 7),
    ('ERDE', 'Welt', 'A', 5, 4, 4),
    ('BAU', 'Gebäude', 'A', 6, 1, 3),
    ('LEIB', 'Körper', 'A', 6, 5, 4),
    ('OFT', 'des Öfteren', 'A', 6, 10, 3),
    ('ULM', 'Münsterstadt', 'A', 7, 1, 3),
    ('INNE', '... halten', 'A', 7, 5, 4),
    ('HEU', 'Viehfutter', 'A', 7, 10, 3),
    ('BESEN', 'Kehrgerät', 'A', 8, 1, 5),
    ('EIGNER', 'Besitzer', 'A', 8, 7, 6),
    ('FETT', 'Schmalz', 'D', 1, 1, 4),
    ('BUB', 'Knabe', 'D', 6, 1, 3),
    ('OHR', 'Lauscher', 'D', 1, 2, 3),
    ('WALE', 'Meeressäuger', 'D', 5, 2, 4),
    ('REIZ', 'Charme', 'D', 1, 3, 4),
    ('UMS', 'um das', 'D', 6, 3, 3),
    ('TREUE', 'Loyalität', 'D', 1, 4, 5),
    ('BERLIN', 'Spree-Metropole', 'D', 3, 5, 6),
    ('SUENDEN', 'Verfehlungen', 'D', 1, 6, 7),
    ('DEINE', 'Possessiv (du)', 'D', 4, 7, 5),
    ('ARME', 'Bedürftige', 'D', 1, 8, 4),
    ('BEI', 'nahe an', 'D', 6, 8, 3),
    ('MAUT', 'Gebühr', 'D', 1, 9, 4),
    ('MUT', 'Courage', 'D', 1, 10, 3),
    ('HOHN', 'Spott', 'D', 5, 10, 4),
    ('TEIG', 'Masse', 'D', 1, 11, 4),
    ('FEE', 'Elfe', 'D', 6, 11, 3),
    ('ENG', 'schmal', 'D', 1, 12, 3),
    ('STUR', 'unnachgiebig', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r086-9x13-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r086-9x13-02', 'Rätsel 86 · 9×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x13-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('BUS', 'Car (schweiz.)', 'A', 1, 1, 3),
    ('LAG', 'befand sich', 'A', 1, 6, 3),
    ('ART', 'Sorte', 'A', 1, 10, 3),
    ('ORT', 'Stelle', 'A', 2, 1, 3),
    ('GEBE', 'reiche', 'A', 2, 5, 4),
    ('KUR', 'Heilaufenthalt', 'A', 2, 10, 3),
    ('DIEB', 'Langfinger', 'A', 3, 1, 4),
    ('BELAUFE', 'summiere', 'A', 3, 6, 7),
    ('ENGE', 'schmale', 'A', 4, 1, 4),
    ('ENDET', 'hört auf', 'A', 4, 6, 5),
    ('SAND', 'Wüstenboden', 'A', 5, 4, 4),
    ('SOBALD', 'wenn', 'A', 6, 1, 6),
    ('STIEG', 'kletterte', 'A', 6, 8, 5),
    ('HEGT', 'pflegt', 'A', 7, 2, 4),
    ('LIESSE', 'erlaubte', 'A', 7, 7, 6),
    ('BRITEN', 'Engländer', 'A', 8, 1, 6),
    ('ENTEN', 'Schwimmvögel', 'A', 8, 8, 5),
    ('BODENS', 'Qualität des ...', 'D', 1, 1, 6),
    ('URIN', 'Ausscheidung', 'D', 1, 2, 4),
    ('OHR', 'Hörorgan', 'D', 6, 2, 3),
    ('STEG', 'Brücklein', 'D', 1, 3, 4),
    ('BEI', 'nahe an', 'D', 6, 3, 3),
    ('BESAGT', 'bedeutet', 'D', 3, 4, 6),
    ('ALTE', 'greise', 'D', 5, 5, 4),
    ('LEBEND', 'atmend', 'D', 1, 6, 6),
    ('ABEND', 'Soiree', 'D', 1, 7, 5),
    ('GELD', 'Kapital', 'D', 1, 8, 4),
    ('SIE', 'Anrede', 'D', 6, 8, 3),
    ('AESTEN', 'Zweigen', 'D', 3, 9, 6),
    ('AKUT', 'dringend', 'D', 1, 10, 4),
    ('IST', 'befindet sich', 'D', 6, 10, 3),
    ('RUF', 'Ansehen', 'D', 1, 11, 3),
    ('LESE', 'studiere', 'D', 5, 11, 4),
    ('TREU', 'anhänglich', 'D', 1, 12, 4),
    ('GEN', 'nach', 'D', 6, 12, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r087-10x10-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r087-10x10-01', 'Rätsel 87 · 10×10', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '10x10-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('VOR', 'ehe', 'A', 1, 1, 3),
    ('SAGA', 'Heldensage', 'A', 1, 6, 4),
    ('OBIGE', 'erwähnte', 'A', 2, 1, 5),
    ('LAS', 'entzifferte', 'A', 2, 7, 3),
    ('LEGE', 'platziere', 'A', 3, 1, 4),
    ('FLUT', 'Hochwasser', 'A', 3, 6, 4),
    ('KNAPPE', 'enge', 'A', 4, 1, 6),
    ('LUECKE', 'Spalt', 'A', 5, 4, 6),
    ('SCHAR', 'Gruppe', 'A', 6, 1, 5),
    ('HAI', 'Raubfisch', 'A', 6, 7, 3),
    ('EHEN', 'Verbindungen', 'A', 7, 1, 4),
    ('PASS', 'Ausweis', 'A', 7, 6, 4),
    ('HORT', 'Schatz', 'A', 8, 1, 4),
    ('ROSE', 'Blume mit Dornen', 'A', 8, 6, 4),
    ('ERZ', 'Bodenschatz', 'A', 9, 1, 3),
    ('DOSEN', 'Büchsen', 'A', 9, 5, 5),
    ('VOLK', 'Nation', 'D', 1, 1, 4),
    ('SEHE', 'erblicke', 'D', 6, 1, 4),
    ('OBEN', 'in der Höhe', 'D', 1, 2, 4),
    ('CHOR', 'Singgruppe', 'D', 6, 2, 4),
    ('RIGA', 'lett. Hauptstadt', 'D', 1, 3, 4),
    ('HERZ', 'Pumpe', 'D', 6, 3, 4),
    ('GEPLANT', 'avisiert', 'D', 2, 4, 7),
    ('PUR', 'rein', 'D', 4, 5, 3),
    ('FEE', 'Elfe', 'D', 3, 6, 3),
    ('PRO', 'per', 'D', 7, 6, 3),
    ('ALL', 'Kosmos', 'D', 1, 7, 3),
    ('CHAOS', 'Wirrwarr', 'D', 5, 7, 5),
    ('GAU', 'Landesteil', 'D', 1, 8, 3),
    ('KASSE', 'Zahlstelle', 'D', 5, 8, 5),
    ('AST', 'Knorren', 'D', 1, 9, 3),
    ('EISEN', 'Ferrum', 'D', 5, 9, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r088-10x10-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r088-10x10-02', 'Rätsel 88 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ABT', 'Klosterchef', 'A', 1, 1, 3),
    ('TORTE', 'Kuchen', 'A', 1, 5, 5),
    ('SAUER', 'verärgert', 'A', 2, 1, 5),
    ('OEL', 'Rohstoff', 'A', 2, 7, 3),
    ('STEHE', 'ich ... auf', 'A', 3, 1, 5),
    ('HAB', '... und Gut', 'A', 3, 7, 3),
    ('ENORME', 'gewaltige', 'A', 4, 4, 6),
    ('SOUNDS', 'Klänge', 'A', 5, 1, 6),
    ('IHM', 'Dativ von er', 'A', 6, 1, 3),
    ('TRAF', 'begegnete', 'A', 6, 6, 4),
    ('ERZ', 'Bodenschatz', 'A', 7, 1, 3),
    ('WEIDE', 'Wiese', 'A', 7, 5, 5),
    ('HEU', 'Viehfutter', 'A', 8, 1, 3),
    ('ENGEL', 'Himmelsbote', 'A', 8, 5, 5),
    ('ENGEM', 'schmalem', 'A', 9, 1, 5),
    ('ALS', 'da, während', 'A', 9, 7, 3),
    ('ASS', 'verspeiste', 'D', 1, 1, 3),
    ('SIEHE', 'vgl.', 'D', 5, 1, 5),
    ('BAT', 'ersuchte', 'D', 1, 2, 3),
    ('OHREN', 'Hörorgane', 'D', 5, 2, 5),
    ('TUE', 'verrichte', 'D', 1, 3, 3),
    ('UMZUG', 'Parade', 'D', 5, 3, 5),
    ('EHEN', 'Verbindungen', 'D', 2, 4, 4),
    ('TREND', 'Tendenz', 'D', 1, 5, 5),
    ('WEM', 'Fragewort (Dativ)', 'D', 7, 5, 3),
    ('OSTEN', 'Morgenland', 'D', 4, 6, 5),
    ('ROHR', 'Leitung', 'D', 1, 7, 4),
    ('RIGA', 'lett. Hauptstadt', 'D', 6, 7, 4),
    ('TEAM', 'Mannschaft', 'D', 1, 8, 4),
    ('ADEL', 'Aristokratie', 'D', 6, 8, 4),
    ('ELBE', 'Strom durch Hamburg', 'D', 1, 9, 4),
    ('FELS', 'Klippe', 'D', 6, 9, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r089-10x10-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r089-10x10-03', 'Rätsel 89 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ESSAY', 'Aufsatz', 'A', 1, 1, 5),
    ('PRO', 'per', 'A', 1, 7, 3),
    ('REIN', 'sauber', 'A', 2, 1, 4),
    ('RUF', 'Ansehen', 'A', 2, 7, 3),
    ('GING', 'lief', 'A', 3, 1, 4),
    ('SAFT', 'Most', 'A', 3, 6, 4),
    ('ANGELEGT', 'investiert', 'A', 4, 1, 8),
    ('BETTEN', 'Lager', 'A', 5, 1, 6),
    ('ABFUHR', 'Absage', 'A', 6, 4, 6),
    ('FEINE', 'zarte', 'A', 7, 1, 5),
    ('MAG', 'liebt', 'A', 7, 7, 3),
    ('EIN', 'unbest. Artikel', 'A', 8, 1, 3),
    ('RASSE', 'Zuchtlinie', 'A', 8, 5, 5),
    ('ESSE', 'verspeise', 'A', 9, 1, 4),
    ('OEL', 'Rohstoff', 'A', 9, 7, 3),
    ('ERGAB', 'brachte', 'D', 1, 1, 5),
    ('FEE', 'Elfe', 'D', 7, 1, 3),
    ('SEINE', 'ihre', 'D', 1, 2, 5),
    ('EIS', 'Gefrorenes', 'D', 7, 2, 3),
    ('SINGT', 'trällert', 'D', 1, 3, 5),
    ('INS', 'in das', 'D', 7, 3, 3),
    ('ANGETAN', 'begeistert', 'D', 1, 4, 7),
    ('LEBER', 'große Drüse', 'D', 4, 5, 5),
    ('SENF', 'Gewürzpaste', 'D', 3, 6, 4),
    ('PRAG', 'Moldau-Stadt', 'D', 1, 7, 4),
    ('UMSO', 'desto', 'D', 6, 7, 4),
    ('RUFT', 'schreit', 'D', 1, 8, 4),
    ('HASE', 'Meister Lampe', 'D', 6, 8, 4),
    ('OFT', 'häufig', 'D', 1, 9, 3),
    ('ORGEL', 'Instrument', 'D', 5, 9, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r090-10x10-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r090-10x10-04', 'Rätsel 90 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('SHOW', 'Vorstellung', 'A', 1, 1, 4),
    ('STAB', 'Stock', 'A', 1, 6, 4),
    ('PUB', 'Wirtshaus', 'A', 2, 1, 3),
    ('FARCE', 'Posse', 'A', 2, 5, 5),
    ('OMEN', 'Vorzeichen', 'A', 3, 1, 4),
    ('NAHT', 'kommt näher', 'A', 3, 6, 4),
    ('TORE', 'Treffer', 'A', 4, 1, 4),
    ('GUTE', 'prima', 'A', 4, 6, 4),
    ('RETTETEN', 'bargen', 'A', 5, 2, 8),
    ('TON', 'Klang', 'A', 6, 4, 3),
    ('ATMET', 'holt Luft', 'A', 7, 1, 5),
    ('MAI', 'Wonnemonat', 'A', 7, 7, 3),
    ('LAUNE', 'Stimmung', 'A', 8, 1, 5),
    ('ALS', 'da, während', 'A', 8, 7, 3),
    ('ALT', 'betagt', 'A', 9, 1, 3),
    ('ROLLT', 'kullert', 'A', 9, 5, 5),
    ('SPOT', 'Werbeclip', 'D', 1, 1, 4),
    ('GALA', 'Festabend', 'D', 6, 1, 4),
    ('HUMOR', 'Witz', 'D', 1, 2, 5),
    ('TAL', 'Senke', 'D', 7, 2, 3),
    ('OBERE', 'höhere', 'D', 1, 3, 5),
    ('MUT', 'Tapferkeit', 'D', 7, 3, 3),
    ('NETTEN', 'freundlichen', 'D', 3, 4, 6),
    ('TOTER', 'verstorbener', 'D', 5, 5, 5),
    ('SANGEN', 'trällerten', 'D', 1, 6, 6),
    ('TRAUT', 'wagt', 'D', 1, 7, 5),
    ('MAL', 'einst', 'D', 7, 7, 3),
    ('ACHTE', 'nach der siebten', 'D', 1, 8, 5),
    ('ALL', 'Weltraum', 'D', 7, 8, 3),
    ('BETEN', 'flehen', 'D', 1, 9, 5),
    ('IST', 'befindet sich', 'D', 7, 9, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r091-11x11-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r091-11x11-01', 'Rätsel 91 · 11×11', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '11x11-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('LAMM', 'Schäfchen', 'A', 1, 1, 4),
    ('WEITE', 'ferne', 'A', 1, 6, 5),
    ('OPA', 'Opi', 'A', 2, 1, 3),
    ('DER', 'Artikel (männl.)', 'A', 2, 8, 3),
    ('TRIFFT', 'begegnet', 'A', 3, 1, 6),
    ('EIS', 'Gefrorenes', 'A', 3, 8, 3),
    ('KALT', 'frostig', 'A', 4, 7, 4),
    ('BLOED', 'doof', 'A', 5, 1, 5),
    ('ALTE', 'greise', 'A', 5, 7, 4),
    ('TRAUM', 'Wunschbild', 'A', 6, 3, 5),
    ('OFT', 'häufig', 'A', 7, 1, 3),
    ('SEELE', 'Psyche', 'A', 7, 5, 5),
    ('TEAM', 'Mannschaft', 'A', 8, 1, 4),
    ('BRAND', 'Feuer', 'A', 8, 6, 5),
    ('ETWA', 'ungefähr', 'A', 9, 1, 4),
    ('TANGO', 'argent. Tanz', 'A', 9, 6, 5),
    ('STANGE', 'Stab', 'A', 10, 1, 6),
    ('DEM', 'Artikel (Dativ)', 'A', 10, 8, 3),
    ('LOT', 'Senkrechte', 'D', 1, 1, 3),
    ('BOOTES', 'Rumpf des ...', 'D', 5, 1, 6),
    ('APRIL', 'Frühlingsmonat', 'D', 1, 2, 5),
    ('FETT', 'Schmalz', 'D', 7, 2, 4),
    ('MAI', 'Wonnemonat', 'D', 1, 3, 3),
    ('OTTAWA', 'kanad. Hauptstadt', 'D', 5, 3, 6),
    ('FUER', 'Präposition', 'D', 3, 4, 4),
    ('MAN', 'jemand', 'D', 8, 4, 3),
    ('DAS', 'Artikel (sächl.)', 'D', 5, 5, 3),
    ('WUT', 'Zorn', 'D', 1, 6, 3),
    ('UEBTE', 'trainierte', 'D', 6, 6, 5),
    ('KAMERA', 'Fotoapparat', 'D', 4, 7, 6),
    ('IDEAL', 'Leitbild', 'D', 1, 8, 5),
    ('LAND', 'Nation', 'D', 7, 8, 4),
    ('TEILT', 'trennt', 'D', 1, 9, 5),
    ('ENGE', 'knappe', 'D', 7, 9, 4),
    ('ERSTEN', 'anfänglichen', 'D', 1, 10, 6),
    ('DOM', 'Kathedrale', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r092-11x11-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r092-11x11-02', 'Rätsel 92 · 11×11', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '11x11-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ORT', 'Platz', 'A', 1, 1, 3),
    ('AKTIEN', 'Wertpapiere', 'A', 1, 5, 6),
    ('BAER', 'Petz', 'A', 2, 1, 4),
    ('RADIO', 'Rundfunk', 'A', 2, 6, 5),
    ('SEX', 'Geschlecht', 'A', 3, 1, 3),
    ('PATENT', 'Schutzrecht', 'A', 3, 5, 6),
    ('TUT', 'verrichtet', 'A', 4, 1, 3),
    ('KAHL', 'glatzköpfig', 'A', 5, 4, 4),
    ('STAUB', 'Schmutz', 'A', 6, 1, 5),
    ('IRIS', 'Regenbogenhaut', 'A', 6, 7, 4),
    ('CHEMNITZ', 'Karl-Marx-Stadt', 'A', 7, 3, 8),
    ('LOK', 'Zugmaschine', 'A', 8, 1, 3),
    ('REDETE', 'sprach', 'A', 8, 5, 6),
    ('OPER', 'Musiktheater', 'A', 9, 1, 4),
    ('HASEN', 'Langohren', 'A', 9, 6, 5),
    ('BAR', 'Lokal', 'A', 10, 1, 3),
    ('BLUETE', 'Blume', 'A', 10, 5, 6),
    ('OBST', 'Früchte', 'D', 1, 1, 4),
    ('LOB', 'Kompliment', 'D', 8, 1, 3),
    ('RAEUMT', 'leert', 'D', 1, 2, 6),
    ('OPA', 'Großvater', 'D', 8, 2, 3),
    ('TEXT', 'Wortlaut', 'D', 1, 3, 4),
    ('ACKER', 'Feld', 'D', 6, 3, 5),
    ('KUH', 'Rind', 'D', 5, 4, 3),
    ('ABER', 'jedoch', 'D', 5, 5, 4),
    ('KRACH', 'Lärm', 'D', 1, 6, 5),
    ('MEHL', 'Backzutat', 'D', 7, 6, 4),
    ('TAT', 'Werk', 'D', 1, 7, 3),
    ('LINDAU', 'Inselstadt', 'D', 5, 7, 6),
    ('IDEE', 'Gedanke', 'D', 1, 8, 4),
    ('RIESE', 'Hüne', 'D', 6, 8, 5),
    ('EIN', 'unbest. Artikel', 'D', 1, 9, 3),
    ('BITTET', 'ersucht', 'D', 5, 9, 6),
    ('NOTE', 'Tonzeichen', 'D', 1, 10, 4),
    ('SZENE', 'Auftritt', 'D', 6, 10, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r093-11x11-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r093-11x11-03', 'Rätsel 93 · 11×11', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '11x11-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('GRAB', 'Gruft', 'A', 1, 1, 4),
    ('GAST', 'Besucher', 'A', 1, 7, 4),
    ('HOB', 'wuchtete', 'A', 2, 1, 3),
    ('NEUBAU', 'moderne Immobilie', 'A', 2, 5, 6),
    ('AMTS', 'im ... sein', 'A', 3, 1, 4),
    ('STELE', 'Gedenkstein', 'A', 3, 6, 5),
    ('ESSENZ', 'Kern', 'A', 4, 4, 6),
    ('ATMETE', 'holte Luft', 'A', 5, 1, 6),
    ('DEM', 'Artikel (Dativ)', 'A', 5, 8, 3),
    ('ROSA', 'Pink', 'A', 6, 2, 4),
    ('BAR', 'Lokal', 'A', 7, 1, 3),
    ('DIE', 'Artikel (weibl.)', 'A', 7, 5, 3),
    ('LUD', 'forderte auf', 'A', 8, 1, 3),
    ('TRAFEN', 'begegneten', 'A', 8, 5, 6),
    ('OMEN', 'Vorzeichen', 'A', 9, 1, 4),
    ('ALIBI', 'Entlastung', 'A', 9, 6, 5),
    ('GAS', 'Treibstoff', 'A', 10, 1, 3),
    ('KETTE', 'Halsschmuck', 'A', 10, 6, 5),
    ('GHANA', 'Staat in Westafrika', 'D', 1, 1, 5),
    ('BLOG', 'Webjournal', 'D', 7, 1, 4),
    ('ROM', 'Hauptstadt Italiens', 'D', 1, 2, 3),
    ('TRAUMA', 'seelische Wunde', 'D', 5, 2, 6),
    ('ABT', 'Ordensoberer', 'D', 1, 3, 3),
    ('MORDES', 'Motiv des ...', 'D', 5, 3, 6),
    ('SEES', 'Fläche des ...', 'D', 3, 4, 4),
    ('STADT', 'Kommune', 'D', 4, 5, 5),
    ('ESSE', 'speise', 'D', 2, 6, 4),
    ('IRAK', 'Zweistromland', 'D', 7, 6, 4),
    ('GUTE', 'prima', 'D', 1, 7, 4),
    ('REALE', 'wirkliche', 'D', 6, 7, 5),
    ('ABEND', 'Soiree', 'D', 1, 8, 5),
    ('FIT', 'sportlich', 'D', 8, 8, 3),
    ('SALZE', 'Mineralien', 'D', 1, 9, 5),
    ('HEBT', 'stemmt', 'D', 7, 9, 4),
    ('TUE', 'verrichte', 'D', 1, 10, 3),
    ('NIE', 'zu keiner Zeit', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r094-9x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r094-9x13-03', 'Rätsel 94 · 9×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '9x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('TUER', 'Pforte', 'A', 1, 1, 4),
    ('GASTHOF', 'Wirtshaus', 'A', 1, 6, 7),
    ('ANSAGE', 'Durchsage', 'A', 2, 1, 6),
    ('TEURE', 'kostspielige', 'A', 2, 8, 5),
    ('TIEREN', 'Kreaturen', 'A', 3, 1, 6),
    ('UEBTE', 'probte', 'A', 3, 8, 5),
    ('WEHR', 'Staustufe', 'A', 4, 5, 4),
    ('MINE', 'Bergwerk', 'A', 5, 4, 4),
    ('GAGE', 'Honorar', 'A', 5, 9, 4),
    ('AFFEN', 'Primaten', 'A', 6, 1, 5),
    ('LEADER', 'Anführer', 'A', 6, 7, 6),
    ('LAIEN', 'Amateure', 'A', 7, 1, 5),
    ('LEID', 'Weh', 'A', 7, 9, 4),
    ('EXTREME', 'äußerste', 'A', 8, 1, 7),
    ('ALLE', 'Pronomen', 'A', 8, 9, 4),
    ('TAT', 'Werk', 'D', 1, 1, 3),
    ('MALE', 'Zeichen', 'D', 5, 1, 4),
    ('UNI', 'Hochschule', 'D', 1, 2, 3),
    ('FAX', 'Telekopie', 'D', 6, 2, 3),
    ('ESEL', 'Grautier', 'D', 1, 3, 4),
    ('FIT', 'gesund', 'D', 6, 3, 3),
    ('RAR', 'selten', 'D', 1, 4, 3),
    ('MEER', 'See', 'D', 5, 4, 4),
    ('GEWINNE', 'Profite', 'D', 2, 5, 7),
    ('GENEN', 'Erbanlagen', 'D', 1, 6, 5),
    ('HELFE', 'unterstütze', 'D', 4, 7, 5),
    ('STUR', 'starrsinnig', 'D', 1, 8, 4),
    ('TEE', 'Heißgetränk', 'D', 1, 9, 3),
    ('GALA', 'Festabend', 'D', 5, 9, 4),
    ('HUB', 'Kolbenweg', 'D', 1, 10, 3),
    ('ADEL', 'Aristokratie', 'D', 5, 10, 4),
    ('ORT', 'Platz', 'D', 1, 11, 3),
    ('GEIL', 'toll (ugs.)', 'D', 5, 11, 4),
    ('FEE', 'Zauberin', 'D', 1, 12, 3),
    ('ERDE', 'Heimatplanet', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r095-12x12-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r095-12x12-01', 'Rätsel 95 · 12×12', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '12x12-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('HAI', 'Raubfisch', 'A', 1, 1, 3),
    ('SEIL', 'Tau', 'A', 1, 8, 4),
    ('ECHTEM', 'wahrem', 'A', 2, 1, 6),
    ('AURA', 'Ausstrahlung', 'A', 2, 8, 4),
    ('UHR', 'Chronometer', 'A', 3, 1, 3),
    ('PAARES', 'Hochzeit des ...', 'A', 3, 6, 6),
    ('OSTENS', 'Völker des ...', 'A', 4, 6, 6),
    ('REGIERT', 'herrscht', 'A', 5, 1, 7),
    ('HAELT', 'stoppt', 'A', 6, 2, 5),
    ('KENNE', 'weiß', 'A', 7, 1, 5),
    ('STEIN', 'Fels', 'A', 7, 7, 5),
    ('GEN', 'nach', 'A', 8, 3, 3),
    ('TANTE', 'Muhme', 'A', 8, 7, 5),
    ('OMA', 'Omi', 'A', 9, 1, 3),
    ('DRANGEN', 'stießen vor', 'A', 9, 5, 7),
    ('PART', 'Rolle', 'A', 10, 1, 4),
    ('ORGELN', 'Instrumente', 'A', 10, 6, 6),
    ('FIT', 'gesund', 'A', 11, 1, 3),
    ('TRENNT', 'scheidet', 'A', 11, 6, 6),
    ('HEUER', 'dieses Jahr', 'D', 1, 1, 5),
    ('KNOPF', 'Taste', 'D', 7, 1, 5),
    ('ACH', 'Ausruf', 'D', 1, 2, 3),
    ('EHE', 'Vermählung', 'D', 5, 2, 3),
    ('MAI', 'Wonnemonat', 'D', 9, 2, 3),
    ('IHR', 'Pronomen (2. Pl.)', 'D', 1, 3, 3),
    ('GANGART', 'Schritt', 'D', 5, 3, 7),
    ('DIENE', 'nütze', 'D', 4, 4, 5),
    ('ELEND', 'Misere', 'D', 5, 5, 5),
    ('IMPORT', 'Einfuhr', 'D', 1, 6, 6),
    ('ROT', 'purpurn', 'D', 9, 6, 3),
    ('AST', 'Zweig', 'D', 3, 7, 3),
    ('STARR', 'steif', 'D', 7, 7, 5),
    ('SAAT', 'Samen', 'D', 1, 8, 4),
    ('STANGE', 'Stab', 'D', 6, 8, 6),
    ('EUREM', 'Possessiv (ihr)', 'D', 1, 9, 5),
    ('ENGEN', 'schmalen', 'D', 7, 9, 5),
    ('IREN', 'Gälen', 'D', 1, 10, 4),
    ('TITELN', 'Namen', 'D', 6, 10, 6),
    ('LASST', 'erlaubt', 'D', 1, 11, 5),
    ('NENNT', 'bezeichnet', 'D', 7, 11, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r096-12x12-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r096-12x12-02', 'Rätsel 96 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('WARF', 'schleuderte', 'A', 1, 1, 4),
    ('ALTE', 'greise', 'A', 1, 8, 4),
    ('IDEE', 'Gedanke', 'A', 2, 1, 4),
    ('URLAUB', 'Ferien', 'A', 2, 6, 6),
    ('ERGEBE', 'resultiere', 'A', 3, 1, 6),
    ('LEGE', 'platziere', 'A', 3, 8, 4),
    ('GEN', 'nach', 'A', 4, 1, 3),
    ('DEN', 'Artikel (Akkusativ)', 'A', 4, 9, 3),
    ('ESEL', 'Grautier', 'A', 5, 1, 4),
    ('ZEHEN', 'Fußglieder', 'A', 5, 6, 5),
    ('STUTE', 'weibl. Pferd', 'A', 6, 2, 5),
    ('ENDE', 'Finale', 'A', 6, 8, 4),
    ('REEDER', 'Schiffsherr', 'A', 7, 1, 6),
    ('ALB', 'Gebirge', 'A', 8, 7, 3),
    ('GASE', 'Dämpfe', 'A', 9, 1, 4),
    ('IREN', 'Gälen', 'A', 9, 8, 4),
    ('EBENSO', 'gleichfalls', 'A', 10, 1, 6),
    ('GEHT', 'läuft', 'A', 10, 8, 4),
    ('STEG', 'Brücklein', 'A', 11, 1, 4),
    ('FREIES', 'ungebundenes', 'A', 11, 6, 6),
    ('WIEGE', 'Kinderbett', 'D', 1, 1, 5),
    ('REGES', 'lebhaftes', 'D', 7, 1, 5),
    ('ADRESSE', 'Anschrift', 'D', 1, 2, 7),
    ('ABT', 'Ordensoberer', 'D', 9, 2, 3),
    ('REGNETE', 'goss', 'D', 1, 3, 7),
    ('SEE', 'Gewässer', 'D', 9, 3, 3),
    ('FEE', 'Zauberin', 'D', 1, 4, 3),
    ('LUD', 'forderte auf', 'D', 5, 4, 3),
    ('ENG', 'schmal', 'D', 9, 4, 3),
    ('TEE', 'Aufguss', 'D', 6, 5, 3),
    ('KUERZER', 'knapper', 'D', 1, 6, 7),
    ('HOF', 'Grundstück', 'D', 9, 6, 3),
    ('ALL', 'Kosmos', 'D', 1, 8, 3),
    ('HEILIGE', 'Sankt', 'D', 5, 8, 7),
    ('LAEDEN', 'Geschäfte', 'D', 1, 9, 6),
    ('BREI', 'Mus', 'D', 8, 9, 4),
    ('TUGEND', 'Moral', 'D', 1, 10, 6),
    ('EHE', 'Bund fürs Leben', 'D', 9, 10, 3),
    ('EBEN', 'just', 'D', 1, 11, 4),
    ('EVENTS', 'Happenings', 'D', 6, 11, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r097-12x12-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r097-12x12-03', 'Rätsel 97 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('SPALT', 'Ritze', 'A', 1, 1, 5),
    ('PLAZA', 'Platz', 'A', 1, 7, 5),
    ('ALKOHOL', 'Weingeist', 'A', 2, 1, 7),
    ('LOK', 'Zugmaschine', 'A', 2, 9, 3),
    ('MATTE', 'Unterlage', 'A', 3, 1, 5),
    ('TOT', 'verstorben', 'A', 3, 9, 3),
    ('TEE', 'Heißgetränk', 'A', 4, 1, 3),
    ('MINE', 'Bergwerk', 'A', 4, 5, 4),
    ('AMT', 'Dienststelle', 'A', 5, 5, 3),
    ('DUO', 'Tandem', 'A', 5, 9, 3),
    ('WERT', 'Bedeutung', 'A', 6, 1, 4),
    ('SESSEL', 'Polstersitz', 'A', 7, 5, 6),
    ('WEG', 'Pfad', 'A', 8, 1, 3),
    ('EROSION', 'Abtragung', 'A', 8, 5, 7),
    ('ERNTE', 'Lese', 'A', 9, 1, 5),
    ('HECKE', 'Buschwerk', 'A', 9, 7, 5),
    ('IDEALEN', 'perfekten', 'A', 10, 1, 7),
    ('HAI', 'Meeresräuber', 'A', 10, 9, 3),
    ('NETTE', 'freundliche', 'A', 11, 1, 5),
    ('FELD', 'Acker', 'A', 11, 8, 4),
    ('SAMT', 'inklusive', 'D', 1, 1, 4),
    ('WEIN', 'Rebensaft', 'D', 8, 1, 4),
    ('PLAENE', 'Vorhaben', 'D', 1, 2, 6),
    ('ERDE', 'Heimatplanet', 'D', 8, 2, 4),
    ('AKTE', 'Vorgang', 'D', 1, 3, 4),
    ('REGNET', 'gießt', 'D', 6, 3, 6),
    ('LOT', 'Senkblei', 'D', 1, 4, 3),
    ('TAT', 'Werk', 'D', 9, 4, 3),
    ('THEMA', 'Sujet', 'D', 1, 5, 5),
    ('SEELE', 'Psyche', 'D', 7, 5, 5),
    ('IMMER', 'ständig', 'D', 4, 6, 5),
    ('PLANT', 'beabsichtigt', 'D', 1, 7, 5),
    ('SOHN', 'Nachkomme', 'D', 7, 7, 4),
    ('ESSE', 'verspeise', 'D', 6, 8, 4),
    ('ALT', 'ergraut', 'D', 1, 9, 3),
    ('EICHE', 'Laubbaum', 'D', 7, 9, 5),
    ('ZOO', 'Tiergarten', 'D', 1, 10, 3),
    ('LOKAL', 'Gaststätte', 'D', 7, 10, 5),
    ('AKTION', 'Unternehmung', 'D', 1, 11, 6),
    ('NEID', 'Eifersucht', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r098-12x12-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r098-12x12-04', 'Rätsel 98 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AUFSTIEG', 'Karriere', 'A', 1, 1, 8),
    ('TEUER', 'kostspielig', 'A', 2, 1, 5),
    ('IHM', 'Dativ von er', 'A', 2, 7, 3),
    ('EBENE', 'Fläche', 'A', 3, 1, 5),
    ('DAUER', 'Zeitspanne', 'A', 3, 7, 5),
    ('MERKT', 'spürt', 'A', 4, 1, 5),
    ('NEID', 'Eifersucht', 'A', 4, 8, 4),
    ('TERRASSE', 'Veranda', 'A', 5, 4, 8),
    ('SET', 'Satz', 'A', 6, 9, 3),
    ('ZUG', 'Sog', 'A', 7, 2, 3),
    ('OFFEN', 'geöffnet', 'A', 7, 6, 5),
    ('DIVA', 'Primadonna', 'A', 8, 1, 4),
    ('PER', 'via', 'A', 8, 6, 3),
    ('REISST', 'zerrt', 'A', 9, 1, 6),
    ('OVAL', 'länglich-rund', 'A', 9, 8, 4),
    ('EHE', 'Vermählung', 'A', 10, 1, 3),
    ('HORT', 'Schatz', 'A', 10, 8, 4),
    ('HELL', 'licht', 'A', 11, 1, 4),
    ('KLEMME', 'Zwickmühle', 'A', 11, 6, 6),
    ('ATEM', 'Odem', 'D', 1, 1, 4),
    ('DREH', 'Kniff', 'D', 8, 1, 4),
    ('UEBER', 'oberhalb', 'D', 1, 2, 5),
    ('ZIEHE', 'zerre', 'D', 7, 2, 5),
    ('FUER', 'zugunsten', 'D', 1, 3, 4),
    ('ZUVIEL', 'übermäßig', 'D', 6, 3, 6),
    ('SENKT', 'reduziert', 'D', 1, 4, 5),
    ('GAS', 'Brennstoff', 'D', 7, 4, 3),
    ('TRETEN', 'kicken', 'D', 1, 5, 6),
    ('OPTIK', 'Aussehen', 'D', 7, 6, 5),
    ('EID', 'Gelöbnis', 'D', 1, 7, 3),
    ('RUFE', 'Schreie', 'D', 5, 7, 4),
    ('GHANA', 'Staat in Westafrika', 'D', 1, 8, 5),
    ('FROHE', 'heitere', 'D', 7, 8, 5),
    ('MUESSE', 'solle', 'D', 2, 9, 6),
    ('VOM', 'von dem', 'D', 9, 9, 3),
    ('EISEN', 'Ferrum', 'D', 3, 10, 5),
    ('ARM', 'Extremität', 'D', 9, 10, 3),
    ('WERDET', 'entsteht', 'D', 1, 11, 6),
    ('ALTE', 'betagte', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r099-13x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r099-13x13-01', 'Rätsel 99 · 13×13', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '13x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('WOG', 'schwankte', 'A', 1, 1, 3),
    ('KAM', 'nahte', 'A', 1, 5, 3),
    ('STAR', 'Berühmtheit', 'A', 1, 9, 4),
    ('IRAN', 'Golfstaat', 'A', 2, 1, 4),
    ('REGER', 'lebhafter', 'A', 2, 6, 5),
    ('RISIKEN', 'Gefahren', 'A', 3, 1, 7),
    ('TAGT', 'berät', 'A', 3, 9, 4),
    ('ERNST', 'Seriosität', 'A', 4, 4, 5),
    ('DIR', 'Dat. (2. Pers.)', 'A', 5, 1, 3),
    ('AACHENER', '... Printen', 'A', 5, 5, 8),
    ('UNION', 'Bündnis', 'A', 6, 1, 5),
    ('HEXE', 'Zauberin', 'A', 6, 7, 4),
    ('BAT', 'ersuchte', 'A', 7, 1, 3),
    ('MARKT', 'Basar', 'A', 7, 8, 5),
    ('ALTE', 'greise', 'A', 8, 1, 4),
    ('IRAK', 'Land am Tigris', 'A', 8, 6, 4),
    ('TIEF', 'abgründig', 'A', 9, 9, 4),
    ('LUSTIGE', 'heitere', 'A', 10, 2, 7),
    ('RIO', 'Zuckerhut-Stadt', 'A', 10, 10, 3),
    ('MONTAG', 'Wochenstart', 'A', 11, 1, 6),
    ('IST', 'befindet sich', 'A', 11, 10, 3),
    ('SIEGE', 'Triumphe', 'A', 12, 2, 5),
    ('DESTO', 'umso', 'A', 12, 8, 5),
    ('WIR', 'Pronomen (1. Pl.)', 'D', 1, 1, 3),
    ('DUBAI', 'Emirat', 'D', 5, 1, 5),
    ('ORIGINAL', 'Urfassung', 'D', 1, 2, 8),
    ('LOS', 'frei', 'D', 10, 2, 3),
    ('GAS', 'Brennstoff', 'D', 1, 3, 3),
    ('RITT', 'Reise zu Pferd', 'D', 5, 3, 4),
    ('UNI', 'Alma Mater', 'D', 10, 3, 3),
    ('NIE', 'zu keiner Zeit', 'D', 2, 4, 3),
    ('ERSTE', 'führende', 'D', 8, 4, 5),
    ('KRAN', 'Hebezeug', 'D', 3, 5, 4),
    ('TAG', '24 Stunden', 'D', 10, 5, 3),
    ('ARENA', 'Stadion', 'D', 1, 6, 5),
    ('EINIGE', 'manche', 'D', 7, 6, 6),
    ('MENSCH', 'Person', 'D', 1, 7, 6),
    ('THEMA', 'Gegenstand', 'D', 4, 8, 5),
    ('EID', 'Gelöbnis', 'D', 10, 8, 3),
    ('SET', 'Ausstattung', 'D', 1, 9, 3),
    ('EXAKT', 'genau', 'D', 5, 9, 5),
    ('TRAINER', 'Coach', 'D', 1, 10, 7),
    ('IRIS', 'Schwertlilie', 'D', 9, 10, 4),
    ('KREIST', 'zirkuliert', 'D', 7, 11, 6),
    ('ROT', 'knallig', 'D', 1, 12, 3),
    ('RAT', 'Gremium', 'D', 5, 12, 3),
    ('FOTO', 'Schnappschuss', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r100-13x13-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r100-13x13-02', 'Rätsel 100 · 13×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '13x13-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('SOKRATES', 'griech. Philosoph', 'A', 1, 1, 8),
    ('LOK', 'Triebwagen', 'A', 1, 10, 3),
    ('LEBEN', 'Dasein', 'A', 2, 3, 5),
    ('WAHL', 'Abstimmung', 'A', 2, 9, 4),
    ('ANTIKE', 'Altertum', 'A', 3, 3, 6),
    ('UNI', 'Hochschule', 'A', 3, 10, 3),
    ('ISST', 'speist', 'A', 4, 1, 4),
    ('LERNTEN', 'paukten', 'A', 4, 6, 7),
    ('LESE', 'studiere', 'A', 5, 1, 4),
    ('ELBE', 'Strom durch Hamburg', 'A', 5, 6, 4),
    ('DIENEN', 'nützen', 'A', 6, 1, 6),
    ('GUT', 'brauchbar', 'A', 6, 8, 3),
    ('TUEREN', 'Pforten', 'A', 7, 7, 6),
    ('NASS', 'feucht', 'A', 8, 3, 4),
    ('ADAPTER', 'Stecker', 'A', 9, 1, 7),
    ('ECKE', 'Winkel', 'A', 9, 9, 4),
    ('LIEFEN', 'rannten', 'A', 10, 1, 6),
    ('BIKER', 'Rocker', 'A', 10, 8, 5),
    ('TEHERAN', 'iran. Hauptstadt', 'A', 11, 1, 7),
    ('LEIB', 'Körper', 'A', 11, 9, 4),
    ('ESEL', 'Grautier', 'A', 12, 1, 4),
    ('NENNE', 'bezeichne', 'A', 12, 8, 5),
    ('SCHILDE', 'Wappen', 'D', 1, 1, 7),
    ('ALTE', 'betagte', 'D', 9, 1, 4),
    ('SEI', 'existiere', 'D', 4, 2, 3),
    ('DIES', 'Pronomen', 'D', 9, 2, 4),
    ('KLASSE', 'Kategorie', 'D', 1, 3, 6),
    ('NAEHE', 'Umgebung', 'D', 8, 3, 5),
    ('RENTEN', 'Pensionen', 'D', 1, 4, 6),
    ('APFEL', 'Kernobst', 'D', 8, 4, 5),
    ('ABT', 'Klosterchef', 'D', 1, 5, 3),
    ('ERSTER', 'anfänglicher', 'D', 6, 5, 6),
    ('TEILEN', 'zu gleichen ...', 'D', 1, 6, 6),
    ('SENAT', 'Ältestenrat', 'D', 8, 6, 5),
    ('ENKEL', 'Kindeskind', 'D', 1, 7, 5),
    ('ERBGUT', 'Gene', 'D', 3, 8, 6),
    ('NEUE', 'frische', 'D', 4, 9, 4),
    ('EILE', 'Hast', 'D', 9, 9, 4),
    ('LAUT', 'lärmend', 'D', 1, 10, 4),
    ('TROCKEN', 'dürr', 'D', 6, 10, 7),
    ('OHNE', 'abzüglich', 'D', 1, 11, 4),
    ('KEIN', 'nicht ein', 'D', 9, 11, 4),
    ('KLINGEN', 'tönen', 'D', 1, 12, 7),
    ('ERBE', 'Thronfolger', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r101-13x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r101-13x13-03', 'Rätsel 101 · 13×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '13x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ODER', 'bzw.', 'A', 1, 1, 4),
    ('AST', 'Knorren', 'A', 1, 6, 3),
    ('GEN', 'nach', 'A', 1, 10, 3),
    ('FIX', 'schnell', 'A', 2, 1, 3),
    ('BAEUME', 'Gehölze', 'A', 2, 5, 6),
    ('TEPPICHE', 'Läufer', 'A', 3, 1, 8),
    ('NEU', 'aktuell', 'A', 3, 10, 3),
    ('BLUEHT', 'gedeiht', 'A', 4, 2, 6),
    ('JETS', 'Düsenflieger', 'A', 4, 9, 4),
    ('IRRE', 'Wahnsinnige', 'A', 5, 3, 4),
    ('RAT', 'Gremium', 'A', 5, 10, 3),
    ('ERZ', 'Gestein', 'A', 6, 1, 3),
    ('NOTLAGE', 'Krise', 'A', 6, 6, 7),
    ('SAITE', 'Draht', 'A', 7, 1, 5),
    ('SAALE', 'Fluss durch Halle', 'A', 7, 7, 5),
    ('ENTE', 'Wasservogel', 'A', 8, 1, 4),
    ('OMEN', 'Vorbote', 'A', 8, 6, 4),
    ('ANGOLA', 'Staat in Afrika', 'A', 9, 7, 6),
    ('ZWAR', 'freilich', 'A', 10, 1, 4),
    ('UND', 'sowie', 'A', 10, 6, 3),
    ('HOB', 'stemmte', 'A', 10, 10, 3),
    ('TEUER', 'kostspielig', 'A', 11, 1, 5),
    ('EINIGE', 'diverse', 'A', 11, 7, 6),
    ('EHEN', 'Bündnisse', 'A', 12, 1, 4),
    ('ENG', 'schmal', 'A', 12, 6, 3),
    ('OEL', 'Schmierstoff', 'A', 12, 10, 3),
    ('OFT', 'des Öfteren', 'D', 1, 1, 3),
    ('GESETZTE', 'reife', 'D', 5, 1, 8),
    ('DIEB', 'Langfinger', 'D', 1, 2, 4),
    ('RAN', 'hinzu', 'D', 6, 2, 3),
    ('WEH', 'schmerzhaft', 'D', 10, 2, 3),
    ('EXPLIZIT', 'ausdrücklich', 'D', 1, 3, 8),
    ('AUE', 'Talwiese', 'D', 10, 3, 3),
    ('PUR', 'unverfälscht', 'D', 3, 4, 3),
    ('TEUREN', 'kostbaren', 'D', 7, 4, 6),
    ('BIER', 'Gerstensaft', 'D', 2, 5, 4),
    ('AACHEN', 'Kaiserstadt', 'D', 1, 6, 6),
    ('SEHT', 'schaut', 'D', 1, 7, 4),
    ('OSMANEN', 'Türken', 'D', 6, 7, 7),
    ('TUE', 'mache', 'D', 1, 8, 3),
    ('STAENDIG', 'dauernd', 'D', 5, 8, 8),
    ('LANG', 'ausgedehnt', 'D', 6, 9, 4),
    ('GENERAL', 'Heerführer', 'D', 1, 10, 7),
    ('OHIO', 'Buckeye-Staat', 'D', 9, 10, 4),
    ('ETAGE', 'Stockwerk', 'D', 3, 11, 5),
    ('LOGE', 'Theaterrang', 'D', 9, 11, 4),
    ('NEUSTE', 'jüngste', 'D', 1, 12, 6),
    ('KABEL', 'Leitung', 'D', 8, 12, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r102-15x15-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r102-15x15-02', 'Rätsel 102 · 15×15', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '15x15-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('FAUNA', 'Tierwelt', 'A', 1, 1, 5),
    ('ERBES', 'Wert des ...', 'A', 1, 10, 5),
    ('ART', 'Spezies', 'A', 2, 1, 3),
    ('GRAU', 'farblos', 'A', 2, 5, 4),
    ('LAUNE', 'Stimmung', 'A', 2, 10, 5),
    ('IMAGE', 'Ansehen', 'A', 3, 1, 5),
    ('DRAENGTE', 'schob', 'A', 3, 7, 8),
    ('HUNDES', 'Bellen des ...', 'A', 4, 3, 6),
    ('STIL', 'Machart', 'A', 5, 4, 4),
    ('IDOL', 'Star', 'A', 5, 9, 4),
    ('RUSS', 'Rauchstaub', 'A', 6, 1, 4),
    ('AST', 'Zweig', 'A', 6, 6, 3),
    ('POSE', 'Haltung', 'A', 6, 11, 4),
    ('ABT', 'Klosterchef', 'A', 7, 1, 3),
    ('PEGEL', 'Wasserstand', 'A', 7, 10, 5),
    ('GAU', 'Landstrich', 'A', 8, 1, 3),
    ('ATLAS', 'Kartenwerk', 'A', 8, 5, 5),
    ('ROT', 'purpurn', 'A', 8, 11, 3),
    ('TIROL', 'Alpenland', 'A', 9, 1, 5),
    ('FEIN', 'zart', 'A', 9, 8, 4),
    ('FLUT', 'Hochwasser', 'A', 10, 4, 4),
    ('BUB', 'Junge', 'A', 10, 12, 3),
    ('ASTEROID', 'Kleinplanet', 'A', 11, 2, 8),
    ('LEHM', 'Ton', 'A', 11, 11, 4),
    ('WUT', 'Zorn', 'A', 12, 1, 3),
    ('MIR', 'Dat. (1. Pers.)', 'A', 12, 5, 3),
    ('AURA', 'Fluidum', 'A', 12, 11, 4),
    ('ELEFANT', 'Dickhäuter', 'A', 13, 1, 7),
    ('RENTEN', 'Pensionen', 'A', 13, 9, 6),
    ('MAG', 'hat gern', 'A', 14, 1, 3),
    ('EIN', 'unbest. Artikel', 'A', 14, 7, 3),
    ('DENN', 'Konjunktion', 'A', 14, 11, 4),
    ('FAIR', 'gerecht', 'D', 1, 1, 4),
    ('RAGTE', 'erhob sich', 'D', 6, 1, 5),
    ('WEM', 'Fragewort (Dativ)', 'D', 12, 1, 3),
    ('ARM', 'Extremität', 'D', 1, 2, 3),
    ('DUBAI', 'Emirat', 'D', 5, 2, 5),
    ('AULA', 'Festsaal', 'D', 11, 2, 4),
    ('UTAH', 'Mormonenstaat', 'D', 1, 3, 4),
    ('STUR', 'unnachgiebig', 'D', 6, 3, 4),
    ('STEG', 'Bootsanleger', 'D', 11, 3, 4),
    ('GUSS', 'Regenschauer', 'D', 3, 4, 4),
    ('OFT', 'häufig', 'D', 9, 4, 3),
    ('AGENT', 'Geheimdienstler', 'D', 1, 5, 5),
    ('ALLEMAL', 'sicher', 'D', 8, 5, 7),
    ('DIAET', 'Schonkost', 'D', 4, 6, 5),
    ('URIN', 'Ausscheidung', 'D', 10, 6, 4),
    ('ADELS', 'Titel des ...', 'D', 2, 7, 5),
    ('TORTE', 'Kuchen', 'D', 10, 7, 5),
    ('KURS', 'Richtung', 'D', 1, 8, 4),
    ('TRAF', 'kreuzte', 'D', 6, 8, 4),
    ('SENDERN', 'Kanälen', 'D', 8, 9, 7),
    ('ELEND', 'Misere', 'D', 1, 10, 5),
    ('RAN', 'heran', 'D', 1, 11, 3),
    ('OPERN', 'Musikdramen', 'D', 5, 11, 5),
    ('LAND', 'Nation', 'D', 11, 11, 4),
    ('BUG', 'Programmfehler', 'D', 1, 12, 3),
    ('LOGO', 'Emblem', 'D', 5, 12, 4),
    ('BEUTE', 'Raubgut', 'D', 10, 12, 5),
    ('ENTE', 'Wasservogel', 'D', 1, 13, 4),
    ('SET', 'Ausstattung', 'D', 6, 13, 3),
    ('UHREN', 'Zeitmesser', 'D', 10, 13, 5),
    ('SEE', 'Weiher', 'D', 1, 14, 3),
    ('OEL', 'Schmierstoff', 'D', 5, 14, 3),
    ('OBMANN', 'Vorsitzender', 'D', 9, 14, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r103-15x15-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r103-15x15-03', 'Rätsel 103 · 15×15', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '15x15-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('PEDAL', 'Fußhebel', 'A', 1, 1, 5),
    ('MASSSTAB', 'Richtschnur', 'A', 1, 7, 8),
    ('ARIE', 'Opernlied', 'A', 2, 1, 4),
    ('GALA', 'Festabend', 'A', 2, 6, 4),
    ('ADEL', 'blaues Blut', 'A', 3, 1, 4),
    ('LUST', 'Verlangen', 'A', 3, 6, 4),
    ('HERR', 'Gebieter', 'A', 3, 11, 4),
    ('RESTLOS', 'völlig', 'A', 4, 1, 7),
    ('WOG', 'schaukelte', 'A', 4, 12, 3),
    ('LIMA', 'peruan. Hauptstadt', 'A', 5, 11, 4),
    ('HAAR', 'Strähne', 'A', 6, 1, 4),
    ('SEX', 'Erotik', 'A', 6, 6, 3),
    ('BEGAB', 'machte sich auf', 'A', 6, 10, 5),
    ('ILLEGAL', 'verboten', 'A', 7, 1, 7),
    ('HABEN', 'besitzen', 'A', 7, 9, 5),
    ('TAT', 'Werk', 'A', 8, 1, 3),
    ('ERFREUT', 'beglückt', 'A', 8, 5, 7),
    ('ETWA', 'ungefähr', 'A', 9, 11, 4),
    ('TALER', 'alte Münze', 'A', 10, 1, 5),
    ('ABT', 'Ordensoberer', 'A', 10, 7, 3),
    ('NEUE', 'frische', 'A', 10, 11, 4),
    ('OMA', 'Großmutter', 'A', 11, 1, 3),
    ('UEBRIG', 'restlich', 'A', 11, 5, 6),
    ('REH', 'Waldtier', 'A', 11, 12, 3),
    ('BANGE', 'ängstlich', 'A', 12, 1, 5),
    ('ZOG', 'zerrte', 'A', 12, 7, 3),
    ('IRRE', 'Wahnsinnige', 'A', 12, 11, 4),
    ('GEBAUTE', 'errichtete', 'A', 13, 3, 7),
    ('HOF', 'Grundstück', 'A', 13, 11, 3),
    ('EVENT', 'Ereignis', 'A', 14, 1, 5),
    ('NARREN', 'Toren', 'A', 14, 9, 6),
    ('PAAR', 'einige', 'D', 1, 1, 4),
    ('HIT', 'Schlager', 'D', 6, 1, 3),
    ('TOBTE', 'wütete', 'D', 10, 1, 5),
    ('ERDE', 'Welt', 'D', 1, 2, 4),
    ('ALABAMA', 'Südstaat', 'D', 6, 2, 7),
    ('DIES', 'Pronomen', 'D', 1, 3, 4),
    ('ALT', 'betagt', 'D', 6, 3, 3),
    ('LANGE', 'geraume Zeit', 'D', 10, 3, 5),
    ('AELTERE', 'betagtere', 'D', 1, 4, 7),
    ('GEN', 'nach', 'D', 12, 4, 3),
    ('GETRUEBT', 'verschleiert', 'D', 7, 5, 8),
    ('GLOSSAR', 'Wortliste', 'D', 2, 6, 7),
    ('MAUS', 'Nager', 'D', 1, 7, 4),
    ('ELF', 'Zahl (10+1)', 'D', 6, 7, 3),
    ('ABZUG', 'Rückzug', 'D', 10, 7, 5),
    ('ALS', 'da, während', 'D', 1, 8, 3),
    ('BROT', 'Laib', 'D', 10, 8, 4),
    ('SATZ', 'Sprung', 'D', 1, 9, 4),
    ('HEUTIGEN', 'aktuellen', 'D', 7, 9, 8),
    ('BAU', 'Gebäude', 'D', 6, 10, 3),
    ('SAH', 'blickte', 'D', 1, 11, 3),
    ('LEBTEN', 'existierten', 'D', 5, 11, 6),
    ('IHR', 'Pronomen (2. Pl.)', 'D', 12, 11, 3),
    ('EWIGE', 'endlose', 'D', 3, 12, 5),
    ('TERROR', 'Schrecken', 'D', 9, 12, 6),
    ('ROMAN', 'Erzählung', 'D', 3, 13, 5),
    ('WUERFE', 'Schüsse', 'D', 9, 13, 6),
    ('BERGAB', 'abwärts', 'D', 1, 14, 6),
    ('NAEHE', 'Umgebung', 'D', 8, 14, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r104-15x15-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r104-15x15-01', 'Rätsel 104 · 15×15', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '15x15-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AKUT', 'dringend', 'A', 1, 1, 4),
    ('BOX', 'Kiste', 'A', 1, 6, 3),
    ('TALES', 'Grund des ...', 'A', 1, 10, 5),
    ('GENIALE', 'brillante', 'A', 2, 1, 7),
    ('TORE', 'Treffer', 'A', 2, 9, 4),
    ('ENTE', 'Wasservogel', 'A', 3, 1, 4),
    ('ALB', 'Gebirge', 'A', 3, 6, 3),
    ('BEIDE', 'alle zwei', 'A', 3, 10, 5),
    ('NIEREN', 'Organe', 'A', 4, 1, 6),
    ('TABUS', 'Verbote', 'A', 4, 10, 5),
    ('DAR', 'stellt ... (zeigt)', 'A', 5, 1, 3),
    ('IKONE', 'Heiligenbild', 'A', 5, 5, 5),
    ('WAR', 'existierte', 'A', 6, 12, 3),
    ('KRIEGS', 'Ende des ...', 'A', 7, 2, 6),
    ('HAWAII', 'Inselstaat der USA', 'A', 7, 9, 6),
    ('BAT', 'flehte', 'A', 8, 1, 3),
    ('NAEHERES', 'Genaueres', 'A', 8, 5, 8),
    ('NEU', 'frisch', 'A', 9, 4, 3),
    ('LAG', 'ruhte', 'A', 9, 9, 3),
    ('JAPAN', 'Nippon', 'A', 10, 1, 5),
    ('HALT', 'eben', 'A', 10, 7, 4),
    ('ATEM', 'Odem', 'A', 11, 1, 4),
    ('HABE', 'besitze', 'A', 11, 6, 4),
    ('POSE', 'Haltung', 'A', 11, 11, 4),
    ('GEREGELT', 'geordnet', 'A', 12, 1, 8),
    ('ERHOB', 'stemmte', 'A', 12, 10, 5),
    ('NARBE', 'Wundmal', 'A', 13, 4, 5),
    ('HOEFE', 'Anwesen', 'A', 13, 10, 5),
    ('NIX', 'nichts', 'A', 14, 1, 3),
    ('BREITE', 'Weite', 'A', 14, 5, 6),
    ('MAN', 'Pronomen', 'A', 14, 12, 3),
    ('AGENDA', 'Tagesordnung', 'D', 1, 1, 6),
    ('JAGEN', 'hetzen', 'D', 10, 1, 5),
    ('KENIA', 'Staat in Ostafrika', 'D', 1, 2, 5),
    ('KARATE', 'Kampfsport', 'D', 7, 2, 6),
    ('UNTERART', 'Varietät', 'D', 1, 3, 8),
    ('PER', 'mittels', 'D', 10, 3, 3),
    ('TIER', 'Lebewesen', 'D', 1, 4, 4),
    ('NAMEN', 'Benennungen', 'D', 9, 4, 5),
    ('EIGENEN', 'persönlichen', 'D', 4, 5, 7),
    ('GAB', 'schenkte', 'D', 12, 5, 3),
    ('BLANK', 'glänzend', 'D', 1, 6, 5),
    ('GAU', 'Landstrich', 'D', 7, 6, 3),
    ('HERR', 'Meister', 'D', 11, 6, 4),
    ('OEL', 'Schmierstoff', 'D', 1, 7, 3),
    ('OASE', 'Wüsteninsel', 'D', 5, 7, 4),
    ('HALBE', 'zur ... Stunde', 'D', 10, 7, 5),
    ('BIN', 'existiere', 'D', 3, 8, 3),
    ('ABTEI', 'Kloster', 'D', 10, 8, 5),
    ('HELLE', 'lichte', 'D', 7, 9, 5),
    ('TOBT', 'wütet', 'D', 1, 10, 4),
    ('PARAT', 'bereit', 'D', 6, 10, 5),
    ('EHE', 'Bund fürs Leben', 'D', 12, 10, 3),
    ('AREAL', 'Gelände', 'D', 1, 11, 5),
    ('WEG', 'Route', 'D', 7, 11, 3),
    ('PRO', 'je', 'D', 11, 11, 3),
    ('LEIB', 'Körper', 'D', 1, 12, 4),
    ('WAS', 'Fragewort (Sache)', 'D', 6, 12, 3),
    ('HOHEM', 'großem', 'D', 10, 12, 5),
    ('DUBAI', 'Emirat', 'D', 3, 13, 5),
    ('SOFA', 'Couch', 'D', 11, 13, 4),
    ('SEES', 'Ufer des ...', 'D', 1, 14, 4),
    ('RIEF', 'schrie', 'D', 6, 14, 4),
    ('EBEN', 'flach', 'D', 11, 14, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

commit;
-- Automatisch erzeugt von tools/generator/generate_raetsel.py – nicht von Hand bearbeiten.
-- Voraussetzung: Migrationen, gitter_vorlagen.sql, woerter_seed.sql, fragen_varianten_seed.sql eingespielt.
-- Idempotent über raetsel.slug. Rätsel mit Prüfhinweisen werden als Entwurf angelegt.

begin;

-- r105-8x8-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r105-8x8-01', 'Rätsel 105 · 8×8', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '8x8-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('UMSO', 'desto', 'A', 1, 1, 4),
    ('HOERST', 'lauschst', 'A', 2, 1, 6),
    ('REITER', 'Jockey', 'A', 3, 1, 6),
    ('ETAT', 'Budget', 'A', 4, 4, 4),
    ('HEU', 'Trockengras', 'A', 5, 1, 3),
    ('ZUR', 'zu der', 'A', 5, 5, 3),
    ('MIETE', 'Pacht', 'A', 6, 3, 5),
    ('BIS', 'nicht später als', 'A', 7, 1, 3),
    ('NEU', 'frisch', 'A', 7, 5, 3),
    ('UHR', 'Zeitmesser', 'D', 1, 1, 3),
    ('HOB', 'stemmte', 'D', 5, 1, 3),
    ('MOEGE', 'solle', 'D', 1, 2, 5),
    ('SEI', 'existiere', 'D', 1, 3, 3),
    ('UMS', 'um das', 'D', 5, 3, 3),
    ('ORTE', 'Plätze', 'D', 1, 4, 4),
    ('SETZEN', 'stellen', 'D', 2, 5, 6),
    ('TRAUTE', 'wagte', 'D', 2, 6, 6),
    ('TREU', 'loyal', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r106-8x8-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r106-8x8-02', 'Rätsel 106 · 8×8', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '8x8-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('BANK', 'Sitzmöbel', 'A', 1, 4, 4),
    ('KABUL', 'afghan. Hauptstadt', 'A', 2, 1, 5),
    ('AGENT', 'Spion', 'A', 3, 1, 5),
    ('NETT', 'freundlich', 'A', 4, 1, 4),
    ('REMIS', 'Gleichstand', 'A', 5, 3, 5),
    ('ANIME', 'jap. Zeichentrick', 'A', 6, 3, 5),
    ('AUF', 'offen', 'A', 7, 1, 3),
    ('TAT', 'Handlung', 'A', 7, 5, 3),
    ('KANADA', 'Ahornland', 'D', 2, 1, 6),
    ('TAGE', 'je 24 Stunden', 'D', 1, 2, 4),
    ('BETRAF', 'anging', 'D', 2, 3, 6),
    ('BUNTEN', 'farbigen', 'D', 1, 4, 6),
    ('ALT', 'betagt', 'D', 1, 5, 3),
    ('MIT', 'samt', 'D', 5, 5, 3),
    ('LIMA', 'peruan. Hauptstadt', 'D', 4, 6, 4),
    ('KAM', 'nahte', 'D', 1, 7, 3),
    ('SET', 'Satz', 'D', 5, 7, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r107-8x8-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r107-8x8-03', 'Rätsel 107 · 8×8', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '8x8-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('EINSAM', 'verlassen', 'A', 1, 1, 6),
    ('SIEGER', 'Gewinner', 'A', 2, 2, 6),
    ('STEHEN', 'aufrecht sein', 'A', 3, 1, 6),
    ('ENGE', 'schmale', 'A', 4, 4, 4),
    ('ABT', 'Klosterchef', 'A', 5, 1, 3),
    ('DER', 'Artikel (männl.)', 'A', 5, 5, 3),
    ('NEU', 'frisch', 'A', 6, 1, 3),
    ('ANS', 'an das', 'A', 6, 5, 3),
    ('DIES', 'das hier', 'A', 7, 1, 4),
    ('STAND', 'stockte', 'D', 3, 1, 5),
    ('IST', 'befindet sich', 'D', 1, 2, 3),
    ('BEI', 'nahe an', 'D', 5, 2, 3),
    ('NIE', 'nimmer', 'D', 1, 3, 3),
    ('TUE', 'mache', 'D', 5, 3, 3),
    ('SEHE', 'erblicke', 'D', 1, 4, 4),
    ('AGENDA', 'Tagesordnung', 'D', 1, 5, 6),
    ('MENGEN', 'Massen', 'D', 1, 6, 6),
    ('ERST', 'zunächst', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r108-9x9-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r108-9x9-01', 'Rätsel 108 · 9×9', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x9-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ROTE', 'purpurne', 'A', 1, 1, 4),
    ('AST', 'Zweig', 'A', 1, 6, 3),
    ('EBEN', 'flach', 'A', 2, 1, 4),
    ('SEI', 'existiere', 'A', 2, 6, 3),
    ('SEIT', 'ab', 'A', 3, 1, 4),
    ('SET', 'Satz', 'A', 3, 6, 3),
    ('ENGE', 'schmale', 'A', 4, 1, 4),
    ('POOL', 'Becken', 'A', 5, 5, 4),
    ('VORWURF', 'Anklage', 'A', 6, 1, 7),
    ('EREILTE', 'traf', 'A', 7, 1, 7),
    ('THESEN', 'Behauptungen', 'A', 8, 2, 6),
    ('RESERVE', 'Rücklage', 'D', 1, 1, 7),
    ('OBEN', 'in der Höhe', 'D', 1, 2, 4),
    ('ORT', 'Stelle', 'D', 6, 2, 3),
    ('TEIG', 'Masse', 'D', 1, 3, 4),
    ('REH', 'Waldtier', 'D', 6, 3, 3),
    ('ENTE', 'Wasservogel', 'D', 1, 4, 4),
    ('WIE', 'gleich', 'D', 6, 4, 3),
    ('PULS', 'Herzschlag', 'D', 5, 5, 4),
    ('ASS', 'speiste', 'D', 1, 6, 3),
    ('ORTE', 'Plätze', 'D', 5, 6, 4),
    ('SEE', 'Gewässer', 'D', 1, 7, 3),
    ('OFEN', 'Herd', 'D', 5, 7, 4),
    ('TITEL', 'Überschrift', 'D', 1, 8, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r109-9x9-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r109-9x9-02', 'Rätsel 109 · 9×9', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '9x9-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AHNT', 'vermutet', 'A', 1, 1, 4),
    ('OFT', 'häufig', 'A', 1, 6, 3),
    ('SAUER', 'verärgert', 'A', 2, 1, 5),
    ('STREIKS', 'Ausstände', 'A', 3, 1, 7),
    ('ERST', 'zunächst', 'A', 4, 5, 4),
    ('ZWEITE', 'nächste', 'A', 5, 1, 6),
    ('WEIN', 'Rebensaft', 'A', 6, 1, 4),
    ('IST', 'befindet sich', 'A', 6, 6, 3),
    ('EHEN', 'Bündnisse', 'A', 7, 1, 4),
    ('SEE', 'Gewässer', 'A', 7, 6, 3),
    ('IRRE', 'Verrückte', 'A', 8, 1, 4),
    ('EIN', 'unbest. Artikel', 'A', 8, 6, 3),
    ('ASS', 'speiste', 'D', 1, 1, 3),
    ('ZWEI', 'Zahl (1+1)', 'D', 5, 1, 4),
    ('HAT', 'besitzt', 'D', 1, 2, 3),
    ('WEHR', 'Staustufe', 'D', 5, 2, 4),
    ('NUR', 'lediglich', 'D', 1, 3, 3),
    ('EIER', 'Gelege', 'D', 5, 3, 4),
    ('TEE', 'Heißgetränk', 'D', 1, 4, 3),
    ('INNE', '... halten', 'D', 5, 4, 4),
    ('RIET', 'empfahl', 'D', 2, 5, 4),
    ('KREISE', 'Zirkel', 'D', 3, 6, 6),
    ('FUSS', 'Sockel', 'D', 1, 7, 4),
    ('SEI', 'existiere', 'D', 6, 7, 3),
    ('TOTEN', 'Verstorbenen', 'D', 4, 8, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r110-9x9-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r110-9x9-03', 'Rätsel 110 · 9×9', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '9x9-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('RUND', 'kreisförmig', 'A', 1, 1, 4),
    ('IST', 'befindet sich', 'A', 1, 6, 3),
    ('ARIE', 'Sologesang', 'A', 2, 1, 4),
    ('NEU', 'frisch', 'A', 2, 6, 3),
    ('DIES', 'das hier', 'A', 3, 1, 4),
    ('HIN', '... und her', 'A', 3, 6, 3),
    ('TRAT', 'schritt', 'A', 4, 4, 4),
    ('SOEBEN', 'gerade', 'A', 5, 3, 6),
    ('EHE', 'Bund fürs Leben', 'A', 6, 1, 3),
    ('GENE', 'Erbanlagen', 'A', 6, 5, 4),
    ('REH', 'Waldtier', 'A', 7, 1, 3),
    ('ERST', 'zunächst', 'A', 7, 5, 4),
    ('TURIN', 'Stadt am Po', 'A', 8, 1, 5),
    ('RAD', 'Velo', 'D', 1, 1, 3),
    ('WERT', 'Bedeutung', 'D', 5, 1, 4),
    ('URIN', 'Harn', 'D', 1, 2, 4),
    ('HEU', 'Trockengras', 'D', 6, 2, 3),
    ('NIE', 'nimmer', 'D', 1, 3, 3),
    ('SEHR', 'äußerst', 'D', 5, 3, 4),
    ('DESTO', 'umso', 'D', 1, 4, 5),
    ('REGEN', 'Niederschlag', 'D', 4, 5, 5),
    ('INHABER', 'Eigentümer', 'D', 1, 6, 7),
    ('SEITENS', 'von', 'D', 1, 7, 7),
    ('TUN', 'machen', 'D', 1, 8, 3),
    ('NETZ', 'Geflecht', 'D', 5, 8, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r111-9x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r111-9x13-01', 'Rätsel 111 · 9×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('JOBS', 'Stellen', 'A', 1, 1, 4),
    ('HIERBEI', 'dabei', 'A', 1, 6, 7),
    ('AERA', 'Epoche', 'A', 2, 1, 4),
    ('HIESS', 'nannte sich', 'A', 2, 8, 5),
    ('GLAUBT', 'meint', 'A', 3, 1, 6),
    ('REIST', 'fährt', 'A', 3, 8, 5),
    ('VERLIEF', 'ging aus', 'A', 4, 3, 7),
    ('RUIN', 'Untergang', 'A', 5, 4, 4),
    ('TAL', 'Senke', 'A', 6, 1, 3),
    ('ENDE', 'Schluss', 'A', 6, 5, 4),
    ('UNI', 'Hochschule', 'A', 6, 10, 3),
    ('OMA', 'Großmutter', 'A', 7, 1, 3),
    ('HEER', 'Armee', 'A', 7, 5, 4),
    ('HIN', '... und her', 'A', 7, 10, 3),
    ('REGEL', 'Norm', 'A', 8, 1, 5),
    ('SZENEN', 'Auftritte', 'A', 8, 7, 6),
    ('JAGT', 'verfolgt', 'D', 1, 1, 4),
    ('TOR', 'Treffer', 'D', 6, 1, 3),
    ('OEL', 'Schmierstoff', 'D', 1, 2, 3),
    ('NAME', 'Bezeichnung', 'D', 5, 2, 4),
    ('BRAV', 'artig', 'D', 1, 3, 4),
    ('LAG', 'ruhte', 'D', 6, 3, 3),
    ('SAUER', 'verärgert', 'D', 1, 4, 5),
    ('BRUEHL', 'Stadt bei Köln', 'D', 3, 5, 6),
    ('HOTLINE', 'Kundentelefon', 'D', 1, 6, 7),
    ('INDES', 'jedoch', 'D', 4, 7, 5),
    ('EHRE', 'Würde', 'D', 1, 8, 4),
    ('ERZ', 'Gestein', 'D', 6, 8, 3),
    ('RIEF', 'schrie', 'D', 1, 9, 4),
    ('BEI', 'nahe an', 'D', 1, 10, 3),
    ('HUHN', 'Henne', 'D', 5, 10, 4),
    ('ESSE', 'speise', 'D', 1, 11, 4),
    ('NIE', 'nimmer', 'D', 6, 11, 3),
    ('IST', 'befindet sich', 'D', 1, 12, 3),
    ('SINN', 'Bedeutung', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r112-9x13-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r112-9x13-02', 'Rätsel 112 · 9×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x13-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('HEU', 'Trockengras', 'A', 1, 1, 3),
    ('BAR', 'Theke', 'A', 1, 6, 3),
    ('OMA', 'Großmutter', 'A', 1, 10, 3),
    ('UHR', 'Zeitmesser', 'A', 2, 1, 3),
    ('GERA', 'Stadt in Thüringen', 'A', 2, 5, 4),
    ('DAR', 'stellt ... (zeigt)', 'A', 2, 10, 3),
    ('SENF', 'Mostrich', 'A', 3, 1, 4),
    ('TENDENZ', 'Trend', 'A', 3, 6, 7),
    ('TREU', 'loyal', 'A', 4, 1, 4),
    ('RADAR', 'Ortungsgerät', 'A', 4, 6, 5),
    ('EGAL', 'gleichgültig', 'A', 5, 4, 4),
    ('NOTRUF', 'SOS', 'A', 6, 1, 6),
    ('FEIND', 'Gegner', 'A', 6, 8, 5),
    ('FETT', 'Schmalz', 'A', 7, 2, 4),
    ('REISTE', 'fuhr', 'A', 7, 7, 6),
    ('STEHEN', 'aufrecht sein', 'A', 8, 1, 6),
    ('ENTEN', 'Wasservögel', 'A', 8, 8, 5),
    ('HUSTEN', 'Keuchen', 'D', 1, 1, 6),
    ('EHER', 'lieber', 'D', 1, 2, 4),
    ('OFT', 'häufig', 'D', 6, 2, 3),
    ('URNE', 'Aschengefäß', 'D', 1, 3, 4),
    ('TEE', 'Heißgetränk', 'D', 6, 3, 3),
    ('FUERTH', 'Stadt bei Nürnberg', 'D', 3, 4, 6),
    ('GUTE', 'prima', 'D', 5, 5, 4),
    ('BETRAF', 'anging', 'D', 1, 6, 6),
    ('AREAL', 'Gelände', 'D', 1, 7, 5),
    ('RAND', 'Kante', 'D', 1, 8, 4),
    ('FEE', 'Zauberin', 'D', 6, 8, 3),
    ('DASEIN', 'Existenz', 'D', 3, 9, 6),
    ('ODER', 'bzw.', 'D', 1, 10, 4),
    ('IST', 'befindet sich', 'D', 6, 10, 3),
    ('MAN', 'jemand', 'D', 1, 11, 3),
    ('ENTE', 'Wasservogel', 'D', 5, 11, 4),
    ('ARZT', 'Mediziner', 'D', 1, 12, 4),
    ('DEN', 'Artikel (Akkusativ)', 'D', 6, 12, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r113-9x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r113-9x13-03', 'Rätsel 113 · 9×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '9x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('OBEN', 'in der Höhe', 'A', 1, 1, 4),
    ('EINGABE', 'Gesuch', 'A', 1, 6, 7),
    ('MUSEEN', 'Galerien', 'A', 2, 1, 6),
    ('AALEN', 'Stadt in Württemberg', 'A', 2, 8, 5),
    ('ABSURD', 'unsinnig', 'A', 3, 1, 6),
    ('MUTIG', 'tapfer', 'A', 3, 8, 5),
    ('LEGE', 'platziere', 'A', 4, 5, 4),
    ('LESE', 'schmökere', 'A', 5, 4, 4),
    ('OELE', 'Fette', 'A', 5, 9, 4),
    ('ERHOB', 'stemmte', 'A', 6, 1, 5),
    ('NARBEN', 'Wundmale', 'A', 6, 7, 6),
    ('LAEGE', 'ruhte', 'A', 7, 1, 5),
    ('TEIG', 'Masse', 'A', 7, 9, 4),
    ('STUENDE', 'wäre', 'A', 8, 1, 7),
    ('ENDE', 'Schluss', 'A', 8, 9, 4),
    ('OMA', 'Großmutter', 'D', 1, 1, 3),
    ('FELS', 'Stein', 'D', 5, 1, 4),
    ('BUB', 'Knabe', 'D', 1, 2, 3),
    ('RAT', 'Tipp', 'D', 6, 2, 3),
    ('ESSE', 'speise', 'D', 1, 3, 4),
    ('HEU', 'Trockengras', 'D', 6, 3, 3),
    ('NEU', 'frisch', 'D', 1, 4, 3),
    ('LOGE', 'Theaterrang', 'D', 5, 4, 4),
    ('ERLEBEN', 'erfahren', 'D', 2, 5, 7),
    ('ENDES', 'letzten ...', 'D', 1, 6, 5),
    ('GENIE', 'Talent', 'D', 4, 7, 5),
    ('NAME', 'Bezeichnung', 'D', 1, 8, 4),
    ('GAU', 'Landstrich', 'D', 1, 9, 3),
    ('ORTE', 'Plätze', 'D', 5, 9, 4),
    ('ALT', 'betagt', 'D', 1, 10, 3),
    ('EBEN', 'flach', 'D', 5, 10, 4),
    ('BEI', 'nahe an', 'D', 1, 11, 3),
    ('LEID', 'Kummer', 'D', 5, 11, 4),
    ('ENG', 'schmal', 'D', 1, 12, 3),
    ('ENGE', 'schmale', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r114-10x10-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r114-10x10-01', 'Rätsel 114 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('PER', 'mittels', 'A', 1, 1, 3),
    ('KORB', 'Absage', 'A', 1, 6, 4),
    ('FUERS', 'für das', 'A', 2, 1, 5),
    ('MAI', '5. Monat', 'A', 2, 7, 3),
    ('ARIE', 'Sologesang', 'A', 3, 1, 4),
    ('KANN', 'vermag', 'A', 3, 6, 4),
    ('DESSAU', 'Bauhausstadt', 'A', 4, 1, 6),
    ('SCHEMA', 'Muster', 'A', 5, 4, 6),
    ('STROH', 'Halme', 'A', 6, 1, 5),
    ('VON', 'ab, aus', 'A', 6, 7, 3),
    ('HAAR', 'Strähne', 'A', 7, 1, 4),
    ('WERK', 'Fabrik', 'A', 7, 6, 4),
    ('OBST', 'Früchte', 'A', 8, 1, 4),
    ('ENDE', 'Schluss', 'A', 8, 6, 4),
    ('WUT', 'Zorn', 'A', 9, 1, 3),
    ('UNTER', 'inmitten', 'A', 9, 5, 5),
    ('PFAD', 'Weg', 'D', 1, 1, 4),
    ('SHOW', 'Vorstellung', 'D', 6, 1, 4),
    ('EURE', 'Possessiv (ihr)', 'D', 1, 2, 4),
    ('TABU', 'verboten', 'D', 6, 2, 4),
    ('REIS', 'Getreideart', 'D', 1, 3, 4),
    ('RAST', 'jagt', 'D', 6, 3, 4),
    ('RESSORT', 'Bereich', 'D', 2, 4, 7),
    ('ACH', 'Ausruf', 'D', 4, 5, 3),
    ('KUH', 'Rind', 'D', 3, 6, 3),
    ('WEN', 'Fragewort (Akk.)', 'D', 7, 6, 3),
    ('OMA', 'Großmutter', 'D', 1, 7, 3),
    ('EVENT', 'Ereignis', 'D', 5, 7, 5),
    ('RAN', 'heran', 'D', 1, 8, 3),
    ('MORDE', 'Tötungen', 'D', 5, 8, 5),
    ('BIN', 'existiere', 'D', 1, 9, 3),
    ('ANKER', 'Halt', 'D', 5, 9, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r115-10x10-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r115-10x10-02', 'Rätsel 115 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('OHR', 'Hörorgan', 'A', 1, 1, 3),
    ('TAFEL', 'Schild', 'A', 1, 5, 5),
    ('PAARE', 'Duos', 'A', 2, 1, 5),
    ('RIO', 'Stadt in Brasilien', 'A', 2, 7, 3),
    ('ABTEI', 'Kloster', 'A', 3, 1, 5),
    ('ENG', 'schmal', 'A', 3, 7, 3),
    ('GLEISE', 'Schienen', 'A', 4, 4, 6),
    ('STRESS', 'Hektik', 'A', 5, 1, 6),
    ('PRO', 'je', 'A', 6, 1, 3),
    ('SEES', 'Ufer des ...', 'A', 6, 6, 4),
    ('AUS', 'vorbei', 'A', 7, 1, 3),
    ('WENDE', 'Umschwung', 'A', 7, 5, 5),
    ('EHE', 'Bund fürs Leben', 'A', 8, 1, 3),
    ('ENDEN', 'aufhören', 'A', 8, 5, 5),
    ('TENOR', 'Sängerstimme', 'A', 9, 1, 5),
    ('ELF', 'Zahl (10+1)', 'A', 9, 7, 3),
    ('OPA', 'Großvater', 'D', 1, 1, 3),
    ('SPAET', 'nicht früh', 'D', 5, 1, 5),
    ('HAB', '... und Gut', 'D', 1, 2, 3),
    ('TRUHE', 'Kiste', 'D', 5, 2, 5),
    ('RAT', 'Tipp', 'D', 1, 3, 3),
    ('ROSEN', 'Dornblumen', 'D', 5, 3, 5),
    ('REGE', 'lebhaft', 'D', 2, 4, 4),
    ('TEILS', 'partiell', 'D', 1, 5, 5),
    ('WER', 'Fragewort (Person)', 'D', 7, 5, 3),
    ('ESSEN', 'Mahlzeit', 'D', 4, 6, 5),
    ('FREI', 'ungebunden', 'D', 1, 7, 4),
    ('ENDE', 'Schluss', 'D', 6, 7, 4),
    ('EINS', 'Zahl (2−1)', 'D', 1, 8, 4),
    ('EDEL', 'vornehm', 'D', 6, 8, 4),
    ('LOGE', 'Theaterrang', 'D', 1, 9, 4),
    ('SENF', 'Mostrich', 'D', 6, 9, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r116-10x10-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r116-10x10-03', 'Rätsel 116 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ASIEN', 'Erdteil', 'A', 1, 1, 5),
    ('APP', 'Anwendung', 'A', 1, 7, 3),
    ('DENN', 'weil', 'A', 2, 1, 4),
    ('KUR', 'Erholung', 'A', 2, 7, 3),
    ('LEST', 'studiert', 'A', 3, 1, 4),
    ('EURO', 'Währung', 'A', 3, 6, 4),
    ('ELEGANTE', 'schicke', 'A', 4, 1, 8),
    ('RELIKT', 'Überbleibsel', 'A', 5, 1, 6),
    ('NUESSE', 'Kerne', 'A', 6, 4, 6),
    ('SINGT', 'trällert', 'A', 7, 1, 5),
    ('TAG', '24 Stunden', 'A', 7, 7, 3),
    ('EHE', 'Bund fürs Leben', 'A', 8, 1, 3),
    ('EWIGE', 'endlose', 'A', 8, 5, 5),
    ('TRUG', 'schleppte', 'A', 9, 1, 4),
    ('LAS', 'schmökerte', 'A', 9, 7, 3),
    ('ADLER', 'Greifvogel', 'D', 1, 1, 5),
    ('SET', 'Satz', 'D', 7, 1, 3),
    ('SEELE', 'Psyche', 'D', 1, 2, 5),
    ('IHR', 'Pronomen (2. Pl.)', 'D', 7, 2, 3),
    ('INSEL', 'Eiland', 'D', 1, 3, 5),
    ('NEU', 'frisch', 'D', 7, 3, 3),
    ('ENTGING', 'entkam', 'D', 1, 4, 7),
    ('AKUTE', 'dringende', 'D', 4, 5, 5),
    ('ENTE', 'Wasservogel', 'D', 3, 6, 4),
    ('AKUT', 'dringend', 'D', 1, 7, 4),
    ('STIL', 'Machart', 'D', 6, 7, 4),
    ('PURE', 'reine', 'D', 1, 8, 4),
    ('SAGA', 'Heldensage', 'D', 6, 8, 4),
    ('PRO', 'je', 'D', 1, 9, 3),
    ('REGES', 'lebhaftes', 'D', 5, 9, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r117-10x10-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r117-10x10-04', 'Rätsel 117 · 10×10', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '10x10-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('OMEN', 'Vorzeichen', 'A', 1, 1, 4),
    ('DOMS', 'Kuppel des ...', 'A', 1, 6, 4),
    ('FIX', 'schnell', 'A', 2, 1, 3),
    ('PARAT', 'bereit', 'A', 2, 5, 5),
    ('ENTE', 'Wasservogel', 'A', 3, 1, 4),
    ('EDLE', 'vornehme', 'A', 3, 6, 4),
    ('NERV', 'Reizleiter', 'A', 4, 1, 4),
    ('NETT', 'freundlich', 'A', 4, 6, 4),
    ('NAEHERES', 'Genaueres', 'A', 5, 2, 8),
    ('NUN', 'jetzt', 'A', 6, 4, 3),
    ('ERNTE', 'Lese', 'A', 7, 1, 5),
    ('AST', 'Zweig', 'A', 7, 7, 3),
    ('GEIST', 'Gespenst', 'A', 8, 1, 5),
    ('RIO', 'Stadt in Brasilien', 'A', 8, 7, 3),
    ('EHE', 'Bund fürs Leben', 'A', 9, 1, 3),
    ('ENGEN', 'schmalen', 'A', 9, 5, 5),
    ('OFEN', 'Herd', 'D', 1, 1, 4),
    ('REGE', 'lebhaft', 'D', 6, 1, 4),
    ('MINEN', 'Bergwerke', 'D', 1, 2, 5),
    ('REH', 'Waldtier', 'D', 7, 2, 3),
    ('EXTRA', 'zusätzlich', 'D', 1, 3, 5),
    ('NIE', 'nimmer', 'D', 7, 3, 3),
    ('EVENTS', 'Anlässe', 'D', 3, 4, 6),
    ('HUETE', 'Kappen', 'D', 5, 5, 5),
    ('DAENEN', 'Skandinavier', 'D', 1, 6, 6),
    ('ORDER', 'Auftrag', 'D', 1, 7, 5),
    ('ARG', 'schlimm', 'D', 7, 7, 3),
    ('MALTE', 'pinselte', 'D', 1, 8, 5),
    ('SIE', 'Anrede', 'D', 7, 8, 3),
    ('STETS', 'immer', 'D', 1, 9, 5),
    ('TON', 'Klang', 'D', 7, 9, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r118-11x11-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r118-11x11-01', 'Rätsel 118 · 11×11', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '11x11-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('VITA', 'Lebenslauf', 'A', 1, 1, 4),
    ('WEISE', 'Art', 'A', 1, 6, 5),
    ('OMA', 'Großmutter', 'A', 2, 1, 3),
    ('NIX', 'nichts', 'A', 2, 8, 3),
    ('MAGIER', 'Zauberer', 'A', 3, 1, 6),
    ('SET', 'Satz', 'A', 3, 8, 3),
    ('MEHR', 'zusätzlich', 'A', 4, 7, 4),
    ('SEIEN', 'wären', 'A', 5, 1, 5),
    ('ALTE', 'betagte', 'A', 5, 7, 4),
    ('NEUEN', 'frischen', 'A', 6, 3, 5),
    ('HAT', 'besitzt', 'A', 7, 1, 3),
    ('NICHT', 'keineswegs', 'A', 7, 5, 5),
    ('LEID', 'Kummer', 'A', 8, 1, 4),
    ('CHAOS', 'Wirrwarr', 'A', 8, 6, 5),
    ('ARME', 'Mittellose', 'A', 9, 1, 4),
    ('HERDE', 'Schar', 'A', 9, 6, 5),
    ('GAESTE', 'Besucher', 'A', 10, 1, 6),
    ('TEE', 'Heißgetränk', 'A', 10, 8, 3),
    ('VOM', 'von dem', 'D', 1, 1, 3),
    ('SCHLAG', 'Hieb', 'D', 5, 1, 6),
    ('IMAGE', 'Ansehen', 'D', 1, 2, 5),
    ('AERA', 'Epoche', 'D', 7, 2, 4),
    ('TAG', '24 Stunden', 'D', 1, 3, 3),
    ('INTIME', 'vertraute', 'D', 5, 3, 6),
    ('IDEE', 'Einfall', 'D', 3, 4, 4),
    ('DES', 'Artikel (Genitiv)', 'D', 8, 4, 3),
    ('NUN', 'jetzt', 'D', 5, 5, 3),
    ('WAR', 'existierte', 'D', 1, 6, 3),
    ('EICHE', 'Laubbaum', 'D', 6, 6, 5),
    ('MANCHE', 'einige', 'D', 4, 7, 6),
    ('INSEL', 'Eiland', 'D', 1, 8, 5),
    ('HART', 'fest', 'D', 7, 8, 4),
    ('SIEHT', 'erblickt', 'D', 1, 9, 5),
    ('TODE', 'zu ... betrübt', 'D', 7, 9, 4),
    ('EXTREM', 'äußerst', 'D', 1, 10, 6),
    ('SEE', 'Gewässer', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r119-11x11-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r119-11x11-02', 'Rätsel 119 · 11×11', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '11x11-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('TAT', 'Handlung', 'A', 1, 1, 3),
    ('UPDATE', 'Nachtrag', 'A', 1, 5, 6),
    ('ETAT', 'Budget', 'A', 2, 1, 4),
    ('HAFER', 'Getreide', 'A', 2, 6, 5),
    ('ARG', 'schlimm', 'A', 3, 1, 3),
    ('DORFES', 'Mitte des ...', 'A', 3, 5, 6),
    ('MIT', 'samt', 'A', 4, 1, 3),
    ('DUOS', 'Paare', 'A', 5, 4, 4),
    ('EMPOR', 'hinauf', 'A', 6, 1, 5),
    ('ESEL', 'Grautier', 'A', 6, 7, 4),
    ('AMNESTIE', 'Straferlass', 'A', 7, 3, 8),
    ('TOT', 'leblos', 'A', 8, 1, 3),
    ('ELSASS', 'Region in Frankreich', 'A', 8, 5, 6),
    ('OMEN', 'Vorzeichen', 'A', 9, 1, 4),
    ('BEUTE', 'Raubgut', 'A', 9, 6, 5),
    ('RAR', 'selten', 'A', 10, 1, 3),
    ('GELBER', 'der ... Fluss', 'A', 10, 5, 6),
    ('TEAM', 'Mannschaft', 'D', 1, 1, 4),
    ('TOR', 'Treffer', 'D', 8, 1, 3),
    ('ATRIUM', 'Innenhof', 'D', 1, 2, 6),
    ('OMA', 'Großmutter', 'D', 8, 2, 3),
    ('TAGT', 'berät', 'D', 1, 3, 4),
    ('PATER', 'Mönch', 'D', 6, 3, 5),
    ('DOM', 'Kathedrale', 'D', 5, 4, 3),
    ('URNE', 'Aschengefäß', 'D', 5, 5, 4),
    ('PHOTO', 'Bild', 'D', 1, 6, 5),
    ('ELBE', 'Strom durch Dresden', 'D', 7, 6, 4),
    ('DAR', 'stellt ... (zeigt)', 'D', 1, 7, 3),
    ('SESSEL', 'Polstersitz', 'D', 5, 7, 6),
    ('AFFE', 'Primat', 'D', 1, 8, 4),
    ('STAUB', 'Schmutz', 'D', 6, 8, 5),
    ('TEE', 'Heißgetränk', 'D', 1, 9, 3),
    ('LEISTE', 'Latte', 'D', 5, 9, 6),
    ('ERST', 'zunächst', 'D', 1, 10, 4),
    ('LESER', 'Publikum', 'D', 6, 10, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r120-11x11-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r120-11x11-03', 'Rätsel 120 · 11×11', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '11x11-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ZEUG', 'Kram', 'A', 1, 1, 4),
    ('WIRT', 'Gastgeber', 'A', 1, 7, 4),
    ('IHN', 'Akkusativ von er', 'A', 2, 1, 3),
    ('CHEMIE', 'Stofflehre', 'A', 2, 5, 6),
    ('REIZ', 'Charme', 'A', 3, 1, 4),
    ('ARMEE', 'Heer', 'A', 3, 6, 5),
    ('WERKES', 'Autor des ...', 'A', 4, 4, 6),
    ('ABSATZ', 'Verkauf', 'A', 5, 1, 6),
    ('REH', 'Waldtier', 'A', 5, 8, 3),
    ('AERA', 'Epoche', 'A', 6, 2, 4),
    ('SEI', 'existiere', 'A', 7, 1, 3),
    ('GAU', 'Landstrich', 'A', 7, 5, 3),
    ('HUT', 'Kopfbedeckung', 'A', 8, 1, 3),
    ('ERFAND', 'ersann', 'A', 8, 5, 6),
    ('OMEN', 'Vorzeichen', 'A', 9, 1, 4),
    ('GERNE', 'mit Freude', 'A', 9, 6, 5),
    ('WEN', 'Fragewort (Akk.)', 'A', 10, 1, 3),
    ('ENGES', 'schmales', 'A', 10, 6, 5),
    ('ZIRKA', 'etwa', 'D', 1, 1, 5),
    ('SHOW', 'Vorstellung', 'D', 7, 1, 4),
    ('EHE', 'Bund fürs Leben', 'D', 1, 2, 3),
    ('BAEUME', 'Gehölze', 'D', 5, 2, 6),
    ('UNI', 'Hochschule', 'D', 1, 3, 3),
    ('SEITEN', 'Flanken', 'D', 5, 3, 6),
    ('ZWAR', 'freilich', 'D', 3, 4, 4),
    ('ETAGE', 'Stockwerk', 'D', 4, 5, 5),
    ('HARZ', 'Baumsaft', 'D', 2, 6, 4),
    ('ARGE', 'schlimme', 'D', 7, 6, 4),
    ('WERK', 'Fabrik', 'D', 1, 7, 4),
    ('RUFEN', 'schreien', 'D', 6, 7, 5),
    ('IMMER', 'stets', 'D', 1, 8, 5),
    ('ARG', 'schlimm', 'D', 8, 8, 3),
    ('RIESE', 'Hüne', 'D', 1, 9, 5),
    ('INNE', '... halten', 'D', 7, 9, 4),
    ('TEE', 'Heißgetränk', 'D', 1, 10, 3),
    ('DES', 'Artikel (Genitiv)', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r121-12x12-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r121-12x12-01', 'Rätsel 121 · 12×12', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '12x12-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('SAH', 'erblickte', 'A', 1, 1, 3),
    ('ADEL', 'Aristokratie', 'A', 1, 8, 4),
    ('TRAUMA', 'Schock', 'A', 2, 1, 6),
    ('TABU', 'verboten', 'A', 2, 8, 4),
    ('AMT', 'Behörde', 'A', 3, 1, 3),
    ('LEEREN', 'hohlen', 'A', 3, 6, 6),
    ('TIMING', 'Zeitplanung', 'A', 4, 6, 6),
    ('REGIMES', 'Sturz des ...', 'A', 5, 1, 7),
    ('HERUM', 'umher', 'A', 6, 2, 5),
    ('HEFTE', 'Broschüren', 'A', 7, 1, 5),
    ('TREND', 'Tendenz', 'A', 7, 7, 5),
    ('OEL', 'Schmierstoff', 'A', 8, 3, 3),
    ('REINE', 'pure', 'A', 8, 7, 5),
    ('UHR', 'Zeitmesser', 'A', 9, 1, 3),
    ('LEUGNEN', 'bestreiten', 'A', 9, 5, 7),
    ('CAMP', 'Lager', 'A', 10, 1, 4),
    ('CHOERE', 'Kantoreien', 'A', 10, 6, 6),
    ('HIT', 'Schlager', 'A', 11, 1, 3),
    ('KENNEN', 'wissen', 'A', 11, 6, 6),
    ('STARR', 'steif', 'D', 1, 1, 5),
    ('HAUCH', 'Atem', 'D', 7, 1, 5),
    ('ARM', 'Gliedmaße', 'D', 1, 2, 3),
    ('EHE', 'Bund fürs Leben', 'D', 5, 2, 3),
    ('HAI', 'Raubfisch', 'D', 9, 2, 3),
    ('HAT', 'besitzt', 'D', 1, 3, 3),
    ('GEFORMT', 'gestaltet', 'D', 5, 3, 7),
    ('WIRTE', 'Gastgeber', 'D', 4, 4, 5),
    ('MUELL', 'Abfall', 'D', 5, 5, 5),
    ('KALTEM', 'frostigem', 'D', 1, 6, 6),
    ('ECK', 'Winkel', 'D', 9, 6, 3),
    ('EIS', 'Gefrorenes', 'D', 3, 7, 3),
    ('TRUHE', 'Kiste', 'D', 7, 7, 5),
    ('ATEM', 'Luft', 'D', 1, 8, 4),
    ('OREGON', 'Staat um Portland', 'D', 6, 8, 6),
    ('DARIN', 'innen', 'D', 1, 9, 5),
    ('EINEN', 'unbest. Art. (Akk.)', 'D', 7, 9, 5),
    ('EBEN', 'flach', 'D', 1, 10, 4),
    ('INNERE', 'interne', 'D', 6, 10, 6),
    ('LUNGE', 'Atmungsorgan', 'D', 1, 11, 5),
    ('DENEN', 'Relativ (Dat. Pl.)', 'D', 7, 11, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r122-12x12-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r122-12x12-02', 'Rätsel 122 · 12×12', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '12x12-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ERST', 'zunächst', 'A', 1, 1, 4),
    ('UTAH', 'Mormonenstaat', 'A', 1, 8, 4),
    ('VITA', 'Lebenslauf', 'A', 2, 1, 4),
    ('ONLINE', 'im Netz', 'A', 2, 6, 6),
    ('ETAGEN', 'Stockwerke', 'A', 3, 1, 6),
    ('MEHR', 'zusätzlich', 'A', 3, 8, 4),
    ('NUR', 'lediglich', 'A', 4, 1, 3),
    ('RAR', 'selten', 'A', 4, 9, 3),
    ('TAKT', 'Rhythmus', 'A', 5, 1, 4),
    ('TAGEN', 'in wenigen ...', 'A', 5, 6, 5),
    ('LEUTE', 'Personen', 'A', 6, 2, 5),
    ('ENDE', 'Schluss', 'A', 6, 8, 4),
    ('RENNEN', 'Wettlauf', 'A', 7, 1, 6),
    ('EID', 'Schwur', 'A', 8, 7, 3),
    ('LEID', 'Kummer', 'A', 9, 1, 4),
    ('NOTE', 'Zensur', 'A', 9, 8, 4),
    ('LINIEN', 'Striche', 'A', 10, 1, 6),
    ('GRAT', 'Kamm', 'A', 10, 8, 4),
    ('ESSE', 'speise', 'A', 11, 1, 4),
    ('DIENTE', 'nützte', 'A', 11, 6, 6),
    ('EVENT', 'Ereignis', 'D', 1, 1, 5),
    ('ROLLE', 'Walze', 'D', 7, 1, 5),
    ('RITUALE', 'Zeremonien', 'D', 1, 2, 7),
    ('EIS', 'Gefrorenes', 'D', 9, 2, 3),
    ('STARKEN', 'kräftigen', 'D', 1, 3, 7),
    ('INS', 'in das', 'D', 9, 3, 3),
    ('TAG', '24 Stunden', 'D', 1, 4, 3),
    ('TUN', 'machen', 'D', 5, 4, 3),
    ('DIE', 'Artikel (weibl.)', 'D', 9, 4, 3),
    ('TEE', 'Heißgetränk', 'D', 6, 5, 3),
    ('MONATEN', 'vor zwei ...', 'D', 1, 6, 7),
    ('UND', 'sowie', 'D', 9, 6, 3),
    ('ULM', 'Münsterstadt', 'D', 1, 8, 3),
    ('GERINGE', 'kleine', 'D', 5, 8, 7),
    ('TIEREN', 'Kreaturen', 'D', 1, 9, 6),
    ('DORN', 'Stachel', 'D', 8, 9, 4),
    ('ANHAND', 'mithilfe', 'D', 1, 10, 6),
    ('TAT', 'Handlung', 'D', 9, 10, 3),
    ('HERR', 'Gebieter', 'D', 1, 11, 4),
    ('ENDETE', 'hörte auf', 'D', 6, 11, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r123-12x12-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r123-12x12-03', 'Rätsel 123 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ELITE', 'Auslese', 'A', 1, 1, 5),
    ('HUNDE', 'Vierbeiner', 'A', 1, 7, 5),
    ('TORONTO', 'Stadt in Kanada', 'A', 2, 1, 7),
    ('AUF', 'offen', 'A', 2, 9, 3),
    ('WEINT', 'heult', 'A', 3, 1, 5),
    ('HOF', 'Gehöft', 'A', 3, 9, 3),
    ('ASS', 'speiste', 'A', 4, 1, 3),
    ('EHER', 'lieber', 'A', 4, 5, 4),
    ('NUN', 'jetzt', 'A', 5, 5, 3),
    ('LOK', 'Zugmaschine', 'A', 5, 9, 3),
    ('SEIN', 'existieren', 'A', 6, 1, 4),
    ('NORMEN', 'Standards', 'A', 7, 5, 6),
    ('TOD', 'Ableben', 'A', 8, 1, 3),
    ('EROSION', 'Abtragung', 'A', 8, 5, 7),
    ('ASIEN', 'Erdteil', 'A', 9, 1, 5),
    ('HOLTE', 'besorgte', 'A', 9, 7, 5),
    ('KLEINER', 'winziger', 'A', 10, 1, 7),
    ('TAT', 'Handlung', 'A', 10, 9, 3),
    ('TONNE', 'Fass', 'A', 11, 1, 5),
    ('HERZ', 'Pumpe', 'A', 11, 8, 4),
    ('ETWA', 'ungefähr', 'D', 1, 1, 4),
    ('TAKT', 'Rhythmus', 'D', 8, 1, 4),
    ('LOESTE', 'klärte', 'D', 1, 2, 6),
    ('OSLO', 'norw. Hauptstadt', 'D', 8, 2, 4),
    ('IRIS', 'Schwertlilie', 'D', 1, 3, 4),
    ('INDIEN', 'Subkontinent', 'D', 6, 3, 6),
    ('TON', 'Klang', 'D', 1, 4, 3),
    ('EIN', 'unbest. Artikel', 'D', 9, 4, 3),
    ('ENTEN', 'Wasservögel', 'D', 1, 5, 5),
    ('NENNE', 'bezeichne', 'D', 7, 5, 5),
    ('HUMOR', 'Witz', 'D', 4, 6, 5),
    ('HOHEN', 'großen', 'D', 1, 7, 5),
    ('ROHR', 'Leitung', 'D', 7, 7, 4),
    ('UMSO', 'desto', 'D', 6, 8, 4),
    ('NAH', 'dicht', 'D', 1, 9, 3),
    ('EILTE', 'hastete', 'D', 7, 9, 5),
    ('DUO', 'Paar', 'D', 1, 10, 3),
    ('NOTAR', 'Jurist', 'D', 7, 10, 5),
    ('EFFEKT', 'Wirkung', 'D', 1, 11, 6),
    ('NETZ', 'Geflecht', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r124-12x12-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r124-12x12-04', 'Rätsel 124 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('PROMILLE', 'Tausendstel', 'A', 1, 1, 8),
    ('REBEN', 'Weinstöcke', 'A', 2, 1, 5),
    ('OMA', 'Großmutter', 'A', 2, 7, 3),
    ('AGENT', 'Spion', 'A', 3, 1, 5),
    ('KAESE', 'Milchprodukt', 'A', 3, 7, 5),
    ('GINGE', 'liefe', 'A', 4, 1, 5),
    ('IRIS', 'Schwertlilie', 'A', 4, 8, 4),
    ('ERFOLGES', 'Geheimnis des ...', 'A', 5, 4, 8),
    ('EHE', 'Bund fürs Leben', 'A', 6, 9, 3),
    ('HUT', 'Kopfbedeckung', 'A', 7, 2, 3),
    ('FAIRE', 'gerechte', 'A', 7, 6, 5),
    ('GASE', 'Dämpfe', 'A', 8, 1, 4),
    ('ALS', 'da, während', 'A', 8, 6, 3),
    ('RASEND', 'wütend', 'A', 9, 1, 6),
    ('LAND', 'Staat', 'A', 9, 8, 4),
    ('ART', 'Sorte', 'A', 10, 1, 3),
    ('ARIE', 'Sologesang', 'A', 10, 8, 4),
    ('SEES', 'Ufer des ...', 'A', 11, 1, 4),
    ('NUMMER', 'Zahl', 'A', 11, 6, 6),
    ('PRAG', 'Moldau-Stadt', 'D', 1, 1, 4),
    ('GRAS', 'Rasen', 'D', 8, 1, 4),
    ('REGIE', 'Spielleitung', 'D', 1, 2, 5),
    ('HAARE', 'Mähne', 'D', 7, 2, 5),
    ('OBEN', 'in der Höhe', 'D', 1, 3, 4),
    ('WUSSTE', 'kannte', 'D', 6, 3, 6),
    ('MENGE', 'Masse', 'D', 1, 4, 5),
    ('TEE', 'Heißgetränk', 'D', 7, 4, 3),
    ('INTERN', 'innen', 'D', 1, 5, 6),
    ('FADEN', 'Garn', 'D', 7, 6, 5),
    ('LOK', 'Zugmaschine', 'D', 1, 7, 3),
    ('OVAL', 'eiförmig', 'D', 5, 7, 4),
    ('EMAIL', 'elektr. Post', 'D', 1, 8, 5),
    ('ISLAM', 'Weltreligion', 'D', 7, 8, 5),
    ('AERGER', 'Verdruss', 'D', 2, 9, 6),
    ('ARM', 'Gliedmaße', 'D', 9, 9, 3),
    ('SIEHE', 'vgl.', 'D', 3, 10, 5),
    ('NIE', 'nimmer', 'D', 9, 10, 3),
    ('PAESSE', 'Übergänge', 'D', 1, 11, 6),
    ('ODER', 'bzw.', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r125-13x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r125-13x13-01', 'Rätsel 125 · 13×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '13x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('HEU', 'Trockengras', 'A', 1, 1, 3),
    ('NAH', 'dicht', 'A', 1, 5, 3),
    ('NUSS', 'Kern', 'A', 1, 9, 4),
    ('OHNE', 'abzüglich', 'A', 2, 1, 4),
    ('REGER', 'lebhafter', 'A', 2, 6, 5),
    ('BRINGEN', 'liefern', 'A', 3, 1, 7),
    ('UTAH', 'Mormonenstaat', 'A', 3, 9, 4),
    ('GANGE', 'im ... sein', 'A', 4, 4, 5),
    ('NIE', 'nimmer', 'A', 5, 1, 3),
    ('BASILIKA', 'Kirche', 'A', 5, 5, 8),
    ('ACHTE', 'nach der siebten', 'A', 6, 1, 5),
    ('TEIL', 'Stück', 'A', 6, 7, 4),
    ('EHE', 'Bund fürs Leben', 'A', 7, 1, 3),
    ('RESTE', 'Überbleibsel', 'A', 7, 8, 5),
    ('HERD', 'Kochstelle', 'A', 8, 1, 4),
    ('GANS', 'Federvieh', 'A', 8, 6, 4),
    ('TIEF', 'abgründig', 'A', 9, 9, 4),
    ('BILDETE', 'formte', 'A', 10, 2, 7),
    ('RIO', 'Stadt in Brasilien', 'A', 10, 10, 3),
    ('MUSTER', 'Vorlage', 'A', 11, 1, 6),
    ('ABT', 'Klosterchef', 'A', 11, 10, 3),
    ('START', 'Beginn', 'A', 12, 2, 5),
    ('KONTO', 'Guthaben', 'A', 12, 8, 5),
    ('HOB', 'stemmte', 'D', 1, 1, 3),
    ('NAEHE', 'Umgebung', 'D', 5, 1, 5),
    ('EHRLICHE', 'aufrichtige', 'D', 1, 2, 8),
    ('BUS', 'Car (schweiz.)', 'D', 10, 2, 3),
    ('UNI', 'Hochschule', 'D', 1, 3, 3),
    ('EHER', 'lieber', 'D', 5, 3, 4),
    ('IST', 'befindet sich', 'D', 10, 3, 3),
    ('ENG', 'schmal', 'D', 2, 4, 3),
    ('DELTA', 'Mündung', 'D', 8, 4, 5),
    ('GABE', 'Geschenk', 'D', 3, 5, 4),
    ('DER', 'Artikel (männl.)', 'D', 10, 5, 3),
    ('ARENA', 'Stadion', 'D', 1, 6, 5),
    ('AGIERT', 'handelt', 'D', 7, 6, 6),
    ('HENGST', 'männl. Pferd', 'D', 1, 7, 6),
    ('EIERN', 'auf ... gehen', 'D', 4, 8, 5),
    ('ECK', 'Winkel', 'D', 10, 8, 3),
    ('NEU', 'frisch', 'D', 1, 9, 3),
    ('LIEST', 'schmökert', 'D', 5, 9, 5),
    ('URTEILS', 'Verkündung des ...', 'D', 1, 10, 7),
    ('IRAN', 'Persien', 'D', 9, 10, 4),
    ('TREIBT', 'schwimmt', 'D', 7, 11, 6),
    ('SAH', 'erblickte', 'D', 1, 12, 3),
    ('AUE', 'Talwiese', 'D', 5, 12, 3),
    ('FOTO', 'Aufnahme', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r126-13x13-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r126-13x13-02', 'Rätsel 126 · 13×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '13x13-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('TIERWELT', 'Fauna', 'A', 1, 1, 8),
    ('ENG', 'schmal', 'A', 1, 10, 3),
    ('RAETE', 'Gremien', 'A', 2, 3, 5),
    ('QUER', 'diagonal', 'A', 2, 9, 4),
    ('GEHABT', 'besessen', 'A', 3, 3, 6),
    ('RIO', 'Stadt in Brasilien', 'A', 3, 10, 3),
    ('FEIN', 'zart', 'A', 4, 1, 4),
    ('PERIODE', 'Zeitraum', 'A', 4, 6, 7),
    ('FING', 'erwischte', 'A', 5, 1, 4),
    ('PRAG', 'Moldau-Stadt', 'A', 5, 6, 4),
    ('ENGERE', 'schmalere', 'A', 6, 1, 6),
    ('FEE', 'Zauberin', 'A', 6, 8, 3),
    ('WELCHE', 'Fragewort (Auswahl)', 'A', 7, 7, 6),
    ('REIF', 'erntefertig', 'A', 8, 3, 4),
    ('VIERTEN', 'am ... Mai', 'A', 9, 1, 7),
    ('LAGE', 'Position', 'A', 9, 9, 4),
    ('IRAKER', 'Mann aus Bagdad', 'A', 10, 1, 6),
    ('LEDER', 'Tierhaut', 'A', 10, 8, 5),
    ('ERLERNT', 'studiert', 'A', 11, 1, 7),
    ('GOLD', 'Edelmetall', 'A', 11, 9, 4),
    ('HEER', 'Armee', 'A', 12, 1, 4),
    ('HERBE', 'bittere', 'A', 12, 8, 5),
    ('TREFFER', 'Tor', 'D', 1, 1, 7),
    ('VIEH', 'Nutztiere', 'D', 9, 1, 4),
    ('EIN', 'unbest. Artikel', 'D', 4, 2, 3),
    ('IRRE', 'Verrückte', 'D', 9, 2, 4),
    ('ERGING', 'widerfuhr', 'D', 1, 3, 6),
    ('REALE', 'wirkliche', 'D', 8, 3, 5),
    ('RAENGE', 'Tribünen', 'D', 1, 4, 6),
    ('ERKER', 'Vorbau', 'D', 8, 4, 5),
    ('WEH', 'schmerzhaft', 'D', 1, 5, 3),
    ('REITER', 'Jockey', 'D', 6, 5, 6),
    ('ETAPPE', 'Abschnitt', 'D', 1, 6, 6),
    ('FERNE', 'Weite', 'D', 8, 6, 5),
    ('LEBER', 'große Drüse', 'D', 1, 7, 5),
    ('TRAFEN', 'begegneten', 'D', 3, 8, 6),
    ('IGEL', 'Stacheltier', 'D', 4, 9, 4),
    ('LEGE', 'platziere', 'D', 9, 9, 4),
    ('EURO', 'Währung', 'D', 1, 10, 4),
    ('ECUADOR', 'Andenstaat', 'D', 6, 10, 7),
    ('NEID', 'Missgunst', 'D', 1, 11, 4),
    ('GELB', 'sonnenfarben', 'D', 9, 11, 4),
    ('GROESSE', 'Format', 'D', 1, 12, 7),
    ('ERDE', 'Welt', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r127-13x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r127-13x13-03', 'Rätsel 127 · 13×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '13x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('OBST', 'Früchte', 'A', 1, 1, 4),
    ('GEN', 'nach', 'A', 1, 6, 3),
    ('SAH', 'erblickte', 'A', 1, 10, 3),
    ('RAT', 'Tipp', 'A', 2, 1, 3),
    ('DEBUET', 'Erstauftritt', 'A', 2, 5, 6),
    ('TURBINEN', 'Triebwerke', 'A', 3, 1, 8),
    ('ABT', 'Klosterchef', 'A', 3, 10, 3),
    ('MAUERN', 'Wände', 'A', 4, 2, 6),
    ('BEAT', 'Rhythmus', 'A', 4, 9, 4),
    ('EBBE', 'Gegenteil der Flut', 'A', 5, 3, 4),
    ('TUE', 'mache', 'A', 5, 10, 3),
    ('RAN', 'heran', 'A', 6, 1, 3),
    ('SANFTEN', 'milden', 'A', 6, 6, 7),
    ('INDER', 'Asiate', 'A', 7, 1, 5),
    ('LAIEN', 'Amateure', 'A', 7, 7, 5),
    ('ESEL', 'Grautier', 'A', 8, 1, 4),
    ('WALL', 'Damm', 'A', 8, 6, 4),
    ('BOMBER', 'Kampfflieger', 'A', 9, 7, 6),
    ('ETAT', 'Budget', 'A', 10, 1, 4),
    ('MAG', 'liebt', 'A', 10, 6, 3),
    ('UNI', 'Hochschule', 'A', 10, 10, 3),
    ('NEUEM', 'frischem', 'A', 11, 1, 5),
    ('MEINTE', 'glaubte', 'A', 11, 7, 6),
    ('SEEN', 'Gewässer', 'A', 12, 1, 4),
    ('MAN', 'jemand', 'A', 12, 6, 3),
    ('DES', 'Artikel (Genitiv)', 'A', 12, 10, 3),
    ('ORT', 'Stelle', 'D', 1, 1, 3),
    ('FRIEDENS', 'Taube des ...', 'D', 5, 1, 8),
    ('BAUM', 'Gehölz', 'D', 1, 2, 4),
    ('ANS', 'an das', 'D', 6, 2, 3),
    ('TEE', 'Heißgetränk', 'D', 10, 2, 3),
    ('STRAENDE', 'Küsten', 'D', 1, 3, 8),
    ('AUE', 'Talwiese', 'D', 10, 3, 3),
    ('BUB', 'Knabe', 'D', 3, 4, 3),
    ('ELITEN', 'Oberschichten', 'D', 7, 4, 6),
    ('DIEB', 'Langfinger', 'D', 2, 5, 4),
    ('GENRES', 'Gattungen', 'D', 1, 6, 6),
    ('EBEN', 'flach', 'D', 1, 7, 4),
    ('ALABAMA', 'Südstaat', 'D', 6, 7, 7),
    ('NUN', 'jetzt', 'D', 1, 8, 3),
    ('ANALOGEN', 'ähnlichen', 'D', 5, 8, 8),
    ('FILM', 'Kinostreifen', 'D', 6, 9, 4),
    ('STAETTE', 'Ort', 'D', 1, 10, 7),
    ('BUND', 'Bündnis', 'D', 9, 10, 4),
    ('BAUEN', 'errichten', 'D', 3, 11, 5),
    ('ENTE', 'Wasservogel', 'D', 9, 11, 4),
    ('HATTEN', 'besaßen', 'D', 1, 12, 6),
    ('FRIES', 'Zierstreifen', 'D', 8, 12, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r128-15x15-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r128-15x15-01', 'Rätsel 128 · 15×15', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '15x15-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AFFE', 'Primat', 'A', 1, 1, 4),
    ('GAB', 'schenkte', 'A', 1, 6, 3),
    ('JENER', 'selbiger', 'A', 1, 10, 5),
    ('BAUHERR', 'Auftraggeber', 'A', 2, 1, 7),
    ('HOHE', 'große', 'A', 2, 9, 4),
    ('FUER', 'zugunsten', 'A', 3, 1, 4),
    ('AMT', 'Behörde', 'A', 3, 6, 3),
    ('BRUCH', 'Riss', 'A', 3, 10, 5),
    ('UNTERM', 'unter dem', 'A', 4, 1, 6),
    ('SEELE', 'Psyche', 'A', 4, 10, 5),
    ('HAT', 'besitzt', 'A', 5, 1, 3),
    ('IMMER', 'stets', 'A', 5, 5, 5),
    ('INS', 'in das', 'A', 6, 12, 3),
    ('ERLOES', 'Ertrag', 'A', 7, 2, 6),
    ('BLOSSE', 'reine', 'A', 7, 9, 6),
    ('BIN', 'existiere', 'A', 8, 1, 3),
    ('RISKIERT', 'wagt', 'A', 8, 5, 8),
    ('LOS', 'frei', 'A', 9, 4, 3),
    ('BIT', 'Binärziffer', 'A', 9, 9, 3),
    ('ABTES', 'Kloster des ...', 'A', 10, 1, 5),
    ('DIES', 'das hier', 'A', 10, 7, 4),
    ('BAER', 'Petz', 'A', 11, 1, 4),
    ('MEHR', 'zusätzlich', 'A', 11, 6, 4),
    ('SAFT', 'Most', 'A', 11, 11, 4),
    ('BUENDELN', 'vereinen', 'A', 12, 1, 8),
    ('WAERE', 'sei', 'A', 12, 10, 5),
    ('TUETE', 'Beutel', 'A', 13, 4, 5),
    ('IHRES', 'seines', 'A', 13, 10, 5),
    ('UND', 'sowie', 'A', 14, 1, 3),
    ('ORANGE', 'Apfelsine', 'A', 14, 5, 6),
    ('MIT', 'samt', 'A', 14, 12, 3),
    ('ABFUHR', 'Absage', 'D', 1, 1, 6),
    ('ABBAU', 'Förderung', 'D', 10, 1, 5),
    ('FAUNA', 'Tierwelt', 'D', 1, 2, 5),
    ('EINBAU', 'Montage', 'D', 7, 2, 6),
    ('FUETTERN', 'ernähren', 'D', 1, 3, 8),
    ('TEE', 'Heißgetränk', 'D', 10, 3, 3),
    ('EHRE', 'Würde', 'D', 1, 4, 4),
    ('LERNT', 'paukt', 'D', 9, 4, 5),
    ('RIGOROS', 'streng', 'D', 4, 5, 7),
    ('DUO', 'Paar', 'D', 12, 5, 3),
    ('GRAMM', 'Tausendstel Kilo', 'D', 1, 6, 5),
    ('EIS', 'Gefrorenes', 'D', 7, 6, 3),
    ('MEER', 'See', 'D', 11, 6, 4),
    ('ARM', 'Gliedmaße', 'D', 1, 7, 3),
    ('MUSS', 'soll', 'D', 5, 7, 4),
    ('DELTA', 'Mündung', 'D', 10, 7, 5),
    ('TUE', 'mache', 'D', 3, 8, 3),
    ('IHNEN', 'Anrede', 'D', 10, 8, 5),
    ('BIBER', 'Nager', 'D', 7, 9, 5),
    ('JOBS', 'Stellen', 'D', 1, 10, 4),
    ('GLEIS', 'Schiene', 'D', 6, 10, 5),
    ('WIE', 'gleich', 'D', 12, 10, 3),
    ('EHREN', 'zu ... von', 'D', 1, 11, 5),
    ('ORT', 'Stelle', 'D', 7, 11, 3),
    ('SAH', 'erblickte', 'D', 11, 11, 3),
    ('NEUE', 'frische', 'D', 1, 12, 4),
    ('IST', 'befindet sich', 'D', 6, 12, 3),
    ('LAERM', 'Krach', 'D', 10, 12, 5),
    ('CLANS', 'Sippen', 'D', 3, 13, 5),
    ('FREI', 'ungebunden', 'D', 11, 13, 4),
    ('RUHE', 'Stille', 'D', 1, 14, 4),
    ('SEHR', 'äußerst', 'D', 6, 14, 4),
    ('TEST', 'Prüfung', 'D', 11, 14, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r129-15x15-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r129-15x15-02', 'Rätsel 129 · 15×15', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '15x15-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('MANGA', 'jap. Comic', 'A', 1, 1, 5),
    ('AKTIV', 'tätig', 'A', 1, 10, 5),
    ('OMA', 'Großmutter', 'A', 2, 1, 3),
    ('DAZU', 'hierzu', 'A', 2, 5, 4),
    ('BUERO', 'Kanzlei', 'A', 2, 10, 5),
    ('STILL', 'ruhig', 'A', 3, 1, 5),
    ('UEBEREIN', '... stimmen', 'A', 3, 7, 8),
    ('VIELER', 'zahlreicher', 'A', 4, 3, 6),
    ('TRUG', 'schleppte', 'A', 5, 4, 4),
    ('ODER', 'bzw.', 'A', 5, 9, 4),
    ('LUST', 'Verlangen', 'A', 6, 1, 4),
    ('NEU', 'frisch', 'A', 6, 6, 3),
    ('RAUE', 'grobe', 'A', 6, 11, 4),
    ('OPA', 'Großvater', 'A', 7, 1, 3),
    ('BLUME', 'Pflanze', 'A', 7, 10, 5),
    ('GEN', 'nach', 'A', 8, 1, 3),
    ('PEGEL', 'Wasserstand', 'A', 8, 5, 5),
    ('ASS', 'speiste', 'A', 8, 11, 3),
    ('ORGEL', 'Instrument', 'A', 9, 1, 5),
    ('RANG', 'Stellung', 'A', 9, 8, 4),
    ('HAUS', 'Gebäude', 'A', 10, 4, 4),
    ('VOR', 'ehe', 'A', 10, 12, 3),
    ('KLETTERT', 'kraxelt', 'A', 11, 2, 8),
    ('WIRD', 'entsteht', 'A', 11, 11, 4),
    ('WIE', 'gleich', 'A', 12, 1, 3),
    ('TAG', '24 Stunden', 'A', 12, 5, 3),
    ('ALTE', 'betagte', 'A', 12, 11, 4),
    ('ANHOEHE', 'Hügel', 'A', 13, 1, 7),
    ('PILLEN', 'Tabletten', 'A', 13, 9, 6),
    ('ROM', 'Ewige Stadt', 'A', 14, 1, 3),
    ('LOS', 'frei', 'A', 14, 7, 3),
    ('DASS', 'Konjunktion', 'A', 14, 11, 4),
    ('MOST', 'Obstsaft', 'D', 1, 1, 4),
    ('LOGOS', 'Embleme', 'D', 6, 1, 5),
    ('WAR', 'existierte', 'D', 12, 1, 3),
    ('AMT', 'Behörde', 'D', 1, 2, 3),
    ('SUPER', 'toll', 'D', 5, 2, 5),
    ('KINO', 'Filmtheater', 'D', 11, 2, 4),
    ('NAIV', 'arglos', 'D', 1, 3, 4),
    ('SANG', 'trällerte', 'D', 6, 3, 4),
    ('LEHM', 'Ton', 'D', 11, 3, 4),
    ('LITT', 'duldete', 'D', 3, 4, 4),
    ('EHE', 'Bund fürs Leben', 'D', 9, 4, 3),
    ('ADLER', 'Greifvogel', 'D', 1, 5, 5),
    ('PLATTEN', 'Scheiben', 'D', 8, 5, 7),
    ('LUNGE', 'Atmungsorgan', 'D', 4, 6, 5),
    ('UTAH', 'Mormonenstaat', 'D', 10, 6, 4),
    ('ZUEGE', 'Bahnen', 'D', 2, 7, 5),
    ('SEGEL', 'Tuch am Mast', 'D', 10, 7, 5),
    ('FUER', 'zugunsten', 'D', 1, 8, 4),
    ('UFER', 'Gestade', 'D', 6, 8, 4),
    ('LAPTOPS', 'Notebooks', 'D', 8, 9, 7),
    ('ABEND', 'Tagesende', 'D', 1, 10, 5),
    ('KUR', 'Erholung', 'D', 1, 11, 3),
    ('ERLAG', 'starb an', 'D', 5, 11, 5),
    ('WALD', 'Forst', 'D', 11, 11, 4),
    ('TEE', 'Heißgetränk', 'D', 1, 12, 3),
    ('RAUS', 'hinweg', 'D', 5, 12, 4),
    ('VILLA', 'Landhaus', 'D', 10, 12, 5),
    ('IRIS', 'Schwertlilie', 'D', 1, 13, 4),
    ('UMS', 'um das', 'D', 6, 13, 3),
    ('ORTES', 'Name des ...', 'D', 10, 13, 5),
    ('VON', 'ab, aus', 'D', 1, 14, 3),
    ('SEE', 'Gewässer', 'D', 5, 14, 3),
    ('ORDENS', 'Mitglied des ...', 'D', 9, 14, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r130-15x15-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r130-15x15-03', 'Rätsel 130 · 15×15', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '15x15-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('EDLEN', 'vornehmen', 'A', 1, 1, 5),
    ('DIENSTES', 'Ende des ...', 'A', 1, 7, 8),
    ('DRAN', 'an der Reihe', 'A', 2, 1, 4),
    ('MANN', 'Herr', 'A', 2, 6, 4),
    ('LIST', 'Trick', 'A', 3, 1, 4),
    ('ERST', 'zunächst', 'A', 3, 6, 4),
    ('ESSE', 'speise', 'A', 3, 11, 4),
    ('ENTWARF', 'skizzierte', 'A', 4, 1, 7),
    ('TAL', 'Senke', 'A', 4, 12, 3),
    ('FIEL', 'stürzte', 'A', 5, 11, 4),
    ('WEHR', 'Staustufe', 'A', 6, 1, 4),
    ('MAN', 'jemand', 'A', 6, 6, 3),
    ('VIELE', 'zahlreiche', 'A', 6, 10, 5),
    ('EHEFRAU', 'Gattin', 'A', 7, 1, 7),
    ('VOLLE', 'gefüllte', 'A', 7, 9, 5),
    ('NEU', 'frisch', 'A', 8, 1, 3),
    ('ELEMENT', 'Bestandteil', 'A', 8, 5, 7),
    ('ERDE', 'Welt', 'A', 9, 11, 4),
    ('PASSE', 'verzichte', 'A', 10, 1, 5),
    ('ASS', 'speiste', 'A', 10, 7, 3),
    ('REIN', 'sauber', 'A', 10, 11, 4),
    ('HAT', 'besitzt', 'A', 11, 1, 3),
    ('VORTAG', 'gestern', 'A', 11, 5, 6),
    ('DES', 'Artikel (Genitiv)', 'A', 11, 12, 3),
    ('ARENA', 'Stadion', 'A', 12, 1, 5),
    ('TAG', '24 Stunden', 'A', 12, 7, 3),
    ('INNE', '... halten', 'A', 12, 11, 4),
    ('HUNDERT', 'Zahl (10×10)', 'A', 13, 3, 7),
    ('SET', 'Satz', 'A', 13, 11, 3),
    ('EVENT', 'Ereignis', 'A', 14, 1, 5),
    ('EXTREM', 'äußerst', 'A', 14, 9, 6),
    ('EDLE', 'vornehme', 'D', 1, 1, 4),
    ('WEN', 'Fragewort (Akk.)', 'D', 6, 1, 3),
    ('PHASE', 'Abschnitt', 'D', 10, 1, 5),
    ('DRIN', 'innen', 'D', 1, 2, 4),
    ('EHEPAAR', 'Mann und Frau', 'D', 6, 2, 7),
    ('LAST', 'Bürde', 'D', 1, 3, 4),
    ('HEU', 'Trockengras', 'D', 6, 3, 3),
    ('STEHE', 'ich ... auf', 'D', 10, 3, 5),
    ('ENTWURF', 'Skizze', 'D', 1, 4, 7),
    ('NUN', 'jetzt', 'D', 12, 4, 3),
    ('RELEVANT', 'bedeutsam', 'D', 7, 5, 8),
    ('MERKMAL', 'Kennzeichen', 'D', 2, 6, 7),
    ('DARF', 'kann', 'D', 1, 7, 4),
    ('AUE', 'Talwiese', 'D', 6, 7, 3),
    ('ARTEN', 'Sorten', 'D', 10, 7, 5),
    ('INS', 'in das', 'D', 1, 8, 3),
    ('STAR', 'Berühmtheit', 'D', 10, 8, 4),
    ('ENTE', 'Wasservogel', 'D', 1, 9, 4),
    ('VERSAGTE', 'scheiterte', 'D', 7, 9, 8),
    ('VON', 'ab, aus', 'D', 6, 10, 3),
    ('SIE', 'Anrede', 'D', 1, 11, 3),
    ('FILTER', 'Sieb', 'D', 5, 11, 6),
    ('IST', 'befindet sich', 'D', 12, 11, 3),
    ('STIEL', 'Griff', 'D', 3, 12, 5),
    ('REDNER', 'Sprecher', 'D', 9, 12, 6),
    ('SAELE', 'Hallen', 'D', 3, 13, 5),
    ('DIENTE', 'nützte', 'D', 9, 13, 6),
    ('STELLE', 'Posten', 'D', 1, 14, 6),
    ('SENSE', 'Mähwerkzeug', 'D', 8, 14, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

commit;
-- Automatisch erzeugt von tools/generator/generate_raetsel.py – nicht von Hand bearbeiten.
-- Voraussetzung: Migrationen, gitter_vorlagen.sql, woerter_seed.sql, fragen_varianten_seed.sql eingespielt.
-- Idempotent über raetsel.slug. Rätsel mit Prüfhinweisen werden als Entwurf angelegt.

begin;

-- r131-8x8-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r131-8x8-01', 'Rätsel 131 · 8×8', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '8x8-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('PLAN', 'Absicht', 'A', 1, 1, 4),
    ('UEBERS', 'über das', 'A', 2, 1, 6),
    ('BITTET', 'ersucht', 'A', 3, 1, 6),
    ('TIEF', 'abgründig', 'A', 4, 4, 4),
    ('FEE', 'Zauberin', 'A', 5, 1, 3),
    ('NIE', 'nimmer', 'A', 5, 5, 3),
    ('HAELT', 'stoppt', 'A', 6, 3, 5),
    ('TUE', 'mache', 'A', 7, 1, 3),
    ('SET', 'Satz', 'A', 7, 5, 3),
    ('PUB', 'Kneipe', 'D', 1, 1, 3),
    ('FIT', 'gesund', 'D', 5, 1, 3),
    ('LEISE', 'gedämpft', 'D', 1, 2, 5),
    ('ABT', 'Klosterchef', 'D', 1, 3, 3),
    ('EHE', 'Bund fürs Leben', 'D', 5, 3, 3),
    ('NETT', 'freundlich', 'D', 1, 4, 4),
    ('REINES', 'pures', 'D', 2, 5, 6),
    ('STEILE', 'abschüssige', 'D', 2, 6, 6),
    ('FETT', 'Schmalz', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r132-8x8-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r132-8x8-02', 'Rätsel 132 · 8×8', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '8x8-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('FUER', 'zugunsten', 'A', 1, 4, 4),
    ('KABEL', 'Leitung', 'A', 2, 1, 5),
    ('ALARM', 'Warnsignal', 'A', 3, 1, 5),
    ('MANN', 'Herr', 'A', 4, 1, 4),
    ('DEALS', 'Geschäfte', 'A', 5, 3, 5),
    ('ERSTE', 'anfängliche', 'A', 6, 3, 5),
    ('AUS', 'vorbei', 'A', 7, 1, 3),
    ('TEE', 'Heißgetränk', 'A', 7, 5, 3),
    ('KAMERA', 'Fotoapparat', 'D', 2, 1, 6),
    ('GALA', 'Festabend', 'D', 1, 2, 4),
    ('BANDES', 'Titel des ...', 'D', 2, 3, 6),
    ('FERNER', 'außerdem', 'D', 1, 4, 6),
    ('ULM', 'Münsterstadt', 'D', 1, 5, 3),
    ('AST', 'Zweig', 'D', 5, 5, 3),
    ('ALTE', 'betagte', 'D', 4, 6, 4),
    ('ROT', 'purpurn', 'D', 1, 7, 3),
    ('SEE', 'Gewässer', 'D', 5, 7, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r133-8x8-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r133-8x8-03', 'Rätsel 133 · 8×8', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '8x8-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('TRUEGT', 'täuscht', 'A', 1, 1, 6),
    ('ANDERS', 'verschieden', 'A', 2, 2, 6),
    ('ANDERE', 'übrige', 'A', 3, 1, 6),
    ('LESE', 'schmökere', 'A', 4, 4, 4),
    ('BAT', 'ersuchte', 'A', 5, 1, 3),
    ('DEN', 'Artikel (Akkusativ)', 'A', 5, 5, 3),
    ('AUE', 'Talwiese', 'A', 6, 1, 3),
    ('ENG', 'schmal', 'A', 6, 5, 3),
    ('UFER', 'Gestade', 'A', 7, 1, 4),
    ('ANBAU', 'Erweiterung', 'D', 3, 1, 5),
    ('RAN', 'heran', 'D', 1, 2, 3),
    ('AUF', 'offen', 'D', 5, 2, 3),
    ('UND', 'sowie', 'D', 1, 3, 3),
    ('TEE', 'Heißgetränk', 'D', 5, 3, 3),
    ('EDEL', 'vornehm', 'D', 1, 4, 4),
    ('GEREDE', 'Geschwätz', 'D', 1, 5, 6),
    ('TRESEN', 'Theke', 'D', 1, 6, 6),
    ('ENGE', 'schmale', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r134-9x9-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r134-9x9-01', 'Rätsel 134 · 9×9', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x9-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ROSE', 'Blume mit Dornen', 'A', 1, 1, 4),
    ('MAN', 'jemand', 'A', 1, 6, 3),
    ('EBEN', 'flach', 'A', 2, 1, 4),
    ('AUE', 'Talwiese', 'A', 2, 6, 3),
    ('LEID', 'Kummer', 'A', 3, 1, 4),
    ('IST', 'befindet sich', 'A', 3, 6, 3),
    ('ENTE', 'Wasservogel', 'A', 4, 1, 4),
    ('OSLO', 'norw. Hauptstadt', 'A', 5, 5, 4),
    ('SPANDAU', 'Berliner Bezirk', 'A', 6, 1, 7),
    ('ERLIESS', 'verfügte', 'A', 7, 1, 7),
    ('OBERST', 'Dienstgrad', 'A', 8, 2, 6),
    ('RELEASE', 'Erscheinen', 'D', 1, 1, 7),
    ('OBEN', 'in der Höhe', 'D', 1, 2, 4),
    ('PRO', 'je', 'D', 6, 2, 3),
    ('SEIT', 'ab', 'D', 1, 3, 4),
    ('ALB', 'Gebirge', 'D', 6, 3, 3),
    ('ENDE', 'Schluss', 'D', 1, 4, 4),
    ('NIE', 'nimmer', 'D', 6, 4, 3),
    ('ODER', 'bzw.', 'D', 5, 5, 4),
    ('MAI', '5. Monat', 'D', 1, 6, 3),
    ('SASS', 'hockte', 'D', 5, 6, 4),
    ('AUS', 'vorbei', 'D', 1, 7, 3),
    ('LUST', 'Verlangen', 'D', 5, 7, 4),
    ('NETTO', 'ohne Steuern', 'D', 1, 8, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r135-9x9-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r135-9x9-02', 'Rätsel 135 · 9×9', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x9-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('DASS', 'Konjunktion', 'A', 1, 1, 4),
    ('ZOO', 'Tierpark', 'A', 1, 6, 3),
    ('AREAL', 'Gelände', 'A', 2, 1, 5),
    ('STEHEND', 'aufrecht', 'A', 3, 1, 7),
    ('HEER', 'Armee', 'A', 4, 5, 4),
    ('STIMMT', 'trifft zu', 'A', 5, 1, 6),
    ('AURA', 'Ausstrahlung', 'A', 6, 1, 4),
    ('TUN', 'machen', 'A', 6, 6, 3),
    ('GEIL', 'toll (ugs.)', 'A', 7, 1, 4),
    ('ENG', 'schmal', 'A', 7, 6, 3),
    ('ERST', 'zunächst', 'A', 8, 1, 4),
    ('NIE', 'nimmer', 'A', 8, 6, 3),
    ('DAS', 'Artikel (sächl.)', 'D', 1, 1, 3),
    ('SAGE', 'Legende', 'D', 5, 1, 4),
    ('ART', 'Sorte', 'D', 1, 2, 3),
    ('TUER', 'Pforte', 'D', 5, 2, 4),
    ('SEE', 'Gewässer', 'D', 1, 3, 3),
    ('IRIS', 'Schwertlilie', 'D', 5, 3, 4),
    ('SAH', 'erblickte', 'D', 1, 4, 3),
    ('MALT', 'pinselt', 'D', 5, 4, 4),
    ('LEHM', 'Ton', 'D', 2, 5, 4),
    ('NETTEN', 'freundlichen', 'D', 3, 6, 6),
    ('OEDE', 'langweilig', 'D', 1, 7, 4),
    ('UNI', 'Hochschule', 'D', 6, 7, 3),
    ('RINGE', 'Reifen', 'D', 4, 8, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r136-9x9-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r136-9x9-03', 'Rätsel 136 · 9×9', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x9-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('FROH', 'heiter', 'A', 1, 1, 4),
    ('SET', 'Satz', 'A', 1, 6, 3),
    ('EURO', 'Währung', 'A', 2, 1, 4),
    ('PRO', 'je', 'A', 2, 6, 3),
    ('ENTE', 'Wasservogel', 'A', 3, 1, 4),
    ('IST', 'befindet sich', 'A', 3, 6, 3),
    ('RAET', 'empfiehlt', 'A', 4, 4, 4),
    ('HELLES', 'lichtes', 'A', 5, 3, 6),
    ('UNI', 'Hochschule', 'A', 6, 1, 3),
    ('GERA', 'Stadt in Thüringen', 'A', 6, 5, 4),
    ('SEE', 'Gewässer', 'A', 7, 1, 3),
    ('ESEL', 'Grautier', 'A', 7, 5, 4),
    ('TURIN', 'Stadt am Po', 'A', 8, 1, 5),
    ('FEE', 'Zauberin', 'D', 1, 1, 3),
    ('LUST', 'Verlangen', 'D', 5, 1, 4),
    ('RUND', 'kreisförmig', 'D', 1, 2, 4),
    ('NEU', 'frisch', 'D', 6, 2, 3),
    ('ORT', 'Stelle', 'D', 1, 3, 3),
    ('HIER', 'an diesem Ort', 'D', 5, 3, 4),
    ('HOERE', 'lausche', 'D', 1, 4, 5),
    ('ALGEN', 'Tang', 'D', 4, 5, 5),
    ('SPIELES', 'Ende des ...', 'D', 1, 6, 7),
    ('ERSTERE', 'Vorgenannte', 'D', 1, 7, 7),
    ('TOT', 'leblos', 'D', 1, 8, 3),
    ('SALZ', 'Würzmittel', 'D', 5, 8, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r137-9x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r137-9x13-01', 'Rätsel 137 · 9×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('RAGT', 'steht empor', 'A', 1, 1, 4),
    ('FLUSSES', 'Ufer des ...', 'A', 1, 6, 7),
    ('OSLO', 'norw. Hauptstadt', 'A', 2, 1, 4),
    ('REIHE', 'Serie', 'A', 2, 8, 5),
    ('STARRE', 'steife', 'A', 3, 1, 6),
    ('NIERE', 'Organ', 'A', 3, 8, 5),
    ('STECKEN', 'klemmen', 'A', 4, 3, 7),
    ('ECHO', 'Widerhall', 'A', 5, 4, 4),
    ('HOB', 'stemmte', 'A', 6, 1, 3),
    ('HERZ', 'Pumpe', 'A', 6, 5, 4),
    ('OMA', 'Großmutter', 'A', 6, 10, 3),
    ('UNI', 'Hochschule', 'A', 7, 1, 3),
    ('TREU', 'loyal', 'A', 7, 5, 4),
    ('RAN', 'heran', 'A', 7, 10, 3),
    ('BESTE', 'optimale', 'A', 8, 1, 5),
    ('AMPELN', 'Signale', 'A', 8, 7, 6),
    ('ROSE', 'Blume mit Dornen', 'D', 1, 1, 4),
    ('HUB', 'Hebung', 'D', 6, 1, 3),
    ('AST', 'Zweig', 'D', 1, 2, 3),
    ('ZONE', 'Bereich', 'D', 5, 2, 4),
    ('GLAS', 'Trinkgefäß', 'D', 1, 3, 4),
    ('BIS', 'nicht später als', 'D', 6, 3, 3),
    ('TORTE', 'Kuchen', 'D', 1, 4, 5),
    ('RECHTE', 'Ansprüche', 'D', 3, 5, 6),
    ('FAECHER', 'Wedel', 'D', 1, 6, 7),
    ('KOREA', 'Halbinsel in Asien', 'D', 4, 7, 5),
    ('URNE', 'Aschengefäß', 'D', 1, 8, 4),
    ('ZUM', 'zu dem', 'D', 6, 8, 3),
    ('SEIN', 'existieren', 'D', 1, 9, 4),
    ('SIE', 'Anrede', 'D', 1, 10, 3),
    ('TORE', 'Treffer', 'D', 5, 10, 4),
    ('EHRE', 'Würde', 'D', 1, 11, 4),
    ('MAL', 'Zeichen ×', 'D', 6, 11, 3),
    ('SEE', 'Gewässer', 'D', 1, 12, 3),
    ('DANN', 'anschließend', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r138-9x13-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r138-9x13-02', 'Rätsel 138 · 9×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x13-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('TAG', '24 Stunden', 'A', 1, 1, 3),
    ('BAU', 'Gebäude', 'A', 1, 6, 3),
    ('AMT', 'Behörde', 'A', 1, 10, 3),
    ('AUE', 'Talwiese', 'A', 2, 1, 3),
    ('GALT', 'zählte', 'A', 2, 5, 4),
    ('RAR', 'selten', 'A', 2, 10, 3),
    ('URNE', 'Aschengefäß', 'A', 3, 1, 4),
    ('STABILE', 'feste', 'A', 3, 6, 7),
    ('SAFT', 'Most', 'A', 4, 1, 4),
    ('LEHRE', 'Ausbildung', 'A', 4, 6, 5),
    ('ABER', 'jedoch', 'A', 5, 4, 4),
    ('HUNGER', 'Appetit', 'A', 6, 1, 6),
    ('UMWEG', 'Abstecher', 'A', 6, 8, 5),
    ('HIER', 'an diesem Ort', 'A', 7, 2, 4),
    ('ANSAGE', 'Durchsage', 'A', 7, 7, 6),
    ('TRENNT', 'scheidet', 'A', 8, 1, 6),
    ('DEREN', 'dessen', 'A', 8, 8, 5),
    ('TAUSCH', 'Wechsel', 'D', 1, 1, 6),
    ('AURA', 'Ausstrahlung', 'D', 1, 2, 4),
    ('UHR', 'Zeitmesser', 'D', 6, 2, 3),
    ('GENF', 'Stadt am Léman', 'D', 1, 3, 4),
    ('NIE', 'nimmer', 'D', 6, 3, 3),
    ('ETAGEN', 'Stockwerke', 'D', 3, 4, 6),
    ('BERN', 'Schweizer Hauptstadt', 'D', 5, 5, 4),
    ('BASLER', 'Schweizer', 'D', 1, 6, 6),
    ('ALTER', 'Lebensjahre', 'D', 1, 7, 5),
    ('UTAH', 'Mormonenstaat', 'D', 1, 8, 4),
    ('UND', 'sowie', 'D', 6, 8, 3),
    ('BREMSE', 'Stechfliege', 'D', 3, 9, 6),
    ('ARIE', 'Sologesang', 'D', 1, 10, 4),
    ('WAR', 'existierte', 'D', 6, 10, 3),
    ('MAL', 'Zeichen ×', 'D', 1, 11, 3),
    ('WEGE', 'Pfade', 'D', 5, 11, 4),
    ('TREU', 'loyal', 'D', 1, 12, 4),
    ('GEN', 'nach', 'D', 6, 12, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r139-9x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r139-9x13-03', 'Rätsel 139 · 9×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('INNE', '... halten', 'A', 1, 1, 4),
    ('SYMPTOM', 'Anzeichen', 'A', 1, 6, 7),
    ('SUENDE', 'Frevel', 'A', 2, 1, 6),
    ('AROMA', 'Geschmack', 'A', 2, 8, 5),
    ('TRUGEN', 'schleppten', 'A', 3, 1, 6),
    ('MORAL', 'Ethik', 'A', 3, 8, 5),
    ('PAPA', 'Vater', 'A', 4, 5, 4),
    ('FOTO', 'Aufnahme', 'A', 5, 4, 4),
    ('ORTE', 'Plätze', 'A', 5, 9, 4),
    ('ERBEN', 'Nachkommen', 'A', 6, 1, 5),
    ('NIVEAU', 'Rang', 'A', 6, 7, 6),
    ('HAITI', 'Karibikstaat', 'A', 7, 1, 5),
    ('AUGE', 'Sehorgan', 'A', 7, 9, 4),
    ('ERSTENS', 'zunächst', 'A', 8, 1, 7),
    ('LEER', 'hohl', 'A', 8, 9, 4),
    ('IST', 'befindet sich', 'D', 1, 1, 3),
    ('GEHE', 'laufe', 'D', 5, 1, 4),
    ('NUR', 'lediglich', 'D', 1, 2, 3),
    ('RAR', 'selten', 'D', 6, 2, 3),
    ('NEUE', 'frische', 'D', 1, 3, 4),
    ('BIS', 'nicht später als', 'D', 6, 3, 3),
    ('ENG', 'schmal', 'D', 1, 4, 3),
    ('FETT', 'Schmalz', 'D', 5, 4, 4),
    ('DEPONIE', 'Müllplatz', 'D', 2, 5, 7),
    ('SENAT', 'Ältestenrat', 'D', 1, 6, 5),
    ('PONYS', 'Kleinpferde', 'D', 4, 7, 5),
    ('MAMA', 'Mutti', 'D', 1, 8, 4),
    ('PRO', 'je', 'D', 1, 9, 3),
    ('OVAL', 'eiförmig', 'D', 5, 9, 4),
    ('TOR', 'Treffer', 'D', 1, 10, 3),
    ('REUE', 'Bedauern', 'D', 5, 10, 4),
    ('OMA', 'Großmutter', 'D', 1, 11, 3),
    ('TAGE', 'je 24 Stunden', 'D', 5, 11, 4),
    ('MAL', 'Zeichen ×', 'D', 1, 12, 3),
    ('EUER', 'Possessiv (ihr)', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r140-10x10-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r140-10x10-01', 'Rätsel 140 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AUF', 'offen', 'A', 1, 1, 3),
    ('GLAS', 'Trinkgefäß', 'A', 1, 6, 4),
    ('UFERN', 'Gestaden', 'A', 2, 1, 5),
    ('AUE', 'Talwiese', 'A', 2, 7, 3),
    ('GEHE', 'laufe', 'A', 3, 1, 4),
    ('ISST', 'speist', 'A', 3, 6, 4),
    ('ERLASS', 'Verordnung', 'A', 4, 1, 6),
    ('KETTEN', 'Fesseln', 'A', 5, 4, 6),
    ('SAGTE', 'äußerte', 'A', 6, 1, 5),
    ('RIO', 'Stadt in Brasilien', 'A', 6, 7, 3),
    ('EURO', 'Währung', 'A', 7, 1, 4),
    ('WELT', 'Erde', 'A', 7, 6, 4),
    ('KLAR', 'deutlich', 'A', 8, 1, 4),
    ('ENTE', 'Wasservogel', 'A', 8, 6, 4),
    ('TAT', 'Handlung', 'A', 9, 1, 3),
    ('EMDEN', 'ostfries. Stadt', 'A', 9, 5, 5),
    ('AUGE', 'Sehorgan', 'D', 1, 1, 4),
    ('SEKT', 'Schaumwein', 'D', 6, 1, 4),
    ('UFER', 'Gestade', 'D', 1, 2, 4),
    ('AULA', 'Festsaal', 'D', 6, 2, 4),
    ('FEHL', '... am Platz', 'D', 1, 3, 4),
    ('GRAT', 'Kamm', 'D', 6, 3, 4),
    ('REAKTOR', 'Meiler', 'D', 2, 4, 7),
    ('SEE', 'Gewässer', 'D', 4, 5, 3),
    ('IST', 'befindet sich', 'D', 3, 6, 3),
    ('WEM', 'Fragewort (Dativ)', 'D', 7, 6, 3),
    ('LAS', 'schmökerte', 'D', 1, 7, 3),
    ('TREND', 'Tendenz', 'D', 5, 7, 5),
    ('AUS', 'vorbei', 'D', 1, 8, 3),
    ('EILTE', 'hastete', 'D', 5, 8, 5),
    ('SET', 'Satz', 'D', 1, 9, 3),
    ('NOTEN', 'Zensuren', 'D', 5, 9, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r141-10x10-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r141-10x10-02', 'Rätsel 141 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ANS', 'an das', 'A', 1, 1, 3),
    ('MAGER', 'dürr', 'A', 1, 5, 5),
    ('LIEBE', 'Zuneigung', 'A', 2, 1, 5),
    ('RIO', 'Stadt in Brasilien', 'A', 2, 7, 3),
    ('BETON', 'Baustoff', 'A', 3, 1, 5),
    ('ALT', 'betagt', 'A', 3, 7, 3),
    ('NUTZTE', 'verwendete', 'A', 4, 4, 6),
    ('IRANER', 'Perser', 'A', 5, 1, 6),
    ('MAG', 'liebt', 'A', 6, 1, 3),
    ('IRRT', 'täuscht sich', 'A', 6, 6, 4),
    ('AUE', 'Talwiese', 'A', 7, 1, 3),
    ('TEUER', 'kostspielig', 'A', 7, 5, 5),
    ('GEN', 'nach', 'A', 8, 1, 3),
    ('OBIGE', 'erwähnte', 'A', 8, 5, 5),
    ('ENTEN', 'Wasservögel', 'A', 9, 1, 5),
    ('NEU', 'frisch', 'A', 9, 7, 3),
    ('ALB', 'Gebirge', 'D', 1, 1, 3),
    ('IMAGE', 'Ansehen', 'D', 5, 1, 5),
    ('NIE', 'nimmer', 'D', 1, 2, 3),
    ('RAUEN', 'groben', 'D', 5, 2, 5),
    ('SET', 'Satz', 'D', 1, 3, 3),
    ('AGENT', 'Spion', 'D', 5, 3, 5),
    ('BONN', 'Ex-Hauptstadt', 'D', 2, 4, 4),
    ('MENUE', 'Speisenfolge', 'D', 1, 5, 5),
    ('TON', 'Klang', 'D', 7, 5, 3),
    ('TRIEB', 'schwamm', 'D', 4, 6, 5),
    ('GRAZ', 'Murstadt', 'D', 1, 7, 4),
    ('RUIN', 'Untergang', 'D', 6, 7, 4),
    ('EILT', 'hastet', 'D', 1, 8, 4),
    ('REGE', 'lebhaft', 'D', 6, 8, 4),
    ('ROTE', 'purpurne', 'D', 1, 9, 4),
    ('TREU', 'loyal', 'D', 6, 9, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r142-10x10-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r142-10x10-03', 'Rätsel 142 · 10×10', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '10x10-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AKTIE', 'Wertpapier', 'A', 1, 1, 5),
    ('SET', 'Satz', 'A', 1, 7, 3),
    ('PLAN', 'Absicht', 'A', 2, 1, 4),
    ('EHE', 'Bund fürs Leben', 'A', 2, 7, 3),
    ('FAST', 'beinahe', 'A', 3, 1, 4),
    ('IHRE', 'seine', 'A', 3, 6, 4),
    ('ERSEHNTE', 'erhoffte', 'A', 4, 1, 8),
    ('LEEREN', 'hohlen', 'A', 5, 1, 6),
    ('NIEDER', 'hinab', 'A', 6, 4, 6),
    ('INDES', 'jedoch', 'A', 7, 1, 5),
    ('INS', 'in das', 'A', 7, 7, 3),
    ('SEI', 'existiere', 'A', 8, 1, 3),
    ('STADT', 'Kommune', 'A', 8, 5, 5),
    ('TURM', 'Bergfried', 'A', 9, 1, 4),
    ('SEE', 'Gewässer', 'A', 9, 7, 3),
    ('APFEL', 'Kernobst', 'D', 1, 1, 5),
    ('IST', 'befindet sich', 'D', 7, 1, 3),
    ('KLARE', 'deutliche', 'D', 1, 2, 5),
    ('NEU', 'frisch', 'D', 7, 2, 3),
    ('TASSE', 'Becher', 'D', 1, 3, 5),
    ('DIR', 'Dat. (2. Pers.)', 'D', 7, 3, 3),
    ('INTERNE', 'innere', 'D', 1, 4, 7),
    ('HEISS', 'glühend', 'D', 4, 5, 5),
    ('INNE', '... halten', 'D', 3, 6, 4),
    ('SEHT', 'schaut', 'D', 1, 7, 4),
    ('DIAS', 'Lichtbilder', 'D', 6, 7, 4),
    ('EHRE', 'Würde', 'D', 1, 8, 4),
    ('ENDE', 'Schluss', 'D', 6, 8, 4),
    ('TEE', 'Heißgetränk', 'D', 1, 9, 3),
    ('ERSTE', 'anfängliche', 'D', 5, 9, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r143-10x10-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r143-10x10-04', 'Rätsel 143 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('WEHT', 'bläst', 'A', 1, 1, 4),
    ('ESSE', 'speise', 'A', 1, 6, 4),
    ('OMA', 'Großmutter', 'A', 2, 1, 3),
    ('KITAS', 'Kindergärten', 'A', 2, 5, 5),
    ('HALB', 'zur Hälfte', 'A', 3, 1, 4),
    ('GANS', 'Federvieh', 'A', 3, 6, 4),
    ('LILA', 'Violett', 'A', 4, 1, 4),
    ('ENDE', 'Schluss', 'A', 4, 6, 4),
    ('LEGENDEN', 'Sagen', 'A', 5, 2, 8),
    ('DIE', 'Artikel (weibl.)', 'A', 6, 4, 3),
    ('OZEAN', 'Weltmeer', 'A', 7, 1, 5),
    ('ASS', 'speiste', 'A', 7, 7, 3),
    ('FUNDE', 'Entdeckungen', 'A', 8, 1, 5),
    ('BEI', 'nahe an', 'A', 8, 7, 3),
    ('ARG', 'schlimm', 'A', 9, 1, 3),
    ('MITTE', 'Zentrum', 'A', 9, 5, 5),
    ('WOHL', 'vermutlich', 'D', 1, 1, 4),
    ('SOFA', 'Couch', 'D', 6, 1, 4),
    ('EMAIL', 'elektr. Post', 'D', 1, 2, 5),
    ('ZUR', 'zu der', 'D', 7, 2, 3),
    ('HALLE', 'Saal', 'D', 1, 3, 5),
    ('ENG', 'schmal', 'D', 7, 3, 3),
    ('BAGDAD', 'irak. Hauptstadt', 'D', 3, 4, 6),
    ('EINEM', 'unbest. Art. (Dat.)', 'D', 5, 5, 5),
    ('EIGENE', 'persönliche', 'D', 1, 6, 6),
    ('STAND', 'stockte', 'D', 1, 7, 5),
    ('ABT', 'Klosterchef', 'D', 7, 7, 3),
    ('SANDE', 'Strände', 'D', 1, 8, 5),
    ('SET', 'Satz', 'D', 7, 8, 3),
    ('ESSEN', 'Mahlzeit', 'D', 1, 9, 5),
    ('SIE', 'Anrede', 'D', 7, 9, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r144-11x11-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r144-11x11-01', 'Rätsel 144 · 11×11', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '11x11-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('MAUS', 'Nager', 'A', 1, 1, 4),
    ('KONGO', 'Strom in Afrika', 'A', 1, 6, 5),
    ('ARM', 'Gliedmaße', 'A', 2, 1, 3),
    ('ANS', 'an das', 'A', 2, 8, 3),
    ('LESBAR', 'entzifferbar', 'A', 3, 1, 6),
    ('TAT', 'Handlung', 'A', 3, 8, 3),
    ('BUDE', 'Kiosk', 'A', 4, 7, 4),
    ('TASTE', 'Knopf', 'A', 5, 1, 5),
    ('IREN', 'Gälen', 'A', 5, 7, 4),
    ('CENTS', 'Hundertstel', 'A', 6, 3, 5),
    ('ACH', 'Ausruf', 'A', 7, 1, 3),
    ('GOTHA', 'Stadt in Thüringen', 'A', 7, 5, 5),
    ('CHAT', 'Plauderei', 'A', 8, 1, 4),
    ('BRAUN', 'brünett', 'A', 8, 6, 5),
    ('KILO', '1000 Gramm', 'A', 9, 1, 4),
    ('TOLLE', 'großartige', 'A', 9, 6, 5),
    ('SPENDE', 'Gabe', 'A', 10, 1, 6),
    ('BAU', 'Gebäude', 'A', 10, 8, 3),
    ('MAL', 'Zeichen ×', 'D', 1, 1, 3),
    ('TRACKS', 'Musikstücke', 'D', 5, 1, 6),
    ('ARENA', 'Stadion', 'D', 1, 2, 5),
    ('CHIP', 'Halbleiter', 'D', 7, 2, 4),
    ('UMS', 'um das', 'D', 1, 3, 3),
    ('SCHALE', 'Schüssel', 'D', 5, 3, 6),
    ('BOTE', 'Kurier', 'D', 3, 4, 4),
    ('TON', 'Klang', 'D', 8, 4, 3),
    ('ENG', 'schmal', 'D', 5, 5, 3),
    ('KUR', 'Erholung', 'D', 1, 6, 3),
    ('TOBTE', 'wütete', 'D', 6, 6, 5),
    ('BISTRO', 'Lokal', 'D', 4, 7, 6),
    ('NATUR', 'Umwelt', 'D', 1, 8, 5),
    ('HALB', 'zur Hälfte', 'D', 7, 8, 4),
    ('GNADE', 'Erbarmen', 'D', 1, 9, 5),
    ('AULA', 'Festsaal', 'D', 7, 9, 4),
    ('OSTENS', 'Völker des ...', 'D', 1, 10, 6),
    ('NEU', 'frisch', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r145-11x11-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r145-11x11-02', 'Rätsel 145 · 11×11', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '11x11-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('RAR', 'selten', 'A', 1, 1, 3),
    ('UMWEGE', 'Abstecher', 'A', 1, 5, 6),
    ('EGAL', 'gleichgültig', 'A', 2, 1, 4),
    ('UEBEN', 'trainieren', 'A', 2, 6, 5),
    ('DEN', 'Artikel (Akkusativ)', 'A', 3, 1, 3),
    ('STRENG', 'rigoros', 'A', 3, 5, 6),
    ('ENG', 'schmal', 'A', 4, 1, 3),
    ('ARGE', 'schlimme', 'A', 5, 4, 4),
    ('PAPPE', 'Karton', 'A', 6, 1, 5),
    ('BEIN', 'Stelze', 'A', 6, 7, 4),
    ('EPIDEMIE', 'Seuche', 'A', 7, 3, 8),
    ('OHR', 'Hörorgan', 'A', 8, 1, 3),
    ('SENDEN', 'schicken', 'A', 8, 5, 6),
    ('FELS', 'Stein', 'A', 9, 1, 4),
    ('ADERN', 'Venen', 'A', 9, 6, 5),
    ('TUE', 'mache', 'A', 10, 1, 3),
    ('PLANTE', 'entwarf', 'A', 10, 5, 6),
    ('REDE', 'Ansprache', 'D', 1, 1, 4),
    ('OFT', 'häufig', 'D', 8, 1, 3),
    ('AGENDA', 'Tagesordnung', 'D', 1, 2, 6),
    ('HEU', 'Trockengras', 'D', 8, 2, 3),
    ('RANG', 'Stellung', 'D', 1, 3, 4),
    ('PERLE', 'Juwel', 'D', 6, 3, 5),
    ('APP', 'Anwendung', 'D', 5, 4, 3),
    ('REIS', 'Getreideart', 'D', 5, 5, 4),
    ('MUTIG', 'tapfer', 'D', 1, 6, 5),
    ('DEAL', 'Geschäft', 'D', 7, 6, 4),
    ('WER', 'Fragewort (Person)', 'D', 1, 7, 3),
    ('EBENDA', 'dort', 'D', 5, 7, 6),
    ('EBEN', 'flach', 'D', 1, 8, 4),
    ('EMDEN', 'ostfries. Stadt', 'D', 6, 8, 5),
    ('GEN', 'nach', 'D', 1, 9, 3),
    ('LIIERT', 'verbunden', 'D', 5, 9, 6),
    ('ENGE', 'schmale', 'D', 1, 10, 4),
    ('NENNE', 'bezeichne', 'D', 6, 10, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r146-11x11-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r146-11x11-03', 'Rätsel 146 · 11×11', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '11x11-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('RAGT', 'steht empor', 'A', 1, 1, 4),
    ('AULA', 'Festsaal', 'A', 1, 7, 4),
    ('OPA', 'Großvater', 'A', 2, 1, 3),
    ('MATRIX', 'Raster', 'A', 2, 5, 6),
    ('SPUK', 'Geisterei', 'A', 3, 1, 4),
    ('KENNT', 'weiß', 'A', 3, 6, 5),
    ('RAUMES', 'Mitte des ...', 'A', 4, 4, 6),
    ('GEHALT', 'Lohn', 'A', 5, 1, 6),
    ('NEU', 'frisch', 'A', 5, 8, 3),
    ('BUNT', 'farbig', 'A', 6, 2, 4),
    ('WEN', 'Fragewort (Akk.)', 'A', 7, 1, 3),
    ('ABT', 'Klosterchef', 'A', 7, 5, 3),
    ('ENG', 'schmal', 'A', 8, 1, 3),
    ('REIFEN', 'Pneu', 'A', 8, 5, 6),
    ('IDEE', 'Einfall', 'A', 9, 1, 4),
    ('ALIBI', 'Entlastung', 'A', 9, 6, 5),
    ('BAR', 'Theke', 'A', 10, 1, 3),
    ('TEXTE', 'Schriften', 'A', 10, 6, 5),
    ('ROSIG', 'blühend', 'D', 1, 1, 5),
    ('WEIB', 'Frau (veraltet)', 'D', 7, 1, 4),
    ('APP', 'Anwendung', 'D', 1, 2, 3),
    ('EBENDA', 'dort', 'D', 5, 2, 6),
    ('GAU', 'Landstrich', 'D', 1, 3, 3),
    ('HUNGER', 'Appetit', 'D', 5, 3, 6),
    ('KRAN', 'Hebezeug', 'D', 3, 4, 4),
    ('ALTAR', 'Opfertisch', 'D', 4, 5, 5),
    ('AKUT', 'dringend', 'D', 2, 6, 4),
    ('BEAT', 'Rhythmus', 'D', 7, 6, 4),
    ('ATEM', 'Luft', 'D', 1, 7, 4),
    ('STILE', 'Machart', 'D', 6, 7, 5),
    ('URNEN', 'Aschengefäße', 'D', 1, 8, 5),
    ('FIX', 'schnell', 'D', 8, 8, 3),
    ('LINSE', 'Objektiv', 'D', 1, 9, 5),
    ('HEBT', 'stemmt', 'D', 7, 9, 4),
    ('AXT', 'Beil', 'D', 1, 10, 3),
    ('NIE', 'nimmer', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r147-12x12-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r147-12x12-01', 'Rätsel 147 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('GAU', 'Landstrich', 'A', 1, 1, 3),
    ('STEG', 'Brücklein', 'A', 1, 8, 4),
    ('HUNGER', 'Appetit', 'A', 2, 1, 6),
    ('ARIE', 'Sologesang', 'A', 2, 8, 4),
    ('ASS', 'speiste', 'A', 3, 1, 3),
    ('IMMENS', 'riesig', 'A', 3, 6, 6),
    ('BITTET', 'ersucht', 'A', 4, 6, 6),
    ('ABSOLUT', 'völlig', 'A', 5, 1, 7),
    ('EKLAT', 'Skandal', 'A', 6, 2, 5),
    ('LIEGE', 'ruhe', 'A', 7, 1, 5),
    ('TEUER', 'kostspielig', 'A', 7, 7, 5),
    ('PER', 'mittels', 'A', 8, 3, 3),
    ('ERNTE', 'Lese', 'A', 8, 7, 5),
    ('UMS', 'um das', 'A', 9, 1, 3),
    ('MINUTEN', 'je 60 Sekunden', 'A', 9, 5, 7),
    ('NAIV', 'arglos', 'A', 10, 1, 4),
    ('SOFERN', 'falls', 'A', 10, 6, 6),
    ('EIS', 'Gefrorenes', 'A', 11, 1, 3),
    ('TRENNT', 'scheidet', 'A', 11, 6, 6),
    ('GHANA', 'Staat in Westafrika', 'D', 1, 1, 5),
    ('LAUNE', 'Stimmung', 'D', 7, 1, 5),
    ('AUS', 'vorbei', 'D', 1, 2, 3),
    ('BEI', 'nahe an', 'D', 5, 2, 3),
    ('MAI', '5. Monat', 'D', 9, 2, 3),
    ('UNS', 'Akk./Dat. von wir', 'D', 1, 3, 3),
    ('SKEPSIS', 'Zweifel', 'D', 5, 3, 7),
    ('FOLGE', 'Episode', 'D', 4, 4, 5),
    ('LAERM', 'Krach', 'D', 5, 5, 5),
    ('TRIBUT', 'Abgabe', 'D', 1, 6, 6),
    ('IST', 'befindet sich', 'D', 9, 6, 3),
    ('MIT', 'samt', 'D', 3, 7, 3),
    ('TENOR', 'Sängerstimme', 'D', 7, 7, 5),
    ('SAMT', 'inklusive', 'D', 1, 8, 4),
    ('BERUFE', 'Jobs', 'D', 6, 8, 6),
    ('TRETE', 'kicke', 'D', 1, 9, 5),
    ('UNTEN', 'am Grund', 'D', 7, 9, 5),
    ('EINE', 'unbest. Artikel (w.)', 'D', 1, 10, 4),
    ('METERN', 'nach hundert ...', 'D', 6, 10, 6),
    ('GESTE', 'Gebärde', 'D', 1, 11, 5),
    ('RENNT', 'läuft', 'D', 7, 11, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r148-12x12-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r148-12x12-02', 'Rätsel 148 · 12×12', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '12x12-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('STEG', 'Brücklein', 'A', 1, 1, 4),
    ('UTAH', 'Mormonenstaat', 'A', 1, 8, 4),
    ('PATE', 'Taufzeuge', 'A', 2, 1, 4),
    ('ONLINE', 'im Netz', 'A', 2, 6, 6),
    ('RUINEN', 'Trümmer', 'A', 3, 1, 6),
    ('MEHL', 'Backzutat', 'A', 3, 8, 4),
    ('ECK', 'Winkel', 'A', 4, 1, 3),
    ('RAD', 'Velo', 'A', 4, 9, 3),
    ('EHER', 'lieber', 'A', 5, 1, 4),
    ('RAUEN', 'groben', 'A', 5, 6, 5),
    ('ETAGE', 'Stockwerk', 'A', 6, 2, 5),
    ('ENGE', 'schmale', 'A', 6, 8, 4),
    ('ANTRAT', 'begann', 'A', 7, 1, 6),
    ('APP', 'Anwendung', 'A', 8, 7, 3),
    ('EBEN', 'flach', 'A', 9, 1, 4),
    ('IRAK', 'Land am Tigris', 'A', 9, 8, 4),
    ('NAHEZU', 'fast', 'A', 10, 1, 6),
    ('GAST', 'Besucher', 'A', 10, 8, 4),
    ('TREU', 'loyal', 'A', 11, 1, 4),
    ('FUEGTE', 'setzte', 'A', 11, 6, 6),
    ('SPREE', 'Fluss durch Berlin', 'D', 1, 1, 5),
    ('AGENT', 'Spion', 'D', 7, 1, 5),
    ('TAUCHEN', 'untergehen', 'D', 1, 2, 7),
    ('BAR', 'Theke', 'D', 9, 2, 3),
    ('ETIKETT', 'Aufkleber', 'D', 1, 3, 7),
    ('EHE', 'Bund fürs Leben', 'D', 9, 3, 3),
    ('GEN', 'nach', 'D', 1, 4, 3),
    ('RAR', 'selten', 'D', 5, 4, 3),
    ('NEU', 'frisch', 'D', 9, 4, 3),
    ('GAU', 'Landstrich', 'D', 6, 5, 3),
    ('KONKRET', 'greifbar', 'D', 1, 6, 7),
    ('RUF', 'Leumund', 'D', 9, 6, 3),
    ('ULM', 'Münsterstadt', 'D', 1, 8, 3),
    ('UEPPIGE', 'reichliche', 'D', 5, 8, 7),
    ('TIEREN', 'Kreaturen', 'D', 1, 9, 6),
    ('PRAG', 'Moldau-Stadt', 'D', 8, 9, 4),
    ('ANHANG', 'Beilage', 'D', 1, 10, 6),
    ('AST', 'Zweig', 'D', 9, 10, 3),
    ('HELD', 'Recke', 'D', 1, 11, 4),
    ('EXAKTE', 'genaue', 'D', 6, 11, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r149-12x12-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r149-12x12-03', 'Rätsel 149 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AMTES', 'Ende des ...', 'A', 1, 1, 5),
    ('HYMNE', 'Lobgesang', 'A', 1, 7, 5),
    ('TORNADO', 'Wirbelsturm', 'A', 2, 1, 7),
    ('AUS', 'vorbei', 'A', 2, 9, 3),
    ('ETAGE', 'Stockwerk', 'A', 3, 1, 5),
    ('INS', 'in das', 'A', 3, 9, 3),
    ('MIT', 'samt', 'A', 4, 1, 3),
    ('LEER', 'hohl', 'A', 4, 5, 4),
    ('EIN', 'unbest. Artikel', 'A', 5, 5, 3),
    ('VON', 'ab, aus', 'A', 5, 9, 3),
    ('HEFT', 'Broschüre', 'A', 6, 1, 4),
    ('OSTERN', 'christl. Fest', 'A', 7, 5, 6),
    ('KUR', 'Erholung', 'A', 8, 1, 3),
    ('STADION', 'Arena', 'A', 8, 5, 7),
    ('ATMET', 'holt Luft', 'A', 9, 1, 5),
    ('GESTE', 'Gebärde', 'A', 9, 7, 5),
    ('NAEHERE', 'das Genauere', 'A', 10, 1, 7),
    ('SEI', 'existiere', 'A', 10, 9, 3),
    ('UHREN', 'Zeitmesser', 'A', 11, 1, 5),
    ('DENN', 'weil', 'A', 11, 8, 4),
    ('ATEM', 'Luft', 'D', 1, 1, 4),
    ('KANU', 'Paddelboot', 'D', 8, 1, 4),
    ('MOTIVE', 'Beweggründe', 'D', 1, 2, 6),
    ('UTAH', 'Mormonenstaat', 'D', 8, 2, 4),
    ('TRAT', 'schritt', 'D', 1, 3, 4),
    ('FARMER', 'Landwirt', 'D', 6, 3, 6),
    ('ENG', 'schmal', 'D', 1, 4, 3),
    ('EHE', 'Bund fürs Leben', 'D', 9, 4, 3),
    ('SAELE', 'Hallen', 'D', 1, 5, 5),
    ('OSTEN', 'Richtung O', 'D', 7, 5, 5),
    ('EINST', 'früher', 'D', 4, 6, 5),
    ('HOHEN', 'großen', 'D', 1, 7, 5),
    ('TAGE', 'je 24 Stunden', 'D', 7, 7, 4),
    ('JEDE', 'alle', 'D', 6, 8, 4),
    ('MAI', '5. Monat', 'D', 1, 9, 3),
    ('RISSE', 'Spalten', 'D', 7, 9, 5),
    ('NUN', 'jetzt', 'D', 1, 10, 3),
    ('NOTEN', 'Zensuren', 'D', 7, 10, 5),
    ('ESSENZ', 'Kern', 'D', 1, 11, 6),
    ('NEIN', 'Ablehnung', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r150-12x12-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r150-12x12-04', 'Rätsel 150 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('BESTICHT', 'überzeugt', 'A', 1, 1, 8),
    ('EIERN', 'auf ... gehen', 'A', 2, 1, 5),
    ('AUS', 'vorbei', 'A', 2, 7, 3),
    ('INNEN', 'intern', 'A', 3, 1, 5),
    ('TRAUM', 'Wunschbild', 'A', 3, 7, 5),
    ('NEFFE', 'Verwandter', 'A', 4, 1, 5),
    ('INNE', '... halten', 'A', 4, 8, 4),
    ('FREUNDIN', 'Partnerin', 'A', 5, 4, 8),
    ('TOT', 'leblos', 'A', 6, 9, 3),
    ('DES', 'Artikel (Genitiv)', 'A', 7, 2, 3),
    ('LESEN', 'schmökern', 'A', 7, 6, 5),
    ('EILE', 'Hast', 'A', 8, 1, 4),
    ('ART', 'Sorte', 'A', 8, 6, 3),
    ('TAETIG', 'aktiv', 'A', 9, 1, 6),
    ('AFFE', 'Primat', 'A', 9, 8, 4),
    ('WEG', 'Pfad', 'A', 10, 1, 3),
    ('TIER', 'Lebewesen', 'A', 10, 8, 4),
    ('ATEM', 'Luft', 'A', 11, 1, 4),
    ('RETTEN', 'bergen', 'A', 11, 6, 6),
    ('BEIN', 'Stelze', 'D', 1, 1, 4),
    ('ETWA', 'ungefähr', 'D', 8, 1, 4),
    ('EINEN', 'unbest. Art. (Akk.)', 'D', 1, 2, 5),
    ('DIAET', 'Schonkost', 'D', 7, 2, 5),
    ('SENF', 'Mostrich', 'D', 1, 3, 4),
    ('BELEGE', 'Quittungen', 'D', 6, 3, 6),
    ('TREFF', 'Stelldichein', 'D', 1, 4, 5),
    ('SET', 'Satz', 'D', 7, 4, 3),
    ('INNERE', 'interne', 'D', 1, 5, 6),
    ('LAGER', 'Depot', 'D', 7, 6, 5),
    ('HAT', 'besitzt', 'D', 1, 7, 3),
    ('UFER', 'Gestade', 'D', 5, 7, 4),
    ('TURIN', 'Stadt am Po', 'D', 1, 8, 5),
    ('STATT', 'anstelle', 'D', 7, 8, 5),
    ('SANDTE', 'schickte', 'D', 2, 9, 6),
    ('FIT', 'gesund', 'D', 9, 9, 3),
    ('UNION', 'Bündnis', 'D', 3, 10, 5),
    ('FEE', 'Zauberin', 'D', 9, 10, 3),
    ('MOMENT', 'Augenblick', 'D', 1, 11, 6),
    ('GERN', 'mit Freude', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r151-13x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r151-13x13-01', 'Rätsel 151 · 13×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '13x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AUS', 'vorbei', 'A', 1, 1, 3),
    ('INS', 'in das', 'A', 1, 5, 3),
    ('WEIL', 'da', 'A', 1, 9, 4),
    ('URIN', 'Harn', 'A', 2, 1, 4),
    ('ACKER', 'Feld', 'A', 2, 6, 5),
    ('FLEISCH', 'Muskelgewebe', 'A', 3, 1, 7),
    ('GLAS', 'Trinkgefäß', 'A', 3, 9, 4),
    ('ETHIK', 'Moral', 'A', 4, 4, 5),
    ('DUO', 'Paar', 'A', 5, 1, 3),
    ('ATELIERS', 'Werkstätten', 'A', 5, 5, 8),
    ('ABBAU', 'Förderung', 'A', 6, 1, 5),
    ('NUSS', 'Kern', 'A', 6, 7, 4),
    ('TEE', 'Heißgetränk', 'A', 7, 1, 3),
    ('BLECH', 'Metallplatte', 'A', 7, 8, 5),
    ('URNE', 'Aschengefäß', 'A', 8, 1, 4),
    ('ROSA', 'Pink', 'A', 8, 6, 4),
    ('MORD', 'Tötung', 'A', 9, 9, 4),
    ('LUEBECK', 'Hansestadt', 'A', 10, 2, 7),
    ('VIA', 'über', 'A', 10, 10, 3),
    ('WOHNEN', 'leben', 'A', 11, 1, 6),
    ('AST', 'Zweig', 'A', 11, 10, 3),
    ('BREIT', 'weit', 'A', 12, 2, 5),
    ('HOLTE', 'besorgte', 'A', 12, 8, 5),
    ('AUF', 'offen', 'D', 1, 1, 3),
    ('DATUM', 'Tagesangabe', 'D', 5, 1, 5),
    ('URLAUBER', 'Tourist', 'D', 1, 2, 8),
    ('LOB', 'Anerkennung', 'D', 10, 2, 3),
    ('SIE', 'Anrede', 'D', 1, 3, 3),
    ('OBEN', 'in der Höhe', 'D', 5, 3, 4),
    ('UHR', 'Zeitmesser', 'D', 10, 3, 3),
    ('NIE', 'nimmer', 'D', 2, 4, 3),
    ('EBENE', 'Fläche', 'D', 8, 4, 5),
    ('STAU', 'Blechlawine', 'D', 3, 5, 4),
    ('BEI', 'nahe an', 'D', 10, 5, 3),
    ('NACHT', 'Dunkelheit', 'D', 1, 6, 5),
    ('ORIENT', 'Morgenland', 'D', 7, 6, 6),
    ('SCHIEN', 'leuchtete', 'D', 1, 7, 6),
    ('KLUBS', 'Vereine', 'D', 4, 8, 5),
    ('KUH', 'Rind', 'D', 10, 8, 3),
    ('WEG', 'Pfad', 'D', 1, 9, 3),
    ('ISLAM', 'Weltreligion', 'D', 5, 9, 5),
    ('ERLOESE', 'Einnahmen', 'D', 1, 10, 7),
    ('OVAL', 'eiförmig', 'D', 9, 10, 4),
    ('CHRIST', 'Gläubiger', 'D', 7, 11, 6),
    ('LOS', 'frei', 'D', 1, 12, 3),
    ('SAH', 'erblickte', 'D', 5, 12, 3),
    ('DATE', 'Verabredung', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r152-13x13-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r152-13x13-02', 'Rätsel 152 · 13×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '13x13-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('FEATURES', 'Merkmale', 'A', 1, 1, 8),
    ('MAN', 'jemand', 'A', 1, 10, 3),
    ('NAHER', 'benachbarter', 'A', 2, 3, 5),
    ('GERA', 'Stadt in Thüringen', 'A', 2, 9, 4),
    ('GERING', 'minimal', 'A', 3, 3, 6),
    ('HIN', '... und her', 'A', 3, 10, 3),
    ('EGAL', 'gleichgültig', 'A', 4, 1, 4),
    ('STEILEN', 'abschüssigen', 'A', 4, 6, 7),
    ('RABE', 'Krähenvogel', 'A', 5, 1, 4),
    ('TEIG', 'Masse', 'A', 5, 6, 4),
    ('TUERKE', 'Anatolier', 'A', 6, 1, 6),
    ('SEE', 'Gewässer', 'A', 6, 8, 3),
    ('KELTEN', 'Gallier', 'A', 7, 7, 6),
    ('BERG', 'Gipfel', 'A', 8, 3, 4),
    ('FAESSER', 'Tonnen', 'A', 9, 1, 7),
    ('INNE', '... halten', 'A', 9, 9, 4),
    ('AUSSEN', 'extern', 'A', 10, 1, 6),
    ('FRIES', 'Zierstreifen', 'A', 10, 8, 5),
    ('STEINEN', 'mit ... werfen', 'A', 11, 1, 7),
    ('REIS', 'Getreideart', 'A', 11, 9, 4),
    ('SONG', 'Lied', 'A', 12, 1, 4),
    ('WENDE', 'Umschwung', 'A', 12, 8, 5),
    ('FEUERTE', 'schoss', 'D', 1, 1, 7),
    ('FASS', 'Tonne', 'D', 9, 1, 4),
    ('GAU', 'Landstrich', 'D', 4, 2, 3),
    ('AUTO', 'Pkw', 'D', 9, 2, 4),
    ('ANGABE', 'Auskunft', 'D', 1, 3, 6),
    ('BESEN', 'Kehrgerät', 'D', 8, 3, 5),
    ('TAELER', 'Senken', 'D', 1, 4, 6),
    ('ESSIG', 'Würzmittel', 'D', 8, 4, 5),
    ('UHR', 'Zeitmesser', 'D', 1, 5, 3),
    ('KURSEN', 'Lehrgängen', 'D', 6, 5, 6),
    ('REISTE', 'fuhr', 'D', 1, 6, 6),
    ('GENEN', 'Erbanlagen', 'D', 8, 6, 5),
    ('ERNTE', 'Lese', 'D', 1, 7, 5),
    ('GEISEL', 'Gefangener', 'D', 3, 8, 6),
    ('IGEL', 'Stacheltier', 'D', 4, 9, 4),
    ('IRRE', 'Verrückte', 'D', 9, 9, 4),
    ('MEHL', 'Backzutat', 'D', 1, 10, 4),
    ('ETHNIEN', 'Volksgruppen', 'D', 6, 10, 7),
    ('ARIE', 'Sologesang', 'D', 1, 11, 4),
    ('NEID', 'Missgunst', 'D', 9, 11, 4),
    ('NANNTEN', 'bezeichneten', 'D', 1, 12, 7),
    ('ESSE', 'speise', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r153-13x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r153-13x13-03', 'Rätsel 153 · 13×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '13x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ERST', 'zunächst', 'A', 1, 1, 4),
    ('LOT', 'Senkblei', 'A', 1, 6, 3),
    ('APP', 'Anwendung', 'A', 1, 10, 3),
    ('NIE', 'nimmer', 'A', 2, 1, 3),
    ('LABORS', 'Prüfstätten', 'A', 2, 5, 6),
    ('GENUEGEN', 'reichen', 'A', 3, 1, 8),
    ('IST', 'befindet sich', 'A', 3, 10, 3),
    ('FINGEN', 'erwischten', 'A', 4, 2, 6),
    ('RATE', 'Teilzahlung', 'A', 4, 9, 4),
    ('ODER', 'bzw.', 'A', 5, 3, 4),
    ('TUN', 'machen', 'A', 5, 10, 3),
    ('OHR', 'Hörorgan', 'A', 6, 1, 3),
    ('NAEHERT', 'rückt heran', 'A', 6, 6, 7),
    ('MAERZ', '3. Monat', 'A', 7, 1, 5),
    ('PRINZ', 'Königssohn', 'A', 7, 7, 5),
    ('MINE', 'Bergwerk', 'A', 8, 1, 4),
    ('SPUR', 'Fährte', 'A', 8, 6, 4),
    ('LENKEN', 'steuern', 'A', 9, 7, 6),
    ('NASE', 'Riechorgan', 'A', 10, 1, 4),
    ('SAH', 'erblickte', 'A', 10, 6, 3),
    ('INS', 'in das', 'A', 10, 10, 3),
    ('DUELL', 'Zweikampf', 'A', 11, 1, 5),
    ('UMWEGE', 'Abstecher', 'A', 11, 7, 6),
    ('OFEN', 'Herd', 'A', 12, 1, 4),
    ('AST', 'Zweig', 'A', 12, 6, 3),
    ('WER', 'Fragewort (Person)', 'A', 12, 10, 3),
    ('ENG', 'schmal', 'D', 1, 1, 3),
    ('KOMMANDO', 'Befehl', 'D', 5, 1, 8),
    ('RIEF', 'schrie', 'D', 1, 2, 4),
    ('HAI', 'Raubfisch', 'D', 6, 2, 3),
    ('AUF', 'offen', 'D', 10, 2, 3),
    ('SENIOREN', 'Ältere', 'D', 1, 3, 8),
    ('SEE', 'Gewässer', 'D', 10, 3, 3),
    ('UND', 'sowie', 'D', 3, 4, 3),
    ('REGELN', 'Normen', 'D', 7, 4, 6),
    ('LEGE', 'platziere', 'D', 2, 5, 4),
    ('LAGERN', 'Depots', 'D', 1, 6, 6),
    ('OBEN', 'in der Höhe', 'D', 1, 7, 4),
    ('APPLAUS', 'Beifall', 'D', 6, 7, 7),
    ('TON', 'Klang', 'D', 1, 8, 3),
    ('BERUEHMT', 'bekannt', 'D', 5, 8, 8),
    ('HIRN', 'Verstand', 'D', 6, 9, 4),
    ('ASIATEN', 'Orientalen', 'D', 1, 10, 7),
    ('KIEW', 'ukrain. Hauptstadt', 'D', 9, 10, 4),
    ('STURZ', 'Fall', 'D', 3, 11, 5),
    ('ENGE', 'schmale', 'D', 9, 11, 4),
    ('PATENT', 'Schutzrecht', 'D', 1, 12, 6),
    ('UNSER', 'Possessiv (wir)', 'D', 8, 12, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r154-15x15-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r154-15x15-01', 'Rätsel 154 · 15×15', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '15x15-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('PAAR', 'einige', 'A', 1, 1, 4),
    ('TAG', '24 Stunden', 'A', 1, 6, 3),
    ('BIRGT', 'enthält', 'A', 1, 10, 5),
    ('ALBANER', 'Skipetaren', 'A', 2, 1, 7),
    ('BUDE', 'Kiosk', 'A', 2, 9, 4),
    ('RISS', 'zerrte', 'A', 3, 1, 4),
    ('UMS', 'um das', 'A', 3, 6, 3),
    ('REIFE', 'Mündigkeit', 'A', 3, 10, 5),
    ('TAETER', 'Verbrecher', 'A', 4, 1, 6),
    ('GENAU', 'exakt', 'A', 4, 10, 5),
    ('IST', 'befindet sich', 'A', 5, 1, 3),
    ('REMIS', 'Gleichstand', 'A', 5, 5, 5),
    ('ECK', 'Winkel', 'A', 6, 12, 3),
    ('VERSAH', 'stattete aus', 'A', 7, 2, 6),
    ('DROHEN', 'bevorstehen', 'A', 7, 9, 6),
    ('YEN', 'Währung Japans', 'A', 8, 1, 3),
    ('TURNIERE', 'Wettkämpfe', 'A', 8, 5, 8),
    ('DES', 'Artikel (Genitiv)', 'A', 9, 4, 3),
    ('AMT', 'Behörde', 'A', 9, 9, 3),
    ('STIRN', 'die ... bieten', 'A', 10, 1, 5),
    ('LIED', 'Song', 'A', 10, 7, 4),
    ('KANU', 'Paddelboot', 'A', 11, 1, 4),
    ('GEHT', 'läuft', 'A', 11, 6, 4),
    ('MORD', 'Tötung', 'A', 11, 11, 4),
    ('ANSCHEIN', 'Eindruck', 'A', 12, 1, 8),
    ('TIGER', 'Großkatze', 'A', 12, 10, 5),
    ('KURSE', 'Lehrgänge', 'A', 13, 4, 5),
    ('ETAGE', 'Stockwerk', 'A', 13, 10, 5),
    ('AUF', 'offen', 'A', 14, 1, 3),
    ('TAENZE', 'Reigen', 'A', 14, 5, 6),
    ('REH', 'Waldtier', 'A', 14, 12, 3),
    ('PARTIE', 'Spiel', 'D', 1, 1, 6),
    ('SKALA', 'Stufenleiter', 'D', 10, 1, 5),
    ('ALIAS', 'auch genannt', 'D', 1, 2, 5),
    ('VERTAN', 'verschwendet', 'D', 7, 2, 6),
    ('ABSETZEN', 'abstellen', 'D', 1, 3, 8),
    ('INS', 'in das', 'D', 10, 3, 3),
    ('RAST', 'jagt', 'D', 1, 4, 4),
    ('DRUCK', 'Zwang', 'D', 9, 4, 5),
    ('ERNSTEN', 'seriösen', 'D', 4, 5, 7),
    ('HUT', 'Kopfbedeckung', 'D', 12, 5, 3),
    ('TEURE', 'kostspielige', 'D', 1, 6, 5),
    ('AUS', 'vorbei', 'D', 7, 6, 3),
    ('GERA', 'Stadt in Thüringen', 'D', 11, 6, 4),
    ('ARM', 'Gliedmaße', 'D', 1, 7, 3),
    ('MEHR', 'zusätzlich', 'D', 5, 7, 4),
    ('LEISE', 'gedämpft', 'D', 10, 7, 5),
    ('SEI', 'existiere', 'D', 3, 8, 3),
    ('IHNEN', 'Anrede', 'D', 10, 8, 5),
    ('DIAET', 'Schonkost', 'D', 7, 9, 5),
    ('BURG', 'Festung', 'D', 1, 10, 4),
    ('FREMD', 'unbekannt', 'D', 6, 10, 5),
    ('TEE', 'Heißgetränk', 'D', 12, 10, 3),
    ('IDEEN', 'Einfälle', 'D', 1, 11, 5),
    ('ORT', 'Stelle', 'D', 7, 11, 3),
    ('MIT', 'samt', 'D', 11, 11, 3),
    ('REIN', 'sauber', 'D', 1, 12, 4),
    ('EHE', 'Bund fürs Leben', 'D', 6, 12, 3),
    ('SOGAR', 'selbst', 'D', 10, 12, 5),
    ('FARCE', 'Posse', 'D', 3, 13, 5),
    ('REGE', 'lebhaft', 'D', 11, 13, 4),
    ('TREU', 'loyal', 'D', 1, 14, 4),
    ('KNIE', 'Gelenk', 'D', 6, 14, 4),
    ('DREH', 'Kniff', 'D', 11, 14, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r155-15x15-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r155-15x15-02', 'Rätsel 155 · 15×15', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '15x15-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('OPERN', 'Musikdramen', 'A', 1, 1, 5),
    ('PARIS', 'Seine-Stadt', 'A', 1, 10, 5),
    ('BUS', 'Car (schweiz.)', 'A', 2, 1, 3),
    ('OSLO', 'norw. Hauptstadt', 'A', 2, 5, 4),
    ('FRAGE', 'Erkundigung', 'A', 2, 10, 5),
    ('EBENE', 'Fläche', 'A', 3, 1, 5),
    ('EREIGNET', 'zugetragen', 'A', 3, 7, 8),
    ('LATEIN', 'alte Sprache', 'A', 4, 3, 6),
    ('HERD', 'Kochstelle', 'A', 5, 4, 4),
    ('PFAD', 'Weg', 'A', 5, 9, 4),
    ('PAKT', 'Bündnis', 'A', 6, 1, 4),
    ('BEI', 'nahe an', 'A', 6, 6, 3),
    ('LEHM', 'Ton', 'A', 6, 11, 4),
    ('HAI', 'Raubfisch', 'A', 7, 1, 3),
    ('STAUS', 'Blechlawinen', 'A', 7, 10, 5),
    ('ALL', 'Weltraum', 'A', 8, 1, 3),
    ('GENRE', 'Gattung', 'A', 8, 5, 5),
    ('ALB', 'Gebirge', 'A', 8, 11, 3),
    ('SEOUL', 'korean. Hauptstadt', 'A', 9, 1, 5),
    ('EIER', 'Gelege', 'A', 9, 8, 4),
    ('NASS', 'feucht', 'A', 10, 4, 4),
    ('BUB', 'Knabe', 'A', 10, 12, 3),
    ('KRISTALL', 'Edelstein', 'A', 11, 2, 8),
    ('RUHM', 'Ehre', 'A', 11, 11, 4),
    ('RIO', 'Stadt in Brasilien', 'A', 12, 1, 3),
    ('GAU', 'Landstrich', 'A', 12, 5, 3),
    ('AERA', 'Epoche', 'A', 12, 11, 4),
    ('ANSPORN', 'Anreiz', 'A', 13, 1, 7),
    ('SAUREN', 'herben', 'A', 13, 9, 6),
    ('ROT', 'purpurn', 'A', 14, 1, 3),
    ('ASS', 'speiste', 'A', 14, 7, 3),
    ('BONN', 'Ex-Hauptstadt', 'A', 14, 11, 4),
    ('OBEN', 'in der Höhe', 'D', 1, 1, 4),
    ('PHASE', 'Abschnitt', 'D', 6, 1, 5),
    ('RAR', 'selten', 'D', 12, 1, 3),
    ('PUB', 'Kneipe', 'D', 1, 2, 3),
    ('SAALE', 'Fluss durch Halle', 'D', 5, 2, 5),
    ('KINO', 'Filmtheater', 'D', 11, 2, 4),
    ('ESEL', 'Grautier', 'D', 1, 3, 4),
    ('KILO', '1000 Gramm', 'D', 6, 3, 4),
    ('ROST', 'Grill', 'D', 11, 3, 4),
    ('NAHT', 'kommt näher', 'D', 3, 4, 4),
    ('UNI', 'Hochschule', 'D', 9, 4, 3),
    ('NOETE', 'Sorgen', 'D', 1, 5, 5),
    ('GLASGOW', 'Stadt in Schottland', 'D', 8, 5, 7),
    ('ERBTE', 'übernahm', 'D', 4, 6, 5),
    ('STAR', 'Berühmtheit', 'D', 10, 6, 4),
    ('LEIDE', 'dulde', 'D', 2, 7, 5),
    ('SAUNA', 'Schwitzbad', 'D', 10, 7, 5),
    ('KORN', 'Getreide', 'D', 1, 8, 4),
    ('IRRE', 'Verrückte', 'D', 6, 8, 4),
    ('EINLASS', 'Zutritt', 'D', 8, 9, 7),
    ('PFIFF', 'Signal', 'D', 1, 10, 5),
    ('ARG', 'schlimm', 'D', 1, 11, 3),
    ('ALTAR', 'Opfertisch', 'D', 5, 11, 5),
    ('RAUB', 'Diebstahl', 'D', 11, 11, 4),
    ('RAN', 'heran', 'D', 1, 12, 3),
    ('DEAL', 'Geschäft', 'D', 5, 12, 4),
    ('BUERO', 'Kanzlei', 'D', 10, 12, 5),
    ('IGEL', 'Stacheltier', 'D', 1, 13, 4),
    ('HUB', 'Hebung', 'D', 6, 13, 3),
    ('UHREN', 'Zeitmesser', 'D', 10, 13, 5),
    ('SET', 'Satz', 'D', 1, 14, 3),
    ('UMS', 'um das', 'D', 5, 14, 3),
    ('OBMANN', 'Vorsitzender', 'D', 9, 14, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r156-15x15-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r156-15x15-03', 'Rätsel 156 · 15×15', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '15x15-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('WOLKE', 'Dunstgebilde', 'A', 1, 1, 5),
    ('REICHTEN', 'genügten', 'A', 1, 7, 8),
    ('EHER', 'lieber', 'A', 2, 1, 4),
    ('MEHR', 'zusätzlich', 'A', 2, 6, 4),
    ('RIGA', 'lett. Hauptstadt', 'A', 3, 1, 4),
    ('ODER', 'bzw.', 'A', 3, 6, 4),
    ('FARM', 'Bauernhof', 'A', 3, 11, 4),
    ('KOENNTE', 'vermöchte', 'A', 4, 1, 7),
    ('KAM', 'nahte', 'A', 4, 12, 3),
    ('GUTE', 'prima', 'A', 5, 11, 4),
    ('ALTE', 'betagte', 'A', 6, 1, 4),
    ('VOR', 'ehe', 'A', 6, 6, 3),
    ('VATER', 'Papa', 'A', 6, 10, 5),
    ('LAENGER', 'ausgedehnter', 'A', 7, 1, 7),
    ('POLEN', 'Weichselland', 'A', 7, 9, 5),
    ('SEE', 'Gewässer', 'A', 8, 1, 3),
    ('ENTLANG', 'längs', 'A', 8, 5, 7),
    ('ESSE', 'speise', 'A', 9, 11, 4),
    ('ADLER', 'Greifvogel', 'A', 10, 1, 5),
    ('BOT', 'offerierte', 'A', 10, 7, 3),
    ('NACH', 'hinter', 'A', 10, 11, 4),
    ('BEI', 'nahe an', 'A', 11, 1, 3),
    ('DRAMEN', 'Schauspiele', 'A', 11, 5, 6),
    ('UHR', 'Zeitmesser', 'A', 11, 12, 3),
    ('ERSTE', 'anfängliche', 'A', 12, 1, 5),
    ('SEI', 'existiere', 'A', 12, 7, 3),
    ('TRAT', 'schritt', 'A', 12, 11, 4),
    ('TURBINE', 'Triebwerk', 'A', 13, 3, 7),
    ('OEL', 'Schmierstoff', 'A', 13, 11, 3),
    ('DIENT', 'nützt', 'A', 14, 1, 5),
    ('NENNEN', 'bezeichnen', 'A', 14, 9, 6),
    ('WERK', 'Fabrik', 'D', 1, 1, 4),
    ('ALS', 'da, während', 'D', 6, 1, 3),
    ('ABEND', 'Tagesende', 'D', 10, 1, 5),
    ('OHIO', 'Staat um Cleveland', 'D', 1, 2, 4),
    ('LAENDER', 'Staaten', 'D', 6, 2, 7),
    ('LEGE', 'platziere', 'D', 1, 3, 4),
    ('TEE', 'Heißgetränk', 'D', 6, 3, 3),
    ('LISTE', 'Aufstellung', 'D', 10, 3, 5),
    ('KRANKEN', 'Patienten', 'D', 1, 4, 7),
    ('TUN', 'machen', 'D', 12, 4, 3),
    ('GEORDERT', 'bestellt', 'D', 7, 5, 8),
    ('MOTIVEN', 'aus niederen ...', 'D', 2, 6, 7),
    ('REDE', 'Ansprache', 'D', 1, 7, 4),
    ('ORT', 'Stelle', 'D', 6, 7, 3),
    ('BASIS', 'Grundlage', 'D', 10, 7, 5),
    ('EHE', 'Bund fürs Leben', 'D', 1, 8, 3),
    ('OMEN', 'Vorzeichen', 'D', 10, 8, 4),
    ('IRRT', 'täuscht sich', 'D', 1, 9, 4),
    ('PARTEIEN', 'politische Lager', 'D', 7, 9, 8),
    ('VON', 'ab, aus', 'D', 6, 10, 3),
    ('HOF', 'Gehöft', 'D', 1, 11, 3),
    ('GALGEN', 'Richtstätte', 'D', 5, 11, 6),
    ('TON', 'Klang', 'D', 12, 11, 3),
    ('AKUTE', 'dringende', 'D', 3, 12, 5),
    ('SAUREN', 'herben', 'D', 9, 12, 6),
    ('RATEN', 'empfehlen', 'D', 3, 13, 5),
    ('SCHALE', 'Schüssel', 'D', 9, 13, 6),
    ('NUMMER', 'Zahl', 'D', 1, 14, 6),
    ('KEHRT', 'fegt', 'D', 8, 14, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

commit;
-- Automatisch erzeugt von tools/generator/generate_raetsel.py – nicht von Hand bearbeiten.
-- Voraussetzung: Migrationen, gitter_vorlagen.sql, woerter_seed.sql, fragen_varianten_seed.sql eingespielt.
-- Idempotent über raetsel.slug. Rätsel mit Prüfhinweisen werden als Entwurf angelegt.

begin;

-- r157-8x8-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r157-8x8-01', 'Rätsel 157 · 8×8', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '8x8-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('PLAN', 'Absicht', 'A', 1, 1, 4),
    ('UEBERS', 'über das', 'A', 2, 1, 6),
    ('RETTET', 'birgt', 'A', 3, 1, 6),
    ('TIEF', 'abgründig', 'A', 4, 4, 4),
    ('BEI', 'nahe an', 'A', 5, 1, 3),
    ('NIE', 'nimmer', 'A', 5, 5, 3),
    ('SIEGT', 'gewinnt', 'A', 6, 3, 5),
    ('GUT', 'prima', 'A', 7, 1, 3),
    ('SET', 'Satz', 'A', 7, 5, 3),
    ('PUR', 'rein', 'D', 1, 1, 3),
    ('BUG', 'Vorderschiff', 'D', 5, 1, 3),
    ('LEERE', 'Vakuum', 'D', 1, 2, 5),
    ('ABT', 'Klosterchef', 'D', 1, 3, 3),
    ('IST', 'befindet sich', 'D', 5, 3, 3),
    ('NETT', 'freundlich', 'D', 1, 4, 4),
    ('REINES', 'pures', 'D', 2, 5, 6),
    ('STEIGE', 'klettere', 'D', 2, 6, 6),
    ('FETT', 'Schmalz', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r158-8x8-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r158-8x8-02', 'Rätsel 158 · 8×8', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '8x8-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('GANZ', 'völlig', 'A', 1, 4, 4),
    ('KABEL', 'Leitung', 'A', 2, 1, 5),
    ('ADELS', 'Titel des ...', 'A', 3, 1, 5),
    ('NETT', 'freundlich', 'A', 4, 1, 4),
    ('REMIS', 'Gleichstand', 'A', 5, 3, 5),
    ('ANIME', 'jap. Zeichentrick', 'A', 6, 3, 5),
    ('AUF', 'offen', 'A', 7, 1, 3),
    ('TAT', 'Handlung', 'A', 7, 5, 3),
    ('KANADA', 'Ahornland', 'D', 2, 1, 6),
    ('WADE', 'Beinmuskel', 'D', 1, 2, 4),
    ('BETRAF', 'anging', 'D', 2, 3, 6),
    ('GELTEN', 'zählen', 'D', 1, 4, 6),
    ('ALS', 'da, während', 'D', 1, 5, 3),
    ('MIT', 'samt', 'D', 5, 5, 3),
    ('LIMA', 'peruan. Hauptstadt', 'D', 4, 6, 4),
    ('ZUM', 'zu dem', 'D', 1, 7, 3),
    ('SET', 'Satz', 'D', 5, 7, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r159-8x8-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r159-8x8-03', 'Rätsel 159 · 8×8', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '8x8-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('PRAEGT', 'formt', 'A', 1, 1, 6),
    ('ANDERN', 'übrigen', 'A', 2, 2, 6),
    ('UNSERE', 'Possessiv (wir)', 'A', 3, 1, 6),
    ('LESE', 'schmökere', 'A', 4, 4, 4),
    ('BAT', 'ersuchte', 'A', 5, 1, 3),
    ('DEN', 'Artikel (Akkusativ)', 'A', 5, 5, 3),
    ('TUE', 'mache', 'A', 6, 1, 3),
    ('ENG', 'schmal', 'A', 6, 5, 3),
    ('ESEL', 'Grautier', 'A', 7, 1, 4),
    ('UEBTE', 'trainierte', 'D', 3, 1, 5),
    ('RAN', 'heran', 'D', 1, 2, 3),
    ('AUS', 'vorbei', 'D', 5, 2, 3),
    ('ANS', 'an das', 'D', 1, 3, 3),
    ('TEE', 'Heißgetränk', 'D', 5, 3, 3),
    ('EDEL', 'vornehm', 'D', 1, 4, 4),
    ('GEREDE', 'Geschwätz', 'D', 1, 5, 6),
    ('TRESEN', 'Theke', 'D', 1, 6, 6),
    ('ENGE', 'schmale', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r160-9x9-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r160-9x9-01', 'Rätsel 160 · 9×9', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '9x9-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('SEHE', 'erblicke', 'A', 1, 1, 4),
    ('ASS', 'speiste', 'A', 1, 6, 3),
    ('CHOR', 'Singgruppe', 'A', 2, 1, 4),
    ('MIT', 'samt', 'A', 2, 6, 3),
    ('HELD', 'Recke', 'A', 3, 1, 4),
    ('TEE', 'Heißgetränk', 'A', 3, 6, 3),
    ('ENTE', 'Wasservogel', 'A', 4, 1, 4),
    ('DOSE', 'Büchse', 'A', 5, 5, 4),
    ('BEINAHE', 'fast', 'A', 6, 1, 7),
    ('EISERNE', 'stählerne', 'A', 7, 1, 7),
    ('STUFEN', 'Etappen', 'A', 8, 2, 6),
    ('SCHEIBE', 'Platte', 'D', 1, 1, 7),
    ('EHEN', 'Bündnisse', 'D', 1, 2, 4),
    ('EIS', 'Gefrorenes', 'D', 6, 2, 3),
    ('HOLT', 'besorgt', 'D', 1, 3, 4),
    ('IST', 'befindet sich', 'D', 6, 3, 3),
    ('ERDE', 'Welt', 'D', 1, 4, 4),
    ('NEU', 'frisch', 'D', 6, 4, 3),
    ('DARF', 'kann', 'D', 5, 5, 4),
    ('AMT', 'Behörde', 'D', 1, 6, 3),
    ('OHNE', 'abzüglich', 'D', 5, 6, 4),
    ('SIE', 'Anrede', 'D', 1, 7, 3),
    ('SEEN', 'Gewässer', 'D', 5, 7, 4),
    ('STEHE', 'ich ... auf', 'D', 1, 8, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r161-9x9-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r161-9x9-02', 'Rätsel 161 · 9×9', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '9x9-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('WANN', 'Fragewort (Zeit)', 'A', 1, 1, 4),
    ('ABT', 'Klosterchef', 'A', 1, 6, 3),
    ('ASIEN', 'Erdteil', 'A', 2, 1, 5),
    ('STEUERN', 'Abgaben', 'A', 3, 1, 7),
    ('SIND', 'existieren', 'A', 4, 5, 4),
    ('UPDATE', 'Nachtrag', 'A', 5, 1, 6),
    ('MAUL', 'Schnauze', 'A', 6, 1, 4),
    ('SEE', 'Gewässer', 'A', 6, 6, 3),
    ('SAFT', 'Most', 'A', 7, 1, 4),
    ('IHN', 'Akkusativ von er', 'A', 7, 6, 3),
    ('ORTE', 'Plätze', 'A', 8, 1, 4),
    ('GEN', 'nach', 'A', 8, 6, 3),
    ('WAS', 'Fragewort (Sache)', 'D', 1, 1, 3),
    ('UMSO', 'desto', 'D', 5, 1, 4),
    ('AST', 'Zweig', 'D', 1, 2, 3),
    ('PAAR', 'einige', 'D', 5, 2, 4),
    ('NIE', 'nimmer', 'D', 1, 3, 3),
    ('DUFT', 'Wohlgeruch', 'D', 5, 3, 4),
    ('NEU', 'frisch', 'D', 1, 4, 3),
    ('ALTE', 'betagte', 'D', 5, 4, 4),
    ('NEST', 'Horst', 'D', 2, 5, 4),
    ('RIESIG', 'gewaltig', 'D', 3, 6, 6),
    ('BANN', 'Zauber', 'D', 1, 7, 4),
    ('EHE', 'Bund fürs Leben', 'D', 6, 7, 3),
    ('DUENN', 'mager', 'D', 4, 8, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r162-9x9-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r162-9x9-03', 'Rätsel 162 · 9×9', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x9-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('SEES', 'Ufer des ...', 'A', 1, 1, 4),
    ('ALS', 'da, während', 'A', 1, 6, 3),
    ('ECHO', 'Widerhall', 'A', 2, 1, 4),
    ('DIE', 'Artikel (weibl.)', 'A', 2, 6, 3),
    ('EHER', 'lieber', 'A', 3, 1, 4),
    ('UNI', 'Hochschule', 'A', 3, 6, 3),
    ('GELD', 'Moneten', 'A', 4, 4, 4),
    ('RETTET', 'birgt', 'A', 5, 3, 6),
    ('RIO', 'Stadt in Brasilien', 'A', 6, 1, 3),
    ('HERR', 'Gebieter', 'A', 6, 5, 4),
    ('ASS', 'speiste', 'A', 7, 1, 3),
    ('INNE', '... halten', 'A', 7, 5, 4),
    ('STARK', 'kräftig', 'A', 8, 1, 5),
    ('SEE', 'Gewässer', 'D', 1, 1, 3),
    ('GRAS', 'Rasen', 'D', 5, 1, 4),
    ('ECHT', 'authentisch', 'D', 1, 2, 4),
    ('IST', 'befindet sich', 'D', 6, 2, 3),
    ('EHE', 'Bund fürs Leben', 'D', 1, 3, 3),
    ('ROSA', 'Pink', 'D', 5, 3, 4),
    ('SORGE', 'Kummer', 'D', 1, 4, 5),
    ('ETHIK', 'Moral', 'D', 4, 5, 5),
    ('ADULTEN', 'erwachsenen', 'D', 1, 6, 7),
    ('LINDERN', 'mildern', 'D', 1, 7, 7),
    ('SEI', 'existiere', 'D', 1, 8, 3),
    ('TREU', 'loyal', 'D', 5, 8, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r163-9x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r163-9x13-01', 'Rätsel 163 · 9×13', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '9x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('CHEF', 'Boss', 'A', 1, 1, 4),
    ('ANSTATT', 'für', 'A', 1, 6, 7),
    ('HOHE', 'große', 'A', 2, 1, 4),
    ('TOKIO', 'jap. Hauptstadt', 'A', 2, 8, 5),
    ('ABRISS', 'Abbruch', 'A', 3, 1, 6),
    ('ARTEN', 'Sorten', 'A', 3, 8, 5),
    ('ENTWARF', 'skizzierte', 'A', 4, 3, 7),
    ('DEAL', 'Geschäft', 'A', 5, 4, 4),
    ('AUF', 'offen', 'A', 6, 1, 3),
    ('CHIP', 'Halbleiter', 'A', 6, 5, 4),
    ('VOR', 'ehe', 'A', 6, 10, 3),
    ('UNI', 'Hochschule', 'A', 7, 1, 3),
    ('KLAR', 'deutlich', 'A', 7, 5, 4),
    ('ART', 'Sorte', 'A', 7, 10, 3),
    ('SITZT', 'hockt', 'A', 8, 1, 5),
    ('SOLLTE', 'müsste', 'A', 8, 7, 6),
    ('CHAT', 'Plauderei', 'D', 1, 1, 4),
    ('AUS', 'vorbei', 'D', 6, 1, 3),
    ('HOB', 'stemmte', 'D', 1, 2, 3),
    ('JUNI', '6. Monat', 'D', 5, 2, 4),
    ('EHRE', 'Würde', 'D', 1, 3, 4),
    ('FIT', 'gesund', 'D', 6, 3, 3),
    ('FEIND', 'Gegner', 'D', 1, 4, 5),
    ('STECKT', 'sitzt fest', 'D', 3, 5, 6),
    ('AUSWAHL', 'Sortiment', 'D', 1, 6, 7),
    ('ALIAS', 'auch genannt', 'D', 4, 7, 5),
    ('STAR', 'Berühmtheit', 'D', 1, 8, 4),
    ('PRO', 'je', 'D', 6, 8, 3),
    ('TORF', 'Moorboden', 'D', 1, 9, 4),
    ('AKT', 'Aufzug', 'D', 1, 10, 3),
    ('OVAL', 'eiförmig', 'D', 5, 10, 4),
    ('TIER', 'Lebewesen', 'D', 1, 11, 4),
    ('ORT', 'Stelle', 'D', 6, 11, 3),
    ('TON', 'Klang', 'D', 1, 12, 3),
    ('ORTE', 'Plätze', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r164-9x13-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r164-9x13-02', 'Rätsel 164 · 9×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x13-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AUF', 'offen', 'A', 1, 1, 3),
    ('DAR', 'stellt ... (zeigt)', 'A', 1, 6, 3),
    ('ANS', 'an das', 'A', 1, 10, 3),
    ('UNI', 'Hochschule', 'A', 2, 1, 3),
    ('PERU', 'Andenstaat', 'A', 2, 5, 4),
    ('TUT', 'macht', 'A', 2, 10, 3),
    ('TIEF', 'abgründig', 'A', 3, 1, 4),
    ('SCHOENE', 'hübsche', 'A', 3, 6, 7),
    ('OSLO', 'norw. Hauptstadt', 'A', 4, 1, 4),
    ('IHREM', 'seinem', 'A', 4, 6, 5),
    ('LOGE', 'Theaterrang', 'A', 5, 4, 4),
    ('SANGEN', 'trällerten', 'A', 6, 1, 6),
    ('ETWAS', 'ein wenig', 'A', 6, 8, 5),
    ('LIED', 'Song', 'A', 7, 2, 4),
    ('KLEINE', 'winzige', 'A', 7, 7, 6),
    ('EBENEN', 'Flächen', 'A', 8, 1, 6),
    ('FREUE', 'juble', 'A', 8, 8, 5),
    ('AUTORS', 'Werk des ...', 'D', 1, 1, 6),
    ('UNIS', 'Hochschulen', 'D', 1, 2, 4),
    ('ALB', 'Gebirge', 'D', 6, 2, 3),
    ('FIEL', 'stürzte', 'D', 1, 3, 4),
    ('NIE', 'nimmer', 'D', 6, 3, 3),
    ('FOLGEN', 'Konsequenzen', 'D', 3, 4, 6),
    ('OEDE', 'langweilig', 'D', 5, 5, 4),
    ('DESIGN', 'Gestaltung', 'D', 1, 6, 6),
    ('ARCHE', 'Noahs Schiff', 'D', 1, 7, 5),
    ('RUHR', 'Fluss im Revier', 'D', 1, 8, 4),
    ('ELF', 'Zahl (10+1)', 'D', 6, 8, 3),
    ('OEFTER', 'häufiger', 'D', 3, 9, 6),
    ('ATEM', 'Luft', 'D', 1, 10, 4),
    ('WIE', 'gleich', 'D', 6, 10, 3),
    ('NUN', 'jetzt', 'D', 1, 11, 3),
    ('KANU', 'Paddelboot', 'D', 5, 11, 4),
    ('STEG', 'Brücklein', 'D', 1, 12, 4),
    ('SEE', 'Gewässer', 'D', 6, 12, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r165-9x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r165-9x13-03', 'Rätsel 165 · 9×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AHNT', 'vermutet', 'A', 1, 1, 4),
    ('NEULAND', 'Terra incognita', 'A', 1, 6, 7),
    ('SAEURE', 'Gegenteil von Base', 'A', 2, 1, 6),
    ('FOLIE', 'Film', 'A', 2, 8, 5),
    ('STREIT', 'Zank', 'A', 3, 1, 6),
    ('ESSEN', 'Mahlzeit', 'A', 3, 8, 5),
    ('STAR', 'Berühmtheit', 'A', 4, 5, 4),
    ('KIEL', 'Förde-Stadt', 'A', 5, 4, 4),
    ('RUFE', 'Schreie', 'A', 5, 9, 4),
    ('BREAK', 'Pause', 'A', 6, 1, 5),
    ('THEMEN', 'Gegenstände', 'A', 6, 7, 6),
    ('SAHNE', 'Rahm', 'A', 7, 1, 5),
    ('ISST', 'speist', 'A', 7, 9, 4),
    ('TRENNEN', 'scheiden', 'A', 8, 1, 7),
    ('NOTE', 'Zensur', 'A', 8, 9, 4),
    ('ASS', 'speiste', 'D', 1, 1, 3),
    ('OBST', 'Früchte', 'D', 5, 1, 4),
    ('HAT', 'besitzt', 'D', 1, 2, 3),
    ('RAR', 'selten', 'D', 6, 2, 3),
    ('NERV', 'Reizleiter', 'D', 1, 3, 4),
    ('EHE', 'Bund fürs Leben', 'D', 6, 3, 3),
    ('TUE', 'mache', 'D', 1, 4, 3),
    ('KANN', 'vermag', 'D', 5, 4, 4),
    ('RISIKEN', 'Gefahren', 'D', 2, 5, 7),
    ('NETTE', 'freundliche', 'D', 1, 6, 5),
    ('ALTEN', 'betagten', 'D', 4, 7, 5),
    ('UFER', 'Gestade', 'D', 1, 8, 4),
    ('LOS', 'frei', 'D', 1, 9, 3),
    ('REIN', 'sauber', 'D', 5, 9, 4),
    ('ALS', 'da, während', 'D', 1, 10, 3),
    ('UMSO', 'desto', 'D', 5, 10, 4),
    ('NIE', 'nimmer', 'D', 1, 11, 3),
    ('FEST', 'stabil', 'D', 5, 11, 4),
    ('DEN', 'Artikel (Akkusativ)', 'D', 1, 12, 3),
    ('ENTE', 'Wasservogel', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r166-10x10-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r166-10x10-01', 'Rätsel 166 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AUF', 'offen', 'A', 1, 1, 3),
    ('DIVA', 'Primadonna', 'A', 1, 6, 4),
    ('UFERN', 'Gestaden', 'A', 2, 1, 5),
    ('HOB', 'stemmte', 'A', 2, 7, 3),
    ('GEHE', 'laufe', 'A', 3, 1, 4),
    ('IRRT', 'täuscht sich', 'A', 3, 6, 4),
    ('ERLASS', 'Verordnung', 'A', 4, 1, 6),
    ('KETTEN', 'Fesseln', 'A', 5, 4, 6),
    ('HATTE', 'besaß', 'A', 6, 1, 5),
    ('RIO', 'Stadt in Brasilien', 'A', 6, 7, 3),
    ('EURO', 'Währung', 'A', 7, 1, 4),
    ('WELT', 'Erde', 'A', 7, 6, 4),
    ('FLUR', 'Diele', 'A', 8, 1, 4),
    ('ENTE', 'Wasservogel', 'A', 8, 6, 4),
    ('TAG', '24 Stunden', 'A', 9, 1, 3),
    ('EMDEN', 'ostfries. Stadt', 'A', 9, 5, 5),
    ('AUGE', 'Sehorgan', 'D', 1, 1, 4),
    ('HEFT', 'Broschüre', 'D', 6, 1, 4),
    ('UFER', 'Gestade', 'D', 1, 2, 4),
    ('AULA', 'Festsaal', 'D', 6, 2, 4),
    ('FEHL', '... am Platz', 'D', 1, 3, 4),
    ('TRUG', 'schleppte', 'D', 6, 3, 4),
    ('REAKTOR', 'Meiler', 'D', 2, 4, 7),
    ('SEE', 'Gewässer', 'D', 4, 5, 3),
    ('IST', 'befindet sich', 'D', 3, 6, 3),
    ('WEM', 'Fragewort (Dativ)', 'D', 7, 6, 3),
    ('IHR', 'Pronomen (2. Pl.)', 'D', 1, 7, 3),
    ('TREND', 'Tendenz', 'D', 5, 7, 5),
    ('VOR', 'ehe', 'D', 1, 8, 3),
    ('EILTE', 'hastete', 'D', 5, 8, 5),
    ('ABT', 'Klosterchef', 'D', 1, 9, 3),
    ('NOTEN', 'Zensuren', 'D', 5, 9, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r167-10x10-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r167-10x10-02', 'Rätsel 167 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ABT', 'Klosterchef', 'A', 1, 1, 3),
    ('ALPHA', 'griech. Buchstabe', 'A', 1, 5, 5),
    ('LIEBT', 'hat gern', 'A', 2, 1, 5),
    ('LOK', 'Zugmaschine', 'A', 2, 7, 3),
    ('STEIL', 'abschüssig', 'A', 3, 1, 5),
    ('ALT', 'betagt', 'A', 3, 7, 3),
    ('TAENZE', 'Reigen', 'A', 4, 4, 6),
    ('WEISST', 'kennst', 'A', 5, 1, 6),
    ('EIN', 'unbest. Artikel', 'A', 6, 1, 3),
    ('WAGT', 'riskiert', 'A', 6, 6, 4),
    ('INS', 'in das', 'A', 7, 1, 3),
    ('MAUER', 'Wand', 'A', 7, 5, 5),
    ('SEE', 'Gewässer', 'A', 8, 1, 3),
    ('ASCHE', 'Glutrest', 'A', 8, 5, 5),
    ('ERLAG', 'starb an', 'A', 9, 1, 5),
    ('HEU', 'Trockengras', 'A', 9, 7, 3),
    ('ALS', 'da, während', 'D', 1, 1, 3),
    ('WEISE', 'Art', 'D', 5, 1, 5),
    ('BIT', 'Binärziffer', 'D', 1, 2, 3),
    ('EINER', 'unbest. Art. (w.)', 'D', 5, 2, 5),
    ('TEE', 'Heißgetränk', 'D', 1, 3, 3),
    ('INSEL', 'Eiland', 'D', 5, 3, 5),
    ('BITS', 'Binärziffern', 'D', 2, 4, 4),
    ('ATLAS', 'Kartenwerk', 'D', 1, 5, 5),
    ('MAG', 'liebt', 'D', 7, 5, 3),
    ('ETWAS', 'ein wenig', 'D', 4, 6, 5),
    ('PLAN', 'Absicht', 'D', 1, 7, 4),
    ('AUCH', 'ebenfalls', 'D', 6, 7, 4),
    ('HOLZ', 'Werkstoff', 'D', 1, 8, 4),
    ('GEHE', 'laufe', 'D', 6, 8, 4),
    ('AKTE', 'Dokument', 'D', 1, 9, 4),
    ('TREU', 'loyal', 'D', 6, 9, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r168-10x10-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r168-10x10-03', 'Rätsel 168 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AMTES', 'Ende des ...', 'A', 1, 1, 5),
    ('ASS', 'speiste', 'A', 1, 7, 3),
    ('KEIN', 'nicht ein', 'A', 2, 1, 4),
    ('BEI', 'nahe an', 'A', 2, 7, 3),
    ('KIND', 'Nachwuchs', 'A', 3, 1, 4),
    ('SEHE', 'erblicke', 'A', 3, 6, 4),
    ('UNTERART', 'Varietät', 'A', 4, 1, 8),
    ('STETIG', 'beständig', 'A', 5, 1, 6),
    ('ETAPPE', 'Abschnitt', 'A', 6, 4, 6),
    ('SEINE', 'ihre', 'A', 7, 1, 5),
    ('LOS', 'frei', 'A', 7, 7, 3),
    ('EIN', 'unbest. Artikel', 'A', 8, 1, 3),
    ('NEUSS', 'Stadt am Rhein', 'A', 8, 5, 5),
    ('ISST', 'speist', 'A', 9, 1, 4),
    ('SEE', 'Gewässer', 'A', 9, 7, 3),
    ('AKKUS', 'Batterien', 'D', 1, 1, 5),
    ('SEI', 'existiere', 'D', 7, 1, 3),
    ('MEINT', 'glaubt', 'D', 1, 2, 5),
    ('EIS', 'Gefrorenes', 'D', 7, 2, 3),
    ('TINTE', 'Tusche', 'D', 1, 3, 5),
    ('INS', 'in das', 'D', 7, 3, 3),
    ('ENDETEN', 'hörten auf', 'D', 1, 4, 7),
    ('RITEN', 'Bräuche', 'D', 4, 5, 5),
    ('SAGA', 'Heldensage', 'D', 3, 6, 4),
    ('ABER', 'jedoch', 'D', 1, 7, 4),
    ('PLUS', 'Überschuss', 'D', 6, 7, 4),
    ('SEHT', 'schaut', 'D', 1, 8, 4),
    ('POSE', 'Haltung', 'D', 6, 8, 4),
    ('SIE', 'Anrede', 'D', 1, 9, 3),
    ('MESSE', 'Gottesdienst', 'D', 5, 9, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r169-10x10-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r169-10x10-04', 'Rätsel 169 · 10×10', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '10x10-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ESSE', 'speise', 'A', 1, 1, 4),
    ('SAFE', 'Tresor', 'A', 1, 6, 4),
    ('HAT', 'besitzt', 'A', 2, 1, 3),
    ('ZOGEN', 'zerrten', 'A', 2, 5, 5),
    ('EGAL', 'gleichgültig', 'A', 3, 1, 4),
    ('LEID', 'Kummer', 'A', 3, 6, 4),
    ('REDE', 'Ansprache', 'A', 4, 1, 4),
    ('INNE', '... halten', 'A', 4, 6, 4),
    ('NEUESTEN', 'jüngsten', 'A', 5, 2, 8),
    ('TUT', 'macht', 'A', 6, 4, 3),
    ('IMMER', 'stets', 'A', 7, 1, 5),
    ('AST', 'Zweig', 'A', 7, 7, 3),
    ('LAUNE', 'Stimmung', 'A', 8, 1, 5),
    ('RIO', 'Stadt in Brasilien', 'A', 8, 7, 3),
    ('MIT', 'samt', 'A', 9, 1, 3),
    ('METER', 'Längenmaß', 'A', 9, 5, 5),
    ('EHER', 'lieber', 'D', 1, 1, 4),
    ('FILM', 'Kinostreifen', 'D', 6, 1, 4),
    ('SAGEN', 'äußern', 'D', 1, 2, 5),
    ('MAI', '5. Monat', 'D', 7, 2, 3),
    ('STADE', 'Elbhafen', 'D', 1, 3, 5),
    ('MUT', 'Courage', 'D', 7, 3, 3),
    ('LEUTEN', 'Menschen', 'D', 3, 4, 6),
    ('EUREM', 'Possessiv (ihr)', 'D', 5, 5, 5),
    ('SOLIST', 'Einzelsänger', 'D', 1, 6, 6),
    ('AGENT', 'Spion', 'D', 1, 7, 5),
    ('ART', 'Sorte', 'D', 7, 7, 3),
    ('FEINE', 'zarte', 'D', 1, 8, 5),
    ('SIE', 'Anrede', 'D', 7, 8, 3),
    ('ENDEN', 'aufhören', 'D', 1, 9, 5),
    ('TOR', 'Treffer', 'D', 7, 9, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r170-11x11-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r170-11x11-01', 'Rätsel 170 · 11×11', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '11x11-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AHNT', 'vermutet', 'A', 1, 1, 4),
    ('WERKE', 'Schöpfungen', 'A', 1, 6, 5),
    ('BAU', 'Gebäude', 'A', 2, 1, 3),
    ('ALB', 'Gebirge', 'A', 2, 8, 3),
    ('TERMIN', 'Verabredung', 'A', 3, 1, 6),
    ('SEE', 'Gewässer', 'A', 3, 8, 3),
    ('BEIN', 'Stelze', 'A', 4, 7, 4),
    ('STAUB', 'Schmutz', 'A', 5, 1, 5),
    ('ENDE', 'Schluss', 'A', 5, 7, 4),
    ('KLIMA', 'Wetterlage', 'A', 6, 3, 5),
    ('ART', 'Sorte', 'A', 7, 1, 3),
    ('SUMME', 'Betrag', 'A', 7, 5, 5),
    ('TEIG', 'Masse', 'A', 8, 1, 4),
    ('STARB', 'verschied', 'A', 8, 6, 5),
    ('IDEE', 'Einfall', 'A', 9, 1, 4),
    ('SEIDE', 'Gewebe', 'A', 9, 6, 5),
    ('KENNST', 'weißt', 'A', 10, 1, 6),
    ('SEI', 'existiere', 'A', 10, 8, 3),
    ('ABT', 'Klosterchef', 'D', 1, 1, 3),
    ('STATIK', 'Baulehre', 'D', 5, 1, 6),
    ('HAELT', 'stoppt', 'D', 1, 2, 5),
    ('REDE', 'Ansprache', 'D', 7, 2, 4),
    ('NUR', 'lediglich', 'D', 1, 3, 3),
    ('AKTIEN', 'Wertpapiere', 'D', 5, 3, 6),
    ('MAUL', 'Schnauze', 'D', 3, 4, 4),
    ('GEN', 'nach', 'D', 8, 4, 3),
    ('BIS', 'nicht später als', 'D', 5, 5, 3),
    ('WEN', 'Fragewort (Akk.)', 'D', 1, 6, 3),
    ('MUSST', 'sollst', 'D', 6, 6, 5),
    ('BEAMTE', 'Staatsdiener', 'D', 4, 7, 6),
    ('RASEN', 'Grünfläche', 'D', 1, 8, 5),
    ('MAIS', 'Kukuruz', 'D', 7, 8, 4),
    ('KLEID', 'Gewand', 'D', 1, 9, 5),
    ('ERDE', 'Welt', 'D', 7, 9, 4),
    ('EBENEN', 'Flächen', 'D', 1, 10, 6),
    ('BEI', 'nahe an', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r171-11x11-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r171-11x11-02', 'Rätsel 171 · 11×11', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '11x11-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('UNI', 'Hochschule', 'A', 1, 1, 3),
    ('OSTSEE', 'Baltisches Meer', 'A', 1, 5, 6),
    ('NAHT', 'kommt näher', 'A', 2, 1, 4),
    ('TEICH', 'Weiher', 'A', 2, 6, 5),
    ('IHR', 'Pronomen (2. Pl.)', 'A', 3, 1, 3),
    ('LUECKE', 'Spalt', 'A', 3, 5, 6),
    ('SEE', 'Gewässer', 'A', 4, 1, 3),
    ('DEMO', 'Kundgebung', 'A', 5, 4, 4),
    ('DUBAI', 'Emirat', 'A', 6, 1, 5),
    ('BAUE', 'errichte', 'A', 6, 7, 4),
    ('ERLIEGEN', 'zum ... kommen', 'A', 7, 3, 8),
    ('GAU', 'Landstrich', 'A', 8, 1, 3),
    ('ERREGT', 'nervös', 'A', 8, 5, 6),
    ('AUGE', 'Sehorgan', 'A', 9, 1, 4),
    ('RENTE', 'Pension', 'A', 9, 6, 5),
    ('SET', 'Satz', 'A', 10, 1, 3),
    ('RENTEN', 'Pensionen', 'A', 10, 5, 6),
    ('UNIS', 'Hochschulen', 'D', 1, 1, 4),
    ('GAS', 'Brennstoff', 'D', 8, 1, 3),
    ('NAHEZU', 'fast', 'D', 1, 2, 6),
    ('AUE', 'Talwiese', 'D', 8, 2, 3),
    ('IHRE', 'seine', 'D', 1, 3, 4),
    ('BEUGT', 'krümmt', 'D', 6, 3, 5),
    ('DAR', 'stellt ... (zeigt)', 'D', 5, 4, 3),
    ('EILE', 'Hast', 'D', 5, 5, 4),
    ('STUMM', 'wortlos', 'D', 1, 6, 5),
    ('IRRE', 'Verrückte', 'D', 7, 6, 4),
    ('TEE', 'Heißgetränk', 'D', 1, 7, 3),
    ('OBEREN', 'höher gelegenen', 'D', 5, 7, 6),
    ('SICH', 'rückbezügl. Fürwort', 'D', 1, 8, 4),
    ('AGENT', 'Spion', 'D', 6, 8, 5),
    ('ECK', 'Winkel', 'D', 1, 9, 3),
    ('FUEGTE', 'setzte', 'D', 5, 9, 6),
    ('EHEN', 'Bündnisse', 'D', 1, 10, 4),
    ('ENTEN', 'Wasservögel', 'D', 6, 10, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r172-11x11-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r172-11x11-03', 'Rätsel 172 · 11×11', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '11x11-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ASYL', 'Zuflucht', 'A', 1, 1, 4),
    ('PFAD', 'Weg', 'A', 1, 7, 4),
    ('TEE', 'Heißgetränk', 'A', 2, 1, 3),
    ('PFARRE', 'Kirchspiel', 'A', 2, 5, 6),
    ('LINK', 'Verknüpfung', 'A', 3, 1, 4),
    ('ASIEN', 'Erdteil', 'A', 3, 6, 5),
    ('NASSEN', 'feuchten', 'A', 4, 4, 6),
    ('SKRIPT', 'Drehbuch', 'A', 5, 1, 6),
    ('SAH', 'erblickte', 'A', 5, 8, 3),
    ('EIER', 'Gelege', 'A', 6, 2, 4),
    ('SIE', 'Anrede', 'A', 7, 1, 3),
    ('IHR', 'Pronomen (2. Pl.)', 'A', 7, 5, 3),
    ('ANS', 'an das', 'A', 8, 1, 3),
    ('LIEGEN', 'ruhen', 'A', 8, 5, 6),
    ('GEIL', 'toll (ugs.)', 'A', 9, 1, 4),
    ('NIERE', 'Organ', 'A', 9, 6, 5),
    ('ENG', 'schmal', 'A', 10, 1, 3),
    ('GENAU', 'exakt', 'A', 10, 6, 5),
    ('ATLAS', 'Kartenwerk', 'D', 1, 1, 5),
    ('SAGE', 'Legende', 'D', 7, 1, 4),
    ('SEI', 'existiere', 'D', 1, 2, 3),
    ('KEINEN', 'null', 'D', 5, 2, 6),
    ('YEN', 'Währung Japans', 'D', 1, 3, 3),
    ('RIESIG', 'gewaltig', 'D', 5, 3, 6),
    ('KNIE', 'Gelenk', 'D', 3, 4, 4),
    ('APRIL', '4. Monat', 'D', 4, 5, 5),
    ('FAST', 'beinahe', 'D', 2, 6, 4),
    ('HING', 'baumelte', 'D', 7, 6, 4),
    ('PASS', 'Ausweis', 'D', 1, 7, 4),
    ('FREIE', 'ungebundene', 'D', 6, 7, 5),
    ('FRIES', 'Zierstreifen', 'D', 1, 8, 5),
    ('GEN', 'nach', 'D', 8, 8, 3),
    ('ARENA', 'Stadion', 'D', 1, 9, 5),
    ('AERA', 'Epoche', 'D', 7, 9, 4),
    ('DEN', 'Artikel (Akkusativ)', 'D', 1, 10, 3),
    ('NEU', 'frisch', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r173-12x12-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r173-12x12-01', 'Rätsel 173 · 12×12', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '12x12-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('TOD', 'Ableben', 'A', 1, 1, 3),
    ('IHRE', 'seine', 'A', 1, 8, 4),
    ('REEDER', 'Schiffsherr', 'A', 2, 1, 6),
    ('DEAL', 'Geschäft', 'A', 2, 8, 4),
    ('ULM', 'Münsterstadt', 'A', 3, 1, 3),
    ('ZIELTE', 'visierte', 'A', 3, 6, 6),
    ('THEMEN', 'Gegenstände', 'A', 4, 6, 6),
    ('PARISER', 'Seine-Städter', 'A', 5, 1, 7),
    ('KINOS', 'Filmtheater', 'A', 6, 2, 5),
    ('STEIF', 'starr', 'A', 7, 1, 5),
    ('DRANG', 'stieß vor', 'A', 7, 7, 5),
    ('SEI', 'existiere', 'A', 8, 3, 3),
    ('UEBTE', 'trainierte', 'A', 8, 7, 5),
    ('HAI', 'Raubfisch', 'A', 9, 1, 3),
    ('AGENTEN', 'Spione', 'A', 9, 5, 7),
    ('AUGE', 'Sehorgan', 'A', 10, 1, 4),
    ('ANDERE', 'übrige', 'A', 10, 6, 6),
    ('FEE', 'Zauberin', 'A', 11, 1, 3),
    ('UNSINN', 'Blödsinn', 'A', 11, 6, 6),
    ('TRUPP', 'Schar', 'D', 1, 1, 5),
    ('SCHAF', 'Wolltier', 'D', 7, 1, 5),
    ('OEL', 'Schmierstoff', 'D', 1, 2, 3),
    ('AKT', 'Aufzug', 'D', 5, 2, 3),
    ('AUE', 'Talwiese', 'D', 9, 2, 3),
    ('DEM', 'Artikel (Dativ)', 'D', 1, 3, 3),
    ('RIESIGE', 'gewaltige', 'D', 5, 3, 7),
    ('LINIE', 'Strich', 'D', 4, 4, 5),
    ('SOFIA', 'bulg. Hauptstadt', 'D', 5, 5, 5),
    ('ARZTES', 'Praxis des ...', 'D', 1, 6, 6),
    ('GAU', 'Landstrich', 'D', 9, 6, 3),
    ('IHR', 'Pronomen (2. Pl.)', 'D', 3, 7, 3),
    ('DUENN', 'mager', 'D', 7, 7, 5),
    ('IDEE', 'Einfall', 'D', 1, 8, 4),
    ('TRENDS', 'Moden', 'D', 6, 8, 6),
    ('HELME', 'Kopfschutz', 'D', 1, 9, 5),
    ('ABTEI', 'Kloster', 'D', 7, 9, 5),
    ('RATE', 'Teilzahlung', 'D', 1, 10, 4),
    ('INTERN', 'innen', 'D', 6, 10, 6),
    ('ELEND', 'Jammer', 'D', 1, 11, 5),
    ('GENEN', 'Erbanlagen', 'D', 7, 11, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r174-12x12-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r174-12x12-02', 'Rätsel 174 · 12×12', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '12x12-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ERST', 'zunächst', 'A', 1, 1, 4),
    ('ALLE', 'sämtliche', 'A', 1, 8, 4),
    ('VITA', 'Lebenslauf', 'A', 2, 1, 4),
    ('ALLEIN', 'einsam', 'A', 2, 6, 6),
    ('ETAGEN', 'Stockwerke', 'A', 3, 1, 6),
    ('SIND', 'existieren', 'A', 3, 8, 4),
    ('NUR', 'lediglich', 'A', 4, 1, 3),
    ('SIE', 'Anrede', 'A', 4, 9, 3),
    ('TAKT', 'Rhythmus', 'A', 5, 1, 4),
    ('HUETE', 'Kappen', 'A', 5, 6, 5),
    ('LEUTE', 'Personen', 'A', 6, 2, 5),
    ('CENT', 'Hundertstel Euro', 'A', 6, 8, 4),
    ('KENNEN', 'wissen', 'A', 7, 1, 6),
    ('LAG', 'ruhte', 'A', 8, 7, 3),
    ('AMTS', 'im ... sein', 'A', 9, 1, 4),
    ('DEAL', 'Geschäft', 'A', 9, 8, 4),
    ('BAUERN', 'Landwirte', 'A', 10, 1, 6),
    ('OHNE', 'abzüglich', 'A', 10, 8, 4),
    ('ENTE', 'Wasservogel', 'A', 11, 1, 4),
    ('STRESS', 'Hektik', 'A', 11, 6, 6),
    ('EVENT', 'Ereignis', 'D', 1, 1, 5),
    ('KNABE', 'Junge', 'D', 7, 1, 5),
    ('RITUALE', 'Zeremonien', 'D', 1, 2, 7),
    ('MAN', 'jemand', 'D', 9, 2, 3),
    ('STARKEN', 'kräftigen', 'D', 1, 3, 7),
    ('TUT', 'macht', 'D', 9, 3, 3),
    ('TAG', '24 Stunden', 'D', 1, 4, 3),
    ('TUN', 'machen', 'D', 5, 4, 3),
    ('SEE', 'Gewässer', 'D', 9, 4, 3),
    ('TEE', 'Heißgetränk', 'D', 6, 5, 3),
    ('MANCHEN', 'einigen', 'D', 1, 6, 7),
    ('INS', 'in das', 'D', 9, 6, 3),
    ('ALS', 'da, während', 'D', 1, 8, 3),
    ('ECUADOR', 'Andenstaat', 'D', 5, 8, 7),
    ('LEISTE', 'Latte', 'D', 1, 9, 6),
    ('GEHE', 'laufe', 'D', 8, 9, 4),
    ('LINIEN', 'Striche', 'D', 1, 10, 6),
    ('ANS', 'an das', 'D', 9, 10, 3),
    ('ENDE', 'Schluss', 'D', 1, 11, 4),
    ('TOLLES', 'großartiges', 'D', 6, 11, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r175-12x12-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r175-12x12-03', 'Rätsel 175 · 12×12', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '12x12-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('SPART', 'legt zurück', 'A', 1, 1, 5),
    ('KRONE', 'Diadem', 'A', 1, 7, 5),
    ('ALKOHOL', 'Weingeist', 'A', 2, 1, 7),
    ('PUR', 'rein', 'A', 2, 9, 3),
    ('NETTE', 'freundliche', 'A', 3, 1, 5),
    ('ANS', 'an das', 'A', 3, 9, 3),
    ('DIE', 'Artikel (weibl.)', 'A', 4, 1, 3),
    ('KEIM', 'Erreger', 'A', 4, 5, 4),
    ('EID', 'Schwur', 'A', 5, 5, 3),
    ('FEE', 'Zauberin', 'A', 5, 9, 3),
    ('LEGE', 'platziere', 'A', 6, 1, 4),
    ('BESASS', 'hatte', 'A', 7, 5, 6),
    ('SEE', 'Gewässer', 'A', 8, 1, 3),
    ('EROSION', 'Abtragung', 'A', 8, 5, 7),
    ('ALIBI', 'Entlastung', 'A', 9, 1, 5),
    ('HELFE', 'unterstütze', 'A', 9, 7, 5),
    ('ABSAGEN', 'streichen', 'A', 10, 1, 7),
    ('BIT', 'Binärziffer', 'A', 10, 9, 3),
    ('LEERE', 'Vakuum', 'A', 11, 1, 5),
    ('BEAT', 'Rhythmus', 'A', 11, 8, 4),
    ('SAND', 'Wüstenboden', 'D', 1, 1, 4),
    ('SAAL', 'Halle', 'D', 8, 1, 4),
    ('PLEITE', 'Bankrott', 'D', 1, 2, 6),
    ('ELBE', 'Strom durch Dresden', 'D', 8, 2, 4),
    ('AKTE', 'Dokument', 'D', 1, 3, 4),
    ('GLEISE', 'Schienen', 'D', 6, 3, 6),
    ('ROT', 'purpurn', 'D', 1, 4, 3),
    ('BAR', 'Theke', 'D', 9, 4, 3),
    ('THEKE', 'Tresen', 'D', 1, 5, 5),
    ('BEIGE', 'sandfarben', 'D', 7, 5, 5),
    ('EIFER', 'Emsigkeit', 'D', 4, 6, 5),
    ('KLEID', 'Gewand', 'D', 1, 7, 5),
    ('SOHN', 'Nachkomme', 'D', 7, 7, 4),
    ('HASE', 'Meister Lampe', 'D', 6, 8, 4),
    ('OPA', 'Großvater', 'D', 1, 9, 3),
    ('SILBE', 'Wortteil', 'D', 7, 9, 5),
    ('NUN', 'jetzt', 'D', 1, 10, 3),
    ('SOFIA', 'bulg. Hauptstadt', 'D', 7, 10, 5),
    ('ERSTEM', 'beim ... Mal', 'D', 1, 11, 6),
    ('NETT', 'freundlich', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r176-12x12-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r176-12x12-04', 'Rätsel 176 · 12×12', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '12x12-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ETHISCHE', 'moralische', 'A', 1, 1, 8),
    ('CREDO', 'Leitsatz', 'A', 2, 1, 5),
    ('ALS', 'da, während', 'A', 2, 7, 3),
    ('KAMEN', 'nahten', 'A', 3, 1, 5),
    ('TIPPS', 'Ratschläge', 'A', 3, 7, 5),
    ('ENDEN', 'aufhören', 'A', 4, 1, 5),
    ('TORE', 'Treffer', 'A', 4, 8, 4),
    ('NIEDEREN', 'unteren', 'A', 5, 4, 8),
    ('EID', 'Schwur', 'A', 6, 9, 3),
    ('PUB', 'Kneipe', 'A', 7, 2, 3),
    ('SEINS', 'Sinn des ...', 'A', 7, 6, 5),
    ('BREI', 'Mus', 'A', 8, 1, 4),
    ('OHR', 'Hörorgan', 'A', 8, 6, 3),
    ('EIGNER', 'Besitzer', 'A', 9, 1, 6),
    ('RATE', 'Teilzahlung', 'A', 9, 8, 4),
    ('TOT', 'leblos', 'A', 10, 1, 3),
    ('EBEN', 'flach', 'A', 10, 8, 4),
    ('TREU', 'loyal', 'A', 11, 1, 4),
    ('ERNTEN', 'Lesen', 'A', 11, 6, 6),
    ('ECKE', 'Winkel', 'D', 1, 1, 4),
    ('BETT', 'Schlafstätte', 'D', 8, 1, 4),
    ('TRANK', 'schluckte', 'D', 1, 2, 5),
    ('PRIOR', 'Klosteroberer', 'D', 7, 2, 5),
    ('HEMD', 'Oberteil', 'D', 1, 3, 4),
    ('FUEGTE', 'setzte', 'D', 6, 3, 6),
    ('IDEEN', 'Einfälle', 'D', 1, 4, 5),
    ('BIN', 'existiere', 'D', 7, 4, 3),
    ('SONNIG', 'heiter', 'D', 1, 5, 6),
    ('SORTE', 'Art', 'D', 7, 6, 5),
    ('HAT', 'besitzt', 'D', 1, 7, 3),
    ('DREH', 'Kniff', 'D', 5, 7, 4),
    ('ELITE', 'Auslese', 'D', 1, 8, 5),
    ('IRREN', 'sich täuschen', 'D', 7, 8, 5),
    ('SPOREN', 'Keimzellen', 'D', 2, 9, 6),
    ('ABT', 'Klosterchef', 'D', 9, 9, 3),
    ('PREIS', 'Tarif', 'D', 3, 10, 5),
    ('TEE', 'Heißgetränk', 'D', 9, 10, 3),
    ('RASEND', 'wütend', 'D', 1, 11, 6),
    ('WENN', 'falls', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r177-13x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r177-13x13-01', 'Rätsel 177 · 13×13', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '13x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('UND', 'sowie', 'A', 1, 1, 3),
    ('ALT', 'betagt', 'A', 1, 5, 3),
    ('WEIL', 'da', 'A', 1, 9, 4),
    ('HAAR', 'Strähne', 'A', 2, 1, 4),
    ('ERKER', 'Vorbau', 'A', 2, 6, 5),
    ('RESERVE', 'Rücklage', 'A', 3, 1, 7),
    ('GLAS', 'Trinkgefäß', 'A', 3, 9, 4),
    ('HUETE', 'Kappen', 'A', 4, 4, 5),
    ('ALS', 'da, während', 'A', 5, 1, 3),
    ('FLEXIBEL', 'biegsam', 'A', 5, 5, 8),
    ('SIEHT', 'erblickt', 'A', 6, 1, 5),
    ('NAHT', 'kommt näher', 'A', 6, 7, 4),
    ('ICH', 'Pronomen (1. Sg.)', 'A', 7, 1, 3),
    ('KREIS', 'Zirkel', 'A', 7, 8, 5),
    ('EHER', 'lieber', 'A', 8, 1, 4),
    ('ROTE', 'purpurne', 'A', 8, 6, 4),
    ('RUHE', 'Stille', 'A', 9, 9, 4),
    ('BESTENS', 'hervorragend', 'A', 10, 2, 7),
    ('TAL', 'Senke', 'A', 10, 10, 3),
    ('SEITEN', 'Flanken', 'A', 11, 1, 6),
    ('ALB', 'Gebirge', 'A', 11, 10, 3),
    ('IDEEN', 'Einfälle', 'A', 12, 2, 5),
    ('ECHTE', 'authentische', 'A', 12, 8, 5),
    ('UHR', 'Zeitmesser', 'D', 1, 1, 3),
    ('ASIEN', 'Erdteil', 'D', 5, 1, 5),
    ('NAEMLICH', 'und zwar', 'D', 1, 2, 8),
    ('BEI', 'nahe an', 'D', 10, 2, 3),
    ('DAS', 'Artikel (sächl.)', 'D', 1, 3, 3),
    ('SEHE', 'erblicke', 'D', 5, 3, 4),
    ('EID', 'Schwur', 'D', 10, 3, 3),
    ('REH', 'Waldtier', 'D', 2, 4, 3),
    ('RESTE', 'Überbleibsel', 'D', 8, 4, 5),
    ('RUFT', 'schreit', 'D', 3, 5, 4),
    ('TEE', 'Heißgetränk', 'D', 10, 5, 3),
    ('LEVEL', 'Stufe', 'D', 1, 6, 5),
    ('BRUENN', 'Brno', 'D', 7, 6, 6),
    ('TRETEN', 'kicken', 'D', 1, 7, 6),
    ('EXAKT', 'genau', 'D', 4, 8, 5),
    ('SIE', 'Anrede', 'D', 10, 8, 3),
    ('WEG', 'Pfad', 'D', 1, 9, 3),
    ('IHRER', 'seiner', 'D', 5, 9, 5),
    ('ERLEBTE', 'erfuhr', 'D', 1, 10, 7),
    ('UTAH', 'Mormonenstaat', 'D', 9, 10, 4),
    ('INHALT', 'Füllung', 'D', 7, 11, 6),
    ('LAS', 'schmökerte', 'D', 1, 12, 3),
    ('LOS', 'frei', 'D', 5, 12, 3),
    ('ELBE', 'Strom durch Dresden', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r178-13x13-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r178-13x13-02', 'Rätsel 178 · 13×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '13x13-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('TROTZDEM', 'dennoch', 'A', 1, 1, 8),
    ('TAL', 'Senke', 'A', 1, 10, 3),
    ('RAUEN', 'groben', 'A', 2, 3, 5),
    ('AERA', 'Epoche', 'A', 2, 9, 4),
    ('GERADE', 'eben', 'A', 3, 3, 6),
    ('SIE', 'Anrede', 'A', 3, 10, 3),
    ('BEAT', 'Rhythmus', 'A', 4, 1, 4),
    ('LERNTEN', 'paukten', 'A', 4, 6, 7),
    ('OHNE', 'abzüglich', 'A', 5, 1, 4),
    ('ETWA', 'ungefähr', 'A', 5, 6, 4),
    ('LEERER', 'hohler', 'A', 6, 1, 6),
    ('ACH', 'Ausruf', 'A', 6, 8, 3),
    ('ERHEBT', 'erhöht', 'A', 7, 7, 6),
    ('MEIN', 'Possessiv (ich)', 'A', 8, 3, 4),
    ('ZWANGEN', 'nötigten', 'A', 9, 1, 7),
    ('ESEL', 'Grautier', 'A', 9, 9, 4),
    ('WINKEN', 'grüßen', 'A', 10, 1, 6),
    ('WISSE', 'kenne', 'A', 10, 8, 5),
    ('ERKENNT', 'bemerkt', 'A', 11, 1, 7),
    ('LESE', 'schmökere', 'A', 11, 9, 4),
    ('IDOL', 'Vorbild', 'A', 12, 1, 4),
    ('JENER', 'selbiger', 'A', 12, 8, 5),
    ('TOMBOLA', 'Verlosung', 'D', 1, 1, 7),
    ('ZWEI', 'Zahl (1+1)', 'D', 9, 1, 4),
    ('EHE', 'Bund fürs Leben', 'D', 4, 2, 3),
    ('WIRD', 'entsteht', 'D', 9, 2, 4),
    ('ORGANE', 'Eingeweide', 'D', 1, 3, 6),
    ('MANKO', 'Mangel', 'D', 8, 3, 5),
    ('TAETER', 'Verbrecher', 'D', 1, 4, 6),
    ('ENKEL', 'Kindeskind', 'D', 8, 4, 5),
    ('ZUR', 'zu der', 'D', 1, 5, 3),
    ('EWIGEN', 'endlosen', 'D', 6, 5, 6),
    ('DEALER', 'Händler', 'D', 1, 6, 6),
    ('NENNT', 'bezeichnet', 'D', 8, 6, 5),
    ('ENDET', 'hört auf', 'D', 1, 7, 5),
    ('ERWARB', 'kaufte', 'D', 3, 8, 6),
    ('NACH', 'hinter', 'D', 4, 9, 4),
    ('EILE', 'Hast', 'D', 9, 9, 4),
    ('TEST', 'Prüfung', 'D', 1, 10, 4),
    ('HEISSEN', 'nennen sich', 'D', 6, 10, 7),
    ('ARIE', 'Sologesang', 'D', 1, 11, 4),
    ('ESSE', 'speise', 'D', 9, 11, 4),
    ('LAENGST', 'seit jeher', 'D', 1, 12, 7),
    ('LEER', 'hohl', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r179-13x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r179-13x13-03', 'Rätsel 179 · 13×13', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '13x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('UEBT', 'trainiert', 'A', 1, 1, 4),
    ('WOG', 'schaukelte', 'A', 1, 6, 3),
    ('APP', 'Anwendung', 'A', 1, 10, 3),
    ('NIE', 'nimmer', 'A', 2, 1, 3),
    ('LABELS', 'Etiketten', 'A', 2, 5, 6),
    ('DESWEGEN', 'daher', 'A', 3, 1, 8),
    ('PRO', 'je', 'A', 3, 10, 3),
    ('REISEN', 'Fahrten', 'A', 4, 2, 6),
    ('CHOR', 'Singgruppe', 'A', 4, 9, 4),
    ('SEEN', 'Gewässer', 'A', 5, 3, 4),
    ('ALT', 'betagt', 'A', 5, 10, 3),
    ('INS', 'in das', 'A', 6, 1, 3),
    ('STAELLE', 'Viehhäuser', 'A', 6, 6, 7),
    ('TUERE', 'Pforte', 'A', 7, 1, 5),
    ('ERBTE', 'übernahm', 'A', 7, 7, 5),
    ('URNE', 'Aschengefäß', 'A', 8, 1, 4),
    ('ERDE', 'Welt', 'A', 8, 6, 4),
    ('MINUTE', '60 Sekunden', 'A', 9, 7, 6),
    ('TRAT', 'schritt', 'A', 10, 1, 4),
    ('BIN', 'existiere', 'A', 10, 6, 3),
    ('MIR', 'Dat. (1. Pers.)', 'A', 10, 10, 3),
    ('EINEM', 'unbest. Art. (Dat.)', 'A', 11, 1, 5),
    ('NASSEN', 'feuchten', 'A', 11, 7, 6),
    ('ROST', 'Grill', 'A', 12, 1, 4),
    ('OEL', 'Schmierstoff', 'A', 12, 6, 3),
    ('OFT', 'häufig', 'A', 12, 10, 3),
    ('UND', 'sowie', 'D', 1, 1, 3),
    ('MITUNTER', 'manchmal', 'D', 5, 1, 8),
    ('EIER', 'Gelege', 'D', 1, 2, 4),
    ('NUR', 'lediglich', 'D', 6, 2, 3),
    ('RIO', 'Stadt in Brasilien', 'D', 10, 2, 3),
    ('BESESSEN', 'gehabt', 'D', 1, 3, 8),
    ('ANS', 'an das', 'D', 10, 3, 3),
    ('WIE', 'gleich', 'D', 3, 4, 3),
    ('REITET', 'trabt', 'D', 7, 4, 6),
    ('LESE', 'schmökere', 'D', 2, 5, 4),
    ('WAGENS', 'Lenker des ...', 'D', 1, 6, 6),
    ('OBEN', 'in der Höhe', 'D', 1, 7, 4),
    ('TERMINE', 'Treffen', 'D', 6, 7, 7),
    ('GEN', 'nach', 'D', 1, 8, 3),
    ('KARDINAL', 'Kirchenfürst', 'D', 5, 8, 8),
    ('EBEN', 'flach', 'D', 6, 9, 4),
    ('ASPHALT', 'Straßenbelag', 'D', 1, 10, 7),
    ('UMSO', 'desto', 'D', 9, 10, 4),
    ('ROLLE', 'Walze', 'D', 3, 11, 5),
    ('TIEF', 'abgründig', 'D', 9, 11, 4),
    ('PFORTE', 'Tor', 'D', 1, 12, 6),
    ('LERNT', 'paukt', 'D', 8, 12, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r180-15x15-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r180-15x15-01', 'Rätsel 180 · 15×15', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '15x15-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('LEGE', 'platziere', 'A', 1, 1, 4),
    ('UHR', 'Zeitmesser', 'A', 1, 6, 3),
    ('GRUND', 'Ursache', 'A', 1, 10, 5),
    ('ALABAMA', 'Südstaat', 'A', 2, 1, 7),
    ('HOHN', 'Spott', 'A', 2, 9, 4),
    ('EILE', 'Hast', 'A', 3, 1, 4),
    ('HIT', 'Schlager', 'A', 3, 6, 3),
    ('LEISE', 'gedämpft', 'A', 3, 10, 5),
    ('STANDE', 'im ...', 'A', 4, 1, 6),
    ('FISCH', 'Wassertier', 'A', 4, 10, 5),
    ('SEX', 'Erotik', 'A', 5, 1, 3),
    ('ERBTE', 'übernahm', 'A', 5, 5, 5),
    ('WAS', 'Fragewort (Sache)', 'A', 6, 12, 3),
    ('GEHWEG', 'Bürgersteig', 'A', 7, 2, 6),
    ('KLAERT', 'löst', 'A', 7, 9, 6),
    ('RAN', 'heran', 'A', 8, 1, 3),
    ('EISENACH', 'Bachs Geburtsort', 'A', 8, 5, 8),
    ('BIS', 'nicht später als', 'A', 9, 4, 3),
    ('ICH', 'Pronomen (1. Sg.)', 'A', 9, 9, 3),
    ('STALL', 'Viehhaus', 'A', 10, 1, 5),
    ('ZAEH', 'hartnäckig', 'A', 10, 7, 4),
    ('PERU', 'Andenstaat', 'A', 11, 1, 4),
    ('BERN', 'Schweizer Hauptstadt', 'A', 11, 6, 4),
    ('GABE', 'Geschenk', 'A', 11, 11, 4),
    ('ANGEBAUT', 'kultiviert', 'A', 12, 1, 8),
    ('AUTOS', 'Wagen', 'A', 12, 10, 5),
    ('SIEGE', 'Triumphe', 'A', 13, 4, 5),
    ('STETS', 'immer', 'A', 13, 10, 5),
    ('TYP', 'Kerl', 'A', 14, 1, 3),
    ('TRENDS', 'Moden', 'A', 14, 5, 6),
    ('SEE', 'Gewässer', 'A', 14, 12, 3),
    ('LAESST', 'erlaubt', 'D', 1, 1, 6),
    ('SPALT', 'Ritze', 'D', 10, 1, 5),
    ('ELITE', 'Auslese', 'D', 1, 2, 5),
    ('GATTEN', 'Ehemänner', 'D', 7, 2, 6),
    ('GALAXIEN', 'Sternsysteme', 'D', 1, 3, 8),
    ('ARG', 'schlimm', 'D', 10, 3, 3),
    ('EBEN', 'flach', 'D', 1, 4, 4),
    ('BLUES', 'Musikstil', 'D', 9, 4, 5),
    ('DERWEIL', 'inzwischen', 'D', 4, 5, 7),
    ('BIT', 'Binärziffer', 'D', 12, 5, 3),
    ('UMHER', 'herum', 'D', 1, 6, 5),
    ('EIS', 'Gefrorenes', 'D', 7, 6, 3),
    ('BAER', 'Petz', 'D', 11, 6, 4),
    ('HAI', 'Raubfisch', 'D', 1, 7, 3),
    ('BUGS', 'Fehler', 'D', 5, 7, 4),
    ('ZEUGE', 'Beobachter', 'D', 10, 7, 5),
    ('TOT', 'leblos', 'D', 3, 8, 3),
    ('ARTEN', 'Sorten', 'D', 10, 8, 5),
    ('KNIEN', 'auf den ...', 'D', 7, 9, 5),
    ('GOLF', 'Meeresbucht', 'D', 1, 10, 4),
    ('FLACH', 'eben', 'D', 6, 10, 5),
    ('ASS', 'speiste', 'D', 12, 10, 3),
    ('RHEIN', 'dt. Strom', 'D', 1, 11, 5),
    ('ACH', 'Ausruf', 'D', 7, 11, 3),
    ('GUT', 'prima', 'D', 11, 11, 3),
    ('UNIS', 'Hochschulen', 'D', 1, 12, 4),
    ('WEH', 'schmerzhaft', 'D', 6, 12, 3),
    ('RATES', 'Mitglied des ...', 'D', 10, 12, 5),
    ('SCHAR', 'Gruppe', 'D', 3, 13, 5),
    ('BOTE', 'Kurier', 'D', 11, 13, 4),
    ('DREH', 'Kniff', 'D', 1, 14, 4),
    ('STUR', 'starrsinnig', 'D', 6, 14, 4),
    ('ESSE', 'speise', 'D', 11, 14, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r181-15x15-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r181-15x15-02', 'Rätsel 181 · 15×15', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '15x15-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('STROH', 'Halme', 'A', 1, 1, 5),
    ('ESSAY', 'Aufsatz', 'A', 1, 10, 5),
    ('AUE', 'Talwiese', 'A', 2, 1, 3),
    ('UMSO', 'desto', 'A', 2, 5, 4),
    ('DIEBE', 'Langfinger', 'A', 2, 10, 5),
    ('REIZE', 'Verlockungen', 'A', 3, 1, 5),
    ('ATHLETEN', 'Sportler', 'A', 3, 7, 8),
    ('FATALE', 'unheilvolle', 'A', 4, 3, 6),
    ('HELD', 'Recke', 'A', 5, 4, 4),
    ('ENDE', 'Schluss', 'A', 5, 9, 4),
    ('HELL', 'licht', 'A', 6, 1, 4),
    ('LOK', 'Zugmaschine', 'A', 6, 6, 3),
    ('EBBE', 'Gegenteil der Flut', 'A', 6, 11, 4),
    ('UNI', 'Hochschule', 'A', 7, 1, 3),
    ('FREUE', 'juble', 'A', 7, 10, 5),
    ('NIE', 'nimmer', 'A', 8, 1, 3),
    ('ZUZUG', 'Zuwanderung', 'A', 8, 5, 5),
    ('ENG', 'schmal', 'A', 8, 11, 3),
    ('DABEI', 'hierbei', 'A', 9, 1, 5),
    ('MEHR', 'zusätzlich', 'A', 9, 8, 4),
    ('LEGE', 'platziere', 'A', 10, 4, 4),
    ('VOR', 'ehe', 'A', 10, 12, 3),
    ('AUFGEBEN', 'kapitulieren', 'A', 11, 2, 8),
    ('WIRD', 'entsteht', 'A', 11, 11, 4),
    ('AUF', 'offen', 'A', 12, 1, 3),
    ('EHE', 'Bund fürs Leben', 'A', 12, 5, 3),
    ('ALTE', 'betagte', 'A', 12, 11, 4),
    ('STELLEN', 'setzen', 'A', 13, 1, 7),
    ('ROLLEN', 'Walzen', 'A', 13, 9, 6),
    ('TOR', 'Treffer', 'A', 14, 1, 3),
    ('EIS', 'Gefrorenes', 'A', 14, 7, 3),
    ('DASS', 'Konjunktion', 'A', 14, 11, 4),
    ('SARG', 'Totenschrein', 'D', 1, 1, 4),
    ('HUNDE', 'Vierbeiner', 'D', 6, 1, 5),
    ('AST', 'Zweig', 'D', 12, 1, 3),
    ('TUE', 'mache', 'D', 1, 2, 3),
    ('KENIA', 'Staat in Ostafrika', 'D', 5, 2, 5),
    ('AUTO', 'Pkw', 'D', 11, 2, 4),
    ('REIF', 'erntefertig', 'D', 1, 3, 4),
    ('LIEB', 'nett', 'D', 6, 3, 4),
    ('UFER', 'Gestade', 'D', 11, 3, 4),
    ('ZAHL', 'Ziffer', 'D', 3, 4, 4),
    ('ELF', 'Zahl (10+1)', 'D', 9, 4, 3),
    ('HUETE', 'Kappen', 'D', 1, 5, 5),
    ('ZIEGELN', 'Backsteinen', 'D', 8, 5, 7),
    ('ALLZU', 'übermäßig', 'D', 4, 6, 5),
    ('GEHE', 'laufe', 'D', 10, 6, 4),
    ('SALDO', 'Kontostand', 'D', 2, 7, 5),
    ('EBENE', 'Fläche', 'D', 10, 7, 5),
    ('TOTE', 'Verstorbene', 'D', 1, 8, 4),
    ('KAUM', 'schwerlich', 'D', 6, 8, 4),
    ('GEGNERS', 'Tor des ...', 'D', 8, 9, 7),
    ('EDLEN', 'vornehmen', 'D', 1, 10, 5),
    ('SIE', 'Anrede', 'D', 1, 11, 3),
    ('DERER', 'jener', 'D', 5, 11, 5),
    ('WALD', 'Forst', 'D', 11, 11, 4),
    ('SET', 'Satz', 'D', 1, 12, 3),
    ('EBEN', 'flach', 'D', 5, 12, 4),
    ('VILLA', 'Landhaus', 'D', 10, 12, 5),
    ('ABER', 'jedoch', 'D', 1, 13, 4),
    ('BUG', 'Vorderschiff', 'D', 6, 13, 3),
    ('ORTES', 'Name des ...', 'D', 10, 13, 5),
    ('YEN', 'Währung Japans', 'D', 1, 14, 3),
    ('SEE', 'Gewässer', 'D', 5, 14, 3),
    ('ORDENS', 'Mitglied des ...', 'D', 9, 14, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r182-15x15-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r182-15x15-03', 'Rätsel 182 · 15×15', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '15x15-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('HEMMT', 'bremst', 'A', 1, 1, 5),
    ('KASTELLS', 'Mauern des ...', 'A', 1, 7, 8),
    ('OHIO', 'Staat um Cleveland', 'A', 2, 1, 4),
    ('WERT', 'Bedeutung', 'A', 2, 6, 4),
    ('HELD', 'Recke', 'A', 3, 1, 4),
    ('ARME', 'Mittellose', 'A', 3, 6, 4),
    ('ETWA', 'ungefähr', 'A', 3, 11, 4),
    ('ENDETEN', 'hörten auf', 'A', 4, 1, 7),
    ('EIN', 'unbest. Artikel', 'A', 4, 12, 3),
    ('HIRN', 'Verstand', 'A', 5, 11, 4),
    ('NEIN', 'Ablehnung', 'A', 6, 1, 4),
    ('MIT', 'samt', 'A', 6, 6, 3),
    ('ZUCKT', 'zittert', 'A', 6, 10, 5),
    ('ERHEBEN', 'erhöhen', 'A', 7, 1, 7),
    ('MUEHE', 'Anstrengung', 'A', 7, 9, 5),
    ('UHR', 'Zeitmesser', 'A', 8, 1, 3),
    ('ERSPART', 'vermieden', 'A', 8, 5, 7),
    ('TABU', 'verboten', 'A', 9, 11, 4),
    ('MEILE', 'Längenmaß', 'A', 10, 1, 5),
    ('WAR', 'existierte', 'A', 10, 7, 3),
    ('EDLE', 'vornehme', 'A', 10, 11, 4),
    ('ULM', 'Münsterstadt', 'A', 11, 1, 3),
    ('GERUCH', 'Duft', 'A', 11, 5, 6),
    ('VON', 'ab, aus', 'A', 11, 12, 3),
    ('STAAT', 'Nation', 'A', 12, 1, 5),
    ('ACH', 'Ausruf', 'A', 12, 7, 3),
    ('GENF', 'Stadt am Léman', 'A', 12, 11, 4),
    ('GLEICHE', 'identische', 'A', 13, 3, 7),
    ('UND', 'sowie', 'A', 13, 11, 3),
    ('KOELN', 'Domstadt', 'A', 14, 1, 5),
    ('NETTES', 'freundliches', 'A', 14, 9, 6),
    ('HOHE', 'große', 'D', 1, 1, 4),
    ('NEU', 'frisch', 'D', 6, 1, 3),
    ('MUSIK', 'Tonkunst', 'D', 10, 1, 5),
    ('EHEN', 'Bündnisse', 'D', 1, 2, 4),
    ('ERHIELT', 'bekam', 'D', 6, 2, 7),
    ('MILD', 'sanft', 'D', 1, 3, 4),
    ('IHR', 'Pronomen (2. Pl.)', 'D', 6, 3, 3),
    ('IMAGE', 'Ansehen', 'D', 10, 3, 5),
    ('MODERNE', 'zeitgemäße', 'D', 1, 4, 7),
    ('ALL', 'Weltraum', 'D', 12, 4, 3),
    ('BELEGTEN', 'bewiesen', 'D', 7, 5, 8),
    ('WAERMER', 'lauer', 'D', 2, 6, 7),
    ('KERN', 'Mittelpunkt', 'D', 1, 7, 4),
    ('INS', 'in das', 'D', 6, 7, 3),
    ('WRACK', 'Trümmer', 'D', 10, 7, 5),
    ('ARM', 'Gliedmaße', 'D', 1, 8, 3),
    ('AUCH', 'ebenfalls', 'D', 10, 8, 4),
    ('STEG', 'Brücklein', 'D', 1, 9, 4),
    ('MAERCHEN', 'Fabel', 'D', 7, 9, 8),
    ('ZUR', 'zu der', 'D', 6, 10, 3),
    ('EHE', 'Bund fürs Leben', 'D', 1, 11, 3),
    ('HUETTE', 'Kate', 'D', 5, 11, 6),
    ('GUT', 'prima', 'D', 12, 11, 3),
    ('TEICH', 'Weiher', 'D', 3, 12, 5),
    ('ADVENT', 'Vorweihnacht', 'D', 9, 12, 6),
    ('WIRKE', 'scheine', 'D', 3, 13, 5),
    ('BLONDE', 'hellhaarige', 'D', 9, 13, 6),
    ('SPANNT', 'strafft', 'D', 1, 14, 6),
    ('FUENF', 'Zahl (10:2)', 'D', 8, 14, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

commit;
-- Automatisch erzeugt von tools/generator/generate_raetsel.py – nicht von Hand bearbeiten.
-- Voraussetzung: Migrationen, gitter_vorlagen.sql, woerter_seed.sql, fragen_varianten_seed.sql eingespielt.
-- Idempotent über raetsel.slug. Rätsel mit Prüfhinweisen werden als Entwurf angelegt.

begin;

-- r183-8x8-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r183-8x8-01', 'Rätsel 183 · 8×8', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '8x8-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('LEER', 'hohl', 'A', 1, 1, 4),
    ('ANLAGE', 'Einrichtung', 'A', 2, 1, 6),
    ('SOFERN', 'falls', 'A', 3, 1, 6),
    ('TAGE', 'je 24 Stunden', 'A', 4, 4, 4),
    ('OMA', 'Großmutter', 'A', 5, 1, 3),
    ('BEI', 'nahe an', 'A', 5, 5, 3),
    ('STERN', 'Gestirn', 'A', 6, 3, 5),
    ('TAT', 'Handlung', 'A', 7, 1, 3),
    ('SEE', 'Gewässer', 'A', 7, 5, 3),
    ('LAS', 'schmökerte', 'D', 1, 1, 3),
    ('ORT', 'Stelle', 'D', 5, 1, 3),
    ('ENORM', 'gewaltig', 'D', 1, 2, 5),
    ('ELF', 'Zahl (10+1)', 'D', 1, 3, 3),
    ('AST', 'Zweig', 'D', 5, 3, 3),
    ('RAET', 'empfiehlt', 'D', 1, 4, 4),
    ('GRABES', 'Stille des ...', 'D', 2, 5, 6),
    ('ENGERE', 'schmalere', 'D', 2, 6, 6),
    ('EINE', 'unbest. Artikel (w.)', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r184-8x8-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r184-8x8-02', 'Rätsel 184 · 8×8', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '8x8-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('WIRD', 'entsteht', 'A', 1, 4, 4),
    ('PARIS', 'Seine-Stadt', 'A', 2, 1, 5),
    ('AGENT', 'Spion', 'A', 3, 1, 5),
    ('NETZ', 'Geflecht', 'A', 4, 1, 4),
    ('TEILT', 'trennt', 'A', 5, 3, 5),
    ('ERNTE', 'Lese', 'A', 6, 3, 5),
    ('WAR', 'existierte', 'A', 7, 1, 3),
    ('SEE', 'Gewässer', 'A', 7, 5, 3),
    ('PANKOW', 'Berliner Bezirk', 'D', 2, 1, 6),
    ('LAGE', 'Position', 'D', 1, 2, 4),
    ('RETTER', 'Erlöser', 'D', 2, 3, 6),
    ('WINZER', 'Weinbauer', 'D', 1, 4, 6),
    ('IST', 'befindet sich', 'D', 1, 5, 3),
    ('INS', 'in das', 'D', 5, 5, 3),
    ('ALTE', 'betagte', 'D', 4, 6, 4),
    ('DAR', 'stellt ... (zeigt)', 'D', 1, 7, 3),
    ('TEE', 'Heißgetränk', 'D', 5, 7, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r185-8x8-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r185-8x8-03', 'Rätsel 185 · 8×8', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '8x8-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('KAPSEL', 'Hülse', 'A', 1, 1, 6),
    ('BUEROS', 'Kanzleien', 'A', 2, 2, 6),
    ('STREBE', 'trachte', 'A', 3, 1, 6),
    ('NAHT', 'kommt näher', 'A', 4, 4, 4),
    ('HOB', 'stemmte', 'A', 5, 1, 3),
    ('UNI', 'Hochschule', 'A', 5, 5, 3),
    ('NEU', 'frisch', 'A', 6, 1, 3),
    ('TEE', 'Heißgetränk', 'A', 6, 5, 3),
    ('ELBE', 'Strom durch Dresden', 'A', 7, 1, 4),
    ('SAHNE', 'Rahm', 'D', 3, 1, 5),
    ('ABT', 'Klosterchef', 'D', 1, 2, 3),
    ('OEL', 'Schmierstoff', 'D', 5, 2, 3),
    ('PUR', 'rein', 'D', 1, 3, 3),
    ('BUB', 'Knabe', 'D', 5, 3, 3),
    ('SEEN', 'Gewässer', 'D', 1, 4, 4),
    ('ERBAUT', 'errichtet', 'D', 1, 5, 6),
    ('LOEHNE', 'Gehälter', 'D', 1, 6, 6),
    ('TIER', 'Lebewesen', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r186-9x9-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r186-9x9-01', 'Rätsel 186 · 9×9', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '9x9-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('EGAL', 'gleichgültig', 'A', 1, 1, 4),
    ('UNS', 'Akk./Dat. von wir', 'A', 1, 6, 3),
    ('IRRE', 'Verrückte', 'A', 2, 1, 4),
    ('MIT', 'samt', 'A', 2, 6, 3),
    ('NAME', 'Bezeichnung', 'A', 3, 1, 4),
    ('SEI', 'existiere', 'A', 3, 6, 3),
    ('TUER', 'Pforte', 'A', 4, 1, 4),
    ('WAHL', 'Abstimmung', 'A', 5, 5, 4),
    ('ANTEILE', 'Aktien', 'A', 6, 1, 7),
    ('FUEHRTE', 'leitete', 'A', 7, 1, 7),
    ('REEDER', 'Schiffsherr', 'A', 8, 2, 6),
    ('EINTRAF', 'ankam', 'D', 1, 1, 7),
    ('GRAU', 'farblos', 'D', 1, 2, 4),
    ('NUR', 'lediglich', 'D', 6, 2, 3),
    ('ARME', 'Mittellose', 'D', 1, 3, 4),
    ('TEE', 'Heißgetränk', 'D', 6, 3, 3),
    ('LEER', 'hohl', 'D', 1, 4, 4),
    ('EHE', 'Bund fürs Leben', 'D', 6, 4, 3),
    ('WIRD', 'entsteht', 'D', 5, 5, 4),
    ('UMS', 'um das', 'D', 1, 6, 3),
    ('ALTE', 'betagte', 'D', 5, 6, 4),
    ('NIE', 'nimmer', 'D', 1, 7, 3),
    ('HEER', 'Armee', 'D', 5, 7, 4),
    ('STILL', 'ruhig', 'D', 1, 8, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r187-9x9-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r187-9x9-02', 'Rätsel 187 · 9×9', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '9x9-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('URNE', 'Aschengefäß', 'A', 1, 1, 4),
    ('WAR', 'existierte', 'A', 1, 6, 3),
    ('NAEHE', 'Umgebung', 'A', 2, 1, 5),
    ('STUETZE', 'Hilfe', 'A', 3, 1, 7),
    ('WIRD', 'entsteht', 'A', 4, 5, 4),
    ('HEIMAT', 'Vaterland', 'A', 5, 1, 6),
    ('AURA', 'Ausstrahlung', 'A', 6, 1, 4),
    ('ABT', 'Klosterchef', 'A', 6, 6, 3),
    ('SEIT', 'ab', 'A', 7, 1, 4),
    ('TEE', 'Heißgetränk', 'A', 7, 6, 3),
    ('ERST', 'zunächst', 'A', 8, 1, 4),
    ('EIN', 'unbest. Artikel', 'A', 8, 6, 3),
    ('UNS', 'Akk./Dat. von wir', 'D', 1, 1, 3),
    ('HASE', 'Meister Lampe', 'D', 5, 1, 4),
    ('RAT', 'Tipp', 'D', 1, 2, 3),
    ('EUER', 'Possessiv (ihr)', 'D', 5, 2, 4),
    ('NEU', 'frisch', 'D', 1, 3, 3),
    ('IRIS', 'Schwertlilie', 'D', 5, 3, 4),
    ('EHE', 'Bund fürs Leben', 'D', 1, 4, 3),
    ('MATT', 'Schachende', 'D', 5, 4, 4),
    ('ETWA', 'ungefähr', 'D', 2, 5, 4),
    ('ZITATE', 'Aussprüche', 'D', 3, 6, 6),
    ('ABER', 'jedoch', 'D', 1, 7, 4),
    ('BEI', 'nahe an', 'D', 6, 7, 3),
    ('DATEN', 'Angaben', 'D', 4, 8, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r188-9x9-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r188-9x9-03', 'Rätsel 188 · 9×9', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '9x9-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('HING', 'baumelte', 'A', 1, 1, 4),
    ('AKT', 'Aufzug', 'A', 1, 6, 3),
    ('ARIE', 'Sologesang', 'A', 2, 1, 4),
    ('GAU', 'Landstrich', 'A', 2, 6, 3),
    ('BREI', 'Mus', 'A', 3, 1, 4),
    ('EIN', 'unbest. Artikel', 'A', 3, 6, 3),
    ('GANS', 'Federvieh', 'A', 4, 4, 4),
    ('WELTEN', 'Planeten', 'A', 5, 3, 6),
    ('HEU', 'Trockengras', 'A', 6, 1, 3),
    ('PURE', 'reine', 'A', 6, 5, 4),
    ('IHR', 'Pronomen (2. Pl.)', 'A', 7, 1, 3),
    ('ERST', 'zunächst', 'A', 7, 5, 4),
    ('OEFEN', 'Herde', 'A', 8, 1, 5),
    ('HAB', '... und Gut', 'D', 1, 1, 3),
    ('OHIO', 'Staat um Cleveland', 'D', 5, 1, 4),
    ('IRRT', 'täuscht sich', 'D', 1, 2, 4),
    ('EHE', 'Bund fürs Leben', 'D', 6, 2, 3),
    ('NIE', 'nimmer', 'D', 1, 3, 3),
    ('WURF', 'Schleudern', 'D', 5, 3, 4),
    ('GEIGE', 'Violine', 'D', 1, 4, 5),
    ('ALPEN', 'Hochgebirge', 'D', 4, 5, 5),
    ('AGENTUR', 'Vermittlung', 'D', 1, 6, 7),
    ('KAISERS', 'Bart des ...', 'D', 1, 7, 7),
    ('TUN', 'machen', 'D', 1, 8, 3),
    ('NETT', 'freundlich', 'D', 5, 8, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r189-9x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r189-9x13-01', 'Rätsel 189 · 9×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('SAGA', 'Heldensage', 'A', 1, 1, 4),
    ('STREBTE', 'trachtete', 'A', 1, 6, 7),
    ('ALLE', 'sämtliche', 'A', 2, 1, 4),
    ('ASIEN', 'Erdteil', 'A', 2, 8, 5),
    ('ALASKA', 'Staat am Yukon', 'A', 3, 1, 6),
    ('ESSIG', 'Würzmittel', 'A', 3, 8, 5),
    ('STAEDTE', 'Kommunen', 'A', 4, 3, 7),
    ('ENTE', 'Wasservogel', 'A', 5, 4, 4),
    ('ZUM', 'zu dem', 'A', 6, 1, 3),
    ('TEST', 'Prüfung', 'A', 6, 5, 4),
    ('UND', 'sowie', 'A', 6, 10, 3),
    ('UNI', 'Hochschule', 'A', 7, 1, 3),
    ('ORTE', 'Plätze', 'A', 7, 5, 4),
    ('SIE', 'Anrede', 'A', 7, 10, 3),
    ('RITEN', 'Bräuche', 'A', 8, 1, 5),
    ('OEFTER', 'häufiger', 'A', 8, 7, 6),
    ('SAAT', 'Samen', 'D', 1, 1, 4),
    ('ZUR', 'zu der', 'D', 6, 1, 3),
    ('ALL', 'Weltraum', 'D', 1, 2, 3),
    ('JUNI', '6. Monat', 'D', 5, 2, 4),
    ('GLAS', 'Trinkgefäß', 'D', 1, 3, 4),
    ('MIT', 'samt', 'D', 6, 3, 3),
    ('AESTE', 'Zweige', 'D', 1, 4, 5),
    ('KANTON', 'Schweizer Gliedstaat', 'D', 3, 5, 6),
    ('SPAETER', 'danach', 'D', 1, 6, 7),
    ('DESTO', 'umso', 'D', 4, 7, 5),
    ('RAET', 'empfiehlt', 'D', 1, 8, 4),
    ('TEE', 'Heißgetränk', 'D', 6, 8, 3),
    ('ESSE', 'speise', 'D', 1, 9, 4),
    ('BIS', 'nicht später als', 'D', 1, 10, 3),
    ('LUST', 'Verlangen', 'D', 5, 10, 4),
    ('TEIL', 'Stück', 'D', 1, 11, 4),
    ('NIE', 'nimmer', 'D', 6, 11, 3),
    ('ENG', 'schmal', 'D', 1, 12, 3),
    ('ODER', 'bzw.', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r190-9x13-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r190-9x13-02', 'Rätsel 190 · 9×13', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '9x13-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('WAR', 'existierte', 'A', 1, 1, 3),
    ('MAG', 'liebt', 'A', 1, 6, 3),
    ('SEE', 'Gewässer', 'A', 1, 10, 3),
    ('AUE', 'Talwiese', 'A', 2, 1, 3),
    ('GUTE', 'prima', 'A', 2, 5, 4),
    ('INS', 'in das', 'A', 2, 10, 3),
    ('STIL', 'Machart', 'A', 3, 1, 4),
    ('SOLANGE', 'während', 'A', 3, 6, 7),
    ('SOFA', 'Couch', 'A', 4, 1, 4),
    ('EMDEN', 'ostfries. Stadt', 'A', 4, 6, 5),
    ('NEUE', 'frische', 'A', 5, 4, 4),
    ('RUNDUM', 'völlig', 'A', 6, 1, 6),
    ('STAAT', 'Nation', 'A', 6, 8, 5),
    ('HIER', 'an diesem Ort', 'A', 7, 2, 4),
    ('ZIELTE', 'visierte', 'A', 7, 7, 6),
    ('TRESOR', 'Safe', 'A', 8, 1, 6),
    ('ERSTE', 'anfängliche', 'A', 8, 8, 5),
    ('WASSER', 'H2O', 'D', 1, 1, 6),
    ('AUTO', 'Pkw', 'D', 1, 2, 4),
    ('UHR', 'Zeitmesser', 'D', 6, 2, 3),
    ('REIF', 'erntefertig', 'D', 1, 3, 4),
    ('NIE', 'nimmer', 'D', 6, 3, 3),
    ('LANDES', 'Mitte des ...', 'D', 3, 4, 6),
    ('EURO', 'Währung', 'D', 5, 5, 4),
    ('MUSEUM', 'Galerie', 'D', 1, 6, 6),
    ('ATOME', 'Teilchen', 'D', 1, 7, 5),
    ('GELD', 'Moneten', 'D', 1, 8, 4),
    ('SIE', 'Anrede', 'D', 6, 8, 3),
    ('AELTER', 'betagter', 'D', 3, 9, 6),
    ('SINN', 'Bedeutung', 'D', 1, 10, 4),
    ('ALS', 'da, während', 'D', 6, 10, 3),
    ('ENG', 'schmal', 'D', 1, 11, 3),
    ('WATT', 'Schlickküste', 'D', 5, 11, 4),
    ('ESEL', 'Grautier', 'D', 1, 12, 4),
    ('TEE', 'Heißgetränk', 'D', 6, 12, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r191-9x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r191-9x13-03', 'Rätsel 191 · 9×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '9x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('OASE', 'Wüsteninsel', 'A', 1, 1, 4),
    ('GASTHOF', 'Wirtshaus', 'A', 1, 6, 7),
    ('HUERDE', 'Hindernis', 'A', 2, 1, 6),
    ('TEUFE', 'Tiefe (Bergbau)', 'A', 2, 8, 5),
    ('REIZEN', 'locken', 'A', 3, 1, 6),
    ('UEBTE', 'trainierte', 'A', 3, 8, 5),
    ('VIER', 'Zahl (2×2)', 'A', 4, 5, 4),
    ('GIER', 'Habsucht', 'A', 5, 4, 4),
    ('HABE', 'besitze', 'A', 5, 9, 4),
    ('RATES', 'Mitglied des ...', 'A', 6, 1, 5),
    ('BEIRUT', 'libanes. Hauptstadt', 'A', 6, 7, 6),
    ('IKONE', 'Heiligenbild', 'A', 7, 1, 5),
    ('RIGA', 'lett. Hauptstadt', 'A', 7, 9, 4),
    ('STRENGE', 'rigorose', 'A', 8, 1, 7),
    ('NEST', 'Horst', 'A', 8, 9, 4),
    ('OHR', 'Hörorgan', 'D', 1, 1, 3),
    ('IRIS', 'Schwertlilie', 'D', 5, 1, 4),
    ('AUE', 'Talwiese', 'D', 1, 2, 3),
    ('AKT', 'Aufzug', 'D', 6, 2, 3),
    ('SEIL', 'Tau', 'D', 1, 3, 4),
    ('TOR', 'Treffer', 'D', 6, 3, 3),
    ('ERZ', 'Gestein', 'D', 1, 4, 3),
    ('GENE', 'Erbanlagen', 'D', 5, 4, 4),
    ('DEVISEN', 'Fremdwährung', 'D', 2, 5, 7),
    ('GENIE', 'Talent', 'D', 1, 6, 5),
    ('ERBTE', 'übernahm', 'D', 4, 7, 5),
    ('STUR', 'starrsinnig', 'D', 1, 8, 4),
    ('TEE', 'Heißgetränk', 'D', 1, 9, 3),
    ('HIRN', 'Verstand', 'D', 5, 9, 4),
    ('HUB', 'Hebung', 'D', 1, 10, 3),
    ('ARIE', 'Sologesang', 'D', 5, 10, 4),
    ('OFT', 'häufig', 'D', 1, 11, 3),
    ('BUGS', 'Fehler', 'D', 5, 11, 4),
    ('FEE', 'Zauberin', 'D', 1, 12, 3),
    ('ETAT', 'Budget', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r192-10x10-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r192-10x10-01', 'Rätsel 192 · 10×10', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '10x10-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('PRO', 'je', 'A', 1, 1, 3),
    ('BREI', 'Mus', 'A', 1, 6, 4),
    ('RAMPE', 'Auffahrt', 'A', 2, 1, 5),
    ('EIS', 'Gefrorenes', 'A', 2, 7, 3),
    ('ABER', 'jedoch', 'A', 3, 1, 4),
    ('AHNT', 'vermutet', 'A', 3, 6, 4),
    ('GENOSS', 'kostete aus', 'A', 4, 1, 6),
    ('PISTEN', 'Abfahrten', 'A', 5, 4, 6),
    ('SIEHE', 'vgl.', 'A', 6, 1, 5),
    ('RIO', 'Stadt in Brasilien', 'A', 6, 7, 3),
    ('ARIE', 'Sologesang', 'A', 7, 1, 4),
    ('WELT', 'Erde', 'A', 7, 6, 4),
    ('GALT', 'zählte', 'A', 8, 1, 4),
    ('ENTE', 'Wasservogel', 'A', 8, 6, 4),
    ('AKT', 'Aufzug', 'A', 9, 1, 3),
    ('EMDEN', 'ostfries. Stadt', 'A', 9, 5, 5),
    ('PRAG', 'Moldau-Stadt', 'D', 1, 1, 4),
    ('SAGA', 'Heldensage', 'D', 6, 1, 4),
    ('RABE', 'Krähenvogel', 'D', 1, 2, 4),
    ('IRAK', 'Land am Tigris', 'D', 6, 2, 4),
    ('OMEN', 'Vorzeichen', 'D', 1, 3, 4),
    ('EILT', 'hastet', 'D', 6, 3, 4),
    ('PROPHET', 'Seher', 'D', 2, 4, 7),
    ('SIE', 'Anrede', 'D', 4, 5, 3),
    ('ASS', 'speiste', 'D', 3, 6, 3),
    ('WEM', 'Fragewort (Dativ)', 'D', 7, 6, 3),
    ('REH', 'Waldtier', 'D', 1, 7, 3),
    ('TREND', 'Tendenz', 'D', 5, 7, 5),
    ('EIN', 'unbest. Artikel', 'D', 1, 8, 3),
    ('EILTE', 'hastete', 'D', 5, 8, 5),
    ('IST', 'befindet sich', 'D', 1, 9, 3),
    ('NOTEN', 'Zensuren', 'D', 5, 9, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r193-10x10-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r193-10x10-02', 'Rätsel 193 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ANS', 'an das', 'A', 1, 1, 3),
    ('WARST', 'du ... dort', 'A', 1, 5, 5),
    ('BUERO', 'Kanzlei', 'A', 2, 1, 5),
    ('OPA', 'Großvater', 'A', 2, 7, 3),
    ('TRIEB', 'schwamm', 'A', 3, 1, 5),
    ('TON', 'Klang', 'A', 3, 7, 3),
    ('GESETZ', 'Vorschrift', 'A', 4, 4, 6),
    ('HEKTIK', 'Hast', 'A', 5, 1, 6),
    ('EIN', 'unbest. Artikel', 'A', 6, 1, 3),
    ('ARGE', 'schlimme', 'A', 6, 6, 4),
    ('UNI', 'Hochschule', 'A', 7, 1, 3),
    ('ALIAS', 'auch genannt', 'A', 7, 5, 5),
    ('TEE', 'Heißgetränk', 'A', 8, 1, 3),
    ('SAELE', 'Hallen', 'A', 8, 5, 5),
    ('ERNST', 'Seriosität', 'A', 9, 1, 5),
    ('TAL', 'Senke', 'A', 9, 7, 3),
    ('ABT', 'Klosterchef', 'D', 1, 1, 3),
    ('HEUTE', 'jetzt', 'D', 5, 1, 5),
    ('NUR', 'lediglich', 'D', 1, 2, 3),
    ('EINER', 'unbest. Art. (w.)', 'D', 5, 2, 5),
    ('SEI', 'existiere', 'D', 1, 3, 3),
    ('KNIEN', 'auf den ...', 'D', 5, 3, 5),
    ('REGT', 'bewegt', 'D', 2, 4, 4),
    ('WOBEI', 'während', 'D', 1, 5, 5),
    ('AST', 'Zweig', 'D', 7, 5, 3),
    ('SKALA', 'Stufenleiter', 'D', 4, 6, 5),
    ('ROTE', 'purpurne', 'D', 1, 7, 4),
    ('RIET', 'empfahl', 'D', 6, 7, 4),
    ('SPOT', 'Werbeclip', 'D', 1, 8, 4),
    ('GALA', 'Festabend', 'D', 6, 8, 4),
    ('TANZ', 'Ball', 'D', 1, 9, 4),
    ('ESEL', 'Grautier', 'D', 6, 9, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r194-10x10-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r194-10x10-03', 'Rätsel 194 · 10×10', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '10x10-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('PHASE', 'Abschnitt', 'A', 1, 1, 5),
    ('WEG', 'Pfad', 'A', 1, 7, 3),
    ('AULA', 'Festsaal', 'A', 2, 1, 4),
    ('EHE', 'Bund fürs Leben', 'A', 2, 7, 3),
    ('SEIN', 'existieren', 'A', 3, 1, 4),
    ('WIEN', 'österr. Hauptstadt', 'A', 3, 6, 4),
    ('STAFFELN', 'Serienteile', 'A', 4, 1, 8),
    ('TESTEN', 'prüfen', 'A', 5, 1, 6),
    ('EINMAL', 'früher', 'A', 6, 4, 6),
    ('SEINE', 'ihre', 'A', 7, 1, 5),
    ('ULM', 'Münsterstadt', 'A', 7, 7, 3),
    ('EIN', 'unbest. Artikel', 'A', 8, 1, 3),
    ('RENTE', 'Pension', 'A', 8, 5, 5),
    ('ISST', 'speist', 'A', 9, 1, 4),
    ('DER', 'Artikel (männl.)', 'A', 9, 7, 3),
    ('PASST', 'sitzt', 'D', 1, 1, 5),
    ('SEI', 'existiere', 'D', 7, 1, 3),
    ('HUETE', 'Kappen', 'D', 1, 2, 5),
    ('EIS', 'Gefrorenes', 'D', 7, 2, 3),
    ('ALIAS', 'auch genannt', 'D', 1, 3, 5),
    ('INS', 'in das', 'D', 7, 3, 3),
    ('SANFTEN', 'milden', 'D', 1, 4, 7),
    ('FEIER', 'Fest', 'D', 4, 5, 5),
    ('WENN', 'falls', 'D', 3, 6, 4),
    ('WEIL', 'da', 'D', 1, 7, 4),
    ('MUND', 'Maul', 'D', 6, 7, 4),
    ('EHEN', 'Bündnisse', 'D', 1, 8, 4),
    ('ALTE', 'betagte', 'D', 6, 8, 4),
    ('GEN', 'nach', 'D', 1, 9, 3),
    ('ULMER', '... Münster', 'D', 5, 9, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r195-10x10-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r195-10x10-04', 'Rätsel 195 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('PLAN', 'Absicht', 'A', 1, 1, 4),
    ('ZEIT', 'Dauer', 'A', 1, 6, 4),
    ('OEL', 'Schmierstoff', 'A', 2, 1, 3),
    ('HYMNE', 'Lobgesang', 'A', 2, 5, 5),
    ('LEID', 'Kummer', 'A', 3, 1, 4),
    ('KANU', 'Paddelboot', 'A', 3, 6, 4),
    ('ERBE', 'Nachlass', 'A', 4, 1, 4),
    ('LIEF', 'rannte', 'A', 4, 6, 4),
    ('EINZELNE', 'separate', 'A', 5, 2, 8),
    ('VON', 'ab, aus', 'A', 6, 4, 3),
    ('UMWEG', 'Abstecher', 'A', 7, 1, 5),
    ('VIA', 'über', 'A', 7, 7, 3),
    ('PAARE', 'Duos', 'A', 8, 1, 5),
    ('OHR', 'Hörorgan', 'A', 8, 7, 3),
    ('EIS', 'Gefrorenes', 'A', 9, 1, 3),
    ('NIMMT', 'greift', 'A', 9, 5, 5),
    ('POLE', 'Slawe', 'D', 1, 1, 4),
    ('LUPE', 'Brennglas', 'D', 6, 1, 4),
    ('LEERE', 'Vakuum', 'D', 1, 2, 5),
    ('MAI', '5. Monat', 'D', 7, 2, 3),
    ('ALIBI', 'Entlastung', 'D', 1, 3, 5),
    ('WAS', 'Fragewort (Sache)', 'D', 7, 3, 3),
    ('DENVER', 'Stadt in Colorado', 'D', 3, 4, 6),
    ('ZOGEN', 'zerrten', 'D', 5, 5, 5),
    ('ZYKLEN', 'Kreisläufe', 'D', 1, 6, 6),
    ('EMAIL', 'elektr. Post', 'D', 1, 7, 5),
    ('VOM', 'von dem', 'D', 7, 7, 3),
    ('INNEN', 'intern', 'D', 1, 8, 5),
    ('IHM', 'Dativ von er', 'D', 7, 8, 3),
    ('TEUFE', 'Tiefe (Bergbau)', 'D', 1, 9, 5),
    ('ART', 'Sorte', 'D', 7, 9, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r196-11x11-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r196-11x11-01', 'Rätsel 196 · 11×11', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '11x11-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('BURG', 'Festung', 'A', 1, 1, 4),
    ('MAUER', 'Wand', 'A', 1, 6, 5),
    ('OMA', 'Großmutter', 'A', 2, 1, 3),
    ('NIE', 'nimmer', 'A', 2, 8, 3),
    ('THRONT', 'sitzt erhaben', 'A', 3, 1, 6),
    ('SEI', 'existiere', 'A', 3, 8, 3),
    ('KERN', 'Mittelpunkt', 'A', 4, 7, 4),
    ('BREAK', 'Pause', 'A', 5, 1, 5),
    ('URNE', 'Aschengefäß', 'A', 5, 7, 4),
    ('BLUME', 'Pflanze', 'A', 6, 3, 5),
    ('EHE', 'Bund fürs Leben', 'A', 7, 1, 3),
    ('HASST', 'verabscheut', 'A', 7, 5, 5),
    ('SONG', 'Lied', 'A', 8, 1, 4),
    ('STARK', 'kräftig', 'A', 8, 6, 5),
    ('ERDE', 'Welt', 'A', 9, 1, 4),
    ('KENIA', 'Staat in Ostafrika', 'A', 9, 6, 5),
    ('STANGE', 'Stab', 'A', 10, 1, 6),
    ('DOM', 'Kathedrale', 'A', 10, 8, 3),
    ('BOT', 'offerierte', 'D', 1, 1, 3),
    ('BOESES', 'gemeines', 'D', 5, 1, 6),
    ('UMHER', 'herum', 'D', 1, 2, 5),
    ('HORT', 'Schatz', 'D', 7, 2, 4),
    ('RAR', 'selten', 'D', 1, 3, 3),
    ('EBENDA', 'dort', 'D', 5, 3, 6),
    ('OVAL', 'eiförmig', 'D', 3, 4, 4),
    ('GEN', 'nach', 'D', 8, 4, 3),
    ('KUH', 'Rind', 'D', 5, 5, 3),
    ('MUT', 'Courage', 'D', 1, 6, 3),
    ('MASKE', 'Larve', 'D', 6, 6, 5),
    ('KUESTE', 'Gestade', 'D', 4, 7, 6),
    ('UNSER', 'Possessiv (wir)', 'D', 1, 8, 5),
    ('SAND', 'Wüstenboden', 'D', 7, 8, 4),
    ('EIERN', 'auf ... gehen', 'D', 1, 9, 5),
    ('TRIO', 'Dreiergruppe', 'D', 7, 9, 4),
    ('REINEN', 'puren', 'D', 1, 10, 6),
    ('KAM', 'nahte', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r197-11x11-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r197-11x11-02', 'Rätsel 197 · 11×11', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '11x11-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('EID', 'Schwur', 'A', 1, 1, 3),
    ('ABGASE', 'Emissionen', 'A', 1, 5, 6),
    ('URIN', 'Harn', 'A', 2, 1, 4),
    ('RAUEN', 'groben', 'A', 2, 6, 5),
    ('RAN', 'heran', 'A', 3, 1, 3),
    ('LASTET', 'drückt', 'A', 3, 5, 6),
    ('ENG', 'schmal', 'A', 4, 1, 3),
    ('ECHO', 'Widerhall', 'A', 5, 4, 4),
    ('KRACH', 'Lärm', 'A', 6, 1, 5),
    ('BAND', 'Musikgruppe', 'A', 6, 7, 4),
    ('SKELETTE', 'Gerippe', 'A', 7, 3, 8),
    ('ASS', 'speiste', 'A', 8, 1, 3),
    ('FIRMEN', 'Betriebe', 'A', 8, 5, 6),
    ('RIET', 'empfahl', 'A', 9, 1, 4),
    ('MEERE', 'Ozeane', 'A', 9, 6, 5),
    ('GEN', 'nach', 'A', 10, 1, 3),
    ('PANNEN', 'Defekte', 'A', 10, 5, 6),
    ('EURE', 'Possessiv (ihr)', 'D', 1, 1, 4),
    ('ARG', 'schlimm', 'D', 8, 1, 3),
    ('IRANER', 'Perser', 'D', 1, 2, 6),
    ('SIE', 'Anrede', 'D', 8, 2, 3),
    ('DING', 'Sache', 'D', 1, 3, 4),
    ('ASSEN', 'speisten', 'D', 6, 3, 5),
    ('ECK', 'Winkel', 'D', 5, 4, 3),
    ('CHEF', 'Boss', 'D', 5, 5, 4),
    ('BRACH', 'barst', 'D', 1, 6, 5),
    ('LIMA', 'peruan. Hauptstadt', 'D', 7, 6, 4),
    ('GAS', 'Brennstoff', 'D', 1, 7, 3),
    ('OBEREN', 'höher gelegenen', 'D', 5, 7, 6),
    ('AUTO', 'Pkw', 'D', 1, 8, 4),
    ('ATMEN', 'Luft holen', 'D', 6, 8, 5),
    ('SEE', 'Gewässer', 'D', 1, 9, 3),
    ('UNTERE', 'tiefere', 'D', 5, 9, 6),
    ('ENTE', 'Wasservogel', 'D', 1, 10, 4),
    ('DENEN', 'Relativ (Dat. Pl.)', 'D', 6, 10, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r198-11x11-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r198-11x11-03', 'Rätsel 198 · 11×11', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '11x11-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ARIE', 'Sologesang', 'A', 1, 1, 4),
    ('GANS', 'Federvieh', 'A', 1, 7, 4),
    ('BIS', 'nicht später als', 'A', 2, 1, 3),
    ('PARTIE', 'Spiel', 'A', 2, 5, 6),
    ('BOTE', 'Kurier', 'A', 3, 1, 4),
    ('KOMET', 'Schweifstern', 'A', 3, 6, 5),
    ('SAUBER', 'rein', 'A', 4, 4, 6),
    ('UMWELT', 'Natur', 'A', 5, 1, 6),
    ('TEE', 'Heißgetränk', 'A', 5, 8, 3),
    ('EILT', 'hastet', 'A', 6, 2, 4),
    ('MIR', 'Dat. (1. Pers.)', 'A', 7, 1, 3),
    ('EHE', 'Bund fürs Leben', 'A', 7, 5, 3),
    ('ALT', 'betagt', 'A', 8, 1, 3),
    ('SATZES', 'Ende des ...', 'A', 8, 5, 6),
    ('MEER', 'See', 'A', 9, 1, 4),
    ('STUTE', 'weibl. Pferd', 'A', 9, 6, 5),
    ('ANS', 'an das', 'A', 10, 1, 3),
    ('SORTE', 'Art', 'A', 10, 6, 5),
    ('ABBAU', 'Förderung', 'D', 1, 1, 5),
    ('MAMA', 'Mutti', 'D', 7, 1, 4),
    ('RIO', 'Stadt in Brasilien', 'D', 1, 2, 3),
    ('MEILEN', 'Längenmaße', 'D', 5, 2, 6),
    ('IST', 'befindet sich', 'D', 1, 3, 3),
    ('WIRTES', 'Gäste des ...', 'D', 5, 3, 6),
    ('ESEL', 'Grautier', 'D', 3, 4, 4),
    ('ALTES', 'betagtes', 'D', 4, 5, 5),
    ('AKUT', 'dringend', 'D', 2, 6, 4),
    ('HASS', 'Abscheu', 'D', 7, 6, 4),
    ('GROB', 'rau', 'D', 1, 7, 4),
    ('NETTO', 'ohne Steuern', 'D', 6, 7, 5),
    ('ATMET', 'holt Luft', 'D', 1, 8, 5),
    ('ZUR', 'zu der', 'D', 8, 8, 3),
    ('NIERE', 'Organ', 'D', 1, 9, 5),
    ('BETT', 'Schlafstätte', 'D', 7, 9, 4),
    ('SET', 'Satz', 'D', 1, 10, 3),
    ('SEE', 'Gewässer', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r199-12x12-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r199-12x12-01', 'Rätsel 199 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('SAH', 'erblickte', 'A', 1, 1, 3),
    ('BROT', 'Laib', 'A', 1, 8, 4),
    ('TRAUMA', 'Schock', 'A', 2, 1, 6),
    ('EUER', 'Possessiv (ihr)', 'A', 2, 8, 4),
    ('AMT', 'Behörde', 'A', 3, 1, 3),
    ('FEINDE', 'Gegner', 'A', 3, 6, 6),
    ('FINDET', 'entdeckt', 'A', 4, 6, 6),
    ('KOMETEN', 'Haarsterne', 'A', 5, 1, 7),
    ('MENUE', 'Speisenfolge', 'A', 6, 2, 5),
    ('KATAR', 'Golfstaat', 'A', 7, 1, 5),
    ('AREAL', 'Gelände', 'A', 7, 7, 5),
    ('ZUM', 'zu dem', 'A', 8, 3, 3),
    ('GINGE', 'liefe', 'A', 8, 7, 5),
    ('ENG', 'schmal', 'A', 9, 1, 3),
    ('SAENGER', 'Vokalist', 'A', 9, 5, 7),
    ('LEER', 'hohl', 'A', 10, 1, 4),
    ('UNGERN', 'widerwillig', 'A', 10, 6, 6),
    ('NUR', 'lediglich', 'A', 11, 1, 3),
    ('STERNE', 'Gestirne', 'A', 11, 6, 6),
    ('STARK', 'kräftig', 'D', 1, 1, 5),
    ('KOELN', 'Domstadt', 'D', 7, 1, 5),
    ('ARM', 'Gliedmaße', 'D', 1, 2, 3),
    ('OMA', 'Großmutter', 'D', 5, 2, 3),
    ('NEU', 'frisch', 'D', 9, 2, 3),
    ('HAT', 'besitzt', 'D', 1, 3, 3),
    ('METZGER', 'Fleischer', 'D', 5, 3, 7),
    ('GENAU', 'exakt', 'D', 4, 4, 5),
    ('TURMS', 'Spitze des ...', 'D', 5, 5, 5),
    ('KAFFEE', 'Mokka', 'D', 1, 6, 6),
    ('AUS', 'vorbei', 'D', 9, 6, 3),
    ('EIN', 'unbest. Artikel', 'D', 3, 7, 3),
    ('AGENT', 'Spion', 'D', 7, 7, 5),
    ('BEIN', 'Stelze', 'D', 1, 8, 4),
    ('BRINGE', 'liefere', 'D', 6, 8, 6),
    ('RUNDE', 'Durchgang', 'D', 1, 9, 5),
    ('ENGER', 'schmaler', 'D', 7, 9, 5),
    ('OEDE', 'langweilig', 'D', 1, 10, 4),
    ('LAGERN', 'Depots', 'D', 6, 10, 6),
    ('TRETE', 'kicke', 'D', 1, 11, 5),
    ('LERNE', 'pauke', 'D', 7, 11, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r200-12x12-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r200-12x12-02', 'Rätsel 200 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('GEBT', 'reicht', 'A', 1, 1, 4),
    ('GAGE', 'Honorar', 'A', 1, 8, 4),
    ('ARIE', 'Sologesang', 'A', 2, 1, 4),
    ('IRAKER', 'Mann aus Bagdad', 'A', 2, 6, 6),
    ('ELTERN', 'Vater und Mutter', 'A', 3, 1, 6),
    ('RUSS', 'Rauchstaub', 'A', 3, 8, 4),
    ('BAT', 'ersuchte', 'A', 4, 1, 3),
    ('TUT', 'macht', 'A', 4, 9, 3),
    ('EUER', 'Possessiv (ihr)', 'A', 5, 1, 4),
    ('GABEN', 'reichten', 'A', 5, 6, 5),
    ('BRAUT', 'Verlobte', 'A', 6, 2, 5),
    ('ENDE', 'Schluss', 'A', 6, 8, 4),
    ('STERNE', 'Gestirne', 'A', 7, 1, 6),
    ('RAT', 'Tipp', 'A', 8, 7, 3),
    ('LEBE', 'existiere', 'A', 9, 1, 4),
    ('NOTE', 'Zensur', 'A', 9, 8, 4),
    ('CHARTA', 'Urkunde', 'A', 10, 1, 6),
    ('KRAN', 'Hebezeug', 'A', 10, 8, 4),
    ('HERZ', 'Pumpe', 'A', 11, 1, 4),
    ('HOTELS', 'Herbergen', 'A', 11, 6, 6),
    ('GAEBE', 'reichte', 'D', 1, 1, 5),
    ('SOLCH', 'derartig', 'D', 7, 1, 5),
    ('ERLAUBT', 'gestattet', 'D', 1, 2, 7),
    ('EHE', 'Bund fürs Leben', 'D', 9, 2, 3),
    ('BITTERE', 'herbe', 'D', 1, 3, 7),
    ('BAR', 'Theke', 'D', 9, 3, 3),
    ('TEE', 'Heißgetränk', 'D', 1, 4, 3),
    ('RAR', 'selten', 'D', 5, 4, 3),
    ('ERZ', 'Gestein', 'D', 9, 4, 3),
    ('UNI', 'Hochschule', 'D', 6, 5, 3),
    ('EINIGTE', 'verständigte', 'D', 1, 6, 7),
    ('NAH', 'dicht', 'D', 9, 6, 3),
    ('GAR', 'durchgekocht', 'D', 1, 8, 3),
    ('BEDANKT', 'erkenntlich', 'D', 5, 8, 7),
    ('AKUTEN', 'dringenden', 'D', 1, 9, 6),
    ('TORE', 'Treffer', 'D', 8, 9, 4),
    ('GESUND', 'fit', 'D', 1, 10, 6),
    ('TAL', 'Senke', 'D', 9, 10, 3),
    ('ERST', 'zunächst', 'D', 1, 11, 4),
    ('EIGENS', 'extra', 'D', 6, 11, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r201-12x12-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r201-12x12-03', 'Rätsel 201 · 12×12', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '12x12-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('PARAT', 'bereit', 'A', 1, 1, 5),
    ('NARBE', 'Wundmal', 'A', 1, 7, 5),
    ('ANALOGE', 'ähnliche', 'A', 2, 1, 7),
    ('OEL', 'Schmierstoff', 'A', 2, 9, 3),
    ('PAUSE', 'Rast', 'A', 3, 1, 5),
    ('MIT', 'samt', 'A', 3, 9, 3),
    ('ALB', 'Gebirge', 'A', 4, 1, 3),
    ('NEST', 'Horst', 'A', 4, 5, 4),
    ('EIS', 'Gefrorenes', 'A', 5, 5, 3),
    ('KUR', 'Erholung', 'A', 5, 9, 3),
    ('IGEL', 'Stacheltier', 'A', 6, 1, 4),
    ('GEHEGE', 'Käfig', 'A', 7, 5, 6),
    ('IHR', 'Pronomen (2. Pl.)', 'A', 8, 1, 3),
    ('ALABAMA', 'Südstaat', 'A', 8, 5, 7),
    ('RAETE', 'Gremien', 'A', 9, 1, 5),
    ('HERDE', 'Schar', 'A', 9, 7, 5),
    ('ABGABEN', 'Steuern', 'A', 10, 1, 7),
    ('DER', 'Artikel (männl.)', 'A', 10, 9, 3),
    ('KETTE', 'Halsschmuck', 'A', 11, 1, 5),
    ('JENA', 'Saalestadt', 'A', 11, 8, 4),
    ('PAPA', 'Vater', 'D', 1, 1, 4),
    ('IRAK', 'Land am Tigris', 'D', 8, 1, 4),
    ('ANALOG', 'entsprechend', 'D', 1, 2, 6),
    ('HABE', 'besitze', 'D', 8, 2, 4),
    ('RAUB', 'Diebstahl', 'D', 1, 3, 4),
    ('ERREGT', 'nervös', 'D', 6, 3, 6),
    ('ALS', 'da, während', 'D', 1, 4, 3),
    ('TAT', 'Handlung', 'D', 9, 4, 3),
    ('TOENE', 'Klänge', 'D', 1, 5, 5),
    ('GAEBE', 'reichte', 'D', 7, 5, 5),
    ('EITEL', 'gefallsüchtig', 'D', 4, 6, 5),
    ('NEUSS', 'Stadt am Rhein', 'D', 1, 7, 5),
    ('HAHN', 'Gockel', 'D', 7, 7, 4),
    ('LEBE', 'existiere', 'D', 6, 8, 4),
    ('ROM', 'Ewige Stadt', 'D', 1, 9, 3),
    ('GARDE', 'Leibwache', 'D', 7, 9, 5),
    ('BEI', 'nahe an', 'D', 1, 10, 3),
    ('EMDEN', 'ostfries. Stadt', 'D', 7, 10, 5),
    ('ELTERN', 'Vater und Mutter', 'D', 1, 11, 6),
    ('AERA', 'Epoche', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r202-12x12-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r202-12x12-04', 'Rätsel 202 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ALBANIEN', 'Balkanstaat', 'A', 1, 1, 8),
    ('KAESE', 'Milchprodukt', 'A', 2, 1, 5),
    ('NEU', 'frisch', 'A', 2, 7, 3),
    ('TURIN', 'Stadt am Po', 'A', 3, 1, 5),
    ('GUNST', 'Wohlwollen', 'A', 3, 7, 5),
    ('ENGEN', 'schmalen', 'A', 4, 1, 5),
    ('EGAL', 'gleichgültig', 'A', 4, 8, 4),
    ('NEUTRALE', 'objektive', 'A', 5, 4, 8),
    ('RAR', 'selten', 'A', 6, 9, 3),
    ('NAH', 'dicht', 'A', 7, 2, 3),
    ('WARNT', 'mahnt', 'A', 7, 6, 5),
    ('OASE', 'Wüsteninsel', 'A', 8, 1, 4),
    ('OMA', 'Großmutter', 'A', 8, 6, 3),
    ('BESUCH', 'Visite', 'A', 9, 1, 6),
    ('STAU', 'Blechlawine', 'A', 9, 8, 4),
    ('EHE', 'Bund fürs Leben', 'A', 10, 1, 3),
    ('SOLO', 'allein', 'A', 10, 8, 4),
    ('NERV', 'Reizleiter', 'A', 11, 1, 4),
    ('EVENTS', 'Anlässe', 'A', 11, 6, 6),
    ('AKTE', 'Dokument', 'D', 1, 1, 4),
    ('OBEN', 'in der Höhe', 'D', 8, 1, 4),
    ('LAUNE', 'Stimmung', 'D', 1, 2, 5),
    ('NAEHE', 'Umgebung', 'D', 7, 2, 5),
    ('BERG', 'Gipfel', 'D', 1, 3, 4),
    ('WASSER', 'H2O', 'D', 6, 3, 6),
    ('ASIEN', 'Erdteil', 'D', 1, 4, 5),
    ('HEU', 'Trockengras', 'D', 7, 4, 3),
    ('NENNER', 'Divisor', 'D', 1, 5, 6),
    ('WOHNE', 'lebe', 'D', 7, 6, 5),
    ('ENG', 'schmal', 'D', 1, 7, 3),
    ('TEAM', 'Mannschaft', 'D', 5, 7, 4),
    ('NEUER', 'frischer', 'D', 1, 8, 5),
    ('RASSE', 'Zuchtlinie', 'D', 7, 8, 5),
    ('UNGARN', 'Magyaren', 'D', 2, 9, 6),
    ('TON', 'Klang', 'D', 9, 9, 3),
    ('SALAT', 'Rohkost', 'D', 3, 10, 5),
    ('ALT', 'betagt', 'D', 9, 10, 3),
    ('BUTLER', 'Diener', 'D', 1, 11, 6),
    ('DUOS', 'Paare', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r203-13x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r203-13x13-01', 'Rätsel 203 · 13×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '13x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('WAR', 'existierte', 'A', 1, 1, 3),
    ('OFT', 'häufig', 'A', 1, 5, 3),
    ('SEIN', 'existieren', 'A', 1, 9, 4),
    ('EGAL', 'gleichgültig', 'A', 2, 1, 4),
    ('ERKER', 'Vorbau', 'A', 2, 6, 5),
    ('GITARRE', 'Klampfe', 'A', 3, 1, 7),
    ('EBEN', 'flach', 'A', 3, 9, 4),
    ('GENUG', 'ausreichend', 'A', 4, 4, 5),
    ('ART', 'Sorte', 'A', 5, 1, 3),
    ('SEELEUTE', 'Matrosen', 'A', 5, 5, 8),
    ('STEHT', 'stockt', 'A', 6, 1, 5),
    ('NEUE', 'frische', 'A', 6, 7, 4),
    ('SEI', 'existiere', 'A', 7, 1, 3),
    ('IRREN', 'sich täuschen', 'A', 7, 8, 5),
    ('ENGE', 'schmale', 'A', 8, 1, 4),
    ('LOSE', 'locker', 'A', 8, 6, 4),
    ('RANG', 'Stellung', 'A', 9, 9, 4),
    ('MADONNA', 'Muttergottes', 'A', 10, 2, 7),
    ('EHE', 'Bund fürs Leben', 'A', 10, 10, 3),
    ('DAUERT', 'währt', 'A', 11, 1, 6),
    ('REH', 'Waldtier', 'A', 11, 10, 3),
    ('NETTE', 'freundliche', 'A', 12, 2, 5),
    ('START', 'Beginn', 'A', 12, 8, 5),
    ('WEG', 'Pfad', 'D', 1, 1, 3),
    ('ASSEN', 'speisten', 'D', 5, 1, 5),
    ('AGIERTEN', 'handelten', 'D', 1, 2, 8),
    ('MAN', 'jemand', 'D', 10, 2, 3),
    ('RAT', 'Tipp', 'D', 1, 3, 3),
    ('TEIG', 'Masse', 'D', 5, 3, 4),
    ('AUE', 'Talwiese', 'D', 10, 3, 3),
    ('LAG', 'ruhte', 'D', 2, 4, 3),
    ('ENDET', 'hört auf', 'D', 8, 4, 5),
    ('REST', 'Überbleibsel', 'D', 3, 5, 4),
    ('ORT', 'Stelle', 'D', 10, 5, 3),
    ('FERNE', 'Weite', 'D', 1, 6, 5),
    ('PLANTE', 'entwarf', 'D', 7, 6, 6),
    ('TREUEN', 'loyalen', 'D', 1, 7, 6),
    ('GLEIS', 'Schiene', 'D', 4, 8, 5),
    ('AUS', 'vorbei', 'D', 10, 8, 3),
    ('SEE', 'Gewässer', 'D', 1, 9, 3),
    ('EURER', 'Possessiv (ihr)', 'D', 5, 9, 5),
    ('ERBAUER', 'Konstrukteur', 'D', 1, 10, 7),
    ('AERA', 'Epoche', 'D', 9, 10, 4),
    ('EINHER', '... gehen', 'D', 7, 11, 6),
    ('NUN', 'jetzt', 'D', 1, 12, 3),
    ('EIN', 'unbest. Artikel', 'D', 5, 12, 3),
    ('GEHT', 'läuft', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r204-13x13-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r204-13x13-02', 'Rätsel 204 · 13×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '13x13-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('SKANDALE', 'Affären', 'A', 1, 1, 8),
    ('WEH', 'schmerzhaft', 'A', 1, 10, 3),
    ('BEIDE', 'alle zwei', 'A', 2, 3, 5),
    ('VITA', 'Lebenslauf', 'A', 2, 9, 4),
    ('KURVEN', 'Biegungen', 'A', 3, 3, 6),
    ('LAG', 'ruhte', 'A', 3, 10, 3),
    ('EHEN', 'Bündnisse', 'A', 4, 1, 4),
    ('EREILTE', 'traf', 'A', 4, 6, 7),
    ('NAHT', 'kommt näher', 'A', 5, 1, 4),
    ('NEUN', 'Zahl (3×3)', 'A', 5, 6, 4),
    ('DIREKT', 'unmittelbar', 'A', 6, 1, 6),
    ('ENG', 'schmal', 'A', 6, 8, 3),
    ('PREISE', 'Tarife', 'A', 7, 7, 6),
    ('GRAS', 'Rasen', 'A', 8, 3, 4),
    ('THEORIE', 'Lehre', 'A', 9, 1, 7),
    ('OSLO', 'norw. Hauptstadt', 'A', 9, 9, 4),
    ('RASTEN', 'ruhen', 'A', 10, 1, 6),
    ('RASER', 'Temposünder', 'A', 10, 8, 5),
    ('INTERNE', 'innere', 'A', 11, 1, 7),
    ('SEIT', 'ab', 'A', 11, 9, 4),
    ('ODER', 'bzw.', 'A', 12, 1, 4),
    ('WENDE', 'Umschwung', 'A', 12, 8, 5),
    ('STAENDE', 'Buden', 'D', 1, 1, 7),
    ('TRIO', 'Dreiergruppe', 'D', 9, 1, 4),
    ('HAI', 'Raubfisch', 'D', 4, 2, 3),
    ('HAND', 'Greiforgan', 'D', 9, 2, 4),
    ('ABKEHR', 'Abwendung', 'D', 1, 3, 6),
    ('GESTE', 'Gebärde', 'D', 8, 3, 5),
    ('NEUNTE', 'nach der achten', 'D', 1, 4, 6),
    ('ROTER', 'purpurner', 'D', 8, 4, 5),
    ('DIR', 'Dat. (2. Pers.)', 'D', 1, 5, 3),
    ('KLARER', 'deutlicher', 'D', 6, 5, 6),
    ('ADVENT', 'Vorweihnacht', 'D', 1, 6, 6),
    ('SINNE', 'im ... von', 'D', 8, 6, 5),
    ('LEERE', 'Vakuum', 'D', 1, 7, 5),
    ('NEUERE', 'Jüngere', 'D', 3, 8, 6),
    ('INNE', '... halten', 'D', 4, 9, 4),
    ('OASE', 'Wüsteninsel', 'D', 9, 9, 4),
    ('WILL', 'möchte', 'D', 1, 10, 4),
    ('GIESSEN', 'Lahnstadt', 'D', 6, 10, 7),
    ('ETAT', 'Budget', 'D', 1, 11, 4),
    ('LEID', 'Kummer', 'D', 9, 11, 4),
    ('HAGELTE', 'prasselte', 'D', 1, 12, 7),
    ('ORTE', 'Plätze', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r205-13x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r205-13x13-03', 'Rätsel 205 · 13×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '13x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ZEUG', 'Kram', 'A', 1, 1, 4),
    ('SEI', 'existiere', 'A', 1, 6, 3),
    ('PRO', 'je', 'A', 1, 10, 3),
    ('UHR', 'Zeitmesser', 'A', 2, 1, 3),
    ('BONNER', 'Rheinländer', 'A', 2, 5, 6),
    ('RESSORTS', 'Bereiche', 'A', 3, 1, 8),
    ('UND', 'sowie', 'A', 3, 10, 3),
    ('RAENGE', 'Tribünen', 'A', 4, 2, 6),
    ('SEIN', 'existieren', 'A', 4, 9, 4),
    ('CENT', 'Hundertstel Euro', 'A', 5, 3, 4),
    ('FEE', 'Zauberin', 'A', 5, 10, 3),
    ('NAH', 'dicht', 'A', 6, 1, 3),
    ('EROBERN', 'einnehmen', 'A', 6, 6, 7),
    ('TUERE', 'Pforte', 'A', 7, 1, 5),
    ('EBENE', 'Fläche', 'A', 7, 7, 5),
    ('GENE', 'Erbanlagen', 'A', 8, 1, 4),
    ('AKUT', 'dringend', 'A', 8, 6, 4),
    ('OSTERN', 'christl. Fest', 'A', 9, 7, 6),
    ('GRAS', 'Rasen', 'A', 10, 1, 4),
    ('ORT', 'Stelle', 'A', 10, 6, 3),
    ('WOG', 'schaukelte', 'A', 10, 10, 3),
    ('EILTE', 'hastete', 'A', 11, 1, 5),
    ('DEVISE', 'Motto', 'A', 11, 7, 6),
    ('NOTE', 'Zensur', 'A', 12, 1, 4),
    ('YEN', 'Währung Japans', 'A', 12, 6, 3),
    ('GAR', 'durchgekocht', 'A', 12, 10, 3),
    ('ZUR', 'zu der', 'D', 1, 1, 3),
    ('ENTGEGEN', 'wider', 'D', 5, 1, 8),
    ('EHER', 'lieber', 'D', 1, 2, 4),
    ('AUE', 'Talwiese', 'D', 6, 2, 3),
    ('RIO', 'Stadt in Brasilien', 'D', 10, 2, 3),
    ('URSACHEN', 'Gründe', 'D', 1, 3, 8),
    ('ALT', 'betagt', 'D', 10, 3, 3),
    ('SEE', 'Gewässer', 'D', 3, 4, 3),
    ('REISTE', 'fuhr', 'D', 7, 4, 6),
    ('BONN', 'Ex-Hauptstadt', 'D', 2, 5, 4),
    ('SORGTE', 'kümmerte sich', 'D', 1, 6, 6),
    ('ENTE', 'Wasservogel', 'D', 1, 7, 4),
    ('REKORDE', 'Höchstwerte', 'D', 6, 7, 7),
    ('INS', 'in das', 'D', 1, 8, 3),
    ('ROBUSTEN', 'stabilen', 'D', 5, 8, 8),
    ('BETT', 'Schlafstätte', 'D', 6, 9, 4),
    ('PRUEFEN', 'testen', 'D', 1, 10, 7),
    ('EWIG', 'endlos', 'D', 9, 10, 4),
    ('NIERE', 'Organ', 'D', 3, 11, 5),
    ('ROSA', 'Pink', 'D', 9, 11, 4),
    ('ORDNEN', 'sortieren', 'D', 1, 12, 6),
    ('ENGER', 'schmaler', 'D', 8, 12, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r206-15x15-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r206-15x15-01', 'Rätsel 206 · 15×15', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '15x15-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AFFE', 'Primat', 'A', 1, 1, 4),
    ('OPA', 'Großvater', 'A', 1, 6, 3),
    ('GRAMM', 'Tausendstel Kilo', 'A', 1, 10, 5),
    ('BAUHERR', 'Auftraggeber', 'A', 2, 1, 7),
    ('TRAT', 'schritt', 'A', 2, 9, 4),
    ('FUER', 'zugunsten', 'A', 3, 1, 4),
    ('TOR', 'Treffer', 'A', 3, 6, 3),
    ('ADELS', 'Titel des ...', 'A', 3, 10, 5),
    ('UNTERE', 'tiefere', 'A', 4, 1, 6),
    ('DAMIT', 'hiermit', 'A', 4, 10, 5),
    ('HAT', 'besitzt', 'A', 5, 1, 3),
    ('UNION', 'Bündnis', 'A', 5, 5, 5),
    ('WIE', 'gleich', 'A', 6, 12, 3),
    ('GROSSE', 'riesige', 'A', 7, 2, 6),
    ('FRAUEN', 'Damen', 'A', 7, 9, 6),
    ('YEN', 'Währung Japans', 'A', 8, 1, 3),
    ('TENDIERT', 'neigt', 'A', 8, 5, 8),
    ('FEE', 'Zauberin', 'A', 9, 4, 3),
    ('GUT', 'prima', 'A', 9, 9, 3),
    ('DAVON', 'hiervon', 'A', 10, 1, 5),
    ('BRUT', 'Nachwuchs', 'A', 10, 7, 4),
    ('IDOL', 'Vorbild', 'A', 11, 1, 4),
    ('FAIR', 'gerecht', 'A', 11, 6, 4),
    ('TAGE', 'je 24 Stunden', 'A', 11, 11, 4),
    ('SEMINARS', 'Leiter des ...', 'A', 12, 1, 8),
    ('EUREN', 'Possessiv (ihr)', 'A', 12, 10, 5),
    ('EINES', 'unbest. Art. (Gen.)', 'A', 13, 4, 5),
    ('RENNT', 'läuft', 'A', 13, 10, 5),
    ('ORT', 'Stelle', 'A', 14, 1, 3),
    ('ESSENZ', 'Kern', 'A', 14, 5, 6),
    ('TEE', 'Heißgetränk', 'A', 14, 12, 3),
    ('ABFUHR', 'Absage', 'D', 1, 1, 6),
    ('DISCO', 'Tanzlokal', 'D', 10, 1, 5),
    ('FAUNA', 'Tierwelt', 'D', 1, 2, 5),
    ('GERADE', 'eben', 'D', 7, 2, 6),
    ('FUETTERN', 'ernähren', 'D', 1, 3, 8),
    ('VOM', 'von dem', 'D', 10, 3, 3),
    ('EHRE', 'Würde', 'D', 1, 4, 4),
    ('FOLIE', 'Film', 'D', 9, 4, 5),
    ('RUESTEN', 'wappnen', 'D', 4, 5, 7),
    ('NIE', 'nimmer', 'D', 12, 5, 3),
    ('ORTEN', 'Stellen', 'D', 1, 6, 5),
    ('SEE', 'Gewässer', 'D', 7, 6, 3),
    ('FANS', 'Anhänger', 'D', 11, 6, 4),
    ('PRO', 'je', 'D', 1, 7, 3),
    ('IREN', 'Gälen', 'D', 5, 7, 4),
    ('BARES', '... Geld', 'D', 10, 7, 5),
    ('RIO', 'Stadt in Brasilien', 'D', 3, 8, 3),
    ('RISSE', 'Spalten', 'D', 10, 8, 5),
    ('FIGUR', 'Gestalt', 'D', 7, 9, 5),
    ('GRAD', 'Stufe', 'D', 1, 10, 4),
    ('FREUT', 'beglückt', 'D', 6, 10, 5),
    ('ERZ', 'Gestein', 'D', 12, 10, 3),
    ('RADAR', 'Ortungsgerät', 'D', 1, 11, 5),
    ('ART', 'Sorte', 'D', 7, 11, 3),
    ('TUE', 'mache', 'D', 11, 11, 3),
    ('ATEM', 'Luft', 'D', 1, 12, 4),
    ('WUT', 'Zorn', 'D', 6, 12, 3),
    ('WARNT', 'mahnt', 'D', 10, 12, 5),
    ('LINIE', 'Strich', 'D', 3, 13, 5),
    ('GENE', 'Erbanlagen', 'D', 11, 13, 4),
    ('MAST', 'Pfosten', 'D', 1, 14, 4),
    ('ENDE', 'Schluss', 'D', 6, 14, 4),
    ('ENTE', 'Wasservogel', 'D', 11, 14, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r207-15x15-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r207-15x15-02', 'Rätsel 207 · 15×15', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '15x15-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('TIPPS', 'Ratschläge', 'A', 1, 1, 5),
    ('CHILE', 'Andenstaat', 'A', 1, 10, 5),
    ('UHR', 'Zeitmesser', 'A', 2, 1, 3),
    ('COOL', 'lässig', 'A', 2, 5, 4),
    ('HASEN', 'Langohren', 'A', 2, 10, 5),
    ('CRASH', 'Unfall', 'A', 3, 1, 5),
    ('STRITTIG', 'kontrovers', 'A', 3, 7, 8),
    ('GAESTE', 'Besucher', 'A', 4, 3, 6),
    ('GUTE', 'prima', 'A', 5, 4, 4),
    ('SAMT', 'inklusive', 'A', 5, 9, 4),
    ('FEST', 'stabil', 'A', 6, 1, 4),
    ('UND', 'sowie', 'A', 6, 6, 3),
    ('OELE', 'Fette', 'A', 6, 11, 4),
    ('RIO', 'Stadt in Brasilien', 'A', 7, 1, 3),
    ('UNION', 'Bündnis', 'A', 7, 10, 5),
    ('ALL', 'Weltraum', 'A', 8, 1, 3),
    ('BLICK', 'Aussicht', 'A', 8, 5, 5),
    ('ALS', 'da, während', 'A', 8, 11, 3),
    ('GELBE', 'die ... Karte', 'A', 9, 1, 5),
    ('HAUT', 'Epidermis', 'A', 9, 8, 4),
    ('ISST', 'speist', 'A', 10, 4, 4),
    ('VON', 'ab, aus', 'A', 10, 12, 3),
    ('JENSEITS', 'drüben', 'A', 11, 2, 8),
    ('MORD', 'Tötung', 'A', 11, 11, 4),
    ('ZUR', 'zu der', 'A', 12, 1, 3),
    ('EHE', 'Bund fürs Leben', 'A', 12, 5, 3),
    ('ORTE', 'Plätze', 'A', 12, 11, 4),
    ('UNSERER', 'Possessiv (wir)', 'A', 13, 1, 7),
    ('RENNER', 'Bestseller', 'A', 13, 9, 6),
    ('MIT', 'samt', 'A', 14, 1, 3),
    ('EIS', 'Gefrorenes', 'A', 14, 7, 3),
    ('DENN', 'weil', 'A', 14, 11, 4),
    ('TUCH', 'Stoff', 'D', 1, 1, 4),
    ('FRAGE', 'Erkundigung', 'D', 6, 1, 5),
    ('ZUM', 'zu dem', 'D', 12, 1, 3),
    ('IHR', 'Pronomen (2. Pl.)', 'D', 1, 2, 3),
    ('TEILE', 'Stücke', 'D', 5, 2, 5),
    ('JUNI', '6. Monat', 'D', 11, 2, 4),
    ('PRAG', 'Moldau-Stadt', 'D', 1, 3, 4),
    ('SOLL', 'muss', 'D', 6, 3, 4),
    ('ERST', 'zunächst', 'D', 11, 3, 4),
    ('SAGT', 'äußert', 'D', 3, 4, 4),
    ('BIN', 'existiere', 'D', 9, 4, 3),
    ('SCHEU', 'schüchtern', 'D', 1, 5, 5),
    ('BESSERE', 'überlegene', 'D', 8, 5, 7),
    ('STUHL', 'Sitz', 'D', 4, 6, 5),
    ('SEHE', 'erblicke', 'D', 10, 6, 4),
    ('OSTEN', 'Richtung O', 'D', 2, 7, 5),
    ('TIERE', 'Lebewesen', 'D', 10, 7, 5),
    ('ALTE', 'betagte', 'D', 1, 8, 4),
    ('DOCH', 'allerdings', 'D', 6, 8, 4),
    ('KAISERS', 'Bart des ...', 'D', 8, 9, 7),
    ('CHINA', 'Reich der Mitte', 'D', 1, 10, 5),
    ('HAT', 'besitzt', 'D', 1, 11, 3),
    ('MONAT', 'etwa 30 Tage', 'D', 5, 11, 5),
    ('MOND', 'Erdtrabant', 'D', 11, 11, 4),
    ('IST', 'befindet sich', 'D', 1, 12, 3),
    ('TEIL', 'Stück', 'D', 5, 12, 4),
    ('VORNE', 'an der Spitze', 'D', 10, 12, 5),
    ('LEIB', 'Körper', 'D', 1, 13, 4),
    ('LOS', 'frei', 'D', 6, 13, 3),
    ('ORTEN', 'Stellen', 'D', 10, 13, 5),
    ('ENG', 'schmal', 'D', 1, 14, 3),
    ('YEN', 'Währung Japans', 'D', 5, 14, 3),
    ('ANDERN', 'übrigen', 'D', 9, 14, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r208-15x15-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r208-15x15-03', 'Rätsel 208 · 15×15', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '15x15-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('SATAN', 'Teufel', 'A', 1, 1, 5),
    ('HIERFUER', 'dazu', 'A', 1, 7, 8),
    ('EBEN', 'flach', 'A', 2, 1, 4),
    ('DANN', 'anschließend', 'A', 2, 6, 4),
    ('HEIL', 'Wohl', 'A', 3, 1, 4),
    ('ERST', 'zunächst', 'A', 3, 6, 4),
    ('TAGE', 'je 24 Stunden', 'A', 3, 11, 4),
    ('ERLAUBT', 'gestattet', 'A', 4, 1, 7),
    ('DES', 'Artikel (Genitiv)', 'A', 4, 12, 3),
    ('GEBE', 'reiche', 'A', 5, 11, 4),
    ('ENDE', 'Schluss', 'A', 6, 1, 4),
    ('TYP', 'Kerl', 'A', 6, 6, 3),
    ('WAREN', 'existierten', 'A', 6, 10, 5),
    ('REINSTE', 'pureste', 'A', 7, 1, 7),
    ('RENNT', 'läuft', 'A', 7, 9, 5),
    ('ZUR', 'zu der', 'A', 8, 1, 3),
    ('TENDENZ', 'Trend', 'A', 8, 5, 7),
    ('EBBE', 'Gegenteil der Flut', 'A', 9, 11, 4),
    ('FARBE', 'Kolorit', 'A', 10, 1, 5),
    ('AKT', 'Aufzug', 'A', 10, 7, 3),
    ('SOLL', 'muss', 'A', 10, 11, 4),
    ('EHE', 'Bund fürs Leben', 'A', 11, 1, 3),
    ('DOLLAR', 'US-Währung', 'A', 11, 5, 6),
    ('DOM', 'Kathedrale', 'A', 11, 12, 3),
    ('TRITT', 'kickt', 'A', 12, 1, 5),
    ('GAB', 'schenkte', 'A', 12, 7, 3),
    ('LESE', 'schmökere', 'A', 12, 11, 4),
    ('HOEHERE', 'größere', 'A', 13, 3, 7),
    ('ANS', 'an das', 'A', 13, 11, 3),
    ('EIERN', 'auf ... gehen', 'A', 14, 1, 5),
    ('LASSEN', 'erlauben', 'A', 14, 9, 6),
    ('SEHE', 'erblicke', 'D', 1, 1, 4),
    ('ERZ', 'Gestein', 'D', 6, 1, 3),
    ('FETTE', 'Öle', 'D', 10, 1, 5),
    ('ABER', 'jedoch', 'D', 1, 2, 4),
    ('NEUJAHR', '1. Januar', 'D', 6, 2, 7),
    ('TEIL', 'Stück', 'D', 1, 3, 4),
    ('DIR', 'Dat. (2. Pers.)', 'D', 6, 3, 3),
    ('REIHE', 'Serie', 'D', 10, 3, 5),
    ('ANLAGEN', 'Beilagen', 'D', 1, 4, 7),
    ('TOR', 'Treffer', 'D', 12, 4, 3),
    ('STAEDTEN', 'Kommunen', 'D', 7, 5, 8),
    ('DEBATTE', 'Diskussion', 'D', 2, 6, 7),
    ('HART', 'fest', 'D', 1, 7, 4),
    ('YEN', 'Währung Japans', 'D', 6, 7, 3),
    ('ALGEN', 'Tang', 'D', 10, 7, 5),
    ('INS', 'in das', 'D', 1, 8, 3),
    ('KLAR', 'deutlich', 'D', 10, 8, 4),
    ('ENTE', 'Wasservogel', 'D', 1, 9, 4),
    ('RENTABEL', 'lohnend', 'D', 7, 9, 8),
    ('WEN', 'Fragewort (Akk.)', 'D', 6, 10, 3),
    ('FIT', 'gesund', 'D', 1, 11, 3),
    ('GANZES', 'komplettes', 'D', 5, 11, 6),
    ('LAS', 'schmökerte', 'D', 12, 11, 3),
    ('ADERN', 'Venen', 'D', 3, 12, 5),
    ('BODENS', 'Qualität des ...', 'D', 9, 12, 6),
    ('GEBET', 'Andacht', 'D', 3, 13, 5),
    ('BLOSSE', 'reine', 'D', 9, 13, 6),
    ('RIESEN', 'Hünen', 'D', 1, 14, 6),
    ('HELME', 'Kopfschutz', 'D', 8, 14, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

commit;
