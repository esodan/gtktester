AC_PREREQ([2.69])


dnl ***********************************************************************
dnl Define Versioning Information
dnl ***********************************************************************
m4_define([major_version],[1])
m4_define([minor_version],[1])
m4_define([micro_version],[0])
m4_define([package_version],[major_version.minor_version.micro_version])
m4_define([bug_report_url],[https://bugzilla.gnome.org/enter_bug.cgi?product=gtktester])
m4_define([api_version],[major_version])

AX_IS_RELEASE([micro-version])

dnl ***********************************************************************
dnl Initialize autoconf
dnl ***********************************************************************
AC_INIT([gtktester],[package_version],[bug_report_url])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_SRCDIR([data/gtktester.pc.in])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_AUX_DIR([build-aux])
AC_SUBST([ACLOCAL_AMFLAGS], "-I m4")
AC_CANONICAL_HOST


dnl ***********************************************************************
dnl Make version information available to autoconf files
dnl ***********************************************************************
AC_SUBST([MAJOR_VERSION],major_version)
AC_SUBST([MINOR_VERSION],minor_version)
AC_SUBST([MICRO_VERSION],micro_version)
AC_SUBST([API_VERSION],api_version)


dnl ***********************************************************************
dnl Initialize automake
dnl ***********************************************************************
AM_SILENT_RULES([yes])
AM_INIT_AUTOMAKE([1.11 foreign subdir-objects tar-ustar no-dist-gzip dist-xz -Wno-portability])
AM_MAINTAINER_MODE([enable])
AX_GENERATE_CHANGELOG


dnl ***********************************************************************
dnl Add extra debugging with --enable-debug and --enable-compile-warnings
dnl ***********************************************************************
AX_CHECK_ENABLE_DEBUG([no],[]
                      [G_DISABLE_ASSERT G_DISABLE_CHECKS G_DISABLE_CAST_CHECKS])


dnl ***********************************************************************
dnl Internationalization
dnl ***********************************************************************
GETTEXT_PACKAGE=AC_PACKAGE_TARNAME
AC_SUBST([GETTEXT_PACKAGE])
AC_DEFINE_UNQUOTED([GETTEXT_PACKAGE], ["$GETTEXT_PACKAGE"], [GETTEXT package name])

AM_GNU_GETTEXT_VERSION([0.19.6])
AM_GNU_GETTEXT([external])


dnl ***********************************************************************
dnl Check for required programs
dnl ***********************************************************************
AC_PROG_CC
AC_PROG_INSTALL
AC_PROG_SED
AC_PATH_PROG([GLIB_GENMARSHAL],[glib-genmarshal])
AC_PATH_PROG([GLIB_MKENUMS],[glib-mkenums])
AC_PATH_PROG([GLIB_COMPILE_RESOURCES],[glib-compile-resources])
PKG_PROG_PKG_CONFIG([0.22])
GLIB_GSETTINGS
GOBJECT_INTROSPECTION_CHECK([1.42.0])

VALAC_CHECK([0.34.6])

# Documentation with Valadoc
AC_PATH_PROG(YELP_BUILD, [yelp-build], [no])
AC_PATH_PROG([VALADOC], [valadoc], [no])


docs=yes
AC_ARG_ENABLE(docs,
	AS_HELP_STRING([--disable-docs], [Disable Docs option [default=yes]]),
        [docs=$enableval], [docs="yes"])

have_valadoc=no
if test "x$VALADOC" = "xno" -o "x$docs" = "xno"; then
	have_valadoc="no"
	docs="no"
else
	have_valadoc="yes"
fi
AM_CONDITIONAL([HAVE_VALADOC], [test x$have_valadoc = xyes])

build_devhelp=no
if test x$have_valadoc = "xyes" -a "x$docs" = "xyes"; then
  if test x$YELP_BUILD != "xno"; then
    build_devhelp=yes
    YELP_HELP_INIT
  else
    build_devhelp=no;
  fi
fi
AM_CONDITIONAL([BUILD_DEVHELP_DOCS], [test "x$build_devhelp" = "xyes"])

debug=no
AC_ARG_ENABLE(debug,
	AS_HELP_STRING([--enable-debug], [Enable Debug options [default=no]]),
        [debug=$enableval], [debug="no"])

AM_CONDITIONAL(DEBUG, [test $debug = yes])

dnl Check Cross Compile
dnl ******************************
dnl Check for Operating System
dnl ******************************
dnl linklibext is the shared link library extension, which varies by platform

#EXPORT_SYM_REGEX='-export-symbols-regex "^(gxml_|fnYM49765777344607__gxml).*"'
#AC_MSG_CHECKING([for platform])
#platform_win32=no
#linklibext=".so"
case "$host" in
*-mingw*)
#    AC_MSG_RESULT([Win32 - MinGW])
    platform_win32=yes
#    AC_DEFINE([USING_MINGW],[],[Using MinGW])
#    NO_UNDEFINED='-no-undefined'
#    LIBTOOL_EXPORT_OPTIONS=
#    linklibext=".dll"
#    AC_CHECK_TOOL(WINDRES, windres, windres)
#    AC_SUBST(WINDRES)
#    AC_CHECK_TOOL(DLLTOOL, dlltool, dlltool)
#    AC_SUBST(DLLTOOL)
    ;;
*)
#    AC_MSG_RESULT([Unix])
#    NO_UNDEFINED=''
#    LIBTOOL_EXPORT_OPTIONS=$EXPORT_SYM_REGEX
#    ;;
esac
AM_CONDITIONAL(PLATFORM_WIN32, [test x$platform_win32 = xyes])

AX_COMPILER_FLAGS


dnl ***********************************************************************
dnl Ensure C11 is Supported
dnl ***********************************************************************
AX_CHECK_COMPILE_FLAG([-std=gnu11],
                      [CFLAGS="$CFLAGS -std=gnu11"],
                      [AC_MSG_ERROR([C compiler cannot compile GNU C11 code])])



dnl ***********************************************************************
dnl Check for required packages
dnl ***********************************************************************
PKG_CHECK_MODULES(GTKTESTER, [gio-2.0 >= 2.42 gtk+-3.0 >= 3.22])


dnl ***********************************************************************
dnl Initialize Libtool
dnl ***********************************************************************
LT_PREREQ([2.2])
LT_INIT


dnl ***********************************************************************
dnl Process .in Files
dnl ***********************************************************************
AC_CONFIG_FILES([
	Makefile

	src/Makefile

	data/Makefile
	data/gtktester-$API_VERSION.pc:data/gtktester.pc.in

	src/gtktester-$API_VERSION.deps:src/gtktester.deps.in
	src/gtktester-namespace.vala:src/gtktester-namespace.vala.in


	docs/Makefile
	docs/valadoc/Makefile
	docs/valadoc/devhelp/Makefile

	po/Makefile.in
],[],
[API_VERSION='$API_VERSION'])
AC_OUTPUT

echo ""
echo " ${PACKAGE} - ${VERSION}"
echo ""
echo " Options"
echo ""
echo "  Prefix ............................... : ${prefix}"
echo "  Libdir ............................... : ${libdir}"
echo "  Documentation .........................: ${build_devhelp}"
echo ""
