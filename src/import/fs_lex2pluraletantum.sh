#!/bin/sh
# plurale tantum sõnad
# filtri remove-sg-forms.est jaoks
# hääldusmärgid ei jää sisse (aga kas peaks ???)
# liitsõna osade vaheline piir _ läheb #-ks

#echo '# remove Sg forms of plurale tantum words' > remove-sg-forms.est.xfscript
#echo '#' >> remove-sg-forms.est.xfscript
#echo 'define plwords [' >> remove-sg-forms.est.xfscript


cat algtmp \
| grep '\\H' \
| grep 'ÕIGEVORM' \
| sed 's/^.* \([^ ]*\)ÕIGEVORM.*$/\1/' \
| sed 's/#//g' \
| sed 's/D$/d/' \
| sed 's/[]_<?]//g' \
| sed 's/\[//g' \
| sed 's/^.*$/               \[ {&}  "+N" "+Prop" \] \| /' \
| sort \
> tmp1_h.remove-sg-forms.est.xfscript

cat algtmp \
| grep -v '\\H' \
| grep 'ÕIGEVORM' \
| sed 's/^.* \([^ ]*\)ÕIGEVORM.*$/\1/' \
| sed 's/#//g' \
| sed 's/D$/d/' \
| sed 's/[]_<?]//g' \
| sed 's/\[//g' \
| sed 's/^.*$/               \[ {&}  "+N" \] \| /' \
| sort \
> tmp1_mitteh.remove-sg-forms.est.xfscript

# manually insert the lists to ../filters/remove-sg-forms.est.xfscript
exit


cat fs_lex \
| grep '^[^ ]*\[D' \
| sed 's/^[^|]*|//' \
| sed 's/!.*$//' \
| sed 's/D/d/' \
| sed 's/_/#/g' \
| sed 's/[]_<?]//g' \
| sed 's/\[//g' \
| sed 's/^.*$/               {&} \| /' \
> tmp2.remove-sg-forms.est.xfscript

cat tmp1.remove-sg-forms.est.xfscript tmp2.remove-sg-forms.est.xfscript \
| sort > tmp.remove-sg-forms.est.xfscript

cat tmp.remove-sg-forms.est.xfscript \
| sed '$s/}.*$/} ] ;/' \
>> remove-sg-forms.est.xfscript

echo 'define SG [ "+Sg" ] ;' >> remove-sg-forms.est.xfscript
echo '' >> remove-sg-forms.est.xfscript
echo '# make sure only word-final components are considered' >> remove-sg-forms.est.xfscript
echo 'define WB [ "#" ] ;' >> remove-sg-forms.est.xfscript
echo 'define lexical [ plwords [\WB]* SG [\WB]+ ] ;' >> remove-sg-forms.est.xfscript
echo '' >> remove-sg-forms.est.xfscript
echo 'regex ~[lexical].i ;' >> remove-sg-forms.est.xfscript

rm tmp.remove-sg-forms.est.xfscript
# cp remove-sg-forms.est.xfscript ../filters/remove-sg-forms.est.xfscript

exit

# kui hääldusmärgid jääksid sisse, siis niimoodi:
# | sed 'y/_<?]/#´`,/' \

