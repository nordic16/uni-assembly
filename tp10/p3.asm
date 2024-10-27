section .text
global main
main:
    ;write your code here
    xor rax, rax
    mov al, 1
    or al, 10101 ;; gets 21.
    
    ret