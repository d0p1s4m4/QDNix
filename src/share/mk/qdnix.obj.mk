.if !defined(_QDNIX_OBJ_MK_)
_QDNIX_OBJ_MK_=1

.if ${MKOBJ} == "no"
obj:
.else
.if defined(MAKEOBJDIR)
obj:
.if ${.CURDIR} == ${.OBJDIR}
	@if [ ! -d "${MAKEOBJDIR}" ];
.endif
.endif

print-objdir:
	@echo ${.OBJDIR}

.endif # !defined(_QDNIX_OBJ_MK_)
