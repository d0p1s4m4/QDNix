SYS_TEST_SRCS		= $(wildcard test/sys/*.c)
SYS_TEST_KERN_SRCS	= $(wildcard src/sys/libkern/*.c)
SYS_TEST_OBJS	= $(SYS_TEST_SRCS:.c=.o) \
					 $(patsubst src/sys/%.c, test/sys/%.o, $(SYS_TEST_KERN_SRCS))

TESTS_TARGET += test/sys_test.run

GARBADGE += $(SYS_TEST_OBJS) $(SYS_TEST_OBJS:.o=.gcda) \
			$(SYS_TEST_OBJS:.o=.gcno) $(TESTS_TARGET)

test/sys_test.run: $(SYS_TEST_OBJS)
	$(CC) -o $@ $^ $(TESTS_LDFLAGS)
	./$@


test/%.o: src/%.c
	@ mkdir -p $(dir $@)
	$(CC) -o $@ -c $< $(TESTS_CFLAGS)

test/%.o: test/%.c
	$(CC) -o $@ -c $< $(TESTS_CFLAGS)

.PHONY: test
test: $(TESTS_TARGET)
