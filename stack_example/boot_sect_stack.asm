;bp stores bottom address of the stack
;sp stores top of the stack
;stack grows downwards (sp gets decremented)

mov ah,0x0e; tty mode

mov bp,0x8000 ;address far away from 0x7c00 so that we dont get overwritten
mov sp,bp ;stack is empty

push 'A'
push 'B'
push 'C'

;to show how stack grows
mov al,[0x7ffe];0x8000-0x0002
int 0x10

;trying to access 0x8000
mov al,[0x8000]
int 0x10

;trying to access 0x7ffff
mov al,[0x7ffff]
int 0x10

;pop returns full words but we only need lower byte

pop bx
mov al,bl
int 0x10;prints C

pop bx 
mov al,bl
int 0x10;prints B

pop bx
mov al,bl
int 0x10;prints A

mov al,[0x8000]
int 0x10;data that has been pop'd from stack is garbage now

jmp$

times 510-($-$$) db 0
dw 0xaa55

