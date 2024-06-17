KCFLAGS	+= -ffreestanding \
			-D__QDNIX__=1 \
			-D__KERNEL__=1 \
			-Isys \
			-Isys/${CONFIG_ARCH} \
			-Isys/${CONFIG_ARCH}/${CONFIG_BOARD} \
			-I$(BUILDDIR_TARGET) \
			-O0

ASFLAGS	+= $(KERNEL_CFLAGS)

LDFLAGS	+= -O0 -nostdlib

KSRCS += ${.CURDIR}/../libkern/kmemset.c \
		${.CURDIR}/../libkern/printk.c \
		${.CURDIR}/../kern/console.c \
		${.CURDIR}/../kern/kern.c \
		${.CURDIR}/../dev/tty/serial/8250.c