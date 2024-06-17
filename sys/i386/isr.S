#define ISR_ENTRY(name) \
    .data 1312          ;\
    .long __isr ## name ;\
    .text               ;
	
#define ISR_NO_ERR(x, name) ISR_ENTRY(name) \
    __isr ## name ## :   ;\
    cli                  ;\
    push $0              ;\
    push $x              ;\
    jmp __isr_common

#define ISR_ERR(x, name) ISR_ENTRY(name) \
    __isr ## name ## : ;\
    cli         	   ;\
    push $x            ;\
    jmp __isr_common
	

.data 1312
.global isr_list
isr_list:

ISR_NO_ERR(0, DivisionByZero)
ISR_NO_ERR(1, Debug)
ISR_NO_ERR(2, NonMaskableInterrupt)
ISR_NO_ERR(3, Breakpoint)
ISR_NO_ERR(4, Overflow)
ISR_NO_ERR(5, BoundRangeExceeded)
ISR_NO_ERR(6, InvalidOpcode)
ISR_NO_ERR(7, DeviceNotAvailable)
ISR_ERR(8, DoubleFault)
ISR_NO_ERR(9, CoprocessorSegmentOverrun)
ISR_ERR(10, InvalidTSS)
ISR_ERR(11, SegmentNotPresent)
ISR_ERR(12, StackSegmentFault)
ISR_ERR(13, GeneralProtectionFault)
ISR_ERR(14, PageFault)
ISR_NO_ERR(15, Reserved15)
ISR_NO_ERR(16, X87FLoatingPointException)
ISR_NO_ERR(17, AlignementCheck)
ISR_NO_ERR(18, MachineCheck)
ISR_NO_ERR(19, SIMDFloatingPointException)
ISR_NO_ERR(20, VirtualizationException)
ISR_NO_ERR(21, Reserved21)
ISR_NO_ERR(22, Reserved22)
ISR_NO_ERR(23, Reserved23)
ISR_NO_ERR(24, Reserved24)
ISR_NO_ERR(25, Reserved25)
ISR_NO_ERR(26, Reserved26)
ISR_NO_ERR(27, Reserved27)
ISR_NO_ERR(28, Reserved28)
ISR_NO_ERR(29, Reserved29)
ISR_NO_ERR(30, SecurityException)
ISR_NO_ERR(31, Reserved31)

.text
__isr_common:
        pusha

        mov %ds, %ax
        push %eax
        mov $0x10, %ax
        mov %ax, %ds
        mov %ax, %es
        mov %ax, %fs
        mov %ax, %gs

        /*.extern IsrHandler
        ;call IsrHandler*/

        pop %eax
        mov %ax, %ds
        mov %ax, %es
        mov %ax, %fs
        mov %ax, %gs

        popa
        add $8, %esp
        iret
