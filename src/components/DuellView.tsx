import { useCallback, useEffect, useMemo, useState } from 'react';
import CrosswordPlayer, { type DuellModus } from '@/components/CrosswordPlayer';
import {
  DuellFehler,
  formatDatum,
  formatZeit,
  gibAb,
  gibAuf,
  ladeErgebnis,
  parseZeit,
  speichereRunde,
  starteRevanche,
  starteRunde,
  type DuellAnsicht,
  type RundenStart,
} from '@/lib/duell';
import { loadPuzzle } from '@/lib/puzzleSource';
import type { Puzzle } from '@/types';

interface Props {
  duellId: number;
  onZurueck: () => void;
  onOeffneDuell: (id: number) => void;
}

type Phase =
  | { art: 'laedt' }
  | { art: 'fehler'; text: string; erneut?: () => void }
  | { art: 'ansicht'; ansicht: DuellAnsicht }
  | { art: 'spiel'; ansicht: DuellAnsicht; puzzle: Puzzle; runde: RundenStart; versatzMs: number };

function fehlerText(e: unknown): string {
  return e instanceof Error ? e.message : String(e);
}

/** Das Duell ist inzwischen zu Ende (Gegner hat aufgegeben, Frist um, ...): dann statt einer Fehlermeldung die Ergebnisansicht zeigen. */
function istDuellVorbei(e: unknown): boolean {
  return e instanceof DuellFehler && (e.code === 'duell_nicht_laufend' || e.code === 'bereits_beendet');
}

export default function DuellView({ duellId, onZurueck, onOeffneDuell }: Props) {
  const [phase, setPhase] = useState<Phase>({ art: 'laedt' });

  const laden = useCallback(async () => {
    try {
      setPhase({ art: 'ansicht', ansicht: await ladeErgebnis(duellId) });
    } catch (e) {
      setPhase({ art: 'fehler', text: fehlerText(e) });
    }
  }, [duellId]);

  useEffect(() => {
    void laden();
  }, [laden]);

  // Wer abgegeben hat und auf den Gegner wartet, sieht das Ergebnis ohne Neuladen.
  const wartet = phase.art === 'ansicht' && phase.ansicht.status === 'laufend' && !!phase.ansicht.ich.abgegeben_am;
  useEffect(() => {
    if (!wartet) return;
    const t = setInterval(() => void laden(), 30000);
    return () => clearInterval(t);
  }, [wartet, laden]);

  // Das Rätsel wird geladen, BEVOR die Uhr startet (sonst ginge Ladezeit oder ein Ladefehler auf die eigene Zeit).
  const starten = useCallback(
    async (ansicht: DuellAnsicht) => {
      setPhase({ art: 'laedt' });
      try {
        if (ansicht.raetsel_id == null) throw new Error('Diesem Duell ist noch kein Rätsel zugewiesen.');
        const puzzle = await loadPuzzle({ id: String(ansicht.raetsel_id), titel: '', rows: 0, cols: 0, schwierigkeit: null, quelle: 'supabase' });
        const runde = await starteRunde(duellId);
        setPhase({ art: 'spiel', ansicht, puzzle, runde, versatzMs: parseZeit(runde.jetzt) - Date.now() });
      } catch (e) {
        if (istDuellVorbei(e)) void laden();
        else setPhase({ art: 'fehler', text: fehlerText(e), erneut: () => void starten(ansicht) });
      }
    },
    [duellId, laden]
  );

  const duellModus = useMemo<DuellModus | null>(() => {
    if (phase.art !== 'spiel') return null;
    const { ansicht, runde, versatzMs } = phase;
    return {
      gegnerName: ansicht.gegner?.name ?? null,
      gestartetMs: parseZeit(runde.gestartet_am),
      versatzMs,
      regeln: runde.regeln,
      start: { tipps: runde.tipps, pruefungen: runde.pruefungen },
      onSpeichern: async (grid, z) => {
        try {
          await speichereRunde(duellId, grid, z);
        } catch (e) {
          if (istDuellVorbei(e)) void laden();
          else throw e;
        }
      },
      onFertig: async (grid, z) => {
        try {
          setPhase({ art: 'ansicht', ansicht: await gibAb(duellId, grid, z) });
        } catch (e) {
          if (istDuellVorbei(e)) void laden();
          else throw e;
        }
      },
      onAufgeben: async () => {
        try {
          setPhase({ art: 'ansicht', ansicht: await gibAuf(duellId) });
        } catch (e) {
          if (istDuellVorbei(e)) void laden();
          else throw e;
        }
      },
    };
  }, [phase, duellId, laden]);

  return (
    <div className="duell-view">
      {phase.art !== 'spiel' && (
        <button className="cw-secondary cw-back" onClick={onZurueck}>
          ← Zur Startseite
        </button>
      )}
      {phase.art === 'spiel' && (
        <button className="cw-secondary cw-back" onClick={onZurueck}>
          ← Zur Startseite (deine Uhr läuft weiter)
        </button>
      )}
      {phase.art === 'laedt' && <p>Wird geladen …</p>}
      {phase.art === 'fehler' && (
        <div className="duell-karte">
          <p className="app-fehler">{phase.text}</p>
          {phase.erneut && (
            <p className="duell-hinweis">
              Falls deine Uhr schon läuft: Sie läuft weiter, bis du abgibst. Am besten gleich noch einmal versuchen.
            </p>
          )}
          <div className="duell-aktionen">
            {phase.erneut && <button onClick={phase.erneut}>Erneut versuchen</button>}
            <button className="cw-secondary" onClick={() => void laden()}>
              Duell neu laden
            </button>
          </div>
        </div>
      )}
      {phase.art === 'ansicht' && (
        <AnsichtKarte ansicht={phase.ansicht} onStarten={() => void starten(phase.ansicht)} onAktualisieren={() => void laden()} onOeffneDuell={onOeffneDuell} />
      )}
      {phase.art === 'spiel' && duellModus && (
        <CrosswordPlayer key={`duell-${duellId}`} puzzle={phase.puzzle} initialUserGrid={phase.runde.eingaben} duell={duellModus} />
      )}
    </div>
  );
}

// ---- Ansichten außerhalb des Spiels ---------------------------------------------------------------------------

function AnsichtKarte({
  ansicht: a,
  onStarten,
  onAktualisieren,
  onOeffneDuell,
}: {
  ansicht: DuellAnsicht;
  onStarten: () => void;
  onAktualisieren: () => void;
  onOeffneDuell: (id: number) => void;
}) {
  const gegner = a.gegner?.name ?? 'Gegner';

  if (a.status === 'offen') {
    return (
      <div className="duell-karte">
        <h2>Einladung offen</h2>
        <p>Es ist noch niemand beigetreten. Den Einladungscode findest du auf der Startseite bei „Meine Duelle“.</p>
      </div>
    );
  }

  if (a.status === 'laufend' && !a.ich.abgegeben_am) {
    const laeuft = !!a.ich.gestartet_am;
    return (
      <div className="duell-karte">
        <h2>Duell gegen {gegner}</h2>
        <p>
          Ihr löst dasselbe Rätsel, jeder für sich und wann er will. Es gewinnt die kürzere Gesamtzeit: deine Zeit plus Strafsekunden
          (jeder aufgedeckte Buchstabe {a.regeln.sek_pro_tipp} s, jedes „Prüfen“ mit Fehler {a.regeln.sek_pro_fehlpruefung} s). Von {gegner} siehst du
          nichts, bis du selbst abgegeben hast.
        </p>
        <p className="duell-hinweis">
          Mit dem Start läuft deine Uhr – auch wenn du die Seite schließt oder pausierst. Abgabe bis {formatDatum(a.frist_am)}; wer bis dahin
          nicht abgegeben hat, verliert, sofern der Gegner abgegeben hat.
        </p>
        <div className="duell-aktionen">
          <button onClick={onStarten}>{laeuft ? 'Weiterspielen' : 'Jetzt starten'}</button>
        </div>
      </div>
    );
  }

  if (a.status === 'laufend') {
    return (
      <div className="duell-karte">
        <h2>Abgegeben – warte auf {gegner}</h2>
        <ErgebnisTabelle a={a} />
        <p className="duell-hinweis">
          {gegner} hat noch bis {formatDatum(a.frist_am)} Zeit. Diese Seite aktualisiert sich alle 30 Sekunden.
        </p>
        <div className="duell-aktionen">
          <button className="cw-secondary" onClick={onAktualisieren}>
            Jetzt aktualisieren
          </button>
        </div>
      </div>
    );
  }

  return <Ergebnis a={a} onOeffneDuell={onOeffneDuell} />;
}

function Ergebnis({ a, onOeffneDuell }: { a: DuellAnsicht; onOeffneDuell: (id: number) => void }) {
  const gegner = a.gegner?.name ?? 'Gegner';
  const [busy, setBusy] = useState(false);
  const [fehler, setFehler] = useState<string | null>(null);

  const titel =
    a.gewinner === 'ich' ? 'Du hast gewonnen' : a.gewinner === 'gegner' ? `${gegner} hat gewonnen` : a.gewinner === 'unentschieden' ? 'Unentschieden' : 'Kein Ergebnis';

  let grund = '';
  switch (a.ende_grund) {
    case 'zeit':
      grund = 'Beide haben abgegeben – die kürzere Gesamtzeit (inklusive Strafen) gewinnt.';
      break;
    case 'aufgabe':
      grund = a.ich.aufgegeben ? 'Du hast aufgegeben.' : `${gegner} hat aufgegeben.`;
      break;
    case 'frist':
      grund = `Die Frist ist abgelaufen – nur ${a.gewinner === 'ich' ? 'du hast' : `${gegner} hat`} abgegeben.`;
      break;
    case 'ohne_ergebnis':
      grund = 'Die Frist ist abgelaufen, ohne dass jemand abgegeben hat.';
      break;
    case 'nicht_beigetreten':
      grund = 'Die Einladung wurde nicht angenommen.';
      break;
  }

  async function revanche() {
    setBusy(true);
    setFehler(null);
    try {
      const r = await starteRevanche(a.duell_id);
      if (r.ok) onOeffneDuell(r.duell_id);
      else setFehler(r.fehler === 'kein_raetsel' ? 'Es gibt kein Rätsel mehr, das ihr beide noch nicht gespielt habt.' : r.fehler);
    } catch (e) {
      setFehler(fehlerText(e));
    } finally {
      setBusy(false);
    }
  }

  return (
    <div className="duell-karte">
      <h2>{titel}</h2>
      <p>{grund}</p>
      {a.ende_grund === 'zeit' || a.ich.abgegeben_am || a.gegner?.abgegeben ? <ErgebnisTabelle a={a} /> : null}
      {a.status === 'beendet' && a.gegner && (
        <div className="duell-aktionen">
          {a.revanche_id ? (
            <button onClick={() => onOeffneDuell(a.revanche_id as number)}>Zur Revanche</button>
          ) : (
            <button disabled={busy} onClick={() => void revanche()}>
              {busy ? 'Einen Moment …' : 'Revanche mit neuem Rätsel'}
            </button>
          )}
        </div>
      )}
      {fehler && <p className="app-fehler">{fehler}</p>}
    </div>
  );
}

function ErgebnisTabelle({ a }: { a: DuellAnsicht }) {
  const g = a.gegner;
  const zeit = (s: number | null | undefined, bruchteil = false) => (s == null ? '–' : formatZeit(s, bruchteil));
  const zahl = (n: number | null | undefined) => (n == null ? '–' : String(n));
  const gegnerFertig = g?.netto_sekunden != null;
  const ichFertig = a.ich.netto_sekunden != null;
  return (
    <table className="duell-tabelle">
      <thead>
        <tr>
          <th />
          <th>Du</th>
          <th>{g?.name ?? 'Gegner'}</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>Zeit</th>
          <td>{zeit(a.ich.dauer_sekunden)}</td>
          <td>{zeit(g?.dauer_sekunden)}</td>
        </tr>
        <tr>
          <th>Aufgedeckte Buchstaben</th>
          <td>{zahl(a.ich.tipps)}</td>
          <td>{zahl(g?.tipps)}</td>
        </tr>
        <tr>
          <th>Prüfen mit Fehlern</th>
          <td>{zahl(a.ich.pruefungen)}</td>
          <td>{zahl(g?.pruefungen)}</td>
        </tr>
        <tr>
          <th>Strafzeit</th>
          <td>{zeit(a.ich.strafsekunden)}</td>
          <td>{zeit(g?.strafsekunden)}</td>
        </tr>
        <tr className="duell-tabelle-summe">
          <th>Gesamtzeit</th>
          <td className={a.gewinner === 'ich' ? 'duell-sieger' : undefined}>{ichFertig ? zeit(a.ich.netto_sekunden, true) : '–'}</td>
          <td className={a.gewinner === 'gegner' ? 'duell-sieger' : undefined}>{gegnerFertig ? zeit(g?.netto_sekunden, true) : g?.aufgegeben ? 'aufgegeben' : '–'}</td>
        </tr>
      </tbody>
    </table>
  );
}
