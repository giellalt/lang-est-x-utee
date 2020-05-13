#!/bin/sh
# 
# palageo_ok, palanim_ok, voorad_ok, voorad_xp on 
# algselt Filosofti sõnastiku failid, mis on teisendatud fs_lex-iks,
# aga neis on mingil moel info nime liigi kohta: G - kohanimi, N - isikunimi, O - muu nimi

cat palageo_ok \
| grep '\\H' \
| sed 's/!/ !/' \
| sed 's/ .*$/+N+Prop/' \
| sed 's/[><_?]//g' \
| sed 's/]//g' \
| sed 's/\[//g' \
| sed 's/’+/+/' \
| sed 's/$/ G/' \
| sed 's/^[^|]*|//' \
| sed 's/K<ohtla-Nõmme/& /' \
> names.tmp

cat palanim_ok \
| grep '\\H' \
| sed 's/!/ !/' \
| sed 's/ .*$/+N+Prop/' \
| sed 's/[><_?]//g' \
| sed 's/]//g' \
| sed 's/\[//g' \
| sed 's/’+/+/' \
| sed 's/$/ N/' \
| sed 's/^[^|]*|//' \
>> names.tmp

cat voorad_ok \
| grep '\\H' \
| sed 's/!/ !/' \
| sed 's/ .*$/+N+Prop/' \
| sed 's/[><_?]//g' \
| sed 's/]//g' \
| sed 's/\[//g' \
| sed 's/’+/+/' \
| sed '/^[^|]*G|/s/$/ G/' \
| sed '/^[^|]*N|/s/$/ N/' \
| sed '/^[^|]*M|/s/$/ O/' \
| sed 's/^[^|]*|//' \
>> names.tmp

cat voorad_xp \
| grep '\\H' \
| sed 's/!/ !/' \
| sed 's/ .*$/+N+Prop/' \
| sed 's/[><_?]//g' \
| sed 's/]//g' \
| sed 's/\[//g' \
| sed 's/’+/+/' \
| sed 's/$/ O/' \
| sed 's/^[^|]*|//' \
| sed '/Baldwin+/s/ O/ N/' \
| sed '/Giovanni+/s/ O/ N/' \
| sed '/Nicolaus+/s/ O/ N/' \
| sed '/Toulouse+/s/ O/ G/' \
| sed '/Tycho+/s/ O/ N/' \
| sed '/Brahe+/s/ O/ N/' \
>> names.tmp

cat names.tmp | sort -u \
| grep -v 'Christopher+N+Prop [OG]' \
| grep -v 'Joseph+N+Prop [OG]' \
| sed 's/Komoor+/Komoorid+/' \
| sed 's/Hašimiid+/Hašimiidid+/' \
| sed 's/Maldiiv+/Maldiivid+/' \
| sed 's/Malviin+/Malviinid+/' \
| sed 's/Myrtoon+/Myrtoonid+/' \
| sed 's/Seišell+/Seišellid+/' \
| sed 's/Türreen+/Türreenid+/' \
| sed 's/ /_/' \
| LC_COLLATE=C sort \
> names.tmp1

exit





