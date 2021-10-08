#!/bin/bash
# list of transducers used for inspecting typos and their corrections

hfst-regexp2fst --format=openfst-tropical -v -S -i add1.regex -o add1.hfst
hfst-regexp2fst --format=openfst-tropical -v -S -i aab2abb.regex -o aab2abb.hfst
hfst-regexp2fst --format=openfst-tropical -v -S -i del1.regex -o del1.hfst
hfst-regexp2fst --format=openfst-tropical -v -S -i double2one.regex -o double2one.hfst
hfst-regexp2fst --format=openfst-tropical -v -S -i one2double.regex -o one2double.hfst
hfst-regexp2fst --format=openfst-tropical -v -S -i repetition.regex -o repetition.hfst
hfst-regexp2fst --format=openfst-tropical -v -S -i subst1.regex -o subst1.hfst
hfst-regexp2fst --format=openfst-tropical -v -S -i subst1_kb_next.regex -o subst1_kb_next.hfst
hfst-regexp2fst --format=openfst-tropical -v -S -i subst_accents.regex -o subst_accents.hfst
hfst-regexp2fst --format=openfst-tropical -v -S -i subst_accents_sz.regex -o subst_accents_sz.hfst
hfst-regexp2fst --format=openfst-tropical -v -S -i transpose1.regex -o transpose1.hfst
hfst-regexp2fst --format=openfst-tropical -v -S -i transpose.regex -o transpose.hfst
hfst-regexp2fst --format=openfst-tropical -v -S -i insert_space.regex -o insert_space.hfst


