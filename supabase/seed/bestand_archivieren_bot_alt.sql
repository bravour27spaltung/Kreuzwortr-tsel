-- Einmalig ausfuehren, BEVOR der Workflow "Rätsel erzeugen" neue Raetsel einspielt (Oktober 2026).
--
-- Hintergrund: Der woechentliche Bot lief auf main noch mit dem alten Generator (ohne Stamm-Sperre, ohne Wort-Limit).
-- bestand_archivieren_stammsperre.sql (Suffix -alt-20261016) hat damals alle vorhandenen Raetsel archiviert;
-- danach hat der Bot (Lauf vom 19.10.) mit dem alten Generator r183-r208 (26 Raetsel) neu eingespielt.
-- Diese 26 werden hier archiviert (nicht geloescht: fragen/nutzer_fortschritt haengen per on delete cascade an raetsel,
-- duelle.raetsel_id ohne Cascade), und ihre Slugs werden frei, damit der Bot r105 ff. mit dem neuen Generator neu vergeben kann.
-- Idempotent: bereits archivierte Slugs (Suffix -alt-JJJJMMTT) bleiben unberuehrt.
begin;

update raetsel
   set status = 'archiviert',
       slug   = slug || '-alt-20261023'
 where slug ~ '^r(18[3-9]|19[0-9]|20[0-8])-'
   and slug !~ '-alt-[0-9]{8}$';

-- Kontrolle
select count(*) filter (where status = 'veroeffentlicht') as veroeffentlicht,
       count(*) filter (where status = 'archiviert')      as archiviert
  from raetsel;

commit;
