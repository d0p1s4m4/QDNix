MKCONF = ${.CURDIR}/.config.mk
SRCDIR = ${.CURDIR}
BUILDDIR = ${.CURDIR}/build

.export BUILDDIR MKCONF SRCDIR

SUBDIR = website src

.include <qdnix.subdir.mk>
