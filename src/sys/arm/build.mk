KERNEL_LDFLAGS += -T src/sys/arm/board/$(CONFIG_BOARD)/linker.ld

ARCH_SRCS	= $(wildcard src/sys/arm/board/$(CONFIG_BOARD)/*.c) \
				$(wildcard src/sys/arm/board/$(CONFIG_BOARD)/*.S) \
				$(wildcard src/sys/arm/soc/$(CONFIG_SOC)/*.c) \
				$(wildcard src/sys/arm/soc/$(CONFIG_SOC)/*.S)

-include src/sys/arm/soc/$(CONFIG_SOC)/build.mk
-include src/sys/arm/board/$(CONFIG_BOARD)/build.mk
