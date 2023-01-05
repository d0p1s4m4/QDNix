#ifndef _DEV_DEVICE_H
# define _DEV_DEVICE_H 1

# include <dev/serial/serial.h>

typedef enum {
	DEVICE_TTY,
} DeviceClass;

typedef struct {
	DeviceClass class;
	char name[16];
	union {
		SerialDevice serial;
	} drivers;
} Device;

#endif /* !_DEV_DEVICE_H */
