.if !defined(_QDNIX_OWN_MK_)
_QDNIX_OWN_MK_=1

# Load build config
.if defined(MKCONF) && exists(${MKCONF})
.include "${MKCONF}"
.endif

MKOBJ=yes

INSTALL	?= install

COPY	?= -c
RENAME	?=
HRDLINK	?= -l h
SYMLINK	?= -l s

INSTALL_DIR		?= ${INSTALL} ${INSTPRIV} -d
INSTALL_FILE	?= ${INSTALL} ${INSTPRIV} ${COPY} ${PRESERVE} ${RENAME}
INSTALL_LINK	?= ${INSTALL} ${INSTPRIV} ${HRDLINK} ${RENAME}
INSTALL_SYMLINK	?= ${INSTALL} ${INSTPRIV} ${SYMLINK} ${RENAME}

DESTDIR		?=

BINDIR		?= /bin
BINGROUP	?= wheel
BINOWNER	?= root
BINMODE		?= 555
NONBINMODE	?= 444

LIBDIR		= /lib
LIBGROUP	= bin
LIBOWNER	= root
LIBMODE		= ${NONBINMODE}

MANDIR		?= /usr/share/man
MANOWNER	?= root
MANGROUP	?= wheel
MANMODE		?= ${NONBINMODE}

DOCDIR		?= /usr/share/doc
DOCOWNER	?= wheel
DOCGROUP	?= root
DOCMODE		?= ${NONBINMODE}

MKDIRMODE	?= 0755
MKDIRPERM	?= -m ${MKDIRMODE}

.include <qdnix.host.mk>

TOOL_AR			= ${TOOLDIR}/bin/${MACHINE_PLATFORM}-ar
TOOL_AS			= ${TOOLDIR}/bin/${MACHINE_PLATFORM}-as
TOOL_LD			= ${TOOLDIR}/bin/${MACHINE_PLATFORM}-ld
TOOL_NM			= ${TOOLDIR}/bin/${MACHINE_PLATFORM}-nm
TOOL_OBJCOPY	= ${TOOLDIR}/bin/${MACHINE_PLATFORM}-objcopy
TOOL_OBJDUMP	= ${TOOLDIR}/bin/${MACHINE_PLATFORM}-objdump

CFLAGS += -std=c99 -pedantic \
			-Wall -Wextra \
			-Werror

TARGETS+=	all clean cleandir depend dependall includes \
		install obj regress tags html analyze describe htmlinstall www
PHONY_NOTMAIN =	all clean cleandir depend dependall distclean includes \
		install obj regress beforedepend afterdepend \
		beforeinstall afterinstall realinstall realdepend realall \
		html subdir-all subdir-install subdir-depend analyze describe \
		htmlinstall www
.PHONY:		${PHONY_NOTMAIN}
.NOTMAIN:	${PHONY_NOTMAIN}

htmlinstall:

#
# MAKEDIRTARGET dir target [extra make(1) params]
#	run "cd $${dir} && ${MAKEDIRTARGETENV} ${MAKE} [params] $${target}", with a pretty message
#
MAKEDIRTARGETENV?=
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
		&& ${MAKEDIRTARGETENV} ${MAKE} _THISDIR_="$${this}" "$$@" $${target}; \
	}; \
	_makedirtarget

#
# MAKEVERBOSE support.  Levels are:
#	0	Minimal output ("quiet")
#	1	Describe what is occurring
#	2	Describe what is occurring and echo the actual command
#	3	Ignore the effect of the "@" prefix in make commands
#	4	Trace shell commands using the shell's -x flag
#
MAKEVERBOSE	?= 2

.if ${MAKEVERBOSE} == 0
_MKMSG		?= @\#
_MKSHMSG	?= : echo
_MKSHECHO	?= : echo
.SILENT:
.elif ${MAKEVERBOSE} == 1
_MKMSG		?= @echo '   '
_MKSHMSG	?= echo '   '
_MKSHECHO	?= : echo
.SILENT:
.else	# MAKEVERBOSE >= 2
_MKMSG		?= @echo '\#  '
_MKSHMSG	?= echo '\#  '
_MKSHECHO	?= echo
.SILENT: __makeverbose_dummy_target__
.endif	# MAKEVERBOSE >= 2
.if ${MAKEVERBOSE} >= 3
.MAKEFLAGS:	-dl
.endif	# ${MAKEVERBOSE} >= 3
.if ${MAKEVERBOSE} >= 4
.MAKEFLAGS:	-dx
.endif	# ${MAKEVERBOSE} >= 4

_MKMSG_BUILD	?= ${_MKMSG} " 👷‍♀️   build "
_MKMSG_CREATE	?= ${_MKMSG} " 🪄  create "
_MKMSG_COMPILE	?= ${_MKMSG} " ⚙️ compile "
_MKMSG_FORMAT	?= ${_MKMSG} " ✏️  format "
_MKMSG_INSTALL	?= ${_MKMSG} " 📦 install "
_MKMSG_LINK		?= ${_MKMSG} " 🔗    link "
_MKMSG_LEX		?= ${_MKMSG} " 📝     lex "
_MKMSG_REMOVE	?= ${_MKMSG} " 🗑️  remove "
_MKMSG_YACC		?= ${_MKMSG} " 🦬    yacc "

_MKSHMSG_CREATE ?= ${_MKSHMSG} " create "
_MKSHMSG_INSTALL?= ${_MKSHMSG} "install "

_MKTARGET_BUILD		?= ${_MKMSG_BUILD} ${.CURDIR:T}/${.TARGET}
_MKTARGET_CREATE	?= ${_MKMSG_CREATE} ${.CURDIR:T}/${.TARGET}
_MKTARGET_COMPILE	?= ${_MKMSG_COMPILE} ${.CURDIR:T}/${.TARGET}
_MKTARGET_FORMAT	?= ${_MKMSG_FORMAT} ${.CURDIR:T}/${.TARGET}
_MKTARGET_INSTALL	?= ${_MKMSG_INSTALL} ${.TARGET}
_MKTARGET_LINK		?= ${_MKMSG_LINK} ${.CURDIR:T}/${.TARGET}
_MKTARGET_LEX		?= ${_MKMSG_LEX} ${.CURDIR:T}/${.TARGET}
_MKTARGET_REMOVE	?= ${_MKMSG_REMOVE} ${.TARGET}
_MKTARGET_YACC		?= ${_MKMSG_YACC} ${.CURDIR:T}/${.TARGET}

.endif # !defined{_QDNIX_OWN_MK_)