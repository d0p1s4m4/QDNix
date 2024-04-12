#include <dev/device.h>
#include <dev/tty/serial/serial.h>
#include <mips/arch.h>
#include <sys/console.h>
#include <libkern/printk.h>

void serial_8250_init(void *dev);

static Device dev = {
	.class = DEVICE_TTY,
	.drivers.serial = {
		.init = serial_8250_init,
		.io_base =  (PHYS_TO_KSEG1(0x1FD00000 + UART_BASE_ADDR)),
		.beaudrate = 9600,
		.reg_offset = 0
	}
};

void
platform_init(void)
{
	dev.drivers.serial.init(&(dev.drivers.serial));

	console_setup(&dev);

	printk("serial initialized\n");
}
