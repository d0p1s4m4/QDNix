#include "asm.h"

/*
 * usefull stuff:
 * - https://github.com/riscv-non-isa/riscv-asm-manual/blob/master/riscv-asm.md
 */

.section .text.boot

.option norvc

.globl _entry
_entry:

.option push
.option norelax
	la gp, global_ptr
.option pop

	/* reset satp (disable paging) */
	csrw satp, x0

	/* setup stack */
	la sp, stack_top

	/* clear bss */
	la t0, bss_begin
	la t1, bss_end

	bltu t1, t0, 2f
1:
	sd x0, (t0)
	addi t0, t0, 8
	bltu t0, t1, 1b
2:
	.extern interrupt_handler
	la t0, interrupt_handler
	csrw CSR_TVEC, t0

	csrs CSR_STATUS, CSR_STATUS_REG_IE

	/* jump to kernel */
	.extern arch_init
	tail arch_init
