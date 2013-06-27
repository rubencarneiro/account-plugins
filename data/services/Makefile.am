# Extract translatable strings from .service files
%.service: %.service.in $(INTLTOOL_MERGE)
	$(INTLTOOL_V_MERGE) LC_ALL=C $(INTLTOOL_MERGE) $(INTLTOOL_MERGE_V_OPTIONS) --no-translations -x -u $< $@

services_in_files = \
	facebook-contacts.service.in \
	facebook-im.service.in \
	facebook-microblog.service.in \
	facebook-sharing.service.in \
	flickr-microblog.service.in \
	flickr-sharing.service.in \
	foursquare-microblog.service.in \
	google-docs.service.in \
	google-im.service.in \
	identica-microblog.service.in \
	picasa.service.in \
	sina-microblog.service.in \
	sohu-microblog.service.in \
	twitter-microblog.service.in \
	wlm.service.in

services_DATA = \
	$(services_in_files:.service.in=.service)

dist_noinst_DATA = \
	$(services_in_files)

CLEANFILES = \
	$(services_DATA)
