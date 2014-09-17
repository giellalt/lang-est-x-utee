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

# Define variable before using it:
GT_FILTER_TARGETS=

# List any local additions here:
GT_FILTER_LOCAL_SRCS=


compound_filter.all.lexc:	compound_definitions.lexc compound_filter.lexc
	$(AM_V_GEN)cat $^ > $@

compound_mask.all.lexc:	compound_definitions.lexc compound_rules.lexc
	$(AM_V_GEN)cat $^ > $@

# Add the target of local additions here:
# HFST targets here:
if CAN_HFST
GT_FILTER_TARGETS+=deriv_filter.hfst compound_mask.lexc.hfst compound_filter.lexc.hfst

endif

# And Xerox targets here:
if CAN_XFST
GT_FILTER_TARGETS+=deriv_filter.xfst compound_mask.lexc.xfst compound_filter.lexc.xfst

endif

####### HFST build rules: ########
%.lexc.hfst: %.all.lexc
	$(AM_V_HLEXC)$(HFST_LEXC) $(VERBOSITY) $(HFST_LEXC_FLAGS) \
		-f openfst-tropical -o $@ $^

####### Xerox build rules: #######
%.lexc.xfst: %.all.lexc
	$(AM_V_XFST)$(XFST) $(VERBOSITY) \
			-e "read lexc $^" \
			-e "compose net" \
			-e "save stack $@ " \
			-stop

include $(top_srcdir)/am-shared/src-filters-dir-include.am

# vim: set ft=automake:
