#!/bin/sh
# verbivormistiku tõlkimine eesti -> soome # translate verb paradigm Estonian -> Finnish
# märgenditeisendused # tag conversion

# terve märgendikombinatsioon eesti -> soome # the whole gram comb Estonian -> Finnish
# vt. 1. teisenduste blokk # see the 1st block of conversions


# soomes on tingival ja käskival kv. 3. isik (eestis on vastav vorm alaspetsif.)
# ei oska otsustada, mida teha...
# Finnish has a form for Cond+Sg3 and Imprt+Sg3, Estonian is underspecified; don't know how to deal with it

`# kudunuksin -> oleksin kudunud` \
 `#sed '/+V+Pers+Prt+Cond/s/^\(.*\)+V+Pers+Prt+Cond\(.*\)$/olla+V+Pers+Prs+Cond\2\n#\n\1+V+Pers+Prt+Prc/' ` \
\
 sed 's/+V+Inf/+V+Act+InfA+Sg+Lat/' \
| sed 's/+V+Ger/+V+Act+InfE+Sg+Ine/' \
| sed 's/+V+Pers+Sup+Ill/+V+Act+InfMa+Sg+Ill/' \
| sed 's/+V+Pers+Sup+Ine/+V+Act+InfMa+Sg+Ine/' \
| sed 's/+V+Pers+Sup+Ela/+V+Act+InfMa+Sg+Ela/' \
| sed 's/+V+Pers+Sup+Tra/+V+Act+InfMa+Sg+Ill/' `# soomes pole maks-vormi # Finnish does not have this translative form` \
| sed 's/+V+Pers+Sup+Abe/+V+Act+InfMa+Sg+Abe/' \
| sed 's/+V+Impers+Sup/+V+Pss+InfMa+Sg+Ins/' \
| sed 's/+V+Pers+Prs+Prc/+V+Act+PrsPrc+Sg+Nom/' \
| sed 's/+V+Pers+Prt+Prc/+V+Act+PrfPrc+Sg+Nom/' \
| sed 's/+V+Impers+Prs+Prc/+V+Pss+PrsPrc+Sg+Nom/' \
| sed 's/+V+Impers+Prt+Prc/+V+Pass+PrfPrc+Sg+Nom/' \
| sed 's/+V+Impers+Prs+Ind+Aff/+V+Pass+Ind+Pr_s+Pe4/' `# Pr_s Prs asemel, et skript töötaks # Pr_s instead of Prs so the script runs properly` \
| sed 's/+V+Impers+Prt+Ind+Aff/+V+Pass+Ind+Pr_t+Pe4/' `# Pr_t Prt asemel, et skript töötaks # Pr_t instead of Prt so the script runs properly` \
\
`# lihtsalt teine tähis   # simply another tag, same meaning` \
| sed 's/+Pers/+Act/' \
| sed 's/+Impers/+Pass/' \
| sed 's/+Neg/+ConNeg/' \
\
`# eestis on aeg enne kõneviisi, soomes vastupidi` \
`# Estonian tense before mood;  Finnish mood before tense` \
| sed 's/+\(Prs\)+\([^+]*\)/+\2+\1/' \
| sed 's/+\(Prt\)+\([^+]*\)/+\2+\1/' \
\
| sed 's/+Aff//' `# soome ei märgi jaatust # Finnish does not tag Affirmative` \
| sed 's/+Cond+Prs/+Cond/' `# soomes pole tingival kv. aega # Finnish Cond has no tense ` \
| sed 's/+Imprt+Prs/+Imprt/' `# soomes pole käskival kv. aega # Finnish Imprt has no tense ` \
\
`# Finnish has some weird combinations...` \
| sed 's/+V+Act+Ind+Prs+ConNeg/+V+Ind+Prs+ConNeg/' `# ei naera (ei naura) soomes pole aktiivi märgendit... # no Act tag ...` \
| sed 's/+V+Pass+PrfPrc+Sg+Nom/+V+Pss+PrfPrc+Sg+Nom/' `# Pass -> Pss` \
| sed 's/+V+Pass+Ind+Prt+ConNeg/+V+Pss+Ind+Prt+ConNeg/' \
`# Pe4 on kasutusel ainult passiivis # Pe4 is used only in passive` \
| sed 's/+V+Pass+Ind+Pr_t+Pe4/+V+Pss+Ind+Prt+Pe4/' \
| sed 's/+V+Pass+Ind+Pr_s+Pe4/+V+Pss+Ind+Prs+Pe4/' \
| sed 's/+V+Pass+Ind+Prs+ConNeg/+V+Pss+Ind+Prs+Pe4+ConNeg/' \
| sed 's/+V+Pass+Imprt/+V+Pss+Imprt+Pe4/' \
| sed '/Prt/!s/+V+Pass+Cond/+V+Pss+Cond+Pe4/' \
\

exit

`# eesti tingiv on alaspets; tekita 6 isiku vormi # Estonian Cond underspecified; generate 6 forms - person and number` \
| sed '/+Act+Cond$/s/^.*$/&+Sg1\n&+Sg2\n&+Sg3\n&+Pl1\n&+Pl2\n&+Pl3/'  \
`# eesti tingiv on alaspets ka minevikus; tekita 6 isiku vormi # Estonian Cond+Prt also underspecified; generate 6 forms - person and number` \
| sed '/+Act+Cond+Prt$/s/^.*$/&+Sg1\n&+Sg2\n&+Sg3\n&+Pl1\n&+Pl2\n&+Pl3/'  \
`# eesti käskiv on alaspets; tekita 5 isiku vormi # Estonian Imprt underspecified; generate 5 forms - person and number` \
| sed '/+Act+Imprt$/s/^.*$/&+Sg2\n&+Sg3\n&+Pl1\n&+Pl2\n&+Pl3/' \
`# eesti mineviku käskiv = nud-vorm # Estonian Past+Imprt = nud-form (PstPrc)` \
| sed '/+Act+Imprt+Prt$/s/+V+Act+Imprt+Prt/+V+Act+PrfPrc+Sg+Nom/' \
`# võiks selle vormi üldse eemaldada, nagunii on homonüümne ? # perhaps delete this form as homonymous with PstPrc anyway ?` \
`# sed '/+Act+Imprt+Prt$/s/^.*$//'` \

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

# üksiksõna kasutusnäide # usage example for one wordform
# (vahepeal tuleb eesti fst analüüsitulemust teisendada, et ta edasistele sobiks) 
# (some intermidiate conversion is necessary for the next tools to run properly)

echo 'kudusin' \
| hfst-lookup -q ~/svn-giellatekno/main/langs/est/src/analyser-gt-norm.hfst \
| tr '\011' '@' \
| sed 's/^[^@]*@\([^@]*\)@.*$/\1/' \
| sed 's/^kuduma/kutoa/' \
| ./V_est_2_fin_tag.sh \
| grep '^[^ ]' \
|  hfst-lookup -q ~/svn-giellatekno/main/langs/fin/src/generator-gt-desc.hfstol

# tulemus:  # result:
# kutoa+V+Act+Ind+Prt+Sg1	kudoin	0,000000



