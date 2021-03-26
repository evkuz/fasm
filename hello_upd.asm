
; fasm demonstration of writing simple ELF executable

format ELF executable 3
entry start

segment readable executable

start:

	mov	eax,4
	mov	ebx,1
	mov	ecx,msg
	mov	edx,msg_size
	int	0x80
	 
; Сложение
	xor eax, eax
	mov eax, 0x03
	mov ebx, 0x04
	add eax, ebx
labling:

    xor eax, eax
    mov ecx, prm
    mov edx, [prm]

compare:
	mov eax, 0x05
	mov ecx, 0x08
	sub eax, ecx ;  subtracts the source operand from the destination operand
	xor eax, eax
	xor ecx, ecx
	mov eax, 0x05
	mov ecx, 0x08
	sub ecx, eax
	xor eax, eax
	xor ecx, ecx
	mov eax, 0x05
	mov ecx, 0x08
    cmp eax,ecx
    

	mov	eax,1
	xor	ebx,ebx
	int	0x80

segment readable writeable

msg db 'Hello world!',0xA
msg_size = $-msg
prm dd 0x00112536


