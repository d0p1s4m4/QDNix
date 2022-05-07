.section .text
.set noreorder
.set noat

.globl
trap_handler:
	addiu $sp, $sp, -148
	sw $at, 0($sp)
	sw $v0, 4($sp)
	sw $v1, 8($sp)
	sw $a0, 12($sp)
	sw $a1, 16($sp)
	sw $a2, 20($sp)
	sw $a3, 24($sp)
	sw $t0, 28($sp)
	sw $t1, 32($sp)
	sw $t2, 36($sp)
	sw $t3, 40($sp)
	sw $t4, 44($sp)
	sw $t5, 48($sp)
	sw $t6, 52($sp)
	sw $t7, 56($sp)
	sw $s0, 60($sp)
	sw $s1, 64($sp)
	sw $s2, 68($sp)
	sw $s3, 72($sp)
	sw $s4, 76($sp)
	sw $s5, 80($sp)
	sw $s6, 84($sp)
	sw $s7, 88($sp)
	sw $t8, 92($sp)
	sw $t9, 96($sp)
	sw $k1, 100($sp)
	sw $gp, 104($sp)
	sw $fp, 108($sp)
	sw $ra, 112($sp)

	eret
