-- Automatisch erzeugt von tools/generator/generate_raetsel.py – nicht von Hand bearbeiten.
-- Voraussetzung: Migrationen, gitter_vorlagen.sql, woerter_seed.sql, fragen_varianten_seed.sql und fragen_varianten_seed_phase6.sql eingespielt.
-- Idempotent über raetsel.slug. Rätsel mit Prüfhinweisen werden als Entwurf angelegt.

begin;

-- r001-8x8-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r001-8x8-01', 'Rätsel 1 · 8×8', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '8x8-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('REIF', 'erntefertig', 'A', 1, 1, 4),
    ('ANHANG', 'Beilage', 'A', 2, 1, 6),
    ('DONNER', 'Grollen', 'A', 3, 1, 6),
    ('STUR', 'unnachgiebig', 'A', 4, 4, 4),
    ('UMS', 'um das', 'A', 5, 1, 3),
    ('TEE', 'Aufguss', 'A', 5, 5, 3),
    ('ELEND', 'Misere', 'A', 6, 3, 5),
    ('MUT', 'Courage', 'A', 7, 1, 3),
    ('SEE', 'Gewässer', 'A', 7, 5, 3),
    ('RAD', 'Kreisscheibe', 'D', 1, 1, 3),
    ('ULM', 'Münsterstadt', 'D', 5, 1, 3),
    ('ENORM', 'gewaltig', 'D', 1, 2, 5),
    ('IHN', 'Akkusativ von er', 'D', 1, 3, 3),
    ('SET', 'Satz', 'D', 5, 3, 3),
    ('FANS', 'Anhänger', 'D', 1, 4, 4),
    ('NETTES', 'freundliches', 'D', 2, 5, 6),
    ('GRUENE', 'ökologische', 'D', 2, 6, 6),
    ('REDE', 'Ansprache', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r002-8x8-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r002-8x8-02', 'Rätsel 2 · 8×8', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '8x8-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('UTAH', 'Mormonenstaat', 'A', 1, 4, 4),
    ('FAHNE', 'Flagge', 'A', 2, 1, 5),
    ('RAETE', 'Gremien', 'A', 3, 1, 5),
    ('IRRE', 'Verrückte', 'A', 4, 1, 4),
    ('ORGAN', 'Eingeweide', 'A', 5, 3, 5),
    ('IMAGE', 'Ansehen', 'A', 6, 3, 5),
    ('TUN', 'verrichten', 'A', 7, 1, 3),
    ('BAU', 'Gebäude', 'A', 7, 5, 3),
    ('FRISST', 'verschlingt', 'D', 2, 1, 6),
    ('PAAR', 'einige', 'D', 1, 2, 4),
    ('HEROIN', 'Rauschgift', 'D', 2, 3, 6),
    ('UNTERM', 'unter dem', 'D', 1, 4, 6),
    ('TEE', 'Aufguss', 'D', 1, 5, 3),
    ('GAB', 'schenkte', 'D', 5, 5, 3),
    ('SAGA', 'Heldensage', 'D', 4, 6, 4),
    ('HIN', 'fort', 'D', 1, 7, 3),
    ('NEU', 'aktuell', 'D', 5, 7, 3)
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
    ('SOVIEL', 'so weit', 'A', 1, 1, 6),
    ('EINBAU', 'Montage', 'A', 2, 2, 6),
    ('PLANEN', 'vorhaben', 'A', 3, 1, 6),
    ('ENGE', 'knappe', 'A', 4, 4, 4),
    ('ASS', 'speiste', 'A', 5, 1, 3),
    ('SET', 'Ausstattung', 'A', 5, 5, 3),
    ('TEE', 'Aufguss', 'A', 6, 1, 3),
    ('OMA', 'Großmutter', 'A', 6, 5, 3),
    ('ZEIT', 'Frist', 'A', 7, 1, 4),
    ('PLATZ', 'Areal', 'D', 3, 1, 5),
    ('OEL', 'Rohstoff', 'D', 1, 2, 3),
    ('SEE', 'Weiher', 'D', 5, 2, 3),
    ('VIA', 'über', 'D', 1, 3, 3),
    ('SEI', 'existiere', 'D', 5, 3, 3),
    ('INNE', '... halten', 'D', 1, 4, 4),
    ('EBENSO', 'gleichfalls', 'D', 1, 5, 6),
    ('LANGEM', 'seit ...', 'D', 1, 6, 6),
    ('ETAT', 'Budget', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r004-9x9-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r004-9x9-01', 'Rätsel 4 · 9×9', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '9x9-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('EGAL', 'einerlei', 'A', 1, 1, 4),
    ('LOS', 'frei', 'A', 1, 6, 3),
    ('IRRE', 'Wahnsinnige', 'A', 2, 1, 4),
    ('AMT', 'Behörde', 'A', 2, 6, 3),
    ('NAME', 'Bezeichnung', 'A', 3, 1, 4),
    ('GAU', 'Landesteil', 'A', 3, 6, 3),
    ('TUER', 'Eingang', 'A', 4, 1, 4),
    ('WAHL', 'Abstimmung', 'A', 5, 5, 4),
    ('ANTEILE', 'Aktien', 'A', 6, 1, 7),
    ('FUEHRTE', 'steuerte', 'A', 7, 1, 7),
    ('REEDER', 'Schiffsherr', 'A', 8, 2, 6),
    ('EINTRAF', 'ankam', 'D', 1, 1, 7),
    ('GRAU', 'farblos', 'D', 1, 2, 4),
    ('NUR', 'lediglich', 'D', 6, 2, 3),
    ('ARME', 'Mittellose', 'D', 1, 3, 4),
    ('TEE', 'Heißgetränk', 'D', 6, 3, 3),
    ('LEER', 'hohl', 'D', 1, 4, 4),
    ('EHE', 'Bund fürs Leben', 'D', 6, 4, 3),
    ('WIRD', 'entsteht', 'D', 5, 5, 4),
    ('LAG', 'befand sich', 'D', 1, 6, 3),
    ('ALTE', 'greise', 'D', 5, 6, 4),
    ('OMA', 'Omi', 'D', 1, 7, 3),
    ('HEER', 'Armee', 'D', 5, 7, 4),
    ('STUHL', 'Sitz', 'D', 1, 8, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r005-9x9-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r005-9x9-02', 'Rätsel 5 · 9×9', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '9x9-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('EBBE', 'Gegenteil der Flut', 'A', 1, 1, 4),
    ('HEU', 'Viehfutter', 'A', 1, 6, 3),
    ('HEILT', 'kuriert', 'A', 2, 1, 5),
    ('EINFALL', 'Idee', 'A', 3, 1, 7),
    ('LIEB', 'nett', 'A', 4, 5, 4),
    ('ERBOST', 'wütend', 'A', 5, 1, 6),
    ('HEER', 'Armee', 'A', 6, 1, 4),
    ('TUN', 'machen', 'A', 6, 6, 3),
    ('RITT', 'Reise zu Pferd', 'A', 7, 1, 4),
    ('ENG', 'knapp', 'A', 7, 6, 3),
    ('ENTE', 'Wasservogel', 'A', 8, 1, 4),
    ('NIE', 'nimmer', 'A', 8, 6, 3),
    ('EHE', 'Bund fürs Leben', 'D', 1, 1, 3),
    ('EHRE', 'Prestige', 'D', 5, 1, 4),
    ('BEI', 'nahe an', 'D', 1, 2, 3),
    ('REIN', 'sauber', 'D', 5, 2, 4),
    ('BIN', 'Verbform', 'D', 1, 3, 3),
    ('BETT', 'Schlafstätte', 'D', 5, 3, 4),
    ('ELF', 'Zahl (10+1)', 'D', 1, 4, 3),
    ('ORTE', 'Stellen', 'D', 5, 4, 4),
    ('TALS', 'Grund des ...', 'D', 2, 5, 4),
    ('LITTEN', 'duldeten', 'D', 3, 6, 6),
    ('EILE', 'Hast', 'D', 1, 7, 4),
    ('UNI', 'Alma Mater', 'D', 6, 7, 3),
    ('BANGE', 'ängstlich', 'D', 4, 8, 5)
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
    ('IRAN', 'Persien', 'A', 1, 1, 4),
    ('UHR', 'Chronometer', 'A', 1, 6, 3),
    ('HEXE', 'Zauberin', 'A', 2, 1, 4),
    ('RIO', 'Zuckerhut-Stadt', 'A', 2, 6, 3),
    ('RITT', 'Reise zu Pferd', 'A', 3, 1, 4),
    ('SET', 'Ausstattung', 'A', 3, 6, 3),
    ('ZWAR', 'freilich', 'A', 4, 4, 4),
    ('LEICHT', 'mühelos', 'A', 5, 3, 6),
    ('OMA', 'Großmutter', 'A', 6, 1, 3),
    ('EHER', 'vielmehr', 'A', 6, 5, 4),
    ('RAN', 'heran', 'A', 7, 1, 3),
    ('GERA', 'Stadt in Thüringen', 'A', 7, 5, 4),
    ('ENDET', 'hört auf', 'A', 8, 1, 5),
    ('IHR', 'Pronomen (2. Pl.)', 'D', 1, 1, 3),
    ('TORE', 'Treffer', 'D', 5, 1, 4),
    ('REIN', 'sauber', 'D', 1, 2, 4),
    ('MAN', 'Pronomen', 'D', 6, 2, 3),
    ('AXT', 'Beil', 'D', 1, 3, 3),
    ('LAND', 'Staat', 'D', 5, 3, 4),
    ('NETZE', 'Geflechte', 'D', 1, 4, 5),
    ('WIEGT', 'schaukelt', 'D', 4, 5, 5),
    ('URSACHE', 'Grund', 'D', 1, 6, 7),
    ('HIERHER', 'herbei', 'D', 1, 7, 7),
    ('ROT', 'knallig', 'D', 1, 8, 3),
    ('TRAT', 'schritt', 'D', 5, 8, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r007-9x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r007-9x13-01', 'Rätsel 7 · 9×13', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '9x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ENDE', 'Schluss', 'A', 1, 1, 4),
    ('HIERBEI', 'dabei', 'A', 1, 6, 7),
    ('HIRN', 'Verstand', 'A', 2, 1, 4),
    ('SEINS', 'Sinn des ...', 'A', 2, 8, 5),
    ('EXAKTE', 'genaue', 'A', 3, 1, 6),
    ('SINGT', 'trällert', 'A', 3, 8, 5),
    ('NEUNTEN', 'am ... Juni', 'A', 4, 3, 7),
    ('LEGE', 'platziere', 'A', 5, 4, 4),
    ('ARM', 'Extremität', 'A', 6, 1, 3),
    ('REST', 'Überbleibsel', 'A', 6, 5, 4),
    ('AST', 'Zweig', 'A', 6, 10, 3),
    ('MAI', '5. Monat', 'A', 7, 1, 3),
    ('ENTE', 'Wasservogel', 'A', 7, 5, 4),
    ('NIE', 'zu keiner Zeit', 'A', 7, 10, 3),
    ('TURIN', 'Stadt am Po', 'A', 8, 1, 5),
    ('SEINEM', 'ihrem', 'A', 8, 7, 6),
    ('EHER', 'vielmehr', 'D', 1, 1, 4),
    ('AMT', 'Behörde', 'D', 6, 1, 3),
    ('NIX', 'gar nichts', 'D', 1, 2, 3),
    ('FRAU', 'Dame', 'D', 5, 2, 4),
    ('DRAN', 'an der Reihe', 'D', 1, 3, 4),
    ('MIR', 'Dat. (1. Pers.)', 'D', 6, 3, 3),
    ('ENKEL', 'Kindeskind', 'D', 1, 4, 5),
    ('TUEREN', 'Pforten', 'D', 3, 5, 6),
    ('HAENGEN', 'baumeln', 'D', 1, 6, 7),
    ('TESTS', 'Kontrollen', 'D', 4, 7, 5),
    ('ESSE', 'verspeise', 'D', 1, 8, 4),
    ('TEE', 'Aufguss', 'D', 6, 8, 3),
    ('REIN', 'sauber', 'D', 1, 9, 4),
    ('BIN', 'Verbform', 'D', 1, 10, 3),
    ('DANN', 'daraufhin', 'D', 5, 10, 4),
    ('ENGE', 'knappe', 'D', 1, 11, 4),
    ('SIE', 'Anrede', 'D', 6, 11, 3),
    ('IST', 'befindet sich', 'D', 1, 12, 3),
    ('ATEM', 'Luft', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r008-9x13-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r008-9x13-02', 'Rätsel 8 · 9×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x13-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('GAB', 'schenkte', 'A', 1, 1, 3),
    ('DEN', 'Artikel (Akkusativ)', 'A', 1, 6, 3),
    ('OMA', 'Omi', 'A', 1, 10, 3),
    ('AUE', 'Talwiese', 'A', 2, 1, 3),
    ('LILA', 'Violett', 'A', 2, 5, 4),
    ('MAL', 'Zeichen ×', 'A', 2, 10, 3),
    ('ETAT', 'Finanzplan', 'A', 3, 1, 4),
    ('EISZEIT', 'Glazial', 'A', 3, 6, 7),
    ('NOTE', 'Tonzeichen', 'A', 4, 1, 4),
    ('STEIN', 'Fels', 'A', 4, 6, 5),
    ('IDEE', 'Einfall', 'A', 5, 4, 4),
    ('ENDLOS', 'ewig', 'A', 6, 1, 6),
    ('AMTES', 'Ende des ...', 'A', 6, 8, 5),
    ('EIER', 'Gelege', 'A', 7, 2, 4),
    ('FREUTE', 'beglückte', 'A', 7, 7, 6),
    ('DUENNE', 'magere', 'A', 8, 1, 6),
    ('TRETE', 'kicke', 'A', 8, 8, 5),
    ('GAENGE', 'Flure', 'D', 1, 1, 6),
    ('AUTO', 'Wagen', 'D', 1, 2, 4),
    ('NEU', 'aktuell', 'D', 6, 2, 3),
    ('BEAT', 'Rhythmus', 'D', 1, 3, 4),
    ('DIE', 'Artikel (weibl.)', 'D', 6, 3, 3),
    ('TEILEN', 'zu gleichen ...', 'D', 3, 4, 6),
    ('DORN', 'Stachel', 'D', 5, 5, 4),
    ('DIESES', 'Pronomen', 'D', 1, 6, 6),
    ('ELITE', 'Auslese', 'D', 1, 7, 5),
    ('NASE', 'Zinken', 'D', 1, 8, 4),
    ('ART', 'Sorte', 'D', 6, 8, 3),
    ('ZIMMER', 'Stube', 'D', 3, 9, 6),
    ('OMEN', 'Vorbote', 'D', 1, 10, 4),
    ('TUE', 'mache', 'D', 6, 10, 3),
    ('MAI', 'Wonnemonat', 'D', 1, 11, 3),
    ('BETT', 'Schlafstätte', 'D', 5, 11, 4),
    ('ALTE', 'greise', 'D', 1, 12, 4),
    ('SEE', 'Gewässer', 'D', 6, 12, 3)
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
    ('INNE', 'Verbpartikel', 'A', 1, 1, 4),
    ('SYMPTOM', 'Anzeichen', 'A', 1, 6, 7),
    ('SUENDE', 'Frevel', 'A', 2, 1, 6),
    ('AROMA', 'Geschmack', 'A', 2, 8, 5),
    ('TRUGEN', 'schleppten', 'A', 3, 1, 6),
    ('MORAL', 'Ethik', 'A', 3, 8, 5),
    ('PAPA', 'Vater', 'A', 4, 5, 4),
    ('NOTE', 'Tonzeichen', 'A', 5, 4, 4),
    ('LESE', 'studiere', 'A', 5, 9, 4),
    ('ERBEN', 'Nachkommen', 'A', 6, 1, 5),
    ('REISEN', 'Fahrten', 'A', 6, 7, 6),
    ('HAITI', 'Karibikstaat', 'A', 7, 1, 5),
    ('LEID', 'Weh', 'A', 7, 9, 4),
    ('ERNTETE', 'pflückte', 'A', 8, 1, 7),
    ('ALLE', 'sämtliche', 'A', 8, 9, 4),
    ('IST', 'befindet sich', 'D', 1, 1, 3),
    ('GEHE', 'wandle', 'D', 5, 1, 4),
    ('NUR', 'lediglich', 'D', 1, 2, 3),
    ('RAR', 'kostbar', 'D', 6, 2, 3),
    ('NEUE', 'frische', 'D', 1, 3, 4),
    ('BIN', 'Verbform', 'D', 6, 3, 3),
    ('ENG', 'knapp', 'D', 1, 4, 3),
    ('NETT', 'sympathisch', 'D', 5, 4, 4),
    ('DEPONIE', 'Müllplatz', 'D', 2, 5, 7),
    ('SENAT', 'Ältestenrat', 'D', 1, 6, 5),
    ('PERLE', 'Juwel', 'D', 4, 7, 5),
    ('MAMA', 'Mutti', 'D', 1, 8, 4),
    ('PRO', 'je', 'D', 1, 9, 3),
    ('LILA', 'Violett', 'D', 5, 9, 4),
    ('TOR', 'Treffer', 'D', 1, 10, 3),
    ('ESEL', 'Dickkopf', 'D', 5, 10, 4),
    ('OMA', 'Großmutter', 'D', 1, 11, 3),
    ('SEIL', 'Tau', 'D', 5, 11, 4),
    ('MAL', 'Zeichen ×', 'D', 1, 12, 3),
    ('ENDE', 'Finale', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r010-10x10-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r010-10x10-01', 'Rätsel 10 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('GUT', 'brauchbar', 'A', 1, 1, 3),
    ('NERV', 'Reizleiter', 'A', 1, 6, 4),
    ('LEIDE', 'dulde', 'A', 2, 1, 5),
    ('HAI', 'Meeresräuber', 'A', 2, 7, 3),
    ('ABER', 'jedoch', 'A', 3, 1, 4),
    ('AERA', 'Epoche', 'A', 3, 6, 4),
    ('STRESS', 'Hektik', 'A', 4, 1, 6),
    ('SETZTE', 'stellte', 'A', 5, 4, 6),
    ('SEIDE', 'Gewebe', 'A', 6, 1, 5),
    ('WER', 'Fragewort (Person)', 'A', 6, 7, 3),
    ('EURE', 'Possessiv (ihr)', 'A', 7, 1, 4),
    ('FEIN', 'zart', 'A', 7, 6, 4),
    ('KRAN', 'Hebezeug', 'A', 8, 1, 4),
    ('EILT', 'hastet', 'A', 8, 6, 4),
    ('TON', 'Klang', 'A', 9, 1, 3),
    ('LEGTE', 'platzierte', 'A', 9, 5, 5),
    ('GLAS', 'Trinkgefäß', 'D', 1, 1, 4),
    ('SEKT', 'Schaumwein', 'D', 6, 1, 4),
    ('UEBT', 'trainiert', 'D', 1, 2, 4),
    ('EURO', 'Währung', 'D', 6, 2, 4),
    ('TIER', 'Lebewesen', 'D', 1, 3, 4),
    ('IRAN', 'Persien', 'D', 6, 3, 4),
    ('DRESDEN', 'Elbflorenz', 'D', 2, 4, 7),
    ('SEE', 'Weiher', 'D', 4, 5, 3),
    ('AST', 'Knorren', 'D', 3, 6, 3),
    ('FEE', 'Elfe', 'D', 7, 6, 3),
    ('EHE', 'Bund fürs Leben', 'D', 1, 7, 3),
    ('ZWEIG', 'Ast', 'D', 5, 7, 5),
    ('RAR', 'kostbar', 'D', 1, 8, 3),
    ('TEILT', 'trennt', 'D', 5, 8, 5),
    ('VIA', 'über', 'D', 1, 9, 3),
    ('ERNTE', 'Lese', 'D', 5, 9, 5)
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
    ('ANS', 'an das', 'A', 1, 1, 3),
    ('LIPPE', 'Mundrand', 'A', 1, 5, 5),
    ('BIENE', 'Imme', 'A', 2, 1, 5),
    ('LOS', 'frei', 'A', 2, 7, 3),
    ('TEXAS', 'Staat um Houston', 'A', 3, 1, 5),
    ('ASS', 'speiste', 'A', 3, 7, 3),
    ('MEINTE', 'glaubte', 'A', 4, 4, 6),
    ('MAUERN', 'Wände', 'A', 5, 1, 6),
    ('ARM', 'Gliedmaße', 'A', 6, 1, 3),
    ('SEES', 'Fläche des ...', 'A', 6, 6, 4),
    ('JOB', 'Beruf', 'A', 7, 1, 3),
    ('SENSE', 'Mähwerkzeug', 'A', 7, 5, 5),
    ('OMA', 'Omi', 'A', 8, 1, 3),
    ('ALTEN', 'ergrauten', 'A', 8, 5, 5),
    ('RAUCH', 'Qualm', 'A', 9, 1, 5),
    ('ELF', 'Zahl (10+1)', 'A', 9, 7, 3),
    ('ABT', 'Klosterchef', 'D', 1, 1, 3),
    ('MAJOR', 'Dienstgrad', 'D', 5, 1, 5),
    ('NIE', 'nimmer', 'D', 1, 2, 3),
    ('AROMA', 'Geschmack', 'D', 5, 2, 5),
    ('SEX', 'Geschlecht', 'D', 1, 3, 3),
    ('UMBAU', 'Renovierung', 'D', 5, 3, 5),
    ('NAME', 'Titel', 'D', 2, 4, 4),
    ('LESER', 'Publikum', 'D', 1, 5, 5),
    ('SAH', 'erblickte', 'D', 7, 5, 3),
    ('INSEL', 'Eiland', 'D', 4, 6, 5),
    ('PLAN', 'Absicht', 'D', 1, 7, 4),
    ('ENTE', 'Wasservogel', 'D', 6, 7, 4),
    ('POST', 'Briefe', 'D', 1, 8, 4),
    ('ESEL', 'Dickkopf', 'D', 6, 8, 4),
    ('ESSE', 'speise', 'D', 1, 9, 4),
    ('SENF', 'Gewürzpaste', 'D', 6, 9, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r012-10x10-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r012-10x10-03', 'Rätsel 12 · 10×10', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '10x10-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('INSEL', 'Eiland', 'A', 1, 1, 5),
    ('SET', 'Satz', 'A', 1, 7, 3),
    ('HIER', 'an dieser Stelle', 'A', 2, 1, 4),
    ('EHE', 'Bund fürs Leben', 'A', 2, 7, 3),
    ('REIF', 'erntefertig', 'A', 3, 1, 4),
    ('IHRE', 'seine', 'A', 3, 6, 4),
    ('ERNANNTE', 'berief', 'A', 4, 1, 8),
    ('MESSEN', 'ermitteln', 'A', 5, 1, 6),
    ('SUESSE', 'zuckrige', 'A', 6, 4, 6),
    ('SEITE', 'Blatt', 'A', 7, 1, 5),
    ('TOD', 'Ableben', 'A', 7, 7, 3),
    ('EIS', 'Gefrorenes', 'A', 8, 1, 3),
    ('REIFE', 'Mündigkeit', 'A', 8, 5, 5),
    ('ENTE', 'Falschmeldung', 'A', 9, 1, 4),
    ('LAS', 'schmökerte', 'A', 9, 7, 3),
    ('IHREM', 'seinem', 'D', 1, 1, 5),
    ('SEE', 'Weiher', 'D', 7, 1, 3),
    ('NIERE', 'Harnorgan', 'D', 1, 2, 5),
    ('EIN', 'unbest. Artikel', 'D', 7, 2, 3),
    ('SEINS', 'Sinn des ...', 'D', 1, 3, 5),
    ('IST', 'befindet sich', 'D', 7, 3, 3),
    ('ERFASST', 'registriert', 'D', 1, 4, 7),
    ('NEUER', 'frischer', 'D', 4, 5, 5),
    ('INNE', '... halten', 'D', 3, 6, 4),
    ('SEHT', 'schaut', 'D', 1, 7, 4),
    ('STIL', 'Machart', 'D', 6, 7, 4),
    ('EHRE', 'Prestige', 'D', 1, 8, 4),
    ('SOFA', 'Couch', 'D', 6, 8, 4),
    ('TEE', 'Heißgetränk', 'D', 1, 9, 3),
    ('JEDES', 'alle', 'D', 5, 9, 5)
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
    ('LEST', 'studiert', 'A', 1, 1, 4),
    ('MEHR', 'obendrein', 'A', 1, 6, 4),
    ('ORT', 'Platz', 'A', 2, 1, 3),
    ('SERIE', 'Reihe', 'A', 2, 5, 5),
    ('KLUB', 'Verein', 'A', 3, 1, 4),
    ('EBEN', 'just', 'A', 3, 6, 4),
    ('SAFE', 'Panzerschrank', 'A', 4, 1, 4),
    ('REST', 'Überbleibsel', 'A', 4, 6, 4),
    ('GEFAESSE', 'Behälter', 'A', 5, 2, 8),
    ('ALS', 'da, während', 'A', 6, 4, 3),
    ('EVENT', 'Ereignis', 'A', 7, 1, 5),
    ('AST', 'Knorren', 'A', 7, 7, 3),
    ('FINDE', 'entdecke', 'A', 8, 1, 5),
    ('RIO', 'Stadt in Brasilien', 'A', 8, 7, 3),
    ('TAG', 'Kalenderblatt', 'A', 9, 1, 3),
    ('REGEN', 'Niederschlag', 'A', 9, 5, 5),
    ('LOKS', 'Triebwagen', 'D', 1, 1, 4),
    ('HEFT', 'Broschüre', 'D', 6, 1, 4),
    ('ERLAG', 'starb an', 'D', 1, 2, 5),
    ('VIA', 'über', 'D', 7, 2, 3),
    ('STUFE', 'Tritt', 'D', 1, 3, 5),
    ('ENG', 'schmal', 'D', 7, 3, 3),
    ('BEFAND', 'urteilte', 'D', 3, 4, 6),
    ('ALTER', 'Lebensjahre', 'D', 5, 5, 5),
    ('MEERES', 'Rauschen des ...', 'D', 1, 6, 6),
    ('ERBES', 'Wert des ...', 'D', 1, 7, 5),
    ('ARG', 'schlimm', 'D', 7, 7, 3),
    ('HIESS', 'nannte sich', 'D', 1, 8, 5),
    ('SIE', 'Anrede', 'D', 7, 8, 3),
    ('RENTE', 'Pension', 'D', 1, 9, 5),
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
    ('EHRT', 'zollt Respekt', 'A', 1, 1, 4),
    ('FLOSS', 'strömte', 'A', 1, 6, 5),
    ('HAI', 'Raubfisch', 'A', 2, 1, 3),
    ('RAT', 'Gremium', 'A', 2, 8, 3),
    ('ENORME', 'gewaltige', 'A', 3, 1, 6),
    ('DUO', 'Tandem', 'A', 3, 8, 3),
    ('SENF', 'Mostrich', 'A', 4, 7, 4),
    ('FUSST', 'beruht', 'A', 5, 1, 5),
    ('TRAF', 'kreuzte', 'A', 5, 7, 4),
    ('ATOME', 'Teilchen', 'A', 6, 3, 5),
    ('BAT', 'flehte', 'A', 7, 1, 3),
    ('TEILS', 'partiell', 'A', 7, 5, 5),
    ('RUIN', 'Untergang', 'A', 8, 1, 4),
    ('ELITE', 'Auslese', 'A', 8, 6, 5),
    ('IRRE', 'Verrückte', 'A', 9, 1, 4),
    ('REGAL', 'Gestell', 'A', 9, 6, 5),
    ('KAEUFE', 'Erwerbe', 'A', 10, 1, 6),
    ('AUF', 'offen', 'A', 10, 8, 3),
    ('EHE', 'Vermählung', 'D', 1, 1, 3),
    ('FABRIK', 'Werk', 'D', 5, 1, 6),
    ('HANAU', 'Stadt am Main', 'D', 1, 2, 5),
    ('AURA', 'Fluidum', 'D', 7, 2, 4),
    ('RIO', 'Zuckerhut-Stadt', 'D', 1, 3, 3),
    ('SATIRE', 'Spottschrift', 'D', 5, 3, 6),
    ('ROST', 'Grill', 'D', 3, 4, 4),
    ('NEU', 'aktuell', 'D', 8, 4, 3),
    ('TOT', 'verstorben', 'D', 5, 5, 3),
    ('FEE', 'Elfe', 'D', 1, 6, 3),
    ('MEERE', 'Ozeane', 'D', 6, 6, 5),
    ('STEILE', 'abschüssige', 'D', 4, 7, 6),
    ('ORDER', 'Auftrag', 'D', 1, 8, 5),
    ('LIGA', 'Spielklasse', 'D', 7, 8, 4),
    ('SAUNA', 'Schwitzbad', 'D', 1, 9, 5),
    ('STAU', 'Blechlawine', 'D', 7, 9, 4),
    ('STOFFE', 'Materialien', 'D', 1, 10, 6),
    ('ELF', 'Zahl (10+1)', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r015-11x11-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r015-11x11-02', 'Rätsel 15 · 11×11', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '11x11-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('BIN', 'Verbform', 'A', 1, 1, 3),
    ('RISIKO', 'Wagnis', 'A', 1, 5, 6),
    ('ESEL', 'Dickkopf', 'A', 2, 1, 4),
    ('HERAB', 'hinunter', 'A', 2, 6, 5),
    ('ART', 'Sorte', 'A', 3, 1, 3),
    ('INTIME', 'vertraute', 'A', 3, 5, 6),
    ('TAT', 'Werk', 'A', 4, 1, 3),
    ('FING', 'erwischte', 'A', 5, 4, 4),
    ('FLAIR', 'Ambiente', 'A', 6, 1, 5),
    ('ERDE', 'Heimatplanet', 'A', 6, 7, 4),
    ('STACHELN', 'Dornen', 'A', 7, 3, 8),
    ('INS', 'in das', 'A', 8, 1, 3),
    ('KOENIG', 'Monarch', 'A', 8, 5, 6),
    ('HEER', 'Armee', 'A', 9, 1, 4),
    ('DINGE', 'Sachen', 'A', 9, 6, 5),
    ('NUN', 'inzwischen', 'A', 10, 1, 3),
    ('AEMTER', 'Behörden', 'A', 10, 5, 6),
    ('BEAT', 'Rhythmus', 'D', 1, 1, 4),
    ('IHN', 'Akkusativ von er', 'D', 8, 1, 3),
    ('ISRAEL', 'Nahoststaat', 'D', 1, 2, 6),
    ('NEU', 'aktuell', 'D', 8, 2, 3),
    ('NETT', 'sympathisch', 'D', 1, 3, 4),
    ('ASSEN', 'verzehrten', 'D', 6, 3, 5),
    ('FIT', 'sportlich', 'D', 5, 4, 3),
    ('IRAK', 'Land am Tigris', 'D', 5, 5, 4),
    ('IHNEN', 'Anrede', 'D', 1, 6, 5),
    ('CODE', 'Kennung', 'D', 7, 6, 4),
    ('SET', 'Ausstattung', 'D', 1, 7, 3),
    ('GEHEIM', 'verborgen', 'D', 5, 7, 6),
    ('IRIS', 'Schwertlilie', 'D', 1, 8, 4),
    ('RENNT', 'läuft', 'D', 6, 8, 5),
    ('KAM', 'traf ein', 'D', 1, 9, 3),
    ('ADLIGE', 'Edelmann', 'D', 5, 9, 6),
    ('OBEN', 'in der Höhe', 'D', 1, 10, 4),
    ('ENGER', 'schmaler', 'D', 6, 10, 5)
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
    ('OHIO', 'Buckeye-Staat', 'A', 1, 1, 4),
    ('AULA', 'Versammlungssaal', 'A', 1, 7, 4),
    ('REH', 'Waldtier', 'A', 2, 1, 3),
    ('WARNEN', 'mahnen', 'A', 2, 5, 6),
    ('TURM', 'Bergfried', 'A', 3, 1, 4),
    ('LIMES', 'röm. Grenzwall', 'A', 3, 6, 5),
    ('AKTEUR', 'Mitspieler', 'A', 4, 4, 6),
    ('STEILE', 'abschüssige', 'A', 5, 1, 6),
    ('TEE', 'Aufguss', 'A', 5, 8, 3),
    ('URNE', 'Aschengefäß', 'A', 6, 2, 4),
    ('ARG', 'schlimm', 'A', 7, 1, 3),
    ('INS', 'in das', 'A', 7, 5, 3),
    ('UNI', 'Alma Mater', 'A', 8, 1, 3),
    ('DACHES', 'First des ...', 'A', 8, 5, 6),
    ('GENE', 'Erbanlagen', 'A', 9, 1, 4),
    ('SAALE', 'Fluss durch Halle', 'A', 9, 6, 5),
    ('ENG', 'knapp', 'A', 10, 1, 3),
    ('ERBTE', 'übernahm', 'A', 10, 6, 5),
    ('ORTES', 'Name des ...', 'D', 1, 1, 5),
    ('AUGE', 'Sehorgan', 'D', 7, 1, 4),
    ('HEU', 'Trockengras', 'D', 1, 2, 3),
    ('TURNEN', 'Gymnastik', 'D', 5, 2, 6),
    ('IHR', 'Pronomen (2. Pl.)', 'D', 1, 3, 3),
    ('ERGING', 'widerfuhr', 'D', 5, 3, 6),
    ('MAIN', 'Fluss in Hessen', 'D', 3, 4, 4),
    ('KLEID', 'Gewand', 'D', 4, 5, 5),
    ('ALTE', 'betagte', 'D', 2, 6, 4),
    ('NASE', 'Riechorgan', 'D', 7, 6, 4),
    ('ARIE', 'Opernlied', 'D', 1, 7, 4),
    ('OSCAR', 'Filmpreis', 'D', 6, 7, 5),
    ('UNMUT', 'Ärger', 'D', 1, 8, 5),
    ('HAB', '... und Gut', 'D', 8, 8, 3),
    ('LEERE', 'Öde', 'D', 1, 9, 5),
    ('ZELT', 'Pavillon', 'D', 7, 9, 4),
    ('ANS', 'an das', 'D', 1, 10, 3),
    ('SEE', 'Weiher', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r017-12x12-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r017-12x12-01', 'Rätsel 17 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('OPA', 'Großvater', 'A', 1, 1, 3),
    ('TOTE', 'Verstorbene', 'A', 1, 8, 4),
    ('BRUDER', 'Mönch', 'A', 2, 1, 6),
    ('OVAL', 'eiförmig', 'A', 2, 8, 4),
    ('LOS', 'ledig', 'A', 3, 1, 3),
    ('ANLAGE', 'Einrichtung', 'A', 3, 6, 6),
    ('BULLEN', 'Stiere', 'A', 4, 6, 6),
    ('GEBOTEN', 'nötig', 'A', 5, 1, 7),
    ('HERRN', 'Mister', 'A', 6, 2, 5),
    ('DESTO', 'umso', 'A', 7, 1, 5),
    ('NEFFE', 'Verwandter', 'A', 7, 7, 5),
    ('AST', 'Zweig', 'A', 8, 3, 3),
    ('IRREN', 'sich täuschen', 'A', 8, 7, 5),
    ('ENG', 'schmal', 'A', 9, 1, 3),
    ('ZOEGERT', 'zaudert', 'A', 9, 5, 7),
    ('NETZ', 'Geflecht', 'A', 10, 1, 4),
    ('FREUDE', 'Frohsinn', 'A', 10, 6, 6),
    ('TUE', 'mache', 'A', 11, 1, 3),
    ('TESTEN', 'prüfen', 'A', 11, 6, 6),
    ('OBLAG', 'war Pflicht', 'D', 1, 1, 5),
    ('DIENT', 'nützt', 'D', 7, 1, 5),
    ('PRO', 'je', 'D', 1, 2, 3),
    ('EHE', 'Bund fürs Leben', 'D', 5, 2, 3),
    ('NEU', 'frisch', 'D', 9, 2, 3),
    ('AUS', 'vorbei', 'D', 1, 3, 3),
    ('BESAGTE', 'erwähnte', 'D', 5, 3, 7),
    ('FORTS', 'Festungen', 'D', 4, 4, 5),
    ('TROTZ', 'Eigensinn', 'D', 5, 5, 5),
    ('GRABEN', 'Rinne', 'D', 1, 6, 6),
    ('OFT', 'häufig', 'D', 9, 6, 3),
    ('NUN', 'jetzt', 'D', 3, 7, 3),
    ('NIERE', 'Harnorgan', 'D', 7, 7, 5),
    ('TOLL', 'großartig', 'D', 1, 8, 4),
    ('BERGES', 'Gipfel des ...', 'D', 6, 8, 6),
    ('OVALE', 'eiförmige', 'D', 1, 9, 5),
    ('FREUT', 'beglückt', 'D', 7, 9, 5),
    ('TAGE', 'je 24 Stunden', 'D', 1, 10, 4),
    ('PFERDE', 'Rösser', 'D', 6, 10, 6),
    ('ELEND', 'Misere', 'D', 1, 11, 5),
    ('ENTEN', 'Schwimmvögel', 'D', 7, 11, 5)
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
    ('LAUB', 'Blätter', 'A', 1, 1, 4),
    ('ALTE', 'greise', 'A', 1, 8, 4),
    ('INNE', '... halten', 'A', 2, 1, 4),
    ('ALLEIN', 'einsam', 'A', 2, 6, 6),
    ('ERGIBT', 'resultiert', 'A', 3, 1, 6),
    ('LITT', 'duldete', 'A', 3, 8, 4),
    ('SEE', 'Weiher', 'A', 4, 1, 3),
    ('TEE', 'Aufguss', 'A', 4, 9, 3),
    ('SINN', 'Bedeutung', 'A', 5, 1, 4),
    ('KUGEL', 'Ball', 'A', 5, 6, 5),
    ('SAUNA', 'Schwitzbad', 'A', 6, 2, 5),
    ('ERST', 'anfangs', 'A', 6, 8, 4),
    ('TEUREN', 'kostbaren', 'A', 7, 1, 6),
    ('LOK', 'Zugmaschine', 'A', 8, 7, 3),
    ('PAAR', 'einige', 'A', 9, 1, 4),
    ('HITS', 'Schlager', 'A', 9, 8, 4),
    ('EUROPA', 'Erdteil', 'A', 10, 1, 6),
    ('REUE', 'Zerknirschung', 'A', 10, 8, 4),
    ('NETT', 'freundlich', 'A', 11, 1, 4),
    ('NETZEN', 'Geflechten', 'A', 11, 6, 6),
    ('LIESS', 'erlaubte', 'D', 1, 1, 5),
    ('TYPEN', 'Kerle', 'D', 7, 1, 5),
    ('ANREISE', 'Hinfahrt', 'D', 1, 2, 7),
    ('AUE', 'Talwiese', 'D', 9, 2, 3),
    ('UNGENAU', 'vage', 'D', 1, 3, 7),
    ('ART', 'Spezies', 'D', 9, 3, 3),
    ('BEI', 'nahe an', 'D', 1, 4, 3),
    ('NUR', 'bloß', 'D', 5, 4, 3),
    ('ROT', 'purpurn', 'D', 9, 4, 3),
    ('NEU', 'aktuell', 'D', 6, 5, 3),
    ('VATIKAN', 'Kirchenstaat', 'D', 1, 6, 7),
    ('RAN', 'heran', 'D', 9, 6, 3),
    ('ALL', 'Weltraum', 'D', 1, 8, 3),
    ('GEBOHRT', 'gedrillt', 'D', 5, 8, 7),
    ('LEITER', 'Chef', 'D', 1, 9, 6),
    ('KIEZ', 'Viertel', 'D', 8, 9, 4),
    ('TITELS', 'Gewinn des ...', 'D', 1, 10, 6),
    ('TUE', 'verrichte', 'D', 9, 10, 3),
    ('ENTE', 'Falschmeldung', 'D', 1, 11, 4),
    ('TRESEN', 'Theke', 'D', 6, 11, 6)
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
    ('SALAT', 'Rohkost', 'A', 1, 1, 5),
    ('ECHTE', 'authentische', 'A', 1, 7, 5),
    ('TRIKOTS', 'Sporthemden', 'A', 2, 1, 7),
    ('AUS', 'vorbei', 'A', 2, 9, 3),
    ('AESTE', 'Zweige', 'A', 3, 1, 5),
    ('INS', 'in das', 'A', 3, 9, 3),
    ('RAT', 'Tipp', 'A', 4, 1, 3),
    ('NAIV', 'arglos', 'A', 4, 5, 4),
    ('ENG', 'knapp', 'A', 5, 5, 3),
    ('YEN', 'Nippon-Währung', 'A', 5, 9, 3),
    ('ESEL', 'Grautier', 'A', 6, 1, 4),
    ('UEBERS', 'über das', 'A', 7, 5, 6),
    ('WOG', 'schwankte', 'A', 8, 1, 3),
    ('FRISEUR', 'Coiffeur', 'A', 8, 5, 7),
    ('EBENE', 'Flachland', 'A', 9, 1, 5),
    ('STADE', 'Elbhafen', 'A', 9, 7, 5),
    ('GEHIRNS', 'Teil des ...', 'A', 10, 1, 7),
    ('LAS', 'schmökerte', 'A', 10, 9, 3),
    ('ENTEN', 'Schwimmvögel', 'A', 11, 1, 5),
    ('CENT', 'Hundertstel Euro', 'A', 11, 8, 4),
    ('STAR', 'Berühmtheit', 'D', 1, 1, 4),
    ('WEGE', 'Routen', 'D', 8, 1, 4),
    ('AREALS', 'Größe des ...', 'D', 1, 2, 6),
    ('OBEN', 'in der Höhe', 'D', 8, 2, 4),
    ('LIST', 'Trick', 'D', 1, 3, 4),
    ('ERGEHT', 'widerfährt', 'D', 6, 3, 6),
    ('AKT', 'Aufzug', 'D', 1, 4, 3),
    ('NIE', 'zu keiner Zeit', 'D', 9, 4, 3),
    ('TOENE', 'Klänge', 'D', 1, 5, 5),
    ('UFERN', 'Gestaden', 'D', 7, 5, 5),
    ('ANKER', 'Halt', 'D', 4, 6, 5),
    ('ESSIG', 'Würzmittel', 'D', 1, 7, 5),
    ('BISS', 'Schneid', 'D', 7, 7, 4),
    ('PEST', 'Seuche', 'D', 6, 8, 4),
    ('HAI', 'Meeresräuber', 'D', 1, 9, 3),
    ('REALE', 'wirkliche', 'D', 7, 9, 5),
    ('TUN', 'machen', 'D', 1, 10, 3),
    ('SUDAN', 'Staat am Nil', 'D', 7, 10, 5),
    ('ESSENZ', 'Kern', 'D', 1, 11, 6),
    ('REST', 'Residuum', 'D', 8, 11, 4)
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
    ('FRISUREN', 'Haarschnitte', 'A', 1, 1, 8),
    ('IHNEN', 'Pronomen', 'A', 2, 1, 5),
    ('RAT', 'Tipp', 'A', 2, 7, 3),
    ('LENKT', 'steuert', 'A', 3, 1, 5),
    ('ZEUGT', 'zeigt von', 'A', 3, 7, 5),
    ('MIETE', 'Pacht', 'A', 4, 1, 5),
    ('HEER', 'Armee', 'A', 4, 8, 4),
    ('EROBERTE', 'nahm ein', 'A', 5, 4, 8),
    ('KAM', 'traf ein', 'A', 6, 9, 3),
    ('RIO', 'Zuckerhut-Stadt', 'A', 7, 2, 3),
    ('WAREN', 'Verbform', 'A', 7, 6, 5),
    ('HELM', 'Kopfschutz', 'A', 8, 1, 4),
    ('AUE', 'Wiesenland', 'A', 8, 6, 3),
    ('ABLAUF', 'Hergang', 'A', 9, 1, 6),
    ('IDEE', 'Einfall', 'A', 9, 8, 4),
    ('SEI', 'existiere', 'A', 10, 1, 3),
    ('SEIT', 'ab', 'A', 10, 8, 4),
    ('ENGE', 'schmale', 'A', 11, 1, 4),
    ('EBENSO', 'gleichfalls', 'A', 11, 6, 6),
    ('FILM', 'Movie', 'D', 1, 1, 4),
    ('HASE', 'Meister Lampe', 'D', 8, 1, 4),
    ('RHEIN', 'dt. Strom', 'D', 1, 2, 5),
    ('REBEN', 'Weinstöcke', 'D', 7, 2, 5),
    ('INNE', 'Verbpartikel', 'D', 1, 3, 4),
    ('BILLIG', 'preiswert', 'D', 6, 3, 6),
    ('SEKTE', 'Kult', 'D', 1, 4, 5),
    ('OMA', 'Großmutter', 'D', 7, 4, 3),
    ('UNTERE', 'tiefere', 'D', 1, 5, 6),
    ('WAFFE', 'Kampfmittel', 'D', 7, 6, 5),
    ('ERZ', 'Gestein', 'D', 1, 7, 3),
    ('BLAU', 'himmelfarben', 'D', 5, 7, 4),
    ('NAEHE', 'Umgebung', 'D', 1, 8, 5),
    ('REISE', 'Fahrt', 'D', 7, 8, 5),
    ('TUERKE', 'Anatolier', 'D', 2, 9, 6),
    ('DEN', 'Artikel (Akkusativ)', 'D', 9, 9, 3),
    ('GETAN', 'gemacht', 'D', 3, 10, 5),
    ('EIS', 'Gefrorenes', 'D', 9, 10, 3),
    ('EXTREM', 'äußerst', 'D', 1, 11, 6),
    ('VETO', 'Einspruch', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r021-13x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r021-13x13-01', 'Rätsel 21 · 13×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '13x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('OPA', 'Großvater', 'A', 1, 1, 3),
    ('TUE', 'verrichte', 'A', 1, 5, 3),
    ('ALLE', 'sämtliche', 'A', 1, 9, 4),
    ('RAUB', 'Diebstahl', 'A', 2, 1, 4),
    ('FINNE', 'Rückenflosse', 'A', 2, 6, 5),
    ('TREIBEN', 'schwimmen', 'A', 3, 1, 7),
    ('SITZ', 'Stuhl', 'A', 3, 9, 4),
    ('TARIF', 'Gebühr', 'A', 4, 4, 5),
    ('HIN', 'fort', 'A', 5, 1, 3),
    ('UNGEMEIN', 'enorm', 'A', 5, 5, 8),
    ('ETAGE', 'Stockwerk', 'A', 6, 1, 5),
    ('EIER', 'Gelege', 'A', 6, 7, 4),
    ('BUS', 'Nahverkehrsmittel', 'A', 7, 1, 3),
    ('ESSEN', 'Ruhrgebietsstadt', 'A', 7, 8, 5),
    ('ERST', 'anfangs', 'A', 8, 1, 4),
    ('VERS', 'Reim', 'A', 8, 6, 4),
    ('ECHO', 'Widerhall', 'A', 9, 9, 4),
    ('BALANCE', 'Ausgleich', 'A', 10, 2, 7),
    ('LOS', 'frei', 'A', 10, 10, 3),
    ('WILLST', 'möchtest', 'A', 11, 1, 6),
    ('ALL', 'Weltraum', 'A', 11, 10, 3),
    ('STETS', 'immer', 'A', 12, 2, 5),
    ('KONTO', 'Guthaben', 'A', 12, 8, 5),
    ('ORT', 'Stelle', 'D', 1, 1, 3),
    ('HEBEL', 'Griff', 'D', 5, 1, 5),
    ('PARTITUR', 'Notenblatt', 'D', 1, 2, 8),
    ('BIS', 'nicht später als', 'D', 10, 2, 3),
    ('AUE', 'Wiesenland', 'D', 1, 3, 3),
    ('NASS', 'feucht', 'D', 5, 3, 4),
    ('ALT', 'betagt', 'D', 10, 3, 3),
    ('BIT', 'Binärziffer', 'D', 2, 4, 3),
    ('TOLLE', 'großartige', 'D', 8, 4, 5),
    ('BAUE', 'errichte', 'D', 3, 5, 4),
    ('AST', 'Zweig', 'D', 10, 5, 3),
    ('UFERN', 'Gestaden', 'D', 1, 6, 5),
    ('EVENTS', 'Anlässe', 'D', 7, 6, 6),
    ('EINIGE', 'manche', 'D', 1, 7, 6),
    ('FEIER', 'Fest', 'D', 4, 8, 5),
    ('ECK', 'Winkel', 'D', 10, 8, 3),
    ('ANS', 'an das', 'D', 1, 9, 3),
    ('MESSE', 'Gottesdienst', 'D', 5, 9, 5),
    ('LEITERS', 'Chefs', 'D', 1, 10, 7),
    ('CLAN', 'Sippe', 'D', 9, 10, 4),
    ('ERHOLT', 'ausgeruht', 'D', 7, 11, 6),
    ('ERZ', 'Gestein', 'D', 1, 12, 3),
    ('NUN', 'inzwischen', 'D', 5, 12, 3),
    ('OSLO', 'norw. Hauptstadt', 'D', 9, 12, 4)
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
    ('VERLASSE', 'gehe weg', 'A', 1, 1, 8),
    ('LOB', 'Kompliment', 'A', 1, 10, 3),
    ('EILTE', 'hastete', 'A', 2, 3, 5),
    ('LIVE', 'direkt', 'A', 2, 9, 4),
    ('GEBURT', 'Entbindung', 'A', 3, 3, 6),
    ('MAI', '5. Monat', 'A', 3, 10, 3),
    ('GRAB', 'Gruft', 'A', 4, 1, 4),
    ('NIEMALS', 'nimmermehr', 'A', 4, 6, 7),
    ('EILE', 'Hektik', 'A', 5, 1, 4),
    ('DEMO', 'Kundgebung', 'A', 5, 6, 4),
    ('HOERTE', 'lauschte', 'A', 6, 1, 6),
    ('PRO', 'per', 'A', 6, 8, 3),
    ('FEDERN', 'Gefieder', 'A', 7, 7, 6),
    ('FELD', 'Acker', 'A', 8, 3, 4),
    ('TRAILER', 'Vorschau', 'A', 9, 1, 7),
    ('STIL', 'Machart', 'A', 9, 9, 4),
    ('RAHMEN', 'Einfassung', 'A', 10, 1, 6),
    ('WAERE', 'sei', 'A', 10, 8, 5),
    ('INNERER', 'interner', 'A', 11, 1, 7),
    ('GRAS', 'Rasen', 'A', 11, 9, 4),
    ('ODER', 'bzw.', 'A', 12, 1, 4),
    ('MASKE', 'Larve', 'A', 12, 8, 5),
    ('VERGEHT', 'verstreicht', 'D', 1, 1, 7),
    ('TRIO', 'Dreiergruppe', 'D', 9, 1, 4),
    ('RIO', 'Stadt in Brasilien', 'D', 4, 2, 3),
    ('RAND', 'Kante', 'D', 9, 2, 4),
    ('REGALE', 'Borde', 'D', 1, 3, 6),
    ('FAHNE', 'Flagge', 'D', 8, 3, 5),
    ('LIEBER', 'eher', 'D', 1, 4, 6),
    ('EIMER', 'Kübel', 'D', 8, 4, 5),
    ('ALB', 'Gebirge', 'D', 1, 5, 3),
    ('TELLER', 'Platte', 'D', 6, 5, 6),
    ('STUNDE', '60 Minuten', 'D', 1, 6, 6),
    ('DENEN', 'Relativ (Dat. Pl.)', 'D', 8, 6, 5),
    ('SERIE', 'Reihe', 'D', 1, 7, 5),
    ('TEMPEL', 'Heiligtum', 'D', 3, 8, 6),
    ('MORD', 'Tötung', 'D', 4, 9, 4),
    ('SAGA', 'Heldensage', 'D', 9, 9, 4),
    ('LIMA', 'peruan. Hauptstadt', 'D', 1, 10, 4),
    ('OEFTERS', 'häufig', 'D', 6, 10, 7),
    ('OVAL', 'eiförmig', 'D', 1, 11, 4),
    ('IRAK', 'Zweistromland', 'D', 9, 11, 4),
    ('BEISSEN', 'schnappen', 'D', 1, 12, 7),
    ('LESE', 'studiere', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r023-13x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r023-13x13-03', 'Rätsel 23 · 13×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '13x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('WEIT', 'fern', 'A', 1, 1, 4),
    ('KUH', 'Rind', 'A', 1, 6, 3),
    ('ARG', 'schlimm', 'A', 1, 10, 3),
    ('EIN', 'unbest. Artikel', 'A', 2, 1, 3),
    ('FORUMS', 'Mitglied des ...', 'A', 2, 5, 6),
    ('GETRENNT', 'geschieden', 'A', 3, 1, 8),
    ('ICH', 'Pronomen (1. Sg.)', 'A', 3, 10, 3),
    ('REISTE', 'fuhr', 'A', 4, 2, 6),
    ('NAHE', 'dicht bei', 'A', 4, 9, 4),
    ('ROTE', 'purpurne', 'A', 5, 3, 4),
    ('TAG', '24 Stunden', 'A', 5, 10, 3),
    ('RAN', 'heran', 'A', 6, 1, 3),
    ('NAEHERE', 'das Genauere', 'A', 6, 6, 7),
    ('SUESS', 'zuckrig', 'A', 7, 1, 5),
    ('DIENT', 'nützt', 'A', 7, 7, 5),
    ('CENT', 'Hundertstel Euro', 'A', 8, 1, 4),
    ('FREI', 'kostenlos', 'A', 8, 6, 4),
    ('ERLEBT', 'erfahren', 'A', 9, 7, 6),
    ('ORTE', 'Plätze', 'A', 10, 1, 4),
    ('AST', 'Knorren', 'A', 10, 6, 3),
    ('BAU', 'Gebäude', 'A', 10, 10, 3),
    ('SAUNA', 'Schwitzbad', 'A', 11, 1, 5),
    ('SELBER', 'persönlich', 'A', 11, 7, 6),
    ('STEG', 'Brücklein', 'A', 12, 1, 4),
    ('YEN', 'Nippon-Währung', 'A', 12, 6, 3),
    ('ERZ', 'Bodenschatz', 'A', 12, 10, 3),
    ('WEG', 'Route', 'D', 1, 1, 3),
    ('ERSCHOSS', 'tötete', 'D', 5, 1, 8),
    ('EIER', 'Gelege', 'D', 1, 2, 4),
    ('AUE', 'Talwiese', 'D', 6, 2, 3),
    ('RAT', 'Gremium', 'D', 10, 2, 3),
    ('INTERNEN', 'inneren', 'D', 1, 3, 8),
    ('TUE', 'verrichte', 'D', 10, 3, 3),
    ('RIO', 'Stadt in Brasilien', 'D', 3, 4, 3),
    ('STRENG', 'rigoros', 'D', 7, 4, 6),
    ('FEST', 'solide', 'D', 2, 5, 4),
    ('KONTEN', 'Guthaben', 'D', 1, 6, 6),
    ('URNE', 'Wahlbehälter', 'D', 1, 7, 4),
    ('ADRESSE', 'Anschrift', 'D', 6, 7, 7),
    ('HUT', 'Vorsicht', 'D', 1, 8, 3),
    ('FEIERTEN', 'zelebrierten', 'D', 5, 8, 8),
    ('HEIL', 'Wohl', 'D', 6, 9, 4),
    ('ASIATEN', 'Orientalen', 'D', 1, 10, 7),
    ('EBBE', 'Gegenteil der Flut', 'D', 9, 10, 4),
    ('CHART', 'Diagramm', 'D', 3, 11, 5),
    ('BAER', 'Raubtier', 'D', 9, 11, 4),
    ('GEHEGE', 'Käfig', 'D', 1, 12, 6),
    ('STURZ', 'Fall', 'D', 8, 12, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r024-15x15-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r024-15x15-01', 'Rätsel 24 · 15×15', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '15x15-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('GAGE', 'Salär', 'A', 1, 1, 4),
    ('ANS', 'an das', 'A', 1, 6, 3),
    ('SAGTE', 'äußerte', 'A', 1, 10, 5),
    ('EREILTE', 'traf', 'A', 2, 1, 7),
    ('POLE', 'Slawe', 'A', 2, 9, 4),
    ('LEGE', 'platziere', 'A', 3, 1, 4),
    ('MUT', 'Courage', 'A', 3, 6, 3),
    ('LINKS', 'nicht rechts', 'A', 3, 10, 5),
    ('ENORME', 'gewaltige', 'A', 4, 1, 6),
    ('OBERE', 'höhere', 'A', 4, 10, 5),
    ('GAS', 'Brennstoff', 'A', 5, 1, 3),
    ('UNTER', 'inmitten', 'A', 5, 5, 5),
    ('OMA', 'Omi', 'A', 6, 12, 3),
    ('REGIME', 'Herrschaft', 'A', 7, 2, 6),
    ('LABELS', 'Etiketten', 'A', 7, 9, 6),
    ('MAN', 'Pronomen', 'A', 8, 1, 3),
    ('KARNEVAL', 'Fasching', 'A', 8, 5, 8),
    ('WEG', 'Route', 'A', 9, 4, 3),
    ('ROT', 'knallig', 'A', 9, 9, 3),
    ('UMHER', 'herum', 'A', 10, 1, 5),
    ('KANN', 'vermag', 'A', 10, 7, 4),
    ('NEID', 'Missgunst', 'A', 11, 1, 4),
    ('KALT', 'frostig', 'A', 11, 6, 4),
    ('GLAS', 'Trinkgefäß', 'A', 11, 11, 4),
    ('INTERNET', 'Netz', 'A', 12, 1, 8),
    ('BEIDE', 'Zahlwort', 'A', 12, 10, 5),
    ('REISE', 'Fahrt', 'A', 13, 4, 5),
    ('UNTEN', 'am Grund', 'A', 13, 10, 5),
    ('NUR', 'lediglich', 'A', 14, 1, 3),
    ('HEERES', 'Führung des ...', 'A', 14, 5, 6),
    ('ELF', 'Zahl (10+1)', 'A', 14, 12, 3),
    ('GELEGT', 'platziert', 'D', 1, 1, 6),
    ('UNION', 'Bündnis', 'D', 10, 1, 5),
    ('ARENA', 'Stadion', 'D', 1, 2, 5),
    ('RAHMEN', 'Einfassung', 'D', 7, 2, 6),
    ('GEGOSSEN', 'bewässert', 'D', 1, 3, 8),
    ('HIT', 'Schlager', 'D', 10, 3, 3),
    ('EIER', 'Gelege', 'D', 1, 4, 4),
    ('WEDER', '... noch', 'D', 9, 4, 5),
    ('MUSIKER', 'Spielmann', 'D', 4, 5, 7),
    ('REH', 'Waldtier', 'D', 12, 5, 3),
    ('ATMEN', 'Luft holen', 'D', 1, 6, 5),
    ('MAG', 'liebt', 'D', 7, 6, 3),
    ('KNIE', 'Scharniergelenk', 'D', 11, 6, 4),
    ('NEU', 'frisch', 'D', 1, 7, 3),
    ('TUER', 'Pforte', 'D', 5, 7, 4),
    ('KAESE', 'Milchprodukt', 'D', 10, 7, 5),
    ('TEE', 'Aufguss', 'D', 3, 8, 3),
    ('ALTER', 'Lebensjahre', 'D', 10, 8, 5),
    ('LERNT', 'paukt', 'D', 7, 9, 5),
    ('SOLO', 'allein', 'D', 1, 10, 4),
    ('DAVON', 'hieraus', 'D', 6, 10, 5),
    ('BUS', 'Nahverkehrsmittel', 'D', 12, 10, 3),
    ('ALIBI', 'Entlastung', 'D', 1, 11, 5),
    ('BAT', 'ersuchte', 'D', 7, 11, 3),
    ('GEN', 'nach', 'D', 11, 11, 3),
    ('GENE', 'Erbanlagen', 'D', 1, 12, 4),
    ('OEL', 'Schmierstoff', 'D', 6, 12, 3),
    ('ELITE', 'Auslese', 'D', 10, 12, 5),
    ('KREML', 'Moskauer Burg', 'D', 3, 13, 5),
    ('ADEL', 'blaues Blut', 'D', 11, 13, 4),
    ('ESSE', 'speise', 'D', 1, 14, 4),
    ('ASYL', 'Unterschlupf', 'D', 6, 14, 4),
    ('SENF', 'Mostrich', 'D', 11, 14, 4)
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
    ('ANGST', 'Furcht', 'A', 1, 1, 5),
    ('AMTES', 'Ende des ...', 'A', 1, 10, 5),
    ('HEU', 'Viehfutter', 'A', 2, 1, 3),
    ('ROSE', 'Blume mit Dornen', 'A', 2, 5, 4),
    ('LAUNE', 'Stimmung', 'A', 2, 10, 5),
    ('NUTZE', 'verwende', 'A', 3, 1, 5),
    ('KABINETT', 'Regierung', 'A', 3, 7, 8),
    ('EINSAM', 'verlassen', 'A', 4, 3, 6),
    ('EDEL', 'vornehm', 'A', 5, 4, 4),
    ('ISST', 'verzehrt', 'A', 5, 9, 4),
    ('POOL', 'Becken', 'A', 6, 1, 4),
    ('LAG', 'ruhte', 'A', 6, 6, 3),
    ('TABU', 'verboten', 'A', 6, 11, 4),
    ('ULM', 'Einstein-Geburtsstadt', 'A', 7, 1, 3),
    ('SOGAR', 'gar', 'A', 7, 10, 5),
    ('NIE', 'nimmer', 'A', 8, 1, 3),
    ('BESTE', 'optimale', 'A', 8, 5, 5),
    ('PER', 'via', 'A', 8, 11, 3),
    ('KENIA', 'Staat in Ostafrika', 'A', 9, 1, 5),
    ('TIPP', 'Hinweis', 'A', 9, 8, 4),
    ('HUND', 'Vierbeiner', 'A', 10, 4, 4),
    ('GAB', 'schenkte', 'A', 10, 12, 3),
    ('JENSEITS', 'drüben', 'A', 11, 2, 8),
    ('LEBE', 'existiere', 'A', 11, 11, 4),
    ('KUR', 'Heilaufenthalt', 'A', 12, 1, 3),
    ('TUN', 'machen', 'A', 12, 5, 3),
    ('EHEN', 'Bündnisse', 'A', 12, 11, 4),
    ('ANSTIEG', 'Zunahme', 'A', 13, 1, 7),
    ('TUGEND', 'Moral', 'A', 13, 9, 6),
    ('MIT', 'samt', 'A', 14, 1, 3),
    ('ERZ', 'Gestein', 'A', 14, 7, 3),
    ('ENDE', 'Finale', 'A', 14, 11, 4),
    ('AHNT', 'vermutet', 'D', 1, 1, 4),
    ('PUNKT', 'Tupfen', 'D', 6, 1, 5),
    ('KAM', 'traf ein', 'D', 12, 1, 3),
    ('NEU', 'aktuell', 'D', 1, 2, 3),
    ('FOLIE', 'Film', 'D', 5, 2, 5),
    ('JUNI', 'Sommerbeginn', 'D', 11, 2, 4),
    ('GUTE', 'prima', 'D', 1, 3, 4),
    ('OMEN', 'Vorbote', 'D', 6, 3, 4),
    ('ERST', 'anfangs', 'D', 11, 3, 4),
    ('ZIEL', 'Zweck', 'D', 3, 4, 4),
    ('IHN', 'Akkusativ von er', 'D', 9, 4, 3),
    ('TREND', 'Tendenz', 'D', 1, 5, 5),
    ('BAUSTIL', 'Architektur', 'D', 8, 5, 7),
    ('SELBE', 'gleiche', 'D', 4, 6, 5),
    ('NEUE', 'frische', 'D', 10, 6, 4),
    ('SKALA', 'Stufenleiter', 'D', 2, 7, 5),
    ('DINGE', 'Sachen', 'D', 10, 7, 5),
    ('TEAM', 'Crew', 'D', 1, 8, 4),
    ('GOTT', 'Schöpfer', 'D', 6, 8, 4),
    ('EINSATZ', 'Investition', 'D', 8, 9, 7),
    ('ALIAS', 'auch genannt', 'D', 1, 10, 5),
    ('MAN', 'Pronomen', 'D', 1, 11, 3),
    ('STOPP', 'Halt', 'D', 5, 11, 5),
    ('LEGE', 'platziere', 'D', 11, 11, 4),
    ('TUE', 'mache', 'D', 1, 12, 3),
    ('TAGE', 'je 24 Stunden', 'D', 5, 12, 4),
    ('GEHEN', 'schreiten', 'D', 10, 12, 5),
    ('ENTE', 'Falschmeldung', 'D', 1, 13, 4),
    ('BAR', 'Lokal', 'D', 6, 13, 3),
    ('ABEND', 'Tagesende', 'D', 10, 13, 5),
    ('SET', 'Ausstattung', 'D', 1, 14, 3),
    ('PUR', 'unverfälscht', 'D', 5, 14, 3),
    ('ABENDE', 'Soireen', 'D', 9, 14, 6)
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
    ('ESSAY', 'Aufsatz', 'A', 1, 1, 5),
    ('GUTHABEN', 'Kontostand', 'A', 1, 7, 8),
    ('TEAM', 'Mannschaft', 'A', 2, 1, 4),
    ('MEHR', 'obendrein', 'A', 2, 6, 4),
    ('WEGE', 'Pfade', 'A', 3, 1, 4),
    ('IHRE', 'seine', 'A', 3, 6, 4),
    ('GASE', 'Dämpfe', 'A', 3, 11, 4),
    ('ANTRITT', 'Beginn', 'A', 4, 1, 7),
    ('LAS', 'entzifferte', 'A', 4, 12, 3),
    ('BITS', 'Binärziffern', 'A', 5, 11, 4),
    ('IRAK', 'Zweistromland', 'A', 6, 1, 4),
    ('ASS', 'speiste', 'A', 6, 6, 3),
    ('LEBTE', 'existierte', 'A', 6, 10, 5),
    ('HEBAMME', 'Wehmutter', 'A', 7, 1, 7),
    ('SOWIE', 'und', 'A', 7, 9, 5),
    ('RAT', 'Tipp', 'A', 8, 1, 3),
    ('ATTACKE', 'Angriff', 'A', 8, 5, 7),
    ('GERA', 'Stadt in Thüringen', 'A', 9, 11, 4),
    ('STIEG', 'kletterte', 'A', 10, 1, 5),
    ('OMA', 'Omi', 'A', 10, 7, 3),
    ('TRAF', 'kreuzte', 'A', 10, 11, 4),
    ('TOD', 'Ableben', 'A', 11, 1, 3),
    ('ERHOLT', 'ausgeruht', 'A', 11, 5, 6),
    ('FEE', 'Zauberin', 'A', 11, 12, 3),
    ('AREAL', 'Gelände', 'A', 12, 1, 5),
    ('ROT', 'knallig', 'A', 12, 7, 3),
    ('DANN', 'daraufhin', 'A', 12, 11, 4),
    ('ALTAERE', 'Opfertische', 'A', 13, 3, 7),
    ('ENG', 'schmal', 'A', 13, 11, 3),
    ('TOLLE', 'großartige', 'A', 14, 1, 5),
    ('RUNDEN', 'Durchgänge', 'A', 14, 9, 6),
    ('ETWA', 'ungefähr', 'D', 1, 1, 4),
    ('IHR', 'Pronomen (2. Pl.)', 'D', 6, 1, 3),
    ('STADT', 'Kommune', 'D', 10, 1, 5),
    ('SEEN', 'Wasserflächen', 'D', 1, 2, 4),
    ('REAKTOR', 'Meiler', 'D', 6, 2, 7),
    ('SAGT', 'äußert', 'D', 1, 3, 4),
    ('ABT', 'Ordensoberer', 'D', 6, 3, 3),
    ('IDEAL', 'Leitbild', 'D', 10, 3, 5),
    ('AMERIKA', 'Neue Welt', 'D', 1, 4, 7),
    ('ALL', 'Weltraum', 'D', 12, 4, 3),
    ('MANGELTE', 'fehlte', 'D', 7, 5, 8),
    ('MITSAMT', 'nebst', 'D', 2, 6, 7),
    ('GEHT', 'läuft', 'D', 1, 7, 4),
    ('SET', 'Ausstattung', 'D', 6, 7, 3),
    ('OHREN', 'Hörorgane', 'D', 10, 7, 5),
    ('UHR', 'Zeitmesser', 'D', 1, 8, 3),
    ('MOOR', 'Sumpf', 'D', 10, 8, 4),
    ('TREU', 'anhänglich', 'D', 1, 9, 4),
    ('SCHALTER', 'Knopf', 'D', 7, 9, 8),
    ('LOK', 'Zugmaschine', 'D', 6, 10, 3),
    ('ARG', 'schlimm', 'D', 1, 11, 3),
    ('BEWEGT', 'gerührt', 'D', 5, 11, 6),
    ('DEN', 'Artikel (Akkusativ)', 'D', 12, 11, 3),
    ('ALIBI', 'Entlastung', 'D', 3, 12, 5),
    ('ERFAND', 'ersann', 'D', 9, 12, 6),
    ('SATTE', 'volle', 'D', 3, 13, 5),
    ('RAENGE', 'Tribünen', 'D', 9, 13, 6),
    ('NUESSE', 'Kerne', 'D', 1, 14, 6),
    ('HAFEN', 'Anlegeplatz', 'D', 8, 14, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r027-8x8-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r027-8x8-01', 'Rätsel 27 · 8×8', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '8x8-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('STUR', 'starrsinnig', 'A', 1, 1, 4),
    ('ERHALT', 'Empfang', 'A', 2, 1, 6),
    ('TURNER', 'Gymnast', 'A', 3, 1, 6),
    ('DIAS', 'Lichtbilder', 'A', 4, 4, 4),
    ('OPA', 'Großvater', 'A', 5, 1, 3),
    ('TUT', 'verrichtet', 'A', 5, 5, 3),
    ('KAEME', 'nahte', 'A', 6, 3, 5),
    ('TAT', 'Handlung', 'A', 7, 1, 3),
    ('TAG', '24 Stunden', 'A', 7, 5, 3),
    ('SET', 'Satz', 'D', 1, 1, 3),
    ('OFT', 'des Öfteren', 'D', 5, 1, 3),
    ('TRUPP', 'Schar', 'D', 1, 2, 5),
    ('UHR', 'Chronometer', 'D', 1, 3, 3),
    ('AKT', 'Nacktgemälde', 'D', 5, 3, 3),
    ('RAND', 'Kante', 'D', 1, 4, 4),
    ('LEITET', 'führt', 'D', 2, 5, 6),
    ('TRAUMA', 'Schock', 'D', 2, 6, 6),
    ('STEG', 'Bootsanleger', 'D', 4, 7, 4)
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
    ('DRIN', 'innen', 'A', 1, 4, 4),
    ('SOFIA', 'bulg. Hauptstadt', 'A', 2, 1, 5),
    ('OHREN', 'Hörorgane', 'A', 3, 1, 5),
    ('BEIN', 'Stelze', 'A', 4, 1, 4),
    ('STARS', 'Prominente', 'A', 5, 3, 5),
    ('UEBTE', 'trainierte', 'A', 6, 3, 5),
    ('DAR', 'stellt ... (zeigt)', 'A', 7, 1, 3),
    ('TEE', 'Heißgetränk', 'A', 7, 5, 3),
    ('SOBALD', 'wenn', 'D', 2, 1, 6),
    ('HOHE', 'große', 'D', 1, 2, 4),
    ('FRISUR', 'Haarschnitt', 'D', 2, 3, 6),
    ('DIENTE', 'nützte', 'D', 1, 4, 6),
    ('RAN', 'hinzu', 'D', 1, 5, 3),
    ('ABT', 'Klosterchef', 'D', 5, 5, 3),
    ('ORTE', 'Stellen', 'D', 4, 6, 4),
    ('NAH', 'unweit', 'D', 1, 7, 3),
    ('SEE', 'Weiher', 'D', 5, 7, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r029-8x8-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r029-8x8-03', 'Rätsel 29 · 8×8', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '8x8-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('PAPIER', 'Dokument', 'A', 1, 1, 6),
    ('MEDIEN', 'Presse', 'A', 2, 2, 6),
    ('STRENG', 'rigoros', 'A', 3, 1, 6),
    ('EINE', 'unbest. Artikel (w.)', 'A', 4, 4, 4),
    ('HAI', 'Meeresräuber', 'A', 5, 1, 3),
    ('GEN', 'Erbanlage', 'A', 5, 5, 3),
    ('NUN', 'jetzt', 'A', 6, 1, 3),
    ('ENG', 'knapp', 'A', 6, 5, 3),
    ('ESSE', 'verspeise', 'A', 7, 1, 4),
    ('SAHNE', 'Rahm', 'D', 3, 1, 5),
    ('AMT', 'Dienststelle', 'D', 1, 2, 3),
    ('AUS', 'vorbei', 'D', 5, 2, 3),
    ('PER', 'via', 'D', 1, 3, 3),
    ('INS', 'in das', 'D', 5, 3, 3),
    ('IDEE', 'Gedanke', 'D', 1, 4, 4),
    ('EINIGE', 'diverse', 'D', 1, 5, 6),
    ('REGNEN', 'gießen', 'D', 1, 6, 6),
    ('ENGE', 'knappe', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r030-9x9-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r030-9x9-01', 'Rätsel 30 · 9×9', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x9-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('MAIS', 'Kukuruz', 'A', 1, 1, 4),
    ('OHR', 'Lauscher', 'A', 1, 6, 3),
    ('AURA', 'Fluidum', 'A', 2, 1, 4),
    ('FEE', 'Elfe', 'A', 2, 6, 3),
    ('STAR', 'Berühmtheit', 'A', 3, 1, 4),
    ('TUN', 'verrichten', 'A', 3, 6, 3),
    ('SONG', 'Lied', 'A', 4, 1, 4),
    ('HOSE', 'Beinkleid', 'A', 5, 5, 4),
    ('VORDERE', 'frontale', 'A', 6, 1, 7),
    ('EREILTE', 'traf', 'A', 7, 1, 7),
    ('THEMEN', 'Gegenstände', 'A', 8, 2, 6),
    ('MASSIVE', 'wuchtige', 'D', 1, 1, 7),
    ('AUTO', 'Pkw', 'D', 1, 2, 4),
    ('ORT', 'Stelle', 'D', 6, 2, 3),
    ('IRAN', 'Persien', 'D', 1, 3, 4),
    ('REH', 'Waldtier', 'D', 6, 3, 3),
    ('SARG', 'Totenschrein', 'D', 1, 4, 4),
    ('DIE', 'Artikel (weibl.)', 'D', 6, 4, 3),
    ('HELM', 'Kopfschutz', 'D', 5, 5, 4),
    ('OFT', 'häufig', 'D', 1, 6, 3),
    ('ORTE', 'Plätze', 'D', 5, 6, 4),
    ('HEU', 'Viehfutter', 'D', 1, 7, 3),
    ('SEEN', 'Gewässer', 'D', 5, 7, 4),
    ('RENTE', 'Pension', 'D', 1, 8, 5)
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
    ('UMSO', 'desto', 'A', 1, 1, 4),
    ('AKT', 'Nacktgemälde', 'A', 1, 6, 3),
    ('NAEHE', 'Umgebung', 'A', 2, 1, 5),
    ('INTRIGE', 'Ränkespiel', 'A', 3, 1, 7),
    ('NEST', 'Kobel', 'A', 4, 5, 4),
    ('SODASS', 'damit', 'A', 5, 1, 6),
    ('TEIL', 'Stück', 'A', 6, 1, 4),
    ('ENG', 'schmal', 'A', 6, 6, 3),
    ('EDEL', 'vornehm', 'A', 7, 1, 4),
    ('TEE', 'Heißgetränk', 'A', 7, 6, 3),
    ('GEBE', 'reiche', 'A', 8, 1, 4),
    ('ZUR', 'zu der', 'A', 8, 6, 3),
    ('UNI', 'Hochschule', 'D', 1, 1, 3),
    ('STEG', 'Brücklein', 'D', 5, 1, 4),
    ('MAN', 'jemand', 'D', 1, 2, 3),
    ('OEDE', 'langweilig', 'D', 5, 2, 4),
    ('SET', 'Ausstattung', 'D', 1, 3, 3),
    ('DIEB', 'Langfinger', 'D', 5, 3, 4),
    ('OHR', 'Hörorgan', 'D', 1, 4, 3),
    ('ALLE', 'sämtliche', 'D', 5, 4, 4),
    ('EINS', 'Zahl (2−1)', 'D', 2, 5, 4),
    ('GESETZ', 'Vorschrift', 'D', 3, 6, 6),
    ('KIES', 'Schotter', 'D', 1, 7, 4),
    ('NEU', 'frisch', 'D', 6, 7, 3),
    ('TIGER', 'Großkatze', 'D', 4, 8, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r032-9x9-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r032-9x9-03', 'Rätsel 32 · 9×9', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '9x9-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('SAUM', 'Rand', 'A', 1, 1, 4),
    ('ALT', 'ergraut', 'A', 1, 6, 3),
    ('ECHO', 'Widerhall', 'A', 2, 1, 4),
    ('BAU', 'Konstruktion', 'A', 2, 6, 3),
    ('EHRT', 'zollt Respekt', 'A', 3, 1, 4),
    ('GUT', 'brauchbar', 'A', 3, 6, 3),
    ('TRAF', 'begegnete', 'A', 4, 4, 4),
    ('MOEBEL', 'Einrichtung', 'A', 5, 3, 6),
    ('OMA', 'Omi', 'A', 6, 1, 3),
    ('GENE', 'Erbanlagen', 'A', 6, 5, 4),
    ('GAR', 'völlig', 'A', 7, 1, 3),
    ('ENDE', 'Finale', 'A', 7, 5, 4),
    ('ONKEL', 'Oheim', 'A', 8, 1, 5),
    ('SEE', 'Weiher', 'D', 1, 1, 3),
    ('LOGO', 'Emblem', 'D', 5, 1, 4),
    ('ACHT', 'Zahl (2×4)', 'D', 1, 2, 4),
    ('MAN', 'Pronomen', 'D', 6, 2, 3),
    ('UHR', 'Zeitmesser', 'D', 1, 3, 3),
    ('MARK', 'alte Währung', 'D', 5, 3, 4),
    ('MOTTO', 'Leitspruch', 'D', 1, 4, 5),
    ('REGEL', 'Norm', 'D', 4, 5, 5),
    ('ABGABEN', 'Steuern', 'D', 1, 6, 7),
    ('LAUFEND', 'ständig', 'D', 1, 7, 7),
    ('TUT', 'verrichtet', 'D', 1, 8, 3),
    ('LEER', 'hohl', 'D', 5, 8, 4)
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
    ('TRAT', 'stapfte', 'A', 1, 1, 4),
    ('FUENDIG', 'erfolgreich', 'A', 1, 6, 7),
    ('EUER', 'Possessiv (ihr)', 'A', 2, 1, 4),
    ('HAARE', 'Mähne', 'A', 2, 8, 5),
    ('AFRIKA', 'Erdteil', 'A', 3, 1, 6),
    ('EHREN', 'zu ... von', 'A', 3, 8, 5),
    ('AELTERE', 'betagtere', 'A', 4, 3, 7),
    ('BAUM', 'Gehölz', 'A', 5, 4, 4),
    ('OMA', 'Großmutter', 'A', 6, 1, 3),
    ('FRAU', 'Dame', 'A', 6, 5, 4),
    ('OFT', 'häufig', 'A', 6, 10, 3),
    ('PER', 'mittels', 'A', 7, 1, 3),
    ('FEIN', 'zart', 'A', 7, 5, 4),
    ('NEU', 'aktuell', 'A', 7, 10, 3),
    ('ANGST', 'Furcht', 'A', 8, 1, 5),
    ('LIEDER', 'Songs', 'A', 8, 7, 6),
    ('TEAM', 'Mannschaft', 'D', 1, 1, 4),
    ('OPA', 'Großvater', 'D', 6, 1, 3),
    ('RUF', 'Ansehen', 'D', 1, 2, 3),
    ('OMEN', 'Vorzeichen', 'D', 5, 2, 4),
    ('AERA', 'Epoche', 'D', 1, 3, 4),
    ('ARG', 'schlimm', 'D', 6, 3, 3),
    ('TRIEB', 'schwamm', 'D', 1, 4, 5),
    ('KLAFFT', 'gähnt', 'D', 3, 5, 6),
    ('FEATURE', 'Merkmal', 'D', 1, 6, 7),
    ('EMAIL', 'digitale Post', 'D', 4, 7, 5),
    ('EHER', 'vielmehr', 'D', 1, 8, 4),
    ('UNI', 'Hochschule', 'D', 6, 8, 3),
    ('NAHE', 'dicht bei', 'D', 1, 9, 4),
    ('DAR', 'stellt ... (zeigt)', 'D', 1, 10, 3),
    ('MOND', 'Erdtrabant', 'D', 5, 10, 4),
    ('IREN', 'Kelten', 'D', 1, 11, 4),
    ('FEE', 'Zauberin', 'D', 6, 11, 3),
    ('GEN', 'nach', 'D', 1, 12, 3),
    ('STUR', 'starrsinnig', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r034-9x13-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r034-9x13-02', 'Rätsel 34 · 9×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '9x13-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('LOT', 'Senkblei', 'A', 1, 1, 3),
    ('GEN', 'nach', 'A', 1, 6, 3),
    ('INS', 'in das', 'A', 1, 10, 3),
    ('IHR', 'Pronomen (2. Pl.)', 'A', 2, 1, 3),
    ('ARIE', 'Sologesang', 'A', 2, 5, 4),
    ('GUT', 'prima', 'A', 2, 10, 3),
    ('SIEB', 'Filter', 'A', 3, 1, 4),
    ('ALTAERE', 'Opfertische', 'A', 3, 6, 7),
    ('TOUR', 'Rundreise', 'A', 4, 1, 4),
    ('TITEL', 'Rang', 'A', 4, 6, 5),
    ('EWIG', 'unaufhörlich', 'A', 5, 4, 4),
    ('THEMAS', 'Kern des ...', 'A', 6, 1, 6),
    ('STORY', 'Geschichte', 'A', 6, 8, 5),
    ('EHEN', 'Verbindungen', 'A', 7, 2, 4),
    ('VIERTE', 'nach der dritten', 'A', 7, 7, 6),
    ('HUERDE', 'Hindernis', 'A', 8, 1, 6),
    ('ENTEN', 'Wasservögel', 'A', 8, 8, 5),
    ('LISTET', 'führt auf', 'D', 1, 1, 6),
    ('OHIO', 'Staat um Cleveland', 'D', 1, 2, 4),
    ('HEU', 'Trockengras', 'D', 6, 2, 3),
    ('TREU', 'anhänglich', 'D', 1, 3, 4),
    ('EHE', 'Vermählung', 'D', 6, 3, 3),
    ('BREMER', 'Hanseat', 'D', 3, 4, 6),
    ('WAND', 'Mauer', 'D', 5, 5, 4),
    ('GRATIS', 'kostenlos', 'D', 1, 6, 6),
    ('EILIG', 'dringend', 'D', 1, 7, 5),
    ('NETT', 'sympathisch', 'D', 1, 8, 4),
    ('SIE', 'Anrede', 'D', 6, 8, 3),
    ('AESTEN', 'Zweigen', 'D', 3, 9, 6),
    ('IGEL', 'Winterschläfer', 'D', 1, 10, 4),
    ('ORT', 'Stelle', 'D', 6, 10, 3),
    ('NUR', 'lediglich', 'D', 1, 11, 3),
    ('ORTE', 'Stellen', 'D', 5, 11, 4),
    ('STEG', 'Brücklein', 'D', 1, 12, 4),
    ('YEN', 'Währung Japans', 'D', 6, 12, 3)
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
    ('GAST', 'Besucher', 'A', 1, 1, 4),
    ('ATLANTA', 'Stadt in Georgia', 'A', 1, 6, 7),
    ('AUTORS', 'Werk des ...', 'A', 2, 1, 6),
    ('ALIAS', 'vulgo', 'A', 2, 8, 5),
    ('BEIDES', 'alle zwei', 'A', 3, 1, 6),
    ('STETS', 'immer', 'A', 3, 8, 5),
    ('CENT', 'Hundertstel Euro', 'A', 4, 5, 4),
    ('OHNE', 'abzüglich', 'A', 5, 4, 4),
    ('LAGE', 'Position', 'A', 5, 9, 4),
    ('ATMEN', 'Luft holen', 'A', 6, 1, 5),
    ('NIEDER', 'hinab', 'A', 6, 7, 6),
    ('REALE', 'wirkliche', 'A', 7, 1, 5),
    ('GELD', 'Moneten', 'A', 7, 9, 4),
    ('GELENKT', 'gesteuert', 'A', 8, 1, 7),
    ('ELBE', 'Strom durch Dresden', 'A', 8, 9, 4),
    ('GAB', 'schenkte', 'D', 1, 1, 3),
    ('KARG', 'spärlich', 'D', 5, 1, 4),
    ('AUE', 'Wiesenland', 'D', 1, 2, 3),
    ('TEE', 'Aufguss', 'D', 6, 2, 3),
    ('STIL', 'Machart', 'D', 1, 3, 4),
    ('MAL', 'einst', 'D', 6, 3, 3),
    ('TOD', 'Exitus', 'D', 1, 4, 3),
    ('OELE', 'Fette', 'D', 5, 4, 4),
    ('RECHNEN', 'kalkulieren', 'D', 2, 5, 7),
    ('ASSEN', 'speisten', 'D', 1, 6, 5),
    ('NENNT', 'bezeichnet', 'D', 4, 7, 5),
    ('LAST', 'Bürde', 'D', 1, 8, 4),
    ('ALT', 'ergraut', 'D', 1, 9, 3),
    ('LEGE', 'platziere', 'D', 5, 9, 4),
    ('NIE', 'nimmer', 'D', 1, 10, 3),
    ('ADEL', 'Aristokratie', 'D', 5, 10, 4),
    ('TAT', 'Handlung', 'D', 1, 11, 3),
    ('GELB', 'zitronenfarben', 'D', 5, 11, 4),
    ('ASS', 'speiste', 'D', 1, 12, 3),
    ('ERDE', 'Heimatplanet', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r036-10x10-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r036-10x10-01', 'Rätsel 36 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ARM', 'Extremität', 'A', 1, 1, 3),
    ('GOLD', 'Edelmetall', 'A', 1, 6, 4),
    ('LEINE', 'Seil', 'A', 2, 1, 5),
    ('MAI', 'Wonnemonat', 'A', 2, 7, 3),
    ('LILA', 'Violett', 'A', 3, 1, 4),
    ('OASE', 'Wüsteninsel', 'A', 3, 6, 4),
    ('ENDETE', 'hörte auf', 'A', 4, 1, 6),
    ('HOLZES', 'Maserung des ...', 'A', 5, 4, 6),
    ('REBEN', 'Weinstöcke', 'A', 6, 1, 5),
    ('ART', 'Spezies', 'A', 6, 7, 3),
    ('EUER', 'Possessiv (ihr)', 'A', 7, 1, 4),
    ('ERBE', 'Nachlass', 'A', 7, 6, 4),
    ('IRRT', 'liegt falsch', 'A', 8, 1, 4),
    ('HEIL', 'Wohl', 'A', 8, 6, 4),
    ('ZOG', 'riss', 'A', 9, 1, 3),
    ('NENNE', 'bezeichne', 'A', 9, 5, 5),
    ('ALLE', 'sämtliche', 'D', 1, 1, 4),
    ('REIZ', 'Charme', 'D', 6, 1, 4),
    ('REIN', 'sauber', 'D', 1, 2, 4),
    ('EURO', 'Währung', 'D', 6, 2, 4),
    ('MILD', 'sanft', 'D', 1, 3, 4),
    ('BERG', 'Anhöhe', 'D', 6, 3, 4),
    ('NAEHERT', 'rückt heran', 'D', 2, 4, 7),
    ('TON', 'Klang', 'D', 4, 5, 3),
    ('OEL', 'Schmierstoff', 'D', 3, 6, 3),
    ('EHE', 'Bund fürs Leben', 'D', 7, 6, 3),
    ('OMA', 'Omi', 'D', 1, 7, 3),
    ('ZAREN', 'russ. Kaiser', 'D', 5, 7, 5),
    ('LAS', 'schmökerte', 'D', 1, 8, 3),
    ('ERBIN', 'Nachkommin', 'D', 5, 8, 5),
    ('DIE', 'Artikel (weibl.)', 'D', 1, 9, 3),
    ('STELE', 'Gedenkstein', 'D', 5, 9, 5)
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
    ('LAS', 'entzifferte', 'A', 1, 1, 3),
    ('LOEWE', 'König der Tiere', 'A', 1, 5, 5),
    ('ALIBI', 'Entlastung', 'A', 2, 1, 5),
    ('HIN', 'fort', 'A', 2, 7, 3),
    ('GLEIS', 'Schiene', 'A', 3, 1, 5),
    ('ENG', 'schmal', 'A', 3, 7, 3),
    ('STUNDE', '60 Minuten', 'A', 4, 4, 6),
    ('PHASEN', 'Abschnitte', 'A', 5, 1, 6),
    ('ROM', 'Hauptstadt Italiens', 'A', 6, 1, 3),
    ('TEIG', 'Masse', 'A', 6, 6, 4),
    ('OFT', 'des Öfteren', 'A', 7, 1, 3),
    ('BEIGE', 'sandfarben', 'A', 7, 5, 5),
    ('SEE', 'Gewässer', 'A', 8, 1, 3),
    ('INNEN', 'hausintern', 'A', 8, 5, 5),
    ('ASSEN', 'speisten', 'A', 9, 1, 5),
    ('ELF', 'Zahl (10+1)', 'A', 9, 7, 3),
    ('LAG', 'ruhte', 'D', 1, 1, 3),
    ('PROSA', 'Erzähltext', 'D', 5, 1, 5),
    ('ALL', 'Weltraum', 'D', 1, 2, 3),
    ('HOFES', 'Mitte des ...', 'D', 5, 2, 5),
    ('SIE', 'Anrede', 'D', 1, 3, 3),
    ('AMTES', 'Ende des ...', 'D', 5, 3, 5),
    ('BISS', 'Schneid', 'D', 2, 4, 4),
    ('LISTE', 'Aufstellung', 'D', 1, 5, 5),
    ('BIN', 'Verbform', 'D', 7, 5, 3),
    ('UNTEN', 'am Grund', 'D', 4, 6, 5),
    ('EHEN', 'Bündnisse', 'D', 1, 7, 4),
    ('EINE', 'unbest. Artikel (w.)', 'D', 6, 7, 4),
    ('WIND', 'Luftzug', 'D', 1, 8, 4),
    ('IGEL', 'Winterschläfer', 'D', 6, 8, 4),
    ('ENGE', 'schmale', 'D', 1, 9, 4),
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
    ('BREAK', 'Pause', 'A', 1, 1, 5),
    ('IST', 'befindet sich', 'A', 1, 7, 3),
    ('LAND', 'Nation', 'A', 2, 1, 4),
    ('RIO', 'Zuckerhut-Stadt', 'A', 2, 7, 3),
    ('OEDE', 'langweilig', 'A', 3, 1, 4),
    ('BAER', 'Petz', 'A', 3, 6, 4),
    ('STELLUNG', 'Position', 'A', 4, 1, 8),
    ('SENIOR', 'Rentner', 'A', 5, 1, 6),
    ('GEGNER', 'Kontrahent', 'A', 6, 4, 6),
    ('TODES', 'Engel des ...', 'A', 7, 1, 5),
    ('UNI', 'Hochschule', 'A', 7, 7, 3),
    ('EHE', 'Bund fürs Leben', 'A', 8, 1, 3),
    ('TESTS', 'Prüfungen', 'A', 8, 5, 5),
    ('ERST', 'anfangs', 'A', 9, 1, 4),
    ('SEE', 'Weiher', 'A', 9, 7, 3),
    ('BLOSS', 'nur', 'D', 1, 1, 5),
    ('TEE', 'Aufguss', 'D', 7, 1, 3),
    ('RAETE', 'Gremien', 'D', 1, 2, 5),
    ('OHR', 'Hörorgan', 'D', 7, 2, 3),
    ('ENDEN', 'auslaufen', 'D', 1, 3, 5),
    ('DES', 'Artikel (Genitiv)', 'D', 7, 3, 3),
    ('ADELIGE', 'Edelfrau', 'D', 1, 4, 7),
    ('LOEST', 'klärt', 'D', 4, 5, 5),
    ('BURG', 'Festung', 'D', 3, 6, 4),
    ('IRAN', 'Golfstaat', 'D', 1, 7, 4),
    ('NUSS', 'Kern', 'D', 6, 7, 4),
    ('SIEG', 'Triumph', 'D', 1, 8, 4),
    ('ENTE', 'Falschmeldung', 'D', 6, 8, 4),
    ('TOR', 'Dummkopf', 'D', 1, 9, 3),
    ('KRISE', 'Notlage', 'D', 5, 9, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r039-10x10-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r039-10x10-04', 'Rätsel 39 · 10×10', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '10x10-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('IDEE', 'Gedanke', 'A', 1, 1, 4),
    ('LEBE', 'existiere', 'A', 1, 6, 4),
    ('GAR', 'völlig', 'A', 2, 1, 3),
    ('DATEN', 'Angaben', 'A', 2, 5, 5),
    ('EBBE', 'Niedrigwasser', 'A', 3, 1, 4),
    ('EWIG', 'unaufhörlich', 'A', 3, 6, 4),
    ('LEER', 'vakant', 'A', 4, 1, 4),
    ('SAGE', 'Legende', 'A', 4, 6, 4),
    ('INDESSEN', 'jedoch', 'A', 5, 2, 8),
    ('ORT', 'Stelle', 'A', 6, 4, 3),
    ('ABTES', 'Kloster des ...', 'A', 7, 1, 5),
    ('TUT', 'macht', 'A', 7, 7, 3),
    ('HAELT', 'stoppt', 'A', 8, 1, 5),
    ('OMA', 'Omi', 'A', 8, 7, 3),
    ('TUE', 'mache', 'A', 9, 1, 3),
    ('ERNST', 'Seriosität', 'A', 9, 5, 5),
    ('IGEL', 'Winterschläfer', 'D', 1, 1, 4),
    ('NAHT', 'kommt näher', 'D', 6, 1, 4),
    ('DABEI', 'Adverb', 'D', 1, 2, 5),
    ('BAU', 'Gebäude', 'D', 7, 2, 3),
    ('ERBEN', 'Nachkommen', 'D', 1, 3, 5),
    ('TEE', 'Heißgetränk', 'D', 7, 3, 3),
    ('ERDOEL', 'Rohöl', 'D', 3, 4, 6),
    ('ERSTE', 'führende', 'D', 5, 5, 5),
    ('LAESST', 'erlaubt', 'D', 1, 6, 6),
    ('ETWAS', 'irgendwas', 'D', 1, 7, 5),
    ('TON', 'Lehm', 'D', 7, 7, 3),
    ('BEIGE', 'sandfarben', 'D', 1, 8, 5),
    ('UMS', 'um das', 'D', 7, 8, 3),
    ('ENGEN', 'schmalen', 'D', 1, 9, 5),
    ('TAT', 'Werk', 'D', 7, 9, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r040-11x11-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r040-11x11-01', 'Rätsel 40 · 11×11', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '11x11-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ELBE', 'Strom durch Hamburg', 'A', 1, 1, 4),
    ('GENRE', 'Stilrichtung', 'A', 1, 6, 5),
    ('HAI', 'Meeresräuber', 'A', 2, 1, 3),
    ('EIN', 'unbest. Artikel', 'A', 2, 8, 3),
    ('EINHER', '... gehen', 'A', 3, 1, 6),
    ('UND', 'sowie', 'A', 3, 8, 3),
    ('LEGE', 'platziere', 'A', 4, 7, 4),
    ('ANBAU', 'Erweiterung', 'A', 5, 1, 5),
    ('ISST', 'speist', 'A', 5, 7, 4),
    ('URNEN', 'Aschengefäße', 'A', 6, 3, 5),
    ('LUD', 'packte auf', 'A', 7, 1, 3),
    ('SIEGE', 'Triumphe', 'A', 7, 5, 5),
    ('ARGE', 'schlimme', 'A', 8, 1, 4),
    ('NAEHE', 'Umgebung', 'A', 8, 6, 5),
    ('GIER', 'Habsucht', 'A', 9, 1, 4),
    ('IRREN', 'sich täuschen', 'A', 9, 6, 5),
    ('ENTZUG', 'Wegnahme', 'A', 10, 1, 6),
    ('ARG', 'schlimm', 'A', 10, 8, 3),
    ('EHE', 'Bund fürs Leben', 'D', 1, 1, 3),
    ('ANLAGE', 'Einrichtung', 'D', 5, 1, 6),
    ('LAIEN', 'Amateure', 'D', 1, 2, 5),
    ('URIN', 'Ausscheidung', 'D', 7, 2, 4),
    ('BIN', 'Verbform', 'D', 1, 3, 3),
    ('BUDGET', 'Etat', 'D', 5, 3, 6),
    ('HAAR', 'Locke', 'D', 3, 4, 4),
    ('ERZ', 'Bodenschatz', 'D', 8, 4, 3),
    ('UNS', 'Akk./Dat. von wir', 'D', 5, 5, 3),
    ('GAR', 'durchgekocht', 'D', 1, 6, 3),
    ('EINIG', 'konform', 'D', 6, 6, 5),
    ('LINEAR', 'geradlinig', 'D', 4, 7, 6),
    ('NEUES', 'frisches', 'D', 1, 8, 5),
    ('GERA', 'Stadt in Thüringen', 'D', 7, 8, 4),
    ('RINGS', 'Herr der ...', 'D', 1, 9, 5),
    ('EHER', 'vielmehr', 'D', 7, 9, 4),
    ('ENDETE', 'hörte auf', 'D', 1, 10, 6),
    ('ENG', 'knapp', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r041-11x11-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r041-11x11-02', 'Rätsel 41 · 11×11', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '11x11-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('UNI', 'Hochschule', 'A', 1, 1, 3),
    ('PFEIFE', 'Flöte', 'A', 1, 5, 6),
    ('NAHM', 'ergriff', 'A', 2, 1, 4),
    ('IHRER', 'seiner', 'A', 2, 6, 5),
    ('IHR', 'Pronomen (2. Pl.)', 'A', 3, 1, 3),
    ('FREIES', 'ungebundenes', 'A', 3, 5, 6),
    ('SEE', 'Weiher', 'A', 4, 1, 3),
    ('GRAZ', 'Murstadt', 'A', 5, 4, 4),
    ('DUBAI', 'Emirat', 'A', 6, 1, 5),
    ('WENN', 'falls', 'A', 6, 7, 4),
    ('AUSLEIHE', 'Bibliothek', 'A', 7, 3, 8),
    ('LOS', 'frei', 'A', 8, 1, 3),
    ('SAITEN', 'Drähte', 'A', 8, 5, 6),
    ('OPER', 'Musiktheater', 'A', 9, 1, 4),
    ('STEIN', 'Fels', 'A', 9, 6, 5),
    ('TAL', 'Niederung', 'A', 10, 1, 3),
    ('STELLT', 'platziert', 'A', 10, 5, 6),
    ('UNIS', 'Hochschulen', 'D', 1, 1, 4),
    ('LOT', 'Senkrechte', 'D', 8, 1, 3),
    ('NAHEZU', 'fast', 'D', 1, 2, 6),
    ('OPA', 'Großvater', 'D', 8, 2, 3),
    ('IHRE', 'Pronomen', 'D', 1, 3, 4),
    ('BASEL', 'Stadt am Rheinknie', 'D', 6, 3, 5),
    ('GAU', 'Landstrich', 'D', 5, 4, 3),
    ('RISS', 'zerrte', 'D', 5, 5, 4),
    ('FIRMA', 'Betrieb', 'D', 1, 6, 5),
    ('LAST', 'Bürde', 'D', 7, 6, 4),
    ('EHE', 'Bund fürs Leben', 'D', 1, 7, 3),
    ('ZWEITE', 'folgende', 'D', 5, 7, 6),
    ('IRIS', 'Regenbogenhaut', 'D', 1, 8, 4),
    ('EITEL', 'gefallsüchtig', 'D', 6, 8, 5),
    ('FEE', 'Zauberin', 'D', 1, 9, 3),
    ('UNHEIL', 'Unglück', 'D', 5, 9, 6),
    ('ERST', 'zunächst', 'D', 1, 10, 4),
    ('NENNT', 'bezeichnet', 'D', 6, 10, 5)
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
    ('REUE', 'Bedauern', 'A', 1, 1, 4),
    ('KUBA', 'Karibikinsel', 'A', 1, 7, 4),
    ('IHN', 'Akkusativ von er', 'A', 2, 1, 3),
    ('KILLER', 'Mörder', 'A', 2, 5, 6),
    ('SEID', 'existiert', 'A', 3, 1, 4),
    ('DAMIT', 'hiermit', 'A', 3, 6, 5),
    ('OBEREN', 'höher gelegenen', 'A', 4, 4, 6),
    ('EMPORE', 'Galerie', 'A', 5, 1, 6),
    ('REH', 'Waldbewohner', 'A', 5, 8, 3),
    ('AFFE', 'Schimpanse', 'A', 6, 2, 4),
    ('PRO', 'je', 'A', 7, 1, 3),
    ('IST', 'befindet sich', 'A', 7, 5, 3),
    ('ROT', 'purpurn', 'A', 8, 1, 3),
    ('TIEFER', 'niedriger', 'A', 8, 5, 6),
    ('ADEL', 'blaues Blut', 'A', 9, 1, 4),
    ('CHINA', 'Reich der Mitte', 'A', 9, 6, 5),
    ('GEN', 'nach', 'A', 10, 1, 3),
    ('HEXEN', 'Zauberinnen', 'A', 10, 6, 5),
    ('RISSE', 'Spalten', 'D', 1, 1, 5),
    ('PRAG', 'Moldau-Stadt', 'D', 7, 1, 4),
    ('EHE', 'Vermählung', 'D', 1, 2, 3),
    ('MARODE', 'baufällig', 'D', 5, 2, 6),
    ('UNI', 'Alma Mater', 'D', 1, 3, 3),
    ('PFOTEN', 'Tatzen', 'D', 5, 3, 6),
    ('DOOF', 'blöd', 'D', 3, 4, 4),
    ('BREIT', 'weit', 'D', 4, 5, 5),
    ('IDEE', 'Gedanke', 'D', 2, 6, 4),
    ('SICH', 'rückbezügl. Fürwort', 'D', 7, 6, 4),
    ('KLAR', 'deutlich', 'D', 1, 7, 4),
    ('STEHE', 'ich ... auf', 'D', 6, 7, 5),
    ('ULMER', '... Münster', 'D', 1, 8, 5),
    ('FIX', 'flink', 'D', 8, 8, 3),
    ('BEINE', 'Gliedmaßen', 'D', 1, 9, 5),
    ('JENE', 'selbige', 'D', 7, 9, 4),
    ('ART', 'Sorte', 'D', 1, 10, 3),
    ('RAN', 'heran', 'D', 8, 10, 3)
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
    ('UMS', 'um das', 'A', 1, 1, 3),
    ('URIN', 'Harn', 'A', 1, 8, 4),
    ('NAEHER', 'dichter', 'A', 2, 1, 6),
    ('NAHE', 'benachbart', 'A', 2, 8, 4),
    ('FIX', 'schnell', 'A', 3, 1, 3),
    ('AGIERT', 'handelt', 'A', 3, 6, 6),
    ('LASTET', 'drückt', 'A', 4, 6, 6),
    ('GEBIETS', 'Grenze des ...', 'A', 5, 1, 7),
    ('HELLE', 'lichte', 'A', 6, 2, 5),
    ('FELLE', 'Pelze', 'A', 7, 1, 5),
    ('PREIS', 'Tarif', 'A', 7, 7, 5),
    ('GEN', 'nach', 'A', 8, 3, 3),
    ('REIZE', 'Verlockungen', 'A', 8, 7, 5),
    ('OHR', 'Lauscher', 'A', 9, 1, 3),
    ('DROHNEN', 'Flugroboter', 'A', 9, 5, 7),
    ('HAAR', 'Locke', 'A', 10, 1, 4),
    ('OSTENS', 'Völker des ...', 'A', 10, 6, 6),
    ('EID', 'Gelöbnis', 'A', 11, 1, 3),
    ('TAENZE', 'Reigen', 'A', 11, 6, 6),
    ('UNFUG', 'Unsinn', 'D', 1, 1, 5),
    ('FROHE', 'heitere', 'D', 7, 1, 5),
    ('MAI', '5. Monat', 'D', 1, 2, 3),
    ('EHE', 'Bund fürs Leben', 'D', 5, 2, 3),
    ('HAI', 'Raubfisch', 'D', 9, 2, 3),
    ('SEX', 'Erotik', 'D', 1, 3, 3),
    ('BELGRAD', 'serb. Hauptstadt', 'D', 5, 3, 7),
    ('WILLE', 'Wunsch', 'D', 4, 4, 5),
    ('ELEND', 'Misere', 'D', 5, 5, 5),
    ('URALTE', 'steinalte', 'D', 1, 6, 6),
    ('ROT', 'purpurn', 'D', 9, 6, 3),
    ('GAS', 'Treibstoff', 'D', 3, 7, 3),
    ('PROSA', 'Erzähltext', 'D', 7, 7, 5),
    ('UNIS', 'Hochschulen', 'D', 1, 8, 4),
    ('DREHTE', 'wendete', 'D', 6, 8, 6),
    ('RAETE', 'Ausschüsse', 'D', 1, 9, 5),
    ('EINEN', 'unbest. Art. (Akk.)', 'D', 7, 9, 5),
    ('IHRE', 'seine', 'D', 1, 10, 4),
    ('LIZENZ', 'Erlaubnis', 'D', 6, 10, 6),
    ('NETTO', 'ohne Steuern', 'D', 1, 11, 5),
    ('SENSE', 'Mähwerkzeug', 'D', 7, 11, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r044-12x12-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r044-12x12-02', 'Rätsel 44 · 12×12', g.id, 'veroeffentlicht', 3, now()
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
    ('ECK', 'Kante', 'A', 4, 1, 3),
    ('RAD', 'Velo', 'A', 4, 9, 3),
    ('EHER', 'vielmehr', 'A', 5, 1, 4),
    ('RUHEN', 'rasten', 'A', 5, 6, 5),
    ('ETAGE', 'Stockwerk', 'A', 6, 2, 5),
    ('ENDE', 'Finale', 'A', 6, 8, 4),
    ('ANTRAT', 'begann', 'A', 7, 1, 6),
    ('ASS', 'verspeiste', 'A', 8, 7, 3),
    ('HAUS', 'Gebäude', 'A', 9, 1, 4),
    ('SAGA', 'Heldensage', 'A', 9, 8, 4),
    ('SCHEMA', 'Muster', 'A', 10, 1, 6),
    ('EGAL', 'gleichgültig', 'A', 10, 8, 4),
    ('EHRT', 'würdigt', 'A', 11, 1, 4),
    ('STREBT', 'trachtet', 'A', 11, 6, 6),
    ('SPREE', 'Fluss durch Berlin', 'D', 1, 1, 5),
    ('ACHSE', 'Welle', 'D', 7, 1, 5),
    ('TAUCHEN', 'untergehen', 'D', 1, 2, 7),
    ('ACH', 'Seufzer', 'D', 9, 2, 3),
    ('ETIKETT', 'Aufkleber', 'D', 1, 3, 7),
    ('UHR', 'Chronometer', 'D', 9, 3, 3),
    ('GEN', 'nach', 'D', 1, 4, 3),
    ('RAR', 'kostbar', 'D', 5, 4, 3),
    ('SET', 'Ausstattung', 'D', 9, 4, 3),
    ('GAU', 'Landesteil', 'D', 6, 5, 3),
    ('KONKRET', 'greifbar', 'D', 1, 6, 7),
    ('GAS', 'Treibstoff', 'D', 9, 6, 3),
    ('ULM', 'Münsterstadt', 'D', 1, 8, 3),
    ('HEISSER', 'glühender', 'D', 5, 8, 7),
    ('TIEREN', 'Kreaturen', 'D', 1, 9, 6),
    ('SAGE', 'Legende', 'D', 8, 9, 4),
    ('ANHAND', 'mithilfe', 'D', 1, 10, 6),
    ('GAB', 'schenkte', 'D', 9, 10, 3),
    ('HELD', 'Recke', 'D', 1, 11, 4),
    ('ERHALT', 'Empfang', 'D', 6, 11, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r045-12x12-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r045-12x12-03', 'Rätsel 45 · 12×12', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '12x12-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('LOKAL', 'Gaststätte', 'A', 1, 1, 5),
    ('DIEBE', 'Langfinger', 'A', 1, 7, 5),
    ('ATELIER', 'Werkstatt', 'A', 2, 1, 7),
    ('RAR', 'kostbar', 'A', 2, 9, 3),
    ('STILE', 'Machart', 'A', 3, 1, 5),
    ('ZUG', 'Bahn', 'A', 3, 9, 3),
    ('TAL', 'Senke', 'A', 4, 1, 3),
    ('BAUS', 'Ende des ...', 'A', 4, 5, 4),
    ('ELF', 'Zahl (10+1)', 'A', 5, 5, 3),
    ('BUB', 'Knabe', 'A', 5, 9, 3),
    ('DATE', 'Rendezvous', 'A', 6, 1, 4),
    ('DROHTE', 'stand bevor', 'A', 7, 5, 6),
    ('FAX', 'Telekopie', 'A', 8, 1, 3),
    ('EMPOERT', 'entrüstet', 'A', 8, 5, 7),
    ('AKTEN', 'Dokumente', 'A', 9, 1, 5),
    ('EWIGE', 'endlose', 'A', 9, 7, 5),
    ('STECKER', 'Anschluss', 'A', 10, 1, 7),
    ('LAS', 'entzifferte', 'A', 10, 9, 3),
    ('SENKE', 'Mulde', 'A', 11, 1, 5),
    ('GEBT', 'reicht', 'A', 11, 8, 4),
    ('LAST', 'Bürde', 'D', 1, 1, 4),
    ('FASS', 'Tonne', 'D', 8, 1, 4),
    ('OTTAWA', 'kanad. Hauptstadt', 'D', 1, 2, 6),
    ('AKTE', 'Vorgang', 'D', 8, 2, 4),
    ('KEIL', 'Dreieckklotz', 'D', 1, 3, 4),
    ('TEXTEN', 'Schriften', 'D', 6, 3, 6),
    ('ALL', 'Weltraum', 'D', 1, 4, 3),
    ('ECK', 'Kante', 'D', 9, 4, 3),
    ('LIEBE', 'Zuneigung', 'D', 1, 5, 5),
    ('DENKE', 'meine', 'D', 7, 5, 5),
    ('ALARM', 'Warnsignal', 'D', 4, 6, 5),
    ('DRAUF', 'darauf', 'D', 1, 7, 5),
    ('OPER', 'Musiktheater', 'D', 7, 7, 4),
    ('SHOW', 'Vorstellung', 'D', 6, 8, 4),
    ('ERZ', 'Bodenschatz', 'D', 1, 9, 3),
    ('TEILE', 'Stücke', 'D', 7, 9, 5),
    ('BAU', 'Gebäude', 'D', 1, 10, 3),
    ('ERGAB', 'brachte', 'D', 7, 10, 5),
    ('ERGEBE', 'resultiere', 'D', 1, 11, 6),
    ('TEST', 'Prüfung', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r046-12x12-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r046-12x12-04', 'Rätsel 46 · 12×12', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '12x12-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ERWARBEN', 'kauften', 'A', 1, 1, 8),
    ('TAUFE', 'Sakrament', 'A', 2, 1, 5),
    ('NEU', 'aktuell', 'A', 2, 7, 3),
    ('WERFT', 'Dock', 'A', 3, 1, 5),
    ('GUNST', 'Wohlwollen', 'A', 3, 7, 5),
    ('ATMET', 'holt Luft', 'A', 4, 1, 5),
    ('EGAL', 'gleichgültig', 'A', 4, 8, 4),
    ('NEUTRALE', 'objektive', 'A', 5, 4, 8),
    ('RAR', 'selten', 'A', 6, 9, 3),
    ('WEH', 'wund', 'A', 7, 2, 3),
    ('AGENT', 'Spion', 'A', 7, 6, 5),
    ('PERU', 'Andenstaat', 'A', 8, 1, 4),
    ('DEM', 'Artikel (Dativ)', 'A', 8, 6, 3),
    ('LIEBTE', 'verehrte', 'A', 9, 1, 6),
    ('DEAL', 'Geschäft', 'A', 9, 8, 4),
    ('UND', 'sowie', 'A', 10, 1, 3),
    ('EILT', 'hastet', 'A', 10, 8, 4),
    ('STEG', 'Bootsanleger', 'A', 11, 1, 4),
    ('SANDTE', 'schickte', 'A', 11, 6, 6),
    ('ETWA', 'vielleicht', 'D', 1, 1, 4),
    ('PLUS', 'Überschuss', 'D', 8, 1, 4),
    ('RAETE', 'Gremien', 'D', 1, 2, 5),
    ('WEINT', 'heult', 'D', 7, 2, 5),
    ('WURM', 'Angelköder', 'D', 1, 3, 4),
    ('GEREDE', 'Geschwätz', 'D', 6, 3, 6),
    ('AFFEN', 'Primaten', 'D', 1, 4, 5),
    ('HUB', 'Kolbenweg', 'D', 7, 4, 3),
    ('RETTET', 'birgt', 'D', 1, 5, 6),
    ('ADELS', 'Titel des ...', 'D', 7, 6, 5),
    ('ENG', 'knapp', 'D', 1, 7, 3),
    ('TAGE', 'je 24 Stunden', 'D', 5, 7, 4),
    ('NEUER', 'frischer', 'D', 1, 8, 5),
    ('EMDEN', 'ostfries. Stadt', 'D', 7, 8, 5),
    ('UNGARN', 'Magyaren', 'D', 2, 9, 6),
    ('EID', 'Gelöbnis', 'D', 9, 9, 3),
    ('SALAT', 'Rohkost', 'D', 3, 10, 5),
    ('ALT', 'ergraut', 'D', 9, 10, 3),
    ('BUTLER', 'Diener', 'D', 1, 11, 6),
    ('ALTE', 'greise', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r047-13x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r047-13x13-01', 'Rätsel 47 · 13×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '13x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('HUB', 'Kolbenweg', 'A', 1, 1, 3),
    ('OMA', 'Omi', 'A', 1, 5, 3),
    ('ABER', 'jedoch', 'A', 1, 9, 4),
    ('OKAY', 'in Ordnung', 'A', 2, 1, 4),
    ('IKONE', 'Heiligenbild', 'A', 2, 6, 5),
    ('BRUETET', 'grübelt', 'A', 3, 1, 7),
    ('STUR', 'starrsinnig', 'A', 3, 9, 4),
    ('NOTIZ', 'Vermerk', 'A', 4, 4, 5),
    ('HIT', 'Chartstürmer', 'A', 5, 1, 3),
    ('REVISION', 'Überprüfung', 'A', 5, 5, 8),
    ('ANRUF', 'Telefonat', 'A', 6, 1, 5),
    ('ETAT', 'Budget', 'A', 6, 7, 4),
    ('TEE', 'Aufguss', 'A', 7, 1, 3),
    ('ALTAR', 'Opfertisch', 'A', 7, 8, 5),
    ('TRUG', 'hatte an', 'A', 8, 1, 4),
    ('PUTZ', 'Mauerbelag', 'A', 8, 6, 4),
    ('EDLE', 'vornehme', 'A', 9, 9, 4),
    ('VERGIBT', 'verleiht', 'A', 10, 2, 7),
    ('RAN', 'heran', 'A', 10, 10, 3),
    ('KINDES', 'Wohl des ...', 'A', 11, 1, 6),
    ('IST', 'befindet sich', 'A', 11, 10, 3),
    ('AGENT', 'Spion', 'A', 12, 2, 5),
    ('LINSE', 'Objektiv', 'A', 12, 8, 5),
    ('HOB', 'wuchtete', 'D', 1, 1, 3),
    ('HATTE', 'besaß', 'D', 5, 1, 5),
    ('UKRAINER', 'Ostslawe', 'D', 1, 2, 8),
    ('VIA', 'durch', 'D', 10, 2, 3),
    ('BAU', 'Konstruktion', 'D', 1, 3, 3),
    ('TREU', 'loyal', 'D', 5, 3, 4),
    ('ENG', 'schmal', 'D', 10, 3, 3),
    ('YEN', 'Währung Japans', 'D', 2, 4, 3),
    ('GARDE', 'Leibwache', 'D', 8, 4, 5),
    ('TORF', 'Moorboden', 'D', 3, 5, 4),
    ('GEN', 'nach', 'D', 10, 5, 3),
    ('MIETE', 'Pacht', 'D', 1, 6, 5),
    ('SPEIST', 'isst', 'D', 7, 6, 6),
    ('AKTIVE', 'tätige', 'D', 1, 7, 6),
    ('ZITAT', 'Ausspruch', 'D', 4, 8, 5),
    ('TAL', 'Niederung', 'D', 10, 8, 3),
    ('ANS', 'an das', 'D', 1, 9, 3),
    ('SALZE', 'Mineralien', 'D', 5, 9, 5),
    ('BETRITT', 'geht hinein', 'D', 1, 10, 7),
    ('DRIN', 'innen', 'D', 9, 10, 4),
    ('ANLASS', 'Gelegenheit', 'D', 7, 11, 6),
    ('RAR', 'selten', 'D', 1, 12, 3),
    ('NUR', 'bloß', 'D', 5, 12, 3),
    ('ENTE', 'Wasservogel', 'D', 9, 12, 4)
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
    ('KOSTBARE', 'wertvolle', 'A', 1, 1, 8),
    ('ERZ', 'Bodenschatz', 'A', 1, 10, 3),
    ('PROBE', 'Test', 'A', 2, 3, 5),
    ('STAU', 'Blechlawine', 'A', 2, 9, 4),
    ('RATSAM', 'klug', 'A', 3, 3, 6),
    ('WUT', 'Zorn', 'A', 3, 10, 3),
    ('NEUE', 'frische', 'A', 4, 1, 4),
    ('ALABAMA', 'Südstaat', 'A', 4, 6, 7),
    ('GING', 'lief', 'A', 5, 1, 4),
    ('GEIL', 'toll (ugs.)', 'A', 5, 6, 4),
    ('ENGERE', 'schmalere', 'A', 6, 1, 6),
    ('LUD', 'forderte auf', 'A', 6, 8, 3),
    ('METERN', 'nach hundert ...', 'A', 7, 7, 6),
    ('MUND', 'Maul', 'A', 8, 3, 4),
    ('TRENNEN', 'scheiden', 'A', 9, 1, 7),
    ('AKTE', 'Dokument', 'A', 9, 9, 4),
    ('RENTEN', 'Pensionen', 'A', 10, 1, 6),
    ('ARMEN', 'Mittellosen', 'A', 10, 8, 5),
    ('EIGENEM', 'persönlichem', 'A', 11, 1, 7),
    ('MAST', 'Pfosten', 'A', 11, 9, 4),
    ('UFER', 'Gestade', 'A', 12, 1, 4),
    ('GELTE', 'zähle', 'A', 12, 8, 5),
    ('KLINGEN', 'tönen', 'D', 1, 1, 7),
    ('TREU', 'anhänglich', 'D', 9, 1, 4),
    ('EIN', 'unbest. Artikel', 'D', 4, 2, 3),
    ('REIF', 'erntefertig', 'D', 9, 2, 4),
    ('SPRUNG', 'Satz', 'D', 1, 3, 6),
    ('MENGE', 'Masse', 'D', 8, 3, 5),
    ('TRAEGE', 'faul', 'D', 1, 4, 6),
    ('UNTER', 'inmitten', 'D', 8, 4, 5),
    ('BOT', 'offerierte', 'D', 1, 5, 3),
    ('RENNEN', 'Wettlauf', 'D', 6, 5, 6),
    ('ABSAGE', 'Ablehnung', 'D', 1, 6, 6),
    ('DENEN', 'Relativ (Dat. Pl.)', 'D', 8, 6, 5),
    ('REALE', 'wirkliche', 'D', 1, 7, 5),
    ('MAILEN', 'senden', 'D', 3, 8, 6),
    ('BLUT', 'Lebenssaft', 'D', 4, 9, 4),
    ('ARME', 'Bedürftige', 'D', 9, 9, 4),
    ('ETWA', 'vielleicht', 'D', 1, 10, 4),
    ('DENKMAL', 'Monument', 'D', 6, 10, 7),
    ('RAUM', 'Zimmer', 'D', 1, 11, 4),
    ('TEST', 'Prüfung', 'D', 9, 11, 4),
    ('ZUTATEN', 'Ingredienzen', 'D', 1, 12, 7),
    ('ENTE', 'Falschmeldung', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r049-13x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r049-13x13-03', 'Rätsel 49 · 13×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '13x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('BAUE', 'errichte', 'A', 1, 1, 4),
    ('TAL', 'Niederung', 'A', 1, 6, 3),
    ('SAH', 'erblickte', 'A', 1, 10, 3),
    ('ULM', 'Münsterstadt', 'A', 2, 1, 3),
    ('ERHOLT', 'ausgeruht', 'A', 2, 5, 6),
    ('GLAUBENS', 'Bekenntnis des ...', 'A', 3, 1, 8),
    ('INS', 'in das', 'A', 3, 10, 3),
    ('ERNEUT', 'wieder', 'A', 4, 2, 6),
    ('REIS', 'Getreideart', 'A', 4, 9, 4),
    ('MINE', 'Bergwerk', 'A', 5, 3, 4),
    ('FEE', 'Zauberin', 'A', 5, 10, 3),
    ('HEU', 'Viehfutter', 'A', 6, 1, 3),
    ('NAEHERN', 'heranrücken', 'A', 6, 6, 7),
    ('RINDE', 'Borke', 'A', 7, 1, 5),
    ('GEILE', 'tolle (ugs.)', 'A', 7, 7, 5),
    ('ENGE', 'knappe', 'A', 8, 1, 4),
    ('HIRN', 'Verstand', 'A', 8, 6, 4),
    ('ENGSTE', 'schmalste', 'A', 9, 7, 6),
    ('MEER', 'See', 'A', 10, 1, 4),
    ('ORT', 'Stelle', 'A', 10, 6, 3),
    ('ARG', 'übel', 'A', 10, 10, 3),
    ('AHNEN', 'vermuten', 'A', 11, 1, 5),
    ('TESTET', 'prüft', 'A', 11, 7, 6),
    ('LEGT', 'deponiert', 'A', 12, 1, 4),
    ('SET', 'Ausstattung', 'A', 12, 6, 3),
    ('TUE', 'mache', 'A', 12, 10, 3),
    ('BUG', 'Programmfehler', 'D', 1, 1, 3),
    ('EHRENMAL', 'Denkmal', 'D', 5, 1, 8),
    ('ALLE', 'sämtliche', 'D', 1, 2, 4),
    ('EIN', 'unbest. Artikel', 'D', 6, 2, 3),
    ('EHE', 'Bund fürs Leben', 'D', 10, 2, 3),
    ('UMARMUNG', 'Umklammerung', 'D', 1, 3, 8),
    ('ENG', 'schmal', 'D', 10, 3, 3),
    ('UNI', 'Hochschule', 'D', 3, 4, 3),
    ('DEKRET', 'Erlass', 'D', 7, 4, 6),
    ('EBEN', 'flach', 'D', 2, 5, 4),
    ('TREUEN', 'loyalen', 'D', 1, 6, 6),
    ('AHNT', 'spürt', 'D', 1, 7, 4),
    ('AGIERTE', 'handelte', 'D', 6, 7, 7),
    ('LOS', 'ledig', 'D', 1, 8, 3),
    ('GEERNTET', 'gepflückt', 'D', 5, 8, 8),
    ('HING', 'baumelte', 'D', 6, 9, 4),
    ('STIEFEL', 'Schaftschuh', 'D', 1, 10, 7),
    ('SATT', 'gesättigt', 'D', 9, 10, 4),
    ('NIERE', 'Organ', 'D', 3, 11, 5),
    ('TREU', 'loyal', 'D', 9, 11, 4),
    ('HASSEN', 'verabscheuen', 'D', 1, 12, 6),
    ('REGTE', 'bewegte', 'D', 8, 12, 5)
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
    ('EBBE', 'Gegenteil der Flut', 'A', 1, 1, 4),
    ('KUH', 'Rind', 'A', 1, 6, 3),
    ('RASCH', 'schnell', 'A', 1, 10, 5),
    ('RUEHREN', 'bewegen', 'A', 2, 1, 7),
    ('GALT', 'zählte', 'A', 2, 9, 4),
    ('LESE', 'schmökere', 'A', 3, 1, 4),
    ('HIN', 'fort', 'A', 3, 6, 3),
    ('STADT', 'Kommune', 'A', 3, 10, 5),
    ('IRANER', 'Perser', 'A', 4, 1, 6),
    ('TABUS', 'Verbote', 'A', 4, 10, 5),
    ('TOT', 'leblos', 'A', 5, 1, 3),
    ('STAND', 'befand sich', 'A', 5, 5, 5),
    ('MAG', 'liebt', 'A', 6, 12, 3),
    ('BERLIN', 'dt. Hauptstadt', 'A', 7, 2, 6),
    ('HAWAII', 'Inselstaat der USA', 'A', 7, 9, 6),
    ('PUR', 'unverfälscht', 'A', 8, 1, 3),
    ('ANTRETEN', 'anfangen', 'A', 8, 5, 8),
    ('UNS', 'Akk./Dat. von wir', 'A', 9, 4, 3),
    ('REH', 'Waldtier', 'A', 9, 9, 3),
    ('BRAND', 'Feuersbrunst', 'A', 10, 1, 5),
    ('GRAS', 'Rasen', 'A', 10, 7, 4),
    ('ROST', 'Grill', 'A', 11, 1, 4),
    ('SEEN', 'Gewässer', 'A', 11, 6, 4),
    ('PLAN', 'Absicht', 'A', 11, 11, 4),
    ('ASTEROID', 'Kleinplanet', 'A', 12, 1, 8),
    ('SEITE', 'Flanke', 'A', 12, 10, 5),
    ('ROLLE', 'Walze', 'A', 13, 4, 5),
    ('ARMES', 'Kraft des ...', 'A', 13, 10, 5),
    ('HOF', 'Gehöft', 'A', 14, 1, 3),
    ('MOENCH', 'Ordensmann', 'A', 14, 5, 6),
    ('AMT', 'Dienststelle', 'A', 14, 12, 3),
    ('ERLITT', 'erduldete', 'D', 1, 1, 6),
    ('BRACH', 'barst', 'D', 10, 1, 5),
    ('BUERO', 'Kanzlei', 'D', 1, 2, 5),
    ('BUEROS', 'Kanzleien', 'D', 7, 2, 6),
    ('BESATZER', 'Okkupanten', 'D', 1, 3, 8),
    ('AST', 'Knorren', 'D', 10, 3, 3),
    ('EHEN', 'Bündnisse', 'D', 1, 4, 4),
    ('UNTER', 'Präposition', 'D', 9, 4, 5),
    ('ESTLAND', 'Baltenstaat', 'D', 4, 5, 7),
    ('ROM', 'Ewige Stadt', 'D', 12, 5, 3),
    ('KEHRT', 'fegt', 'D', 1, 6, 5),
    ('INS', 'in das', 'D', 7, 6, 3),
    ('SOLO', 'allein', 'D', 11, 6, 4),
    ('UNI', 'Hochschule', 'D', 1, 7, 3),
    ('AHNT', 'spürt', 'D', 5, 7, 4),
    ('GEILE', 'tolle (ugs.)', 'D', 10, 7, 5),
    ('NUN', 'inzwischen', 'D', 3, 8, 3),
    ('REDEN', 'sprechen', 'D', 10, 8, 5),
    ('HERAN', 'herbei', 'D', 7, 9, 5),
    ('RAST', 'jagt', 'D', 1, 10, 4),
    ('RATES', 'Mitglied des ...', 'D', 6, 10, 5),
    ('SAH', 'blickte', 'D', 12, 10, 3),
    ('ALTAR', 'Opfertisch', 'D', 1, 11, 5),
    ('WEH', 'schmerzhaft', 'D', 7, 11, 3),
    ('PER', 'mittels', 'D', 11, 11, 3),
    ('STAB', 'Stock', 'D', 1, 12, 4),
    ('MAN', 'Pronomen', 'D', 6, 12, 3),
    ('KLIMA', 'Wetterlage', 'D', 10, 12, 5),
    ('DUBAI', 'Emirat', 'D', 3, 13, 5),
    ('ATEM', 'Odem', 'D', 11, 13, 4),
    ('HITS', 'Schlager', 'D', 1, 14, 4),
    ('GILT', 'ist gültig', 'D', 6, 14, 4),
    ('NEST', 'Kobel', 'D', 11, 14, 4)
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
    ('PHASE', 'Abschnitt', 'A', 1, 1, 5),
    ('ATHEN', 'griech. Hauptstadt', 'A', 1, 10, 5),
    ('LOT', 'Senkrechte', 'A', 2, 1, 3),
    ('REDE', 'Vortrag', 'A', 2, 5, 4),
    ('BOOTE', 'Kähne', 'A', 2, 10, 5),
    ('UFERN', 'Gestaden', 'A', 3, 1, 5),
    ('UNTERBAU', 'Fundament', 'A', 3, 7, 8),
    ('MATTEN', 'Unterlagen', 'A', 4, 3, 6),
    ('NEIN', 'Absage', 'A', 5, 4, 4),
    ('IDOL', 'Star', 'A', 5, 9, 4),
    ('SARG', 'Totenschrein', 'A', 6, 1, 4),
    ('ENG', 'schmal', 'A', 6, 6, 3),
    ('BITS', 'Binärziffern', 'A', 6, 11, 4),
    ('TUE', 'verrichte', 'A', 7, 1, 3),
    ('DEMOS', 'Kundgebungen', 'A', 7, 10, 5),
    ('UNI', 'Alma Mater', 'A', 8, 1, 3),
    ('FEHLT', 'mangelt', 'A', 8, 5, 5),
    ('RAD', 'Velo', 'A', 8, 11, 3),
    ('MAFIA', 'Cosa Nostra', 'A', 9, 1, 5),
    ('TAGE', 'je 24 Stunden', 'A', 9, 8, 4),
    ('CHEF', 'Boss', 'A', 10, 4, 4),
    ('APP', 'Anwendung', 'A', 10, 12, 3),
    ('MEHRHEIT', 'Großteil', 'A', 11, 2, 8),
    ('STAU', 'Blechlawine', 'A', 11, 11, 4),
    ('GAR', 'durchgekocht', 'A', 12, 1, 3),
    ('REH', 'Waldtier', 'A', 12, 5, 3),
    ('TOTE', 'Verstorbene', 'A', 12, 11, 4),
    ('UMSTAND', 'Faktor', 'A', 13, 1, 7),
    ('ROEMER', 'Latiner', 'A', 13, 9, 6),
    ('TAT', 'Werk', 'A', 14, 1, 3),
    ('EIS', 'Gefrorenes', 'A', 14, 7, 3),
    ('GENE', 'Erbanlagen', 'A', 14, 11, 4),
    ('PLUS', 'Überschuss', 'D', 1, 1, 4),
    ('STUMM', 'wortlos', 'D', 6, 1, 5),
    ('GUT', 'brauchbar', 'D', 12, 1, 3),
    ('HOF', 'Grundstück', 'D', 1, 2, 3),
    ('FAUNA', 'Tierwelt', 'D', 5, 2, 5),
    ('MAMA', 'Mutti', 'D', 11, 2, 4),
    ('ATEM', 'Luft', 'D', 1, 3, 4),
    ('REIF', 'erntefertig', 'D', 6, 3, 4),
    ('ERST', 'anfangs', 'D', 11, 3, 4),
    ('RANG', 'Stellung', 'D', 3, 4, 4),
    ('ICH', 'Pronomen (1. Sg.)', 'D', 9, 4, 3),
    ('ERNTE', 'Lese', 'D', 1, 5, 5),
    ('FAHRRAD', 'Drahtesel', 'D', 8, 5, 7),
    ('TIERE', 'Lebewesen', 'D', 4, 6, 5),
    ('EHEN', 'Verbindungen', 'D', 10, 6, 4),
    ('DUENN', 'mager', 'D', 2, 7, 5),
    ('FEHDE', 'Streit', 'D', 10, 7, 5),
    ('DENN', 'Konjunktion', 'D', 1, 8, 4),
    ('GILT', 'ist gültig', 'D', 6, 8, 4),
    ('TAETERS', 'Spur des ...', 'D', 8, 9, 7),
    ('ABEND', 'Soiree', 'D', 1, 10, 5),
    ('TOR', 'Dummkopf', 'D', 1, 11, 3),
    ('OBERE', 'höhere', 'D', 5, 11, 5),
    ('STEG', 'Brücklein', 'D', 11, 11, 4),
    ('HOB', 'wuchtete', 'D', 1, 12, 3),
    ('LIMA', 'peruan. Hauptstadt', 'D', 5, 12, 4),
    ('ATOME', 'Teilchen', 'D', 10, 12, 5),
    ('ETAT', 'Finanzplan', 'D', 1, 13, 4),
    ('TOD', 'Exitus', 'D', 6, 13, 3),
    ('PATEN', 'Taufzeugen', 'D', 10, 13, 5),
    ('NEU', 'aktuell', 'D', 1, 14, 3),
    ('ASS', 'verspeiste', 'D', 5, 14, 3),
    ('SPUERE', 'fühle', 'D', 9, 14, 6)
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
    ('TEAMS', 'Mannschaften', 'A', 1, 1, 5),
    ('DUISBURG', 'Ruhrstadt', 'A', 1, 7, 8),
    ('AURA', 'Ausstrahlung', 'A', 2, 1, 4),
    ('MOND', 'Erdtrabant', 'A', 2, 6, 4),
    ('NEIN', 'Ablehnung', 'A', 3, 1, 4),
    ('UMSO', 'desto', 'A', 3, 6, 4),
    ('BAHN', 'Zug', 'A', 3, 11, 4),
    ('KREUZES', 'Zeichen des ...', 'A', 4, 1, 7),
    ('TOR', 'Treffer', 'A', 4, 12, 3),
    ('POLE', 'Slawe', 'A', 5, 11, 4),
    ('BALL', 'Kugel', 'A', 6, 1, 4),
    ('DUO', 'Tandem', 'A', 6, 6, 3),
    ('LIMES', 'röm. Grenzwall', 'A', 6, 10, 5),
    ('ADULTEN', 'erwachsenen', 'A', 7, 1, 7),
    ('HOSEN', 'Beinkleider', 'A', 7, 9, 5),
    ('RAD', 'Kreisscheibe', 'A', 8, 1, 3),
    ('ETIKETT', 'Aufkleber', 'A', 8, 5, 7),
    ('ELBE', 'Strom durch Dresden', 'A', 9, 11, 4),
    ('STARR', 'steif', 'A', 10, 1, 5),
    ('AKT', 'Aufzug', 'A', 10, 7, 3),
    ('NERV', 'Reizleiter', 'A', 10, 11, 4),
    ('OEL', 'Rohstoff', 'A', 11, 1, 3),
    ('ALLEIN', 'einsam', 'A', 11, 5, 6),
    ('SEE', 'Gewässer', 'A', 11, 12, 3),
    ('ERBES', 'Wert des ...', 'A', 12, 1, 5),
    ('ARG', 'schlimm', 'A', 12, 7, 3),
    ('HEIL', 'Wohl', 'A', 12, 11, 4),
    ('EISERNE', 'stählerne', 'A', 13, 3, 7),
    ('ART', 'Spezies', 'A', 13, 11, 3),
    ('TONNE', 'Fass', 'A', 14, 1, 5),
    ('MEINEN', 'glauben', 'A', 14, 9, 6),
    ('TANK', 'Behälter', 'D', 1, 1, 4),
    ('BAR', 'Lokal', 'D', 6, 1, 3),
    ('SOEST', 'Stadt in Westfalen', 'D', 10, 1, 5),
    ('EUER', 'Possessiv (ihr)', 'D', 1, 2, 4),
    ('ADAPTER', 'Stecker', 'D', 6, 2, 7),
    ('ARIE', 'Sologesang', 'D', 1, 3, 4),
    ('LUD', 'packte auf', 'D', 6, 3, 3),
    ('ALBEN', 'Platten', 'D', 10, 3, 5),
    ('MANUELL', 'von Hand', 'D', 1, 4, 7),
    ('EIN', 'unbest. Artikel', 'D', 12, 4, 3),
    ('TERRASSE', 'Veranda', 'D', 7, 5, 8),
    ('MUENDET', 'fließt ein', 'D', 2, 6, 7),
    ('DOMS', 'Kuppel des ...', 'D', 1, 7, 4),
    ('UNI', 'Hochschule', 'D', 6, 7, 3),
    ('ALARM', 'Warnsignal', 'D', 10, 7, 5),
    ('UNS', 'Akk./Dat. von wir', 'D', 1, 8, 3),
    ('KERN', 'Mittelpunkt', 'D', 10, 8, 4),
    ('IDOL', 'Star', 'D', 1, 9, 4),
    ('HEUTIGEM', 'aktuellem', 'D', 7, 9, 8),
    ('LOT', 'Senkblei', 'D', 6, 10, 3),
    ('BUB', 'Knabe', 'D', 1, 11, 3),
    ('PISTEN', 'Abfahrten', 'D', 5, 11, 6),
    ('HAI', 'Meeresräuber', 'D', 12, 11, 3),
    ('ATOME', 'Teilchen', 'D', 3, 12, 5),
    ('LESERN', 'Publikum', 'D', 9, 12, 6),
    ('HOLEN', 'besorgen', 'D', 3, 13, 5),
    ('BREITE', 'Weite', 'D', 9, 13, 6),
    ('GENRES', 'Gattungen', 'D', 1, 14, 6),
    ('LEVEL', 'Stufe', 'D', 8, 14, 5)
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
    ('PLAN', 'Absicht', 'A', 1, 1, 4),
    ('UEBERS', 'über das', 'A', 2, 1, 6),
    ('BITTET', 'ersucht', 'A', 3, 1, 6),
    ('ZIEL', 'Zweck', 'A', 4, 4, 4),
    ('WEH', 'schmerzhaft', 'A', 5, 1, 3),
    ('NIE', 'zu keiner Zeit', 'A', 5, 5, 3),
    ('ADELS', 'Titel des ...', 'A', 6, 3, 5),
    ('GAB', 'schenkte', 'A', 7, 1, 3),
    ('SEE', 'Gewässer', 'A', 7, 5, 3),
    ('PUB', 'Wirtshaus', 'D', 1, 1, 3),
    ('WOG', 'schwankte', 'D', 5, 1, 3),
    ('LEISE', 'lautlos', 'D', 1, 2, 5),
    ('ABT', 'Klosterchef', 'D', 1, 3, 3),
    ('HAB', '... und Gut', 'D', 5, 3, 3),
    ('NETZ', 'Geflecht', 'D', 1, 4, 4),
    ('REINES', 'pures', 'D', 2, 5, 6),
    ('STEILE', 'abschüssige', 'D', 2, 6, 6),
    ('LESE', 'schmökere', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r054-8x8-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r054-8x8-02', 'Rätsel 54 · 8×8', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '8x8-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('SAMT', 'inklusive', 'A', 1, 4, 4),
    ('ROTOR', 'Propeller', 'A', 2, 1, 5),
    ('ALARM', 'Warnsignal', 'A', 3, 1, 5),
    ('ZEUG', 'Kram', 'A', 4, 1, 4),
    ('STAUS', 'Blechlawinen', 'A', 5, 3, 5),
    ('CELLE', 'Allerstadt', 'A', 6, 3, 5),
    ('ACH', 'Seufzer', 'A', 7, 1, 3),
    ('BIT', 'Dualziffer', 'A', 7, 5, 3),
    ('RAZZIA', 'Durchsuchung', 'D', 2, 1, 6),
    ('POLE', 'Slawe', 'D', 1, 2, 4),
    ('TAUSCH', 'Wechsel', 'D', 2, 3, 6),
    ('SORGTE', 'kümmerte sich', 'D', 1, 4, 6),
    ('ARM', 'Gliedmaße', 'D', 1, 5, 3),
    ('ALB', 'Gebirge', 'D', 5, 5, 3),
    ('JULI', 'Hochsommermonat', 'D', 4, 6, 4),
    ('TYP', 'Kerl', 'D', 1, 7, 3),
    ('SET', 'Ausstattung', 'D', 5, 7, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r055-8x8-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r055-8x8-03', 'Rätsel 55 · 8×8', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '8x8-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ZUSAGE', 'Einwilligung', 'A', 1, 1, 6),
    ('HEREIN', 'hinein', 'A', 2, 2, 6),
    ('FREIEN', 'ungebundenen', 'A', 3, 1, 6),
    ('ERBE', 'Thronfolger', 'A', 4, 4, 4),
    ('ZOO', 'Tiergarten', 'A', 5, 1, 3),
    ('BAU', 'Konstruktion', 'A', 5, 5, 3),
    ('IHM', 'Dativ von er', 'A', 6, 1, 3),
    ('TUE', 'verrichte', 'A', 6, 5, 3),
    ('TRAT', 'schritt', 'A', 7, 1, 4),
    ('FAZIT', 'Ergebnis', 'D', 3, 1, 5),
    ('UHR', 'Zeitmesser', 'D', 1, 2, 3),
    ('OHR', 'Lauscher', 'D', 5, 2, 3),
    ('SEE', 'Gewässer', 'D', 1, 3, 3),
    ('OMA', 'Großmutter', 'D', 5, 3, 3),
    ('ARIE', 'Opernlied', 'D', 1, 4, 4),
    ('GEERBT', 'übernommen', 'D', 1, 5, 6),
    ('EINBAU', 'Montage', 'D', 1, 6, 6),
    ('EUER', 'Possessiv (ihr)', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r056-9x9-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r056-9x9-01', 'Rätsel 56 · 9×9', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x9-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('FREI', 'kostenlos', 'A', 1, 1, 4),
    ('AKT', 'Aufzug', 'A', 1, 6, 3),
    ('RUIN', 'Untergang', 'A', 2, 1, 4),
    ('PUR', 'rein', 'A', 2, 6, 3),
    ('EHEN', 'Verbindungen', 'A', 3, 1, 4),
    ('PRO', 'je', 'A', 3, 6, 3),
    ('IRRE', 'Verrückte', 'A', 4, 1, 4),
    ('POST', 'Briefe', 'A', 5, 5, 4),
    ('AFFAERE', 'Liebschaft', 'A', 6, 1, 7),
    ('DIENSTE', 'Services', 'A', 7, 1, 7),
    ('TESTEN', 'prüfen', 'A', 8, 2, 6),
    ('FREIBAD', 'Lido', 'D', 1, 1, 7),
    ('RUHR', 'Fluss im Revier', 'D', 1, 2, 4),
    ('FIT', 'sportlich', 'D', 6, 2, 3),
    ('EIER', 'Gelege', 'D', 1, 3, 4),
    ('FEE', 'Elfe', 'D', 6, 3, 3),
    ('INNE', '... halten', 'D', 1, 4, 4),
    ('ANS', 'an das', 'D', 6, 4, 3),
    ('PEST', 'Seuche', 'D', 5, 5, 4),
    ('APP', 'Anwendung', 'D', 1, 6, 3),
    ('ORTE', 'Plätze', 'D', 5, 6, 4),
    ('KUR', 'Erholung', 'D', 1, 7, 3),
    ('SEEN', 'Gewässer', 'D', 5, 7, 4),
    ('TROST', 'Zuspruch', 'D', 1, 8, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r057-9x9-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r057-9x9-02', 'Rätsel 57 · 9×9', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '9x9-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ARIE', 'Sologesang', 'A', 1, 1, 4),
    ('AMT', 'Dienststelle', 'A', 1, 6, 3),
    ('LINIE', 'Strich', 'A', 2, 1, 5),
    ('BOSNIEN', 'Balkanland', 'A', 3, 1, 7),
    ('LIEF', 'rannte', 'A', 4, 5, 4),
    ('EWIGEN', 'endlosen', 'A', 5, 1, 6),
    ('REDE', 'Vortrag', 'A', 6, 1, 4),
    ('BAR', 'Theke', 'A', 6, 6, 3),
    ('BIER', 'Gerstensaft', 'A', 7, 1, 4),
    ('ART', 'Spezies', 'A', 7, 6, 3),
    ('EBEN', 'just', 'A', 8, 1, 4),
    ('UMS', 'um das', 'A', 8, 6, 3),
    ('ALB', 'Gebirge', 'D', 1, 1, 3),
    ('ERBE', 'Nachlass', 'D', 5, 1, 4),
    ('RIO', 'Stadt in Brasilien', 'D', 1, 2, 3),
    ('WEIB', 'Frau (veraltet)', 'D', 5, 2, 4),
    ('INS', 'in das', 'D', 1, 3, 3),
    ('IDEE', 'Einfall', 'D', 5, 3, 4),
    ('EIN', 'unbest. Artikel', 'D', 1, 4, 3),
    ('GERN', 'mit Freude', 'D', 5, 4, 4),
    ('EILE', 'Hektik', 'D', 2, 5, 4),
    ('EINBAU', 'Montage', 'D', 3, 6, 6),
    ('MINE', 'Sprengkörper', 'D', 1, 7, 4),
    ('ARM', 'Extremität', 'D', 6, 7, 3),
    ('FORTS', 'Festungen', 'D', 4, 8, 5)
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
    ('DIAS', 'Lichtbilder', 'A', 1, 1, 4),
    ('DAS', 'Artikel (sächl.)', 'A', 1, 6, 3),
    ('EDLE', 'vornehme', 'A', 2, 1, 4),
    ('UNI', 'Hochschule', 'A', 2, 6, 3),
    ('SOLO', 'allein', 'A', 3, 1, 4),
    ('EHE', 'Vermählung', 'A', 3, 6, 3),
    ('UMSO', 'desto', 'A', 4, 4, 4),
    ('BLUTES', 'Gruppe des ...', 'A', 5, 3, 6),
    ('OPA', 'Großvater', 'A', 6, 1, 3),
    ('SEHE', 'schaue', 'A', 6, 5, 4),
    ('NEU', 'frisch', 'A', 7, 1, 3),
    ('IREN', 'Gälen', 'A', 7, 5, 4),
    ('DRECK', 'Schmutz', 'A', 8, 1, 5),
    ('DES', 'Artikel (Genitiv)', 'D', 1, 1, 3),
    ('MOND', 'Erdtrabant', 'D', 5, 1, 4),
    ('IDOL', 'Vorbild', 'D', 1, 2, 4),
    ('PER', 'mittels', 'D', 6, 2, 3),
    ('ALL', 'Weltraum', 'D', 1, 3, 3),
    ('BAUE', 'errichte', 'D', 5, 3, 4),
    ('SEOUL', 'korean. Hauptstadt', 'D', 1, 4, 5),
    ('MUSIK', 'Tonkunst', 'D', 4, 5, 5),
    ('DUESTER', 'finster', 'D', 1, 6, 7),
    ('ANHOEHE', 'Hügel', 'D', 1, 7, 7),
    ('SIE', 'Anrede', 'D', 1, 8, 3),
    ('SENF', 'Mostrich', 'D', 5, 8, 4)
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
    ('SAGA', 'Heldensage', 'A', 1, 1, 4),
    ('TUERKEI', 'Land am Bosporus', 'A', 1, 6, 7),
    ('ALLE', 'Pronomen', 'A', 2, 1, 4),
    ('NEUSS', 'Stadt am Rhein', 'A', 2, 8, 5),
    ('ALASKA', 'Staat am Yukon', 'A', 3, 1, 6),
    ('DURST', 'Brand (ugs.)', 'A', 3, 8, 5),
    ('STAUSEE', 'Talsperre', 'A', 4, 3, 7),
    ('ELBE', 'Strom durch Hamburg', 'A', 5, 4, 4),
    ('BIN', 'Verbform', 'A', 6, 1, 3),
    ('TEIG', 'Masse', 'A', 6, 5, 4),
    ('OPA', 'Großvater', 'A', 6, 10, 3),
    ('UNI', 'Alma Mater', 'A', 7, 1, 3),
    ('ENTE', 'Falschmeldung', 'A', 7, 5, 4),
    ('HUB', 'Kolbenweg', 'A', 7, 10, 3),
    ('BOXER', 'Faustkämpfer', 'A', 8, 1, 5),
    ('ENGERE', 'schmalere', 'A', 8, 7, 6),
    ('SAAT', 'Samen', 'D', 1, 1, 4),
    ('BUB', 'Junge', 'D', 6, 1, 3),
    ('ALL', 'Weltraum', 'D', 1, 2, 3),
    ('KINO', 'Filmtheater', 'D', 5, 2, 4),
    ('GLAS', 'Trinkgefäß', 'D', 1, 3, 4),
    ('NIX', 'gar nichts', 'D', 6, 3, 3),
    ('AESTE', 'Zweige', 'D', 1, 4, 5),
    ('KALTER', 'frostiger', 'D', 3, 5, 6),
    ('TRAUBEN', 'Weinbeeren', 'D', 1, 6, 7),
    ('SEITE', 'Blatt', 'D', 4, 7, 5),
    ('ENDE', 'Finale', 'D', 1, 8, 4),
    ('GEN', 'nach', 'D', 6, 8, 3),
    ('REUE', 'Zerknirschung', 'D', 1, 9, 4),
    ('KUR', 'Erholung', 'D', 1, 10, 3),
    ('HOHE', 'große', 'D', 5, 10, 4),
    ('ESSE', 'verspeise', 'D', 1, 11, 4),
    ('PUR', 'unverfälscht', 'D', 6, 11, 3),
    ('IST', 'befindet sich', 'D', 1, 12, 3),
    ('RABE', 'Unglücksvogel', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r060-9x13-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r060-9x13-02', 'Rätsel 60 · 9×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x13-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('BOT', 'offerierte', 'A', 1, 1, 3),
    ('GEN', 'Erbanlage', 'A', 1, 6, 3),
    ('UMS', 'um das', 'A', 1, 10, 3),
    ('UHR', 'Zeitmesser', 'A', 2, 1, 3),
    ('GEBE', 'reiche', 'A', 2, 5, 4),
    ('RAT', 'Tipp', 'A', 2, 10, 3),
    ('DIAS', 'Lichtbilder', 'A', 3, 1, 4),
    ('HEUTIGE', 'aktuelle', 'A', 3, 6, 7),
    ('GOTT', 'Schöpfer', 'A', 4, 1, 4),
    ('INNEN', 'intern', 'A', 4, 6, 5),
    ('EHRE', 'Prestige', 'A', 5, 4, 4),
    ('TOLLEN', 'großartigen', 'A', 6, 1, 6),
    ('ALLEM', 'vor ...', 'A', 6, 8, 5),
    ('POLE', 'Slawe', 'A', 7, 2, 4),
    ('ALTONA', 'Hamburger Bezirk', 'A', 7, 7, 6),
    ('FASERN', 'Fäden', 'A', 8, 1, 6),
    ('BEBEN', 'Erdstoß', 'A', 8, 8, 5),
    ('BUDGET', 'Etat', 'D', 1, 1, 6),
    ('OHIO', 'Staat um Cleveland', 'D', 1, 2, 4),
    ('OPA', 'Opi', 'D', 6, 2, 3),
    ('TRAT', 'schritt', 'D', 1, 3, 4),
    ('LOS', 'ledig', 'D', 6, 3, 3),
    ('STELLE', 'Posten', 'D', 3, 4, 6),
    ('HEER', 'Armee', 'D', 5, 5, 4),
    ('GEHIRN', 'Denkorgan', 'D', 1, 6, 6),
    ('EBENE', 'Fläche', 'D', 1, 7, 5),
    ('NEUN', 'Zahl (3×3)', 'D', 1, 8, 4),
    ('ALB', 'Gebirge', 'D', 6, 8, 3),
    ('TEILTE', 'trennte', 'D', 3, 9, 6),
    ('URIN', 'Harn', 'D', 1, 10, 4),
    ('LOB', 'Anerkennung', 'D', 6, 10, 3),
    ('MAG', 'hat gern', 'D', 1, 11, 3),
    ('JENE', 'selbige', 'D', 5, 11, 4),
    ('STEG', 'Brücklein', 'D', 1, 12, 4),
    ('MAN', 'Pronomen', 'D', 6, 12, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r061-9x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r061-9x13-03', 'Rätsel 61 · 9×13', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('TUER', 'Eingang', 'A', 1, 1, 4),
    ('MADONNA', 'Muttergottes', 'A', 1, 6, 7),
    ('ANSAGE', 'Durchsage', 'A', 2, 1, 6),
    ('AREAL', 'Gelände', 'A', 2, 8, 5),
    ('LISTEN', 'Tabellen', 'A', 3, 1, 6),
    ('STUHL', 'Sitz', 'A', 3, 8, 5),
    ('NUSS', 'Kern', 'A', 4, 5, 4),
    ('RAET', 'empfiehlt', 'A', 5, 4, 4),
    ('FROH', 'heiter', 'A', 5, 9, 4),
    ('ABBAU', 'Förderung', 'A', 6, 1, 5),
    ('EUROPA', 'Erdteil', 'A', 6, 7, 6),
    ('BOOTE', 'Kähne', 'A', 7, 1, 5),
    ('EHER', 'vielmehr', 'A', 7, 9, 4),
    ('EXTERNE', 'äußere', 'A', 8, 1, 7),
    ('IRRT', 'täuscht sich', 'A', 8, 9, 4),
    ('TAL', 'Niederung', 'D', 1, 1, 3),
    ('GABE', 'Geschenk', 'D', 5, 1, 4),
    ('UNI', 'Hochschule', 'D', 1, 2, 3),
    ('BOX', 'Schachtel', 'D', 6, 2, 3),
    ('ESSE', 'speise', 'D', 1, 3, 4),
    ('BOT', 'offerierte', 'D', 6, 3, 3),
    ('RAT', 'Gremium', 'D', 1, 4, 3),
    ('RATE', 'Teilzahlung', 'D', 5, 4, 4),
    ('GENAUER', 'exakter', 'D', 2, 5, 7),
    ('MENUE', 'Speisenfolge', 'D', 1, 6, 5),
    ('STEHE', 'ich ... auf', 'D', 4, 7, 5),
    ('DASS', 'Konjunktion', 'D', 1, 8, 4),
    ('ORT', 'Stelle', 'D', 1, 9, 3),
    ('FREI', 'ungebunden', 'D', 5, 9, 4),
    ('NEU', 'aktuell', 'D', 1, 10, 3),
    ('ROHR', 'Leitung', 'D', 5, 10, 4),
    ('NAH', 'unweit', 'D', 1, 11, 3),
    ('OPER', 'Musiktheater', 'D', 5, 11, 4),
    ('ALL', 'Weltraum', 'D', 1, 12, 3),
    ('HART', 'fest', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r062-10x10-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r062-10x10-01', 'Rätsel 62 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('JOB', 'Beruf', 'A', 1, 1, 3),
    ('STAB', 'Stock', 'A', 1, 6, 4),
    ('EMAIL', 'digitale Post', 'A', 2, 1, 5),
    ('UNI', 'Hochschule', 'A', 2, 7, 3),
    ('NEST', 'Horst', 'A', 3, 1, 4),
    ('FEST', 'solide', 'A', 3, 6, 4),
    ('ANSAGE', 'Durchsage', 'A', 4, 1, 6),
    ('LUECKE', 'Spalt', 'A', 5, 4, 6),
    ('LIMIT', 'Grenze', 'A', 6, 1, 5),
    ('HAI', 'Raubfisch', 'A', 6, 7, 3),
    ('IDEE', 'Gedanke', 'A', 7, 1, 4),
    ('PASS', 'Ausweis', 'A', 7, 6, 4),
    ('LOHN', 'Gehalt', 'A', 8, 1, 4),
    ('ROSE', 'Blume mit Dornen', 'A', 8, 6, 4),
    ('ALL', 'Weltraum', 'A', 9, 1, 3),
    ('DOSEN', 'Büchsen', 'A', 9, 5, 5),
    ('JENA', 'Saalestadt', 'D', 1, 1, 4),
    ('LILA', 'Violett', 'D', 6, 1, 4),
    ('OMEN', 'Vorzeichen', 'D', 1, 2, 4),
    ('IDOL', 'Vorbild', 'D', 6, 2, 4),
    ('BASS', 'tiefe Stimme', 'D', 1, 3, 4),
    ('MEHL', 'Backzutat', 'D', 6, 3, 4),
    ('ITALIEN', 'Stiefelland', 'D', 2, 4, 7),
    ('GUT', 'brauchbar', 'D', 4, 5, 3),
    ('FEE', 'Elfe', 'D', 3, 6, 3),
    ('PRO', 'je', 'D', 7, 6, 3),
    ('TUE', 'verrichte', 'D', 1, 7, 3),
    ('CHAOS', 'Wirrwarr', 'D', 5, 7, 5),
    ('ANS', 'an das', 'D', 1, 8, 3),
    ('KASSE', 'Zahlstelle', 'D', 5, 8, 5),
    ('BIT', 'Binärziffer', 'D', 1, 9, 3),
    ('EISEN', 'Ferrum', 'D', 5, 9, 5)
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
    ('ABT', 'Ordensoberer', 'A', 1, 1, 3),
    ('SPIKE', 'Dorn', 'A', 1, 5, 5),
    ('LAUTE', 'Töne', 'A', 2, 1, 5),
    ('RAD', 'Velo', 'A', 2, 7, 3),
    ('BREIT', 'weit', 'A', 3, 1, 5),
    ('ALL', 'Kosmos', 'A', 3, 7, 3),
    ('PUNKTE', 'Score', 'A', 4, 4, 6),
    ('ETAPPE', 'Abschnitt', 'A', 5, 1, 6),
    ('TON', 'Lehm', 'A', 6, 1, 3),
    ('BROT', 'Laib', 'A', 6, 6, 4),
    ('WEG', 'Pfad', 'A', 7, 1, 3),
    ('SEIDE', 'Gewebe', 'A', 7, 5, 5),
    ('ANS', 'an das', 'A', 8, 1, 3),
    ('ENGES', 'schmales', 'A', 8, 5, 5),
    ('SETZT', 'stellt', 'A', 9, 1, 5),
    ('ART', 'Spezies', 'A', 9, 7, 3),
    ('ALB', 'Gebirge', 'D', 1, 1, 3),
    ('ETWAS', 'irgendwas', 'D', 5, 1, 5),
    ('BAR', 'Theke', 'D', 1, 2, 3),
    ('TOENE', 'Klänge', 'D', 5, 2, 5),
    ('TUE', 'verrichte', 'D', 1, 3, 3),
    ('ANGST', 'Furcht', 'D', 5, 3, 5),
    ('TIPP', 'Hinweis', 'D', 2, 4, 4),
    ('SETUP', 'Einrichtung', 'D', 1, 5, 5),
    ('SET', 'Ausstattung', 'D', 7, 5, 3),
    ('NEBEN', 'seitlich von', 'D', 4, 6, 5),
    ('IRAK', 'Zweistromland', 'D', 1, 7, 4),
    ('RIGA', 'lett. Hauptstadt', 'D', 6, 7, 4),
    ('KALT', 'frostig', 'D', 1, 8, 4),
    ('ODER', 'bzw.', 'D', 6, 8, 4),
    ('EDLE', 'vornehme', 'D', 1, 9, 4),
    ('TEST', 'Klausur', 'D', 6, 9, 4)
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
    ('BLOED', 'doof', 'A', 1, 1, 5),
    ('HEU', 'Trockengras', 'A', 1, 7, 3),
    ('LEST', 'schmökert', 'A', 2, 1, 4),
    ('ARM', 'Gliedmaße', 'A', 2, 7, 3),
    ('AUCH', 'ebenfalls', 'A', 3, 1, 4),
    ('BASS', 'tiefe Stimme', 'A', 3, 6, 4),
    ('STANDORT', 'Lage', 'A', 4, 1, 8),
    ('SERIEN', 'Reihen', 'A', 5, 1, 6),
    ('ERNSTE', 'seriöse', 'A', 6, 4, 6),
    ('FEINE', 'zarte', 'A', 7, 1, 5),
    ('TOT', 'verstorben', 'A', 7, 7, 3),
    ('EIS', 'Sorbet', 'A', 8, 1, 3),
    ('NIERE', 'Harnorgan', 'A', 8, 5, 5),
    ('ENTE', 'Wasservogel', 'A', 9, 1, 4),
    ('GEN', 'nach', 'A', 9, 7, 3),
    ('BLASS', 'bleich', 'D', 1, 1, 5),
    ('FEE', 'Elfe', 'D', 7, 1, 3),
    ('LEUTE', 'Volk', 'D', 1, 2, 5),
    ('EIN', 'unbest. Artikel', 'D', 7, 2, 3),
    ('OSCAR', 'Academy Award', 'D', 1, 3, 5),
    ('IST', 'befindet sich', 'D', 7, 3, 3),
    ('ETHNIEN', 'Volksgruppen', 'D', 1, 4, 7),
    ('DEREN', 'Pronomen', 'D', 4, 5, 5),
    ('BONN', 'Ex-Hauptstadt', 'D', 3, 6, 4),
    ('HAAR', 'Strähne', 'D', 1, 7, 4),
    ('STEG', 'Bootsanleger', 'D', 6, 7, 4),
    ('ERST', 'zunächst', 'D', 1, 8, 4),
    ('TORE', 'Treffer', 'D', 6, 8, 4),
    ('UMS', 'um das', 'D', 1, 9, 3),
    ('BETEN', 'flehen', 'D', 5, 9, 5)
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
    ('REST', 'Überbleibsel', 'A', 1, 1, 4),
    ('NASS', 'feucht', 'A', 1, 6, 4),
    ('AXT', 'Tomahawk', 'A', 2, 1, 3),
    ('KALTE', 'frostige', 'A', 2, 5, 5),
    ('UTAH', 'Mormonenstaat', 'A', 3, 1, 4),
    ('ETAT', 'Finanzplan', 'A', 3, 6, 4),
    ('ERDE', 'Heimatplanet', 'A', 4, 1, 4),
    ('HERZ', 'Pumpe', 'A', 4, 6, 4),
    ('AELTESTE', 'erstgeborene', 'A', 5, 2, 8),
    ('DIR', 'Dat. (2. Pers.)', 'A', 6, 4, 3),
    ('ASIEN', 'Erdteil', 'A', 7, 1, 5),
    ('AST', 'Knorren', 'A', 7, 7, 3),
    ('BAHNT', 'ebnet', 'A', 8, 1, 5),
    ('RIO', 'Stadt in Brasilien', 'A', 8, 7, 3),
    ('UHR', 'Zeitmesser', 'A', 9, 1, 3),
    ('EIGEN', 'seltsam', 'A', 9, 5, 5),
    ('RAUE', 'grobe', 'D', 1, 1, 4),
    ('TABU', 'verboten', 'D', 6, 1, 4),
    ('EXTRA', 'zusätzlich', 'D', 1, 2, 5),
    ('SAH', 'erblickte', 'D', 7, 2, 3),
    ('STADE', 'Elbhafen', 'D', 1, 3, 5),
    ('IHR', 'Pronomen (2. Pl.)', 'D', 7, 3, 3),
    ('HELDEN', 'Recken', 'D', 3, 4, 6),
    ('TINTE', 'Tusche', 'D', 5, 5, 5),
    ('NAEHER', 'enger', 'D', 1, 6, 6),
    ('ALTES', 'betagtes', 'D', 1, 7, 5),
    ('ARG', 'übel', 'D', 7, 7, 3),
    ('START', 'Beginn', 'D', 1, 8, 5),
    ('SIE', 'Anrede', 'D', 7, 8, 3),
    ('SETZE', 'stelle', 'D', 1, 9, 5),
    ('TON', 'Klang', 'D', 7, 9, 3)
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
    ('LAGE', 'Position', 'A', 1, 1, 4),
    ('BLASS', 'bleich', 'A', 1, 6, 5),
    ('OPA', 'Opi', 'A', 2, 1, 3),
    ('BEI', 'nahe an', 'A', 2, 8, 3),
    ('TRUGEN', 'schleppten', 'A', 3, 1, 6),
    ('TON', 'Lehm', 'A', 3, 8, 3),
    ('ZEUG', 'Kram', 'A', 4, 7, 4),
    ('BLOED', 'doof', 'A', 5, 1, 5),
    ('EILE', 'Hektik', 'A', 5, 7, 4),
    ('TROST', 'Zuspruch', 'A', 6, 3, 5),
    ('TOT', 'verstorben', 'A', 7, 1, 3),
    ('MUTIG', 'tapfer', 'A', 7, 5, 5),
    ('TRAT', 'stapfte', 'A', 8, 1, 4),
    ('DEREN', 'dessen', 'A', 8, 6, 5),
    ('ETWA', 'vielleicht', 'A', 9, 1, 4),
    ('ALIBI', 'Entlastung', 'A', 9, 6, 5),
    ('REALEN', 'wirklichen', 'A', 10, 1, 6),
    ('SEX', 'Geschlecht', 'A', 10, 8, 3),
    ('LOT', 'Senkrechte', 'D', 1, 1, 3),
    ('BUTTER', 'Streichfett', 'D', 5, 1, 6),
    ('APRIL', '4. Monat', 'D', 1, 2, 5),
    ('ORTE', 'Stellen', 'D', 7, 2, 4),
    ('GAU', 'Landesteil', 'D', 1, 3, 3),
    ('OTTAWA', 'kanad. Hauptstadt', 'D', 5, 3, 6),
    ('GIER', 'Habsucht', 'D', 3, 4, 4),
    ('TAL', 'Senke', 'D', 8, 4, 3),
    ('DOM', 'Münster', 'D', 5, 5, 3),
    ('BIN', 'existiere', 'D', 1, 6, 3),
    ('SUDAN', 'Staat am Nil', 'D', 6, 6, 5),
    ('ZETTEL', 'Notizblatt', 'D', 4, 7, 6),
    ('ABTEI', 'Kloster', 'D', 1, 8, 5),
    ('IRIS', 'Regenbogenhaut', 'D', 7, 8, 4),
    ('SEOUL', 'korean. Hauptstadt', 'D', 1, 9, 5),
    ('GEBE', 'reiche', 'D', 7, 9, 4),
    ('SINGEN', 'trällern', 'D', 1, 10, 6),
    ('NIX', 'gar nichts', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r067-11x11-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r067-11x11-02', 'Rätsel 67 · 11×11', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '11x11-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('LAS', 'entzifferte', 'A', 1, 1, 3),
    ('NAMENS', 'mit Namen', 'A', 1, 5, 6),
    ('IRAK', 'Land am Tigris', 'A', 2, 1, 4),
    ('RADIO', 'Rundfunk', 'A', 2, 6, 5),
    ('LAG', 'befand sich', 'A', 3, 1, 3),
    ('ZELLEN', 'Kammern', 'A', 3, 5, 6),
    ('ABT', 'Klosterchef', 'A', 4, 1, 3),
    ('FRAU', 'Dame', 'A', 5, 4, 4),
    ('FREIE', 'ungebundene', 'A', 6, 1, 5),
    ('RUND', 'kreisförmig', 'A', 6, 7, 4),
    ('STIFTETE', 'spendete', 'A', 7, 3, 8),
    ('WAS', 'Fragewort (Sache)', 'A', 8, 1, 3),
    ('SOEBEN', 'gerade', 'A', 8, 5, 6),
    ('EUER', 'Possessiv (ihr)', 'A', 9, 1, 4),
    ('TIERE', 'Lebewesen', 'A', 9, 6, 5),
    ('GEN', 'Erbanlage', 'A', 10, 1, 3),
    ('WOLLEN', 'Verbform', 'A', 10, 5, 6),
    ('LILA', 'Violett', 'D', 1, 1, 4),
    ('WEG', 'Pfad', 'D', 8, 1, 3),
    ('ARABER', 'Pferderasse', 'D', 1, 2, 6),
    ('AUE', 'Wiesenland', 'D', 8, 2, 3),
    ('SAGT', 'äußert', 'D', 1, 3, 4),
    ('ESSEN', 'Ruhrgebietsstadt', 'D', 6, 3, 5),
    ('FIT', 'gesund', 'D', 5, 4, 3),
    ('REIS', 'Sushi-Zutat', 'D', 5, 5, 4),
    ('ARENA', 'Kolosseum', 'D', 1, 6, 5),
    ('FOTO', 'Aufnahme', 'D', 7, 6, 4),
    ('MAL', 'einst', 'D', 1, 7, 3),
    ('URTEIL', 'Verdikt', 'D', 5, 7, 6),
    ('EDLE', 'noble', 'D', 1, 8, 4),
    ('UEBEL', 'schlecht', 'D', 6, 8, 5),
    ('NIE', 'zu keiner Zeit', 'D', 1, 9, 3),
    ('UNTERE', 'tiefere', 'D', 5, 9, 6),
    ('SONG', 'Lied', 'D', 1, 10, 4),
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
    ('CHEF', 'Boss', 'A', 1, 1, 4),
    ('AKKU', 'Batterie', 'A', 1, 7, 4),
    ('HAI', 'Meeresräuber', 'A', 2, 1, 3),
    ('VILLEN', 'Landhäuser', 'A', 2, 5, 6),
    ('OBST', 'Früchte', 'A', 3, 1, 4),
    ('STARS', 'Prominente', 'A', 3, 6, 5),
    ('ESSENZ', 'Kern', 'A', 4, 4, 6),
    ('STRITT', 'zankte', 'A', 5, 1, 6),
    ('GEN', 'nach', 'A', 5, 8, 3),
    ('OELE', 'Fette', 'A', 6, 2, 4),
    ('HUT', 'Kopfbedeckung', 'A', 7, 1, 3),
    ('INS', 'in das', 'A', 7, 5, 3),
    ('ART', 'Spezies', 'A', 8, 1, 3),
    ('LACHEN', 'Gelächter', 'A', 8, 5, 6),
    ('STEG', 'Bootsanleger', 'A', 9, 1, 4),
    ('HAITI', 'Karibikstaat', 'A', 9, 6, 5),
    ('SET', 'Satz', 'A', 10, 1, 3),
    ('ERNTE', 'Lese', 'A', 10, 6, 5),
    ('CHORS', 'Leiter des ...', 'D', 1, 1, 5),
    ('HASS', 'Abscheu', 'D', 7, 1, 4),
    ('HAB', 'Besitz', 'D', 1, 2, 3),
    ('TOURTE', 'reiste', 'D', 5, 2, 6),
    ('EIS', 'Sorbet', 'D', 1, 3, 3),
    ('RETTET', 'birgt', 'D', 5, 3, 6),
    ('TEIL', 'Stück', 'D', 3, 4, 4),
    ('STEIL', 'abschüssig', 'D', 4, 5, 5),
    ('ISST', 'speist', 'D', 2, 6, 4),
    ('NAHE', 'benachbart', 'D', 7, 6, 4),
    ('ALTE', 'betagte', 'D', 1, 7, 4),
    ('OSCAR', 'Academy Award', 'D', 6, 7, 5),
    ('KLANG', 'Ton', 'D', 1, 8, 5),
    ('HIN', 'fort', 'D', 8, 8, 3),
    ('KERZE', 'Licht', 'D', 1, 9, 5),
    ('FETT', 'Schmalz', 'D', 7, 9, 4),
    ('UNS', 'Akk./Dat. von wir', 'D', 1, 10, 3),
    ('NIE', 'nimmer', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r069-12x12-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r069-12x12-02', 'Rätsel 69 · 12×12', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '12x12-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ERST', 'zunächst', 'A', 1, 1, 4),
    ('IREN', 'Kelten', 'A', 1, 8, 4),
    ('VITA', 'Lebenslauf', 'A', 2, 1, 4),
    ('INNERE', 'interne', 'A', 2, 6, 6),
    ('ETAGEN', 'Stockwerke', 'A', 3, 1, 6),
    ('SAFT', 'Most', 'A', 3, 8, 4),
    ('NUN', 'inzwischen', 'A', 4, 1, 3),
    ('LOT', 'Senkrechte', 'A', 4, 9, 3),
    ('TAGS', '... darauf', 'A', 5, 1, 4),
    ('TITEL', 'Überschrift', 'A', 5, 6, 5),
    ('LEERE', 'Vakuum', 'A', 6, 2, 5),
    ('ENGE', 'schmale', 'A', 6, 8, 4),
    ('RENTEN', 'Altersbezüge', 'A', 7, 1, 6),
    ('ALS', 'da, während', 'A', 8, 7, 3),
    ('STAR', 'Berühmtheit', 'A', 9, 1, 4),
    ('UTAH', 'Salzsee-Staat', 'A', 9, 8, 4),
    ('EUROPA', 'Erdteil', 'A', 10, 1, 6),
    ('NEUE', 'moderne', 'A', 10, 8, 4),
    ('REGT', 'bewegt', 'A', 11, 1, 4),
    ('ROGGEN', 'Getreide', 'A', 11, 6, 6),
    ('EVENT', 'Ereignis', 'D', 1, 1, 5),
    ('RASER', 'Temposünder', 'D', 7, 1, 5),
    ('RITUALE', 'Zeremonien', 'D', 1, 2, 7),
    ('TUE', 'verrichte', 'D', 9, 2, 3),
    ('STANGEN', 'Stäbe', 'D', 1, 3, 7),
    ('ARG', 'übel', 'D', 9, 3, 3),
    ('TAG', 'Kalenderblatt', 'D', 1, 4, 3),
    ('SET', 'Ausstattung', 'D', 5, 4, 3),
    ('ROT', 'purpurn', 'D', 9, 4, 3),
    ('REH', 'Waldbewohner', 'D', 6, 5, 3),
    ('MINUTEN', 'je 60 Sekunden', 'D', 1, 6, 7),
    ('DAR', 'stellt ... (zeigt)', 'D', 9, 6, 3),
    ('INS', 'in das', 'D', 1, 8, 3),
    ('TEILUNG', 'Spaltung', 'D', 5, 8, 7),
    ('REALEN', 'wirklichen', 'D', 1, 9, 6),
    ('STEG', 'Brücklein', 'D', 8, 9, 4),
    ('ERFOLG', 'Triumph', 'D', 1, 10, 6),
    ('AUE', 'Wiesenland', 'D', 9, 10, 3),
    ('NETT', 'sympathisch', 'D', 1, 11, 4),
    ('EICHEN', 'Laubbäume', 'D', 6, 11, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r070-12x12-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r070-12x12-03', 'Rätsel 70 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('PAARE', 'Duos', 'A', 1, 1, 5),
    ('SOWIE', 'und', 'A', 1, 7, 5),
    ('ANKUNFT', 'Eintreffen', 'A', 2, 1, 7),
    ('IHN', 'Akkusativ von er', 'A', 2, 9, 3),
    ('KLUFT', 'Spalte', 'A', 3, 1, 5),
    ('ERZ', 'Gestein', 'A', 3, 9, 3),
    ('TAT', 'Werk', 'A', 4, 1, 3),
    ('EBEN', 'flach', 'A', 4, 5, 4),
    ('NUR', 'lediglich', 'A', 5, 5, 3),
    ('KAM', 'traf ein', 'A', 5, 9, 3),
    ('ISST', 'speist', 'A', 6, 1, 4),
    ('THRONT', 'sitzt erhaben', 'A', 7, 5, 6),
    ('DAR', 'Verbvorsilbe', 'A', 8, 1, 3),
    ('ITALIEN', 'Stiefelland', 'A', 8, 5, 7),
    ('REALE', 'wirkliche', 'A', 9, 1, 5),
    ('SZENE', 'Auftritt', 'A', 9, 7, 5),
    ('ERHOFFT', 'erwartet', 'A', 10, 1, 7),
    ('ROT', 'purpurn', 'A', 10, 9, 3),
    ('HALBE', 'zur ... Stunde', 'A', 11, 1, 5),
    ('HERZ', 'Pumpe', 'A', 11, 8, 4),
    ('PAKT', 'Bündnis', 'D', 1, 1, 4),
    ('DREH', 'Kniff', 'D', 8, 1, 4),
    ('ANLASS', 'Gelegenheit', 'D', 1, 2, 6),
    ('AERA', 'Epoche', 'D', 8, 2, 4),
    ('AKUT', 'dringend', 'D', 1, 3, 4),
    ('STRAHL', 'Lichtbündel', 'D', 6, 3, 6),
    ('RUF', 'Leumund', 'D', 1, 4, 3),
    ('LOB', 'Anerkennung', 'D', 9, 4, 3),
    ('ENTEN', 'Wasservögel', 'D', 1, 5, 5),
    ('TIEFE', 'Abgrund', 'D', 7, 5, 5),
    ('BUCHT', 'Golf', 'D', 4, 6, 5),
    ('STIER', 'Sternzeichen', 'D', 1, 7, 5),
    ('RAST', 'jagt', 'D', 7, 7, 4),
    ('HOLZ', 'Werkstoff', 'D', 6, 8, 4),
    ('WIE', 'gleich', 'D', 1, 9, 3),
    ('NIERE', 'Organ', 'D', 7, 9, 5),
    ('IHR', 'Pronomen (2. Pl.)', 'D', 1, 10, 3),
    ('TENOR', 'Sängerstimme', 'D', 7, 10, 5),
    ('ENZYME', 'Fermente', 'D', 1, 11, 6),
    ('NETZ', 'Geflecht', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r071-12x12-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r071-12x12-04', 'Rätsel 71 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AUFSTAND', 'Revolte', 'A', 1, 1, 8),
    ('TEUER', 'kostspielig', 'A', 2, 1, 5),
    ('ARG', 'schlimm', 'A', 2, 7, 3),
    ('EBENE', 'Flachland', 'A', 3, 1, 5),
    ('HAELT', 'stoppt', 'A', 3, 7, 5),
    ('MERKT', 'spürt', 'A', 4, 1, 5),
    ('UNIS', 'Hochschulen', 'A', 4, 8, 4),
    ('TELEFONE', 'Fernsprecher', 'A', 5, 4, 8),
    ('SIE', 'Anrede', 'A', 6, 9, 3),
    ('VOR', 'ehe', 'A', 7, 2, 3),
    ('DIESE', 'Pronomen', 'A', 7, 6, 5),
    ('HOLE', 'besorge', 'A', 8, 1, 4),
    ('ALT', 'ergraut', 'A', 8, 6, 3),
    ('ARCHIV', 'Ablage', 'A', 9, 1, 6),
    ('WADE', 'Beinmuskel', 'A', 9, 8, 4),
    ('SAH', 'blickte', 'A', 10, 1, 3),
    ('ARIE', 'Sologesang', 'A', 10, 8, 4),
    ('EBEN', 'flach', 'A', 11, 1, 4),
    ('NESTER', 'Horste', 'A', 11, 6, 6),
    ('ATEM', 'Odem', 'D', 1, 1, 4),
    ('HASE', 'Meister Lampe', 'D', 8, 1, 4),
    ('UEBER', 'oberhalb', 'D', 1, 2, 5),
    ('VORAB', 'vorher', 'D', 7, 2, 5),
    ('FUER', 'zugunsten', 'D', 1, 3, 4),
    ('SOLCHE', 'derartige', 'D', 6, 3, 6),
    ('SENKT', 'reduziert', 'D', 1, 4, 5),
    ('REH', 'Waldbewohner', 'D', 7, 4, 3),
    ('TRETEN', 'kicken', 'D', 1, 5, 6),
    ('DAVON', 'hiervon', 'D', 7, 6, 5),
    ('NAH', 'dicht', 'D', 1, 7, 3),
    ('EXIL', 'Verbannung', 'D', 5, 7, 4),
    ('DRAUF', 'darauf', 'D', 1, 8, 5),
    ('ETWAS', 'irgendwas', 'D', 7, 8, 5),
    ('GENOSS', 'kostete aus', 'D', 2, 9, 6),
    ('ART', 'Sorte', 'D', 9, 9, 3),
    ('LINIE', 'Strich', 'D', 3, 10, 5),
    ('DIE', 'Artikel (weibl.)', 'D', 9, 10, 3),
    ('OSTSEE', 'Baltisches Meer', 'D', 1, 11, 6),
    ('MEER', 'See', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r072-12x12-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r072-12x12-01', 'Rätsel 72 · 12×12', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '12x12-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('OPA', 'Opi', 'A', 1, 1, 3),
    ('BOOM', 'Aufschwung', 'A', 1, 8, 4),
    ('VULKAN', 'Feuerberg', 'A', 2, 1, 6),
    ('ARME', 'Mittellose', 'A', 2, 8, 4),
    ('ABT', 'Ordensoberer', 'A', 3, 1, 3),
    ('SAUGEN', 'lutschen', 'A', 3, 6, 6),
    ('IMMENS', 'riesig', 'A', 4, 6, 6),
    ('ERLERNT', 'studiert', 'A', 5, 1, 7),
    ('EINEN', 'unbest. Art. (Akk.)', 'A', 6, 2, 5),
    ('RHEIN', 'dt. Strom', 'A', 7, 1, 5),
    ('GRAUE', 'trübe', 'A', 7, 7, 5),
    ('BAT', 'ersuchte', 'A', 8, 3, 3),
    ('RAGEN', 'aufsteigen', 'A', 8, 7, 5),
    ('UMS', 'um das', 'A', 9, 1, 3),
    ('EROBERT', 'eingenommen', 'A', 9, 5, 7),
    ('MATT', 'Schachende', 'A', 10, 1, 4),
    ('ABENDE', 'Soireen', 'A', 10, 6, 6),
    ('SIE', 'Anrede', 'A', 11, 1, 3),
    ('RESTEN', 'Abfällen', 'A', 11, 6, 6),
    ('OVALE', 'eiförmige', 'D', 1, 1, 5),
    ('RAUMS', 'Mitte des ...', 'D', 7, 1, 5),
    ('PUB', 'Wirtshaus', 'D', 1, 2, 3),
    ('REH', 'Waldbewohner', 'D', 5, 2, 3),
    ('MAI', 'Wonnemonat', 'D', 9, 2, 3),
    ('ALT', 'ergraut', 'D', 1, 3, 3),
    ('LIEBSTE', 'bevorzugte', 'D', 5, 3, 7),
    ('KENIA', 'Staat in Ostafrika', 'D', 4, 4, 5),
    ('RENTE', 'Pension', 'D', 5, 5, 5),
    ('UNSINN', 'Blödsinn', 'D', 1, 6, 6),
    ('RAR', 'selten', 'D', 9, 6, 3),
    ('AMT', 'Behörde', 'D', 3, 7, 3),
    ('GROBE', 'raue', 'D', 7, 7, 5),
    ('BAUM', 'Gehölz', 'D', 1, 8, 4),
    ('GRABES', 'Stille des ...', 'D', 6, 8, 6),
    ('ORGEL', 'Instrument', 'D', 1, 9, 5),
    ('AGENT', 'Spion', 'D', 7, 9, 5),
    ('OMEN', 'Vorbote', 'D', 1, 10, 4),
    ('HUERDE', 'Hindernis', 'D', 6, 10, 6),
    ('MENSA', 'Kantine', 'D', 1, 11, 5),
    ('ENTEN', 'Schwimmvögel', 'D', 7, 11, 5)
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
    ('APP', 'Anwendung', 'A', 1, 1, 3),
    ('ASS', 'verspeiste', 'A', 1, 5, 3),
    ('ISST', 'verzehrt', 'A', 1, 9, 4),
    ('KRUG', 'Kanne', 'A', 2, 1, 4),
    ('POCHT', 'klopft', 'A', 2, 6, 5),
    ('TIBETER', 'Himalaya-Volk', 'A', 3, 1, 7),
    ('MEHL', 'Backzutat', 'A', 3, 9, 4),
    ('NOETE', 'Sorgen', 'A', 4, 4, 5),
    ('BAT', 'ersuchte', 'A', 5, 1, 3),
    ('DREIZEHN', 'Unglückszahl', 'A', 5, 5, 8),
    ('ETAGE', 'Stockwerk', 'A', 6, 1, 5),
    ('NEIN', 'Absage', 'A', 6, 7, 4),
    ('SEX', 'Erotik', 'A', 7, 1, 3),
    ('REDEN', 'sprechen', 'A', 7, 8, 5),
    ('TRIO', 'Dreiergruppe', 'A', 8, 1, 4),
    ('FANG', 'Beute', 'A', 8, 6, 4),
    ('EILE', 'Hast', 'A', 9, 9, 4),
    ('ATELIER', 'Werkstatt', 'A', 10, 2, 7),
    ('RAN', 'heran', 'A', 10, 10, 3),
    ('PLURAL', 'Mehrzahl', 'A', 11, 1, 6),
    ('IST', 'befindet sich', 'A', 11, 10, 3),
    ('SENSE', 'Mähwerkzeug', 'A', 12, 2, 5),
    ('MESSE', 'Gottesdienst', 'A', 12, 8, 5),
    ('AKT', 'Nacktgemälde', 'D', 1, 1, 3),
    ('BESTE', 'optimale', 'D', 5, 1, 5),
    ('PRIVATER', 'persönlicher', 'D', 1, 2, 8),
    ('ALS', 'da, während', 'D', 10, 2, 3),
    ('PUB', 'Wirtshaus', 'D', 1, 3, 3),
    ('TAXI', 'Droschke', 'D', 5, 3, 4),
    ('TUE', 'verrichte', 'D', 10, 3, 3),
    ('GEN', 'nach', 'D', 2, 4, 3),
    ('OPERN', 'Musikdramen', 'D', 8, 4, 5),
    ('TODE', 'zu ... betrübt', 'D', 3, 5, 4),
    ('LAS', 'entzifferte', 'D', 10, 5, 3),
    ('SPEER', 'Wurfspieß', 'D', 1, 6, 5),
    ('PFEILE', 'Geschosse', 'D', 7, 6, 6),
    ('SORTEN', 'Arten', 'D', 1, 7, 6),
    ('EIERN', 'schwanken', 'D', 4, 8, 5),
    ('ROM', 'Hauptstadt Italiens', 'D', 10, 8, 3),
    ('IHM', 'Dativ von er', 'D', 1, 9, 3),
    ('ZIEGE', 'Geiß', 'D', 5, 9, 5),
    ('STEHEND', 'aufrecht', 'D', 1, 10, 7),
    ('IRIS', 'Schwertlilie', 'D', 9, 10, 4),
    ('ERLASS', 'Verordnung', 'D', 7, 11, 6),
    ('TAL', 'Senke', 'D', 1, 12, 3),
    ('NUN', 'inzwischen', 'D', 5, 12, 3),
    ('ENTE', 'Wasservogel', 'D', 9, 12, 4)
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
    ('GRANATEN', 'Geschosse', 'A', 1, 1, 8),
    ('TON', 'Klang', 'A', 1, 10, 3),
    ('BESEN', 'Kehrgerät', 'A', 2, 3, 5),
    ('SAFE', 'Panzerschrank', 'A', 2, 9, 4),
    ('WUSSTE', 'kannte', 'A', 3, 3, 6),
    ('BEI', 'nahe an', 'A', 3, 10, 3),
    ('IDEE', 'Gedanke', 'A', 4, 1, 4),
    ('TEILUNG', 'Spaltung', 'A', 4, 6, 7),
    ('SEHR', 'äußerst', 'A', 5, 1, 4),
    ('ENGE', 'knappe', 'A', 5, 6, 4),
    ('ERREGT', 'nervös', 'A', 6, 1, 6),
    ('NIE', 'zu keiner Zeit', 'A', 6, 8, 3),
    ('UEBRIG', 'restlich', 'A', 7, 7, 6),
    ('GIER', 'Habsucht', 'A', 8, 3, 4),
    ('AGENTEN', 'Spione', 'A', 9, 1, 7),
    ('HOSE', 'Beinkleid', 'A', 9, 9, 4),
    ('RASSEN', 'Zuchtlinien', 'A', 10, 1, 6),
    ('SOGAR', 'selbst', 'A', 10, 8, 5),
    ('INTERNE', 'innere', 'A', 11, 1, 7),
    ('HERD', 'Kochstelle', 'A', 11, 9, 4),
    ('ESEL', 'Dickkopf', 'A', 12, 1, 4),
    ('MENGE', 'Masse', 'A', 12, 8, 5),
    ('GLEISEN', 'Schienen', 'D', 1, 1, 7),
    ('ARIE', 'Sologesang', 'D', 9, 1, 4),
    ('DER', 'Artikel (männl.)', 'D', 4, 2, 3),
    ('GANS', 'Federvieh', 'D', 9, 2, 4),
    ('ABWEHR', 'Verteidigung', 'D', 1, 3, 6),
    ('GESTE', 'Gebärde', 'D', 8, 3, 5),
    ('NEUERE', 'Jüngere', 'D', 1, 4, 6),
    ('INSEL', 'Eiland', 'D', 8, 4, 5),
    ('ASS', 'speiste', 'D', 1, 5, 3),
    ('GUETER', 'Waren', 'D', 6, 5, 6),
    ('TESTET', 'prüft', 'D', 1, 6, 6),
    ('RENNT', 'spurtet', 'D', 8, 6, 5),
    ('ENTEN', 'Wasservögel', 'D', 1, 7, 5),
    ('EIGNET', 'passt', 'D', 3, 8, 6),
    ('LEIB', 'Körper', 'D', 4, 9, 4),
    ('HOHE', 'große', 'D', 9, 9, 4),
    ('TABU', 'verboten', 'D', 1, 10, 4),
    ('ERZOGEN', 'großgezogen', 'D', 6, 10, 7),
    ('OFEN', 'Wärmequelle', 'D', 1, 11, 4),
    ('SARG', 'Totenschrein', 'D', 9, 11, 4),
    ('NEIGUNG', 'Vorliebe', 'D', 1, 12, 7),
    ('ERDE', 'Heimatplanet', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r075-13x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r075-13x13-03', 'Rätsel 75 · 13×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '13x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('HOSE', 'Beinkleid', 'A', 1, 1, 4),
    ('HOB', 'stemmte', 'A', 1, 6, 3),
    ('DIR', 'Dat. (2. Pers.)', 'A', 1, 10, 3),
    ('APP', 'Handyprogramm', 'A', 2, 1, 3),
    ('MOBILE', 'bewegliche', 'A', 2, 5, 6),
    ('BEREITEN', 'verursachen', 'A', 3, 1, 8),
    ('SEI', 'existiere', 'A', 3, 10, 3),
    ('RUINEN', 'Trümmer', 'A', 4, 2, 6),
    ('BITS', 'Binärziffern', 'A', 4, 9, 4),
    ('EDEL', 'vornehm', 'A', 5, 3, 4),
    ('GAS', 'Brennstoff', 'A', 5, 10, 3),
    ('RAN', 'heran', 'A', 6, 1, 3),
    ('SPRENGT', 'zündet', 'A', 6, 6, 7),
    ('ALGEN', 'Tang', 'A', 7, 1, 5),
    ('LINSE', 'Objektiv', 'A', 7, 7, 5),
    ('EBEN', 'flach', 'A', 8, 1, 4),
    ('HABT', 'besitzt', 'A', 8, 6, 4),
    ('KUECHE', 'Kochraum', 'A', 9, 7, 6),
    ('GLAS', 'Trinkgefäß', 'A', 10, 1, 4),
    ('MAN', 'Pronomen', 'A', 10, 6, 3),
    ('HUB', 'Hebung', 'A', 10, 10, 3),
    ('TANTE', 'Muhme', 'A', 11, 1, 5),
    ('TARIFE', 'Gebühren', 'A', 11, 7, 6),
    ('ESSE', 'verspeise', 'A', 12, 1, 4),
    ('OEL', 'Rohstoff', 'A', 12, 6, 3),
    ('PER', 'mittels', 'A', 12, 10, 3),
    ('HAB', 'Besitz', 'D', 1, 1, 3),
    ('DRAENGTE', 'schob', 'D', 5, 1, 8),
    ('OPER', 'Musiktheater', 'D', 1, 2, 4),
    ('ALB', 'Gebirge', 'D', 6, 2, 3),
    ('LAS', 'entzifferte', 'D', 10, 2, 3),
    ('SPRUENGE', 'Sätze', 'D', 1, 3, 8),
    ('ANS', 'an das', 'D', 10, 3, 3),
    ('EID', 'Schwur', 'D', 3, 4, 3),
    ('ENGSTE', 'schmalste', 'D', 7, 4, 6),
    ('MINE', 'Sprengkörper', 'D', 2, 5, 4),
    ('HOTELS', 'Herbergen', 'D', 1, 6, 6),
    ('OBEN', 'in der Höhe', 'D', 1, 7, 4),
    ('PLAKATE', 'Poster', 'D', 6, 7, 7),
    ('BIN', 'Verbform', 'D', 1, 8, 3),
    ('TRIBUNAL', 'Gericht', 'D', 5, 8, 8),
    ('ENTE', 'Falschmeldung', 'D', 6, 9, 4),
    ('DESIGNS', 'Entwürfe', 'D', 1, 10, 7),
    ('CHIP', 'Halbleiter', 'D', 9, 10, 4),
    ('ETAGE', 'Stockwerk', 'D', 3, 11, 5),
    ('HUFE', 'Pferdefüße', 'D', 9, 11, 4),
    ('REISST', 'zerrt', 'D', 1, 12, 6),
    ('LEBER', 'große Drüse', 'D', 8, 12, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r076-15x15-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r076-15x15-02', 'Rätsel 76 · 15×15', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '15x15-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('LASER', 'Lichtstrahl', 'A', 1, 1, 5),
    ('STATT', 'anstelle', 'A', 1, 10, 5),
    ('ORT', 'Platz', 'A', 2, 1, 3),
    ('AUCH', 'ebenfalls', 'A', 2, 5, 4),
    ('TOKIO', 'jap. Hauptstadt', 'A', 2, 10, 5),
    ('STAND', 'befand sich', 'A', 3, 1, 5),
    ('HERUNTER', 'hinab', 'A', 3, 7, 8),
    ('REISEN', 'Fahrten', 'A', 4, 3, 6),
    ('TOPF', 'Kochgeschirr', 'A', 5, 4, 4),
    ('JETS', 'Düsenflieger', 'A', 5, 9, 4),
    ('TANZ', 'Ball', 'A', 6, 1, 4),
    ('IST', 'befindet sich', 'A', 6, 6, 3),
    ('ETWA', 'ungefähr', 'A', 6, 11, 4),
    ('AUE', 'Wiesenland', 'A', 7, 1, 3),
    ('EMAIL', 'elektr. Post', 'A', 7, 10, 5),
    ('NEU', 'aktuell', 'A', 8, 1, 3),
    ('BLITZ', 'Donnerkeil', 'A', 8, 5, 5),
    ('PUR', 'unverfälscht', 'A', 8, 11, 3),
    ('KREML', 'Moskauer Burg', 'A', 9, 1, 5),
    ('EURO', 'Währung', 'A', 9, 8, 4),
    ('AUTO', 'Wagen', 'A', 10, 4, 4),
    ('PRO', 'per', 'A', 10, 12, 3),
    ('AELTERER', 'betagterer', 'A', 11, 2, 8),
    ('GLAS', 'Trinkgefäß', 'A', 11, 11, 4),
    ('WUT', 'Raserei', 'A', 12, 1, 3),
    ('TAG', '24 Stunden', 'A', 12, 5, 3),
    ('RAST', 'jagt', 'A', 12, 11, 4),
    ('ALABAMA', 'Südstaat', 'A', 13, 1, 7),
    ('CHANCE', 'Gelegenheit', 'A', 13, 9, 6),
    ('RAT', 'Tipp', 'A', 14, 1, 3),
    ('NAH', 'dicht', 'A', 14, 7, 3),
    ('SEHT', 'schaut', 'A', 14, 11, 4),
    ('LOSE', 'locker', 'D', 1, 1, 4),
    ('TANKS', 'Behälter', 'D', 6, 1, 5),
    ('WAR', 'existierte', 'D', 12, 1, 3),
    ('ART', 'Sorte', 'D', 1, 2, 3),
    ('MAUER', 'Wand', 'D', 5, 2, 5),
    ('AULA', 'Festsaal', 'D', 11, 2, 4),
    ('STAR', 'Berühmtheit', 'D', 1, 3, 4),
    ('NEUE', 'frische', 'D', 6, 3, 4),
    ('ETAT', 'Budget', 'D', 11, 3, 4),
    ('NETZ', 'Geflecht', 'D', 3, 4, 4),
    ('MAL', 'Zeichen ×', 'D', 9, 4, 3),
    ('RADIO', 'Rundfunk', 'D', 1, 5, 5),
    ('BLUTTAT', 'Verbrechen', 'D', 8, 5, 7),
    ('SPIEL', 'Match', 'D', 4, 6, 5),
    ('TEAM', 'Crew', 'D', 10, 6, 4),
    ('CHEFS', 'Leiter', 'D', 2, 7, 5),
    ('ORGAN', 'Körperteil', 'D', 10, 7, 5),
    ('EHEN', 'Bündnisse', 'D', 1, 8, 4),
    ('TOTE', 'Verstorbene', 'D', 6, 8, 4),
    ('ZUERICH', 'Limmatstadt', 'D', 8, 9, 7),
    ('STUFE', 'Tritt', 'D', 1, 10, 5),
    ('TON', 'Klang', 'D', 1, 11, 3),
    ('TEMPO', 'Rasanz', 'D', 5, 11, 5),
    ('GRAS', 'Rasen', 'D', 11, 11, 4),
    ('AKT', 'Aufzug', 'D', 1, 12, 3),
    ('STAU', 'Blechlawine', 'D', 5, 12, 4),
    ('PLANE', 'beabsichtige', 'D', 10, 12, 5),
    ('TIEF', 'abgründig', 'D', 1, 13, 4),
    ('WIR', 'Pronomen (1. Pl.)', 'D', 6, 13, 3),
    ('RASCH', 'schnell', 'D', 10, 13, 5),
    ('TOR', 'Dummkopf', 'D', 1, 14, 3),
    ('TAL', 'Niederung', 'D', 5, 14, 3),
    ('KOSTET', 'probiert', 'D', 9, 14, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r077-15x15-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r077-15x15-01', 'Rätsel 77 · 15×15', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '15x15-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AFFE', 'Schimpanse', 'A', 1, 1, 4),
    ('GAR', 'durchgekocht', 'A', 1, 6, 3),
    ('GRUSS', 'Salut', 'A', 1, 10, 5),
    ('BAUHERR', 'Auftraggeber', 'A', 2, 1, 7),
    ('KEIN', 'nicht ein', 'A', 2, 9, 4),
    ('FUER', 'Präposition', 'A', 3, 1, 4),
    ('AMT', 'Dienststelle', 'A', 3, 6, 3),
    ('BEIDE', 'Zahlwort', 'A', 3, 10, 5),
    ('UNTERM', 'unter dem', 'A', 4, 1, 6),
    ('ESSIG', 'Würzmittel', 'A', 4, 10, 5),
    ('HAT', 'besitzt', 'A', 5, 1, 3),
    ('IMMER', 'ständig', 'A', 5, 5, 5),
    ('ECK', 'Kante', 'A', 6, 12, 3),
    ('DREHTE', 'wendete', 'A', 7, 2, 6),
    ('LEGION', 'Heerschar', 'A', 7, 9, 6),
    ('RAN', 'hinzu', 'A', 8, 1, 3),
    ('TORBOGEN', 'Portal', 'A', 8, 5, 8),
    ('BIN', 'Verbform', 'A', 9, 4, 3),
    ('HIN', 'fort', 'A', 9, 9, 3),
    ('GENUG', 'ausreichend', 'A', 10, 1, 5),
    ('INNE', '... halten', 'A', 10, 7, 4),
    ('URIN', 'Ausscheidung', 'A', 11, 1, 4),
    ('IDEE', 'Gedanke', 'A', 11, 6, 4),
    ('GRAD', 'Stufe', 'A', 11, 11, 4),
    ('TEXTUREN', 'Oberflächen', 'A', 12, 1, 8),
    ('VATER', 'Papa', 'A', 12, 10, 5),
    ('EHREN', 'Auszeichnungen', 'A', 13, 4, 5),
    ('OBERE', 'höhere', 'A', 13, 10, 5),
    ('RUF', 'Ansehen', 'A', 14, 1, 3),
    ('RENTEN', 'Pensionen', 'A', 14, 5, 6),
    ('NAH', 'unweit', 'A', 14, 12, 3),
    ('ABFUHR', 'Absage', 'D', 1, 1, 6),
    ('GUTER', 'braver', 'D', 10, 1, 5),
    ('FAUNA', 'Tierwelt', 'D', 1, 2, 5),
    ('DAUERE', 'währe', 'D', 7, 2, 6),
    ('FUETTERN', 'ernähren', 'D', 1, 3, 8),
    ('NIX', 'nichts', 'D', 10, 3, 3),
    ('EHRE', 'Würde', 'D', 1, 4, 4),
    ('BUNTE', 'farbige', 'D', 9, 4, 5),
    ('RICHTIG', 'korrekt', 'D', 4, 5, 7),
    ('UHR', 'Zeitmesser', 'D', 12, 5, 3),
    ('GRAMM', 'Tausendstel Kilo', 'D', 1, 6, 5),
    ('TON', 'Klang', 'D', 7, 6, 3),
    ('IRRE', 'Wahnsinnige', 'D', 11, 6, 4),
    ('ARM', 'Extremität', 'D', 1, 7, 3),
    ('MEER', 'See', 'D', 5, 7, 4),
    ('IDEEN', 'Einfälle', 'D', 10, 7, 5),
    ('TUE', 'mache', 'D', 3, 8, 3),
    ('NENNT', 'bezeichnet', 'D', 10, 8, 5),
    ('LOHNE', 'vergelte', 'D', 7, 9, 5),
    ('GEBE', 'reiche', 'D', 1, 10, 4),
    ('REGIE', 'Spielleitung', 'D', 6, 10, 5),
    ('VON', 'ab, aus', 'D', 12, 10, 3),
    ('RIESE', 'Hüne', 'D', 1, 11, 5),
    ('GEN', 'Erbanlage', 'D', 7, 11, 3),
    ('GAB', 'reichte', 'D', 11, 11, 3),
    ('UNIS', 'Bildungsstätten', 'D', 1, 12, 4),
    ('EIN', 'unbest. Artikel', 'D', 6, 12, 3),
    ('ARTEN', 'Gattungen', 'D', 10, 12, 5),
    ('DISCO', 'Tanzlokal', 'D', 3, 13, 5),
    ('AERA', 'Epoche', 'D', 11, 13, 4),
    ('SIEG', 'Triumph', 'D', 1, 14, 4),
    ('KNIE', 'Scharniergelenk', 'D', 6, 14, 4),
    ('DREH', 'Kniff', 'D', 11, 14, 4)
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
    ('WAAGE', 'Sternzeichen', 'A', 1, 1, 5),
    ('FUELLTEN', 'stopften', 'A', 1, 7, 8),
    ('ERBE', 'Nachlass', 'A', 2, 1, 4),
    ('LOHN', 'Gehalt', 'A', 2, 6, 4),
    ('IGEL', 'Winterschläfer', 'A', 3, 1, 4),
    ('IRRT', 'täuscht sich', 'A', 3, 6, 4),
    ('KANU', 'Paddelboot', 'A', 3, 11, 4),
    ('BERAUBT', 'bestohlen', 'A', 4, 1, 7),
    ('DES', 'Artikel (Genitiv)', 'A', 4, 12, 3),
    ('FETT', 'Schmalz', 'A', 5, 11, 4),
    ('PRAG', 'Moldau-Stadt', 'A', 6, 1, 4),
    ('NIX', 'gar nichts', 'A', 6, 6, 3),
    ('MALTE', 'pinselte', 'A', 6, 10, 5),
    ('RESTLOS', 'völlig', 'A', 7, 1, 7),
    ('LASSE', 'erlaube', 'A', 7, 9, 5),
    ('OFT', 'des Öfteren', 'A', 8, 1, 3),
    ('ENTGELT', 'Vergütung', 'A', 8, 5, 7),
    ('EDLE', 'noble', 'A', 9, 11, 4),
    ('PREIS', 'Tarif', 'A', 10, 1, 5),
    ('MUT', 'Courage', 'A', 10, 7, 3),
    ('NEID', 'Missgunst', 'A', 10, 11, 4),
    ('FAX', 'Telekopie', 'A', 11, 1, 3),
    ('TRATEN', 'schritten', 'A', 11, 5, 6),
    ('FEE', 'Zauberin', 'A', 11, 12, 3),
    ('ETAGE', 'Stockwerk', 'A', 12, 1, 5),
    ('TAT', 'Werk', 'A', 12, 7, 3),
    ('GEBT', 'reicht', 'A', 12, 11, 4),
    ('KUTSCHE', 'Pferdewagen', 'A', 13, 3, 7),
    ('AKT', 'Aufzug', 'A', 13, 11, 3),
    ('LATTE', 'Leiste', 'A', 14, 1, 5),
    ('NESTER', 'Horste', 'A', 14, 9, 6),
    ('WEIB', 'Frau (veraltet)', 'D', 1, 1, 4),
    ('PRO', 'per', 'D', 6, 1, 3),
    ('PFEIL', 'Geschoss', 'D', 10, 1, 5),
    ('ARGE', 'schlimme', 'D', 1, 2, 4),
    ('REFERAT', 'Vortrag', 'D', 6, 2, 7),
    ('ABER', 'jedoch', 'D', 1, 3, 4),
    ('AST', 'Zweig', 'D', 6, 3, 3),
    ('EXAKT', 'genau', 'D', 10, 3, 5),
    ('GELANGT', 'kommt', 'D', 1, 4, 7),
    ('GUT', 'prima', 'D', 12, 4, 3),
    ('LEISTETE', 'vollbrachte', 'D', 7, 5, 8),
    ('LIBANON', 'Zedernstaat', 'D', 2, 6, 7),
    ('FORT', 'weg', 'D', 1, 7, 4),
    ('IST', 'befindet sich', 'D', 6, 7, 3),
    ('MATCH', 'Spiel', 'D', 10, 7, 5),
    ('UHR', 'Chronometer', 'D', 1, 8, 3),
    ('UTAH', 'Mormonenstaat', 'D', 10, 8, 4),
    ('ENTE', 'Wasservogel', 'D', 1, 9, 4),
    ('LEITETEN', 'führten', 'D', 7, 9, 8),
    ('MAL', 'einst', 'D', 6, 10, 3),
    ('LOK', 'Triebwagen', 'D', 1, 11, 3),
    ('FASTEN', 'Verzicht', 'D', 5, 11, 6),
    ('GAS', 'Brennstoff', 'D', 12, 11, 3),
    ('ADELS', 'Titel des ...', 'D', 3, 12, 5),
    ('DEFEKT', 'Schaden', 'D', 9, 12, 6),
    ('NETTE', 'freundliche', 'D', 3, 13, 5),
    ('LIEBTE', 'verehrte', 'D', 9, 13, 6),
    ('NEUSTE', 'jüngste', 'D', 1, 14, 6),
    ('REDET', 'spricht', 'D', 8, 14, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

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
    ('OFEN', 'Herd', 'A', 1, 1, 4),
    ('FLIEHT', 'flüchtet', 'A', 2, 1, 6),
    ('TESTER', 'Prüfer', 'A', 3, 1, 6),
    ('TRAT', 'schritt', 'A', 4, 4, 4),
    ('AKT', 'Aufzug', 'A', 5, 1, 3),
    ('ZUR', 'zu der', 'A', 5, 5, 3),
    ('ATOME', 'Teilchen', 'A', 6, 3, 5),
    ('BUG', 'Programmfehler', 'A', 7, 1, 3),
    ('GAU', 'Landesteil', 'A', 7, 5, 3),
    ('OFT', 'häufig', 'D', 1, 1, 3),
    ('ALB', 'Gebirge', 'D', 5, 1, 3),
    ('FLECK', 'Makel', 'D', 1, 2, 5),
    ('EIS', 'Sorbet', 'D', 1, 3, 3),
    ('TAG', '24 Stunden', 'D', 5, 3, 3),
    ('NETT', 'freundlich', 'D', 1, 4, 4),
    ('HERZOG', 'Adelstitel', 'D', 2, 5, 6),
    ('TRAUMA', 'Schock', 'D', 2, 6, 6),
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
    ('WALD', 'Forst', 'A', 1, 4, 4),
    ('ALTEM', 'betagtem', 'A', 2, 1, 5),
    ('BLATT', 'Seite', 'A', 3, 1, 5),
    ('WEIT', 'fern', 'A', 4, 1, 4),
    ('WEDEL', 'Fächer', 'A', 5, 3, 5),
    ('ARENA', 'Kolosseum', 'A', 6, 3, 5),
    ('RAN', 'hinzu', 'A', 7, 1, 3),
    ('MAG', 'liebt', 'A', 7, 5, 3),
    ('ABWEHR', 'Verteidigung', 'D', 2, 1, 6),
    ('ALLE', 'Pronomen', 'D', 1, 2, 4),
    ('TAIWAN', 'Formosa', 'D', 2, 3, 6),
    ('WETTER', 'Witterung', 'D', 1, 4, 6),
    ('AMT', 'Behörde', 'D', 1, 5, 3),
    ('DEM', 'Artikel (Dativ)', 'D', 5, 5, 3),
    ('JENA', 'Saalestadt', 'D', 4, 6, 4),
    ('DOM', 'Kathedrale', 'D', 1, 7, 3),
    ('LAG', 'befand sich', 'D', 5, 7, 3)
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
    ('NATION', 'Volk', 'A', 1, 1, 6),
    ('PORTAL', 'Tor', 'A', 2, 2, 6),
    ('UPDATE', 'Nachtrag', 'A', 3, 1, 6),
    ('NAHE', 'dicht bei', 'A', 4, 4, 4),
    ('BAU', 'Konstruktion', 'A', 5, 1, 3),
    ('WEN', 'Fragewort (Akk.)', 'A', 5, 5, 3),
    ('TUN', 'verrichten', 'A', 6, 1, 3),
    ('ARG', 'schlimm', 'A', 6, 5, 3),
    ('ESSE', 'verspeise', 'A', 7, 1, 4),
    ('UEBTE', 'probte', 'D', 3, 1, 5),
    ('APP', 'Anwendung', 'D', 1, 2, 3),
    ('AUS', 'vorbei', 'D', 5, 2, 3),
    ('TOD', 'Exitus', 'D', 1, 3, 3),
    ('UNS', 'Akk./Dat. von wir', 'D', 5, 3, 3),
    ('IRAN', 'Golfstaat', 'D', 1, 4, 4),
    ('OTTAWA', 'kanad. Hauptstadt', 'D', 1, 5, 6),
    ('NAEHER', 'enger', 'D', 1, 6, 6),
    ('ENGE', 'schmale', 'D', 4, 7, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r082-9x9-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r082-9x9-01', 'Rätsel 82 · 9×9', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '9x9-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('FREI', 'ungebunden', 'A', 1, 1, 4),
    ('MIT', 'samt', 'A', 1, 6, 3),
    ('RUIN', 'Untergang', 'A', 2, 1, 4),
    ('ACH', 'Ausruf', 'A', 2, 6, 3),
    ('EHEN', 'Verbindungen', 'A', 3, 1, 4),
    ('IHR', 'Pronomen (2. Pl.)', 'A', 3, 6, 3),
    ('IRRE', 'Verrückte', 'A', 4, 1, 4),
    ('SOHN', 'Filius', 'A', 5, 5, 4),
    ('ALABAMA', 'Südstaat', 'A', 6, 1, 7),
    ('GARAGEN', 'Stellplätze', 'A', 7, 1, 7),
    ('STRAND', 'Ufer', 'A', 8, 2, 6),
    ('FREITAG', 'vor Samstag', 'D', 1, 1, 7),
    ('RUHR', 'Fluss im Revier', 'D', 1, 2, 4),
    ('LAS', 'entzifferte', 'D', 6, 2, 3),
    ('EIER', 'Gelege', 'D', 1, 3, 4),
    ('ART', 'Spezies', 'D', 6, 3, 3),
    ('INNE', '... halten', 'D', 1, 4, 4),
    ('BAR', 'Theke', 'D', 6, 4, 3),
    ('SAGA', 'Heldensage', 'D', 5, 5, 4),
    ('MAI', 'Wonnemonat', 'D', 1, 6, 3),
    ('OMEN', 'Vorzeichen', 'D', 5, 6, 4),
    ('ICH', 'Pronomen (1. Sg.)', 'D', 1, 7, 3),
    ('HAND', 'Greiforgan', 'D', 5, 7, 4),
    ('THRON', 'Königssitz', 'D', 1, 8, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r083-9x9-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r083-9x9-02', 'Rätsel 83 · 9×9', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '9x9-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('PFAD', 'Weg', 'A', 1, 1, 4),
    ('BOX', 'Schachtel', 'A', 1, 6, 3),
    ('UEBEN', 'trainieren', 'A', 2, 1, 5),
    ('BETRUGS', 'Opfer des ...', 'A', 3, 1, 7),
    ('SEES', 'Ufer des ...', 'A', 4, 5, 4),
    ('FLEISS', 'Eifer', 'A', 5, 1, 6),
    ('ROHR', 'Leitung', 'A', 6, 1, 4),
    ('IHR', 'Pronomen (2. Pl.)', 'A', 6, 6, 3),
    ('EHER', 'vielmehr', 'A', 7, 1, 4),
    ('MAG', 'liebt', 'A', 7, 6, 3),
    ('INNE', 'Verbpartikel', 'A', 8, 1, 4),
    ('SIE', 'Anrede', 'A', 8, 6, 3),
    ('PUB', 'Kneipe', 'D', 1, 1, 3),
    ('FREI', 'kostenlos', 'D', 5, 1, 4),
    ('FEE', 'Elfe', 'D', 1, 2, 3),
    ('LOHN', 'Gehalt', 'D', 5, 2, 4),
    ('ABT', 'Ordensoberer', 'D', 1, 3, 3),
    ('EHEN', 'Verbindungen', 'D', 5, 3, 4),
    ('DER', 'Artikel (männl.)', 'D', 1, 4, 3),
    ('IRRE', 'Verrückte', 'D', 5, 4, 4),
    ('NUSS', 'Kern', 'D', 2, 5, 4),
    ('GESIMS', 'Vorsprung', 'D', 3, 6, 6),
    ('OASE', 'Wüsteninsel', 'D', 1, 7, 4),
    ('HAI', 'Raubfisch', 'D', 6, 7, 3),
    ('SORGE', 'Kummer', 'D', 4, 8, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r084-9x9-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r084-9x9-03', 'Rätsel 84 · 9×9', g.id, 'veroeffentlicht', 1, now()
  from gitter g where g.name = '9x9-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ETWA', 'ungefähr', 'A', 1, 1, 4),
    ('PRO', 'per', 'A', 1, 6, 3),
    ('IRAK', 'Land am Tigris', 'A', 2, 1, 4),
    ('FEE', 'Elfe', 'A', 2, 6, 3),
    ('NEST', 'Kobel', 'A', 3, 1, 4),
    ('ALL', 'Weltraum', 'A', 3, 6, 3),
    ('IHRE', 'Pronomen', 'A', 4, 4, 4),
    ('HEIRAT', 'Hochzeit', 'A', 5, 3, 6),
    ('OPA', 'Opi', 'A', 6, 1, 3),
    ('LESE', 'schmökere', 'A', 6, 5, 4),
    ('HEU', 'Viehfutter', 'A', 7, 1, 3),
    ('FREI', 'ungebunden', 'A', 7, 5, 4),
    ('ERSTE', 'führende', 'A', 8, 1, 5),
    ('EIN', 'unbest. Artikel', 'D', 1, 1, 3),
    ('HOHE', 'große', 'D', 5, 1, 4),
    ('TREU', 'anhänglich', 'D', 1, 2, 4),
    ('PER', 'mittels', 'D', 6, 2, 3),
    ('WAS', 'Fragewort (Sache)', 'D', 1, 3, 3),
    ('HAUS', 'Heim', 'D', 5, 3, 4),
    ('AKTIE', 'Wertpapier', 'D', 1, 4, 5),
    ('HILFE', 'Beistand', 'D', 4, 5, 5),
    ('PFARRER', 'Pastor', 'D', 1, 6, 7),
    ('RELEASE', 'Erscheinen', 'D', 1, 7, 7),
    ('OEL', 'Schmierstoff', 'D', 1, 8, 3),
    ('TEIL', 'Fragment', 'D', 5, 8, 4)
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
    ('ESSE', 'speise', 'A', 1, 1, 4),
    ('ELEGANZ', 'Anmut', 'A', 1, 6, 7),
    ('REIN', 'sauber', 'A', 2, 1, 4),
    ('HANAU', 'Stadt am Main', 'A', 2, 8, 5),
    ('SIEGEL', 'Stempel', 'A', 3, 1, 6),
    ('ESSIG', 'Würzmittel', 'A', 3, 8, 5),
    ('GEWEHRT', 'verteidigt', 'A', 4, 3, 7),
    ('RIGA', 'lett. Hauptstadt', 'A', 5, 4, 4),
    ('RIO', 'Stadt in Brasilien', 'A', 6, 1, 3),
    ('GELB', 'sonnenfarben', 'A', 6, 5, 4),
    ('OFT', 'häufig', 'A', 6, 10, 3),
    ('ACH', 'Ausruf', 'A', 7, 1, 3),
    ('ENTE', 'Wasservogel', 'A', 7, 5, 4),
    ('HEU', 'Viehfutter', 'A', 7, 10, 3),
    ('THRON', 'Königssitz', 'A', 8, 1, 5),
    ('EIGNER', 'Besitzer', 'A', 8, 7, 6),
    ('ERST', 'anfangs', 'D', 1, 1, 4),
    ('RAT', 'Tipp', 'D', 6, 1, 3),
    ('SEI', 'existiere', 'D', 1, 2, 3),
    ('WICH', 'gab nach', 'D', 5, 2, 4),
    ('SIEG', 'Triumph', 'D', 1, 3, 4),
    ('OHR', 'Lauscher', 'D', 6, 3, 3),
    ('ENGER', 'schmaler', 'D', 1, 4, 5),
    ('EWIGEN', 'endlosen', 'D', 3, 5, 6),
    ('ERLEGEN', 'schießen', 'D', 1, 6, 7),
    ('HALTE', 'stoppe', 'D', 4, 7, 5),
    ('EHER', 'lieber', 'D', 1, 8, 4),
    ('BEI', 'nahe an', 'D', 6, 8, 3),
    ('GAST', 'Besucher', 'D', 1, 9, 4),
    ('ANS', 'an das', 'D', 1, 10, 3),
    ('HOHN', 'Spott', 'D', 5, 10, 4),
    ('NAIV', 'arglos', 'D', 1, 11, 4),
    ('FEE', 'Elfe', 'D', 6, 11, 3),
    ('ZUG', 'Bahn', 'D', 1, 12, 3),
    ('STUR', 'starrsinnig', 'D', 5, 12, 4)
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
    ('WOG', 'schwankte', 'A', 1, 1, 3),
    ('DER', 'Artikel (männl.)', 'A', 1, 6, 3),
    ('ZOO', 'Tierpark', 'A', 1, 10, 3),
    ('IHR', 'Pronomen (2. Pl.)', 'A', 2, 1, 3),
    ('KILO', '1000 Gramm', 'A', 2, 5, 4),
    ('WER', 'Fragewort (Person)', 'A', 2, 10, 3),
    ('DIAS', 'Lichtbilder', 'A', 3, 1, 4),
    ('EISKALT', 'frostig', 'A', 3, 6, 7),
    ('MOST', 'Obstsaft', 'A', 4, 1, 4),
    ('STARR', 'steif', 'A', 4, 6, 5),
    ('IDEE', 'Einfall', 'A', 5, 4, 4),
    ('NORMAL', 'üblich', 'A', 6, 1, 6),
    ('DERBY', 'Lokalduell', 'A', 6, 8, 5),
    ('HAMM', 'Stadt in Westfalen', 'A', 7, 2, 4),
    ('ZUGABE', 'Extra', 'A', 7, 7, 6),
    ('ERNTEN', 'Lesen', 'A', 8, 1, 6),
    ('OSTEN', 'Morgenland', 'A', 8, 8, 5),
    ('WIDMEN', 'zueignen', 'D', 1, 1, 6),
    ('OHIO', 'Buckeye-Staat', 'D', 1, 2, 4),
    ('OHR', 'Lauscher', 'D', 6, 2, 3),
    ('GRAS', 'Rasen', 'D', 1, 3, 4),
    ('RAN', 'hinzu', 'D', 6, 3, 3),
    ('STIMMT', 'trifft zu', 'D', 3, 4, 6),
    ('DAME', 'Frau', 'D', 5, 5, 4),
    ('DIESEL', 'Kraftstoff', 'D', 1, 6, 6),
    ('ELITE', 'Oberschicht', 'D', 1, 7, 5),
    ('ROSA', 'Pink', 'D', 1, 8, 4),
    ('DUO', 'Paar', 'D', 6, 8, 3),
    ('KRIEGS', 'Ende des ...', 'D', 3, 9, 6),
    ('ZWAR', 'Konjunktionaladverb', 'D', 1, 10, 4),
    ('RAT', 'Gremium', 'D', 6, 10, 3),
    ('OEL', 'Schmierstoff', 'D', 1, 11, 3),
    ('EBBE', 'Niedrigwasser', 'D', 5, 11, 4),
    ('ORTE', 'Plätze', 'D', 1, 12, 4),
    ('YEN', 'Währung Japans', 'D', 6, 12, 3)
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
    ('AKTE', 'Dokument', 'A', 1, 1, 4),
    ('NEULAND', 'Terra incognita', 'A', 1, 6, 7),
    ('LUECKE', 'Spalt', 'A', 2, 1, 6),
    ('FOLIE', 'Film', 'A', 2, 8, 5),
    ('TRIKOT', 'Sporthemd', 'A', 3, 1, 6),
    ('ESSEN', 'Mahlzeit', 'A', 3, 8, 5),
    ('STAR', 'Berühmtheit', 'A', 4, 5, 4),
    ('STEG', 'Brücklein', 'A', 5, 4, 4),
    ('LEBE', 'existiere', 'A', 5, 9, 4),
    ('RAMPE', 'Auffahrt', 'A', 6, 1, 5),
    ('ELITEN', 'Oberschichten', 'A', 6, 7, 6),
    ('TRAUT', 'wagt', 'A', 7, 1, 5),
    ('EWIG', 'unaufhörlich', 'A', 7, 9, 4),
    ('ETIKETT', 'Aufkleber', 'A', 8, 1, 7),
    ('DAME', 'Frau', 'A', 8, 9, 4),
    ('ALT', 'ergraut', 'D', 1, 1, 3),
    ('ORTE', 'Plätze', 'D', 5, 1, 4),
    ('KUR', 'Erholung', 'D', 1, 2, 3),
    ('ART', 'Spezies', 'D', 6, 2, 3),
    ('TEIG', 'Masse', 'D', 1, 3, 4),
    ('MAI', '5. Monat', 'D', 6, 3, 3),
    ('ECK', 'Winkel', 'D', 1, 4, 3),
    ('SPUK', 'Geisterei', 'D', 5, 4, 4),
    ('KOSTETE', 'probierte', 'D', 2, 5, 7),
    ('NETTE', 'freundliche', 'D', 1, 6, 5),
    ('AGENT', 'Spion', 'D', 4, 7, 5),
    ('UFER', 'Küste', 'D', 1, 8, 4),
    ('LOS', 'frei', 'D', 1, 9, 3),
    ('LIED', 'Song', 'D', 5, 9, 4),
    ('ALS', 'da, während', 'D', 1, 10, 3),
    ('ETWA', 'ungefähr', 'D', 5, 10, 4),
    ('NIE', 'zu keiner Zeit', 'D', 1, 11, 3),
    ('BEIM', 'bei dem', 'D', 5, 11, 4),
    ('DEN', 'Artikel (Akkusativ)', 'D', 1, 12, 3),
    ('ENGE', 'schmale', 'D', 5, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r088-10x10-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r088-10x10-04', 'Rätsel 88 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('NEST', 'Kobel', 'A', 1, 1, 4),
    ('SAFE', 'Tresor', 'A', 1, 6, 4),
    ('AXT', 'Tomahawk', 'A', 2, 1, 3),
    ('BOGEN', 'Kurve', 'A', 2, 5, 5),
    ('STAB', 'Stock', 'A', 3, 1, 4),
    ('LEID', 'Weh', 'A', 3, 6, 4),
    ('ERDE', 'Heimatplanet', 'A', 4, 1, 4),
    ('INNE', 'Verbpartikel', 'A', 4, 6, 4),
    ('AERMSTEN', 'elendsten', 'A', 5, 2, 8),
    ('GUT', 'brauchbar', 'A', 6, 4, 3),
    ('AUGES', 'Farbe des ...', 'A', 7, 1, 5),
    ('AST', 'Zweig', 'A', 7, 7, 3),
    ('BLASS', 'bleich', 'A', 8, 1, 5),
    ('RIO', 'Zuckerhut-Stadt', 'A', 8, 7, 3),
    ('UMS', 'um das', 'A', 9, 1, 3),
    ('TOTER', 'verstorbener', 'A', 9, 5, 5),
    ('NASE', 'Riechorgan', 'D', 1, 1, 4),
    ('TABU', 'verboten', 'D', 6, 1, 4),
    ('EXTRA', 'zusätzlich', 'D', 1, 2, 5),
    ('ULM', 'Einstein-Geburtsstadt', 'D', 7, 2, 3),
    ('STADE', 'Elbhafen', 'D', 1, 3, 5),
    ('GAS', 'Brennstoff', 'D', 7, 3, 3),
    ('BERGES', 'Gipfel des ...', 'D', 3, 4, 6),
    ('MUSST', 'sollst', 'D', 5, 5, 5),
    ('SOLIST', 'Einzelsänger', 'D', 1, 6, 6),
    ('AGENT', 'Spion', 'D', 1, 7, 5),
    ('ART', 'Spezies', 'D', 7, 7, 3),
    ('FEINE', 'zarte', 'D', 1, 8, 5),
    ('SIE', 'Anrede', 'D', 7, 8, 3),
    ('ENDEN', 'auslaufen', 'D', 1, 9, 5),
    ('TOR', 'Dummkopf', 'D', 7, 9, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r089-11x11-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r089-11x11-01', 'Rätsel 89 · 11×11', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '11x11-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ALLE', 'Pronomen', 'A', 1, 1, 4),
    ('WERKS', 'Chef des ...', 'A', 1, 6, 5),
    ('RIO', 'Zuckerhut-Stadt', 'A', 2, 1, 3),
    ('ART', 'Spezies', 'A', 2, 8, 3),
    ('GESANG', 'Lied', 'A', 3, 1, 6),
    ('DIE', 'Artikel (weibl.)', 'A', 3, 8, 3),
    ('ZAEH', 'hartnäckig', 'A', 4, 7, 4),
    ('HEBEN', 'stemmen', 'A', 5, 1, 5),
    ('ARGE', 'schlimme', 'A', 5, 7, 4),
    ('IMAGE', 'Ruf', 'A', 6, 3, 5),
    ('UMS', 'um das', 'A', 7, 1, 3),
    ('HASST', 'verabscheut', 'A', 7, 5, 5),
    ('SATZ', 'Sprung', 'A', 8, 1, 4),
    ('BUERO', 'Kanzlei', 'A', 8, 6, 5),
    ('EURO', 'Währung', 'A', 9, 1, 4),
    ('ERKER', 'Vorsprung', 'A', 9, 6, 5),
    ('SLOGAN', 'Werbespruch', 'A', 10, 1, 6),
    ('TUT', 'verrichtet', 'A', 10, 8, 3),
    ('ARG', 'schlimm', 'D', 1, 1, 3),
    ('HAUSES', 'Herr des ...', 'D', 5, 1, 6),
    ('LIEGE', 'ruhe', 'D', 1, 2, 5),
    ('MAUL', 'Schnauze', 'D', 7, 2, 4),
    ('LOS', 'ledig', 'D', 1, 3, 3),
    ('BISTRO', 'Lokal', 'D', 5, 3, 6),
    ('ATEM', 'Luft', 'D', 3, 4, 4),
    ('ZOG', 'riss', 'D', 8, 4, 3),
    ('NAH', 'dicht', 'D', 5, 5, 3),
    ('WOG', 'schwankte', 'D', 1, 6, 3),
    ('GABEN', 'reichten', 'D', 6, 6, 5),
    ('ZAESUR', 'Einschnitt', 'D', 4, 7, 6),
    ('RADAR', 'Ortungsgerät', 'D', 1, 8, 5),
    ('SEKT', 'Schaumwein', 'D', 7, 8, 4),
    ('KRIEG', 'Kampf', 'D', 1, 9, 5),
    ('TREU', 'anhänglich', 'D', 7, 9, 4),
    ('STEHEN', 'aufrecht sein', 'D', 1, 10, 6),
    ('ORT', 'Platz', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r090-11x11-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r090-11x11-02', 'Rätsel 90 · 11×11', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '11x11-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ALS', 'da, während', 'A', 1, 1, 3),
    ('REZEPT', 'Verordnung', 'A', 1, 5, 6),
    ('SAAL', 'Halle', 'A', 2, 1, 4),
    ('RUDER', 'Steuer', 'A', 2, 6, 5),
    ('YEN', 'Währung Japans', 'A', 3, 1, 3),
    ('ENGERE', 'schmalere', 'A', 3, 5, 6),
    ('LUD', 'packte auf', 'A', 4, 1, 3),
    ('FOTO', 'Aufnahme', 'A', 5, 4, 4),
    ('STEIF', 'starr', 'A', 6, 1, 5),
    ('BUND', 'Bündnis', 'A', 6, 7, 4),
    ('STEHENDE', 'aufrechte', 'A', 7, 3, 8),
    ('ASS', 'verspeiste', 'A', 8, 1, 3),
    ('NORMEN', 'Standards', 'A', 8, 5, 6),
    ('LEER', 'hohl', 'A', 9, 1, 4),
    ('HEUTE', 'an diesem Tag', 'A', 9, 6, 5),
    ('BIN', 'Verbform', 'A', 10, 1, 3),
    ('RENTEN', 'Pensionen', 'A', 10, 5, 6),
    ('ASYL', 'Unterschlupf', 'D', 1, 1, 4),
    ('ALB', 'Gebirge', 'D', 8, 1, 3),
    ('LAEUFT', 'rennt', 'D', 1, 2, 6),
    ('SEI', 'existiere', 'D', 8, 2, 3),
    ('SAND', 'Strandboden', 'D', 1, 3, 4),
    ('ESSEN', 'Ruhrgebietsstadt', 'D', 6, 3, 5),
    ('FIT', 'gesund', 'D', 5, 4, 3),
    ('OFEN', 'Herd', 'D', 5, 5, 4),
    ('ERNST', 'Seriosität', 'D', 1, 6, 5),
    ('HOHE', 'große', 'D', 7, 6, 4),
    ('ZUG', 'Bahn', 'D', 1, 7, 3),
    ('OBEREN', 'höher gelegenen', 'D', 5, 7, 6),
    ('EDEL', 'vornehm', 'D', 1, 8, 4),
    ('UNMUT', 'Ärger', 'D', 6, 8, 5),
    ('PER', 'mittels', 'D', 1, 9, 3),
    ('ENDETE', 'hörte auf', 'D', 5, 9, 6),
    ('TREU', 'loyal', 'D', 1, 10, 4),
    ('DENEN', 'Relativ (Dat. Pl.)', 'D', 6, 10, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r091-11x11-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r091-11x11-03', 'Rätsel 91 · 11×11', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '11x11-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('BRAV', 'artig', 'A', 1, 1, 4),
    ('OASE', 'Wüsteninsel', 'A', 1, 7, 4),
    ('LOK', 'Zugmaschine', 'A', 2, 1, 3),
    ('HERBEI', 'heran', 'A', 2, 5, 6),
    ('AMTS', 'im ... sein', 'A', 3, 1, 4),
    ('STETS', 'immer', 'A', 3, 6, 5),
    ('ESSENZ', 'Kern', 'A', 4, 4, 6),
    ('KNEIPE', 'Lokal', 'A', 5, 1, 6),
    ('DER', 'Artikel (männl.)', 'A', 5, 8, 3),
    ('ERDE', 'Heimatplanet', 'A', 6, 2, 4),
    ('BUS', 'Nahverkehrsmittel', 'A', 7, 1, 3),
    ('ELF', 'Zahl (10+1)', 'A', 7, 5, 3),
    ('ABT', 'Ordensoberer', 'A', 8, 1, 3),
    ('RUEBER', 'hinüber', 'A', 8, 5, 6),
    ('RAET', 'empfiehlt', 'A', 9, 1, 4),
    ('PROSA', 'Erzähltext', 'A', 9, 6, 5),
    ('TUN', 'verrichten', 'A', 10, 1, 3),
    ('ENTEN', 'Schwimmvögel', 'A', 10, 6, 5),
    ('BLANK', 'glänzend', 'D', 1, 1, 5),
    ('BART', 'Gesichtshaar', 'D', 7, 1, 4),
    ('ROM', 'Ewige Stadt', 'D', 1, 2, 3),
    ('NEUBAU', 'moderne Immobilie', 'D', 5, 2, 6),
    ('AKT', 'Nacktgemälde', 'D', 1, 3, 3),
    ('ERSTEN', 'führenden', 'D', 5, 3, 6),
    ('SEID', 'existiert', 'D', 3, 4, 4),
    ('SPEER', 'Wurfspieß', 'D', 4, 5, 5),
    ('ESSE', 'verspeise', 'D', 2, 6, 4),
    ('LUPE', 'Brennglas', 'D', 7, 6, 4),
    ('ORTE', 'Plätze', 'D', 1, 7, 4),
    ('UFERN', 'Gestaden', 'D', 6, 7, 5),
    ('ABEND', 'Tagesende', 'D', 1, 8, 5),
    ('BOT', 'unterbreitete', 'D', 8, 8, 3),
    ('SETZE', 'stelle', 'D', 1, 9, 5),
    ('LESE', 'schmökere', 'D', 7, 9, 4),
    ('EIS', 'Sorbet', 'D', 1, 10, 3),
    ('RAN', 'hinzu', 'D', 8, 10, 3)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r092-12x12-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r092-12x12-02', 'Rätsel 92 · 12×12', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '12x12-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('HELD', 'Recke', 'A', 1, 1, 4),
    ('EWIG', 'endlos', 'A', 1, 8, 4),
    ('ARIE', 'Opernlied', 'A', 2, 1, 4),
    ('ANREDE', 'Begrüßung', 'A', 2, 6, 6),
    ('ABENDS', 'spät am Tag', 'A', 3, 1, 6),
    ('ZIEL', 'Zweck', 'A', 3, 8, 4),
    ('RAD', 'Kreisscheibe', 'A', 4, 1, 3),
    ('HAB', 'Besitz', 'A', 4, 9, 3),
    ('EUER', 'Possessiv (ihr)', 'A', 5, 1, 4),
    ('HEBEL', 'Griff', 'A', 5, 6, 5),
    ('TRUHE', 'Kiste', 'A', 6, 2, 5),
    ('IREN', 'Gälen', 'A', 6, 8, 4),
    ('GENFER', '... See', 'A', 7, 1, 6),
    ('ALB', 'Schwäbische ...', 'A', 8, 7, 3),
    ('SAUM', 'Rand', 'A', 9, 1, 4),
    ('IRIS', 'Schwertlilie', 'A', 9, 8, 4),
    ('SCHUHE', 'Treter', 'A', 10, 1, 6),
    ('GUSS', 'Regenschauer', 'A', 10, 8, 4),
    ('EHRT', 'zollt Respekt', 'A', 11, 1, 4),
    ('HUETTE', 'Kate', 'A', 11, 6, 6),
    ('HAARE', 'Mähne', 'D', 1, 1, 5),
    ('GASSE', 'Durchgang', 'D', 7, 1, 5),
    ('ERBAUTE', 'errichtete', 'D', 1, 2, 7),
    ('ACH', 'Seufzer', 'D', 9, 2, 3),
    ('LIEDERN', 'Songs', 'D', 1, 3, 7),
    ('UHR', 'Chronometer', 'D', 9, 3, 3),
    ('DEN', 'Artikel (Akkusativ)', 'D', 1, 4, 3),
    ('RUF', 'Leumund', 'D', 5, 4, 3),
    ('MUT', 'Tapferkeit', 'D', 9, 4, 3),
    ('HEU', 'Trockengras', 'D', 6, 5, 3),
    ('RASCHER', 'schneller', 'D', 1, 6, 7),
    ('WEH', 'schmerzhaft', 'D', 9, 6, 3),
    ('ERZ', 'Bodenschatz', 'D', 1, 8, 3),
    ('BILLIGE', 'preiswerte', 'D', 5, 8, 7),
    ('WEIHER', 'Teich', 'D', 1, 9, 6),
    ('BRUT', 'Nachwuchs', 'D', 8, 9, 4),
    ('IDEALE', 'perfekte', 'D', 1, 10, 6),
    ('IST', 'befindet sich', 'D', 9, 10, 3),
    ('GELB', 'sonnenfarben', 'D', 1, 11, 4),
    ('NUESSE', 'Kerne', 'D', 6, 11, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r093-12x12-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r093-12x12-03', 'Rätsel 93 · 12×12', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '12x12-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('SCHOB', 'drückte', 'A', 1, 1, 5),
    ('GRADE', 'Stufen', 'A', 1, 7, 5),
    ('EHEFRAU', 'Gattin', 'A', 2, 1, 7),
    ('KUH', 'Rind', 'A', 2, 9, 3),
    ('HARTE', 'feste', 'A', 3, 1, 5),
    ('TOR', 'Treffer', 'A', 3, 9, 3),
    ('ERZ', 'Gestein', 'A', 4, 1, 3),
    ('TAKT', 'Rhythmus', 'A', 4, 5, 4),
    ('TUT', 'verrichtet', 'A', 5, 5, 3),
    ('WEN', 'Fragewort (Akk.)', 'A', 5, 9, 3),
    ('OSLO', 'Friedenspreis-Stadt', 'A', 6, 1, 4),
    ('SODASS', 'damit', 'A', 7, 5, 6),
    ('BEI', 'nahe an', 'A', 8, 1, 3),
    ('ASIATEN', 'Orientalen', 'A', 8, 5, 7),
    ('ERSTE', 'anfängliche', 'A', 9, 1, 5),
    ('ARENA', 'Stadion', 'A', 9, 7, 5),
    ('IDEALES', 'perfektes', 'A', 10, 1, 7),
    ('LAS', 'schmökerte', 'A', 10, 9, 3),
    ('MENGE', 'Masse', 'A', 11, 1, 5),
    ('JETS', 'Düsenflieger', 'A', 11, 8, 4),
    ('SEHE', 'schaue', 'D', 1, 1, 4),
    ('BEIM', 'bei dem', 'D', 8, 1, 4),
    ('CHARTS', 'Hitparade', 'D', 1, 2, 6),
    ('ERDE', 'Welt', 'D', 8, 2, 4),
    ('HERZ', 'Pumpe', 'D', 1, 3, 4),
    ('LEISEN', 'stillen', 'D', 6, 3, 6),
    ('OFT', 'des Öfteren', 'D', 1, 4, 3),
    ('TAG', 'Kalenderblatt', 'D', 9, 4, 3),
    ('BRETT', 'Planke', 'D', 1, 5, 5),
    ('SAELE', 'Hallen', 'D', 7, 5, 5),
    ('AUTOS', 'Wagen', 'D', 4, 6, 5),
    ('GUCKT', 'schaut', 'D', 1, 7, 5),
    ('DIAS', 'Lichtbilder', 'D', 7, 7, 4),
    ('PAAR', 'einige', 'D', 6, 8, 4),
    ('AKT', 'Aufzug', 'D', 1, 9, 3),
    ('STELE', 'Gedenkstein', 'D', 7, 9, 5),
    ('DUO', 'Tandem', 'D', 1, 10, 3),
    ('SENAT', 'Ältestenrat', 'D', 7, 10, 5),
    ('EHRUNG', 'Würdigung', 'D', 1, 11, 6),
    ('NASS', 'feucht', 'D', 8, 11, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r094-12x12-04
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r094-12x12-04', 'Rätsel 94 · 12×12', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '12x12-04' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('PRAEGTEN', 'formten', 'A', 1, 1, 8),
    ('FELLE', 'Pelze', 'A', 2, 1, 5),
    ('RAD', 'Velo', 'A', 2, 7, 3),
    ('AMTES', 'Ende des ...', 'A', 3, 1, 5),
    ('ZEUGE', 'Beobachter', 'A', 3, 7, 5),
    ('DIENT', 'nützt', 'A', 4, 1, 5),
    ('HEER', 'Armee', 'A', 4, 8, 4),
    ('DERSELBE', 'der Gleiche', 'A', 5, 4, 8),
    ('LOS', 'frei', 'A', 6, 9, 3),
    ('MUT', 'Courage', 'A', 7, 2, 3),
    ('TIBET', 'Hochland Asiens', 'A', 7, 6, 5),
    ('RIGA', 'lett. Hauptstadt', 'A', 8, 1, 4),
    ('ALL', 'Weltraum', 'A', 8, 6, 3),
    ('ANALOG', 'entsprechend', 'A', 9, 1, 6),
    ('ARGE', 'schlimme', 'A', 9, 8, 4),
    ('BUB', 'Junge', 'A', 10, 1, 3),
    ('SAAT', 'Samen', 'A', 10, 8, 4),
    ('ESEL', 'Dickkopf', 'A', 11, 1, 4),
    ('EBENSO', 'gleichfalls', 'A', 11, 6, 6),
    ('PFAD', 'Weg', 'D', 1, 1, 4),
    ('RABE', 'Unglücksvogel', 'D', 8, 1, 4),
    ('REMIS', 'Gleichstand', 'D', 1, 2, 5),
    ('MINUS', 'Fehlbetrag', 'D', 7, 2, 5),
    ('ALTE', 'betagte', 'D', 1, 3, 4),
    ('ZUGABE', 'Extra', 'D', 6, 3, 6),
    ('ELEND', 'Misere', 'D', 1, 4, 5),
    ('TAL', 'Senke', 'D', 7, 4, 3),
    ('GESTEN', 'Gebärden', 'D', 1, 5, 6),
    ('TAGTE', 'beriet', 'D', 7, 6, 5),
    ('ERZ', 'Gestein', 'D', 1, 7, 3),
    ('SEIL', 'Tau', 'D', 5, 7, 4),
    ('NAEHE', 'Umgebung', 'D', 1, 8, 5),
    ('BLASE', 'Clique (ugs.)', 'D', 7, 8, 5),
    ('DUELLE', 'Zweikämpfe', 'D', 2, 9, 6),
    ('RAN', 'heran', 'D', 9, 9, 3),
    ('GEBOT', 'Weisung', 'D', 3, 10, 5),
    ('GAS', 'Treibstoff', 'D', 9, 10, 3),
    ('TIERES', 'Name des ...', 'D', 1, 11, 6),
    ('VETO', 'Einspruch', 'D', 8, 11, 4)
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
    ('MAI', 'Wonnemonat', 'A', 1, 1, 3),
    ('EWIG', 'unaufhörlich', 'A', 1, 8, 4),
    ('INNERE', 'interne', 'A', 2, 1, 6),
    ('BUDE', 'Kiosk', 'A', 2, 8, 4),
    ('ASS', 'verspeiste', 'A', 3, 1, 3),
    ('EBENEN', 'Flächen', 'A', 3, 6, 6),
    ('RUNDER', 'kugeliger', 'A', 4, 6, 6),
    ('IDEALES', 'perfektes', 'A', 5, 1, 7),
    ('ORTEN', 'Stellen', 'A', 6, 2, 5),
    ('UMZUG', 'Parade', 'A', 7, 1, 5),
    ('TAUBE', 'Stadtvogel', 'A', 7, 7, 5),
    ('OMA', 'Omi', 'A', 8, 3, 3),
    ('RUFEN', 'schreien', 'A', 8, 7, 5),
    ('WEG', 'Pfad', 'A', 9, 1, 3),
    ('LIEGEND', 'ruhend', 'A', 9, 5, 7),
    ('EHEN', 'Verbindungen', 'A', 10, 1, 4),
    ('HUERDE', 'Hindernis', 'A', 10, 6, 6),
    ('GEN', 'nach', 'A', 11, 1, 3),
    ('NENNEN', 'bezeichnen', 'A', 11, 6, 6),
    ('MIAMI', 'Stadt in Florida', 'D', 1, 1, 5),
    ('UMWEG', 'Abstecher', 'D', 7, 1, 5),
    ('ANS', 'an das', 'D', 1, 2, 3),
    ('DOM', 'Kathedrale', 'D', 5, 2, 3),
    ('EHE', 'Bund fürs Leben', 'D', 9, 2, 3),
    ('INS', 'in das', 'D', 1, 3, 3),
    ('ERZOGEN', 'großgezogen', 'D', 5, 3, 7),
    ('DATUM', 'Stichtag', 'D', 4, 4, 5),
    ('LEGAL', 'rechtmäßig', 'D', 5, 5, 5),
    ('LEEREN', 'hohlen', 'D', 1, 6, 6),
    ('IHN', 'Akkusativ von er', 'D', 9, 6, 3),
    ('BUS', 'Car (schweiz.)', 'D', 3, 7, 3),
    ('TREUE', 'Loyalität', 'D', 7, 7, 5),
    ('EBEN', 'flach', 'D', 1, 8, 4),
    ('SAUGEN', 'lutschen', 'D', 6, 8, 6),
    ('WUNDE', 'Verletzung', 'D', 1, 9, 5),
    ('UFERN', 'Gestaden', 'D', 7, 9, 5),
    ('IDEE', 'Einfall', 'D', 1, 10, 4),
    ('ABENDE', 'Soireen', 'D', 6, 10, 6),
    ('GENRE', 'Stilrichtung', 'D', 1, 11, 5),
    ('ENDEN', 'aufhören', 'D', 7, 11, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r096-13x13-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r096-13x13-01', 'Rätsel 96 · 13×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '13x13-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ALB', 'Schwäbische ...', 'A', 1, 1, 3),
    ('DER', 'Artikel (männl.)', 'A', 1, 5, 3),
    ('ASYL', 'Unterschlupf', 'A', 1, 9, 4),
    ('LAUB', 'Blätter', 'A', 2, 1, 4),
    ('LOCKT', 'reizt', 'A', 2, 6, 5),
    ('LEGITIM', 'rechtmäßig', 'A', 3, 1, 7),
    ('TRUG', 'hatte an', 'A', 3, 9, 4),
    ('TOTAL', 'völlig', 'A', 4, 4, 5),
    ('OHR', 'Lauscher', 'A', 5, 1, 3),
    ('BENENNEN', 'bezeichnen', 'A', 5, 5, 8),
    ('ZEUGT', 'zeigt von', 'A', 6, 1, 5),
    ('SIEG', 'Triumph', 'A', 6, 7, 4),
    ('ELF', 'Zahl (10+1)', 'A', 7, 1, 3),
    ('STERN', 'Gestirn', 'A', 7, 8, 5),
    ('ATEM', 'Odem', 'A', 8, 1, 4),
    ('RIET', 'empfahl', 'A', 8, 6, 4),
    ('ORTE', 'Plätze', 'A', 9, 9, 4),
    ('HELFERN', 'Assistenten', 'A', 10, 2, 7),
    ('EIS', 'Gefrorenes', 'A', 10, 10, 3),
    ('SAITEN', 'Drähte', 'A', 11, 1, 6),
    ('INS', 'in das', 'A', 11, 10, 3),
    ('IDEEN', 'Einfälle', 'A', 12, 2, 5),
    ('RINGE', 'Reifen', 'A', 12, 8, 5),
    ('ALL', 'Kosmos', 'D', 1, 1, 3),
    ('OZEAN', 'Weltmeer', 'D', 5, 1, 5),
    ('LAECHELT', 'schmunzelt', 'D', 1, 2, 8),
    ('HAI', 'Raubfisch', 'D', 10, 2, 3),
    ('BUG', 'Vorderschiff', 'D', 1, 3, 3),
    ('RUFE', 'Schreie', 'D', 5, 3, 4),
    ('EID', 'Gelöbnis', 'D', 10, 3, 3),
    ('BIT', 'Binärziffer', 'D', 2, 4, 3),
    ('MALTE', 'pinselte', 'D', 8, 4, 5),
    ('TOBT', 'wütet', 'D', 3, 5, 4),
    ('FEE', 'Zauberin', 'D', 10, 5, 3),
    ('ELITE', 'Oberschicht', 'D', 1, 6, 5),
    ('BRUENN', 'Brno', 'D', 7, 6, 6),
    ('ROMANS', 'Held des ...', 'D', 1, 7, 6),
    ('LEISE', 'gedämpft', 'D', 4, 8, 5),
    ('NUR', 'lediglich', 'D', 10, 8, 3),
    ('AKT', 'Nacktgemälde', 'D', 1, 9, 3),
    ('NETTO', 'ohne Steuern', 'D', 5, 9, 5),
    ('STRENGE', 'rigorose', 'D', 1, 10, 7),
    ('REIN', 'sauber', 'D', 9, 10, 4),
    ('RATING', 'Bewertung', 'D', 7, 11, 6),
    ('LAG', 'befand sich', 'D', 1, 12, 3),
    ('NUN', 'jetzt', 'D', 5, 12, 3),
    ('ESSE', 'speise', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r097-13x13-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r097-13x13-02', 'Rätsel 97 · 13×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '13x13-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('REPUBLIK', 'Freistaat', 'A', 1, 1, 8),
    ('WOG', 'schaukelte', 'A', 1, 10, 3),
    ('FRUEH', 'zeitig', 'A', 2, 3, 5),
    ('GEHE', 'laufe', 'A', 2, 9, 4),
    ('LAGERS', 'Leiter des ...', 'A', 3, 3, 6),
    ('HIT', 'Chartstürmer', 'A', 3, 10, 3),
    ('ESEL', 'Grautier', 'A', 4, 1, 4),
    ('REAKTOR', 'Meiler', 'A', 4, 6, 7),
    ('LEGT', 'platziert', 'A', 5, 1, 4),
    ('ESSE', 'speise', 'A', 5, 6, 4),
    ('TITELN', 'Namen', 'A', 6, 1, 6),
    ('SIE', 'Anrede', 'A', 6, 8, 3),
    ('RELIKT', 'Überbleibsel', 'A', 7, 7, 6),
    ('KIND', 'Nachwuchs', 'A', 8, 3, 4),
    ('GRENZEN', 'Schranken', 'A', 9, 1, 7),
    ('STIL', 'Machart', 'A', 9, 9, 4),
    ('LANDEN', 'aufsetzen', 'A', 10, 1, 6),
    ('VERSE', 'Reime', 'A', 10, 8, 5),
    ('AGIEREN', 'handeln', 'A', 11, 1, 7),
    ('HASS', 'Abscheu', 'A', 11, 9, 4),
    ('STAR', 'Berühmtheit', 'A', 12, 1, 4),
    ('REGTE', 'bewegte', 'A', 12, 8, 5),
    ('REGELTE', 'ordnete', 'D', 1, 1, 7),
    ('GLAS', 'Trinkgefäß', 'D', 9, 1, 4),
    ('SEI', 'existiere', 'D', 4, 2, 3),
    ('RAGT', 'steht empor', 'D', 9, 2, 4),
    ('PFLEGT', 'hegt', 'D', 1, 3, 6),
    ('KENIA', 'Staat in Ostafrika', 'D', 8, 3, 5),
    ('URALTE', 'steinalte', 'D', 1, 4, 6),
    ('INDER', 'Asiate', 'D', 8, 4, 5),
    ('BUG', 'Programmfehler', 'D', 1, 5, 3),
    ('LINZER', '... Torte', 'D', 6, 5, 6),
    ('LEEREN', 'hohlen', 'D', 1, 6, 6),
    ('DENEN', 'Relativ (Dat. Pl.)', 'D', 8, 6, 5),
    ('IHRES', 'seines', 'D', 1, 7, 5),
    ('SASSEN', 'hockten', 'D', 3, 8, 6),
    ('KEIL', 'Dreieckklotz', 'D', 4, 9, 4),
    ('SEHE', 'erblicke', 'D', 9, 9, 4),
    ('WEHT', 'bläst', 'D', 1, 10, 4),
    ('EINTRAG', 'Vermerk', 'D', 6, 10, 7),
    ('OHIO', 'Buckeye-Staat', 'D', 1, 11, 4),
    ('ISST', 'verzehrt', 'D', 9, 11, 4),
    ('GETROST', 'beruhigt', 'D', 1, 12, 7),
    ('LESE', 'schmökere', 'D', 9, 12, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r098-13x13-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r098-13x13-03', 'Rätsel 98 · 13×13', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '13x13-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ADEL', 'Aristokratie', 'A', 1, 1, 4),
    ('TON', 'Klang', 'A', 1, 6, 3),
    ('SAH', 'erblickte', 'A', 1, 10, 3),
    ('KUH', 'Milchlieferantin', 'A', 2, 1, 3),
    ('ROBUST', 'stabil', 'A', 2, 5, 6),
    ('TOETETEN', 'brachten um', 'A', 3, 1, 8),
    ('ELF', 'Zahl (10+1)', 'A', 3, 10, 3),
    ('SLOGAN', 'Werbespruch', 'A', 4, 2, 6),
    ('RIEF', 'schrie', 'A', 4, 9, 4),
    ('EDEL', 'vornehm', 'A', 5, 3, 4),
    ('GUT', 'prima', 'A', 5, 10, 3),
    ('BAU', 'Konstruktion', 'A', 6, 1, 3),
    ('ERNTETE', 'pflückte', 'A', 6, 6, 7),
    ('GUTEM', 'bravem', 'A', 7, 1, 5),
    ('IKONE', 'Heiligenbild', 'A', 7, 7, 5),
    ('ESEL', 'Grautier', 'A', 8, 1, 4),
    ('FELD', 'Acker', 'A', 8, 6, 4),
    ('SAEURE', 'Gegenteil von Base', 'A', 9, 7, 6),
    ('AHNT', 'vermutet', 'A', 10, 1, 4),
    ('WIR', 'Pronomen (1. Pl.)', 'A', 10, 6, 3),
    ('FIX', 'schnell', 'A', 10, 10, 3),
    ('GEIER', 'Aasvogel', 'A', 11, 1, 5),
    ('GELEGE', 'Eier', 'A', 11, 7, 6),
    ('TUER', 'Pforte', 'A', 12, 1, 4),
    ('YEN', 'Währung Japans', 'A', 12, 6, 3),
    ('RAN', 'hinzu', 'A', 12, 10, 3),
    ('AKT', 'Aufzug', 'D', 1, 1, 3),
    ('ABGESAGT', 'gestrichen', 'D', 5, 1, 8),
    ('DUOS', 'Paare', 'D', 1, 2, 4),
    ('AUS', 'vorbei', 'D', 6, 2, 3),
    ('HEU', 'Trockengras', 'D', 10, 2, 3),
    ('EHELEUTE', 'Gatten', 'D', 1, 3, 8),
    ('NIE', 'nimmer', 'D', 10, 3, 3),
    ('TOD', 'Ableben', 'D', 3, 4, 3),
    ('ELSTER', 'Rabenvogel', 'D', 7, 4, 6),
    ('REGE', 'geschäftig', 'D', 2, 5, 4),
    ('TOTALE', 'völlige', 'D', 1, 6, 6),
    ('OBEN', 'in der Höhe', 'D', 1, 7, 4),
    ('RIESIGE', 'gewaltige', 'D', 6, 7, 7),
    ('NUN', 'jetzt', 'D', 1, 8, 3),
    ('UNKLAREN', 'vagen', 'D', 5, 8, 8),
    ('TODE', 'zu ... betrübt', 'D', 6, 9, 4),
    ('STEIGEN', 'klettern', 'D', 1, 10, 7),
    ('UFER', 'Gestade', 'D', 9, 10, 4),
    ('LEUTE', 'Volk', 'D', 3, 11, 5),
    ('RIGA', 'lett. Hauptstadt', 'D', 9, 11, 4),
    ('HOFFTE', 'erwartete', 'D', 1, 12, 6),
    ('HEXEN', 'Zauberinnen', 'D', 8, 12, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r099-15x15-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r099-15x15-01', 'Rätsel 99 · 15×15', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '15x15-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('LOGE', 'Theaterrang', 'A', 1, 1, 4),
    ('APP', 'Anwendung', 'A', 1, 6, 3),
    ('SOFIA', 'bulg. Hauptstadt', 'A', 1, 10, 5),
    ('EREILTE', 'traf', 'A', 2, 1, 7),
    ('WAHR', 'zutreffend', 'A', 2, 9, 4),
    ('STIL', 'Machart', 'A', 3, 1, 4),
    ('ORT', 'Platz', 'A', 3, 6, 3),
    ('TREFF', 'Stelldichein', 'A', 3, 10, 5),
    ('BESTEM', 'optimalem', 'A', 4, 1, 6),
    ('TEILS', 'partiell', 'A', 4, 10, 5),
    ('AST', 'Knorren', 'A', 5, 1, 3),
    ('REALE', 'echte', 'A', 5, 5, 5),
    ('RIO', 'Zuckerhut-Stadt', 'A', 6, 12, 3),
    ('AGIERT', 'handelt', 'A', 7, 2, 6),
    ('BEDARF', 'Nachfrage', 'A', 7, 9, 6),
    ('AUE', 'Talwiese', 'A', 8, 1, 3),
    ('TOETETEN', 'brachten um', 'A', 8, 5, 8),
    ('WEM', 'Fragewort (Dativ)', 'A', 9, 4, 3),
    ('LAS', 'entzifferte', 'A', 9, 9, 3),
    ('POLEN', 'Weichselland', 'A', 10, 1, 5),
    ('KRAN', 'Hebezeug', 'A', 10, 7, 4),
    ('FROH', 'heiter', 'A', 11, 1, 4),
    ('ZEUG', 'Kram', 'A', 11, 6, 4),
    ('ZAEH', 'hartnäckig', 'A', 11, 11, 4),
    ('ASTEROID', 'Kleinplanet', 'A', 12, 1, 8),
    ('BUCHE', 'Laubbaum', 'A', 12, 10, 5),
    ('NENNE', 'bezeichne', 'A', 13, 4, 5),
    ('UMHER', 'herum', 'A', 13, 10, 5),
    ('EID', 'Schwur', 'A', 14, 1, 3),
    ('HEERES', 'Führung des ...', 'A', 14, 5, 6),
    ('ERZ', 'Gestein', 'A', 14, 12, 3),
    ('LESBAR', 'entzifferbar', 'D', 1, 1, 6),
    ('PFADE', 'Wege', 'D', 10, 1, 5),
    ('ORTES', 'Name des ...', 'D', 1, 2, 5),
    ('AUTORS', 'Werk des ...', 'D', 7, 2, 6),
    ('GEISTIGE', 'mentale', 'D', 1, 3, 8),
    ('LOT', 'Senkblei', 'D', 10, 3, 3),
    ('EILT', 'hastet', 'D', 1, 4, 4),
    ('WEHEN', 'Kontraktionen', 'D', 9, 4, 5),
    ('ERBETEN', 'erwünscht', 'D', 4, 5, 7),
    ('REH', 'Waldtier', 'D', 12, 5, 3),
    ('ATOME', 'Teilchen', 'D', 1, 6, 5),
    ('ROM', 'Ewige Stadt', 'D', 7, 6, 3),
    ('ZONE', 'Bereich', 'D', 11, 6, 4),
    ('PER', 'mittels', 'D', 1, 7, 3),
    ('AKTE', 'Vorgang', 'D', 5, 7, 4),
    ('KEINE', 'null', 'D', 10, 7, 5),
    ('TAL', 'Niederung', 'D', 3, 8, 3),
    ('RUDER', 'Steuer', 'D', 10, 8, 5),
    ('BELAG', 'Überzug', 'D', 7, 9, 5),
    ('SATT', 'vollgestopft', 'D', 1, 10, 4),
    ('GETAN', 'gemacht', 'D', 6, 10, 5),
    ('BUS', 'Nahverkehrsmittel', 'D', 12, 10, 3),
    ('OHREN', 'Hörorgane', 'D', 1, 11, 5),
    ('DES', 'Artikel (Genitiv)', 'D', 7, 11, 3),
    ('ZUM', 'zu dem', 'D', 11, 11, 3),
    ('FREI', 'kostenlos', 'D', 1, 12, 4),
    ('RAN', 'hinzu', 'D', 6, 12, 3),
    ('WACHE', 'Posten', 'D', 10, 12, 5),
    ('FLAIR', 'Ambiente', 'D', 3, 13, 5),
    ('EHER', 'vielmehr', 'D', 11, 13, 4),
    ('AUFS', 'auf das', 'D', 1, 14, 4),
    ('OFEN', 'Herd', 'D', 6, 14, 4),
    ('HERZ', 'Pumpe', 'D', 11, 14, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r100-15x15-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r100-15x15-02', 'Rätsel 100 · 15×15', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '15x15-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('SAUNA', 'Schwitzbad', 'A', 1, 1, 5),
    ('SKALA', 'Stufenleiter', 'A', 1, 10, 5),
    ('ELF', 'Zahl (10+1)', 'A', 2, 1, 3),
    ('BOOT', 'Kahn', 'A', 2, 5, 4),
    ('PARIS', 'Seine-Stadt', 'A', 2, 10, 5),
    ('KLEBT', 'haftet', 'A', 3, 1, 5),
    ('BEKOMMST', 'erhältst', 'A', 3, 7, 8),
    ('RIESIG', 'gewaltig', 'A', 4, 3, 6),
    ('SIEG', 'Triumph', 'A', 5, 4, 4),
    ('ETWA', 'vielleicht', 'A', 5, 9, 4),
    ('PAKT', 'Bündnis', 'A', 6, 1, 4),
    ('OEL', 'Schmierstoff', 'A', 6, 6, 3),
    ('EURO', 'Währung', 'A', 6, 11, 4),
    ('HEU', 'Trockengras', 'A', 7, 1, 3),
    ('INFOS', 'Auskünfte', 'A', 7, 10, 5),
    ('ALB', 'Gebirge', 'A', 8, 1, 3),
    ('ALLES', 'das Ganze', 'A', 8, 5, 5),
    ('IST', 'befindet sich', 'A', 8, 11, 3),
    ('STARB', 'erlag', 'A', 9, 1, 5),
    ('FANG', 'Beute', 'A', 9, 8, 4),
    ('ISST', 'speist', 'A', 10, 4, 4),
    ('NIE', 'zu keiner Zeit', 'A', 10, 12, 3),
    ('KROATIEN', 'Adriastaat', 'A', 11, 2, 8),
    ('MORD', 'Tötung', 'A', 11, 11, 4),
    ('HAI', 'Meeresräuber', 'A', 12, 1, 3),
    ('GAB', 'schenkte', 'A', 12, 5, 3),
    ('AERA', 'Epoche', 'A', 12, 11, 4),
    ('UNTREUE', 'Seitensprung', 'A', 13, 1, 7),
    ('ERSTER', 'anfänglicher', 'A', 13, 9, 6),
    ('TUT', 'verrichtet', 'A', 14, 1, 3),
    ('TOR', 'Dummkopf', 'A', 14, 7, 3),
    ('SENF', 'Gewürzpaste', 'A', 14, 11, 4),
    ('SEKT', 'Schaumwein', 'D', 1, 1, 4),
    ('PHASE', 'Abschnitt', 'D', 6, 1, 5),
    ('HUT', 'Kopfbedeckung', 'D', 12, 1, 3),
    ('ALL', 'Kosmos', 'D', 1, 2, 3),
    ('HAELT', 'stoppt', 'D', 5, 2, 5),
    ('KANU', 'Paddelboot', 'D', 11, 2, 4),
    ('UFER', 'Gestade', 'D', 1, 3, 4),
    ('KUBA', 'Karibikinsel', 'D', 6, 3, 4),
    ('RITT', 'Reise zu Pferd', 'D', 11, 3, 4),
    ('BIST', 'existierst', 'D', 3, 4, 4),
    ('RIO', 'Zuckerhut-Stadt', 'D', 9, 4, 3),
    ('ABTEI', 'Kloster', 'D', 1, 5, 5),
    ('ABSAGEN', 'streichen', 'D', 8, 5, 7),
    ('SEOUL', 'korean. Hauptstadt', 'D', 4, 6, 5),
    ('STAU', 'Blechlawine', 'D', 10, 6, 4),
    ('OBIGE', 'erwähnte', 'D', 2, 7, 5),
    ('TIBET', 'Hochland Asiens', 'D', 10, 7, 5),
    ('STEG', 'Brücklein', 'D', 1, 8, 4),
    ('LIEF', 'rannte', 'D', 6, 8, 4),
    ('SAENGER', 'Vokalist', 'D', 8, 9, 7),
    ('SPORT', 'Leibesübung', 'D', 1, 10, 5),
    ('KAM', 'nahte', 'D', 1, 11, 3),
    ('WENIG', 'kaum', 'D', 5, 11, 5),
    ('MASS', 'Größe', 'D', 11, 11, 4),
    ('ARM', 'Gliedmaße', 'D', 1, 12, 3),
    ('AUFS', 'auf das', 'D', 5, 12, 4),
    ('NOETE', 'Sorgen', 'D', 10, 12, 5),
    ('LIST', 'Trick', 'D', 1, 13, 4),
    ('ROT', 'knallig', 'D', 6, 13, 3),
    ('IRREN', 'sich täuschen', 'D', 10, 13, 5),
    ('AST', 'Knorren', 'D', 1, 14, 3),
    ('LOS', 'frei', 'D', 5, 14, 3),
    ('BEDARF', 'Nachfrage', 'D', 9, 14, 6)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r101-15x15-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r101-15x15-03', 'Rätsel 101 · 15×15', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '15x15-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('PFLUG', 'Ackergerät', 'A', 1, 1, 5),
    ('BEERDIGT', 'bestattet', 'A', 1, 7, 8),
    ('IREN', 'Gälen', 'A', 2, 1, 4),
    ('MAIS', 'Kukuruz', 'A', 2, 6, 4),
    ('LAST', 'Bürde', 'A', 3, 1, 4),
    ('URNE', 'Wahlbehälter', 'A', 3, 6, 4),
    ('MEHR', 'obendrein', 'A', 3, 11, 4),
    ('ZUTRITT', 'Einlass', 'A', 4, 1, 7),
    ('KAM', 'traf ein', 'A', 4, 12, 3),
    ('ALLE', 'sämtliche', 'A', 5, 11, 4),
    ('AKKU', 'Stromspeicher', 'A', 6, 1, 4),
    ('GAU', 'Landstrich', 'A', 6, 6, 3),
    ('DEALS', 'Geschäfte', 'A', 6, 10, 5),
    ('PRUEGEL', 'Schläge', 'A', 7, 1, 7),
    ('AESTE', 'Zweige', 'A', 7, 9, 5),
    ('PER', 'via', 'A', 8, 1, 3),
    ('ERTOENT', 'erklingt', 'A', 8, 5, 7),
    ('EBBE', 'Gegenteil der Flut', 'A', 9, 11, 4),
    ('ASCHE', 'Glutrest', 'A', 10, 1, 5),
    ('MUT', 'Tapferkeit', 'A', 10, 7, 3),
    ('NERV', 'Reizleiter', 'A', 10, 11, 4),
    ('REH', 'Waldbewohner', 'A', 11, 1, 3),
    ('REITEN', 'Pferdesport', 'A', 11, 5, 6),
    ('RIO', 'Stadt in Brasilien', 'A', 11, 12, 3),
    ('CLOWN', 'Spaßmacher', 'A', 12, 1, 5),
    ('LAS', 'entzifferte', 'A', 12, 7, 3),
    ('MEER', 'See', 'A', 12, 11, 4),
    ('RUTSCHT', 'gleitet', 'A', 13, 3, 7),
    ('AUF', 'offen', 'A', 13, 11, 3),
    ('ERSTE', 'führende', 'A', 14, 1, 5),
    ('ELITEN', 'Oberschichten', 'A', 14, 9, 6),
    ('PILZ', 'Schwamm', 'D', 1, 1, 4),
    ('APP', 'Anwendung', 'D', 6, 1, 3),
    ('ARCHE', 'Noahs Schiff', 'D', 10, 1, 5),
    ('FRAU', 'Gemahlin', 'D', 1, 2, 4),
    ('KREISEL', 'Spielzeug', 'D', 6, 2, 7),
    ('LEST', 'studiert', 'D', 1, 3, 4),
    ('KUR', 'Erholung', 'D', 6, 3, 3),
    ('CHORS', 'Leiter des ...', 'D', 10, 3, 5),
    ('UNTREUE', 'Seitensprung', 'D', 1, 4, 7),
    ('WUT', 'Raserei', 'D', 12, 4, 3),
    ('GELERNTE', 'ausgebildete', 'D', 7, 5, 8),
    ('MUTIGER', 'tapferer', 'D', 2, 6, 7),
    ('BART', 'Gesichtshaar', 'D', 1, 7, 4),
    ('ALT', 'ergraut', 'D', 6, 7, 3),
    ('MILCH', 'Kuhprodukt', 'D', 10, 7, 5),
    ('EIN', 'unbest. Artikel', 'D', 1, 8, 3),
    ('UTAH', 'Mormonenstaat', 'D', 10, 8, 4),
    ('ESEL', 'Grautier', 'D', 1, 9, 4),
    ('AELTESTE', 'erstgeborene', 'D', 7, 9, 8),
    ('DEN', 'Artikel (Akkusativ)', 'D', 6, 10, 3),
    ('DOM', 'Kathedrale', 'D', 1, 11, 3),
    ('AESTEN', 'Zweigen', 'D', 5, 11, 6),
    ('MAI', '5. Monat', 'D', 12, 11, 3),
    ('EKLAT', 'Skandal', 'D', 3, 12, 5),
    ('BEREUT', 'bedauert', 'D', 9, 12, 6),
    ('HALLE', 'Saal', 'D', 3, 13, 5),
    ('BRIEFE', 'Schreiben', 'D', 9, 13, 6),
    ('TURMES', 'Spitze des ...', 'D', 1, 14, 6),
    ('BEVOR', 'ehe', 'D', 8, 14, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r102-10x10-01
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r102-10x10-01', 'Rätsel 102 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-01' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('GAR', 'völlig', 'A', 1, 1, 3),
    ('COOL', 'lässig', 'A', 1, 6, 4),
    ('ADELS', 'Titel des ...', 'A', 2, 1, 5),
    ('PRO', 'je', 'A', 2, 7, 3),
    ('NEUE', 'moderne', 'A', 3, 1, 4),
    ('WATT', 'Schlickküste', 'A', 3, 6, 4),
    ('GLEISE', 'Schienen', 'A', 4, 1, 6),
    ('SIMPLE', 'einfache', 'A', 5, 4, 6),
    ('STUTE', 'weibl. Pferd', 'A', 6, 1, 5),
    ('FAX', 'Telekopie', 'A', 6, 7, 3),
    ('ARME', 'Mittellose', 'A', 7, 1, 4),
    ('TAGT', 'berät', 'A', 7, 6, 4),
    ('LIST', 'Trick', 'A', 8, 1, 4),
    ('ODER', 'bzw.', 'A', 8, 6, 4),
    ('ZOO', 'Tiergarten', 'A', 9, 1, 3),
    ('ARENA', 'Stadion', 'A', 9, 5, 5),
    ('GANG', 'Flur', 'D', 1, 1, 4),
    ('SALZ', 'Würzmittel', 'D', 6, 1, 4),
    ('ADEL', 'blaues Blut', 'D', 1, 2, 4),
    ('TRIO', 'Dreiergruppe', 'D', 6, 2, 4),
    ('REUE', 'Bedauern', 'D', 1, 3, 4),
    ('UMSO', 'Konjunktionaladverb', 'D', 6, 3, 4),
    ('LEISTET', 'vollbringt', 'D', 2, 4, 7),
    ('SIE', 'Anrede', 'D', 4, 5, 3),
    ('WEM', 'Fragewort (Dativ)', 'D', 3, 6, 3),
    ('TOR', 'Dummkopf', 'D', 7, 6, 3),
    ('OPA', 'Großvater', 'D', 1, 7, 3),
    ('PFADE', 'Wege', 'D', 5, 7, 5),
    ('ORT', 'Platz', 'D', 1, 8, 3),
    ('LAGEN', 'ruhten', 'D', 5, 8, 5),
    ('LOT', 'Senkrechte', 'D', 1, 9, 3),
    ('EXTRA', 'zusätzlich', 'D', 5, 9, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r103-10x10-02
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r103-10x10-02', 'Rätsel 103 · 10×10', g.id, 'veroeffentlicht', 3, now()
  from gitter g where g.name = '10x10-02' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('ARG', 'schlimm', 'A', 1, 1, 3),
    ('WACHE', 'Posten', 'A', 1, 5, 5),
    ('SAALE', 'Fluss durch Halle', 'A', 2, 1, 5),
    ('HOB', 'wuchtete', 'A', 2, 7, 3),
    ('STROH', 'Halme', 'A', 3, 1, 5),
    ('ALB', 'Schwäbische ...', 'A', 3, 7, 3),
    ('GROTTE', 'Höhle', 'A', 4, 4, 6),
    ('SPAETE', 'vorgerückte', 'A', 5, 1, 6),
    ('TON', 'Klang', 'A', 6, 1, 3),
    ('FLOH', 'flüchtete', 'A', 6, 6, 4),
    ('ERZ', 'Bodenschatz', 'A', 7, 1, 3),
    ('WEIDE', 'Wiese', 'A', 7, 5, 5),
    ('HEU', 'Trockengras', 'A', 8, 1, 3),
    ('ENGEL', 'Himmelsbote', 'A', 8, 5, 5),
    ('ENGEM', 'schmalem', 'A', 9, 1, 5),
    ('ARM', 'Gliedmaße', 'A', 9, 7, 3),
    ('ASS', 'speiste', 'D', 1, 1, 3),
    ('STEHE', 'ich ... auf', 'D', 5, 1, 5),
    ('RAT', 'Gremium', 'D', 1, 2, 3),
    ('POREN', 'Löcher', 'D', 5, 2, 5),
    ('GAR', 'völlig', 'D', 1, 3, 3),
    ('ANZUG', 'Zweiteiler', 'D', 5, 3, 5),
    ('LOGE', 'Theaterrang', 'D', 2, 4, 4),
    ('WEHRT', 'verteidigt', 'D', 1, 5, 5),
    ('WEM', 'Fragewort (Dativ)', 'D', 7, 5, 3),
    ('OEFEN', 'Herde', 'D', 4, 6, 5),
    ('CHAT', 'Plauderei', 'D', 1, 7, 4),
    ('LIGA', 'Spielklasse', 'D', 6, 7, 4),
    ('HOLT', 'besorgt', 'D', 1, 8, 4),
    ('ODER', 'bzw.', 'D', 6, 8, 4),
    ('EBBE', 'Gegenteil der Flut', 'D', 1, 9, 4),
    ('HELM', 'Kopfschutz', 'D', 6, 9, 4)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

-- r104-10x10-03
with neu as (
  insert into raetsel (slug, titel, gitter_id, status, schwierigkeit, veroeffentlicht_am)
  select 'r104-10x10-03', 'Rätsel 104 · 10×10', g.id, 'veroeffentlicht', 2, now()
  from gitter g where g.name = '10x10-03' order by g.id limit 1
  on conflict (slug) do nothing
  returning id
)
insert into fragen (raetsel_id, wort_id, frage_varianten_id, richtung, start_zeile, start_spalte, laenge)
select neu.id, w.id, fv.id, v.dir, v.r, v.c, v.len
from neu cross join (values
    ('AMTES', 'Ende des ...', 'A', 1, 1, 5),
    ('HEU', 'Trockengras', 'A', 1, 7, 3),
    ('KEIN', 'Verneinung', 'A', 2, 1, 4),
    ('ICH', 'Pronomen (1. Sg.)', 'A', 2, 7, 3),
    ('KIND', 'Nachwuchs', 'A', 3, 1, 4),
    ('SEHR', 'überaus', 'A', 3, 6, 4),
    ('UNTERART', 'Varietät', 'A', 4, 1, 8),
    ('STETIG', 'beständig', 'A', 5, 1, 6),
    ('ENTKAM', 'entwischte', 'A', 6, 4, 6),
    ('ZWANG', 'Druck', 'A', 7, 1, 5),
    ('REH', 'Waldtier', 'A', 7, 7, 3),
    ('OEL', 'Rohstoff', 'A', 8, 1, 3),
    ('TEURE', 'kostspielige', 'A', 8, 5, 5),
    ('ORTE', 'Plätze', 'A', 9, 1, 4),
    ('GAR', 'durchgekocht', 'A', 9, 7, 3),
    ('AKKUS', 'Batterien', 'D', 1, 1, 5),
    ('ZOO', 'Tiergarten', 'D', 7, 1, 3),
    ('MEINT', 'glaubt', 'D', 1, 2, 5),
    ('WER', 'Fragewort (Person)', 'D', 7, 2, 3),
    ('TINTE', 'Tusche', 'D', 1, 3, 5),
    ('ALT', 'betagt', 'D', 7, 3, 3),
    ('ENDETEN', 'hörten auf', 'D', 1, 4, 7),
    ('RINGT', 'kämpft', 'D', 4, 5, 5),
    ('SAGT', 'äußert', 'D', 3, 6, 4),
    ('HIER', 'an diesem Ort', 'D', 1, 7, 4),
    ('KRUG', 'Kanne', 'D', 6, 7, 4),
    ('ECHT', 'authentisch', 'D', 1, 8, 4),
    ('AERA', 'Epoche', 'D', 6, 8, 4),
    ('UHR', 'Zeitmesser', 'D', 1, 9, 3),
    ('UMHER', 'herum', 'D', 5, 9, 5)
  ) as v(wort, frage, dir, r, c, len)
join woerter w on w.wort = v.wort
left join fragen_varianten fv on fv.wort_id = w.id and fv.frage = v.frage;

commit;
