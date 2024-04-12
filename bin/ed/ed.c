#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#ifndef ED_VERSION
# define ED_VERSION "1.0"
#endif /* !ED_VERSION */

#define IS_OPTARG(a, s, l) a[1] == s || \
					 strcmp(a + 1, "-" l) == 0

static const char *prg_name;

void
version(void)
{
	printf("%s v%s\n", prg_name, ED_VERSION);
	printf("Copyright (C) 2022 d0p1\n");
	printf("License BSD-3: <https://directory.fsf.org/wiki/License:BSD-3-Clause>\n");
	printf("This is free software: you are free to change and redistribute it.\n");
	printf("There is NO WARRANTY, to the extent permitted by law.\n");
	exit(EXIT_SUCCESS);
}

void
usage(FILE *out, int retval)
{
	fprintf(out, "Usage: %s [OPTION]... [FILE]\n\n", prg_name);
	fprintf(out, "Options:\n");
	fprintf(out, "\t-h, --help\tdisplay this help and exit\n");
	fprintf(out, "\t-V, --version\toutput version information and exit\n");

	exit(retval);
}

size_t
parse_flags(int argc, char *const argv[])
{
	int idx;

	for (idx = 0; idx < argc; idx++)
	{
		if (argv[idx][0] == '-')
		{
			if (IS_OPTARG(argv[idx], 'h', "help"))
			{
				usage(stdout, EXIT_SUCCESS);
			}
			else if (IS_OPTARG(argv[idx], 'V', "version"))
			{
				version();
			}
			else
			{
				usage(stderr, EXIT_FAILURE);
			}
		}
		else
		{
			break;
		}
	}

	if (idx >= argc)
	{
		usage(stderr, EXIT_FAILURE);
	}

	return (idx);
}

int
main(int argc, char *const argv[])
{
	size_t idx;

	prg_name = *argv++; /* save and skip program name */
	argc--;

	idx = parse_flags(argc, argv);
	(void)idx;
	return (EXIT_SUCCESS);
}
