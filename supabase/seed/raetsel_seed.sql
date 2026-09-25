-- Automatisch erzeugt von tools/generator/generate_raetsel.py – nicht von Hand bearbeiten.
-- Voraussetzung: Migrationen, gitter_vorlagen.sql, woerter_seed.sql, fragen_varianten_seed.sql eingespielt.
-- Idempotent über raetsel.slug. Rätsel mit Prüfhinweisen werden als Entwurf angelegt.

begin;

-- r001-8x8-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r001-8x8-01', 'Rätsel 1 · 8×8', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '8x8-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('HASS', 'Abscheu', 'A', 1, 1, 4),
    ('AREALS', 'Größe des ...', 'A', 2, 1, 6),
    ('TOETET', 'bringt um', 'A', 3, 1, 6),
    ('TIEF', 'abgründig', 'A', 4, 4, 4),
    ('GAS', 'Brennstoff', 'A', 5, 1, 3),
    ('DIR', 'Dat. (2. Pers.)', 'A', 5, 5, 3),
    ('ARENA', 'Stadion', 'A', 6, 3, 5),
    ('REH', 'Waldtier', 'A', 7, 1, 3),
    ('NEU', 'frisch', 'A', 7, 5, 3),
    ('HAT', 'besitzt', 'D', 1, 1, 3),
    ('GAR', 'durchgekocht', 'D', 5, 1, 3),
    ('AROMA', 'Geschmack', 'D', 1, 2, 5),
    ('SEE', 'Gewässer', 'D', 1, 3, 3),
    ('SAH', 'erblickte', 'D', 5, 3, 3),
    ('SATT', 'gesättigt', 'D', 1, 4, 4),
    ('LEIDEN', 'dulden', 'D', 2, 5, 6),
    ('STEINE', 'Felsen', 'D', 2, 6, 6),
    ('FRAU', 'Dame', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r002-8x8-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r002-8x8-01', 'Rätsel 2 · 8×8', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '8x8-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('BIST', 'existierst', 'A', 1, 1, 4),
    ('ORIENT', 'Morgenland', 'A', 2, 1, 6),
    ('TRESOR', 'Safe', 'A', 3, 1, 6),
    ('TRAT', 'schritt', 'A', 4, 4, 4),
    ('UNI', 'Hochschule', 'A', 5, 1, 3),
    ('DER', 'Artikel (männl.)', 'A', 5, 5, 3),
    ('SIEGE', 'Triumphe', 'A', 6, 3, 5),
    ('RAT', 'Tipp', 'A', 7, 1, 3),
    ('NEU', 'frisch', 'A', 7, 5, 3),
    ('BOT', 'offerierte', 'D', 1, 1, 3),
    ('UHR', 'Zeitmesser', 'D', 5, 1, 3),
    ('IRREN', 'sich täuschen', 'D', 1, 2, 5),
    ('SIE', 'Anrede', 'D', 1, 3, 3),
    ('IST', 'befindet sich', 'D', 5, 3, 3),
    ('TEST', 'Prüfung', 'D', 1, 4, 4),
    ('NORDEN', 'Richtung N', 'D', 2, 5, 6),
    ('TRAEGE', 'faul', 'D', 2, 6, 6),
    ('TREU', 'loyal', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r003-8x8-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r003-8x8-01', 'Rätsel 3 · 8×8', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '8x8-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('EUER', 'Possessiv (ihr)', 'A', 1, 1, 4),
    ('INHALT', 'Füllung', 'A', 2, 1, 6),
    ('DIENER', 'Knecht', 'A', 3, 1, 6),
    ('DIAS', 'Lichtbilder', 'A', 4, 4, 4),
    ('UNI', 'Hochschule', 'A', 5, 1, 3),
    ('TUE', 'mache', 'A', 5, 5, 3),
    ('CREME', 'Salbe', 'A', 6, 3, 5),
    ('SAH', 'erblickte', 'A', 7, 1, 3),
    ('RAN', 'heran', 'A', 7, 5, 3),
    ('EID', 'Schwur', 'D', 1, 1, 3),
    ('UMS', 'um das', 'D', 5, 1, 3),
    ('UNION', 'Bündnis', 'D', 1, 2, 5),
    ('EHE', 'Bund fürs Leben', 'D', 1, 3, 3),
    ('ICH', 'Pronomen (1. Sg.)', 'D', 5, 3, 3),
    ('RAND', 'Kante', 'D', 1, 4, 4),
    ('LEITER', 'Chef', 'D', 2, 5, 6),
    ('TRAUMA', 'Schock', 'D', 2, 6, 6),
    ('SEEN', 'Gewässer', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r004-8x8-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r004-8x8-02', 'Rätsel 4 · 8×8', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '8x8-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('NAHM', 'griff', 'A', 1, 4, 4),
    ('NEUES', 'frisches', 'A', 2, 1, 5),
    ('ARMUT', 'Not', 'A', 3, 1, 5),
    ('HUFE', 'Pferdefüße', 'A', 4, 1, 4),
    ('ERHOB', 'stemmte', 'A', 5, 3, 5),
    ('LEERE', 'Vakuum', 'A', 6, 3, 5),
    ('UND', 'sowie', 'A', 7, 1, 3),
    ('UNI', 'Hochschule', 'A', 7, 5, 3),
    ('NAHEZU', 'fast', 'D', 2, 1, 6),
    ('PERU', 'Andenstaat', 'D', 1, 2, 4),
    ('UMFELD', 'Milieu', 'D', 2, 3, 6),
    ('NEUERE', 'Jüngere', 'D', 1, 4, 6),
    ('AST', 'Zweig', 'D', 1, 5, 3),
    ('HEU', 'Trockengras', 'D', 5, 5, 3),
    ('VORN', 'an der Spitze', 'D', 4, 6, 4),
    ('MIT', 'samt', 'D', 1, 7, 3),
    ('BEI', 'nahe an', 'D', 5, 7, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r005-8x8-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r005-8x8-02', 'Rätsel 5 · 8×8', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '8x8-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ASYL', 'Zuflucht', 'A', 1, 4, 4),
    ('KOSTE', 'probiere', 'A', 2, 1, 5),
    ('ASCHE', 'Glutrest', 'A', 3, 1, 5),
    ('MEHL', 'Backzutat', 'A', 4, 1, 4),
    ('LEHRT', 'unterrichtet', 'A', 5, 3, 5),
    ('ATOME', 'Teilchen', 'A', 6, 3, 5),
    ('AUF', 'offen', 'A', 7, 1, 3),
    ('FEE', 'Zauberin', 'A', 7, 5, 3),
    ('KAMERA', 'Fotoapparat', 'D', 2, 1, 6),
    ('ROSE', 'Blume mit Dornen', 'D', 1, 2, 4),
    ('SCHLAF', 'Nachtruhe', 'D', 2, 3, 6),
    ('ATHLET', 'Sportler', 'D', 1, 4, 6),
    ('SEE', 'Gewässer', 'D', 1, 5, 3),
    ('HOF', 'Gehöft', 'D', 5, 5, 3),
    ('ARME', 'Mittellose', 'D', 4, 6, 4),
    ('LAG', 'ruhte', 'D', 1, 7, 3),
    ('TEE', 'Heißgetränk', 'D', 5, 7, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r006-8x8-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r006-8x8-02', 'Rätsel 6 · 8×8', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '8x8-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('BAUT', 'errichtet', 'A', 1, 4, 4),
    ('AUGES', 'Farbe des ...', 'A', 2, 1, 5),
    ('FREUT', 'beglückt', 'A', 3, 1, 5),
    ('REST', 'Überbleibsel', 'A', 4, 1, 4),
    ('UEBTE', 'trainierte', 'A', 5, 3, 5),
    ('CLOWN', 'Spaßmacher', 'A', 6, 3, 5),
    ('ACH', 'Ausruf', 'A', 7, 1, 3),
    ('TAG', '24 Stunden', 'A', 7, 5, 3),
    ('AFRIKA', 'Erdteil', 'D', 2, 1, 6),
    ('PURE', 'reine', 'D', 1, 2, 4),
    ('GESUCH', 'Antrag', 'D', 2, 3, 6),
    ('BEUTEL', 'Tasche', 'D', 1, 4, 6),
    ('AST', 'Zweig', 'D', 1, 5, 3),
    ('BOT', 'offerierte', 'D', 5, 5, 3),
    ('ETWA', 'ungefähr', 'D', 4, 6, 4),
    ('TAL', 'Senke', 'D', 1, 7, 3),
    ('ENG', 'schmal', 'D', 5, 7, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r007-8x8-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r007-8x8-03', 'Rätsel 7 · 8×8', g.id, 'veroeffentlicht', 1, now()
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
    ('ENDE', 'Schluss', 'A', 4, 4, 4),
    ('UND', 'sowie', 'A', 5, 1, 3),
    ('DEN', 'Artikel (Akkusativ)', 'A', 5, 5, 3),
    ('TUE', 'mache', 'A', 6, 1, 3),
    ('ART', 'Sorte', 'A', 6, 5, 3),
    ('ERST', 'zunächst', 'A', 7, 1, 4),
    ('HEUTE', 'jetzt', 'D', 3, 1, 5),
    ('OPA', 'Großvater', 'D', 1, 2, 3),
    ('NUR', 'lediglich', 'D', 5, 2, 3),
    ('ORT', 'Stelle', 'D', 1, 3, 3),
    ('DES', 'Artikel (Genitiv)', 'D', 5, 3, 3),
    ('TOTE', 'Verstorbene', 'D', 1, 4, 4),
    ('EBENDA', 'dort', 'D', 1, 5, 6),
    ('SENDER', 'Kanal', 'D', 1, 6, 6),
    ('ENTE', 'Wasservogel', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r008-8x8-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r008-8x8-03', 'Rätsel 8 · 8×8', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '8x8-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('WASSER', 'H2O', 'A', 1, 1, 6),
    ('LIEBEN', 'gernhaben', 'A', 2, 2, 6),
    ('STEHEN', 'aufrecht sein', 'A', 3, 1, 6),
    ('ENTE', 'Wasservogel', 'A', 4, 4, 4),
    ('HAI', 'Raubfisch', 'A', 5, 1, 3),
    ('DER', 'Artikel (männl.)', 'A', 5, 5, 3),
    ('NUN', 'jetzt', 'A', 6, 1, 3),
    ('ANS', 'an das', 'A', 6, 5, 3),
    ('ESSE', 'speise', 'A', 7, 1, 4),
    ('SAHNE', 'Rahm', 'D', 3, 1, 5),
    ('ALT', 'betagt', 'D', 1, 2, 3),
    ('AUS', 'vorbei', 'D', 5, 2, 3),
    ('SIE', 'Anrede', 'D', 1, 3, 3),
    ('INS', 'in das', 'D', 5, 3, 3),
    ('SEHE', 'erblicke', 'D', 1, 4, 4),
    ('EBENDA', 'dort', 'D', 1, 5, 6),
    ('RENTEN', 'Pensionen', 'D', 1, 6, 6),
    ('ERST', 'zunächst', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r009-8x8-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r009-8x8-03', 'Rätsel 9 · 8×8', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '8x8-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('NATION', 'Volk', 'A', 1, 1, 6),
    ('PORTAL', 'Tor', 'A', 2, 2, 6),
    ('UPDATE', 'Nachtrag', 'A', 3, 1, 6),
    ('NAHE', 'dicht bei', 'A', 4, 4, 4),
    ('BAU', 'Gebäude', 'A', 5, 1, 3),
    ('WEN', 'Fragewort (Akk.)', 'A', 5, 5, 3),
    ('TUN', 'machen', 'A', 6, 1, 3),
    ('ARG', 'schlimm', 'A', 6, 5, 3),
    ('ESSE', 'speise', 'A', 7, 1, 4),
    ('UEBTE', 'trainierte', 'D', 3, 1, 5),
    ('APP', 'Anwendung', 'D', 1, 2, 3),
    ('AUS', 'vorbei', 'D', 5, 2, 3),
    ('TOD', 'Ableben', 'D', 1, 3, 3),
    ('UNS', 'Akk./Dat. von wir', 'D', 5, 3, 3),
    ('IRAN', 'Persien', 'D', 1, 4, 4),
    ('OTTAWA', 'kanad. Hauptstadt', 'D', 1, 5, 6),
    ('NAEHER', 'dichter', 'D', 1, 6, 6),
    ('ENGE', 'schmale', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r010-9x9-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r010-9x9-01', 'Rätsel 10 · 9×9', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x9-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('MAIS', 'Kukuruz', 'A', 1, 1, 4),
    ('INS', 'in das', 'A', 1, 6, 3),
    ('AURA', 'Ausstrahlung', 'A', 2, 1, 4),
    ('SET', 'Satz', 'A', 2, 6, 3),
    ('STAR', 'Berühmtheit', 'A', 3, 1, 4),
    ('TUE', 'mache', 'A', 3, 6, 3),
    ('SONG', 'Lied', 'A', 4, 1, 4),
    ('POOL', 'Becken', 'A', 5, 5, 4),
    ('VORWURF', 'Anklage', 'A', 6, 1, 7),
    ('EREILTE', 'traf', 'A', 7, 1, 7),
    ('THESEN', 'Behauptungen', 'A', 8, 2, 6),
    ('MASSIVE', 'wuchtige', 'D', 1, 1, 7),
    ('AUTO', 'Pkw', 'D', 1, 2, 4),
    ('ORT', 'Stelle', 'D', 6, 2, 3),
    ('IRAN', 'Persien', 'D', 1, 3, 4),
    ('REH', 'Waldtier', 'D', 6, 3, 3),
    ('SARG', 'Totenschrein', 'D', 1, 4, 4),
    ('WIE', 'gleich', 'D', 6, 4, 3),
    ('PULS', 'Herzschlag', 'D', 5, 5, 4),
    ('IST', 'befindet sich', 'D', 1, 6, 3),
    ('ORTE', 'Plätze', 'D', 5, 6, 4),
    ('NEU', 'frisch', 'D', 1, 7, 3),
    ('OFEN', 'Herd', 'D', 5, 7, 4),
    ('STEIL', 'abschüssig', 'D', 1, 8, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r011-9x9-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r011-9x9-01', 'Rätsel 11 · 9×9', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x9-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('VOLT', 'Maßeinheit', 'A', 1, 1, 4),
    ('OHR', 'Hörorgan', 'A', 1, 6, 3),
    ('EHER', 'lieber', 'A', 2, 1, 4),
    ('FEE', 'Zauberin', 'A', 2, 6, 3),
    ('RIGA', 'lett. Hauptstadt', 'A', 3, 1, 4),
    ('TUN', 'machen', 'A', 3, 6, 3),
    ('GOTT', 'Schöpfer', 'A', 4, 1, 4),
    ('DOSE', 'Büchse', 'A', 5, 5, 4),
    ('BEINAHE', 'fast', 'A', 6, 1, 7),
    ('EISERNE', 'stählerne', 'A', 7, 1, 7),
    ('STUFEN', 'Etappen', 'A', 8, 2, 6),
    ('VERGABE', 'Zuteilung', 'D', 1, 1, 7),
    ('OHIO', 'Staat um Cleveland', 'D', 1, 2, 4),
    ('EIS', 'Gefrorenes', 'D', 6, 2, 3),
    ('LEGT', 'platziert', 'D', 1, 3, 4),
    ('IST', 'befindet sich', 'D', 6, 3, 3),
    ('TRAT', 'schritt', 'D', 1, 4, 4),
    ('NEU', 'frisch', 'D', 6, 4, 3),
    ('DARF', 'kann', 'D', 5, 5, 4),
    ('OFT', 'häufig', 'D', 1, 6, 3),
    ('OHNE', 'abzüglich', 'D', 5, 6, 4),
    ('HEU', 'Trockengras', 'D', 1, 7, 3),
    ('SEEN', 'Gewässer', 'D', 5, 7, 4),
    ('RENTE', 'Pension', 'D', 1, 8, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r012-9x9-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r012-9x9-01', 'Rätsel 12 · 9×9', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x9-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ARME', 'Mittellose', 'A', 1, 1, 4),
    ('MAN', 'jemand', 'A', 1, 6, 3),
    ('NEID', 'Missgunst', 'A', 2, 1, 4),
    ('AUE', 'Talwiese', 'A', 2, 6, 3),
    ('ADEL', 'Aristokratie', 'A', 3, 1, 4),
    ('IST', 'befindet sich', 'A', 3, 6, 3),
    ('LESE', 'schmökere', 'A', 4, 1, 4),
    ('OSLO', 'norw. Hauptstadt', 'A', 5, 5, 4),
    ('SPANDAU', 'Berliner Bezirk', 'A', 6, 1, 7),
    ('ERLIESS', 'verfügte', 'A', 7, 1, 7),
    ('OBERST', 'Dienstgrad', 'A', 8, 2, 6),
    ('ANALYSE', 'Untersuchung', 'D', 1, 1, 7),
    ('REDE', 'Ansprache', 'D', 1, 2, 4),
    ('PRO', 'je', 'D', 6, 2, 3),
    ('MIES', 'schlecht', 'D', 1, 3, 4),
    ('ALB', 'Gebirge', 'D', 6, 3, 3),
    ('EDLE', 'vornehme', 'D', 1, 4, 4),
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

-- r013-9x9-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r013-9x9-02', 'Rätsel 13 · 9×9', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '9x9-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('SIEB', 'Filter', 'A', 1, 1, 4),
    ('UND', 'sowie', 'A', 1, 6, 3),
    ('IHREN', 'seinen', 'A', 2, 1, 5),
    ('ERZIELT', 'erreicht', 'A', 3, 1, 7),
    ('SATZ', 'Sprung', 'A', 4, 5, 4),
    ('SENATS', 'Sitzung des ...', 'A', 5, 1, 6),
    ('EHER', 'lieber', 'A', 6, 1, 4),
    ('TUE', 'mache', 'A', 6, 6, 3),
    ('HEIM', 'Zuhause', 'A', 7, 1, 4),
    ('ENG', 'schmal', 'A', 7, 6, 3),
    ('ENDE', 'Schluss', 'A', 8, 1, 4),
    ('NIE', 'nimmer', 'A', 8, 6, 3),
    ('SIE', 'Anrede', 'D', 1, 1, 3),
    ('SEHE', 'erblicke', 'D', 5, 1, 4),
    ('IHR', 'Pronomen (2. Pl.)', 'D', 1, 2, 3),
    ('EHEN', 'Bündnisse', 'D', 5, 2, 4),
    ('ERZ', 'Gestein', 'D', 1, 3, 3),
    ('NEID', 'Missgunst', 'D', 5, 3, 4),
    ('BEI', 'nahe an', 'D', 1, 4, 3),
    ('ARME', 'Mittellose', 'D', 5, 4, 4),
    ('NEST', 'Horst', 'D', 2, 5, 4),
    ('LASTEN', 'Bürden', 'D', 3, 6, 6),
    ('NETT', 'freundlich', 'D', 1, 7, 4),
    ('UNI', 'Hochschule', 'D', 6, 7, 3),
    ('ZUEGE', 'Bahnen', 'D', 4, 8, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r014-9x9-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r014-9x9-02', 'Rätsel 14 · 9×9', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '9x9-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('NEID', 'Missgunst', 'A', 1, 1, 4),
    ('ASS', 'speiste', 'A', 1, 6, 3),
    ('EISEN', 'Metall', 'A', 2, 1, 5),
    ('UNTREUE', 'Seitensprung', 'A', 3, 1, 7),
    ('UMSO', 'desto', 'A', 4, 5, 4),
    ('VORWEG', 'vorab', 'A', 5, 1, 6),
    ('IDEE', 'Einfall', 'A', 6, 1, 4),
    ('AST', 'Zweig', 'A', 6, 6, 3),
    ('TEIL', 'Stück', 'A', 7, 1, 4),
    ('NIE', 'nimmer', 'A', 7, 6, 3),
    ('ARZT', 'Mediziner', 'A', 8, 1, 4),
    ('GEN', 'nach', 'A', 8, 6, 3),
    ('NEU', 'frisch', 'D', 1, 1, 3),
    ('VITA', 'Lebenslauf', 'D', 5, 1, 4),
    ('EIN', 'unbest. Artikel', 'D', 1, 2, 3),
    ('ODER', 'bzw.', 'D', 5, 2, 4),
    ('IST', 'befindet sich', 'D', 1, 3, 3),
    ('REIZ', 'Charme', 'D', 5, 3, 4),
    ('DER', 'Artikel (männl.)', 'D', 1, 4, 3),
    ('WELT', 'Erde', 'D', 5, 4, 4),
    ('NEUE', 'frische', 'D', 2, 5, 4),
    ('UMGANG', 'Verkehr', 'D', 3, 6, 6),
    ('SEES', 'Ufer des ...', 'D', 1, 7, 4),
    ('SIE', 'Anrede', 'D', 6, 7, 3),
    ('ORTEN', 'Stellen', 'D', 4, 8, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r015-9x9-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r015-9x9-02', 'Rätsel 15 · 9×9', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '9x9-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('LOGO', 'Emblem', 'A', 1, 1, 4),
    ('LOT', 'Senkblei', 'A', 1, 6, 3),
    ('OPERN', 'Musikdramen', 'A', 2, 1, 5),
    ('KANTONE', 'Schweizer Gliedstaaten', 'A', 3, 1, 7),
    ('CENT', 'Hundertstel Euro', 'A', 4, 5, 4),
    ('ERGEHT', 'widerfährt', 'A', 5, 1, 6),
    ('WEIB', 'Frau (veraltet)', 'A', 6, 1, 4),
    ('TUN', 'machen', 'A', 6, 6, 3),
    ('IDEE', 'Einfall', 'A', 7, 1, 4),
    ('ENG', 'schmal', 'A', 7, 6, 3),
    ('GERN', 'mit Freude', 'A', 8, 1, 4),
    ('RIO', 'Stadt in Brasilien', 'A', 8, 6, 3),
    ('LOK', 'Zugmaschine', 'D', 1, 1, 3),
    ('EWIG', 'endlos', 'D', 5, 1, 4),
    ('OPA', 'Großvater', 'D', 1, 2, 3),
    ('REDE', 'Ansprache', 'D', 5, 2, 4),
    ('GEN', 'nach', 'D', 1, 3, 3),
    ('GIER', 'Habsucht', 'D', 5, 3, 4),
    ('ORT', 'Stelle', 'D', 1, 4, 3),
    ('EBEN', 'flach', 'D', 5, 4, 4),
    ('NOCH', 'bislang', 'D', 2, 5, 4),
    ('NETTER', 'freundlicher', 'D', 3, 6, 6),
    ('OMEN', 'Vorzeichen', 'D', 1, 7, 4),
    ('UNI', 'Hochschule', 'D', 6, 7, 3),
    ('TANGO', 'argent. Tanz', 'D', 4, 8, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r016-9x9-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r016-9x9-03', 'Rätsel 16 · 9×9', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x9-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AMTS', 'im ... sein', 'A', 1, 1, 4),
    ('ALS', 'da, während', 'A', 1, 6, 3),
    ('MAUT', 'Gebühr', 'A', 2, 1, 4),
    ('DIE', 'Artikel (weibl.)', 'A', 2, 6, 3),
    ('TREU', 'loyal', 'A', 3, 1, 4),
    ('UNI', 'Hochschule', 'A', 3, 6, 3),
    ('FELD', 'Acker', 'A', 4, 4, 4),
    ('AEMTER', 'Behörden', 'A', 5, 3, 6),
    ('ALL', 'Weltraum', 'A', 6, 1, 3),
    ('AERA', 'Epoche', 'A', 6, 5, 4),
    ('ROT', 'purpurn', 'A', 7, 1, 3),
    ('INNE', '... halten', 'A', 7, 5, 4),
    ('STEIL', 'abschüssig', 'A', 8, 1, 5),
    ('AMT', 'Behörde', 'D', 1, 1, 3),
    ('MARS', 'roter Planet', 'D', 5, 1, 4),
    ('MARK', 'alte Währung', 'D', 1, 2, 4),
    ('LOT', 'Senkblei', 'D', 6, 2, 3),
    ('TUE', 'mache', 'D', 1, 3, 3),
    ('ALTE', 'betagte', 'D', 5, 3, 4),
    ('STUFE', 'Tritt', 'D', 1, 4, 5),
    ('EMAIL', 'elektr. Post', 'D', 4, 5, 5),
    ('ADULTEN', 'erwachsenen', 'D', 1, 6, 7),
    ('LINDERN', 'mildern', 'D', 1, 7, 7),
    ('SEI', 'existiere', 'D', 1, 8, 3),
    ('RAET', 'empfiehlt', 'D', 5, 8, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r017-9x9-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r017-9x9-03', 'Rätsel 17 · 9×9', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x9-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('DEAL', 'Geschäft', 'A', 1, 1, 4),
    ('KAM', 'nahte', 'A', 1, 6, 3),
    ('EURO', 'Währung', 'A', 2, 1, 4),
    ('NEU', 'frisch', 'A', 2, 6, 3),
    ('REGE', 'lebhaft', 'A', 3, 1, 4),
    ('ALT', 'betagt', 'A', 3, 6, 3),
    ('WELT', 'Erde', 'A', 4, 4, 4),
    ('DERLEI', 'solches', 'A', 5, 3, 6),
    ('SEI', 'existiere', 'A', 6, 1, 3),
    ('BERN', 'Schweizer Hauptstadt', 'A', 6, 5, 4),
    ('SIE', 'Anrede', 'A', 7, 1, 3),
    ('IREN', 'Gälen', 'A', 7, 5, 4),
    ('ESSEN', 'Mahlzeit', 'A', 8, 1, 5),
    ('DER', 'Artikel (männl.)', 'D', 1, 1, 3),
    ('ESSE', 'speise', 'D', 5, 1, 4),
    ('EUER', 'Possessiv (ihr)', 'D', 1, 2, 4),
    ('EIS', 'Gefrorenes', 'D', 6, 2, 3),
    ('ARG', 'schlimm', 'D', 1, 3, 3),
    ('DIES', 'das hier', 'D', 5, 3, 4),
    ('LOEWE', 'König der Tiere', 'D', 1, 4, 5),
    ('ERBIN', 'Nachkommin', 'D', 4, 5, 5),
    ('KNALLER', 'Böller', 'D', 1, 6, 7),
    ('AELTERE', 'betagtere', 'D', 1, 7, 7),
    ('MUT', 'Courage', 'D', 1, 8, 3),
    ('INNE', '... halten', 'D', 5, 8, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r018-9x9-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r018-9x9-03', 'Rätsel 18 · 9×9', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x9-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ETWA', 'ungefähr', 'A', 1, 1, 4),
    ('GAU', 'Landstrich', 'A', 1, 6, 3),
    ('LEER', 'hohl', 'A', 2, 1, 4),
    ('REH', 'Waldtier', 'A', 2, 6, 3),
    ('FARM', 'Bauernhof', 'A', 3, 1, 4),
    ('OHR', 'Hörorgan', 'A', 3, 6, 3),
    ('EBEN', 'flach', 'A', 4, 4, 4),
    ('FELSEN', 'Steine', 'A', 5, 3, 6),
    ('RIO', 'Stadt in Brasilien', 'A', 6, 1, 3),
    ('OSLO', 'norw. Hauptstadt', 'A', 6, 5, 4),
    ('AST', 'Zweig', 'A', 7, 1, 3),
    ('CENT', 'Hundertstel Euro', 'A', 7, 5, 4),
    ('STOCK', 'Stab', 'A', 8, 1, 5),
    ('ELF', 'Zahl (10+1)', 'D', 1, 1, 3),
    ('GRAS', 'Rasen', 'D', 5, 1, 4),
    ('TEAM', 'Mannschaft', 'D', 1, 2, 4),
    ('IST', 'befindet sich', 'D', 6, 2, 3),
    ('WER', 'Fragewort (Person)', 'D', 1, 3, 3),
    ('FOTO', 'Aufnahme', 'D', 5, 3, 4),
    ('ARMEE', 'Heer', 'D', 1, 4, 5),
    ('BLOCK', 'Klotz', 'D', 4, 5, 5),
    ('GROESSE', 'Format', 'D', 1, 6, 7),
    ('AEHNELN', 'gleichen', 'D', 1, 7, 7),
    ('UHR', 'Zeitmesser', 'D', 1, 8, 3),
    ('NOTE', 'Zensur', 'D', 5, 8, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r019-9x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r019-9x13-01', 'Rätsel 19 · 9×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('LEBT', 'existiert', 'A', 1, 1, 4),
    ('URUGUAY', 'Staat in Südamerika', 'A', 1, 6, 7),
    ('EHER', 'lieber', 'A', 2, 1, 4),
    ('FEHDE', 'Streit', 'A', 2, 8, 5),
    ('BERUFT', 'ernennt', 'A', 3, 1, 6),
    ('EHREN', 'zu ... von', 'A', 3, 8, 5),
    ('GELEERT', 'geräumt', 'A', 4, 3, 7),
    ('BARS', 'Kneipen', 'A', 5, 4, 4),
    ('LOB', 'Anerkennung', 'A', 6, 1, 3),
    ('NEST', 'Horst', 'A', 6, 5, 4),
    ('IST', 'befindet sich', 'A', 6, 10, 3),
    ('OMA', 'Großmutter', 'A', 7, 1, 3),
    ('KNIE', 'Gelenk', 'A', 7, 5, 4),
    ('GAU', 'Landstrich', 'A', 7, 10, 3),
    ('SAUCE', 'Soße', 'A', 8, 1, 5),
    ('GEFAHR', 'Risiko', 'A', 8, 7, 6),
    ('LEBE', 'existiere', 'D', 1, 1, 4),
    ('LOS', 'frei', 'D', 6, 1, 3),
    ('EHE', 'Bund fürs Leben', 'D', 1, 2, 3),
    ('KOMA', 'tiefe Ohnmacht', 'D', 5, 2, 4),
    ('BERG', 'Gipfel', 'D', 1, 3, 4),
    ('BAU', 'Gebäude', 'D', 6, 3, 3),
    ('TRUEB', 'diesig', 'D', 1, 4, 5),
    ('FLANKE', 'Seite', 'D', 3, 5, 6),
    ('UNTEREN', 'tieferen', 'D', 1, 6, 7),
    ('ESSIG', 'Würzmittel', 'D', 4, 7, 5),
    ('UFER', 'Gestade', 'D', 1, 8, 4),
    ('TEE', 'Heißgetränk', 'D', 6, 8, 3),
    ('GEHT', 'läuft', 'D', 1, 9, 4),
    ('UHR', 'Zeitmesser', 'D', 1, 10, 3),
    ('LIGA', 'Spielklasse', 'D', 5, 10, 4),
    ('ADEL', 'Aristokratie', 'D', 1, 11, 4),
    ('SAH', 'erblickte', 'D', 6, 11, 3),
    ('YEN', 'Währung Japans', 'D', 1, 12, 3),
    ('STUR', 'starrsinnig', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r020-9x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r020-9x13-01', 'Rätsel 20 · 9×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('OVAL', 'eiförmig', 'A', 1, 1, 4),
    ('FREIBAD', 'Lido', 'A', 1, 6, 7),
    ('HOLE', 'besorge', 'A', 2, 1, 4),
    ('BRITE', 'Engländer', 'A', 2, 8, 5),
    ('INTIME', 'vertraute', 'A', 3, 1, 6),
    ('BESEN', 'Kehrgerät', 'A', 3, 8, 5),
    ('ENORMEN', 'gewaltigen', 'A', 4, 3, 7),
    ('ERBE', 'Nachlass', 'A', 5, 4, 4),
    ('LAS', 'schmökerte', 'A', 6, 1, 3),
    ('GELD', 'Moneten', 'A', 6, 5, 4),
    ('UND', 'sowie', 'A', 6, 10, 3),
    ('OMA', 'Großmutter', 'A', 7, 1, 3),
    ('ENDE', 'Schluss', 'A', 7, 5, 4),
    ('TUE', 'mache', 'A', 7, 10, 3),
    ('SEHEN', 'erblicken', 'A', 8, 1, 5),
    ('EMPORE', 'Galerie', 'A', 8, 7, 6),
    ('OHIO', 'Staat um Cleveland', 'D', 1, 1, 4),
    ('LOS', 'frei', 'D', 6, 1, 3),
    ('VON', 'ab, aus', 'D', 1, 2, 3),
    ('NAME', 'Bezeichnung', 'D', 5, 2, 4),
    ('ALTE', 'betagte', 'D', 1, 3, 4),
    ('SAH', 'erblickte', 'D', 6, 3, 3),
    ('LEINE', 'Seil', 'D', 1, 4, 5),
    ('MORGEN', 'Frühe', 'D', 3, 5, 6),
    ('FAERBEN', 'tönen', 'D', 1, 6, 7),
    ('MELDE', 'zeige an', 'D', 4, 7, 5),
    ('EBBE', 'Gegenteil der Flut', 'D', 1, 8, 4),
    ('DEM', 'Artikel (Dativ)', 'D', 6, 8, 3),
    ('IREN', 'Gälen', 'D', 1, 9, 4),
    ('BIS', 'nicht später als', 'D', 1, 10, 3),
    ('AUTO', 'Pkw', 'D', 5, 10, 4),
    ('ATEM', 'Luft', 'D', 1, 11, 4),
    ('NUR', 'lediglich', 'D', 6, 11, 3),
    ('DEN', 'Artikel (Akkusativ)', 'D', 1, 12, 3),
    ('IDEE', 'Einfall', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r021-9x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r021-9x13-01', 'Rätsel 21 · 9×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '9x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('EBBE', 'Gegenteil der Flut', 'A', 1, 1, 4),
    ('ZOEGERT', 'zaudert', 'A', 1, 6, 7),
    ('DORN', 'Stachel', 'A', 2, 1, 4),
    ('GENAU', 'exakt', 'A', 2, 8, 5),
    ('EXAKTE', 'genaue', 'A', 3, 1, 6),
    ('ANGST', 'Furcht', 'A', 3, 8, 5),
    ('VERHALF', 'unterstützte', 'A', 4, 3, 7),
    ('LINK', 'Verknüpfung', 'A', 5, 4, 4),
    ('HOF', 'Gehöft', 'A', 6, 1, 3),
    ('NETT', 'freundlich', 'A', 6, 5, 4),
    ('UNI', 'Hochschule', 'A', 6, 10, 3),
    ('AUE', 'Talwiese', 'A', 7, 1, 3),
    ('KNIE', 'Gelenk', 'A', 7, 5, 4),
    ('SIE', 'Anrede', 'A', 7, 10, 3),
    ('BRETT', 'Planke', 'A', 8, 1, 5),
    ('VERSEN', 'Reimen', 'A', 8, 7, 6),
    ('EDEL', 'vornehm', 'D', 1, 1, 4),
    ('HAB', '... und Gut', 'D', 6, 1, 3),
    ('BOX', 'Kiste', 'D', 1, 2, 3),
    ('TOUR', 'Rundreise', 'D', 5, 2, 4),
    ('BRAV', 'artig', 'D', 1, 3, 4),
    ('FEE', 'Zauberin', 'D', 6, 3, 3),
    ('ENKEL', 'Kindeskind', 'D', 1, 4, 5),
    ('TRINKT', 'schluckt', 'D', 3, 5, 6),
    ('ZAEHNEN', 'Beißern', 'D', 1, 6, 7),
    ('AKTIV', 'tätig', 'D', 4, 7, 5),
    ('EGAL', 'gleichgültig', 'D', 1, 8, 4),
    ('TEE', 'Heißgetränk', 'D', 6, 8, 3),
    ('GENF', 'Stadt am Léman', 'D', 1, 9, 4),
    ('ENG', 'schmal', 'D', 1, 10, 3),
    ('GUSS', 'Regenschauer', 'D', 5, 10, 4),
    ('RAST', 'jagt', 'D', 1, 11, 4),
    ('NIE', 'nimmer', 'D', 6, 11, 3),
    ('TUT', 'macht', 'D', 1, 12, 3),
    ('WIEN', 'österr. Hauptstadt', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r022-9x13-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r022-9x13-02', 'Rätsel 22 · 9×13', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '9x13-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('GAB', 'schenkte', 'A', 1, 1, 3),
    ('AST', 'Zweig', 'A', 1, 6, 3),
    ('UND', 'sowie', 'A', 1, 10, 3),
    ('ALL', 'Weltraum', 'A', 2, 1, 3),
    ('AUTO', 'Pkw', 'A', 2, 5, 4),
    ('RIO', 'Stadt in Brasilien', 'A', 2, 10, 3),
    ('ETAT', 'Budget', 'A', 3, 1, 4),
    ('TURNIER', 'Wettkampf', 'A', 3, 6, 7),
    ('NEUE', 'frische', 'A', 4, 1, 4),
    ('OFFEN', 'geöffnet', 'A', 4, 6, 5),
    ('IHRE', 'seine', 'A', 5, 4, 4),
    ('ENDLOS', 'ewig', 'A', 6, 1, 6),
    ('ABZUG', 'Rückzug', 'A', 6, 8, 5),
    ('EIER', 'Gelege', 'A', 7, 2, 4),
    ('TRAUMA', 'Schock', 'A', 7, 7, 6),
    ('DUENNE', 'magere', 'A', 8, 1, 6),
    ('TURMS', 'Spitze des ...', 'A', 8, 8, 5),
    ('GAENGE', 'Flure', 'D', 1, 1, 6),
    ('ALTE', 'betagte', 'D', 1, 2, 4),
    ('NEU', 'frisch', 'D', 6, 2, 3),
    ('BLAU', 'betrunken', 'D', 1, 3, 4),
    ('DIE', 'Artikel (weibl.)', 'D', 6, 3, 3),
    ('TEILEN', 'zu gleichen ...', 'D', 3, 4, 6),
    ('HORN', 'Hupe', 'D', 5, 5, 4),
    ('AUTORS', 'Werk des ...', 'D', 1, 6, 6),
    ('STUFE', 'Tritt', 'D', 1, 7, 5),
    ('TORF', 'Moorboden', 'D', 1, 8, 4),
    ('ART', 'Sorte', 'D', 6, 8, 3),
    ('NEUBAU', 'frisches Gebäude', 'D', 3, 9, 6),
    ('URIN', 'Harn', 'D', 1, 10, 4),
    ('ZUR', 'zu der', 'D', 6, 10, 3),
    ('NIE', 'nimmer', 'D', 1, 11, 3),
    ('DUMM', 'töricht', 'D', 5, 11, 4),
    ('DORF', 'Weiler', 'D', 1, 12, 4),
    ('GAS', 'Brennstoff', 'D', 6, 12, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r023-9x13-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r023-9x13-02', 'Rätsel 23 · 9×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x13-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AUF', 'offen', 'A', 1, 1, 3),
    ('ENG', 'schmal', 'A', 1, 6, 3),
    ('INS', 'in das', 'A', 1, 10, 3),
    ('UNI', 'Hochschule', 'A', 2, 1, 3),
    ('ZWAR', 'freilich', 'A', 2, 5, 4),
    ('RIO', 'Stadt in Brasilien', 'A', 2, 10, 3),
    ('TIER', 'Lebewesen', 'A', 3, 1, 4),
    ('ITALIEN', 'Stiefelland', 'A', 3, 6, 7),
    ('OSLO', 'norw. Hauptstadt', 'A', 4, 1, 4),
    ('GUTES', 'braves', 'A', 4, 6, 5),
    ('MEER', 'See', 'A', 5, 4, 4),
    ('SODANN', 'dann', 'A', 6, 1, 6),
    ('STAND', 'stockte', 'A', 6, 8, 5),
    ('HING', 'baumelte', 'A', 7, 2, 4),
    ('VIERTE', 'nach der dritten', 'A', 7, 7, 6),
    ('TRESEN', 'Theke', 'A', 8, 1, 6),
    ('ENGER', 'schmaler', 'A', 8, 8, 5),
    ('AUTORS', 'Werk des ...', 'D', 1, 1, 6),
    ('UNIS', 'Hochschulen', 'D', 1, 2, 4),
    ('OHR', 'Hörorgan', 'D', 6, 2, 3),
    ('FIEL', 'stürzte', 'D', 1, 3, 4),
    ('DIE', 'Artikel (weibl.)', 'D', 6, 3, 3),
    ('ROMANS', 'Held des ...', 'D', 3, 4, 6),
    ('ENGE', 'schmale', 'D', 5, 5, 4),
    ('EWIGEN', 'endlosen', 'D', 1, 6, 6),
    ('NATUR', 'Umwelt', 'D', 1, 7, 5),
    ('GRAT', 'Kamm', 'D', 1, 8, 4),
    ('SIE', 'Anrede', 'D', 6, 8, 3),
    ('LEBTEN', 'existierten', 'D', 3, 9, 6),
    ('IRIS', 'Schwertlilie', 'D', 1, 10, 4),
    ('ARG', 'schlimm', 'D', 6, 10, 3),
    ('NIE', 'nimmer', 'D', 1, 11, 3),
    ('ENTE', 'Wasservogel', 'D', 5, 11, 4),
    ('SONG', 'Lied', 'D', 1, 12, 4),
    ('DER', 'Artikel (männl.)', 'D', 6, 12, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r024-9x13-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r024-9x13-02', 'Rätsel 24 · 9×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '9x13-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('KUR', 'Erholung', 'A', 1, 1, 3),
    ('HUT', 'Kopfbedeckung', 'A', 1, 6, 3),
    ('WIR', 'Pronomen (1. Pl.)', 'A', 1, 10, 3),
    ('OMA', 'Großmutter', 'A', 2, 1, 3),
    ('KINO', 'Filmtheater', 'A', 2, 5, 4),
    ('EHE', 'Bund fürs Leben', 'A', 2, 10, 3),
    ('ESEL', 'Grautier', 'A', 3, 1, 4),
    ('EMPFING', 'erhielt', 'A', 3, 6, 7),
    ('NOTE', 'Zensur', 'A', 4, 1, 4),
    ('RUFEN', 'schreien', 'A', 4, 6, 5),
    ('CHAT', 'Plauderei', 'A', 5, 4, 4),
    ('TANKEN', 'Nachfüllen', 'A', 6, 1, 6),
    ('BELEG', 'Quittung', 'A', 6, 8, 5),
    ('PIER', 'Anleger', 'A', 7, 2, 4),
    ('MARODE', 'baufällig', 'A', 7, 7, 6),
    ('SPERRT', 'blockiert', 'A', 8, 1, 6),
    ('UNTEN', 'am Grund', 'A', 8, 8, 5),
    ('KOENNT', 'vermögt', 'D', 1, 1, 6),
    ('UMSO', 'desto', 'D', 1, 2, 4),
    ('APP', 'Anwendung', 'D', 6, 2, 3),
    ('RAET', 'empfiehlt', 'D', 1, 3, 4),
    ('NIE', 'nimmer', 'D', 6, 3, 3),
    ('LECKER', 'köstlich', 'D', 3, 4, 6),
    ('HERR', 'Gebieter', 'D', 5, 5, 4),
    ('HIERAN', 'daran', 'D', 1, 6, 6),
    ('UNMUT', 'Ärger', 'D', 1, 7, 5),
    ('TOPF', 'Kochgeschirr', 'D', 1, 8, 4),
    ('BAU', 'Gebäude', 'D', 6, 8, 3),
    ('FEDERN', 'Gefieder', 'D', 3, 9, 6),
    ('WEIN', 'Rebensaft', 'D', 1, 10, 4),
    ('LOT', 'Senkblei', 'D', 6, 10, 3),
    ('IHN', 'Akkusativ von er', 'D', 1, 11, 3),
    ('OEDE', 'langweilig', 'D', 5, 11, 4),
    ('REGE', 'lebhaft', 'D', 1, 12, 4),
    ('GEN', 'nach', 'D', 6, 12, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r025-9x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r025-9x13-03', 'Rätsel 25 · 9×13', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '9x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('INNE', '... halten', 'A', 1, 1, 4),
    ('SCHWIEG', 'sagte nichts', 'A', 1, 6, 7),
    ('SUENDE', 'Frevel', 'A', 2, 1, 6),
    ('EICHE', 'Laubbaum', 'A', 2, 8, 5),
    ('TRUGEN', 'schleppten', 'A', 3, 1, 6),
    ('GEHEN', 'laufen', 'A', 3, 8, 5),
    ('BAUT', 'errichtet', 'A', 4, 5, 4),
    ('RATE', 'Teilzahlung', 'A', 5, 4, 4),
    ('ROSA', 'Pink', 'A', 5, 9, 4),
    ('ENDET', 'hört auf', 'A', 6, 1, 5),
    ('BRUDER', 'Mönch', 'A', 6, 7, 6),
    ('REIST', 'fährt', 'A', 7, 1, 5),
    ('HEIM', 'Zuhause', 'A', 7, 9, 4),
    ('GUETERN', 'Waren', 'A', 8, 1, 7),
    ('ERDE', 'Welt', 'A', 8, 9, 4),
    ('IST', 'befindet sich', 'D', 1, 1, 3),
    ('BERG', 'Gipfel', 'D', 5, 1, 4),
    ('NUR', 'lediglich', 'D', 1, 2, 3),
    ('NEU', 'frisch', 'D', 6, 2, 3),
    ('NEUE', 'frische', 'D', 1, 3, 4),
    ('DIE', 'Artikel (weibl.)', 'D', 6, 3, 3),
    ('ENG', 'schmal', 'D', 1, 4, 3),
    ('REST', 'Überbleibsel', 'D', 5, 4, 4),
    ('DEBATTE', 'Diskussion', 'D', 2, 5, 7),
    ('SENAT', 'Ältestenrat', 'D', 1, 6, 5),
    ('UEBEN', 'trainieren', 'D', 4, 7, 5),
    ('HEGT', 'pflegt', 'D', 1, 8, 4),
    ('WIE', 'gleich', 'D', 1, 9, 3),
    ('RUHE', 'Stille', 'D', 5, 9, 4),
    ('ICH', 'Pronomen (1. Sg.)', 'D', 1, 10, 3),
    ('ODER', 'bzw.', 'D', 5, 10, 4),
    ('EHE', 'Bund fürs Leben', 'D', 1, 11, 3),
    ('SEID', 'existiert', 'D', 5, 11, 4),
    ('GEN', 'nach', 'D', 1, 12, 3),
    ('ARME', 'Mittellose', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r026-9x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r026-9x13-03', 'Rätsel 26 · 9×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ATEM', 'Luft', 'A', 1, 1, 4),
    ('WEISSES', 'helles', 'A', 1, 6, 7),
    ('SATIRE', 'Spottschrift', 'A', 2, 1, 6),
    ('SEINE', 'ihre', 'A', 2, 8, 5),
    ('STATUS', 'Zustand', 'A', 3, 1, 6),
    ('SIEGT', 'gewinnt', 'A', 3, 8, 5),
    ('HEBT', 'stemmt', 'A', 4, 5, 4),
    ('MINE', 'Bergwerk', 'A', 5, 4, 4),
    ('REGE', 'lebhaft', 'A', 5, 9, 4),
    ('OBLAG', 'war Pflicht', 'A', 6, 1, 5),
    ('TRAGEN', 'schleppen', 'A', 6, 7, 6),
    ('REALE', 'wirkliche', 'A', 7, 1, 5),
    ('BALD', 'demnächst', 'A', 7, 9, 4),
    ('EIGENEN', 'persönlichen', 'A', 8, 1, 7),
    ('ELBE', 'Strom durch Dresden', 'A', 8, 9, 4),
    ('ASS', 'speiste', 'D', 1, 1, 3),
    ('TORE', 'Treffer', 'D', 5, 1, 4),
    ('TAT', 'Handlung', 'D', 1, 2, 3),
    ('BEI', 'nahe an', 'D', 6, 2, 3),
    ('ETAT', 'Budget', 'D', 1, 3, 4),
    ('LAG', 'ruhte', 'D', 6, 3, 3),
    ('MIT', 'samt', 'D', 1, 4, 3),
    ('MALE', 'Zeichen', 'D', 5, 4, 4),
    ('RUHIGEN', 'stillen', 'D', 2, 5, 7),
    ('WESEN', 'Kreatur', 'D', 1, 6, 5),
    ('BETON', 'Baustoff', 'D', 4, 7, 5),
    ('ISST', 'speist', 'D', 1, 8, 4),
    ('SEI', 'existiere', 'D', 1, 9, 3),
    ('RABE', 'Krähenvogel', 'D', 5, 9, 4),
    ('SIE', 'Anrede', 'D', 1, 10, 3),
    ('EGAL', 'gleichgültig', 'D', 5, 10, 4),
    ('ENG', 'schmal', 'D', 1, 11, 3),
    ('GELB', 'sonnenfarben', 'D', 5, 11, 4),
    ('SET', 'Satz', 'D', 1, 12, 3),
    ('ENDE', 'Schluss', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r027-9x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r027-9x13-03', 'Rätsel 27 · 9×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '9x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AHNT', 'vermutet', 'A', 1, 1, 4),
    ('HIERAUS', 'daraus', 'A', 1, 6, 7),
    ('LAEUFE', 'Rennen', 'A', 2, 1, 6),
    ('LAUNE', 'Stimmung', 'A', 2, 8, 5),
    ('BITTER', 'herb', 'A', 3, 1, 6),
    ('BREIT', 'weit', 'A', 3, 8, 5),
    ('IDEE', 'Einfall', 'A', 4, 5, 4),
    ('HEER', 'Armee', 'A', 5, 4, 4),
    ('JULI', '7. Monat', 'A', 5, 9, 4),
    ('INDER', 'Asiate', 'A', 6, 1, 5),
    ('BIETER', 'Interessent', 'A', 6, 7, 6),
    ('NEIGT', 'tendiert', 'A', 7, 1, 5),
    ('NASE', 'Riechorgan', 'A', 7, 9, 4),
    ('GUETERN', 'Waren', 'A', 8, 1, 7),
    ('EHEN', 'Bündnisse', 'A', 8, 9, 4),
    ('ALB', 'Gebirge', 'D', 1, 1, 3),
    ('FING', 'erwischte', 'D', 5, 1, 4),
    ('HAI', 'Raubfisch', 'D', 1, 2, 3),
    ('NEU', 'frisch', 'D', 6, 2, 3),
    ('NETZ', 'Geflecht', 'D', 1, 3, 4),
    ('DIE', 'Artikel (weibl.)', 'D', 6, 3, 3),
    ('TUT', 'macht', 'D', 1, 4, 3),
    ('HEGT', 'pflegt', 'D', 5, 4, 4),
    ('FEIERTE', 'zelebrierte', 'D', 2, 5, 7),
    ('HERDE', 'Schar', 'D', 1, 6, 5),
    ('ERBIN', 'Nachkommin', 'D', 4, 7, 5),
    ('ELBE', 'Strom durch Dresden', 'D', 1, 8, 4),
    ('RAR', 'selten', 'D', 1, 9, 3),
    ('JENE', 'selbige', 'D', 5, 9, 4),
    ('AUE', 'Talwiese', 'D', 1, 10, 3),
    ('UTAH', 'Mormonenstaat', 'D', 5, 10, 4),
    ('UNI', 'Hochschule', 'D', 1, 11, 3),
    ('LESE', 'schmökere', 'D', 5, 11, 4),
    ('SET', 'Satz', 'D', 1, 12, 3),
    ('IREN', 'Gälen', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r028-10x10-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r028-10x10-01', 'Rätsel 28 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('EHE', 'Bund fürs Leben', 'A', 1, 1, 3),
    ('HAUS', 'Gebäude', 'A', 1, 6, 4),
    ('HALBE', 'zur ... Stunde', 'A', 2, 1, 5),
    ('UNI', 'Hochschule', 'A', 2, 7, 3),
    ('RABE', 'Krähenvogel', 'A', 3, 1, 4),
    ('OEDE', 'langweilig', 'A', 3, 6, 4),
    ('TRESOR', 'Safe', 'A', 4, 1, 6),
    ('SETZTE', 'stellte', 'A', 5, 4, 6),
    ('TAFEL', 'Schild', 'A', 6, 1, 5),
    ('WAS', 'Fragewort (Sache)', 'A', 6, 7, 3),
    ('EUER', 'Possessiv (ihr)', 'A', 7, 1, 4),
    ('TAGS', '... darauf', 'A', 7, 6, 4),
    ('ALLE', 'sämtliche', 'A', 8, 1, 4),
    ('ENTE', 'Wasservogel', 'A', 8, 6, 4),
    ('MAL', 'Zeichen ×', 'A', 9, 1, 3),
    ('GEGEN', 'wider', 'A', 9, 5, 5),
    ('EHRT', 'würdigt', 'D', 1, 1, 4),
    ('TEAM', 'Mannschaft', 'D', 6, 1, 4),
    ('HAAR', 'Strähne', 'D', 1, 2, 4),
    ('AULA', 'Festsaal', 'D', 6, 2, 4),
    ('ELBE', 'Strom durch Dresden', 'D', 1, 3, 4),
    ('FELL', 'Pelz', 'D', 6, 3, 4),
    ('BESSERE', 'überlegene', 'D', 2, 4, 7),
    ('OEL', 'Schmierstoff', 'D', 4, 5, 3),
    ('ORT', 'Stelle', 'D', 3, 6, 3),
    ('TEE', 'Heißgetränk', 'D', 7, 6, 3),
    ('AUE', 'Talwiese', 'D', 1, 7, 3),
    ('ZWANG', 'Druck', 'D', 5, 7, 5),
    ('UND', 'sowie', 'D', 1, 8, 3),
    ('TAGTE', 'beriet', 'D', 5, 8, 5),
    ('SIE', 'Anrede', 'D', 1, 9, 3),
    ('ESSEN', 'Mahlzeit', 'D', 5, 9, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r029-10x10-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r029-10x10-01', 'Rätsel 29 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AUF', 'offen', 'A', 1, 1, 3),
    ('AMTS', 'im ... sein', 'A', 1, 6, 4),
    ('TREFF', 'Stelldichein', 'A', 2, 1, 5),
    ('AUE', 'Talwiese', 'A', 2, 7, 3),
    ('ENTE', 'Wasservogel', 'A', 3, 1, 4),
    ('ALTE', 'betagte', 'A', 3, 6, 4),
    ('METALL', 'Werkstoff', 'A', 4, 1, 6),
    ('TASCHE', 'Beutel', 'A', 5, 4, 6),
    ('BEZUG', 'Überzug', 'A', 6, 1, 5),
    ('HAI', 'Raubfisch', 'A', 6, 7, 3),
    ('EUER', 'Possessiv (ihr)', 'A', 7, 1, 4),
    ('PASS', 'Ausweis', 'A', 7, 6, 4),
    ('ARIE', 'Sologesang', 'A', 8, 1, 4),
    ('ROSE', 'Blume mit Dornen', 'A', 8, 6, 4),
    ('TOT', 'leblos', 'A', 9, 1, 3),
    ('ROSEN', 'Dornblumen', 'A', 9, 5, 5),
    ('ATEM', 'Luft', 'D', 1, 1, 4),
    ('BEAT', 'Rhythmus', 'D', 6, 1, 4),
    ('URNE', 'Aschengefäß', 'D', 1, 2, 4),
    ('EURO', 'Währung', 'D', 6, 2, 4),
    ('FETT', 'Schmalz', 'D', 1, 3, 4),
    ('ZEIT', 'Dauer', 'D', 6, 3, 4),
    ('FEATURE', 'Merkmal', 'D', 2, 4, 7),
    ('LAG', 'ruhte', 'D', 4, 5, 3),
    ('ALS', 'da, während', 'D', 3, 6, 3),
    ('PRO', 'je', 'D', 7, 6, 3),
    ('MAL', 'Zeichen ×', 'D', 1, 7, 3),
    ('CHAOS', 'Wirrwarr', 'D', 5, 7, 5),
    ('TUT', 'macht', 'D', 1, 8, 3),
    ('HASSE', 'verabscheue', 'D', 5, 8, 5),
    ('SEE', 'Gewässer', 'D', 1, 9, 3),
    ('EISEN', 'Metall', 'D', 5, 9, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r030-10x10-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r030-10x10-01', 'Rätsel 30 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AUS', 'vorbei', 'A', 1, 1, 3),
    ('LIVE', 'direkt', 'A', 1, 6, 4),
    ('KRAFT', 'Stärke', 'A', 2, 1, 5),
    ('HIN', '... und her', 'A', 2, 7, 3),
    ('KINO', 'Filmtheater', 'A', 3, 1, 4),
    ('PRAG', 'Moldau-Stadt', 'A', 3, 6, 4),
    ('UNKLAR', 'vage', 'A', 4, 1, 6),
    ('GROBEN', 'rauen', 'A', 5, 4, 6),
    ('HOHEM', 'großem', 'A', 6, 1, 5),
    ('RIO', 'Stadt in Brasilien', 'A', 6, 7, 3),
    ('EHEN', 'Bündnisse', 'A', 7, 1, 4),
    ('MINE', 'Bergwerk', 'A', 7, 6, 4),
    ('MILD', 'sanft', 'A', 8, 1, 4),
    ('ISST', 'speist', 'A', 8, 6, 4),
    ('DOM', 'Kathedrale', 'A', 9, 1, 3),
    ('TRETE', 'kicke', 'A', 9, 5, 5),
    ('AKKU', 'Batterie', 'D', 1, 1, 4),
    ('HEMD', 'Oberteil', 'D', 6, 1, 4),
    ('URIN', 'Harn', 'D', 1, 2, 4),
    ('OHIO', 'Staat um Cleveland', 'D', 6, 2, 4),
    ('SANK', 'fiel', 'D', 1, 3, 4),
    ('HELM', 'Kopfschutz', 'D', 6, 3, 4),
    ('FOLGEND', 'nachstehend', 'D', 2, 4, 7),
    ('ARM', 'Gliedmaße', 'D', 4, 5, 3),
    ('PRO', 'je', 'D', 3, 6, 3),
    ('MIR', 'Dat. (1. Pers.)', 'D', 7, 6, 3),
    ('IHR', 'Pronomen (2. Pl.)', 'D', 1, 7, 3),
    ('BRISE', 'Lüftchen', 'D', 5, 7, 5),
    ('VIA', 'über', 'D', 1, 8, 3),
    ('EINST', 'früher', 'D', 5, 8, 5),
    ('ENG', 'schmal', 'D', 1, 9, 3),
    ('NOETE', 'Sorgen', 'D', 5, 9, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r031-10x10-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r031-10x10-02', 'Rätsel 31 · 10×10', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '10x10-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ART', 'Sorte', 'A', 1, 1, 3),
    ('GOTHA', 'Stadt in Thüringen', 'A', 1, 5, 5),
    ('LAEGE', 'ruhte', 'A', 2, 1, 5),
    ('RAR', 'selten', 'A', 2, 7, 3),
    ('STEIN', 'Fels', 'A', 3, 1, 5),
    ('ULM', 'Münsterstadt', 'A', 3, 7, 3),
    ('FRAGTE', 'erkundigte sich', 'A', 4, 4, 6),
    ('KETTEN', 'Fesseln', 'A', 5, 1, 6),
    ('OMA', 'Großmutter', 'A', 6, 1, 3),
    ('KAUF', 'Erwerb', 'A', 6, 6, 4),
    ('MAN', 'jemand', 'A', 7, 1, 3),
    ('TEUFE', 'Tiefe (Bergbau)', 'A', 7, 5, 5),
    ('MIT', 'samt', 'A', 8, 1, 3),
    ('ORTES', 'Name des ...', 'A', 8, 5, 5),
    ('ELEND', 'Jammer', 'A', 9, 1, 5),
    ('ORT', 'Stelle', 'A', 9, 7, 3),
    ('ALS', 'da, während', 'D', 1, 1, 3),
    ('KOMME', 'ich ... an', 'D', 5, 1, 5),
    ('RAT', 'Tipp', 'D', 1, 2, 3),
    ('EMAIL', 'elektr. Post', 'D', 5, 2, 5),
    ('TEE', 'Heißgetränk', 'D', 1, 3, 3),
    ('TANTE', 'Muhme', 'D', 5, 3, 5),
    ('GIFT', 'Toxin', 'D', 2, 4, 4),
    ('GENRE', 'Gattung', 'D', 1, 5, 5),
    ('TOD', 'Ableben', 'D', 7, 5, 3),
    ('ANKER', 'Halt', 'D', 4, 6, 5),
    ('TRUG', 'schleppte', 'D', 1, 7, 4),
    ('AUTO', 'Pkw', 'D', 6, 7, 4),
    ('HALT', 'eben', 'D', 1, 8, 4),
    ('UFER', 'Gestade', 'D', 6, 8, 4),
    ('ARME', 'Mittellose', 'D', 1, 9, 4),
    ('FEST', 'stabil', 'D', 6, 9, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r032-10x10-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r032-10x10-02', 'Rätsel 32 · 10×10', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '10x10-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AMT', 'Behörde', 'A', 1, 1, 3),
    ('ABEND', 'Tagesende', 'A', 1, 5, 5),
    ('LIEST', 'schmökert', 'A', 2, 1, 5),
    ('SEI', 'existiere', 'A', 2, 7, 3),
    ('STEIL', 'abschüssig', 'A', 3, 1, 5),
    ('SIE', 'Anrede', 'A', 3, 7, 3),
    ('NAMENS', 'genannt', 'A', 4, 4, 6),
    ('EBENSO', 'gleichfalls', 'A', 5, 1, 6),
    ('TOR', 'Treffer', 'A', 6, 1, 3),
    ('RAET', 'empfiehlt', 'A', 6, 6, 4),
    ('WEN', 'Fragewort (Akk.)', 'A', 7, 1, 3),
    ('HAUSE', 'zu ...', 'A', 7, 5, 5),
    ('ASS', 'speiste', 'A', 8, 1, 3),
    ('ALLES', 'sämtliches', 'A', 8, 5, 5),
    ('SETZT', 'stellt', 'A', 9, 1, 5),
    ('ALT', 'betagt', 'A', 9, 7, 3),
    ('ALS', 'da, während', 'D', 1, 1, 3),
    ('ETWAS', 'ein wenig', 'D', 5, 1, 5),
    ('MIT', 'samt', 'D', 1, 2, 3),
    ('BOESE', 'gemein', 'D', 5, 2, 5),
    ('TEE', 'Heißgetränk', 'D', 1, 3, 3),
    ('ERNST', 'Seriosität', 'D', 5, 3, 5),
    ('SINN', 'Bedeutung', 'D', 2, 4, 4),
    ('ATLAS', 'Kartenwerk', 'D', 1, 5, 5),
    ('HAT', 'besitzt', 'D', 7, 5, 3),
    ('MORAL', 'Ethik', 'D', 4, 6, 5),
    ('ESSE', 'speise', 'D', 1, 7, 4),
    ('AULA', 'Festsaal', 'D', 6, 7, 4),
    ('NEIN', 'Ablehnung', 'D', 1, 8, 4),
    ('ESEL', 'Grautier', 'D', 6, 8, 4),
    ('DIES', 'das hier', 'D', 1, 9, 4),
    ('TEST', 'Prüfung', 'D', 6, 9, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r033-10x10-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r033-10x10-02', 'Rätsel 33 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ANS', 'an das', 'A', 1, 1, 3),
    ('SZENE', 'Auftritt', 'A', 1, 5, 5),
    ('REIFE', 'Mündigkeit', 'A', 2, 1, 5),
    ('HAB', '... und Gut', 'A', 2, 7, 3),
    ('MUELL', 'Abfall', 'A', 3, 1, 5),
    ('EHE', 'Bund fürs Leben', 'A', 3, 7, 3),
    ('OBEREN', 'höher gelegenen', 'A', 4, 4, 6),
    ('KEEPER', 'Torwart', 'A', 5, 1, 6),
    ('NIX', 'nichts', 'A', 6, 1, 3),
    ('KIES', 'Schotter', 'A', 6, 6, 4),
    ('OFT', 'häufig', 'A', 7, 1, 3),
    ('HERDE', 'Schar', 'A', 7, 5, 5),
    ('PER', 'mittels', 'A', 8, 1, 3),
    ('IRREN', 'sich täuschen', 'A', 8, 5, 5),
    ('FRAGT', 'erkundigt sich', 'A', 9, 1, 5),
    ('ELF', 'Zahl (10+1)', 'A', 9, 7, 3),
    ('ARM', 'Gliedmaße', 'D', 1, 1, 3),
    ('KNOPF', 'Taste', 'D', 5, 1, 5),
    ('NEU', 'frisch', 'D', 1, 2, 3),
    ('EIFER', 'Emsigkeit', 'D', 5, 2, 5),
    ('SIE', 'Anrede', 'D', 1, 3, 3),
    ('EXTRA', 'zusätzlich', 'D', 5, 3, 5),
    ('FLOP', 'Reinfall', 'D', 2, 4, 4),
    ('SELBE', 'gleiche', 'D', 1, 5, 5),
    ('HIT', 'Schlager', 'D', 7, 5, 3),
    ('ERKER', 'Vorbau', 'D', 4, 6, 5),
    ('EHER', 'lieber', 'D', 1, 7, 4),
    ('IRRE', 'Verrückte', 'D', 6, 7, 4),
    ('NAHE', 'dicht bei', 'D', 1, 8, 4),
    ('EDEL', 'vornehm', 'D', 6, 8, 4),
    ('EBEN', 'flach', 'D', 1, 9, 4),
    ('SENF', 'Mostrich', 'D', 6, 9, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r034-10x10-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r034-10x10-03', 'Rätsel 34 · 10×10', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '10x10-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('DEREN', 'dessen', 'A', 1, 1, 5),
    ('TOD', 'Ableben', 'A', 1, 7, 3),
    ('ABER', 'jedoch', 'A', 2, 1, 4),
    ('OPA', 'Großvater', 'A', 2, 7, 3),
    ('TEIL', 'Stück', 'A', 3, 1, 4),
    ('ODER', 'bzw.', 'A', 3, 6, 4),
    ('UNSICHER', 'zweifelnd', 'A', 4, 1, 8),
    ('METERN', 'nach hundert ...', 'A', 5, 1, 6),
    ('SAEULE', 'Pfeiler', 'A', 6, 4, 6),
    ('WEISS', 'schneefarben', 'A', 7, 1, 5),
    ('MIR', 'Dat. (1. Pers.)', 'A', 7, 7, 3),
    ('IHN', 'Akkusativ von er', 'A', 8, 1, 3),
    ('HASEN', 'Langohren', 'A', 8, 5, 5),
    ('REST', 'Überbleibsel', 'A', 9, 1, 4),
    ('OFT', 'häufig', 'A', 9, 7, 3),
    ('DATUM', 'Tagesangabe', 'D', 1, 1, 5),
    ('WIR', 'Pronomen (1. Pl.)', 'D', 7, 1, 3),
    ('EBENE', 'Fläche', 'D', 1, 2, 5),
    ('EHE', 'Bund fürs Leben', 'D', 7, 2, 3),
    ('REIST', 'fährt', 'D', 1, 3, 5),
    ('INS', 'in das', 'D', 7, 3, 3),
    ('ERLIESS', 'verfügte', 'D', 1, 4, 7),
    ('CRASH', 'Unfall', 'D', 4, 5, 5),
    ('OHNE', 'abzüglich', 'D', 3, 6, 4),
    ('TODE', 'zu ... betrübt', 'D', 1, 7, 4),
    ('UMSO', 'desto', 'D', 6, 7, 4),
    ('OPER', 'Musiktheater', 'D', 1, 8, 4),
    ('LIEF', 'rannte', 'D', 6, 8, 4),
    ('DAR', 'stellt ... (zeigt)', 'D', 1, 9, 3),
    ('LERNT', 'paukt', 'D', 5, 9, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r035-10x10-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r035-10x10-03', 'Rätsel 35 · 10×10', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '10x10-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('BLOED', 'doof', 'A', 1, 1, 5),
    ('AMT', 'Behörde', 'A', 1, 7, 3),
    ('LEST', 'studiert', 'A', 2, 1, 4),
    ('BAU', 'Gebäude', 'A', 2, 7, 3),
    ('AUCH', 'ebenfalls', 'A', 3, 1, 4),
    ('BETT', 'Schlafstätte', 'A', 3, 6, 4),
    ('STANDORT', 'Lage', 'A', 4, 1, 8),
    ('SERIEN', 'Reihen', 'A', 5, 1, 6),
    ('ERNSTE', 'seriöse', 'A', 6, 4, 6),
    ('SEINE', 'ihre', 'A', 7, 1, 5),
    ('TOT', 'leblos', 'A', 7, 7, 3),
    ('EIS', 'Gefrorenes', 'A', 8, 1, 3),
    ('NOETE', 'Sorgen', 'A', 8, 5, 5),
    ('ENTE', 'Wasservogel', 'A', 9, 1, 4),
    ('GEN', 'nach', 'A', 9, 7, 3),
    ('BLASS', 'bleich', 'D', 1, 1, 5),
    ('SEE', 'Gewässer', 'D', 7, 1, 3),
    ('LEUTE', 'Personen', 'D', 1, 2, 5),
    ('EIN', 'unbest. Artikel', 'D', 7, 2, 3),
    ('OSCAR', 'Filmpreis', 'D', 1, 3, 5),
    ('IST', 'befindet sich', 'D', 7, 3, 3),
    ('ETHNIEN', 'Volksgruppen', 'D', 1, 4, 7),
    ('DEREN', 'dessen', 'D', 4, 5, 5),
    ('BONN', 'Ex-Hauptstadt', 'D', 3, 6, 4),
    ('ABER', 'jedoch', 'D', 1, 7, 4),
    ('STEG', 'Brücklein', 'D', 6, 7, 4),
    ('MATT', 'Schachende', 'D', 1, 8, 4),
    ('TOTE', 'Verstorbene', 'D', 6, 8, 4),
    ('TUT', 'macht', 'D', 1, 9, 3),
    ('BETEN', 'flehen', 'D', 5, 9, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r036-10x10-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r036-10x10-03', 'Rätsel 36 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('KLARE', 'deutliche', 'A', 1, 1, 5),
    ('ULM', 'Münsterstadt', 'A', 1, 7, 3),
    ('LEGE', 'platziere', 'A', 2, 1, 4),
    ('NEU', 'frisch', 'A', 2, 7, 3),
    ('IGEL', 'Stacheltier', 'A', 3, 1, 4),
    ('GIBT', 'schenkt', 'A', 3, 6, 4),
    ('MANIFEST', 'Programm', 'A', 4, 1, 8),
    ('ALTERN', 'Reifen', 'A', 5, 1, 6),
    ('FIELEN', 'stürzten', 'A', 6, 4, 6),
    ('BOSSE', 'Chefs', 'A', 7, 1, 5),
    ('EID', 'Schwur', 'A', 7, 7, 3),
    ('EHE', 'Bund fürs Leben', 'A', 8, 1, 3),
    ('SEILE', 'Taue', 'A', 8, 5, 5),
    ('IREN', 'Gälen', 'A', 9, 1, 4),
    ('DEM', 'Artikel (Dativ)', 'A', 9, 7, 3),
    ('KLIMA', 'Wetterlage', 'D', 1, 1, 5),
    ('BEI', 'nahe an', 'D', 7, 1, 3),
    ('LEGAL', 'rechtmäßig', 'D', 1, 2, 5),
    ('OHR', 'Hörorgan', 'D', 7, 2, 3),
    ('AGENT', 'Spion', 'D', 1, 3, 5),
    ('SEE', 'Gewässer', 'D', 7, 3, 3),
    ('RELIEFS', 'Flachbilder', 'D', 1, 4, 7),
    ('FRIES', 'Zierstreifen', 'D', 4, 5, 5),
    ('GENE', 'Erbanlagen', 'D', 3, 6, 4),
    ('UNIS', 'Hochschulen', 'D', 1, 7, 4),
    ('LEID', 'Kummer', 'D', 6, 7, 4),
    ('LEBT', 'existiert', 'D', 1, 8, 4),
    ('EILE', 'Hast', 'D', 6, 8, 4),
    ('MUT', 'Courage', 'D', 1, 9, 3),
    ('INDEM', 'dadurch dass', 'D', 5, 9, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r037-10x10-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r037-10x10-04', 'Rätsel 37 · 10×10', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '10x10-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('PLUS', 'Überschuss', 'A', 1, 1, 4),
    ('DEMO', 'Kundgebung', 'A', 1, 6, 4),
    ('OEL', 'Schmierstoff', 'A', 2, 1, 3),
    ('TAXIS', 'Droschken', 'A', 2, 5, 5),
    ('LIMA', 'peruan. Hauptstadt', 'A', 3, 1, 4),
    ('RAET', 'empfiehlt', 'A', 3, 6, 4),
    ('ODER', 'bzw.', 'A', 4, 1, 4),
    ('AKTE', 'Dokument', 'A', 4, 6, 4),
    ('ERBAUTEN', 'errichteten', 'A', 5, 2, 8),
    ('ELF', 'Zahl (10+1)', 'A', 6, 4, 3),
    ('EMAIL', 'elektr. Post', 'A', 7, 1, 5),
    ('BIN', 'existiere', 'A', 7, 7, 3),
    ('LAUTE', 'Töne', 'A', 8, 1, 5),
    ('UNI', 'Hochschule', 'A', 8, 7, 3),
    ('BIS', 'nicht später als', 'A', 9, 1, 3),
    ('MASSE', 'Menge', 'A', 9, 5, 5),
    ('POLO', 'Ballsport zu Pferd', 'D', 1, 1, 4),
    ('GELB', 'sonnenfarben', 'D', 6, 1, 4),
    ('LEIDE', 'dulde', 'D', 1, 2, 5),
    ('MAI', '5. Monat', 'D', 7, 2, 3),
    ('ULMER', '... Münster', 'D', 1, 3, 5),
    ('AUS', 'vorbei', 'D', 7, 3, 3),
    ('ARBEIT', 'Tätigkeit', 'D', 3, 4, 6),
    ('ALLEM', 'vor ...', 'D', 5, 5, 5),
    ('DARAUF', 'hernach', 'D', 1, 6, 6),
    ('EXAKT', 'genau', 'D', 1, 7, 5),
    ('BUS', 'Car (schweiz.)', 'D', 7, 7, 3),
    ('MIETE', 'Pacht', 'D', 1, 8, 5),
    ('INS', 'in das', 'D', 7, 8, 3),
    ('OSTEN', 'Richtung O', 'D', 1, 9, 5),
    ('NIE', 'nimmer', 'D', 7, 9, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r038-10x10-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r038-10x10-04', 'Rätsel 38 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ENDE', 'Schluss', 'A', 1, 1, 4),
    ('GABE', 'Geschenk', 'A', 1, 6, 4),
    ('WAR', 'existierte', 'A', 2, 1, 3),
    ('REGER', 'lebhafter', 'A', 2, 5, 5),
    ('IDOL', 'Vorbild', 'A', 3, 1, 4),
    ('WERK', 'Fabrik', 'A', 3, 6, 4),
    ('GEHE', 'laufe', 'A', 4, 1, 4),
    ('ENGE', 'schmale', 'A', 4, 6, 4),
    ('LEICHTER', 'müheloser', 'A', 5, 2, 8),
    ('DER', 'Artikel (männl.)', 'A', 6, 4, 3),
    ('BOTEN', 'offerierten', 'A', 7, 1, 5),
    ('BEI', 'nahe an', 'A', 7, 7, 3),
    ('SPORT', 'Leibesübung', 'A', 8, 1, 5),
    ('INS', 'in das', 'A', 8, 7, 3),
    ('TAT', 'Handlung', 'A', 9, 1, 3),
    ('SINGT', 'trällert', 'A', 9, 5, 5),
    ('EWIG', 'endlos', 'D', 1, 1, 4),
    ('OBST', 'Früchte', 'D', 6, 1, 4),
    ('NADEL', 'Nähwerkzeug', 'D', 1, 2, 5),
    ('OPA', 'Großvater', 'D', 7, 2, 3),
    ('DROHE', 'stehe bevor', 'D', 1, 3, 5),
    ('TOT', 'leblos', 'D', 7, 3, 3),
    ('LEIDER', 'schade', 'D', 3, 4, 6),
    ('CENTS', 'Hundertstel', 'D', 5, 5, 5),
    ('GEWEHR', 'Flinte', 'D', 1, 6, 6),
    ('AGENT', 'Spion', 'D', 1, 7, 5),
    ('BIN', 'existiere', 'D', 7, 7, 3),
    ('BERGE', 'Gipfel', 'D', 1, 8, 5),
    ('ENG', 'schmal', 'D', 7, 8, 3),
    ('ERKER', 'Vorbau', 'D', 1, 9, 5),
    ('IST', 'befindet sich', 'D', 7, 9, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r039-10x10-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r039-10x10-04', 'Rätsel 39 · 10×10', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '10x10-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('OMEN', 'Vorzeichen', 'A', 1, 1, 4),
    ('AKKU', 'Batterie', 'A', 1, 6, 4),
    ('FIX', 'schnell', 'A', 2, 1, 3),
    ('REALE', 'wirkliche', 'A', 2, 5, 5),
    ('ENTE', 'Wasservogel', 'A', 3, 1, 4),
    ('STAB', 'Stock', 'A', 3, 6, 4),
    ('NERV', 'Reizleiter', 'A', 4, 1, 4),
    ('TAGT', 'berät', 'A', 4, 6, 4),
    ('NAEHERTE', 'kam heran', 'A', 5, 2, 8),
    ('NUN', 'jetzt', 'A', 6, 4, 3),
    ('TOBTE', 'wütete', 'A', 7, 1, 5),
    ('AST', 'Zweig', 'A', 7, 7, 3),
    ('WEIST', 'zeigt', 'A', 8, 1, 5),
    ('RIO', 'Stadt in Brasilien', 'A', 8, 7, 3),
    ('ALT', 'betagt', 'A', 9, 1, 3),
    ('EIMER', 'Kübel', 'A', 9, 5, 5),
    ('OFEN', 'Herd', 'D', 1, 1, 4),
    ('ETWA', 'ungefähr', 'D', 6, 1, 4),
    ('MINEN', 'Bergwerke', 'D', 1, 2, 5),
    ('OEL', 'Schmierstoff', 'D', 7, 2, 3),
    ('EXTRA', 'zusätzlich', 'D', 1, 3, 5),
    ('BIT', 'Binärziffer', 'D', 7, 3, 3),
    ('EVENTS', 'Anlässe', 'D', 3, 4, 6),
    ('HUETE', 'Kappen', 'D', 5, 5, 5),
    ('AESTEN', 'Zweigen', 'D', 1, 6, 6),
    ('KATAR', 'Golfstaat', 'D', 1, 7, 5),
    ('ARM', 'Gliedmaße', 'D', 7, 7, 3),
    ('KLAGT', 'jammert', 'D', 1, 8, 5),
    ('SIE', 'Anrede', 'D', 7, 8, 3),
    ('UEBTE', 'trainierte', 'D', 1, 9, 5),
    ('TOR', 'Treffer', 'D', 7, 9, 3)
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
    ('ZONE', 'Bereich', 'A', 1, 1, 4),
    ('HEUTE', 'jetzt', 'A', 1, 6, 5),
    ('OPA', 'Großvater', 'A', 2, 1, 3),
    ('MAN', 'jemand', 'A', 2, 8, 3),
    ('GEHIRN', 'Denkorgan', 'A', 3, 1, 6),
    ('BUG', 'Vorderschiff', 'A', 3, 8, 3),
    ('SAFE', 'Tresor', 'A', 4, 7, 4),
    ('ENKEL', 'Kindeskind', 'A', 5, 1, 5),
    ('TUER', 'Pforte', 'A', 5, 7, 4),
    ('REALE', 'wirkliche', 'A', 6, 3, 5),
    ('WIE', 'gleich', 'A', 7, 1, 3),
    ('GILDE', 'Zunft', 'A', 7, 5, 5),
    ('IRIS', 'Schwertlilie', 'A', 8, 1, 4),
    ('CLANS', 'Sippen', 'A', 8, 6, 5),
    ('ERDE', 'Welt', 'A', 9, 1, 4),
    ('HERDE', 'Schar', 'A', 9, 6, 5),
    ('STEIGT', 'klettert', 'A', 10, 1, 6),
    ('FEE', 'Zauberin', 'A', 10, 8, 3),
    ('ZOG', 'zerrte', 'D', 1, 1, 3),
    ('ERWIES', 'zeigte', 'D', 5, 1, 6),
    ('OPERN', 'Musikdramen', 'D', 1, 2, 5),
    ('IRRT', 'täuscht sich', 'D', 7, 2, 4),
    ('NAH', 'dicht', 'D', 1, 3, 3),
    ('KREIDE', 'Tafelstift', 'D', 5, 3, 6),
    ('IDEE', 'Einfall', 'D', 3, 4, 4),
    ('SEI', 'existiere', 'D', 8, 4, 3),
    ('LAG', 'ruhte', 'D', 5, 5, 3),
    ('HIN', '... und her', 'D', 1, 6, 3),
    ('LICHT', 'Helligkeit', 'D', 6, 6, 5),
    ('STELLE', 'Posten', 'D', 4, 7, 6),
    ('UMBAU', 'Renovierung', 'D', 1, 8, 5),
    ('DARF', 'kann', 'D', 7, 8, 4),
    ('TAUFE', 'Sakrament', 'D', 1, 9, 5),
    ('ENDE', 'Schluss', 'D', 7, 9, 4),
    ('ENGERE', 'schmalere', 'D', 1, 10, 6),
    ('SEE', 'Gewässer', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r041-11x11-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r041-11x11-01', 'Rätsel 41 · 11×11', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '11x11-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('OKAY', 'in Ordnung', 'A', 1, 1, 4),
    ('TIEFE', 'Abgrund', 'A', 1, 6, 5),
    ('PER', 'mittels', 'A', 2, 1, 3),
    ('MAL', 'Zeichen ×', 'A', 2, 8, 3),
    ('ANTRAG', 'Gesuch', 'A', 3, 1, 6),
    ('ASS', 'speiste', 'A', 3, 8, 3),
    ('MIST', 'Dung', 'A', 4, 7, 4),
    ('MAHNT', 'warnt', 'A', 5, 1, 5),
    ('ALTE', 'betagte', 'A', 5, 7, 4),
    ('IDEEN', 'Einfälle', 'A', 6, 3, 5),
    ('SIE', 'Anrede', 'A', 7, 1, 3),
    ('ENDET', 'hört auf', 'A', 7, 5, 5),
    ('EHRE', 'Würde', 'A', 8, 1, 4),
    ('DATEI', 'Dokument', 'A', 8, 6, 5),
    ('URIN', 'Harn', 'A', 9, 1, 4),
    ('ETWAS', 'ein wenig', 'A', 9, 6, 5),
    ('MENGEN', 'Massen', 'A', 10, 1, 6),
    ('AMT', 'Behörde', 'A', 10, 8, 3),
    ('OPA', 'Großvater', 'D', 1, 1, 3),
    ('MUSEUM', 'Galerie', 'D', 5, 1, 6),
    ('KENIA', 'Staat in Ostafrika', 'D', 1, 2, 5),
    ('IHRE', 'seine', 'D', 7, 2, 4),
    ('ART', 'Sorte', 'D', 1, 3, 3),
    ('HIERIN', 'darin', 'D', 5, 3, 6),
    ('RUND', 'kreisförmig', 'D', 3, 4, 4),
    ('ENG', 'schmal', 'D', 8, 4, 3),
    ('TEE', 'Heißgetränk', 'D', 5, 5, 3),
    ('TAG', '24 Stunden', 'D', 1, 6, 3),
    ('ENDEN', 'aufhören', 'D', 6, 6, 5),
    ('MANDAT', 'Auftrag', 'D', 4, 7, 6),
    ('EMAIL', 'elektr. Post', 'D', 1, 8, 5),
    ('ETWA', 'ungefähr', 'D', 7, 8, 4),
    ('FASST', 'packt', 'D', 1, 9, 5),
    ('TEAM', 'Mannschaft', 'D', 7, 9, 4),
    ('ELSTER', 'Rabenvogel', 'D', 1, 10, 6),
    ('IST', 'befindet sich', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r042-11x11-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r042-11x11-01', 'Rätsel 42 · 11×11', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '11x11-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AFFE', 'Primat', 'A', 1, 1, 4),
    ('ELFTE', 'nach der zehnten', 'A', 1, 6, 5),
    ('SEE', 'Gewässer', 'A', 2, 1, 3),
    ('RAR', 'selten', 'A', 2, 8, 3),
    ('TIEFES', 'abgründiges', 'A', 3, 1, 6),
    ('INS', 'in das', 'A', 3, 8, 3),
    ('SEKT', 'Schaumwein', 'A', 4, 7, 4),
    ('GENUA', 'Hafenstadt Italiens', 'A', 5, 1, 5),
    ('ESSE', 'speise', 'A', 5, 7, 4),
    ('ALLZU', 'übermäßig', 'A', 6, 3, 5),
    ('EHE', 'Bund fürs Leben', 'A', 7, 1, 3),
    ('BUCHS', 'Autor des ...', 'A', 7, 5, 5),
    ('SEHT', 'schaut', 'A', 8, 1, 4),
    ('CHAOS', 'Wirrwarr', 'A', 8, 6, 5),
    ('TREU', 'loyal', 'A', 9, 1, 4),
    ('HELFE', 'unterstütze', 'A', 9, 6, 5),
    ('ERREGT', 'nervös', 'A', 10, 1, 6),
    ('FAX', 'Fernkopie', 'A', 10, 8, 3),
    ('AST', 'Zweig', 'D', 1, 1, 3),
    ('GAESTE', 'Besucher', 'D', 5, 1, 6),
    ('FEINE', 'zarte', 'D', 1, 2, 5),
    ('HERR', 'Gebieter', 'D', 7, 2, 4),
    ('FEE', 'Zauberin', 'D', 1, 3, 3),
    ('NAEHER', 'dichter', 'D', 5, 3, 6),
    ('FOUL', 'Regelverstoß', 'D', 3, 4, 4),
    ('TUE', 'mache', 'D', 8, 4, 3),
    ('ALB', 'Gebirge', 'D', 5, 5, 3),
    ('EIS', 'Gefrorenes', 'D', 1, 6, 3),
    ('ZUCHT', 'Disziplin', 'D', 6, 6, 5),
    ('SEUCHE', 'Epidemie', 'D', 4, 7, 6),
    ('FRIES', 'Zierstreifen', 'D', 1, 8, 5),
    ('HALF', 'stand bei', 'D', 7, 8, 4),
    ('TANKS', 'Behälter', 'D', 1, 9, 5),
    ('SOFA', 'Couch', 'D', 7, 9, 4),
    ('ERSTEM', 'beim ... Mal', 'D', 1, 10, 6),
    ('SEX', 'Erotik', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r043-11x11-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r043-11x11-02', 'Rätsel 43 · 11×11', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '11x11-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ERZ', 'Gestein', 'A', 1, 1, 3),
    ('PARTEI', 'Lager', 'A', 1, 5, 6),
    ('TEAM', 'Mannschaft', 'A', 2, 1, 4),
    ('PARIS', 'Seine-Stadt', 'A', 2, 6, 5),
    ('WIE', 'gleich', 'A', 3, 1, 3),
    ('ORDENS', 'Mitglied des ...', 'A', 3, 5, 6),
    ('ACH', 'Ausruf', 'A', 4, 1, 3),
    ('VOLL', 'gefüllt', 'A', 5, 4, 4),
    ('STROH', 'Halme', 'A', 6, 1, 5),
    ('EURE', 'Possessiv (ihr)', 'A', 6, 7, 4),
    ('ANNEHMEN', 'vermuten', 'A', 7, 3, 8),
    ('INS', 'in das', 'A', 8, 1, 3),
    ('EINZUG', 'Einmarsch', 'A', 8, 5, 6),
    ('SEES', 'Ufer des ...', 'A', 9, 1, 4),
    ('LEUTE', 'Personen', 'A', 9, 6, 5),
    ('TUN', 'machen', 'A', 10, 1, 3),
    ('MENGEN', 'Massen', 'A', 10, 5, 6),
    ('ETWA', 'ungefähr', 'D', 1, 1, 4),
    ('IST', 'befindet sich', 'D', 8, 1, 3),
    ('REICHT', 'genügt', 'D', 1, 2, 6),
    ('NEU', 'frisch', 'D', 8, 2, 3),
    ('ZAEH', 'hartnäckig', 'D', 1, 3, 4),
    ('RASEN', 'Grünfläche', 'D', 6, 3, 5),
    ('VON', 'ab, aus', 'D', 5, 4, 3),
    ('OHNE', 'abzüglich', 'D', 5, 5, 4),
    ('APRIL', '4. Monat', 'D', 1, 6, 5),
    ('EILE', 'Hast', 'D', 7, 6, 4),
    ('RAD', 'Velo', 'D', 1, 7, 3),
    ('LEHNEN', 'stützen', 'D', 5, 7, 6),
    ('TREU', 'loyal', 'D', 1, 8, 4),
    ('UMZUG', 'Parade', 'D', 6, 8, 5),
    ('EIN', 'unbest. Artikel', 'D', 1, 9, 3),
    ('FREUTE', 'beglückte', 'D', 5, 9, 6),
    ('ISST', 'speist', 'D', 1, 10, 4),
    ('ENGEN', 'schmalen', 'D', 6, 10, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r044-11x11-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r044-11x11-02', 'Rätsel 44 · 11×11', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '11x11-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('UMS', 'um das', 'A', 1, 1, 3),
    ('STRAFE', 'Buße', 'A', 1, 5, 6),
    ('TEAM', 'Mannschaft', 'A', 2, 1, 4),
    ('RAUEN', 'groben', 'A', 2, 6, 5),
    ('AXT', 'Beil', 'A', 3, 1, 3),
    ('BITTET', 'ersucht', 'A', 3, 5, 6),
    ('HIT', 'Schlager', 'A', 4, 1, 3),
    ('EBBE', 'Gegenteil der Flut', 'A', 5, 4, 4),
    ('HOEHE', 'Erhebung', 'A', 6, 1, 5),
    ('BAND', 'Musikgruppe', 'A', 6, 7, 4),
    ('WERDENDE', 'künftige', 'A', 7, 3, 8),
    ('HAI', 'Raubfisch', 'A', 8, 1, 3),
    ('GANZEN', 'kompletten', 'A', 8, 5, 6),
    ('AUGE', 'Sehorgan', 'A', 9, 1, 4),
    ('TEURE', 'kostspielige', 'A', 9, 6, 5),
    ('TEE', 'Heißgetränk', 'A', 10, 1, 3),
    ('MENGEN', 'Massen', 'A', 10, 5, 6),
    ('UTAH', 'Mormonenstaat', 'D', 1, 1, 4),
    ('HAT', 'besitzt', 'D', 8, 1, 3),
    ('MEXIKO', 'Aztekenland', 'D', 1, 2, 6),
    ('AUE', 'Talwiese', 'D', 8, 2, 3),
    ('SATT', 'gesättigt', 'D', 1, 3, 4),
    ('EWIGE', 'endlose', 'D', 6, 3, 5),
    ('EHE', 'Bund fürs Leben', 'D', 5, 4, 3),
    ('BERG', 'Gipfel', 'D', 5, 5, 4),
    ('TRIEB', 'schwamm', 'D', 1, 6, 5),
    ('DATE', 'Verabredung', 'D', 7, 6, 4),
    ('RAT', 'Tipp', 'D', 1, 7, 3),
    ('EBENEN', 'Flächen', 'D', 5, 7, 6),
    ('AUTO', 'Pkw', 'D', 1, 8, 4),
    ('ANZUG', 'Zweiteiler', 'D', 6, 8, 5),
    ('FEE', 'Zauberin', 'D', 1, 9, 3),
    ('ANDERE', 'übrige', 'D', 5, 9, 6),
    ('ENTE', 'Wasservogel', 'D', 1, 10, 4),
    ('DENEN', 'Relativ (Dat. Pl.)', 'D', 6, 10, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r045-11x11-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r045-11x11-02', 'Rätsel 45 · 11×11', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '11x11-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('HUB', 'Hebung', 'A', 1, 1, 3),
    ('ADLIGE', 'Edelmann', 'A', 1, 5, 6),
    ('ARIE', 'Sologesang', 'A', 2, 1, 4),
    ('EURER', 'Possessiv (ihr)', 'A', 2, 6, 5),
    ('ALL', 'Weltraum', 'A', 3, 1, 3),
    ('ORDENS', 'Mitglied des ...', 'A', 3, 5, 6),
    ('RAD', 'Velo', 'A', 4, 1, 3),
    ('ASYL', 'Zuflucht', 'A', 5, 4, 4),
    ('OBHUT', 'Schutz', 'A', 6, 1, 5),
    ('IRAK', 'Land am Tigris', 'A', 6, 7, 4),
    ('AEUSSERE', 'externe', 'A', 7, 3, 8),
    ('ASS', 'speiste', 'A', 8, 1, 3),
    ('RATING', 'Bewertung', 'A', 8, 5, 6),
    ('NEST', 'Horst', 'A', 9, 1, 4),
    ('GESTE', 'Gebärde', 'A', 9, 6, 5),
    ('SET', 'Satz', 'A', 10, 1, 3),
    ('SATTEL', 'Reitsitz', 'A', 10, 5, 6),
    ('HAAR', 'Strähne', 'D', 1, 1, 4),
    ('ANS', 'an das', 'D', 8, 1, 3),
    ('URLAUB', 'Ferien', 'D', 1, 2, 6),
    ('SEE', 'Gewässer', 'D', 8, 2, 3),
    ('BILD', 'Gemälde', 'D', 1, 3, 4),
    ('HASST', 'verabscheut', 'D', 6, 3, 5),
    ('AUE', 'Talwiese', 'D', 5, 4, 3),
    ('STUR', 'starrsinnig', 'D', 5, 5, 4),
    ('DERBY', 'Lokalduell', 'D', 1, 6, 5),
    ('SAGA', 'Heldensage', 'D', 7, 6, 4),
    ('LUD', 'packte auf', 'D', 1, 7, 3),
    ('LISTET', 'führt auf', 'D', 5, 7, 6),
    ('IREN', 'Gälen', 'D', 1, 8, 4),
    ('REIST', 'fährt', 'D', 6, 8, 5),
    ('GEN', 'nach', 'D', 1, 9, 3),
    ('WARNTE', 'mahnte', 'D', 5, 9, 6),
    ('ERST', 'zunächst', 'D', 1, 10, 4),
    ('KEGEL', 'Konus', 'D', 6, 10, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r046-11x11-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r046-11x11-03', 'Rätsel 46 · 11×11', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '11x11-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('KRUG', 'Kanne', 'A', 1, 1, 4),
    ('BAND', 'Musikgruppe', 'A', 1, 7, 4),
    ('RAN', 'heran', 'A', 2, 1, 3),
    ('POESIE', 'Dichtkunst', 'A', 2, 5, 6),
    ('IRIS', 'Schwertlilie', 'A', 3, 1, 4),
    ('BASEN', 'Laugen', 'A', 3, 6, 5),
    ('TAETER', 'Verbrecher', 'A', 4, 4, 6),
    ('OPFERN', 'Geschädigten', 'A', 5, 1, 6),
    ('NEU', 'frisch', 'A', 5, 8, 3),
    ('REGT', 'bewegt', 'A', 6, 2, 4),
    ('VOR', 'ehe', 'A', 7, 1, 3),
    ('EHE', 'Bund fürs Leben', 'A', 7, 5, 3),
    ('ABT', 'Klosterchef', 'A', 8, 1, 3),
    ('NAMENS', 'genannt', 'A', 8, 5, 6),
    ('GEIL', 'toll (ugs.)', 'A', 9, 1, 4),
    ('BEIDE', 'alle zwei', 'A', 9, 6, 5),
    ('ENG', 'schmal', 'A', 10, 1, 3),
    ('ENDET', 'hört auf', 'A', 10, 6, 5),
    ('KRIPO', 'Ermittler', 'D', 1, 1, 5),
    ('VAGE', 'unklar', 'D', 7, 1, 4),
    ('RAR', 'selten', 'D', 1, 2, 3),
    ('PROBEN', 'Muster', 'D', 5, 2, 6),
    ('UNI', 'Hochschule', 'D', 1, 3, 3),
    ('FERTIG', 'erledigt', 'D', 5, 3, 6),
    ('STEG', 'Brücklein', 'D', 3, 4, 4),
    ('ARTEN', 'Sorten', 'D', 4, 5, 5),
    ('OBEN', 'in der Höhe', 'D', 2, 6, 4),
    ('HABE', 'besitze', 'D', 7, 6, 4),
    ('BEAT', 'Rhythmus', 'D', 1, 7, 4),
    ('JEMEN', 'Staat in Arabien', 'D', 6, 7, 5),
    ('ASSEN', 'speisten', 'D', 1, 8, 5),
    ('EID', 'Schwur', 'D', 8, 8, 3),
    ('NIERE', 'Organ', 'D', 1, 9, 5),
    ('ENDE', 'Schluss', 'D', 7, 9, 4),
    ('DEN', 'Artikel (Akkusativ)', 'D', 1, 10, 3),
    ('SET', 'Satz', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r047-11x11-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r047-11x11-03', 'Rätsel 47 · 11×11', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '11x11-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('RUSS', 'Rauchstaub', 'A', 1, 1, 4),
    ('DAME', 'Frau', 'A', 1, 7, 4),
    ('UNI', 'Hochschule', 'A', 2, 1, 3),
    ('BLASEN', 'Perlen', 'A', 2, 5, 6),
    ('IDEE', 'Einfall', 'A', 3, 1, 4),
    ('ESSIG', 'Würzmittel', 'A', 3, 6, 5),
    ('SASSEN', 'hockten', 'A', 4, 4, 6),
    ('ERLEBT', 'erfahren', 'A', 5, 1, 6),
    ('NEU', 'frisch', 'A', 5, 8, 3),
    ('EILT', 'hastet', 'A', 6, 2, 4),
    ('BIS', 'nicht später als', 'A', 7, 1, 3),
    ('EID', 'Schwur', 'A', 7, 5, 3),
    ('IST', 'befindet sich', 'A', 8, 1, 3),
    ('IRLAND', 'Grüne Insel', 'A', 8, 5, 6),
    ('STEG', 'Brücklein', 'A', 9, 1, 4),
    ('RESTE', 'Überbleibsel', 'A', 9, 6, 5),
    ('SET', 'Satz', 'A', 10, 1, 3),
    ('ENTEN', 'Wasservögel', 'A', 10, 6, 5),
    ('RUINE', 'Trümmer', 'D', 1, 1, 5),
    ('BISS', 'Schneid', 'D', 7, 1, 4),
    ('UND', 'sowie', 'D', 1, 2, 3),
    ('REISTE', 'fuhr', 'D', 5, 2, 6),
    ('SIE', 'Anrede', 'D', 1, 3, 3),
    ('LISTET', 'führt auf', 'D', 5, 3, 6),
    ('ESEL', 'Grautier', 'D', 3, 4, 4),
    ('ABTEI', 'Kloster', 'D', 4, 5, 5),
    ('LEST', 'studiert', 'D', 2, 6, 4),
    ('IRRE', 'Verrückte', 'D', 7, 6, 4),
    ('DASS', 'Konjunktion', 'D', 1, 7, 4),
    ('EDLEN', 'vornehmen', 'D', 6, 7, 5),
    ('ASSEN', 'speisten', 'D', 1, 8, 5),
    ('AST', 'Zweig', 'D', 8, 8, 3),
    ('MEINE', 'Possessiv (ich)', 'D', 1, 9, 5),
    ('ENTE', 'Wasservogel', 'D', 7, 9, 4),
    ('ENG', 'schmal', 'D', 1, 10, 3),
    ('DEN', 'Artikel (Akkusativ)', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r048-11x11-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r048-11x11-03', 'Rätsel 48 · 11×11', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '11x11-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ASYL', 'Zuflucht', 'A', 1, 1, 4),
    ('KUBA', 'Karibikinsel', 'A', 1, 7, 4),
    ('TEE', 'Heißgetränk', 'A', 2, 1, 3),
    ('FARMER', 'Landwirt', 'A', 2, 5, 6),
    ('LINK', 'Verknüpfung', 'A', 3, 1, 4),
    ('RUHIG', 'still', 'A', 3, 6, 5),
    ('EWIGEN', 'endlosen', 'A', 4, 4, 6),
    ('SCHRIE', 'brüllte', 'A', 5, 1, 6),
    ('REH', 'Waldtier', 'A', 5, 8, 3),
    ('HALT', 'eben', 'A', 6, 2, 4),
    ('MAL', 'Zeichen ×', 'A', 7, 1, 3),
    ('WEH', 'schmerzhaft', 'A', 7, 5, 3),
    ('ORT', 'Stelle', 'A', 8, 1, 3),
    ('EINZUG', 'Einmarsch', 'A', 8, 5, 6),
    ('STEG', 'Brücklein', 'A', 9, 1, 4),
    ('LEUTE', 'Personen', 'A', 9, 6, 5),
    ('TAT', 'Handlung', 'A', 10, 1, 3),
    ('ENGEN', 'schmalen', 'A', 10, 6, 5),
    ('ATLAS', 'Kartenwerk', 'D', 1, 1, 5),
    ('MOST', 'Obstsaft', 'D', 7, 1, 4),
    ('SEI', 'existiere', 'D', 1, 2, 3),
    ('CHARTA', 'Urkunde', 'D', 5, 2, 6),
    ('YEN', 'Währung Japans', 'D', 1, 3, 3),
    ('HALTET', 'stoppt', 'D', 5, 3, 6),
    ('KERL', 'Typ', 'D', 3, 4, 4),
    ('WITWE', 'Hinterbliebene', 'D', 4, 5, 5),
    ('ARIE', 'Sologesang', 'D', 2, 6, 4),
    ('EILE', 'Hast', 'D', 7, 6, 4),
    ('KRUG', 'Kanne', 'D', 1, 7, 4),
    ('AHNEN', 'vermuten', 'D', 6, 7, 5),
    ('UMHER', 'herum', 'D', 1, 8, 5),
    ('ZUG', 'Bahn', 'D', 8, 8, 3),
    ('BEINE', 'Gliedmaßen', 'D', 1, 9, 5),
    ('GUTE', 'prima', 'D', 7, 9, 4),
    ('ARG', 'schlimm', 'D', 1, 10, 3),
    ('GEN', 'nach', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r049-12x12-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r049-12x12-01', 'Rätsel 49 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('APP', 'Anwendung', 'A', 1, 1, 3),
    ('BROT', 'Laib', 'A', 1, 8, 4),
    ('BREMER', 'Hanseat', 'A', 2, 1, 6),
    ('AURA', 'Ausstrahlung', 'A', 2, 8, 4),
    ('TOR', 'Treffer', 'A', 3, 1, 3),
    ('EVENTS', 'Anlässe', 'A', 3, 6, 6),
    ('MORDES', 'Motiv des ...', 'A', 4, 6, 6),
    ('STERBEN', 'verscheiden', 'A', 5, 1, 7),
    ('EIERN', 'auf ... gehen', 'A', 6, 2, 5),
    ('GENUA', 'Hafenstadt Italiens', 'A', 7, 1, 5),
    ('SEGEN', 'Gnade', 'A', 7, 7, 5),
    ('WEN', 'Fragewort (Akk.)', 'A', 8, 3, 3),
    ('OBERE', 'höhere', 'A', 8, 7, 5),
    ('OMA', 'Großmutter', 'A', 9, 1, 3),
    ('DAGEGEN', 'kontra', 'A', 9, 5, 7),
    ('BAND', 'Musikgruppe', 'A', 10, 1, 4),
    ('LATEIN', 'alte Sprache', 'A', 10, 6, 6),
    ('EID', 'Schwur', 'A', 11, 1, 3),
    ('TRENNT', 'scheidet', 'A', 11, 6, 6),
    ('ABTES', 'Kloster des ...', 'D', 1, 1, 5),
    ('GROBE', 'raue', 'D', 7, 1, 5),
    ('PRO', 'je', 'D', 1, 2, 3),
    ('TEE', 'Heißgetränk', 'D', 5, 2, 3),
    ('MAI', '5. Monat', 'D', 9, 2, 3),
    ('PER', 'mittels', 'D', 1, 3, 3),
    ('EINWAND', 'Widerspruch', 'D', 5, 3, 7),
    ('FREUE', 'juble', 'D', 4, 4, 5),
    ('BRAND', 'Feuer', 'D', 5, 5, 5),
    ('BREMEN', 'Hansestadt', 'D', 1, 6, 6),
    ('ALT', 'betagt', 'D', 9, 6, 3),
    ('VON', 'ab, aus', 'D', 3, 7, 3),
    ('SOGAR', 'selbst', 'D', 7, 7, 5),
    ('BAER', 'Petz', 'D', 1, 8, 4),
    ('GEBETE', 'Andachten', 'D', 6, 8, 6),
    ('RUNDE', 'Durchgang', 'D', 1, 9, 5),
    ('GEGEN', 'wider', 'D', 7, 9, 5),
    ('ORTE', 'Plätze', 'D', 1, 10, 4),
    ('VEREIN', 'Klub', 'D', 6, 10, 6),
    ('TASSE', 'Becher', 'D', 1, 11, 5),
    ('NENNT', 'bezeichnet', 'D', 7, 11, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r050-12x12-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r050-12x12-01', 'Rätsel 50 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('SAH', 'erblickte', 'A', 1, 1, 3),
    ('ERBE', 'Nachlass', 'A', 1, 8, 4),
    ('TRAUMA', 'Schock', 'A', 2, 1, 6),
    ('DIES', 'das hier', 'A', 2, 8, 4),
    ('AMT', 'Behörde', 'A', 3, 1, 3),
    ('EVENTS', 'Anlässe', 'A', 3, 6, 6),
    ('FOLGTE', 'gehorchte', 'A', 4, 6, 6),
    ('STERBEN', 'verscheiden', 'A', 5, 1, 7),
    ('EIMER', 'Kübel', 'A', 6, 2, 5),
    ('REGER', 'lebhafter', 'A', 7, 1, 5),
    ('KABEL', 'Leitung', 'A', 7, 7, 5),
    ('NEU', 'frisch', 'A', 8, 3, 3),
    ('LEISE', 'gedämpft', 'A', 8, 7, 5),
    ('HEU', 'Trockengras', 'A', 9, 1, 3),
    ('FUEHLTE', 'spürte', 'A', 9, 5, 7),
    ('RING', 'Reif', 'A', 10, 1, 4),
    ('NIEDER', 'hinab', 'A', 10, 6, 6),
    ('ENG', 'schmal', 'A', 11, 1, 3),
    ('INNERE', 'interne', 'A', 11, 6, 6),
    ('STARS', 'Prominente', 'D', 1, 1, 5),
    ('ROHRE', 'Leitungen', 'D', 7, 1, 5),
    ('ARM', 'Gliedmaße', 'D', 1, 2, 3),
    ('TEE', 'Heißgetränk', 'D', 5, 2, 3),
    ('EIN', 'unbest. Artikel', 'D', 9, 2, 3),
    ('HAT', 'besitzt', 'D', 1, 3, 3),
    ('EIGNUNG', 'Befähigung', 'D', 5, 3, 7),
    ('ARMEE', 'Heer', 'D', 4, 4, 5),
    ('BERUF', 'Job', 'D', 5, 5, 5),
    ('KAEFER', 'Krabbeltier', 'D', 1, 6, 6),
    ('UNI', 'Hochschule', 'D', 9, 6, 3),
    ('VON', 'ab, aus', 'D', 3, 7, 3),
    ('KLEIN', 'winzig', 'D', 7, 7, 5),
    ('EDEL', 'vornehm', 'D', 1, 8, 4),
    ('SAEHEN', 'erblickten', 'D', 6, 8, 6),
    ('RINGS', 'Herr der ...', 'D', 1, 9, 5),
    ('BILDE', 'forme', 'D', 7, 9, 5),
    ('BETT', 'Schlafstätte', 'D', 1, 10, 4),
    ('FESTER', 'stabiler', 'D', 6, 10, 6),
    ('ESSEN', 'Mahlzeit', 'D', 1, 11, 5),
    ('LEERE', 'Vakuum', 'D', 7, 11, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r051-12x12-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r051-12x12-01', 'Rätsel 51 · 12×12', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '12x12-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ARM', 'Gliedmaße', 'A', 1, 1, 3),
    ('ESSE', 'speise', 'A', 1, 8, 4),
    ('REISTE', 'fuhr', 'A', 2, 1, 6),
    ('DEAL', 'Geschäft', 'A', 2, 8, 4),
    ('OHR', 'Hörorgan', 'A', 3, 1, 3),
    ('STEIGE', 'klettere', 'A', 3, 6, 6),
    ('SOLLEN', 'müssen', 'A', 4, 6, 6),
    ('ABGEBEN', 'aushändigen', 'A', 5, 1, 7),
    ('UEBEL', 'schlecht', 'A', 6, 2, 5),
    ('ABTEI', 'Kloster', 'A', 7, 1, 5),
    ('GRAUE', 'trübe', 'A', 7, 7, 5),
    ('ARG', 'schlimm', 'A', 8, 3, 3),
    ('RAGEN', 'aufsteigen', 'A', 8, 7, 5),
    ('PER', 'mittels', 'A', 9, 1, 3),
    ('EROBERT', 'eingenommen', 'A', 9, 5, 7),
    ('HING', 'baumelte', 'A', 10, 1, 4),
    ('ABENDE', 'Soireen', 'A', 10, 6, 6),
    ('AST', 'Zweig', 'A', 11, 1, 3),
    ('RENTEN', 'Pensionen', 'A', 11, 6, 6),
    ('AROMA', 'Geschmack', 'D', 1, 1, 5),
    ('ALPHA', 'griech. Buchstabe', 'D', 7, 1, 5),
    ('REH', 'Waldtier', 'D', 1, 2, 3),
    ('BUB', 'Knabe', 'D', 5, 2, 3),
    ('EIS', 'Gefrorenes', 'D', 9, 2, 3),
    ('MIR', 'Dat. (1. Pers.)', 'D', 1, 3, 3),
    ('GETARNT', 'verborgen', 'D', 5, 3, 7),
    ('LEBER', 'große Drüse', 'D', 4, 4, 5),
    ('BEIGE', 'sandfarben', 'D', 5, 5, 5),
    ('SESSEL', 'Polstersitz', 'D', 1, 6, 6),
    ('RAR', 'selten', 'D', 9, 6, 3),
    ('TON', 'Klang', 'D', 3, 7, 3),
    ('GROBE', 'raue', 'D', 7, 7, 5),
    ('EDEL', 'vornehm', 'D', 1, 8, 4),
    ('GRABEN', 'Rinne', 'D', 6, 8, 6),
    ('SEILE', 'Taue', 'D', 1, 9, 5),
    ('AGENT', 'Spion', 'D', 7, 9, 5),
    ('SAGE', 'Legende', 'D', 1, 10, 4),
    ('HUERDE', 'Hindernis', 'D', 6, 10, 6),
    ('ELEND', 'Jammer', 'D', 1, 11, 5),
    ('ENTEN', 'Wasservögel', 'D', 7, 11, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r052-12x12-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r052-12x12-02', 'Rätsel 52 · 12×12', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '12x12-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('SAGA', 'Heldensage', 'A', 1, 1, 4),
    ('AKTE', 'Dokument', 'A', 1, 8, 4),
    ('ADEL', 'Aristokratie', 'A', 2, 1, 4),
    ('UNKLAR', 'vage', 'A', 2, 6, 6),
    ('LEITET', 'führt', 'A', 3, 1, 6),
    ('TAGS', '... darauf', 'A', 3, 8, 4),
    ('ALS', 'da, während', 'A', 4, 1, 3),
    ('GUT', 'prima', 'A', 4, 9, 3),
    ('TIER', 'Lebewesen', 'A', 5, 1, 4),
    ('IHNEN', 'Anrede', 'A', 5, 6, 5),
    ('GLATT', 'eben', 'A', 6, 2, 5),
    ('ENGE', 'schmale', 'A', 6, 8, 4),
    ('WENDET', 'dreht', 'A', 7, 1, 6),
    ('WEG', 'Pfad', 'A', 8, 7, 3),
    ('ENDE', 'Schluss', 'A', 9, 1, 4),
    ('REDE', 'Ansprache', 'A', 9, 8, 4),
    ('REIHEN', 'Serien', 'A', 10, 1, 6),
    ('EBEN', 'flach', 'A', 10, 8, 4),
    ('EURE', 'Possessiv (ihr)', 'A', 11, 1, 4),
    ('INNERE', 'interne', 'A', 11, 6, 6),
    ('SALAT', 'Rohkost', 'D', 1, 1, 5),
    ('WAERE', 'sei', 'D', 7, 1, 5),
    ('ADELIGE', 'Edelfrau', 'D', 1, 2, 7),
    ('NEU', 'frisch', 'D', 9, 2, 3),
    ('GEISELN', 'Gefangene', 'D', 1, 3, 7),
    ('DIR', 'Dat. (2. Pers.)', 'D', 9, 3, 3),
    ('ALT', 'betagt', 'D', 1, 4, 3),
    ('RAD', 'Velo', 'D', 5, 4, 3),
    ('EHE', 'Bund fürs Leben', 'D', 9, 4, 3),
    ('TEE', 'Heißgetränk', 'D', 6, 5, 3),
    ('ZUTRITT', 'Einlass', 'D', 1, 6, 7),
    ('UNI', 'Hochschule', 'D', 9, 6, 3),
    ('AKT', 'Aufzug', 'D', 1, 8, 3),
    ('NEUEREN', 'jüngeren', 'D', 5, 8, 7),
    ('KLAGEN', 'Beschwerden', 'D', 1, 9, 6),
    ('GEBE', 'reiche', 'D', 8, 9, 4),
    ('TAGUNG', 'Kongress', 'D', 1, 10, 6),
    ('DER', 'Artikel (männl.)', 'D', 9, 10, 3),
    ('ERST', 'zunächst', 'D', 1, 11, 4),
    ('EIGENE', 'persönliche', 'D', 6, 11, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r053-12x12-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r053-12x12-02', 'Rätsel 53 · 12×12', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '12x12-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('LAUT', 'lärmend', 'A', 1, 1, 4),
    ('SAGT', 'äußert', 'A', 1, 8, 4),
    ('INNE', '... halten', 'A', 2, 1, 4),
    ('HOERER', 'Lauscher', 'A', 2, 6, 6),
    ('ERGEBE', 'resultiere', 'A', 3, 1, 6),
    ('TABU', 'verboten', 'A', 3, 8, 4),
    ('SEE', 'Gewässer', 'A', 4, 1, 3),
    ('BUG', 'Vorderschiff', 'A', 4, 9, 3),
    ('SINN', 'Bedeutung', 'A', 5, 1, 4),
    ('ALLER', 'sämtlicher', 'A', 5, 6, 5),
    ('SAUNA', 'Schwitzbad', 'A', 6, 2, 5),
    ('ORTE', 'Plätze', 'A', 6, 8, 4),
    ('TEURER', 'kostbarer', 'A', 7, 1, 6),
    ('WAR', 'existierte', 'A', 8, 7, 3),
    ('EDEL', 'vornehm', 'A', 9, 1, 4),
    ('LUPE', 'Brennglas', 'A', 9, 8, 4),
    ('MARODE', 'baufällig', 'A', 10, 1, 6),
    ('EHER', 'lieber', 'A', 10, 8, 4),
    ('ARZT', 'Mediziner', 'A', 11, 1, 4),
    ('INNERE', 'interne', 'A', 11, 6, 6),
    ('LIESS', 'erlaubte', 'D', 1, 1, 5),
    ('THEMA', 'Gegenstand', 'D', 7, 1, 5),
    ('ANREISE', 'Hinfahrt', 'D', 1, 2, 7),
    ('DAR', 'stellt ... (zeigt)', 'D', 9, 2, 3),
    ('UNGENAU', 'vage', 'D', 1, 3, 7),
    ('ERZ', 'Gestein', 'D', 9, 3, 3),
    ('TEE', 'Heißgetränk', 'D', 1, 4, 3),
    ('NUR', 'lediglich', 'D', 5, 4, 3),
    ('LOT', 'Senkblei', 'D', 9, 4, 3),
    ('NEU', 'frisch', 'D', 6, 5, 3),
    ('EHEPAAR', 'Mann und Frau', 'D', 1, 6, 7),
    ('BEI', 'nahe an', 'D', 9, 6, 3),
    ('SET', 'Satz', 'D', 1, 8, 3),
    ('LOKALEN', 'örtlichen', 'D', 5, 8, 7),
    ('ARABER', 'Pferderasse', 'D', 1, 9, 6),
    ('RUHE', 'Stille', 'D', 8, 9, 4),
    ('GEBURT', 'Entbindung', 'D', 1, 10, 6),
    ('PER', 'mittels', 'D', 9, 10, 3),
    ('TRUG', 'schleppte', 'D', 1, 11, 4),
    ('ENGERE', 'schmalere', 'D', 6, 11, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r054-12x12-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r054-12x12-02', 'Rätsel 54 · 12×12', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '12x12-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('SPOT', 'Werbeclip', 'A', 1, 1, 4),
    ('HABT', 'besitzt', 'A', 1, 8, 4),
    ('AFFE', 'Primat', 'A', 2, 1, 4),
    ('IRONIE', 'Spott', 'A', 2, 6, 6),
    ('LATEIN', 'alte Sprache', 'A', 3, 1, 6),
    ('BREI', 'Mus', 'A', 3, 8, 4),
    ('ARM', 'Gliedmaße', 'A', 4, 1, 3),
    ('ENG', 'schmal', 'A', 4, 9, 3),
    ('TRAF', 'begegnete', 'A', 5, 1, 4),
    ('GNADE', 'Erbarmen', 'A', 5, 6, 5),
    ('ELITE', 'Auslese', 'A', 6, 2, 5),
    ('SENF', 'Mostrich', 'A', 6, 8, 4),
    ('BISTUM', 'Diözese', 'A', 7, 1, 6),
    ('WEH', 'schmerzhaft', 'A', 8, 7, 3),
    ('ABER', 'jedoch', 'A', 9, 1, 4),
    ('KINN', 'Unterkiefer', 'A', 9, 8, 4),
    ('NAHEZU', 'fast', 'A', 10, 1, 6),
    ('TRUG', 'schleppte', 'A', 10, 8, 4),
    ('DREH', 'Kniff', 'A', 11, 1, 4),
    ('BRENNT', 'lodert', 'A', 11, 6, 6),
    ('SALAT', 'Rohkost', 'D', 1, 1, 5),
    ('BRAND', 'Feuer', 'D', 7, 1, 5),
    ('PFARREI', 'Sprengel', 'D', 1, 2, 7),
    ('BAR', 'Theke', 'D', 9, 2, 3),
    ('OFTMALS', 'häufig', 'D', 1, 3, 7),
    ('EHE', 'Bund fürs Leben', 'D', 9, 3, 3),
    ('TEE', 'Heißgetränk', 'D', 1, 4, 3),
    ('FIT', 'gesund', 'D', 5, 4, 3),
    ('REH', 'Waldtier', 'D', 9, 4, 3),
    ('TUE', 'mache', 'D', 6, 5, 3),
    ('EINIGEM', 'manchem', 'D', 1, 6, 7),
    ('PUB', 'Kneipe', 'D', 9, 6, 3),
    ('HOB', 'stemmte', 'D', 1, 8, 3),
    ('ASPEKTE', 'Seiten', 'D', 5, 8, 7),
    ('ANREDE', 'Begrüßung', 'D', 1, 9, 6),
    ('HIRN', 'Verstand', 'D', 8, 9, 4),
    ('BIENEN', 'Honigsammler', 'D', 1, 10, 6),
    ('NUN', 'jetzt', 'D', 9, 10, 3),
    ('TEIG', 'Masse', 'D', 1, 11, 4),
    ('FAENGT', 'erwischt', 'D', 6, 11, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r055-12x12-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r055-12x12-03', 'Rätsel 55 · 12×12', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '12x12-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('MUEDE', 'schläfrig', 'A', 1, 1, 5),
    ('TRITT', 'kickt', 'A', 1, 7, 5),
    ('INTERNE', 'innere', 'A', 2, 1, 7),
    ('NEU', 'frisch', 'A', 2, 9, 3),
    ('CRASH', 'Unfall', 'A', 3, 1, 5),
    ('SEE', 'Gewässer', 'A', 3, 9, 3),
    ('HUT', 'Kopfbedeckung', 'A', 4, 1, 3),
    ('OVAL', 'eiförmig', 'A', 4, 5, 4),
    ('BIS', 'nicht später als', 'A', 5, 5, 3),
    ('ZUM', 'zu dem', 'A', 5, 9, 3),
    ('FEST', 'stabil', 'A', 6, 1, 4),
    ('KLERUS', 'Priesterstand', 'A', 7, 5, 6),
    ('GUT', 'prima', 'A', 8, 1, 3),
    ('LEITETE', 'führte', 'A', 8, 5, 7),
    ('LEISE', 'gedämpft', 'A', 9, 1, 5),
    ('NEBEN', 'seitlich von', 'A', 9, 7, 5),
    ('ABREISE', 'Aufbruch', 'A', 10, 1, 7),
    ('EID', 'Schwur', 'A', 10, 9, 3),
    ('STEIN', 'Fels', 'A', 11, 1, 5),
    ('ALLE', 'sämtliche', 'A', 11, 8, 4),
    ('MICH', 'Akk. (1. Pers.)', 'D', 1, 1, 4),
    ('GLAS', 'Trinkgefäß', 'D', 8, 1, 4),
    ('UNRUHE', 'Aufregung', 'D', 1, 2, 6),
    ('UEBT', 'trainiert', 'D', 8, 2, 4),
    ('ETAT', 'Budget', 'D', 1, 3, 4),
    ('SATIRE', 'Spottschrift', 'D', 6, 3, 6),
    ('DES', 'Artikel (Genitiv)', 'D', 1, 4, 3),
    ('SEI', 'existiere', 'D', 9, 4, 3),
    ('ERHOB', 'stemmte', 'D', 1, 5, 5),
    ('KLEIN', 'winzig', 'D', 7, 5, 5),
    ('VIELE', 'zahlreiche', 'D', 4, 6, 5),
    ('TEXAS', 'Staat um Houston', 'D', 1, 7, 5),
    ('EINE', 'unbest. Artikel (w.)', 'D', 7, 7, 4),
    ('ORTE', 'Plätze', 'D', 6, 8, 4),
    ('INS', 'in das', 'D', 1, 9, 3),
    ('UEBEL', 'schlecht', 'D', 7, 9, 5),
    ('TEE', 'Heißgetränk', 'D', 1, 10, 3),
    ('STEIL', 'abschüssig', 'D', 7, 10, 5),
    ('TUERME', 'Bergfriede', 'D', 1, 11, 6),
    ('ENDE', 'Schluss', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r056-12x12-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r056-12x12-03', 'Rätsel 56 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('FILME', 'Streifen', 'A', 1, 1, 5),
    ('ECHTE', 'authentische', 'A', 1, 7, 5),
    ('IDEALEN', 'perfekten', 'A', 2, 1, 7),
    ('AUS', 'vorbei', 'A', 2, 9, 3),
    ('NEIGE', 'zur ... gehen', 'A', 3, 1, 5),
    ('INS', 'in das', 'A', 3, 9, 3),
    ('GAB', 'schenkte', 'A', 4, 1, 3),
    ('NORM', 'Regel', 'A', 4, 5, 4),
    ('DEM', 'Artikel (Dativ)', 'A', 5, 5, 3),
    ('VON', 'ab, aus', 'A', 5, 9, 3),
    ('SEHR', 'äußerst', 'A', 6, 1, 4),
    ('LEERER', 'hohler', 'A', 7, 5, 6),
    ('GAR', 'durchgekocht', 'A', 8, 1, 3),
    ('INNEREN', 'internen', 'A', 8, 5, 7),
    ('EUREN', 'Possessiv (ihr)', 'A', 9, 1, 5),
    ('DINGE', 'Sachen', 'A', 9, 7, 5),
    ('BLICKTE', 'schaute', 'A', 10, 1, 7),
    ('TAT', 'Handlung', 'A', 10, 9, 3),
    ('TANKS', 'Behälter', 'A', 11, 1, 5),
    ('WELT', 'Erde', 'A', 11, 8, 4),
    ('FING', 'erwischte', 'D', 1, 1, 4),
    ('GEBT', 'reicht', 'D', 8, 1, 4),
    ('IDEALE', 'perfekte', 'D', 1, 2, 6),
    ('AULA', 'Festsaal', 'D', 8, 2, 4),
    ('LEIB', 'Körper', 'D', 1, 3, 4),
    ('HERRIN', 'Gebieterin', 'D', 6, 3, 6),
    ('MAG', 'liebt', 'D', 1, 4, 3),
    ('ECK', 'Winkel', 'D', 9, 4, 3),
    ('ELEND', 'Jammer', 'D', 1, 5, 5),
    ('LINKS', 'nicht rechts', 'D', 7, 5, 5),
    ('OEFEN', 'Herde', 'D', 4, 6, 5),
    ('ENORM', 'gewaltig', 'D', 1, 7, 5),
    ('ENDE', 'Schluss', 'D', 7, 7, 4),
    ('FREI', 'ungebunden', 'D', 6, 8, 4),
    ('HAI', 'Raubfisch', 'D', 1, 9, 3),
    ('ERNTE', 'Lese', 'D', 7, 9, 5),
    ('TUN', 'machen', 'D', 1, 10, 3),
    ('REGAL', 'Bord', 'D', 7, 10, 5),
    ('ESSENZ', 'Kern', 'D', 1, 11, 6),
    ('NETT', 'freundlich', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r057-12x12-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r057-12x12-03', 'Rätsel 57 · 12×12', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '12x12-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('STEIL', 'abschüssig', 'A', 1, 1, 5),
    ('IKONE', 'Heiligenbild', 'A', 1, 7, 5),
    ('ARCHIVS', 'Bestand des ...', 'A', 2, 1, 7),
    ('MIR', 'Dat. (1. Pers.)', 'A', 2, 9, 3),
    ('NEHMT', 'greift', 'A', 3, 1, 5),
    ('AXT', 'Beil', 'A', 3, 9, 3),
    ('DUO', 'Paar', 'A', 4, 1, 3),
    ('ETAT', 'Budget', 'A', 4, 5, 4),
    ('ROM', 'Ewige Stadt', 'A', 5, 5, 3),
    ('OPA', 'Großvater', 'A', 5, 9, 3),
    ('ENGE', 'schmale', 'A', 6, 1, 4),
    ('GEERBT', 'übernommen', 'A', 7, 5, 6),
    ('SEE', 'Gewässer', 'A', 8, 1, 3),
    ('ERBAUEN', 'errichten', 'A', 8, 5, 7),
    ('ALIBI', 'Entlastung', 'A', 9, 1, 5),
    ('EBENE', 'Fläche', 'A', 9, 7, 5),
    ('ABSAGEN', 'streichen', 'A', 10, 1, 7),
    ('ROT', 'purpurn', 'A', 10, 9, 3),
    ('LEERE', 'Vakuum', 'A', 11, 1, 5),
    ('HORT', 'Schatz', 'A', 11, 8, 4),
    ('SAND', 'Wüstenboden', 'D', 1, 1, 4),
    ('SAAL', 'Halle', 'D', 8, 1, 4),
    ('TREUEN', 'loyalen', 'D', 1, 2, 6),
    ('ELBE', 'Strom durch Dresden', 'D', 8, 2, 4),
    ('ECHO', 'Widerhall', 'D', 1, 3, 4),
    ('GLEISE', 'Schienen', 'D', 6, 3, 6),
    ('IHM', 'Dativ von er', 'D', 1, 4, 3),
    ('BAR', 'Theke', 'D', 9, 4, 3),
    ('LITER', 'Hohlmaß', 'D', 1, 5, 5),
    ('GEIGE', 'Violine', 'D', 7, 5, 5),
    ('TOTER', 'verstorbener', 'D', 4, 6, 5),
    ('ISLAM', 'Weltreligion', 'D', 1, 7, 5),
    ('EBEN', 'flach', 'D', 7, 7, 4),
    ('GRAB', 'Gruft', 'D', 6, 8, 4),
    ('OMA', 'Großmutter', 'D', 1, 9, 3),
    ('BUERO', 'Kanzlei', 'D', 7, 9, 5),
    ('NIX', 'nichts', 'D', 1, 10, 3),
    ('TENOR', 'Sängerstimme', 'D', 7, 10, 5),
    ('ERTRAG', 'Gewinn', 'D', 1, 11, 6),
    ('NETT', 'freundlich', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r058-12x12-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r058-12x12-04', 'Rätsel 58 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('PASSENDE', 'geeignete', 'A', 1, 1, 8),
    ('ALTEN', 'betagten', 'A', 2, 1, 5),
    ('ABT', 'Klosterchef', 'A', 2, 7, 3),
    ('ABEND', 'Tagesende', 'A', 3, 1, 5),
    ('REALE', 'wirkliche', 'A', 3, 7, 5),
    ('REGAL', 'Bord', 'A', 4, 1, 5),
    ('NEIN', 'Ablehnung', 'A', 4, 8, 4),
    ('TOETETEN', 'brachten um', 'A', 5, 4, 8),
    ('IST', 'befindet sich', 'A', 6, 9, 3),
    ('HUB', 'Hebung', 'A', 7, 2, 3),
    ('LIEGT', 'ruht', 'A', 7, 6, 5),
    ('PERU', 'Andenstaat', 'A', 8, 1, 4),
    ('ALS', 'da, während', 'A', 8, 6, 3),
    ('AUSBAU', 'Erweiterung', 'A', 9, 1, 6),
    ('SEHR', 'äußerst', 'A', 9, 8, 4),
    ('TEE', 'Heißgetränk', 'A', 10, 1, 3),
    ('EHER', 'lieber', 'A', 10, 8, 4),
    ('ERST', 'zunächst', 'A', 11, 1, 4),
    ('ERNEUT', 'wieder', 'A', 11, 6, 6),
    ('PAAR', 'einige', 'D', 1, 1, 4),
    ('PATE', 'Taufzeuge', 'D', 8, 1, 4),
    ('ALBEN', 'Platten', 'D', 1, 2, 5),
    ('HEUER', 'dieses Jahr', 'D', 7, 2, 5),
    ('STEG', 'Brücklein', 'D', 1, 3, 4),
    ('KURSES', 'Leiter des ...', 'D', 6, 3, 6),
    ('SENAT', 'Ältestenrat', 'D', 1, 4, 5),
    ('BUB', 'Knabe', 'D', 7, 4, 3),
    ('ENDLOS', 'ewig', 'D', 1, 5, 6),
    ('LAUNE', 'Stimmung', 'D', 7, 6, 5),
    ('DAR', 'stellt ... (zeigt)', 'D', 1, 7, 3),
    ('TEIL', 'Stück', 'D', 5, 7, 4),
    ('EBENE', 'Fläche', 'D', 1, 8, 5),
    ('ESSEN', 'Mahlzeit', 'D', 7, 8, 5),
    ('TAETIG', 'aktiv', 'D', 2, 9, 6),
    ('EHE', 'Bund fürs Leben', 'D', 9, 9, 3),
    ('LIEST', 'schmökert', 'D', 3, 10, 5),
    ('HEU', 'Trockengras', 'D', 9, 10, 3),
    ('KOENNT', 'vermögt', 'D', 1, 11, 6),
    ('IRRT', 'täuscht sich', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r059-12x12-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r059-12x12-04', 'Rätsel 59 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('DRAMATIK', 'Spannung', 'A', 1, 1, 8),
    ('OHREN', 'Hörorgane', 'A', 2, 1, 5),
    ('SAH', 'erblickte', 'A', 2, 7, 3),
    ('REGER', 'lebhafter', 'A', 3, 1, 5),
    ('TRUHE', 'Kiste', 'A', 3, 7, 5),
    ('TIERE', 'Lebewesen', 'A', 4, 1, 5),
    ('TEIL', 'Stück', 'A', 4, 8, 4),
    ('EINZELNE', 'separate', 'A', 5, 4, 8),
    ('LAS', 'schmökerte', 'A', 6, 9, 3),
    ('ZUR', 'zu der', 'A', 7, 2, 3),
    ('BLIEB', 'verweilte', 'A', 7, 6, 5),
    ('DIVA', 'Primadonna', 'A', 8, 1, 4),
    ('ALS', 'da, während', 'A', 8, 6, 3),
    ('REINES', 'pures', 'A', 9, 1, 6),
    ('LAND', 'Staat', 'A', 9, 8, 4),
    ('EHE', 'Bund fürs Leben', 'A', 10, 1, 3),
    ('ARIE', 'Sologesang', 'A', 10, 8, 4),
    ('HELD', 'Recke', 'A', 11, 1, 4),
    ('SOMMER', 'Jahreszeit', 'A', 11, 6, 6),
    ('DORT', 'da', 'D', 1, 1, 4),
    ('DREH', 'Kniff', 'D', 8, 1, 4),
    ('RHEIN', 'dt. Strom', 'D', 1, 2, 5),
    ('ZIEHE', 'zerre', 'D', 7, 2, 5),
    ('ARGE', 'schlimme', 'D', 1, 3, 4),
    ('ZUVIEL', 'übermäßig', 'D', 6, 3, 6),
    ('MEERE', 'Ozeane', 'D', 1, 4, 5),
    ('RAN', 'heran', 'D', 7, 4, 3),
    ('ANREIZ', 'Ansporn', 'D', 1, 5, 6),
    ('BASIS', 'Grundlage', 'D', 7, 6, 5),
    ('IST', 'befindet sich', 'D', 1, 7, 3),
    ('ZOLL', 'Abgabe', 'D', 5, 7, 4),
    ('KARTE', 'Ticket', 'D', 1, 8, 5),
    ('ISLAM', 'Weltreligion', 'D', 7, 8, 5),
    ('HUELLE', 'Umschlag', 'D', 2, 9, 6),
    ('ARM', 'Gliedmaße', 'D', 9, 9, 3),
    ('HINAB', 'hinunter', 'D', 3, 10, 5),
    ('NIE', 'nimmer', 'D', 9, 10, 3),
    ('VIELES', 'allerlei', 'D', 1, 11, 6),
    ('ODER', 'bzw.', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r060-12x12-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r060-12x12-04', 'Rätsel 60 · 12×12', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '12x12-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('DRAMATIK', 'Spannung', 'A', 1, 1, 8),
    ('OHREN', 'Hörorgane', 'A', 2, 1, 5),
    ('HAB', '... und Gut', 'A', 2, 7, 3),
    ('REGER', 'lebhafter', 'A', 3, 1, 5),
    ('MUEDE', 'schläfrig', 'A', 3, 7, 5),
    ('NIERE', 'Organ', 'A', 4, 1, 5),
    ('FRAU', 'Dame', 'A', 4, 8, 4),
    ('EINSTURZ', 'Zusammenfall', 'A', 5, 4, 8),
    ('HUT', 'Kopfbedeckung', 'A', 6, 9, 3),
    ('GAB', 'schenkte', 'A', 7, 2, 3),
    ('ALTEM', 'betagtem', 'A', 7, 6, 5),
    ('TREU', 'loyal', 'A', 8, 1, 4),
    ('TOR', 'Treffer', 'A', 8, 6, 3),
    ('RATSAM', 'klug', 'A', 9, 1, 6),
    ('ADEL', 'Aristokratie', 'A', 9, 8, 4),
    ('AUE', 'Talwiese', 'A', 10, 1, 3),
    ('GEIL', 'toll (ugs.)', 'A', 10, 8, 4),
    ('FERN', 'weit weg', 'A', 11, 1, 4),
    ('NUESSE', 'Kerne', 'A', 11, 6, 6),
    ('DORN', 'Stachel', 'D', 1, 1, 4),
    ('TRAF', 'begegnete', 'D', 8, 1, 4),
    ('RHEIN', 'dt. Strom', 'D', 1, 2, 5),
    ('GRAUE', 'trübe', 'D', 7, 2, 5),
    ('ARGE', 'schlimme', 'D', 1, 3, 4),
    ('VAETER', 'Papas', 'D', 6, 3, 6),
    ('MEERE', 'Ozeane', 'D', 1, 4, 5),
    ('BUS', 'Car (schweiz.)', 'D', 7, 4, 3),
    ('ANREIZ', 'Ansporn', 'D', 1, 5, 6),
    ('ATMEN', 'Luft holen', 'D', 7, 6, 5),
    ('IHM', 'Dativ von er', 'D', 1, 7, 3),
    ('SOLO', 'allein', 'D', 5, 7, 4),
    ('KAUFT', 'erwirbt', 'D', 1, 8, 5),
    ('TRAGE', 'schleppe', 'D', 7, 8, 5),
    ('BERUHE', 'basiere', 'D', 2, 9, 6),
    ('DES', 'Artikel (Genitiv)', 'D', 9, 9, 3),
    ('DARUM', 'deshalb', 'D', 3, 10, 5),
    ('EIS', 'Gefrorenes', 'D', 9, 10, 3),
    ('KREUZT', 'schneidet', 'D', 1, 11, 6),
    ('ALLE', 'sämtliche', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r061-13x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r061-13x13-01', 'Rätsel 61 · 13×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '13x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('VOM', 'von dem', 'A', 1, 1, 3),
    ('AMT', 'Behörde', 'A', 1, 5, 3),
    ('SASS', 'hockte', 'A', 1, 9, 4),
    ('IRAK', 'Land am Tigris', 'A', 2, 1, 4),
    ('ORDEN', 'Auszeichnung', 'A', 2, 6, 5),
    ('ATLANTA', 'Stadt in Georgia', 'A', 3, 1, 7),
    ('INNE', '... halten', 'A', 3, 9, 4),
    ('MATTE', 'Unterlage', 'A', 4, 4, 5),
    ('ARG', 'schlimm', 'A', 5, 1, 3),
    ('MOENCHEN', 'Brüdern', 'A', 5, 5, 8),
    ('SAALE', 'Fluss durch Halle', 'A', 6, 1, 5),
    ('NORM', 'Regel', 'A', 6, 7, 4),
    ('INS', 'in das', 'A', 7, 1, 3),
    ('RAETE', 'Gremien', 'A', 7, 8, 5),
    ('EDEL', 'vornehm', 'A', 8, 1, 4),
    ('DOMS', 'Kuppel des ...', 'A', 8, 6, 4),
    ('HIER', 'an diesem Ort', 'A', 9, 9, 4),
    ('MUNDART', 'Dialekt', 'A', 10, 2, 7),
    ('RIO', 'Stadt in Brasilien', 'A', 10, 10, 3),
    ('KANZEL', 'Predigtstuhl', 'A', 11, 1, 6),
    ('ABT', 'Klosterchef', 'A', 11, 10, 3),
    ('NIERE', 'Organ', 'A', 12, 2, 5),
    ('TANTE', 'Muhme', 'A', 12, 8, 5),
    ('VIA', 'über', 'D', 1, 1, 3),
    ('ASIEN', 'Erdteil', 'D', 5, 1, 5),
    ('ORTSRAND', 'Peripherie', 'D', 1, 2, 8),
    ('MAN', 'jemand', 'D', 10, 2, 3),
    ('MAL', 'Zeichen ×', 'D', 1, 3, 3),
    ('GASE', 'Dämpfe', 'D', 5, 3, 4),
    ('UNI', 'Hochschule', 'D', 10, 3, 3),
    ('KAM', 'nahte', 'D', 2, 4, 3),
    ('LANZE', 'Speer', 'D', 8, 4, 5),
    ('NAME', 'Bezeichnung', 'D', 3, 5, 4),
    ('DER', 'Artikel (männl.)', 'D', 10, 5, 3),
    ('MOTTO', 'Leitspruch', 'D', 1, 6, 5),
    ('IDEALE', 'perfekte', 'D', 7, 6, 6),
    ('TRATEN', 'schritten', 'D', 1, 7, 6),
    ('ENORM', 'gewaltig', 'D', 4, 8, 5),
    ('TAT', 'Handlung', 'D', 10, 8, 3),
    ('SEI', 'existiere', 'D', 1, 9, 3),
    ('CRASH', 'Unfall', 'D', 5, 9, 5),
    ('ANNAHME', 'Vermutung', 'D', 1, 10, 7),
    ('IRAN', 'Persien', 'D', 9, 10, 4),
    ('TREIBT', 'schwimmt', 'D', 7, 11, 6),
    ('SIE', 'Anrede', 'D', 1, 12, 3),
    ('NIE', 'nimmer', 'D', 5, 12, 3),
    ('ROTE', 'purpurne', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r062-13x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r062-13x13-01', 'Rätsel 62 · 13×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '13x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AUS', 'vorbei', 'A', 1, 1, 3),
    ('UMS', 'um das', 'A', 1, 5, 3),
    ('IGEL', 'Stacheltier', 'A', 1, 9, 4),
    ('URIN', 'Harn', 'A', 2, 1, 4),
    ('ACHSE', 'Welle', 'A', 2, 6, 5),
    ('FLEISCH', 'Muskelgewebe', 'A', 3, 1, 7),
    ('TRUG', 'schleppte', 'A', 3, 9, 4),
    ('ETHIK', 'Moral', 'A', 4, 4, 5),
    ('DUO', 'Paar', 'A', 5, 1, 3),
    ('ATELIERS', 'Werkstätten', 'A', 5, 5, 8),
    ('ABBAU', 'Förderung', 'A', 6, 1, 5),
    ('NEST', 'Horst', 'A', 6, 7, 4),
    ('TEE', 'Heißgetränk', 'A', 7, 1, 3),
    ('BLECH', 'Metallplatte', 'A', 7, 8, 5),
    ('URNE', 'Aschengefäß', 'A', 8, 1, 4),
    ('VITA', 'Lebenslauf', 'A', 8, 6, 4),
    ('MORD', 'Tötung', 'A', 9, 9, 4),
    ('BANANEN', 'Südfrüchte', 'A', 10, 2, 7),
    ('VIA', 'über', 'A', 10, 10, 3),
    ('DAUERT', 'währt', 'A', 11, 1, 6),
    ('AST', 'Zweig', 'A', 11, 10, 3),
    ('TESTS', 'Prüfungen', 'A', 12, 2, 5),
    ('HALTE', 'stoppe', 'A', 12, 8, 5),
    ('AUF', 'offen', 'D', 1, 1, 3),
    ('DATUM', 'Tagesangabe', 'D', 5, 1, 5),
    ('URLAUBER', 'Tourist', 'D', 1, 2, 8),
    ('BAT', 'ersuchte', 'D', 10, 2, 3),
    ('SIE', 'Anrede', 'D', 1, 3, 3),
    ('OBEN', 'in der Höhe', 'D', 5, 3, 4),
    ('AUE', 'Talwiese', 'D', 10, 3, 3),
    ('NIE', 'nimmer', 'D', 2, 4, 3),
    ('EINES', 'unbest. Art. (Gen.)', 'D', 8, 4, 5),
    ('STAU', 'Blechlawine', 'D', 3, 5, 4),
    ('ART', 'Sorte', 'D', 10, 5, 3),
    ('MACHT', 'tut', 'D', 1, 6, 5),
    ('EVENTS', 'Anlässe', 'D', 7, 6, 6),
    ('SCHIEN', 'leuchtete', 'D', 1, 7, 6),
    ('KLEBT', 'haftet', 'D', 4, 8, 5),
    ('NAH', 'dicht', 'D', 10, 8, 3),
    ('IST', 'befindet sich', 'D', 1, 9, 3),
    ('ISLAM', 'Weltreligion', 'D', 5, 9, 5),
    ('GERAETE', 'Apparate', 'D', 1, 10, 7),
    ('OVAL', 'eiförmig', 'D', 9, 10, 4),
    ('CHRIST', 'Gläubiger', 'D', 7, 11, 6),
    ('LAG', 'ruhte', 'D', 1, 12, 3),
    ('SAH', 'erblickte', 'D', 5, 12, 3),
    ('DATE', 'Verabredung', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r063-13x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r063-13x13-01', 'Rätsel 63 · 13×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '13x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('HUB', 'Hebung', 'A', 1, 1, 3),
    ('UMS', 'um das', 'A', 1, 5, 3),
    ('BART', 'Gesichtshaar', 'A', 1, 9, 4),
    ('OKAY', 'in Ordnung', 'A', 2, 1, 4),
    ('AALEN', 'Stadt in Württemberg', 'A', 2, 6, 5),
    ('BRUEGGE', 'Stadt in Belgien', 'A', 3, 1, 7),
    ('IGEL', 'Stacheltier', 'A', 3, 9, 4),
    ('NAEHE', 'Umgebung', 'A', 4, 4, 5),
    ('BIT', 'Binärziffer', 'A', 5, 1, 3),
    ('GREIFBAR', 'konkret', 'A', 5, 5, 8),
    ('ANIME', 'jap. Zeichentrick', 'A', 6, 1, 5),
    ('NEUE', 'frische', 'A', 6, 7, 4),
    ('SEE', 'Gewässer', 'A', 7, 1, 3),
    ('RENNT', 'läuft', 'A', 7, 8, 5),
    ('IRRT', 'täuscht sich', 'A', 8, 1, 4),
    ('FANG', 'Beute', 'A', 8, 6, 4),
    ('TANK', 'Behälter', 'A', 9, 9, 4),
    ('SPERRTE', 'blockierte', 'A', 10, 2, 7),
    ('UNI', 'Hochschule', 'A', 10, 10, 3),
    ('WARTET', 'harrt', 'A', 11, 1, 6),
    ('GEN', 'nach', 'A', 11, 10, 3),
    ('HOEHE', 'Erhebung', 'A', 12, 2, 5),
    ('STERN', 'Gestirn', 'A', 12, 8, 5),
    ('HOB', 'stemmte', 'D', 1, 1, 3),
    ('BASIS', 'Grundlage', 'D', 5, 1, 5),
    ('UKRAINER', 'Ostslawe', 'D', 1, 2, 8),
    ('SAH', 'erblickte', 'D', 10, 2, 3),
    ('BAU', 'Gebäude', 'D', 1, 3, 3),
    ('TIER', 'Lebewesen', 'D', 5, 3, 4),
    ('PRO', 'je', 'D', 10, 3, 3),
    ('YEN', 'Währung Japans', 'D', 2, 4, 3),
    ('TUETE', 'Beutel', 'D', 8, 4, 5),
    ('GAGE', 'Honorar', 'D', 3, 5, 4),
    ('REH', 'Waldtier', 'D', 10, 5, 3),
    ('MAGER', 'dürr', 'D', 1, 6, 5),
    ('PFORTE', 'Tor', 'D', 7, 6, 6),
    ('SAEHEN', 'erblickten', 'D', 1, 7, 6),
    ('EIERN', 'auf ... gehen', 'D', 4, 8, 5),
    ('EIS', 'Gefrorenes', 'D', 10, 8, 3),
    ('BEI', 'nahe an', 'D', 1, 9, 3),
    ('FUEGT', 'setzt', 'D', 5, 9, 5),
    ('ANGEBEN', 'prahlen', 'D', 1, 10, 7),
    ('AUGE', 'Sehorgan', 'D', 9, 10, 4),
    ('NENNER', 'Divisor', 'D', 7, 11, 6),
    ('TAL', 'Senke', 'D', 1, 12, 3),
    ('ROT', 'purpurn', 'D', 5, 12, 3),
    ('KINN', 'Unterkiefer', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r064-13x13-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r064-13x13-02', 'Rätsel 64 · 13×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '13x13-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ERSTMALS', 'nie zuvor', 'A', 1, 1, 8),
    ('WIR', 'Pronomen (1. Pl.)', 'A', 1, 10, 3),
    ('TEILE', 'Stücke', 'A', 2, 3, 5),
    ('MINE', 'Bergwerk', 'A', 2, 9, 4),
    ('RITTER', 'Edelmann', 'A', 3, 3, 6),
    ('ENG', 'schmal', 'A', 3, 10, 3),
    ('ESEL', 'Grautier', 'A', 4, 1, 4),
    ('ERAHNEN', 'vermuten', 'A', 4, 6, 7),
    ('UEBT', 'trainiert', 'A', 5, 1, 4),
    ('REDE', 'Ansprache', 'A', 5, 6, 4),
    ('TITELS', 'Gewinn des ...', 'A', 6, 1, 6),
    ('ICH', 'Pronomen (1. Sg.)', 'A', 6, 8, 3),
    ('LOKALE', 'örtliche', 'A', 7, 7, 6),
    ('REIF', 'erntefertig', 'A', 8, 3, 4),
    ('VIERTEL', 'Stadtteil', 'A', 9, 1, 7),
    ('FLUG', 'Luftreise', 'A', 9, 9, 4),
    ('IRAKER', 'Mann aus Bagdad', 'A', 10, 1, 6),
    ('HEFTE', 'Broschüren', 'A', 10, 8, 5),
    ('ERLERNT', 'studiert', 'A', 11, 1, 7),
    ('STAB', 'Stock', 'A', 11, 9, 4),
    ('LEER', 'hohl', 'A', 12, 1, 4),
    ('STEHT', 'stockt', 'A', 12, 8, 5),
    ('ERNEUTE', 'wiederholte', 'D', 1, 1, 7),
    ('VIEL', 'reichlich', 'D', 9, 1, 4),
    ('SEI', 'existiere', 'D', 4, 2, 3),
    ('IRRE', 'Verrückte', 'D', 9, 2, 4),
    ('STREBT', 'trachtet', 'D', 1, 3, 6),
    ('REALE', 'wirkliche', 'D', 8, 3, 5),
    ('TEILTE', 'trennte', 'D', 1, 4, 6),
    ('ERKER', 'Vorbau', 'D', 8, 4, 5),
    ('MIT', 'samt', 'D', 1, 5, 3),
    ('LEITER', 'Chef', 'D', 6, 5, 6),
    ('ALTERS', 'im ... von', 'D', 1, 6, 6),
    ('FERNE', 'Weite', 'D', 8, 6, 5),
    ('LEERE', 'Vakuum', 'D', 1, 7, 5),
    ('RADIOS', 'Empfänger', 'D', 3, 8, 6),
    ('HECK', 'Hinterteil', 'D', 4, 9, 4),
    ('FEST', 'stabil', 'D', 9, 9, 4),
    ('WIEN', 'österr. Hauptstadt', 'D', 1, 10, 4),
    ('HAELFTE', '50 Prozent', 'D', 6, 10, 7),
    ('INNE', '... halten', 'D', 1, 11, 4),
    ('UTAH', 'Mormonenstaat', 'D', 9, 11, 4),
    ('REGNETE', 'goss', 'D', 1, 12, 7),
    ('GEBT', 'reicht', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r065-13x13-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r065-13x13-02', 'Rätsel 65 · 13×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '13x13-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('KAUFMANN', 'Händler', 'A', 1, 1, 8),
    ('DER', 'Artikel (männl.)', 'A', 1, 10, 3),
    ('PIANO', 'Klavier', 'A', 2, 3, 5),
    ('ERDE', 'Welt', 'A', 2, 9, 4),
    ('DENKEN', 'grübeln', 'A', 3, 3, 6),
    ('ELF', 'Zahl (10+1)', 'A', 3, 10, 3),
    ('EGAL', 'gleichgültig', 'A', 4, 1, 4),
    ('ATELIER', 'Werkstatt', 'A', 4, 6, 7),
    ('RATE', 'Teilzahlung', 'A', 5, 1, 4),
    ('REUE', 'Bedauern', 'A', 5, 6, 4),
    ('EBENDA', 'dort', 'A', 6, 1, 6),
    ('BIS', 'nicht später als', 'A', 6, 8, 3),
    ('NADELN', 'Nähzeug', 'A', 7, 7, 6),
    ('FUER', 'zugunsten', 'A', 8, 3, 4),
    ('DUENNER', 'magerer', 'A', 9, 1, 7),
    ('SAFE', 'Tresor', 'A', 9, 9, 4),
    ('ERSTEN', 'anfänglichen', 'A', 10, 1, 6),
    ('DATEN', 'Angaben', 'A', 10, 8, 5),
    ('ANTENNE', 'Empfänger', 'A', 11, 1, 7),
    ('GOLD', 'Edelmetall', 'A', 11, 9, 4),
    ('LEER', 'hohl', 'A', 12, 1, 4),
    ('VERSE', 'Reime', 'A', 12, 8, 5),
    ('KLAEREN', 'lösen', 'D', 1, 1, 7),
    ('DEAL', 'Geschäft', 'D', 9, 1, 4),
    ('GAB', 'schenkte', 'D', 4, 2, 3),
    ('URNE', 'Aschengefäß', 'D', 9, 2, 4),
    ('UPDATE', 'Nachtrag', 'D', 1, 3, 6),
    ('FESTE', 'stabile', 'D', 8, 3, 5),
    ('FIELEN', 'stürzten', 'D', 1, 4, 6),
    ('UNTER', 'inmitten', 'D', 8, 4, 5),
    ('MAN', 'jemand', 'D', 1, 5, 3),
    ('DIENEN', 'nützen', 'D', 6, 5, 6),
    ('ANKARA', 'türk. Hauptstadt', 'D', 1, 6, 6),
    ('RENNT', 'läuft', 'D', 8, 6, 5),
    ('NOETE', 'Sorgen', 'D', 1, 7, 5),
    ('NEUBAU', 'frisches Gebäude', 'D', 3, 8, 6),
    ('LEID', 'Kummer', 'D', 4, 9, 4),
    ('SAGE', 'Legende', 'D', 9, 9, 4),
    ('DREI', 'Zahl (2+1)', 'D', 1, 10, 4),
    ('SENATOR', 'Ratsherr', 'D', 6, 10, 7),
    ('EDLE', 'vornehme', 'D', 1, 11, 4),
    ('FELS', 'Stein', 'D', 9, 11, 4),
    ('REFRAIN', 'Kehrreim', 'D', 1, 12, 7),
    ('ENDE', 'Schluss', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r066-13x13-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r066-13x13-02', 'Rätsel 66 · 13×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '13x13-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('WAEHLBAR', 'optional', 'A', 1, 1, 8),
    ('ABT', 'Klosterchef', 'A', 1, 10, 3),
    ('RAUER', 'grober', 'A', 2, 3, 5),
    ('GRAU', 'farblos', 'A', 2, 9, 4),
    ('REDETE', 'sprach', 'A', 3, 3, 6),
    ('ZUR', 'zu der', 'A', 3, 10, 3),
    ('KRAN', 'Hebezeug', 'A', 4, 1, 4),
    ('REISTEN', 'fuhren', 'A', 4, 6, 7),
    ('SANG', 'trällerte', 'A', 5, 1, 4),
    ('ENGE', 'schmale', 'A', 5, 6, 4),
    ('ANGELN', 'Fischen', 'A', 6, 1, 6),
    ('NIE', 'nimmer', 'A', 6, 8, 3),
    ('GELDER', 'Mittel', 'A', 7, 7, 6),
    ('NEID', 'Missgunst', 'A', 8, 3, 4),
    ('AMEISEN', 'Krabbeltiere', 'A', 9, 1, 7),
    ('STEG', 'Brücklein', 'A', 9, 9, 4),
    ('RUNTER', 'hinab', 'A', 10, 1, 6),
    ('WEIHE', 'Segnung', 'A', 10, 8, 5),
    ('INNERER', 'interner', 'A', 11, 1, 7),
    ('HORN', 'Hupe', 'A', 11, 9, 4),
    ('EDEL', 'vornehm', 'A', 12, 1, 4),
    ('RENTE', 'Pension', 'A', 12, 8, 5),
    ('WIRKSAM', 'effektiv', 'D', 1, 1, 7),
    ('ARIE', 'Sologesang', 'D', 9, 1, 4),
    ('RAN', 'heran', 'D', 4, 2, 3),
    ('MUND', 'Maul', 'D', 9, 2, 4),
    ('ERRANG', 'gewann', 'D', 1, 3, 6),
    ('NENNE', 'bezeichne', 'D', 8, 3, 5),
    ('HAENGE', 'baumle', 'D', 1, 4, 6),
    ('EITEL', 'gefallsüchtig', 'D', 8, 4, 5),
    ('LUD', 'packte auf', 'D', 1, 5, 3),
    ('LEISER', 'gedämpfter', 'D', 6, 5, 6),
    ('BEEREN', 'Früchte', 'D', 1, 6, 6),
    ('DERER', 'jener', 'D', 8, 6, 5),
    ('ARTEN', 'Sorten', 'D', 1, 7, 5),
    ('EIGNEN', 'passen', 'D', 3, 8, 6),
    ('SEIL', 'Tau', 'D', 4, 9, 4),
    ('SEHE', 'erblicke', 'D', 9, 9, 4),
    ('ARZT', 'Mediziner', 'D', 1, 10, 4),
    ('EDITION', 'Ausgabe', 'D', 6, 10, 7),
    ('BAUE', 'errichte', 'D', 1, 11, 4),
    ('EHRT', 'würdigt', 'D', 9, 11, 4),
    ('TURNIER', 'Wettkampf', 'D', 1, 12, 7),
    ('GENE', 'Erbanlagen', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r067-13x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r067-13x13-03', 'Rätsel 67 · 13×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '13x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('TYPS', 'Art des ...', 'A', 1, 1, 4),
    ('SIE', 'Anrede', 'A', 1, 6, 3),
    ('ACH', 'Ausruf', 'A', 1, 10, 3),
    ('AUF', 'offen', 'A', 2, 1, 3),
    ('ATRIUM', 'Innenhof', 'A', 2, 5, 6),
    ('GALERIEN', 'Kunsthallen', 'A', 3, 1, 8),
    ('ELF', 'Zahl (10+1)', 'A', 3, 10, 3),
    ('NAHMEN', 'griffen', 'A', 4, 2, 6),
    ('LIEF', 'rannte', 'A', 4, 9, 4),
    ('SEES', 'Ufer des ...', 'A', 5, 3, 4),
    ('SET', 'Satz', 'A', 5, 10, 3),
    ('IST', 'befindet sich', 'A', 6, 1, 3),
    ('SAUBERE', 'reine', 'A', 6, 6, 7),
    ('SAELE', 'Hallen', 'A', 7, 1, 5),
    ('LEINE', 'Seil', 'A', 7, 7, 5),
    ('EHRE', 'Würde', 'A', 8, 1, 4),
    ('NAHE', 'dicht bei', 'A', 8, 6, 4),
    ('BELEGE', 'Quittungen', 'A', 9, 7, 6),
    ('EBBE', 'Gegenteil der Flut', 'A', 10, 1, 4),
    ('MAL', 'Zeichen ×', 'A', 10, 6, 3),
    ('WAR', 'existierte', 'A', 10, 10, 3),
    ('REINE', 'pure', 'A', 11, 1, 5),
    ('MOBILE', 'bewegliche', 'A', 11, 7, 6),
    ('ZINS', 'Ertrag', 'A', 12, 1, 4),
    ('LAS', 'schmökerte', 'A', 12, 6, 3),
    ('GAR', 'durchgekocht', 'A', 12, 10, 3),
    ('TAG', '24 Stunden', 'D', 1, 1, 3),
    ('EISENERZ', 'Rohstoff', 'D', 5, 1, 8),
    ('YUAN', 'chin. Währung', 'D', 1, 2, 4),
    ('SAH', 'erblickte', 'D', 6, 2, 3),
    ('BEI', 'nahe an', 'D', 10, 2, 3),
    ('PFLASTER', 'Straßenbelag', 'D', 1, 3, 8),
    ('BIN', 'existiere', 'D', 10, 3, 3),
    ('EHE', 'Bund fürs Leben', 'D', 3, 4, 3),
    ('LEBENS', 'Ende des ...', 'D', 7, 4, 6),
    ('ARME', 'Mittellose', 'D', 2, 5, 4),
    ('STIESS', 'schubste', 'D', 1, 6, 6),
    ('IREN', 'Gälen', 'D', 1, 7, 4),
    ('ALABAMA', 'Südstaat', 'D', 6, 7, 7),
    ('EIN', 'unbest. Artikel', 'D', 1, 8, 3),
    ('MUEHELOS', 'leicht', 'D', 5, 8, 8),
    ('BIEL', 'Bienne', 'D', 6, 9, 4),
    ('AMEISEN', 'Krabbeltiere', 'D', 1, 10, 7),
    ('EWIG', 'endlos', 'D', 9, 10, 4),
    ('LEERE', 'Vakuum', 'D', 3, 11, 5),
    ('GALA', 'Festabend', 'D', 9, 11, 4),
    ('HOFFTE', 'erwartete', 'D', 1, 12, 6),
    ('DERER', 'jener', 'D', 8, 12, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r068-13x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r068-13x13-03', 'Rätsel 68 · 13×13', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '13x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ERBE', 'Nachlass', 'A', 1, 1, 4),
    ('ABT', 'Klosterchef', 'A', 1, 6, 3),
    ('AUS', 'vorbei', 'A', 1, 10, 3),
    ('NIE', 'nimmer', 'A', 2, 1, 3),
    ('BLAUEN', 'azurnen', 'A', 2, 5, 6),
    ('GEDEUTET', 'ausgelegt', 'A', 3, 1, 8),
    ('WAR', 'existierte', 'A', 3, 10, 3),
    ('FELDER', 'Äcker', 'A', 4, 2, 6),
    ('GEBE', 'reiche', 'A', 4, 9, 4),
    ('UFER', 'Gestade', 'A', 5, 3, 4),
    ('SEI', 'existiere', 'A', 5, 10, 3),
    ('ART', 'Sorte', 'A', 6, 1, 3),
    ('STUDENT', 'Hochschüler', 'A', 6, 6, 7),
    ('HIELT', 'stoppte', 'A', 7, 1, 5),
    ('STAND', 'stockte', 'A', 7, 7, 5),
    ('ROTE', 'purpurne', 'A', 8, 1, 4),
    ('RUHT', 'rastet', 'A', 8, 6, 4),
    ('NAEHER', 'dichter', 'A', 9, 7, 6),
    ('ABER', 'jedoch', 'A', 10, 1, 4),
    ('GAB', 'schenkte', 'A', 10, 6, 3),
    ('UND', 'sowie', 'A', 10, 10, 3),
    ('SEHEN', 'erblicken', 'A', 11, 1, 5),
    ('MEINTE', 'glaubte', 'A', 11, 7, 6),
    ('TIER', 'Lebewesen', 'A', 12, 1, 4),
    ('HIN', '... und her', 'A', 12, 6, 3),
    ('DER', 'Artikel (männl.)', 'A', 12, 10, 3),
    ('ENG', 'schmal', 'D', 1, 1, 3),
    ('FAHRGAST', 'Passagier', 'D', 5, 1, 8),
    ('RIEF', 'schrie', 'D', 1, 2, 4),
    ('RIO', 'Stadt in Brasilien', 'D', 6, 2, 3),
    ('BEI', 'nahe an', 'D', 10, 2, 3),
    ('BEDEUTET', 'heißt', 'D', 1, 3, 8),
    ('EHE', 'Bund fürs Leben', 'D', 10, 3, 3),
    ('ELF', 'Zahl (10+1)', 'D', 3, 4, 3),
    ('LEHRER', 'Pädagoge', 'D', 7, 4, 6),
    ('BUDE', 'Kiosk', 'D', 2, 5, 4),
    ('ALTERS', 'im ... von', 'D', 1, 6, 6),
    ('BAER', 'Petz', 'D', 1, 7, 4),
    ('TSUNAMI', 'Flutwelle', 'D', 6, 7, 7),
    ('TUT', 'macht', 'D', 1, 8, 3),
    ('GUTHABEN', 'Kontostand', 'D', 5, 8, 8),
    ('DATE', 'Verabredung', 'D', 6, 9, 4),
    ('ANWESEN', 'Landgut', 'D', 1, 10, 7),
    ('HUND', 'Vierbeiner', 'D', 9, 10, 4),
    ('ABEND', 'Tagesende', 'D', 3, 11, 5),
    ('ENTE', 'Wasservogel', 'D', 9, 11, 4),
    ('STREIT', 'Zank', 'D', 1, 12, 6),
    ('ORDER', 'Auftrag', 'D', 8, 12, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r069-13x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r069-13x13-03', 'Rätsel 69 · 13×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '13x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('EWIG', 'endlos', 'A', 1, 1, 4),
    ('NIE', 'nimmer', 'A', 1, 6, 3),
    ('SAH', 'erblickte', 'A', 1, 10, 3),
    ('HIN', '... und her', 'A', 2, 1, 3),
    ('MARINE', 'Flotte', 'A', 2, 5, 6),
    ('ENTKAMEN', 'entwischten', 'A', 3, 1, 8),
    ('ART', 'Sorte', 'A', 3, 10, 3),
    ('DAUMEN', 'Finger', 'A', 4, 2, 6),
    ('ETAT', 'Budget', 'A', 4, 9, 4),
    ('KRAN', 'Hebezeug', 'A', 5, 3, 4),
    ('TUE', 'mache', 'A', 5, 10, 3),
    ('AKT', 'Aufzug', 'A', 6, 1, 3),
    ('STOLLEN', 'Grubengang', 'A', 6, 6, 7),
    ('SUESS', 'zuckrig', 'A', 7, 1, 5),
    ('IDEEN', 'Einfälle', 'A', 7, 7, 5),
    ('AHNT', 'vermutet', 'A', 8, 1, 4),
    ('SEES', 'Ufer des ...', 'A', 8, 6, 4),
    ('FRESKO', 'Wandbild', 'A', 9, 7, 6),
    ('TRAF', 'begegnete', 'A', 10, 1, 4),
    ('GEN', 'nach', 'A', 10, 6, 3),
    ('TOT', 'leblos', 'A', 10, 10, 3),
    ('EILTE', 'hastete', 'A', 11, 1, 5),
    ('REGIME', 'Herrschaft', 'A', 11, 7, 6),
    ('NOTE', 'Zensur', 'A', 12, 1, 4),
    ('PER', 'mittels', 'A', 12, 6, 3),
    ('LAS', 'schmökerte', 'A', 12, 10, 3),
    ('EHE', 'Bund fürs Leben', 'D', 1, 1, 3),
    ('RASANTEN', 'schnellen', 'D', 5, 1, 8),
    ('WIND', 'Luftzug', 'D', 1, 2, 4),
    ('KUH', 'Rind', 'D', 6, 2, 3),
    ('RIO', 'Stadt in Brasilien', 'D', 10, 2, 3),
    ('INTAKTEN', 'unversehrten', 'D', 1, 3, 8),
    ('ALT', 'betagt', 'D', 10, 3, 3),
    ('KUR', 'Erholung', 'D', 3, 4, 3),
    ('STIFTE', 'Kulis', 'D', 7, 4, 6),
    ('MAMA', 'Mutti', 'D', 2, 5, 4),
    ('NAMENS', 'genannt', 'D', 1, 6, 6),
    ('IREN', 'Gälen', 'D', 1, 7, 4),
    ('TIEFERE', 'niedrigere', 'D', 6, 7, 7),
    ('EIN', 'unbest. Artikel', 'D', 1, 8, 3),
    ('MODERNER', 'zeitgemäßer', 'D', 5, 8, 8),
    ('LESE', 'schmökere', 'D', 6, 9, 4),
    ('SEATTLE', 'Stadt in Washington', 'D', 1, 10, 7),
    ('STIL', 'Machart', 'D', 9, 10, 4),
    ('RAUEN', 'groben', 'D', 3, 11, 5),
    ('KOMA', 'tiefe Ohnmacht', 'D', 9, 11, 4),
    ('HATTEN', 'besaßen', 'D', 1, 12, 6),
    ('ROTES', 'purpurnes', 'D', 8, 12, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r070-15x15-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r070-15x15-01', 'Rätsel 70 · 15×15', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '15x15-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('KIES', 'Schotter', 'A', 1, 1, 4),
    ('OFT', 'häufig', 'A', 1, 6, 3),
    ('SEKTE', 'Kult', 'A', 1, 10, 5),
    ('ANREISE', 'Hinfahrt', 'A', 2, 1, 7),
    ('NAME', 'Bezeichnung', 'A', 2, 9, 4),
    ('EDLE', 'vornehme', 'A', 3, 1, 4),
    ('TEE', 'Heißgetränk', 'A', 3, 6, 3),
    ('FARBE', 'Kolorit', 'A', 3, 10, 5),
    ('FEINDE', 'Gegner', 'A', 4, 1, 6),
    ('EINER', 'unbest. Art. (w.)', 'A', 4, 10, 5),
    ('IST', 'befindet sich', 'A', 5, 1, 3),
    ('ANKER', 'Halt', 'A', 5, 5, 5),
    ('GAS', 'Brennstoff', 'A', 6, 12, 3),
    ('METERN', 'nach hundert ...', 'A', 7, 2, 6),
    ('BEWEGT', 'gerührt', 'A', 7, 9, 6),
    ('MAN', 'jemand', 'A', 8, 1, 3),
    ('BEDIENEN', 'servieren', 'A', 8, 5, 8),
    ('WEH', 'schmerzhaft', 'A', 9, 4, 3),
    ('TAG', '24 Stunden', 'A', 9, 9, 3),
    ('WOVON', 'worüber', 'A', 10, 1, 5),
    ('BROT', 'Laib', 'A', 10, 7, 4),
    ('IDOL', 'Vorbild', 'A', 11, 1, 4),
    ('KEIN', 'nicht ein', 'A', 11, 6, 4),
    ('PUTZ', 'Mauerbelag', 'A', 11, 11, 4),
    ('DENKMALS', 'Sockel des ...', 'A', 12, 1, 8),
    ('TUERE', 'Pforte', 'A', 12, 10, 5),
    ('EINES', 'unbest. Art. (Gen.)', 'A', 13, 4, 5),
    ('ORGEL', 'Instrument', 'A', 13, 10, 5),
    ('RUF', 'Leumund', 'A', 14, 1, 3),
    ('TUGEND', 'Moral', 'A', 14, 5, 6),
    ('TUT', 'macht', 'A', 14, 12, 3),
    ('KAEFIG', 'Gehege', 'D', 1, 1, 6),
    ('WIDER', 'gegen', 'D', 10, 1, 5),
    ('INDES', 'jedoch', 'D', 1, 2, 5),
    ('MARODE', 'baufällig', 'D', 7, 2, 6),
    ('ERLITTEN', 'erduldet', 'D', 1, 3, 8),
    ('VON', 'ab, aus', 'D', 10, 3, 3),
    ('SEEN', 'Gewässer', 'D', 1, 4, 4),
    ('WOLKE', 'Dunstgebilde', 'D', 9, 4, 5),
    ('DANEBEN', 'außerdem', 'D', 4, 5, 7),
    ('MIT', 'samt', 'D', 12, 5, 3),
    ('OSTEN', 'Richtung O', 'D', 1, 6, 5),
    ('REH', 'Waldtier', 'D', 7, 6, 3),
    ('KANU', 'Paddelboot', 'D', 11, 6, 4),
    ('FEE', 'Zauberin', 'D', 1, 7, 3),
    ('KIND', 'Nachwuchs', 'D', 5, 7, 4),
    ('BELEG', 'Quittung', 'D', 10, 7, 5),
    ('EHE', 'Bund fürs Leben', 'D', 3, 8, 3),
    ('RISSE', 'Spalten', 'D', 10, 8, 5),
    ('BETON', 'Baustoff', 'D', 7, 9, 5),
    ('SAFE', 'Tresor', 'D', 1, 10, 4),
    ('SENAT', 'Ältestenrat', 'D', 6, 10, 5),
    ('TOD', 'Ableben', 'D', 12, 10, 3),
    ('EMAIL', 'elektr. Post', 'D', 1, 11, 5),
    ('WEG', 'Pfad', 'D', 7, 11, 3),
    ('PUR', 'rein', 'D', 11, 11, 3),
    ('KERN', 'Mittelpunkt', 'D', 1, 12, 4),
    ('GEN', 'nach', 'D', 6, 12, 3),
    ('FUEGT', 'setzt', 'D', 10, 12, 5),
    ('BELAG', 'Überzug', 'D', 3, 13, 5),
    ('TREU', 'loyal', 'D', 11, 13, 4),
    ('EIER', 'Gelege', 'D', 1, 14, 4),
    ('STIL', 'Machart', 'D', 6, 14, 4),
    ('ZELT', 'Pavillon', 'D', 11, 14, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r071-15x15-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r071-15x15-01', 'Rätsel 71 · 15×15', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '15x15-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ELBE', 'Strom durch Dresden', 'A', 1, 1, 4),
    ('MIT', 'samt', 'A', 1, 6, 3),
    ('PFEIL', 'Geschoss', 'A', 1, 10, 5),
    ('RAEUMEN', 'Zimmern', 'A', 2, 1, 7),
    ('KALT', 'frostig', 'A', 2, 9, 4),
    ('BIER', 'Gerstensaft', 'A', 3, 1, 4),
    ('IST', 'befindet sich', 'A', 3, 6, 3),
    ('SOWIE', 'und', 'A', 3, 10, 5),
    ('GENOSS', 'kostete aus', 'A', 4, 1, 6),
    ('STAND', 'stockte', 'A', 4, 10, 5),
    ('UND', 'sowie', 'A', 5, 1, 3),
    ('ETAGE', 'Stockwerk', 'A', 5, 5, 5),
    ('SEI', 'existiere', 'A', 6, 12, 3),
    ('STRAHL', 'Lichtbündel', 'A', 7, 2, 6),
    ('AREALS', 'Größe des ...', 'A', 7, 9, 6),
    ('WIE', 'gleich', 'A', 8, 1, 3),
    ('ROETLICH', 'rosig', 'A', 8, 5, 8),
    ('GAB', 'schenkte', 'A', 9, 4, 3),
    ('LOK', 'Zugmaschine', 'A', 9, 9, 3),
    ('ENDET', 'hört auf', 'A', 10, 1, 5),
    ('HIER', 'an diesem Ort', 'A', 10, 7, 4),
    ('RAUB', 'Diebstahl', 'A', 11, 1, 4),
    ('SOHN', 'Nachkomme', 'A', 11, 6, 4),
    ('KIES', 'Schotter', 'A', 11, 11, 4),
    ('KLOESTER', 'Abteien', 'A', 12, 1, 8),
    ('ZUNGE', 'Schmeckorgan', 'A', 12, 10, 5),
    ('TEURE', 'kostspielige', 'A', 13, 4, 5),
    ('ORGAN', 'Körperteil', 'A', 13, 10, 5),
    ('RUF', 'Leumund', 'A', 14, 1, 3),
    ('ERTRAG', 'Gewinn', 'A', 14, 5, 6),
    ('ELF', 'Zahl (10+1)', 'A', 14, 12, 3),
    ('ERBGUT', 'Gene', 'D', 1, 1, 6),
    ('ERKER', 'Vorbau', 'D', 10, 1, 5),
    ('LAIEN', 'Amateure', 'D', 1, 2, 5),
    ('SIGNAL', 'Zeichen', 'D', 7, 2, 6),
    ('BEENDETE', 'schloss ab', 'D', 1, 3, 8),
    ('DUO', 'Paar', 'D', 10, 3, 3),
    ('EURO', 'Währung', 'D', 1, 4, 4),
    ('GEBET', 'Andacht', 'D', 9, 4, 5),
    ('SEPARAT', 'getrennt', 'D', 4, 5, 7),
    ('SEE', 'Gewässer', 'D', 12, 5, 3),
    ('MEIST', 'überwiegend', 'D', 1, 6, 5),
    ('HOB', 'stemmte', 'D', 7, 6, 3),
    ('STUR', 'starrsinnig', 'D', 11, 6, 4),
    ('INS', 'in das', 'D', 1, 7, 3),
    ('ALLE', 'sämtliche', 'D', 5, 7, 4),
    ('HOERT', 'lauscht', 'D', 10, 7, 5),
    ('TAG', '24 Stunden', 'D', 3, 8, 3),
    ('IHRER', 'seiner', 'D', 10, 8, 5),
    ('ALLEN', 'sämtlichen', 'D', 7, 9, 5),
    ('PASS', 'Ausweis', 'D', 1, 10, 4),
    ('PRIOR', 'Klosteroberer', 'D', 6, 10, 5),
    ('ZOG', 'zerrte', 'D', 12, 10, 3),
    ('FLOTT', 'zügig', 'D', 1, 11, 5),
    ('ECK', 'Winkel', 'D', 7, 11, 3),
    ('KUR', 'Erholung', 'D', 11, 11, 3),
    ('ETWA', 'ungefähr', 'D', 1, 12, 4),
    ('SAH', 'erblickte', 'D', 6, 12, 3),
    ('RINGE', 'Reifen', 'D', 10, 12, 5),
    ('INSEL', 'Eiland', 'D', 3, 13, 5),
    ('EGAL', 'gleichgültig', 'D', 11, 13, 4),
    ('LIED', 'Song', 'D', 1, 14, 4),
    ('ISST', 'speist', 'D', 6, 14, 4),
    ('SENF', 'Mostrich', 'D', 11, 14, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r072-15x15-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r072-15x15-01', 'Rätsel 72 · 15×15', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '15x15-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AFFE', 'Primat', 'A', 1, 1, 4),
    ('RAD', 'Velo', 'A', 1, 6, 3),
    ('BAUEN', 'errichten', 'A', 1, 10, 5),
    ('BLENDEN', 'Jalousien', 'A', 2, 1, 7),
    ('MAUT', 'Gebühr', 'A', 2, 9, 4),
    ('FORT', 'weg', 'A', 3, 1, 4),
    ('ASS', 'speiste', 'A', 3, 6, 3),
    ('STAAT', 'Nation', 'A', 3, 10, 5),
    ('URTEIL', 'Verdikt', 'A', 4, 1, 6),
    ('SOHLE', 'Talgrund', 'A', 4, 10, 5),
    ('HAI', 'Raubfisch', 'A', 5, 1, 3),
    ('NEBEL', 'Dunst', 'A', 5, 5, 5),
    ('BEI', 'nahe an', 'A', 6, 12, 3),
    ('GESIMS', 'Vorsprung', 'A', 7, 2, 6),
    ('ALBUMS', 'Titel des ...', 'A', 7, 9, 6),
    ('YEN', 'Währung Japans', 'A', 8, 1, 3),
    ('ZUSCHLAG', 'Aufpreis', 'A', 8, 5, 8),
    ('SET', 'Satz', 'A', 9, 4, 3),
    ('NEU', 'frisch', 'A', 9, 9, 3),
    ('STAUS', 'Blechlawinen', 'A', 10, 1, 5),
    ('EBEN', 'flach', 'A', 10, 7, 4),
    ('OELE', 'Fette', 'A', 11, 1, 4),
    ('URIN', 'Harn', 'A', 11, 6, 4),
    ('REIS', 'Getreideart', 'A', 11, 11, 4),
    ('ENTSORGT', 'beseitigt', 'A', 12, 1, 8),
    ('LANGE', 'geraume Zeit', 'A', 12, 10, 5),
    ('SENAT', 'Ältestenrat', 'A', 13, 4, 5),
    ('URNEN', 'Aschengefäße', 'A', 13, 10, 5),
    ('TYP', 'Kerl', 'A', 14, 1, 3),
    ('LEBEND', 'atmend', 'A', 14, 5, 6),
    ('ELF', 'Zahl (10+1)', 'A', 14, 12, 3),
    ('ABFUHR', 'Absage', 'D', 1, 1, 6),
    ('SOEST', 'Stadt in Westfalen', 'D', 10, 1, 5),
    ('FLORA', 'Pflanzenwelt', 'D', 1, 2, 5),
    ('GELTEN', 'zählen', 'D', 7, 2, 6),
    ('FERTIGEN', 'herstellen', 'D', 1, 3, 8),
    ('ALT', 'betagt', 'D', 10, 3, 3),
    ('ENTE', 'Wasservogel', 'D', 1, 4, 4),
    ('SUESS', 'zuckrig', 'D', 9, 4, 5),
    ('INDIZES', 'Kennzahlen', 'D', 4, 5, 7),
    ('OEL', 'Schmierstoff', 'D', 12, 5, 3),
    ('REALE', 'wirkliche', 'D', 1, 6, 5),
    ('MUT', 'Courage', 'D', 7, 6, 3),
    ('URNE', 'Aschengefäß', 'D', 11, 6, 4),
    ('ANS', 'an das', 'D', 1, 7, 3),
    ('BOSS', 'Chef', 'D', 5, 7, 4),
    ('ERGAB', 'brachte', 'D', 10, 7, 5),
    ('SEE', 'Gewässer', 'D', 3, 8, 3),
    ('BITTE', 'Anliegen', 'D', 10, 8, 5),
    ('AHNEN', 'vermuten', 'D', 7, 9, 5),
    ('BASS', 'tiefe Stimme', 'D', 1, 10, 4),
    ('ALLEN', 'sämtlichen', 'D', 6, 10, 5),
    ('LUD', 'packte auf', 'D', 12, 10, 3),
    ('AUTOS', 'Wagen', 'D', 1, 11, 5),
    ('BAU', 'Gebäude', 'D', 7, 11, 3),
    ('RAR', 'selten', 'D', 11, 11, 3),
    ('UTAH', 'Mormonenstaat', 'D', 1, 12, 4),
    ('BUG', 'Vorderschiff', 'D', 6, 12, 3),
    ('KENNE', 'weiß', 'D', 10, 12, 5),
    ('ALTEM', 'betagtem', 'D', 3, 13, 5),
    ('IGEL', 'Stacheltier', 'D', 11, 13, 4),
    ('NOTE', 'Zensur', 'D', 1, 14, 4),
    ('ISST', 'speist', 'D', 6, 14, 4),
    ('SENF', 'Mostrich', 'D', 11, 14, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r073-15x15-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r073-15x15-02', 'Rätsel 73 · 15×15', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '15x15-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('FUERS', 'für das', 'A', 1, 1, 5),
    ('STAAT', 'Nation', 'A', 1, 10, 5),
    ('UND', 'sowie', 'A', 2, 1, 3),
    ('TEST', 'Prüfung', 'A', 2, 5, 4),
    ('TOLLE', 'großartige', 'A', 2, 10, 5),
    ('HILFE', 'Beistand', 'A', 3, 1, 5),
    ('TEUERSTE', 'kostbarste', 'A', 3, 7, 8),
    ('ERTRAG', 'Gewinn', 'A', 4, 3, 6),
    ('ESEL', 'Grautier', 'A', 5, 4, 4),
    ('ETWA', 'ungefähr', 'A', 5, 9, 4),
    ('DREI', 'Zahl (2+1)', 'A', 6, 1, 4),
    ('ALL', 'Weltraum', 'A', 6, 6, 3),
    ('ELBE', 'Strom durch Dresden', 'A', 6, 11, 4),
    ('EIN', 'unbest. Artikel', 'A', 7, 1, 3),
    ('PILOT', 'Flieger', 'A', 7, 10, 5),
    ('AMT', 'Behörde', 'A', 8, 1, 3),
    ('WERDE', 'entstehe', 'A', 8, 5, 5),
    ('SEX', 'Erotik', 'A', 8, 11, 3),
    ('LIEBE', 'Zuneigung', 'A', 9, 1, 5),
    ('EINS', 'Zahl (2−1)', 'A', 9, 8, 4),
    ('ERBE', 'Nachlass', 'A', 10, 4, 4),
    ('DAR', 'stellt ... (zeigt)', 'A', 10, 12, 3),
    ('ZEITLICH', 'temporal', 'A', 11, 2, 8),
    ('WADE', 'Beinmuskel', 'A', 11, 11, 4),
    ('MIT', 'samt', 'A', 12, 1, 3),
    ('LOS', 'frei', 'A', 12, 5, 3),
    ('EHEN', 'Bündnisse', 'A', 12, 11, 4),
    ('ANALOGE', 'ähnliche', 'A', 13, 1, 7),
    ('REGELN', 'Normen', 'A', 13, 9, 6),
    ('IST', 'befindet sich', 'A', 14, 1, 3),
    ('NUN', 'jetzt', 'A', 14, 7, 3),
    ('ERST', 'zunächst', 'A', 14, 11, 4),
    ('FUHR', 'reiste', 'D', 1, 1, 4),
    ('DEALS', 'Geschäfte', 'D', 6, 1, 5),
    ('MAI', '5. Monat', 'D', 12, 1, 3),
    ('UNI', 'Hochschule', 'D', 1, 2, 3),
    ('KRIMI', 'Thriller', 'D', 5, 2, 5),
    ('ZINS', 'Ertrag', 'D', 11, 2, 4),
    ('EDLE', 'vornehme', 'D', 1, 3, 4),
    ('ENTE', 'Wasservogel', 'D', 6, 3, 4),
    ('ETAT', 'Budget', 'D', 11, 3, 4),
    ('FREI', 'ungebunden', 'D', 3, 4, 4),
    ('BEI', 'nahe an', 'D', 9, 4, 3),
    ('STETS', 'immer', 'D', 1, 5, 5),
    ('WERTLOS', 'nichtig', 'D', 8, 5, 7),
    ('REALE', 'wirkliche', 'D', 4, 6, 5),
    ('BLOG', 'Webjournal', 'D', 10, 6, 4),
    ('STALL', 'Viehhaus', 'D', 2, 7, 5),
    ('EISEN', 'Metall', 'D', 10, 7, 5),
    ('STEG', 'Brücklein', 'D', 1, 8, 4),
    ('LADE', 'packe auf', 'D', 6, 8, 4),
    ('EINHORN', 'Fabeltier', 'D', 8, 9, 7),
    ('STEHT', 'stockt', 'D', 1, 10, 5),
    ('TOR', 'Treffer', 'D', 1, 11, 3),
    ('WEISS', 'schneefarben', 'D', 5, 11, 5),
    ('WEGE', 'Pfade', 'D', 11, 11, 4),
    ('ALS', 'da, während', 'D', 1, 12, 3),
    ('ALLE', 'sämtliche', 'D', 5, 12, 4),
    ('DAHER', 'deshalb', 'D', 10, 12, 5),
    ('ALTE', 'betagte', 'D', 1, 13, 4),
    ('BOX', 'Kiste', 'D', 6, 13, 3),
    ('ADELS', 'Titel des ...', 'D', 10, 13, 5),
    ('TEE', 'Heißgetränk', 'D', 1, 14, 3),
    ('SET', 'Satz', 'D', 5, 14, 3),
    ('BRENNT', 'lodert', 'D', 9, 14, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r074-15x15-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r074-15x15-02', 'Rätsel 74 · 15×15', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '15x15-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('PAPST', 'Pontifex', 'A', 1, 1, 5),
    ('ORTES', 'Name des ...', 'A', 1, 10, 5),
    ('AUF', 'offen', 'A', 2, 1, 3),
    ('IDEE', 'Einfall', 'A', 2, 5, 4),
    ('PAUSE', 'Rast', 'A', 2, 10, 5),
    ('TEAMS', 'Mannschaften', 'A', 3, 1, 5),
    ('INTERNET', 'Netz', 'A', 3, 7, 8),
    ('DECKEN', 'verhüllen', 'A', 4, 3, 6),
    ('EHER', 'lieber', 'A', 5, 4, 4),
    ('ENDE', 'Schluss', 'A', 5, 9, 4),
    ('MEHR', 'zusätzlich', 'A', 6, 1, 4),
    ('INS', 'in das', 'A', 6, 6, 3),
    ('RUHE', 'Stille', 'A', 6, 11, 4),
    ('OMA', 'Großmutter', 'A', 7, 1, 3),
    ('VORAN', 'vorwärts', 'A', 7, 10, 5),
    ('TOR', 'Treffer', 'A', 8, 1, 3),
    ('AESTE', 'Zweige', 'A', 8, 5, 5),
    ('HOB', 'stemmte', 'A', 8, 11, 3),
    ('OSTEN', 'Richtung O', 'A', 9, 1, 5),
    ('TRAT', 'schritt', 'A', 9, 8, 4),
    ('HAST', 'besitzt', 'A', 10, 4, 4),
    ('VIA', 'über', 'A', 10, 12, 3),
    ('ADELAIDE', 'Stadt in Australien', 'A', 11, 2, 8),
    ('DOMS', 'Kuppel des ...', 'A', 11, 11, 4),
    ('DUO', 'Paar', 'A', 12, 1, 3),
    ('OFT', 'häufig', 'A', 12, 5, 3),
    ('IRAK', 'Land am Tigris', 'A', 12, 11, 4),
    ('ERREGTE', 'weckte', 'A', 13, 1, 7),
    ('LAENGE', 'Ausdehnung', 'A', 13, 9, 6),
    ('RAT', 'Tipp', 'A', 14, 1, 3),
    ('LOT', 'Senkblei', 'A', 14, 7, 3),
    ('SEEN', 'Gewässer', 'A', 14, 11, 4),
    ('PATE', 'Taufzeuge', 'D', 1, 1, 4),
    ('MOTOR', 'Antrieb', 'D', 6, 1, 5),
    ('DER', 'Artikel (männl.)', 'D', 12, 1, 3),
    ('AUE', 'Talwiese', 'D', 1, 2, 3),
    ('DEMOS', 'Kundgebungen', 'D', 5, 2, 5),
    ('AURA', 'Ausstrahlung', 'D', 11, 2, 4),
    ('PFAD', 'Weg', 'D', 1, 3, 4),
    ('HART', 'fest', 'D', 6, 3, 4),
    ('DORT', 'da', 'D', 11, 3, 4),
    ('MEER', 'See', 'D', 3, 4, 4),
    ('EHE', 'Bund fürs Leben', 'D', 9, 4, 3),
    ('TISCH', 'Tafel', 'D', 1, 5, 5),
    ('ANALOGE', 'ähnliche', 'D', 8, 5, 7),
    ('KEINE', 'null', 'D', 4, 6, 5),
    ('SAFT', 'Most', 'D', 10, 6, 4),
    ('EIERN', 'auf ... gehen', 'D', 2, 7, 5),
    ('TITEL', 'Überschrift', 'D', 10, 7, 5),
    ('WENN', 'falls', 'D', 1, 8, 4),
    ('SATT', 'gesättigt', 'D', 6, 8, 4),
    ('ERTEILT', 'gewährt', 'D', 8, 9, 7),
    ('OPERN', 'Musikdramen', 'D', 1, 10, 5),
    ('RAR', 'selten', 'D', 1, 11, 3),
    ('DROHT', 'steht bevor', 'D', 5, 11, 5),
    ('DIES', 'das hier', 'D', 11, 11, 4),
    ('TUN', 'machen', 'D', 1, 12, 3),
    ('EURO', 'Währung', 'D', 5, 12, 4),
    ('VORNE', 'an der Spitze', 'D', 10, 12, 5),
    ('ESEL', 'Grautier', 'D', 1, 13, 4),
    ('HAB', '... und Gut', 'D', 6, 13, 3),
    ('IMAGE', 'Ansehen', 'D', 10, 13, 5),
    ('SET', 'Satz', 'D', 1, 14, 3),
    ('YEN', 'Währung Japans', 'D', 5, 14, 3),
    ('MASKEN', 'Larven', 'D', 9, 14, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r075-15x15-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r075-15x15-02', 'Rätsel 75 · 15×15', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '15x15-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('APRIL', '4. Monat', 'A', 1, 1, 5),
    ('IMAGE', 'Ansehen', 'A', 1, 10, 5),
    ('FEE', 'Zauberin', 'A', 2, 1, 3),
    ('AKKU', 'Batterie', 'A', 2, 5, 4),
    ('DAUER', 'Zeitspanne', 'A', 2, 10, 5),
    ('FRIES', 'Zierstreifen', 'A', 3, 1, 5),
    ('EISENERZ', 'Rohstoff', 'A', 3, 7, 8),
    ('ZUSATZ', 'Ergänzung', 'A', 4, 3, 6),
    ('REST', 'Überbleibsel', 'A', 5, 4, 4),
    ('CLAN', 'Sippe', 'A', 5, 9, 4),
    ('ARIE', 'Sologesang', 'A', 6, 1, 4),
    ('SET', 'Satz', 'A', 6, 6, 3),
    ('LADE', 'packe auf', 'A', 6, 11, 4),
    ('BAR', 'Theke', 'A', 7, 1, 3),
    ('EISEN', 'Metall', 'A', 7, 10, 5),
    ('ZUR', 'zu der', 'A', 8, 1, 3),
    ('ANRUF', 'Telefonat', 'A', 8, 5, 5),
    ('ASS', 'speiste', 'A', 8, 11, 3),
    ('UFERN', 'Gestaden', 'A', 9, 1, 5),
    ('RUSS', 'Rauchstaub', 'A', 9, 8, 4),
    ('ASYL', 'Zuflucht', 'A', 10, 4, 4),
    ('GAR', 'durchgekocht', 'A', 10, 12, 3),
    ('ERNEUERN', 'renovieren', 'A', 11, 2, 8),
    ('WEGE', 'Pfade', 'A', 11, 11, 4),
    ('DUO', 'Paar', 'A', 12, 1, 3),
    ('HAI', 'Raubfisch', 'A', 12, 5, 3),
    ('ATEM', 'Luft', 'A', 12, 11, 4),
    ('ERSTENS', 'zunächst', 'A', 13, 1, 7),
    ('INLAND', 'Heimat', 'A', 13, 9, 6),
    ('ROT', 'purpurn', 'A', 14, 1, 3),
    ('ENG', 'schmal', 'A', 14, 7, 3),
    ('ENTE', 'Wasservogel', 'A', 14, 11, 4),
    ('AFFE', 'Primat', 'D', 1, 1, 4),
    ('ABZUG', 'Rückzug', 'D', 6, 1, 5),
    ('DER', 'Artikel (männl.)', 'D', 12, 1, 3),
    ('PER', 'mittels', 'D', 1, 2, 3),
    ('DRAUF', 'darauf', 'D', 5, 2, 5),
    ('EURO', 'Währung', 'D', 11, 2, 4),
    ('REIZ', 'Charme', 'D', 1, 3, 4),
    ('IRRE', 'Verrückte', 'D', 6, 3, 4),
    ('ROST', 'Grill', 'D', 11, 3, 4),
    ('EURE', 'Possessiv (ihr)', 'D', 3, 4, 4),
    ('RAN', 'heran', 'D', 9, 4, 3),
    ('LASSE', 'erlaube', 'D', 1, 5, 5),
    ('ANSEHEN', 'Prestige', 'D', 8, 5, 7),
    ('ASSEN', 'speisten', 'D', 4, 6, 5),
    ('YUAN', 'chin. Währung', 'D', 10, 6, 4),
    ('KETTE', 'Halsschmuck', 'D', 2, 7, 5),
    ('LEISE', 'gedämpft', 'D', 10, 7, 5),
    ('QUIZ', 'Ratespiel', 'D', 1, 8, 4),
    ('TOUR', 'Rundreise', 'D', 6, 8, 4),
    ('FUENDIG', 'erfolgreich', 'D', 8, 9, 7),
    ('IDEAL', 'Leitbild', 'D', 1, 10, 5),
    ('MAN', 'jemand', 'D', 1, 11, 3),
    ('ALIAS', 'auch genannt', 'D', 5, 11, 5),
    ('WALE', 'Meeressäuger', 'D', 11, 11, 4),
    ('AUE', 'Talwiese', 'D', 1, 12, 3),
    ('NASS', 'feucht', 'D', 5, 12, 4),
    ('GETAN', 'gemacht', 'D', 10, 12, 5),
    ('GERA', 'Stadt in Thüringen', 'D', 1, 13, 4),
    ('DES', 'Artikel (Genitiv)', 'D', 6, 13, 3),
    ('AGENT', 'Spion', 'D', 10, 13, 5),
    ('ERZ', 'Gestein', 'D', 1, 14, 3),
    ('GEN', 'nach', 'D', 5, 14, 3),
    ('FREMDE', 'Ausland', 'D', 9, 14, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r076-15x15-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r076-15x15-03', 'Rätsel 76 · 15×15', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '15x15-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('FLUSS', 'Strom', 'A', 1, 1, 5),
    ('FEATURES', 'Merkmale', 'A', 1, 7, 8),
    ('LUFT', 'Atmosphäre', 'A', 2, 1, 4),
    ('BEIM', 'bei dem', 'A', 2, 6, 4),
    ('OPER', 'Musiktheater', 'A', 3, 1, 4),
    ('LIST', 'Trick', 'A', 3, 6, 4),
    ('MEHR', 'zusätzlich', 'A', 3, 11, 4),
    ('GERATEN', 'angezeigt', 'A', 4, 1, 7),
    ('BEI', 'nahe an', 'A', 4, 12, 3),
    ('FERN', 'weit weg', 'A', 5, 11, 4),
    ('HAUS', 'Gebäude', 'A', 6, 1, 4),
    ('BIS', 'nicht später als', 'A', 6, 6, 3),
    ('MONAT', 'etwa 30 Tage', 'A', 6, 10, 5),
    ('INNEREN', 'internen', 'A', 7, 1, 7),
    ('WAREN', 'existierten', 'A', 7, 9, 5),
    ('TOD', 'Ableben', 'A', 8, 1, 3),
    ('ANSTALT', 'Institution', 'A', 8, 5, 7),
    ('ALLE', 'sämtliche', 'A', 9, 11, 4),
    ('TYPEN', 'Kerle', 'A', 10, 1, 5),
    ('HIN', '... und her', 'A', 10, 7, 3),
    ('NEIN', 'Ablehnung', 'A', 10, 11, 4),
    ('OMA', 'Großmutter', 'A', 11, 1, 3),
    ('DIENST', 'Arbeit', 'A', 11, 5, 6),
    ('SEE', 'Gewässer', 'A', 11, 12, 3),
    ('LEUTE', 'Personen', 'A', 12, 1, 5),
    ('UNI', 'Hochschule', 'A', 12, 7, 3),
    ('MUSS', 'soll', 'A', 12, 11, 4),
    ('SORGTEN', 'kümmerten sich', 'A', 13, 3, 7),
    ('ANS', 'an das', 'A', 13, 11, 3),
    ('EIERN', 'auf ... gehen', 'A', 14, 1, 5),
    ('NEIGEN', 'tendieren', 'A', 14, 9, 6),
    ('FLOG', 'segelte', 'D', 1, 1, 4),
    ('HIT', 'Schlager', 'D', 6, 1, 3),
    ('TOLLE', 'großartige', 'D', 10, 1, 5),
    ('LUPE', 'Brennglas', 'D', 1, 2, 4),
    ('ANONYME', 'namenlose', 'D', 6, 2, 7),
    ('UFER', 'Gestade', 'D', 1, 3, 4),
    ('UND', 'sowie', 'D', 6, 3, 3),
    ('PAUSE', 'Rast', 'D', 10, 3, 5),
    ('STRASSE', 'Fahrweg', 'D', 1, 4, 7),
    ('TOR', 'Treffer', 'D', 12, 4, 3),
    ('RAENDERN', 'Kanten', 'D', 7, 5, 8),
    ('BLEIBEN', 'verweilen', 'D', 2, 6, 7),
    ('FEIN', 'zart', 'D', 1, 7, 4),
    ('INS', 'in das', 'D', 6, 7, 3),
    ('HEUTE', 'jetzt', 'D', 10, 7, 5),
    ('EIS', 'Gefrorenes', 'D', 1, 8, 3),
    ('INNE', '... halten', 'D', 10, 8, 4),
    ('AMTS', 'im ... sein', 'D', 1, 9, 4),
    ('WAHNSINN', 'Irrsinn', 'D', 7, 9, 8),
    ('MAL', 'Zeichen ×', 'D', 6, 10, 3),
    ('ULM', 'Münsterstadt', 'D', 1, 11, 3),
    ('FORTAN', 'künftig', 'D', 5, 11, 6),
    ('MAI', '5. Monat', 'D', 12, 11, 3),
    ('EBENE', 'Fläche', 'D', 3, 12, 5),
    ('LESUNG', 'Vortrag', 'D', 9, 12, 6),
    ('HERAN', 'herbei', 'D', 3, 13, 5),
    ('LIESSE', 'erlaubte', 'D', 9, 13, 6),
    ('SPRINT', 'Spurt', 'D', 1, 14, 6),
    ('JENES', 'selbiges', 'D', 8, 14, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r077-15x15-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r077-15x15-03', 'Rätsel 77 · 15×15', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '15x15-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('FRIST', 'Termin', 'A', 1, 1, 5),
    ('KUEMMERT', 'sorgt sich', 'A', 1, 7, 8),
    ('LEGT', 'platziert', 'A', 2, 1, 4),
    ('FANS', 'Anhänger', 'A', 2, 6, 4),
    ('ODER', 'bzw.', 'A', 3, 1, 4),
    ('UNIS', 'Hochschulen', 'A', 3, 6, 4),
    ('IRRE', 'Verrückte', 'A', 3, 11, 4),
    ('GELADEN', 'wütend', 'A', 4, 1, 7),
    ('AUF', 'offen', 'A', 4, 12, 3),
    ('SEHE', 'erblicke', 'A', 5, 11, 4),
    ('MAUS', 'Nager', 'A', 6, 1, 4),
    ('RIO', 'Stadt in Brasilien', 'A', 6, 6, 3),
    ('VATER', 'Papa', 'A', 6, 10, 5),
    ('INNEREN', 'internen', 'A', 7, 1, 7),
    ('BOTEN', 'offerierten', 'A', 7, 9, 5),
    ('TOD', 'Ableben', 'A', 8, 1, 3),
    ('INSTANZ', 'Stelle', 'A', 8, 5, 7),
    ('EBBE', 'Gegenteil der Flut', 'A', 9, 11, 4),
    ('LYRIK', 'Poesie', 'A', 10, 1, 5),
    ('OHR', 'Hörorgan', 'A', 10, 7, 3),
    ('SEEN', 'Gewässer', 'A', 10, 11, 4),
    ('OMA', 'Großmutter', 'A', 11, 1, 3),
    ('ISRAEL', 'Nahoststaat', 'A', 11, 5, 6),
    ('WAR', 'existierte', 'A', 11, 12, 3),
    ('BESTE', 'optimale', 'A', 12, 1, 5),
    ('GAU', 'Landstrich', 'A', 12, 7, 3),
    ('DAME', 'Frau', 'A', 12, 11, 4),
    ('TORWART', 'Keeper', 'A', 13, 3, 7),
    ('ART', 'Sorte', 'A', 13, 11, 3),
    ('EVENT', 'Ereignis', 'A', 14, 1, 5),
    ('HERBEI', 'heran', 'A', 14, 9, 6),
    ('FLOG', 'segelte', 'D', 1, 1, 4),
    ('MIT', 'samt', 'D', 6, 1, 3),
    ('LOBTE', 'pries', 'D', 10, 1, 5),
    ('REDE', 'Ansprache', 'D', 1, 2, 4),
    ('ANONYME', 'namenlose', 'D', 6, 2, 7),
    ('IGEL', 'Stacheltier', 'D', 1, 3, 4),
    ('UND', 'sowie', 'D', 6, 3, 3),
    ('RASTE', 'jagte', 'D', 10, 3, 5),
    ('STRASSE', 'Fahrweg', 'D', 1, 4, 7),
    ('TON', 'Klang', 'D', 12, 4, 3),
    ('RISKIERT', 'wagt', 'D', 7, 5, 8),
    ('FUEHREN', 'leiten', 'D', 2, 6, 7),
    ('KANN', 'vermag', 'D', 1, 7, 4),
    ('INS', 'in das', 'D', 6, 7, 3),
    ('ORGAN', 'Körperteil', 'D', 10, 7, 5),
    ('UNI', 'Hochschule', 'D', 1, 8, 3),
    ('HAAR', 'Strähne', 'D', 10, 8, 4),
    ('ESSE', 'speise', 'D', 1, 9, 4),
    ('BAYREUTH', 'Wagnerstadt', 'D', 7, 9, 8),
    ('VON', 'ab, aus', 'D', 6, 10, 3),
    ('MAI', '5. Monat', 'D', 1, 11, 3),
    ('SATZES', 'Ende des ...', 'D', 5, 11, 6),
    ('DAR', 'stellt ... (zeigt)', 'D', 12, 11, 3),
    ('RAETE', 'Gremien', 'D', 3, 12, 5),
    ('BEWARB', 'pries an', 'D', 9, 12, 6),
    ('RUHEN', 'rasten', 'D', 3, 13, 5),
    ('BEAMTE', 'Staatsdiener', 'D', 9, 13, 6),
    ('TIEFER', 'niedriger', 'D', 1, 14, 6),
    ('GENRE', 'Gattung', 'D', 8, 14, 5)
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
    ('KLEVE', 'Stadt am Niederrhein', 'A', 1, 1, 5),
    ('NAECHTEN', 'in langen ...', 'A', 1, 7, 8),
    ('LESE', 'schmökere', 'A', 2, 1, 4),
    ('TALS', 'Grund des ...', 'A', 2, 6, 4),
    ('ABER', 'jedoch', 'A', 3, 1, 4),
    ('RISS', 'zerrte', 'A', 3, 6, 4),
    ('BLAU', 'betrunken', 'A', 3, 11, 4),
    ('RELATIV', 'ziemlich', 'A', 4, 1, 7),
    ('INS', 'in das', 'A', 4, 12, 3),
    ('REGT', 'bewegt', 'A', 5, 11, 4),
    ('PFAD', 'Weg', 'A', 6, 1, 4),
    ('REH', 'Waldtier', 'A', 6, 6, 3),
    ('RISSE', 'Spalten', 'A', 6, 10, 5),
    ('ERBAUEN', 'errichten', 'A', 7, 1, 7),
    ('DUETT', 'Zwiegesang', 'A', 7, 9, 5),
    ('ROT', 'purpurn', 'A', 8, 1, 3),
    ('ERGRIFF', 'packte', 'A', 8, 5, 7),
    ('EHRE', 'Würde', 'A', 9, 11, 4),
    ('STELE', 'Gedenkstein', 'A', 10, 1, 5),
    ('JOB', 'Beruf', 'A', 10, 7, 3),
    ('NEUN', 'Zahl (3×3)', 'A', 10, 11, 4),
    ('TAL', 'Senke', 'A', 11, 1, 3),
    ('RUEBER', 'hinüber', 'A', 11, 5, 6),
    ('IHR', 'Pronomen (2. Pl.)', 'A', 11, 12, 3),
    ('ALIAS', 'auch genannt', 'A', 12, 1, 5),
    ('AST', 'Zweig', 'A', 12, 7, 3),
    ('ARIE', 'Sologesang', 'A', 12, 11, 4),
    ('TRENNTE', 'schied', 'A', 13, 3, 7),
    ('MAG', 'liebt', 'A', 13, 11, 3),
    ('KAEME', 'nahte', 'A', 14, 1, 5),
    ('SITTEN', 'Bräuche', 'A', 14, 9, 6),
    ('KLAR', 'deutlich', 'D', 1, 1, 4),
    ('PER', 'mittels', 'D', 6, 1, 3),
    ('STARK', 'kräftig', 'D', 10, 1, 5),
    ('LEBE', 'existiere', 'D', 1, 2, 4),
    ('FRONTAL', 'von vorn', 'D', 6, 2, 7),
    ('ESEL', 'Grautier', 'D', 1, 3, 4),
    ('ABT', 'Klosterchef', 'D', 6, 3, 3),
    ('ELITE', 'Auslese', 'D', 10, 3, 5),
    ('VERANDA', 'Terrasse', 'D', 1, 4, 7),
    ('ARM', 'Gliedmaße', 'D', 12, 4, 3),
    ('UEBERSEE', 'ferne Länder', 'D', 7, 5, 8),
    ('TRIERER', 'Moselstädter', 'D', 2, 6, 7),
    ('NAIV', 'arglos', 'D', 1, 7, 4),
    ('ENG', 'schmal', 'D', 6, 7, 3),
    ('JEANS', 'Nietenhose', 'D', 10, 7, 5),
    ('ALS', 'da, während', 'D', 1, 8, 3),
    ('OBST', 'Früchte', 'D', 10, 8, 4),
    ('ESSE', 'speise', 'D', 1, 9, 4),
    ('DIABETES', 'Zuckerleiden', 'D', 7, 9, 8),
    ('RUF', 'Leumund', 'D', 6, 10, 3),
    ('HAB', '... und Gut', 'D', 1, 11, 3),
    ('RIEFEN', 'schrien', 'D', 5, 11, 6),
    ('AMT', 'Behörde', 'D', 12, 11, 3),
    ('LIEST', 'schmökert', 'D', 3, 12, 5),
    ('HEIRAT', 'Hochzeit', 'D', 9, 12, 6),
    ('ANGST', 'Furcht', 'D', 3, 13, 5),
    ('RUHIGE', 'stille', 'D', 9, 13, 6),
    ('NEUSTE', 'jüngste', 'D', 1, 14, 6),
    ('GENRE', 'Gattung', 'D', 8, 14, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

commit;
-- Automatisch erzeugt von tools/generator/generate_raetsel.py – nicht von Hand bearbeiten.
-- Voraussetzung: Migrationen, gitter_vorlagen.sql, woerter_seed.sql, fragen_varianten_seed.sql eingespielt.
-- Idempotent über raetsel.slug. Rätsel mit Prüfhinweisen werden als Entwurf angelegt.

begin;

-- r079-8x8-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r079-8x8-01', 'Rätsel 79 · 8×8', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '8x8-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('EDEL', 'vornehm', 'A', 1, 1, 4),
    ('RELIKT', 'Überbleibsel', 'A', 2, 1, 6),
    ('ZIFFER', 'Zahlzeichen', 'A', 3, 1, 6),
    ('TRAT', 'schritt', 'A', 4, 4, 4),
    ('HEU', 'Trockengras', 'A', 5, 1, 3),
    ('ZUR', 'zu der', 'A', 5, 5, 3),
    ('MIETE', 'Pacht', 'A', 6, 3, 5),
    ('BUS', 'Car (schweiz.)', 'A', 7, 1, 3),
    ('NEU', 'frisch', 'A', 7, 5, 3),
    ('ERZ', 'Gestein', 'D', 1, 1, 3),
    ('HUB', 'Hebung', 'D', 5, 1, 3),
    ('DEINE', 'Possessiv (du)', 'D', 1, 2, 5),
    ('ELF', 'Zahl (10+1)', 'D', 1, 3, 3),
    ('UMS', 'um das', 'D', 5, 3, 3),
    ('LIFT', 'Aufzug', 'D', 1, 4, 4),
    ('KERZEN', 'Lichter', 'D', 2, 5, 6),
    ('TRAUTE', 'wagte', 'D', 2, 6, 6),
    ('TREU', 'loyal', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r080-8x8-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r080-8x8-02', 'Rätsel 80 · 8×8', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '8x8-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('NOCH', 'bislang', 'A', 1, 4, 4),
    ('NEUER', 'frischer', 'A', 2, 1, 5),
    ('ARMUT', 'Not', 'A', 3, 1, 5),
    ('HUFE', 'Pferdefüße', 'A', 4, 1, 4),
    ('ERLAG', 'starb an', 'A', 5, 3, 5),
    ('LEUTE', 'Personen', 'A', 6, 3, 5),
    ('UND', 'sowie', 'A', 7, 1, 3),
    ('DEN', 'Artikel (Akkusativ)', 'A', 7, 5, 3),
    ('NAHEZU', 'fast', 'D', 2, 1, 6),
    ('PERU', 'Andenstaat', 'D', 1, 2, 4),
    ('UMFELD', 'Milieu', 'D', 2, 3, 6),
    ('NEUERE', 'Jüngere', 'D', 1, 4, 6),
    ('ORT', 'Stelle', 'D', 1, 5, 3),
    ('LUD', 'packte auf', 'D', 5, 5, 3),
    ('RATE', 'Teilzahlung', 'D', 4, 6, 4),
    ('HAT', 'besitzt', 'D', 1, 7, 3),
    ('GEN', 'nach', 'D', 5, 7, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r081-8x8-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r081-8x8-03', 'Rätsel 81 · 8×8', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '8x8-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('FINGER', 'Glied der Hand', 'A', 1, 1, 6),
    ('SIEBEN', 'Zahl (3+4)', 'A', 2, 2, 6),
    ('STEHEN', 'aufrecht sein', 'A', 3, 1, 6),
    ('ENTE', 'Wasservogel', 'A', 4, 4, 4),
    ('AMT', 'Behörde', 'A', 5, 1, 3),
    ('DER', 'Artikel (männl.)', 'A', 5, 5, 3),
    ('SIE', 'Anrede', 'A', 6, 1, 3),
    ('ANS', 'an das', 'A', 6, 5, 3),
    ('STEG', 'Brücklein', 'A', 7, 1, 4),
    ('SPASS', 'Vergnügen', 'D', 3, 1, 5),
    ('IST', 'befindet sich', 'D', 1, 2, 3),
    ('MIT', 'samt', 'D', 5, 2, 3),
    ('NIE', 'nimmer', 'D', 1, 3, 3),
    ('TEE', 'Heißgetränk', 'D', 5, 3, 3),
    ('GEHE', 'laufe', 'D', 1, 4, 4),
    ('EBENDA', 'dort', 'D', 1, 5, 6),
    ('RENTEN', 'Pensionen', 'D', 1, 6, 6),
    ('ERST', 'zunächst', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r082-9x9-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r082-9x9-01', 'Rätsel 82 · 9×9', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '9x9-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('EGAL', 'gleichgültig', 'A', 1, 1, 4),
    ('UND', 'sowie', 'A', 1, 6, 3),
    ('IRRE', 'Verrückte', 'A', 2, 1, 4),
    ('MIR', 'Dat. (1. Pers.)', 'A', 2, 6, 3),
    ('NAME', 'Bezeichnung', 'A', 3, 1, 4),
    ('SEE', 'Gewässer', 'A', 3, 6, 3),
    ('TUER', 'Pforte', 'A', 4, 1, 4),
    ('GILT', 'zählt', 'A', 5, 5, 4),
    ('ALTAERE', 'Opfertische', 'A', 6, 1, 7),
    ('FAELLIG', 'zahlbar', 'A', 7, 1, 7),
    ('SELBST', 'persönlich', 'A', 8, 2, 6),
    ('EINTRAF', 'ankam', 'D', 1, 1, 7),
    ('GRAU', 'farblos', 'D', 1, 2, 4),
    ('LAS', 'schmökerte', 'D', 6, 2, 3),
    ('ARME', 'Mittellose', 'D', 1, 3, 4),
    ('TEE', 'Heißgetränk', 'D', 6, 3, 3),
    ('LEER', 'hohl', 'D', 1, 4, 4),
    ('ALL', 'Weltraum', 'D', 6, 4, 3),
    ('GELB', 'sonnenfarben', 'D', 5, 5, 4),
    ('UMS', 'um das', 'D', 1, 6, 3),
    ('IRIS', 'Schwertlilie', 'D', 5, 6, 4),
    ('NIE', 'nimmer', 'D', 1, 7, 3),
    ('LEGT', 'platziert', 'D', 5, 7, 4),
    ('DREHT', 'wendet', 'D', 1, 8, 5)
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
    ('WIES', 'zeigte', 'A', 1, 1, 4),
    ('OFT', 'häufig', 'A', 1, 6, 3),
    ('IHRER', 'seiner', 'A', 2, 1, 5),
    ('ERZEUGT', 'hergestellt', 'A', 3, 1, 7),
    ('FROH', 'heiter', 'A', 4, 5, 4),
    ('DREHTE', 'wendete', 'A', 5, 1, 6),
    ('AERA', 'Epoche', 'A', 6, 1, 4),
    ('IST', 'befindet sich', 'A', 6, 6, 3),
    ('NUSS', 'Kern', 'A', 7, 1, 4),
    ('FIT', 'gesund', 'A', 7, 6, 3),
    ('NETT', 'freundlich', 'A', 8, 1, 4),
    ('TEE', 'Heißgetränk', 'A', 8, 6, 3),
    ('WIE', 'gleich', 'D', 1, 1, 3),
    ('DANN', 'anschließend', 'D', 5, 1, 4),
    ('IHR', 'Pronomen (2. Pl.)', 'D', 1, 2, 3),
    ('REUE', 'Bedauern', 'D', 5, 2, 4),
    ('ERZ', 'Gestein', 'D', 1, 3, 3),
    ('ERST', 'zunächst', 'D', 5, 3, 4),
    ('SEE', 'Gewässer', 'D', 1, 4, 3),
    ('HAST', 'besitzt', 'D', 5, 4, 4),
    ('RUFT', 'schreit', 'D', 2, 5, 4),
    ('GREIFT', 'packt', 'D', 3, 6, 6),
    ('FOTO', 'Aufnahme', 'D', 1, 7, 4),
    ('SIE', 'Anrede', 'D', 6, 7, 3),
    ('HATTE', 'besaß', 'D', 4, 8, 5)
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
    ('IRAK', 'Land am Tigris', 'A', 1, 1, 4),
    ('ALB', 'Gebirge', 'A', 1, 6, 3),
    ('HERR', 'Gebieter', 'A', 2, 1, 4),
    ('BEI', 'nahe an', 'A', 2, 6, 3),
    ('RIGA', 'lett. Hauptstadt', 'A', 3, 1, 4),
    ('HIT', 'Schlager', 'A', 3, 6, 3),
    ('FLOP', 'Reinfall', 'A', 4, 4, 4),
    ('STOLZE', 'hochmütige', 'A', 5, 3, 6),
    ('OPA', 'Großvater', 'A', 6, 1, 3),
    ('SEID', 'existiert', 'A', 6, 5, 4),
    ('TUN', 'machen', 'A', 7, 1, 3),
    ('ENGE', 'schmale', 'A', 7, 5, 4),
    ('ORGAN', 'Körperteil', 'A', 8, 1, 5),
    ('IHR', 'Pronomen (2. Pl.)', 'D', 1, 1, 3),
    ('FOTO', 'Aufnahme', 'D', 5, 1, 4),
    ('REIS', 'Getreideart', 'D', 1, 2, 4),
    ('PUR', 'rein', 'D', 6, 2, 3),
    ('ARG', 'schlimm', 'D', 1, 3, 3),
    ('SANG', 'trällerte', 'D', 5, 3, 4),
    ('KRAFT', 'Stärke', 'D', 1, 4, 5),
    ('LOSEN', 'lockeren', 'D', 4, 5, 5),
    ('ABHOLEN', 'mitnehmen', 'D', 1, 6, 7),
    ('LEIPZIG', 'Messestadt', 'D', 1, 7, 7),
    ('BIT', 'Binärziffer', 'D', 1, 8, 3),
    ('EDEL', 'vornehm', 'D', 5, 8, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r085-9x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r085-9x13-01', 'Rätsel 85 · 9×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('OSLO', 'norw. Hauptstadt', 'A', 1, 1, 4),
    ('ALABAMA', 'Südstaat', 'A', 1, 6, 7),
    ('REIS', 'Getreideart', 'A', 2, 1, 4),
    ('KANAL', 'Wasserstraße', 'A', 2, 8, 5),
    ('TISCHE', 'Tafeln', 'A', 3, 1, 6),
    ('TESTS', 'Prüfungen', 'A', 3, 8, 5),
    ('TAENZER', 'Ballerino', 'A', 4, 3, 7),
    ('REDE', 'Ansprache', 'A', 5, 4, 4),
    ('ARM', 'Gliedmaße', 'A', 6, 1, 3),
    ('REIN', 'sauber', 'A', 6, 5, 4),
    ('ASS', 'speiste', 'A', 6, 10, 3),
    ('BEI', 'nahe an', 'A', 7, 1, 3),
    ('ENGE', 'schmale', 'A', 7, 5, 4),
    ('NIE', 'nimmer', 'A', 7, 10, 3),
    ('TURMS', 'Spitze des ...', 'A', 8, 1, 5),
    ('TUNNEL', 'Unterführung', 'A', 8, 7, 6),
    ('ORTE', 'Plätze', 'D', 1, 1, 4),
    ('ABT', 'Klosterchef', 'D', 6, 1, 3),
    ('SEI', 'existiere', 'D', 1, 2, 3),
    ('TREU', 'loyal', 'D', 5, 2, 4),
    ('LIST', 'Trick', 'D', 1, 3, 4),
    ('MIR', 'Dat. (1. Pers.)', 'D', 6, 3, 3),
    ('OSCAR', 'Filmpreis', 'D', 1, 4, 5),
    ('HEERES', 'Führung des ...', 'D', 3, 5, 6),
    ('ABENDEN', 'an lauen ...', 'D', 1, 6, 7),
    ('ZEIGT', 'weist', 'D', 4, 7, 5),
    ('AKTE', 'Dokument', 'D', 1, 8, 4),
    ('NEU', 'frisch', 'D', 6, 8, 3),
    ('BAER', 'Petz', 'D', 1, 9, 4),
    ('ANS', 'an das', 'D', 1, 10, 3),
    ('DANN', 'anschließend', 'D', 5, 10, 4),
    ('MATT', 'Schachende', 'D', 1, 11, 4),
    ('SIE', 'Anrede', 'D', 6, 11, 3),
    ('ALS', 'da, während', 'D', 1, 12, 3),
    ('ESEL', 'Grautier', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r086-9x13-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r086-9x13-02', 'Rätsel 86 · 9×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '9x13-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ALT', 'betagt', 'A', 1, 1, 3),
    ('REH', 'Waldtier', 'A', 1, 6, 3),
    ('UMS', 'um das', 'A', 1, 10, 3),
    ('GAR', 'durchgekocht', 'A', 2, 1, 3),
    ('WALE', 'Meeressäuger', 'A', 2, 5, 4),
    ('RAT', 'Tipp', 'A', 2, 10, 3),
    ('EDEL', 'vornehm', 'A', 3, 1, 4),
    ('BILLIGE', 'preiswerte', 'A', 3, 6, 7),
    ('NEUE', 'frische', 'A', 4, 1, 4),
    ('ATMEN', 'Luft holen', 'A', 4, 6, 5),
    ('BOTE', 'Kurier', 'A', 5, 4, 4),
    ('AGIERT', 'handelt', 'A', 6, 1, 6),
    ('BEVOR', 'ehe', 'A', 6, 8, 5),
    ('AHNT', 'vermutet', 'A', 7, 2, 4),
    ('VERONA', 'Stadt der Arena', 'A', 7, 7, 6),
    ('RUNDER', 'kugeliger', 'A', 8, 1, 6),
    ('INNEN', 'intern', 'A', 8, 8, 5),
    ('AGENDA', 'Tagesordnung', 'D', 1, 1, 6),
    ('LADE', 'packe auf', 'D', 1, 2, 4),
    ('GAU', 'Landstrich', 'D', 6, 2, 3),
    ('TREU', 'loyal', 'D', 1, 3, 4),
    ('IHN', 'Akkusativ von er', 'D', 6, 3, 3),
    ('LEBEND', 'atmend', 'D', 3, 4, 6),
    ('ORTE', 'Plätze', 'D', 5, 5, 4),
    ('RABATT', 'Nachlass', 'D', 1, 6, 6),
    ('ELITE', 'Auslese', 'D', 1, 7, 5),
    ('HELM', 'Kopfschutz', 'D', 1, 8, 4),
    ('BEI', 'nahe an', 'D', 6, 8, 3),
    ('LESERN', 'Publikum', 'D', 3, 9, 6),
    ('URIN', 'Harn', 'D', 1, 10, 4),
    ('VON', 'ab, aus', 'D', 6, 10, 3),
    ('MAG', 'liebt', 'D', 1, 11, 3),
    ('ZONE', 'Bereich', 'D', 5, 11, 4),
    ('STEG', 'Brücklein', 'D', 1, 12, 4),
    ('RAN', 'heran', 'D', 6, 12, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r087-9x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r087-9x13-03', 'Rätsel 87 · 9×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AHNT', 'vermutet', 'A', 1, 1, 4),
    ('SKEPSIS', 'Zweifel', 'A', 1, 6, 7),
    ('LAEUFE', 'Rennen', 'A', 2, 1, 6),
    ('REISE', 'Fahrt', 'A', 2, 8, 5),
    ('STREIT', 'Zank', 'A', 3, 1, 6),
    ('BRETT', 'Planke', 'A', 3, 8, 5),
    ('GUTE', 'prima', 'A', 4, 5, 4),
    ('LUPE', 'Brennglas', 'A', 5, 4, 4),
    ('RUFE', 'Schreie', 'A', 5, 9, 4),
    ('RADAR', 'Ortungsgerät', 'A', 6, 1, 5),
    ('IRANER', 'Perser', 'A', 6, 7, 6),
    ('IMAGE', 'Ansehen', 'A', 7, 1, 5),
    ('BILD', 'Gemälde', 'A', 7, 9, 4),
    ('STRENGE', 'rigorose', 'A', 8, 1, 7),
    ('ESSE', 'speise', 'A', 8, 9, 4),
    ('ALS', 'da, während', 'D', 1, 1, 3),
    ('IRIS', 'Schwertlilie', 'D', 5, 1, 4),
    ('HAT', 'besitzt', 'D', 1, 2, 3),
    ('AMT', 'Behörde', 'D', 6, 2, 3),
    ('NERV', 'Reizleiter', 'D', 1, 3, 4),
    ('DAR', 'stellt ... (zeigt)', 'D', 6, 3, 3),
    ('TUE', 'mache', 'D', 1, 4, 3),
    ('LAGE', 'Position', 'D', 5, 4, 4),
    ('FIGUREN', 'Gestalten', 'D', 2, 5, 7),
    ('SETUP', 'Einrichtung', 'D', 1, 6, 5),
    ('TEILE', 'Stücke', 'D', 4, 7, 5),
    ('ERBE', 'Nachlass', 'D', 1, 8, 4),
    ('PER', 'mittels', 'D', 1, 9, 3),
    ('RABE', 'Krähenvogel', 'D', 5, 9, 4),
    ('SIE', 'Anrede', 'D', 1, 10, 3),
    ('UNIS', 'Hochschulen', 'D', 5, 10, 4),
    ('IST', 'befindet sich', 'D', 1, 11, 3),
    ('FELS', 'Stein', 'D', 5, 11, 4),
    ('SET', 'Satz', 'D', 1, 12, 3),
    ('ERDE', 'Welt', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r088-10x10-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r088-10x10-01', 'Rätsel 88 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ZUM', 'zu dem', 'A', 1, 1, 3),
    ('GUTE', 'prima', 'A', 1, 6, 4),
    ('EMAIL', 'elektr. Post', 'A', 2, 1, 5),
    ('NUN', 'jetzt', 'A', 2, 7, 3),
    ('ISST', 'speist', 'A', 3, 1, 4),
    ('SIEG', 'Triumph', 'A', 3, 6, 4),
    ('TOTALE', 'völlige', 'A', 4, 1, 6),
    ('LOEWEN', 'Raubkatzen', 'A', 5, 4, 6),
    ('LIMIT', 'Grenze', 'A', 6, 1, 5),
    ('EHE', 'Bund fürs Leben', 'A', 6, 7, 3),
    ('IDEE', 'Einfall', 'A', 7, 1, 4),
    ('HIRN', 'Verstand', 'A', 7, 6, 4),
    ('LOHN', 'Gehalt', 'A', 8, 1, 4),
    ('EHEN', 'Bündnisse', 'A', 8, 6, 4),
    ('ALL', 'Weltraum', 'A', 9, 1, 3),
    ('DUENE', 'Sandhügel', 'A', 9, 5, 5),
    ('ZEIT', 'Dauer', 'D', 1, 1, 4),
    ('LILA', 'Violett', 'D', 6, 1, 4),
    ('UMSO', 'desto', 'D', 1, 2, 4),
    ('IDOL', 'Vorbild', 'D', 6, 2, 4),
    ('MAST', 'Pfosten', 'D', 1, 3, 4),
    ('MEHL', 'Backzutat', 'D', 6, 3, 4),
    ('ITALIEN', 'Stiefelland', 'D', 2, 4, 7),
    ('LOT', 'Senkblei', 'D', 4, 5, 3),
    ('SEE', 'Gewässer', 'D', 3, 6, 3),
    ('HEU', 'Trockengras', 'D', 7, 6, 3),
    ('UNI', 'Hochschule', 'D', 1, 7, 3),
    ('WEIHE', 'Segnung', 'D', 5, 7, 5),
    ('TUE', 'mache', 'D', 1, 8, 3),
    ('EHREN', 'zu ... von', 'D', 5, 8, 5),
    ('ENG', 'schmal', 'D', 1, 9, 3),
    ('NENNE', 'bezeichne', 'D', 5, 9, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r089-10x10-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r089-10x10-02', 'Rätsel 89 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ANS', 'an das', 'A', 1, 1, 3),
    ('MANKO', 'Mangel', 'A', 1, 5, 5),
    ('BUERO', 'Kanzlei', 'A', 2, 1, 5),
    ('UND', 'sowie', 'A', 2, 7, 3),
    ('TRIEB', 'schwamm', 'A', 3, 1, 5),
    ('SIE', 'Anrede', 'A', 3, 7, 3),
    ('DIESER', 'jener', 'A', 4, 4, 6),
    ('INSELN', 'Eilande', 'A', 5, 1, 6),
    ('NIE', 'nimmer', 'A', 6, 1, 3),
    ('DIAS', 'Lichtbilder', 'A', 6, 6, 4),
    ('SET', 'Satz', 'A', 7, 1, 3),
    ('WENDE', 'Umschwung', 'A', 7, 5, 5),
    ('ERZ', 'Gestein', 'A', 8, 1, 3),
    ('INNEN', 'intern', 'A', 8, 5, 5),
    ('LEERE', 'Vakuum', 'A', 9, 1, 5),
    ('ELF', 'Zahl (10+1)', 'A', 9, 7, 3),
    ('ABT', 'Klosterchef', 'D', 1, 1, 3),
    ('INSEL', 'Eiland', 'D', 5, 1, 5),
    ('NUR', 'lediglich', 'D', 1, 2, 3),
    ('NIERE', 'Organ', 'D', 5, 2, 5),
    ('SEI', 'existiere', 'D', 1, 3, 3),
    ('SETZE', 'stelle', 'D', 5, 3, 5),
    ('REDE', 'Ansprache', 'D', 2, 4, 4),
    ('MOBIL', 'beweglich', 'D', 1, 5, 5),
    ('WIE', 'gleich', 'D', 7, 5, 3),
    ('ENDEN', 'aufhören', 'D', 4, 6, 5),
    ('NUSS', 'Kern', 'D', 1, 7, 4),
    ('INNE', '... halten', 'D', 6, 7, 4),
    ('KNIE', 'Gelenk', 'D', 1, 8, 4),
    ('ADEL', 'Aristokratie', 'D', 6, 8, 4),
    ('ODER', 'bzw.', 'D', 1, 9, 4),
    ('SENF', 'Mostrich', 'D', 6, 9, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r090-10x10-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r090-10x10-03', 'Rätsel 90 · 10×10', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '10x10-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('KRIPO', 'Ermittler', 'A', 1, 1, 5),
    ('ERZ', 'Gestein', 'A', 1, 7, 3),
    ('ROHR', 'Leitung', 'A', 2, 1, 4),
    ('HEU', 'Trockengras', 'A', 2, 7, 3),
    ('EHRE', 'Würde', 'A', 3, 1, 4),
    ('ZEUG', 'Kram', 'A', 3, 6, 4),
    ('BREITERE', 'ausladendere', 'A', 4, 1, 8),
    ('SESSEL', 'Polstersitz', 'A', 5, 1, 6),
    ('EXTRAS', 'Zusätze', 'A', 6, 4, 6),
    ('ERNST', 'Seriosität', 'A', 7, 1, 5),
    ('AKT', 'Aufzug', 'A', 7, 7, 3),
    ('HAI', 'Raubfisch', 'A', 8, 1, 3),
    ('ERNTE', 'Lese', 'A', 8, 5, 5),
    ('EDEL', 'vornehm', 'A', 9, 1, 4),
    ('GEN', 'nach', 'A', 9, 7, 3),
    ('KREBS', 'Sternzeichen', 'D', 1, 1, 5),
    ('EHE', 'Bund fürs Leben', 'D', 7, 1, 3),
    ('ROHRE', 'Leitungen', 'D', 1, 2, 5),
    ('RAD', 'Velo', 'D', 7, 2, 3),
    ('IHRES', 'seines', 'D', 1, 3, 5),
    ('NIE', 'nimmer', 'D', 7, 3, 3),
    ('PREISES', 'Höhe des ...', 'D', 1, 4, 7),
    ('TEXTE', 'Schriften', 'D', 4, 5, 5),
    ('ZELT', 'Pavillon', 'D', 3, 6, 4),
    ('EHER', 'lieber', 'D', 1, 7, 4),
    ('RANG', 'Stellung', 'D', 6, 7, 4),
    ('REUE', 'Bedauern', 'D', 1, 8, 4),
    ('AKTE', 'Dokument', 'D', 6, 8, 4),
    ('ZUG', 'Bahn', 'D', 1, 9, 3),
    ('OSTEN', 'Richtung O', 'D', 5, 9, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r091-10x10-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r091-10x10-04', 'Rätsel 91 · 10×10', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '10x10-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('HOSE', 'Beinkleid', 'A', 1, 1, 4),
    ('HIER', 'an diesem Ort', 'A', 1, 6, 4),
    ('ABT', 'Klosterchef', 'A', 2, 1, 3),
    ('KENIA', 'Staat in Ostafrika', 'A', 2, 5, 5),
    ('LEID', 'Kummer', 'A', 3, 1, 4),
    ('INNE', '... halten', 'A', 3, 6, 4),
    ('FREI', 'ungebunden', 'A', 4, 1, 4),
    ('LEST', 'studiert', 'A', 4, 6, 4),
    ('ELEMENTE', 'Bestandteile', 'A', 5, 2, 8),
    ('NUN', 'jetzt', 'A', 6, 4, 3),
    ('INDES', 'jedoch', 'A', 7, 1, 5),
    ('AST', 'Zweig', 'A', 7, 7, 3),
    ('SEINS', 'Sinn des ...', 'A', 8, 1, 5),
    ('RIO', 'Stadt in Brasilien', 'A', 8, 7, 3),
    ('TUE', 'mache', 'A', 9, 1, 3),
    ('TATEN', 'Handlungen', 'A', 9, 5, 5),
    ('HALF', 'stand bei', 'D', 1, 1, 4),
    ('BIST', 'existierst', 'D', 6, 1, 4),
    ('OBERE', 'höhere', 'D', 1, 2, 5),
    ('NEU', 'frisch', 'D', 7, 2, 3),
    ('STIEL', 'Griff', 'D', 1, 3, 5),
    ('DIE', 'Artikel (weibl.)', 'D', 7, 3, 3),
    ('DIENEN', 'nützen', 'D', 3, 4, 6),
    ('MUSST', 'sollst', 'D', 5, 5, 5),
    ('HEILEN', 'kurieren', 'D', 1, 6, 6),
    ('INNEN', 'intern', 'D', 1, 7, 5),
    ('ART', 'Sorte', 'D', 7, 7, 3),
    ('EINST', 'früher', 'D', 1, 8, 5),
    ('SIE', 'Anrede', 'D', 7, 8, 3),
    ('RAETE', 'Gremien', 'D', 1, 9, 5),
    ('TON', 'Klang', 'D', 7, 9, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r092-11x11-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r092-11x11-01', 'Rätsel 92 · 11×11', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '11x11-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AMTS', 'im ... sein', 'A', 1, 1, 4),
    ('HERBE', 'bittere', 'A', 1, 6, 5),
    ('NEU', 'frisch', 'A', 2, 1, 3),
    ('ALB', 'Gebirge', 'A', 2, 8, 3),
    ('STELLT', 'setzt', 'A', 3, 1, 6),
    ('DIE', 'Artikel (weibl.)', 'A', 3, 8, 3),
    ('SINN', 'Bedeutung', 'A', 4, 7, 4),
    ('DRAMA', 'Schauspiel', 'A', 5, 1, 5),
    ('TODE', 'zu ... betrübt', 'A', 5, 7, 4),
    ('GARDE', 'Leibwache', 'A', 6, 3, 5),
    ('EHE', 'Bund fürs Leben', 'A', 7, 1, 3),
    ('GRILL', 'Rost', 'A', 7, 5, 5),
    ('SAND', 'Wüstenboden', 'A', 8, 1, 4),
    ('ALIAS', 'auch genannt', 'A', 8, 6, 5),
    ('ERDE', 'Welt', 'A', 9, 1, 4),
    ('HELME', 'Kopfschutz', 'A', 9, 6, 5),
    ('STARRT', 'glotzt', 'A', 10, 1, 6),
    ('AMT', 'Behörde', 'A', 10, 8, 3),
    ('ANS', 'an das', 'D', 1, 1, 3),
    ('DIESES', 'jenes', 'D', 5, 1, 6),
    ('METER', 'Längenmaß', 'D', 1, 2, 5),
    ('HART', 'fest', 'D', 7, 2, 4),
    ('TUE', 'mache', 'D', 1, 3, 3),
    ('AGENDA', 'Tagesordnung', 'D', 5, 3, 6),
    ('LIMA', 'peruan. Hauptstadt', 'D', 3, 4, 4),
    ('DER', 'Artikel (männl.)', 'D', 8, 4, 3),
    ('ARG', 'schlimm', 'D', 5, 5, 3),
    ('HUT', 'Kopfbedeckung', 'D', 1, 6, 3),
    ('DRAHT', 'Metallfaden', 'D', 6, 6, 5),
    ('STEILE', 'abschüssige', 'D', 4, 7, 6),
    ('RADIO', 'Rundfunk', 'D', 1, 8, 5),
    ('LILA', 'Violett', 'D', 7, 8, 4),
    ('BLIND', 'ohne Sehkraft', 'D', 1, 9, 5),
    ('LAMM', 'Schäfchen', 'D', 7, 9, 4),
    ('EBENEN', 'Flächen', 'D', 1, 10, 6),
    ('SET', 'Satz', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r093-11x11-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r093-11x11-02', 'Rätsel 93 · 11×11', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '11x11-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AST', 'Zweig', 'A', 1, 1, 3),
    ('GAENSE', 'Federvieh', 'A', 1, 5, 6),
    ('UTAH', 'Mormonenstaat', 'A', 2, 1, 4),
    ('PREIS', 'Tarif', 'A', 2, 6, 5),
    ('GEN', 'nach', 'A', 3, 1, 3),
    ('ARZTES', 'Praxis des ...', 'A', 3, 5, 6),
    ('ECK', 'Winkel', 'A', 4, 1, 3),
    ('GALA', 'Festabend', 'A', 5, 4, 4),
    ('STAAT', 'Nation', 'A', 6, 1, 5),
    ('KURZ', 'knapp', 'A', 6, 7, 4),
    ('DUESTERE', 'finstere', 'A', 7, 3, 8),
    ('SEE', 'Gewässer', 'A', 8, 1, 3),
    ('MOEBEL', 'Einrichtung', 'A', 8, 5, 6),
    ('EILT', 'hastet', 'A', 9, 1, 4),
    ('FUEGT', 'setzt', 'A', 9, 6, 5),
    ('INS', 'in das', 'A', 10, 1, 3),
    ('WARNTE', 'mahnte', 'A', 10, 5, 6),
    ('AUGE', 'Sehorgan', 'D', 1, 1, 4),
    ('SEI', 'existiere', 'D', 8, 1, 3),
    ('STECKT', 'sitzt fest', 'D', 1, 2, 6),
    ('EIN', 'unbest. Artikel', 'D', 8, 2, 3),
    ('TANK', 'Behälter', 'D', 1, 3, 4),
    ('ADELS', 'Titel des ...', 'D', 6, 3, 5),
    ('GAU', 'Landstrich', 'D', 5, 4, 3),
    ('ATEM', 'Luft', 'D', 5, 5, 4),
    ('APRIL', '4. Monat', 'D', 1, 6, 5),
    ('SOFA', 'Couch', 'D', 7, 6, 4),
    ('ERZ', 'Gestein', 'D', 1, 7, 3),
    ('AKTEUR', 'Mitspieler', 'D', 5, 7, 6),
    ('NETZ', 'Geflecht', 'D', 1, 8, 4),
    ('UEBEN', 'trainieren', 'D', 6, 8, 5),
    ('SIE', 'Anrede', 'D', 1, 9, 3),
    ('ERREGT', 'nervös', 'D', 5, 9, 6),
    ('ESSE', 'speise', 'D', 1, 10, 4),
    ('ZELTE', 'Pavillons', 'D', 6, 10, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r094-11x11-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r094-11x11-03', 'Rätsel 94 · 11×11', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '11x11-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AMTS', 'im ... sein', 'A', 1, 1, 4),
    ('DARM', 'Eingeweide', 'A', 1, 7, 4),
    ('BAU', 'Gebäude', 'A', 2, 1, 3),
    ('VORBEI', 'zu Ende', 'A', 2, 5, 6),
    ('BITS', 'Binärziffern', 'A', 3, 1, 4),
    ('DIENT', 'nützt', 'A', 3, 6, 5),
    ('TRENNT', 'scheidet', 'A', 4, 4, 6),
    ('UNFAIR', 'ungerecht', 'A', 5, 1, 6),
    ('DEM', 'Artikel (Dativ)', 'A', 5, 8, 3),
    ('EURE', 'Possessiv (ihr)', 'A', 6, 2, 4),
    ('MUT', 'Courage', 'A', 7, 1, 3),
    ('SIE', 'Anrede', 'A', 7, 5, 3),
    ('ABT', 'Klosterchef', 'A', 8, 1, 3),
    ('EHRUNG', 'Würdigung', 'A', 8, 5, 6),
    ('RAET', 'empfiehlt', 'A', 9, 1, 4),
    ('RANDE', 'am ... bemerkt', 'A', 9, 6, 5),
    ('KUR', 'Erholung', 'A', 10, 1, 3),
    ('ENDEN', 'aufhören', 'A', 10, 6, 5),
    ('ABBAU', 'Förderung', 'D', 1, 1, 5),
    ('MARK', 'alte Währung', 'D', 7, 1, 4),
    ('MAI', '5. Monat', 'D', 1, 2, 3),
    ('NEUBAU', 'frisches Gebäude', 'D', 5, 2, 6),
    ('TUT', 'macht', 'D', 1, 3, 3),
    ('FUTTER', 'Nahrung', 'D', 5, 3, 6),
    ('STAR', 'Berühmtheit', 'D', 3, 4, 4),
    ('RIESE', 'Hüne', 'D', 4, 5, 5),
    ('ODER', 'bzw.', 'D', 2, 6, 4),
    ('IHRE', 'seine', 'D', 7, 6, 4),
    ('DRIN', 'innen', 'D', 1, 7, 4),
    ('HERAN', 'herbei', 'D', 6, 7, 5),
    ('ABEND', 'Tagesende', 'D', 1, 8, 5),
    ('UND', 'sowie', 'D', 8, 8, 3),
    ('RENTE', 'Pension', 'D', 1, 9, 5),
    ('ENDE', 'Schluss', 'D', 7, 9, 4),
    ('MIT', 'samt', 'D', 1, 10, 3),
    ('GEN', 'nach', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r095-12x12-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r095-12x12-01', 'Rätsel 95 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('HAI', 'Raubfisch', 'A', 1, 1, 3),
    ('IRRE', 'Verrückte', 'A', 1, 8, 4),
    ('AUSBAU', 'Erweiterung', 'A', 2, 1, 6),
    ('REIS', 'Getreideart', 'A', 2, 8, 4),
    ('SET', 'Satz', 'A', 3, 1, 3),
    ('EVENTS', 'Anlässe', 'A', 3, 6, 6),
    ('KONNTE', 'vermochte', 'A', 4, 6, 6),
    ('THEATER', 'Bühne', 'A', 5, 1, 7),
    ('ARTEN', 'Sorten', 'A', 6, 2, 5),
    ('ETWAS', 'ein wenig', 'A', 7, 1, 5),
    ('ELEND', 'Jammer', 'A', 7, 7, 5),
    ('ALT', 'betagt', 'A', 8, 3, 3),
    ('BANDE', 'Gang', 'A', 8, 7, 5),
    ('NUR', 'lediglich', 'A', 9, 1, 3),
    ('SAENGER', 'Vokalist', 'A', 9, 5, 7),
    ('ENTE', 'Wasservogel', 'A', 10, 1, 4),
    ('UNTERE', 'tiefere', 'A', 10, 6, 6),
    ('SIE', 'Anrede', 'A', 11, 1, 3),
    ('SEELEN', 'Psychen', 'A', 11, 6, 6),
    ('HASST', 'verabscheut', 'D', 1, 1, 5),
    ('EINES', 'unbest. Art. (Gen.)', 'D', 7, 1, 5),
    ('AUE', 'Talwiese', 'D', 1, 2, 3),
    ('HAT', 'besitzt', 'D', 5, 2, 3),
    ('UNI', 'Hochschule', 'D', 9, 2, 3),
    ('IST', 'befindet sich', 'D', 1, 3, 3),
    ('ERWARTE', 'erhoffe', 'D', 5, 3, 7),
    ('FATAL', 'unheilvoll', 'D', 4, 4, 5),
    ('TESTS', 'Prüfungen', 'D', 5, 5, 5),
    ('KUEKEN', 'Hühnerjunges', 'D', 1, 6, 6),
    ('AUS', 'vorbei', 'D', 9, 6, 3),
    ('VOR', 'ehe', 'D', 3, 7, 3),
    ('EBENE', 'Fläche', 'D', 7, 7, 5),
    ('IREN', 'Gälen', 'D', 1, 8, 4),
    ('PLANTE', 'entwarf', 'D', 6, 8, 6),
    ('RENNT', 'läuft', 'D', 1, 9, 5),
    ('ENGEL', 'Himmelsbote', 'D', 7, 9, 5),
    ('RITT', 'Reise zu Pferd', 'D', 1, 10, 4),
    ('ANDERE', 'übrige', 'D', 6, 10, 6),
    ('ESSEN', 'Mahlzeit', 'D', 1, 11, 5),
    ('DEREN', 'dessen', 'D', 7, 11, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r096-12x12-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r096-12x12-02', 'Rätsel 96 · 12×12', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '12x12-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('JAGD', 'Hatz', 'A', 1, 1, 4),
    ('AKTE', 'Dokument', 'A', 1, 8, 4),
    ('AULA', 'Festsaal', 'A', 2, 1, 4),
    ('UNKLAR', 'vage', 'A', 2, 6, 6),
    ('PFORTE', 'Tor', 'A', 3, 1, 6),
    ('TAGS', '... darauf', 'A', 3, 8, 4),
    ('ALS', 'da, während', 'A', 4, 1, 3),
    ('GUT', 'prima', 'A', 4, 9, 3),
    ('NASE', 'Riechorgan', 'A', 5, 1, 4),
    ('HABEN', 'besitzen', 'A', 5, 6, 5),
    ('GANGE', 'im ... sein', 'A', 6, 2, 5),
    ('ENGE', 'schmale', 'A', 6, 8, 4),
    ('AERGER', 'Verdruss', 'A', 7, 1, 6),
    ('PER', 'mittels', 'A', 8, 7, 3),
    ('TRIO', 'Dreiergruppe', 'A', 9, 1, 4),
    ('GASE', 'Dämpfe', 'A', 9, 8, 4),
    ('EICHEN', 'Laubbäume', 'A', 10, 1, 6),
    ('TUER', 'Pforte', 'A', 10, 8, 4),
    ('ROHR', 'Leitung', 'A', 11, 1, 4),
    ('DIESEN', 'jenen', 'A', 11, 6, 6),
    ('JAPAN', 'Nippon', 'D', 1, 1, 5),
    ('ALTER', 'Lebensjahre', 'D', 7, 1, 5),
    ('AUFLAGE', 'Ausgabe', 'D', 1, 2, 7),
    ('RIO', 'Stadt in Brasilien', 'D', 9, 2, 3),
    ('GLOSSAR', 'Wortliste', 'D', 1, 3, 7),
    ('ICH', 'Pronomen (1. Sg.)', 'D', 9, 3, 3),
    ('DAR', 'stellt ... (zeigt)', 'D', 1, 4, 3),
    ('ENG', 'schmal', 'D', 5, 4, 3),
    ('OHR', 'Hörorgan', 'D', 9, 4, 3),
    ('GEN', 'nach', 'D', 6, 5, 3),
    ('BUECHER', 'Bände', 'D', 1, 6, 7),
    ('UND', 'sowie', 'D', 9, 6, 3),
    ('AKT', 'Aufzug', 'D', 1, 8, 3),
    ('BELEGTE', 'bewies', 'D', 5, 8, 7),
    ('KLAGEN', 'Beschwerden', 'D', 1, 9, 6),
    ('RAUS', 'hinweg', 'D', 8, 9, 4),
    ('TAGUNG', 'Kongress', 'D', 1, 10, 6),
    ('SEE', 'Gewässer', 'D', 9, 10, 3),
    ('ERST', 'zunächst', 'D', 1, 11, 4),
    ('ELTERN', 'Vater und Mutter', 'D', 6, 11, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r097-12x12-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r097-12x12-03', 'Rätsel 97 · 12×12', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '12x12-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('SALAT', 'Rohkost', 'A', 1, 1, 5),
    ('KURSE', 'Lehrgänge', 'A', 1, 7, 5),
    ('ATELIER', 'Werkstatt', 'A', 2, 1, 7),
    ('OEL', 'Schmierstoff', 'A', 2, 9, 3),
    ('FRIST', 'Termin', 'A', 3, 1, 5),
    ('MIT', 'samt', 'A', 3, 9, 3),
    ('EID', 'Schwur', 'A', 4, 1, 3),
    ('EBEN', 'flach', 'A', 4, 5, 4),
    ('LAG', 'ruhte', 'A', 5, 5, 3),
    ('VOR', 'ehe', 'A', 5, 9, 3),
    ('UMSO', 'desto', 'A', 6, 1, 4),
    ('SCHWER', 'gewichtig', 'A', 7, 5, 6),
    ('HAI', 'Raubfisch', 'A', 8, 1, 3),
    ('THEATER', 'Bühne', 'A', 8, 5, 7),
    ('EBENE', 'Fläche', 'A', 9, 1, 5),
    ('FRAGE', 'Erkundigung', 'A', 9, 7, 5),
    ('GELEHRT', 'unterrichtet', 'A', 10, 1, 7),
    ('GAS', 'Brennstoff', 'A', 10, 9, 3),
    ('TREUE', 'Loyalität', 'A', 11, 1, 5),
    ('WELT', 'Erde', 'A', 11, 8, 4),
    ('SAFE', 'Tresor', 'D', 1, 1, 4),
    ('HEGT', 'pflegt', 'D', 8, 1, 4),
    ('ATRIUM', 'Innenhof', 'D', 1, 2, 6),
    ('ABER', 'jedoch', 'D', 8, 2, 4),
    ('LEID', 'Kummer', 'D', 1, 3, 4),
    ('SPIELE', 'Partien', 'D', 6, 3, 6),
    ('ALS', 'da, während', 'D', 1, 4, 3),
    ('NEU', 'frisch', 'D', 9, 4, 3),
    ('TITEL', 'Überschrift', 'D', 1, 5, 5),
    ('STEHE', 'ich ... auf', 'D', 7, 5, 5),
    ('BAUCH', 'Wanst', 'D', 4, 6, 5),
    ('KRIEG', 'Kampf', 'D', 1, 7, 5),
    ('HEFT', 'Broschüre', 'D', 7, 7, 4),
    ('ZWAR', 'freilich', 'D', 6, 8, 4),
    ('ROM', 'Ewige Stadt', 'D', 1, 9, 3),
    ('ETAGE', 'Stockwerk', 'D', 7, 9, 5),
    ('SEI', 'existiere', 'D', 1, 10, 3),
    ('REGAL', 'Bord', 'D', 7, 10, 5),
    ('ELTERN', 'Vater und Mutter', 'D', 1, 11, 6),
    ('REST', 'Überbleibsel', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r098-12x12-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r098-12x12-04', 'Rätsel 98 · 12×12', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '12x12-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('DIKTATUR', 'Tyrannei', 'A', 1, 1, 8),
    ('IDEAL', 'Leitbild', 'A', 2, 1, 5),
    ('LOB', 'Anerkennung', 'A', 2, 7, 3),
    ('NEIGT', 'tendiert', 'A', 3, 1, 5),
    ('MUEDE', 'schläfrig', 'A', 3, 7, 5),
    ('GELTE', 'zähle', 'A', 4, 1, 5),
    ('TRAT', 'schritt', 'A', 4, 8, 4),
    ('ERFREUTE', 'beglückte', 'A', 5, 4, 8),
    ('HUT', 'Kopfbedeckung', 'A', 6, 9, 3),
    ('VIA', 'über', 'A', 7, 2, 3),
    ('GUTEM', 'bravem', 'A', 7, 6, 5),
    ('HITS', 'Schlager', 'A', 8, 1, 4),
    ('REH', 'Waldtier', 'A', 8, 6, 3),
    ('ALASKA', 'Staat am Yukon', 'A', 9, 1, 6),
    ('ENTE', 'Wasservogel', 'A', 9, 8, 4),
    ('ALT', 'betagt', 'A', 10, 1, 3),
    ('KUER', 'freies Programm', 'A', 10, 8, 4),
    ('RAET', 'empfiehlt', 'A', 11, 1, 4),
    ('EBENEN', 'Flächen', 'A', 11, 6, 6),
    ('DING', 'Sache', 'D', 1, 1, 4),
    ('HAAR', 'Strähne', 'D', 8, 1, 4),
    ('IDEEN', 'Einfälle', 'D', 1, 2, 5),
    ('VILLA', 'Landhaus', 'D', 7, 2, 5),
    ('KEIL', 'Dreieckklotz', 'D', 1, 3, 4),
    ('ZITATE', 'Aussprüche', 'D', 6, 3, 6),
    ('TAGTE', 'beriet', 'D', 1, 4, 5),
    ('ASS', 'speiste', 'D', 7, 4, 3),
    ('ALTERN', 'Reifen', 'D', 1, 5, 6),
    ('GRADE', 'Stufen', 'D', 7, 6, 5),
    ('ULM', 'Münsterstadt', 'D', 1, 7, 3),
    ('RAUE', 'grobe', 'D', 5, 7, 4),
    ('ROUTE', 'Strecke', 'D', 1, 8, 5),
    ('THEKE', 'Tresen', 'D', 7, 8, 5),
    ('BERUHE', 'basiere', 'D', 2, 9, 6),
    ('NUN', 'jetzt', 'D', 9, 9, 3),
    ('DATUM', 'Tagesangabe', 'D', 3, 10, 5),
    ('TEE', 'Heißgetränk', 'D', 9, 10, 3),
    ('TOETET', 'bringt um', 'D', 1, 11, 6),
    ('KERN', 'Mittelpunkt', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r099-13x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r099-13x13-01', 'Rätsel 99 · 13×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '13x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('OMA', 'Großmutter', 'A', 1, 1, 3),
    ('ASS', 'speiste', 'A', 1, 5, 3),
    ('TAKT', 'Rhythmus', 'A', 1, 9, 4),
    ('POST', 'Briefe', 'A', 2, 1, 4),
    ('PIXEL', 'Bildpunkt', 'A', 2, 6, 5),
    ('ALTAERE', 'Opfertische', 'A', 3, 1, 7),
    ('ELBE', 'Strom durch Dresden', 'A', 3, 9, 4),
    ('LIEGE', 'ruhe', 'A', 4, 4, 5),
    ('FEE', 'Zauberin', 'A', 5, 1, 3),
    ('LETTLAND', 'Baltenstaat', 'A', 5, 5, 8),
    ('ARCHE', 'Noahs Schiff', 'A', 6, 1, 5),
    ('EWIG', 'endlos', 'A', 6, 7, 4),
    ('REH', 'Waldtier', 'A', 7, 1, 3),
    ('ASSEN', 'speisten', 'A', 7, 8, 5),
    ('BITS', 'Binärziffern', 'A', 8, 1, 4),
    ('LAST', 'Bürde', 'A', 8, 6, 4),
    ('EBBE', 'Gegenteil der Flut', 'A', 9, 9, 4),
    ('GARAGEN', 'Stellplätze', 'A', 10, 2, 7),
    ('LAS', 'schmökerte', 'A', 10, 10, 3),
    ('MAXIME', 'Grundsatz', 'A', 11, 1, 6),
    ('AUS', 'vorbei', 'A', 11, 10, 3),
    ('STETS', 'immer', 'A', 12, 2, 5),
    ('ROUTE', 'Strecke', 'A', 12, 8, 5),
    ('OPA', 'Großvater', 'D', 1, 1, 3),
    ('FARBE', 'Kolorit', 'D', 5, 1, 5),
    ('MOLKEREI', 'Milchbetrieb', 'D', 1, 2, 8),
    ('GAS', 'Brennstoff', 'D', 10, 2, 3),
    ('AST', 'Zweig', 'D', 1, 3, 3),
    ('ECHT', 'authentisch', 'D', 5, 3, 4),
    ('AXT', 'Beil', 'D', 10, 3, 3),
    ('TAL', 'Senke', 'D', 2, 4, 3),
    ('SERIE', 'Reihe', 'D', 8, 4, 5),
    ('EILE', 'Hast', 'D', 3, 5, 4),
    ('AMT', 'Behörde', 'D', 10, 5, 3),
    ('SPREE', 'Fluss durch Berlin', 'D', 1, 6, 5),
    ('FLUGES', 'Dauer des ...', 'D', 7, 6, 6),
    ('SIEGTE', 'gewann', 'D', 1, 7, 6),
    ('ETWAS', 'ein wenig', 'D', 4, 8, 5),
    ('NUR', 'lediglich', 'D', 10, 8, 3),
    ('TEE', 'Heißgetränk', 'D', 1, 9, 3),
    ('LISTE', 'Aufstellung', 'D', 5, 9, 5),
    ('ALLTAGS', 'Sorgen des ...', 'D', 1, 10, 7),
    ('BLAU', 'betrunken', 'D', 9, 10, 4),
    ('ERBAUT', 'errichtet', 'D', 7, 11, 6),
    ('TUE', 'mache', 'D', 1, 12, 3),
    ('DEN', 'Artikel (Akkusativ)', 'D', 5, 12, 3),
    ('ESSE', 'speise', 'D', 9, 12, 4)
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
    ('NOCHMALS', 'wiederum', 'A', 1, 1, 8),
    ('ABT', 'Klosterchef', 'A', 1, 10, 3),
    ('HAARE', 'Mähne', 'A', 2, 3, 5),
    ('FRAU', 'Dame', 'A', 2, 9, 4),
    ('ALLEIN', 'einsam', 'A', 3, 3, 6),
    ('ZUR', 'zu der', 'A', 3, 10, 3),
    ('EHRT', 'würdigt', 'A', 4, 1, 4),
    ('ASIATEN', 'Orientalen', 'A', 4, 6, 7),
    ('NAME', 'Bezeichnung', 'A', 5, 1, 4),
    ('LEER', 'hohl', 'A', 5, 6, 4),
    ('ABENDS', 'spät am Tag', 'A', 6, 1, 6),
    ('DIE', 'Artikel (weibl.)', 'A', 6, 8, 3),
    ('REEDER', 'Schiffsherr', 'A', 7, 7, 6),
    ('MOOR', 'Sumpf', 'A', 8, 3, 4),
    ('ZWANGEN', 'nötigten', 'A', 9, 1, 7),
    ('ETWA', 'ungefähr', 'A', 9, 9, 4),
    ('WINKEN', 'grüßen', 'A', 10, 1, 6),
    ('BRIEF', 'Schreiben', 'A', 10, 8, 5),
    ('ERKENNE', 'begreife', 'A', 11, 1, 7),
    ('DORF', 'Weiler', 'A', 11, 9, 4),
    ('IDOL', 'Vorbild', 'A', 12, 1, 4),
    ('RENTE', 'Pension', 'A', 12, 8, 5),
    ('NEBENAN', 'daneben', 'D', 1, 1, 7),
    ('ZWEI', 'Zahl (1+1)', 'D', 9, 1, 4),
    ('HAB', '... und Gut', 'D', 4, 2, 3),
    ('WIRD', 'entsteht', 'D', 9, 2, 4),
    ('CHARME', 'Liebreiz', 'D', 1, 3, 6),
    ('MANKO', 'Mangel', 'D', 8, 3, 5),
    ('HALTEN', 'stoppen', 'D', 1, 4, 6),
    ('ONKEL', 'Oheim', 'D', 8, 4, 5),
    ('MAL', 'Zeichen ×', 'D', 1, 5, 3),
    ('DROGEN', 'Rauschgift', 'D', 6, 5, 6),
    ('AREALS', 'Größe des ...', 'D', 1, 6, 6),
    ('RENNT', 'läuft', 'D', 8, 6, 5),
    ('LEISE', 'gedämpft', 'D', 1, 7, 5),
    ('NIEDER', 'hinab', 'D', 3, 8, 6),
    ('ARIE', 'Sologesang', 'D', 4, 9, 4),
    ('ERDE', 'Welt', 'D', 9, 9, 4),
    ('ARZT', 'Mediziner', 'D', 1, 10, 4),
    ('EDITION', 'Ausgabe', 'D', 6, 10, 7),
    ('BAUE', 'errichte', 'D', 1, 11, 4),
    ('WERT', 'Bedeutung', 'D', 9, 11, 4),
    ('TURNIER', 'Wettkampf', 'D', 1, 12, 7),
    ('AFFE', 'Primat', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r101-13x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r101-13x13-03', 'Rätsel 101 · 13×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '13x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('WEGE', 'Pfade', 'A', 1, 1, 4),
    ('BOT', 'offerierte', 'A', 1, 6, 3),
    ('RAT', 'Tipp', 'A', 1, 10, 3),
    ('EHE', 'Bund fürs Leben', 'A', 2, 1, 3),
    ('FLAUTE', 'Windstille', 'A', 2, 5, 6),
    ('GEHAEUSE', 'Hülle', 'A', 3, 1, 8),
    ('ZUR', 'zu der', 'A', 3, 10, 3),
    ('ROLLTE', 'kullerte', 'A', 4, 2, 6),
    ('SEHR', 'äußerst', 'A', 4, 9, 4),
    ('ESSE', 'speise', 'A', 5, 3, 4),
    ('PRO', 'je', 'A', 5, 10, 3),
    ('OHR', 'Hörorgan', 'A', 6, 1, 3),
    ('SPAETER', 'danach', 'A', 6, 6, 7),
    ('MAERZ', '3. Monat', 'A', 7, 1, 5),
    ('EHREN', 'zu ... von', 'A', 7, 7, 5),
    ('MINE', 'Bergwerk', 'A', 8, 1, 4),
    ('IRIS', 'Schwertlilie', 'A', 8, 6, 4),
    ('INTERN', 'innen', 'A', 9, 7, 6),
    ('NASE', 'Riechorgan', 'A', 10, 1, 4),
    ('TOT', 'leblos', 'A', 10, 6, 3),
    ('WOG', 'schaukelte', 'A', 10, 10, 3),
    ('DUELL', 'Zweikampf', 'A', 11, 1, 5),
    ('DEVISE', 'Motto', 'A', 11, 7, 6),
    ('OFEN', 'Herd', 'A', 12, 1, 4),
    ('PER', 'mittels', 'A', 12, 6, 3),
    ('GAS', 'Brennstoff', 'A', 12, 10, 3),
    ('WEG', 'Pfad', 'D', 1, 1, 3),
    ('KOMMANDO', 'Befehl', 'D', 5, 1, 8),
    ('EHER', 'lieber', 'D', 1, 2, 4),
    ('HAI', 'Raubfisch', 'D', 6, 2, 3),
    ('AUF', 'offen', 'D', 10, 2, 3),
    ('GEHOEREN', 'zählen zu', 'D', 1, 3, 8),
    ('SEE', 'Gewässer', 'D', 10, 3, 3),
    ('ALS', 'da, während', 'D', 3, 4, 3),
    ('REGELN', 'Normen', 'D', 7, 4, 6),
    ('FELS', 'Stein', 'D', 2, 5, 4),
    ('BLUTES', 'Gruppe des ...', 'D', 1, 6, 6),
    ('OASE', 'Wüsteninsel', 'D', 1, 7, 4),
    ('PERIODE', 'Zeitraum', 'D', 6, 7, 7),
    ('TUE', 'mache', 'D', 1, 8, 3),
    ('DAHINTER', 'rückwärtig', 'D', 5, 8, 8),
    ('ERST', 'zunächst', 'D', 6, 9, 4),
    ('REZEPTE', 'Verordnungen', 'D', 1, 10, 7),
    ('EWIG', 'endlos', 'D', 9, 10, 4),
    ('UHREN', 'Zeitmesser', 'D', 3, 11, 5),
    ('ROSA', 'Pink', 'D', 9, 11, 4),
    ('TERROR', 'Schrecken', 'D', 1, 12, 6),
    ('ENGES', 'schmales', 'D', 8, 12, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r102-15x15-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r102-15x15-01', 'Rätsel 102 · 15×15', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '15x15-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('GAGE', 'Honorar', 'A', 1, 1, 4),
    ('FAX', 'Fernkopie', 'A', 1, 6, 3),
    ('MAHNT', 'warnt', 'A', 1, 10, 5),
    ('ERAHNEN', 'vermuten', 'A', 2, 1, 7),
    ('TORE', 'Treffer', 'A', 2, 9, 4),
    ('HEER', 'Armee', 'A', 3, 1, 4),
    ('IST', 'befindet sich', 'A', 3, 6, 3),
    ('REISE', 'Fahrt', 'A', 3, 10, 5),
    ('ANREDE', 'Begrüßung', 'A', 4, 1, 6),
    ('DAMPF', 'Dunst', 'A', 4, 10, 5),
    ('BAT', 'ersuchte', 'A', 5, 1, 3),
    ('ERBEN', 'Nachkommen', 'A', 5, 5, 5),
    ('LOK', 'Zugmaschine', 'A', 6, 12, 3),
    ('BEWARB', 'pries an', 'A', 7, 2, 6),
    ('BRAUNE', 'brünette', 'A', 7, 9, 6),
    ('KUR', 'Erholung', 'A', 8, 1, 3),
    ('KEYBOARD', 'Tastatur', 'A', 8, 5, 8),
    ('WEH', 'schmerzhaft', 'A', 9, 4, 3),
    ('AMT', 'Behörde', 'A', 9, 9, 3),
    ('PFEIL', 'Geschoss', 'A', 10, 1, 5),
    ('WURM', 'Angelköder', 'A', 10, 7, 4),
    ('FEHL', '... am Platz', 'A', 11, 1, 4),
    ('SAND', 'Wüstenboden', 'A', 11, 6, 4),
    ('AUGE', 'Sehorgan', 'A', 11, 11, 4),
    ('ATELIERS', 'Werkstätten', 'A', 12, 1, 8),
    ('ALGEN', 'Tang', 'A', 12, 10, 5),
    ('ECHTE', 'authentische', 'A', 13, 4, 5),
    ('STEHT', 'stockt', 'A', 13, 10, 5),
    ('ECK', 'Winkel', 'A', 14, 1, 3),
    ('HEERES', 'Führung des ...', 'A', 14, 5, 6),
    ('SEE', 'Gewässer', 'A', 14, 12, 3),
    ('GEHABT', 'besessen', 'D', 1, 1, 6),
    ('PFADE', 'Wege', 'D', 10, 1, 5),
    ('ARENA', 'Stadion', 'D', 1, 2, 5),
    ('BUFFET', 'Anrichte', 'D', 7, 2, 6),
    ('GAERTNER', 'Grünpfleger', 'D', 1, 3, 8),
    ('EHE', 'Bund fürs Leben', 'D', 10, 3, 3),
    ('EHRE', 'Würde', 'D', 1, 4, 4),
    ('WILLE', 'Wunsch', 'D', 9, 4, 5),
    ('DEBAKEL', 'Fiasko', 'D', 4, 5, 7),
    ('ICH', 'Pronomen (1. Sg.)', 'D', 12, 5, 3),
    ('FEIER', 'Fest', 'D', 1, 6, 5),
    ('REH', 'Waldtier', 'D', 7, 6, 3),
    ('SEHE', 'erblicke', 'D', 11, 6, 4),
    ('ANS', 'an das', 'D', 1, 7, 3),
    ('BABY', 'Säugling', 'D', 5, 7, 4),
    ('WARTE', 'harre', 'D', 10, 7, 5),
    ('TEE', 'Heißgetränk', 'D', 3, 8, 3),
    ('UNSER', 'Possessiv (wir)', 'D', 10, 8, 5),
    ('BOARD', 'Gremium', 'D', 7, 9, 5),
    ('MORD', 'Tötung', 'D', 1, 10, 4),
    ('GRAMM', 'Tausendstel Kilo', 'D', 6, 10, 5),
    ('ASS', 'speiste', 'D', 12, 10, 3),
    ('AREAL', 'Gelände', 'D', 1, 11, 5),
    ('ART', 'Sorte', 'D', 7, 11, 3),
    ('ALT', 'betagt', 'D', 11, 11, 3),
    ('HEIM', 'Zuhause', 'D', 1, 12, 4),
    ('LUD', 'packte auf', 'D', 6, 12, 3),
    ('ZUGES', 'Abfahrt des ...', 'D', 10, 12, 5),
    ('SPION', 'Agent', 'D', 3, 13, 5),
    ('GEHE', 'laufe', 'D', 11, 13, 4),
    ('TIEF', 'abgründig', 'D', 1, 14, 4),
    ('KEIM', 'Erreger', 'D', 6, 14, 4),
    ('ENTE', 'Wasservogel', 'D', 11, 14, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r103-15x15-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r103-15x15-02', 'Rätsel 103 · 15×15', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '15x15-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('DISCO', 'Tanzlokal', 'A', 1, 1, 5),
    ('ZWEIG', 'Ast', 'A', 1, 10, 5),
    ('EHE', 'Bund fürs Leben', 'A', 2, 1, 3),
    ('VETO', 'Einspruch', 'A', 2, 5, 4),
    ('WURDE', 'entstand', 'A', 2, 10, 5),
    ('ARENA', 'Stadion', 'A', 3, 1, 5),
    ('ABSETZEN', 'abstellen', 'A', 3, 7, 8),
    ('SOLLST', 'musst', 'A', 4, 3, 6),
    ('REIS', 'Getreideart', 'A', 5, 4, 4),
    ('IGEL', 'Stacheltier', 'A', 5, 9, 4),
    ('BOOM', 'Aufschwung', 'A', 6, 1, 4),
    ('TEE', 'Heißgetränk', 'A', 6, 6, 3),
    ('SEHE', 'erblicke', 'A', 6, 11, 4),
    ('OPA', 'Großvater', 'A', 7, 1, 3),
    ('OSCAR', 'Filmpreis', 'A', 7, 10, 5),
    ('EIS', 'Gefrorenes', 'A', 8, 1, 3),
    ('BRAND', 'Feuer', 'A', 8, 5, 5),
    ('AKT', 'Aufzug', 'A', 8, 11, 3),
    ('SEELE', 'Psyche', 'A', 9, 1, 5),
    ('SEXY', 'attraktiv', 'A', 9, 8, 4),
    ('OHIO', 'Staat um Cleveland', 'A', 10, 4, 4),
    ('TUE', 'mache', 'A', 10, 12, 3),
    ('GITARREN', 'Klampfen', 'A', 11, 2, 8),
    ('GIER', 'Habsucht', 'A', 11, 11, 4),
    ('RAR', 'selten', 'A', 12, 1, 3),
    ('ART', 'Sorte', 'A', 12, 5, 3),
    ('LEBT', 'existiert', 'A', 12, 11, 4),
    ('AGIERTE', 'handelte', 'A', 13, 1, 7),
    ('CHARTA', 'Urkunde', 'A', 13, 9, 6),
    ('DES', 'Artikel (Genitiv)', 'A', 14, 1, 3),
    ('NAH', 'dicht', 'A', 14, 7, 3),
    ('SEEN', 'Gewässer', 'A', 14, 11, 4),
    ('DEAL', 'Geschäft', 'D', 1, 1, 4),
    ('BOESE', 'gemein', 'D', 6, 1, 5),
    ('RAD', 'Velo', 'D', 12, 1, 3),
    ('IHR', 'Pronomen (2. Pl.)', 'D', 1, 2, 3),
    ('KOPIE', 'Abschrift', 'D', 5, 2, 5),
    ('GAGE', 'Honorar', 'D', 11, 2, 4),
    ('SEES', 'Ufer des ...', 'D', 1, 3, 4),
    ('OASE', 'Wüsteninsel', 'D', 6, 3, 4),
    ('IRIS', 'Schwertlilie', 'D', 11, 3, 4),
    ('NORM', 'Regel', 'D', 3, 4, 4),
    ('LOT', 'Senkblei', 'D', 9, 4, 3),
    ('OVALE', 'eiförmige', 'D', 1, 5, 5),
    ('BEHAART', 'pelzig', 'D', 8, 5, 7),
    ('LITER', 'Hohlmaß', 'D', 4, 6, 5),
    ('IRRT', 'täuscht sich', 'D', 10, 6, 4),
    ('TASSE', 'Becher', 'D', 2, 7, 5),
    ('ORTEN', 'Stellen', 'D', 10, 7, 5),
    ('LOBT', 'preist', 'D', 1, 8, 4),
    ('EINS', 'Zahl (2−1)', 'D', 6, 8, 4),
    ('DEMNACH', 'folglich', 'D', 8, 9, 7),
    ('ZWERG', 'Wicht', 'D', 1, 10, 5),
    ('WUT', 'Zorn', 'D', 1, 11, 3),
    ('ESSAY', 'Aufsatz', 'D', 5, 11, 5),
    ('GLAS', 'Trinkgefäß', 'D', 11, 11, 4),
    ('ERZ', 'Gestein', 'D', 1, 12, 3),
    ('LECK', 'Loch', 'D', 5, 12, 4),
    ('TIERE', 'Lebewesen', 'D', 10, 12, 5),
    ('IDEE', 'Einfall', 'D', 1, 13, 4),
    ('HAT', 'besitzt', 'D', 6, 13, 3),
    ('UEBTE', 'trainierte', 'D', 10, 13, 5),
    ('GEN', 'nach', 'D', 1, 14, 3),
    ('PER', 'mittels', 'D', 5, 14, 3),
    ('VERTAN', 'verschwendet', 'D', 9, 14, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r104-15x15-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r104-15x15-03', 'Rätsel 104 · 15×15', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '15x15-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('STUBE', 'Zimmer', 'A', 1, 1, 5),
    ('SHOWDOWN', 'Duell', 'A', 1, 7, 8),
    ('IRRE', 'Verrückte', 'A', 2, 1, 4),
    ('KEIM', 'Erreger', 'A', 2, 6, 4),
    ('TEIL', 'Stück', 'A', 3, 1, 4),
    ('OHNE', 'abzüglich', 'A', 3, 6, 4),
    ('RAND', 'Kante', 'A', 3, 11, 4),
    ('ZUNAHME', 'Anstieg', 'A', 4, 1, 7),
    ('TEE', 'Heißgetränk', 'A', 4, 12, 3),
    ('FOUL', 'Regelverstoß', 'A', 5, 11, 4),
    ('ZEIT', 'Dauer', 'A', 6, 1, 4),
    ('LOS', 'frei', 'A', 6, 6, 3),
    ('ARMEN', 'Mittellosen', 'A', 6, 10, 5),
    ('URHEBER', 'Schöpfer', 'A', 7, 1, 7),
    ('GRUEN', 'unreif', 'A', 7, 9, 5),
    ('MAN', 'jemand', 'A', 8, 1, 3),
    ('EXTREME', 'äußerste', 'A', 8, 5, 7),
    ('HABE', 'besitze', 'A', 9, 11, 4),
    ('ENTEN', 'Wasservögel', 'A', 10, 1, 5),
    ('UHR', 'Zeitmesser', 'A', 10, 7, 3),
    ('EBEN', 'flach', 'A', 10, 11, 4),
    ('BEI', 'nahe an', 'A', 11, 1, 3),
    ('ARMEEN', 'Heere', 'A', 11, 5, 6),
    ('FIT', 'gesund', 'A', 11, 12, 3),
    ('ENGEM', 'schmalem', 'A', 12, 1, 5),
    ('BIS', 'nicht später als', 'A', 12, 7, 3),
    ('MASS', 'Größe', 'A', 12, 11, 4),
    ('EHEMALS', 'früher', 'A', 13, 3, 7),
    ('ALS', 'da, während', 'A', 13, 11, 3),
    ('EHREN', 'zu ... von', 'A', 14, 1, 5),
    ('TEILTE', 'trennte', 'A', 14, 9, 6),
    ('SITZ', 'Stuhl', 'D', 1, 1, 4),
    ('ZUM', 'zu dem', 'D', 6, 1, 3),
    ('EBENE', 'Fläche', 'D', 10, 1, 5),
    ('TREU', 'loyal', 'D', 1, 2, 4),
    ('ERAHNEN', 'vermuten', 'D', 6, 2, 7),
    ('URIN', 'Harn', 'D', 1, 3, 4),
    ('IHN', 'Akkusativ von er', 'D', 6, 3, 3),
    ('TIGER', 'Großkatze', 'D', 10, 3, 5),
    ('BELASTE', 'beschwere', 'D', 1, 4, 7),
    ('EHE', 'Bund fürs Leben', 'D', 12, 4, 3),
    ('BEINAMEN', 'Epitheta', 'D', 7, 5, 8),
    ('KOMPLEX', 'Gefüge', 'D', 2, 6, 7),
    ('SEHE', 'erblicke', 'D', 1, 7, 4),
    ('ORT', 'Stelle', 'D', 6, 7, 3),
    ('UMBAU', 'Renovierung', 'D', 10, 7, 5),
    ('HIN', '... und her', 'D', 1, 8, 3),
    ('HEIL', 'Wohl', 'D', 10, 8, 4),
    ('OMEN', 'Vorzeichen', 'D', 1, 9, 4),
    ('GEPRESST', 'gedrückt', 'D', 7, 9, 8),
    ('ARM', 'Gliedmaße', 'D', 6, 10, 3),
    ('DAR', 'stellt ... (zeigt)', 'D', 1, 11, 3),
    ('FRUEHE', 'zeitige', 'D', 5, 11, 6),
    ('MAI', '5. Monat', 'D', 12, 11, 3),
    ('ATOME', 'Teilchen', 'D', 3, 12, 5),
    ('ABFALL', 'Müll', 'D', 9, 12, 6),
    ('NEUEN', 'frischen', 'D', 3, 13, 5),
    ('BEISST', 'schnappt', 'D', 9, 13, 6),
    ('NUDELN', 'Teigwaren', 'D', 1, 14, 6),
    ('CENTS', 'Hundertstel', 'D', 8, 14, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

commit;
