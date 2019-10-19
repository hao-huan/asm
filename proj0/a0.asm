
jmp start

gdt_beg:
  desc_sg_null dd 0000_0000_0000_0000_0000_0000_0000_0000b, 0000_0000_0000_0000_0000_0000_0000_0000b
  desc_sg_code dd 0000_0000_0000_0000_0000_0001_1111_1111b, 0000_0000_0100_0000_1001_1010_0000_0001b ; TYPE=1010,代码段必须可读，否则msg中的内容是无法读出并写到显卡中的
  ;desc_sg_code dd 0111_1100_0000_0000_0000_0001_1111_1111b, 0000_0000_0100_0000_1001_1010_0000_0000b ; TYPE=1010,代码段必须可读，否则msg中的内容是无法读出并写到显卡中的

  desc_sg_video dd 1000_0000_0000_0000_1111_1111_1111_1111b, 0000_0000_0100_0000_1001_0010_0000_1011b

  desc_sg_stack dd 0000_0000_0000_0000_0111_1010_0000_0000b, 0000_0000_0100_0000_1001_0110_0000_0000b
gdt_end:


; 段选择子
  slct_null   equ   desc_sg_null -  gdt_beg
  slct_code   equ   desc_sg_code - gdt_beg
  slct_video  equ   desc_sg_video - gdt_beg
  slct_stack  equ   desc_sg_stack - gdt_beg


;;; gdt 总共多少个双字
gdt_size_dword  equ  (gdt_end-gdt_beg) / 4


gdtr:
gdt_bound dw  gdt_end - gdt_beg - 1 ; 
gdt_base dd 0111_1110_0000_0000b ;

port_fast_a20  equ  1001_0010b
gate_alt_a20  equ  0000_0010b
gate_pe equ  0000_0001b


start: 
  mov ax, cs
  mov ss, ax
  mov sp, 0111_1100_0000_0000b
  
  mov ax, cs
  mov ds, ax
  mov si, gdt_beg
  

  mov ax, [cs: gdt_base]
  mov dx, [cs: gdt_base+2]
  mov bx, 16
  div bx
  mov es, ax
  mov di, 0
  

  mov cx, gdt_size_dword
  cld 
  rep  movsd
  
  lgdt [cs: gdtr]
  
  in al, port_fast_a20
  or al, gate_alt_a20
  out port_fast_a20, al
  
  cli
  mov eax, cr0
  or eax, gate_pe
  mov cr0, eax
  
  ;jmp 0000_1000b:0000_0000b
  ;jmp dword slct_code:(pm32_start - 0x7c00)
   jmp dword slct_code:pm32_start

 msg  db 'Already in protect mode...'
 len_msg equ $-msg
  [bits 32]

pm32_start:
  mov eax, slct_video
  mov ds, eax
  
 ;mov ebx, msg-0x10000 -- ;;;
  xor ebx,ebx
  mov ebx, msg
 mov esi, 0
 mov edi, 0

.lp: 
  mov al, [cs: ebx+esi]
  mov [edi], al
  inc esi
  add edi, 2
  loop .lp

  mov eax, slct_stack
  mov ss, eax
  mov esp, 0x7c00
  mov ebp, esp
  
  push byte '!'
  sub ebp, 4
  cmp ebp, esp
  jne .tail
  pop eax
  mov [0x1A], al
  mov byte [0x1C], ' '
  
.tail: jmp $
  
 
