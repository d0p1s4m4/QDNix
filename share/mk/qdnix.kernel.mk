.include <qdnix.init.mk>

.if defined(KERNEL)

LDSCRIPT	?= ${.CURDIR}/linker.ld

CFLAGS  = -I.. -Wall -Wextra -ffreestanding -fno-stack-protector \
			-fno-stack-check -fno-lto -fPIE -m64 -march=x86-64 -mabi=sysv \
			-mno-80387 -mno-mmx -mno-sse -mno-sse2 -mno-red-zone
LDFLAGS = -nostdlib -static -pie --no-dynamic-linker -z text \
			-z max-page-size=0x1000 -T ${LDSCRIPT}

KOBJS   += ${KSRCS:R:S/$/.o/g}

${KERNEL}.sys: ${KOBJS}
	${MSG.LINK}
	@${CC} -o ${.TARGET} ${KOBJS} ${LDFLAGS}

realall: ${KERNEL}.sys

__kernelinstall: .USE
	${MSG.INSTALL}
	@${INSTALL_FILE} ${.ALLSRC} ${.TARGET}

${DESTDIR}${KERNEL}! __kernelinstall

realinstall: ${DESTDIR}${KERNEL}

.if !target(clean)

clean:
	${MSG.REMOVE} ${KERNEL}.sys ${KOBJS}
	@rm -rf ${KERNEL}.sys ${KOBJS}

.endif # !clean

.endif # !KERNEL

.include <qdnix.sys.mk>

${TARGETS}:
