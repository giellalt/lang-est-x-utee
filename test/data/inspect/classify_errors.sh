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
cat ../typos.txt \
| sed 's/#.*$//' \
| grep '.' \
| cut -f 1 \
> only_typos.txt

# create the column of known corrects
cat ../typos.txt \
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

for typo in add1 one2double del1 double2one transpose transpose1 aab2abb repetition subst1 subst1_kb_next subst_accents subst_accents_sz insert_space capitalize
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
| sed 's/#_transpose #_transpose1/#_transpose1/' \
| sed 's/#_add1 #_one2double/#_one2double/' \
| sed 's/#_del1 #_double2one/#_double2one/' \
| sed 's/#_subst1 #_subst1_kb_next/#_subst1_kb_next/' \
| sed 's/#_subst1 #_subst_accents/#_subst_accents/' \
> errors_marked.txt

exit

# for counting the tags:
cat errors_marked.txt | grep '#' | sed 's/^[^#]*#/#/' | sed 's/#/\n#/g' | sed 's/ $//' | sort | uniq -c | sort -nr


