#include "arch.h"

/* Clock control unit */
#define CCU_BASE_ADDR 0x01C20000

#define PPL_PERIPH0_CTRL_REG 0x0028

void ccu_init_clock(void)
{
	mmio_write32(CCU_BASE_ADDR + PPL_PERIPH0_CTRL_REG, 0x90041811);
	while(!(mmio_read32(CCU_BASE_ADDR + PPL_PERIPH0_CTRL_REG) & (1 << 28)));
}
