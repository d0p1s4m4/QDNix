#ifndef _SYS_ARM_H
# define _SYS_ARM_H 1

# include <sys/machine/mmio.h>

void uart_putchar(uint8_t c);
void ccu_init_clock(void);

#endif /* !_SYS_ARM_H */
