#include "sys/machine/mmio.h"
#include <stdint.h>

#define UART_BASE_ADDR 0x10000000

void uart_putchar(uint8_t c) {
	while(mmio_read8(UART_BASE_ADDR));

	mmio_write8(UART_BASE_ADDR, c);
}
