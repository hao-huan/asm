
mov ah,0000_0000b
mov al,0000_0100b 
int 0001_0000b

mov ah,0000_1011b
mov bh,0000_0001b 
mov bl,0000_0011b 
int 0001_0000b


mov cx,0000_0000_0000_1111b
mov ax,0000_0000_0000_0000b
mov bx,0000_0000_0000_0000b



;t:
;push ax
;push bx
;push cx
;call draw_diagonal_lines
;pop cx
;pop bx
;pop ax 
;inc ax
;inc bx
;loop t


call draw_boxes


; draw diagonal line 
draw_diagonal_lines:
push bp
mov bp, sp

mov ah,0000_1100b
mov al,0000_1111b
mov bh,0000_0000b
mov cx,[bp+6]
mov dx,[bp+8]

int 0001_0000b
mov sp, bp
pop bp
ret



; draw horizontal 
vdraw_horizontal:
push bp
mov bp, sp

mov ah, 0000_1100b
mov al, 0000_1111b
mov bh, 0000_0000b 
mov cx,[bp+6]
mov dx,[bp+8]
int 0001_0000b

mov sp, bp
pop bp 
ret 


draw_boxes:
  push bp
  mov bp,sp


mov cx, 0000_0000_0000_1111b 
mov ax, 0000_0000_0000_0000b
mov bx, 0000_0000_0000_0000b 



a: db  0000_0000b, 0000_0000b
;mov ax,a


t0:
 push ax
 push bx
 push cx
 call vdraw_horizontal
 pop cx
 pop bx
 pop ax 
 inc bx 
 loop t0



  mov sp,bp
  pop bp
ret 
