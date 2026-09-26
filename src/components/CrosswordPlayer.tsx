import { useCallback, useEffect, useLayoutEffect, useMemo, useRef, useState } from 'react';
import type { Direction, Puzzle, PuzzleEntry } from '@/types';
import { formatZeit, type Regeln, type Zaehler } from '@/lib/duell';

function key(r: number, c: number): string {
  return `${r},${c}`;
}

interface DirEntries {
  A: PuzzleEntry | null;
  D: PuzzleEntry | null;
}

function entryCells(e: PuzzleEntry): [number, number][] {
  const cells: [number, number][] = [];
  for (let i = 0; i < e.len; i++) {
    cells.push(e.dir === 'A' ? [e.r, e.c + i] : [e.r + i, e.c]);
  }
  return cells;
}

interface Selection {
  r: number;
  c: number;
  dir: Direction;
}

/** Duell-Modus: Serveruhr, Strafen und Rückmeldungen an die Datenbank. Ohne dieses Objekt läuft der Player wie gewohnt. */
export interface DuellModus {
  gegnerName: string | null;
  /** Start der eigenen Runde (Serverzeit, ms seit 1970). */
  gestartetMs: number;
  /** Serverzeit minus Uhr dieses Geräts (ms), damit die Anzeige der Serveruhr folgt. */
  versatzMs: number;
  regeln: Regeln;
  /** Bereits gezählte Tipps/Prüfungen (bei Wiederaufnahme einer laufenden Runde). */
  start: Zaehler;
  onSpeichern: (userGrid: Record<string, string>, zaehler: Zaehler) => Promise<void>;
  /** Wird einmal aufgerufen, sobald das Gitter vollständig richtig ist. */
  onFertig: (userGrid: Record<string, string>, zaehler: Zaehler) => Promise<void>;
  onAufgeben: () => Promise<void>;
}

interface Props {
  puzzle: Puzzle;
  /** Gespeicherter Fortschritt, mit dem der Player startet (z.B. aus nutzer_fortschritt geladen). */
  initialUserGrid?: Record<string, string>;
  /** Wird gedämpft (debounced) bei jeder Änderung aufgerufen, z.B. um in Supabase zu speichern. */
  onFortschritt?: (userGrid: Record<string, string>, fertig: boolean) => void;
  duell?: DuellModus;
}

/** Kopfleiste im Duell: Gegner, Uhr (Serverzeit), Strafen, Aufgeben. Eigene Komponente, damit nur sie jede Sekunde neu zeichnet. */
function DuellLeiste({
  duell,
  zaehler,
  hinweis,
  abgabe,
  onErneutAbgeben,
}: {
  duell: DuellModus;
  zaehler: Zaehler;
  hinweis: string | null;
  abgabe: { art: 'offen' | 'laeuft' | 'fehler'; text?: string };
  onErneutAbgeben: () => void;
}) {
  const [jetzt, setJetzt] = useState(() => Date.now());
  const [frage, setFrage] = useState(false);
  const [aufgebenFehler, setAufgebenFehler] = useState<string | null>(null);
  useEffect(() => {
    const t = setInterval(() => setJetzt(Date.now()), 1000);
    return () => clearInterval(t);
  }, []);
  const dauer = (jetzt + duell.versatzMs - duell.gestartetMs) / 1000;
  const strafe = zaehler.tipps * duell.regeln.sek_pro_tipp + zaehler.pruefungen * duell.regeln.sek_pro_fehlpruefung;
  return (
    <div className="cw-duellbar">
      <div className="cw-duellbar-zeile">
        <span className="cw-duellbar-gegner">Duell gegen {duell.gegnerName ?? 'Gegner'}</span>
        <span className="cw-duellbar-uhr" aria-label="Zeit inklusive Strafsekunden">
          {formatZeit(dauer)}
          {strafe > 0 && <span className="cw-duellbar-strafe"> + {formatZeit(strafe)} Strafe</span>}
        </span>
        {!frage ? (
          <button className="cw-secondary" onClick={() => setFrage(true)}>
            Aufgeben
          </button>
        ) : (
          <span className="cw-duellbar-frage">
            Wirklich aufgeben? Dein Gegner gewinnt sofort.
            <button
              onClick={() => {
                setAufgebenFehler(null);
                duell.onAufgeben().catch((e: unknown) => setAufgebenFehler(e instanceof Error ? e.message : 'Aufgeben fehlgeschlagen.'));
              }}
            >
              Ja, aufgeben
            </button>
            <button className="cw-secondary" onClick={() => setFrage(false)}>
              Abbrechen
            </button>
          </span>
        )}
      </div>
      <div className="cw-duellbar-regeln">
        Jeder aufgedeckte Buchstabe kostet {duell.regeln.sek_pro_tipp} s, jedes „Prüfen“ mit Fehler {duell.regeln.sek_pro_fehlpruefung} s. Deine Uhr läuft weiter,
        auch wenn du die Seite verlässt.
      </div>
      {aufgebenFehler && <div className="cw-duellbar-warn">{aufgebenFehler}</div>}
      {hinweis && <div className="cw-duellbar-warn">Speichern fehlgeschlagen: {hinweis}</div>}
      {abgabe.art === 'laeuft' && <div className="cw-duellbar-info">Gitter vollständig – Abgabe wird geprüft …</div>}
      {abgabe.art === 'fehler' && (
        <div className="cw-duellbar-warn">
          Abgabe fehlgeschlagen: {abgabe.text}{' '}
          <button onClick={onErneutAbgeben}>Erneut versuchen</button>
        </div>
      )}
    </div>
  );
}

export default function CrosswordPlayer({ puzzle, initialUserGrid, onFortschritt, duell }: Props) {
  const { rows, cols, solution, entries } = puzzle;

  const whiteSet = useMemo(() => new Set(Object.keys(solution)), [solution]);

  // Frage-Zellen: Position -> {A: Eintrag|null, D: Eintrag|null}
  const clueCells = useMemo(() => {
    const map: Record<string, DirEntries> = {};
    entries.forEach((e) => {
      const k = key(e.clueR, e.clueC);
      if (!map[k]) map[k] = { A: null, D: null };
      map[k][e.dir] = e;
    });
    return map;
  }, [entries]);

  // Für jede weiße Zelle: welche(s) Wort/Wörter laufen hier durch
  const cellEntries = useMemo(() => {
    const map: Record<string, DirEntries> = {};
    whiteSet.forEach((k) => {
      map[k] = { A: null, D: null };
    });
    entries.forEach((e) => {
      entryCells(e).forEach(([r, c]) => {
        const k = key(r, c);
        if (!map[k]) map[k] = { A: null, D: null };
        map[k][e.dir] = e;
      });
    });
    return map;
  }, [entries, whiteSet]);

  const [userGrid, setUserGrid] = useState<Record<string, string>>(() => initialUserGrid ?? {});
  const [sel, setSel] = useState<Selection | null>(null);
  const [checkState, setCheckState] = useState<Record<string, 'correct' | 'incorrect'>>({});
  const [status, setStatus] = useState('');
  // Per Tipp aufgedeckte Felder: nicht mehr überschreibbar, zählen fürs Ergebnis.
  const [revealed, setRevealed] = useState<Record<string, boolean>>({});
  const [hintLetters, setHintLetters] = useState(duell?.start.tipps ?? 0);
  // Duell: Prüfungen, bei denen mindestens ein Feld falsch war (kosten Strafsekunden).
  const [pruefungen, setPruefungen] = useState(duell?.start.pruefungen ?? 0);
  const [duellHinweis, setDuellHinweis] = useState<string | null>(null);
  const [abgabe, setAbgabe] = useState<{ art: 'offen' | 'laeuft' | 'fehler'; text?: string }>({ art: 'offen' });

  const inputRefs = useRef<Record<string, HTMLInputElement | null>>({});
  const clueTextRefs = useRef<Record<string, HTMLSpanElement | null>>({});
  const scrollRef = useRef<HTMLDivElement | null>(null);
  const boardRef = useRef<HTMLDivElement | null>(null);

  const currentEntry = useMemo((): PuzzleEntry | null => {
    if (!sel) return null;
    const ent = cellEntries[key(sel.r, sel.c)];
    return ent ? ent[sel.dir] : null;
  }, [sel, cellEntries]);

  const inwordSet = useMemo(() => {
    const s = new Set<string>();
    if (currentEntry) {
      entryCells(currentEntry).forEach(([r, c]) => s.add(key(r, c)));
    }
    return s;
  }, [currentEntry]);

  const isRight = useCallback((k: string) => (userGrid[k] || '') === solution[k], [userGrid, solution]);

  const selectCell = useCallback(
    (r: number, c: number, forceDir: Direction | null, userClick: boolean) => {
      const k = key(r, c);
      const ent = cellEntries[k];
      if (!ent) return;
      setSel((prev) => {
        let nextDir: Direction;
        if (forceDir && ent[forceDir]) {
          nextDir = forceDir;
        } else if (prev && prev.r === r && prev.c === c && userClick) {
          if (ent.A && ent.D) {
            nextDir = prev.dir === 'A' ? 'D' : 'A';
          } else {
            nextDir = ent.A ? 'A' : 'D';
          }
        } else if (prev && ent[prev.dir]) {
          nextDir = prev.dir;
        } else {
          nextDir = ent.A ? 'A' : 'D';
        }
        return { r, c, dir: nextDir };
      });
    },
    [cellEntries]
  );

  const focusCell = useCallback((r: number, c: number) => {
    inputRefs.current[key(r, c)]?.focus();
  }, []);

  const moveInDirection = useCallback(
    (r: number, c: number, delta: number, clearOnBack?: boolean) => {
      const entry = currentEntry;
      if (!entry) return;
      const cells = entryCells(entry);
      const idx = cells.findIndex(([rr, cc]) => rr === r && cc === c);
      const nextIdx = idx + delta;
      if (nextIdx >= 0 && nextIdx < cells.length) {
        const [nr, nc] = cells[nextIdx];
        setSel((prev) => (prev ? { ...prev, r: nr, c: nc } : prev));
        if (clearOnBack && !revealed[key(nr, nc)]) {
          setUserGrid((g) => ({ ...g, [key(nr, nc)]: '' }));
        }
        focusCell(nr, nc);
      }
    },
    [currentEntry, focusCell, revealed]
  );

  const moveArrow = useCallback(
    (r: number, c: number, dr: number, dc: number) => {
      const ent = cellEntries[key(r, c)];
      const wantDir: Direction = dr !== 0 ? 'D' : 'A';
      let dir: Direction = sel?.dir ?? wantDir;
      if (ent && ent[wantDir] && wantDir !== dir) {
        dir = wantDir;
      }
      let nr = r + dr;
      let nc = c + dc;
      while (nr >= 0 && nr < rows && nc >= 0 && nc < cols && !whiteSet.has(key(nr, nc))) {
        nr += dr;
        nc += dc;
      }
      if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && whiteSet.has(key(nr, nc))) {
        setSel({ r: nr, c: nc, dir });
        focusCell(nr, nc);
      }
    },
    [cellEntries, sel, rows, cols, whiteSet, focusCell]
  );

  const handleInput = useCallback(
    (r: number, c: number, raw: string) => {
      const k = key(r, c);
      if (revealed[k]) return; // aufgedecktes Feld ist read-only
      let v = raw.toUpperCase().replace(/[^A-ZÄÖÜ]/g, '');
      v = v.slice(-1);
      setUserGrid((g) => ({ ...g, [k]: v }));
      setCheckState({});
      if (v) {
        moveInDirection(r, c, 1);
      }
    },
    [moveInDirection, revealed]
  );

  const handleKey = useCallback(
    (r: number, c: number, ev: React.KeyboardEvent<HTMLInputElement>) => {
      if (ev.key === '?') {
        ev.preventDefault();
        hintLetterRef.current();
        return;
      }
      if (ev.key === 'Backspace') {
        if (!ev.currentTarget.value) {
          ev.preventDefault();
          moveInDirection(r, c, -1, true);
        }
        return;
      }
      if (ev.key === 'ArrowRight') {
        ev.preventDefault();
        moveArrow(r, c, 0, 1);
        return;
      }
      if (ev.key === 'ArrowLeft') {
        ev.preventDefault();
        moveArrow(r, c, 0, -1);
        return;
      }
      if (ev.key === 'ArrowDown') {
        ev.preventDefault();
        moveArrow(r, c, 1, 0);
        return;
      }
      if (ev.key === 'ArrowUp') {
        ev.preventDefault();
        moveArrow(r, c, -1, 0);
        return;
      }
    },
    [moveInDirection, moveArrow]
  );

  const handleCheck = useCallback(() => {
    let total = 0;
    let correct = 0;
    let filled = 0;
    let falsch = 0;
    const next: Record<string, 'correct' | 'incorrect'> = {};
    whiteSet.forEach((k) => {
      total++;
      const val = (userGrid[k] || '').toUpperCase();
      if (val) filled++;
      if (val && val === solution[k]) {
        correct++;
        next[k] = 'correct';
      } else if (val) {
        next[k] = 'incorrect';
        falsch++;
      }
    });
    setCheckState(next);
    const hintTxt = hintLetters ? ` – davon ${hintLetters} per Tipp aufgedeckt` : '';
    let strafTxt = '';
    if (duell && falsch > 0) {
      setPruefungen((n) => n + 1);
      strafTxt = ` Prüfen mit Fehlern: +${duell.regeln.sek_pro_fehlpruefung} s.`;
    }
    setStatus(
      (correct === total
        ? `Fertig! Alle ${total} Felder korrekt${hintTxt}.`
        : `${correct} von ${total} Feldern korrekt (${filled} ausgefüllt)${hintTxt}.`) + strafTxt
    );
  }, [whiteSet, userGrid, solution, hintLetters, duell]);

  const handleSolve = useCallback(() => {
    setCheckState({});
    const next: Record<string, string> = {};
    whiteSet.forEach((k) => {
      next[k] = solution[k];
    });
    setUserGrid(next);
    setStatus('Lösung eingeblendet.');
  }, [whiteSet, solution]);

  const handleReset = useCallback(() => {
    setCheckState({});
    const next: Record<string, string> = {};
    whiteSet.forEach((k) => {
      next[k] = '';
    });
    setUserGrid(next);
    setRevealed({});
    setHintLetters(0);
    setStatus('Zurückgesetzt.');
  }, [whiteSet]);

  // ---- Tipps ----
  const hintLetterRef = useRef<() => void>(() => {});

  const handleHintLetter = useCallback(() => {
    if (!currentEntry || !sel) {
      setStatus('Wähle zuerst ein Feld oder eine Frage aus.');
      return;
    }
    setCheckState({});
    const cells = entryCells(currentEntry).map(([r, c]) => key(r, c));
    const selK = key(sel.r, sel.c);
    const target = !isRight(selK) && !revealed[selK] ? selK : cells.find((k) => !isRight(k) && !revealed[k]);
    if (!target) {
      setStatus('Dieses Wort ist bereits vollständig richtig.');
      return;
    }
    const wasRight = isRight(target);
    const letter = solution[target];
    setUserGrid((g) => ({ ...g, [target]: letter }));
    setRevealed((r) => ({ ...r, [target]: true }));
    if (!wasRight) setHintLetters((n) => n + 1);
    const nextOpen = cells.find((k) => k !== target && !isRight(k)) || target;
    const [nr, nc] = nextOpen.split(',').map(Number);
    setSel({ r: nr, c: nc, dir: currentEntry.dir });
    focusCell(nr, nc);
    setStatus(`Buchstabe „${letter}“ aufgedeckt. Aufgedeckte Buchstaben bisher: ${wasRight ? hintLetters : hintLetters + 1}.`);
  }, [currentEntry, sel, isRight, revealed, solution, hintLetters, focusCell]);

  useEffect(() => {
    hintLetterRef.current = handleHintLetter;
  }, [handleHintLetter]);

  const handleHintWord = useCallback(() => {
    if (!currentEntry) {
      setStatus('Wähle zuerst ein Feld oder eine Frage aus.');
      return;
    }
    setCheckState({});
    const cells = entryCells(currentEntry).map(([r, c]) => key(r, c));
    let n = 0;
    const gridUpd: Record<string, string> = {};
    const revUpd: Record<string, boolean> = {};
    cells.forEach((k) => {
      if (!isRight(k)) {
        if (!revealed[k]) n++;
        gridUpd[k] = solution[k];
        revUpd[k] = true;
      }
    });
    if (n === 0 && cells.every((k) => revealed[k] || isRight(k))) {
      setStatus('Dieses Wort ist bereits vollständig richtig.');
      return;
    }
    setUserGrid((g) => ({ ...g, ...gridUpd }));
    setRevealed((r) => ({ ...r, ...revUpd }));
    setHintLetters((h) => h + n);
    setStatus(`Wort aufgedeckt (${n} Buchstabe${n === 1 ? '' : 'n'}).`);
  }, [currentEntry, isRight, revealed, solution]);

  // ---- Fortschritt speichern: gedämpft (700ms nach der letzten Eingabe), nicht beim
  // ersten Rendern (das wäre nur der geladene Fortschritt selbst). ----
  const ersterRender = useRef(true);
  useEffect(() => {
    if (!onFortschritt) return;
    if (ersterRender.current) {
      ersterRender.current = false;
      return;
    }
    const t = setTimeout(() => {
      const felder = Object.keys(solution);
      const fertig = felder.length > 0 && felder.every((k) => (userGrid[k] || '') === solution[k]);
      onFortschritt(userGrid, fertig);
    }, 700);
    return () => clearTimeout(t);
  }, [userGrid, onFortschritt, solution]);

  // ---- Duell: Zwischenstand sichern. Tipps und Prüfungen kosten Zeit und gehen sofort raus (sonst ließe sich die Strafe
  // durch Schließen des Tabs umgehen), reine Eingaben gedämpft. Die Rückrufe liegen in Refs, damit ein neues
  // duell-Objekt des Elternbauteils den Timer nicht zurücksetzt. ----
  const duellSpeichernRef = useRef(duell?.onSpeichern);
  const duellFertigRef = useRef(duell?.onFertig);
  useEffect(() => {
    duellSpeichernRef.current = duell?.onSpeichern;
    duellFertigRef.current = duell?.onFertig;
  }, [duell]);
  const letzteZaehler = useRef<Zaehler>({ tipps: hintLetters, pruefungen });
  const duellErsterRender = useRef(true);
  useEffect(() => {
    if (!duellSpeichernRef.current) return;
    if (duellErsterRender.current) {
      duellErsterRender.current = false;
      return;
    }
    const zaehlerGeaendert = letzteZaehler.current.tipps !== hintLetters || letzteZaehler.current.pruefungen !== pruefungen;
    letzteZaehler.current = { tipps: hintLetters, pruefungen };
    const t = setTimeout(
      () => {
        duellSpeichernRef.current?.(userGrid, { tipps: hintLetters, pruefungen })
          .then(() => setDuellHinweis(null))
          .catch((e: unknown) => setDuellHinweis(e instanceof Error ? e.message : 'unbekannter Fehler'));
      },
      zaehlerGeaendert ? 0 : 700
    );
    return () => clearTimeout(t);
  }, [userGrid, hintLetters, pruefungen]);

  // ---- Duell: Sobald jedes Feld stimmt, wird abgegeben (die Datenbank prüft das Gitter noch einmal und stoppt die Zeit). ----
  const sendeAbgabe = useCallback((grid: Record<string, string>, z: Zaehler) => {
    const fn = duellFertigRef.current;
    if (!fn) return;
    setAbgabe({ art: 'laeuft' });
    fn(grid, z).catch((e: unknown) => setAbgabe({ art: 'fehler', text: e instanceof Error ? e.message : 'unbekannter Fehler' }));
  }, []);
  useEffect(() => {
    if (!duell || abgabe.art !== 'offen') return;
    const felder = Object.keys(solution);
    if (felder.length > 0 && felder.every((k) => (userGrid[k] || '') === solution[k])) {
      sendeAbgabe(userGrid, { tipps: hintLetters, pruefungen });
    }
  }, [duell, abgabe.art, userGrid, solution, hintLetters, pruefungen, sendeAbgabe]);

  // ---- Fragetext an die Zellgröße anpassen: größtmögliche Schrift (max. 13px)
  // ohne Abschneiden, sonst wird ein 2-Wort-Begriff wie "Erkundigung" auf den
  // ersten Blick unlesbar. Fällt bei sehr kleinen Zellen auf Silbentrennung
  // zurück (min. 8px), statt den Text abzuschneiden. ----
  const fitClues = useCallback(() => {
    Object.values(clueTextRefs.current).forEach((box) => {
      if (!box) return;
      const span = box.firstElementChild as HTMLElement | null;
      if (!span) return;
      box.classList.remove('cw-brk');
      const fits = () => span.scrollHeight <= box.clientHeight && span.scrollWidth <= box.clientWidth;
      let size = 13;
      box.style.fontSize = `${size}px`;
      while (size > 9.5 && !fits()) {
        size -= 0.5;
        box.style.fontSize = `${size}px`;
      }
      if (fits()) return;
      box.classList.add('cw-brk');
      size = 9.5;
      box.style.fontSize = `${size}px`;
      while (size > 8 && !fits()) {
        size -= 0.5;
        box.style.fontSize = `${size}px`;
      }
    });
  }, []);

  // ---- Zellgröße an die verfügbare Breite anpassen (zwischen 52 und 68px) ----
  const layout = useCallback(() => {
    const scrollEl = scrollRef.current;
    const boardEl = boardRef.current;
    if (!scrollEl || !boardEl) return;
    const avail = scrollEl.clientWidth - 2;
    const size = Math.max(52, Math.min(68, Math.floor((avail - (cols - 1) * 2) / cols)));
    boardEl.style.setProperty('--cell', `${size}px`);
    fitClues();
  }, [cols, fitClues]);

  useLayoutEffect(() => {
    layout();
  }, [layout, entries]);

  useEffect(() => {
    let t: ReturnType<typeof setTimeout>;
    const onResize = () => {
      clearTimeout(t);
      t = setTimeout(layout, 80);
    };
    window.addEventListener('resize', onResize);
    return () => {
      clearTimeout(t);
      window.removeEventListener('resize', onResize);
    };
  }, [layout]);

  // ---- Render ----
  const rowsArr = Array.from({ length: rows }, (_, r) => r);
  const colsArr = Array.from({ length: cols }, (_, c) => c);

  const selectedCellEntries = sel ? cellEntries[key(sel.r, sel.c)] : null;

  return (
    <div className="cw-wrap">
      <div className="cw-panel">
        {duell && (
          <DuellLeiste
            duell={duell}
            zaehler={{ tipps: hintLetters, pruefungen }}
            hinweis={duellHinweis}
            abgabe={abgabe}
            onErneutAbgeben={() => sendeAbgabe(userGrid, { tipps: hintLetters, pruefungen })}
          />
        )}
        <div className="cw-cluebar" aria-live="polite">
          {!sel && <span className="cw-empty">Tippe auf eine Frage oder ein weißes Feld – die Frage erscheint dann hier in voller Größe.</span>}
          {sel &&
            selectedCellEntries &&
            (['A', 'D'] as Direction[]).map((d) => {
              const e = selectedCellEntries[d];
              if (!e) return null;
              return (
                <div
                  key={d}
                  className={`cw-entry${d === sel.dir ? ' cw-entry-active' : ''}`}
                  onClick={() => setSel((prev) => (prev ? { ...prev, dir: d } : prev))}
                >
                  <span className="cw-arrow-big">{d === 'A' ? '→' : '↓'}</span>
                  <span>{e.clue}</span>
                  <span className="cw-len">({e.len})</span>
                </div>
              );
            })}
        </div>

        <div className="cw-board-scroll" ref={scrollRef}>
          <div
            className="cw-board"
            ref={boardRef}
            style={{
              gridTemplateColumns: `repeat(${cols}, var(--cell))`,
              gridTemplateRows: `repeat(${rows}, var(--cell))`,
            }}
          >
            {rowsArr.map((r) =>
              colsArr.map((c) => {
                const k = key(r, c);
                if (whiteSet.has(k)) {
                  const classes = ['cw-cell', 'cw-white'];
                  if (inwordSet.has(k)) classes.push('cw-inword');
                  if (sel && sel.r === r && sel.c === c) classes.push('cw-active');
                  if (checkState[k]) classes.push(`cw-${checkState[k]}`);
                  if (revealed[k]) classes.push('cw-revealed');
                  return (
                    <div
                      key={k}
                      className={classes.join(' ')}
                      onClick={() => {
                        selectCell(r, c, null, true);
                        focusCell(r, c);
                      }}
                    >
                      <input
                        ref={(el) => {
                          inputRefs.current[k] = el;
                        }}
                        maxLength={1}
                        autoComplete="off"
                        spellCheck={false}
                        readOnly={!!revealed[k]}
                        aria-label={`Feld Zeile ${r + 1}, Spalte ${c + 1}`}
                        value={userGrid[k] || ''}
                        onChange={(ev) => handleInput(r, c, ev.target.value)}
                        onKeyDown={(ev) => handleKey(r, c, ev)}
                      />
                    </div>
                  );
                }
                const cd = clueCells[k];
                if (cd) {
                  const dirs = (['A', 'D'] as Direction[]).filter((d) => cd[d]);
                  return (
                    <div key={k} className="cw-cell cw-clue">
                      <div className="cw-clue-slot">
                        {dirs.map((d, i) => {
                          const e = cd[d] as PuzzleEntry;
                          const half = `cw-half cw-dir-${d.toLowerCase()}${dirs.length === 2 && i === 0 ? ' cw-split-top' : ''}${
                            currentEntry === e ? ' cw-hl' : ''
                          }`;
                          return (
                            <div
                              key={d}
                              className={half}
                              tabIndex={0}
                              role="button"
                              aria-label={`${d === 'A' ? 'Waagerecht' : 'Senkrecht'}: ${e.clue}, ${e.len} Buchstaben`}
                              title={e.clue}
                              onClick={() => {
                                const [sr, sc] = entryCells(e)[0];
                                selectCell(sr, sc, d, true);
                                focusCell(sr, sc);
                              }}
                              onKeyDown={(ev) => {
                                if (ev.key === 'Enter' || ev.key === ' ') {
                                  ev.preventDefault();
                                  const [sr, sc] = entryCells(e)[0];
                                  selectCell(sr, sc, d, true);
                                  focusCell(sr, sc);
                                }
                              }}
                            >
                              <span
                                className="cw-clue-txt"
                                ref={(el) => {
                                  clueTextRefs.current[`${k}-${d}`] = el;
                                }}
                              >
                                <span>{e.clue}</span>
                              </span>
                              <span className="cw-arrow">{d === 'A' ? '▶' : '▼'}</span>
                            </div>
                          );
                        })}
                      </div>
                    </div>
                  );
                }
                return <div key={k} className="cw-cell cw-bg" />;
              })
            )}
          </div>
        </div>

        <div className="cw-controls">
          <div className="cw-group">
            <span className="cw-group-label">Tipp{duell ? ` (+${duell.regeln.sek_pro_tipp} s je Buchstabe)` : ''}:</span>
            <button
              className="cw-hint"
              title="Deckt den Buchstaben im gewählten Feld auf (Tastenkürzel: ?)"
              onMouseDown={(ev) => ev.preventDefault()}
              onClick={handleHintLetter}
            >
              Buchstabe aufdecken
            </button>
            <button className="cw-hint" title="Deckt das ganze aktuelle Wort auf" onMouseDown={(ev) => ev.preventDefault()} onClick={handleHintWord}>
              Wort aufdecken
            </button>
          </div>
          <span className="cw-sep" aria-hidden="true" />
          <div className="cw-group">
            <button onClick={handleCheck} title={duell ? `Mit Fehlern: +${duell.regeln.sek_pro_fehlpruefung} s` : undefined}>
              Prüfen
            </button>
            {!duell && (
              <>
                <button className="cw-secondary" onClick={handleSolve}>
                  Lösung zeigen
                </button>
                <button className="cw-secondary" onClick={handleReset}>
                  Zurücksetzen
                </button>
              </>
            )}
          </div>
        </div>
        <div className="cw-status">{status}</div>
      </div>
    </div>
  );
}
