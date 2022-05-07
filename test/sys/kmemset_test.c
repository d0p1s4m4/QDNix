#include <stdarg.h>
#include <stdlib.h>
#include <setjmp.h>
#include <stdint.h>
#include <string.h>
#include <cmocka.h>

#define BUFF_SIZE 16

void *kmemset(void *, int, size_t);

int
kmemset_setup(void **state)
{
	char *buff = malloc(sizeof(char) * BUFF_SIZE);
	if (buff == NULL)
	{
		return (-1);
	}

	memset(buff, 'o', BUFF_SIZE);
	*state = buff;
	return (0);
}

int
kmemset_teardown(void **state)
{
	free(*state);

	return (0);
}

void
kmemset_half_zero(void **state)
{
	const char res[BUFF_SIZE] = {
		0, 0, 0, 0, 0, 0, 0, 0, 'o', 'o', 'o', 'o', 'o', 'o', 'o', 'o'
	};
	char *buff;

	buff = *state;
	kmemset(buff, 0, BUFF_SIZE / 2);

	assert_memory_equal(buff, res, BUFF_SIZE);
}
