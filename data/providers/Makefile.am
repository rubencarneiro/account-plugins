# Extract transatable strings from .provider files
%.provider: %.provider.in $(INTLTOOL_MERGE)
	$(INTLTOOL_V_MERGE) LC_ALL=C $(INTLTOOL_MERGE) $(INTLTOOL_MERGE_V_OPTIONS) --no-translations -x -u $< $@

providers_in_files = \
	facebook.provider.in \
	flickr.provider.in \
	foursquare.provider.in \
	google.provider.in \
	identica.provider.in \
	sina.provider.in \
	sohu.provider.in \
	twitter.provider.in \
	windows-live.provider.in

providers_DATA = \
	$(providers_in_files:.provider.in=.provider)

dist_noinst_DATA = \
	$(providers_in_files)

CLEANFILES = \
	$(services_DATA)
