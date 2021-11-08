#!/bin/bash
# try to figure out what kind of modifications are needed to turn a typo into a correct word
# input: typos.txt file
# output: 3 column file: typo correct #modification_type(s)
#
# uses hfst transducers; be sure to compile them beforehand! 

# algorithm:
# (create the rows of a table: 1 row per 1 typo from the input file) 
# 1) from typos.txt, remove everything except: _typo_ <tab> _correct_
# 2) for any number of possible modification type, do 
#     2.1) use a specialised transducer to generate correction candidates
#     2.2) if one of the candidates was the _correct_ one, make a mark #_modification_type
#     2.3) save the #_modification_type in a file
# 3) combine all the files to arrive at 3 columns: typo correct #modification_type(s)

# create the column of typos
cat ../typos.txt.old_error_types \
| sed 's/#.*$//' \
| grep '.' \
| cut -f 1 \
> only_typos.txt

# create the column of known corrects
cat ../typos.txt.old_error_types \
| sed 's/#.*$//' \
| grep '.' \
| cut -f 2 \
> only_corrects.txt

# sanity check: find rows where typo = correct 
paste only_typos.txt only_corrects.txt \
| sed 's/\t/@ /' \
| sed 's/$/ /' \
| sed '/^\([^@]*\)@.* \1 /s/$/#_no_error/' \
| sed 's/^.*#/#/' \
| sed 's/^[^#]*$//' \
> success_no_error.txt

# prepare typos for subsequent processing:
# add a special symbol @ to separate candidates of one typo from those of the next one
cat only_typos.txt \
| sed 's/$/\n@/' \
> typos_tmp.txt

# start with tmp file for including all the errors (resulting in a table)
paste only_typos.txt only_corrects.txt \
| paste - success_no_error.txt \
> tmp_errors_marked

# for every kind of a typo (add_one, delete_one etc.), ... 

for typo in add1 one2double del1 double2one transpose transpose1 aab2abb repetition subst1 subst1_kb_next subst1_gbd subst_accents subst_accents_sz insert_space capitalize strings transpose1_plus accents_plus length_plus
do

  # 1) create all the possible modifications of this type

  cat typos_tmp.txt \
  | hfst-lookup -s ${typo}.hfst \
  | sed '/^@/s/^@.*$/@/' \
  | sed 's/\t[^\t]*$//' \
  | sed 's/^[^\t]*\t//' \
  | tr '\n' ' ' \
  | sed 's/@ /@/g' \
  | tr -s '@' \
  | sed 's/@/\n/g' \
  > tmp1.txt

  # 2) check if some of the suggested corrections was indeed the known correct one
  # ... and mark the file line accordingly, i.e. with the type of the correction
  # (add1, del1 etc)
  
  paste only_corrects.txt tmp1.txt \
  | sed 's/\t/@ /' \
  | sed 's/$/ /' \
  | sed "/^\([^@]*\)@.* \1 /s/$/#_${typo}/" \
  | sed 's/^.*#/#/' \
  | sed 's/^[^#]*$//' \
  > tmp2.txt

  # collect all the classifications
  paste tmp_errors_marked tmp2.txt \
  > tmp3
  cp tmp3 tmp_errors_marked
done

# remove some redundant classifications
# (they are here because of the way we made the transducers,
# while experimenting with different ideas on how to classify)

# notice that the removal requires you to know how the "columns" of the tmp file were created; 
# look at the for-cycle 

cat tmp_errors_marked \
| tr -s '\t' \
| sed 's/\t#/@#/' \
| sed 's/\t#/ #/g' \
| sed 's/\t$//' \
| sed 's/@#/\t#/' \
| sed 's/#_no_error.*$/#_no_error/' \
| sed 's/\(#_transpose\) #_transpose1_plus/\1/' \
| sed 's/#_transpose #_transpose1/#_transpose1/' \
| sed 's/#_add1 #_one2double/#_one2double/' \
| sed 's/#_del1 #_double2one/#_double2one/' \
| sed 's/\(#_.*\) #_transpose1_plus/\1/' \
| sed 's/\(#_.*\) #_accents_plus/\1/' \
| sed 's/\(#_.*\) #_length_plus/\1/' \
> errors_marked.txt


# mark some more pairs with sed REs

cat errors_marked.txt \
| sed 's/\t/@/g' \
| sed '/#/!s/^\([^ ]*\)\([^ ]*\)@\1\([^ ][^ ]\)\2$/&@#_add2_adjacent/' \
| sed 's/^\([^ ]*\)\([ ]\)\([^ ]*\)@\1\3@#.*$/\1\2\3@\1\3@#_del_space/' \
| sed '/#/!s/^\([^ ]*\)\([^ ]\)\([^ ]*\)@\1\([^ ]\)\3$/&@#_subst1_xtra/' \
| sed '/#/!s/^\([^ ]*\)\([^ ]*\)@\1\( \)\2$/&@#_insert_space_xtra/' \
| sed '/#/!s/^\([^ ]*\)\([^ ][^ ]\)\([^ ]*\)@\1\([^ ][^ ]\)\3$/&@#_subst2_xtra_adjacent/' \
| sed '/#/!s/^\([^ ]*\)\([^ ]\)\([^ ][^ ]*\)\([^ ]\)\([^ ]*\)@\1[^ ]\3[^ ]\5$/&@#_subst2_xtra_nonadjacent/' \
\
| sed '/#/!s/^\([^ ]*\)\([^ ][^ ]\)\([^ ]*\)@\1\3$/&@#_del2_xtra_adjacent/' \
| sed '/#/!s/^\([^ ]*\)\([^ ]\)\([^ ][^ ]*\)\([^ ]\)\([^ ]*\)@\1\3\5$/&@#_del2_xtra_nonadjacent/' \
\
| sed '/#/!s/^\([^ ]*\)\([^ ][^ ]*\)\([^ ]*\)@\1[^ ]\2[^ ]\3$/&@#_add2_xtra_nonadjacent/' \
> errors_marked2.txt


# rename
# addN delN substN trans (N is the number of operations; N = 1, 2, 3)  
# _type = one2double, double2one, space etc
# # retain only the type field

cat errors_marked2.txt \
| sed 's/transpose1/trans_12-21/' \
| sed 's/transpose/trans/' \
| sed 's/one2double/add1_one2double/' \
| sed 's/double2one/del1_double2one/' \
| sed 's/insert_space_xtra/add1_space_letters/' \
| sed 's/insert_space/add1_space_nonletters/' \
| sed 's/^\(.*\)\(..\)\(.*\)@\1\3@#_repetition/&2/' \
| sed 's/^\(.*\)\(...\)\(.*\)@\1\3@#_repetition/&3/' \
| sed 's/repetition2/del2_repetition/' \
| sed 's/repetition3/del3_repetition/' \
| sed 's/^\(.*\)\([aeiou]\)\(.*\)@\1[aeiou]\3@#_subst1/&_aeiou2aeiou/' \
| sed 's/\(subst1.*\)_xtra/\1/' \
| sed 's/aab2abb/subst2_aab2abb/' \
| sed 's/xtra_adjacent/adjacent/' \
| sed 's/xtra_nonadjacent/nonadjacent/' \
| sed 's/del_space/del1_space/' \
| sed 's/#_length_plus//' \
| sed 's/capitalize/subst1_capitalize/' \
| sed 's/accents_plus/subst_accents_plus/' \
\
| sed 's/^.*@\([^@]*\)$/@\1/' \
| sed 's/@[^#]*$/@/' \
\
> error_types.txt


cat ../typos.txt.old_error_types \
| sed 's/^#.*$//' \
| grep '.' \
| paste - error_types.txt \
> err_types.txt

# create a 3-column table with some type for every word
# (in case of multiple types, keep only the first one on the line)
cat err_types.txt \
| sed 's/^\t@#.*$//' | sed 's/#[^@]*@/@/' | sed 's/@$/@#_complex/' | sed 's/@#_/# /g' \
| sed 's/#\([^#]*\) *#.*$/#\1/'\
> err_types_all_words.txt

exit

# some example filters for 
# more detailed look at a type

# make a frequency list for the letters that get substituted
cat errors_marked2.txt | grep '#_subst1$' | sed 's/#.*$//' | sed 's/@/ /' | gawk '{max=length($1); for (i=1; i <=max; i++){v1=substr($1, i, 1); v2=substr($2, i, 1); printf("%s", v1); if (v1 != v2){printf(":%s", v2)} } printf("\n")}' | sed 's/\(.:.\)/ \1 /g' | tr ' ' '\n' | grep ':' | sort | uniq -c | sort -nr | less

# frequency list of letters that have been omitted (and thus they need to be added to arrive at the correct word)

cat errors_marked2.txt | grep '#_add1' | sed 's/#.*$//' | sed 's/@/ /g' | sed 's/ $//' | sed 's/^\(.*\)\(.*\) \1\(.\)\2$/\1\2 \1\n\3:\n\2/' | grep ':' | sort | uniq -c | sort -nr | less

# frequency list of letters of correct words
cat only_corrects.txt | sed 's/./\n&\n/g' | grep '.' | sort | uniq -c | sort -nr | less

# --> they are rather similar; 
# a and s top the list of omitted ones probably because they are typed with the small finger of the left hand...

# notes
strings.regex: linguistic errors:
otsusi otsuseid
kumba kumma
töötleda töödelda
gbd <-> kpt

?
ühekordne <-> topelt
töödata töötada # või transpos dat -> tad

kombinatsioonid:
täpitäht + trükkimisega seotu 
transpos + ühekordne <-> topelt
transpos + transpos

praegu välja jäetud:
haruldane asendus, nt. n:l hüdraunuline
                       v:s mõistuv mõistus


2-3 kõrvuti tähte lisatud
pikem korduvus
suurema kaugusega transposits 
---
...miset -> miste, mist, mised, mise, misest
----

---


