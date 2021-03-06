- `docs/` Documentation
	- `book` [QDNix handbook](https://qdnix.d0p1.eu)
	- `man/` man pages
		- `man2/` system calls
		- `man7/` overview and miscellany section
- `make/` Makefiles helper
	- `arm/`
	- `mips/`
	- `riscv64/`
	- `z80/`
- `src/` QDNix Source code
	- `bin/` source code for files in /bin
	- `sbin/` source code for files in /sbin
	- `sys/` Kernel source code
		- `arm/` ARM architecture support
		- `dev/` device drivers
		- `kern/` main part of the kernel
		- `libkern/` C library routines used in the kernel
		- `minixfs/` Minix File System
		- `netinet/` internet protocol family
		- `mips/` MIPS architecture support
		- `riscv64/` RISC-V 64 architecture support
		- `sys/` kernel headers
		- `z80/` z80 architecture support
- `test/`
	- `sys/`
	- `bin/`
	- `sbin/`
- `thirdparty/` Sources code from external source
- `tools/` Scripts used in order to build QDNix
