#!/bin/sh
# convert Filosoft's sufix file to GT
# excluding real suffixes, but including words that often act as last components in compounds

echo 'LEXICON FinalComponents\n' > final_components.lexc

cat fs_suf \
| grep -v '|F' \
| sed 's/suf:[^|]*|//' \
| sed 's/ .*$//' \
| sed 's/!.*$//' \
| sed 's/[]<?]//g' \
| sed 's/^\([^@]*\)@\(.*\)$/\2 :\1/' \
| LC_COLLATE=C sort | sed 's/ :/_/' \
> suf.tmp1

grep ':' ../morphology/stems/*.lexc \
| grep -v '\/pref' \
| grep -v '\/final' \
| sed 's/^[^:]*://' \
| sed 's/^  *\([^ ]\)/\1/' \
| sed '/@/s/^\([^:]*@\)\([^@:+][^@:+]*\)\(+.*\)$/\2 _\1\2\3/' \
| sed '/@/!s/^\([^:+][^:+]*\)\(+.*\)$/\1 _\1\2/' \
| LC_COLLATE=C sort | sed 's/ _/_/' \
> lexicon.tmp1

LC_COLLATE=C join -a 1 -a 2 -e "###" -t _  -o 1.2 2.2 suf.tmp1 lexicon.tmp1 > suf_lexicon.tmp1

cat suf_lexicon.tmp1 \
| grep -v '###' \
| sed 's/-0=0_/_/' \
| LC_COLLATE=C sort \
| grep -v 'pealt+Adp' \
| grep -v 'mööda+Adp' \
| sed 's/+Adp/+Adv/' \
| sed '/pidi+Adv/s/+0/+t/' \
| grep -v 'taoline+Pron' \
| grep -v 'mööda+A' \
| sed '/mööda/s/+0/+t/' \
| sed '/hoog/s/+0/+d/' \
| grep -v 'juht+.*KOON' \
| grep -v 'jutt+.*TAUD' \
| grep -v 'kohus+.*KOHUS' \
| grep -v 'kool+.*PIIM' \
| grep -v 'kott+.*PIIM' \
| grep -v 'lamp+A.' \
| grep -v 'loom+.*KOON' \
| grep -v 'maks+.*PIIM' \
| grep -v 'pakk+.*KOON' \
| grep -v 'pind+.*KOON' \
| grep -v 'silm+.*KOON' \
| grep -v 'kogu+A' \
| grep -v 'kord+Adv' \
| grep -v 'pea+Adv' \
| grep -v 'täis+A' \
| grep -v 'vastane+N' \
| grep -v 'juht+.*KOON' \
> suf_lexicon.tmp2

echo '\nLEXICON FinalComponents\n' > final_components.lexc
echo '  @R.POS.IntNum@@R.Case.Nom@ AdjAfterNumeralNom ;' >> final_components.lexc
#echo '  @R.POS.NumCard@@R.Case.Gen@ AfterNumeralGen ;' >> final_components.lexc
#echo ' @R.POS.A@@R.Case.Gen@ AfterAdjectiveGen ;\n' >> final_components.lexc
#echo ' @R.POS.AComp@@R.Case.Gen@ AfterCompAdjectiveGen ;\n' >> final_components.lexc
echo '  @R.POS.IntNum@@R.Case.Gen@@P.POS.Adv@ AdvAfterNumeral ;' >> final_components.lexc
echo '  @R.POS.N@@P.POS.N@@C.Der@@C.Stem@ NounFinalComp ;  ! insufficient flag diacritics' >> final_components.lexc
echo '  @R.POS.N@@R.Case.Nom@@P.POS.Adv@@C.Der@@C.Stem@ AdvAfterNounNom ;' >> final_components.lexc
echo '  @R.POS.N@@R.Case.Gen@@P.POS.Adv@@C.Der@@C.Stem@ AdvAfterNounGen ;' >> final_components.lexc
echo '  @R.POS.N@@R.Case.Par@@P.POS.Adv@@C.Der@@C.Stem@ AdvAfterNounPar ;' >> final_components.lexc
echo '  @R.POS.GA@@P.POS.A@ AdjAfterGenAttrib ;' >> final_components.lexc
echo '  @R.POS.A@@R.Case.Gen@@P.POS.A@@C.Der@@C.Stem@ AdjAfterAdjGen ;' >> final_components.lexc
echo '  @R.POS.AComp@@R.Case.Gen@@P.POS.A@@C.Der@@C.Stem@ AdjAfterAdjGen ;' >> final_components.lexc
echo '  @R.POS.AComp@@R.Case.Short@@P.POS.A@@C.Der@@C.Stem@ VäärtFinal ;' >> final_components.lexc


echo '\nLEXICON AdjAfterNumeralNom\n' >> final_components.lexc
cat suf_lexicon.tmp2 | grep '+A:' | grep '^N+0_' | sed 's/^N+0_//' >> final_components.lexc

#echo '\nLEXICON AfterNumeralGen\n' >> final_components.lexc
#cat suf_lexicon.tmp2 | grep '^N+0_' | sed 's/^N+0_//' >> final_components.lexc
#cat suf_lexicon.tmp2 | grep '^SN+0_' | sed 's/^SN+0_//' >> final_components.lexc
#cat suf_lexicon.tmp2 | grep '^N+d_' | sed 's/^N+d_//' >> final_components.lexc
#cat suf_lexicon.tmp2 | grep '^SN+d_' | sed 's/^SN+d_//' >> final_components.lexc
#cat suf_lexicon.tmp2 | grep '^SABCGN+d_' | sed 's/^SABCGN+d_//' >> final_components.lexc

echo '\nLEXICON AdvAfterNumeral\n' >> final_components.lexc
cat suf_lexicon.tmp2 | grep 'kaupa+Adv' | sed 's/^.*_//' >> final_components.lexc

#echo '\nLEXICON AfterAdjectiveGen\n' >> final_components.lexc
#cat suf_lexicon.tmp2 | grep '^AB+d_' | sed 's/^AB+d_//' >> final_components.lexc
# poolne cat suf_lexicon.tmp2 | grep '^SABCGN+d_' | sed 's/^SABCGN+d_//' >> final_components.lexc

#echo '\nLEXICON AfterCompAdjectiveGen\n' >> final_components.lexc
#cat suf_lexicon.tmp2 | grep '^AB+d_' | sed 's/^AB+d_//' >> final_components.lexc
# poolne cat suf_lexicon.tmp2 | grep '^SABCGN+d_' | sed 's/^SABCGN+d_//' >> final_components.lexc

echo '\nLEXICON NounFinalComp\n' >> final_components.lexc
cat suf_lexicon.tmp2 | grep '+N' | grep '^S+0_' | sed 's/^S+0_//' >> final_components.lexc
cat suf_lexicon.tmp2 | grep '+N' | grep '^SD+0_' | sed 's/^SD+0_//' >> final_components.lexc
cat suf_lexicon.tmp2 | grep '+N' | grep '^SN+0_' | sed 's/^SN+0_//' >> final_components.lexc

echo '\nLEXICON AdvAfterNounNom\n' >> final_components.lexc
cat suf_lexicon.tmp2 | grep '+Adv' | grep '^S+0_' | sed 's/^S+0_//' >> final_components.lexc
cat suf_lexicon.tmp2 | grep '+Adv' | grep '^SD+0_' | sed 's/^SD+0_//' >> final_components.lexc
cat suf_lexicon.tmp2 | grep '+Adv' | grep '^SN+0_' | sed 's/^SN+0_//' >> final_components.lexc

echo '\nLEXICON AdvAfterNounGen\n' >> final_components.lexc
cat suf_lexicon.tmp2 | grep '^S+0_' | sed 's/^S+0_//' | grep -v '+[NA]:' >> final_components.lexc
cat suf_lexicon.tmp2 | grep '^SD+0_' | sed 's/^SD+0_//' | grep -v '+[NA]:' >> final_components.lexc
cat suf_lexicon.tmp2 | grep '^SN+0_' | sed 's/^SN+0_//' | grep -v '+[NA]:' >> final_components.lexc
cat suf_lexicon.tmp2 | grep '^S+d_' | sed 's/^S+d_//' | grep -v '+[NA]:' >> final_components.lexc
cat suf_lexicon.tmp2 | grep '^SN+d_' | sed 's/^SN+d_//' | grep -v '+[NA]:' >> final_components.lexc
cat suf_lexicon.tmp2 | grep '^SABCGN+d_' | sed 's/^SABCGN+d_//' | grep -v '+[NA]:' >> final_components.lexc

echo '\nLEXICON AdvAfterNounPar\n' >> final_components.lexc
cat suf_lexicon.tmp2 | grep '^SN+t_' | sed 's/^SN+t_//' >> final_components.lexc
echo 'mööda+Adv:m´ööda # ;' >> final_components.lexc

echo '\nLEXICON AdjAfterGenAttrib\n' >> final_components.lexc
cat suf_lexicon.tmp2 | grep '^SABCGN+d_' | sed 's/^SABCGN+d_//' >> final_components.lexc
cat suf_lexicon.tmp2 | grep '^SG+d_' | sed 's/^SG+d_//' >> final_components.lexc

echo '\nLEXICON AdjAfterAdjGen\n' >> final_components.lexc
echo 'karva+A:k´arva GI ;' >> final_components.lexc
echo 'võitu+A:v´õitu GI ;' >> final_components.lexc
echo 'värvi+A:v´ärvi GI ;' >> final_components.lexc
echo 'moodi+A:m´ood,i GI ;' >> final_components.lexc
echo 'kasvu+A:k´asvu GI ;' >> final_components.lexc

echo '\nLEXICON VäärtFinal\n' >> final_components.lexc
echo 'väärt+A:v´äärt GI ;' >> final_components.lexc

exit

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
echo 'laiatarbe+Pref:laia#t´arbe- #;' >> pref.lexc
echo 'linnalähi+Pref:linna#lähi- #;' >> pref.lexc
echo 'nõuka+Pref:nõuka- #;' >> pref.lexc
echo 'väli+Pref:väli- #;' >> pref.lexc
echo 'põhi+Pref:põhi- #;' >> pref.lexc
echo 'pöörd+Pref:pöörd- #;' >> pref.lexc
echo 'sega+Pref:sega- #;' >> pref.lexc
echo 'puhke+Pref:p´uhke- #;' >> pref.lexc
echo 'vääris+Pref:vääris- #;' >> pref.lexc

cat pref.lexc | sort -u >> prefixes.lexc

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
 
 





