.include <qdnix.own.mk>

.MAIN: build_install

.if "${CONFIG_BUILD_TOOLS}" == "yes"
SUBDIR = gmake .WAIT binutils .WAIT gcc
.else
NOSUBDIR=
.endif

.include <qdnix.subdir.mk>
.include <qdnix.buildinstall.mk>
