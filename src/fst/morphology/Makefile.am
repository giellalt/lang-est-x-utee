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

# build before test
SUBDIRS=. test

# Add language-specific flags for hfst-lexc compilation here:
if HAVE_SHARED_COMMON
HFST_LEXC_LOCAL_FLAGS=  # --Werror # uncomment if lexc is good enough
else
HFST_LEXC_LOCAL_FLAGS=  # No --Werror if deps are missing !
endif


####### Morphology source file defs: ########

# Set this to name of lexc file containing Multichar_Symbols and LEXICON Root
GT_LEXC_ROOT=$(srcdir)/root.lexc

# Set this to the names of all regular lexc source files:
GT_LEXC_SRCS_L1_L2=\
                         stems/abbreviations.lexc \
                         stems/adjectives.lexc \
                         stems/noninflecting_adjectives.lexc \
                         stems/comparative_adjectives.lexc \
                         stems/superlative_adjectives.lexc \
                         stems/adpositions.lexc \
                         stems/adverbs.lexc \
                         stems/conjunctions.lexc \
                         stems/genitive_attributes.lexc \
                         stems/interjections.lexc \
                         stems/nouns.lexc \
                         stems/cardinalnumerals.lexc \
                         stems/ordinalnumerals.lexc \
                         stems/pronouns.lexc \
                         stems/propernouns.lexc \
                         stems/verbs.lexc \
                         stems/noninflecting_verbs.lexc \
                         stems/final_components.lexc \
			stems/numbers.lexc \
			stems/acronyms.lexc \
			stems/symbol_strings.lexc \
			affixes/prefixes.lexc \
			affixes/regular_declinations.lexc \
			affixes/exceptional_declinations.lexc \
			affixes/verbs.lexc \
			affixes/gi.lexc

# If you are building an error-detecting L2 analyser, specify the lexc files
# that differ between the regular L1 and the L2 analysers below, in L1 and
# L2 respectively. L2 files must end in "*-L2.lexc". See SME for an example.
L1=

L2=

GT_LEXC_SRCS=\
			$(GT_LEXC_SRCS_L1_L2) \
			$(L1)

GT_LEXC_L2_SRCS=\
			$(GT_LEXC_SRCS_L1_L2) \
			$(L2)

# Set this to the names of all generated lexc files, if any
GENERATED_LEXC_SRCS=generated_files/mul-$(GLANG)-punctuation.lexc \
                    generated_files/mul-$(GLANG)-symbols.lexc

# change handling of shared lexical data here:
if HAVE_SHARED_COMMON
.generated/url.tmp.lexc: $(gt_SHARED_common)/src/fst/url.lexc
	$(MAKE) $(GENDIR)
	$(AM_V_CP)cp -f $< $@

generated_files/mul-$(GLANG)-%.lexc: $(gt_SHARED_common)/src/fst/stems/%.lexc
	$(AM_V_at)$(MKDIR_P) generated_files
	$(AM_V_CP)cp -f $< $@
else
# this is "safe" fallback (compiles but you miss everything)
.generated/url.tmp.lexc:
	echo "LEXICON Root" > $@
	echo "< h t t p (s) %: %/ %/ ?*> # ;" >> $@

.generated/mul-$(GLANG)-%.lexc:
	$(MAKE) $(GENDIR)
	echo "! Missing shared common data" > $@
endif
# add other lexical shared data handling here

# Set this to the names of all source xml files, if any
GT_XML_SRCS=

# Define any additional lexc sources here (compiled on their own):
GT_LOCAL_SRCS=\
				pair_initial.tmp.lexc \
				pair_final.tmp.lexc \
				num_initial.tmp.lexc \
				num_final.tmp.lexc \
				abbrevdot.tmp.lexc \
				guesser-simplex-nouns.tmp.lexc \
				guesser-names.tmp0.lexc

#				guesser-derivations.tmp.lexc
#				punctuation.tmp.lexc
#				acronyms.tmp.lexc 

# Define local xfscripts here:
GT_LOCAL_XFSCRIPT_SRCS=

# Define here any additional sources just included in the distro:
GT_DISTRO_SRCS=

### BEGIN: Local processing: ###
EST_AFFIX_FILES=$(srcdir)/affixes/regular_declinations \
				$(srcdir)/affixes/exceptional_declinations \
				$(srcdir)/affixes/verbs \
				$(srcdir)/affixes/gi

# make the parts inflect 
# by re-using root.lexc and affixes, and omitting all the stem lexicons
# ... and remove the flag diacritics from initial parts (why? because otherwise the filter that 
# puts the initial and final part together doesn't work ?)
 
pair_initial.tmp.lexc: pair_initial.lexc $(GT_LEXC_ROOT) $(EST_AFFIX_FILES:%=%.lexc)
	$(AM_V_GEN)cat $(GT_LEXC_ROOT) | sed '/^ *LEXICON  *Root/,$$d' > $@ && \
			  cat $< >> $@ && \
			  cat $(EST_AFFIX_FILES:%=%.lexc) | sed 's/@.\.[^@]*@//g' >> $@

num_initial.tmp.lexc: num_initial.lexc $(GT_LEXC_ROOT) $(EST_AFFIX_FILES:%=%.lexc)
	$(AM_V_GEN)cat $(GT_LEXC_ROOT) | sed '/^ *LEXICON  *Root/,$$d' > $@ && \
			  cat $< >> $@ && \
			  cat $(EST_AFFIX_FILES:%=%.lexc) | sed 's/@.\.[^@]*@//g' >> $@

pair_final.tmp.lexc: pair_final.lexc $(GT_LEXC_ROOT) $(EST_AFFIX_FILES:%=%.lexc)
	$(AM_V_GEN)cat $(GT_LEXC_ROOT) | sed '/^ *LEXICON  *Root/,$$d' > $@ && \
			  cat $< >> $@ && \
			  cat $(EST_AFFIX_FILES:%=%.lexc) >> $@

num_final.tmp.lexc: num_final.lexc $(GT_LEXC_ROOT) $(EST_AFFIX_FILES:%=%.lexc)
	$(AM_V_GEN)cat $(GT_LEXC_ROOT) | sed '/^ *LEXICON  *Root/,$$d' > $@ && \
			  cat $< >> $@ && \
			  cat $(EST_AFFIX_FILES:%=%.lexc) >> $@

# abbreviations with a dot ...
# ... should be kept separately because of tokenisation issues
# copy the abbrevs that can have a final dot and format them appropriately:
# attach a final dot and continuation lexicon ;
# and add flag diacritics to prevent these abbreviations to be part of some compound word

abbrevdot.tmp.lexc: stems/abbreviations.lexc $(GT_LEXC_ROOT) $(EST_AFFIX_FILES:%=%.lexc)
	$(AM_V_GEN)cat $(GT_LEXC_ROOT) | sed '/^ *LEXICON  *Root/,$$d' > $@ && \
	echo 'LEXICON Root'  >> $@ && \
	echo '  @D.Part@@P.Part.Bad@ DABBR ;'  >> $@ && \
	echo 'LEXICON DABBR'  >> $@ && \
	$(AM_V_GEN)cat $< | grep '^ *!.*DOTABBR' | sed 's/^ *!//' >> $@ && \
	$(AM_V_GEN)cat $< | grep 'may also end with a dot' | \
			   sed 's/:\([^ ]*\)  *[^ ]*  *; *! *may also end with a dot/:\1 DOTABBR ;/' >> $@ && \
			  cat $(EST_AFFIX_FILES:%=%.lexc) >> $@



# guesser:
# re-using root.lexc and affixes
guesser-simplex-nouns.tmp.lexc: guesser-simplex-nouns.lexc $(GT_LEXC_ROOT) $(EST_AFFIX_FILES:%=%.lexc)
	$(AM_V_GEN)cat $(GT_LEXC_ROOT) | sed '/^ *LEXICON  *Root/,$$d' > $@ && \
			  cat $< >> $@ && \
			  cat $(EST_AFFIX_FILES:%=%.lexc) >> $@

guesser-names.tmp0.lexc: guesser-simplex-nouns.lexc $(GT_LEXC_ROOT) $(EST_AFFIX_FILES:%=%.lexc)
	$(AM_V_GEN)cat $(GT_LEXC_ROOT) | sed '/^ *LEXICON  *Root/,$$d' > $@ && \
			  cat $< >> $@ && \
			  cat $(EST_AFFIX_FILES:%=%.lexc) >> $@

### List additional targets in the following variable, for build targets not
### covered by other means. This comes ***in addition to*** what you can do by
### just targeting lexicon.*: lexicon.tmp.*, and is useful if you want to build
### separate fst's that need further treatment in the src/ dir. See the language
### gle/ for an example of how this is used.

GIELLA_LOCAL_TARGETS=

### END: Local processing: ###

####### Other targets: ###########
# Clean: add local clean targets on separate lines, so that the first line can
# easily get updates from the template dir through svn merge.

include $(srcdir)/Makefile.modifications-local.am
include $(srcdir)/Makefile.modifications-phon.am
include $(top_srcdir)/../giella-core/am-shared/src-morphology-dir-include.am

# vim: set ft=automake:
include $(top_srcdir)/../giella-core/am-shared/devtest-include.am
