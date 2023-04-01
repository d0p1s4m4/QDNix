#include <netinet/in.h>
#include <openssl/prov_ssl.h>
#include <openssl/types.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>
#include <signal.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <sys/select.h>
#include <openssl/ssl.h>
#include <openssl/err.h>

#include "geminid.h"

#define IS_OPTARG(a, s, l) a[1] == s || \
					 strcmp(a + 1, "-" l) == 0

static const char *prg_name;
static uint16_t srv_port = 1965;
static const char *cert_file = "cert.pem";
static const char *key_file = "key.pem";
static const char *srv_dir = "/var/gemini";

static void
version(void)
{
	printf("%s v%s\n", prg_name, GEMINID_VERSION);
	printf("Copyright (C) 2023 d0p1\n");
	printf("License BSD-3: <https://directory.fsf.org/wiki/License:BSD-3-Clause>\n");
	printf("This is free software: you are free to change and redistribute it.\n");
	printf("There is NO WARRANTY, to the extent permitted by law.\n");
	exit(EXIT_SUCCESS);
}

static void
usage(int retval)
{
	printf("Usage: %s [OPTION]... [DIR]\n\n", prg_name);
	printf("Arguments:\n");
	printf("\tDIR\t\tGemini page directory (default: %s)\n", srv_dir);
	printf("Options:\n");
	printf("\t-h, --help\tdisplay this help and exit\n");
	printf("\t-V, --version\toutput version information and exit\n");
	printf("\t-p,--port PORT\tListen port (default: %u)\n", srv_port);
	printf("\t-c,--cert FILE\t(default: %s)\n", cert_file);
	printf("\t-k,--key FILE\t(default: %s)\n", key_file);
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
	prg_name = *argv++; /* save and skip program name */
	argc--;

	tls_init();

	/* Ignore broken pipe signals */
	signal(SIGPIPE, SIG_IGN);

	for (idx = 0; idx < argc; idx++)
	{
		if (argv[idx][0] == '-')
		{
			if (IS_OPTARG(argv[idx], 'h', "help"))
			{
				usage(EXIT_SUCCESS);
			}
			else if (IS_OPTARG(argv[idx], 'V', "version"))
			{
				version();
			}
			else
			{
				usage(EXIT_FAILURE);
			}
		}
		else 
		{
			break;
		}
	}

	server(srv_dir, srv_port, cert_file, key_file);

	return (EXIT_SUCCESS);
}
