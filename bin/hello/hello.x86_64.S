movq $1, %rdi
movq $msg, %rsi
movq $size, %rdx
movq $1, %rax
syscall

mov $0, %rdi
mov $60, %rax
syscall
