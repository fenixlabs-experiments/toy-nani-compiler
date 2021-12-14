#!/usr/bin/env bash

# nasm -f elf nani.asm
# # gcc -m32 -Wall -s nani.o -o nani
# # gcc -m32 -Wall -s -nostartfiles nani.o -o nani
# gcc -m32 -Wall -s -nostdlib nani.o -o nani

# nasm nani.asm -f bin -l assembly_list/nani_0.lst

# gcc -S -O -fverbose-asm nani_hex.c -o nani_hex.s -nostdlib -nostartfiles
# as -alhnd nani_hex.s > nani_hex.lst

sed 's/#.*//' nani.he | xxd -r -ps > nani_
./nani_ < nani_hex.he > nani_2 && chmod +x nani_2
