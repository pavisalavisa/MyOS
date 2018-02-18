gdt_start: ; starts with a null 8byte
	dd 0x0
	dd 0x0

;GTD for code segment 
gdt_code:
	dw 0xffff ; length 
	dw 0x0 ;base 0-15
	db 0x0 ; base 16-23
	db 10011010b ; flags
	db 11001111b ; flags + segment length
	db 0x0 ; segment base, 24-31 bits

gdt_data:
	dw 0xffff
	dw 0x0
	db 0x0
	db 10010010b
	db 11001111b
	db 0x0

gdt_end:


gdt_descriptor:
	dw gdt_end-gdt_start-1 ; size 16bit always 1 less than true size
	dd gdt_start ; address ( 32bit)

CODE_SEG equ gdt_code-gdt_start
DATA_SEG equ gdt_data-gdt_start
