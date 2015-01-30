#!/usr/bin/perl -w

while (my $word = <>) {
	chomp $word;
	my $rule = <>;
	chomp $rule;

	my $word = join(' ', map { (/\w/ && !/[_0]/) ? $_ : "%$_"; } (split('', $word)));

	for my $by_POS (split '&', $rule) {
		my ($pos, $readings) = split(' \*', $by_POS);
		$pos = '"+' . $pos . '"';
		$pos = 'm a "+V"' if $pos eq '"+V"';
		print ".o. [ ";

		print join(", ", map { "[ " . join(" ", map { "\"+$_\"" } (split(' ', $_))) . " ] <- []" } (split '\|', $readings));
		print " || [ .#. | %# ] $word $pos ?* _ .#. ]\n";
	}
}


