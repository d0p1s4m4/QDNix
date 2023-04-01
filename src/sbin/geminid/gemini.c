#include <string.h>
#include "geminid.h"

#ifndef MAX_PATH
# define MAX_PATH 1024
#endif /* !MAX_PATH */

char *
gemini_get_path(const char *req)
{
	static char path[MAX_PATH];
	size_t i;
	size_t j;
	int has_pass_hostname;
	size_t len;

	len = strlen(req);
	if (req[len - 2] != '\r' || req[len - 1] != '\n')
	{
		return (NULL);
	}

	if (strncmp("gemini://", req, 9) != 0)
	{
		return (NULL);
	}

	has_pass_hostname = 0;
	for (i = 9, j = 0 /* skip gemi..:// */; i < len && j < MAX_BUFFER; i++)
	{
		if (req[i] == '\r' || req[i] == '\n')
		{
			break;
		}

		if (!has_pass_hostname)
		{
			if (req[i] != '/')
			{
				continue;
			}
			has_pass_hostname = 1;
		}

		path[j++] = req[i];
	}

	path[j] = '\0';
	if (strcmp("/", path) == 0)
	{
		strcpy(path, "/index.gmi");
	}
	return (path);
}

void
gemini_protocol_handler(SSL *client, const char *srv_dir)
{
	char buffer[MAX_BUFFER];
	ssize_t read;
	char *path;

	if ((read = SSL_read(client, buffer, MAX_BUFFER)) > 0)
	{
		buffer[read] = '\0';
		printf("%s", buffer);
		path = gemini_get_path(buffer);
		if (path == NULL)
		{
			sprintf(buffer, "59 Invalid URI\r\n");
			SSL_write(client, buffer, MAX_BUFFER);
			return;
		}
		printf("%s\n", path);
	}
}
