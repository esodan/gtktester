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
# For libraries you should define VALA_CHEADER for its C header and VALA_VAPI
# for its VAPI file and its VALA_DEPS as its library dependencies.
#
# Use VALA_INCLUDEDIR to define directory where do you want to install your C header.
#
# For GObject Introspection optional generation support you should use
# --enable-instrospection switch on configure and define INTROSPECTION_GIRS
# and INTROSPECTION_TYPELIBS. VALA_TARGET should be a library.

include $(top_srcdir)/vala.mk


VALAFLAGS += \
	-H $(VALA_CHEADER) \
	--vapi $(VALA_VAPI) \
	--library=$(VALA_VAPI:.vapi=) \
	$(NULL)

# .h header file
$(VALA_CHEADER) : vala-stamp

vala_cheaderdir= $(includedir)/$(VALA_INCLUDEDIR)
vala_cheader_HEADERS = $(VALA_CHEADER)

# .vapi Vala API file
$(VALA_VAPI) : vala-stamp
vala_vapidir = $(datadir)/vala/vapi
dist_vala_vapi_DATA = \
	$(VALA_VAPI) \
	$(VALA_DEPS) \
	$(NULL)

CLEANFILES += \
	$(VALA_VAPI) \
	$(VALA_CHEADER) \
	$(NULL)

