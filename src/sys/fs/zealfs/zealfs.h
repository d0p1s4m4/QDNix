#ifndef _SYS_FS_ZEALFS_H
# define _SYS_FS_ZEALFS_H 1

# include <stdint.h>

typedef struct {
	uint8_t magic;
	uint8_t version;
	uint8_t bitmap_size;
} ZealFSHdr;

#endif /* !_SYS_FS_ZEALFS_H */
