;; for generic experiments.


section .text
global main
main:
    mov rbp, rsp; for correct debugging
    ;write your code here
    
    xor rbx, rbx

    mov eax, 12
    mov ebx, 4
    
    div ebx
    
    cmp edx, 0
    jne odd
    jmp end
    
    odd:
        mov ebx, 1
    
    end:
        mov rax, 60    
        xor rdi, rdi 
        syscall