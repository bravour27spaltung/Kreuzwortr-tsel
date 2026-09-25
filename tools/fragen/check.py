"""Formale Prüfung der Fragen (Phase 4).
Aufruf: python3 check.py clues/b01.txt [...]
Prüft je Zeile 'schreibweise|frage' (frage '-' = bewusst übersprungen):
  E1 Wort nicht im Batch / doppelt / fehlt
  E2 Frage leer
  E3 Frage > 22 Zeichen oder > 3 Wörter (Kürze-Regel)
  E4 Lösung steckt in der Frage (gemeinsame Buchstabenfolge >= 4, bei kurzen Lösungen die ganze Lösung)
  W1 Einzelwort in der Frage > 12 Zeichen (Lesbarkeit im Feld)
  W2 dieselbe Frage bei > 8 Lösungen (zu unspezifisch)
"""
import sys, re, json, collections

def norm(s):
    s = s.upper()
    for a, b in (("Ä", "AE"), ("Ö", "OE"), ("Ü", "UE"), ("ß", "SS")):
        s = s.replace(a, b)
    return re.sub(r"[^A-Z]", "", s)

def common_run(a, b):
    best = 0
    for i in range(len(a)):
        for j in range(len(b)):
            k = 0
            while i + k < len(a) and j + k < len(b) and a[i + k] == b[j + k]:
                k += 1
            best = max(best, k)
    return best

SUFFIXES = ("ERINNEN", "ERIN", "EREI", "ISCH", "IERTEN", "IERTE", "IERT", "IEREN", "LICHEN", "LICHE", "LICH", "ISCHE", "ISCHEN", "SCHE", "KEIT", "HEIT", "UNGEN", "UNG")
import os
OVERRIDE = set(l.split("#")[0].strip() for l in open(os.path.join(os.path.dirname(os.path.abspath(__file__)), "overrides.txt"), encoding="utf-8")) if os.path.exists(os.path.join(os.path.dirname(os.path.abspath(__file__)), "overrides.txt")) else set()

def stem_hit(a, clue):
    """True, wenn die Lösung (bzw. ihr Stamm) in der Frage steckt."""
    toks = [norm(t) for t in re.split(r"[\s,;/()-]+", clue) if norm(t)]
    if len(a) <= 3:
        # kurze Lösung: nur als ganzes Wort, Wortanfang oder Wortende auffällig
        return any(t == a or t.startswith(a) or t.endswith(a) for t in toks)
    core = a
    for suf in SUFFIXES:
        if a.endswith(suf) and len(a) - len(suf) >= 3:
            core = a[: -len(suf)]
            break
    def strip_end(x):
        for e in ("EN", "EM", "ER", "ES", "E", "N", "S"):
            if x.endswith(e) and len(x) - len(e) >= 3:
                return x[: -len(e)]
        return x
    core = strip_end(core)
    need = min(4, len(core))
    return any(common_run(core, strip_end(t)) >= need for t in toks)

def check_file(path, batch_words):
    errs, warns, seen, data = [], [], set(), []
    for n, line in enumerate(open(path, encoding="utf-8"), 1):
        line = line.rstrip("\n")
        if not line.strip():
            continue
        if "|" not in line:
            errs.append(f"{n}: kein Trenner: {line}"); continue
        w, c = line.split("|", 1)
        w, c = w.strip(), c.strip()
        if w not in batch_words:
            errs.append(f"E1 {w}: nicht im Batch")
        if w in seen:
            errs.append(f"E1 {w}: doppelt")
        seen.add(w)
        if not c:
            errs.append(f"E2 {w}: leer"); continue
        if c == "-":
            data.append((w, None)); continue
        words = [x for x in re.split(r"[\s]+", c) if x]
        if len(c) > 22 or len(words) > 3:
            errs.append(f"E3 {w}: zu lang ({len(c)} Z., {len(words)} W.): {c}")
        a, q = norm(w), norm(c)
        if w not in OVERRIDE and stem_hit(a, c):
            errs.append(f"E4 {w}: Lösung/Stamm in Frage: {c}")
        for x in words:
            if len(re.sub(r"[^\wÄÖÜäöüß]", "", x)) > 12:
                warns.append(f"W1 {w}: langes Wort '{x}'")
        data.append((w, c))
    missing = [w for w in batch_words if w not in seen]
    for w in missing:
        errs.append(f"E1 {w}: fehlt")
    return errs, warns, data

if __name__ == "__main__":
    allc = collections.defaultdict(list)
    tot_e = tot_w = 0
    for p in sys.argv[1:]:
        b = p.replace("clues/", "batches/")
        words = open(b, encoding="utf-8").read().split()
        errs, warns, data = check_file(p, words)
        for w, c in data:
            if c: allc[c].append(w)
        print(f"== {p}: {len(data)} Einträge, {sum(1 for _,c in data if c is None)} übersprungen, {len(errs)} Fehler, {len(warns)} Warnungen")
        for e in errs + warns:
            print("  ", e)
        tot_e += len(errs); tot_w += len(warns)
    for c, ws in sorted(allc.items(), key=lambda x: -len(x[1])):
        if len(ws) > 8:
            print(f"W2 '{c}' bei {len(ws)} Lösungen: {' '.join(ws[:12])}")
    sys.exit(1 if tot_e else 0)
