SUBDIRS = \
	data \
	tools

# Plugins.
plugin_LTLIBRARIES = \
	libfacebook.la \
	libflickr.la \
	libfoursquare.la \
	libgoogle.la \
	libidentica.la \
	libsina.la \
	libtwitter.la

VALAFLAGS = \
	--vapidir $(top_srcdir)/src \
	--pkg config \
	--pkg AccountPlugin \
	--pkg accounts \
	--pkg posix \
	--pkg signon \
	--pkg gtk+-3.0 \
	--pkg gmodule-2.0

plugin_cppflags = \
	$(ACCOUNT_PLUGINS_CFLAGS) \
	-include $(top_builddir)/config.h \
	$(WARN_CFLAGS)

plugin_libadd = \
	$(ACCOUNT_PLUGINS_LIBS)

plugin_ldflags = \
	-export_dynamic \
	-avoid-version \
	-module \
	-no-undefined \
	-export-symbols-regex '^ap_module_get_object_type'

libfacebook_la_CPPFLAGS = $(plugin_cppflags)
libfacebook_la_LIBADD = $(plugin_libadd)
libfacebook_la_LDFLAGS = $(plugin_ldflags)
libfacebook_la_SOURCES = \
	src/facebook.vala

libflickr_la_CPPFLAGS = $(plugin_cppflags)
libflickr_la_LIBADD = $(plugin_libadd)
libflickr_la_LDFLAGS = $(plugin_ldflags)
libflickr_la_SOURCES = \
	src/flickr.vala

libfoursquare_la_CPPFLAGS = $(plugin_cppflags)
libfoursquare_la_LIBADD = $(plugin_libadd)
libfoursquare_la_LDFLAGS = $(plugin_ldflags)
libfoursquare_la_SOURCES = \
	src/foursquare.vala

libgoogle_la_CPPFLAGS = $(plugin_cppflags)
libgoogle_la_LIBADD = $(plugin_libadd)
libgoogle_la_LDFLAGS = $(plugin_ldflags)
libgoogle_la_SOURCES = \
	src/google.vala

libidentica_la_CPPFLAGS = $(plugin_cppflags)
libidentica_la_LIBADD = $(plugin_libadd)
libidentica_la_LDFLAGS = $(plugin_ldflags)
libidentica_la_SOURCES = \
	src/identica.vala

libsina_la_CPPFLAGS = $(plugin_cppflags)
libsina_la_LIBADD = $(plugin_libadd)
libsina_la_LDFLAGS = $(plugin_ldflags)
libsina_la_SOURCES = \
	src/sina.vala

libtwitter_la_CPPFLAGS = $(plugin_cppflags)
libtwitter_la_LIBADD = $(plugin_libadd)
libtwitter_la_LDFLAGS = $(plugin_ldflags)
libtwitter_la_SOURCES = \
	src/twitter.vala

dist_noinst_DATA = \
	src/config.vapi \
	src/accounts.deps \
	src/accounts.vapi \
	src/signon.vapi \
	src/AccountPlugin.vapi
