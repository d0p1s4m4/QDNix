OUTPUT_ARCH(i386:x86-64)

ENTRY(_entry)

PHDRS
{
    text     PT_LOAD    FLAGS(0x05); /* Execute + Read */
    rodata   PT_LOAD    FLAGS(0x04); /* Read only */
    data     PT_LOAD    FLAGS(0x06); /* Write + Read */
    dynamic  PT_DYNAMIC FLAGS(0x06); /* Dynamic PHDR for relocations */
}

_kern_virt_base =  0xffffffff80000000;

SECTIONS
{
	. = _kern_virt_base;

	.text : ALIGN(4096) {
		*(.text)
	} : text

	.rodata : ALIGN(4096) {
		*(.rodata)
	} :rodata

	.data : ALIGN(4096) {
		*(.data)

		/* limine related stuff */
		KEEP(*(.requests_start_marker))
		KEEP(*(.requests))
		KEEP(*(.requests_end_marker))
	} : data

	.dynamic : ALIGN(4096) {
		*(.dynamic)
	} :data :dynamic

	.bss : ALIGN(4096) {
		*(.bss)
		*(COMMON)
	} : data

	/DISCARD/ : {
        *(.eh_frame*)
        *(.note .note.*)
        *(.interp)
    }
}