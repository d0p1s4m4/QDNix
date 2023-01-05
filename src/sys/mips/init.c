#include <sys/machine/mmio.h>
#include "arch.h"
#include <stdarg.h>
#include <stddef.h>
#include <libkern/printk.h>

void
arch_init(int argc, char **argv, char **envp, uintptr_t memsize)
{
	int idx;

	printk("QDNX hello\n");

	printk("serial initialized\n");
	printk("cmdline:\n");
	for (idx = 0; idx < argc; idx++)
	{
		printk("\t%d: %s\n", idx, argv[idx]);
	}

	printk("env:\n");
	for (; *envp != NULL; envp++)
	{
		printk("\t%s\n", *envp);
	}

	printk("memsize: %u\n", memsize);
	return;
}
