KERNEL_C_SRCS	= $(wildcard src/sys/$(CONFIG_ARCH)/*.c) \
					$(wildcard src/sys/libkern/*.c)
KERNEL_S_SRCS	= $(wildcard src/sys/$(CONFIG_ARCH)/*.S)
KERNEL_OBJS	= $(KERNEL_S_SRCS:.S=.S.o) $(KERNEL_C_SRCS:.c=.o) 

KERNEL_FILE	= vmqdnix

GARBADGE	+= $(KERNEL_OBJS) $(KERNEL_FILE)

src/sys/%.o: src/sys/%.c
	$(TARGET_CC) $(KERNEL_CFLAGS) -c -o $@ $<

src/sys/%.S.o: src/sys/%.S
	$(TARGET_AS) $(KERNEL_ASFLAGS) -c -o $@ $<

ifeq ($(CONFIG_SDCC), y)
GARBADGE += $(KERNEL_FILE).ihx

$(KERNEL_FILE).ihx: $(KERNEL_OBJS)
	$(TARGET_LD) -i $@ $^

$(KERNEL_FILE): $(KERNEL_FILE).ihx
	makebin $^ > $@

else
$(KERNEL_FILE):	$(KERNEL_OBJS)
	$(TARGET_LD) $(KERNEL_LDFLAGS) -o $@ $^
endif
