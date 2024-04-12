#ifndef SYS_ARM_SOC_NRF52832_H
# define SYS_ARM_SOC_NRF52832_H 1

# include <stdint.h>

typedef struct {  
	uint32_t reserved0[321];
	uint32_t out;
	uint32_t outset;
	uint32_t outclr;
	uint32_t in;
	uint32_t dir;
	uint32_t dirset;
	uint32_t dirclr;
	uint32_t latch;
	uint32_t detectmode;
	uint32_t reserved1[118];
	uint32_t pin_cnf[32];
} GpioRegister;

typedef struct {
	uint32_t tasks_startrx;
	uint32_t tasks_stoprx;
	uint32_t tasks_starttx;
	uint32_t tasks_stoptx;
	uint32_t reserved0[3];
	uint32_t tasks_suspend;
	uint32_t reserved1[56];
	uint32_t events_cts;
	uint32_t events_ncts;
	uint32_t events_rxdrdy;
	uint32_t reserved2[4];
	uint32_t events_txdrdy;
	uint32_t reserved3;
	uint32_t events_error;
	uint32_t reserved4[7];
	uint32_t events_rxto;
	uint32_t reserved5[46];
	uint32_t shorts;
	uint32_t reserved6[64];
	uint32_t intenset;
	uint32_t intenclr;
	uint32_t reserved7[93];
	uint32_t errorsrc;
	uint32_t reserved8[31];
	uint32_t enable;
	uint32_t reserved9;
	uint32_t pselrts;
	uint32_t pseltxd;
	uint32_t pselcts;
	uint32_t pselrxd;
	uint32_t rxd;
	uint32_t txd;
	uint32_t reserved10;
	uint32_t baudrate;
	uint32_t reserved11[17];
	uint32_t config;
} UARTRegister;

# define UART_REG ((UARTRegister *)0x40002000UL)
# define GPIO_REG ((GpioRegister *)0x50000000UL)

/* P017 -> LED1 */

#endif
