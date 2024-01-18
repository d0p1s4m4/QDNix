#ifndef _SYS_DEV_TTY_H
# define _SYS_DEV_TTY_H 1

# include <dev/tty/serial/serial.h>

typedef struct {
	void (*init)(void *);
	size_t (*write)(void *, const char *, size_t);
	size_t (*read)(void *, char *, size_t);
	void (*deinit)(void *);
	
	void *config;
} TTYDevice;

#endif /* !_SYS_DEV_TTY_H */
