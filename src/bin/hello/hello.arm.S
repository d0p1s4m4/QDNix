/* write(2) */
mov %r0, $1
ldr %r1, =msg
ldr %r2, =len
mov %r7, $21
swi $0

/* exit(2) */
mov %r0, $0
mov %r7, $5
swi $0
