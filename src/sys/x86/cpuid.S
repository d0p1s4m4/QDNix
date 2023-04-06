.section .data

.globl cpu_has_cpuid
cpu_has_cpuid: .long 0

.globl cpu_level_max
cpu_level_max: .long 0

.globl cpu_vendor_id
cpu_vendor_id: .space 16

.globl cpu_id
cpu_id: .long 0

.globl cpu_misc
cpu_misc: .long 0

.globl cpu_feature_edx
cpu_feature_edx: .long 0

.globl cpu_feature_ecx
cpu_feature_ecx: .long 0

.section .text

cpuid_check_cpuid:
	pushf
	pushf
	xorl $0x200000, (%esp)
	popf
	pushf
	pop %eax
	xorl %eax, (%esp)
	popf
	andl $0x200000, %eax
	ret

.globl cpuid_identify
cpuid_identify:
	call cpuid_check_cpuid
	movl %eax, (cpu_has_cpuid)
	test %eax, %eax
	je .no_cpuid

	xor %eax, %eax
	cpuid
	movl %eax, (cpu_level_max)
	movl %ebx, (cpu_vendor_id)
	movl %edx, (cpu_vendor_id)+4
	movl %ecx, (cpu_vendor_id)+8
	movl $0, (cpu_vendor_id)+12

	movl $1, %eax
	cpuid
	movl %eax, (cpu_id)
	movl %ebx, (cpu_misc)
	movl %edx, (cpu_feature_edx)
	movl %ecx, (cpu_feature_ecx)

.no_cpu_id:
	ret
