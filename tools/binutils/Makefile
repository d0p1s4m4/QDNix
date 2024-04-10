.include <qdnix.hostinit.mk>

LICENSE = gpl3
MODULE =  binutils

BRANDING ?= \
	--with-pkgversion="QDNix Binutils" \
	--with-bugurl="https://github.com/d0p1s4m4/binutils/issues" \
	--with-sysroot

CONFIGURE_ARGS = \
	--target="${MACHINE_PLATFORM}" \
	--prefix="${TOOLS_DIR}" \
	--disable-werror \
	--disable-nls \
	${BRANDING}

ALL_TARGET = all-binutils all-gas all-ld
INSTALL_TARGET = install-binutils install-gas install-ld

.include "${.CURDIR}/../Makefile.host"
