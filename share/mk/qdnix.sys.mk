.if !defined(_QDNIX_SYS_MK_)
_QDNIX_SYS_MK_ = 1

.SUFFIXES: .o .S .c .m .cc .cpp .cxx

# Assembly
.S.o:
	${MSG.COMPILE}
	@${CC} ${CFLAGS} -c -o ${.TARGET} ${.IMPSRC} ${LDADD}

.s.o:
	${MSG.COMPILE}

# C
.c.o:
	${MSG.COMPILE}
	@${CC} ${CFLAGS} -c -o ${.TARGET} ${.IMPSRC} ${LDADD}
#       ${COMPILE.c} -c ${.IMPSRC}

# Objective-C
.m.o:
	${MSG.COMPILE}
# ${COMPILE.m} $ -c {.IMPSRC}

# C++
.cc.o .cpp.o .cxx.o:
	${MSG.COMPILE}
#       ${COMPILE.cc} -c ${.IMPSRC}

.endif # !_QDNIX_SYS_MK_
