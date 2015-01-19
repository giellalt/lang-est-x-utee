#!/bin/sh

# format of input:
# laste|aed
# aasta|aeg
# tolmu|imeja (+ja liide, tehakse asju)

for w in `cut -d ' ' -f1 $1 | cut -d '|' -f 2 | sort -u `
do 
	echo
	echo "! $w:"
	EXTRA=""
	case "$w" in
		*ja)
			EXTRA="$EXTRA|:\\+ja "
		;;
	esac
	[ -z "$EXTRA" ] || echo "! ($EXTRA)"
	grep -hrE " $w\\+[A-Z]$EXTRA" $GTHOME/langs/est/src/morphology/ | \
		sort -u | \
		grep -v '^[[:space:]]*!' | \
		while read row; do
			echo "!  $row"
			for pref in `egrep '\|'"$w"'\b' $1 | cut -d'|' -f1`; do
				echo "!   $pref$w:"
				case $w in
					*ja)
						w_=`echo $w | sed -e 's/ja$//'`
						echo $row | sed -e "s/^/$pref$w_/" -e "s/:+/:$pref$w_/"
					;;
					*)
						echo $row | sed -e "s/^/$pref/" -e "s/:/:$pref/"
					;;
				esac
			done
		done
done
