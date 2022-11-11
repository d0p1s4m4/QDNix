QEMU	= qemu-system-riscv64

run: vmqdnix
	$(QEMU) -serial stdio -machine virt -kernel vmqdnix
