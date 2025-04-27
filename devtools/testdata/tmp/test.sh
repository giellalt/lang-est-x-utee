#!/bin/sh

# liitsõnade testfail on pärit 2017 siit:
# svnfsvabamorf/svnfs/trunk/private/tests/cmdline/etana/
# etana poolt tuntud liitsõnad:
# cat korpustest-8.M | grep '    [^ ]*_[^ ]* ' | grep -v '^[1234567890]' | grep -v '^[+-]' > korpustest-8-alakriips
# 2019 on see testfail veidi erinev, sest vahepeal on sõnatikku ja algoritmi veidi parandatud: korpustest-8-alakriips.2019

# etana jaoks tundmatud sõnad:
# cat korpustest-8.M | grep  '^[[:alpha:]]' | grep '###' | sed 's/    .*$//' > etana_tundmatud.txt
# ja nende oletamine:
# cat etana_tundmatud.txt | etana -O > etana_tundmatud.etana

# oletatud liitsõnad, kusjuures sõnas pole punkti sees:
# cat etana_tundmatud.etana | grep '    [^ ]*_' | sed 's/    .*$//' | grep -v '[[:punct:]]' > etana_oletatud_liitsonad.txt


cat korpustest-8-alakriips | sed 's/    .*$//' | hfst-lookup -q ../../src/analyser-gt-desc.hfstol > korpustest-8-alakriips.hjk.hfst

cat korpustest-8-alakriips.hjk.hfst | grep '?' | sed 's/\t.*$//' > eitunne.hfst

exit

cat ~/svn-giellatekno/main/experiment-langs/est/test/tmp/korpustest-8-alakriips | sed 's/    .*$//' | ~/xfst/bin/lookup ../../src/analyser-gt-desc.xfst -q -flags TT > ~/svn-giellatekno/main/experiment-langs/est/test/tmp/korpustest-8-alakriips.hjk.xfst

cat korpustest-8-alakriips.hjk.xfst | grep '?' | sed 's/\t.*$//' > eitunne.xfst
-----------------
cat ~/svn-giellatekno/main/experiment-langs/est/test/tmp/korpustest-8-alakriips | sed 's/    .*$//' | hfst-lookup analyser-gt-desc.hfstol > ~/svn-giellatekno/main/experiment-langs/est/test/tmp/korpustest-8-alakriips.hjk.hfst

cat ../test/tmp/korpustest-8-alakriips.hjk.hfst | grep '?' | sed 's/\t.*$//' > ../test/tmp/eitunne.hfst

