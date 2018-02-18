[bits 16]

switch_to_pm:
	cli ; disable interupts
	lgdt [gdt_descriptor] ; load the GDT descriptor
	mov eax,cr0
	or eax, 0x1 ; set 32 bit mode bit in cr0
	mov cr0, eax
	jmp CODE_SEG: init_pm ; far jump using a different segment

[bits 32]

init_pm: ; 32bit instructions from now on
	mov ax, DATA_SEG ; update segment registers
	mov ds,ax
	mov ss,ax
	mov es,ax
	mov fs,ax
	mov gs,ax

	mov ebp,0x90000 ; update the stack at the top of free space
	mov esp,ebp 

	call BEGIN_PM ; call to a well known label with useful code
