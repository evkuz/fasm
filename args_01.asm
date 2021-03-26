;
; Выводим параметр №1 - количество аргументов командной строки. 
; т.е фактически количество опций вводимой команды

format ELF executable 3
entry start
segment readable writeable

msg1 db 'Enter some text : '
msg1_size = $-msg1

msg2 rb 255
msg2_sz rb 1 ; резервируем 1 байт под значение длины

msg3 db 'your arguments number is     : '
msg3_sz = $ - msg3
max_len db '255'

msg4 db 'your 1st argument is : '
msg4_sz = $ - msg4

msg5 rb 255    ; 5 символов - строка, показывающая число
msg5_sz db 1 ; 1 байт - хранит длину строки. 255 символов хватит


segment readable writeable executable
include 'int_2_str.inc'
start:


        push    ebp
        mov     ebp,esp
        mov     eax,[ebp + 4]     ;argc
        dec eax                 ; (-1) as there is "path" argument in addition to user arguments

  mov edi, msg5

; По завершении системного вызова Чтение имеем в регистре eax длину строки, 
; введенной пользователем.

; Переводим 1 параметр - число аргументов в строку 
call int_to_string
    mov [msg5_sz], dl ; сохраняем длину строки, показывающей число

   ;1st print comment message
	mov	eax,4
	mov	ebx,1
	mov	ecx,msg3
	mov	edx,msg3_sz
	int	0x80

   ;4th print arguments count 
    mov eax,4
    mov ebx,1
    mov ecx,msg5
    mov dl, [msg5_sz]
    int 80h
; Вывели число параметров, двигаемся дальше.




exit:

	mov	eax,1           ; sys_exit
	xor	ebx,ebx         ; exit code == 0
	int	0x80            ; Вызов прерывания

