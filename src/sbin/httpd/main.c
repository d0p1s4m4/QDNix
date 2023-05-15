#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <signal.h>

#define HTTPD_VERSION "1.0"

#define IS_OPTARG(a, s, l) a[1] == s || \
					 strcmp(a + 1, "-" l) == 0

static const char *prg_name;
static const char *srv_dir = "/var/html";

static void
version(void)
{
	printf("%s v%s\n", prg_name, HTTPD_VERSION);
	printf("Copyright (C) 2023 d0p1\n");
	printf("License BSD-3: <https://directory.fsf.org/wiki/License:BSD-3-Clause>\n");
	printf("This is free software: you are free to change and redistribute it.\n");
	printf("There is NO WARRANTY, to the extent permitted by law.\n");
	exit(EXIT_SUCCESS);
}

static void
usage(int retval)
{
	printf("Usage: %s [OPTION].. [DIR]\n\n", prg_name);
	printf("Arguments:\n");
	printf("\tDIR\t\tHTML page directory (default: %s)\n", srv_dir);
	printf("\tOptions:\n");
	printf("\t-h,--help\tdisplay this menu and exit\n");
	printf("\t-V,--version\toutput version information and exit\n");
	exit(retval);
}

int
main(int argc, char *const argv[])
{
	size_t idx;

	/*
	 * QDNix will always provide argv[0] so we won't care about 
	 * things like: CVE-2021-4034 and broken sys
	 */
	prg_name = *argv++;
	argc--;

	signal(SIGPIPE, SIG_IGN);

	for (idx = 0; idx < argc; idx++)
	{
		if (IS_OPTARG(argv[idx], 'V', "version"))
		{
			version();
		}
		if (IS_OPTARG(argv[idx], 'h', "help"))
		{
			usage(EXIT_SUCCESS);
		}
	}
	return (EXIT_SUCCESS);
}
