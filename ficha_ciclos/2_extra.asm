section .rodata
    eo: db 10101010b
    oe: db 01010101b
    ns: db 11001100b
    sn: db 00110011b
    
    ; since there will only be 4 iterations until all cars have passed.
    ; CHANGE 1: ITERATIONS ARE NOW 8 INSTEAD OF 4.
    MAX_ITERATIONS: equ 8

section .text
global main
main:
    mov rbp, rsp; for correct debugging
    ; will be used as a counter later.
    xor r8, r8
    
    ; CHANGE 2: different registers.
    mov r9b, [oe]
    mov r10b, [eo]
    mov r11b, [sn]
    mov r12b, [ns]
    
    for:
        cmp r8, MAX_ITERATIONS
        jb _cycle
        jmp _end
        
    _cycle:
        ; CHANGE 3: SHIFT BY 1 INSTEAD OF 2
        shl r9w, 1 
        shr r10w, 1
        shl r11w, 1
        shr r12w, 1
        
        inc r8
        jmp for
    
    _end:
        mov rax, 60
        xor rdi, rdi
        syscall