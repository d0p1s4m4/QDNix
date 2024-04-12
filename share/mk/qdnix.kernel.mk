.include <qdnix.init.mk>

.if defined(KERNEL)

LDSCRIPT	?= ${.CURDIR}/linker.ld

CFLAGS  = -I.. -Iamd64 -Wall -Wextra -ffreestanding -fno-stack-protector \
                        -fno-stack-check -fno-lto -fPIE -m64 -march=x86-64 -mabi=sysv \
                        -mno-80387 -mno-mmx -mno-sse -mno-sse2 -mno-red-zone
LDFLAGS = -m elf_x86_64 -nostdlib -static -pie --no-dynamic-linker -z text \
                        -z max-page-size=0x1000 -T amd64/linker.ld

KOBJS   += ${KSRCS:R:S/$/.o/g}

${KERNEL}.elf: ${KOBJS}
        ${MSG.LINK}
        @ld.lld -o ${.TARGET} ${KOBJS} ${LDFLAGS}

all: ${KERNEL}.elf


.if !target(clean)

clean:
        ${MSG.REMOVE} ${KERNEL}.elf ${KOBJS}
        @rm -rf ${KERNEL}.elf ${KOBJS}

.endif # !clean

.endif # !KERNEL

.include <qdnix.sys.mk>

${TARGETS}:
