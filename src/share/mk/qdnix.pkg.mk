.include <qdnix.init.mk>

PKG_NAME    ?= unknown
PKG_VERSION ?= 0
PKG_EXT     ?= .tar.gz
PKG_ARCHIVE ?= ${PKG_NAME}-${PKG_VERSION}${PKG_EXT}

${PKG_ARCHIVE}:
.if defined(PKG_URL) && !empty(PKG_URL)
	wget -4 -O ${PKG_ARCHIVE} ${PKG_URL}
.endif
.if defined(PKG_SHA256) && !empty(PKG_SHA256)
	${HASHPY} verify -a sha256 -f ${PKG_ARCHIVE} -H ${PKG_SHA256}
.endif

dist: ${PKG_ARCHIVE}
	tar -xf ${PKG_ARCHIVE}
	mv -f ${PKG_NAME}-${PKG_VERSION} dist

.PHONY: fetch
fetch: dist

${TARGETS}: # ensure existance
