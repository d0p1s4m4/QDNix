.section .bss
.align 16
stack_bottom:
.skip 16384
stack_top:

.section .text.boot

.globl _entry
_entry:

	/* set stack */
	la sp, stack_top

	/* clear bss */
	la r1, bss_begin
	la r2, bss_end

clear_bss_loop:
	sw $0, 0(r1)
	addi r1, r1, 4
	bne r2, r1, clear_bss_loop
	nop

	.extern arch_init
	call arch_init

hang:
	jmp hang

