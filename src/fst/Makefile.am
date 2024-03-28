## Process this file with automake to produce Makefile.in
## Copyright: Sámediggi/Divvun/UiT
## Licence: GPL v3+

# always build . last here, and tagsets have to be built after morphology
SUBDIRS = morphology filters phonetics syllabification orthography transcriptions tagsets .

####### Automake targets: ########

# Define target variables first, before assigning to them:
GT_ANALYSERS=
GT_GENERATORS=
CUSTOM_FSTS=

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

if WANT_CUSTOM_FSTS
CUSTOM_FSTS+=
endif # WANT_CUSTOM_FSTS

endif # CAN_XFST

#### HFST transducers
if CAN_HFST
GT_ANALYSERS+=analyser-gt-desc.hfst \
			  analyser-gt-norm.hfst \
			  analyser-gt-desc.hfst \
			  analyser-gt-descguess.hfst \
			  analyser-gt-guess.hfst \
			  analyser-disamb-gt-desc.hfst
GT_GENERATORS+=generator-gt-desc.hfst \
			   generator-gt-norm.hfst \
			   generator-gt-desc.hfst \
			   generator-gt-descguess.hfst \
			   generator-gt-guess.hfst

if WANT_CUSTOM_FSTS
CUSTOM_FSTS+=
endif # WANT_CUSTOM_FSTS

endif # CAN_HFST

#### FOMA transducers
if CAN_FOMA
GT_ANALYSERS+=
GT_GENERATORS+=

if WANT_CUSTOM_FSTS
CUSTOM_FSTS+=
endif # WANT_CUSTOM_FSTS

endif # CAN_FOMA

#################################################
#### Add language-specific build rules here: ####

EST_EXTRA_PRE_FILTERS=filters/remove-sg-forms.est filters/remove-pl-forms.est filters/remove-sg-nom-forms.est filters/remove-non-gi-forms.est filters/block-derivations.est # filters/remove-usage-tags.est
#EST_GUESSER_PRE_FILTERS=filters/block-guesser-derivations.est 
EST_EXTRA_POST_FILTERS=filters/modify-derivations.est # filters/downcase-derived_proper-strings.est
EST_WORDPAIR_FILTERS=filters/reorder-tags.est filters/wordpair-filter.est
EST_NUMERAL_FILTERS=filters/reorder-tags.est filters/numeral-filter.est
#EST_COMPOUND_PRE_FILTERS=filters/block-compounds.est
#EST_COMPOUND_POST_FILTERS=filters/compound-filter.est

# ---------- Overriding patterns for .generated 

# For Estonian, we must override some "language-independent" pattern rules of building raw and tmp transducers. 
# We accomplish this by defining our own pattern rules for some files created into the .generated directory by default. 
# The correct files will be built into the current directory instead, and then copied to .generated 

# NB! Only .hfst transducers have been tested !!!

# Two transducers are built correctly into the .generated directory:
# the "raw_desc_tmp1" transducer results from lexc files + twol
# .generated/generator-raw-gt-desc.tmp1.hfst 
# the "raw_desc_tmp" transducer results from "raw_desc_tmp1" + tag reordering filters
# .generated/generator-raw-gt-desc.tmp.hfst

generator-raw-gt-desc.tmp.hfst: .generated/generator-raw-gt-desc.tmp.hfst
	$(AM_V_CP)cp $< $@
	
analyser-raw-gt-desc.tmp.hfst: generator-raw-gt-desc.tmp.hfst
	$(AM_V_CP)cp $< $@

analyser-raw-gt-%.hfst: generator-raw-gt-%.hfst
	$(AM_V_CP)cp $< $@

# override the default pattern rules

.generated/generator-raw-gt-desc.hfst: generator-raw-gt-desc.hfst
	$(AM_V_CP)cp $< $@

.generated/analyser-raw-gt-desc.hfst: analyser-raw-gt-desc.hfst
	$(AM_V_CP)cp $< $@

.generated/analyser-gt-desc.tmp.hfst: analyser-gt-desc.tmp.hfst
	$(AM_V_CP)cp $< $@

.generated/analyser-gt-desc.hfst: analyser-gt-desc.hfst
	$(AM_V_CP)cp $< $@

.generated/analyser-gt-norm.hfst: analyser-gt-norm.hfst
	$(AM_V_CP)cp $< $@

# override the default normative analyser and generator
# (is it necessary actually? where are they used ?)
.generated/analyser-gt-norm.tmp.hfst: analyser-gt-norm.tmp.hfst
	$(AM_V_CP)cp $< $@

.generated/generator-gt-norm.tmp.hfst: generator-gt-norm.tmp.hfst
	$(AM_V_CP)cp $< $@

# ---------- End of overriding patterns

# paired words are words whose both parts inflect, e.g. emb-kumb, kihin-kahin
# they are compiled into a transducer of its own:
# initial_part final_part  
# this transducer is union-ed with the transducer of the rest of vocabulary (?)

# paired words: initial part
# HFST:
pair_initial.tmp1.hfst: morphology/pair_initial.tmp.hfst \
					 morphology/phonology.compose.hfst
	$(AM_V_INTRSCT)\
		  $(HFST_DETERMINIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) $<\
		| $(HFST_MINIMIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) \
		| $(HFST_COMPOSE_INTERSECT) $(COMPOSE_INTERSECT_FLAG) \
			$(MORE_VERBOSITY) $(HFST_FLAGS) \
			-2 morphology/phonology.compose.hfst \
		| $(HFST_MINIMIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) \
		-o $@

# XEROX
pair_initial.tmp1.xfst: morphology/pair_initial.tmp.xfst \
			 morphology/phonology.compose.xfst
	$(AM_V_LEXC)$(PRINTF) \
		"read-source morphology/pair_initial.tmp.xfst\n\
		read-rules morphology/phon.compose.xfst\n\
		compose-result\n\
		save-result $@\n\
		quit\n" \
		| $(LEXC) $(VERBOSITY)

# compound numerals where both parts inflect, e.g. viis#sada, viie#saja
# they are compiled into a transducer of its own
# this transducer is union-ed with the transducer of the simplex words

# compound numerals: initial part
# HFST:
num_initial.tmp1.hfst: morphology/num_initial.tmp.hfst \
					 morphology/phonology.compose.hfst
	$(AM_V_INTRSCT)\
		  $(HFST_DETERMINIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) $<\
		| $(HFST_MINIMIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) \
		| $(HFST_COMPOSE_INTERSECT) $(COMPOSE_INTERSECT_FLAG) \
			$(MORE_VERBOSITY) $(HFST_FLAGS) \
			-2 morphology/phonology.compose.hfst \
		| $(HFST_MINIMIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) \
		-o $@

# XEROX
num_initial.tmp1.xfst: morphology/num_initial.tmp.xfst \
			 morphology/phonology.compose.xfst
	$(AM_V_LEXC)$(PRINTF) \
		"read-source morphology/num_initial.tmp.xfst\n\
		read-rules morphology/phonology.compose.xfst\n\
		compose-result\nsave-result $@\n\
		quit\n" \
		| $(LEXC) $(VERBOSITY)


# paired words: final part
# HFST:
pair_final.tmp1.hfst: morphology/pair_final.tmp.hfst \
					 morphology/phonology.compose.hfst
	$(AM_V_INTRSCT)\
		  $(HFST_DETERMINIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) $<\
		| $(HFST_MINIMIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) \
		| $(HFST_COMPOSE_INTERSECT) $(COMPOSE_INTERSECT_FLAG) \
			$(MORE_VERBOSITY) $(HFST_FLAGS) \
			-2 morphology/phonology.compose.hfst \
		| $(HFST_MINIMIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) \
		-o $@ 

# XEROX
pair_final.tmp1.xfst: morphology/pair_final.tmp.xfst \
			 morphology/phonology.compose.xfst
	$(AM_V_LEXC)$(PRINTF) \
		"read-source morphology/pair_final.tmp.xfst\n\
		read-rules morphology/phonology.compose.xfst\n\
		compose-result\n\
		save-result $@\n\
		quit\n" \
		| $(LEXC) $(VERBOSITY)

# compound numerals: final part
# HFST:
num_final.tmp1.hfst: morphology/num_final.tmp.hfst \
					 morphology/phonology.compose.hfst
	$(AM_V_INTRSCT)\
		  $(HFST_DETERMINIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) $<\
		| $(HFST_MINIMIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) \
		| $(HFST_COMPOSE_INTERSECT) $(COMPOSE_INTERSECT_FLAG) \
			$(MORE_VERBOSITY) $(HFST_FLAGS) \
			-2 morphology/phonology.compose.hfst \
		| $(HFST_MINIMIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) \
		-o $@ 

# XEROX
num_final.tmp1.xfst: morphology/num_final.tmp.xfst \
			 morphology/phonology.compose.xfst
	$(AM_V_LEXC)$(PRINTF) \
		"read-source morphology/num_final.tmp.xfst\n\
		read-rules morphology/phonology.compose.xfst\n\
		compose-result\n\
		save-result $@\n\
		quit\n" \
		| $(LEXC) $(VERBOSITY)

# guesser

# guesser for simplex words
# create draft "phonological" name patterns:
# select only nouns, tag them as proper nouns, 
# and upcase both the lexical and the surface side
# (perhaps this could be done more elegantly, i.e. in some other dir and/or makefile)
morphology/guesser-names.tmp.hfst: morphology/guesser-names.tmp0.hfst filters/upcase-guessed-names.est.hfst
	$(AM_V_XFST_TOOL)$(PRINTF) "set flag-is-epsilon OFF\n\
			read regex                                                 \
			[ \"+Guess\" \"+N\" \"+Prop\" <- \"+Guess\" \"+N\" ]        \
			.o. \$$[\"+Guess\" \"+N\"]                                   \
			.o. @\"filters/upcase-guessed-names.est.hfst\".i  \
			.o. @\"$<\"                                                \
			.o. @\"filters/upcase-guessed-names.est.hfst\"    \
			;\n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)


# phonological simplex word patterns with inflections
guesser-simplex-nouns.tmp1.hfst: morphology/guesser-simplex-nouns.tmp.hfst \
					 morphology/phonology.compose.hfst
	$(AM_V_INTRSCT)\
		  $(HFST_DETERMINIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) $<\
		| $(HFST_MINIMIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) \
		| $(HFST_COMPOSE_INTERSECT) $(COMPOSE_INTERSECT_FLAG) \
			$(MORE_VERBOSITY) $(HFST_FLAGS) \
			-2 morphology/phonology.compose.hfst \
		| $(HFST_MINIMIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) \
		-o $@ 

# phonological name patterns with inflections
guesser-names.tmp1.hfst: morphology/guesser-names.tmp.hfst \
					 morphology/phonology.compose.hfst
	$(AM_V_INTRSCT)\
		  $(HFST_DETERMINIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) $<\
		| $(HFST_MINIMIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) \
		| $(HFST_COMPOSE_INTERSECT) $(COMPOSE_INTERSECT_FLAG) \
			$(MORE_VERBOSITY) $(HFST_FLAGS) \
			-2 morphology/phonology.compose.hfst \
		| $(HFST_MINIMIZE) $(MORE_VERBOSITY) $(HFST_FLAGS) \
		-o $@ 


# XEROX
# not implemented...

# acronyms
# acronyms.tmp1.%: fst/acronyms.tmp.%
# 	cp $< $@ 

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

# phonological simplex word and name patterns with inflections
# (with lexical-side tags ordered correctly)
guesser-simplex.tmp.%: guesser-simplex-nouns.tmp1.% \
					guesser-names.tmp1.% \
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
			.o. [@\"$<\" | @\"guesser-names.tmp1.$*\" ]\
			;\n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)



# HFST: generator 
# Xerox & FOMA: analyser
#
# concatenate initial and final part of paired words and numerals

redundant_wordpairs.%: pair_final.tmp.% pair_initial.tmp.%
	$(AM_V_XFST_TOOL)$(PRINTF) "set flag-is-epsilon ON\n\
			read regex [ [~[?* \"+Foc/gi\" ?*] \
			.o. @\"pair_initial.tmp.$*\"] (\"-\") [ 0:\"#\" ] @\"pair_final.tmp.$*\"] \
			.o. ~[?* » ?*] ; \nsave stack $@\nquit\n" | $(XFST_TOOL)

redundant_numerals.%: num_final.tmp.% num_initial.tmp.%
	$(AM_V_XFST_TOOL)$(PRINTF) "set flag-is-epsilon ON\n\
			read regex [ [~[?* \"+Foc/gi\" ?*] \
			.o. @\"num_initial.tmp.$*\"] @\"num_final.tmp.$*\"] \
			.o. ~[?* » ?*] ; \nsave stack $@\nquit\n" | $(XFST_TOOL)

# HFST:
# filter out ungrammatical wordforms of paired words and numerals
# the result is a transducer that can be unioned with simple words lexicon to arrive at the set of simplex words and derivations

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

# guesser: 
# phological patterns of simplex words and derived words
guesser-raw.simple.hfst: guesser-simplex.tmp.hfst \
				$(EST_EXTRA_PRE_FILTERS:%=%.hfst) \
				$(EST_EXTRA_POST_FILTERS:%=%.hfst) \
				filters/downcase-derived_proper-strings.est.hfst
	$(AM_V_XFST)$(PRINTF) "set flag-is-epsilon ON\n\
			read regex                         \
			@\"filters/block-derivations.est.hfst\"    \
			.o. [ @\"$<\"] \
			$(EST_EXTRA_POST_FILTERS:%=.o. @\"%.hfst\")   \
			;\n\
			define fst \n\
			set flag-is-epsilon OFF\n\
			read regex fst \
			.o. @\"filters/downcase-derived_proper-strings.est.hfst\"       \
			;\n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)


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

# HFST:
# 1) make a union of simple words, paired words and compound numerals
# 2) create derivations from proper names
# 3) filter out the incorrect derivations (derived from names, verbs, nouns etc)
# result: lexicon-based simplex words and derivations
# NB! includes potential compound word initial components tagged as +Guess, e.g. blabla; 
# they will be legit parts of compound words, once the compound word transducer is created

generator-raw-gt-desc.simple.weightless.hfst: generator-raw-gt-desc.tmp.hfst \
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

# weights added to all analyses
# result: lexicon-based simplex words and derivations with weights

# no weight added to compound border '#' here; do it somewhere else
# 7.01.2019 from Sjur:
# Hfst - add weights to simplex words if using tropical-semiring fst format:
if WITH_OFST_TROPICAL
generator-raw-gt-desc.simple.hfst: generator-raw-gt-desc.simple.weightless.hfst 
	$(AM_V_REWEIGHT)$(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) \
		-S '#' -a 0 --arcs-only -i $< \
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
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+ABBR' -a 5 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+ACR' -a 5 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Usage/Rare' -a 30 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Usage/Hyp' -a 30 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Usage/NotNorm' -a 30 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Usage/CommonNotNorm' -a 30 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Use/Circ' -a 0 -A \
		> $@

# do somewhere else:
#		-S '#' -a 30 --arcs-only -i  \
#	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Guess' -a 200 -A \
#

else !WITH_OFST_TROPICAL

generator-raw-gt-desc.simple.hfst: generator-raw-gt-desc.simple.weightless.hfst
		cp $< $@
endif !WITH_OFST_TROPICAL


# HFST:
# compound words: 
# 1. the non-final parts cannot be a form with a focus particle, so filter them out
# 2. the non-final parts part may end with a hyphen (ajalooline+A+Der/minus:ajaloolis»-), which may be omitted in compounds,
#    or may have a hyphen appended (for better readabilty of a compound)
# result: lexicon-based simplex words, derivations, paired words and numerals, compound words; everything with weights
# NB! includes words where the first part is marked as +Guess, e.g. blablawords

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
		| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Guess' -a 200 -A \
		> $@

else !WITH_OFST_TROPICAL

generator-raw-gt-desc.weighted.hfst: generator-raw-gt-desc.vocabulary.hfst
		cp $< $@
endif !WITH_OFST_TROPICAL


# weights added to all guessed simplex word analyses
# result: guessed simplex words and derivations with weights

# analogy with generator-raw-gt-desc.weighted.hfst
# notice that the derived forms are weighted LESS, i.e. they are guessed MORE LIKELY than simplex forms
# Hfst - add weights to compounds if using tropical-semiring fst format:
if WITH_OFST_TROPICAL
guesser-raw.weighted.hfst: guesser-raw.simple.hfst
	$(AM_V_REWEIGHT)$(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) \
		-S '#' -a 30 --arcs-only -i $< \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/mine' -a -10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/ja' -a -10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/nu' -a -10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/mus' -a -10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/ng' -a -10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/v' -a -10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/tav' -a -10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/nud' -a -10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/mata' -a -10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/matu' -a -10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/tamatu' -a -10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/tu' -a -10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/tud' -a -10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/lik' -a -10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/line' -a -10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/ne' -a -10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/lt' -a -10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/sti' -a -10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/ini' -a -10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/m' -a -10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/im' -a -10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/nna' -a -10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/kond' -a 10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/ist' -a -10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/is' -a -10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/us' -a -10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/ti' -a -10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/lane' -a -10 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Der/kas' -a -10 -A \
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
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+ABBR' -a 5 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+ACR' -a 5 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Usage/Rare' -a 30 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Usage/Hyp' -a 30 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Usage/NotNorm' -a 30 -A \
	| $(HFST_REWEIGHT) $(MORE_VERBOSITY) $(HFST_FLAGS) -S '+Usage/CommonNotNorm' -a 30 -A \
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

# Tokens ending with a dot (e.g. abbreviations) need special treament by a tokeniser
# They cannot be a part of the analyser that the tokeniser uses
# Therefore, dot-ending stuff must be added separately to the default descriptive analyser 

# .dot transducer is the the base for:
# 1. -desc, -norm etc transducers
# 2. guesser

# This is the default, descriptive analyser:
# Visible tags (ie do NOT remove):
#   - variant tags
#   - the Err/Orth tag
# Invisible tags (ie to be removed):
#   - semantic tags
#   - homonymy tags

analyser-gt-desc.dot.tmp.%: analyser-raw-gt-desc.%                \
					morphology/abbrevdot.tmp.% \
					filters/remove-area-tags.%                \
					filters/remove-dialect-tags.%             \
					filters/remove-number-string-tags.%       \
					filters/remove-usage-tags.%               \
					filters/remove-semantic-tags.%            \
					filters/remove-hyphenation-marks.%        \
					filters/remove-infl_deriv-borders.%       \
					filters/remove-word-boundary.%            \
					filters/remove-orthography-tags.%         \
					filters/remove-Orth_IPA-strings.%         \
					filters/remove-orig_lang-tags.%           \
					filters/remove-Use_GC-strings.%           \
					filters/remove-Use_minusGC-tags.%         \
					filters/remove-Use_minus_PMatch-tags.%    \
					filters/remove-Use_PMatch-strings.%       \
					filters/remove-mwe-tags.%                 \
					orthography/inituppercase.compose.%       \
					orthography/allcaps.compose.%       \
					orthography/spellrelax.compose.%          \
					$(GLT_DOWNCASE_FILTER)
	$(AM_V_XFST_TOOL)$(PRINTF) "read regex \
				@\"filters/remove-area-tags.$*\"                \
			.o. @\"filters/remove-dialect-tags.$*\"             \
			.o. @\"filters/remove-number-string-tags.$*\"       \
			.o. @\"filters/remove-usage-tags.$*\"               \
			.o. @\"filters/remove-semantic-tags.$*\"            \
			.o. @\"filters/remove-orig_lang-tags.$*\"           \
			.o. @\"filters/remove-orthography-tags.$*\"         \
			.o. @\"filters/remove-Orth_IPA-strings.$*\"         \
			.o. @\"filters/remove-Use_minus_PMatch-tags.$*\"    \
			.o. @\"filters/remove-Use_GC-strings.$*\"           \
			.o. @\"filters/remove-Use_minusGC-tags.$*\"         \
			.o. @\"filters/remove-Use_PMatch-strings.$*\"       \
			.o. @\"filters/remove-mwe-tags.$*\"                 \
			.o. [@\"$<\" | @\"morphology/abbrevdot.tmp.$*\"]           \
			    $(GLT_DOWNCASE_COMPOSE) \
			.o. @\"filters/remove-hyphenation-marks.$*\"        \
			.o. @\"filters/remove-infl_deriv-borders.$*\"       \
			.o. @\"filters/remove-word-boundary.$*\"            \
			; \n\
			define fst \n\
			set flag-is-epsilon ON\n\
			set encode-weights ON\n\
			read regex fst \
			.o. @\"orthography/inituppercase.compose.$*\"       \
			.o. @\"orthography/allcaps.compose.$*\"       \
			.o. @\"orthography/spellrelax.compose.$*\"          \
			; \n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

# This is the default, descriptive generating transducer.
generator-gt-desc.dot.tmp.%: analyser-raw-gt-desc.%            \
					morphology/abbrevdot.tmp.% \
					filters/make-optional-transitivity-tags.% \
					filters/make-optional-homonymy-tags.%     \
					filters/make-optional-hyph-tags.%         \
					filters/make-optional-variant-tags.%      \
					filters/make-optional-semantic-tags.%     \
					filters/make-optional-error-tags.%        \
					filters/make-optional-adv_comp-tags.%     \
					filters/make-optional-orig_lang-tags.%    \
					filters/remove-area-tags.%                \
					filters/remove-dialect-tags.%             \
					filters/remove-hyphenation-marks.%        \
					filters/remove-infl_deriv-borders.%       \
					filters/remove-word-boundary.%            \
					filters/remove-number-string-tags.%       \
					filters/remove-orthography-tags.%         \
					filters/remove-Orth_IPA-strings.%         \
					filters/remove-usage-tags.%               \
					filters/remove-Use_GC-strings.%           \
					filters/remove-Use_minusGC-tags.%         \
					filters/remove-Use_minus_PMatch-tags.%    \
					filters/remove-Use_PMatch-strings.%       \
					filters/remove-mwe-tags.%                 \
					$(GLT_DOWNCASE_FILTER)
	$(AM_V_XFST_TOOL)$(PRINTF) "read regex \
				@\"filters/make-optional-transitivity-tags.$*\" \
			.o. @\"filters/make-optional-homonymy-tags.$*\"     \
			.o. @\"filters/make-optional-hyph-tags.$*\"         \
			.o. @\"filters/make-optional-variant-tags.$*\"      \
			.o. @\"filters/make-optional-semantic-tags.$*\"     \
			.o. @\"filters/make-optional-error-tags.$*\"        \
			.o. @\"filters/make-optional-adv_comp-tags.$*\"     \
			.o. @\"filters/make-optional-orig_lang-tags.$*\"    \
			.o. @\"filters/remove-area-tags.$*\"                \
			.o. @\"filters/remove-dialect-tags.$*\"             \
			.o. @\"filters/remove-number-string-tags.$*\"       \
			.o. @\"filters/remove-usage-tags.$*\"               \
			.o. @\"filters/remove-orthography-tags.$*\"         \
			.o. @\"filters/remove-Orth_IPA-strings.$*\"         \
			.o. @\"filters/remove-Use_minus_PMatch-tags.$*\"    \
			.o. @\"filters/remove-Use_GC-strings.$*\"           \
			.o. @\"filters/remove-Use_minusGC-tags.$*\"         \
			.o. @\"filters/remove-Use_PMatch-strings.$*\"       \
			.o. @\"filters/remove-mwe-tags.$*\"                 \
			.o. [@\"$<\" | @\"morphology/abbrevdot.tmp.$*\"]           \
			    $(GLT_DOWNCASE_COMPOSE) \
			.o. @\"filters/remove-hyphenation-marks.$*\"        \
			.o. @\"filters/remove-infl_deriv-borders.$*\"       \
			.o. @\"filters/remove-word-boundary.$*\"            \
			;\n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

# override the default descriptive analyser and generator
# result: lexicon-based analyses

analyser-gt-desc.tmp.hfst: analyser-gt-desc.dot.tmp.hfst \
					filters/remove-guessed-forms.est.hfst 
	$(AM_V_XFST_TOOL)$(PRINTF) "read regex \
				@\"filters/remove-guessed-forms.est.hfst\" \
			.o. @\"$<\" \
			;\n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

generator-gt-desc.tmp.hfst: generator-gt-desc.dot.tmp.hfst \
					filters/remove-guessed-forms.est.hfst 
	$(AM_V_XFST_TOOL)$(PRINTF) "read regex \
				@\"filters/remove-guessed-forms.est.hfst\" \
			.o. @\"$<\" \
			;\n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)


#--- begin guesser-related ad hoc

# substitute placeholders with fsts containing real symbols;
# relax hyphen and apostrophe writing conventions 
# result: lexicon-based analyses plus blablawords
# this will be later unioned with simplex word guesser to result in a complete guesser

analyser-gt-descguess.hfst: analyser-gt-desc.dot.tmp.hfst \
					morphology/substitute_blockcap.xfscript \
					morphology/substitutions.xfscript \
					orthography/punctrelax.compose.hfst
	$(AM_V_XFST_TOOL)$(PRINTF) "set encode-weights ON\n\
				read regex @\"$<\";\n\
				source morphology/substitute_blockcap.xfscript\n\
				source morphology/substitutions.xfscript\n\
				define fst\n\
				read regex fst \
				.o. @\"orthography/punctrelax.compose.hfst\" \
			;\n\
		 $(INVERT_HFST)\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

# ... and generators:
# substitute placeholders with fsts containing real symbols
 
generator-gt-descguess.hfst: generator-gt-desc.dot.tmp.hfst \
					morphology/substitute_blockcap.xfscript \
					morphology/substitutions.xfscript 
	$(AM_V_XFST_TOOL)$(PRINTF) "set encode-weights ON\n\
				read regex @\"$<\";\n\
				source morphology/substitute_blockcap.xfscript\n\
				source morphology/substitutions.xfscript\n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

# --- end guesser-related ad hoc

# override the default normative analyser and generator
# (is it necessary actually? where are they used ?)
analyser-gt-norm.tmp.hfst: analyser-gt-desc.tmp.hfst \
				filters/remove-nospell-words.est.hfst \
				filters/remove-NotNorm-wordforms.est.hfst
	$(AM_V_XFST_TOOL)$(PRINTF) "set flag-is-epsilon ON\n\
			read regex \
			@\"filters/remove-nospell-words.est.hfst\" \
			.o. @\"filters/remove-NotNorm-wordforms.est.hfst\" \
			.o. @\"$<\" \
			;\n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

generator-gt-norm.tmp.hfst: generator-gt-desc.tmp.hfst \
				filters/remove-nospell-words.est.hfst \
				filters/remove-NotNorm-wordforms.est.hfst
	$(AM_V_XFST_TOOL)$(PRINTF) "set flag-is-epsilon ON\n\
			read regex \
			@\"filters/remove-nospell-words.est.hfst\" \
			.o. @\"filters/remove-NotNorm-wordforms.est.hfst\" \
			.o. @\"$<\" \
			;\n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

# override the default fallback processing for the -gt-desc.hfst and -gt-norm.hfst analysers and generators:
analyser-gt%.hfst: analyser-gt%.tmp.hfst \
				filters/remove-usage-tags.hfst
	$(AM_V_XFST_TOOL)$(PRINTF) "read regex \
				@\"filters/remove-usage-tags.hfst\"  \
			.o. @\"$<\" \
			;\n\
		 $(INVERT_HFST)\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

generator-gt%.hfst: generator-gt%.tmp.hfst \
				filters/remove-usage-tags.hfst
	$(AM_V_XFST_TOOL)$(PRINTF) "read regex \
				@\"filters/remove-usage-tags.hfst\"  \
			.o. @\"$<\" \
			;\n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)
#---------
# HFST:
# simplex word guesser;
# result: guessed simplex words and derivations with weights
# (surface side without phonotactics symbols)
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
# simplex word guesser, enlarged to cover standard orthography
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

# complete guesser
# includes 
# 1) phonological patterns for simplex words (and names) and their derivations
# 2) all the lexicon-based words (simplex, compound, derived; paired)
# 3) blablawords, i.e. words where the last component gets an analysis, and the rest is +Guess

# katsetus
generator-gt-guess.hfst: generator-gt-descguess.hfst \
			 generator-raw-gt-guess.hfst
	$(AM_V_XFST_TOOL)$(PRINTF) "set encode-weights ON\n\
			read regex \
			[[ @\"$<\"] | @\"generator-raw-gt-guess.hfst\"] \
			; \n\
		 	save stack $@\n\
		 	quit\n" | $(XFST_TOOL)

analyser-gt-guess.hfst: analyser-gt-descguess.hfst \
			analyser-raw-gt-guess.hfst
	$(AM_V_XFST_TOOL)$(PRINTF) "set encode-weights ON\n\
			read regex \
			[[ @\"$<\" ] | @\"analyser-raw-gt-guess.hfst\"] \
			; \n\
		 	save stack $@\n\
		 	quit\n" | $(XFST_TOOL)


# XEROX:
# not implemented...
#


##################################################################
#### END: Add local processing instructions ABOVE this line ######
##################################################################
include $(top_srcdir)/../giella-core/am-shared/src-fst-dir-include.am
