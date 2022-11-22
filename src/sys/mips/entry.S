/*
 * BSD 3-Clause License
 *
 * Copyright (c) 2022, d0p1
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its
 *    contributors may be used to endorse or promote products derived from
 *    this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include "asm.h"

.set noreorder
.set noat

.section .bss
.align 8
stack_bottom:
.space 16384
stack_top:

.section .text.boot

.globl _entry
_entry:
	/* get status register */
	mfc0 $t0, C0_STATUS

	/* check if we are in kernel mode or user mode */
	andi $t1, $t0, 0x10
	bnez $t1, hang /* hang if user mode */
	nop

	/* clear status register */
	mtc0 $zero, C0_STATUS

	/* set ebase to kernel entry */
	la $t0, _entry
	mtc0 $t0, C0_EBASE

	/* check cpu number */
	mfc0 $t0, C0_PRID
	srl $t0, $t0, 24
	bnez $t0, hang
	nop

	/* save boot start args */
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	move $s3, $a3

	/* set stack */
	la $sp, stack_top

	/* clear bss */
	la $a0, bss_begin
	la $a3, bss_end
1:
	sw $zero, 0($a0)
	bne $a3, $a0, 1b
	addi $a0, $a0, 4

	/* restore boot start args */
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	move $a3, $s3

	.extern arch_init
	jal arch_init
	nop

hang:
	j hang
	nop
