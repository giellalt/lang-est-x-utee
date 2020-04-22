## Process this file with automake to produce Makefile.in
## Copyright: Sámediggi/Divvun/UiT
## Licence: GPL v3+

# always build . last here, and tagsets have to be built after morphology
SUBDIRS = morphology filters phonetics hyphenation orthography cg3 transcriptions tagsets .

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
GT_ANALYSERS+=analyser-forcg-desc.xfst
GT_GENERATORS+=
endif # CAN_XFST

#### HFST transducers
if CAN_HFST
GT_ANALYSERS+=analyser-forcg-desc.hfst analyser-forcg-desc.hfstol
GT_GENERATORS+=
endif # CAN_HFST

#### FOMA transducers
if CAN_FOMA
GT_ANALYSERS+=analyser-forcg-desc.foma
GT_GENERATORS+=
endif # CAN_FOMA

#################################################
#### Add language-specific build rules here: ####


#### Hfst build rules: ####
inverted-phonology.hfst: morphology/phonology.compose.hfst
	$(AM_V_HINV)$(HFST_INVERT) $(VERBOSITY) $(HFST_FLAGS) -i $< -o $@

# generator-raw-gt-desc-simple-with-av.hfst:
generator-raw-gt-desc-simple-with-av.hfst: \
			morphology/lexicon.hfst \
			inverted-phonology.hfst
	$(AM_V_INTRSCT)$(HFST_COMPOSE_INTERSECT) $(VERBOSITY) $(HFST_FLAGS) \
		-I -1 morphology/lexicon.hfst -2 inverted-phonology.hfst \
		| $(HFST_MINIMIZE) $(HFST_FLAGS) -o $@

# generator-raw-gt-desc-simple-full.hfst: \
#   generator-raw-gt-desc-simple-with-av.hfst
generator-raw-gt-desc-simple-full.hfst: \
				generator-raw-gt-desc-simple-with-av.hfst \
				filters/deriv_filter.hfst \
				morphology/overriding-exceptions.all.hfst \
				morphology/numbers.hfst \
				morphology/phonology.compose.hfst
	$(AM_V_RGX2FST)$(PRINTF) '[ @"filters/deriv_filter.hfst" .o. [ @"morphology/overriding-exceptions.all.hfst" .P. @"generator-raw-gt-desc-simple-with-av.hfst" ] .o. ~$$ [ "{" "}" ]]' | \
	$(HFST_REGEXP2FST) $(VERBOSITY) $(HFST_FLAGS) $(HFST_FORMAT) -x true -X flag-is-epsilon | \
	$(HFST_COMPOSE_INTERSECT) $(VERBOSITY) $(HFST_FLAGS) -2 morphology/phonology.compose.hfst | \
	$(HFST_DISJUNCT) $(VERBOSITY) $(HFST_FLAGS) morphology/numbers.hfst | \
	$(HFST_MINIMIZE) $(HFST_FLAGS) -o $@

# generator-raw-gt-desc.hfst: generator-raw-gt-desc-full-simple.hfst
generator-raw-gt-desc.hfst: \
			generator-raw-gt-desc-simple-full.hfst \
			filters/compound_filter.hfst \
			filters/compound_mask.hfst
	$(AM_V_RGX2FST)$(PRINTF) ' @"filters/compound_mask.hfst" .o. [("-" "#") [ @"generator-raw-gt-desc-simple-full.hfst" "#" ("-" "#") ]* @"generator-raw-gt-desc-simple-full.hfst" ("#" "-")] .o. [ "#" -> "" ]' | \
	$(HFST_REGEXP2FST) $(VERBOSITY) $(HFST_FLAGS) $(HFST_FORMAT) -x true | \
	$(HFST_MINIMIZE) $(HFST_FLAGS) -o $@

#	$(AM_V_RGX2FST)$(PRINTF) '   @"filters/compound_filter.hfst" .o. @"filters/compound_mask.hfst" .o. [("-" "#") [ @"generator-raw-gt-desc-simple-full.hfst" "#" ("-" "#") ]* @"generator-raw-gt-desc-simple-full.hfst" ("#" "-")] .o. [ "#" -> "" ]' | 

#### Xerox build rules: ####
analyser-raw-gt-desc-simple-with-av.xfst: \
			morphology/lexicon.xfst \
			morphology/phonology.compose.xfst \
			analyser-raw-gt-desc.tmp.xfst
	$(AM_V_at)$(PRINTF) \
	"read-source analyser-raw-gt-desc.tmp.xfst\ninvert-source\nread-rules morphology/phonology.compose.xfst\ncompose-result\ninvert-result\nsave-result $@\nquit\n" \
	> $@.script
	$(AM_V_LEXC)$(LEXC) $(VERBOSITY) < $@.script
	$(AM_V_at)rm -f $@.script
	
analyser-raw-gt-desc-simple-full.xfst: \
				analyser-raw-gt-desc-simple-with-av.xfst \
				filters/deriv_filter.xfst \
				morphology/overriding-exceptions.all.xfst \
				morphology/numbers.xfst \
				morphology/phonology.compose.xfst
	$(AM_V_XFST)$(PRINTF) \
		'load morphology/phonology.compose.xfst\nintersect net\nsave stack intersected-phonology.tmp.xfst\nquit\n' | \
		 $(XFST) $(VERBOSITY) $(XFSTFLAGS)
	$(AM_V_XFST)$(PRINTF) \
		'read regex [ @"filters/deriv_filter.xfst" .o. [   [@"morphology/overriding-exceptions.all.xfst"] .P. [@"analyser-raw-gt-desc-simple-with-av.xfst"]] .o. ~$$[ "{" "}" ] .o. @"intersected-phonology.tmp.xfst"] | @"morphology/numbers.xfst";\nsave stack $@\nquit\n' | \
	        $(XFST) $(VERBOSITY) $(XFSTFLAGS)
	$(AM_V_at)rm -f intersected-phonology.tmp.xfst

analyser-raw-gt-desc.xfst: \
			analyser-raw-gt-desc-simple-full.xfst \
			filters/compound_filter.xfst \
			filters/compound_mask.xfst
	$(AM_V_XFST)$(PRINTF) \
		'read regex @"filters/compound_mask.xfst" .o. [("-" "#") [ @"analyser-raw-gt-desc-simple-full.xfst" "#" ("-" "#") ]* @"analyser-raw-gt-desc-simple-full.xfst" ("#" "-")] .o. [ "#" -> "" ];\nsave stack $@\nquit\n' | \
	        $(XFST) $(VERBOSITY) $(XFSTFLAGS)

#		'read regex @"filters/compound_filter.xfst" .o. @"filters/compound_mask.xfst" .o. [("-" "#") [ @"analyser-raw-gt-desc-simple-full.xfst" "#" ("-" "#") ]* @"analyser-raw-gt-desc-simple-full.xfst" ("#" "-")] .o. [ "#" -> "" ];\nsave stack $@\nquit\n' | 

##################################################################
#### END: Add local processing instructions ABOVE this line ######
##################################################################

include $(top_srcdir)/am-shared/src-dir-include.am
