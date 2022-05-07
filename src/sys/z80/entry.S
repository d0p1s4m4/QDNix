jp _entry

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


.globl _delay
_delay:
	ld bc, #0x0
	1$:
		bit #0, a
		bit #0, a
		bit #0, a
		and a, #255
		dec bc
		ld a, c
		or a, b
		jp nz, 1$
	ret
