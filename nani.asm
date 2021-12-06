; nani.asm
[bits 32]

global nani_main
section .text
nani_main:
    mov eax, 1
    int 0x80