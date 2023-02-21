COMMON_CFLAGS	= -std=c99 \
					-pedantic \
					-Wall \
					-Wextra \
					-Werror

# ==============================================================================
#  Kernel
# ==============================================================================

KERNEL_CFLAGS	= $(COMMON_CFLAGS) \
					-ffreestanding \
					-D__QDNIX__=1 \
					-D__KERNEL__=1 \
					-Isrc/sys \
					-Isrc/sys/$(CONFIG_ARCH) \
					-Isrc/sys/$(CONFIG_ARCH)/$(CONFIG_BOARD) \
					-I$(BUILDDIR_TARGET) \
					-O0

KERNEL_ASFLAGS	= $(KERNEL_CFLAGS)

KERNEL_LDFLAGS	=	\
					-O0 \
					-nostdlib

# ==============================================================================
#  Userspace
# ==============================================================================

USERSPACE_CFLAGS	= $(COMMON_CFLAGS)

USERSPACE_LDFLAGS	=

# ==============================================================================
#  tests
# ==============================================================================
TESTS_CFLAGS	= $(COMMON_CFLAGS) \
					-fno-builtin \
					-Isrc/sys

TESTS_LDFLAGS	= -lcmocka

ifeq ($(CONFIG_WITH_COVERAGE), y)
TESTS_CFLAGS	+= --coverage
TESTS_LDFLAGS	+= --coverage
endif

ifdef CONFIG_ARCH
include make/$(CONFIG_ARCH)/flags.mk
endif