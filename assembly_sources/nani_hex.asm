; nani.asm
[bits 32]

            org 0x08048000

ehdr:
            db 0x7F, "ELF", 1, 1, 1, 0
    times 8 db  0
            dw  2
            dw  3
            dd  1
            dd  nani_main
            dd  phdr - $$
            dd  0
            dd  0
            dw  ehdrsize
            dw  phdrsize
            dw  1
            dw  0
            dw  0
            dw  0
ehdrsize    equ $ - ehdr

phdr:
            dd  1
            dd  0
            dd  $$
            dd  $$
            dd  filesize
            dd  filesize
            dd  5
            dd  0x1000
phdrsize    equ $ - phdr

filesize    equ $ - $$

nani_main:
    call gethex
    sal eax, 4
    push eax
    call gethex
    add [esp], eax
    call putchar
    pop eax
    jmp nani_main

putchar:
    xor ebx, ebx
    inc ebx
    lea ecx, [esp+4]
    mov edx, ebx
    mov eax, 4
    int 0x80
    ret

gethex:
    call getchar
    cmp eax, 35
    jne .convhex

.loop:
    call getchar
    cmp eax, 10
    jne .loop
    jmp gethex
    
.convhex:
    sub eax, 48
    jl gethex
    cmp eax, 48
    jl .ret
    sub eax, 39

.ret:
    ret

getchar:
    push 0
    xor ebx, ebx
    mov ecx, esp
    mov edx, ebx
    inc edx
    mov eax, 3
    int 0x80
    test eax, eax
    je exit
    pop eax
    ret

exit:
    xor eax, eax
    mov ebx, eax
    inc eax
    int 0x80

