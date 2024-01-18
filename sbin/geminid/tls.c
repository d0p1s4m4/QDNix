/** 
 * \file tls.c
 * \brief All TLS related function.
 */
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

static int
servername_callback(SSL *ssl, int *a, void *b)
{
	return (SSL_TLSEXT_ERR_OK);
}

SSL_CTX *
create_tls_context(const char *cert_file, const char *key_file)
{
	const SSL_METHOD *method;
	SSL_CTX *ctx;

	method = TLS_server_method();

	ctx = SSL_CTX_new(method);
	if (ctx == NULL)
	{
		ERR_print_errors_fp(stderr);
		exit(EXIT_FAILURE);
	}

	/* from gemini spec: Servers MUST use TLS version 1.2 or higher and SHOULD 
	 * use TLS version 1.3 or higher.*/
	SSL_CTX_set_min_proto_version(ctx, TLS1_2_VERSION);

	if (SSL_CTX_use_certificate_file(ctx, cert_file, SSL_FILETYPE_PEM) <= 0)
	{
		ERR_print_errors_fp(stderr);
		exit(EXIT_FAILURE);
	}

	if (SSL_CTX_use_PrivateKey_file(ctx, key_file, SSL_FILETYPE_PEM) <= 0)
	{
		ERR_print_errors_fp(stderr);
		exit(EXIT_FAILURE);
	}

	SSL_CTX_set_tlsext_servername_callback(ctx, servername_callback);

	return (ctx);
}

void
tls_init(void)
{
	SSL_load_error_strings();
	SSL_library_init();
}
