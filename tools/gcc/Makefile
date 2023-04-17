LICENSE = gpl3
MODULE = gcc

LANGUAGES = c

BRANDING ?= \
	--with-pkgversion="QDNix GCC" \
	--with-bugurl="https://github.com/d0p1s4m4/gcc/issues"

CONFIGURE_ARGS= \
	--target="${MACHINE_PLATFORM}" \
	--prefix="${TOOLDIR}" \
	--without-headers \
	--disable-nls \
	--enable-languages="${LANGUAGES}"
	${BRANDING}

ALL_TARGET = all-gcc
INSTALL_TARGET = install-gcc

.include "${.CURDIR}/../Makefile.host"
