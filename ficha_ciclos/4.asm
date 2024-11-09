section .rodata
    IMG_TAM: equ 1024

section .bss
    imagem: resd IMG_TAM

section .text
global main
main:
    mov rbp, rsp; for correct debugging
    ;write your code here
    xor rax, rax
    xor rcx, rcx
    
    _for:
        cmp rcx, IMG_TAM
        jb _cycle
        jmp _next
        
    _cycle:
        lea rdx, [imagem + 4*rcx] ; pass by reference.
        
        ; red
        xor byte [rdx + 1], 10000000b
        and byte [rdx + 1], 11111110b
        
        ; green
        or byte [rdx + 2], 10000000b
        and byte [rdx + 2], 11111110b
        
        ; blue
        and byte [rdx + 3], 01111111b
        or byte [rdx + 3], 00000001b
        
        inc rcx
        jmp _for
    
    _next:
        mov rax, 60
        xor rdi, rdi
        syscall