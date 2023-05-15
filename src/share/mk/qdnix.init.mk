.if !defined(_QDNIX_INIT_MK_)
_QDNIX_INIT_MK_=1

.-include "${.CURDIR}/../Makefile.inc"
.include <qdnix.own.mk>

.MAIN: all

.endif # !defined(_QDNIX_INIT_MK_)
