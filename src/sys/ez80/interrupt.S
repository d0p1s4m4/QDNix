; "Interrupt Mode 1 always calls the subroutine beginning at address 38h."
; http://www.z80.info/1653.htm


interrupt_handler:
	; disable interrupts
	di

	; save register states
	ex af, af'
	exx

	; restore register states
	exx
	ex af, af'

	; enable interrupts
	ei

	reti
