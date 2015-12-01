#!/bin/bash

# ex: ./find_parallels.sh 
#  find all parallel forms in descriptive FST
#
# ex: INCLUDE_FILTER='$[ "+Sg" "+Ill" ]' ./find_parallels.sh
#  find parallel forms for words that have symbols +Sg +Ill in that order
#  somewhere on the lexical side
#
# ex: INCLUDE_FILTER="m a j a ?*" ./find_parallels.sh
#  find parallel forms for words that have lemma that starts with "maja"
#
# ex: GENERATOR="/your/lang/dir/generator-gt-norm.hfst" EXCLUDE_FILTER='~$"#"' ./find_parallels.sh
#  use alternative base-FST and narrower exclude filter.
#


GENERATOR=${GENERATOR:-"${GTLANG_est}/src/generator-gt-desc.hfst"}

if [ ! -r "$GENERATOR" ]; then
	pushd `dirname "$GENERATOR"`
	make `basename "$GENERATOR"`
	popd
fi


EXCLUDE_FILTER=${EXCLUDE_FILTER:-'~$["#" | "+Num" | "+Der" | "+Der/us" | "+Der/lik" | "+Dim/ke" | "+Dim/kene" | "+Comp" | "+Foc/gi" | "+prefix"]'}
INCLUDE_FILTER=${INCLUDE_FILTER:-'?*'}
FILTER=${FILTER:-"[$EXCLUDE_FILTER] .o. [$INCLUDE_FILTER]"}

echo "$FILTER" | hfst-regexp2fst | \
	hfst-compose -F -2 $GENERATOR | \
	hfst-fst2strings -c 0 | \
	awk -F: '
		BEGIN { lexical = ""; delete forms; delete grammar; delete maxforms; }
		function check() {
			if (lexical && lexical != $1) {
				if (length(forms) > 1) {
					split(gensub("+", " +", 1, lexical), lex, " ");	
					printf("%d %s %s", length(forms), lex[1], lex[2]);
					for (form in forms) {
						printf(" %s", form)
					}
					printf("\n");
					grammar[lex[2]] = grammar[lex[2]] + 1
					if (length(forms) > maxforms[lex[2]]) {
						maxforms[lex[2]] = length(forms);
					}
				}
				delete forms;
			}
			lexical = $1;
			forms[$2] = $2; 
		}
		{ check(); }
		END {
			$1 = ""; 
			check();
			print "Tag combinations with parallel forms (tagset, count of stems, max no of parallels):"
			for (g in grammar) {
				print g " " grammar[g] " " maxforms[g];
			}
		}
	'

