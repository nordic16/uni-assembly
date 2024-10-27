section .text
global main
main:
    xor rax, rax
    mov al, 2
    
    shl al, 2 ;; 2³ = 8
    
    ret