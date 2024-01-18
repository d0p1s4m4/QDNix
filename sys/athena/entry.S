.section .bss
.align 8
stack_bottom:
.skip 16384
stack_top:

.section .text.boot

.globl _entry
_entry:

	/* set stack */
	la sp, stack_top

	/* clear bss */
	la t0, bss_begin
	la t1, bss_end

clear_bss_loop:
	sw zero, 0(t0)
	addiu t0, t0, 4
	bne t1, t0, clear_bss_loop
	nop

	.extern arch_init
	call arch_init

hang:
	jmp hang

