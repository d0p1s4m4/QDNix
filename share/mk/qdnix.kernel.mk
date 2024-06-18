.include <qdnix.init.mk>

.if defined(KERNEL)

LDSCRIPT	?= ${.CURDIR}/kernel.lds

CFLAGS  = -D__QDNIX__=1 \
		  -D__KERNEL__=1 \
		  -I.. \
		  -I${QDNIXSRCDIR} \
		  -Wall \
		  -Wextra \
		  -ffreestanding \
		  -fno-stack-protector \
		  -fno-stack-check \
		  -fno-lto \
		  -fPIE \
		  ${KCFLAGS}
LDFLAGS = -nostdlib -static -pie  -z text \
			-z max-page-size=0x1000 -T ${LDSCRIPT} \
			-lgcc 

KOBJS   += ${KSRCS:R:S/$/.o/g}

${KERNEL}.sys: ${KOBJS}
	${MSG.LINK}
	@${CC} -o ${.TARGET} ${KOBJS} ${LDFLAGS}

realall: ${KERNEL}.sys

__kernelinstall: .USE
	${MSG.INSTALL}
	@${INSTALL_FILE} ${KERNEL}.sys ${.TARGET}

${DESTDIR}/${KERNEL}.sys! __kernelinstall

realinstall: ${DESTDIR}/${KERNEL}.sys

.if !target(clean)

clean:
	${MSG.REMOVE} ${KERNEL}.sys ${KOBJS}
	@rm -rf ${KERNEL}.sys ${KOBJS}

.endif # !clean

.endif # !KERNEL

.include <qdnix.sys.mk>

${TARGETS}:
