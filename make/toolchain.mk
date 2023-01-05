ifdef CONFIG_ARCH
include make/$(CONFIG_ARCH)/toolchain.mk
endif

ifeq ($(CONFIG_LLVM), y)
	LLVM_TARGET		= -target $(TRIPLE)
	TARGET_CC		:= clang $(LLVM_TARGET)
	TARGET_AS		:= $(TARGET_CC)
	TARGET_LD		:= ld.lld
	TARGET_OBJDUMP	:= llvm-objdump

	CC				:= clang
else ifeq ($(CONFIG_GNU), y)
	TARGET_CC		:= $(TRIPLE)-gcc
	TARGET_AS		:= $(TARGET_CC)
	TARGET_LD		:= $(TRIPLE)-ld
	TARGET_OBJDUMP	:= $(TRIPLE)-objdump

	CC				:= gcc
else ifeq ($(CONFIG_CC65), y)
	TARGET_CC	:= cl65
	TARGET_AS	:= ca65
	TARGET_LD	:= cl65
else ifeq ($(CONFIG_SDCC), y)
	TARGET_CC	:=	sdcc
	TARGET_AS	:=	sdasz80
	TARGET_LD	:=	sdldz80
endif
