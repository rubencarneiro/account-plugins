SUBDIRS = \
	data \
	tools

# Plugins.
plugin_LTLIBRARIES = \
	libfacebook.la \
	libgoogle.la

VALAFLAGS = \
	--vapidir $(top_srcdir)/src \
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

libgoogle_la_CPPFLAGS = $(plugin_cppflags)
libgoogle_la_LIBADD = $(plugin_libadd)
libgoogle_la_LDFLAGS = $(plugin_ldflags)
libgoogle_la_SOURCES = \
	src/google.vala

dist_noinst_DATA = \
	src/accounts.deps \
	src/accounts.vapi \
	src/signon.vapi \
	src/AccountPlugin.vapi
