#!/bin/sh
# otsi sõnu, mis on küll lühikesed, aga ikkagi sobivad liitsõnasse hästi

# vähenda alternatiivsete analüüside hulka
# kasutab sama ideed, mida korpuse ühestamine tekti konteksi põhjal 
# selles failis on 305145 eri sõna, kokku 340469 analüüsi; see võte vähendab analüüside arvu 3106 võrra 337363-ni
# rohkem kui 1 analüüs jääb 28997-le sõnale
# ~/svnkrpsoft/trunk/yhine/yhh-t3/yhh-t3-2-yhh-lem-1.sh alusel

post3-eeltootlus.sh < ~/svn-giellatekno/main/experiment-langs/est/test/tmp/korpustest-8-alakriips > tmp.eelt
post3-teeloend.sh   < tmp.eelt  > tmp.loend

post3-vali_sagedam_lemma.gawk tmp.loend tmp.eelt \
| post3-jareltootlus.sh > tmp.jarel

# eemalda mõned ilmselgelt valed variandid (441-st valest jääb järele 273)

cat tmp.jarel \
| sed '/_ihald.*i_hald/s/    [^ ]*_ihald[^\/]*\/\/[^\/]*\/\///' \
| sed '/_iva=lik.*i_valik/s/    [^ ]*_iva=lik[^\/]*\/\/[^\/]*\/\///' \
| sed '/+singi.*_sink/s/    [^ ]*_sink[^\/]*\/\/[^\/]*\/\///' \
| sed '/_ira=ja.*i_rada/s/    [^ ]*_ira=ja[^\/]*\/\/[^\/]*\/\///' \
| sed '/_ura=ja.*u_rada/s/    [^ ]*_ura=ja[^\/]*\/\/[^\/]*\/\///' \
| sed '/+tagi.*_tagi/s/    [^ ]*_tagi[^\/]*\/\/[^\/]*\/\///' \
| sed '/+detagi.*+de_tagi/s/    [^ ]*_tagi[^\/]*\/\/[^\/]*\/\///' \
| sed '/_tagi.*ta+gi/s/    [^ ]*_tagi[^\/]*\/\/[^\/]*\/\///' \
| sed '/+nagi.*_nagi/s/    [^ ]*_nagi[^\/]*\/\/[^\/]*\/\///' \
| sed '/_nagi.*+nagi/s/    [^ ]*_nagi[^\/]*\/\/[^\/]*\/\///' \
| sed '/+telgi.*_telk/s/    [^ ]*_telk[^\/]*\/\/[^\/]*\/\///' \
| sed '/+telgi.*_telg/s/    [^ ]*_telg[^\/]*\/\/[^\/]*\/\///' \
> tmp.jarel2

# meid huvitavad ainult esiosad, seega viska minema alternatiivanalüüs, millel on sama esiosa
# ... ja siis jäta välja ka need 298 sõna, millel on mitu analüüsi (sest pole teada, et millised esiosad on õigesti leitud)
cat tmp.jarel2 | sed 's/    \([^_ ]*\)\(_[^#]*\)    \1_/    \1_/' | grep -v '    .*    ' \
| grep -v '    [^_]* \/\/_' | sed 's/^[^ ]*    \([^ ]*\)+[^ +]* \/\/.*$/\1/' | grep -v '\/' | sort -u \
| sed 's/_.*$//' | sort | uniq -c | sort -nr | etana | sed '/^[1234567890]/s/$/@/g' | tr '\n' '@' | sed 's/@@/ /g' | tr '@' '\n' > korpusest_esiosad

# need on N sg n, mis esinevad liitsõnade esiosana
# arvesta ainult sagedasemaid, sest harvemate puhul võib tegu olla veaga või leksikaliseerunud sõnadega... 
cat korpusest_esiosad | grep '_S_ [^,]*sg n' | grep -v 'sg g' \
| grep -v '^[123] ' \
| sed 's/^[^\/]*\/\/_N_[^\/]*\/\/ //' | sed 's/    .*$//' \
| grep -v '^aar$' \
| grep -v '^alk$' \
| grep -v '^lood$' \
| grep -v '^pau$' \
| grep -v '^und$' \
| LC_COLLATE=C sort -u > head_esiosad

exit

# need on 3 või 4 tähelised N sg n, mis esinevad liitsõnade esiosana
# arvesta ainult sagedasemaid, sest harvemate puhul võib tegu olla veaga või leksikaliseerunud sõnadega... 
cat korpusest_esiosad | grep '_S_ [^,]*sg n' | grep -v 'sg g' | sed 's/[^ ][^ ][^ ][^ ][^ ]    /&@/' | grep -v '@' \
| grep -v '^[123456789] ' \
| sed 's/^[^\/]*\/\/_N_[^\/]*\/\/ //' | sed 's/    .*$//' | LC_COLLATE=C sort -u > head_esiosad

exit

# kirjuta iga kirje taha see inf, mis fs_lex-sist tuleb
cat fs_gt.inflecting.tmp1 | grep '+N:' \
| sed 's/^\(WDEVERBAL\)\(.*\)$/\2\1/' \
| sed 's/^\(mnocompound\)\(.*\)$/\2\1/' \
| sed 's/^\(nnolastpart\)\(.*\)$/\2\1/' \
| LC_COLLATE=C sort > fs_gt.inflecting.tmp1.srt

# ja lisa siia märge nende lühikeste nimisõnade kohta, mis ei osale liitsõnades
LC_COLLATE=C join -t+ -a 1 -a 2 -o 1.1 2.1 2.2 head_esiosad fs_gt.inflecting.tmp1.srt | sed '/^+...+N/s/$/pahaesi/' | sed '/^+....+N/s/$/pahaesi/' > fs_gt.inflecting.tmp1.tagged

# tulemuseks on, et ühel sõnal võib olla mitu märget, s.t. sõnavara ei jagune ilusti alamleksikonideks

exit

cat ~/svn-giellatekno/main/experiment-langs/est/test/tmp/korpustest-8-alakriips | grep -v '    [^_]* \/\/_' | sed 's/    /\n/g' | grep '\/\/' | sed 's/_[^_]* \/\/_.*$//' | sort | uniq -c | sort -nr | etana | sed '/^[1234567890]/s/$/@/g' | tr '\n' '@' | sed 's/@@/ /g' | tr '@' '\n' > korpusest_esiosad

cat ~/svn-giellatekno/main/experiment-langs/est/test/tmp/korpustest-8-alakriips | grep -v '    [^_]* \/\/_' | sed 's/    /\n/g' | grep '\/\/' | sed 's/_[^_]* \/\/_.*$//' | tr '_' '\n' | sort | uniq -c | sort -nr | etana | sed '/^[1234567890]/s/$/@/g' | tr '\n' '@' | sed 's/@@/ /g' | tr '@' '\n' > korpusest_mitte_viimased_osad

cat korpusest_esiosad | grep '_S_ [^,]*sg n' | grep -v 'sg g' | sed 's/[^ ][^ ][^ ][^ ][^ ]    /&@/' | grep -v '@' | grep -v '^[123456789] ' | sed 's/^[^\/]*\/\/_N_[^\/]*\/\/ //' | sed 's/    .*$//' | LC_COLLATE=C sort > head_esiosad

cat fs_gt.inflecting.tmp1 | grep '+N:' | grep 'nnolastpart' | sed 's/nnolastpart//' | sed 's/+.*$//' | LC_COLLATE=C sort -u > pahad_tagaosad

cat head_esiosad pahad_tagaosad | LC_COLLATE=C sort | LC_COLLATE=C uniq -c | grep -v ' 1 ' | sed 's/^.* [23456789] //' > hea_esi_paha_taga
 
cat fs_gt.inflecting.tmp1 | grep '+N:' | grep 'mnocompound' | sed 's/mnocompound//' | sed 's/+.*$//' | LC_COLLATE=C sort -u > pahad_osad

cat fs_gt.inflecting.tmp1 | grep '+N:' \
| grep -v 'WDEVERBAL' \
| grep -v 'mnocompound' \
| grep -v 'nnolastpart' \
| grep '\(^[^+][^+][^+]+\)\|\(^[^+][^+][^+][^+]+\)' | sed 's/+/ +/' | LC_COLLATE=C sort > lyhikesed



LC_COLLATE=C join -a 1 -a 2 -o 1.1 2.1 2.2 head_esiosad lyhikesed | grep -v '^\([^ ]*\) \1 ' | grep '+N' | sed 's/^ //' | sed 's/ +/+/' > pahad_lyhikesed

LC_COLLATE=C join -a 1 -a 2 -o 1.1 2.1 2.2 head_esiosad lyhikesed | grep '^\([^ ]*\) \1 ' | sed 's/^[^ ]* //' | sed 's/ +/+/' > head_lyhikesed

exit

# 
cat ~/svn-giellatekno/main/experiment-langs/est/test/tmp/korpustest-8-alakriips | grep -v '    [^_]* \/\/_'
