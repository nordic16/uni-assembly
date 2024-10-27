section .text
global main
main:
    ;write your code here
    mov al, 5
    mov bl, -4
    
    imul bl ; al = al * bl [reads imul WITH bl].
    ret