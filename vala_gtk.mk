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
# To compile Vala sources for UI interfaces using GTK+, first include vala.mk,
# follow its documentation in order to define all required variables; then
# include this file, is more clear if include sentence is inmediatelly after the one for
# vala.mk, if you are including another file, like valalib.mk, that includes vala.mk, you should
# include this file after it.
#
# Set VALA_GTK_RESOURCES to your XML resources file using GLib format;
# set VALA_GTK_UI to all your xml UI as defined by GtkBuilder and may created
# by Glade to be attached as resources to your binaries; also, set VALA_GTK_IMAGES
# to all image resources to be attached to your binaries as resources.
#

VALAFLAGS+= \
	--pkg gtk+-3.0 \
	--gresources=@srcdir@/$(VALA_GTK_RESOURCES) \
	$(NULL)

vala_resources.c : $(VALA_GTK_RESOURCES)
	$(GLIB_COMPILE_RESOURCES) --sourcedir=$(abs_srcdir) --generate-source --target vala_resources.c --internal  $(VALA_GTK_RESOURCES)
	$(GLIB_COMPILE_RESOURCES) --sourcedir=$(srcdir) --generate --target vala_resources.h --internal $(VALA_GTK_RESOURCES)

vala_resources.h : vala_resources.c $(VALA_GTK_UI) $(VALA_GTK_IMAGES)

CLEANFILES+= \
	vala_resources.c \
	vala_resources.h \
	$(NULL)

VALA_CSOURCES+= \
	vala_resources.c \
	vala_resources.h \
	$(NULL)

EXTRA_DIST+= \
	$(VALA_GTK_UI) \
	$(VALA_GTK_IMAGES) \
	$(VALA_GTK_RESOURCES) \
	$(NULL)

