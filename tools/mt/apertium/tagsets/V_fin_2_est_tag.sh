#!/bin/sh
# verbivormistiku tõlkimine soome -> eesti # translate verb paradigm Finnish -> Estonian
# märgenditeisendused # tag conversion


sed 's/+V+Pss/+V+Pass/' `# paranda soome vead # fix errors in Finnish tags` \
| sed 's/+V+Ind/+V+Act+Ind/' `# paranda soome vead # fix errors in Finnish tags` \
| sed 's/+V+Imprt/+V+Act+Imprt/' `# paranda soome vead # fix errors in Finnish tags` \
| sed 's/+V+Cond/+V+Act+Cond/' `# paranda soome vead # fix errors in Finnish tags` \
\
`# eestis on aeg enne kõneviisi, soomes vastupidi` \
`# in Estonian, tense before mood, in Finnish, mood before tense` \
| sed 's/+\([^+]*\)+\(Prs\)+/+\2+\1+/' \
| sed 's/+\([^+]*\)+\(Prt\)+/+\2+\1+/' \
\
`# terve märgendikombinatsioon eesti -> soome # the whole gram comb Finnish -> Estonian ` \
| sed 's/+V+Act+InfA+Sg+Lat/+V+Inf/' \
| sed 's/+V+Act+InfE+Sg+Ine/+V+Ger/' \
| sed 's/+V+Act+InfMa+Sg+Ill/+V+Pers+Sup+Ill/' \
| sed 's/+V+Act+InfMa+Sg+Ine/+V+Pers+Sup+Ine/' \
| sed 's/+V+Act+InfMa+Sg+Ela/+V+Pers+Sup+Ela/' \
| sed 's/+V+Act+InfMa+Sg+Abe/+V+Pers+Sup+Abe/' \
| sed 's/+V+Pass+InfMa+Sg+Ins/+V+Impers+Sup/' \
| sed 's/+V+Act+PrsPrc+Sg+Nom/+V+Pers+Prs+Prc/' \
| sed 's/+V+Act+PrfPrc+Sg+Nom/+V+Pers+Prt+Prc/' \
| sed 's/+V+Pass+PrsPrc+Sg+Nom/+V+Impers+Prs+Prc/' \
| sed 's/+V+Pass+PrfPrc+Sg+Nom/+V+Impers+Prt+Prc/' \
\
`# lihtsalt teine tähis:   # simply another tag, same meaning` \
| sed 's/+Act/+Pers/' \
| sed 's/+Pass/+Impers/' \
| sed 's/+ConNeg/+Neg/' \
\
`# soomes pole tingival ega käskival kv. aega # Finnish has no tense in Cond and Imprt` \
| sed 's/+Cond/+Prs+Cond/' \
| sed '/+Prs/!s/+Imprt/+Prs+Imprt/' \
\
`# soomes on tingival ja käskival kv. 3. isik (eestis on vastav vorm alaspetsif.)` \
`# Finnish has forms Cond+Sg3 and Imprt+Sg3, Pl3, Estonian is underspecified` \
| sed 's/+Cond+Sg3/+Cond/' \
| sed 's/+Imprt+[SP][gl]3/+Imprt/' \
\
`# soome ei märgi jaatust # Finnish does not tag Affirmative, but Estonian does (in Ind, Cond)` \
| sed 's/+Pers+.*+Ind+[SP][gl][123]/&+Aff/' \
| sed 's/+Pers+.*+Cond+[SP][gl][123]/&+Aff/' \
| sed '/+Neg/!s/+Impers+.*+Ind/&+Aff/' \
\
`# soome agentpartitsiibi puhul käänet ei tõlgitagi... # case not translated in Fin. agent participle...` \
| sed 's/AgPrc+[+SgPl]*+[^ ][^ ][^ ]/Impers+Prt+Prc/' \
`# soomes on asjatu märgend Pe4 # Pe4 is unnecessary` \
| sed 's/+Pe4//' \
| sed 's/+Cond+Neg/+Cond/' `# antaisi -> annaks` \


exit


# usage example
# translate kutoa -> kuduma (knit)
# will succeed for ??? paradigm cells
# will fail for ??? cells - no Estonian one-word translation

echo 'k u t o a "+V" [ ? - [ "#" | "+Foc/han" | "+Foc/kaan" | "+Foc/kin" | "+Foc/pa" | "+Foc/s" | "+Der/maisilla" | "+Der/inen" | "+Der/minen" | "+Use/Rare" ] ] *' \
|   hfst-regexp2fst \
|   hfst-compose -F -2 - -1 ~/svn-giellatekno/main/langs/fin/src/analyser-gt-desc.hfst \
|   hfst-project -p lower \
|   hfst-fst2strings \
|   sort -u \
\
| sed 's/^kutoa/kuduma/' \
\
| ./V_fin_2_est_tag.sh \
\
|   hfst-lookup -q ~/svn-giellatekno/main/langs/est/src/generator-gt-norm.hfstol \
|   grep -v ^$ \


#----------------
echo 'kutoa+V+Act+PrfPrc+Comp+Cmt+PxPl3' | hfst-lookup -q ~/svn-giellatekno/main/langs/fin/src/generator-gt-desc.hfstol
kutoa+V+Act+PrfPrc+Comp+Cmt+PxPl3	kutoneempinean	0,000000
kutoa+V+Act+PrfPrc+Comp+Cmt+PxPl3	kutoneempinensa	0,000000

