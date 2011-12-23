dnl Process this file with autoconf to produce a configure script.

AC_INIT(account-plugins, 0.1)

AM_INIT_AUTOMAKE(AC_PACKAGE_NAME, AC_PACKAGE_VERSION)
AM_CONFIG_HEADER(config.h)

# Gobject Introspection
AC_CONFIG_MACRO_DIR([m4])
GOBJECT_INTROSPECTION_CHECK([1.30.0])

PKG_CHECK_MODULES(
	LIBACCOUNTS,
	libaccounts-glib)
AC_SUBST(LIBACCOUNTS_CFLAGS)
AC_SUBST(LIBACCOUNTS_LIBS)

providersdir=`$PKG_CONFIG --variable providerfilesdir libaccounts-glib`
AC_SUBST(providersdir)

servicesdir=`$PKG_CONFIG --variable servicefilesdir libaccounts-glib`
AC_SUBST(servicesdir)

AC_OUTPUT([
	Makefile
	data/Makefile
	data/providers/Makefile
	data/services/Makefile
	tools/Makefile
])
