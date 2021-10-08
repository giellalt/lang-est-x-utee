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

cat typos_tmp.txt \
| hfst-lookup -s add1.hfst \
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
> possiblewords_add1.txt

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

