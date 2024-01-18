#ifndef LIBKERN_FDT_H
# define LIBLERN_FDT_H 1

# include <stdint.h>

# define FDT_MAGIC      0xD00DFEED
# define FDT_BEGIN_NODE 0x00000001
# define FDT_END_NODE   0x00000002
# define FDT_PROP       0x00000003
# define FDT_NOP        0x00000004
# define FDT_END        0x00000009

typedef struct {
	uint32_t magic;
	uint32_t totalsize;
	uint32_t off_dt_struct;
	uint32_t off_dt_strings;
	uint32_t off_mem_rsvmap;
	uint32_t version;
	uint32_t last_comp_version;
	uint32_t boot_cpuid_phys;
	uint32_t size_dt_strings;
	uint32_t size_dt_struct;
} FDTHeader;

typedef struct {
	uint64_t address;
	uint64_t size;
} FDTEntry;

typedef struct {
	uint32_t len;
	uint32_t nameoff;
} FDTProp;

#endif /* !LIBKERN_FDT_H */
