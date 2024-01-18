#ifndef _SYS_STAT_H
# define _SYS_STAT_H 1

# include <sys/types.h>

# define S_IFBLK  1
# define S_IFCHR  2
# define S_IFIFO  3
# define S_IFREG  4
# define S_IFLNK  5
# define S_IFSOCK 6

# define S_IRWXU  0o0700
# define S_IRUSR  0o0400
# define S_IWUSR  0o0200
# define S_IXUSR  0o0100
# define S_IRWXG  0o070
# define S_IRGRP  0o040
# define S_IWGRP  0o020
# define S_IXGRP  0o010
# define S_IRWXO  0o07
# define S_IROTH  0o04
# define S_IWOTH  0o02
# define S_IXOTH  0o01
# define S_ISUID  0o04000
# define S_ISGID  0o02000



struct stat {
	dev_t st_dev;
	ino_t st_ino;
	mode_t st_mode;
	nlink_t st_nlink;
	uid_t st_uid;
	gid_t st_gid;

};


#endif /* !_SYS_STAT_H */
