#!/usr/bin/env perl -w

use utf8;
use feature 'unicode_strings';
BEGIN {
       $| = 1;
       binmode(STDIN, ':encoding(UTF-8)');
       binmode(STDOUT, ':encoding(UTF-8)');
}
use open qw( :encoding(UTF-8) :std );

while (<>) {
#    chomp;
    s/\+Prs\+Ind/+Ind+Prs/g;
    s/\+Prs\+Cond/+Cond+Prs/g;
    s/\+Prs\+Imprt/+Imprt+Prs/g;
    s/\+Prt\+Ind/+Ind+Prt/g;
    s/\+Prt\+Cond/+Cond+Prt/g;
    s/\+Prt\+Imprt/+Imprt+Prt/g;

    print ;
}
