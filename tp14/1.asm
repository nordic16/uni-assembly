section .rodata
    var1: dq "hello",10
    var2: dq "world",10

section .text
global main
main:
    mov rbp, rsp; for correct debugging
    ;write your code here
    xor rax, rax
    
    ; performs exchange...
    push qword [var1]
    push qword [var2]
    
    pop qword [var1]
    pop qword [var2]
    
    ret