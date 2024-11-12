section .data
    X: dw 4
    N: db 127

section .text
global _start
_start:
    xor rax, rax
    xor rdx, rdx
    
    mov edx, [X]
    mov cl, [N]
    
    shl edx, cl
    
    mov [X], edx
    
    cmp edx, 0
    je zero
    jmp end
    
    zero:
        mov rax, -1

    end:
        mov rax, 60
        xor rdi, rdi
        syscall