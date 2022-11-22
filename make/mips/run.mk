QEMU	= qemu-system-mips

QEMUFLAGS += -serial stdio -machine $(CONFIG_BOARD)

ifdef CONFIG_SMP
QEMUFLAGS += -smp $(CONFIG_SMP)
endif

run:
	$(QEMU) $(QEMUFLAGS) -kernel vmqdnix
