.include <qdnix.init.mk>

.SUFFIXES: .o .c .y .l .S .s .out .elf

CFLAGS	+= 

.if defined(PROG)
.if defined(SRCS)

OBJS	+= ${SRCS:R:S/$/.o/g}

${PROG}: ${OBJS}
	${CC} ${CFLAGS} -o ${.TARGET} ${OBJS} ${LDADD}

.else

SRCS = ${PROG}.c

${PROG}: ${SRCS}
	${CC} ${CFLAGS} -o ${.TARGET} ${.CURDIR}/${SRCS} ${LDADD}

.endif
.endif

MANALL = ${MAN1} ${MAN2} ${MAN2} ${MAN3} ${MAN4} ${MAN5} ${MAN6} ${MAN7} 
MANALL += ${MAN8} ${MAN9}

.MAIN: all
all: ${PROG} ${MANALL}

.if !target(clean)
clean:
	rm -f ${PROG} ${OBJS}
.endif

.if !target(install)
.endif

.if !target(lint)
.endif

.if defined(MAN1) || defined(MAN2) || defined(MAN3) || defined(MAN4) || \
    defined(MAN5) || defined(MAN6) || defined(MAN7) || defined(MAN8) 
.include <qdnix.man.mk>
.endif
