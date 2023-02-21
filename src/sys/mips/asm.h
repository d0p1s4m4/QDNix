#ifndef _MIPS_ASM_
# define _MIPS_ASM_ 1

# include "arch.h"

# ifdef __ASSEMBLER__

/* coproc0 registers */

#  define C0_INDEX     $0, 0
#  define C0_ENTRYLO_0 $2, 0
#  define C0_ENTRYLO_1 $3, 0
#  define C0_CONTEXT   $4, 0
#  define C0_PAGEMASK  $5, 0
#  define C0_WIRED     $6, 0
#  define C0_ENTRYHI   $10, 0

#  define C0_STATUS    $12, 0
#  define C0_INTCTL    $12, 1
#  define C0_CAUSE     $13, 0
#  define C0_EPC       $14, 0
#  define C0_PRID      $15, 0
#  define C0_EBASE     $15, 1
#  define C0_CONFIG    $16, 0
#  define C0_CONFIG1   $16, 1
#  define C0_CONFIG2   $16, 2
#  define C0_CONFIG3   $16, 3
#  define C0_CONFIG4   $16, 4

# endif /* __ASSEMBLER__ */

#endif /* !_MIPS_ARCH_ */
