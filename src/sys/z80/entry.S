.area _HEADER (ABS)

.org 0x0000
jp _entry

.org 0x0008

.org 0x0010

.org 0x0018



_entry:
	; disable interrupt
	di

	; set interrupt mode 1
	; see: http://www.z80.info/1653.htm
	im 1

	.globl _arch_init
	call _arch_init

hang:
	jp hang
