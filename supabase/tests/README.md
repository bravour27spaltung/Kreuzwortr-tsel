# Datenbanktests für die Duelle

Prüfen `supabase/migrations/20260927000000_duelle.sql` gegen ein **lokales** Postgres 16 (nie gegen die echte Supabase-Datenbank):
Rechte, Rätselauswahl, Wertung, Sichtbarkeitsregel, Fristen, Revanche, Sperren bei gleichzeitiger Abgabe, Lösungsprüfung aller Rätsel.

```bash
createdb kwr_test
psql -d kwr_test -f supabase/tests/00_supabase_shim.sql      # Rollen anon/authenticated, auth.users, auth.uid()
psql -d kwr_test -f supabase/tests/01_default_privs.sql      # Default-Rechte wie in Supabase
for f in migrations/20260919000000_create_kreuzwortraetsel_tables.sql migrations/20260925000000_raetsel_laden.sql \
         seed/gitter_vorlagen.sql seed/woerter_seed.sql seed/fragen_varianten_seed.sql seed/raetsel_seed.sql \
         migrations/20260926000000_fortschritt_zugriff.sql migrations/20260927000000_duelle.sql; do
  psql -v ON_ERROR_STOP=1 -q -d kwr_test -f supabase/$f
done
pip install psycopg2-binary
python3 supabase/tests/test_duelle.py      # als Benutzer mit Zugriff auf die Datenbank (DSN oben im Skript anpassen)
```
