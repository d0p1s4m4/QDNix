/*
 * BSD 3-Clause License
 *
 * Copyright (c) 2023, d0p1
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

.section .bss
.align 8
stack_bottom:
.space 16384
stack_top:

.section .text
.globl _entry 

_entry:

	mov r0, 0
	ldr r1, =(bss_begin)
	ldr r2, =(bss_end)
1:
	strt r0, [r1, 0]
	add r1, 4
	cmp r2, r1
	bgt 1b

	.extern init
	bl init
	nop
halt:
	b halt
	nop


.section .vtor
.word stack_top

.word _entry /* reset */
.word 0      /* NMI */
.word 0      /* Hard fault */
.word 0      /* Mem fault */
.word 0      /* Bus fault */
.word 0      /* Usage fault */
.word 0      /* Reserved */
.word 0      /* Reserved */
.word 0      /* Reserved */
.word 0      /* Reserved */
.word 0      /* SVCall */
.word 0      /* Reserved for Debug */
.word 0      /* Reserved */
.word 0      /* PendSV */
.word 0      /* Systick */

