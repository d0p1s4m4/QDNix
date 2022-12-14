PANDOC		= pandoc
CONVERT		= convert

HTML_BUILDDIR	= docs/html
HTML_INCDIR		= docs/site/include

SITE_MD		=  $(wildcard docs/site/*.md) $(wildcard docs/site/**/*.md)
MAN_MD		= $(wildcard docs/man/**/*.md)
SITE_HTML	= $(patsubst docs/site/%.md, $(HTML_BUILDDIR)/%.html, $(SITE_MD))
MAN_HTML	= $(patsubst docs/%.md, $(HTML_BUILDDIR)/%.html, $(MAN_MD))

HTML_HDR	= $(addprefix $(HTML_INCDIR)/, head)
HTML_NAV	= $(addprefix $(HTML_INCDIR)/,  nav)
HTML_FOOTER	= $(addprefix $(HTML_INCDIR)/, footer)

GARBADGE	+= $(SITE_HTML) $(MAN_HTML)

.PHONY: html
html: $(SITE_HTML) $(MAN_HTML)
	cp .github/logo.png docs/html/logo.png
	convert docs/html/logo.png -resize 256x256 \
    	-define icon:auto-resize="256,128,96,64,48,32,16" \
		docs/html/favicon.ico

docs/html/%.html: docs/site/%.md $(HTML_HDR) $(HTML_NAV) $(HTML_FOOTER)
	@ $(MKCWD)
	pandoc -H $(HTML_HDR) -B $(HTML_NAV) -A $(HTML_FOOTER) -o $@ $<

docs/html/man/%.html: docs/man/%.md $(HTML_HDR) $(HTML_FOOTER)
	@ $(MKCWD)
	pandoc -H $(HTML_HDR) -A $(HTML_FOOTER) -o $@ $<
