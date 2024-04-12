.include <qdnix.own.mk>

DIST_DIR:sh = cat ${.CURDIR}/qdnix.dist

.PHONY: distrib-dirs
distrib-dirs:
.for dir in ${DIST_DIR}
	mkdir -p ${DESTDIR}${dir}
.endfor

${TARGETS}:
