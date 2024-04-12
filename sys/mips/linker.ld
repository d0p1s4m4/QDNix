OUTPUT_ARCH(mips)

ENTRY(_entry)

SECTIONS
{
	. = 0x80100000;

	.text :
	{
		KEEP(*(.text.boot))
		*(.text)
	}

	.rodata :
	{
		*(.rodata)
	}

	.data :  ALIGN(8)
	{
		*(.data)
	}

	bss_begin = .;
	.bss : ALIGN(8)
	{
		*(.bss)
	}
	bss_end = .;
}
