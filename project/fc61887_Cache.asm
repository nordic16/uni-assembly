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

_start:    
  mov rbp, rsp
  xor rcx, rcx

  ; discards argc and prog name.
  pop rbx
  pop rsi 

  ; since prog name is discarded, must deduct one from argc.
  dec rbx

  ; error in case not enough arguments are provided.
  cmp rbx, 0
  je error

  for:
    cmp rcx, rbx
    jb ciclo
    je fim
    
    ciclo: 
      mov rax, [rsp + 8*rcx]
      mov rdi, [rax] ; deref 
      call handle_addr

      push rcx
      ; prepares get_validation_bit call.
      mov rdi, r9
      call get_validation_bit

      cmp rax, 0
      je is_zero
      jmp not_zero

      is_zero:  
        ; note: rdi and rcx get changed after most function calls      
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
        jne not_equal
        jmp next

        ; in case tags don't match, set new tag.
        not_equal:
          mov rdi, r9
          mov rsi, r8 
          call set_tag
          jmp next

        next:
          call get_data_func
          jmp continue 
         

      continue:
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

; this only exists to make code less repetitive.
get_data_func:
  mov rdi, r9
  mov rsi, r10 
  call get_data
  call display_table
  ret

; handles each address accordingly.
handle_addr:
  xor r8, r8
  xor r9, r9
  xor r10, r10

  rol di, 8

  mov r8, rdi             ; tag.
  mov r9, rdi ; index
  mov r10, rdi ; offset

  shr r8, 6 ; clears lowest 8 bits.

  and r9, 111100b ; leaves only 2nd-6th bits.
  shr r9, 2

  and r10, 11b ; offset.  

  ret
