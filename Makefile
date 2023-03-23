MKCONF = ${.CURDIR}/.config.mk
SRCDIR = ${.CURDIR}
BUILDDIR = ${.CURDIR}/build

.export BUILDDIR MKCONF SRCDIR

SUBDIR = src

www: 
	(cd "${.CURDIR}/website" && ${MAKE} www)
	doxygen "${.CURDIR}/Doxyfile"

.include <qdnix.subdir.mk>
