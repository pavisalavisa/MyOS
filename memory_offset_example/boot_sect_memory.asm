mov ah,0x0e

;attempt 1 
;fails because it tries to print pointer not it's contents

mov al, "1"
int 0x10
mov al, the_secret
int 0x10

;attempt 2
;tries to print the contents in memory adress of the secret 
;however BIOS places bootsectory binary at 0x7c00

mov al, "2"
int 0x10
mov al,[the_secret]
int 0x10

;attempt 3
;add the bios starting offset to the memory address of the X
;and dereference the contents of that pointer
;we are using bx register because mov al,[ax] is illegal
;because the register can't be used as source and destination for the same comma
mov al, "3"
int 0x10
mov bx,the_secret
add bx,0x7c00
mov al,[bx]
int 0x10

;attempt 4
;shortcut since we know x is stored at byte 0x2d in binary
;ineffective because we dont want to be recounting label offsets 
;everytime we change the code

mov al,"4"
int 0x10
mov al,[0x7c2d]
int 0x10

jmp$

the_secret:
	;ASCII code 0x58('X') is stored before the zero padding
	db "X"

times 510-($-$$) db 0
dw 0xaa55
