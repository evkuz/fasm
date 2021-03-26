;exch_ops
; 0 - либо оба “0”, либо  оба “1”
; 1 - когда оба разные, не равны
format ELF executable 3
entry start

segment readable executable

start:

	mov al, 0xAA
	mov cl, 0xBC
	mov bl, 0xDE
	mov dl, 0xAA
	cmpxchg cl, bl
	cmpxchg dl, cl
	
	cmpxchg8b
	;cmpxchg16b

   
	mov	eax,1           ; sys_exit
	xor	ebx,ebx         ; exit code == 0
	int	0x80            ; Вызов прерывания

segment readable writeable

msg db 'Test XOR!',0xA
msg_size = $-msg