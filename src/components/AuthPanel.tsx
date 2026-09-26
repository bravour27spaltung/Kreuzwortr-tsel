import { useState } from 'react';
import type { Session } from '@supabase/supabase-js';
import { signIn, signOut, signUp } from '@/lib/auth';
import { isSupabaseConfigured } from '@/lib/supabase';

interface Props {
  session: Session | null;
}

type Modus = 'login' | 'registrieren';

export default function AuthPanel({ session }: Props) {
  const [modus, setModus] = useState<Modus>('login');
  const [email, setEmail] = useState('');
  const [passwort, setPasswort] = useState('');
  const [laedt, setLaedt] = useState(false);
  const [fehler, setFehler] = useState<string | null>(null);
  const [hinweis, setHinweis] = useState<string | null>(null);

  if (!isSupabaseConfigured) {
    return (
      <div className="auth-panel auth-panel-hinweis">
        Login und Fortschrittsspeicherung sind ohne Supabase-Konfiguration nicht verfügbar.
      </div>
    );
  }

  if (session) {
    return (
      <div className="auth-panel auth-panel-eingeloggt">
        <span>
          Eingeloggt als <strong>{session.user.email}</strong>
        </span>
        <button
          className="cw-secondary"
          onClick={() => {
            void signOut();
          }}
        >
          Abmelden
        </button>
      </div>
    );
  }

  async function absenden(ev: React.FormEvent) {
    ev.preventDefault();
    setFehler(null);
    setHinweis(null);
    if (!email || passwort.length < 6) {
      setFehler('Bitte E-Mail und ein Passwort mit mindestens 6 Zeichen angeben.');
      return;
    }
    setLaedt(true);
    try {
      if (modus === 'registrieren') {
        const { bestaetigungNoetig } = await signUp(email, passwort);
        if (bestaetigungNoetig) {
          setHinweis('Fast geschafft: Bitte bestätige deine E-Mail-Adresse über den Link, den wir dir geschickt haben, und melde dich danach an.');
          setModus('login');
        }
      } else {
        await signIn(email, passwort);
      }
    } catch (e) {
      setFehler(e instanceof Error ? e.message : String(e));
    } finally {
      setLaedt(false);
    }
  }

  return (
    <form className="auth-panel auth-panel-form" onSubmit={(ev) => void absenden(ev)}>
      <div className="auth-tabs">
        <button
          type="button"
          className={modus === 'login' ? 'auth-tab auth-tab-aktiv' : 'auth-tab'}
          onClick={() => {
            setModus('login');
            setFehler(null);
            setHinweis(null);
          }}
        >
          Anmelden
        </button>
        <button
          type="button"
          className={modus === 'registrieren' ? 'auth-tab auth-tab-aktiv' : 'auth-tab'}
          onClick={() => {
            setModus('registrieren');
            setFehler(null);
            setHinweis(null);
          }}
        >
          Registrieren
        </button>
      </div>
      <label className="auth-feld">
        E-Mail
        <input type="email" autoComplete="email" value={email} onChange={(e) => setEmail(e.target.value)} required />
      </label>
      <label className="auth-feld">
        Passwort
        <input
          type="password"
          autoComplete={modus === 'registrieren' ? 'new-password' : 'current-password'}
          value={passwort}
          onChange={(e) => setPasswort(e.target.value)}
          minLength={6}
          required
        />
      </label>
      <button type="submit" disabled={laedt}>
        {laedt ? 'Einen Moment …' : modus === 'registrieren' ? 'Konto erstellen' : 'Anmelden'}
      </button>
      {fehler && <p className="auth-fehler">{fehler}</p>}
      {hinweis && <p className="auth-hinweis">{hinweis}</p>}
      {!fehler && !hinweis && (
        <p className="auth-hinweis-klein">Mit einem Konto wird dein Rätsel-Fortschritt automatisch gespeichert.</p>
      )}
    </form>
  );
}
