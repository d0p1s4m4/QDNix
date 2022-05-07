mov rdi, 1
mov rsi, msg
mov rdx, size
mov rax, 1
syscall

mov rdi, 0
mov rax, 60
syscall
