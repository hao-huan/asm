org 0x7c00

mov dx,0x1f2
mov al,0x01
out dx,al


mov dx, 0x1f3
mov al, 0x01
out dx, al ; 7-0


inc dx
mov al,0x00
out dx,al ; 15-8

inc dx
out dx,al ; 23-16

inc dx
mov al,0xe0  ; 27-24
out dx, al


mov dx, 0x1f7
mov al, 0x20  ; read command 
out dx, al   ; 



waits:
 in al, dx
 and al,0x88
 cmp al,0x08
 jnz waits 
 


mov cx,256
mov dx,0x1f0
mov ax,0x1000 
mov ds,ax 
.readw:
   in ax,dx
   mov [bx],ax
   add bx,2
   loop .readw 

nop
nop
nop
nop 
jmp 0x1000:0 

times 510-($-$$) db 0
db 0x55, 0xaa
