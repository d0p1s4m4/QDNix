ENTRY(_entry)

SECTIONS
{
	. = 1M;

	.text :
	{
		*(.multiboot)
		*(.text)
	}

	.data :
	{
		*(.data)
	}

	.rodata :
	{
		*(.rodata)
	}

	.bss :
	{
		bss_begin = .;
		*(COMMON)
		*(.bss)
		bss_end = .;
	}
}
