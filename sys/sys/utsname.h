#ifndef SYS_UTSNAME_H
# define SYS_UTSNAME_H 1

struct utsname {
	char sysname[36];
	char nodename[36];
	char release[36];
	char version[36];
	char machine[36];
};

int uname(struct utsname *);

#endif /* !SYS_UTSNAME_H */
