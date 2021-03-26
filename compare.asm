
; fasm demonstration of writing simple ELF executable

format ELF executable 3
entry start

segment readable executable

start:

	mov eax, 0x05
	mov ecx, 0x05
	cmp eax, ecx

	mov	eax,1           ; sys_exit
	xor	ebx,ebx         ; exit code == 0
	int	0x80            ; Вызов прерывания

segment readable writeable

msg db 'Hello world!',0xA
msg_size = $-msg
