%macro sys_write 2 ; basically a function with two arguments
    mov eax, 1 ; sys_write
    mov edi, 1 ; stdout
    mov esi, %1 ; value to write (first arg)
    mov edx, %2 ; len (second arg)
    syscall
%endmacro

section .rodata
    msg: db "Hello world",10
    len: equ $-msg

section .text
global main
main:
    mov rbp, rsp; for correct debugging
    xor rax, rax
    
    ; calls sys_write macro with msg and len as args.
    ; quick note: in order to properly perform a sys_write, one must transfer not the value to esi but rather its address.
    sys_write msg, len
    sys_write msg, 5
    
    ret