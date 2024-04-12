#ifndef _SYS_CONSOLE_H
# define _SYS_CONSOLE_H 1

# include <stddef.h>
# include <dev/device.h>

typedef struct console {
	size_t (*write)(void *, const char *, size_t);
	size_t (*read)(void *, char *, size_t);

	void *device;

	struct console *next;
} Console;

void console_flush(void);
void console_putchar(char c);
void console_setup(Device *dev);

#endif /* !_SYS_CONSOLE_H */
