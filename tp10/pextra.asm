section .rodata
    var: db 25
    var2: db -25

section .text
global main
main:
    mov rbp, rsp; for correct debugging
    xor rax, rax
    
    mov rax, [var]
    mov rbx, [var2]
    neg rax ; Negates num.
    
    cmp rax, rbx
    je equal
    
    equal:
        mov rcx, 1
        
    ret
