section .text
global main
main:
    mov rbp, rsp; for correct debugging
    mov rcx, 0
    
    for:
    ;; increment is 2, therefore rcx must be smaller or equal to 10.
      cmp rcx, 10
      jne ciclo
      jmp fim
    
    ciclo:
      add rcx, 2
      jmp for
    
     fim:
      mov rax, 60
      xor rdi, rdi
    
      syscall
