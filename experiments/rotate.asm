
section .rodata
  num: db 16

section .text
global main

main:
    mov ebp, esp; for correct debugging
    xor ebx, ebx
    mov ebp, esp; for correct debugging
    mov ebx, [num]
    rol eax, 1

    ret