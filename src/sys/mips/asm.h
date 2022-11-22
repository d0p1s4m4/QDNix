#ifndef _MIPS_ASM_
# define _MIPS_ASM_ 1

# ifdef __ASSEMBLER__

/* coproc0 registers */

#  define C0_STATUS  $12, 0
#  define C0_INTCTL  $12, 1
#  define C0_CAUSE   $13, 0
#  define C0_EPC     $14, 0
#  define C0_PRID    $15, 0
#  define C0_EBASE   $15, 1
#  define C0_CONFIG  $16, 0
#  define C0_CONFIG1 $16, 1

# endif /* __ASSEMBLER__ */

#endif /* !_MIPS_ARCH_ */
