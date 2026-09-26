import type { Session } from '@supabase/supabase-js';
import { supabase } from '@/lib/supabase';

/** Aktuelle Session einmalig abfragen (z.B. beim App-Start). */
export async function getSession(): Promise<Session | null> {
  if (!supabase) return null;
  const { data } = await supabase.auth.getSession();
  return data.session;
}

/** Auf Login/Logout/Token-Refresh reagieren. Gibt eine Abbestell-Funktion zurück. */
export function onAuthChange(callback: (session: Session | null) => void): () => void {
  if (!supabase) return () => {};
  const { data } = supabase.auth.onAuthStateChange((_event, session) => callback(session));
  return () => data.subscription.unsubscribe();
}

/**
 * Registrierung per E-Mail/Passwort. `bestaetigungNoetig` ist true, wenn Supabase
 * (je nach Projekteinstellung "Confirm email") erst eine Bestätigung per Mail verlangt,
 * bevor eine Sitzung entsteht.
 */
export async function signUp(email: string, password: string): Promise<{ bestaetigungNoetig: boolean }> {
  if (!supabase) throw new Error('Supabase ist nicht konfiguriert.');
  const { data, error } = await supabase.auth.signUp({ email, password });
  if (error) throw error;
  return { bestaetigungNoetig: !data.session };
}

export async function signIn(email: string, password: string): Promise<void> {
  if (!supabase) throw new Error('Supabase ist nicht konfiguriert.');
  const { error } = await supabase.auth.signInWithPassword({ email, password });
  if (error) throw error;
}

export async function signOut(): Promise<void> {
  if (!supabase) return;
  await supabase.auth.signOut();
}
