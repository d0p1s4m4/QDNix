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

.if make(build) || make(release) || make(snapshot)
.for targ in ${TARGETS:Nobj:Ncleandir}
.if make(${targ}) && !target(.BEGIN)
.BEGIN:
	@echo 'BUILD ABORTED: "make build" and "make ${targ}" are mutually exclusive.'
	@false
.endif
.endfor
.endif

_SUBDIR = external .WAIT tools .WAIT lib include \
			bin sbin share sys etc .WAIT distrib

.for dir in ${_SUBDIR}
.if "${dir}" == ".WAIT" \
	|| (${BUILD_${dir}:Uyes} != "no" && exists(${dir}/Makefile))
SUBDIR+=	${dir}
.endif
.endfor

MKCONF = ${.CURDIR}/.config.mk

BUILDTARGETS=	cleandir \
				do-fetch \
				do-tools \
				do-distrib-dirs \
				includes \
				do-lib \
				do-build

.ORDER: ${BUILDTARGETS}

SUBDIR = etc include share sys

www: .PHONY .MAKE
	@mkdir -p ${DESTDIR}/html
	${MAKEDIRTARGET} src htmlinstall
	${MAKEDIRTARGET} thirdparty htmlinstall
	${MAKEDIRTARGET} website www
	@doxygen "${.CURDIR}/Doxyfile"
	@${.CURDIR}/tools/site-map-gen.sh ${DESTDIR}/html > ${DESTDIR}/html/sitemap.xml

do-fetch: .PHONY .MAKE
	${MAKEDIRTARGET} external fetch

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

build: .PHONY .MAKE
	mkdir -p ${DESTDIR}/usr/include
.for tgt in ${BUILDTARGETS}
	${MAKEDIRTARGET} . ${tgt}
.endfor

.include <qdnix.subdir.mk>
.include <qdnix.clean.mk>
