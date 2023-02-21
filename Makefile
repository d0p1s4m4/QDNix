.SUFFIXES:
.DELETE_ON_ERROR:
.DEFAULT_GOAL := all

YACC		= yacc
RM			= rm -f
MKDIR		= mkdir -p
MKCWD		= $(MKDIR) $(@D)

MKCONF		= .config.mk
TOOLDIR		= tools
SRCDIR		= src
DOCSDIR		= docs
MAKEDIR		= make
BUILDDIR	= build

GARBADGE	= 

-include $(MKCONF)

ifdef CONFIG_ARCH
CONFIG_ARCH	:= $(CONFIG_ARCH:"%"=%)
endif

ifdef CONFIG_BOARD
CONFIG_BOARD	:= $(CONFIG_BOARD:"%"=%)
else
CONFIG_BOARD	:= pc
endif

ifdef CONFIG_SOC
CONFIG_SOC	:= $(CONFIG_SOC:"%"=%)
endif

ifdef CONFIG_BUILD_TYPE
CONFIG_BUILD_TYPE	:= $(CONFIG_BUILD_TYPE:"%"=%)
endif

ifdef CONFIG_TOOLCHAIN
CONFIG_TOOLCHAIN	:= $(CONFIG_TOOLCHAIN:"%"=%)
endif

HOST_ARCH		?= $(shell uname -m)
BUILDDIR_HOST	= $(BUILDDIR)/$(HOST_ARCH)
BUILDDIR_TARGET	= $(BUILDDIR)/$(CONFIG_TOOLCHAIN)-$(CONFIG_ARCH)-$(CONFIG_BOARD)-$(CONFIG_BUILD_TYPE)

CONFIG_HEADER	= $(BUILDDIR_TARGET)/config.h

ifdef CONFIG_ARCH
include $(MAKEDIR)/toolchain.mk
include $(MAKEDIR)/flags.mk
include $(MAKEDIR)/run.mk

include $(TOOLDIR)/build.mk
include $(SRCDIR)/build.mk
include test/build.mk
endif
include $(DOCSDIR)/build.mk


.PHONY: menuconfig
menuconfig:
	$(CONF) --menuconfig
	$(CONF) --genmake $(MKCONF)

.PHONY: defconfig
defconfig:
	$(CONF) --defconfig
	$(CONF) --genmake $(MKCONF)

.PHONY: all
all: $(CONFIG_HEADER) $(KERNEL_FILE)

.config:
	@ echo "Please run: \"make menuconfig\" or \"make defconfig\""
	@ exit 255

$(CONFIG_HEADER): .config
	@ $(MKCWD)
	$(CONF) --genheader $@

.PHONY: clean
clean:
	$(RM) $(GARBADGE) $(CONFIG_HEADER)

.PHONY: fclean
fclean: clean
	$(RM) $(MKCONF) .config
	$(RM) -r $(BUILDDIR)

.PHONY: re
re: clean all

