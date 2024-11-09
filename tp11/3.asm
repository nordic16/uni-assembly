section .data
    vet: dd 1,2,3,4

section .text
global main
main:
    mov rbp, rsp; for correct debugging
    ;write your code here
    xor rax, rax
    mov ebx, vet
    ; ebx serves as base register. Out of bounds exception will be thrown if num is too high.
    mov eax,[ebx + 8]
    ret