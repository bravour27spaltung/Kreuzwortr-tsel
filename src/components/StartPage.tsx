import { useEffect, useMemo, useState } from 'react';
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
        <h2>Rätsel auswählen</h2>
        {hinweis && <p className="app-hinweis">{hinweis}</p>}
        <RaetselAuswahl liste={liste} fortschritt={fortschrittByRaetsel} onSelect={onSelect} />
      </div>
    </div>
  );
}

/** Auswahl nach Größe und Schwierigkeit statt langer Kachelliste. */
function RaetselAuswahl({
  liste,
  fortschritt,
  onSelect,
}: {
  liste: PuzzleSummary[];
  fortschritt: Map<string, FortschrittEintrag>;
  onSelect: (id: string) => void;
}) {
  const [groesse, setGroesse] = useState<string>(''); // '' = egal, sonst "8×8"
  const [schwierigkeit, setSchwierigkeit] = useState<number | null>(null);
  const [nurNeue, setNurNeue] = useState(true);
  const [keineTreffer, setKeineTreffer] = useState(false);

  const groessen = useMemo(() => {
    const m = new Map<string, number>();
    for (const r of liste) m.set(`${r.rows}×${r.cols}`, r.rows * r.cols);
    return [...m.entries()].sort((a, b) => a[1] - b[1]).map(([k]) => k);
  }, [liste]);

  const passend = liste.filter(
    (r) => (!groesse || `${r.rows}×${r.cols}` === groesse) && (schwierigkeit === null || r.schwierigkeit === schwierigkeit)
  );
  // "neu" = weder angefangen noch gelöst
  const neue = passend.filter((r) => !fortschritt.has(r.id));
  const kandidaten = nurNeue && neue.length > 0 ? neue : passend;

  function zufaellig() {
    if (kandidaten.length === 0) {
      setKeineTreffer(true);
      return;
    }
    setKeineTreffer(false);
    onSelect(kandidaten[Math.floor(Math.random() * kandidaten.length)].id);
  }

  const chip = (aktiv: boolean, text: string, onClick: () => void, key: string) => (
    <button key={key} type="button" className={aktiv ? 'auswahl-chip auswahl-chip-aktiv' : 'auswahl-chip'} aria-pressed={aktiv} onClick={onClick}>
      {text}
    </button>
  );

  return (
    <div className="auswahl">
      <div className="auswahl-gruppe">
        <span className="auswahl-label">Größe</span>
        <div className="auswahl-chips">
          {chip(groesse === '', 'egal', () => setGroesse(''), 'g-egal')}
          {groessen.map((g) => chip(groesse === g, g, () => setGroesse(g), `g-${g}`))}
        </div>
      </div>
      <div className="auswahl-gruppe">
        <span className="auswahl-label">Schwierigkeit</span>
        <div className="auswahl-chips">
          {chip(schwierigkeit === null, 'egal', () => setSchwierigkeit(null), 's-egal')}
          {Object.entries(SCHWIERIGKEIT).map(([k, v]) => chip(schwierigkeit === Number(k), v, () => setSchwierigkeit(Number(k)), `s-${k}`))}
        </div>
      </div>
      <label className="auswahl-check">
        <input type="checkbox" checked={nurNeue} onChange={(e) => setNurNeue(e.target.checked)} />
        Lieber ein Rätsel, das ich noch nicht angefangen habe
      </label>
      <div className="auswahl-aktion">
        <button type="button" className="auswahl-start" onClick={zufaellig} disabled={passend.length === 0}>
          Rätsel starten
        </button>
        <span className="auswahl-anzahl">
          {passend.length === 0 ? 'Kein Rätsel passt zu dieser Auswahl.' : `${passend.length} passend, davon ${neue.length} neu`}
        </span>
      </div>
      {keineTreffer && <p className="app-hinweis">Kein Rätsel passt zu dieser Auswahl.</p>}
      {passend.length > 0 && (
        <details className="auswahl-liste">
          <summary>Bestimmtes Rätsel wählen ({passend.length})</summary>
          <ul className="puzzle-grid">
            {passend.map((s) => {
              const f = fortschritt.get(s.id);
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
        </details>
      )}
    </div>
  );
}
