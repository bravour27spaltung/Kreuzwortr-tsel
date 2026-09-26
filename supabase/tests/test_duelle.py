#!/usr/bin/env python3
"""Tests für supabase/migrations/20260927000000_duelle.sql gegen ein lokales Postgres 16 mit Supabase-Shim.
Aufruf (als Postgres-Benutzer): python3 test_duelle.py"""
import re
import sys
import threading
import time

import psycopg2
import psycopg2.extras

DSN = "dbname=kwr_test user=postgres host=/var/run/postgresql"  # lokale Testdatenbank, siehe README.md in diesem Ordner
ergebnisse = []


def check(name, bedingung, detail=""):
    ergebnisse.append((name, bool(bedingung), detail))
    print(("  ok   " if bedingung else "  FAIL ") + name + ("" if bedingung or not detail else f"  -> {detail}"))


def admin(sql, params=None, fetch=False):
    conn = psycopg2.connect(DSN)
    try:
        cur = conn.cursor()
        cur.execute(sql, params)
        rows = cur.fetchall() if fetch else None
        conn.commit()
        return rows
    finally:
        conn.close()


def rpc(user, sql, params=(), pre_sql=None):
    """Führt einen Aufruf als eingeloggter Nutzer (user = uuid) oder anon (None) aus, in eigener Transaktion.
    pre_sql läuft vorher als Superuser in derselben Transaktion (z.B. um die Uhrzeit-Startwerte zu setzen)."""
    conn = psycopg2.connect(DSN)
    try:
        cur = conn.cursor()
        if pre_sql:
            cur.execute(pre_sql)
        cur.execute("set local role %s" % ("authenticated" if user else "anon"))
        if user:
            cur.execute("select set_config('request.jwt.claim.sub', %s, true)", (user,))
        cur.execute(sql, params)
        wert = cur.fetchone()[0] if cur.description else None
        conn.commit()
        return "ok", wert
    except psycopg2.Error as e:
        conn.rollback()
        return "err", e.diag.message_primary
    finally:
        conn.close()


def ok(user, sql, params=(), pre_sql=None):
    art, wert = rpc(user, sql, params, pre_sql)
    if art != "ok":
        raise AssertionError(f"unerwarteter Fehler: {wert}  [{sql}]")
    return wert


def fehler(user, sql, params=(), pre_sql=None):
    art, wert = rpc(user, sql, params, pre_sql)
    return wert if art == "err" else f"(kein Fehler, Ergebnis {wert})"


def json(x):
    return psycopg2.extras.Json(x)


def loesung(raetsel_id):
    zeilen = admin(
        """select f.richtung, f.start_zeile, f.start_spalte, w.wort from fragen f join woerter w on w.id = f.wort_id
           where f.raetsel_id = %s""", (raetsel_id,), fetch=True)
    grid = {}
    for richtung, r, c, wort in zeilen:
        for i, b in enumerate(wort):
            grid[f"{r},{c + i}" if richtung == "A" else f"{r + i},{c}"] = b
    return grid


def zuruecksetzen():
    admin("truncate duell_versuche, duell_teilnahme, duelle, profile, nutzer_fortschritt restart identity cascade")
    admin("delete from auth.users")


def nutzer(name, profil=True):
    uid = admin("insert into auth.users (email) values (%s) returning id", (name + "@test.local",), fetch=True)[0][0]
    uid = str(uid)
    if profil:
        ok(uid, "select profil_setzen(%s)", (name.capitalize(),))
    return uid


def neues_duell(a, b, schwierigkeit=None, groesse=None):
    d = ok(a, "select duell_erstellen(%s::smallint, %s)", (schwierigkeit, groesse))
    r = ok(b, "select duell_beitreten(%s)", (d["code"],))
    assert r["ok"], r
    return d["duell_id"], d["code"]


def gestartet(duell_id, user):
    return ok(user, "select duell_starten(%s)", (duell_id,))


def abgeben(duell_id, user, tipps=0, pruef=0, pre_sql=None):
    rid = admin("select raetsel_id from duelle where id = %s", (duell_id,), fetch=True)[0][0]
    return ok(user, "select duell_abgeben(%s, %s, %s, %s)", (duell_id, json(loesung(rid)), tipps, pruef), pre_sql=pre_sql)


# ---------------------------------------------------------------------------------------------------------------
print("\n[1] Rechte: keine direkten Tabellenzugriffe, Hilfsfunktionen gesperrt")
zuruecksetzen()
a = nutzer("anna")
for t in ["duelle", "duell_teilnahme", "profile", "duell_versuche"]:
    m = fehler(a, f"select count(*) from {t}")
    check(f"authenticated darf {t} nicht lesen", "permission denied" in m, m)
    m = fehler(None, f"select count(*) from {t}")
    check(f"anon darf {t} nicht lesen", "permission denied" in m, m)
m = fehler(a, "insert into duelle (code, ersteller_id) values ('X', %s)", (a,))
check("authenticated darf nicht in duelle schreiben", "permission denied" in m, m)
m = fehler(a, "select _duell_code()")
check("Hilfsfunktion _duell_code() für authenticated gesperrt", "permission denied" in m, m)
m = fehler(a, "select _duell_ansicht(null::duelle, %s)", (a,))
check("Hilfsfunktion _duell_ansicht() gesperrt", "permission denied" in m, m)
m = fehler(None, "select duell_erstellen(null::smallint, null)")
check("anon darf duell_erstellen nicht aufrufen", "permission denied" in m, m)
m = fehler(None, "select duelle_liste()")
check("anon darf duelle_liste nicht aufrufen", "permission denied" in m, m)

# ---------------------------------------------------------------------------------------------------------------
print("\n[2] Profil")
zuruecksetzen()
u = nutzer("ben", profil=False)
check("profil_laden ohne Profil = null", ok(u, "select profil_laden()") is None)
for schlecht in ["a", "x" * 25, "   ", "Na\nme", ""]:
    m = fehler(u, "select profil_setzen(%s)", (schlecht,))
    check(f"Name {schlecht!r} wird abgelehnt", m == "name_ungueltig", m)
check("Name wird getrimmt gespeichert", ok(u, "select profil_setzen(%s)", ("  Bens Name  ",))["anzeigename"] == "Bens Name")
check("Name änderbar", ok(u, "select profil_setzen(%s)", ("Benno",))["anzeigename"] == "Benno")
check("profil_laden liefert Namen", ok(u, "select profil_laden()")["anzeigename"] == "Benno")
m = fehler(None, "select profil_setzen('Hallo')")
check("profil_setzen ohne Login gesperrt", "permission denied" in m, m)

# ---------------------------------------------------------------------------------------------------------------
print("\n[3] Einladungscodes")
codes = [r[0] for r in admin("select _duell_code() from generate_series(1, 3000)", fetch=True)]
check("Codes haben 8 Zeichen aus dem 32er-Alphabet", all(re.fullmatch(r"[A-HJ-NP-Z2-9]{8}", c) for c in codes))
check("3000 Codes sind alle verschieden", len(set(codes)) == 3000)
zeichen = "".join(codes)
haeufigkeit = {z: zeichen.count(z) for z in set(zeichen)}
check("Alle 32 Symbole kommen vor, keins dominiert (Verteilung grob gleich)",
      len(haeufigkeit) == 32 and max(haeufigkeit.values()) < 1.25 * len(zeichen) / 32 and min(haeufigkeit.values()) > 0.75 * len(zeichen) / 32,
      f"min={min(haeufigkeit.values())} max={max(haeufigkeit.values())} soll≈{len(zeichen)//32}")

# ---------------------------------------------------------------------------------------------------------------
print("\n[4] Erstellen")
zuruecksetzen()
ohne = nutzer("ohne", profil=False)
check("Erstellen ohne Profil -> profil_fehlt", fehler(ohne, "select duell_erstellen(null::smallint, null)") == "profil_fehlt")
a = nutzer("anna")
check("Ungültige Schwierigkeit", fehler(a, "select duell_erstellen(7::smallint, null)") == "ungueltige_angabe")
check("Ungültige Größe", fehler(a, "select duell_erstellen(null::smallint, 'riesig')") == "ungueltige_angabe")
ids = [ok(a, "select duell_erstellen(null::smallint, null)") for _ in range(5)]
check("5 offene Duelle erlaubt", len(ids) == 5 and len({i["code"] for i in ids}) == 5)
check("6. offenes Duell -> zu_viele_offene_duelle", fehler(a, "select duell_erstellen(null::smallint, null)") == "zu_viele_offene_duelle")
ok(a, "select duell_zurueckziehen(%s)", (ids[0]["duell_id"],))
check("Zurückziehen macht Platz für ein neues Duell", "code" in ok(a, "select duell_erstellen(null::smallint, null)"))
check("Ersteller ist als Teilnehmer eingetragen",
      admin("select count(*) from duell_teilnahme where duell_id = %s and nutzer_id = %s", (ids[1]["duell_id"], a), fetch=True)[0][0] == 1)

# ---------------------------------------------------------------------------------------------------------------
print("\n[5] Einladung und Beitritt")
zuruecksetzen()
a, b, c = nutzer("anna"), nutzer("ben"), nutzer("cleo")
d = ok(a, "select duell_erstellen(null::smallint, null)")
code = d["code"]
formatiert = code[:4].lower() + "-" + code[4:] + " "
v = ok(b, "select duell_einladung(%s)", (formatiert,))
check("Einladungsvorschau (Kleinschreibung, Bindestrich, Leerzeichen) erkannt", v["ok"] and v["ersteller_name"] == "Anna" and not v["bereits_dabei"], str(v))
check("Vorschau ändert nichts", admin("select status, gegner_id from duelle where id = %s", (d["duell_id"],), fetch=True)[0] == ("offen", None))
v = ok(a, "select duell_einladung(%s)", (code,))
check("Ersteller sieht 'eigenes' Duell", v["ok"] and v["eigenes"])
check("Beitreten des Erstellers -> eigenes_duell", ok(a, "select duell_beitreten(%s)", (code,))["fehler"] == "eigenes_duell")
noprofil = nutzer("dora", profil=False)
check("Beitreten ohne Profil -> profil_fehlt", fehler(noprofil, "select duell_beitreten(%s)", (code,)) == "profil_fehlt")
r = ok(b, "select duell_beitreten(%s)", (formatiert,))
check("Beitritt klappt", r["ok"] and r["duell_id"] == d["duell_id"], str(r))
z = admin("select status, gegner_id::text, raetsel_id, frist_am > now() + interval '6 days 23 hours', beigetreten_am is not null from duelle where id = %s", (d["duell_id"],), fetch=True)[0]
check("Status laufend, Gegner gesetzt, Rätsel gewählt, Frist ≈ 7 Tage", z[0] == "laufend" and z[1] == b and z[2] is not None and z[3] and z[4], str(z))
check("Beide haben eine Teilnahme-Zeile", admin("select count(*) from duell_teilnahme where duell_id = %s", (d["duell_id"],), fetch=True)[0][0] == 2)
check("Erneutes Beitreten ist idempotent", ok(b, "select duell_beitreten(%s)", (code,)) == {"ok": True, "duell_id": d["duell_id"]})
check("Dritte Person -> nicht_mehr_offen", ok(c, "select duell_beitreten(%s)", (code,))["fehler"] == "nicht_mehr_offen")
check("Dritte Person sieht in der Vorschau nicht_mehr_offen", ok(c, "select duell_einladung(%s)", (code,))["fehler"] == "nicht_mehr_offen")
check("Dritte Person kann das Duell nicht öffnen", fehler(c, "select duell_ergebnis(%s)", (d["duell_id"],)) == "duell_unbekannt")
check("Dritte Person kann nicht starten", fehler(c, "select duell_starten(%s)", (d["duell_id"],)) == "duell_unbekannt")
check("Dritte Person kann nicht speichern", fehler(c, "select duell_speichern(%s, %s, 0, 0)", (d["duell_id"], json({}))) == "duell_unbekannt")
check("Dritte Person kann nicht aufgeben", fehler(c, "select duell_aufgeben(%s)", (d["duell_id"],)) == "duell_unbekannt")
check("Dritte Person sieht das Duell nicht in ihrer Liste", ok(c, "select duelle_liste()") == [])

# Fehlversuche begrenzen
for i in range(10):
    ok(c, "select duell_beitreten(%s)", (f"FALSCH{i:02d}",))
r = ok(c, "select duell_beitreten(%s)", ("ZZZZZZZZ",))
check("Falsche Codes werden gezählt und liefern code_unbekannt", admin("select count(*) from duell_versuche where nutzer_id = %s", (c,), fetch=True)[0][0] == 10)
check("Nach 10 Fehlversuchen -> zu_viele_versuche (auch bei richtigem Code)",
      ok(c, "select duell_beitreten(%s)", (code,))["fehler"] == "zu_viele_versuche" and ok(c, "select duell_einladung(%s)", (code,))["fehler"] == "zu_viele_versuche")
admin("update duell_versuche set zeit = now() - interval '11 minutes'")
check("Nach 10 Minuten wieder erlaubt", ok(c, "select duell_beitreten(%s)", (code,))["fehler"] == "nicht_mehr_offen")

# ---------------------------------------------------------------------------------------------------------------
print("\n[6] Rätselauswahl: nur Rätsel, die keiner der beiden kennt")
zuruecksetzen()
a, b = nutzer("anna"), nutzer("ben")
alle = [r[0] for r in admin("select id from raetsel where status = 'veroeffentlicht' order by id", fetch=True)]
check("78 veröffentlichte Rätsel vorhanden", len(alle) == 78)
# A kennt die ersten 40 (Fortschritt), B die nächsten 36; frei bleiben genau 2
frei = alle[-2:]
for r in alle[:40]:
    admin("insert into nutzer_fortschritt (nutzer_id, raetsel_id) values (%s, %s)", (a, r))
for r in alle[40:-2]:
    admin("insert into nutzer_fortschritt (nutzer_id, raetsel_id) values (%s, %s)", (b, r))
gewaehlt = []
for i in range(2):
    d, _ = neues_duell(a, b)
    gewaehlt.append(admin("select raetsel_id from duelle where id = %s", (d,), fetch=True)[0][0])
check("Gewählte Rätsel sind genau die 2 freien (in beliebiger Reihenfolge)", sorted(gewaehlt) == sorted(frei), f"{gewaehlt} vs {frei}")
d = ok(a, "select duell_erstellen(null::smallint, null)")
check("Pool erschöpft -> kein_raetsel, Duell bleibt offen",
      ok(b, "select duell_beitreten(%s)", (d["code"],))["fehler"] == "kein_raetsel"
      and admin("select status from duelle where id = %s", (d["duell_id"],), fetch=True)[0][0] == "offen")

# Wünsche
zuruecksetzen()
a, b = nutzer("anna"), nutzer("ben")
einfach = admin("select r.id from raetsel r where r.schwierigkeit = 1 order by r.id limit 1", fetch=True)[0][0]
schwer = admin("select r.id from raetsel r where r.schwierigkeit = 3 order by r.id limit 1", fetch=True)[0][0]
for r in alle:
    if r not in (einfach, schwer):
        admin("insert into nutzer_fortschritt (nutzer_id, raetsel_id) values (%s, %s)", (a, r))
treffer = 0
for i in range(6):
    admin("truncate duell_teilnahme, duelle cascade")
    d, _ = neues_duell(a, b, schwierigkeit=3)
    treffer += admin("select r.schwierigkeit from duelle d join raetsel r on r.id = d.raetsel_id where d.id = %s", (d,), fetch=True)[0][0] == 3
check("Wunsch 'schwer' wird erfüllt, wenn ein ungespieltes schweres Rätsel da ist", treffer == 6, f"{treffer}/6")
admin("truncate duell_teilnahme, duelle cascade")
admin("delete from nutzer_fortschritt where raetsel_id = %s and nutzer_id = %s", (einfach, a))
admin("insert into nutzer_fortschritt (nutzer_id, raetsel_id) values (%s, %s)", (a, schwer))
d, _ = neues_duell(a, b, schwierigkeit=3)
check("Wunsch nicht erfüllbar -> Fallback auf ein ungespieltes Rätsel",
      admin("select raetsel_id from duelle where id = %s", (d,), fetch=True)[0][0] == einfach)
# Größen
zuruecksetzen()
a, b = nutzer("anna"), nutzer("ben")
for klasse in ["klein", "mittel", "gross"]:
    d, _ = neues_duell(a, b, groesse=klasse)
    zeilen, spalten = admin("select g.zeilen, g.spalten from duelle d join raetsel r on r.id = d.raetsel_id join gitter g on g.id = r.gitter_id where d.id = %s", (d,), fetch=True)[0]
    passt = {"klein": zeilen * spalten < 100, "mittel": 100 <= zeilen * spalten < 150, "gross": zeilen * spalten >= 150}[klasse]
    check(f"Größenwunsch {klasse}: {zeilen}x{spalten}", passt)

# ---------------------------------------------------------------------------------------------------------------
print("\n[7] Starten, Speichern, Abgeben, Wertung")
zuruecksetzen()
a, b, c = nutzer("anna"), nutzer("ben"), nutzer("cleo")
d, code = neues_duell(a, b)
rid = admin("select raetsel_id from duelle where id = %s", (d,), fetch=True)[0][0]
sol = loesung(rid)
check("Vor dem Start: Speichern nicht möglich", fehler(b, "select duell_speichern(%s, %s, 0, 0)", (d, json({}))) == "nicht_gestartet")
check("Vor dem Start: Abgeben nicht möglich", fehler(b, "select duell_abgeben(%s, %s, 0, 0)", (d, json(sol))) == "nicht_gestartet")
s1 = gestartet(d, b)
time.sleep(0.05)
s2 = gestartet(d, b)
check("Starten ist idempotent (gleiche Startzeit)", s1["gestartet_am"] == s2["gestartet_am"] and s1["raetsel_id"] == rid)
check("Start liefert Serverzeit und Frist mit", s1["jetzt"] is not None and s1["frist_am"] is not None)
check("Start liefert die Regeln (20 s je Tipp, 15 s je Fehlprüfung) mit", s1["regeln"] == {"sek_pro_tipp": 20, "sek_pro_fehlpruefung": 15}, str(s1.get("regeln")))
check("Ansicht liefert die Regeln ebenfalls", ok(a, "select duell_ergebnis(%s)", (d,))["regeln"] == {"sek_pro_tipp": 20, "sek_pro_fehlpruefung": 15})
check("Gegner ist noch nicht gestartet", admin("select gestartet_am from duell_teilnahme where duell_id = %s and nutzer_id = %s", (d, a), fetch=True)[0][0] is None)

teil = {k: sol[k] for k in list(sol)[:10]}
r = ok(b, "select duell_speichern(%s, %s, 3, 1)", (d, json(teil)))
check("Strafsekunden = 3×20 + 1×15 = 75", r["strafsekunden"] == 75, str(r))
r = ok(b, "select duell_speichern(%s, %s, 2, 0)", (d, json(teil)))
check("Zähler gehen nur aufwärts (2 < 3 wird ignoriert)", r["tipps"] == 3 and r["pruefungen"] == 1 and r["strafsekunden"] == 75, str(r))
r = ok(b, "select duell_speichern(%s, %s, 5, 1)", (d, json(teil)))
check("Zähler steigen (5 Tipps -> 115 s)", r["tipps"] == 5 and r["strafsekunden"] == 115, str(r))
check("Fortsetzen liefert gespeicherten Stand", (lambda s: s["tipps"] == 5 and s["pruefungen"] == 1 and s["eingaben"] == teil)(gestartet(d, b)))
check("Ungültige Eingaben (Array) abgelehnt", fehler(b, "select duell_speichern(%s, %s, 0, 0)", (d, json([1, 2]))) == "ungueltige_angabe")
check("Negative Zähler abgelehnt", fehler(b, "select duell_speichern(%s, %s, -1, 0)", (d, json({}))) == "ungueltige_angabe")
check("Zu große Zähler abgelehnt", fehler(b, "select duell_speichern(%s, %s, 5000, 0)", (d, json({}))) == "ungueltige_angabe")
check("Zu große Eingaben abgelehnt", fehler(b, "select duell_speichern(%s, %s, 0, 0)", (d, json({f"{i},0": "A" for i in range(3000)}))) == "ungueltige_angabe")

falsch = dict(sol)
k0 = next(iter(falsch))
falsch[k0] = "Q" if falsch[k0] != "Q" else "X"
check("Abgabe mit einem falschen Feld -> loesung_falsch", fehler(b, "select duell_abgeben(%s, %s, 5, 1)", (d, json(falsch))) == "loesung_falsch")
luecke = dict(sol)
del luecke[k0]
check("Abgabe mit fehlendem Feld -> loesung_falsch", fehler(b, "select duell_abgeben(%s, %s, 5, 1)", (d, json(luecke))) == "loesung_falsch")
check("Abgabe leeres Gitter -> loesung_falsch", fehler(b, "select duell_abgeben(%s, %s, 0, 0)", (d, json({}))) == "loesung_falsch")
check("Fehlgeschlagene Abgabe setzt nichts", admin("select abgegeben_am is null from duell_teilnahme where duell_id = %s and nutzer_id = %s", (d, b), fetch=True)[0][0])

# Zeiten festlegen: B 100 s gespielt (+115 s Strafe), A 300 s (+0)
admin("update duell_teilnahme set gestartet_am = now() - interval '100 seconds' where duell_id = %s and nutzer_id = %s", (d, b))
klein = {k: v.lower() for k, v in sol.items()}
ans_b = ok(b, "select duell_abgeben(%s, %s, 5, 1)", (d, json(klein)))     # Kleinschreibung wird akzeptiert
netto_b = ans_b["ich"]["netto_sekunden"]
check("B: Netto ≈ 100 s + 115 s Strafe", 214.5 < netto_b < 217, str(netto_b))
check("Duell läuft weiter, solange A nicht fertig ist", ans_b["status"] == "laufend" and ans_b["gewinner"] is None)
check("Nach der Abgabe sieht B, dass A noch nicht abgegeben hat, aber keine Zahlen von A",
      ans_b["gegner"]["abgegeben"] is False and ans_b["gegner"]["netto_sekunden"] is None and ans_b["gegner"]["tipps"] is None, str(ans_b["gegner"]))

# Sichtbarkeit: A hat nicht abgegeben und sieht nichts von B
va = ok(a, "select duell_ergebnis(%s)", (d,))
check("A (noch nicht fertig) sieht von B nur den Namen", va["gegner"] == {"name": "Ben", "abgegeben": None, "aufgegeben": None, "tipps": None, "pruefungen": None, "strafsekunden": None, "dauer_sekunden": None, "netto_sekunden": None}, str(va["gegner"]))
check("A sieht nicht einmal den Status 'B hat abgegeben' (Duell bleibt 'laufend', kein Gewinner)", va["status"] == "laufend" and va["gewinner"] is None and va["ende_grund"] is None)
liste_a = ok(a, "select duelle_liste()")
check("Liste von A verrät nichts über B", liste_a[0]["mein_zustand"] in ("nicht_gestartet", "laeuft") and liste_a[0]["gewinner"] is None and liste_a[0]["meine_netto_sekunden"] is None)
check("Abgabe zweimal -> bereits_beendet", fehler(b, "select duell_abgeben(%s, %s, 5, 1)", (d, json(sol))) == "bereits_beendet")
check("Speichern nach Abgabe -> bereits_beendet", fehler(b, "select duell_speichern(%s, %s, 5, 1)", (d, json(sol))) == "bereits_beendet")
check("Aufgeben nach Abgabe -> bereits_beendet", fehler(b, "select duell_aufgeben(%s)", (d,)) == "bereits_beendet")

gestartet(d, a)
admin("update duell_teilnahme set gestartet_am = now() - interval '300 seconds' where duell_id = %s and nutzer_id = %s", (d, a))
ans_a = abgeben(d, a)
check("A: Netto ≈ 300 s, keine Strafe", 299.5 < ans_a["ich"]["netto_sekunden"] < 302 and ans_a["ich"]["strafsekunden"] == 0, str(ans_a["ich"]))
check("Duell ist beendet, Sieger B (schneller nach Strafen)", ans_a["status"] == "beendet" and ans_a["gewinner"] == "gegner" and ans_a["ende_grund"] == "zeit", str(ans_a))
vb = ok(b, "select duell_ergebnis(%s)", (d,))
check("B sieht Sieg und A's Zahlen", vb["gewinner"] == "ich" and 299.5 < vb["gegner"]["netto_sekunden"] < 302 and vb["gegner"]["tipps"] == 0, str(vb["gegner"]))
check("Ergebnis enthält nie die Zelleingaben", "eingaben" not in str(vb) and "zell" not in str(vb))
check("Nach Ende: Speichern -> duell_nicht_laufend", fehler(a, "select duell_speichern(%s, %s, 0, 0)", (d, json(sol))) == "duell_nicht_laufend")
check("Nach Ende: Starten -> duell_nicht_laufend", fehler(a, "select duell_starten(%s)", (d,)) == "duell_nicht_laufend")
check("Nach Ende: Aufgeben -> duell_nicht_laufend", fehler(a, "select duell_aufgeben(%s)", (d,)) == "duell_nicht_laufend")

# Gleichstand: beide 0,000 s Netto
print("\n[8] Gleichstand, Aufgeben, Fristen")
zuruecksetzen()
a, b = nutzer("anna"), nutzer("ben")
d, _ = neues_duell(a, b)
gestartet(d, a), gestartet(d, b)
admin("update duell_teilnahme set gestartet_am = now(), abgegeben_am = now(), netto_sekunden = 0, strafsekunden = 0 where duell_id = %s and nutzer_id = %s", (d, a))
ans = abgeben(d, b, pre_sql=f"update duell_teilnahme set gestartet_am = now() where duell_id = {d} and nutzer_id = '{b}'")
check("Gleichstand -> beendet ohne Sieger ('unentschieden')", ans["status"] == "beendet" and ans["gewinner"] == "unentschieden" and ans["ende_grund"] == "zeit", str(ans))

# Aufgeben
zuruecksetzen()
a, b = nutzer("anna"), nutzer("ben")
d, _ = neues_duell(a, b)
gestartet(d, b)
ans = ok(b, "select duell_aufgeben(%s)", (d,))
check("Aufgeben: beendet, Gegner gewinnt", ans["status"] == "beendet" and ans["gewinner"] == "gegner" and ans["ende_grund"] == "aufgabe" and ans["ich"]["aufgegeben"], str(ans))
va = ok(a, "select duell_ergebnis(%s)", (d,))
check("Der Gegner sieht Sieg und 'aufgegeben' – ohne Zeiten", va["gewinner"] == "ich" and va["gegner"]["aufgegeben"] is True and va["gegner"]["netto_sekunden"] is None, str(va["gegner"]))
check("Weiterspielen nach Aufgabe des Gegners: duell_nicht_laufend", fehler(a, "select duell_speichern(%s, %s, 0, 0)", (d, json({}))) == "duell_nicht_laufend")

# Frist: einer hat abgegeben
zuruecksetzen()
a, b = nutzer("anna"), nutzer("ben")
d, _ = neues_duell(a, b)
gestartet(d, a)
abgeben(d, a)
admin("update duelle set frist_am = now() - interval '1 minute' where id = %s", (d,))
ans = ok(b, "select duell_ergebnis(%s)", (d,))
check("Frist um, A abgegeben, B nicht -> A gewinnt (ende_grund frist)", ans["status"] == "beendet" and ans["ende_grund"] == "frist" and ans["gewinner"] == "gegner", str(ans))
check("B sieht dann A's Zeit", ans["gegner"]["netto_sekunden"] is not None)
check("Spätes Abgeben -> duell_nicht_laufend", fehler(b, "select duell_starten(%s)", (d,)) == "duell_nicht_laufend")
# Frist: keiner hat abgegeben
d2, _ = neues_duell(a, b)
admin("update duelle set frist_am = now() - interval '1 minute' where id = %s", (d2,))
lst = ok(a, "select duelle_liste()")
e = next(x for x in lst if x["id"] == d2)
check("Frist um, niemand abgegeben -> abgelaufen (ohne_ergebnis), kein Sieger", e["status"] == "abgelaufen" and e["ende_grund"] == "ohne_ergebnis" and e["gewinner"] is None, str(e))
# Frist: Einladung nicht angenommen
d3 = ok(a, "select duell_erstellen(null::smallint, null)")
admin("update duelle set frist_am = now() - interval '1 minute' where id = %s", (d3["duell_id"],))
check("Abgelaufene Einladung -> Beitritt liefert 'abgelaufen'", ok(b, "select duell_beitreten(%s)", (d3["code"],))["fehler"] == "abgelaufen")
lst = ok(a, "select duelle_liste()")
check("Abgelaufene Einladung erscheint als abgelaufen (nicht_beigetreten)", next(x for x in lst if x["id"] == d3["duell_id"])["ende_grund"] == "nicht_beigetreten")
# Frist während des Spielens: Speichern nach Fristende
d4, _ = neues_duell(a, b)
gestartet(d4, b)
admin("update duelle set frist_am = now() - interval '1 minute' where id = %s", (d4,))
check("Speichern nach Fristende -> duell_nicht_laufend", fehler(b, "select duell_speichern(%s, %s, 0, 0)", (d4, json({}))) == "duell_nicht_laufend")

# ---------------------------------------------------------------------------------------------------------------
print("\n[9] Revanche, Zurückziehen, Liste")
zuruecksetzen()
a, b, c = nutzer("anna"), nutzer("ben"), nutzer("cleo")
d, _ = neues_duell(a, b)
check("Revanche bei laufendem Duell -> duell_nicht_beendet", fehler(a, "select duell_revanche(%s)", (d,)) == "duell_nicht_beendet")
check("Revanche für Fremde -> duell_unbekannt", fehler(c, "select duell_revanche(%s)", (d,)) == "duell_unbekannt")
gestartet(d, a), gestartet(d, b)
abgeben(d, a), abgeben(d, b)
alt_raetsel = admin("select raetsel_id from duelle where id = %s", (d,), fetch=True)[0][0]
r = ok(b, "select duell_revanche(%s)", (d,))
check("Revanche klappt", r["ok"] and r["duell_id"] != d, str(r))
neu = admin("select status, ersteller_id::text, gegner_id::text, raetsel_id, revanche_von from duelle where id = %s", (r["duell_id"],), fetch=True)[0]
check("Revanche: laufend, Ersteller = Anfragender (B), Gegner = A", neu[0] == "laufend" and neu[1] == b and neu[2] == a and neu[4] == d, str(neu))
check("Revanche: neues Rätsel", neu[3] != alt_raetsel)
check("Revanche: beide haben eine Teilnahme-Zeile", admin("select count(*) from duell_teilnahme where duell_id = %s", (r["duell_id"],), fetch=True)[0][0] == 2)
check("Revanche ist idempotent (auch für den Gegner)", ok(a, "select duell_revanche(%s)", (d,)) == r and ok(b, "select duell_revanche(%s)", (d,)) == r)
check("Nur eine Revanche je Duell in der Datenbank", admin("select count(*) from duelle where revanche_von = %s", (d,), fetch=True)[0][0] == 1)
lst = ok(a, "select duelle_liste()")
alt_eintrag = next(x for x in lst if x["id"] == d)
neu_eintrag = next(x for x in lst if x["id"] == r["duell_id"])
check("Liste: altes Duell verweist auf die Revanche", alt_eintrag["revanche_id"] == r["duell_id"] and neu_eintrag["revanche"] is True)
check("Liste: A sieht B als Gegner", neu_eintrag["gegner_name"] == "Ben" and alt_eintrag["gegner_name"] == "Ben")
check("Liste: laufendes Duell zeigt kein Ergebnis und keinen Code", neu_eintrag["gewinner"] is None and neu_eintrag["code"] is None and neu_eintrag["mein_zustand"] == "nicht_gestartet")
check("Liste: Rätselinfo vorhanden", set(neu_eintrag["raetsel"]) == {"titel", "zeilen", "spalten", "schwierigkeit"})
check("Liste: abgeschlossenes Duell zeigt Sieger und eigene Zeit", alt_eintrag["gewinner"] in ("ich", "gegner", "unentschieden") and alt_eintrag["meine_netto_sekunden"] is not None)

off = ok(a, "select duell_erstellen(null::smallint, null)")
lst = ok(a, "select duelle_liste()")
check("Liste: offenes Duell zeigt den Code dem Ersteller", next(x for x in lst if x["id"] == off["duell_id"])["code"] == off["code"])
check("Zurückziehen durch Nicht-Ersteller nicht möglich", fehler(b, "select duell_zurueckziehen(%s)", (off["duell_id"],)) == "duell_unbekannt")
ok(a, "select duell_zurueckziehen(%s)", (off["duell_id"],))
check("Zurückziehen löscht das offene Duell", admin("select count(*) from duelle where id = %s", (off["duell_id"],), fetch=True)[0][0] == 0)
check("Laufendes Duell nicht zurückziehbar", fehler(a, "select duell_zurueckziehen(%s)", (r["duell_id"],)) == "duell_nicht_offen")

# ---------------------------------------------------------------------------------------------------------------
print("\n[10] Lösungsprüfung für alle 78 Rätsel")
fehl = []
for rid in alle:
    sol = loesung(rid)
    if not admin("select _duell_loesung_ok(%s, %s)", (rid, json(sol)), fetch=True)[0][0]:
        fehl.append(("richtig abgelehnt", rid))
    k = sorted(sol)[len(sol) // 2]
    mut = dict(sol)
    mut[k] = "Q" if sol[k] != "Q" else "X"
    if admin("select _duell_loesung_ok(%s, %s)", (rid, json(mut)), fetch=True)[0][0]:
        fehl.append(("falsch akzeptiert", rid))
    mut = dict(sol)
    del mut[k]
    if admin("select _duell_loesung_ok(%s, %s)", (rid, json(mut)), fetch=True)[0][0]:
        fehl.append(("Lücke akzeptiert", rid))
check("Alle 78 Rätsel: richtige Lösung ok, falsche/lückenhafte abgelehnt", not fehl, str(fehl[:5]))
umlaute = [rid for rid in alle if any(ch in "ÄÖÜ" for ch in "".join(loesung(rid).values()))]
check("Lösungswörter enthalten keine Umlaute (sie stehen als AE/OE/UE in der Datenbank)", not umlaute, str(umlaute[:5]))
check("upper() behandelt Ä/Ö/Ü korrekt (falls später Wörter mit Umlauten kommen)", admin("select upper('äöü')", fetch=True)[0][0] == "ÄÖÜ")
check("Rätsel ohne Einträge gilt nie als gelöst", admin("select _duell_loesung_ok(-1, '{}'::jsonb)", fetch=True)[0][0] is False)

# ---------------------------------------------------------------------------------------------------------------
print("\n[11] Gleichzeitige Abgabe (Sperren)")
zuruecksetzen()
a, b = nutzer("anna"), nutzer("ben")
d, _ = neues_duell(a, b)
gestartet(d, a), gestartet(d, b)
sol = loesung(admin("select raetsel_id from duelle where id = %s", (d,), fetch=True)[0][0])
c1 = psycopg2.connect(DSN)
cur1 = c1.cursor()
cur1.execute("set local role authenticated")
cur1.execute("select set_config('request.jwt.claim.sub', %s, true)", (a,))
cur1.execute("select duell_abgeben(%s, %s, 0, 0)", (d, json(sol)))     # hält die Sperre, noch nicht committed
ausgang = {}


def zweiter():
    ausgang["b"] = rpc(b, "select duell_abgeben(%s, %s, 0, 0)", (d, json(sol)))


t = threading.Thread(target=zweiter)
t.start()
time.sleep(0.6)
check("Zweite Abgabe wartet auf die Sperre", t.is_alive())
c1.commit()
c1.close()
t.join(10)
z = admin("select status, ende_grund, gewinner_id is not null from duelle where id = %s", (d,), fetch=True)[0]
check("Nach gleichzeitiger Abgabe ist das Duell genau einmal entschieden", ausgang["b"][0] == "ok" and z[0] == "beendet" and z[1] == "zeit", f"{ausgang} {z}")

print("\n[12] Datenschutz: Konto löschen")
zuruecksetzen()
a, b, c = nutzer("anna"), nutzer("ben"), nutzer("cleo")
d1, _ = neues_duell(a, b)
d2, _ = neues_duell(a, c)
admin("delete from auth.users where id = %s", (b,))
rest = [r[0] for r in admin("select id from duelle", fetch=True)]
check("Duelle des gelöschten Kontos sind weg, andere bleiben", rest == [d2], str(rest))
check("Teilnahme- und Profilzeilen des gelöschten Kontos sind weg",
      admin("select count(*) from duell_teilnahme where nutzer_id = %s", (b,), fetch=True)[0][0] == 0
      and admin("select count(*) from profile where nutzer_id = %s", (b,), fetch=True)[0][0] == 0)

# ---------------------------------------------------------------------------------------------------------------
zuruecksetzen()
fehlgeschlagen = [n for n, ok_, _ in ergebnisse if not ok_]
print(f"\n{len(ergebnisse) - len(fehlgeschlagen)}/{len(ergebnisse)} Prüfungen bestanden")
if fehlgeschlagen:
    print("Fehlgeschlagen:")
    for n in fehlgeschlagen:
        print("  -", n)
    sys.exit(1)
