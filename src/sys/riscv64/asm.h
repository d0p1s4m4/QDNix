#ifndef _SYS_RISCV64_ASM_H
# define _SYS_RISCV64_ASM_H 1

# if CONFIG_M_MODE
#  define CSR_STATUS        mstatus
#  define CSR_STATUS_REG_IE 0x8

#  define CSR_IE            mie
#  define CSR_IP            mip
#  define CSR_TVEC          mtvec

# define IRET               mret
# else
#  define CSR_STATUS        sstatus
#  define CSR_STATUS_REG_IE 0x2

#  define CSR_IE            sie
#  define CSR_IP            sip
#  define CSR_TVEC          stvec

#  define IRET              sret
# endif /* !CONFIG_M_MODE */

#endif /* !_SYS_RISCV64_ASM_H */
