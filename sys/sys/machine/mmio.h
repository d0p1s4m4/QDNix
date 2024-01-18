#ifndef SYS_KERN_MACHINE_H
# define SYS_KERN_MACHINE_H 1

# include <stdint.h>

static __inline__ void
mmio_write8(uintptr_t addr, uint8_t value)
{
#ifdef __i386__
	__asm__ volatile ( "outb %0, %1" : : "a"(value), "Nd"((uint16_t)addr) );
#else
	*(volatile uint8_t *)(addr) = value;
#endif
}

static __inline__ uint8_t
mmio_read8(uintptr_t addr)
{
#ifdef __i386__
	uint8_t ret;

    __asm__ volatile ( "inb %1, %0"
                   : "=a"(ret)
                   : "Nd"((uint16_t)addr) );
    return (ret);
#else
	return (*(volatile uint8_t *)addr);
#endif
}

static __inline__ void
mmio_write16(uintptr_t addr, uint16_t value)
{
	*(volatile uint16_t *)(addr) = value;
}

static __inline__ uint16_t
mmio_read16(uintptr_t addr)
{
	return (*(volatile uint16_t *)addr);
}

static __inline__ void
mmio_write32(uintptr_t addr, uint32_t value)
{
	*(volatile uint32_t *)(addr) = value;
}

static __inline__ uint32_t
mmio_read32(uintptr_t addr)
{
	return (*(volatile uint32_t *)addr);
}

# if __has_include_next(<sys/machine/mmio.h>)
#  include_next <sys/machine/mmio.h>
# endif

#endif /* !SYS_MMIO_H */
