## Include this file to lexc directory to build lexical automata

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

SUBDIRS = filters . tests

##################################################################
#### BEGIN: Add local processing instructions BELOW this line ####
##################################################################

# Set this variable to point to generated lexc source files, if any:
GENRSRCS:=

########################################################
#### Add language-specific transducer targets here: ####

#################################################
#### Add language-specific build rules here: ####

# regex for emoticons
emoticon.hfst: $(top_srcdir)/src/fst/emoticon.hfst
		cp $< $@

# abbreviations with a final dot
# remove the paths with +Use/-PMatch and the tags +Use/PMatch
abbrevdot.tmp.hfst:  $(top_srcdir)/src/fst/morphology/abbrevdot.tmp.hfst \
			$(top_srcdir)/src/fst/filters/remove-Use_minus_PMatch-strings.hfst \
			$(top_srcdir)/src/fst/filters/remove-Use_minus_PMatch-tags.hfst
	$(PRINTF) "read regex \
			    @\"$(top_srcdir)/src/fst/filters/remove-Use_minus_PMatch-strings.hfst\" \
			.o. @\"$(top_srcdir)/src/fst/filters/remove-Use_PMatch-tags.hfst\"          \
			.o. @\"$<\"                                         \
			;\n\
		 save stack $@\n\
		 quit\n" | $(HFST_XFST) -p $(MORE_VERBOSITY) $(HFST_FORMAT)

# turn it right
abbrevdot.inv.hfst: abbrevdot.tmp.hfst
	$(AM_V_INVERT)$(HFST_INVERT) -i $< -o $@

# convert GT tags to CG tags
abbrdot-%.hfst:  abbrevdot.inv.hfst filters/make-%-CG-tags.hfst
	$(CMD)

# convert the 2 flag diacritics into pmatch variables
abbrdot_relabelled-%.hfst: abbrdot-%.hfst \
						 btrelabeller.hfst \
						 relabeller.hfst
	$(AM_V_HSUBST)$(HFST_SUBSTITUTE) \
		-f '@P.Pmatch.Backtrack@' -T btrelabeller.hfst $< \
		| $(HFST_SUBSTITUTE) \
		-f '@P.Pmatch.Loc@'       -T   relabeller.hfst \
		-o $@

# This is the real tokeniser build target:
tokeniser-gramcheck-gt-desc.pmhfst: tokeniser-gramcheck-gt-desc.pmscript \
                    analyser_relabelled-gramcheck-gt-desc.hfst \
                    analyser-url-gt-desc.hfst \
                    emoticon.hfst \
                    abbrdot_relabelled-gramcheck.hfst
	$(AM_V_PM2FST)$(HFST_PMATCH2FST) < $< > $@.tmp
	$(AM_V_at)mv -f $@.tmp $@

# not sure that gramcheck tokenisation should be different from disamb tokenisation
tokeniser-disamb-gt-desc.pmhfst: tokeniser-gramcheck-gt-desc.pmhfst
		cp $< $@

##################################################################
#### END: Add local processing instructions ABOVE this line ######
##################################################################

####### Other targets: ###########
clean-local:
	-rm -f *.hfst *.xfst *.pmhfst

include $(top_srcdir)/../giella-core/am-shared/tools-tokenisers-dir-include.am
include $(top_srcdir)/../giella-core/am-shared/devtest-include.am
