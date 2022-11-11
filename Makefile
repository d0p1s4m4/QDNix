.SUFFIXES:
.DEFAULT_GOAL := all

RM			= rm -f

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

include $(MAKEDIR)/toolchain.mk
include $(MAKEDIR)/flags.mk
include $(MAKEDIR)/run.mk

include $(TOOLDIR)/build.mk
include $(DOCSDIR)/build.mk
include $(SRCDIR)/build.mk
include test/build.mk

.PHONY: menuconfig
menuconfig:
	$(CONF) --menuconfig
	$(CONF) --genmake $(MKCONF)
	$(CONF) --genheader config.h

.PHONY: defconfig
defconfig:
	$(CONF) --defconfig
	$(CONF) --genmake $(MKCONF)
	$(CONF) --genheader config.h

.PHONY: all
all: $(KERNEL_FILE)

.PHONY: clean
clean:
	$(RM) $(GARBADGE)

.PHONY: fclean
fclean: clean
	$(RM) $(MKCONF)

.PHONY: re
re: clean all

