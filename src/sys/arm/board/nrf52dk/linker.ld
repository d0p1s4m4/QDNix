ENTRY(_entry)

MEMORY
{
	FLASH (rx) : ORIGIN = (0x00000000), LENGTH = 0x80000
	RAM (rwx)  : ORIGIN = (0x20000000), LENGTH = 0x10000
}

SECTIONS
{
	.text : ALIGN(4)
	{
		KEEP(*(.vtor))

		*(.text*)
		*(.rodata*)

		. = ALIGN(4);
	} >FLASH

	.data : ALIGN(4)
	{
		*(.data*)
	} >RAM AT>FLASH
	
	.bss (NOLOAD): ALIGN(4)
	{
		bss_begin = .;
		*(.bss*)
		bss_end = .;
	} > RAM
}
