#include <machine/multiboot.h>
#include <libkern/printk.h>

int
multiboot_entry(Multiboot *boot_info)
{
	if (boot_info->flags | MULTIBOOT_INFO_MMAP)
	{
		printk("mmap found\n");
	}
	if (boot_info->flags | MULTIBOOT_INFO_DRIVES)
	{
		printk("has drives info\n");
	}
	return (0);
}
