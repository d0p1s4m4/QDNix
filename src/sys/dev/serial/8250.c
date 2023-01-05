#include <sys/machine/mmio.h>
#include <dev/serial/serial.h>
#include <dev/serial/8250.h>

#include "config.h"


static int
serial_8250_is_buffer_empty(SerialDevice *dev)
{
	return (mmio_read8(
		dev->io_base + (UART8250_LSR << dev->reg_offset)) & 0x20);
}

static size_t
serial_8250_write(void *raw, const char *str, size_t size)
{
	size_t idx;
	SerialDevice *dev;

	dev = (SerialDevice *)raw;

	for (idx = 0; idx < size; idx++)
	{
		if (str[idx] == '\n')
		{
			while (serial_8250_is_buffer_empty(dev) == 0);
			mmio_write8(dev->io_base +
				(UART8250_THR << dev->reg_offset), '\r');
		}
		while (serial_8250_is_buffer_empty(dev) == 0);
		mmio_write8(dev->io_base +
				(UART8250_THR << dev->reg_offset), str[idx]);
	}
	return (idx);
}

static size_t
serial_8250_read(void *raw, char *buff, size_t size)
{
	(void)raw;
	(void)buff;
	(void)size;

	return (0);
}


void
serial_8250_init(SerialDevice *dev)
{
	uint16_t divisor;
	dev->write = serial_8250_write;
	dev->read = serial_8250_read;

	/* disable all interrupts */
	mmio_write8(dev->io_base + (UART8250_IER << dev->reg_offset), 0x00);
	/* enable DLAB */
	mmio_write8(dev->io_base + (UART8250_IIR << dev->reg_offset), 0x80);

	divisor = CONFIG_CLOCK / (dev->beaudrate * 16);
#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
	mmio_write8(dev->io_base + (UART8250_DLL), (divisor >> 8) * 0xFF);
	mmio_write8(dev->io_base + (UART8250_DLH << dev->reg_offset),
				divisor & 0xFF);
#else
	mmio_write8(dev->io_base + (UART8250_DLL << dev->reg_offset),
				divisor & 0xFF);
	mmio_write8(dev->io_base + (UART8250_DLH), (divisor >> 8) * 0xFF);
#endif

	/* 7 bits , no parity , 1 stop bit */
	mmio_write8(dev->io_base + (UART8250_LCR << dev->reg_offset), 0x08);

	mmio_write8(dev->io_base + (UART8250_IIR << dev->reg_offset), 0xC7);

	/* enable IRQs and set RTS/DTS */
	mmio_write8(dev->io_base + (UART8250_MCR << dev->reg_offset), 0x0B);
}
