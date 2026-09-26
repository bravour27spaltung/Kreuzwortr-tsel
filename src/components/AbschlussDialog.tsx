import { useEffect, useRef } from 'react';
import { formatZeit } from '@/lib/duell';

/** Ergebnis einer Solo-Runde, wie es das Popup anzeigt. */
export interface Abschluss {
  /** Aktive Lösezeit in Sekunden (ohne Zeiten, in denen der Tab im Hintergrund war). */
  sekunden: number;
  felder: number;
  woerter: number;
  /** Falsch eingetippte Buchstaben (auch, wenn sie später korrigiert wurden). */
  fehleingaben: number;
  /** „Prüfen“-Klicks, bei denen mindestens ein Feld falsch war. */
  pruefungenMitFehlern: number;
  /** Per Tipp aufgedeckte Felder. */
  tipps: number;
}

interface Props {
  ergebnis: Abschluss;
  titel?: string;
  schwierigkeit?: string;
  /** Ohne diese Funktion (z.B. letztes Rätsel der Liste) entfällt der Knopf „Nächstes Rätsel“. */
  onNaechstes?: () => void;
  onMenue: () => void;
  /** Schließt nur das Popup, damit man das gelöste Gitter noch ansehen kann. */
  onSchliessen: () => void;
}

const FOKUSSIERBAR = 'button:not([disabled]), [href], input, [tabindex]:not([tabindex="-1"])';

function mehrzahl(n: number, einzahl: string, plural: string): string {
  return `${n} ${n === 1 ? einzahl : plural}`;
}

/** Bewertung in einem Satz: rein beschreibend, ohne Punkte- oder Sterne-System. */
function fazit(e: Abschluss): string {
  if (e.tipps === 0 && e.fehleingaben === 0 && e.pruefungenMitFehlern === 0) return 'Fehlerfrei und ohne Tipps gelöst.';
  if (e.tipps === 0) return 'Ohne Tipps gelöst.';
  return `Gelöst mit ${mehrzahl(e.tipps, 'aufgedecktem Buchstaben', 'aufgedeckten Buchstaben')}.`;
}

export default function AbschlussDialog({ ergebnis: e, titel, schwierigkeit, onNaechstes, onMenue, onSchliessen }: Props) {
  const dialogRef = useRef<HTMLDivElement | null>(null);
  const primaerRef = useRef<HTMLButtonElement | null>(null);

  // Fokus in den Dialog holen und danach wieder dorthin zurückgeben, wo er vorher war.
  useEffect(() => {
    const vorher = document.activeElement as HTMLElement | null;
    primaerRef.current?.focus();
    return () => vorher?.focus?.();
  }, []);

  function tastatur(ev: React.KeyboardEvent<HTMLDivElement>) {
    if (ev.key === 'Escape') {
      ev.stopPropagation();
      onSchliessen();
      return;
    }
    if (ev.key !== 'Tab') return;
    // Fokus im Dialog halten
    const el = dialogRef.current?.querySelectorAll<HTMLElement>(FOKUSSIERBAR);
    if (!el || el.length === 0) return;
    const erstes = el[0];
    const letztes = el[el.length - 1];
    if (ev.shiftKey && document.activeElement === erstes) {
      ev.preventDefault();
      letztes.focus();
    } else if (!ev.shiftKey && document.activeElement === letztes) {
      ev.preventDefault();
      erstes.focus();
    }
  }

  const zeilen: [string, string][] = [
    ['Zeit', formatZeit(e.sekunden)],
    ['Fehleingaben', String(e.fehleingaben)],
    ['Prüfen mit Fehlern', String(e.pruefungenMitFehlern)],
    ['Aufgedeckte Buchstaben (Tipps)', String(e.tipps)],
    ['Größe', `${e.felder} Felder, ${e.woerter} Wörter`],
  ];

  return (
    <div className="cw-modal-overlay" onClick={onSchliessen}>
      <div
        ref={dialogRef}
        className="cw-modal"
        role="dialog"
        aria-modal="true"
        aria-labelledby="cw-modal-titel"
        aria-describedby="cw-modal-fazit"
        onClick={(ev) => ev.stopPropagation()}
        onKeyDown={tastatur}
      >
        <h2 id="cw-modal-titel">Rätsel gelöst!</h2>
        {(titel || schwierigkeit) && <p className="cw-modal-sub">{[titel, schwierigkeit].filter(Boolean).join(' · ')}</p>}
        <p id="cw-modal-fazit" className="cw-modal-fazit">
          {fazit(e)}
        </p>
        <table className="duell-tabelle cw-modal-tabelle">
          <tbody>
            {zeilen.map(([label, wert]) => (
              <tr key={label}>
                <th>{label}</th>
                <td>{wert}</td>
              </tr>
            ))}
          </tbody>
        </table>
        <div className="cw-modal-aktionen">
          {onNaechstes && (
            <button ref={primaerRef} onClick={onNaechstes}>
              Nächstes Rätsel
            </button>
          )}
          <button ref={onNaechstes ? undefined : primaerRef} className={onNaechstes ? 'cw-secondary' : undefined} onClick={onMenue}>
            Zurück zum Menü
          </button>
        </div>
        <button className="cw-modal-link" onClick={onSchliessen}>
          Gitter noch ansehen
        </button>
      </div>
    </div>
  );
}
