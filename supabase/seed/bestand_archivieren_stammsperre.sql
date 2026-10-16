-- Einmalig VOR dem Einspielen des neuen supabase/seed/raetsel_seed.sql ausführen (Rätselbestand mit Stamm-Sperre, Oktober 2026).
--
-- Warum archivieren statt löschen:
--   * fragen und nutzer_fortschritt hängen mit 'on delete cascade' an raetsel -> Löschen würde den Nutzerfortschritt mitlöschen.
--   * duelle.raetsel_id verweist OHNE Cascade auf raetsel -> Löschen schlägt fehl, sobald ein Duell das Rätsel benutzt hat.
--   * raetsel_seed.sql arbeitet mit 'on conflict (slug) do nothing': Rätsel, deren Slug schon existiert, würden stillschweigend
--     NICHT eingefügt. Die alten Slugs müssen also frei werden.
-- Folge: Alte Rätsel bleiben samt Fortschritt/Duellhistorie erhalten, werden aber nicht mehr ausgeliefert
-- (raetsel_liste()/raetsel_laden() und die Duell-Auswahl liefern nur status = 'veroeffentlicht').
-- Idempotent: ein zweiter Lauf ändert nichts (bereits archivierte Slugs enden auf '-alt-20261016').
begin;

update raetsel
   set status = 'archiviert',
       slug   = slug || '-alt-20261016'
 where slug ~ '^r[0-9]+-'
   and slug !~ '-alt-[0-9]{8}$';

-- Kontrolle: erwartet 0 veröffentlichte Rätsel vor dem Einspielen des neuen Seeds
select count(*) filter (where status = 'veroeffentlicht') as veroeffentlicht,
       count(*) filter (where status = 'archiviert')      as archiviert
  from raetsel;

commit;
