.include <qdnix.init.mk>

.SUFFIXES: .o .c .y .l .S .s .out .elf

.if defined(PROG)
.if defined(SRCS)

OBJS	+= ${SRCS:R:S/$/.o/g}

${PROG}: ${OBJS}
	${MSG.LINK}
	@${CC} ${CFLAGS} -o ${.TARGET} ${.ALLSRC} ${LDADD}

.else

SRCS = ${PROG}.c

${PROG}: ${SRCS}
	${MSG.LINK}
	@${CC} ${CFLAGS} -o ${.TARGET} ${.CURDIR}/${SRCS} ${LDADD}

.endif # !SRCS

.if !target(clean)
clean:
	rm -f ${PROG} ${OBJS}
.endif # !target(clean)

.endif # !PROG

MANALL = ${MAN1} ${MAN2} ${MAN2} ${MAN3} ${MAN4} ${MAN5} ${MAN6} ${MAN7} 
MANALL += ${MAN8} ${MAN9}

.MAIN: all
all: ${PROG} ${MANALL}

.if !target(install)
.endif

.if defined(MAN1) || defined(MAN2) || defined(MAN3) || defined(MAN4) || \
    defined(MAN5) || defined(MAN6) || defined(MAN7) || defined(MAN8) 
.include <qdnix.man.mk>
.endif

.include <qdnix.sys.mk>
.include <qdnix.clean.mk>
.include <qdnix.inc.mk>

${TARGETS}:	# ensure existence
