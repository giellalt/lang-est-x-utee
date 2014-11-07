#!/bin/sh
# verbivormistiku tõlkimine eesti -> soome # translate verb paradigm Estonian -> Finnish
# märgenditeisendused # tag conversion

# terve märgendikombinatsioon eesti -> soome # the whole gram comb Estonian -> Finnish
# vt. 1. teisenduste blokk # see the 1st block of conversions

# lihtsalt teine tähis:   # simply another tag, same meaning: 
# vt 2. teisenduste blokk # see the 2nd block of conversions

# eestis on aeg enne kõneviisi, soomes vastupidi
# in Estonian, tense before mood, in Finnish, mood before tense
# | sed 's/+\(Prs\)+\([^+]*\)/+\2+\1/' \
# | sed 's/+\(Prt\)+\([^+]*\)/+\2+\1/' \

# soome ei märgi jaatust # Finnish does not tag Affirmative
# | sed 's/+Aff//' \

# soomes pole tingival ega käskival kv. aega # Finnish has no tense for Cond and Imprt
# | sed 's/+Cond+Prs/+Cond/' \
# | sed 's/+Imprt+Prs/+Imprt/' \

# soomes on tingival ja käskival kv. 3. isik (eestis on vastav vorm alaspetsif.)
# ei oska otsustada, mida teha...
# Finnish has a form for Cond+Sg3 and Imprt+Sg3, Estonian is underspecified; don't know how to deal with it

# Finnish has some weird combinations... 
# ei naera (ei naura) soomes pole aktiivi märgendit...
# soomes on mõnikord Pass asemel Pss...

 sed 's/+V+Inf/+V+Act+InfA+Sg+Lat/' \
| sed 's/+V+Ger/+V+Act+InfE+Sg+Ine/' \
| sed 's/+V+Pers+Sup+Ill/+V+Act+InfMa+Sg+Ill/' \
| sed 's/+V+Pers+Sup+Ine/+V+Act+InfMa+Sg+Ine/' \
| sed 's/+V+Pers+Sup+Ela/+V+Act+InfMa+Sg+Ela/' \
| sed 's/+V+Pers+Sup+Tra/+V+Act+InfMa+Sg+Ill/' \
| sed 's/+V+Pers+Sup+Abe/+V+Act+InfMa+Sg+Abe/' \
| sed 's/+V+Impers+Sup/+V+Pss+InfMa+Sg+Ins/' \
| sed 's/+V+Pers+Prs+Prc/+V+Act+PrsPrc+Sg+Nom/' \
| sed 's/+V+Pers+Past+Prc/+V+Act+PrfPrc+Sg+Nom/' \
| sed 's/+V+Impers+Prs+Prc/+V+Pss+PrsPrc+Sg+Nom/' \
| sed 's/+V+Impers+Past+Prc/+V+Pass+PrfPrc+Sg+Nom/' \
| sed 's/+V+Impers+Prs+Ind+Aff/+V+Pass+Ind+Pr_s+Pe4/' \
| sed 's/+V+Impers+Past+Ind+Aff/+V+Pass+Ind+Pr_t+Pe4/' \
\
| sed 's/+Pers/+Act/' \
| sed 's/+Impers/+Pass/' \
| sed 's/+Past/+Prt/' \
| sed 's/+Neg/+ConNeg/' \
\
| sed 's/+\(Prs\)+\([^+]*\)/+\2+\1/' \
| sed 's/+\(Prt\)+\([^+]*\)/+\2+\1/' \
| sed 's/+Aff//' \
| sed 's/+Cond+Prs/+Cond/' \
| sed 's/+Imprt+Prs/+Imprt/' \
\
| sed 's/+V+Act+Ind+Prs+ConNeg/+V+Ind+Prs+ConNeg/' \
| sed 's/+V+Pass+PrfPrc+Sg+Nom/+V+Pss+PrfPrc+Sg+Nom/' \
| sed 's/+V+Pass+Ind+Prt+ConNeg/+V+Pss+Ind+Prt+ConNeg/' \
| sed 's/+V+Pass+Ind+Pr_t+Pe4/+V+Pss+Ind+Prt+Pe4/' \
| sed 's/+V+Pass+Ind+Pr_s+Pe4/+V+Pss+Ind+Prs+Pe4/' \
| sed 's/+V+Pass+Ind+Prs+ConNeg/+V+Pss+Ind+Prs+Pe4+ConNeg/' \
| sed 's/+V+Pass+Imprt/+V+Pss+Imprt+Pe4/' \
| sed '/Prt/!s/+V+Pass+Cond/+V+Pss+Cond+Pe4/' \
\

exit

# usage example
# translate kuduma -> kutoa (knit)
# will succeed for 40 paradigm cells
# will fail for 13 cells - no Finnish one-word translation

echo 'k u d u m a "+V" [ ? - [ "#" | "+Der/nu" ] ] *' \
|   hfst-regexp2fst \
|   hfst-compose -F -2 - -1 ~/svn-giellatekno/main/langs/est/src/analyser-gt-norm.hfst \
|   hfst-project -p lower \
|   hfst-fst2strings \
|   sort -u \
\
| sed 's/^kuduma/kutoa/' \
\
| ./V_est_2_fin_tag.sh \
\
|   hfst-lookup -q ~/svn-giellatekno/main/langs/fin/src/generator-gt-desc.hfstol \
|   grep -v ^$ \



