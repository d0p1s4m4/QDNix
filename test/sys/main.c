#include <stdarg.h>
#include <stddef.h>
#include <setjmp.h>
#include <stdint.h>
#include <cmocka.h>
#include "test.h"

static const struct CMUnitTest sys_test[] = {
	cmocka_unit_test_setup_teardown(kmemset_half_zero, kmemset_setup, kmemset_teardown),
};

int
main(void)
{
	return (cmocka_run_group_tests_name("sys", sys_test, NULL, NULL));
}
