#ifndef QDNIX_GEMINID_H
# define QDNIX_GEMINID_H 1

# include <stdint.h>
# include <openssl/ssl.h>

# ifndef GEMINID_VERSION
#  define GEMINID_VERSION "1.0"
# endif /* !GEMINID_VERSION */

# define MAX_CLIENTS 15
# define MAX_BUFFER 1024

SSL_CTX *create_tls_context(const char *cert_file, const char *key_file);
void tls_init(void);

int server(const char *srv_dir, uint16_t port,
	const char *cert_file, const char *key_file);
void gemini_protocol_handler(SSL *client, const char *srv_dir);

#endif /* !QDNIX_GEMINID_H */
