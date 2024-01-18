#ifndef SYS_X86_CPU_H
# define SYS_X86_CPU_H 1

# include <stdint.h>
# include <sys/macros.h>

typedef struct PACKED
{
	uint16_t limit;
	uint32_t base;
} SegmentDesc;

typedef struct PACKED
{
	uint16_t limit_low;
	uint16_t base_low;
	uint8_t base_mid;
	uint8_t access;
	uint8_t flags;
	uint8_t base_high;
} GDTDesc;

#endif /* !SYS_X86_CPU_H */
