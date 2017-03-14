include $(top_srcdir)/valalib.mk

VALA_TARGET = libgtktester-@API_VERSION@.la

lib_LTLIBRARIES = $(VALA_TARGET)

VALASOURCES = \
	gtktester-namespace.vala \
	gtktester.vala \
	$(NULL)

libgtktester_@API_VERSION@_la_SOURCES = \
	$(VALA_CSOURCES) \
	$(NULL)

libgtktester_@API_VERSION@_la_CFLAGS = \
	$(GTKTESTER_CFLAGS) \
	$(WARN_CFLAGS) \
	$(NULL)

libgtktester_@API_VERSION@_la_LIBADD = \
	$(GTKTESTER_LIBS) \
	$(NULL)

libgtktester_@API_VERSION@_la_LDFLAGS = \
	$(WARN_LDFLAGS) \
	$(NULL)

VALAFLAGS += \
	--vapidir=$(VAPIDIR) \
	--thread \
	--target-glib=2.44 \
	--pkg glib-2.0 \
	$(NULL)

VALA_CHEADER = gtktester.h
VALA_INCLUDEDIR = gtktester-@API_VERSION@

VALA_VAPI = gtktester-@API_VERSION@.vapi

gtktester-@API_VERSION@.deps:
	cp gtktester.deps gtktester-@API_VERSION@.deps

DISTCLEANFILES=gtktester-@API_VERSION@.deps

VALA_DEPS = gtktester-@API_VERSION@.deps

if HAVE_INTROSPECTION

include $(top_srcdir)/valalib_introspection.mk

INTROSPECTION_GIRS = Gtkt-@API_VERSION@.gir
INTROSPECTION_TYPELIBS = Gtkt-@API_VERSION@.typelib

endif

include $(top_srcdir)/vala_gtk.mk

VALA_GTK_RESOURCES=resources.xml

VALA_GTK_UI=gtktester.ui

VALA_GTK_IMAGES=

