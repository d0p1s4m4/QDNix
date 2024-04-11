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

INCDIR		= /include
INCGROUP	= bin
INCOWNER	= bin
INCMODE		= ${NONBINMODE}

MANDIR		= /usr/share/man
MANOWNER	= bin
MANGROUP	= bin
MANMODE		= ${NONBINMODE}

DOCDIR		= /usr/share/doc
DOCOWNER	= bin
DOCGROUP	= bin
DOCMODE		= ${NONBINMODE}

MKDIRMODE	= 0755

AR	= ${TOOLDIR}/bin/${MACHINE_PLATFORM}-ar
AS	= ${TOOLDIR}/bin/${MACHINE_PLATFORM}-as
LD	= ${TOOLDIR}/bin/${MACHINE_PLATFORM}-ld
NM	= ${TOOLDIR}/bin/${MACHINE_PLATFORM}-nm
OBJCOPY = ${TOOLDIR}/bin/${MACHINE_PLATFORM}-objcopy
OBJDUMP = ${TOOLDIR}/bin/${MACHINE_PLATFORM}-objdump
HASHPY  = ${QDNIXSRCDIR}/tools/hash.py

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

TARGETS+=	all clean cleandir depend dependall includes \
		install obj regress tags html analyze describe htmlinstall fetch
PHONY_NOTMAIN =	all clean cleandir depend dependall distclean includes \
		install obj regress beforedepend afterdepend \
		beforeinstall afterinstall realinstall realdepend realall \
		html subdir-all subdir-install subdir-depend analyze describe \
		htmlinstall www
.PHONY:		${PHONY_NOTMAIN}
.NOTMAIN:	${PHONY_NOTMAIN}

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
	
MSG.BUILD	?= @echo " 👷‍♂️   build " ${.CURDIR:T}/${.TARGET}
MSG.CREATE	?= @echo "     create " ${.CURDIR:T}/${.TARGET}
MSG.COMPILE	?= @echo " ⚙️ compile " ${.CURDIR:T}/${.TARGET}
MSG.LINK    ?= @echo " 🔗    link " ${.CURDIR:T}/${.TARGET}
MSG.EXECUTE	?= @echo " ▶️ execute " ${.CURDIR:T}/${.TARGET}
MSG.FORMAT	?= @echo " ✏️  format " ${.CURDIR:T}/${.TARGET}
MSG.INSTALL	?= @echo " 📦 install " ${.CURDIR:T}/${.TARGET}
MSG.REMOVE	?= @echo " 🗑️  remove " ${.TARGET}

.endif
