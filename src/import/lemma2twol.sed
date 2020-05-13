#!/bin/sed -f

/@/s/\(g[aeiu][^aeiuõäöü]*:.*\)k\([AEIU]2\)/\1K2\2/
/@/s/\(b[aeiu][^aeiuõäöü]*:.*\)p\([AEIU]2\)/\1P2\2/
/@/s/\(d[aeiu][^aeiuõäöü]*:.*\)t\([AEIU]2\)/\1T2\2/
/@/s/\(d[i][^aeiuõäöü]*:.*\)t\(i\)/\1T2\2/
/@/s/\([lmnr]\)\(\]*[lmnr][aeiu][^aeiuõäöü]*:.*\)g\([AEIU]2\)/\1\2\1G1\3/
/@/s/\([lmnr]\)\(\]*[lmnr][aeiu][^aeiuõäöü]*:.*\)b\([AEIU]2\)/\1\2\1B1\3/
/@/s/\([lmnr]\)\(\]*[lmnr][aeiu][^aeiuõäöü]*:.*\)d\([AEIU]2\)/\1\2\1D1\3/
/@/s/\([aeiouõäöü]\)\([aeiu][^aeiuõäöü]*:.*\)g\([AEIU]2\)/\1\2G1\3/
/@/s/\([aeiouõäöü]\)\([aeiu][^aeiuõäöü]*:.*\)b\([AEIU]2\)/\1\2B1\3/
/@/s/\([aeiouõäöü]\)\([aeiu][^aeiuõäöü]*:.*\)d\([AEIU]2\)/\1\2D1\3/
/@[PK]/s/\([^k]k[aeiu][^aeiuõäöü]*:.*k\)k\([AEIU]2\)/\1K1\2/
/@/s/\([^p]p[aeiu][^aeiuõäöü]*:.*p\)p\([AEIU]2\)/\1P1\2/
/@/s/\([^t]t[aeiu][^aeiuõäöü]*:.*t\)t\([AEIU]2\)/\1T1\2/
/@/s/\([hs][aeiu][^aeiuõäöü]*:.*[hs]\)k\([AEIU]2\)/\1K1\2/
/@/s/\([hs][aeiu][^aeiuõäöü]*:.*[hs]\)p\([AEIU]2\)/\1P1\2/
/@/s/\([hs][aeiu][^aeiuõäöü]*:.*[hs]\)t\([AEIU]2\)/\1T1\2/
/@/s/\(j[aeiu][^aeiuõäöü]*:.*\)g\([AEIU]2\)/\1J1G1\2/
/@/s/\(j[aeiu][^aeiuõäöü]*:.*\)d\([AEIU]2\)/\1J1D1\2/
/@/s/\(v[aeiu][^aeiuõäöü]*:.*\)b\([AEIU]2\)/\1B2\2/
/@/s/\(g[aeiu][^aeiuõäöü]*:.*\)k\([aeiu]\)$/\1K2\2/
/@/s/\(b[aeiu][^aeiuõäöü]*:.*\)p\([aeiu]\)$/\1P2\2/
/@/s/\(d[aeiu][^aeiuõäöü]*:.*\)t\([aeiu]\)$/\1T2\2/
/@/s/\(b[lrj][aeiu][^aeiuõäöü]*:.*\)p\([lrj][aeiu]\)$/\1P2\2/
/@/s/\([lmnr]\)\(\]*[lmnr][aeiu][^aeiuõäöü]*:.*\)g\([aeiu]\)$/\1\2\1G1\3/
/@/s/\([lmnr]\)\(\]*[lmnr][aeiu][^aeiuõäöü]*:.*\)b\([aeiu]\)$/\1\2\1B1\3/
/@/s/\([lmnr]\)\(\]*[lmnr][aeiu][^aeiuõäöü]*:.*\)d\([aeiu]\)$/\1\2\1D1\3/
/@/s/\([aeiouõäöü]\)\([aeiu][^aeiuõäöü]*:.*\)g\([aeiu]\)$/\1\2G1\3/
/@/s/\([aeiouõäöü]\)\([aeiu][^aeiuõäöü]*:.*\)b\([aeiu]\)$/\1\2B1\3/
/@/s/\([aeiouõäöü]\)\([aeiu][^aeiuõäöü]*:.*\)d\([aeiu]\)$/\1\2D1\3/
/@/s/\([^k]k[aeiu][^aeiuõäöü]*:.*k\)k\([aeiu]\)$/\1K1\2/
/@/s/\([^k]k[i][^aeiuõäöü]*:.*k\)k\(i\)$/\1K1\2/
/@/s/\([^p]p[aeiu][^aeiuõäöü]*:.*p\)p\([aeiu]\)$/\1P1\2/
/@/s/\([^t]t[aeiu][^aeiuõäöü]*:.*t\)t\([aeiu]\)$/\1T1\2/
/@/s/\([hs][aeiu][^aeiuõäöü]*:.*[hs]\)k\([aeiu]\)$/\1K1\2/
/@/s/\([hs][aeiu][^aeiuõäöü]*:.*[hs]\)p\([aeiu]\)$/\1P1\2/
/@/s/\([hs][aeiu][^aeiuõäöü]*:.*[hs]\)t\([aeiu]\)$/\1T1\2/
/@/s/\(j[aeiu][^aeiuõäöü]*:.*\)g\([aeiu]\)$/\1J1G1\2/
/@/s/\(j[aeiu][^aeiuõäöü]*:.*\)d\([aeiu]\)$/\1J1D1\2/
/@/s/\(v[aeiu][^aeiuõäöü]*:.*\)b\([aeiu]\)$/\1B2\2/

/@/s/\(.\)\([aeiu]\)\([^aeiuõäöü]*:.*\)\1g\2$/\1\2\3\1G1\2/
/@/s/\(.\)\([aeiu]\)\([^aeiuõäöü]*:.*\)\1b\2$/\1\2\3\1B1\2/
/@/s/\(.\)\([aeiu]\)\([^aeiuõäöü]*:.*\)\1d\2$/\1\2\3\1D1\2/

/@/s/’:/:/
/@/s/’$/%{apo%}/
/’i .*@TAUD/s/$/%{apo%}/



