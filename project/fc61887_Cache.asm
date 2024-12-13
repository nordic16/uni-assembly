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

  xor rax, rax
  xor rcx, rcx

  ; discards argc and prog name.
  pop rbx
  ; pop rsi 
   
  ; since prog name is discarded, must deduct one from argc.
  dec rbx

  for:
    cmp rcx, rbx
    jb ciclo
    jmp next

  ciclo:
    pop rdi
    printVal rdi
    call handle_addr
    inc rcx
    jmp for

  next:
    ;; call display_table
 
fim:
  mov rax, 60
  xor rdi, rdi
  syscall


; handles each address accordingly.
handle_addr:
  xor r8, r8
  xor r9, r9
  xor r10, r10

  mov r8, rdi             ; tag.
  mov r9, rdi ; index
  mov r10, rdi ; offset

  shr r8, 6 ; clears lowest 8 bits.
  and r9, 111100b ; leaves only 2nd-6th bits.
  and r10, 11b ; offset.  

  ret
