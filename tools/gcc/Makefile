.include <qdnix.hostinit.mk>

LICENSE = gpl3
MODULE =  gcc

BRANDING ?= \
	--with-pkgversion="QDNix gcc" \
	--with-bugurl="https://github.com/d0p1s4m4/gcc/issues" 

CONFIGURE_ARGS = \
	--with-sysroot=${BUILD_DIR} \
	--target="${MACHINE_PLATFORM}" \
	--prefix="${TOOLS_DIR}" \
	--disable-werror \
	--disable-nls \
	--enable-languages=c \
	${BRANDING}

ALL_TARGET = all-gcc
INSTALL_TARGET = install-gcc

.include "${.CURDIR}/../Makefile.gnuhost"
