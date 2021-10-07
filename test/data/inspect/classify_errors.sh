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

# for every typo, create all the possible modifications of a certain type:
# add_one, delete_one etc.
cat typos_tmp.txt \
| hfst-lookup -s add1.hfst \
| sed '/^@/s/^@.*$/@/' \
| sed 's/\t[^\t]*$//' \
| sed 's/^[^\t]*\t//' \
| tr '\n' ' ' \
| sed 's/@ /@/g' \
| tr -s '@' \
| sed 's/@/\n/g' \
> suggestions_add1.txt

cat typos_tmp.txt \
| hfst-lookup -s one2double.hfst \
| sed '/^@/s/^@.*$/@/' \
| sed 's/\t[^\t]*$//' \
| sed 's/^[^\t]*\t//' \
| tr '\n' ' ' \
| sed 's/@ /@/g' \
| tr -s '@' \
| sed 's/@/\n/g' \
> suggestions_one2double.txt

cat typos_tmp.txt \
| hfst-lookup -s del1.hfst \
| sed '/^@/s/^@.*$/@/' \
| sed 's/\t[^\t]*$//' \
| sed 's/^[^\t]*\t//' \
| tr '\n' ' ' \
| sed 's/@ /@/g' \
| tr -s '@' \
| sed 's/@/\n/g' \
> suggestions_del1.txt

cat typos_tmp.txt \
| hfst-lookup -s double2one.hfst \
| sed '/^@/s/^@.*$/@/' \
| sed 's/\t[^\t]*$//' \
| sed 's/^[^\t]*\t//' \
| tr '\n' ' ' \
| sed 's/@ /@/g' \
| tr -s '@' \
| sed 's/@/\n/g' \
> suggestions_double2one.txt

cat typos_tmp.txt \
| hfst-lookup -s transpose.hfst \
| sed '/^@/s/^@.*$/@/' \
| sed 's/\t[^\t]*$//' \
| sed 's/^[^\t]*\t//' \
| tr '\n' ' ' \
| sed 's/@ /@/g' \
| tr -s '@' \
| sed 's/@/\n/g' \
> suggestions_transpose.txt

cat typos_tmp.txt \
| hfst-lookup -s transpose1.hfst \
| sed '/^@/s/^@.*$/@/' \
| sed 's/\t[^\t]*$//' \
| sed 's/^[^\t]*\t//' \
| tr '\n' ' ' \
| sed 's/@ /@/g' \
| tr -s '@' \
| sed 's/@/\n/g' \
> suggestions_transpose1.txt

cat typos_tmp.txt \
| hfst-lookup -s aab2abb.hfst \
| sed '/^@/s/^@.*$/@/' \
| sed 's/\t[^\t]*$//' \
| sed 's/^[^\t]*\t//' \
| tr '\n' ' ' \
| sed 's/@ /@/g' \
| tr -s '@' \
| sed 's/@/\n/g' \
> suggestions_aab2abb.txt

cat typos_tmp.txt \
| hfst-lookup -s repetition.hfst \
| sed '/^@/s/^@.*$/@/' \
| sed 's/\t[^\t]*$//' \
| sed 's/^[^\t]*\t//' \
| tr '\n' ' ' \
| sed 's/@ /@/g' \
| tr -s '@' \
| sed 's/@/\n/g' \
> suggestions_repetition.txt

cat typos_tmp.txt \
| hfst-lookup -s subst1.hfst \
| sed '/^@/s/^@.*$/@/' \
| sed 's/\t[^\t]*$//' \
| sed 's/^[^\t]*\t//' \
| tr '\n' ' ' \
| sed 's/@ /@/g' \
| tr -s '@' \
| sed 's/@/\n/g' \
> suggestions_subst1.txt

cat typos_tmp.txt \
| hfst-lookup -s subst_accents.hfst \
| sed '/^@/s/^@.*$/@/' \
| sed 's/\t[^\t]*$//' \
| sed 's/^[^\t]*\t//' \
| tr '\n' ' ' \
| sed 's/@ /@/g' \
| tr -s '@' \
| sed 's/@/\n/g' \
> suggestions_accents.txt

cat typos_tmp.txt \
| hfst-lookup -s insert_space.hfst \
| sed '/^@/s/^@.*$/@/' \
| sed 's/\t[^\t]*$//' \
| sed 's/^[^\t]*\t//' \
| tr '\n' ' ' \
| sed 's/@ /@/g' \
| tr -s '@' \
| sed 's/@/\n/g' \
> suggestions_space.txt


# check if some of the suggested corrections was indeed the known correct one
# ... and mark the file line accordingly, i.e. with the type of the correction
# (add1, del1 etc)

paste only_corrects.txt suggestions_add1.txt \
| sed 's/\t/@ /' \
| sed 's/$/ /' \
| sed '/^\([^@]*\)@.* \1 /s/$/#_add1/' \
| sed 's/^.*#/#/' \
| sed 's/^[^#]*$//' \
> success_add1.txt

paste only_corrects.txt suggestions_one2double.txt \
| sed 's/\t/@ /' \
| sed 's/$/ /' \
| sed '/^\([^@]*\)@.* \1 /s/$/#_one2double/' \
| sed 's/^.*#/#/' \
| sed 's/^[^#]*$//' \
> success_one2double.txt

paste only_corrects.txt suggestions_del1.txt \
| sed 's/\t/@ /' \
| sed 's/$/ /' \
| sed '/^\([^@]*\)@.* \1 /s/$/#_del1/' \
| sed 's/^.*#/#/' \
| sed 's/^[^#]*$//' \
> success_del1.txt

paste only_corrects.txt suggestions_double2one.txt \
| sed 's/\t/@ /' \
| sed 's/$/ /' \
| sed '/^\([^@]*\)@.* \1 /s/$/#_double2one/' \
| sed 's/^.*#/#/' \
| sed 's/^[^#]*$//' \
> success_double2one.txt

paste only_corrects.txt suggestions_transpose.txt \
| sed 's/\t/@ /' \
| sed 's/$/ /' \
| sed '/^\([^@]*\)@.* \1 /s/$/#_transpose/' \
| sed 's/^.*#/#/' \
| sed 's/^[^#]*$//' \
> success_transpose.txt

paste only_corrects.txt suggestions_transpose1.txt \
| sed 's/\t/@ /' \
| sed 's/$/ /' \
| sed '/^\([^@]*\)@.* \1 /s/$/#_transpose1/' \
| sed 's/^.*#/#/' \
| sed 's/^[^#]*$//' \
> success_transpose1.txt

paste only_corrects.txt suggestions_aab2abb.txt \
| sed 's/\t/@ /' \
| sed 's/$/ /' \
| sed '/^\([^@]*\)@.* \1 /s/$/#_aab2abb/' \
| sed 's/^.*#/#/' \
| sed 's/^[^#]*$//' \
> success_aab2abb.txt

paste only_corrects.txt suggestions_repetition.txt \
| sed 's/\t/@ /' \
| sed 's/$/ /' \
| sed '/^\([^@]*\)@.* \1 /s/$/#_repetition/' \
| sed 's/^.*#/#/' \
| sed 's/^[^#]*$//' \
> success_repetition.txt

paste only_corrects.txt suggestions_subst1.txt \
| sed 's/\t/@ /' \
| sed 's/$/ /' \
| sed '/^\([^@]*\)@.* \1 /s/$/#_subst1/' \
| sed 's/^.*#/#/' \
| sed 's/^[^#]*$//' \
> success_subst1.txt

paste only_corrects.txt suggestions_accents.txt \
| sed 's/\t/@ /' \
| sed 's/$/ /' \
| sed '/^\([^@]*\)@.* \1 /s/$/#_accents/' \
| sed 's/^.*#/#/' \
| sed 's/^[^#]*$//' \
> success_accents.txt

paste only_corrects.txt suggestions_space.txt \
| sed 's/\t/@ /' \
| sed 's/$/ /' \
| sed '/^\([^@]*\)@.* \1 /s/$/#_space/' \
| sed 's/^.*#/#/' \
| sed 's/^[^#]*$//' \
> success_space.txt

# collect all the classifications
# and remove some redundant ones
# (they are here because of the way we made the transducers,
# while experimenting with different ideas on how to classify)

paste only_typos.txt only_corrects.txt \
| paste - success_no_error.txt \
| paste - success_add1.txt \
| paste - success_one2double.txt \
| paste - success_del1.txt \
| paste - success_double2one.txt \
| paste - success_transpose.txt \
| paste - success_transpose1.txt \
| paste - success_subst1.txt \
| paste - success_accents.txt \
| paste - success_aab2abb.txt \
| paste - success_repetition.txt \
| paste - success_space.txt \
| tr -s '\t' \
| sed 's/\t#/@#/' \
| sed 's/\t#/ #/g' \
| sed 's/\t$//' \
| sed 's/@#/\t#/' \
| sed 's/#_no_error.*$/#_no_error/' \
| sed 's/#_transpose #_transpose1/#_transpose1/' \
| sed 's/#_add1 #_one2double/#_one2double/' \
| sed 's/#_del1 #_double2one/#_double2one/' \
| sed 's/#_subst1 #_accents/#_accents/' \
> errors_marked.txt

exit

# for counting the tags:
cat errors_marked.txt | grep '#' | sed 's/^[^#]*#/#/' | sed 's/#/\n#/g' | sed 's/ $//' | sort | uniq -c | sort -nr


