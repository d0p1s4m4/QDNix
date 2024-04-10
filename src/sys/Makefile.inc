CFLAGS	+= -ffreestanding \
			-D__QDNIX__=1 \
			-D__KERNEL__=1 \
			-Isrc/sys \
			-Isrc/sys/${CONFIG_ARCH} \
			-Isrc/sys/${CONFIG_ARCH}/${CONFIG_BOARD} \
			-I$(BUILDDIR_TARGET) \
			-O0

ASFLAGS	+= $(KERNEL_CFLAGS)

LDFLAGS	+= -O0 -nostdlib
