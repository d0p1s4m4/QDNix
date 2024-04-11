# -----------------------------------------------------------------------------
#  TOP LEVEL MAKEFILE
# -----------------------------------------------------------------------------
#  Variables:
#     DESTDIR
# -----------------------------------------------------------------------------


.if ${.MAKEFLAGS:M${.CURDIR}/src/share/mk} == ""
.MAKEFLAGS: -m ${.CURDIR}/src/share/mk
.endif

_SRC_TOP_OBJ_=

.include <qdnix.own.mk>

MKCONF = ${.CURDIR}/.config.mk

BUILDTARGETS=	cleandir \
				do-top-obj \
				do-tools-obj \
				do-tools \
				obj \
				do-distrib-dirs \
				includes \
				do-lib \
				do-build

.ORDER: ${BUILDTARGETS}

SUBDIR = tools .WAIT external src

www: .PHONY .MAKE
	@mkdir -p ${DESTDIR}/html
	${MAKEDIRTARGET} src htmlinstall
	${MAKEDIRTARGET} thirdparty htmlinstall
	${MAKEDIRTARGET} website www
	@doxygen "${.CURDIR}/Doxyfile"
	@${.CURDIR}/tools/site-map-gen.sh ${DESTDIR}/html > ${DESTDIR}/html/sitemap.xml

do-top-obj: .PHONY .MAKE
	${MAKEDIRTARGET} . obj NOSUBDIR=

do-tools-obj: .PHONY .MAKE
	${MAKEDIRTARGET} tools obj

do-tools: .PHONY .MAKE
	${MAKEDIRTARGET} tools build_install

do-distrib-dirs: .PHONY .MAKE
	(cd "${.CURDIR}/src/etc" && ${MAKE} distrib-dirs)
	@true

do-lib: .PHONY .MAKE
	@true

do-build: .PHONY .MAKE
.for targ in all install
	${MAKEDIRTARGET} . ${targ} BUILD_tools=no BUILD_lib=no
.endfor

START_TIME!=	date

build: .PHONY .MAKE
.for tgt in ${BUILDTARGETS}
	${MAKEDIRTARGET} . ${tgt}
.endfor
	@echo   "Build started at:  ${START_TIME}"
	@printf "Build finished at: " && date

.include <qdnix.subdir.mk>
.include <qdnix.clean.mk>
