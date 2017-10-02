SUBDIRS = \
	po

DISTCHECK_CONFIGURE_FLAGS = \
	--enable-tests

if ENABLE_QML_PLUGINS
SUBDIRS += qml
endif # ENABLE_QML_PLUGINS

# Extract transatable strings from .provider files
%.provider: %.provider.in $(INTLTOOL_MERGE)
	$(AM_V_at)$(MKDIR_P) $(builddir)/data/providers
	$(INTLTOOL_V_MERGE) LC_ALL=C $(INTLTOOL_MERGE) $(INTLTOOL_MERGE_V_OPTIONS) --no-translations -x -u $< $@

providers_in_in_files = \
	data/providers/facebook.provider.in.in \
	data/providers/flickr.provider.in.in \
	data/providers/foursquare.provider.in.in \
	data/providers/google.provider.in.in \
	data/providers/identica.provider.in.in \
	data/providers/linkedin.provider.in.in \
	data/providers/instagram.provider.in.in \
	data/providers/mcloud.provider.in.in \
	data/providers/microsoft.provider.in.in \
	data/providers/nextcloud.provider.in.in \
	data/providers/owncloud.provider.in.in \
	data/providers/sina.provider.in.in \
	data/providers/sohu.provider.in.in \
	data/providers/twitter.provider.in.in \
	data/providers/vk.provider.in.in

providers_DATA = \
	$(providers_in_in_files:.provider.in.in=.provider)

# Extract translatable strings from .service files
%.service: %.service.in $(INTLTOOL_MERGE)
	$(AM_V_at)$(MKDIR_P) $(builddir)/data/services
	$(INTLTOOL_V_MERGE) LC_ALL=C $(INTLTOOL_MERGE) $(INTLTOOL_MERGE_V_OPTIONS) --no-translations -x -u $< $@

services_in_files = \
	data/services/facebook-microblog.service.in \
	data/services/facebook-sharing.service.in \
	data/services/flickr-microblog.service.in \
	data/services/flickr-sharing.service.in \
	data/services/foursquare-microblog.service.in \
	data/services/google-drive.service.in \
	data/services/google-im.service.in \
	data/services/identica-microblog.service.in \
	data/services/linkedin-microblog.service.in \
	data/services/instagram-microblog.service.in \
	data/services/picasa.service.in \
	data/services/sina-microblog.service.in \
	data/services/sohu-microblog.service.in \
	data/services/twitter-microblog.service.in

services_DATA = \
	$(services_in_files:.service.in=.service)

# Temporary until these bugs are fixed:
# https://bugs.launchpad.net/bugs/1567908
# https://bugs.launchpad.net/bugs/1640704
iconsdir = $(datadir)/icons/hicolor/32x32/apps
dist_icons_DATA = \
	data/icons/mcloud.png \
	data/icons/microsoft.png \
	data/icons/nextcloud.png \
	data/icons/vk.png

dist_bin_SCRIPTS = \
	tools/account-console

dist_noinst_DATA = \
	$(services_in_files)

if HAVE_XMLLINT
TESTS = \
	test-provider \
	test-service

test-provider: Makefile $(providers_DATA)
	$(AM_V_GEN)echo "#!/bin/sh -e" > $@; \
		echo "for provider in $(providers_DATA)" >> $@; \
		echo "do" >> $@; \
		echo "    $(XMLLINT) --noout $(top_builddir)/\$$provider || exit 1" >> $@; \
		echo "done" >> $@; \
		chmod +x $@

test-service: Makefile $(services_DATA)
	$(AM_V_GEN)echo "#!/bin/sh -e" > $@; \
		echo "for service in $(services_DATA)" >> $@; \
		echo "do" >> $@; \
		echo "    $(XMLLINT) --noout $(top_builddir)/\$$service || exit 1" >> $@; \
		echo "done" >> $@; \
		chmod +x $@
endif # HAVE_XMLLINT

CLEANFILES = \
	$(services_DATA) \
	$(providers_DATA) \
	$(TESTS)

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
