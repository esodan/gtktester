# pkg-config data
# Note that the template file is called gtktester.pc.in, but generates a
# versioned .pc file using some magic in AC_CONFIG_FILES.
pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = gtktester-$(API_VERSION).pc

DISTCLEANFILES = $(pkgconfig_DATA)
EXTRA_DIST = gtktester.pc.in

-include $(top_srcdir)/git.mk
