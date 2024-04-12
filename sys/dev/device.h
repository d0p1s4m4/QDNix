#ifndef _DEV_DEVICE_H
# define _DEV_DEVICE_H 1

# include <dev/tty/serial/serial.h>

struct device;
struct driver;

typedef enum {
	DEVICE_CPU,
	DEVICE_TTY,
	DEVICE_NET,
	DEVICE_DISK,
	DEVICE_AUDIO,
	DEVICE_VIDEO,
	DEVICE_BUS,
	DEVICE_NULL
} DeviceClass;

typedef struct device {
	DeviceClass class;
	char name[16];
	union {
		SerialDevice serial;
	} drivers;
	struct device *next;
	struct device *child;
} Device;

typedef struct {
	const char *name;
	Device **devs;
	DeviceClass class;
} Driver;


#endif /* !_DEV_DEVICE_H */
