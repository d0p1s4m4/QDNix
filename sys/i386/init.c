#include <dev/device.h>
#include <dev/tty/serial/serial.h>
#include <sys/console.h>
#include <libkern/printk.h>
#include <machine/multiboot.h>

/* TODO: refactor */
void serial_8250_init(void *dev);

static Device dev = {
	.class = DEVICE_TTY,
	.drivers.serial = {
		.init = serial_8250_init,
		.io_base = 0x3F8,
		.beaudrate = 9600,
		.reg_offset = 0
	}
};
/* END TODO */

void
arch_init(uint32_t magic, void *boot_info)
{
	/* TODO: refactor */
	dev.drivers.serial.init(&(dev.drivers.serial));

	console_setup(&dev);
	/* END TODO */

	printk("Magic: 0x%x, BootInfo: %p\n", magic, boot_info);

	switch (magic)
	{
		case MULTIBOOT_BOOTLOADER_MAGIC:
			printk("yay multiboot\n");
			multiboot_entry(boot_info);
			break;

		default:
			printk("Invalide multiboot magic\n");
			break;
	}
}
