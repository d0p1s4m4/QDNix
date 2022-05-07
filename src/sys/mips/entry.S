.set noreorder
.set noat

.section .bss
.align 16
stack_bottom:
.skip 16384
stack_top:

.section .text.boot

.globl _entry
_entry:
	/* coproc 0 get status register */
	mfc0 $t0, $12

	/* check if we are in kernel mode or user mode */
	andi $t1, $t0, 0x8
	bnez $t1, hang /* hang if user mode */
	nop

	/* disable interrupt */
	li $t1, 0x1
	or $t0, $t1, $t1
	xor $t0, $t0, $t1

	/* set interrupt mask for later */
	ori $t0, $t0,  0xff00

	/* write back to coproc 0 */
	mtc0 $t0, $12

	/* save boot start args */
	add $s0, $0, $a0
	add $s1, $0, $a1
	add $s2, $0, $a2
	add $s3, $0, $a3

	/* set stack */
	la $sp, stack_top

	/* clear bss */
	la $a0, bss_begin
	la $a3, bss_end
1:
	sw $0, 0($a0)
	bne $a3, $a0, 1b
	addi $a0, $a0, 4

	/* restore boot start args */
	add $a0, $0, $s0
	add $a1, $0, $s1
	add $a2, $0, $s2
	add $a3, $0, $s3

	.extern arch_init
	jal arch_init
	nop

hang:
	j hang
	nop
