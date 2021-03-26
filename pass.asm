
; check pasword example

format ELF executable 3
entry start

segment readable executable

start:

	mov	eax,4
	mov	ebx,1
	mov	ecx,msg1
	mov	edx,msg1_size
	int	0x80

; now read password
  mov eax, 3
  mov ebx, 0
  mov ecx, msg2
  mov edx, msg2_sz
  int 0x80

 ; mov ebx, [mypass]
  ;cmp ebx, [msg2]

   ; jnz wrong

	mov	eax,4
	mov	ebx,1
	mov	ecx,msg1
	mov	edx,msg1_size
	int	0x80
	jmp exit



wrong:
	mov	eax,4
	mov	ebx,1
	mov	ecx,msg4
	mov	edx,msg4_sz
	int	0x80


exit:

	mov	eax,1           ; sys_exit
	xor	ebx,ebx         ; exit code == 0
	int	0x80            ; Вызов прерывания

segment readable writeable

msg1 db 'password:',0xA
msg1_size = $-msg1
mypass db 'qwerty'
msg2 rb 255
msg2_sz = $ - msg2
msg3 db 'wrong password, try again'
msg3_sz = $ - msg3
msg4 db 'welcome !'
msg4_sz = $ - msg4