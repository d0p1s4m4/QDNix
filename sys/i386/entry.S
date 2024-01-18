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

#include <machine/multiboot.h>

#define MULTIBOOT_FLAGS MULTIBOOT_HEADER_PAGE_ALIGN \
		| MULTIBOOT_HEADER_MEM_INFO \
		| MULTIBOOT_HEADER_VIDEO_MODE
#define MULTIBOOT_CHKSUM -(MULTIBOOT_HEADER_MAGIC + MULTIBOOT_FLAGS)

#define FRAMEBUFFER_WIDTH  1024
#define FRAMEBUFFER_HEIGHT 768
#define FRAMEBUFFER_BPP    32

	.section .bss
	.align 8
stack_bottom:
	.space 16384
stack_top:

	.section .multiboot
	.align 4
	.long MULTIBOOT_HEADER_MAGIC
	.long MULTIBOOT_FLAGS
	.long MULTIBOOT_CHKSUM

	.long 0x0
	.long 0x0
	.long 0x0
	.long 0x0
	.long 0x0

	.long 0x0
	.long FRAMEBUFFER_WIDTH
	.long FRAMEBUFFER_HEIGHT
	.long FRAMEBUFFER_BPP

	.section .text
	.globl _entry
	.type _entry,@function
_entry:
	movl $stack_top, %esp

	movl %eax, %edx /* save boot magic */

	cli

	/* clear bss */
	xorl %eax, %eax
	movl $bss_begin, %edi
	movl $bss_end, %ecx
	subl %edi, %ecx
	cld
	rep
	stosb

	push %ebx /* boot info */
	push %edx /* magic */

	call arch_init

	cli
halt:
	hlt
	jmp halt
