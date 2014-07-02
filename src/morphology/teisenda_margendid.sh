#!/bin/bash
# teisenda Plamki märgendid Giellatekno omadeks
# kataloogis
# ~/giellatekno/main/langs/est/src/morphology
# puudutab faile root.lexc ja affixes/cmd-rules.lexc
# sisend: root.lexc
#         affixes/cmd-rules.lexc
#         tag_conv1              <- kõik märgendivastavused, v.a. verbikategooriad
#         root.lexc.hjk2         <- verbikategooriate võimalikud kombinatsioonid
# abifailid:
#         tag_conv1.sh           <- märgendite teisendamise skript
#         root.lexc.jaak[123]    <- root.lexc 3 tükki, millest 1. ja 3. saab tag_conv1.sh abil teisendada
#                                   aga 2. tuleb lihtsalt minema visata
#         tag_conv2.sh           <- skript, mis teisendab verbikat-te pikad versioonid lühikesteks
#         verb_cat_combinations.tmp1  <- verbikat-d lühikeses, GT versioonis
#         tag_conv3.sh           <- skript, mis teisendab affixes/cmd-rules.lexc 
#                                   verbikat-te jorud GT versioonideks
# väljund:
#          root.lexc.hjk1
#          root.lexc.hjk3
#          cmd-rules.lexc.hjk    <- nagu cmd-rules.lexc, aga GT verbikat-te jorud on lisatud @-märkide vahele
#                                   nii et nad saaks lihtsa sed-iga panna plamki jorude asemele
#                                   (aga seda pole tehtud, sest kat-te teistsuguse tõlgenduse tõttu
#                                   peaks ikka inimene tulemuse vahepeal üle vaatama) 
#                                   NB! üksikud kategooriad on kõik teisendamata, sest siin on ühes failis
#                                   koos verbi ja noomeni jm asjad, kus mõnikord üks on teise alamstring...
#                                   arvatavasti peaks algse faili tükeldama nagu root.lexc ja seejärel 
#                                   üksikuid osi teisendama...

# verbikategooriate teisendamine on keeruline, mistõttu 
# selle asemel tuleb omatehtud tekstijupp root.lexc.hjk2 root.lexc-sse lihtsalt sealse asemele panna, s.t. 
# tagasi kokku panekuks tee:
# cat root.lexc.hjk1 root.lexc.hjk2 root.lexc.hjk3 > root.lexc

cat tag_conv1 | tr '\t' ' ' | tr -s ' ' \
| sed 's/ $//' \
| sed "s/^\([^ ]*\) \(.*\)$/\| sed 's#\1#\2#' /" \
| sed 's/$/\\/' \
| sed '1s/^| //' \
> tag_conv1.sh

chmod 0755 tag_conv1.sh

# tee root.lexc kolmeks tükiks
# 1. ja 3. tükk teisenda
# 2. tükk (verbikategooriad) asenda enda omaga root.lexc.hjk2

cat root.lexc \
| sed '/^! verb/,$d' \
> root.lexc.jaak1

cat root.lexc \
| sed '1,/+super/d' \
| sed '/^! ainult liitsõna osadena/,$d' \
> root.lexc.jaak2

cat root.lexc \
| sed '1,/^! +partic+past+imps -- impersonal past particle/d' \
> root.lexc.jaak3


cat root.lexc.jaak1 \
| ./tag_conv1.sh \
> root.lexc.hjk1

cat root.lexc.jaak3 \
| ./tag_conv1.sh \
> root.lexc.hjk3

# verbikategooriate teisendamise skript tee failist root.lexc.hjk2
# s.t. tee uus teisendus Viksi stiilis formatiividest gramm. kategooriate kombinatsioonideks

# algul tekita teisendusskript pikkade terminite teisendamiseks lühikesteks:
# võta kõik read, millel on kategooria
# eemalda sealt see, mida pole vaja
# muuda tulemus sed'i failiks

cat root.lexc.hjk2 \
| grep '^+' \
| grep -v '[123]' \
| tr '\t' ' ' | tr -s ' ' \
| sed 's/![^!]*!/@/' \
| sed 's/$/ /' \
| sed "s/^\([^ ]*\) @ \([^ ]*\) .*$/| sed '#-#!s#\2#\1#' \\\/" \
| tr '#' '/' \
| sed '1s/|//' \
> tag_conv2.sh 

chmod 0755 tag_conv2.sh

# teisenda kombinatsioonide kirjeldus teisenduse skriptiks

# esiteks pikad terminid lühikesteks
cat root.lexc.hjk2 \
| sed '1,/personal finite forms ---/d' \
| sed '/Exceptional cases/,$d' \
| tr '\t' ' ' | tr -s ' ' \
| sed 's/,.*$//' \
| sed 's/ $//' \
| sed '/[^-]/s/ \([eäp][^ ]*\)$/@\1/' \
\
| ./tag_conv2.sh \
| sed 's/abessive/+Abe/' \
| sed 's/elative/+Ela/' \
| sed 's/illative/+Ill/' \
| sed 's/inessive/+Ine/' \
| sed 's/translative/+Tra/' \
\
| sed 's/ \([^ (]*[123]\) / +\1 /' \
> verb_cat_combinations.tmp1
 
# tee teisenduse sed-i skript
# aluseks on read, millel on näidiseks 'elama' vormid
# NB! vaata, et ei teisendaks valesti, nt da/ta puhul: ela+da, ei ela+ta, aga vaadel+da, ei vaadel+da
# selle vältimiseks lisa skripti lisatingimused
# (mis teisendamisel kontrollivad plamki failis olevaid gramm tähiseid)
# et ei tekitataks topelt teisendusi, nt ...sid puhul, lisa tingimused
# mõnede morfeemide (need, mis algavad g või t-ga) teisendused tuleb topeldada (g->k, t->d)
# pluss erisused: takse -> akse
# des -> tes , 0es
# si... -> i... , 0in
# s -> is, i
# v -> ev
# da (infinitiivina) -> ta, a
# :+ma..., :+v... (v.a. :+vad) asemel on plamkis ilma plussita :ma... ja :v..., need tuleb seega asendada

cat verb_cat_combinations.tmp1 \
| sed 's/^! //' \
| sed 's/([^)]*)//g' \
| tr -s ' ' \
| sed 's/ +/+/g' \
| sed 's/ @/@/' \
\
| grep '@ela' \
\
| sed 's/^\([^@]*\)@ela\(.*\)$/\2@\1/' \
| sed 's/^@/0@/' \
| sed "s/^\([^@]*\)@\(.*\)$/| sed 's#:+\1 #@\2@:+\1 #' \\\/" \
| sed '/+ta /s/s#/#+[Nn]eg#s#/' \
| sed '/+da /s/s#/#+[Ii]nf#s#/' \
| sed '/2/s/s#/#2#s#/' \
| sed '/Sg3/s/s#/#3+sg#s#/' \
| sed '/Pl3/s/s#/#3+pl#s#/' \
| sed '/+0.*Neg/s/s#/#+[Nn]eg#s#/' \
| sed '/+nud.*Prc/s/s#/#+partic#s#/' \
| tr '#' '/' \
| sed '1s/|//' \
\
| sed '/:+g/s/^\(.*\):+g\(.*\):+g\(.*\)$/&\n\1:+k\2:+k\3/' \
| sed '/:+t/s/^\(.*\):+t\(.*\):+t\(.*\)$/&\n\1:+d\2:+d\3/' \
| sed '/:+takse/s/^\(.*\):+t\(.*\):+t\(.*\)$/&\n\1:+\2:+\3/' \
| sed '/:+des/s/^\(.*\):+d\(.*\):+d\(.*\)$/&\n\1:+t\2:+t\3\n\1:+0\2:+0\3/' \
| sed '/:+si[dmt]/s/^\(.*\):+si\(.*\):+si\(.*\)$/&\n\1:+i\2:+i\3/' \
| sed '/:+sin/s/^\(.*\):+si\(.*\):+si\(.*\)$/&\n\1:+0i\2:+0i\3/' \
| sed '/:+s /s/^\(.*\):+s\(.*\):+s\(.*\)$/&\n\1:+is\2:+is\3\n\1:+i\2:+i\3/' \
| sed '/:+da .*Inf/s/^\(.*\):+da\(.*\):+da\(.*\)$/&\n\1:+ta\2:+ta\3\n\1:+a\2:+a\3/' \
| sed '/:+ma/s/^\(.*\):+ma\(.*\):+ma\(.*\)$/\1:ma\2:ma\3/' \
| sed '/:+vad/!s/^\(.*\):+v\(.*\):+v\(.*\)$/\1:v\2:v\3/' \
| sed '/:v /s/^\(.*\):v\(.*\):v\(.*\)$/&\n\1:ev\2:ev\3/' \
\
| LC_COLLATE=C sort \
> tag_conv3.sh 

chmod 0755 tag_conv3.sh

# teisenda veel üks plamki fail õigeks
# ... kusjuures tee tagantjärle parandusi
cat affixes/cmd-rules.lexc \
| ./tag_conv3.sh \
\
| sed 's/@@+Pers+Past+Imprt@:+nud/@:+nud/' \
> cmd-rules.lexc.hjk

exit


