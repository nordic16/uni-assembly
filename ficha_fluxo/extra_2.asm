section .data
    text: dd "1",10  
    
section .bss
    y: resb 1

section .text
global main
main:
    mov rbp, rsp; for correct debugging
    
    mov eax, [text]
    xor eax, 00110000b
    mov [y], eax

    mov rax, 60    
    xor rdi, rdi
    syscall