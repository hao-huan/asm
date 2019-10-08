

mov ah, 0000_0000b
mov al, 0000_0100b
int 0001_0000b



call fun1


fun0:
 push bp
 mov bp,sp

 ; mov word [bp+6],0000_0000_0000_0000b
 ; push word 0000_0000_0000_0000b
 sub sp, 8

t:
mov ah,0000_1100b
mov al,0000_1111b
mov bh, 0000_0000b
mov cx, word [bp+6]
mov dx, 0000_0000_0000_0000b
int  0001_0000b
inc word [bp+6]
mov ah, 0000_1111b 
cmp byte [bp+6],ah
jne t  



 mov sp,bp
 pop ax
 pop bp 
ret


fun1:
  push bp
  mov bp,sp
  mov word [bp+6], 0000_0000_0000_0000b
t2:
  mov ax, word [bp+6]
  push ax 
  call fun0 
  inc word [bp+6]
  pop ax
  cmp ax,0000_0000_0000_1111b
  jne t2 
  mov sp,bp
  pop bp  
ret 
