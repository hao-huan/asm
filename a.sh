#!/bin/bash
#echo $1
nasm -f elf64 a.asm
gcc a.o -o $1
objdump -d $1 > $1.txt
