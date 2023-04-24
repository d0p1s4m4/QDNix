.if !defined(_QDNIX_OWN_MK_)
_QDNIX_OWN_MK_=1

.if defined(MKCONF) && exists(${MKCONF})
.include "${MKCONF}"
.endif

DESTDIR		?=

BINDIR		= /bin
BINGROUP	= bin
BINOWNER	= root
BINMODE		= 555

LIBDIR		= /lib
LIBGROUP	= bin
LIBOWNER	= root
LIBMODE		= 444

MANDIR		= /usr/share/man
MANOWNER	= root
MANGROUP	= bin
MANMODE		= 444

INCSDIR		= /usr/include

.include <qdnix.host.mk>

AR	= ${TOOLDIR}/bin/${MACHINE_PLATFORM}-ar
AS	= ${TOOLDIR}/bin/${MACHINE_PLATFORM}-as
LD	= ${TOOLDIR}/bin/${MACHINE_PLATFORM}-ld
NM	= ${TOOLDIR}/bin/${MACHINE_PLATFORM}-nm
OBJCOPY = ${TOOLDIR}/bin/${MACHINE_PLATFORM}-objcopy
OBJDUMP = ${TOOLDIR}/bin/${MACHINE_PLATFORM}-objdump

CFLAGS += -std=c99 -pedantic \
			-Wall -Wextra \
			-Werror

.if !defined(HOSTPROG)
.if ${DESTDIR} != ""
.if empty(CPPFLAGS:M*--sysroot=*)
CPPFLAGS+= --sysroot=${DESTDIR}
.endif
LDFLAGS	+= --sysroot=${DESTDIR}
.else
.if empty(CPPFLAGS:M*--sysroot=*)
CPPFLAGS+= --sysroot=/
.endif
LDFLAGS	+= --sysroot=/
.endif
.endif

all:
www:
htmlinstall:

.endif
