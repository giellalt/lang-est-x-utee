#!/usr/bin/perl -w

while (my $word = <>) {
	chomp $word;
	my $rule = <>;
	chomp $rule;

	my $word = join(' ', map { /\w/ ? $_ : "%$_"; } (split('', $word)));

	for my $by_POS (split '&', $rule) {
		my ($pos, $readings) = split(' \*', $by_POS);
		$pos = '"+' . $pos . '"';
		$pos = 'm a "+V"' if $pos eq '"+V"';
		for my $r (split '\|', $readings) {

			my @r = map { "\"+$_\"" } (split(' ', $r));

			print "[ $word $pos @r ] <- [ $word $pos ],\n";

		}
	}
}


