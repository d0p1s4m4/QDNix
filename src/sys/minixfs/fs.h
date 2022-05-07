#ifndef _SYS_MINIX_FS_H
# define _SYS_MINIX_FS_H 1

# include <stdint.h>

# define BLOCK_SIZE 512

struct minix_inode {
	uint16_t i_mode;
	uint16_t i_uid;
	uint32_t i_size;
	uint32_t i_time;
	uint8_t i_gid;
	uint8_t i_nlinks;
	uint16_t i_zone[9];
};

struct minix_dir_entry {
	uint16_t inode;
	char name[0];
};

struct minix_super_block {
	uint16_t s_ninides;
	uint16_t s_nzones;
	uint16_t s_imap_blocks;
	uint16_t s_zmap_blocks;
	uint16_t s_firstdatazone;
	uint16_t s_log_zone_size;
	uint32_t s_max_size;
	uint16_t s_magic;
	uint16_t s_state;
};

#endif /* !_SYS_MINIX_FS_H */
