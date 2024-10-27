SECTION .data
    mem8: db 39
SECTION .text
global main
main:
    mov rbp, rsp; for correct debugging
    mov rax, 26
    inc rax
    add rax, 76
    add rax, [mem8]
    mov rbx, rax
    add rax, rbx
    nop
    mov rax, 60
    xor rdi, rdi
    syscall