.section .data

msg:
	.ascii "Hello, World\n"
	len = . - msg

.section .text
.globl _start

_start:

#ifdef __arm__
.include "hello.arm.S"
#elif defined(__riscv)
.include "hello.riscv.S"
#elif defined(__x86_64__)
.include "hello.x86_64.S"
#elif defined(__i386__)
.include "hello.i386.S"
#elif defined(__pdp__)
.include "hello.pdp11.S"
#else
# error "Unsupported architecture"
#endif
