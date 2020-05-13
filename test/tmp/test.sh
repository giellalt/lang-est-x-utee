#!/bin/sh

cat korpustest-8-alakriips | sed 's/    .*$//' | hfst-lookup -b 190 ../../src/analyser-gt-desc.hfstol > korpustest-8-alakriips.hjk.hfst

cat korpustest-8-alakriips.hjk.hfst | grep '?' | sed 's/\t.*$//' > eitunne.hfst

exit

cat ~/svn-giellatekno/main/experiment-langs/est/test/tmp/korpustest-8-alakriips | sed 's/    .*$//' | ~/xfst/bin/lookup ../../src/analyser-gt-desc.xfst -q -flags TT > ~/svn-giellatekno/main/experiment-langs/est/test/tmp/korpustest-8-alakriips.hjk.xfst

cat korpustest-8-alakriips.hjk.xfst | grep '?' | sed 's/\t.*$//' > eitunne.xfst
-----------------
cat ~/svn-giellatekno/main/experiment-langs/est/test/tmp/korpustest-8-alakriips | sed 's/    .*$//' | hfst-lookup analyser-gt-desc.hfstol > ~/svn-giellatekno/main/experiment-langs/est/test/tmp/korpustest-8-alakriips.hjk.hfst

cat ../test/tmp/korpustest-8-alakriips.hjk.hfst | grep '?' | sed 's/\t.*$//' > ../test/tmp/eitunne.hfst

