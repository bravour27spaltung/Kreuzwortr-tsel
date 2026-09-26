import { supabase } from '@/lib/supabase';

/*
 * Anbindung der Duell-Funktionen aus supabase/migrations/20260927000000_duelle.sql.
 * Die Typen entsprechen den jsonb-Antworten der SQL-Funktionen (deshalb snake_case).
 */

export type DuellStatus = 'offen' | 'laufend' | 'beendet' | 'abgelaufen';
export type EndeGrund = 'zeit' | 'aufgabe' | 'frist' | 'ohne_ergebnis' | 'nicht_beigetreten';
export type MeinZustand = 'nicht_gestartet' | 'laeuft' | 'abgegeben' | 'aufgegeben';
export type Gewinner = 'ich' | 'gegner' | 'unentschieden' | null;
export type GroesseWunsch = 'klein' | 'mittel' | 'gross';

export interface Regeln {
  sek_pro_tipp: number;
  sek_pro_fehlpruefung: number;
}

export interface DuellListeneintrag {
  id: number;
  status: DuellStatus;
  ende_grund: EndeGrund | null;
  code: string | null; // nur bei offenen Duellen des Erstellers
  ich_ersteller: boolean;
  gegner_name: string | null;
  erstellt_am: string;
  frist_am: string;
  revanche: boolean;
  revanche_id: number | null;
  wunsch_schwierigkeit: number | null;
  wunsch_groesse: GroesseWunsch | null;
  raetsel: { titel: string; zeilen: number; spalten: number; schwierigkeit: number | null } | null;
  mein_zustand: MeinZustand | null;
  gewinner: Gewinner;
  meine_netto_sekunden: number | null;
}

export interface SpielerAnsicht {
  name: string | null;
  gestartet_am?: string | null;
  abgegeben_am?: string | null;
  aufgegeben: boolean | null;
  tipps: number | null;
  pruefungen: number | null;
  strafsekunden: number | null;
  dauer_sekunden: number | null;
  netto_sekunden: number | null;
}

export interface DuellAnsicht {
  duell_id: number;
  status: DuellStatus;
  ende_grund: EndeGrund | null;
  jetzt: string;
  frist_am: string;
  raetsel_id: number | null;
  regeln: Regeln;
  revanche: boolean;
  revanche_id: number | null;
  gewinner: Gewinner;
  ich: SpielerAnsicht & { gestartet_am: string | null; abgegeben_am: string | null; aufgegeben: boolean };
  gegner: (SpielerAnsicht & { abgegeben: boolean | null }) | null;
}

export interface RundenStart {
  raetsel_id: number;
  gestartet_am: string;
  jetzt: string;
  frist_am: string;
  regeln: Regeln;
  eingaben: Record<string, string>;
  tipps: number;
  pruefungen: number;
}

export interface Zaehler {
  tipps: number;
  pruefungen: number;
}

export type EinladungVorschau =
  | { ok: true; duell_id: number; bereits_dabei: boolean; eigenes: boolean; ersteller_name: string | null }
  | { ok: false; fehler: string };

export type Ergebnis = { ok: true; duell_id: number } | { ok: false; fehler: string };

/** Fehler aus der Datenbank; `code` ist die kurze Kennung aus der SQL-Exception (z.B. 'duell_nicht_laufend'). */
export class DuellFehler extends Error {
  readonly code: string;
  constructor(code: string) {
    super(duellFehlerText(code));
    this.code = code;
  }
}

const FEHLERTEXTE: Record<string, string> = {
  nicht_angemeldet: 'Bitte melde dich zuerst an.',
  nicht_konfiguriert: 'Duelle brauchen eine Supabase-Verbindung.',
  profil_fehlt: 'Bitte lege zuerst einen Anzeigenamen fest.',
  name_ungueltig: 'Der Name muss 2 bis 24 Zeichen lang sein (ohne Steuerzeichen).',
  ungueltige_angabe: 'Ungültige Angabe.',
  zu_viele_offene_duelle: 'Du hast schon 5 offene Einladungen. Ziehe eine zurück oder warte, bis jemand annimmt.',
  duell_unbekannt: 'Dieses Duell gibt es nicht (mehr) oder du bist nicht dabei.',
  duell_nicht_laufend: 'Dieses Duell läuft nicht mehr.',
  duell_nicht_offen: 'Diese Einladung ist nicht mehr offen.',
  duell_nicht_beendet: 'Eine Revanche gibt es erst, wenn das Duell beendet ist.',
  bereits_beendet: 'Du hast dieses Duell schon abgeschlossen.',
  nicht_gestartet: 'Du hast dieses Duell noch nicht gestartet.',
  loesung_falsch: 'Die Lösung stimmt nicht mit der Datenbank überein.',
  code_unbekannt: 'Diesen Einladungscode gibt es nicht. Bitte prüfe die Schreibweise.',
  zu_viele_versuche: 'Zu viele Fehlversuche. Bitte warte ein paar Minuten.',
  abgelaufen: 'Diese Einladung ist abgelaufen.',
  nicht_mehr_offen: 'Bei diesem Duell sind schon zwei Spieler dabei.',
  eigenes_duell: 'Das ist dein eigener Einladungscode – schicke ihn an jemand anderen.',
  kein_raetsel: 'Es gibt kein Rätsel mehr, das ihr beide noch nicht gespielt habt.',
};

export function duellFehlerText(code: string): string {
  return FEHLERTEXTE[code] ?? `Unerwarteter Fehler (${code}).`;
}

async function rufe<T>(name: string, args?: Record<string, unknown>): Promise<T> {
  if (!supabase) throw new DuellFehler('nicht_konfiguriert');
  const { data, error } = await supabase.rpc(name, args);
  if (error) throw new DuellFehler(error.message);
  return data as T;
}

export async function ladeProfil(): Promise<string | null> {
  const p = await rufe<{ anzeigename: string } | null>('profil_laden');
  return p?.anzeigename ?? null;
}

export async function setzeProfil(name: string): Promise<string> {
  const p = await rufe<{ anzeigename: string }>('profil_setzen', { p_name: name });
  return p.anzeigename;
}

export async function erstelleDuell(schwierigkeit: number | null, groesse: GroesseWunsch | null): Promise<{ duell_id: number; code: string }> {
  return rufe('duell_erstellen', { p_schwierigkeit: schwierigkeit, p_groesse: groesse });
}

export const pruefeEinladung = (code: string) => rufe<EinladungVorschau>('duell_einladung', { p_code: code });
export const tretBei = (code: string) => rufe<Ergebnis>('duell_beitreten', { p_code: code });
export const starteRunde = (duellId: number) => rufe<RundenStart>('duell_starten', { p_duell_id: duellId });

export const speichereRunde = (duellId: number, eingaben: Record<string, string>, z: Zaehler) =>
  rufe<{ jetzt: string; strafsekunden: number }>('duell_speichern', {
    p_duell_id: duellId,
    p_eingaben: eingaben,
    p_tipps: z.tipps,
    p_pruefungen: z.pruefungen,
  });

export const gibAb = (duellId: number, eingaben: Record<string, string>, z: Zaehler) =>
  rufe<DuellAnsicht>('duell_abgeben', { p_duell_id: duellId, p_eingaben: eingaben, p_tipps: z.tipps, p_pruefungen: z.pruefungen });

export const gibAuf = (duellId: number) => rufe<DuellAnsicht>('duell_aufgeben', { p_duell_id: duellId });
export const zieheZurueck = (duellId: number) => rufe<null>('duell_zurueckziehen', { p_duell_id: duellId });
export const ladeErgebnis = (duellId: number) => rufe<DuellAnsicht>('duell_ergebnis', { p_duell_id: duellId });
export const starteRevanche = (duellId: number) => rufe<Ergebnis>('duell_revanche', { p_duell_id: duellId });
export const listeDuelle = () => rufe<DuellListeneintrag[]>('duelle_liste');

// ---- Darstellung -------------------------------------------------------------------------------------------

/** 'ABCDEFGH' -> 'ABCD-EFGH' */
export function formatCode(code: string): string {
  return code.length === 8 ? `${code.slice(0, 4)}-${code.slice(4)}` : code;
}

/** Einladungscode aus ?duell=… lesen (nur Buchstaben/Ziffern, höchstens 16 Zeichen). */
export function codeAusUrl(suche: string): string | null {
  const roh = new URLSearchParams(suche).get('duell');
  const code = (roh ?? '').replace(/[^A-Za-z0-9]/g, '').toUpperCase().slice(0, 16);
  return code.length >= 4 ? code : null;
}

export function einladungsLink(code: string): string {
  return `${window.location.origin}${window.location.pathname}?duell=${encodeURIComponent(code)}`;
}

/** Postgres liefert Mikrosekunden; JS-Date kommt nur mit Millisekunden sicher klar. */
export function parseZeit(iso: string): number {
  return Date.parse(iso.replace(/(\.\d{3})\d+/, '$1'));
}

/** Sekunden als m:ss bzw. h:mm:ss; mit `bruchteil` zusätzlich Zehntelsekunden (für den Vergleich im Ergebnis). */
export function formatZeit(sekunden: number, bruchteil = false): string {
  const gesamt = Math.max(0, sekunden);
  const ganz = Math.floor(gesamt);
  const h = Math.floor(ganz / 3600);
  const m = Math.floor((ganz % 3600) / 60);
  const s = ganz % 60;
  const ss = String(s).padStart(2, '0');
  const basis = h > 0 ? `${h}:${String(m).padStart(2, '0')}:${ss}` : `${m}:${ss}`;
  return bruchteil ? `${basis},${Math.floor((gesamt - ganz) * 10)}` : basis;
}

export function formatDatum(iso: string): string {
  return new Date(parseZeit(iso)).toLocaleString('de-DE', { day: '2-digit', month: '2-digit', hour: '2-digit', minute: '2-digit' });
}
