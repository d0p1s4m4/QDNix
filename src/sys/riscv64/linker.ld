OUTPUT_ARCH("riscv")

ENTRY(_entry)

MEMORY
{
	testram (arwx) : ORIGIN = 0x80100000, LENGTH = 0x7f00000
}

PHDRS
{
	rom PT_LOAD;
	ram_init PT_LOAD;
	ram PT_LOAD;
	text PT_LOAD;
}

SECTIONS
{
	.rodata : {
		*(.rdata)
		*(.rodata .rodata.*)
	} >testram :rom
	
	.text : {
		*(.text.boot .text)
	} >testram :text
	
	.data : ALIGN(8) {
		*(.data .data.*)
		. = ALIGN(8);
		PROVIDE( global_ptr = . + 0x800 );
	} >testram AT>testram :ram_init
	
	.bss (NOLOAD): ALIGN(8) {
		*(.bss .bss.*)
		*(COMMON)
	} >testram :ram

	PROVIDE( bss_begin  = ADDR(.bss) );
	PROVIDE( bss_end = ADDR(.bss) + SIZEOF(.bss) );
	
	.stack (NOLOAD) : ALIGN(16) {
		. += 0x4000;
		PROVIDE(stack_top = .);
	} >testram :ram

}
