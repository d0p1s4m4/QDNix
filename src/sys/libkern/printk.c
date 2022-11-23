/*
 * BSD 3-Clause License
 *
 * Copyright (c) 2022, d0p1
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its
 *    contributors may be used to endorse or promote products derived from
 *    this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <stddef.h>
#include <stdarg.h>
#include <stdint.h>

extern void console_putchar(char);

static __inline__ void
printstr(const char *str)
{
	if (str == NULL)
	{
		printstr("(null)");
		return;
	}

	while (*str != '\0')
	{
		console_putchar(*str++);
	}
}

static __inline__ void
printuint(uintptr_t u, int base)
{
	static const char digits[] = "0123456789abcdef";
	static char buff[20];
	int idx;

	idx = 0;
	do
	{
		buff[idx++] = digits[u % base];
	} while((u /= base) != 0);

	for (; idx > 0; idx--)
	{
		console_putchar(buff[idx-1]);
	}
}

void
printk(const char *fmt, ...)
{
	va_list args;
	char *ptr;
	int tmp;

	va_start(args, fmt);
	for (ptr = (char *)fmt; *ptr != '\0'; ptr++)
	{
		if (*ptr != '%')
		{
			/* TODO: tty/console  */
			console_putchar(*ptr);
			continue;
		}

		ptr++;
		switch (*ptr)
		{
			case '%':
				console_putchar('%');
				break;

			case 'd':
			case 'i':
				tmp = va_arg(args, int);
				if (tmp < 0)
				{
					console_putchar('-');
					printuint(-tmp, 10);
				}
				else
				{
					printuint(tmp, 10);
				}
				break;
			
			case 'u':
				printuint((va_arg(args, unsigned)), 10);
				break;

			case 'x':
				printuint((va_arg(args, unsigned)), 16);
				break;

			case 'o':
				console_putchar('0');
				printuint((va_arg(args, unsigned)), 8);
				break;

			case 's':
				printstr(va_arg(args, const char *));
				break;

			case 'c':
				console_putchar(va_arg(args, int));
				break;
			
			case 'p':
			case 'a':
				printstr("0x");
				printuint((va_arg(args, uintptr_t)), 16);
				break;

			default:
				console_putchar('%');
				console_putchar(*ptr);
		}
	}
	va_end(args);
}
