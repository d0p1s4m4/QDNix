#ifndef SYS_KERN_VFS_H
# define SYS_KERN_VFS_H 1

typedef struct {
	int (*mount)();
	int (*unmount)();
	int (*root)();
	int (*statfs)();
	int (*sync)();
	int (*fid)();
	int (*vget)();
} VSFOps;

typedef enum {
	VFS_NON,
	VFS_REG,
	VFS_DIR,
	VFS_BLK,
	VFS_CHR,
	VFS_LNK,
	VFS_SOCK,
	VFS_BAD
} VFSType;

typedef struct vfs {
	struct vfs *next;
	VSFOps *op;

} VFS;

#endif /* !SYS_KERN_VFS_H */
