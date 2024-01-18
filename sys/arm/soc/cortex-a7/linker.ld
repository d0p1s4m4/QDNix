ENTRY(_entry)

SECTIONS
{
	. = 0x8000;

	.text :
	{
		KEEP(*(.text.boot))
		*(.text)
	}
	. = ALIGN(4096);

	.rodata :
	{
		*(.rodata)
	}
	. = ALIGN(4096);

	.data :
	{
		*(.data)
	}
	. = ALIGN(4096);

	bss_begin = .;
	.bss :
	{
		*(.bss)
	}
	. = ALIGN(4096);
	bss_end = .;
}
