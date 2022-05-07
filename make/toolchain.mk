ifdef CONFIG_ARCH
include make/$(CONFIG_ARCH:"%"=%)/toolchain.mk
endif

ifeq ($(CONFIG_LLVM), y)
	LLVM_TARGET	= -target $(TRIPLET)
	TARGET_CC	:= clang $(LLVM_TARGET)
	TARGET_AS	:= $(TARGET_CC)
	TARGET_LD	:= ld.lld

	CC			:= clang
else ifeq ($(CONFIG_GNU), y)
	TARGET_CC	:= $(TRIPLET)-gcc
	TARGET_AS	:= $(TARGET_CC)
	TARGET_LD	:= $(TRIPLET)-ld

	CC			:= gcc
else ifeq ($(CONFIG_CC65), y)
	TARGET_CC	:= cl65
	TARGET_AS	:= ca65
	TARGET_LD	:= cl65
else ifeq ($(CONFIG_SDCC), y)
	TARGET_CC	:=	sdcc
	TARGET_AS	:=	sdasz80
	TARGET_LD	:=	sdldz80
endif
