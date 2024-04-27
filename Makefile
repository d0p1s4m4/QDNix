# -----------------------------------------------------------------------------
#  TOP LEVEL MAKEFILE
# -----------------------------------------------------------------------------
#  Variables:
#     DESTDIR
# -----------------------------------------------------------------------------


.if ${.MAKEFLAGS:M${.CURDIR}/share/mk} == ""
.MAKEFLAGS: -m ${.CURDIR}/share/mk
.endif

_SRC_TOP_OBJ_=

.include <qdnix.own.mk>

MKCONF = ${.CURDIR}/.config.mk

BUILDTARGETS=	cleandir \
				fetch \
				do-tools \
				do-distrib-dirs \
				includes \
				do-lib \
				do-build

.ORDER: ${BUILDTARGETS}

SUBDIR = tools .WAIT external etc include share sys

www: .PHONY .MAKE
	@mkdir -p ${DESTDIR}/html
	${MAKEDIRTARGET} src htmlinstall
	${MAKEDIRTARGET} thirdparty htmlinstall
	${MAKEDIRTARGET} website www
	@doxygen "${.CURDIR}/Doxyfile"
	@${.CURDIR}/tools/site-map-gen.sh ${DESTDIR}/html > ${DESTDIR}/html/sitemap.xml

do-tools: .PHONY .MAKE
	${MAKEDIRTARGET} tools build_install

do-distrib-dirs: .PHONY .MAKE
	(cd "${.CURDIR}/etc" && ${MAKE} distrib-dirs)
	@true

do-lib: .PHONY .MAKE
	@true

do-build: .PHONY .MAKE
.for targ in dependall install
	${MAKEDIRTARGET} . ${targ}
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
