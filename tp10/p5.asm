section .data
    a: dd 1

section .text
global main

main:
  mov rbp, rsp; for correct debugging
  mov rax, [a]
  cmp rax, 0
  jge fim ;; jge and NOT jg.
  mov dword [a], 0

fim:
  mov rax, 60

  xor rdi, rdi

  syscall

