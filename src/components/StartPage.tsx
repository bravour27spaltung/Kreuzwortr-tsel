import { useEffect, useState } from 'react';
import type { Session } from '@supabase/supabase-js';
import AuthPanel from '@/components/AuthPanel';
import DuellPanel from '@/components/DuellPanel';
import { listProgress, type FortschrittEintrag } from '@/lib/progress';
import { SCHWIERIGKEIT, type PuzzleSummary } from '@/lib/puzzleSource';
import { isSupabaseConfigured } from '@/lib/supabase';

interface Props {
  session: Session | null;
  liste: PuzzleSummary[];
  hinweis: string | null;
  onSelect: (id: string) => void;
  /** Einladungscode aus dem Link (?duell=…) oder null. */
  einladungsCode: string | null;
  onEinladungErledigt: () => void;
  onOeffneDuell: (id: number) => void;
}

function schwierigkeitLabel(s: number | null): string {
  return s ? SCHWIERIGKEIT[s] ?? String(s) : '';
}

export default function StartPage({ session, liste, hinweis, onSelect, einladungsCode, onEinladungErledigt, onOeffneDuell }: Props) {
  const [fortschritt, setFortschritt] = useState<FortschrittEintrag[]>([]);
  const nutzerId = session?.user.id ?? null;

  useEffect(() => {
    if (!nutzerId) {
      setFortschritt([]);
      return;
    }
    let aktiv = true;
    listProgress().then((f) => aktiv && setFortschritt(f));
    return () => {
      aktiv = false;
    };
  }, [nutzerId]);

  const fortschrittByRaetsel = new Map(fortschritt.map((f) => [String(f.raetselId), f]));
  const angefangen = fortschritt.filter((f) => !f.fertig);
  const geloest = fortschritt.filter((f) => f.fertig);

  return (
    <div className="start-page">
      <div className="app-header">
        <h1>Kreuzworträtsel-App</h1>
        <p>
          Schwedenrätsel: Die Fragen stehen in den schattierten Feldern, der Pfeil zeigt die Richtung. Alle Rätsel sind
          automatisch aus geprüften Rastervorlagen und der Fragen-Datenbank erzeugt und werden laufend um neue ergänzt.
        </p>
      </div>

      <AuthPanel session={session} />

      {isSupabaseConfigured && (
        <DuellPanel session={session} einladungsCode={einladungsCode} onEinladungErledigt={onEinladungErledigt} onOeffneDuell={onOeffneDuell} />
      )}

      {nutzerId && (angefangen.length > 0 || geloest.length > 0) && (
        <div className="progress-overview">
          <h2>Meine Rätsel</h2>
          {angefangen.length > 0 && (
            <>
              <h3>Angefangen</h3>
              <ul className="progress-list">
                {angefangen.map((f) => (
                  <li key={f.raetselId}>
                    <button className="progress-item" onClick={() => onSelect(String(f.raetselId))}>
                      <span className="progress-titel">{f.titel}</span>
                      <span className="progress-meta">
                        {f.anzahlAusgefuellt} {f.anzahlAusgefuellt === 1 ? 'Feld' : 'Felder'} ausgefüllt ·{' '}
                        {schwierigkeitLabel(f.schwierigkeit)}
                      </span>
                    </button>
                  </li>
                ))}
              </ul>
            </>
          )}
          {geloest.length > 0 && (
            <>
              <h3>Gelöst</h3>
              <ul className="progress-list">
                {geloest.map((f) => (
                  <li key={f.raetselId}>
                    <button className="progress-item progress-item-fertig" onClick={() => onSelect(String(f.raetselId))}>
                      <span className="progress-titel">✓ {f.titel}</span>
                      <span className="progress-meta">{schwierigkeitLabel(f.schwierigkeit)}</span>
                    </button>
                  </li>
                ))}
              </ul>
            </>
          )}
        </div>
      )}

      <div className="puzzle-catalog">
        <h2>Alle Rätsel</h2>
        {hinweis && <p className="app-hinweis">{hinweis}</p>}
        <ul className="puzzle-grid">
          {liste.map((s) => {
            const f = fortschrittByRaetsel.get(s.id);
            return (
              <li key={s.id}>
                <button className="puzzle-card" onClick={() => onSelect(s.id)}>
                  <span className="puzzle-card-titel">{s.titel}</span>
                  <span className="puzzle-card-meta">
                    {s.rows}×{s.cols} {s.schwierigkeit ? `· ${SCHWIERIGKEIT[s.schwierigkeit] ?? s.schwierigkeit}` : ''}
                  </span>
                  {f && <span className={f.fertig ? 'puzzle-card-badge puzzle-card-badge-fertig' : 'puzzle-card-badge'}>{f.fertig ? 'gelöst' : 'angefangen'}</span>}
                </button>
              </li>
            );
          })}
        </ul>
      </div>
    </div>
  );
}
