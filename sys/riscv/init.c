#include "arch.h"
void uart_putchar(uint8_t c);

void
arch_init(void)
{
	uart_putchar('H');
	uart_putchar('e');
	uart_putchar('l');
	uart_putchar('l');
	uart_putchar('o');

	__asm__ volatile("wfi");
}
