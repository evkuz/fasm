
; fasm demonstration of writing simple ELF executable

format ELF executable 3
entry start

segment readable executable

start:

	mov	eax,4           ; sys_write - код 4
	mov	ebx,1           ; stdout   mycommand 2>&1    0 - STDIN, 1 - STDOUT, 2 - STDERR
	mov	ecx,msg         ; Адрес строки, т.е 1-го байта 
	mov	edx,msg_size    ; Размер строки
	int	0x80            ; Вызов прерывания

	mov	eax,1           ; sys_exit
	xor	ebx,ebx         ; exit code == 0
	int	0x80            ; Вызов прерывания

segment readable writeable

msg db 'Hello world!',0xA
msg_size = $-msg
