#include <stddef.h>
#include <stdint.h>

void (*early_console_putchar)(char) = NULL;
static size_t early_console_idx = 0;
static char early_console_buff[512];

void
console_putchar(char c)
{
	size_t idx;

	if (early_console_putchar == NULL)
	{
		early_console_buff[early_console_idx++] = c;
		early_console_idx %= 512;
		return;
	}

	for (idx = 0; early_console_idx > 0; idx++, early_console_idx--)
	{
		early_console_putchar(early_console_buff[idx]);
	}

	early_console_putchar(c);
}

