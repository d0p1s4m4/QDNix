PANDOC		= pandoc
CONVERT		= convert
DOXYGEN		= doxygen

HTML_BUILDDIR	= docs/html
HTML_INCDIR		= docs/site/include

SITE_MD		=  $(wildcard docs/site/*.md) $(wildcard docs/site/**/*.md)
MAN_MD		= $(wildcard docs/man/**/*.md)
MAN_2       = $(wildcard docs/man/**/*.2)
SITE_HTML	= $(patsubst docs/site/%.md, $(HTML_BUILDDIR)/%.html, $(SITE_MD))
MAN_HTML	= $(patsubst docs/%.md, $(HTML_BUILDDIR)/%.html, $(MAN_MD)) \
				$(patsubst docs/%.2, $(HTML_BUILDDIR)/%.html, $(MAN_2))

HTML_HDR	= $(addprefix $(HTML_INCDIR)/, head)
HTML_NAV	= $(addprefix $(HTML_INCDIR)/,  nav)
HTML_FOOTER	= $(addprefix $(HTML_INCDIR)/, footer)
HTML_CSS	= $(addprefix $(HTML_INCDIR)/, qdnix.css)

PANDOC_FLAGS =  -s \
				-c "https://cdn.simplecss.org/simple.min.css" \
				-c /qdnix.css \
				-H $(HTML_HDR) \
				-B $(HTML_NAV) \
				-A $(HTML_FOOTER) \
				-T "Quick'n'dirty *NIX"


GARBADGE	+= $(SITE_HTML) $(MAN_HTML)

.PHONY: html
html: $(SITE_HTML) $(MAN_HTML)
	cp $(HTML_CSS) docs/html/
	cp -r docs/site/images docs/html/
	cp .github/logo.png docs/html/logo.png
	convert docs/html/logo.png -resize 256x256 \
    	-define icon:auto-resize="256,128,96,64,48,32,16" \
		docs/html/favicon.ico
	convert docs/html/logo.png -resize 64x64 \
		docs/html/logo-tiny.png
	$(DOXYGEN) docs/Doxyfile

docs/html/%.html: docs/site/%.md $(HTML_HDR) $(HTML_NAV) $(HTML_FOOTER)
	@ $(MKCWD)
	pandoc $(PANDOC_FLAGS) -o $@ $<

docs/html/man/%.html: docs/man/%.md $(HTML_HDR) $(HTML_FOOTER)
	@ $(MKCWD)
	pandoc $(PANDOC_FLAGS) -o $@ $<

docs/html/man/%.html: docs/man/%.2 $(HTML_HDR) $(HTML_FOOTER)
	@ $(MKCWD)
	pandoc --from man $(PANDOC_FLAGS) -o $@ $<
