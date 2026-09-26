import { useEffect, useState } from 'react';
import type { Session } from '@supabase/supabase-js';
import CrosswordPlayer from '@/components/CrosswordPlayer';
import DuellView from '@/components/DuellView';
import StartPage from '@/components/StartPage';
import { getSession, onAuthChange } from '@/lib/auth';
import { codeAusUrl } from '@/lib/duell';
import { seedPuzzle } from '@/lib/seedPuzzle';
import { listPuzzles, loadPuzzle, SCHWIERIGKEIT, type PuzzleSummary } from '@/lib/puzzleSource';
import { loadProgress, saveProgress } from '@/lib/progress';
import type { Puzzle } from '@/types';

type Ansicht = 'start' | 'spiel' | 'duell';

type Zustand =
  | { art: 'laedt' }
  | { art: 'fehler'; text: string }
  | { art: 'bereit'; puzzle: Puzzle; initialUserGrid?: Record<string, string> };

function App() {
  const [ansicht, setAnsicht] = useState<Ansicht>('start');
  const [session, setSession] = useState<Session | null>(null);
  const [liste, setListe] = useState<PuzzleSummary[]>([]);
  const [hinweis, setHinweis] = useState<string | null>(null);
  const [auswahl, setAuswahl] = useState<string | null>(null);
  const [zustand, setZustand] = useState<Zustand>({ art: 'laedt' });
  const [duellId, setDuellId] = useState<number | null>(null);
  // Einladungslink (?duell=CODE): bleibt erhalten, bis die Einladung angenommen oder abgelehnt ist (auch über Login/Registrierung hinweg).
  const [einladungsCode, setEinladungsCode] = useState<string | null>(() => codeAusUrl(window.location.search));

  function einladungErledigt() {
    setEinladungsCode(null);
    if (window.location.search) window.history.replaceState(null, '', window.location.pathname + window.location.hash);
  }

  // Session einmal laden, dann auf Änderungen (Login/Logout) reagieren.
  useEffect(() => {
    let aktiv = true;
    getSession().then((s) => aktiv && setSession(s));
    const unsubscribe = onAuthChange((s) => aktiv && setSession(s));
    return () => {
      aktiv = false;
      unsubscribe();
    };
  }, []);

  // Rätselliste einmal laden
  useEffect(() => {
    let aktiv = true;
    listPuzzles()
      .then(({ liste: l, hinweis: h }) => {
        if (!aktiv) return;
        setListe(l);
        setHinweis(h);
        if (l.length === 0) setZustand({ art: 'bereit', puzzle: seedPuzzle });
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

  // Gewähltes Rätsel (+ evtl. gespeicherten Fortschritt) laden
  useEffect(() => {
    const s = liste.find((x) => x.id === auswahl);
    if (!s) return;
    let aktiv = true;
    setZustand({ art: 'laedt' });
    (async () => {
      try {
        const puzzle = await loadPuzzle(s);
        let initialUserGrid: Record<string, string> | undefined;
        if (session && s.quelle === 'supabase') {
          const gespeichert = await loadProgress(session.user.id, Number(s.id));
          if (gespeichert) initialUserGrid = gespeichert.eingaben;
        }
        if (aktiv) setZustand({ art: 'bereit', puzzle, initialUserGrid });
      } catch (e) {
        if (aktiv) setZustand({ art: 'fehler', text: e instanceof Error ? e.message : String(e) });
      }
    })();
    return () => {
      aktiv = false;
    };
  }, [auswahl, liste, session]);

  // Ohne Login gibt es keine Duell-Ansicht (z.B. nach dem Abmelden).
  useEffect(() => {
    if (ansicht === 'duell' && session === null) {
      setAnsicht('start');
      setDuellId(null);
    }
  }, [ansicht, session]);

  const aktuelleAuswahl = liste.find((x) => x.id === auswahl);
  const kannSpeichern = !!session && aktuelleAuswahl?.quelle === 'supabase';

  // „Nächstes Rätsel“ im Abschluss-Popup: das folgende in der Katalogreihenfolge. Beim letzten gibt es keins (der Knopf entfällt).
  const aktuellerIndex = liste.findIndex((x) => x.id === auswahl);
  const naechstes = aktuellerIndex >= 0 ? liste[aktuellerIndex + 1] : undefined;

  function zumMenue() {
    setAnsicht('start');
    setAuswahl(null);
    setZustand({ art: 'laedt' });
  }

  return (
    <div className="app-shell">
      {ansicht === 'start' && (
        <StartPage
          session={session}
          liste={liste}
          hinweis={hinweis}
          onSelect={(id) => {
            setAuswahl(id);
            setAnsicht('spiel');
          }}
          einladungsCode={einladungsCode}
          onEinladungErledigt={einladungErledigt}
          onOeffneDuell={(id) => {
            setDuellId(id);
            setAnsicht('duell');
          }}
        />
      )}

      {ansicht === 'duell' && duellId !== null && (
        <DuellView
          key={duellId}
          duellId={duellId}
          onZurueck={() => {
            setAnsicht('start');
            setDuellId(null);
          }}
          onOeffneDuell={(id) => setDuellId(id)}
        />
      )}

      {ansicht === 'spiel' && (
        <>
          <button className="cw-secondary cw-back" onClick={zumMenue}>
            ← Zur Startseite
          </button>
          {zustand.art === 'laedt' && <p>Rätsel wird geladen …</p>}
          {zustand.art === 'fehler' && <p className="app-fehler">Fehler: {zustand.text}</p>}
          {zustand.art === 'bereit' && (
            <CrosswordPlayer
              key={auswahl ?? 'beispiel'}
              puzzle={zustand.puzzle}
              initialUserGrid={zustand.initialUserGrid}
              titel={aktuelleAuswahl?.titel}
              schwierigkeit={aktuelleAuswahl?.schwierigkeit != null ? SCHWIERIGKEIT[aktuelleAuswahl.schwierigkeit] : undefined}
              onZumMenue={zumMenue}
              onNaechstes={
                naechstes
                  ? () => {
                      setZustand({ art: 'laedt' });
                      setAuswahl(naechstes.id);
                      window.scrollTo(0, 0);
                    }
                  : undefined
              }
              onFortschritt={
                kannSpeichern && session
                  ? (userGrid, fertig) => {
                      void saveProgress(session.user.id, Number(auswahl), userGrid, fertig);
                    }
                  : undefined
              }
            />
          )}
        </>
      )}
    </div>
  );
}

export default App;
