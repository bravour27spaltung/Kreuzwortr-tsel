import { supabase } from '@/lib/supabase';

/** Ein Eintrag der "Meine Rätsel"-Übersicht auf der Startseite. */
export interface FortschrittEintrag {
  raetselId: number;
  titel: string;
  slug: string | null;
  rows: number;
  cols: number;
  schwierigkeit: number | null;
  fertig: boolean;
  aktualisiertAm: string;
  anzahlEintraege: number;
  anzahlAusgefuellt: number;
}

interface FortschrittListeRow {
  raetsel_id: number;
  titel: string;
  slug: string | null;
  zeilen: number;
  spalten: number;
  schwierigkeit: number | null;
  fertig: boolean;
  aktualisiert_am: string;
  anzahl_eintraege: number;
  anzahl_ausgefuellt: number;
}

/** Eigene Fortschritte über alle Rätsel (leer, wenn nicht eingeloggt oder Supabase nicht konfiguriert). */
export async function listProgress(): Promise<FortschrittEintrag[]> {
  if (!supabase) return [];
  const { data, error } = await supabase.rpc('fortschritt_liste');
  if (error || !Array.isArray(data)) return [];
  return (data as FortschrittListeRow[]).map((r) => ({
    raetselId: r.raetsel_id,
    titel: r.titel,
    slug: r.slug,
    rows: r.zeilen,
    cols: r.spalten,
    schwierigkeit: r.schwierigkeit,
    fertig: r.fertig,
    aktualisiertAm: r.aktualisiert_am,
    anzahlEintraege: r.anzahl_eintraege,
    anzahlAusgefuellt: r.anzahl_ausgefuellt,
  }));
}

/** Gespeicherten Fortschritt zu einem Rätsel laden (null, wenn noch keiner existiert). */
export async function loadProgress(
  nutzerId: string,
  raetselId: number
): Promise<{ eingaben: Record<string, string>; fertig: boolean } | null> {
  if (!supabase) return null;
  const { data, error } = await supabase
    .from('nutzer_fortschritt')
    .select('eingaben, fertig')
    .eq('nutzer_id', nutzerId)
    .eq('raetsel_id', raetselId)
    .maybeSingle();
  if (error || !data) return null;
  return { eingaben: (data.eingaben as Record<string, string>) ?? {}, fertig: !!data.fertig };
}

/** Fortschritt speichern (upsert über den Unique-Index nutzer_id+raetsel_id). */
export async function saveProgress(
  nutzerId: string,
  raetselId: number,
  eingaben: Record<string, string>,
  fertig: boolean
): Promise<void> {
  if (!supabase) return;
  await supabase.from('nutzer_fortschritt').upsert(
    { nutzer_id: nutzerId, raetsel_id: raetselId, eingaben, fertig, aktualisiert_am: new Date().toISOString() },
    { onConflict: 'nutzer_id,raetsel_id' }
  );
}
