#!/bin/sh
# pronounciation marking characters and lexc-specific # to final lexc

sed 's/`/ˈ/g' \
| sed 's/´/˘/g' \
| sed 's/,/ʲ/g' \
| sed 's/ # *;/ @@@ ;/g' \
| sed 's/#/%#/g' \
| sed 's/@@@/#/g'


