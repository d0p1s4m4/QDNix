.if !defined(_QDNIX_OWN_MK_)
_QDNIX_OWN_MK_=1

.if defined(MKCONF) && exists(${MKCONF})
.include "${MKCONF}"
.endif

INSTALL			?=install
COPY			?= -c
RENAME			?=
HRDLINK			?=	-lh
SYMLINK			?= -ls
INSTALL_DIR		?=		${INSTALL} ${INSTPRIV} -d
INSTALL_FILE	?=		${INSTALL} ${INSTPRIV} ${COPY} ${PRESERVE} ${RENAME}
INSTALL_LINK	?=		${INSTALL} ${INSTPRIV} ${HRDLINK} ${RENAME}
INSTALL_SYMLINK	?=	${INSTALL} ${INSTPRIV} ${SYMLINK} ${RENAME}

DESTDIR			?=

BINDIR		= /bin
BINGROUP	= bin
BINOWNER	= bin
BINMODE		= 555
NONBINMODE	= 444

LIBDIR		= /lib
LIBGROUP	= bin
LIBOWNER	= root
LIBMODE		= ${NONBINMODE}

INCSDIR		= /usr/include
INCSGROUP	= bin
INCSOWNER	= bin
INCSMODE	= ${NONBINMODE}

MANDIR		= /usr/share/man
MANOWNER	= bin
MANGROUP	= bin
MANMODE		= ${NONBINMODE}

DOCDIR		= /usr/share/doc
DOCOWNER	= bin
DOCGROUP	= bin
DOCMODE		= ${NONBINMODE}

MKDIRMODE	= 0755

.if defined(CONFIG_ARCH)
.	if ${CONFIG_ARCH} == "pdp11"
MACHINE_PLATFORM	?= ${CONFIG_ARCH}-aout
.	elif ${CONFIG_ARCH} == "arm"
MACHINE_PLATFORM ?= arm-none-eabi
.	else
MACHINE_PLATFORM	?= ${CONFIG_ARCH}-elf
.	endif
.endif

AR	= ${TOOLDIR}/bin/${MACHINE_PLATFORM}-ar
AS	= ${TOOLDIR}/bin/${MACHINE_PLATFORM}-as
LD	= ${TOOLDIR}/bin/${MACHINE_PLATFORM}-ld
NM	= ${TOOLDIR}/bin/${MACHINE_PLATFORM}-nm
OBJCOPY = ${TOOLDIR}/bin/${MACHINE_PLATFORM}-objcopy
OBJDUMP = ${TOOLDIR}/bin/${MACHINE_PLATFORM}-objdump
HASHPY  = ${QDNIXSRCDIR}/tools/hash.py

TOOL_BMAKE = ${TOOLS_DIR}/bin/${TOOLS_PREFIX}bmake
TOOL_GMAKE = ${TOOLS_DIR}/bin/${TOOLS_PREFIX}gmake

CFLAGS += -std=c99 -pedantic \
			-Wall -Wextra \
			-Werror

.if !defined(HOSTPROG)
.	if ${DESTDIR} != ""
.		if empty(CPPFLAGS:M*--sysroot=*)
CPPFLAGS+= --sysroot=${DESTDIR}
.		endif
.		if empty(LDFLAGS:M*--sysroot=*)
LDFLAGS	+= --sysroot=${DESTDIR}
.		endif
.	else
.		if empty(CPPFLAGS:M*--sysroot=*)
CPPFLAGS+= --sysroot=/
.		endif
.		if empty(LDFLAGS:M*--sysroot=*)
LDFLAGS	+= --sysroot=/
.		endif
.	endif
.endif

TARGETS = all clean cleandir depend dependall includes \
			install objs fetch
PHONY_NOTMAIN = all clean cleandir depend dependall distclean includes install \
                                obj beforedepend afterdepend beforeinstall afterinstall realinstall \
                                realdepend realall subdir-all subdir-install subdir-depend
.PHONY: ${PHONY_NOTMAIN}
.NOTMAIN: ${PHONY_NOTMAIN}

.if !target(install)
install: beforeinstall .WAIT subdir-install realinstall .WAIT afterinstall
beforeinstall:
subdir-install:
realinstall:
afterinstall:
.endif

all: realall subdir-all
subdir-all:
realall:
depend: realdepend subdir-depend
subdir-depend:
realdepend:
distclean: cleandir
cleandir: clean
dependall: .NOTMAIN realdepend .MAKE
	@cd "${.CURDIR}"; ${MAKE} realall

MAKEDIRTARGET=\
	@_makedirtarget() { \
		dir="$$1"; shift; \
		target="$$1"; shift; \
		case "$${dir}" in \
		/*)	this="$${dir}/"; \
			real="$${dir}" ;; \
		.)	this="${_THISDIR_}"; \
			real="${.CURDIR}" ;; \
		*)	this="${_THISDIR_}$${dir}/"; \
			real="${.CURDIR}/$${dir}" ;; \
		esac; \
		show=$${this:-.}; \
		echo "$${target} ===> 📁 $${show%/}$${1:+	(with: $$@)}"; \
		cd "$${real}" \
		&& ${MAKE} _THISDIR_="$${this}" "$$@" $${target}; \
	}; \
	_makedirtarget
	
MSG.BUILD	?= @echo " 👷‍♂️    build " ${.CURDIR:T}/${.TARGET}
MSG.CREATE	?= @echo "      create " ${.CURDIR:T}/${.TARGET}
MSG.COMPILE	?= @echo " ⚙️  compile " ${.CURDIR:T}/${.TARGET}
MSG.LINK    ?= @echo " 🔗     link " ${.CURDIR:T}/${.TARGET}
MSG.EXECUTE	?= @echo " ▶️  execute " ${.CURDIR:T}/${.TARGET}
MSG.FORMAT	?= @echo " ✏️   format " ${.CURDIR:T}/${.TARGET}
MSG.INSTALL	?= @echo " 📦  install " ${.CURDIR:T}/${.TARGET:T}
MSG.REMOVE	?= @echo " 🗑️   remove " ${.TARGET}
MSG.FETCH   ?= @echo " 📥 download " ${.CURDIR:T}/${.TARGET}
MSG.VERIFY  ?= @echo " 🔑   verify " ${.TARGET}

.endif
