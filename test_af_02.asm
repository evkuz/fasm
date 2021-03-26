
; fasm demonstration of writing simple ELF executable
; here use bt instruction !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

format ELF executable 3
entry start

segment readable executable

start: 
    
    xor eax,eax
	mov cx, 0x0B ; 0x0f -> 0x10
@@:
	inc cx
    lahf     ; copies SF, ZF, AF, PF, and CF to bits 
                    ;  7,  6,  4,  2, and 0 of the AH register.
    bt eax,12
    ;and ax, 0x1000
    ;cmp ax, 0x1000  ; Проверяем ZF, но не CF
    jc YES  ; AF is set
    ;je YES
    NO:
    ;jne @b
    jnc @b  ; AF == 0

    mov eax,0x04          ; write 
    mov ebx,1             ; 1=stdout to ebx
    mov ecx,msg2          ; address of data 
    mov edx,msg2_sz       ; size (amount) of data
    int 80h
    jmp THE_END

    YES:
    mov eax,0x04          ; write 
    mov ebx,1             ; 1=stdout to ebx
    mov ecx,msg1          ; address of data 
    mov edx,msg1_sz       ; size (amount) of data
    int 80h

 THE_END:   
	mov	eax,1           ; sys_exit
	xor	ebx,ebx         ; exit code == 0
	int	0x80            ; Вызов прерывания

segment readable writeable

msg_1_gt db '1st arg greater than 2nd',0xA
msg_size = $-msg_1_gt
msg_2_gt db '2nd arg greater than 1st',0xA
msg1 db 'Ура перепрыгнули', 0xA
msg1_sz = $ - msg1
msg2 db 'Увы, не получилось перейти', 0xA
msg2_sz = $ - msg2

