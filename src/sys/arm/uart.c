#include "arch.h"

#define UART0_BASE_ADDR 0x01C28000
#define UART1_BASE_ADDR 0x01C28400
#define UART2_BASE_ADDR 0x01C28800
#define UART3_BASE_ADDR 0x01C28C00
#define R_UART_BASE_ADDR 0x01F02800

#define UART0(x) (UART0_BASE_ADDR + x)
#define UART1(x) (UART1_BASE_ADDR + x)
#define UART2(x) (UART2_BASE_ADDR + x)
#define UART3(x) (UART3_BASE_ADDR + x)
#define R_UART(x) (R_UART_BASE_ADDR + x)

#define UART_RECV_BUFF_REG        0x00
#define UART_TRANSMIT_HOLDING_REG 0x00
#define UART_DIV_LATCH_LOW_REG    0x00
#define UART_DIV_LATCH_HIGH_REG   0x04
#define UART_INT_ENABLE_REG       0x04
#define UART_INT_ID_REG           0x08
#define UART_FIFO_CONTROL_REG     0x08
#define UART_LINE_CONTROL_REG     0x0C
#define UART_MODEM_CONTROL_REG    0x10
#define UART_LINE_STATUS_REG      0x14
#define UART_MODEM_STATUS_REG     0x18
#define UART_SCRATCH_REG          0x1C
#define UART_STATUS_REG           0x7C
#define UART_TRANSMIT_FIFO_LEVEL  0x80
#define UART_RFL                  0x84
#define UART_HALT_TX_REG          0xA4

void
uart_init(void)
{

}

void
uart_putchar(uint8_t c)
{
	while ((mmio_read32(UART0(UART_LINE_STATUS_REG)) & (1 << 5)) > 0)
	{}
	mmio_write32(UART0(UART_TRANSMIT_HOLDING_REG), c);
}
