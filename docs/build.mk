PANDOC		= pandoc

BOOK_MD		= $(wildcard docs/book/*.md)
MAN_MD		= $(wildcard docs/man/**/*.md)
BOOK_HTML	= $(patsubst docs/book/%.md, docs/html/%.html, $(BOOK_MD))
MAN_HTML	= $(patsubst docs/%.md, docs/html/%.html, $(MAN_MD))

GARBADGE	+= $(BOOK_HTML) $(MAN_HTML)

.PHONY: html
html: $(BOOK_HTML) $(MAN_HTML)
	cp .github/logo.png docs/html/logo.png

docs/html/%.html: docs/book/%.md
	@ mkdir -p $(dir $@)
	pandoc -H docs/book/include/head -o $@ $<

docs/html/man/%.html: docs/man/%.md
	@ mkdir -p $(dir $@)
	pandoc -H docs/book/include/head -o $@ $<
