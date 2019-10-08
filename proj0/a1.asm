



jmp code 



section .data:
a0 db 0000_0000b, 0000_0001b, 0000_0010b


code:


mov ah,0000_0000b
mov al,0000_0100b
int 0001_0000b

mov cx,0000_0000_0000_1111b 
t:
mov ax, a0
mov bx,cs
mov ds,bx
mov bx,ax
mov al, byte [bx]
push ax
push cx
call fun0
pop cx
pop ax
inc byte [bx]
loop t 


jmp code0



fun0:
 push bp
 mov bp,sp

mov ah,0000_1100b
mov al,0000_1111b
mov bh,0000_0000b 
mov cx,[bp+6]
mov dx,0000_1111b
int 0001_0000b


 mov sp,bp
 pop bp  
ret

code0:
 mov ah,0000_0000b
 mov ah,0000_0001b
