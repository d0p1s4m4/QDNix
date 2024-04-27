.text
.even

.globl _entry
_entry:
	reset
	mov $0x1000, sp

	.extern _arch_init
	jsr pc, _arch_init
	halt

.end
