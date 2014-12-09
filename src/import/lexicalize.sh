#!/bin/sh

# format of input:
# laste|aed
# aasta|aeg

for w in `cut -d ' ' -f1 $1 | cut -d '|' -f 2 | sort -u `
do 
	echo
	echo "! $w:"
	grep -hrF " $w+" $GTHOME/langs/est/src/morphology/ | \
		sort -u | \
		grep -v '^[[:space:]]*!' | \
		while read row; do
			echo "!  $row"
			for pref in `egrep '\|'"$w"'\b' $1 | cut -d'|' -f1`; do
				echo "!   $pref$w:"
				echo $row | sed -e "s/^/$pref/" -e "s/:/:$pref/"
			done
		done
done
