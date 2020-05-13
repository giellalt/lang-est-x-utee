## Process this file with automake to produce Makefile.in
## Copyright: Sámediggi/Divvun/UiT
## Licence: GPL v3+

# always build . last here, and tagsets have to be built after morphology
SUBDIRS = fst filters phonetics hyphenation orthography cg3 transcriptions tagsets .

####### Automake targets: ########

# Define target variables first, before assigning to them:
GT_ANALYSERS=
GT_GENERATORS=

#### Local modifications in *fst processing: ####
####
#### Copy the fallback targets, and rename them to the desired targets. Then:
#### Replace the 'cp' command (Xerox) / Prepend the hfst-invert command (Hfst -
#### remember to move the $<) with whatever you need to complete
#### the processing to get the final target transducer.
#### Remember to add the dependencies as well.
#### Also make sure that HFST and Xerox processing are the same.
####
#### If you add new transducers to be built, you need to add them to the
#### relevant variable, e.g.:
####
#### if CAN_HFST
#### GT_GENERATORS+=generator-oahpa-gt-norm.hfst
#### endif
####
#### NB!!!! The HFST targets should get a hyphen after 'analyser'/'generator'
#### respectively, to make the local targets minimally different from and
#### slightly more specific than the fallback targets. This is to avoid warnings
#### about duplicate targets. That is, the local targets should looke like:
####
#### analyser-%.hfst: analyser-%.tmp.hfst
#### generator-%.hfst: generator-%.tmp.hfst

##################################################################
#### BEGIN: Add local processing instructions BELOW this line ####
##################################################################

########################################################
#### Add language-specific transducer targets here: ####

#### Xerox transducers:
if CAN_XFST
GT_ANALYSERS+=analyser-gt-desc.xfst \
			  analyser-gt-norm.xfst \
			  analyser-disamb-gt-desc.xfst
GT_GENERATORS+=generator-gt-desc.xfst \
			   generator-gt-norm.xfst
endif # CAN_XFST

#### HFST transducers
if CAN_HFST
GT_ANALYSERS+=analyser-gt-desc.hfst \
			  analyser-gt-norm.hfst \
			  analyser-gt-guess.hfst \
			  analyser-disamb-gt-desc.hfst
GT_GENERATORS+=generator-gt-desc.hfst \
			   generator-gt-norm.hfst \
			   generator-gt-guess.hfst
endif # CAN_HFST

#### FOMA transducers
if CAN_FOMA
GT_ANALYSERS+=
GT_GENERATORS+=
endif # CAN_FOMA

#################################################
#### Add language-specific build rules here: ####

EST_EXTRA_PRE_FILTERS=filters/remove-sg-forms.est filters/remove-pl-forms.est filters/remove-sg-nom-forms.est filters/remove-non-gi-forms.est filters/block-derivations.est # filters/remove-usage-tags.est
EST_GUESSER_PRE_FILTERS=filters/block-derivations.est 
EST_EXTRA_POST_FILTERS=filters/modify-derivations.est # filters/downcase-derived_proper-strings.est
EST_WORDPAIR_FILTERS=filters/reorder-tags.est filters/wordpair-filter.est
EST_NUMERAL_FILTERS=filters/reorder-tags.est filters/numeral-filter.est
#EST_COMPOUND_PRE_FILTERS=filters/block-compounds.est
#EST_COMPOUND_POST_FILTERS=filters/compound-filter.est

# paired words are words whose both parts inflect, e.g. emb-kumb, kihin-kahin
# paired words: initial part
# HFST:
pair_initial.tmp1.hfst: fst/pair_initial.tmp.hfst \
					 fst/phonology.compose.hfst
	$(AM_V_INTRSCT)\
		  $(HFST_DETERMINIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) $<\
		| $(HFST_MINIMIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) \
		| $(HFST_COMPOSE_INTERSECT) $(COMPOSE_INTERSECT_FLAG) \
			$(MORE_VERBOSITY) $(HFST_FLAGS) \
			-2 fst/phonology.compose.hfst \
		| $(HFST_MINIMIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) \
		-o $@

# XEROX
pair_initial.tmp1.xfst: fst/pair_initial.tmp.xfst \
			 fst/phonology.compose.xfst
	$(AM_V_LEXC)$(PRINTF) \
		"read-source fst/pair_initial.tmp.xfst\n\
		read-rules fst/phon.compose.xfst\n\
		compose-result\n\
		save-result $@\n\
		quit\n" \
		| $(LEXC) $(VERBOSITY)

# compound numerals where both parts inflect, e.g. viis#sada, viie#saja
# compound numerals: initial part
# HFST:
num_initial.tmp1.hfst: fst/num_initial.tmp.hfst \
					 fst/phonology.compose.hfst
	$(AM_V_INTRSCT)\
		  $(HFST_DETERMINIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) $<\
		| $(HFST_MINIMIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) \
		| $(HFST_COMPOSE_INTERSECT) $(COMPOSE_INTERSECT_FLAG) \
			$(MORE_VERBOSITY) $(HFST_FLAGS) \
			-2 fst/phonology.compose.hfst \
		| $(HFST_MINIMIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) \
		-o $@

# XEROX
num_initial.tmp1.xfst: fst/num_initial.tmp.xfst \
			 fst/phonology.compose.xfst
	$(AM_V_LEXC)$(PRINTF) \
		"read-source fst/num_initial.tmp.xfst\n\
		read-rules fst/phonology.compose.xfst\n\
		compose-result\nsave-result $@\n\
		quit\n" \
		| $(LEXC) $(VERBOSITY)


# paired words: final part
# HFST:
pair_final.tmp1.hfst: fst/pair_final.tmp.hfst \
					 fst/phonology.compose.hfst
	$(AM_V_INTRSCT)\
		  $(HFST_DETERMINIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) $<\
		| $(HFST_MINIMIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) \
		| $(HFST_COMPOSE_INTERSECT) $(COMPOSE_INTERSECT_FLAG) \
			$(MORE_VERBOSITY) $(HFST_FLAGS) \
			-2 fst/phonology.compose.hfst \
		| $(HFST_MINIMIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) \
		-o $@ 

# XEROX
pair_final.tmp1.xfst: fst/pair_final.tmp.xfst \
			 fst/phonology.compose.xfst
	$(AM_V_LEXC)$(PRINTF) \
		"read-source fst/pair_final.tmp.xfst\n\
		read-rules fst/phonology.compose.xfst\n\
		compose-result\n\
		save-result $@\n\
		quit\n" \
		| $(LEXC) $(VERBOSITY)

# compound numerals: final part
# HFST:
num_final.tmp1.hfst: fst/num_final.tmp.hfst \
					 fst/phonology.compose.hfst
	$(AM_V_INTRSCT)\
		  $(HFST_DETERMINIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) $<\
		| $(HFST_MINIMIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) \
		| $(HFST_COMPOSE_INTERSECT) $(COMPOSE_INTERSECT_FLAG) \
			$(MORE_VERBOSITY) $(HFST_FLAGS) \
			-2 fst/phonology.compose.hfst \
		| $(HFST_MINIMIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) \
		-o $@ 

# XEROX
num_final.tmp1.xfst: fst/num_final.tmp.xfst \
			 fst/phonology.compose.xfst
	$(AM_V_LEXC)$(PRINTF) \
		"read-source fst/num_final.tmp.xfst\n\
		read-rules fst/phonology.compose.xfst\n\
		compose-result\n\
		save-result $@\n\
		quit\n" \
		| $(LEXC) $(VERBOSITY)

# upcase names:
# upcase both the lexical and the surface side
fst/guesser.tmp.hfst: fst/guesser.tmp0.hfst filters/upcase-guessed_proper-strings.est.hfst
	$(AM_V_XFST)$(PRINTF) "set flag-is-epsilon OFF\n\
			read regex                         \
			@\"filters/upcase-guessed_proper-strings.est.hfst\".i       \
			.o. @\"$<\"   \
			.o. @\"filters/upcase-guessed_proper-strings.est.hfst\"       \
			;\n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)
	

# guesser
# HFST:
# a transducer for blabla- and Blabla-
guesser-smth.hfst: fst/guesser-smth.xfscript
	$(AM_V_XFST)$(PRINTF) "set flag-is-epsilon ON\n\
			source $<   \
			\n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

guesser.tmp1.hfst: fst/guesser.tmp.hfst \
					 fst/phonology.compose.hfst
	$(AM_V_INTRSCT)\
		  $(HFST_DETERMINIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) $<\
		| $(HFST_MINIMIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) \
		| $(HFST_COMPOSE_INTERSECT) $(COMPOSE_INTERSECT_FLAG) \
			$(MORE_VERBOSITY) $(HFST_FLAGS) \
			-2 fst/phonology.compose.hfst \
		| $(HFST_MINIMIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) \
		-o $@ 

# XEROX
# not implemented...

# acronyms
acronyms.tmp1.%: fst/acronyms.tmp.%
			   cp $< $@ 

# FOMA
# not implemented...

# HFST: generator 
# Xerox & FOMA: analyser
# (with a language-specific tag reordering script applied)
pair_initial.tmp.%: pair_initial.tmp1.% \
					filters/reorder-tags.$(GTLANG).% \
					filters/reorder-semantic-tags.%       \
					filters/reorder-subpos-tags.%         \
					filters/remove-mwe-tags.%
	$(AM_V_XFST_TOOL)$(PRINTF) "set flag-is-epsilon ON\n\
			read regex \
			 @\"filters/reorder-tags.$(GTLANG).$*\"\
			.o. @\"filters/reorder-subpos-tags.$*\"   \
			.o. @\"filters/reorder-semantic-tags.$*\" \
			.o. @\"filters/remove-mwe-tags.$*\"       \
			.o. @\"$<\" \
			;\n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

num_initial.tmp.%: num_initial.tmp1.% \
					filters/reorder-tags.$(GTLANG).% \
					filters/reorder-semantic-tags.%       \
					filters/reorder-subpos-tags.%         \
					filters/remove-mwe-tags.%
	$(AM_V_XFST_TOOL)$(PRINTF) "set flag-is-epsilon ON\n\
			read regex \
			 @\"filters/reorder-tags.$(GTLANG).$*\"\
			.o. @\"filters/reorder-subpos-tags.$*\"   \
			.o. @\"filters/reorder-semantic-tags.$*\" \
			.o. @\"filters/remove-mwe-tags.$*\"       \
			.o. @\"$<\" \
			;\n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)


# HFST: generator 
# Xerox & FOMA: analyser
# (with a language-specific tag reordering script applied)
pair_final.tmp.%: pair_final.tmp1.% \
					filters/reorder-tags.$(GTLANG).% \
					filters/reorder-semantic-tags.%       \
					filters/reorder-subpos-tags.%         \
					filters/remove-mwe-tags.%
	$(AM_V_XFST_TOOL)$(PRINTF) "set flag-is-epsilon ON\n\
			read regex \
			 @\"filters/reorder-tags.$(GTLANG).$*\"\
			.o. @\"filters/reorder-subpos-tags.$*\"   \
			.o. @\"filters/reorder-semantic-tags.$*\" \
			.o. @\"filters/remove-mwe-tags.$*\"       \
			.o. @\"$<\" \
			;\n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

num_final.tmp.%: num_final.tmp1.% \
					filters/reorder-tags.$(GTLANG).% \
					filters/reorder-semantic-tags.%       \
					filters/reorder-subpos-tags.%         \
					filters/remove-mwe-tags.%
	$(AM_V_XFST_TOOL)$(PRINTF) "set flag-is-epsilon ON\n\
			read regex \
			 @\"filters/reorder-tags.$(GTLANG).$*\"\
			.o. @\"filters/reorder-subpos-tags.$*\"   \
			.o. @\"filters/reorder-semantic-tags.$*\" \
			.o. @\"filters/remove-mwe-tags.$*\"       \
			.o. @\"$<\" \
			;\n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

guesser.tmp.%: guesser.tmp1.% \
					filters/reorder-tags.$(GTLANG).% \
					filters/reorder-semantic-tags.%       \
					filters/reorder-subpos-tags.%         \
					filters/remove-mwe-tags.%
	$(AM_V_XFST_TOOL)$(PRINTF) "set flag-is-epsilon ON\n\
			read regex \
			 @\"filters/reorder-tags.$(GTLANG).$*\"\
			.o. @\"filters/reorder-subpos-tags.$*\"   \
			.o. @\"filters/reorder-semantic-tags.$*\" \
			.o. @\"filters/remove-mwe-tags.$*\"       \
			.o. @\"$<\" \
			;\n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

acronyms.tmp.%: acronyms.tmp1.% \
					filters/reorder-tags.$(GTLANG).% \
					filters/reorder-semantic-tags.%       \
					filters/reorder-subpos-tags.%         \
					filters/remove-mwe-tags.%
	$(AM_V_XFST_TOOL)$(PRINTF) "set flag-is-epsilon ON\n\
			read regex \
			 @\"filters/reorder-tags.$(GTLANG).$*\"\
			.o. @\"filters/reorder-subpos-tags.$*\"   \
			.o. @\"filters/reorder-semantic-tags.$*\" \
			.o. @\"filters/remove-mwe-tags.$*\"       \
			.o. @\"$<\" \
			;\n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

# HFST: generator 
# Xerox & FOMA: analyser
#

redundant_wordpairs.%: pair_final.tmp.% pair_initial.tmp.%
	$(AM_V_XFST_TOOL)$(PRINTF) "set flag-is-epsilon ON\n\
			read regex [ [~[?* \"+Foc/gi\" ?*] \
			.o. @\"pair_initial.tmp.$*\"] (\"-\") @\"pair_final.tmp.$*\"] \
			.o. ~[?* » ?*] ; \nsave stack $@\nquit\n" | $(XFST_TOOL)

redundant_numerals.%: num_final.tmp.% num_initial.tmp.%
	$(AM_V_XFST_TOOL)$(PRINTF) "set flag-is-epsilon ON\n\
			read regex [ [~[?* \"+Foc/gi\" ?*] \
			.o. @\"num_initial.tmp.$*\"] @\"num_final.tmp.$*\"] \
			.o. ~[?* » ?*] ; \nsave stack $@\nquit\n" | $(XFST_TOOL)

# We need to add processing of language-specific tags in the generator for paired words:
# HFST:
generator-wordpairs-raw.simple.hfst: redundant_wordpairs.hfst \
					$(EST_WORDPAIR_FILTERS:%=%.hfst)
	$(AM_V_XFST)$(PRINTF) "set flag-is-epsilon ON\n\
			read regex                         \
			$(EST_WORDPAIR_FILTERS:%=@\"%.hfst\" .o.)    \
			@\"$<\"                                       \
			;\n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

generator-numerals-raw.simple.hfst: redundant_numerals.hfst \
					$(EST_NUMERAL_FILTERS:%=%.hfst)
	$(AM_V_XFST)$(PRINTF) "set flag-is-epsilon ON\n\
			read regex                         \
			$(EST_NUMERAL_FILTERS:%=@\"%.hfst\" .o.)    \
			@\"$<\"                                       \
			;\n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

# guesser: no derivation allowed
guesser-raw.simple.hfst: guesser.tmp.hfst \
				$(EST_GUESSER_PRE_FILTERS:%=%.hfst) 
	$(AM_V_XFST)$(PRINTF) "set flag-is-epsilon ON\n\
			read regex                         \
			$(EST_GUESSER_PRE_FILTERS:%=@\"%.hfst\" .o.)    \
			[ @\"$<\" ] \
			;\n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

# guesser: use filters for derivation
#guesser-raw.simple.hfst: guesser.tmp.hfst \
#				$(EST_GUESSER_PRE_FILTERS:%=%.hfst) \
#				$(EST_EXTRA_POST_FILTERS:%=%.hfst) \
#				filters/downcase-derived_proper-strings.est.hfst
#	$(AM_V_XFST)$(PRINTF) "set flag-is-epsilon ON\n\
#			read regex                         \
#			$(EST_GUESSER_PRE_FILTERS:%=@\"%.hfst\" .o.)    \
#			[ @\"$<\" ] \
#			$(EST_EXTRA_POST_FILTERS:%=.o. @\"%.hfst\")   \
#			;\n\
#			define fst \n\
#			set flag-is-epsilon OFF\n\
#			read regex fst \
#			.o. @\"filters/downcase-derived_proper-strings.est.hfst\"       \
#			;\n\
#		 save stack $@\n\
#		 quit\n" | $(XFST_TOOL)
#

# XEROX:
analyser-wordpairs-raw.simple.xfst: redundant_wordpairs.xfst \
					$(EST_WORDPAIR_FILTERS:%=%.xfst)
	$(AM_V_XFST)$(PRINTF) "set flag-is-epsilon ON\n\
			read regex                         \
			$(EST_WORDPAIR_FILTERS:%=@\"%.xfst\" .o.)    \
			@\"$<\"                                       \
			;\n\
		 save stack $@\n\
		 quit\n" | $(XFST) $(VERBOSITY)

analyser-numerals-raw.simple.xfst: redundant_numerals.xfst \
					$(EST_NUMERAL_FILTERS:%=%.xfst)
	$(AM_V_XFST)$(PRINTF) "set flag-is-epsilon ON\n\
			read regex                         \
			$(EST_NUMERAL_FILTERS:%=@\"%.xfst\" .o.)    \
			@\"$<\"                                       \
			;\n\
		 save stack $@\n\
		 quit\n" | $(XFST) $(VERBOSITY)

# We need to add processing of language-specific tags in the analyser:
# XEROX:
# NB! cleanup net
analyser-raw-gt-desc.simple.xfst: analyser-raw-gt-desc.tmp.xfst \
				analyser-numerals-raw.simple.xfst \
				$(EST_EXTRA_PRE_FILTERS:%=%.xfst) \
				$(EST_EXTRA_POST_FILTERS:%=%.xfst) \
				filters/downcase-derived_proper-strings.est.xfst
	$(AM_V_XFST)$(PRINTF) "set flag-is-epsilon ON\n\
			read regex                         \
			$(EST_EXTRA_PRE_FILTERS:%=@\"%.xfst\" .o.)    \
			[ @\"$<\" | @\"analyser-numerals-raw.simple.xfst\" ]  \
			$(EST_EXTRA_POST_FILTERS:%=.o. @\"%.xfst\")   \
			;\n\
			cleanup net\n\
			define fst \n\
			set flag-is-epsilon OFF\n\
			read regex fst \
			.o. @\"filters/downcase-derived_proper-strings.est.xfst\"       \
			;\n\
		 save stack $@\n\
		 quit\n" | $(XFST) $(VERBOSITY)

# include paired words and compound numerals
# We need to add processing of language-specific tags in the generator:
# HFST:
generator-raw-gt-desc.simple.hfst: generator-raw-gt-desc.tmp.hfst \
				generator-numerals-raw.simple.hfst \
				generator-wordpairs-raw.simple.hfst \
				$(EST_EXTRA_PRE_FILTERS:%=%.hfst) \
				$(EST_EXTRA_POST_FILTERS:%=%.hfst) \
				filters/downcase-derived_proper-strings.est.hfst
	$(AM_V_XFST)$(PRINTF) "set flag-is-epsilon ON\n\
			read regex                         \
			$(EST_EXTRA_PRE_FILTERS:%=@\"%.hfst\" .o.)    \
			[ @\"$<\" | @\"generator-numerals-raw.simple.hfst\" \
			          | @\"generator-wordpairs-raw.simple.hfst\"] \
			$(EST_EXTRA_POST_FILTERS:%=.o. @\"%.hfst\")   \
			;\n\
			define fst \n\
			set flag-is-epsilon OFF\n\
			read regex fst \
			.o. @\"filters/downcase-derived_proper-strings.est.hfst\"       \
			;\n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)


# compound words: 
# 1. the first part cannot be a form with a focus particle, so filter it out
# 2. the first part may end with a hyphen (ajalooline+A+Der/minus:ajaloolis»-), which may be omitted in compounds,
#    or the first part may have a hyphen appended (for better readabilty of a compound)
# HFST:
generator-raw-gt-desc.comp.hfst: generator-raw-gt-desc.simple.hfst \
				filters/evaluate-flags.est.hfst
	$(AM_V_XFST)$(PRINTF) "set flag-is-epsilon ON\n\
			read regex \
			[								\
			  [                                                                    \
			    [                                                                \
			      ~[?* \"+Foc/gi\" ?*] .o. @\"$<\"  \
			       .o. [[ \"-\" (->) 0 || » _ .#. ] | [ [..] (->) \"-\" || \\[\"-\"] _ .#. ]] \
			    ] \"#\"                                \
			  ]* @\"$<\"                                                         \
			] @\"filters/evaluate-flags.est.hfst\"                               \
			;\n\
		save stack $@\n\
		quit\n" | $(XFST_TOOL)

# XFST:
analyser-raw-gt-desc.comp.xfst: analyser-raw-gt-desc.simple.xfst \
				filters/evaluate-flags.est.xfst
	$(AM_V_XFST)$(PRINTF) "set flag-is-epsilon ON\n\
			read regex \
			[                                                                    \
			  [                                                                  \
			    [                                                                \
			      ~[?* \"+Foc/gi\" ?*] .o. @\"$<\"  \
			       .o. [[ \"-\" (->) 0 || » _ .#. ] | [ [..] (->) \"-\" || \\[\"-\"] _ .#. ]] \
			    ] \"#\"                                                          \
			  ]* @\"$<\"                                                         \
			] @\"filters/evaluate-flags.est.xfst\"                               \
			;\n\
			cleanup net\n\
		save stack $@\n\
		quit\n" | $(XFST) $(VERBOSITY)

# the vocabulary, i.e. words that might be combined with - / or otherwise
# HFST:
generator-raw-gt-desc.vocabulary.hfst: generator-raw-gt-desc.comp.hfst
	$(AM_V_XFST)$(PRINTF) "set flag-is-epsilon ON\n\
			read regex @\"$<\" ; \n\
			save stack $@\n\
			quit\n" | $(XFST_TOOL)

# XEROX:
analyser-raw-gt-desc.vocabulary.xfst: analyser-raw-gt-desc.comp.xfst \
					analyser-wordpairs-raw.simple.xfst 					
	$(AM_V_XFST)$(PRINTF) "set flag-is-epsilon ON\n\
			read regex @\"$<\" ; \n\
			read regex @\"analyser-wordpairs-raw.simple.xfst\" ; \n\
			union net\n\
			cleanup net\n\
			save stack $@\n\
			quit\n" | $(XFST) $(VERBOSITY)

# weights added to all analyses
# 7.01.2019 from Sjur:
# Hfst - add weights to compounds if using tropical-semiring fst format:
if WITH_OFST_TROPICAL
generator-raw-gt-desc.weighted.hfst: generator-raw-gt-desc.vocabulary.hfst
	$(AM_V_REWEIGHT)$(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) \
		-S '#' -a 30 --arcs-only -i $< \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/mine' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/ja' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/nu' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/mus' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/ng' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/v' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/tav' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/nud' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/mata' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/matu' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/tamatu' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/tu' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/tud' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/lik' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/line' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/ne' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/lt' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/sti' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/ini' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/m' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/im' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/nna' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/kond' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/ist' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/is' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/us' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/ti' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/lane' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/kas' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+N' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+A' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Num' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Pron' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+V' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Adv' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Interj' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+CC' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+CS' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Adp' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Pref' -a 5 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Prop' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Card' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Ord' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Comp' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Superl' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Sg' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Pl' -a 1 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Nom' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Gen' -a 1 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Par' -a 2 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Ill' -a 3 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Ine' -a 3 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Ela' -a 3 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+All' -a 3 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Ade' -a 3 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Abl' -a 3 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Tra' -a 3 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Trm' -a 3 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Ess' -a 3 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Abe' -a 3 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Com' -a 3 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Impers' -a 1 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Pers' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Prs' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Prt' -a 1 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Ind' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Cond' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Imprt' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Quot' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Sg1' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Sg2' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Sg3' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Pl1' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Pl2' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Pl3' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Aff' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Neg' -a 1 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Sup' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Inf' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Ger' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Prc' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Foc/gi' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Emph' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Pref' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Dim/ke' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+ABBR' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+ACR' -a 5 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Use/Rare' -a 30 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Use/Hyp' -a 30 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Use/NotNorm' -a 30 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Use/CommonNotNorm' -a 30 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Use/Circ' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Guess' -a 200 -A \
		> $@

else !WITH_OFST_TROPICAL

generator-raw-gt-desc.weighted.hfst: generator-raw-gt-desc.vocabulary.hfst
		cp $< $@
endif !WITH_OFST_TROPICAL


# analogy with generator-raw-gt-desc.weighted.hfst
# Hfst - add weights to compounds if using tropical-semiring fst format:
if WITH_OFST_TROPICAL
guesser-raw.weighted.hfst: guesser-raw.simple.hfst
	$(AM_V_REWEIGHT)$(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) \
		-S '#' -a 30 --arcs-only -i $< \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/mine' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/ja' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/nu' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/mus' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/ng' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/v' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/tav' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/nud' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/mata' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/matu' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/tamatu' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/tu' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/tud' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/lik' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/line' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/ne' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/lt' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/sti' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/ini' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/m' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/im' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/nna' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/kond' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/ist' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/is' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/us' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/ti' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/lane' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/kas' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+N' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+A' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Num' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Pron' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+V' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Adv' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Interj' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+CC' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+CS' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Adp' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Pref' -a 5 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Prop' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Card' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Ord' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Comp' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Superl' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Sg' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Pl' -a 1 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Nom' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Gen' -a 1 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Par' -a 2 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Ill' -a 3 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Ine' -a 3 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Ela' -a 3 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+All' -a 3 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Ade' -a 3 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Abl' -a 3 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Tra' -a 3 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Trm' -a 3 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Ess' -a 3 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Abe' -a 3 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Com' -a 3 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Impers' -a 1 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Pers' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Prs' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Prt' -a 1 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Ind' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Cond' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Imprt' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Quot' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Sg1' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Sg2' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Sg3' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Pl1' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Pl2' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Pl3' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Aff' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Neg' -a 1 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Sup' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Inf' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Ger' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Prc' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Foc/gi' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Emph' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Pref' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Dim/ke' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+ABBR' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+ACR' -a 5 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Use/Rare' -a 30 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Use/Hyp' -a 30 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Use/NotNorm' -a 30 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Use/CommonNotNorm' -a 30 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Use/Circ' -a 0 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Guess' -a 200 -A \
		> $@

else !WITH_OFST_TROPICAL

guesser-raw.weighted.hfst: guesser-raw.simple.hfst 
		cp $< $@
endif !WITH_OFST_TROPICAL

# make the raw ones
# HFST:
# map the name to GT/Divvun conventions

generator-raw-gt-desc.hfst: generator-raw-gt-desc.weighted.hfst 
		cp $< $@

# HFST:
# this is probably the pure guesser;
generator-raw-gt-guess.hfst: guesser-raw.weighted.hfst \
					filters/remove-hyphenation-marks.hfst        \
					filters/remove-infl_deriv-borders.hfst       \
					filters/remove-word-boundary.hfst            
	$(AM_V_XFST_TOOL)$(PRINTF) "read regex \
			@\"$<\" \
			.o. @\"filters/remove-hyphenation-marks.hfst\"        \
			.o. @\"filters/remove-infl_deriv-borders.hfst\"       \
			.o. @\"filters/remove-word-boundary.hfst\"            \
			;\n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

# HFST:
# upcasing added (like for analyser-gt-desc)
# perhaps a spellrelax filter should be also added ?
analyser-raw-gt-guess.hfst: generator-raw-gt-guess.hfst \
					orthography/inituppercase.compose.hfst       \
					orthography/allcaps.compose.hfst       \
					orthography/spellrelax.compose.hfst
	$(AM_V_XFST_TOOL)$(PRINTF) "set flag-is-epsilon ON\n\
			read regex \
			@\"$<\" \
			.o. [@\"orthography/inituppercase.compose.hfst\"       \
			| @\"orthography/allcaps.compose.hfst\" ]      \
			.o. @\"orthography/spellrelax.compose.hfst\"          \
			;\n\
		 invert net \n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)


# XEROX:
# probably garbage anyway
analyser-raw-gt-desc.xfst: analyser-raw-gt-desc.vocabulary.xfst 
		cp $< $@

# generator with a guesser
# 
# katsetus
generator-gt-guess.hfst: generator-gt-desc.hfst \
			 guesser-smth.hfst \
			 generator-raw-gt-guess.hfst
	$(AM_V_XFST_TOOL)$(PRINTF) "read regex \
			[[(@\"guesser-smth.hfst\") @\"$<\"] | @\"generator-raw-gt-guess.hfst\"] \
			; \n\
		 	save stack $@\n\
		 	quit\n" | $(XFST_TOOL)

analyser-gt-guess.hfst: analyser-gt-desc.hfst \
			guesser-smth.hfst \
			analyser-raw-gt-guess.hfst
	$(AM_V_XFST_TOOL)$(PRINTF) "read regex \
			[[([ @\"guesser-smth.hfst\"].i) @\"$<\" ] | @\"analyser-raw-gt-guess.hfst\"] \
			; \n\
		 	save stack $@\n\
		 	quit\n" | $(XFST_TOOL)

# XEROX:
# not implemented...
#


##################################################################
#### END: Add local processing instructions ABOVE this line ######
##################################################################

include $(top_srcdir)/../giella-core/am-shared/src-dir-include.am
