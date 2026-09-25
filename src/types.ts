export type Direction = 'A' | 'D';

export interface PuzzleEntry {
  dir: Direction;
  r: number;
  c: number;
  len: number;
  clueR: number;
  clueC: number;
  clue: string;
}

export interface Puzzle {
  rows: number;
  cols: number;
  solution: Record<string, string>; // key: "r,c" -> Buchstabe
  entries: PuzzleEntry[];
}
