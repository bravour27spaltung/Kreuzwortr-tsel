import type { Direction, Puzzle, PuzzleEntry } from '@/types';
import { supabase } from '@/lib/supabase';

/** Eintrag in der Rätselauswahl. */
export interface PuzzleSummary {
  id: string;
  titel: string;
  rows: number;
  cols: number;
  schwierigkeit: number | null;
  quelle: 'supabase' | 'lokal';
}

export const SCHWIERIGKEIT: Record<number, string> = { 1: 'leicht', 2: 'mittel', 3: 'schwer' };

const LOKAL_BASIS = `${import.meta.env.BASE_URL}raetsel/`;

interface LokalIndexEintrag {
  id: string;
  titel: string;
  rows: number;
  cols: number;
  schwierigkeit: number;
  status: string;
}

interface DbEintrag {
  dir: Direction;
  r: number;
  c: number;
  len: number;
  wort: string;
  frage: string | null;
}

interface DbRaetsel {
  id: number;
  titel: string;
  zeilen: number;
  spalten: number;
  eintraege: DbEintrag[];
}

/**
 * Liste der veröffentlichten Rätsel. Zuerst Supabase (falls konfiguriert),
 * bei Fehler oder ohne Konfiguration die mitgelieferten Rätsel aus public/raetsel/.
 */
export async function listPuzzles(): Promise<{ liste: PuzzleSummary[]; hinweis: string | null }> {
  let hinweis: string | null = null;
  if (supabase) {
    const { data, error } = await supabase.rpc('raetsel_liste');
    if (!error && Array.isArray(data) && data.length > 0) {
      return {
        liste: data.map((r: { id: number; titel: string; zeilen: number; spalten: number; schwierigkeit: number | null }) => ({
          id: String(r.id),
          titel: r.titel,
          rows: r.zeilen,
          cols: r.spalten,
          schwierigkeit: r.schwierigkeit,
          quelle: 'supabase' as const,
        })),
        hinweis: null,
      };
    }
    hinweis = error
      ? `Supabase nicht erreichbar (${error.message}) – zeige mitgelieferte Rätsel.`
      : 'In Supabase sind noch keine Rätsel veröffentlicht – zeige mitgelieferte Rätsel.';
  }
  const res = await fetch(`${LOKAL_BASIS}index.json`);
  if (!res.ok) throw new Error(`Rätselliste nicht gefunden (${res.status}).`);
  const index = (await res.json()) as LokalIndexEintrag[];
  return {
    liste: index
      .filter((r) => r.status === 'veroeffentlicht')
      .map((r) => ({ id: r.id, titel: r.titel, rows: r.rows, cols: r.cols, schwierigkeit: r.schwierigkeit, quelle: 'lokal' as const })),
    hinweis,
  };
}

/** Lädt ein Rätsel und prüft es, bevor es an den Player geht. */
export async function loadPuzzle(s: PuzzleSummary): Promise<Puzzle> {
  let puzzle: Puzzle;
  if (s.quelle === 'supabase') {
    if (!supabase) throw new Error('Supabase ist nicht konfiguriert.');
    const { data, error } = await supabase.rpc('raetsel_laden', { p_id: Number(s.id) });
    if (error) throw new Error(error.message);
    if (!data) throw new Error('Rätsel nicht gefunden oder nicht veröffentlicht.');
    puzzle = fromDb(data as DbRaetsel);
  } else {
    const res = await fetch(`${LOKAL_BASIS}${encodeURIComponent(s.id)}.json`);
    if (!res.ok) throw new Error(`Rätsel nicht gefunden (${res.status}).`);
    puzzle = ((await res.json()) as { puzzle: Puzzle }).puzzle;
  }
  const fehler = validatePuzzle(puzzle);
  if (fehler.length) throw new Error(`Rätsel fehlerhaft: ${fehler.slice(0, 3).join('; ')}`);
  return puzzle;
}

/** Datenbankformat -> Player-Format. Fragezelle liegt direkt vor dem Wort (links bzw. darüber). */
export function fromDb(d: DbRaetsel): Puzzle {
  const solution: Record<string, string> = {};
  const entries: PuzzleEntry[] = d.eintraege.map((e) => {
    for (let i = 0; i < e.len; i++) {
      const r = e.dir === 'A' ? e.r : e.r + i;
      const c = e.dir === 'A' ? e.c + i : e.c;
      solution[`${r},${c}`] = e.wort[i];
    }
    return {
      dir: e.dir,
      r: e.r,
      c: e.c,
      len: e.len,
      clueR: e.dir === 'A' ? e.r : e.r - 1,
      clueC: e.dir === 'A' ? e.c - 1 : e.c,
      clue: e.frage ?? '(Frage fehlt)',
    };
  });
  return { rows: d.zeilen, cols: d.spalten, solution, entries };
}

/** Strukturprüfung: Einträge im Raster, alle Wortzellen haben Buchstaben, jede weiße Zelle gehört zu einem Wort, Fragezellen sind dunkel. */
export function validatePuzzle(p: Puzzle): string[] {
  const fehler: string[] = [];
  const belegt = new Set<string>();
  for (const e of p.entries) {
    for (let i = 0; i < e.len; i++) {
      const r = e.dir === 'A' ? e.r : e.r + i;
      const c = e.dir === 'A' ? e.c + i : e.c;
      const k = `${r},${c}`;
      if (r < 0 || c < 0 || r >= p.rows || c >= p.cols) fehler.push(`Eintrag außerhalb des Rasters (${k})`);
      if (!p.solution[k]) fehler.push(`Zelle ${k} ohne Buchstaben`);
      belegt.add(k);
    }
    if (p.solution[`${e.clueR},${e.clueC}`]) fehler.push(`Fragezelle ${e.clueR},${e.clueC} ist weiß`);
    if (!e.clue) fehler.push(`Eintrag ${e.r},${e.c} ohne Frage`);
  }
  for (const k of Object.keys(p.solution)) if (!belegt.has(k)) fehler.push(`Zelle ${k} gehört zu keinem Wort`);
  return fehler;
}
