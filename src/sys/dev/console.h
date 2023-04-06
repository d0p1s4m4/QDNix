#ifndef SYS_DEV_CONSOLE_H
# define SYS_DEV_CONSOLE_H 1

typedef struct consoledevice {
	void (*probe)(struct consoledevice *);
} ConsoleDevice;

# define CONS_DECL(name) 

#endif /* !SYS_DEV_CONSOLE_H */
