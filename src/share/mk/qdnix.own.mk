.if !defined(_QDNIX_OWN_MK_)
_QDNIX_OWN_MK_=1

.if defined(MKCONF) && exists(${MKCONF})
.include "${MKCONF}"
.else
.error "ok"
.endif

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

all:
www:

.endif
