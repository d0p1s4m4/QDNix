#include <sys/machine/mmio.h>
#include "arch.h"

void
serial_init(void)
{
	mmio_write8(UART(1), 0x00);		/* disable all interrupts */

	mmio_write8(UART(2), 0x80);		/* enable DLAB */
	mmio_write8(UART(0), 0x0C);		/* 9600 baud */
	mmio_write8(UART(1), 0x00);

	mmio_write8(UART(3), 0x08);		/* 7 bits , no parity , 1 stop bit */
	mmio_write8(UART(2), 0xC7);
	mmio_write8(UART(4), 0x0B);		/* enable IRQs and set RTS/DTS */
}

static int
serial_is_buffer_empty(void)
{
	return (mmio_read8(UART(5)) & 0x20);
}

void
serial_write(uint8_t data)
{
	while (serial_is_buffer_empty() == 0);
	mmio_write8(UART(0), data);
}

static int
serial_received(void)
{
	return (mmio_read8(UART(5)) & 1);
}

uint8_t
serial_read(void)
{
	while (serial_received() == 0);
	return (mmio_read8(UART(0)));
}

void
debug_puts(const char *str)
{
	while (*str != '\0')
		serial_write(*str++);
}

void
debug_putchar(char c)
{
	serial_write(c);
}

void
arch_init(void)
{
	serial_init();
	debug_puts("Hello World");

	return;
}
