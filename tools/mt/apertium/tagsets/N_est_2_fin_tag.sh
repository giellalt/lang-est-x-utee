#!/bin/sh
# nimisõna vormistiku tõlkimine eesti -> soome # translate noun paradigm Estonian -> Finnish
# märgenditeisendused # tag conversion


sed 's/+Pl+Com/+Pl+Ins/' `# mitmuse kaasaütlev on soome k. viisiütlev # Est. pl comitative = Fin. instrumental `\
| sed 's/+Sg+Com/+Com/' \
\
`# ei tõlgi: rajav on soome k. om + saakka # Est. terminative = Fin. genitive + saakka `\

exit

# usage example
# translate hobune -> hevonen (horse)
# will succeed for ... paradigm cells
# will fail for ... cells - no Finnish one-word translation

echo 'h o b u n e "+N" [ ? - [ "#" | "+Dim/kene" | "+Dim/ke" | "+Der/lt"] ] *' \
|   hfst-regexp2fst \
|   hfst-compose -F -2 - -1 ~/svn-giellatekno/main/langs/est/src/analyser-gt-norm.hfst \
|   hfst-project -p lower \
|   hfst-fst2strings \
|   sort -u \
\
| sed 's/^hobune/hevonen/' \
\
| ./N_est_2_fin_tag.sh \
\
|   hfst-lookup -q ~/svn-giellatekno/main/langs/fin/src/generator-gt-desc.hfstol \
|   grep -v ^$ 

# üksiksõna kasutusnäide # usage example for one wordform
# (vahepeal tuleb eesti fst analüüsitulemust teisendada, et ta edasistele sobiks) 
# (some intermidiate conversion is necessary for the next tools to run properly)

echo 'hobustega' \
| hfst-lookup -q ~/svn-giellatekno/main/langs/est/src/analyser-gt-norm.hfstol \
| tr '\011' '@' \
| sed 's/^[^@]*@\([^@]*\)@.*$/\1/' \
| sed 's/^hobune/hevonen/' \
| ./N_est_2_fin_tag.sh \
| grep '^[^ ]' \
|  hfst-lookup -q ~/svn-giellatekno/main/langs/fin/src/generator-gt-desc.hfstol


