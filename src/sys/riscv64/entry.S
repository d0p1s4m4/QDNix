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
	la a0, bss_begin
	la a1, bss_end
	sub a2, a0, a1
	addi a1, x0, 0
	.extern kmemset
	call kmemset

	/* jump to kernel */
	.extern arch_init
	tail arch_init
