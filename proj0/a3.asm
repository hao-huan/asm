


mov ah, 0000_0000b
mov al, 0000_0100b
int 0001_0000b

;push 0000_0000_0000_0001b
;call draw_hori 
call draw_square 
jmp end


draw_hori:
 push bp
 mov bp,sp
 sub sp,0000_1000b
 mov word [bp-0000_0010b], 0000_0000_0000_0000b

draw_hori_label0: 
mov ah, 0000_1100b
mov al, 0000_1110b
mov bl, 0000_0000b
mov cx, word [bp-0000_0010b]
mov dx, word [bp+ 0000_0100b]
int 0001_0000b
inc word [bp-0000_0010b]
cmp word [bp-0000_0010b], 0000_0000_0000_1111b
jne draw_hori_label0

 mov sp,bp
 pop bp 
ret


end:
  nop
  jmp end 


draw_square:
  push bp
  mov bp,sp
  sub sp,8 


  mov word [bp-2], 0000_0000_0000_0000b   
 draw_square_label0:
  push word [bp-2]
  call draw_hori
  inc word [bp-2]
  cmp word [bp-2], 0000_0000_0000_1111b 
  jne draw_square_label0 
 
  mov sp,bp
  pop bp 
ret 
