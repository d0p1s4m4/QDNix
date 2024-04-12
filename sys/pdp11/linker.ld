OUTPUT_FORMAT(a.out-pdp11)
OUTPUT_ARCH(pdp11)
ENTRY(_entry)

SECTIONS
{
	. = 01000;

	.text :
	{
		*(.text)
		*(.rodata)
		. = ALIGN(01000);
	}

	.data : 
	{
		*(.data)
		. = ALIGN(01000);
	}

	bss_begin = .;
	.bss :
	{
		*(.bss)
		. = ALIGN(01000);
	}
	bss_end = .;
}
