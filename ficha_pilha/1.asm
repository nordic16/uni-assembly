section .bss
    s_pares: resq 1
    s_impares: resq 1
section .text
global _start
_start:
    ; criar espaço na pilha para vetor como variável local
    mov rbp, rsp
    ; sub rsp, 16
    sub rsp, 24 ; c) (20 bytes + 4 padding)
    ; gerar números aleatórios e guardá-los no vetor
    mov rax, 318 ; sys_getrandom
    mov rdi, rsp ; armazenar valores no vetor
    ; mov rsi, 16 
    mov rsi, 20 ; c) vetor com 20 bytes
    mov rdx, 0 ; flags para a operação

_x: syscall
    xor rcx, rcx
    xor rax, rax
        
_for:
    ; cmp rcx, 16
    cmp rcx, 20 ; c
    jbe _ciclo
    jmp _fim    

_ciclo:
    mov ax, [rsp + rcx]
    inc rcx
    ; testar o último bit (será impar caso esteja ativo).
    test ax, 00000001b
    jz _par
    jmp _impar
    
    _par:
        add [s_pares], ax
        jmp _for
    
    _impar:
        add [s_impares], ax
        jmp _for
       
_fim:
    ; b)
    ; add rsp, 16
    add rsp, 24 ; c)
    mov rax, 60 ; sys_exit
    xor rdi, rdi
    syscall