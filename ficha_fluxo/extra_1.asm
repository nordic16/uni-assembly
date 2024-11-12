section .data
    var1: dd 25
    var2: dd 42
    var3: dd -2 ; just to add some spice lol.

section .bss
    var4: resd 1

section .text
global main
main:
    mov rbp, rsp; for correct debugging
    ;write your code here
    xor rdx, rdx
    
    add rdx, [var1]
    add rdx, [var2]
    
    
    imul rdx, [var3]
    mov [var4], rdx


    
    mov rax, 60
    xor rdi, rdi
    syscall