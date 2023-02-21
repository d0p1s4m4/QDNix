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
		.io_base =  UART(0),
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
