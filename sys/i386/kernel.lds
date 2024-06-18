OUTPUT_ARCH("i386")
ENTRY(_entry)

_kern_phys_base = 1M;
_kern_virt_base = 0xC0100000;
_kern_offset    = _kern_virt_base - _kern_phys_base;

SECTIONS
{
	. = _kern_phys_base;
	__kernel_unpaged_start = .;

	.unpaged_text : { entry.o(.multiboot .text) }
	.unpaged_data : { entry.o(.data) }
	.unpaged_bss  : { entry.o(.bss)}

	__kernel_unpaged_end = .;

	. += _kern_offset;

	.text ALIGN(4096) : AT (ADDR (.text) - _kern_offset)
	{
		*(.text)
	}

	.data ALIGN(4096) : AT (ADDR (.data) - _kern_offset)
	{
		*(.data)
	}

	.rodata ALIGN(4096) : AT (ADDR (.rodata) - _kern_offset)
	{
		*(.rodata)
	}

	.bss ALIGN(4096) : AT (ADDR (.bss) - _kern_offset)
	{
		bss_begin = .;
		*(COMMON)
		*(.bss)
		bss_end = .;
	}

	_end = .;
}
