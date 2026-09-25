import { createClient, type SupabaseClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL as string | undefined;
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY as string | undefined;

/** true, wenn in .env echte Supabase-Zugangsdaten stehen (nicht die Platzhalter aus .env.example). */
export const isSupabaseConfigured =
  !!supabaseUrl &&
  !!supabaseAnonKey &&
  !supabaseUrl.includes('dein-projekt') &&
  supabaseAnonKey !== 'dein-anon-key';

/**
 * Supabase-Client oder null. Ohne Konfiguration läuft die App mit den mitgelieferten
 * Rätseln aus public/raetsel/ weiter (siehe src/lib/puzzleSource.ts).
 */
export const supabase: SupabaseClient | null = isSupabaseConfigured
  ? createClient(supabaseUrl!, supabaseAnonKey!)
  : null;
