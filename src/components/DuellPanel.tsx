import { useCallback, useEffect, useRef, useState } from 'react';
import type { Session } from '@supabase/supabase-js';
import {
  duellFehlerText,
  einladungsLink,
  erstelleDuell,
  formatCode,
  formatDatum,
  formatZeit,
  ladeProfil,
  listeDuelle,
  pruefeEinladung,
  setzeProfil,
  tretBei,
  zieheZurueck,
  type DuellListeneintrag,
  type EinladungVorschau,
  type GroesseWunsch,
} from '@/lib/duell';
import { SCHWIERIGKEIT } from '@/lib/puzzleSource';

interface Props {
  session: Session | null;
  /** Einladungscode aus dem Link (?duell=…); wird angezeigt, bis er angenommen oder abgelehnt ist. */
  einladungsCode: string | null;
  onEinladungErledigt: () => void;
  onOeffneDuell: (id: number) => void;
}

function fehlerText(e: unknown): string {
  return e instanceof Error ? e.message : String(e);
}

/** Bereich "Duelle" auf der Startseite: Anzeigename, Einladen, Beitreten, Liste. */
export default function DuellPanel({ session, einladungsCode, onEinladungErledigt, onOeffneDuell }: Props) {
  const nutzerId = session?.user.id ?? null;
  const [profil, setProfil] = useState<string | null | undefined>(undefined); // undefined = lädt
  const [liste, setListe] = useState<DuellListeneintrag[] | null>(null);
  const [fehler, setFehler] = useState<string | null>(null);
  const [aktiverCode, setAktiverCode] = useState<string | null>(einladungsCode);
  const [beitrittsCode, setBeitrittsCode] = useState('');

  const laden = useCallback(async () => {
    try {
      const [p, l] = await Promise.all([ladeProfil(), listeDuelle()]);
      setProfil(p);
      setListe(l);
      setFehler(null);
    } catch (e) {
      setFehler(fehlerText(e));
    }
  }, []);

  useEffect(() => {
    if (!nutzerId) {
      setProfil(undefined);
      setListe(null);
      return;
    }
    void laden();
    // Beim Zurückkehren in den Tab aktualisieren (z.B. nachdem der Gegner abgegeben hat).
    const beiFokus = () => {
      if (document.visibilityState === 'visible') void laden();
    };
    document.addEventListener('visibilitychange', beiFokus);
    return () => document.removeEventListener('visibilitychange', beiFokus);
  }, [nutzerId, laden]);

  useEffect(() => {
    if (einladungsCode) setAktiverCode(einladungsCode);
  }, [einladungsCode]);

  function einladungBeendet() {
    setAktiverCode(null);
    setBeitrittsCode('');
    onEinladungErledigt();
  }

  if (!nutzerId) {
    return (
      <div className="duell-panel">
        <h2>Duelle</h2>
        {aktiverCode ? (
          <p className="duell-einladung-banner">Du wurdest zu einem Duell eingeladen. Melde dich an oder registriere dich, um es anzunehmen.</p>
        ) : (
          <p className="duell-hinweis">Melde dich an, um andere zu einem Duell herauszufordern: Ihr löst dasselbe Rätsel, wann ihr wollt, und die schnellere Zeit gewinnt.</p>
        )}
      </div>
    );
  }

  if (profil === undefined) {
    return (
      <div className="duell-panel">
        <h2>Duelle</h2>
        {fehler ? <p className="app-fehler">{fehler}</p> : <p className="duell-hinweis">Wird geladen …</p>}
      </div>
    );
  }

  return (
    <div className="duell-panel">
      <h2>Duelle</h2>
      {fehler && <p className="app-fehler">{fehler}</p>}

      <ProfilFeld profil={profil} onGespeichert={(n) => setProfil(n)} />

      {profil && aktiverCode && (
        <EinladungKarte
          key={aktiverCode}
          code={aktiverCode}
          onOeffneDuell={(id) => {
            einladungBeendet();
            onOeffneDuell(id);
          }}
          onFertig={einladungBeendet}
        />
      )}
      {!profil && aktiverCode && <p className="duell-einladung-banner">Du wurdest zu einem Duell eingeladen. Lege zuerst einen Anzeigenamen fest, dann kannst du annehmen.</p>}

      {profil && (
        <div className="duell-aktionsleiste">
          <NeuesDuell onErstellt={() => void laden()} />
          <form
            className="duell-code-form"
            onSubmit={(ev) => {
              ev.preventDefault();
              const code = beitrittsCode.replace(/[^A-Za-z0-9]/g, '').toUpperCase();
              if (code.length >= 4) setAktiverCode(code);
            }}
          >
            <label>
              Einladungscode eingeben
              <span className="duell-zeile">
                <input value={beitrittsCode} onChange={(e) => setBeitrittsCode(e.target.value)} placeholder="ABCD-EFGH" autoCapitalize="characters" autoComplete="off" spellCheck={false} />
                <button type="submit" disabled={beitrittsCode.replace(/[^A-Za-z0-9]/g, '').length < 4}>
                  Prüfen
                </button>
              </span>
            </label>
          </form>
        </div>
      )}

      {profil && liste && <DuellListe liste={liste} onOeffneDuell={onOeffneDuell} onGeaendert={() => void laden()} />}
    </div>
  );
}

// ---- Anzeigename ------------------------------------------------------------------------------------------------

function ProfilFeld({ profil, onGespeichert }: { profil: string | null; onGespeichert: (name: string) => void }) {
  const [bearbeiten, setBearbeiten] = useState(!profil);
  const [name, setName] = useState(profil ?? '');
  const [fehler, setFehler] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);

  async function speichern(ev: React.FormEvent) {
    ev.preventDefault();
    setBusy(true);
    setFehler(null);
    try {
      const gespeichert = await setzeProfil(name);
      onGespeichert(gespeichert);
      setName(gespeichert);
      setBearbeiten(false);
    } catch (e) {
      setFehler(fehlerText(e));
    } finally {
      setBusy(false);
    }
  }

  if (!bearbeiten && profil) {
    return (
      <p className="duell-profil">
        Dein Anzeigename im Duell: <strong>{profil}</strong>{' '}
        <button className="duell-link" onClick={() => setBearbeiten(true)}>
          ändern
        </button>
      </p>
    );
  }
  return (
    <form className="duell-profil-form" onSubmit={(ev) => void speichern(ev)}>
      <label>
        {profil ? 'Anzeigename ändern' : 'Wie sollen dich deine Gegner nennen?'}
        <span className="duell-zeile">
          <input value={name} onChange={(e) => setName(e.target.value)} maxLength={24} minLength={2} required autoComplete="nickname" placeholder="z.B. Steffen" />
          <button type="submit" disabled={busy || name.trim().length < 2}>
            Speichern
          </button>
          {profil && (
            <button type="button" className="cw-secondary" onClick={() => setBearbeiten(false)}>
              Abbrechen
            </button>
          )}
        </span>
      </label>
      <span className="duell-hinweis">Dieser Name ist für deine Gegner sichtbar, deine E-Mail-Adresse nie.</span>
      {fehler && <span className="auth-fehler">{fehler}</span>}
    </form>
  );
}

// ---- Neues Duell ------------------------------------------------------------------------------------------------

function NeuesDuell({ onErstellt }: { onErstellt: () => void }) {
  const [schwierigkeit, setSchwierigkeit] = useState('');
  const [groesse, setGroesse] = useState('');
  const [busy, setBusy] = useState(false);
  const [fehler, setFehler] = useState<string | null>(null);

  async function erstellen() {
    setBusy(true);
    setFehler(null);
    try {
      await erstelleDuell(schwierigkeit ? Number(schwierigkeit) : null, (groesse || null) as GroesseWunsch | null);
      onErstellt();
    } catch (e) {
      setFehler(fehlerText(e));
    } finally {
      setBusy(false);
    }
  }

  return (
    <div className="duell-neu">
      <span className="duell-neu-titel">Neues Duell</span>
      <span className="duell-zeile">
        <label>
          Schwierigkeit
          <select value={schwierigkeit} onChange={(e) => setSchwierigkeit(e.target.value)}>
            <option value="">egal</option>
            {Object.entries(SCHWIERIGKEIT).map(([k, v]) => (
              <option key={k} value={k}>
                {v}
              </option>
            ))}
          </select>
        </label>
        <label>
          Größe
          <select value={groesse} onChange={(e) => setGroesse(e.target.value)}>
            <option value="">egal</option>
            <option value="klein">klein (bis 9×9)</option>
            <option value="mittel">mittel (bis 12×12)</option>
            <option value="gross">groß (ab 13×13)</option>
          </select>
        </label>
        <button disabled={busy} onClick={() => void erstellen()}>
          {busy ? 'Einen Moment …' : 'Herausfordern'}
        </button>
      </span>
      <span className="duell-hinweis">Danach bekommst du einen Link, den du verschicken kannst. Das Rätsel wird erst beim Beitritt gewählt – eines, das ihr beide noch nicht gespielt habt.</span>
      {fehler && <span className="auth-fehler">{fehler}</span>}
    </div>
  );
}

// ---- Einladung annehmen -----------------------------------------------------------------------------------------

function EinladungKarte({ code, onOeffneDuell, onFertig }: { code: string; onOeffneDuell: (id: number) => void; onFertig: () => void }) {
  const [vorschau, setVorschau] = useState<EinladungVorschau | null>(null);
  const [fehler, setFehler] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);
  // Die Prüfung soll nur einmal je Code laufen, auch wenn der Elternbaustein bei jedem Rendern eine neue Funktion übergibt.
  const oeffneRef = useRef(onOeffneDuell);
  useEffect(() => {
    oeffneRef.current = onOeffneDuell;
  }, [onOeffneDuell]);

  useEffect(() => {
    let aktiv = true;
    pruefeEinladung(code)
      .then((v) => {
        if (!aktiv) return;
        if (v.ok && v.bereits_dabei && !v.eigenes) oeffneRef.current(v.duell_id); // schon angenommen: direkt zum Duell
        else setVorschau(v);
      })
      .catch((e: unknown) => aktiv && setFehler(fehlerText(e)));
    return () => {
      aktiv = false;
    };
  }, [code]);

  async function annehmen() {
    setBusy(true);
    setFehler(null);
    try {
      const r = await tretBei(code);
      if (r.ok) onOeffneDuell(r.duell_id);
      else setFehler(duellFehlerText(r.fehler));
    } catch (e) {
      setFehler(fehlerText(e));
    } finally {
      setBusy(false);
    }
  }

  let inhalt: React.ReactNode;
  if (fehler && !vorschau) {
    inhalt = <p className="app-fehler">{fehler}</p>;
  } else if (!vorschau) {
    inhalt = <p className="duell-hinweis">Einladung wird geprüft …</p>;
  } else if (!vorschau.ok) {
    inhalt = <p className="app-fehler">{duellFehlerText(vorschau.fehler)}</p>;
  } else if (vorschau.eigenes) {
    inhalt = <p>Das ist dein eigener Einladungslink. Schicke ihn an jemand anderen – er oder sie kann damit beitreten.</p>;
  } else {
    inhalt = (
      <>
        <p>
          <strong>{vorschau.ersteller_name ?? 'Jemand'}</strong> fordert dich zu einem Kreuzworträtsel-Duell heraus. Ihr löst dasselbe Rätsel zeitversetzt; die kürzere Zeit
          (mit Strafsekunden für Tipps und Fehl-Prüfungen) gewinnt.
        </p>
        <div className="duell-aktionen">
          <button disabled={busy} onClick={() => void annehmen()}>
            {busy ? 'Einen Moment …' : 'Annehmen'}
          </button>
        </div>
        {fehler && <p className="app-fehler">{fehler}</p>}
      </>
    );
  }
  return (
    <div className="duell-karte duell-karte-einladung">
      <div className="duell-karte-kopf">
        <h3>Einladung {formatCode(code)}</h3>
        <button className="cw-secondary" onClick={onFertig}>
          {vorschau?.ok && !vorschau.eigenes ? 'Ablehnen' : 'Schließen'}
        </button>
      </div>
      {inhalt}
    </div>
  );
}

// ---- Liste ------------------------------------------------------------------------------------------------------

function gruppe(d: DuellListeneintrag): 'dran' | 'wartet' | 'fertig' {
  if (d.status === 'laufend' && (d.mein_zustand === 'nicht_gestartet' || d.mein_zustand === 'laeuft')) return 'dran';
  if (d.status === 'offen' || d.status === 'laufend') return 'wartet';
  return 'fertig';
}

function DuellListe({ liste, onOeffneDuell, onGeaendert }: { liste: DuellListeneintrag[]; onOeffneDuell: (id: number) => void; onGeaendert: () => void }) {
  if (liste.length === 0) {
    return <p className="duell-hinweis">Noch keine Duelle. Fordere jemanden heraus oder gib einen Einladungscode ein.</p>;
  }
  const gruppen: { schluessel: 'dran' | 'wartet' | 'fertig'; titel: string }[] = [
    { schluessel: 'dran', titel: 'Du bist dran' },
    { schluessel: 'wartet', titel: 'Wartet' },
    { schluessel: 'fertig', titel: 'Beendet' },
  ];
  return (
    <div className="duell-liste">
      {gruppen.map(({ schluessel, titel }) => {
        const eintraege = liste.filter((d) => gruppe(d) === schluessel);
        if (eintraege.length === 0) return null;
        return (
          <div key={schluessel}>
            <h3>{titel}</h3>
            <ul>
              {eintraege.map((d) => (
                <li key={d.id}>
                  <DuellEintrag d={d} onOeffneDuell={onOeffneDuell} onGeaendert={onGeaendert} />
                </li>
              ))}
            </ul>
          </div>
        );
      })}
    </div>
  );
}

function raetselText(d: DuellListeneintrag): string {
  if (!d.raetsel) return '';
  const s = d.raetsel.schwierigkeit ? SCHWIERIGKEIT[d.raetsel.schwierigkeit] : null;
  return `${d.raetsel.zeilen}×${d.raetsel.spalten}${s ? ` · ${s}` : ''}`;
}

function DuellEintrag({ d, onOeffneDuell, onGeaendert }: { d: DuellListeneintrag; onOeffneDuell: (id: number) => void; onGeaendert: () => void }) {
  const [hinweis, setHinweis] = useState<string | null>(null);
  const [fehler, setFehler] = useState<string | null>(null);
  const gegner = d.gegner_name ?? 'Gegner';

  if (d.status === 'offen') {
    const link = d.code ? einladungsLink(d.code) : '';
    const kannTeilen = typeof navigator !== 'undefined' && typeof navigator.share === 'function';
    return (
      <div className="duell-eintrag duell-eintrag-offen">
        <div className="duell-eintrag-kopf">
          <strong>Einladung offen</strong>
          <span className="duell-meta">gültig bis {formatDatum(d.frist_am)}</span>
        </div>
        {d.code && (
          <>
            <span className="duell-meta">
              Code <strong className="duell-code">{formatCode(d.code)}</strong>
            </span>
            <input className="duell-link-feld" readOnly value={link} onFocus={(e) => e.currentTarget.select()} aria-label="Einladungslink" />
            <div className="duell-aktionen">
              <button
                onClick={() => {
                  navigator.clipboard
                    .writeText(link)
                    .then(() => setHinweis('Link kopiert.'))
                    .catch(() => setHinweis('Kopieren nicht möglich – markiere den Link und kopiere ihn von Hand.'));
                }}
              >
                Link kopieren
              </button>
              {kannTeilen && (
                <button className="cw-secondary" onClick={() => void navigator.share({ title: 'Kreuzworträtsel-Duell', text: 'Ich fordere dich zu einem Kreuzworträtsel-Duell heraus!', url: link }).catch(() => {})}>
                  Teilen …
                </button>
              )}
              <button
                className="cw-secondary"
                onClick={() => {
                  zieheZurueck(d.id)
                    .then(onGeaendert)
                    .catch((e: unknown) => setFehler(fehlerText(e)));
                }}
              >
                Zurückziehen
              </button>
            </div>
          </>
        )}
        {hinweis && <span className="duell-hinweis">{hinweis}</span>}
        {fehler && <span className="auth-fehler">{fehler}</span>}
      </div>
    );
  }

  const zustand =
    d.status === 'laufend'
      ? d.mein_zustand === 'abgegeben'
        ? `Abgegeben (${d.meine_netto_sekunden != null ? formatZeit(d.meine_netto_sekunden, true) : '–'}) – ${gegner} ist noch dran`
        : d.mein_zustand === 'laeuft'
          ? 'Deine Uhr läuft'
          : 'Noch nicht gestartet'
      : d.status === 'beendet'
        ? d.gewinner === 'ich'
          ? 'Gewonnen'
          : d.gewinner === 'gegner'
            ? 'Verloren'
            : 'Unentschieden'
        : d.ende_grund === 'nicht_beigetreten'
          ? 'Einladung nicht angenommen'
          : 'Kein Ergebnis';

  const aktion = gruppe(d) === 'dran' ? (d.mein_zustand === 'laeuft' ? 'Weiterspielen' : 'Ansehen und starten') : 'Ansehen';

  return (
    <div className={`duell-eintrag duell-eintrag-${d.status}${d.gewinner === 'ich' ? ' duell-eintrag-sieg' : ''}`}>
      <div className="duell-eintrag-kopf">
        <strong>
          {d.revanche ? 'Revanche gegen ' : 'Duell gegen '}
          {gegner}
        </strong>
        <span className="duell-badge">{zustand}</span>
      </div>
      <span className="duell-meta">
        {raetselText(d)}
        {d.status === 'laufend' && ` · Frist ${formatDatum(d.frist_am)}`}
        {d.status === 'beendet' && d.meine_netto_sekunden != null && ` · deine Gesamtzeit ${formatZeit(d.meine_netto_sekunden, true)}`}
      </span>
      {d.status !== 'abgelaufen' || d.ende_grund !== 'nicht_beigetreten' ? (
        <div className="duell-aktionen">
          <button className={gruppe(d) === 'dran' ? undefined : 'cw-secondary'} onClick={() => onOeffneDuell(d.id)}>
            {aktion}
          </button>
        </div>
      ) : null}
    </div>
  );
}
