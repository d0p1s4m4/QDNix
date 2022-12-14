#ifndef _PDP11_ASM_
# define _PDP11_ASM_ 1

# ifdef __ASSEMBLER__

/* 
 * Control registers
 * (https://gunkies.org/wiki/PDP-11_Memory_Management)
 */
#  define MMR0 0177572
#  define MMR1 0177574
#  define MMR2 0177576
#  define MMR3 0177516

# endif /* __ASSEMBLER__ */

#endif /* !_PDP11_ARCH_ */
