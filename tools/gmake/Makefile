.include <qdnix.hostinit.mk>

LICENSE = gpl3
MODULE =  gcc

CONFIGURE_ARGS = \
	--prefix="${TOOLS_DIR}" \
	--program-prefix=${TOOLS_PREFIX}g \
	--disable-nls \

ALL_TARGET = all-binutils all-gas all-ld
INSTALL_TARGET = install-binutils install-gas install-ld

.include "${.CURDIR}/../Makefile.host"
