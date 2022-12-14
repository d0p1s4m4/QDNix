KERNEL_C_SRCS	= $(wildcard src/sys/$(CONFIG_ARCH)/*.c) \
					$(wildcard src/sys/libkern/*.c) \
					$(wildcard src/sys/kern/*.c)
KERNEL_S_SRCS	= $(wildcard src/sys/$(CONFIG_ARCH)/*.S)
KERNEL_OBJS	= $(patsubst src/%.S, $(BUILDDIR_TARGET)/%.S.o, $(KERNEL_S_SRCS)) \
				$(patsubst src/%.c, $(BUILDDIR_TARGET)/%.o, $(KERNEL_C_SRCS)) 
KERNEL_FILE	= vmqdnix

GARBADGE	+= $(KERNEL_OBJS) $(KERNEL_FILE)

$(BUILDDIR_TARGET)/sys/%.o: src/sys/%.c
	@ $(MKCWD)
	$(TARGET_CC) $(KERNEL_CFLAGS) -c -o $@ $<

$(BUILDDIR_TARGET)/sys/%.S.o: src/sys/%.S
	@ $(MKCWD)
	$(TARGET_AS) $(KERNEL_ASFLAGS) -c -o $@ $<

ifeq ($(CONFIG_SDCC), y)
GARBADGE += $(KERNEL_FILE).ihx

$(KERNEL_FILE).ihx: $(KERNEL_OBJS)
	$(TARGET_LD) -i $@ $^

$(KERNEL_FILE): $(KERNEL_FILE).ihx
	makebin $^ > $@

else
$(KERNEL_FILE):	$(KERNEL_OBJS)
	$(TARGET_LD) -o $@  $^ $(KERNEL_LDFLAGS)
endif
