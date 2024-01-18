KERNEL_LDFLAGS += -T src/sys/mips/linker.ld

ARCH_SRCS	= $(wildcard src/sys/mips/board/$(CONFIG_BOARD)/*.c) \
				$(wildcard src/sys/mips/*.c) \
				$(wildcard src/sys/mips/*.S)
