-include $(top_srcdir)/git.mk
CLEANFILES=

VALADOC_FLAGS = \
	--driver $(VALA_API_VERSION) \
	--force \
	--package-name=GtkTester-$(API_VERSION) \
	--package-version=$(PACKAGE_VERSION) \
	--pkg gtk+-3.0 \
	--vapidir=$(abs_top_srcdir)/src \
	$(NULL)
sources= \
	$(top_srcdir)/src/*.vala


gtktesterdocdir=$(datadir)/devhelp/books/GtkTester-$(API_VERSION)
gtktesterdoc_DATA = \
	GtkTester/GtkTester-$(API_VERSION)/GtkTester-$(API_VERSION).devhelp2 \
	GtkTester/GtkTester-$(API_VERSION)/*.png \
	GtkTester/GtkTester-$(API_VERSION)/*.html \
	GtkTester/GtkTester-$(API_VERSION)/*.htm \
	GtkTester/GtkTester-$(API_VERSION)/*.css \
	GtkTester/GtkTester-$(API_VERSION)/*.js

gtktesterdocimgdir=$(datadir)/devhelp/books/GtkTester-$(API_VERSION)/img
gtktesterdocimg_DATA=\
	GtkTester/GtkTester-$(API_VERSION)/img/*

$(gtktesterdoc_DATA) $(gtktesterdocimg_DATA): gtktester-doc

gtktester-doc:
	$(VALADOC) -o GtkTester --doclet=devhelp $(VALADOC_FLAGS) $(sources)

clean-local: clean-local-gtktester-doc
.PHONY: clean-local-gtktester-doc
clean-local-gtktester-doc:
	-rm -rf GtkTester
