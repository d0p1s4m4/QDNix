KERNEL_LDFLAGS += -T src/sys/riscv64/linker.ld

ARCH_SRCS	= $(wildcard src/sys/riscv64/*.c) \
				$(wildcard src/sys/riscv64/*.S)
