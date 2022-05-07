#ifndef _MIPS_ARCH_
# define _MIPS_ARCH_ 1

# define MMIO_BASE_ADDR 0xbfd00000

# define UART_BASE_ADDR 0x3f8

# define UART(x) (MMIO_BASE_ADDR + UART_BASE_ADDR + x)


/* coproc0 registers */
# define CO0_STATUS_REG 12
# define CO0_CAUSE_REG  13
# define CO0_EPC_REG    14

#endif /* !_MIPS_ARCH_ */
