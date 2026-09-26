-- wie in Supabase: neue Tabellen/Funktionen im Schema public sind zunächst für anon/authenticated offen
alter default privileges in schema public grant all on tables to anon, authenticated;
alter default privileges in schema public grant all on sequences to anon, authenticated;
alter default privileges in schema public grant execute on functions to anon, authenticated;
