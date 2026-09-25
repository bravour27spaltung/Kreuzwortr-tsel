import type { Puzzle } from '@/types';

// Fest hinterlegtes Beispiel-Rätsel (aus dem Player-Prototyp übernommen).
// Sobald Wörter/Fragen/Gitter aus Supabase geladen werden können, wird
// diese Funktion durch eine echte Datenabfrage ersetzt.
export const seedPuzzle: Puzzle = {
  rows: 9,
  cols: 13,
  solution: {
    '1,3': 'H', '1,4': 'A', '1,5': 'U', '1,6': 'S',
    '2,3': 'U',
    '3,3': 'N',
    '4,3': 'D',
    '3,4': 'A', '3,5': 'S', '3,6': 'E',
    '2,6': 'T',
    '4,6': 'R',
    '5,6': 'N',
    '4,7': 'O', '4,8': 'S', '4,9': 'E',
    '3,8': 'E',
    '5,8': 'E',
    '6,8': 'L',
    '4,1': 'R', '4,2': 'A',
    '5,1': 'E',
    '6,1': 'G',
    '7,1': 'E',
    '8,1': 'N',
    '2,9': 'I', '2,10': 'G', '2,11': 'E', '2,12': 'L',
  },
  entries: [
    { dir: 'A', r: 1, c: 3, len: 4, clueR: 1, clueC: 2, clue: 'Wohngebäude' },
    { dir: 'D', r: 1, c: 3, len: 4, clueR: 0, clueC: 3, clue: 'Bellendes Haustier' },
    { dir: 'A', r: 3, c: 3, len: 4, clueR: 3, clueC: 2, clue: 'Riechorgan' },
    { dir: 'D', r: 1, c: 6, len: 5, clueR: 0, clueC: 6, clue: 'Leuchtet nachts' },
    { dir: 'A', r: 4, c: 6, len: 4, clueR: 4, clueC: 5, clue: 'Blume mit Dornen' },
    { dir: 'D', r: 3, c: 8, len: 4, clueR: 2, clueC: 8, clue: 'Störrisches Tier' },
    { dir: 'A', r: 2, c: 9, len: 4, clueR: 2, clueC: 8, clue: 'Stacheltier' },
    { dir: 'A', r: 4, c: 1, len: 3, clueR: 4, clueC: 0, clue: 'Fahrradteil' },
    { dir: 'D', r: 4, c: 1, len: 5, clueR: 3, clueC: 1, clue: 'Niederschlag' },
  ],
};
