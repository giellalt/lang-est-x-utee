#!/bin/sed -f

s/^[^|]*|//
/@ARGPÜKS/!s/^.* \([^ ]*#[^ ]*#\).*$/& \1ÕIGEVORM/
/ÕIGEVORM/!s/^\([^ ]*\) \(.*\)!\\S\\\.1[67]\.PL.*@.*$/& \1[DÕIGEVORM/
/ÕIGEVORM/!s/^\([^ ]*\) \([^ ]*\) *!\\S\\\.2\.PL.*@.*$/& \2[DÕIGEVORM/
/ÕIGEVORM/!s/^[^ ]* [^ ]* \([^ ]*\) !\\H\\\.22\^E\^\.PL.*@.*$/& \1[DÕIGEVORM/
/ÕIGEVORM/!s/^[^ ]* [^ ]* \([^ ]*\) !\\S[^\\]*\\\.22\^E\^\.PL.*@.*$/& \1[DÕIGEVORM/
/ÕIGEVORM/!s/^\([^ ]*\[D\) .*\.PL.*@.*$/& \1ÕIGEVORM/
/ÕIGEVORM/!s/^\([^ ]*Pürenee\)\[\(d .*@.*\)$/\1\2 \1[DÕIGEVORM/
/ÕIGEVORM/s/\[D\[DÕIGE/[DÕIGE/
/^[^(].*l[ia]se\[D#/s/ [^ ]*ÕIGEVORM$//

