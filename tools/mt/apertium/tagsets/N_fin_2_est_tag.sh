#!/bin/sh
# nimisõna vormistiku tõlkimine soome -> eesti # translate noun paradigm Finnish -> Estonian
# märgenditeisendused # tag conversion

sed 's/+Pl+Ins/+Pl+Com/' `# mitmuse kaasaütlev on soome k. viisiütlev # Est. pl comitative = Fin. instrumental `\
| sed 's/N+Com/N+Sg+Com/' \
\
`# ei tõlgi: rajav on soome k. om + saakka # no translation Est. terminative = Fin. genitive + saakka `\

exit

# usage example
# translate hobune -> hevonen (horse)
# omit questions, possessive suffixes
# will succeed for ... paradigm cells
# will fail for ... cells - no Finnish one-word translation

echo 'h e v o n e n "+N" [ ? - [ "#" | "+Foc/han" | "+Foc/kaan" | "+Foc/kin" | "+Foc/pa" | "+Foc/s" ] ] *' \
|   hfst-regexp2fst \
|   hfst-compose -F -2 - -1 ~/svn-giellatekno/main/langs/fin/src/analyser-gt-desc.hfst \
|   hfst-project -p lower \
|   hfst-fst2strings \
| sed 's/+Qst//' \
| sed 's/+Px[SP][gl][123]//' \
|   sort -u \
\
| sed 's/^hevonen/hobune/' \
\
| ./N_fin_2_est_tag.sh \
\
|   hfst-lookup -q ~/svn-giellatekno/main/langs/est/src/generator-gt-norm.hfstol \
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


