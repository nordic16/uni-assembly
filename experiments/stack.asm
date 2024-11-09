section .text
global main
main:
    mov rbp, rsp; for correct debugging
    ;write your code here
    xor rax, rax
    
    sub rsp, 16
    
    ret