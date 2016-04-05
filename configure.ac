dnl Process this file with autoconf to produce a configure script.

AC_INIT([account-plugins],
        [0.12],
        [https://bugs.launchpad.net/online-accounts-account-plugins/+filebug],
        [account-plugins],
        [https://launchpad.net/online-accounts-account-plugins])

AM_INIT_AUTOMAKE([1.10 -Wall -Wno-portability silent-rules subdir-objects])
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

IT_PROG_INTLTOOL([0.50.0])
AC_SUBST([GETTEXT_PACKAGE], [$PACKAGE_TARNAME])

PKG_PROG_PKG_CONFIG([0.24])

AS_IF([test "x$prefix" = "xNONE"],
      [real_prefix=$ac_default_prefix],
      [real_prefix=$prefix])

# Binary account plugins.
AC_ARG_ENABLE([libaccount-plugin],
              [AS_HELP_STRING([--disable-libaccount-plugin],
                              [build without support for libaccount-plugin (binary account plugins)])])

AS_IF([test "x$enable_libaccount_plugin" != "xno"],
      [PKG_CHECK_EXISTS([account-plugin], [have_libaccount_plugin=yes],
                        [have_libaccount_plugin=no])],
      [have_libaccount_plugin=no])

AS_IF([test "x$have_libaccount_plugin" = "xyes"],
      [
        PKG_CHECK_MODULES([ACCOUNT_PLUGINS], [account-plugin >= 0.1.3])
        PKG_CHECK_MODULES([RESTAPIS], [libsoup-2.4 json-glib-1.0])
      ],
      [AS_IF([test "x$enable_libaccount_plugin" = "xyes"],
             [AC_MSG_ERROR([libaccount-plugin support enabled but required dependencies were not found])])])

AM_CONDITIONAL([ENABLE_LIBACCOUNT_PLUGIN],
               [test "x$have_libaccount_plugin" = "xyes"])

# XML data files for libaccounts-glib.
PKG_CHECK_EXISTS([libaccounts-glib])

AC_SUBST([plugindir],
         [`$PKG_CONFIG --variable provider_plugindir --define-variable=prefix=$real_prefix account-plugin`])

# QML account plugins.
AC_ARG_ENABLE([qml-plugins],
              [AS_HELP_STRING([--disable-qml-plugins],
                              [build without support for QML plugins for Ubuntu Touch])])

AS_IF([test "x$enable_qml_plugins" != "xno"],
      [have_uoa_plugin=yes])

AM_CONDITIONAL([ENABLE_QML_PLUGINS],
               [test "x$have_uoa_plugin" = "xyes"])

# QML plugins installation path
AC_SUBST([qmlpluginsdir],
	 [`$PKG_CONFIG --variable plugin_qml_dir --define-variable=prefix=$real_prefix OnlineAccountsPlugin`])
AC_MSG_CHECKING(for qmlplugins directory)
if test "x$qmlpluginsdir" = "x" ; then
        # fallback if the previous failed
        qmlpluginsdir="$real_prefix/share/accounts/qml-plugins"
fi

# libaccounts providers and service files
AC_SUBST([providersdir],
         [`$PKG_CONFIG --variable providerfilesdir --define-variable=prefix=$real_prefix libaccounts-glib`])

AC_SUBST([servicesdir],
         [`$PKG_CONFIG --variable servicefilesdir --define-variable=prefix=$real_prefix libaccounts-glib`])

AC_ARG_ENABLE([TESTS],
    [AS_HELP_STRING([--disable-tests], [Disable tests])])

AS_IF([test "x$enable_tests" != "xno"],
    [AC_PATH_PROG([XMLLINT], [xmllint], [notfound])
     AS_IF([test "x$XMLLINT" = "xnotfound"],
         [have_xmllint=no],
         [have_xmllint=yes])])

AS_IF([test "x$have_xmllint" = "xyes"],
    [AC_SUBST([XMLLINT])],
    [AS_IF([test "x$enable_tests" = "xyes"],
         [AC_MSG_ERROR([testing support enabled but required dependencies were not found])])])

AM_CONDITIONAL([HAVE_XMLLINT], [test "x$have_xmllint" = "xyes"])

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
AC_SUBST(TWITTER_CONSUMER_KEY, ["$twitter_consumer_key"])
AC_SUBST(TWITTER_CONSUMER_SECRET, ["$twitter_consumer_secret"])

# Set LinkedIn consumer key/secret.
AC_ARG_WITH(linkedin-consumer-key,
            [AS_HELP_STRING([--with-linkedin-consumer-key],
                            [LinkedIn consumer key])],
                            [linkedin_consumer_key=$withval],
                            [linkedin_consumer_key="34gnzrg96iq5"])
AC_ARG_WITH(linkedin-consumer-secret,
            [AS_HELP_STRING([--with-linkedin-consumer-secret],
                            [LinkedIn consumer secret])],
                            [linkedin_consumer_secret=$withval],
                            [linkedin_consumer_secret="BazRki2LE8eZtcqh"])
AC_SUBST(LINKEDIN_CONSUMER_KEY, ["$linkedin_consumer_key"])
AC_SUBST(LINKEDIN_CONSUMER_SECRET, ["$linkedin_consumer_secret"])

# Set Instagram client id/secret.
AC_ARG_WITH(instagram-client-id,
            [AS_HELP_STRING([--with-instagram-client-id],
                            [instagram client id])],
                            [instagram_client_id=$withval],
                            [instagram_client_id="01c3df41a2274a14882adea8e8ebbd46"])
AC_ARG_WITH(instagram-client-secret,
            [AS_HELP_STRING([--with-instagram-client-secret],
                            [instagram client secret])],
                            [instagram_client_secret=$withval],
                            [instagram_client_secret="4751ccdc39c648719ea83cfb1c866c26"])
AC_SUBST(INSTAGRAM_CLIENT_ID, ["$instagram_client_id"])
AC_SUBST(INSTAGRAM_CLIENT_SECRET, ["$instagram_client_secret"])

# Set Facebook client id
AC_ARG_WITH(facebook-client-id,
            [AS_HELP_STRING([--with-facebook-client-id],
                            [Facebook client ID])],
                            [facebook_client_id=$withval],
                            [facebook_client_id="302061903208115"])
AC_SUBST(FACEBOOK_CLIENT_ID, ["$facebook_client_id"])

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
AC_SUBST(FLICKR_CONSUMER_KEY, ["$flickr_consumer_key"])
AC_SUBST(FLICKR_CONSUMER_SECRET, ["$flickr_consumer_secret"])

# Set Google client id
AC_ARG_WITH(google-client-id,
            [AS_HELP_STRING([--with-google-client-id],
                            [Google client ID])],
                            [google_client_id=$withval],
                            [google_client_id="995235780104-c3nepmjkcetqua2ao9797r5j38leb3e4.apps.googleusercontent.com"])
AC_ARG_WITH(google-client-secret,
            [AS_HELP_STRING([--with-google-client-secret],
                            [Google client secret])],
                            [google_client_secret=$withval],
                            [google_client_secret="NCB6sQ1OHn3-OamBu8-98M31"])
AC_SUBST(GOOGLE_CLIENT_ID, ["$google_client_id"])
AC_SUBST(GOOGLE_CLIENT_SECRET, ["$google_client_secret"])

# Set Foursquare client id
AC_ARG_WITH(foursquare-client-id,
            [AS_HELP_STRING([--with-foursquare-client-id],
                            [Foursquare client ID])],
                            [foursquare_client_id=$withval],
                            [foursquare_client_id="BA0GOA0K3PTRS1KUJ5TTZ1P3GDRH3VJEEXY4N44ROPUJYKPW"])
AC_SUBST(FOURSQUARE_CLIENT_ID, ["$foursquare_client_id"])

# Set identi.ca consumer key/secret
AC_ARG_WITH(identica-consumer-key,
            [AS_HELP_STRING([--with-identica-consumer-key],
                            [identi.ca consumer key])],
                            [identica_consumer_key=$withval],
                            [identica_consumer_key="anonymous"])
AC_ARG_WITH(identica-consumer-secret,
            [AS_HELP_STRING([--with-identica-consumer-secret],
                            [identi.ca consumer secret])],
                            [identica_consumer_secret=$withval],
                            [identica_consumer_secret="anonymous"])
AC_SUBST(IDENTICA_CONSUMER_KEY, ["$identica_consumer_key"])
AC_SUBST(IDENTICA_CONSUMER_SECRET, ["$identica_consumer_secret"])

# Set Sina client id/secret
AC_ARG_WITH(sina-client-id,
            [AS_HELP_STRING([--with-sina-client-id],
                            [Sina client id])],
                            [sina_client_id=$withval],
                            [sina_client_id="3011480316"])
AC_ARG_WITH(sina-client-secret,
            [AS_HELP_STRING([--with-sina-client-secret],
                            [Sina client secret])],
                            [sina_client_secret=$withval],
                            [sina_client_secret="bb66bd5dacdaa84ee2917e1162359b48"])
AC_SUBST(SINA_CLIENT_ID, ["$sina_client_id"])
AC_SUBST(SINA_CLIENT_SECRET, ["$sina_client_secret"])

# Set Sohu client id/secret
AC_ARG_WITH(sohu-client-id,
            [AS_HELP_STRING([--with-sohu-client-id],
                            [Sohu client id])],
                            [sohu_client_id=$withval],
                            [sohu_client_id="dXucVvzJseF3wFfeDBqE"])
AC_ARG_WITH(sohu-client-secret,
            [AS_HELP_STRING([--with-sohu-client-secret],
                            [Sohu client secret])],
                            [sohu_client_secret=$withval],
                            [sohu_client_secret="XuOg9=djoUMA%BRRPO)X=(8FExQz8T$9DahIj=9u"])
AC_SUBST(SOHU_CLIENT_ID, ["$sohu_client_id"])
AC_SUBST(SOHU_CLIENT_SECRET, ["$sohu_client_secret"])

# Set Windows Live client id
AC_ARG_WITH(windows-live-client-id,
            [AS_HELP_STRING([--with-windows-live-client-id],
                            [Windows Live client ID])],
                            [windows_live_client_id=$withval],
                            [windows_live_client_id="00000000480CBF28"])
AC_SUBST(WINDOWS_LIVE_CLIENT_ID, ["$windows_live_client_id"])

AC_CONFIG_FILES([
	data/providers/facebook.provider.in
	data/providers/flickr.provider.in
	data/providers/foursquare.provider.in
	data/providers/google.provider.in
	data/providers/identica.provider.in
	data/providers/linkedin.provider.in
	data/providers/instagram.provider.in
	data/providers/sina.provider.in
	data/providers/sohu.provider.in
	data/providers/twitter.provider.in
	data/providers/windows-live.provider.in
	Makefile
	po/Makefile.in
	qml/Makefile
])
AC_OUTPUT
