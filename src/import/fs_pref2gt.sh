#!/bin/sh
# convert Filosoft's prefix file to GT

echo 'LEXICON Prefixes\n' > prefixes.lexc

cat pref.pok \
| sed 's/^.*@//' \
| sed 's/,H.*$//' \
| sed 's/<//g' \
| sed 's/\]//g' \
| sed 's/?//g' \
| paste - pref.pok \
| grep -v 'Z' \
| tr '\t' '\n' \
| hfst-lookup ../analyser-gt-desc.hfstol \
| sed '/^6000/s/,.*$/_/' \
| tr -d '\n' \
| sed 's/_/\n/g' \
| grep '+?' \
| sed 's/^\([^\t]*\)\t.*@\(.*\)$/\1+Pref:\2- #;/' \
| ./diacritics.sed \
>  pref.lexc

echo 'ainu+Pref:ainu- #;' >> pref.lexc
echo 'esi+Pref:esi- #;' >> pref.lexc
echo 'ees+Pref:´ees- #;' >> pref.lexc
echo 'eel+Pref:´eel- #;' >> pref.lexc
echo 'ime+Pref:ime- #;' >> pref.lexc

echo 'alg+Pref:´alg- #;' >> pref.lexc
echo 'all+Pref:´all- #;' >> pref.lexc
echo 'alla+Pref:´alla- #;' >> pref.lexc
echo 'alpi+Pref:al,pi- #;' >> pref.lexc
echo 'anti+Pref:an,ti- #;' >> pref.lexc
echo 'eht+Pref:´eht- #;' >> pref.lexc
echo 'eks+Pref:´eks- #;' >> pref.lexc
echo 'emas+Pref:emas- #;' >> pref.lexc
echo 'era+Pref:era- #;' >> pref.lexc
#echo 'eri+Pref:eri- #;' >> pref.lexc
echo 'euro+Pref:euro- #;' >> pref.lexc
echo 'finants+Pref:fin`an,ts- #;' >> pref.lexc
echo 'haju+Pref:haju- #;' >> pref.lexc
echo 'hulgi+Pref:hul,gi- #;' >> pref.lexc
echo 'jae+Pref:j´ae- #;' >> pref.lexc
echo 'isas+Pref:isas- #;' >> pref.lexc
echo 'kesk+Pref:k´esk- #;' >> pref.lexc
echo 'kvaasi+Pref:kvaasi- #;' >> pref.lexc
echo 'külalis+Pref:külalis- #;' >> pref.lexc
echo 'laus+Pref:l´aus- #;' >> pref.lexc
echo 'lõhke+Pref:l´õhke- #;' >> pref.lexc
echo 'meelis+Pref:meelis- #;' >> pref.lexc
#echo 'mega+Pref:mega- #;' >> pref.lexc
echo 'mitte+Pref:m´itte- #;' >> pref.lexc
echo 'muidu+Pref:muidu- #;' >> pref.lexc
echo 'multi+Pref:mul,ti- #;' >> pref.lexc
echo 'nais+Pref:n´ais- #;' >> pref.lexc
echo 'süva+Pref:süva- #;' >> pref.lexc
echo 'lühimaa+Pref:lühi#m´aa- #;' >> pref.lexc
echo 'pikamaa+Pref:pika#m´aa- #;' >> pref.lexc
#echo 'laiatarbe+Pref:laia#t´arbe- #;' >> pref.lexc
echo 'linnalähi+Pref:linna#lähi- #;' >> pref.lexc
echo 'nõuka+Pref:nõuka- #;' >> pref.lexc
echo 'väli+Pref:väli- #;' >> pref.lexc
echo 'põhi+Pref:põhi- #;' >> pref.lexc
echo 'pöörd+Pref:pöörd- #;' >> pref.lexc
echo 'sega+Pref:sega- #;' >> pref.lexc
echo 'puhke+Pref:p´uhke- #;' >> pref.lexc
echo 'vääris+Pref:vääris- #;' >> pref.lexc
echo 'toor+Pref:toor- #;' >> pref.lexc
echo 'lühi+Pref:lühi- #;' >> pref.lexc
echo 'puhtavee+Pref:p´uhta#v´ee- #;' >> pref.lexc

# 15.02.2019 olid need miskipärast svn-i versiooni failis prefixes.lexc olemas, aga programm neid ei tekitanud... 
echo 'geo+Pref:g´eo- #;' >> pref.lexc
echo 'intiim+Pref:intiim- #;' >> pref.lexc
echo 'isoleer+Pref:isoleer- #;' >> pref.lexc
echo 'meteo+Pref:meteo- #;' >> pref.lexc
echo 'neo+Pref:n´eo- #;' >> pref.lexc
echo 'nüüdis+Pref:nüüdis- #;' >> pref.lexc
echo 'paleo+Pref:paleo- #;' >> pref.lexc
echo 'polaar+Pref:pol´aar- #;' >> pref.lexc
echo 'poliit+Pref:pol´iit- #;' >> pref.lexc
echo 'raid+Pref:r´aid- #;' >> pref.lexc

cat pref.lexc | sort -u | sed 's/\- #/»&/' >> prefixes.lexc

cp prefixes.lexc ../morphology/stems

exit

cat pref.pok \
| sed 's/^.*@//' \
| sed 's/,H.*$//' \
| sed 's/<//g' \
| sed 's/\]//g' \
| sed 's/?//g' \
| hfst-lookup ../analyser-gt-desc.hfstol \
| grep '?' | tr '\t' '_' | grep -v '^de_' | grep -v '^re_' \
| sed 's/_.*$//' \
| sed 's/^.*$/&+Pref:&- #;/' \ 
> prefixes.lexc


| sed 's/^6000.*@/@/' | sed '/@/s/,.*$/_/' \

------
eriti liituvad 
alg all alla anti eel ees eht+adj eks emas enam enama+adj enese+adj enim+adj era eri esi ette+adj? euro
finants haju hulgi hüper isas ise? jae jooksev? järel kesk kõrval käsitsi? külalis laus lõhke meelis mega mitte
muidu multi mõne+adj nais

lisasin prefiksite hulka, nii et nüüd on veel lisamata:
enam enama+adj enese+adj enim+adj ette+adj? ise? jooksev? järel kõrval käsitsi? mõne+adj

verbile liituvad
alles edasi eraldi halvasti juurde järele kaotsi? kaua kaugele kergelt kergesti kindlaks kinni klaariks? kõrgelt kõvaks kõrvuti+adj? külili laiali ligi läbi lähedal

lisasin adv faili, nii et nüüd on veel lisamata:
 lähedal

deverbid
kandlus
 
 





