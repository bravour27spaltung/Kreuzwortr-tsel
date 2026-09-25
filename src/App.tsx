import { useEffect, useState } from 'react';
import CrosswordPlayer from '@/components/CrosswordPlayer';
import { seedPuzzle } from '@/lib/seedPuzzle';
import { listPuzzles, loadPuzzle, SCHWIERIGKEIT, type PuzzleSummary } from '@/lib/puzzleSource';
import type { Puzzle } from '@/types';

type Zustand =
  | { art: 'laedt' }
  | { art: 'fehler'; text: string }
  | { art: 'bereit'; puzzle: Puzzle };

function label(s: PuzzleSummary): string {
  const schw = s.schwierigkeit ? ` · ${SCHWIERIGKEIT[s.schwierigkeit] ?? s.schwierigkeit}` : '';
  return `${s.titel}${schw}`;
}

function App() {
  const [liste, setListe] = useState<PuzzleSummary[]>([]);
  const [hinweis, setHinweis] = useState<string | null>(null);
  const [auswahl, setAuswahl] = useState<string | null>(null);
  const [zustand, setZustand] = useState<Zustand>({ art: 'laedt' });

  // Rätselliste einmal laden
  useEffect(() => {
    let aktiv = true;
    listPuzzles()
      .then(({ liste: l, hinweis: h }) => {
        if (!aktiv) return;
        setListe(l);
        setHinweis(h);
        if (l.length > 0) setAuswahl(l[0].id);
        else setZustand({ art: 'bereit', puzzle: seedPuzzle });
      })
      .catch((e: unknown) => {
        if (!aktiv) return;
        setHinweis(`Rätselliste konnte nicht geladen werden (${e instanceof Error ? e.message : String(e)}). Zeige Beispielrätsel.`);
        setZustand({ art: 'bereit', puzzle: seedPuzzle });
      });
    return () => {
      aktiv = false;
    };
  }, []);

  // Gewähltes Rätsel laden
  useEffect(() => {
    const s = liste.find((x) => x.id === auswahl);
    if (!s) return;
    let aktiv = true;
    setZustand({ art: 'laedt' });
    loadPuzzle(s)
      .then((p) => aktiv && setZustand({ art: 'bereit', puzzle: p }))
      .catch((e: unknown) => aktiv && setZustand({ art: 'fehler', text: e instanceof Error ? e.message : String(e) }));
    return () => {
      aktiv = false;
    };
  }, [auswahl, liste]);

  return (
    <div className="app-shell">
      <div className="app-header">
        <h1>Kreuzworträtsel-App</h1>
        <p>
          Schwedenrätsel: Die Fragen stehen in den schattierten Feldern, der Pfeil zeigt die Richtung.
          Alle Rätsel sind automatisch aus geprüften Rastervorlagen und der Fragen-Datenbank erzeugt.
        </p>
        {liste.length > 0 && (
          <label>
            Rätsel:{' '}
            <select value={auswahl ?? ''} onChange={(e) => setAuswahl(e.target.value)}>
              {liste.map((s) => (
                <option key={s.id} value={s.id}>
                  {label(s)}
                </option>
              ))}
            </select>
          </label>
        )}
        {hinweis && <p className="app-hinweis">{hinweis}</p>}
      </div>
      {zustand.art === 'laedt' && <p>Rätsel wird geladen …</p>}
      {zustand.art === 'fehler' && <p className="app-fehler">Fehler: {zustand.text}</p>}
      {zustand.art === 'bereit' && <CrosswordPlayer key={auswahl ?? 'beispiel'} puzzle={zustand.puzzle} />}
    </div>
  );
}

export default App;
