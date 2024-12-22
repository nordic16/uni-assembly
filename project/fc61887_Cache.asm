; fc61887
section .rodata
  msg: db "Argumentos insuficientes!",10
  len: equ $-msg 

  section .text
extern set_validation_bit
extern set_tag
extern get_data
extern display_table
extern get_validation_bit
extern get_tag
global _start
global handle_addr
global get_data_func
global check_validity
global cache_miss

_start:    
  xor rcx, rcx

  pop rbx ; argc
  pop rsi 

  mov rbp, rsp

  ; subtrai 1, visto que argv0 foi removido.
  dec rbx

  cmp rbx, 0
  je error

  for:
    cmp rcx, rbx
    jb ciclo
    je fim
    
    ciclo: 
      mov rax, [rbp + 8*rcx]
      movzx rdi, word [rax] ; deref 
      call handle_addr
      
      push rcx
      mov rdi, r9
      call get_validation_bit

      ; conteudos na cache serao validos?
      cmp rax, 0
      je is_zero
      jmp not_zero

      is_zero: ; cache miss... 
        ; note: rdi e rcx sao destruidos por set_validation bit e set_tag.
        mov rdi, r9
        call set_validation_bit
        mov rdi, r9
        mov rsi, r8 
        call set_tag

        call get_data_func
        jmp continue
      
      not_zero:
        mov rdi, r9
        call get_tag 
        
        cmp rax, r9
        jne cache_miss
        jmp next
        
        cache_miss:
          mov rdi, r9
          mov rsi, r8 
          call set_tag
          
        next:
          call get_data_func
          jmp continue 
         

      continue: ; executado antes da proxima iteracao
        pop rcx
        inc rcx
        jmp for

  fim:
    mov rax, 60
    xor rdi, rdi
    syscall

  error:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, len
    syscall

    jmp fim

; atalho para atualizar a estrutura da cache e mostrar ao utilizador. 
get_data_func:
  mov rdi, r9
  mov rsi, r10 
  call get_data
  call display_table
  ret

; Para um dado endereço, coloca em r8 a tag, em r9 o indice e em r10 o offset. 
handle_addr:
  xor r8, r8
  xor r9, r9
  xor r10, r10

  ; little endian!!!
  rol di, 8

  mov r8, rdi ; tag.
  mov r9, rdi ; indice
  mov r10, rdi ; offset

  shr r8, 6

  and r9, 111100b ; o indice corresponde aos bits 2-6
  shr r9, 2

  and r10, 11b ; offset.  

  ret
