#!/bin/sh
# Example script
# modify according to the local directory structrure and file naming conventions

# purpose:
# I would like to see how many false correction candidates I would get
# if I create them in a certain way, i.e. add1, del1, transpose etc
# this script 
# 1) creates new strings from the error string
# 2) keeps only those that are valid words (according to the speller)
# 
# paste the result with errors_marked.txt 
# to inspect how many stupid suggestions the speller accepts...

# Output:
# possiblewords_<typo_class>.txt
# containing 4 <tab>-separated fields:
# typo <tab> correct word <tab> #_typo_class <tab> candidate1 candidate2 etc.


# first, fix a bug:
# add a <tab> to the end of line that contains no error classification 
cat errors_marked.txt \
| sed 's/\t/@/g' \
| sed '/^[^@]*@[^@]*$/s/$/@/' \
| sed 's/@/\t/g' \
> tmp_errors_marked.txt

# for any kind of classified typo, ...

for typo in add1 one2double del1 double2one transpose transpose1 aab2abb repetition subst1 subst1_kb_next subst_accents subst_accents_sz insert_space capitalize
do

  cat typos_tmp.txt \
  | hfst-lookup -s ${typo}.hfst \
  | sed '/^@/s/^@.*$/@/' \
  | sed 's/\t[^\t]*$//' \
  | sed 's/^[^\t]*\t//' \
\
  | grep '.' \
  | hfst-lookup -s -n 1 ~/giella/lang-est-x-utee/src/analyser-gt-desc.hfstol \
  | grep '.' \
  | sed 's/^@\t@.*$/@/' \
  | sed '/?\tinf/s/^.*$//' \
  | sed 's/\t.*$//' \
\
  | tr '\n' ' ' \
  | sed 's/@ /@/g' \
  | tr -s '@' \
  | tr -s ' ' \
  | sed 's/@/\n/g' \
\
  | gawk '{for (k=1; k <= NF; k++){a[$k]=k} for (k in a) {printf("%s ", k)} print ""; delete a}' \
  | paste tmp_errors_marked.txt - \
  > possiblewords_${typo}.txt
done

exit

part that is copied from classify_errors.sh
----
cat typos_tmp.txt \
| hfst-lookup -s add1.hfst \
| sed '/^@/s/^@.*$/@/' \
| sed 's/\t[^\t]*$//' \
| sed 's/^[^\t]*\t//' \
----

this is also copied
-----
| tr '\n' ' ' \
| sed 's/@ /@/g' \
| tr -s '@' \
| sed 's/@/\n/g' \
------

> suggestions_add1.txt

