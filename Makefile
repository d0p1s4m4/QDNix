# -----------------------------------------------------------------------------
#  TOP LEVEL MAKEFILE
# -----------------------------------------------------------------------------
#  Variables:
#     DESTDIR
# -----------------------------------------------------------------------------
#  Targets:
#     build
#     www
#
#  Targets invoked by `make build`
#     cleandir
#     do-top-obj:      creates the top level object directory.
#     do-tools-obj:    creates object directories for the host toolchain
#     do-tools:        builds host toolchain
#     obj:             creates object directories
#     do-distrib-dirs: creates the distribution directories.
#     includes:        installs include files.
#     do-lib           builds and install
#     do-build

.if ${.MAKEFLAGS:M${.CURDIR}/src/share/mk} == ""
.MAKEFLAGS: -m ${.CURDIR}/src/share/mk
.endif

_SRC_TOP_OBJ_=

.include <qdnix.own.mk>

MKCONF = ${.CURDIR}/.config.mk
SRCDIR = ${.CURDIR}
BUILDDIR = ${.CURDIR}/build

.export BUILDDIR MKCONF SRCDIR

BUILDTARGETS	= cleandir \
				  do-top-obj \
				  do-tools-objs \
				  do-tools \
				  do-distrib-dirs \
				  includes \
				  do-build

.ORDER: ${BUILDTARGETS}

SUBDIR = tools .WAIT thirdparty src

www: .PHONY .MAKE
	@mkdir -p ${DESTDIR}/html
	${MAKEDIRTARGET} src htmlinstall
	${MAKEDIRTARGET} thirdparty htmlinstall
	${MAKEDIRTARGET} website www
	@doxygen "${.CURDIR}/Doxyfile"
	@${.CURDIR}/tools/site-map-gen.sh ${DESTDIR}/html > ${DESTDIR}/html/sitemap.xml

do-top-obj: .PHONY .MAKE
	${MAKEDIRTARGET} . obj NOSUBDIR=

do-tools-objs: .PHONY .MAKE
	@true

do-tools: .PHONY .MAKE
	@true

do-distrib-dirs: .PHONY .MAKE
	(cd "${.CURDIR}/src/etc" && ${MAKE} distrib-dirs)
	@true

do-build: .PHONY .MAKE
	@true

build: .PHONY .MAKE
.for tgt in ${BUILDTARGETS}
	${MAKEDIRTARGET} . ${tgt}
.endfor

.include <qdnix.subdir.mk>
.include <qdnix.obj.mk>
.include <qdnix.clean.mk>
