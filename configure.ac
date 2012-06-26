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

# Set Facebook client id
AC_ARG_WITH(facebook-client-id,
            [AS_HELP_STRING([--with-facebook-client-id],
                            [Facebook client ID])],
                            [facebook_client_id=$withval],
                            [facebook_client_id="302061903208115"])
AC_DEFINE_UNQUOTED(FACEBOOK_CLIENT_ID, ["$facebook_client_id"], [Facebook client ID])

# Set Flickr consumer key/secret
AC_ARG_WITH(flickr-consumer-key,
            [AS_HELP_STRING([--with-flickr-consumer-key],
                            [Flickr consumer key])],
                            [flickr_consumer_key=$withval],
                            [flickr_consumer_key="4aa0260d1eccfe968bb9f214f18e46fe"])
AC_ARG_WITH(flickr-consumer-secret,
            [AS_HELP_STRING([--with-flickr-consumer-secret],
                            [Flickr consumer secret])],
                            [flickr_consumer_secret=$withval],
                            [flickr_consumer_secret="cbb9e94a8c3fe831"])
AC_DEFINE_UNQUOTED(FLICKR_CONSUMER_KEY, ["$flickr_consumer_key"], [Flickr consumer key])
AC_DEFINE_UNQUOTED(FLICKR_CONSUMER_SECRET, ["$flickr_consumer_secret"], [Flickr consumer secret])

# Set Google client id
AC_ARG_WITH(google-client-id,
            [AS_HELP_STRING([--with-google-client-id],
                            [Google client ID])],
                            [google_client_id=$withval],
                            [google_client_id="995235780104-c3nepmjkcetqua2ao9797r5j38leb3e4.apps.googleusercontent.com"])
AC_DEFINE_UNQUOTED(GOOGLE_CLIENT_ID, ["$google_client_id"], [Google client ID])

AC_OUTPUT([
	Makefile
	data/Makefile
	data/icons/Makefile
	data/providers/Makefile
	data/services/Makefile
	data/webkit-options/Makefile
	tools/Makefile
])
