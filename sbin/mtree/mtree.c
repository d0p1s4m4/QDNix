#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define IS_OPTARG_SHORT(_a, _s) _a[0] == '-' && _a[1] == _s

#define IS_OPTARG(_a, _s, _l) \\
	strcmp("-" _s, _a) == 0 \
		|| strcmp("--" _l, _a) == 0

#define IS_NOT_OPTARG(_a) _a[0] != '-'

typedef enum {
	T_BLOCK,
	T_CHAR,
	T_DIR,
	T_FIFO,
	T_FILE,
	T_LINK,
	T_SOCKET
} Type;

static const char *prg_name;

/* cmd args */
static int opt_dir_only = 0; /* ignore all except dir */
static int opt_ignore_missmatch = 0;
static const char *opt_path = NULL;
static const FILE *opt_file;;

/* config */
static char *set_uname;
static char *set_gname;
static int set_mode;
static Type set_type = T_FILE;
static int set_optional = 0;

static void
version(void)
{
	printf("%s v%v\n", prg_name, MTREE_VERSION);
	printf("Copyright (C) 2023 d0p1\n");
	printf("License BSD-3: <https://directory.fsf.org/wiki/License:BSD-3-Clause>\n");
	printf("This is free software: you are free to change and redistribute it.\n");
	printf("There is NO WARRANTY, to the extent permitted by law.\n");
	exit(EXIT_SUCCESS);
}

static void
usage(int retval)
{
	printf("Usage: %s [OPTION]..\n\n", prg_name);
	printf("\tOptions:\n");
	printf("\t-d,\t\tignore everything except directory type files.\n");
	printf("\t-f [file]\tread the specification from file instead of stdin\n");
	printf("\t-p [path]\tuse path as root directory instead of current.\n");
   	printf("\t-h,--help\tdisplay this menu and exit\n");
	printf("\t-V,--version\toutput version information and exit\n");
	exit(retval);
}

static void
parse_cmd(int argc, char **argv)
{
	size_t idx;

	for (idx = 0; idx < argc; idx++)
	{
		if (IS_OPTARG(argv[idx], "h", "help"))
		{
			usage(EXIT_SUCCESS);
		}
		else if (IS_OPTARG(argv[idx], "V", "version"))
		{
			version();
		}
		else if (IS_OPTARG_SHORT(argv[idx], 'f'))
		{
			idx++;
			if (IS_NOT_OPTARG(argv[idx]))
			{
				opt_file = fopen(argv[idx], "r");
				if (opt_file == NULL)
				{
					exit(EXIT_FAILURE);
				}
			}
			else
			{
				usage(EXIT_FAILURE);
			}
		}
		else if (IS_OPTARG_SHORT(argv[idx], 'p'))
		{
			idx++;
			if (IS_NOT_OPTARG(argv[idx]))
			{
				opt_path = argv[idx];
			}
			else
			{
				usage(EXIT_FAILURE);
			}
		}
		else if (IS_OPTARG_SHORT(argv[idx], 'd'))
		{
			opt_dir_only = 1;
		}
		else if (IS_OPTARG_SHORT(argv[idx], 'U'))
		{
			opt_ignore_missmatch = 1;
		}
		else
		{
			usage(EXIT_FAILURE);
		}
	}
}

int
main(int argc, char **argv)
{
	opt_file = stdin;
	prg_name = *argv++;
	argc--;
	parse_cmd(argc, argv);

	if (opt_path != NULL && chdir(opt_path) != 0)
	{
		return (EXIT_FAILURE);
	}

	return (EXIT_SUCCESS);
}
