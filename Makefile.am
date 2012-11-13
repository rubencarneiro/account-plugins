SUBDIRS = \
	data \
	po

DISTCHECK_CONFIGURE_FLAGS = \
	--enable-libaccount-plugin

if ENABLE_LIBACCOUNT_PLUGIN
# Binary account plugins.
plugin_LTLIBRARIES = \
	libfacebook.la \
	libflickr.la \
	libfoursquare.la \
	libgoogle.la \
	libidentica.la \
	libsina.la \
	libsohu.la \
	libtwitter.la \
	libwindows-live.la

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

libsohu_la_CPPFLAGS = $(plugin_cppflags)
libsohu_la_LIBADD = $(plugin_libadd)
libsohu_la_LDFLAGS = $(plugin_ldflags)
libsohu_la_SOURCES = \
	src/sohu.vala

libtwitter_la_CPPFLAGS = $(plugin_cppflags)
libtwitter_la_LIBADD = $(plugin_libadd)
libtwitter_la_LDFLAGS = $(plugin_ldflags)
libtwitter_la_SOURCES = \
	src/twitter.vala

libwindows_live_la_CPPFLAGS = $(plugin_cppflags)
libwindows_live_la_LIBADD = $(plugin_libadd)
libwindows_live_la_LDFLAGS = $(plugin_ldflags)
libwindows_live_la_SOURCES = \
	src/windows-live.vala
endif # ENABLE_LIBACCOUNT_PLUGIN

iconsdir = $(datadir)/icons/hicolor/32x32/apps
dist_icons_DATA = \
	data/icons/aim.png \
	data/icons/facebook.png \
	data/icons/flickr.png \
	data/icons/foursquare.png \
	data/icons/gadugadu.png \
	data/icons/google.png \
	data/icons/groupwise.png \
	data/icons/identica.png \
	data/icons/icq.png \
	data/icons/irc.png \
	data/icons/jabber.png \
	data/icons/live.png \
	data/icons/msn.png \
	data/icons/mxit.png \
	data/icons/myspace.png \
	data/icons/people-nearby.png \
	data/icons/sametime.png \
	data/icons/sip.png \
	data/icons/twitter.png \
	data/icons/yahoo.png \
	data/icons/zephyr.png

# Extract transatable strings from .provider files
%.provider: %.provider.in $(INTLTOOL_MERGE)
	$(INTLTOOL_V_MERGE) LC_ALL=C $(INTLTOOL_MERGE) $(INTLTOOL_MERGE_V_OPTIONS) --no-translations -x -u $< $@

providers_in_files = \
	data/providers/facebook.provider.in \
	data/providers/flickr.provider.in \
	data/providers/foursquare.provider.in \
	data/providers/google.provider.in \
	data/providers/identica.provider.in \
	data/providers/sina.provider.in \
	data/providers/sohu.provider.in \
	data/providers/twitter.provider.in \
	data/providers/windows-live.provider.in

providers_DATA = \
	$(providers_in_files:.provider.in=.provider)

# Extract translatable strings from .service files
%.service: %.service.in $(INTLTOOL_MERGE)
	$(INTLTOOL_V_MERGE) LC_ALL=C $(INTLTOOL_MERGE) $(INTLTOOL_MERGE_V_OPTIONS) --no-translations -x -u $< $@

services_in_files = \
	data/services/facebook-im.service.in \
	data/services/facebook-microblog.service.in \
	data/services/facebook-sharing.service.in \
	data/services/flickr-microblog.service.in \
	data/services/flickr-sharing.service.in \
	data/services/foursquare-microblog.service.in \
	data/services/google-docs.service.in \
	data/services/google-im.service.in \
	data/services/identica-microblog.service.in \
	data/services/picasa.service.in \
	data/services/sina-microblog.service.in \
	data/services/sohu-microblog.service.in \
	data/services/twitter-microblog.service.in \
	data/services/wlm.service.in

services_DATA = \
	$(services_in_files:.service.in=.service)

dist_bin_SCRIPTS = \
	tools/account-console

dist_noinst_DATA = \
	$(providers_in_files) \
	$(services_in_files) \
	src/config.vapi

CLEANFILES = \
	$(services_DATA) \
	$(providers_DATA)

DISTCLEANFILES = \
	intltool-extract \
	intltool-merge \
	intltool-update \
	po/.intltool-merge-cache

dist-hook: bzr-changelog-hook

bzr-changelog-hook: Makefile
	$(AM_V_at)cd $(top_srcdir) && \
	if $(top_srcdir)/missing --run bzr log \
		--gnu-changelog > .ChangeLog.tmp; \
	then mv -f .ChangeLog.tmp "$(top_distdir)/ChangeLog"; \
	else rm -f .ChangeLog.tmp; exit 1; fi

.PHONY: bzr-changelog-hook
