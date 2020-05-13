#!/bin/sed -f

/#/s/^\([^() ]*\)(\([^ ()]*\))/\1\2/ 
s/#//g
s/^\([^@]*\)\[D \(.*@\)/\1 \2/
s/(\([^@]*\))\([aeiu]\)\[DE /\1\2 /
s/^\([^ ]*\)is [^@]*@KALLIS.*$/& \1is:\1i/
s/^\([^ ]*\)is [^@]*@LOHAKAS.*$/& \1is:\1i/
s/^\([^ ]*\) [^@]*@KEVAD.*$/& \1:\1/
s/^\([^ ]*kohus\) \([^ ]*k<oh\)tu [^@]*@KOHUS.*$/& \1:\2T1u/
s/^\([^ ]*kura\)t [^@]*@KURAT.*$/& \1t:\1/
s/^\([^ ]*k<õrb\) [^@]*@KÕRB.*$/& \1:\1/
s/^\([^ ]*k<*ööm\)en [^@]*@KÖÖMEN.*$/& \1en:\1E2n/
s/^\([^ ]*\)ps [^@]*@LAPS.*$/& \1ps:\1P1s/
s/^\([^ ]*\)ks [^@]*@LAPS.*$/& \1ks:\1K1s/
s/^\([^ ]*lõuna\) \([^ ]*l<õuna\)[^@]*@LÕUNA.*$/& \1:\2/
s/^\([^ ]*an\)ner [^@]*@MANNER.*$/& \1ner:\1nD1E2r/
s/^\([^ ]*\)m<ees [^@]*@MEES.*$/& \1m<ees:\1me/
s/^\([^ ]*\)naine [^@]*@NAINE.*$/& \1naine:\1naine/
s/^\([^ ]*\)teine [^@]*@TEINE.*$/& \1teine:\1teine/
s/^\([^ ]*\)õlu [^@]*@ÕLU.*$/& \1õlu:\1õl/
s/^\([^ ]*\)ks [^@]*@KAKS.*$/& \1ks:\1/
s/^\([^ ]*\) [^@]*@PEEN$/& \1:\1/
s/^\([^ ]*\) [^@]*@NIIN$/& \1:\1/
s/^\([^ ]*\)ke [^@]*@PÄIKE.*$/& \1ke:\1/
s/^\([^ ]*\)e [^@]*@SEEME.*$/& \1e:\1E2/
s/^\([^ ]*süda\) [^@]*@SÜDA.*$/& \1:\1%{stemill%}%{rare%}/
s/^\([^ ]*ah\)er [^@]*@VAHER.*$/& \1er:\1T1E2r/
s/^\([^ ]*\)ke [^@]*@VÄIKE.*$/& \1ke:\1/
s/^\([^ ]*emand\) [^@]*@MAGUS.*$/& \1:\1/
s/^\([^ ]*is*sand\) [^@]*@MAGUS.*$/& \1:\1/
s/^\([^ ]*para\)s [^@]*@PARAS.*$/& \1s:\1/
s/^\([^ ]*põrand\) [^@]*@MAGUS.*$/& \1:\1/
s/^\([^ ]*rätsep\) [^@]*@MAGUS.*$/& \1:\1/
s/^\([^ ]*tuha\)t [^@]*@TUHAT.*$/& \1t:\1/
s/^\([^ ]*tulnuk\) [^@]*@MAGUS.*$/& \1:\1/
s/^\([^ ]*Tooming\) [^@]*@MAGUS.*$/& \1:\1/
s/^\([^ ]*raamat\) [^@]*@VIRSIK.*$/& \1:\1/
s/^\([^ ]*Lembit\) [^@]*@VIRSIK.*$/& \1:\1/
s/^\([^ ]*\) [^@]*@AASTA.*$/& \1:\1/
/@.*:/!s/^\([^ ]*ud\) \([^ ]*u\) [^@]*@TUNTUD.*$/& \1:\2/
/@.*:/!s/^\([^ ]*\) \1u [^@]*@VIRSIK.*$/& \1:\1/
/@.*:/!s/^\([^ ]*\)\([kpt]*\)u\([lr]\) \1[kpt]*\3u [^@]*@VIRSIK.*$/& \1\2u\3:\1\2U2\3/
/@.*:/!s/^\([^ ]*\) \1’i [^@]*@REDEL.*$/& \1:\1%{apo%}/
/@.*:/!s/^\([^ ]*\) \1i [^@]*@REDEL.*$/& \1:\1/
/@.*:/!s/^\([^ ]*\)\([kptmshf]*\)e\([lr]\) \1[kpt]*\3i [^@]*@REDEL.*$/& \1\2e\3:\1\2E2\3/
/@.*:/!s/^\([^ ]*\) \1a [^@]*@MAGUS.*$/& \1:\1/
/@.*:/!s/^[^ ]*sg_g\$ \([^ ]*\)a [^@]*@MAGUS.*$/& \1a:\1/
/@.*:/!s/^\([^ ]*\)\([kptmshf]*\)e\([lmnrsv]\) \1[kpt]*\3a [^@]*@MAGUS.*$/& \1\2e\3:\1\2E2\3/
/@.*:/!s/^\([^ ]*k\)\(orst\)e\(n\) \1<orst\3a [^@]*@MAGUS.*$/& \1\2e\3:\1<\2E2\3/
/@.*:/!s/^\([^ ]*\)\([kptmshf]*\)u\([lmnrsv]\) \1[kpt]*\3a [^@]*@MAGUS.*$/& \1\2u\3:\1\2U2\3/
/@.*:/!s/^\([^ ]*\)\([kptmshf]*\)i\([lmnrsv]\) \1[kpt]*\3a [^@]*@MAGUS.*$/& \1\2i\3:\1\2I2\3/
/@.*:/!s/^\([^ ]*\)ne \1sa [^@]*@MAGUS.*$/& \1ne:\1ne/
/@.*:/!s/^\([^ ]*\)s \1 [^@]*@LOHAKAS.*$/& \1s:\1/
/@.*:/!s/^\([^ ]*\)s \1nda [^@]*@HALE.*$/& \1s:\1N1S1/
/@.*:/!s/^\([^ ]*\) [^@]*@HALE.*$/& \1:\1/
/@.*:/!s/^\([^ ]*\)as \([^ ]*\)sa [^@]*@HOOLAS.*$/& \1as:\2A2s/
/@.*:/!s/^\([^ ]*\)es \([^ ]*\)sa [^@]*@HOOLAS.*$/& \1es:\2E2s/
/@.*:/!s/^\([^ ]*\)is \([^ ]*\)sa [^@]*@HOOLAS.*$/& \1is:\2I2s/
/@.*:/!s/^\([^ ]*\)us \([^ ]*\)sa [^@]*@HOOLAS.*$/& \1us:\2U2s/
/@.*:/!s/^\([^ ]*\) [^@]*@HABE.*$/& \1:\1/
/@.*:/!s/^\([^ ]*[aeiouõäöü]k\)e \([^ ]*k\)me [^@]*@HAARE.*$/& \1e:\2kE2/
/@.*:/!s/^\([^ ]*[aeiouõäöü]p\)e \([^ ]*p\)me [^@]*@HAARE.*$/& \1e:\2pE2/
/@.*:/!s/^\([^ ]*[aeiouõäöü]t\)e \([^ ]*t\)me [^@]*@HAARE.*$/& \1e:\2tE2/
/@.*:/!s/^\([^ ]*\)e \([^ ]*\)me [^@]*@HAARE.*$/& \1e:\2E2/
/@.*:/!s/^\([^ ]*\)t\]i \([^ ]*\)t\]me [^@]*@HAARE.*$/& \1ti:\2ttI2/
/@.*:/!s/^\([^ ]*\)tu \([^ ]*\)tme [^@]*@HAARE.*$/& \1tu:\2ttU2/
/@.*:/!s/^\([^ ]*\) \([^ ]*\) [^@]*@PINGE.*$/& \1:\2/
/@.*:/!s/^\([^ ]*\)as \([^ ]*\)a [^@]*@KOTKAS.*$/& \1as:\2a/
/@.*:/!s/^\([^ ]*\)is \([^ ]*\)i [^@]*@KOTKAS.*$/& \1is:\2i/
/@.*:/!s/^\([^ ]*\)es \([^ ]*\)e [^@]*@KOTKAS.*$/& \1es:\2e/
/@.*:/!s/^\([^ ]*\)us \([^ ]*\)u [^@]*@KOTKAS.*$/& \1us:\2u/
/@.*:/!s/^\([^ ]*kärb\)es \([^ ]*\)se [^@]*@KANNEL.*$/& \1es:\2E2s/
/@.*:/!s/^\([^ ]*lemm\)el \([^ ]*em\)le [^@]*@KANNEL.*$/& \1el:\2mE2l/
/@.*:/!s/^\([^ ]*kann\)el \([^ ]*\)le [^@]*@KANNEL.*$/& \1el:\2E2l/
/@.*:/!s/^\([^ ]*tüt\)ar \([^ ]*\)re [^@]*@KANNEL.*$/& \1ar:\2A2r/
/@.*:/!s/^\([^ ]*\)ar \([^ ]*\)ra [^@]*@PIPAR.*$/& \1ar:\2A2r/
/@.*:/!s/^\([^ ]*\)al \([^ ]*\)la [^@]*@PIPAR.*$/& \1al:\2A2l/
/@.*:/!s/^\([^ ]*\)el \([^ ]*\)la [^@]*@PIPAR.*$/& \1el:\2E2l/
/@.*:/!s/^\([^ ]*\)en \([^ ]*\)na [^@]*@PIPAR.*$/& \1en:\2E2n/
/@.*:/!s/^\([^ ]*nn\)er \([^ ]*\)ra [^@]*@PIPAR.*$/& \1er:\2E2r/
/@.*:/!s/^\([^ ]*\)s \1kse[^@]*@SOOLANE.*$/& \1s:\1K3s/
/@.*:/!s/^\([^ ]*\)s [^@]*@SOOLANE.*$/& \1s:\1s/
/@.*:/!s/^\([^ ]*\)ne [^@]*@SOOLANE.*$/& \1ne:\1ne/
/@.*:/!s/^\([^ ]*\)s [^@]*@OLULINE.*$/& \1s:\1s/
/@.*:/!s/^\([^ ]*\)ne [^@]*@OLULINE.*$/& \1ne:\1ne/
/@.*:/!s/^[^ ]*sg_g\$ \([^ ]*\)se [^@]*@OLULINE.*$/& \1se:\1ne/
/@.*:/!s/^\([^ ]*\)s [^@]*@KATKINE.*$/& \1s:\1s/
/@.*:/!s/^\([^ ]*\)ne [^@]*@KATKINE.*$/& \1ne:\1ne/
/@.*:/!s/^\([^ ]*\)s [^@]*@SUULINE.*$/& \1s:\1s/
/@.*:/!s/^\([^ ]*\)ne [^@]*@SUULINE.*$/& \1ne:\1ne/
/@.*:/!s/^\([^ ]*\) [^@]*@PEENIKE.*$/& \1:\1/
/@.*:/!s/^\([^ ]*l<ee\)m [^@]*@KEEL.*$/& \1m:\1M1/
/@.*:/!s/^\([^ ]*\) [^@]*@KEEL.*$/& \1:\1/
/@.*:/!s/^\([^ ]*\)s\]* \([^ ]*\)ne [^@]*@VARS.*$/& \1s:\1N1S1/
/@.*:/!s/^\([^ ]*\)rs \([^ ]*\)rre [^@]*@VARS.*$/& \1rs:\1rrS1/
/@.*:/!s/^\([^ ]*\)s \([^ ]*\)e [^@]*@VARS.*$/& \1s:\1S1/
/@.*:/!s/^\([^ ]*\)üs\]i [^@]*@MESI.*$/& \1üsi:\1üS1/
/@.*:/!s/^\([^ ]*\)us\]i [^@]*@MESI.*$/& \1usi:\1uS1/
/@.*:/!s/^\([^ ]*\)s\]i [^@]*@MESI.*$/& \1si:\1S1/
/@.*:/!s/^\([^ ]*\) [^@]*@RUBLA.*$/& \1:\1/
/@.*:/!s/^\([^ ]*[pk]ere\) \([^ (][^ ]*[^)]\) [^@]*@PERE.*$/& \1:\1%{stemill%}/
/@.*:/!s/^\([^ ]*tare\) \([^ (][^ ]*[^)]\) [^@]*@PERE.*$/& \1:\1%{stemill%}/
/@.*:/!s/^\([^ ]*[^gbd]\)\([aeiu]\) \([^ ]*\)g\2 [^@]*\\H[^@]*@PERE.*$/& \1\2:\1G3\2%{stemill%}/
/@.*:/!s/^\([^ ]*[^gbd]\)\([aeiu]\) \([^ ]*\)d\2 [^@]*\\H[^@]*@PERE.*$/& \1\2:\1D3\2%{stemill%}/

/@.*:/!s/^\([^ ]*\)bj\([aeiu]\) \([^ ]*\)pj\2 [^@]*\\H[^@]*@PERE.*$/& \1bj\2:\1B4j\2%{stemill%}/
/@.*:/!s/^\([^ ]*\)d\([aeiu]\) \([^ ]*\)t\2 [^@]*\\H[^@]*@PERE.*$/& \1d\2:\1D4\2%{stemill%}/
/@.*:/!s/^\([^ ]*\)g\([aeiu]\) \([^ ]*\)k\2 [^@]*\\H[^@]*@PERE.*$/& \1g\2:\1G4\2%{stemill%}/

/@.*:/!s/^\([^ ]*\) \([^ (][^ ]*[^)]\) [^@]*\\H[^@]*@PERE.*$/& \1:\1%{stemill%}/
/@.*:/!s/^\([^ ]*\) [^@]*@PERE.*$/& \1:\1/
/^[^ <]*[gbd][lr][aiu] .*\\[AS].*@PERE.*:/s/@PERE/@RUBLA/
/@.*:/!s/^\([^ ]*\) ([^ ]*) [^@]*\.17[^@]*@KAVA.*$/& \1:\1/
/@.*:/!s/^\([^ ]*\) [^ @]*\.17[^@]*@KAVA.*$/& \1:\1/
/@.*:/!s/^\([^ ]*\)\([aeiouõäöü]\)\(.\)\]*\([aeiou]\) [^ ]*\2\3\]*\3\4 [^@]*\.17[^@]*@KAVA.*$/& \1\2\3\4:\1\2\3\4%{stemill%}/
/@.*:/!s/^\([^ ]*\)\([aeiouõäöü]\)\(g\)\([aeiou]\) [^ ]*\2kk\4 [^@]*\.17[^@]*@KAVA.*$/& \1\2\3\4:\1\2\3\4%{stemill%}/
/@.*:/!s/^\([^ ]*\)\([aeiouõäöü]\)\(b\)\([aeiou]\) [^ ]*\2pp\4 [^@]*\.17[^@]*@KAVA.*$/& \1\2\3\4:\1\2\3\4%{stemill%}/
/@.*:/!s/^\([^ ]*\)\([aeiouõäöü]\)\(d\)\([aeiou]\) [^ ]*\2tt\4 [^@]*\.17[^@]*@KAVA.*$/& \1\2\3\4:\1\2\3\4%{stemill%}/
/@.*:/!s/^\([^ ]*\)\([aeiouõäöü]\)\(d\)\([aeiou]\) [^ ]*\2j\4 [^@]*\.17[^@]*@KAVA.*$/& \1\2\3\4:\1\2J1D1\4%{stemill%}/

/@.*:/!s/^\([^ ]*\)gu [^ ][^ ]*o [^@]*\.18[^@]*@KAVA.*$/& \1gu:\1G1u/
/@.*:/!s/^\([^ ]*\)bu [^ ][^ ]*o [^@]*\.18[^@]*@KAVA.*$/& \1bu:\1B1u/
/@.*:/!s/^\([^ ]*\)du [^ ][^ ]*o [^@]*\.18[^@]*@KAVA.*$/& \1du:\1D1u/
/@.*:/!s/^\([^ ]*\)du [^ ][^ ]*ju [^@]*\.18[^@]*@KAVA.*$/& \1du:\1D1J1u/

/@.*:/!s/^\([^ ]*\)da [^ ][^ ]*ja [^@]*\.18[^@]*@KAVA.*$/& \1da:\1D1J1a/
/@.*:/!s/^\([^ ]*\)da [^ ][^ ]*[^j]a [^@]*\.18[^@]*@KAVA.*$/& \1da:\1D1a/
/@.*:/!s/^\([^ ]*\)ga [^ ][^ ]*a [^@]*\.18[^@]*@KAVA.*$/& \1ga:\1G1a/
/@.*:/!s/^\([^ ]*\)ba [^ ][^ ]*a [^@]*\.18[^@]*@KAVA.*$/& \1ba:\1B1a/

/@.*:/!s/^\([^ ]*\)de [^ ][^ ]*[^d]e [^@]*\.18[^@]*@KAVA.*$/& \1de:\1D1e/
/^[^ <]*sada .*@KAVA.*:/s/@KAVA/@SADA/
/_sada .*@KAVA.*:/s/@KAVA/@SADA/


/^\([^ ]*\) [^ ][^ ]* [^ (][^ ]*[^)] .*@KAVA/s/$/%{stemill%}/
/iga.*ikka /s/%{stemill%}/&%{rare%}/
/suga.*ukka /s/%{stemill%}//

/@.*:/s/^[^ ]* [^@]*\^E\^[^!]*!@KAVA.*$/&%>%{pl.e%}/
/@.*:/s/^[^ ]* [^@]*\^I\^[^!]*!@KAVA.*$/&%>%{pl.i%}/
/@.*:/s/^[^ ]* [^@]*\^U\^[^!]*!@KAVA.*$/&%>%{pl.u%}/

/@KAVA.*%{stemill%}/s/\(%{stemill%}\)\(%>%{pl.[eiu]%}\)/\2\1/
/^sada .*@SADA/s/$/%>%{pl.u%}/
/aasta_sada .*@SADA/s/$/%>%{pl.u%}/

/\.17.*@KAVA.*%{stemill%}/s/%{stemill%}/&%{rare%}/
/^elu .*%{stemill%}%{rare%}/s/%{rare%}//
/_elu .*%{stemill%}%{rare%}/s/%{rare%}//
/^maru .*%{stemill%}%{rare%}/s/%{rare%}//
/_maru .*%{stemill%}%{rare%}/s/%{rare%}//
/^eru .*%{stemill%}%{rare%}/s/%{rare%}//
/_eru .*%{stemill%}%{rare%}/s/%{rare%}//
/^häda .*%{stemill%}%{rare%}/s/%{rare%}//
/^ida .*%{stemill%}%{rare%}/s/%{rare%}//
/_ida .*%{stemill%}%{rare%}/s/%{rare%}//
/^abi .*%{stemill%}%{rare%}/s/%{rare%}//
/kino .*%{stemill%}%{rare%}/s/%{rare%}//
/kodu .*%{stemill%}%{rare%}/s/%{rare%}//
/kõri .*%{stemill%}%{rare%}/s/%{rare%}//
/küla .*%{stemill%}%{rare%}/s/%{rare%}//
/maja .*%{stemill%}%{rare%}/s/%{rare%}//
/mälu .*%{stemill%}%{rare%}/s/%{rare%}//
/nina .*%{stemill%}%{rare%}/s/%{rare%}//
/^oja .*%{stemill%}%{rare%}/s/%{rare%}//
/_oja .*%{stemill%}%{rare%}/s/%{rare%}//
/^osa .*%{stemill%}%{rare%}/s/%{rare%}//
/_osa .*%{stemill%}%{rare%}/s/%{rare%}//
/^pada .*%{stemill%}%{rare%}/s/%{rare%}//
/_pada .*%{stemill%}%{rare%}/s/%{rare%}//
/^pesa .*%{stemill%}%{rare%}/s/%{rare%}//
/_pesa .*%{stemill%}%{rare%}/s/%{rare%}//
/^võsa .*%{stemill%}%{rare%}/s/%{rare%}//
/_võsa .*%{stemill%}%{rare%}/s/%{rare%}//
/^saba .*%{stemill%}%{rare%}/s/%{rare%}//
/talu .*%{stemill%}%{rare%}/s/%{rare%}//
/^tül\]i .*%{stemill%}%{rare%}/s/%{rare%}//
/^udu .*%{stemill%}%{rare%}/s/%{rare%}//
/_udu .*%{stemill%}%{rare%}/s/%{rare%}//

/raba .*17^U^!@KAVA/s/%>%{pl\.u%}//
/jada .*17^U^!@KAVA/s/%>%{pl\.u%}//
/lava .*17^U^!@KAVA/s/%>%{pl\.u%}//
/nõva .*17^U^!@KAVA/s/%>%{pl\.u%}//
/[ljs]uga .*18^.^!@KAVA/s/%>%{pl\..%}//
/pada .*18^.^!@KAVA/s/%>%{pl\..%}//

/kava .*17^U^!@KAVA/s/%>%{pl\..%}/&%{rare%}/
/nina .*17^U^!@KAVA/s/%>%{pl\..%}/&%{rare%}/
/saba .*17^U^!@KAVA/s/%>%{pl\..%}/&%{rare%}/
/kena .*17^U^!@KAVA/s/%>%{pl\..%}/&%{rare%}/
/kõva .*17^U^!@KAVA/s/%>%{pl\..%}/&%{rare%}/
/paha .*17^U^!@KAVA/s/%>%{pl\..%}/&%{rare%}/
/vaga .*17^U^!@KAVA/s/%>%{pl\..%}/&%{rare%}/
/^ala .*17^U^!@KAVA/s/%>%{pl\..%}/&%{rare%}/
/_ala .*17^U^!@KAVA/s/%>%{pl\..%}/&%{rare%}/
/huvi .*17^U^!@KAVA/s/%>%{pl\..%}/&%{rare%}/
/keha .*17^U^!@KAVA/s/%>%{pl\..%}/&%{rare%}/

s/^\([^ ]*\) [^@]*@MUUSEUM.*$/& \1:\1/
s/^\([^ ]*lu\)mi [^@]*@MERI.*$/& \1mi:\1M1%{stemill%}/
s/^\([^ ]*mõ\)n\]i [^@]*@MERI.*$/& MÕNI \1ni:\1nD3/
/@MERI.*MÕNI/s/@MERI.*MÕNI/@MÕNI/
/@.*:/!s/^\([^ ]*\)i [^@]*@MERI.*$/& \1i:\1%{stemill%}/
/[ _]kuse .*MERI/s/%{stemill%}/&%{rare%}/
s/^\([^ ]*\)i [^@]*20[^@]*@NIMI.*$/& \1i:\1/
/[ _]süle [^@]*20[^@]*@NIMI/s/$/%{stemill%}/
/[ _]tüve [^@]*20[^@]*@NIMI/s/$/%{stemill%}%{rare%}/
s/^\([^ ]*t\)ugi [^@]*21[^@]*@NIMI.*$/& \1ugi:\1uG1/
/@.*:/!s/^\([^ ]*\)gi [^@]*21[^@]*@NIMI.*$/& \1gi:\1G1%{stemill%}/
/@.*:/!s/^\([^ ]*\)bi [^@]*21[^@]*@NIMI.*$/& \1bi:\1B2%{stemill%}/


/@.*:/!s/^\([^ ]*\) \([^ ]*\)\([lmnr]\)g[aeiu] \([^ ]*\)\3\3[aeiu] [^@]*22[^@]*@.*$/& \1:\2\3\3G1/
/@.*:/!s/^\([^ ]*\) \([^ ]*\)\([lmnr]\)b[aeiu] \([^ ]*\)\3\3[aeiu] [^@]*22[^@]*@.*$/& \1:\2\3\3B1/
/@.*:/!s/^\([^ ]*\) \([^ ]*\)\([lmnr]\)\]*d[aeiu] \([^ ]*\)\3\]*\3[aeiu] [^@]*22[^@]*@.*$/& \1:\2\3\3D1/

/@.*:/!s/^\([^ ]*\) \([^ ]*\)\(.\)g[aeiu] \([^ ]*\)\3[aeiu] [^@]*22[^@]*@.*$/& \1:\2\3G1/
/@.*:/!s/^\([^ ]*\) \([^ ]*\)\(.\)b[aeiu] \([^ ]*\)\3[aeiu] [^@]*22[^@]*@.*$/& \1:\2\3B1/
/@.*:/!s/^\([^ ]*\) \([^ ]*\)\(.\)d[aeiu] \([^ ]*\)\3[aeiu] [^@]*22[^@]*@.*$/& \1:\2\3D1/

/@.*:/!s/^\([^ ]*\) \([^ ]*\)\([sh]\)k[aeiu] \([^ ]*\)\3[aeiu] [^@]*22[^@]*@.*$/& \1:\2\3K1/
/@.*:/!s/^\([^ ]*\) \([^ ]*\)\([sh]\)p[aeiu] \([^ ]*\)\3[aeiu] [^@]*22[^@]*@.*$/& \1:\2\3P1/
/@.*:/!s/^\([^ ]*\) \([^ ]*\)\([sh]\)t[aeiu] \([^ ]*\)\3[aeiu] [^@]*22[^@]*@.*$/& \1:\2\3T1/

/@.*:/!s/^\([^ ]*\) \([^ ]*\)\([ao]\)eg[aeiu] \([^ ]*\)\3j[aeiu] [^@]*22[^@]*@.*$/& \1:\2\3E4G1/
/@.*:/!s/^\([^ ]*\) \([^ ]*\)\([ao]\)ed[aeiu] \([^ ]*\)\3i[aeiu] [^@]*22[^@]*@.*$/& \1:\2\3J1D1/

/@.*:/!s/^\([^ ]*\) \([^ ]*\)\(.\)tv[aeiu] \([^ ]*\)dv[aeiu] [^@]*22[^@]*@.*$/& \1:\2\3T2v/

/@.*:/!s/^\([^ ]*\) \([^ ]*\)\(.\)g[aeiu] \([^ ]*\)\3j[aeiu] [^@]*22[^@]*@.*$/& \1:\2\3J1G1/
/@.*:/!s/^\([^ ]*\) \([^ ]*\)\(.\)b[aeiu] \([^ ]*\)\3v[aeiu] [^@]*22[^@]*@.*$/& \1:\2\3B2/

/@.*:/!s/^\([^ ]*\) \([^ ]*\)\(ss\)[aeiu] \([^ ]*\)s[aeiu] [^@]*22[^@]*@.*$/& \1:\1/
/@.*:/!s/^\([^ ]*\) \([^ ]*\)\(šš\)[aeiu] \([^ ]*\)š[aeiu] [^@]*22[^@]*@.*$/& \1:\1/
/@.*:/!s/^\([^ ]*\) \([^ ]*\)\(ff\)[aeiu] \([^ ]*\)f[aeiu] [^@]*22[^@]*@.*$/& \1:\1/
/@.*:/!s/^\([^ ]*\) \([^ ]*\)\([kpt]\)\]*[aeiu] \([^ ]*\)[gbdkpt]\]*[aeiu] [^@]*22[^@]*@.*$/& \1:\1/
/@.*:/!s/^\([^ ]*\) \([^ ]*\)\(..\)[aeiu] \([^ ]*\)\3[aeiu] [^@]*22[^@]*@.*$/& \1:\1/

/@.*:/!s/^\([^ ]*i\) \([^ ]*\)\(.\)kj[aeiu] \([^ ]*\)\3gj[aeiu] [^@]*24[^@]*@.*$/& \1:\2\3K2J1/
/@.*:/!s/^\([^ ]*i\) \([^ ]*\)\(.\)pj[aeiu] \([^ ]*\)\3bj[aeiu] [^@]*24[^@]*@.*$/& \1:\2\3P2J1/
/@.*:/!s/^\([^ ]*i\) \([^ ]*\)\(.\)t\]*j[aeiu] \([^ ]*\)\3d\]*j[aeiu] [^@]*24[^@]*@.*$/& \1:\2\3T2J1/

/@.*:/!s/^\([^ ]*i\) \([^ ]*\)\(.\)j[aeiu]\[DE \([^ ]*\)\3j[aeiu] [^@]*24[^@]*@.*$/& \1:\2\3J1/
/@.*:/!s/^\([^ ]*i\) \([^ ]*\)\(.\)j[aeiu] \([^ ]*\)\3j[aeiu] [^@]*24[^@]*@.*$/& \1:\2\3J1/
/@.*:/!s/^\([^ ]*e\) \([^ ]*\)\(.\)j[aeiu] \([^ ]*\)\3j[aeiu] [^@]*24[^@]*@.*$/& \1:\2\3E4/

/@.*:/!s/^\([^ ]*e[lr]\) \([^ ]*\)k\([lr]\)[aeiu] \([^ ]*\)g\3[aeiu] [^@]*24[^@]*@.*$/& \1:\2K2E2\3/
/@.*:/!s/^\([^ ]*e[lr]\) \([^ ]*\)p\([lr]\)[aeiu] \([^ ]*\)b\3[aeiu] [^@]*24[^@]*@.*$/& \1:\2P2E2\3/
/@.*:/!s/^\([^ ]*e[lr]\) \([^ ]*\)t\([lr]\)[aeiu] \([^ ]*\)d\3[aeiu] [^@]*24[^@]*@.*$/& \1:\2T2E2\3/

/@.*:/!s/^\([^ ]*g\]*\) \([^ ]*\)\(.\)g\]*[aeiu] \([^ ]*\)[aeiuo] [^@]*22[^@]*@.*$/& \1:\2\3G1/
/@.*:/!s/^\([^ ]*b\]*\) \([^ ]*\)\(.\)b\]*[aeiu] \([^ ]*\)[aeiuo] [^@]*22[^@]*@.*$/& \1:\2\3B1/
/@.*:/!s/^\([^ ]*d\]*\) \([^ ]*\)\(.\)d\]*[aeiu] \([^ ]*\)[aeiuo] [^@]*22[^@]*@.*$/& \1:\2\3D1/

/@.*:/!s/^\([^ ]*s\]*\) \([^ ]*\)\(.\)s\]*i \([^ ]*[^s]\)e [^@]*22[^@]*@.*$/& \1:\2\3S1/

/@.*:/s/^[^ ]* [^@]*\.2[24][^@]*\^E\^[^!]*!.*@.*$/&%>%{pl.e%}%{rare%}/
/@.*:/s/^[^ ]* [^@]*\.2[24][^@]*\^I\^[^!]*!.*@.*$/&%>%{pl.i%}%{rare%}/
/@.*:/s/^[^ ]* [^@]*\.2[24][^@]*\^U\^[^!]*!.*@.*$/&%>%{pl.u%}%{rare%}/

/rohi.*@KOON/s/^\([^ ]*ro\)hi \(.*@\)KOON/\1hi \2KOON \1hi:\1hJ1T1%>%{pl.e%}%{rare%}/

/r[eu]hi.*@EIT/s/^\([^ ]*r[eu]\)hi \(.*@\)EIT/\1hi \2REHI \1hi:\1hJ1T1/

/@.*:/!s/^\([^ ]*_p<üks\)i*d* [^@]*23[^@]*@.*$/& \1:\1/

/@.*:/!s/^\([^ ]*\]*\) \([^ ]*\) [^@]*\.19[^@]*@TAUD$/& \1:\1/

/@TAUD/s/%>%{pl..%}%{rare%}//
/@TAUD/s/%>%{pl..%}//
/@KABINET/s/%>%{pl.e%}%{rare%}//
/@FIAT/s/%>%{pl.e%}%{rare%}//
/@ARGPÜKS/s/%>%{pl.e%}%{rare%}//
/@POISS/s/%>%{pl.e%}%{rare%}//
/@KAEL/s/%{rare%}//

/k<*onnD1/s/%{rare%}//

/[ =_-]k<ehva .*PIIM/s/%{rare%}//
/[ =_-]<arga .*PIIM/s/%{rare%}//
/[ =_-]k<uiva .*PIIM/s/%{rare%}//
/[ =_-]k<urba .*PIIM/s/%{rare%}//
/[ =_-]k<urja .*PIIM/s/%{rare%}//
/[ =_-]k<uuma .*PIIM/s/%{rare%}//
/[ =_-]k<õhna .*PIIM/s/%{rare%}//
/[ =_-]k<ülma .*PIIM/s/%{rare%}//
/[ =_-]l<aia .*PIIM/s/%{rare%}//
/[ =_-]l<aiska .*PIIM/s/%{rare%}//
/[ =_-]l<õtva .*PIIM/s/%{rare%}//
/[ =_-]m<usta .*PIIM/s/%{rare%}//
/[ =_-]m<ärga .*PIIM/s/%{rare%}//
/[ =_-]n<õrka .*PIIM/s/%{rare%}//
/[ =_-]p<elka .*PIIM/s/%{rare%}//
/[ =_-]p<ikka .*PIIM/s/%{rare%}//
/[ =_-]r<änka .*PIIM/s/%{rare%}//
/[ =_-]s<ooja .*PIIM/s/%{rare%}//
/[ =_-]s<ünka .*PIIM/s/%{rare%}//
/[ =_-]t<arka .*PIIM/s/%{rare%}//
/[ =_-]t<uima .*PIIM/s/%{rare%}//
/[ =_-]t<umma .*PIIM/s/%{rare%}//
/[ =_-]t<ühja .*PIIM/s/%{rare%}//
/[ =_-]v<irka .*PIIM/s/%{rare%}//
/[ =_-]<õrna .*PIIM/s/%{rare%}//
/[ =_-]h<alba .*PIIM/s/%{rare%}//
/[ =_-]h<arva .*PIIM/s/%{rare%}//
/[ =_-]h<ella .*PIIM/s/%{rare%}//
/[ =_-]j<ulma .*PIIM/s/%{rare%}//
/[ =_-]j<äika .*PIIM/s/%{rare%}//
/[ =_-]r<inda .*PIIM/s/%{rare%}//
/[ =_-]s<ilma .*PIIM/s/%{rare%}//
/[ =_-]j<alga .*PIIM/s/%{rare%}//
/[ =_-]<atra .*PIIM/s/%{rare%}//
/[ =_-]<as]ja .*PIIM/s/%{rare%}//
/[ =_-]<aeda .*PIIM/s/%{rare%}//
/[ =_-]<aega .*PIIM/s/%{rare%}//
/[ =_-]<aasa .*PIIM/s/%{rare%}//
/[ =_-]h<aaba .*PIIM/s/%{rare%}//
/[ =_-]h<aava .*PIIM/s/%{rare%}//
/[ =_-]h<arja .*PIIM/s/%{rare%}//
/[ =_-]h<auda .*PIIM/s/%{rare%}//
/[ =_-]h<inda .*PIIM/s/%{rare%}//
/[ =_-]h<ulka .*PIIM/s/%{rare%}//
/[ =_-]h<õlma .*PIIM/s/%{rare%}//
/[ =_-]h<ärga .*PIIM/s/%{rare%}//
/[ =_-]<ilma .*PIIM/s/%{rare%}//
/[ =_-]j<aama .*PIIM/s/%{rare%}//
/[ =_-]k<anda .*PIIM/s/%{rare%}//
/[ =_-]k<arja .*PIIM/s/%{rare%}//
/[ =_-]k<arva .*PIIM/s/%{rare%}//
/[ =_-]k<aupa .*PIIM/s/%{rare%}//
/[ =_-]k<austa .*PIIM/s/%{rare%}//
/[ =_-]k<ella .*PIIM/s/%{rare%}//
/[ =_-]k<esta .*PIIM/s/%{rare%}//
/[ =_-]k<ihva .*PIIM/s/%{rare%}//
/[ =_-]k<inga .*PIIM/s/%{rare%}//
/[ =_-]k<irja .*PIIM/s/%{rare%}//
/[ =_-]k<ohta .*PIIM/s/%{rare%}//
/[ =_-]k<oiba .*PIIM/s/%{rare%}//
/[ =_-]k<okka .*PIIM/s/%{rare%}//
/[ =_-]k<onna .*PIIM/s/%{rare%}//
/[ =_-]k<ontsa .*PIIM/s/%{rare%}//
/[ =_-]k<oppa .*PIIM/s/%{rare%}//
/[ =_-]k<orda .*PIIM/s/%{rare%}//
/[ =_-]k<uhja .*PIIM/s/%{rare%}//
/[ =_-]k?ujut<elma .*PIIM/s/%{rare%}//
/[ =_-]k<õntsa .*PIIM/s/%{rare%}//
/[ =_-]k<õrva .*PIIM/s/%{rare%}//
/[ =_-]k<äppa .*PIIM/s/%{rare%}//
/[ =_-]k<ärssa .*PIIM/s/%{rare%}//
/[ =_-]l<aata .*PIIM/s/%{rare%}//
/[ =_-]l<aeva .*PIIM/s/%{rare%}//
/[ =_-]l<aipa .*PIIM/s/%{rare%}//
/[ =_-]l<atva .*PIIM/s/%{rare%}//
/[ =_-]l<auda .*PIIM/s/%{rare%}//
/[ =_-]l<aupa .*PIIM/s/%{rare%}//
/[ =_-]l<auta .*PIIM/s/%{rare%}//
/[ =_-]l<ehma .*PIIM/s/%{rare%}//
/[ =_-]l<eiba .*PIIM/s/%{rare%}//
/[ =_-]l<eina .*PIIM/s/%{rare%}//
/[ =_-]l<eppa .*PIIM/s/%{rare%}//
/[ =_-]l<esta .*PIIM/s/%{rare%}//
/[ =_-]l<inna .*PIIM/s/%{rare%}//
/[ =_-]l<ooma .*PIIM/s/%{rare%}//
/[ =_-]l<õhna .*PIIM/s/%{rare%}//
/[ =_-]l<õnga .*PIIM/s/%{rare%}//
/[ =_-]l<õuga .*PIIM/s/%{rare%}//
/[ =_-]l<õusta .*PIIM/s/%{rare%}//
/[ =_-]k<apja .*PIIM/s/%{rare%}//
/[ =_-]l<ünka .*PIIM/s/%{rare%}//
/[ =_-]m<ahla .*PIIM/s/%{rare%}//
/[ =_-]m<altsa .*PIIM/s/%{rare%}//
/[ =_-]m<arja .*PIIM/s/%{rare%}//
/[ =_-]m<arka .*PIIM/s/%{rare%}//
/[ =_-]m<atka .*PIIM/s/%{rare%}//
/[ =_-]m<etsa .*PIIM/s/%{rare%}//
/[ =_-]m<okka .*PIIM/s/%{rare%}//
/[ =_-]m<ulda .*PIIM/s/%{rare%}//
/[ =_-]m<unka .*PIIM/s/%{rare%}//
/[ =_-]m<õrda .*PIIM/s/%{rare%}//
/[ =_-]m<õrva .*PIIM/s/%{rare%}//
/[ =_-]m<õõka .*PIIM/s/%{rare%}//
/[ =_-]n<ahka .*PIIM/s/%{rare%}//
/[ =_-]n<al]ja .*PIIM/s/%{rare%}//
/[ =_-]n<okka .*PIIM/s/%{rare%}//
/[ =_-]n<ukka .*PIIM/s/%{rare%}//
/[ =_-]n<urka .*PIIM/s/%{rare%}//
/[ =_-]n<õida .*PIIM/s/%{rare%}//
/[ =_-]n<õlva .*PIIM/s/%{rare%}//
/[ =_-]<ohja .*PIIM/s/%{rare%}//
/[ =_-]<orja .*PIIM/s/%{rare%}//
/[ =_-]p<at]ja .*PIIM/s/%{rare%}//
/[ =_-]p<ahna .*PIIM/s/%{rare%}//
/[ =_-]p<aika .*PIIM/s/%{rare%}//
/[ =_-]p<alka .*PIIM/s/%{rare%}//
/[ =_-]p<anka .*PIIM/s/%{rare%}//
/[ =_-]p<auna .*PIIM/s/%{rare%}//
/[ =_-]p<iina .*PIIM/s/%{rare%}//
/[ =_-]p<iitsa .*PIIM/s/%{rare%}//
/[ =_-]p<inda .*PIIM/s/%{rare%}//
/[ =_-]p<oega .*PIIM/s/%{rare%}//
/[ =_-]p<ohla .*PIIM/s/%{rare%}//
/[ =_-]p<ulka .*PIIM/s/%{rare%}//
/[ =_-]p<ulma .*PIIM/s/%{rare%}//
/[ =_-]p<unga .*PIIM/s/%{rare%}//
/[ =_-]p<uusa .*PIIM/s/%{rare%}//
/[ =_-]p<õtra .*PIIM/s/%{rare%}//
/[ =_-]p<õhja .*PIIM/s/%{rare%}//
/[ =_-]p<äeva .*PIIM/s/%{rare%}//
/[ =_-]p<ärga .*PIIM/s/%{rare%}//
/[ =_-]p<ärna .*PIIM/s/%{rare%}//
/[ =_-]r<aiska .*PIIM/s/%{rare%}//
/[ =_-]r<anda .*PIIM/s/%{rare%}//
/[ =_-]r<asva .*PIIM/s/%{rare%}//
/[ =_-]r<auda .*PIIM/s/%{rare%}//
/[ =_-]r<auka .*PIIM/s/%{rare%}//
/[ =_-]r<elva .*PIIM/s/%{rare%}//
/[ =_-]r<ihma .*PIIM/s/%{rare%}//
/[ =_-]r<iita .*PIIM/s/%{rare%}//
/[ =_-]r<oima .*PIIM/s/%{rare%}//
/[ =_-]r<onka .*PIIM/s/%{rare%}//
/[ =_-]r<ooga .*PIIM/s/%{rare%}//
/[ =_-]r<ühma .*PIIM/s/%{rare%}//
/[ =_-]r<ünka .*PIIM/s/%{rare%}//
/[ =_-]s<aia .*PIIM/s/%{rare%}//
/[ =_-]s<alka .*PIIM/s/%{rare%}//
/[ =_-]s<anga .*PIIM/s/%{rare%}//
/[ =_-]s<arja .*PIIM/s/%{rare%}//
/[ =_-]s<auna .*PIIM/s/%{rare%}//
/[ =_-]s<eika .*PIIM/s/%{rare%}//
/[ =_-]s<el]ga .*PIIM/s/%{rare%}//
/[ =_-]s<eppa .*PIIM/s/%{rare%}//
/[ =_-]s<erva .*PIIM/s/%{rare%}//
/[ =_-]s<ilda .*PIIM/s/%{rare%}//
/[ =_-]s<oola .*PIIM/s/%{rare%}//
/[ =_-]s<ukka .*PIIM/s/%{rare%}//
/[ =_-]s<uunda .*PIIM/s/%{rare%}//
/[ =_-]s<uuska .*PIIM/s/%{rare%}//
/[ =_-]s<õpra .*PIIM/s/%{rare%}//
/[ =_-]s<õrga .*PIIM/s/%{rare%}//
/[ =_-]s<ööta .*PIIM/s/%{rare%}//
/[ =_-]t<alda .*PIIM/s/%{rare%}//
/[ =_-]t<austa .*PIIM/s/%{rare%}//
/[ =_-]t<iiba .*PIIM/s/%{rare%}//
/[ =_-]t<ilka .*PIIM/s/%{rare%}//
/[ =_-]t<urja .*PIIM/s/%{rare%}//
/[ =_-]t<urska .*PIIM/s/%{rare%}//
/[ =_-]t<uuma .*PIIM/s/%{rare%}//
/[ =_-]v<aala .*PIIM/s/%{rare%}//
/[ =_-]v<aeva .*PIIM/s/%{rare%}//
/[ =_-]v<akla .*PIIM/s/%{rare%}//
/[ =_-]v<aia .*PIIM/s/%{rare%}//
/[ =_-]v<aipa .*PIIM/s/%{rare%}//
/[ =_-]r<iista .*PIIM/s/%{rare%}//
/[ =_-]v<arna .*PIIM/s/%{rare%}//
/[ =_-]v<arssa .*PIIM/s/%{rare%}//
/[ =_-]v<atsa .*PIIM/s/%{rare%}//
/[ =_-]v<enda .*PIIM/s/%{rare%}//
/[ =_-]v<il]ja .*PIIM/s/%{rare%}//
/[ =_-]v<illa .*PIIM/s/%{rare%}//
/[ =_-]v<irna .*PIIM/s/%{rare%}//
/[ =_-]v<õlga .*PIIM/s/%{rare%}//
/[ =_-]v<äl]ja .*PIIM/s/%{rare%}//
/[ =_-]<õlga .*PIIM/s/%{rare%}//
/[ =_-]n<el]ja .*PIIM/s/%{rare%}//


/[ _-]kr<iimu .*KOON/s/%{rare%}//
/[ _-]l<augu .*KOON/s/%{rare%}//
/[ _-]l<õppu .*KOON/s/%{rare%}//
/[ _-]n<artsu .*KOON/s/%{rare%}//
/[ _-]p<aksu .*KOON/s/%{rare%}//
/[ _-]p<irtsu .*KOON/s/%{rare%}//
/[ _-]h<ullu .*KOON/s/%{rare%}//
/[ _-]h<õrku .*KOON/s/%{rare%}//
/[ _-]<arvu .*KOON/s/%{rare%}//
/[ _-]<auku .*KOON/s/%{rare%}//
/[ _-]<auru .*KOON/s/%{rare%}//
/[ _-]<aeru .*KOON/s/%{rare%}//
/[ _-]departem<angu .*KOON/s/%{rare%}//
/[ _-]<ahju .*KOON/s/%{rare%}//
/[ _-]h<aisu .*KOON/s/%{rare%}//
/[ _-]h<algu .*KOON/s/%{rare%}//
/[ _-]h<ilpu .*KOON/s/%{rare%}//
/[ _-]h<irmu .*KOON/s/%{rare%}//
/[ _-]h<oogu .*KOON/s/%{rare%}//
/[ _-]h<õimu .*KOON/s/%{rare%}//
/[ _-]j<ooksu .*KOON/s/%{rare%}//
/[ _-]<ampsu .*KOON/s/%{rare%}//
/[ _-]k<akku .*KOON/s/%{rare%}//
/[ _-]k<almu .*KOON/s/%{rare%}//
/[ _-]k<altsu .*KOON/s/%{rare%}//
/[ _-]k<annu .*KOON/s/%{rare%}//
/[ _-]k<arku .*KOON/s/%{rare%}//
/[ _-]k<asvu .*KOON/s/%{rare%}//
/[ _-]k<eeldu .*KOON/s/%{rare%}//
/[ _-]k<empsu .*KOON/s/%{rare%}//
/[ _-]k<iiksu .*KOON/s/%{rare%}//
/[ _-]k<iilu .*KOON/s/%{rare%}//
/[ _-]k<ildu .*KOON/s/%{rare%}//
/[ _-]k<impu .*KOON/s/%{rare%}//
/[ _-]k<intsu .*KOON/s/%{rare%}//
/[ _-]k<irpu .*KOON/s/%{rare%}//
/[ _-]k<irstu .*KOON/s/%{rare%}//
/[ _-]k<iudu .*KOON/s/%{rare%}//
/[ _-]kl<õksu .*KOON/s/%{rare%}//
/[ _-]kl<õmmu .*KOON/s/%{rare%}//
/[ _-]kl<õpsu .*KOON/s/%{rare%}//
/[ _-]kn<iksu .*KOON/s/%{rare%}//
/[ _-]k<ompsu .*KOON/s/%{rare%}//
/[ _-]k<onksu .*KOON/s/%{rare%}//
/[ _-]k<ortsu .*KOON/s/%{rare%}//
/[ _-]kr<iipsu .*KOON/s/%{rare%}//
/[ _-]kr<iuksu .*KOON/s/%{rare%}//
/[ _-]kr<õksu .*KOON/s/%{rare%}//
/[ _-]kr<õpsu .*KOON/s/%{rare%}//
/[ _-]k?uberm<angu .*KOON/s/%{rare%}//
/[ _-]k<ulmu .*KOON/s/%{rare%}//
/[ _-]k<uppu .*KOON/s/%{rare%}//
/[ _-]k<õksu .*KOON/s/%{rare%}//
/[ _-]k<õlksu .*KOON/s/%{rare%}//
/[ _-]k<õpsu .*KOON/s/%{rare%}//
/[ _-]k<õõksu .*KOON/s/%{rare%}//
/[ _-]k<äiku .*KOON/s/%{rare%}//
/[ _-]k<ändu .*KOON/s/%{rare%}//
/[ _-]k<äntsu .*KOON/s/%{rare%}//
/[ _-]k<äsku .*KOON/s/%{rare%}//
/[ _-]k<ääksu .*KOON/s/%{rare%}//
/[ _-]k<äändu .*KOON/s/%{rare%}//
/[ _-]l<aastu .*KOON/s/%{rare%}//
/[ _-]l<aenu .*KOON/s/%{rare%}//
/[ _-]l<aiku .*KOON/s/%{rare%}//
/[ _-]l<aksu .*KOON/s/%{rare%}//
/[ _-]l<artsu .*KOON/s/%{rare%}//
/[ _-]l<asku .*KOON/s/%{rare%}//
/[ _-]l<aulu .*KOON/s/%{rare%}//
/[ _-]l<eidu .*KOON/s/%{rare%}//
/[ _-]l<endu .*KOON/s/%{rare%}//
/[ _-]l<iitu .*KOON/s/%{rare%}//
/[ _-]l<indu .*KOON/s/%{rare%}//
/[ _-]l<ippu .*KOON/s/%{rare%}//
/[ _-]l<ipsu .*KOON/s/%{rare%}//
/[ _-]l<irtsu .*KOON/s/%{rare%}//
/[ _-]l<iugu .*KOON/s/%{rare%}//
/[ _-]l<ohku .*KOON/s/%{rare%}//
/[ _-]l<oiku .*KOON/s/%{rare%}//
/[ _-]l<oitsu .*KOON/s/%{rare%}//
/[ _-]l<oksu .*KOON/s/%{rare%}//
/[ _-]l<onksu .*KOON/s/%{rare%}//
/[ _-]l<opsu .*KOON/s/%{rare%}//
/[ _-]l<uisku .*KOON/s/%{rare%}//
/[ _-]l<ukku .*KOON/s/%{rare%}//
/[ _-]l<upsu .*KOON/s/%{rare%}//
/[ _-]l<urtsu .*KOON/s/%{rare%}//
/[ _-]l<utsu .*KOON/s/%{rare%}//
/[ _-]l<õiku .*KOON/s/%{rare%}//
/[ _-]l<õivu .*KOON/s/%{rare%}//
/[ _-]l<õksu .*KOON/s/%{rare%}//
/[ _-]l<õmpsu .*KOON/s/%{rare%}//
/[ _-]l<õnksu .*KOON/s/%{rare%}//
/[ _-]l<ärtsu .*KOON/s/%{rare%}//
/[ _-]j<uhtu .*KOON/s/%{rare%}//
/[ _-]j<uttu .*KOON/s/%{rare%}//
/[ _-]j<õnksu .*KOON/s/%{rare%}//
/[ _-]j<õudu .*KOON/s/%{rare%}//
/[ _-]j<õuku .*KOON/s/%{rare%}//
/[ _-]j<õulu .*KOON/s/%{rare%}//
/[ _-]k<aalu .*KOON/s/%{rare%}//
/[ _-]k<aevu .*KOON/s/%{rare%}//
/[ _-]m<ahtu .*KOON/s/%{rare%}//
/[ _-]m<aimu .*KOON/s/%{rare%}//
/[ _-]m<aksu .*KOON/s/%{rare%}//
/[ _-]m<atsu .*KOON/s/%{rare%}//
/[ _-]m<uksu .*KOON/s/%{rare%}//
/[ _-]m<ulku .*KOON/s/%{rare%}//
/[ _-]m<ulksu .*KOON/s/%{rare%}//
/[ _-]m<urdu .*KOON/s/%{rare%}//
/[ _-]m<õõtu .*KOON/s/%{rare%}//
/[ _-]m<ängu .*KOON/s/%{rare%}//
/[ _-]m<ässu .*KOON/s/%{rare%}//
/[ _-]m<öllu .*KOON/s/%{rare%}//
/[ _-]m<üksu .*KOON/s/%{rare%}//
/[ _-]m<ürsku .*KOON/s/%{rare%}//
/[ _-]m<ürtsu .*KOON/s/%{rare%}//
/[ _-]m<ütsu .*KOON/s/%{rare%}//
/[ _-]n<aastu .*KOON/s/%{rare%}//
/[ _-]n<aeru .*KOON/s/%{rare%}//
/[ _-]n<aksu .*KOON/s/%{rare%}//
/[ _-]n<apsu .*KOON/s/%{rare%}//
/[ _-]n<eeru .*KOON/s/%{rare%}//
/[ _-]n<iitu .*KOON/s/%{rare%}//
/[ _-]n<ipsu .*KOON/s/%{rare%}//
/[ _-]n<iuksu .*KOON/s/%{rare%}//
/[ _-]n<ukku .*KOON/s/%{rare%}//
/[ _-]n<ulgu .*KOON/s/%{rare%}//
/[ _-]n<uttu .*KOON/s/%{rare%}//
/[ _-]n<uuksu .*KOON/s/%{rare%}//
/[ _-]n<õksu .*KOON/s/%{rare%}//
/[ _-]n<äitu .*KOON/s/%{rare%}//
/[ _-]n<äppu .*KOON/s/%{rare%}//
/[ _-]n<ätsu .*KOON/s/%{rare%}//
/[ _-]n<äuksu .*KOON/s/%{rare%}//
/[ _-]<orgu .*KOON/s/%{rare%}//
/[ _-]<ostu .*KOON/s/%{rare%}//
/[ _-]p<aastu .*KOON/s/%{rare%}//
/[ _-]p<aisu .*KOON/s/%{rare%}//
/[ _-]p<ampu .*KOON/s/%{rare%}//
/[ _-]p<armu .*KOON/s/%{rare%}//
/[ _-]p<artsu .*KOON/s/%{rare%}//
/[ _-]p<attu .*KOON/s/%{rare%}//
/[ _-]p<auku .*KOON/s/%{rare%}//
/[ _-]p<eergu .*KOON/s/%{rare%}//
/[ _-]p<iiksu .*KOON/s/%{rare%}//
/[ _-]p<iipu .*KOON/s/%{rare%}//
/[ _-]p<ilku .*KOON/s/%{rare%}//
/[ _-]p<indu .*KOON/s/%{rare%}//
/[ _-]p<irdu .*KOON/s/%{rare%}//
/[ _-]p<iuksu .*KOON/s/%{rare%}//
/[ _-]pl<aksu .*KOON/s/%{rare%}//
/[ _-]pl<anku .*KOON/s/%{rare%}//
/[ _-]pl<artsu .*KOON/s/%{rare%}//
/[ _-]pl<irtsu .*KOON/s/%{rare%}//
/[ _-]pl<õksu .*KOON/s/%{rare%}//
/[ _-]pl<ärtsu .*KOON/s/%{rare%}//
/[ _-]p<ortsu .*KOON/s/%{rare%}//
/[ _-]pr<aksu .*KOON/s/%{rare%}//
/[ _-]pr<ääksu .*KOON/s/%{rare%}//
/[ _-]p<õldu .*KOON/s/%{rare%}//
/[ _-]p<õntsu .*KOON/s/%{rare%}//
/[ _-]r<ahnu .*KOON/s/%{rare%}//
/[ _-]r<akku .*KOON/s/%{rare%}//
/[ _-]r<iidu .*KOON/s/%{rare%}//
/[ _-]r<opsu .*KOON/s/%{rare%}//
/[ _-]r<uutu .*KOON/s/%{rare%}//
/[ _-]r<õhku .*KOON/s/%{rare%}//
/[ _-]r<õõmu .*KOON/s/%{rare%}//
/[ _-]s<ammu .*KOON/s/%{rare%}//
/[ _-]s<antsu .*KOON/s/%{rare%}//
/[ _-]s<apsu .*KOON/s/%{rare%}//
/[ _-]s<eisu .*KOON/s/%{rare%}//
/[ _-]s<iilu .*KOON/s/%{rare%}//
/[ _-]s<ilku .*KOON/s/%{rare%}//
/[ _-]s<irtsu .*KOON/s/%{rare%}//
/[ _-]s<opsu .*KOON/s/%{rare%}//
/[ _-]s<ortsu .*KOON/s/%{rare%}//
/[ _-]s<uitsu .*KOON/s/%{rare%}//
/[ _-]s<ulgu .*KOON/s/%{rare%}//
/[ _-]s<ulksu .*KOON/s/%{rare%}//
/[ _-]s<ulpsu .*KOON/s/%{rare%}//
/[ _-]s<urtsu .*KOON/s/%{rare%}//
/[ _-]s<utsu .*KOON/s/%{rare%}//
/[ _-]s<õitu .*KOON/s/%{rare%}//
/[ _-]s<õõmu .*KOON/s/%{rare%}//
/[ _-]s<älku .*KOON/s/%{rare%}//
/[ _-]s<äästu .*KOON/s/%{rare%}//
/[ _-]s<ööstu .*KOON/s/%{rare%}//
/[ _-]s<öötu .*KOON/s/%{rare%}//
/[ _-]t<ahku .*KOON/s/%{rare%}//
/[ _-]t<angu .*KOON/s/%{rare%}//
/[ _-]t<antsu .*KOON/s/%{rare%}//
/[ _-]t<appu .*KOON/s/%{rare%}//
/[ _-]t<empu .*KOON/s/%{rare%}//
/[ _-]t<iiru .*KOON/s/%{rare%}//
/[ _-]t<ikku .*KOON/s/%{rare%}//
/[ _-]t<ingu .*KOON/s/%{rare%}//
/[ _-]t<ipsu .*KOON/s/%{rare%}//
/[ _-]t<irtsu .*KOON/s/%{rare%}//
/[ _-]t<oitu .*KOON/s/%{rare%}//
/[ _-]t<ompu .*KOON/s/%{rare%}//
/[ _-]t<onksu .*KOON/s/%{rare%}//
/[ _-]t<ortsu .*KOON/s/%{rare%}//
/[ _-]tr<iipu .*KOON/s/%{rare%}//
/[ _-]tr<ipsu .*KOON/s/%{rare%}//
/[ _-]tr<itsu .*KOON/s/%{rare%}//
/[ _-]t<uisku .*KOON/s/%{rare%}//
/[ _-]t<upsu .*KOON/s/%{rare%}//
/[ _-]t<urgu .*KOON/s/%{rare%}//
/[ _-]t<urtsu .*KOON/s/%{rare%}//
/[ _-]t<õugu .*KOON/s/%{rare%}//
/[ _-]t<õuku .*KOON/s/%{rare%}//
/[ _-]t<õusu .*KOON/s/%{rare%}//
/[ _-]t<örtsu .*KOON/s/%{rare%}//
/[ _-]<uisku .*KOON/s/%{rare%}//
/[ _-]<urgu .*KOON/s/%{rare%}//
/[ _-]<usku .*KOON/s/%{rare%}//
/[ _-]v<aimu .*KOON/s/%{rare%}//
/[ _-]v<alku .*KOON/s/%{rare%}//
/[ _-]l<iistu .*KOON/s/%{rare%}//
/[ _-]v<aistu .*KOON/s/%{rare%}//
/[ _-]v<arju .*KOON/s/%{rare%}//
/[ _-]v<eergu .*KOON/s/%{rare%}//
/[ _-]v<empu .*KOON/s/%{rare%}//
/[ _-]v<iirgu .*KOON/s/%{rare%}//
/[ _-]v<iisku .*KOON/s/%{rare%}//
/[ _-]v<iuksu .*KOON/s/%{rare%}//
/[ _-]v<olksu .*KOON/s/%{rare%}//
/[ _-]v<oogu .*KOON/s/%{rare%}//
/[ _-]v<oolu .*KOON/s/%{rare%}//
/[ _-]v<opsu .*KOON/s/%{rare%}//
/[ _-]v<ulksu .*KOON/s/%{rare%}//
/[ _-]v<õitu .*KOON/s/%{rare%}//
/[ _-]v<õrku .*KOON/s/%{rare%}//
/[ _-]n<utsu .*KOON/s/%{rare%}//
/[ _-]kl<eepsu .*KOON/s/%{rare%}//
/[ _-]s<äutsu .*KOON/s/%{rare%}//
/[ _-]t<ümpsu .*KOON/s/%{rare%}//

/[ =_-]h<ange .*EIT/s/%{rare%}//
/[ =_-]h<etke .*EIT/s/%{rare%}//
/[ =_-]h<inge .*EIT/s/%{rare%}//
/[ =_-]h<irve .*EIT/s/%{rare%}//
/[ =_-]k<aske .*EIT/s/%{rare%}//
/[ =_-]k<irge .*EIT/s/%{rare%}//
/[ =_-]k<itse .*EIT/s/%{rare%}//
/[ =_-]k<oske .*EIT/s/%{rare%}//
/[ =_-]k<ukke .*EIT/s/%{rare%}//
/[ =_-]k<urge .*EIT/s/%{rare%}//
/[ =_-]k<uuske .*EIT/s/%{rare%}//
/[ =_-]k<ül]ge .*EIT/s/%{rare%}//
/[ =_-]l<ehte .*EIT/s/%{rare%}//
/[ =_-]l<eske .*EIT/s/%{rare%}//
/[ =_-]l<ille .*EIT/s/%{rare%}//
/[ =_-]l<uike .*EIT/s/%{rare%}//
/[ =_-]l<õime .*EIT/s/%{rare%}//
/[ =_-]l<äätse .*EIT/s/%{rare%}//
/[ =_-]j<äl]ge .*EIT/s/%{rare%}//
/[ =_-]j<ärge .*EIT/s/%{rare%}//
/[ =_-]j<ärve .*EIT/s/%{rare%}//
/[ =_-]n<urme .*EIT/s/%{rare%}//
/[ =_-]p<arve .*EIT/s/%{rare%}//
/[ =_-]p<erve .*EIT/s/%{rare%}//
/[ =_-]p<ilve .*EIT/s/%{rare%}//
/[ =_-]p<õlve .*EIT/s/%{rare%}//
/[ =_-]p<õlve .*EIT/s/%{rare%}//
/[ =_-]p<õske .*EIT/s/%{rare%}//
/[ =_-]r<etke .*EIT/s/%{rare%}//
/[ =_-]r<äime .*EIT/s/%{rare%}//
/[ =_-]s<arve .*EIT/s/%{rare%}//
/[ =_-]s<õime .*EIT/s/%{rare%}//
/[ =_-]s<õlme .*EIT/s/%{rare%}//
/[ =_-]s<õrme .*EIT/s/%{rare%}//
/[ =_-]s<ärge .*EIT/s/%{rare%}//
/[ =_-]s<ääske .*EIT/s/%{rare%}//
/[ =_-]s<ül]ge .*EIT/s/%{rare%}//
/[ =_-]t<aime .*EIT/s/%{rare%}//
/[ =_-]t<amme .*EIT/s/%{rare%}//
/[ =_-]t<el]ge .*EIT/s/%{rare%}//
/[ =_-]t<ähte .*EIT/s/%{rare%}//
/[ =_-]<uime .*EIT/s/%{rare%}//
/[ =_-]v<el]ge .*EIT/s/%{rare%}//
/[ =_-]<õlge .*EIT/s/%{rare%}//
/[ =_-]<õnge .*EIT/s/%{rare%}//

/[ =_-]koju .*@KAVA/s/@KAVA/@KODU/
/@KODU/s/%{stemill%}//
/@KODU/s/koJ1D1u/ko/
/[ =_-]<as]ja .*@PIIM/s/@PIIM/@ASI/
/[ =_-]p<aika .*@PIIM/s/@PIIM/@ASI/
/p<äev .*@PIIM/s/@PIIM/@PÄEV/
/k<ond .*@PIIM/s/@PIIM/@PÄEV/
/^osa .*@KAVA/s/@KAVA/@OSA/
/[ =_-]osa .*@KAVA/s/@KAVA/@OSA/
/[ =_-]r<inda .*@PIIM/s/@PIIM/@RIND/
/[ =_-]s<ilma .*@PIIM/s/@PIIM/@SILM/
/j<alg .*@PIIM/s/@PIIM/@JALG/
/p<õlv .*@EIT/s/@EIT/@PÕLV/
/t<alv .*@EIT/s/@EIT/@TALV/
/p<õlv .*@PÕLV/s/:p<*õlv/:p<õl/
/t<alv .*@TALV/s/:t<*alv/:t<al/
/tervis .*@SOOLANE/s/@SOOLANE/@KATKINE/

s/^\([^ ]*\) .*@ELANIK/& \1:\1/

/[ =_-]<ümbr<ik .*@ELANIK/s/@ELANIK/@ÜMBRIK/
/^<ümbr<ik .*@ELANIK/s/@ELANIK/@ÜMBRIK/
/ümbrik .*@VIRSIK/s/^.*$//

/[ =_-]pealik .*@VIRSIK/s/@VIRSIK/@ÜMBRIK/
/^pealik .*@VIRSIK/s/@VIRSIK/@ÜMBRIK/
/[ =_-][^aeiouõäöü ]*<[aeiouõäöü]*[^aeiouõäöü ]*<ikku .*@ELANIK/s/@ELANIK/@ÄMBLIK/

/p<*ea .*ADT\$: [^\-].*ARMEE/s/^\([^ ]*p<*\)ea\( .*@\)ARMEE/\1ea\2PUU \1ea:\1E6A6H3Y3%>%{id%}%{stemill%}/
/@.*:/!s/^\([^ ]*p<*\)ea\( .*@\)ARMEE/& \1ea:\1E6A6%>%{id%}/
/h<*ea .*PL\.P.*ARMEE/s/^\([^ ]*\)ea\( .*@\)ARMEE/\1ea\2PUU \1ea:\1E6A6%>%{id%}/
/s<*oo .*ADT.*ARMEE/s/^\([^ ]*\)\( .*@\)ARMEE/\1\2PUU \1:\1H3Y3%>%{id%}%{stemill%}/
/s<*uu .*ADT.*ARMEE/s/^\([^ ]*\)\( .*@\)ARMEE/\1\2PUU \1:\1H3Y3%>%{id%}%{stemill%}/
/<*öö .*ADT.*ARMEE/s/^\([^ ]*\)\( .*@\)ARMEE/\1\2PUU \1:\1H3Y3%>%{id%}%{stemill%}%{rare%}/
/@.*:/!s/^\([^ ]*\) .*[aouö]>.*@ARMEE/& \1:\1%>%{id%}/
/@.*:/!s/^\([^ ]*\) .*ee>e.*@ARMEE/& \1:\1%>%{id%}%{rare%}/
/@.*:/!s/^\([^ ]*\) .*@ARMEE/& \1:\1/

/^id<ee .*ARMEE/s/%{rare%}//
/[ =_-]id<ee .*ARMEE/s/%{rare%}//
/^t<ee .*ARMEE/s/%{rare%}//
/[ =_-]t<ee .*ARMEE/s/%{rare%}//
/_m<aa .*ARMEE.*m<aa$/s/$/%{id%}/
/_k<uu .*ARMEE.*k<uu$/s/$/%{id%}/

/\.26.*ARMEE.*%{id%}$/s/ARMEE/PUU/

/\\H.*ADT.*@AASTA/s/$/%{stemill%}/

/r<uum .*@TAUD/s/TAUD/RUUM/
/^p<iir .*@TAUD/s/TAUD/RUUM/
/[ =_-]p<iir .*@TAUD/s/TAUD/RUUM/
/t<iib .*@PIIM/s/PIIM/ASI/
/k<õrv .*@PIIM/s/PIIM/ASI/
/mari .*@PIIM/s/PIIM/ASI/

/MUUSEUM.*ua[lmnr]:/s/MUUSEUM/TAUD/


