.include <qdnix.init.mk>

PKG_NAME    ?= unknown
PKG_VERSION ?= 0
PKG_EXT     ?= .tar.gz
PKG_ARCHIVE ?= ${PKG_NAME}-${PKG_VERSION}${PKG_EXT}

${PKG_ARCHIVE}:
.if defined(PKG_URL) && !empty(PKG_URL)
	${MSG.FETCH}
	@wget -nv -O ${PKG_ARCHIVE} ${PKG_URL}
.endif
.if (defined(PKG_SHA256SUM) && !empty(PKG_SHA256SUM)) || \
	(defined(PKG_B2SUM) && !empty(PKG_B2SUM))
	${MSG.VERIFY}
.if defined(PKG_SHA256SUM)
	@${HASHPY} verify -a sha256 -f ${PKG_ARCHIVE} -H ${PKG_SHA256SUM}
.endif
.if defined(PKG_B2SUM)
	@${HASHPY} verify -a blake2b -f ${PKG_ARCHIVE} -H ${PKG_B2SUM}
.endif
.endif

dist: ${PKG_ARCHIVE}
	tar -xf ${PKG_ARCHIVE}
	mv -f ${PKG_NAME}-${PKG_VERSION} dist

fetch: dist .PHONY
	@true

clean:
	@rm -rf ${.CURDIR}/dist ${PKG_ARCHIVE}

${TARGETS}: # ensure existance
