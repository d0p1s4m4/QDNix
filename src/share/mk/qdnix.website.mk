.include <qdnix.init.mk>

.SUFFIXES: .md .html .png .scss .css .png .gif

WEBSITE_DIR ?= /html
CSS_DIR ?= /assets/css
IMG_DIR ?= /assets/img
HTML_DIR ?= 

PANDOC = pandoc
TEMPLATE = ${SRCDIR}/website/template/base.html
PANDOC_FLAGS = -s --template ${TEMPLATE}

SASSC = sassc
SASSC_FLAGS =  -t compressed

CONVERT = convert

WEBINSTALL = install 

.scss.css:
	${SASSC} ${SASSC_FLAGS} ${.IMPSRC} ${.TARGET}

.md.html: ${TEMPLATE}
	${PANDOC} ${PANDOC_FLAGS} -o ${.TARGET} ${.IMPSRC}

www: ${CSS} ${HTML} ${IMG} _SUBDIRUSE
.if defined(HTML) && !empty(HTML)
	mkdir -p ${DESTDIR}${WEBSITE_DIR}${HTML_DIR}/
	${WEBINSTALL} ${HTML} ${DESTDIR}${WEBSITE_DIR}${HTML_DIR}/
.endif
.if defined(CSS) && !empty(CSS)
	mkdir -p ${DESTDIR}${WEBSITE_DIR}${CSS_DIR}/
	${WEBINSTALL} ${CSS} ${DESTDIR}${WEBSITE_DIR}${CSS_DIR}/
.endif
.if defined(IMG) && !empty(IMG)
	mkdir -p ${DESTDIR}${WEBSITE_DIR}${IMG_DIR}/
	${WEBINSTALL} ${IMG} ${DESTDIR}${WEBSITE_DIR}${IMG_DIR}/
.endif

.if !target(clean)
clean:
	rm -f ${CSS} ${HTML}
.endif

.if !target(_SUBDIRUSE)
_SUBDIRUSE:
.endif
