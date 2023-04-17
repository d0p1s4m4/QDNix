MKCONF = ${.CURDIR}/.config.mk
SRCDIR = ${.CURDIR}
BUILDDIR = ${.CURDIR}/build

.export BUILDDIR MKCONF SRCDIR

BUILDTARGETS	= do-tools do-distrib-dirs do-build

SUBDIR = src

.ORDER: ${BUILDTARGETS}

www:
	mkdir -p ${.CURDIR}/build/www/html/
	(cd "${.CURDIR}/website" && ${MAKE} www)
	doxygen "${.CURDIR}/Doxyfile"

do-tools: .PHONY .MAKE
	@true

do-distrib-dirs: .PHONY .MAKE
	(cd "${.CURDIR}/src/etc" && ${MAKE} distrib-dirs)
	@true

do-build: .PHONY .MAKE
	@true

build: .PHONY .MAKE
.for tgt in ${BUILDTARGETS}
	${MAKE} ${tgt}
.endfor

.include <qdnix.subdir.mk>
