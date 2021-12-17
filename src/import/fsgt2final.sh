#!/bin/sh
# NB! run in the import dir where the source files are, i.e. ./fsgt2final.sh
# NB! leia_osad.sh must have generated head_esiosad, the file with good noun first parts of compounds

cat fs_gt.noninfl \
| sed 's/""/\n/g' \
| sed 's/^[^|]*| //g' \
> fs_gt.noninfl.tmp1

cat fs_gt.inflecting \
| sed 's/""/\n/g' \
| sed 's/^[^|]*| //g' \
> fs_gt.inflecting.tmp1

echo 'LEXICON Adjectives\n\n Adjectives_v ;\n Adjectives_ne ;\n PlainAdjectives ;\n' > adjectives.proto
#echo 'LEXICON Adjectives\n\n @P.Stem.Short@ ShortAdjectives ;  ! max 2 syllables\n Adjectives_v ;  ! no compounds\n Adjectives_ne ;  ! no compounds\n PlainAdjectives ;\n' > adjectives.protolexc

# ignore the classification of vabamorf
cat fs_gt.inflecting.tmp1 | grep '+A:' \
| sed 's/WDEVERBAL//' | sed 's/mnocompound//' \
| sed 's/^\(nnolastpart\)\(.*\)$/\2\1/' \
| sed 's/kilo#/kilo?/' \
| sed 's/milli#/milli?/' \
| sed 's/mega#/mega?/' \
| sed 's/\(giga\)#/\1?/' \
| sed 's/\(senti\)#/\1?/' \
| sed 's/\(mikro\)#/\1?/' \
| sed 's/\(detsi\)#/\1?/' \
| sed 's/\(atmo\)#/\1?/' \
| sed 's/#\(m.eetrine\)/?\1/' \
| sed 's/#\(päevane\)/?\1/' \
| sed '/#.*?päevane/s/?/#/' \
| sed 's/\(iga\)?\(päevane\)/\1#\2/' \
| sed 's/\(kahe\)?\(päevane\)/\1#\2/' \
| sed 's/\(mõne\)?\(päevane\)/\1#\2/' \
| sed 's/\(paari\)?\(päevane\)/\1#\2/' \
| sed 's/\(täna\)?\(päevane\)/\1#\2/' \
| sed 's/\(ühe\)?\(päevane\)/\1#\2/' \
> adjectives.tmp1

cat fs_gt.inflecting.tmp1 | grep '+A+Usage/NotNorm:' \
>> adjectives.tmp1

# short adjectives are special in that they may compound in sg nom

# adjectives ending in v

echo '\nLEXICON Adjectives_v\n' >> adjectives.proto
cat adjectives.tmp1 \
| grep -v '#' | grep 'v+' \
| sed '/^[^aeiouõäöü]*[aeiouõäöü]*[^aeiouõäöü]*[aeiouõäöü][aeiouõäöü]*[^aeiouõäöü]*+A/s/^\([^:]*+A\):\([^;]*;\)\(.*\)$/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^vahelduv+A/s/^\([^:]*+A\):\([^;]*;\)\(.*\)$/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/;.*nnolastpart/s/^\([^:]*+A\):\([^;]*;\)\(.*\)nnolastpart/@R.Part.One@\1:@R.Part.One@\2\3/' \
| sed '/@elev+A/s/@P.Stem.Nom@//g' \
| sed '/@ülev+A/s/@P.Stem.Nom@//g' \
| sed '/@tulev+A/s/@P.Stem.Nom@//g' \
| sed '/@omav+A/s/@P.Stem.Nom@//g' \
| sed 's/?/#/g' \
>> adjectives.proto

# adjectives ending in ne

echo '\nLEXICON Adjectives_ne\n' >> adjectives.proto
cat adjectives.tmp1 \
| grep -v '#' | grep 'ne+' \
| sed '/;.*nnolastpart/s/^\([^:]*+A\):\([^;]*;\)\(.*\)nnolastpart/@R.Part.One@\1:@R.Part.One@\2\3/' \
| sed 's/?/#/g' \
>> adjectives.proto

# other adjectives

echo '\nLEXICON PlainAdjectives\n' >> adjectives.proto

cat adjectives.tmp1 \
| grep '#' \
> adjectives.tmp2

# in compounding, pruunjas and hallikas expect adjective to follow
cat adjectives.tmp1 \
| grep -v '#' | grep '[jk]as+' \
| sed 's/^\([^:]*+A\):\([^;]*;\)\(.*\)$/@P.Der.kas@@P.Stem.Nom@\1:@P.Der.kas@@P.Stem.Nom@\2\3/' \
| sed '/[ph]aljas+/s/@P.Der.kas@//g' \
>> adjectives.tmp2

cat adjectives.tmp1 \
| grep -v '#' | grep -v 'ne+' | grep -v 'v+' | grep -v '[jk]as+' \
| sed '/^[^aeiouõäöü]*[aeiouõäöü]*[^aeiouõäöü]*[aeiouõäöü][aeiouõäöü]*[^aeiouõäöü]*+A/s/^\([^:]*+A\):\([^;]*;\)\(.*\)$/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^möödunud+A/s/^\([^:]*+A\):\([^;]*;\)\(.*\)$/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^[^aeiouõäöü]*[aeiouõäöü]*[^aeiouõäöü]*[aeiouõäöü]tu+A/s/^\([^:]*+A\):\([^;]*;\)\(.*\)$/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
>> adjectives.tmp2

cat adjectives.tmp2 \
| sed '/;.*nnolastpart/s/^\([^:]*+A\):\([^;]*;\)\(.*\)nnolastpart/@R.Part.One@\1:@R.Part.One@\2\3/' \
| sed '/@kasutu+/s/@P.Stem.Nom@//g' \
| sed '/@antu+/s/@P.Stem.Nom@//g' \
| sed 's/?/#/g' \
| sort -u >> adjectives.proto

# some more flag diacritics to block some paths in compounding
# ... followed by deleting flags that are spurious because of more restrictive flags
cat  adjectives.proto \
| sed -f badfinal_A.sed \
| sed '/@P.Stem.Single@/s/@P.Stem.Nom@//g' \
| sed '/@P.Stem.Single@/s/@R.Part.One@//g' \
| sed '/@P.Stem.Single@/s/@D.Stem.Guessed@//g' \
| sed '/@R.Part.One@/s/@D.Stem.Guessed@//g' \
> adjectives.protolexc

echo '\nLEXICON NoninflectingAdjectives\n' \
> noninflecting_adjectives.protolexc
cat fs_gt.noninfl.tmp1 | grep '+A:' > noninflecting_adjectives.tmp1

# mark good words for compounding 
# by falsely giving them the tag of a shortened form (like vaatamis-),
# or correctly giving them the tag of inessive case (like punnis, upakil),
# although these are uninflected words...
cat noninflecting_adjectives.tmp1 \
| sed '/^ekstra+/s/^\([^:]*+A\):\([^;]*;\)\(.*\)/@P.Case.Short@\1:@P.Case.Short@\2\3/' \
| sed '/^eri+/s/^\([^:]*+A\):\([^;]*;\)\(.*\)/@P.Case.Short@\1:@P.Case.Short@\2\3/' \
| sed '/^ise+/s/^\([^:]*+A\):\([^;]*;\)\(.*\)/@P.Case.Short@\1:@P.Case.Short@\2\3/' \
| sed '/^mega+/s/^\([^:]*+A\):\([^;]*;\)\(.*\)/@P.Case.Short@\1:@P.Case.Short@\2\3/' \
| sed '/^paaris+/s/^\([^:]*+A\):\([^;]*;\)\(.*\)/@P.Case.Short@\1:@P.Case.Short@\2\3/' \
| sed '/^päris+/s/^\([^:]*+A\):\([^;]*;\)\(.*\)/@P.Case.Short@\1:@P.Case.Short@\2\3/' \
| sed '/^täis+/s/^\([^:]*+A\):\([^;]*;\)\(.*\)/@P.Case.Short@\1:@P.Case.Short@\2\3/' \
| sed '/^väärt+/s/^\([^:]*+A\):\([^;]*;\)\(.*\)/@P.Case.Short@\1:@P.Case.Short@\2\3/' \
| sed '/^[^aeiouõäöü]*[aeiouõäöü][aeiouõäöü]*[^aeiouõäöü][^aeiouõäöü]*[aeiu]s+/s/^\([^:]*+A\):\([^;]*;\)\(.*\)/@P.Case.Ine@\1:@P.Case.Ine@\2\3/' \
| sed '/il+/s/^\([^:]*+A\):\([^;]*;\)\(.*\)/@P.Case.Ine@\1:@P.Case.Ine@\2\3/' \
> noninflecting_adjectives.tmp2

cat noninflecting_adjectives.tmp2 >> noninflecting_adjectives.protolexc

echo 'LEXICON ComparativeAdjectives\n' > comparative_adjectives.protolexc
cat fs_gt.inflecting.tmp1 | grep '+A+Comp' > comparative_adjectives.tmp1

# mark good words for compounding in Sg Nom
cat comparative_adjectives.tmp1 \
| sed '/^alam+/s/^\([^:]*+A+Comp\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^enam+/s/^\([^:]*+A+Comp\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^kauem+/s/^\([^:]*+A+Comp\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^lähem+/s/^\([^:]*+A+Comp\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^lühem+/s/^\([^:]*+A+Comp\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^noorem+/s/^\([^:]*+A+Comp\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^parem+/s/^\([^:]*+A+Comp\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^suurem+/s/^\([^:]*+A+Comp\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^vanem+/s/^\([^:]*+A+Comp\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^vähem+/s/^\([^:]*+A+Comp\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^ülem+/s/^\([^:]*+A+Comp\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
> comparative_adjectives.tmp2

cat comparative_adjectives.tmp2 >> comparative_adjectives.protolexc

echo 'LEXICON SuperlativeAdjectives\n' > superlative_adjectives.protolexc
cat fs_gt.inflecting.tmp1 | grep '+A+Superl' > superlative_adjectives.tmp1

# mark good words for compounding in Sg Nom
cat superlative_adjectives.tmp1 \
| sed '/^enim+/s/^\([^:]*+A+Superl\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^vähim+/s/^\([^:]*+A+Superl\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^ülim+/s/^\([^:]*+A+Superl\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
> superlative_adjectives.tmp2

cat superlative_adjectives.tmp2 >> superlative_adjectives.protolexc



# find short adverbs:
# grep '^[^aeiouõäöü]*[aeiouõäöü]*[^aeiouõäöü][^aeiouõäöü][aeiouõäöü][aeiouõäöü]*[^aeiouõäöü]*[^aeiouõäöü]i*+[^#=]*$'

# lisaks (1), lisaks (2)
cat fs_gt.noninfl.tmp1 | grep '+Adv' \
| grep '\(^järel+\)\|\(^koos+\)\|\(^kõrval+\)\|\(^otse+\)\|\(^piki+\)\|\(^püsti+\)\|\(^ratsa+\)\|\(^taga+\)\|\(^topelt+\)\|\(^vallas+\)\|\(^vastas+\)\|\(^vastu+\)\|\(^üle+\)' \
> tmpadv.0

cat fs_gt.noninfl.tmp1 | grep '+Adv' \
| grep -v '\(^järel+\)\|\(^koos+\)\|\(^kõrval+\)\|\(^otse+\)\|\(^piki+\)\|\(^püsti+\)\|\(^ratsa+\)\|\(^taga+\)\|\(^topelt+\)\|\(^vallas+\)\|\(^vastas+\)\|\(^vastu+\)\|\(^üle+\)' \
> tmpadv.alg

cat tmpadv.alg \
| grep '\(^all+\)\|\(^alt+\)\|\(^eel+\)\|\(^ees+\)\|\(^ise+\)\|\(^jae+\)\|\(^oma+\)\|\(^pea+\)\|\(^ula+\)\|\(^õue+\)\|\(^ära+\)\|\(^üle+\)\|\(^....+\)\|\(^umbes+\)\|\(^....[^s]+[^#-]*$\)\|\(^...ks+[^#-]*$\)\|\(^...*li+[^#-]*$\)\|\(^...*il+[^#-]*$\)\|\(^...*ile+[^#-]*$\)\|\(^[^aeiouõäöü]*[aeiouõäöü][aeiouõäöü]*[^aeiouõäöü][^aeiouõäöü]*si+\)\|\(^hiljuti+\)\|\(^kaheti+\)\|\(^kolmeti+\)\|\(^kunagi+\)\|\(^mitmeti+\)\|\(^teisiti+\)\|\(^tükati+\)\|\(^võõriti+\)\|\(^uuesti+\)\|\(^valesti+\)' \
| grep -v '\(^miks+\)\|\(^näos+\)\|\(^egas+\)\|\(^kuis+\)\|\(^siis+\)\|\(^teps+\)\|\(^aina+\)\|\(^aiva+\)\|\(^eele+\)\|\(^eelt+\)\|\(^ikka+\)\|\(^istu+\)\|\(^jalu+\)\|\(^jaol+\)\|\(^jokk+\)\|\(^juba+\)\|\(^just+\)\|\(^jõle+\)\|\(^jönt+\)\|\(^kohe+\)\|\(^kole+\)\|\(^kord+\)\|\(^kuhu+\)\|\(^kuna+\)\|\(^küll+\)\|\(^loga+\)\|\(^loha+\)\|\(^losa+\)\|\(^mant+\)\|\(^manu+\)\|\(^nagu+\)\|\(^nõka+\)\|\(^nõus+\)\|\(^nüüd+\)\|\(^olgu+\)\|\(^puha+\)\|\(^põsi+\)\|\(^päta+\)\|\(^seep+\)\|\(^seni+\)\|\(^siva+\)\|\(^sugu+\)\|\(^tuna+\)\|\(^täna+\)\|\(^töhe+\)\|\(^vaid+\)\|\(^vaja+\)\|\(^veel+\)\|\(^vist+\)\|\(^väga+\)\|\(^õige+\)\|\(^õkva+\)\|\(^ähmi+\)\|\(^äkki+\)\|\(^ängi+\)\|\(^äsja+\)\|\(^+ühti\)\|\(^üsna+\)\|\(^abiga+\)\|\(^eduga+\)\|\(^hulga+\)\|\(^jõuga+\)\|\(^liiga+\)\|\(^lõõga+\)\|\(^punga+\)\|\(^seega+\)\|\(^tõega+\)' \
> tmpadv.1

# lisaks (3)
cat tmpadv.alg \
| grep '\(^alasti+\)\|\(^alles+\)\|\(^edasi+\)\|\(^eemale+\)\|\(^eemalt+\)\|\(^eraldi+\)\|\(^halvasti+\)\|\(^juurde+\)\|\(^järele+\)\|\(^kaotsi+\)\|\(^kaugele+\)\|\(^kaugelt+\)\|\(^kergelt+\)\|\(^kergesti+\)\|\(^kindlaks+\)\|\(^klaariks+\)\|\(^käsitsi+\)\|\(^kõrgelt+\)\|\(^kõrval+\)\|\(^kõrvalt+\)\|\(^kõvaks+\)\|\(^kõrvuti+\)\|\(^külili+\)\|\(^laiali+\)\|\(^raskesti+\)\|\(^seni+\)\|\(^sisse+\)\|\(^tagant+\)\|\(^tagasi+\)\|\(^viimati+\)\|\(^võistu+\)\|\(^vääriti+\)\|\(^äsja+\)' \
>> tmpadv.1

# NB! see loend olgu sama, mis lisaks (2)
cat tmpadv.alg \
| grep '\(^miks+\)\|\(^näos+\)\|\(^egas+\)\|\(^kuis+\)\|\(^siis+\)\|\(^teps+\)\|\(^aina+\)\|\(^aiva+\)\|\(^eele+\)\|\(^eelt+\)\|\(^ikka+\)\|\(^istu+\)\|\(^jalu+\)\|\(^jaol+\)\|\(^jokk+\)\|\(^juba+\)\|\(^just+\)\|\(^jõle+\)\|\(^jönt+\)\|\(^kohe+\)\|\(^kole+\)\|\(^kord+\)\|\(^kuhu+\)\|\(^kuna+\)\|\(^küll+\)\|\(^loga+\)\|\(^loha+\)\|\(^losa+\)\|\(^mant+\)\|\(^manu+\)\|\(^nagu+\)\|\(^nõka+\)\|\(^nõus+\)\|\(^nüüd+\)\|\(^olgu+\)\|\(^puha+\)\|\(^põsi+\)\|\(^päta+\)\|\(^seep+\)\|\(^seni+\)\|\(^siva+\)\|\(^sugu+\)\|\(^tuna+\)\|\(^täna+\)\|\(^töhe+\)\|\(^vaid+\)\|\(^vaja+\)\|\(^veel+\)\|\(^vist+\)\|\(^väga+\)\|\(^õige+\)\|\(^õkva+\)\|\(^ähmi+\)\|\(^äkki+\)\|\(^ängi+\)\|\(^äsja+\)\|\(^+ühti\)\|\(^üsna+\)\|\(^abiga+\)\|\(^eduga+\)\|\(^hulga+\)\|\(^jõuga+\)\|\(^liiga+\)\|\(^lõõga+\)\|\(^punga+\)\|\(^seega+\)\|\(^tõega+\)' \
> tmpadv.2

#> adverbs.tmp2
# NB! see loend olgu sama, mis lisaks (1)
cat tmpadv.alg \
| grep -v '\(^all+\)\|\(^alt+\)\|\(^eel+\)\|\(^ees+\)\|\(^ise+\)\|\(^jae+\)\|\(^oma+\)\|\(^pea+\)\|\(^ula+\)\|\(^õue+\)\|\(^ära+\)\|\(^üle+\)\|\(^....+\)\|\(^umbes+\)\|\(^....[^s]+[^#-]*$\)\|\(^...ks+[^#-]*$\)\|\(^...*li+[^#-]*$\)\|\(^...*il+[^#-]*$\)\|\(^...*ile+[^#-]*$\)\|\(^[^aeiouõäöü]*[aeiouõäöü][aeiouõäöü]*[^aeiouõäöü][^aeiouõäöü]*si+\)\|\(^hiljuti+\)\|\(^kaheti+\)\|\(^kolmeti+\)\|\(^kunagi+\)\|\(^mitmeti+\)\|\(^teisiti+\)\|\(^tükati+\)\|\(^võõriti+\)\|\(^uuesti+\)\|\(^valesti+\)' \
>> tmpadv.2
#>> adverbs.tmp2

# NB! see loend olgu sama, mis lisaks (3)
cat tmpadv.2 | grep -v '\(^alasti+\)\|\(^alles+\)\|\(^edasi+\)\|\(^eemale+\)\|\(^eemalt+\)\|\(^eraldi+\)\|\(^halvasti+\)\|\(^juurde+\)\|\(^järele+\)\|\(^kaotsi+\)\|\(^kaugele+\)\|\(^kaugelt+\)\|\(^kergelt+\)\|\(^kergesti+\)\|\(^kindlaks+\)\|\(^klaariks+\)\|\(^käsitsi+\)\|\(^kõrgelt+\)\|\(^kõrval+\)\|\(^kõrvalt+\)\|\(^kõvaks+\)\|\(^kõrvuti+\)\|\(^külili+\)\|\(^laiali+\)\|\(^raskesti+\)\|\(^seni+\)\|\(^sisse+\)\|\(^tagant+\)\|\(^tagasi+\)\|\(^viimati+\)\|\(^võistu+\)\|\(^vääriti+\)\|\(^äsja+\)' \
> tmpadv.3

#>> adverbs.protolexc

echo 'LEXICON Adverbs\n\n CompoundingAdverbs ;\n @P.Part.Bad@ PlainAdverbs ;\n\n' > adverbs.protolexc

echo 'LEXICON CompoundingAdverbs\n' >> adverbs.protolexc
cat tmpadv.0 \
| sed '/^üle+/!s/^\([^:]*\):\([^;]*;\)\(.*\)/@P.Stem.topelt@\1:@P.Stem.topelt@\2\3/' \
| sed '/^üle+/s/^\([^:]*\):\([^;]*;\)\(.*\)/@P.Stem.üle@\1:@P.Stem.üle@\2\3/' \
>> adverbs.protolexc

cat tmpadv.1 \
| sed '/^vähe+/s/^\([^:]*\):\([^;]*;\)\(.*\)/@P.Stem.vähe@\1:@P.Stem.vähe@\2\3/' \
| sed '/^puht+/s/^\([^:]*\):\([^;]*;\)\(.*\)/@P.Stem.vähe@\1:@P.Stem.vähe@\2\3/' \
| sort -u \
>> adverbs.protolexc

echo '\nLEXICON PlainAdverbs\n' >> adverbs.protolexc

cat tmpadv.3 | sort -u >> adverbs.protolexc
#cat adverbs.tmp2 | sort -u >> adverbs.protolexc

echo 'LEXICON Adpositions\n' > adpositions.protolexc
cat fs_gt.noninfl.tmp1 | grep '+Adp' >> adpositions.protolexc

echo 'LEXICON Conjunctions\n' > conjunctions.protolexc
cat fs_gt.noninfl.tmp1 | grep '+C[CS]' >> conjunctions.protolexc

# add compounding-related flag diacritics to individual words

# kirjuta iga kirje taha see inf, mis fs_lex-sist tuleb
# ja eering-lõpulised
# ... ja palju PINGE tüüpi sõnu polegi deverbaalideks märgitud...
# (ja siin all olevad lisandused pole kõik, mis võimalik...)
cat fs_gt.inflecting.tmp1 | grep '\(+N:\)\|\(+N+Usage\)' \
| sed 's/^\(WDEVERBAL\)\(.*\)$/\2\1/' \
| sed 's/^\(mnocompound\)\(.*\)$/\2\1/' \
| sed 's/^\(nnolastpart\)\(.*\)$/\2\1/' \
| sed '/WDEVERBAL/!s/ing+N[^#]*VIRSIK.*$/&WDEVERBAL/' \
| sed '/^veering+/s/WDEVERBAL//' \
| sed '/brauning+/s/WDEVERBAL//' \
| sed '/curling+N/s/WDEVERBAL//' \
| sed '/doping+N/s/WDEVERBAL//' \
| sed '/dumping+N/s/WDEVERBAL//' \
| sed '/elling+N/s/WDEVERBAL//' \
| sed '/etsing+N/s/WDEVERBAL//' \
| sed '/faktooring+N/s/WDEVERBAL//' \
| sed '/holding+N/s/WDEVERBAL//' \
| sed '/kamming+N/s/WDEVERBAL//' \
| sed '/kämping+N/s/WDEVERBAL//' \
| sed '/lasing+N/s/WDEVERBAL//' \
| sed '/miiting+N/s/WDEVERBAL//' \
| sed '/puding+N/s/WDEVERBAL//' \
| sed '/pööning+N/s/WDEVERBAL//' \
| sed '/reeling+N/s/WDEVERBAL//' \
| sed '/reiting+N/s/WDEVERBAL//' \
| sed '/seltsing+N/s/WDEVERBAL//' \
| sed '/smoking+N/s/WDEVERBAL//' \
| sed '/sobing+N/s/WDEVERBAL//' \
| sed '/soling+N/s/WDEVERBAL//' \
| sed '/spinning+N/s/WDEVERBAL//' \
| sed '/tafting+N/s/WDEVERBAL//' \
| sed '/telling+N/s/WDEVERBAL//' \
| sed '/täring+N/s/WDEVERBAL//' \
| sed '/valing+N/s/WDEVERBAL//' \
| sed '/^ehitis+/s/$/WDEVERBAL/' \
| sed '/^anne+/s/$/WDEVERBAL/' \
| sed '/^haare+/s/$/WDEVERBAL/' \
| sed '/^heide+/s/$/WDEVERBAL/' \
| sed '/^hindlus+/s/$/WDEVERBAL/' \
| sed '/^hoie+/s/$/WDEVERBAL/' \
| sed '/^hoole+/s/$/WDEVERBAL/' \
| sed '/^huige+/s/$/WDEVERBAL/' \
| sed '/^hõige+/s/$/WDEVERBAL/' \
| sed '/^hõise+/s/$/WDEVERBAL/' \
| sed '/^joode+/s/$/WDEVERBAL/' \
| sed '/^kaabe+/s/$/WDEVERBAL/' \
| sed '/^kaeve+/s/$/WDEVERBAL/' \
| sed '/^kaitse+/s/$/WDEVERBAL/' \
| sed '/^kanne+/s/$/WDEVERBAL/' \
| sed '/^karje+/s/$/WDEVERBAL/' \
| sed '/^kilge+/s/$/WDEVERBAL/' \
| sed '/^korje+/s/$/WDEVERBAL/' \
| sed '/^liide+/s/$/WDEVERBAL/' \
| sed '/^loome+/s/$/WDEVERBAL/' \
| sed '/^luure+/s/$/WDEVERBAL/' \
| sed '/^lõikus+/s/$/WDEVERBAL/' \
| sed '/^lüke+/s/$/WDEVERBAL/' \
| sed '/^maks+.*KOON/s/$/WDEVERBAL/' \
| sed '/^makse+/s/$/WDEVERBAL/' \
| sed '/^muie+/s/$/WDEVERBAL/' \
| sed '/^möire+/s/$/WDEVERBAL/' \
| sed '/^ost+.*KOON/s/$/WDEVERBAL/' \
| sed '/^pilge+/s/$/WDEVERBAL/' \
| sed '/^piste+/s/$/WDEVERBAL/' \
| sed '/^pooge+/s/$/WDEVERBAL/' \
| sed '/^purse+/s/$/WDEVERBAL/' \
| sed '/^puude+/s/$/WDEVERBAL/' \
| sed '/^pööre+/s/$/WDEVERBAL/' \
| sed '/^raie+/s/$/WDEVERBAL/' \
| sed '/^surve+/s/$/WDEVERBAL/' \
| sed '/^torge+/s/$/WDEVERBAL/' \
| sed '/^viibe+/s/$/WDEVERBAL/' \
| sed '/^viide+/s/$/WDEVERBAL/' \
| sed '/^võnge+/s/$/WDEVERBAL/' \
| sed '/^võte+/s/$/WDEVERBAL/' \
| sed '/^esi+/s/$/mnocompound/' \
| sed '/^deism+/s/$/mnocompound/' \
| sed '/^marss+/s/$/WDEVERBAL/' \
| sed '/^müük+/s/$/WDEVERBAL/' \
| sed '/^sööst+/s/$/WDEVERBAL/' \
| sed '/^vool+/s/$/WDEVERBAL/' \
| sed '/^õpe+/s/$/WDEVERBAL/' \
| sed '/^tulija+/s/$/WDEVERBAL/' \
| sed '/^panija+/s/$/WDEVERBAL/' \
| sed '/^tegija+/s/$/WDEVERBAL/' \
| sed '/^nägija+/s/$/WDEVERBAL/' \
| sed '/^kandlus+/s/$/WDEVERBAL/' \
| sed '/^leplus+/s/$/WDEVERBAL/' \
| sed '/^mäng+/s/$/WDEVERBAL/' \
| sed 's/+N+Usage/+N_Usage/' \
| LC_COLLATE=C sort > fs_gt.inflecting.tmp1.srt

# ja lisa siia märge nende lühikeste nimisõnade kohta, mis ei osale liitsõnades
LC_COLLATE=C join -t+ -a 1 -a 2 -o 1.1 2.1 2.2 head_esiosad fs_gt.inflecting.tmp1.srt | grep -v '++' | sed '/^[^+].*+N/s/$/heaesi/' \
| sed '/^[k]*ost+/s/heaesi//' \
| sed '/^õpe+/s/heaesi//' \
| sed '/^anne+/s/heaesi//' \
| sed 's/^[^+]*+//' \
| sed 's/+N_Usage/+N+Usage/' > fs_gt.inflecting.tmp1.tagged
#----

echo 'LEXICON Nouns\n\n DeverbalNouns ;\n PlainNouns ;\n' > nouns.protolexc

echo '\nLEXICON DeverbalNouns\n' >> nouns.protolexc
cat fs_gt.inflecting.tmp1.tagged | grep '+N:' \
| grep 'WDEVERBAL' | sed 's/WDEVERBAL//' \
| sed '/;.*heaesi/s/^\([^:]*+N[^:]*\):\([^;]*;\)\(.*\)heaesi/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^[^@]...*s+N[^:]*:[^#]* SUULINE/s/^\([^:]*+N[^:]*\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
>> nouns.protolexc

#echo '\nLEXICON PlainNouns\n\n @P.Stem.Single@ PlainNouns_nocompound ;\n @R.Part.One@ PlainNouns_nolastpart ;\n @P.Len.3@ PlainNouns_three ;\n @P.Len.4@ PlainNouns_four ;\n PlainNouns_fiveplus ;\n' >> nouns.protolexc

echo '\nLEXICON PlainNouns\n\n' >> nouns.protolexc

# add flags for limiting compounding
cat fs_gt.inflecting.tmp1.tagged | grep '\(+N:\)\|\(+N+Usage\)' \
| grep -v 'WDEVERBAL' \
| sed 's/:de#/:de?/' \
| sed 's/:in#/:in?/' \
| sed 's/:re#/:re?/' \
| sed 's/:di#/:di?/' \
| sed 's/:bi#/:bi?/' \
| sed 's/:ir#/:ir?/' \
| sed 's/:an#/:an?/' \
| sed 's/:ko#/:ko?/' \
| sed 's/:im#/:im?/' \
| sed 's/:en#/:en?/' \
| sed 's/:eba#/:eba?/' \
| sed 's/:dis#/:dis?/' \
| sed 's/:bio#/:bio?/' \
| sed 's/:des#/:des?/' \
| sed 's/:geo#/:geo?/' \
| sed 's/:sub#/:sub?/' \
| sed 's/:dia#/:dia?/' \
| sed 's/:epi#/:epi?/' \
| sed 's/:iso#/:iso?/' \
| sed 's/:ego#/:ego?/' \
| sed 's/:pop#/:pop?/' \
| sed 's/:zoo#/:zoo?/' \
| sed 's/:kom#/:kom?/' \
| sed 's/:tri#/:tri?/' \
| sed 's/:pan#/:pan?/' \
| sed 's/:polü#/:polü?/' \
| sed 's/:an,ti#/:an,ti?/' \
| sed 's/:tele#/:tele?/' \
| sed '/^alg+.*KOON/s/nnolastpartheaesi/mnocompound/' \
| sed '/;.*heaesi/s/^\([^:]*+N[^:]*\):\([^;]*;\)\(.*\)heaesi/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^[^@]....*+[^#]* TAUD/s/^\([^:]*+N[^:]*\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^[^@].*+[^#]*#sk.oop TAUD/s/^\([^:]*+N[^:]*\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/ism+.*TAUD/s/@P.Stem.Nom@//g' \
| sed '/@...[žš]+.*TAUD/s/@P.Stem.Nom@//g' \
| sed '/@mart+.*TAUD/s/@P.Stem.Nom@//g' \
| sed '/@kult+.*TAUD/s/@P.Stem.Nom@//g' \
| sed '/^[^@]...*[iu]s+N[^:]*:[^#]* OLULINE/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^[^@]...*s+N[^:]*:[^#]* SUULINE/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^[^@]...*us+N[^:]*:.*#.* SUULINE/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^[^@]...*[iu]s+N[^:]*:.*#.* OLULINE/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^[^@]...*s+N[^:]*:[^#]* KATKINE/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^[^@]...*s+N[^:]*:[^#]* SOOLANE/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^[^@]....*+[^#]* REDEL/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^[^@]....*+[^#]* TOOBER/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^[^@]....*+[^#]* PIKSEL/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^[^@]....*+[^#]* GOSPEL/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^[^@]....*+[^#]* VIRSIK/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^[^@]....*+[^#]* ÄMBLIK/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^käsi+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^tõsi+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^mesi+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^vesi+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^säär+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^huul+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
\
| sed '/^emand+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^isand+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^kamar+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^kamin+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^kardin+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^keerits+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^kodar+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^kuhil+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^kägar+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^kõrvits+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^lagrits+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^latern+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^mügar+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^näpits+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^orav+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^pasun+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^ranits+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^rosin+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^räbal+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^rätsep+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^unelm+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^vasar+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^värnits+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^ädal+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
\
| sed '/^pude+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^pune+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^sade+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^helmes+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^helves+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^kirves+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^kääbas+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^kännas+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^küngas+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^laegas+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^lammas+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^pilbas+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^puhmas+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^roobas+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^turvas+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^tüügas+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^varras+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^varvas+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^ehmes+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^mülgas+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^tõbras+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^urgas+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^tainas+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^riugas+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^oinas+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^baarium+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^deuteerium+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^gallium+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^germaanium+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^heelium+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^iriidium+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^kaadmium+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^kambium+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^nukleon+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^oopium+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^plutoonium+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^poloonium+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^raadium+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^strontsium+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^toorium+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^triitium+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^tseesium+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^vanaadium+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^händikäp+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^kabinet+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^siksak+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^kogumik+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^killustik+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^kapsas+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^nälg+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^kameeleon+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
| sed '/^sari+N.*PIIM/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
\
| sed '/^....*[kpt]s+.*KOON/s/^\([^:]*+N[^:]*\):\([^#;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
> nouns.proto1

# exception: kuulmetõri kuulmetõrve
echo 'kuulmetõri+N:k´uulme#tõr TÕRI ;' >> nouns.proto1

cat nouns.proto1 \
| sed -f nomstem_first_koon.sed \
| sed -f nomstem_first_piim.sed \
| sed -f nomstem_first_eit.sed \
\
| sed '/;.*mnocompound/s/^\([^:]*+N[^:]*\):\([^;]*;\)\(.*\)mnocompound/@P.Stem.Single@\1:@P.Stem.Single@\2\3/' \
| sed '/^vana+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Final@\1:@P.Stem.Final@\2\3/' \
| sed '/^alam+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Final@\1:@P.Stem.Final@\2\3/' \
| sed '/@alam+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Final@\1:@P.Stem.Final@\2\3/' \
| sed '/^ülem+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Final@\1:@P.Stem.Final@\2\3/' \
| sed '/@ülem+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Final@\1:@P.Stem.Final@\2\3/' \
\
| sed '/^pee+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Single@\1:@P.Stem.Single@\2\3/' \
| sed '/^aar+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Single@\1:@P.Stem.Single@\2\3/' \
| sed '/^boi+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Single@\1:@P.Stem.Single@\2\3/' \
| sed '/^erg+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Single@\1:@P.Stem.Single@\2\3/' \
| sed '/@ess+/s/^\([^:]*+N\):\([^;]*;\)\(.*\)/@P.Stem.Single@\1:@P.Stem.Single@\2\3/' \
\
| sed '/;.*nnolastpart/s/^\([^:]*+N[^:]*\):\([^;]*;\)\(.*\)nnolastpart/@R.Part.One@\1:@R.Part.One@\2\3/' \
| sed 's/@R.Part.One@@R.Part.One@/@R.Part.One@/g' \
\
| sed '/-/s/@P.Stem.Nom@//g' \
\
> nouns.proto2

cat nouns.proto2 \
| sed -f no_nomstem_first.sed \
\
| sed '/^iga+/s/^\([^:]*\):\(.*\)$/@D.Case.Nom@\1:@D.Case.Nom@\2/' \
| sed '/^au+/s/^\([^:]*\):\(.*\)$/@D.Case.Nom@\1:@D.Case.Nom@\2/' \
| sed '/^kuma+/s/^\([^:]*\):\(.*\)$/@D.Case.Nom@\1:@D.Case.Nom@\2/' \
| sed '/@lust+/s/^\([^:]*\):\(.*\)$/@D.Case.Nom@\1:@D.Case.Nom@\2/' \
\
| sed -f bad_after_nom3.sed \
| sed -f badfinal_N.sed \
| sed -f badfinal3_N.sed \
| sed -f badfinal4_N.sed \
\
| sed '/@..+/s/@D.Stem.Guessed@//g' \
| sed '/@..+/s/^\([^:]*\):\(.*\)$/@D.Stem.Guessed@\1:@D.Stem.Guessed@\2/' \
| sed '/^..+/s/^\([^:]*\):\(.*\)$/@D.Stem.Guessed@\1:@D.Stem.Guessed@\2/' \
| sed '/@...+/s/@D.Stem.Guessed@//g' \
| sed '/@...+/s/^\([^:]*\):\(.*\)$/@D.Stem.Guessed@\1:@D.Stem.Guessed@\2/' \
| sed '/^...+/s/^\([^:]*\):\(.*\)$/@D.Stem.Guessed@\1:@D.Stem.Guessed@\2/' \
| sed '/@maa+/s/@D.Stem.Guessed@//g' \
| sed '/@töö+/s/@D.Stem.Guessed@//g' \
| sed '/@õde+/s/@D.Stem.Guessed@//g' \
| sed '/@ülem+N/s/@P.Stem.Nom@//g' \
\
| sed 's/@P\.Stem\.Nom@@P\.Stem\.Nom@/@P.Stem.Nom@/g' \
| sed '/@P.Stem.Single@/s/@R.Part.One@//g' \
| sed '/@P.Stem.Single@/s/@P.Stem.Nom@//g' \
| sed '/@P.Stem.Single@/s/@D.Case.Nom@//g' \
| sed '/@R.Part.One@/s/@D.Stem.Guessed@//g' \
| sed '/@R.Part.One@/s/@D.Case.Nom@//g' \
| sed 's/\(@D.Stem.Guessed@\)\(@D.Case.Nom@\)/\2\1/g' \
| sed 's/\(@D.Case.Nom@\)\(@D.Case.Nom@\)/\1/g' \
| sed 's/\(@D.Stem.Guessed@\)\(@D.Stem.Guessed@\)/\1/g' \
\
| sed '/@erim+/s/@P.Stem.Nom@//g' \
| sed 's/?/#/' \
>> nouns.protolexc

# grep 'Nom#...+' korpustest-8-alakriips.hjk.hfst.14dets | sed 's/^.*Nom#\(...\)+.*$/\1/' | sort | uniq -c | sed 's/ \([^ ][^ ][^ ]\)$/ sed \/^\1+\/s\/^\\([^:]*\\):\\(.*\\)$\/@D.Case.Nom@\\1:@D.Case.Nom@\\2\//' | sed 's/^.* \/^/\/^/' 
# grep -v '\^töö+' | grep -v '\^ala+'
#> ~/svn-giellatekno/main/experiment-langs/est/src/import/bad_after_nom3.sed
# ... and filter by hand



#echo '\nLEXICON PlainNouns_fiveplus\n' >> nouns.protolexc
#cat fs_gt.inflecting.tmp1 | grep '+N:' \
#| grep -v 'WDEVERBAL' \
#| grep -v 'mnocompound' \
#| grep -v 'nnolastpart' \
#| grep -v '^[^+][^+][^+]+' \
#| grep -v '^[^+][^+][^+][^+]+' \
#>> nouns.protolexc

echo 'lapselaps+N: LAPSELAPS ;' >> nouns.protolexc
echo 'lapselapselaps+N: LAPSELAPSELAPS ;' >> nouns.protolexc

# make a file for classifying proper names
# the result is names.tmp1 (it is used below)
./classify_names.sh

cat fs_gt.inflecting.tmp1 | grep '+N+Prop' | sed 's/nnolastpart//' \
| sed 's/+N+Prop/&_/' \
| LC_COLLATE=C sort \
> proper.tmp

LC_COLLATE=C join -a 1 -a 2 -t "_" -e "###" -o 1.2 2.1 2.2 names.tmp1 proper.tmp \
| grep -v '###_###' \
| sed "/###_Aatomik+N+Prop/s/###/O/" \
| sed "/###_Franz=Joseph+N+Prop/s/###/N/" \
| sed "/###_Jumalapoeg+N+Prop/s/###/O/" \
| sed "/###_Kohtla-Nõmme+N+Prop/s/###/G/" \
| sed "/###_Leppik+N+Prop/s/###/N/" \
| sed "/###_Loorits+N+Prop/s/###/N/" \
| sed "/###_Lunastaja+N+Prop/s/###/O/" \
| sed "/###_Messias+N+Prop/s/###/O/" \
| sed "/###_Mõttus+N+Prop/s/###/N/" \
| sed "/###_Pärnits+N+Prop/s/###/N/" \
| sed "/###_Päästja+N+Prop/s/###/O/" \
| sed "/###_Saint=Christopher+N+Prop/s/###/O/" \
| sed "/###_Tomson+N+Prop/s/###/N/" \
| sed "/###_Toompea+N+Prop/s/###/G/" \
| sed 's/_:/:/' \
| sort -u \
> proper.tmp2 

echo 'LEXICON ProperNouns\n  ProperNounsGeo ;\n  ProperNounsPersons ;\n  ProperNounsOther ;\n' > propernouns.protolexc
echo '\nLEXICON ProperNounsGeo\n' >> propernouns.protolexc
cat proper.tmp2 | grep '^G_' | sed 's/^G_//' >> propernouns.protolexc

echo '\nLEXICON ProperNounsPersons\n' >> propernouns.protolexc
cat proper.tmp2 | grep '^N_' | sed 's/^N_//' >> propernouns.protolexc

echo '\nLEXICON ProperNounsOther\n' >> propernouns.protolexc
cat proper.tmp2 | grep '^O_' | sed 's/^O_//' >> propernouns.protolexc

cat fs_gt.inflecting.tmp1 | grep '+Num+Card' \
| grep -v '#p.aar ' \
| sed '/^pool+/s/^\([^:]*+Num+Card\):\([^;]*;\)\(.*\)/@P.Stem.Nom@\1:@P.Stem.Nom@\2\3/' \
> cardinalnumerals.tmp1
echo 'poolteist+Num+Card:p´ool POOLTEIST ;' >> cardinalnumerals.tmp1

echo 'LEXICON CardinalNumerals\n  IntegerNumerals ;\n  NonIntegerNumerals ;\n' > cardinalnumerals.protolexc
echo '\nLEXICON IntegerNumerals\n' >> cardinalnumerals.protolexc

# compoundable with Der/ne words
cat cardinalnumerals.tmp1 \
| grep -v 'ELANIK' | grep  -v ':.*[#-]' \
>> cardinalnumerals.protolexc

echo '\nLEXICON NonIntegerNumerals\n' >> cardinalnumerals.protolexc
cat cardinalnumerals.tmp1 \
| grep 'ELANIK' \
>> cardinalnumerals.protolexc

cat cardinalnumerals.tmp1 \
| grep -v 'ELANIK' | grep  ':.*[#-]' \
>> cardinalnumerals.protolexc

echo 'LEXICON OrdinalNumerals\n' > ordinalnumerals.protolexc
cat fs_gt.inflecting.tmp1 | grep '+Num+Ord' >> ordinalnumerals.protolexc

echo 'LEXICON Pronouns\n\n @P.Part.Bad@ PlainPronouns ;\n CompoundingPronouns ;\n\nLEXICON PlainPronouns\n' > pronouns.protolexc
cat fs_gt.noninfl.tmp1 | grep '+Pron' >> pronouns.protolexc

# exclude list(1) words
cat fs_gt.inflecting.tmp1 | grep '+Pron' \
| sed 's/nnolastpart//' \
| grep -v '\(^iga+\)\|\(^igaüks+\)\|\(^mitu+\)\|\(^mõlema+\)\|\(^mõni+\)\|\(^sama+\)\|\(^palju+\)' \
>> pronouns.protolexc

# insert LEXICON CompoundingPronouns
cat pronouns_exceptions.handmade \
| sed '/ise+/s/^\([^:]*\):\([^;]*;\)\(.*\)/@P.Stem.ise@\1:@P.Stem.ise@\2\3/' \
| sed '/iseenese+/s/^\([^:]*\):\([^;]*;\)\(.*\)/@P.Stem.ise@\1:@P.Stem.ise@\2\3/' \
>> pronouns.protolexc

# include list(1) words
cat fs_gt.inflecting.tmp1 | grep '+Pron' \
| sed 's/nnolastpart//' \
| grep '\(^iga+\)\|\(^igaüks+\)\|\(^mitu+\)\|\(^mõlema+\)\|\(^mõni+\)\|\(^sama+\)\|\(^palju+\)' \
| sed '/igaüks+/s/^\([^:]*\):\([^;]*;\)\(.*\)/@P.Stem.ise@\1:@P.Stem.ise@\2\3/' \
>> pronouns.protolexc

echo 'LEXICON NoninflectingVerbs\n' > noninflecting_verbs.protolexc
cat fs_gt.noninfl.tmp1 | grep '+V:' >> noninflecting_verbs.protolexc
cat ara.handmade >> noninflecting_verbs.protolexc

echo 'LEXICON Interjections\n' > interjections.protolexc
cat fs_gt.noninfl.tmp1 | grep '+Interj' >> interjections.protolexc

# some words cannot be a latter part of a compound
echo 'LEXICON GenitiveAttributes\n' > genitive_attributes.protolexc
cat fs_gt.noninfl.tmp1 \
| grep '+N+Sg+Gen' \
| sed '/^doni+/s/^\([^:]*\):\(.*\)$/@R.Part.One@\1:@R.Part.One@\2/' \
| sed '/^komi+/s/^\([^:]*\):\(.*\)$/@R.Part.One@\1:@R.Part.One@\2/' \
| sed '/^moka+/s/^\([^:]*\):\(.*\)$/@R.Part.One@\1:@R.Part.One@\2/' \
| sed '/^pisa+/s/^\([^:]*\):\(.*\)$/@R.Part.One@\1:@R.Part.One@\2/' \
| sed '/^saku+/s/^\([^:]*\):\(.*\)$/@R.Part.One@\1:@R.Part.One@\2/' \
| sed '/^semi+/s/^\([^:]*\):\(.*\)$/@R.Part.One@\1:@R.Part.One@\2/' \
| sed '/^süva+/s/^\([^:]*\):\(.*\)$/@R.Part.One@\1:@R.Part.One@\2/' \
| sed '/^tori+/s/^\([^:]*\):\(.*\)$/@R.Part.One@\1:@R.Part.One@\2/' \
| sed '/^võsu+/s/^\([^:]*\):\(.*\)$/@R.Part.One@\1:@R.Part.One@\2/' \
>> genitive_attributes.protolexc

echo 'LEXICON Verbs\n\neel+Pref#:eel# SimpleVerbs ;\neel+Pref#:eel# EerVerbs ;\neelis+Pref#:eelis# SimpleVerbs ;\neelis+Pref#:eelis# EerVerbs ;\nkaug+Pref#:kaug# SimpleVerbs ;\nkaug+Pref#:kaug# EerVerbs ;\nkiir+Pref#:kiir# SimpleVerbs ;\nkiir+Pref#:kiir# EerVerbs ;\nsund+Pref#:sund# SimpleVerbs ;\nsund+Pref#:sund# EerVerbs ;\ntaas+Pref#:taas# SimpleVerbs ;\ntaas+Pref#:taas# EerVerbs ;\nvaeg+Pref#:vaeg# SimpleVerbs ;\nvaeg+Pref#:vaeg# EerVerbs ;\nühis+Pref#:ühis# SimpleVerbs ;\nühis+Pref#:ühis# EerVerbs ;\nde+Pref#:de# EerVerbs ;\nre+Pref#:re# EerVerbs ;\nSimpleVerbs ;\nEerVerbs ;\n' > verbs.protolexc
echo '\nLEXICON SimpleVerbs\n' >> verbs.protolexc
cat fs_gt.inflecting.tmp1 | grep '+V:' | grep -v '...eer[iu]ma+' \
| sed 's/nnolastpart//' \
| sed -f bad_final_V.sed \
\
>> verbs.protolexc

echo '\nLEXICON EerVerbs\n' >> verbs.protolexc
cat fs_gt.inflecting.tmp1 | grep '+V:' | grep '...eer[iu]ma+' \
| sed 's/nnolastpart//' \
| sed '/^seerima+V/s/^\([^:]*\):\([^;]*;\)\(.*\)/@P.Stem.Single@\1:@P.Stem.Single@\2\3/' \
 >> verbs.protolexc

# create final_components.lexc
./fs_suf2gt.sh

# NB! this relies on the dir structure being the same as in Giellatekno
#cp *.lexc ../fst/stems

# ../fst/stems/abbreviations.lexc
# ../fst/stems/acronyms.lexc
cat adjectives.protolexc | ./special_chars.sh | ./insert_weights.py 15miljon.astak - - \
> ../fst/stems/adjectives.lexc

cat adpositions.protolexc | ./special_chars.sh | ./insert_weights.py 15miljon.astak - -  > ../fst/stems/adpositions.lexc
cat adverbs.protolexc | ./special_chars.sh | ./insert_weights.py 15miljon.astak - - > ../fst/stems/adverbs.lexc
cat cardinalnumerals.protolexc | ./special_chars.sh | ./insert_weights.py 15miljon.astak - - > ../fst/stems/cardinalnumerals.lexc
cat comparative_adjectives.protolexc | ./special_chars.sh | ./insert_weights.py 15miljon.astak - - > ../fst/stems/comparative_adjectives.lexc
cat conjunctions.protolexc | ./special_chars.sh | ./insert_weights.py 15miljon.astak - - > ../fst/stems/conjunctions.lexc
# final_components.lexc was made by ./fs_suf2gt.sh; should contain no weights
cat final_components.lexc | sed 's/"weight:[^"]*"//' | ./special_chars.sh  > ../fst/stems/final_components.lexc

cat genitive_attributes.protolexc | ./special_chars.sh | ./insert_weights.py 15miljon.astak - - \
| sed -f badfinal_N.sed \
> ../fst/stems/genitive_attributes.lexc

cat interjections.protolexc | ./special_chars.sh | ./insert_weights.py 15miljon.astak - - > ../fst/stems/interjections.lexc
cat noninflecting_adjectives.protolexc | ./special_chars.sh | ./insert_weights.py 15miljon.astak - - > ../fst/stems/noninflecting_adjectives.lexc
cat noninflecting_verbs.protolexc | ./special_chars.sh | ./insert_weights.py 15miljon.astak - - > ../fst/stems/noninflecting_verbs.lexc

cat nouns.protolexc | ./special_chars.sh | ./insert_weights.py 15miljon.astak - - \
> ../fst/stems/nouns.lexc

# ../fst/stems/numbers.lexc
cat ordinalnumerals.protolexc | ./special_chars.sh | ./insert_weights.py 15miljon.astak - - > ../fst/stems/ordinalnumerals.lexc
# prefixes.lexc was made by ./fs_pref2gt.sh; no weights
cat prefixes.lexc | ./special_chars.sh > ../fst/stems/prefixes.lexc
cat pronouns.protolexc | ./special_chars.sh | ./insert_weights.py 15miljon.astak - - > ../fst/stems/pronouns.lexc
cat propernouns.protolexc | ./special_chars.sh | ./insert_weights.py 15miljon.astak - - > ../fst/stems/propernouns.lexc
cat superlative_adjectives.protolexc | ./special_chars.sh | ./insert_weights.py 15miljon.astak - - > ../fst/stems/superlative_adjectives.lexc

cat verbs.protolexc | ./special_chars.sh | ./insert_weights.py 15miljon.astak - - \
| sed '/Pref+/s/"weight:[^"]*"//' \
> ../fst/stems/verbs.lexc

# words that should be filtered out of the speller lexicon
# make them into a filter

echo '#a filter to eliminate words that should not be a part of a speller' > nosp
echo '#automatically generated by ....src/import/fsgt2final.sh' >> nosp
echo '#while transforming fs_lex to lexc files' >> nosp
echo 'define words [' >> nosp
cat fs_gt.nosp \
| sed 's/nnolastpart//' \
| sed 's/mnocompound//' \
| sed 's/^nosp[^ ]*| \([^+:]*\)+\([^+:]*\)+\([^+:]*\):.*$/     [{\1} "+\2" "+\3"] |/' \
| sed 's/^nosp[^ ]*| \([^:]*\)+\([^+:]*\):.*$/     [{\1} "+\2" ] |/' \
| tr '\n' '@' | sed 's/|@$/@/' | tr '@' '\n' \
>> nosp
echo '] ;' >> nosp
echo 'regex ~[words ?*] ;' >> nosp

cp nosp ../filters/remove-nospell-words.est.xfscript
 




