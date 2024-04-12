/**
  * \file zealfs.h
  */
#ifndef _SYS_FS_ZEALFS_H
# define _SYS_FS_ZEALFS_H 1

# include <stdint.h>

# define ZEALFS_MAGIC 'Z'

struct zealfs_dir_entry {
	uint8_t flags;
	char name[16];
	uint8_t page;
	uint16_t size;
	uint8_t reserved[4];
};

typedef struct zealfs_header {
	uint8_t magic;
	uint8_t version;
	uint8_t bitmap_size;
	uint8_t free_pages_count;
	uint8_t bitmap[32];
	uint8_t reserved[28];
	struct zealfs_dir_entry root_entries[6];
} ZealFSHdr;

#endif /* !_SYS_FS_ZEALFS_H */
