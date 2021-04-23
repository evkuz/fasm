; before execution the module must have
; INPUT
; EAX has pointer to integer which will receive the return value
; EBX has pointer to integer which will receive the return value
; 
; Returns the time since the Epoch (00:00:00 UTC, January 1, 1970)
; 86400 sec per day * 365 == 31 536 000 секунд в году
; C 1970г. т.е. за 50 лет набегает 1 576 800 000 сек.
; 86400 * 125 = 10 800 000 секунд за 125 дней
 ; 1 587 600 000  01.01.2020
 ; 1 588 073 223
 ; 1 588 073 647




format ELF executable 3
entry start

segment readable executable
include 'int_2_str.inc'

start:

    
start_time_stamp:
   ; mov ebx, eax  ; 
    mov eax, 13
    mov ebx, st_time_val ; pointer going to store the return value
    int 0x80

    mov ecx, dword [st_time_val]

    ;          the return value is the time in seconds since the Epoch
    ; convert value to string
    ;mov eax, [ebx] ; ebx stores value in seconds
    mov edi, str_of_time
    call int_to_string
    ; now get string with address in edi
    ; and string length in edx


end_time_stamp:

	mov	eax,4           ; sys_write - код 4
	mov	ebx,1           ; stdout   mycommand 2>&1    0 - STDIN, 1 - STDOUT, 2 - STDERR
	mov	ecx,str_of_time ; edi сейчас указывает на конец этой строки Адрес строки, т.е 1-го байта 
	;mov	edx,msg_size    ; Размер строки
	int	0x80            ; Вызов прерывания


; now exit
exit:
	mov eax, 1
	xor	ebx,ebx         ; exit code == 0
	int 0x80   


segment readable writeable

msg db 'The integer value is',0xA
msg_size = $-msg

st_time_val rb  4  ; start time value
str_of_time rb 10
