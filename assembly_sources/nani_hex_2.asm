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
            dd  0x08048000
            dd  0x08048000
            dd  244h
            dd  244h
            dd  7
            dd  1000h
phdrsize    equ $ - phdr

filesize    equ $ - $$

; https://cs.lmu.edu/~ray/notes/x86assembly/
times 40h dd 0
times 3 db 0

pos:
    push    dword 0x08048054

label:
    push    dword 0x08048058

getchar:
    push    0
    xor     ebx,ebx
    mov     ecx,esp
    inc     edx
    mov     eax,3
    int     80h
    test    eax,eax
    je      exit
    pop     eax
    ret

exit:
    xor     eax,eax
    mov     ebx,eax
    inc     eax
    int     80h

gethex:
    call    getchar
    cmp     eax,20h
    jle     gethex
    cmp     eax,23h
    jne     .l1

.loop:
    call    getchar
    cmp     eax,0Ah
    jne     .loop
    jmp     gethex

.l1:
    cmp     eax,2Eh
    jne     .l2
    call    getchar
    and     eax,0FFh
    add     eax,label
    mov     ebx,[eax]
    mov     eax,pos
    mov     [eax],ebx
    jmp     gethex

.l2:
    cmp     eax,30h
    jl      .l3
    cmp     eax,3Ah
    jge     .l3
    sub     eax,30h
    ret

.l3:
    cmp     eax,61h
    jl      .l4
    cmp     eax,67h
    jge     .l4
    sub     eax,57h
    ret

.l4:
    and     eax,0FFh
    add     eax,label
    mov     ebx,[eax]
    mov     eax, dword [pos]
    add     eax,4
    mov     dword [pos], eax
    sub     ebx,eax
    mov     eax,ebx
    push    eax
    call    putchar
    pop     eax
    sar     eax,8
    call    putchar
    pop     eax
    sar     eax,10h
    push    eax
    call    putchar
    pop     eax
    sar     eax,18h
    push    eax
    call    putchar
    pop     eax
    jmp     gethex

putchar:
    xor     ebx,ebx
    inc     ebx
    lea     ecx,[esp+4]
    mov     edx,ebx
    mov     eax,4
    int     80h
    ret

nani_main:
    call    gethex
    shl     eax,4
    push    eax
    call    gethex
    add     [esp+4-4],eax
    inc     dword [pos]
    call    putchar
    pop     eax
    jmp     nani_main
    