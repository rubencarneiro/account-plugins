dnl Process this file with autoconf to produce a configure script.

AC_INIT(account-plugins, 0.3)

AM_INIT_AUTOMAKE([subdir-objects])
AM_CONFIG_HEADER(config.h)

# Gobject Introspection
AC_CONFIG_MACRO_DIR([m4])
GOBJECT_INTROSPECTION_CHECK([1.30.0])

# Check for programs
AC_PROG_CC
AM_PROG_CC_C_O
OVERRIDE_PROG_VALAC([0.15.1], [valac-0.16 valac-0.14 valac])

LT_PREREQ([2.2])
LT_INIT([disable-static])

PKG_CHECK_MODULES(ACCOUNT_PLUGINS,
	account-plugin)
AC_SUBST(ACCOUNT_PLUGINS_CFLAGS)
AC_SUBST(ACCOUNT_PLUGINS_LIBS)

plugindir=`$PKG_CONFIG --variable provider_plugindir account-plugin`
AC_SUBST(plugindir)

providersdir=`$PKG_CONFIG --variable providerfilesdir libaccounts-glib`
AC_SUBST(providersdir)

servicesdir=`$PKG_CONFIG --variable servicefilesdir libaccounts-glib`
AC_SUBST(servicesdir)

# Set Twitter consumer key/secret
AC_ARG_WITH(twitter-consumer-key,
            [AS_HELP_STRING([--with-twitter-consumer-key],
                            [Twitter consumer key])],
                            [twitter_consumer_key=$withval],
                            [twitter_consumer_key="mkFv4kTQ89G6J8fB3rxg"])
AC_ARG_WITH(twitter-consumer-secret,
            [AS_HELP_STRING([--with-twitter-consumer-secret],
                            [Twitter consumer secret])],
                            [twitter_consumer_secret=$withval],
                            [twitter_consumer_secret="9fvOe8rtOXUeO5MynIaU1JtDEKeQaYmvOt1AjLavHw"])

AC_DEFINE_UNQUOTED(TWITTER_CONSUMER_KEY, ["$twitter_consumer_key"], [Twitter consumer key])
AC_DEFINE_UNQUOTED(TWITTER_CONSUMER_SECRET, ["$twitter_consumer_secret"], [Twitter consumer secret])

AC_OUTPUT([
	Makefile
	data/Makefile
	data/icons/Makefile
	data/providers/Makefile
	data/services/Makefile
	data/webkit-options/Makefile
	tools/Makefile
])
