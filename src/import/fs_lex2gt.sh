#!/bin/sh
# convert the Filosoft lexicon to a nearly-final Giellatekno format
# usage:
#   ./fs_lex2gt.sh
# result:
#    fs_gt.noninfl fs_gt.inflecting fs_lex.unhandled

# i.e. determine continuation lexicon names for inflecting words,
# lexical sides and surface stems for all words,
# POS tags for all words;
#
# keep the date when the word was included in the Filosoft lexicon,
# and if a word belonged to several POS, keep them in the same line

# määra muuttüübid
# define the inflectional types
cat fs_lex | ./fs_lex2tyyp.sed \
| sed '/Al\]pid/s/@TAUD/@FIAT/' \
> ajutmp

# määra lemmad
# mitmuselised algvormid
# define lemmas and plurale tantum
cat ajutmp | ./fs_lex2algvorm.sed \
| sed '/n<eed.MA/s/HOIDMA@SAATMA/HOIDMA/' \
> algtmp

# käändsõnade omad
# declinables
cat algtmp | ./fs_lex2lemma.sed \
| sed '/ÕIGEVORM$/s/ \([^: ]*\):\([^ ]*\) \([^ ]*ÕIGEVORM\)/ \3 \1:\2/' \
| sed '/ÕIGEVORM.*[^i]id:/s/id$//' \
| sed '/ÕIGEVORM.*eed:/s/eed$/ee/' \
| sed '/KÕRB/s/õrb$/õrB2/' \
| sed '/@EIT laane_k<õrb:/s/@EIT laane_k<õrb:laane_k<õrB2%>%{pl.i%}%{rare%}/@KÕRB laane_k<õrb:laane_k<õrB2/' \
| sed '/@EIT k<õrb:/s/@.*$//' \
> decltmp1

# pöördsõnade omad
# verbs
cat decltmp1 | ./fs_lex2verblemma.sed \
| sed '/n<eed.MA/s/n<eedma:n<eeD1 n<eedma:n<eeD1/n<eedma:n<eeD1/' \
| sed '/SIPLEMA/s/E2\([lr]\)$/\1e/' \
| sed 's/SIPLEMA/HAKKAMA/' \
| sed '/RABELEMA/s/$/e/' \
| sed '/SAATMA/s/T2$/t/' \
| sed 's/TUNDMA/NAERMA/' \
| sed 's/HOIDMA/NAERMA/' \
| sed 's/TÕUSMA/NAERMA/' \
| sed 's/SEISMA/NAERMA/' \
| sed 's/PUSKMA/NAERMA/' \
| sed 's/LÕPMA/SAATMA/' \
| sed 's/KUULMA/NAERMA/' \
| sed '/a\[B.*\.3[2345]/s/$/A7/' \
| sed '/e\[B.*\.3[2345]/s/$/E7/' \
| sed '/KATMA/s/[AE]7//' \
| sed '/JOOKSMA/s/[AE]7//' \
| sed '/LASKMA/s/[AE]7//' \
| sed '/LEPPIMA [km]aitsema:/s/@.*$//' \
| sed '/ELAMA <ehtima:/s/@.*$//' \
| sed '/ELAMA h<auduma:/s/@.*$//' \
| sed 's/LEPPIMA h<auduma:/LEKKIMA h<auduma:/' \
| sed '/ELAMA <uhtuma:/s/@.*$//' \
| sed 's/LEPPIMA <uhtuma:/LEKKIMA <uhtuma:/' \
> tmp1

# kirjuta mõnedesse lemmadesse sisse leksikaalse tasandi märgid
# ja paranda erandsõnade vead
# add characters for lexical forms
# and correct some errors of exceptions
cat tmp1 | ./lemma2twol.sed \
| sed 's/gG1/gg/g' \
| sed 's/h<auG1/h<aug/' \
| sed '/HAARE/s/tT1/tt/' \
| sed 's/ \*\*\([^$:]*:\)/ \1/' \
| sed 's/:\*\*\([^$:]*\)$/:\1/' \
| sed '/KANNEL/s/\(.\)\([kpt]\)\([aeiu][lmnr]:.*<\)\1\2\([AEIU]2\)/\1\2\3\1\2\2\4/' \
| sed '/PIPAR/s/\(.\)\([kpt]\)\([aeiu][lmnr]:.*<\)\1\2\([AEIU]2\)/\1\2\3\1\2\2\4/' \
| sed 's/HABE/HAARE/' \
| sed 's/I5/i/g' \
| sed '/käsi:/s/käS1/&%{stemill%}/' \
| sed '/vesi:/s/veS1/&%{stemill%}/' \
| ./post_lex2lemma.sed \
\
| sed 's/mmB1/mB1/g' \
| sed 's/l]lD1/l]D1/g' \
| sed 's/n]nD1/n]D1/g' \
| sed 's/llD1/lD1/g' \
| sed 's/nnD1/nD1/g' \
| sed 's/rrD1/rD1/g' \
| sed 's/rrS1/rS1/g' \
\
| sed '/mõne /s/mõnD3/mõn/' \
> tmp1twol

# | sed 's/mmB1/mB1/g' \
#| sed 's/llD1/lD1/g' \
#| sed 's/nnD1/nD1/g' \
#| sed 's/rrD1/rD1/g' \
#| sed 's/nnD3/nD3/g' \
#| sed 's/rrS1/rS1/g' \
#| sed '/mõne /s/mõnD3/mõn/' \
#
 
# create a file that contains everything from Filosoft lexicon 
# and most of what will be in final Giellatekno lexicon
# (it may be useful in future amendments)

paste fs_lex tmp1twol \
| sed 's/\t/""/' | sed 's/|.*""/| /' \
| sed 's/!\\D\\!&&!\\K\\!/!\\DK\\!/' \
| sed 's/!\\K\\!&&!\\D\\!/!\\DK\\!/' \
> fs_lex.gt1

# a letter in the field of word class, but actually some other type of info:
# t - taboo
# s - the word can be only as the non-fisrt part of a compound, e.g. Lanka (of Sri Lanka)
# e - the word form exists only in thesaurus; it is an inflectional form of some word, e.g. habemega (= habemik) 
# m - the word cannot participate in compounding
# n - the word cannot be the last part of a compound
# W - deverbal noun, e.g. hüpe (jump)

# create the nearly final lexicons
# ja see rida võiks ära märkida (mingil moel) sõnad, mis pole spellerile sobivad:
# | sed '/^nosp/s/\([^:]*:[^:]*[^ ]\):/\1+Use\/NotNorm:/' \

cat fs_lex.gt1 \
| grep '^[^@]* !\\[^\\]*\\!$' \
\
| sed 's/[tsemnW]\\/\\/g' \
| sed 's/[tsemnW]\([ABCDEFGHIJKLMNOPQRSTUVWXYZ]\)\\/\1\\/g' \
| sed 's/[tsemnW]\\/\\/g' \
| sed 's/^\([^!]*!\\\)\([ABCDEFGHIJKLMNOPQRSTUVWXYZ]\)\([ABCDEFGHIJKLMNOPQRSTUVWXYZ]\)\(\\!\)$/\1\2\4""\1\3\4/' \
| ./sliik2gt.sed \
| sed 's/| \([^ ]*\) !\\\(+[^\\]*\)\\!/| \1\2:\1 #;/g' \
| sed 's/\( ...[^ :]*+Adv[^ ]*\) #;/\1 GI ;/' \
| sed 's/\( ...[^ :]*+A:[^ ]*\) #;/\1 GI ;/' \
| sed '/+Interj/s/ GI ;/ #;/g' \
| sed '/+C[SC]/s/ GI ;/ #;/g' \
| ./diacritics.sed \
| ./eemalda_gi.sed \
| sort -k 2 \
| sed '/^nosp/s/\([^:]*:[^:]*[^ ]\):/\1+Use\/NotNorm:/' \
> fs_gt.noninfl

cat fs_lex.gt1 \
| grep -v '^[^@]* !\\[^\\]*\\!$' \
| grep '@.*:' \
\
| sed '/W[ABCDEFGHIJKLMNOPQRSTUVWXYZ]*\\/s/\(@[^ ]* \)/\1WDEVERBAL/g' \
| sed '/m[ABCDEFGHIJKLMNOPQRSTUVWXYZ]*\\/s/\(@[^ ]* \)/\1mnocompound/g' \
| sed '/n[ABCDEFGHIJKLMNOPQRSTUVWXYZ]*\\/s/\(@[^ ]* \)/\1nnolastpart/g' \
| sed 's/[tsemnW]\\/\\/g' \
| sed 's/[tsemnW]\([ABCDEFGHIJKLMNOPQRSTUVWXYZ]\)\\/\1\\/g' \
| sed 's/[tsemnW]\\/\\/g' \
| sed 's/^\([^!]*!\\\)\([ABCDEFGHIJKLMNOPQRSTUVWXYZ]\)\([ABCDEFGHIJKLMNOPQRSTUVWXYZ]\)\(\\.*\)$/\1\2\4""\1\3\4/' \
| sed 's/$/""/' \
\
| sed '/ÕIGEVORM/s/ \([^ ]*\)\[DÕIGEVORM [^ :]*:/ \1d:/g' \
| sed '/ÕIGEVORM *$/s/ \([^:]*\):\([^ ]*\) \([^ ]*\)\[DÕIGEVORM *$/ \1d:\2/g' \
| sed '/pulmad/s/pulmad:/pulm:/' \
\
| ./sliik2gt.sed \
| sed 's/| \([^!"]* !\\\)\(+[^\\]*\)\(\\[^@]*@\)\([^ ]*\) \([^:]*\):\([^"]*\)""/| \1\2\3 \5\2:\6 \4 ;""/g' \
| sed 's/""$//' \
| ./diacritics2.sed \
\
| sed 's/\(p.õl,\)v%>%{pl.i%} EIT /\1 PÕLV /' \
| sed 's/\(t.al,\)v%>%{pl.i%}%{rare%} EIT /\1 TALV /' \
| sed 's/\(p.urJ1\) EIT /\1 PURI /' \
| sed 's/\(v.äi\) PÄIKE /\1 VÄIKE /' \
\
| sed '/_.*#.* SADA /s/$/EEMALDADA/' \
| sed '/_.*#.* TUHAT /s/$/EEMALDADA/' \
| sed '/üksainus+/s/$/EEMALDADA/' \
| sed '/üksainuke+/s/$/EEMALDADA/' \
| sed '/viimnepäev+N:/s/$/EEMALDADA/' \
| sed '/veerand.*EEMALDADA/s/EEMALDADA//' \
| sed '/aasta.*EEMALDADA/s/EEMALDADA//' \
| sed '/EEMALDADA/s/^.*$//' \
\
| sed 's/#&#p´ersse//' \
| sed 's/#&#p´õrssa//' \
| sed '/perse+/s/erse PINGE/ers PERSE/' \
| sed '/põrsas+/s/õrsa KOTKAS/õrs PÕRSAS/' \
\
| sed '/Aksel+.*REDEL/s/E2\([lr]\)\( REDEL\)/e\1%{rare%}%{E%}\2/' \
| sed '/piksel+.*REDEL/s/E2\([lr]\)\( REDEL\)/e\1%{rare%}%{E%}\2/' \
| sed '/vesper+.*REDEL/s/e\([lr]\)\( REDEL\)/e\1%{rare%}%{E%}\2/' \
| sed '/snuuker+.*REDEL/s/e\([lr]\)\( REDEL\)/e\1%{rare%}%{E%}\2/' \
| sed '/snaiper+.*REDEL/s/E2\([lr]\)\( REDEL\)/e\1%{rare%}%{E%}\2/' \
\
| sed '/Valter+.*REDEL/s/e\([lr]\)\( REDEL\)/e\1%{E%}%{rare%}\2/' \
| sed '/gospel+.*REDEL/s/e\([lr]\)\( REDEL\)/e\1%{E%}%{rare%}\2/' \
| sed '/paabel+.*REDEL/s/e\([lr]\)\( REDEL\)/e\1%{E%}%{rare%}\2/' \
| sed '/kaamel+.*REDEL/s/e\([lr]\)\( REDEL\)/e\1%{E%}%{rare%}\2/' \
| sed '/transponder+.*REDEL/s/e\([lr]\)\( REDEL\)/e\1%{E%}%{rare%}\2/' \
| sed '/stopper+.*REDEL/s/E2\([lr]\)/e\1%{E%}%{rare%}/' \
| sed '/jokker+.*REDEL/s/E2\([lr]\)/e\1%{E%}%{rare%}/' \
| sed '/džokker+.*REDEL/s/E2\([lr]\)/e\1%{E%}%{rare%}/' \
| sed '/röster+.*REDEL/s/E2\([lr]\)/e\1%{E%}%{rare%}/' \
| sed '/rabarber+.*REDEL/s/E2\([lr]\)/e\1%{E%}%{rare%}/' \
\
| sed '/E2.*REDEL/s/E2\([lr]\)/e\1%{E%}/' \
\
| sed '/mõru+A/s/KAVA/MÕRU/' \
| sed '/vaagima+V/s/LEPPIMA/VAAGIMA/' \
| sed '/taotlema+V/s/ELAMA/TAOTLEMA/' \
| sed '/töötama+V/s/ELAMA/TAOTLEMA/' \
| sed '/taastama+V/s/ELAMA/TAOTLEMA/' \
| sed '/kaotama+V/s/ELAMA/TAOTLEMA/' \
| sed '/paitama+V/s/ELAMA/TAOTLEMA/' \
| sed '/peatama+V/s/ELAMA/TAOTLEMA/' \
| sed '/teatama+V/s/ELAMA/TAOTLEMA/' \
| sed '/saastama+V/s/HAKKAMA/LAASTAMA/' \
| sed '/laastama+V/s/HAKKAMA/LAASTAMA/' \
| sed '/siirdama+V/s/HAKKAMA/TÜÜTAMA/' \
| sed '/tüütama+V/s/HAKKAMA/TÜÜTAMA/' \
| sed '/vastama+V/s/HAKKAMA/TÜÜTAMA/' \
| sed '/puistama+V/s/HAKKAMA/TÜÜTAMA/' \
| sed '/rüüstama+V/s/HAKKAMA/TÜÜTAMA/' \
| sed '/uitama+V/s/HAKKAMA/TÜÜTAMA/' \
| sed '/raadama+V/s/HAKKAMA/TÜÜTAMA/' \
| sed '/kiirgama+V/s/HAKKAMA/TÜÜTAMA/' \
| sed '/\.27!@.*pügama+V/s/püG1 VEDAMA/püga ELAMA/' \
| sed '/veenma+V/s/eenA7 NAERMA/een VEENMA/' \
| sed '/möönma+V/s/öönA7 NAERMA/öön VEENMA/' \
| sed '/koolma+V/s/oolE7 NAERMA/ool NAASMA/' \
| sed '/naasma+V/s/aasE7 NAERMA/aas NAASMA/' \
\
| grep -v 'naasema+V' \
| grep -v 'siirdama+.*ELAMA' \
| grep -v 'saastama+.*ELAMA' \
| grep -v 'k<aamel k<aamli' \
| grep -v 'sn<aiper sn<aiperi' \
| grep -v 'p<iksel p<ikseli' \
| grep -v 'transp<onder transp<ondri' \
\
> fs_gt.pre-inflecting

# NB! perse, põrsas praegu osaliselt valesti 
# | sed '/rabarber+N/s/REDEL/RABARBER/' \
#| sed '/rabarber+N/s/\(@.*\)er /\1 /' \
# 
#
# ja see rida võiks ära märkida (mingil moel) sõnad, mis pole spellerile sobivad:
# | sed '/^nosp/s/\([^:]*:[^:]*[^ ]\):/\1+Use\/NotNorm:/' \

cat fs_gt.pre-inflecting \
| sed 's/| \([^@]*\)@ /| /g' \
| sort -k 2 \
> fs_gt.inflecting

cat fs_lex.gt1 \
| grep -v '^[^@]* !\\[^\\]*\\!$' \
| grep -v '@.*:' \
> fs_lex.unhandled

exit


