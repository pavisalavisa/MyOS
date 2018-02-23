[org 0x7c00]

	mov bp,0x8000; move stack away
	mov sp,bp

	mov bx,0x9000; es_bx=0x0000:0x9000
	mov dh,2 ;read 2 sectors
	call disk_load

	mov dx,[0x9000];retrieve first loaded word
	call print_hex

	call print_nl

	mov dx,[0x9000+512];first word from second loaded sector
	call print_hex

	jmp $

%include "../bootsector_string_function/boot_sect_print.asm"
%include "../bootsector_string_function/boot_sect_print_hex.asm"
%include "boot_sect_disk.asm"

	times 510-($-$$) db 0
	dw 0xaa55
	
	;sector 2
	times 256 dw 0xdada
	times 256 dw 0xface;sector 3
