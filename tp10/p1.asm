section .text
global main
main:
    mov rbp, rsp; for correct debugging
    ;write your code here
    mov al, 0
    mov bl, 1
    add  al, bl ; 2
    adc  al, 2 ; 3. No carry, since al is 8 bits long 
    stc ; Sets carry flag to 1.
    adc  bl, al ; 3 (al) + 1 (bl) + 1 (carry flag) = 5.
    ret
