#include <stdarg.h>
#include <stddef.h>
#include <stdint.h>

void printk(const char *fmt, ...);

extern void (*early_console_putchar)(char);

void
debug_putchar(char c)
{
	while ((*((unsigned *)0177564) & 0x80) == 0)
	{

	}
	*((char *)0177566) = c;
	while ((*((unsigned *)0177564) & 0x80) == 0)
	{

	}
}

void
arch_init(void)
{
	printk("QDNX hello\n");
	early_console_putchar = &debug_putchar;
	printk("\r\nOwO");

	printk("\r\nyay");
	return;
}
