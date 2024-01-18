#ifndef SYS_X86_MACHINE_MULTIBOOT_H
# define SYS_X86_MACHINE_MULTIBOOT_H 1

# define MULTIBOOT_HEADER_MAGIC     0x1BADB002
# define MULTIBOOT_BOOTLOADER_MAGIC 0x2BADB002

# define MULTIBOOT_MOD_ALIGN  1 << 12
# define MULTIBOOT_INFO_ALIGN 1 << 2

# define MULTIBOOT_HEADER_PAGE_ALIGN 1 << 0
# define MULTIBOOT_HEADER_MEM_INFO   1 << 1
# define MULTIBOOT_HEADER_VIDEO_MODE 1 << 2

# define MULTIBOOT_INFO_MEM             1 << 0
# define MULTIBOOT_INFO_BOOT_DEVICE     1 << 1
# define MULTIBOOT_INFO_CMDLINE         1 << 2
# define MULTIBOOT_INFO_MODS            1 << 3
# define MULTIBOOT_INFO_AOUT_SYMS       1 << 4
# define MULTIBOOT_INFO_AOUT_SHDR       1 << 5
# define MULTIBOOT_INFO_MMAP            1 << 6
# define MULTIBOOT_INFO_DRIVES          1 << 7
# define MULTIBOOT_INFO_CONFIG_TABLE    1 << 8
# define MULTIBOOT_INFO_BOOTLOADER_NAME 1 << 9
# define MULTIBOOT_INFO_APM_TABLE       1 << 10
# define MULTIBOOT_INFO_VBE             1 << 11
# define MULTIBOOT_INFO_FRAMEBUFFER     1 << 12

# define MULTIBOOT_DRIVE_CHS 0
# define MULTIBOOT_DRIVE_LBA 1

# ifndef __ASSEMBLER__

#  include <stdint.h>

typedef struct
{
        uint32_t flags;

        uint32_t mem_lower;
        uint32_t mem_upper;

        uint32_t boot_device;

        uint32_t cmd;

        uint32_t mods_count;
        uint32_t mods_addr;

        uint32_t syms[4];

        uint32_t mmap_length;
        uint32_t mmap_addr;

        uint32_t drives_length;
        uint32_t drives_addr;

        uint32_t config_table;

        uint32_t bootloader_name;

        uint32_t apm_table;

        uint32_t vbe_control_info;
        uint32_t vbe_mode_info;
        uint32_t vbe_interface_seg;
        uint32_t vbe_interface_off;
        uint32_t vbe_interface_len;

        uint64_t framebuffer_addr;
        uint32_t framebuffer_pitch;
        uint32_t framebuffer_width;
        uint32_t framebuffer_height;
        uint8_t framebuffer_bpp;
        uint8_t framebuffer_type;

} Multiboot;

typedef struct
{
        uint32_t size;
        uint64_t address;
        uint64_t length;
        uint32_t type;
} __attribute__((packed)) MultibootMemEntry;

typedef struct
{
	uint32_t size;
	uint8_t drive_number;
	uint8_t drive_mode;
	uint16_t drive_cylinders;
	uint8_t drive_heads;
	uint8_t drive_sectors;
} __attribute__((packed)) MultibootDriveEntry;

int multiboot_entry(Multiboot *boot_info);

# endif /* !__ASSEMBLER__ */

#endif /* !SYS_X86_MACHINE_MULTIBOOT_H */
