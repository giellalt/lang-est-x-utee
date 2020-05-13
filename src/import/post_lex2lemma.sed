#!/bin/sed -f

/VARS/s/$/%{stemill%}/
/k<ir.DE@VARS/s/%{stemill%}//
/[ _-][k]*<õr.DE@VARS/s/%{stemill%}/&%{rare%}/
/k<üün.DE@VARS/s/%{stemill%}/&%{rare%}/
/k<aan.DE@VARS/s/%{stemill%}//
/n<ii.DE@VARS/s/%{stemill%}//
/p<ar.DE@VARS/s/%{stemill%}//
/t<õr.DE@VARS/s/%{stemill%}/&%{rare%}/
/v<ar.DE@VARS/s/%{stemill%}/&%{rare%}/
/v<oo.DE@VARS/s/%{stemill%}//

/KEEL/s/$/%{stemill%}/
/h<iir.DE@KEEL/s/%{stemill%}//
/k<iir.DE@KEEL/s/%{stemill%}/&%{rare%}/
/l<een.DE@KEEL/s/%{stemill%}/&%{rare%}/
/j<uur.DE@KEEL/s/%{stemill%}//
/n<ool.DE@KEEL/s/%{stemill%}/&%{rare%}/
/s<aar.DE@KEEL/s/%{stemill%}/&/
/\-\-@KEEL/s/%{stemill%}//

/[ _]h<aarde .*@PINGE/s/$/%{stemill%}/
/[ _]h<oolde .*@PINGE/s/$/%{stemill%}/
/[ _]k<ütte .*@PINGE/s/$/%{stemill%}/
/[ _]p<alge .*@PINGE/s/$/%{stemill%}/
/[ _]r<iide .*@PINGE/s/$/%{stemill%}/
/[ _]r<ooste .*@PINGE/s/$/%{stemill%}/
/[ _]t<oime .*@PINGE/s/$/%{stemill%}/
/[ _]t<äkke .*@PINGE/s/$/%{stemill%}/
/[ _]r<akke .*@PINGE/s/$/%{stemill%}%{rare%}/
/[ _]<ehte .*@PINGE/s/$/%{stemill%}%{rare%}/
/[ _]k<ütke .*@PINGE/s/$/%{stemill%}%{rare%}/
/[ _]v<erme .*@PINGE/s/$/%{stemill%}%{rare%}/

/[ _]k<iila /s/$/%{stemill%}/
/[ _]p<õõsa /s/$/%{stemill%}%{rare%}/
/[ _]r<oopa /s/$/%{stemill%}%{rare%}/
/[ _]r<ukki /s/$/%{stemill%}%{rare%}/
/[ _]r<äästa /s/$/%{stemill%}%{rare%}/
/[ _]r<ööpa /s/$/%{stemill%}%{rare%}/
/[ _]t<aeva /s/$/%{stemill%}%{rare%}/
/[ _]t<eiba /s/$/%{stemill%}%{rare%}/
/[ _]v<arda /s/$/%{stemill%}%{rare%}/

/b<uldog /s/$/%{stemill%}%{rare%}/
/[ _]h<amba /s/$/%{stemill%}%{rare%}/
/[ _]kr<emli /s/$/%{stemill%}%{rare%}/
/[ _]p<ärli /s/$/%{stemill%}%{rare%}/
/[ _]k<ütke /s/$/%{stemill%}%{rare%}/
/p<õrgu /s/$/%{stemill%}/
/t<asku /s/$/%{stemill%}/

/<aed:/s/PIIM\(.*\)aJ1D1.*$/AED\1a/

s/D1J1/J1D1/

