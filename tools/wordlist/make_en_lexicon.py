#!/usr/bin/env python3
"""Erzeugt lexika/en_US.words.txt aus dem Hunspell-Woerterbuch (nur Kleinbuchstaben-Basisformen, >= 3 Zeichen)."""
import sys
src = sys.argv[1] if len(sys.argv) > 1 else '/usr/share/hunspell/en_US.dic'
base = set()
for l in open(src, encoding='utf-8', errors='ignore').read().split('\n')[1:]:
    w = l.split('/')[0].strip()
    if w and w.isalpha() and w.isascii() and w.islower() and len(w) >= 3:
        base.add(w)
open('lexika/en_US.words.txt', 'w').write('\n'.join(sorted(base)) + '\n')
print(len(base), 'Woerter')
