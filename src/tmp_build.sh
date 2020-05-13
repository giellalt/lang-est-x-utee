#!/bin/sh
# experimental build for Estonian
# involving re-ordering of usage-related flags
# Heiki-Jaan Kaalep

# make nets for lexc and twol:
hfst-lexc -o tmp.lexc morphology/root.lexc
hfst-twolc -o tmp.twol phonology/est-phon.twolc

# make generator
hfst-compose-intersect tmp.lexc tmp.twol -o tmp.gen

# make analyser
hfst-invert tmp.gen -o tmp.ana

# make tag reordering net
hfst-xfst -q -F reorder-usage-tags.regex

# analyser + reordered tags = final analyser
# reorder-usage-tags.regex uses ellipsis and thus has to be composed with analysis side
hfst-compose tmp.ana reorder-usage-tags.hfst -o tmp2.ana

# final generator
hfst-invert tmp2.ana -o tmp2.gen

# look at what you've done:
# hfst-fst2strings tmp2.gen | less
# hfst-fst2strings tmp2.ana | less
