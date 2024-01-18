.SUFFIXES: .out .elf .a .o .c .y .l .s .S
.LIBS: .a

AR		?= ar
ARFLAGS	?= r
RANLIB	?= ranlib

CC	?= cc
CFLAGS = -Werror -Wextra -Wall

AS = ${CC}
ASFLAGS =

OBJC = ${CC}
OBJCFLAGS = ${CFLAGS}

LD ?= ${CC}

.S:
	${AS} ${ASFLAGS} ${LDFLAGS} -o ${.TARGET}
.S.o:
	${AS} ${ASFLAGS} -c ${.IMPSRC}

.c:
	${CC} ${CFLAGS} ${LDFLAGS} -o ${.TARGET} ${.IMPSRC} ${LDLIBS}
.c.o:
	${CC} ${CFLAGS} -c ${.IMPSRC}
