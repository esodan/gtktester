# vala.mk
# Copyright (C) 2015  Daniel Espinosa <esodan@gmail.com>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, see <http://www.gnu.org/licenses/>.
#
# Authors:
#      Daniel Espinosa <esodan@gmail.com>
#
#
# To compile Vala sources, define a target using Autotools standard variable
# using target_BIN or lib_LTLIBRARIES to $(VALA_TARGET).
# All Vala sources should be defined in VALASOURCES, as result
# you have to set your target sources to target_SOURCES = $(VALA_CSOURCES).
#
# Use standard Autotools variables to set CFLAGS, LDFLAGS and LIBADD, as required.

-include $(top_srcdir)/git.mk

NULL=
VALAFLAGS=

vala-stamp: $(VALASOURCES)
	@rm -f vala-temp
	@touch vala-temp
	$(VALAC) $(VALAFLAGS) -C $^
	@mv -f vala-temp $@

$(VALASOURCES:.vala=.c): vala-stamp
## Recover from the removal of $@
	@if test -f $@; then :; else \
		trap ’rm -rf vala-lock vala-stamp’ 1 2 13 15; \
		if mkdir vala-lock 2>/dev/null; then \
## This code is being executed by the first process.
			rm -f vala-stamp; \
			$(MAKE) $(AM_MAKEFLAGS) vala-stamp; \
			rmdir vala-lock; \
		else \
## This code is being executed by the follower processes.
## Wait until the first process is done.
			while test -d vala-lock; do sleep 1; done; \
## Succeed if and only if the first process succeeded.
			test -f vala-stamp; exit $$?; \
		fi; \
	fi

VALA_CSOURCES= \
  $(VALASOURCES:.vala=.c) \
  $(NULL)

$(VALA_CSOURCES):vala-stamp

EXTRA_DIST = \
	$(VALASOURCES) \
	$(NULL)

GITIGNOREFILES = \
	$(VALASOURCES:.vala=.c) \
	$(NULL)


CLEANFILES = \
	vala-stamp \
	$(VALASOURCES:.vala=.c) \
	$(NULL)

