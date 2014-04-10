## Process this file with automake to produce Makefile.in

## Copyright (C) 2011 Samediggi

## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.

## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.

## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Set this to name of lexc file containing Multichar_Symbols and LEXICON Root
GT_LEXC_ROOT=root.lexc

# Set this to the names of all other source lexc files
GT_LEXC_SRCS=\
			 affixes/cmd-rules.lexc \
			 stems/adjectives.lexc \
			 stems/adverbs.lexc \
			 stems/conjunctions.lexc \
			 stems/genitive-attributes.lexc \
			 stems/interjections.lexc \
			 stems/noninfectionals.lexc \
			 stems/nouns.lexc \
			 stems/numerals.lexc \
			 stems/prepostpos.lexc \
			 stems/pronouns.lexc \
			 stems/proper-names.lexc \
			 stems/punctuation.lexc \
			 stems/verbs.lexc

#			 affixes/adjectives.lexc \
#			 affixes/nouns.lexc \
#			 affixes/propernouns.lexc \
#			 affixes/verbs.lexc \
#			 affixes/digits.lexc \
#			 stems/adjectives.lexc \
#			 stems/nouns.lexc \
#			 stems/numerals.lexc \
#			 stems/prefixes.lexc \
#			 stems/pronouns.lexc \
#			 stems/digits.lexc \
#			 stems/verbs.lexc

# Set this to the names of all generated lexc files, if any
GENERATED_LEXC_SRCS=

# Set this to the names of all source xml files, if any
GT_XML_SRCS=

overriding-exceptions.all.lexc:	overriding-exceptions.lexc
	$(AM_V_GEN)cat $^ > $@

numbers.all.lexc:	numbers.lexc
	$(AM_V_GEN)cat $^ > $@

include $(top_srcdir)/am-shared/src-morphology-dir-include.am

if CAN_HFST
noinst_DATA+=overriding-exceptions.lexc.hfst numbers.lexc.hfst
endif

if CAN_XFST
noinst_DATA+=overriding-exceptions.lexc.xfst numbers.lexc.xfst
endif


# vim: set ft=automake:
