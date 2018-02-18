mov ah,0x0e

mov al,[the_secret]
int 0x10;this doesn't work

mov bx,0x7c0 ;the segment is automatically <<4 
mov ds,bx ;we cannot use mov on ds

mov al,[the_secret]
int 0x10 ;not all memory refs will be offset by ds implicitly

mov al, [es:the_secret]
int 0x10

mov bx,0x7c0
mov es,bx
mov al,[es:the_secret]
int 0x10

jmp$

the_secret:
	db 'X'

times 510-($-$$) db 0
dw 0xaa55
