/**
  * \file xfs.h
  * XFS file system \cite xfs:algoritm_and_data_structs
  */
#ifndef _SYS_FS_XFS_H
# define _SYS_FS_XFS_H 1

#include <stdint.h>

/** ascii: XFSB */
# define XFS_SB_MAGIC  0x58465342 
/** ascii: XAGF */
# define XFS_AGF_MAGIC 0x58414743
/** ascii: XAGI */ 
# define XFS_AGI_MAGIC 0x58414749

/** inode number */
typedef uint64_t xfs_ino_t;
/** file offset */
typedef int64_t xfs_off_t;
/** disk address (sectors) */
typedef int64_t xfs_daddr_t;
typedef uint32_t xfs_agnumber_t;
typedef uint32_t xfs_agblock_t;
typedef uint32_t xfs_extlen_t;
typedef int32_t xfs_extnum_t;
typedef int16_t xfs_aextnum_t;
typedef uint32_t xfs_dablk_t;
typedef uint32_t xfs_dahash_t;
typedef uint64_t xfs_fsblock_t;
typedef uint64_t xfs_rfsblock_t;
typedef uint64_t xfs_rtblock_t;
typedef uint64_t xfs_fileoff_t;
typedef uint64_t xfs_fillblks_t;
typedef uint8_t uuid_t[16];
typedef int64_t xfs_fsize_t;

struct xfs_btree_sblock {
};

struct xfs_btree_lblock {
};

typedef struct xfs_da_blkinfo {
} xfs_da_blkinfo_t;

struct xfs_da3_blkinfo {
};

typedef struct xfs_da_intnode {
	struct xfs_da_node_hdr {
		xfs_da_blkinfo_t info;
		uint16_t count;
		uint16_t level;
	} hdr;
	struct xfs_da_node_entry {
		xfs_dahash_t hashval;
		xfs_dablk_t before;
	} betree[1];
} xfs_da_intnode_t;

struct xfs_da3_intnode {
	struct xfs_da3_node_hdr {
		struct xfs_da3_blkinfo info;
		uint16_t count;
		uint16_t level;
		uint32_t pad32;
	} hdr;
	struct xfs_da_node_entry betree[1];
};

struct xfs_legacy_timestamp {
	int32_t t_sec;
	int32_t t_nsec;
};

struct xfs_sb {
	uint32_t sb_magicnum;
};

xfs_dahash_t xfs_da_hashname(const uint8_t *name, int namelen);


#endif /* !_SYS_FS_XFS_H */
