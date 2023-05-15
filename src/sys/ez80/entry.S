	.file "entry.S"
	.globl _entry

	.assume ADL=1

_entry:
	;; disable interrupt
	di

	;; setup mmu
	
	;; setup kernel stack
	ld sp, 0

	;; clear bss
	ld hl, __bss_start
	ld (hl), #0
	ld de, __bss_start + 1
	ld bc, __bss_size - 1
	ldir

hang:
	halt
	jp hang
