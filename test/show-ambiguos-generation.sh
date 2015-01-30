#!/bin/sh

echo '[~$[%#|%0|1|2|3|4|5|6|7|8|9|"+Foc/gi"|"+Dim/ke"|"+Dim/kene"]  .o. @"'$GTHOME'/langs/est/src/generator-gt-desc.hfstol"].u' \
	| hfst-regexp2fst -x ON \
	| hfst-fst2strings \
	| hfst-lookup  -q $GTHOME/langs/est/tools/mt/apertium/generator-mt-gt-norm.hfstol \
	| uniq \
	| awk '
		BEGIN { 
			p = 0; 
		} 
		
		/^$/ { 
			p = 0;
			prev = "";
		} 
		{ 
			if (p) { 
				print;
			} else { 
				if (prev) { 
					print prev;
					print;
					p = 1;
				} else {
					prev = $0;
				}
			}
		}'


