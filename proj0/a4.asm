
mov ah,0000_1110b
mov al,'a'
int 0001_0000b

mov ah, 0000_0000b
int 0001_0110b

mov ah, 0000_1110b
mov bl, 0000_0111b
int 0001_0000b

t:
 jmp t
