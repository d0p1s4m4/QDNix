QEMU	= qemu-system-i386

QEMUFLAGS += -serial stdio 

run:
	$(QEMU) $(QEMUFLAGS) -kernel vmqdnix
