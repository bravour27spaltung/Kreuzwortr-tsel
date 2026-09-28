/**
 * Sehr leichte, synthetisierte Klangrückmeldung über die Web Audio API – keine Audio-Dateien nötig.
 * Schaltbar über einen Knopf im Player, Zustand in localStorage (Standard: an). Schlägt Web Audio fehl
 * oder ist blockiert (z.B. Autoplay-Policy, nicht verfügbar), bleibt die App stumm statt einen Fehler zu werfen.
 */

const SPEICHER_SCHLUESSEL = 'cw-ton-an';

let audioContext: AudioContext | null = null;

function holeContext(): AudioContext | null {
  if (typeof window === 'undefined') return null;
  const Ctor = window.AudioContext ?? (window as unknown as { webkitAudioContext?: typeof AudioContext }).webkitAudioContext;
  if (!Ctor) return null;
  if (!audioContext) audioContext = new Ctor();
  if (audioContext.state === 'suspended') {
    audioContext.resume().catch(() => {
      /* ignorieren – Ton bleibt dann einfach aus */
    });
  }
  return audioContext;
}

export function tonAktiviert(): boolean {
  if (typeof window === 'undefined') return true;
  try {
    const wert = window.localStorage.getItem(SPEICHER_SCHLUESSEL);
    return wert === null ? true : wert === '1';
  } catch {
    return true;
  }
}

/** Schaltet um und gibt den neuen Zustand zurück. */
export function tonUmschalten(): boolean {
  const naechsterZustand = !tonAktiviert();
  try {
    window.localStorage.setItem(SPEICHER_SCHLUESSEL, naechsterZustand ? '1' : '0');
  } catch {
    /* Speicher evtl. nicht verfügbar (z.B. privates Fenster) – gilt dann nur für diese Sitzung */
  }
  return naechsterZustand;
}

function piep(frequenzHz: number, dauerMs: number, verzoegerungMs = 0, lautstaerke = 0.05) {
  if (!tonAktiviert()) return;
  try {
    const audio = holeContext();
    if (!audio) return;
    const start = audio.currentTime + verzoegerungMs / 1000;
    const ende = start + dauerMs / 1000;
    const osc = audio.createOscillator();
    const gain = audio.createGain();
    osc.type = 'sine';
    osc.frequency.setValueAtTime(frequenzHz, start);
    gain.gain.setValueAtTime(0, start);
    gain.gain.linearRampToValueAtTime(lautstaerke, start + 0.015);
    gain.gain.exponentialRampToValueAtTime(0.0001, ende);
    osc.connect(gain);
    gain.connect(audio.destination);
    osc.start(start);
    osc.stop(ende + 0.02);
  } catch {
    /* Web Audio evtl. nicht verfügbar oder blockiert – dann eben ohne Ton */
  }
}

/** Zweiklang, wenn ein ganzes Wort selbst getippt fertig und richtig ist (kein Ton pro Buchstabe – das wäre
    zu häufig/zu leicht verdient). */
export function spieleWortFertig() {
  piep(660, 90);
  piep(990, 110, 90);
}

/** Kleine Fanfare, wenn das ganze Rätsel gelöst ist. */
export function spieleFertig() {
  piep(523, 120);
  piep(659, 120, 110);
  piep(784, 180, 220);
}
