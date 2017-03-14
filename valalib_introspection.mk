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
# GObject Introspection should be optional and included in a if HAVE_INTROSPECTION
# in Makefile.am file. For generate you should use --enable-instrospection switch
# on configure and define INTROSPECTION_GIRS and INTROSPECTION_TYPELIBS.
# VALA_TARGET should be set to a library.


### GObject Introspection
# dlname:
#   Extract our dlname like libfolks does, see bgo#658002 and bgo#585116
#   This is what g-ir-scanner does.
dlname=\
	`$(SED) -nE "s/^dlname='([A-Za-z0-9.+-]+)'/\1/p" $(VALA_TARGET)`

VALAFLAGS += \
	--gir=$(INTROSPECTION_GIRS) \
	$(NULL)

INTROSPECTION_COMPILER_ARGS = --includedir=. -l $(dlname)

$(INTROSPECTION_GIRS): $(VALA_TARGET)

$(INTROSPECTION_TYPELIBS): $(INTROSPECTION_GIRS)
	$(INTROSPECTION_COMPILER) $(INTROSPECTION_COMPILER_ARGS) $< -o $@

girdir = $(INTROSPECTION_GIRDIR)
gir_DATA = $(INTROSPECTION_GIRS)
typelibdir = $(INTROSPECTION_TYPELIBDIR)
typelib_DATA = $(INTROSPECTION_TYPELIBS)
CLEANFILES += $(gir_DATA) $(typelib_DATA)

