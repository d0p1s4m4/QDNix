#include "dev/device.h"
#include <stddef.h>
#include <stdint.h>

#include <sys/console.h>

#ifdef CONFIG_BUFFERED_CONSOLE
static char console_buffer[CONFIG_CONSOLE_BUFFER_SIZE] = { '\0' };
static size_t console_buffer_idx = 0;
#endif /* CONFIG_BUFFERED_CONSOLE */

static Console *console = NULL;

void
console_flush(void)
{
#ifdef CONFIG_BUFFERED_CONSOLE
	if (console != NULL && console->write != NULL && console_buffer_idx > 0)
	{
		console->write(console->device, console_buffer, console_buffer_idx);
	}
#endif /* CONFIG_BUFFERED_CONSOLE */
}

void
console_putchar(char c)
{
#ifdef CONFIG_BUFFERED_CONSOLE
	if (console_buffer_idx > CONFIG_CONSOLE_BUFFER_SIZE)
	{
		console_flush();
	}
	console_buffer[console_buffer_idx++] = c;
#else
	if (console != NULL && console->write != NULL)
	{
		console->write(console->device, &c, 1);
	}
#endif /* CONFIG_BUFFERED_CONSOLE */
}

void
console_setup(Device *dev)
{
	/* XXX: rework drivers */
	static Console cons;

	if (dev->class == DEVICE_TTY)
	{
		cons.write = dev->drivers.serial.write;
		cons.read = dev->drivers.serial.read;
	}
	cons.device = &(dev->drivers.serial);

	console = &cons;
#ifdef CONFIG_BUFFERED_CONSOLE
	if (console_buffer_idx > 0)
	{
		console_flush();
	}
#endif /* CONFIG_BUFFERED_CONSOLE */
}

