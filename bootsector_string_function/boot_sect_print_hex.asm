;receiving data in dx register 

print_hex:
	pusha
	mov cx,0 ;index var

;Get the alst cahr of dx then convert to ASCII
;Numeric ASCII values: 0x30- 0x39
;Alpha chars A-F 0x41-0x46
;move ASCII byte to the correct position on the resulting string

hex_loop:
	cmp cx,4 ; for(cx=0;cx<4;cx++)
	je end
	
	;convert last char of dx to ascii
	mov ax,dx
	and ax,0x000f ; masking first three values
	add al,0x30
	cmp al,0x39 ;if (al>0x39) it's an alpha char
	jle step2
	add al,7;A is ASCII 65 instead of 58

step2:
	;get the correct position of the string to place ASCII char
	;bx <- base address+strlen - index of char
	mov bx,HEX_OUT+5;base+len
	sub bx,cx ;index var
	mov [bx],al
	ror dx,4

	add cx,1
	jmp hex_loop

end:
	mov bx,HEX_OUT
	call print

	popa
	ret

HEX_OUT:
	db '0x0000',0 ;reserve memory for strin
	
	;convert last char of dx to ascii
	mov ax,dx
	and ax,0x000f ; masking first three values
	add al,0x30
	cmp al,0x39 ;if (al>0x39) it's an alpha char
	jle step2
	add al,7;A is ASCII 65 instead of 58


