# Lexika

`en_US.words.txt` — englische Basisformen (nur Kleinbuchstaben-Eintraege, ohne Eigennamen), extrahiert aus dem
Hunspell-Woerterbuch `en_US` (Debian-Paket `hunspell-en-us`, SCOWL).
Verwendet nur fuer die Regel `fremd_englisch` in `build_wordlist.py`.

SCOWL: Copyright 2000-2011 Kevin Atkinson. Permission to use, copy, modify, distribute and sell these word lists,
the associated scripts, the output created from the scripts, and its documentation for any purpose is hereby granted
without fee, provided that the above copyright notice appears in all copies and that both that copyright notice
and this permission notice appear in supporting documentation. (Volltext: /usr/share/doc/hunspell-en-us/copyright)

Neu erzeugen: siehe `make_en_lexicon.py` (liest /usr/share/hunspell/en_US.dic).
