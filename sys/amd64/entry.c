
static void
hang(void)
{
	asm ("cli");
	while (1)
	{
		asm ("hlt");
	}
}

void
_entry()
{
	hang();
}