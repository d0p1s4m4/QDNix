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
#include <stdio.h>

#include "geminid.h"

static void
client_handler(int sock, SSL_CTX *ctx, const char *srv_dir)
{
	SSL *client_tls;

	client_tls = SSL_new(ctx);
	SSL_set_fd(client_tls, sock);

	if (SSL_accept(client_tls) <= 0)
	{
		ERR_print_errors_fp(stderr);
		goto end;
	}

	gemini_protocol_handler(client_tls, srv_dir);

end:
	SSL_shutdown(client_tls);
	SSL_free(client_tls);
	close(sock);
}

static int
create_server(uint16_t port)
{
	struct sockaddr_in6 addr;
	int sock;

	addr.sin6_family = AF_INET6;
	addr.sin6_port = htons(port);
	addr.sin6_addr = in6addr_any;

	sock = socket(AF_INET6, SOCK_STREAM, 0);
	if (sock < 0)
	{
		exit(EXIT_FAILURE);
	}

	setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &(int){1}, sizeof(int));

	if (bind(sock, (struct sockaddr *)&addr, sizeof(addr)) < 0)
	{
		exit(EXIT_FAILURE);
	}

	if (listen(sock, 5) < 0)
	{
		exit(EXIT_FAILURE);
	}

	return (sock);
}


int
server(const char *srv_dir, uint16_t port,
	const char *cert_file, const char *key_file)
{
	int server_sock;
	struct sockaddr_in6 addr;
	socklen_t addrlen;
	int client_sock;
	pid_t pid;
	SSL_CTX *ctx;

	ctx = create_tls_context(cert_file, key_file);
	server_sock = create_server(port);
	while (1)
	{
		client_sock = accept(server_sock, (struct sockaddr *)&addr, &addrlen);
		if (client_sock < 0)
		{
			printf("Can't accept");
			continue;
		}

		pid = fork();
		if (pid == 0)
		{
			close(server_sock);
			client_handler(client_sock, ctx, srv_dir);
			exit(0);
		}
		else if (pid > 0)
		{
			close(client_sock);
		}
		else
		{
			printf("can't fork");
		}
	}

	(void)ctx;

	return (0);
}
