#!/bin/bash
# list of transducers used for inspecting typos and their corrections

for typo in add1 one2double del1 double2one transpose transpose1 aab2abb repetition subst1 subst1_kb_next subst_accents subst_accents_sz insert_space capitalize
do
  hfst-regexp2fst --format=openfst-tropical -v -S -i ${typo}.regex -o ${typo}.hfst
done

