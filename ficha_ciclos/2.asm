section .rodata
    eo: db 10101010b
    oe: db 01010101b
    ns: db 11001100b
    sn: db 00110011b
    
    ; since there will only be 4 iterations until all cars have passed.
    MAX_ITERATIONS: equ 4

section .text
global main
main:
    mov rbp, rsp; for correct debugging
    ; will be used as a counter later.
    xor r8, r8
    
    mov ah, [oe]
    mov bl, [eo]
    mov ch, [sn]
    mov dl, [ns]
    
    for:
        cmp r8, MAX_ITERATIONS
        jb _cycle
        jmp _end
        
    _cycle:
        shl dx, 2
        shr cx, 2
        shl bx, 2
        shr ax, 2
        
        inc r8
        jmp for
    
    _end:
        mov rax, 60
        xor rdi, rdi
        syscall