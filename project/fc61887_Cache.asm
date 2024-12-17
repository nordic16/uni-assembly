%include "linux64.inc"

section .text
extern set_validation_bit
extern set_tag
extern get_data
extern display_table
extern get_validation_bit
extern get_tag
global _start
global handle_addr
_start:    
  mov rbp, rsp

  xor rcx, rcx

  ; discards argc and prog name.
  pop rbx
  pop rsi 

  ; since prog name is discarded, must deduct one from argc.
  dec rbx

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

        jmp continue
      
      not_zero:
        ; ....

      continue:
        pop rcx
        inc rcx
        jmp for

fim:
  call display_table
  mov rax, 60
  xor rdi, rdi
  syscall

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
