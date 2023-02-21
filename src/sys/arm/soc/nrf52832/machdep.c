#include <stdint.h>
#include "register.h"
#include <sys/machine/mmio.h>

void init(void)
{
	GPIO_REG->pin_cnf[17] = 0x3;
	GPIO_REG->outclr = 1 << 17;
}
