;
; - Выводим количество аргументов командной строки. т.е фактически количество опций вводимой команды
; - Выводим Первый аргумент

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

msg4 db 'your only 1 argument is  : '
msg4_sz = $ - msg4

msg5 rb 255    ; 5 символов - строка, показывающая число
msg5_sz db 1 ; 1 байт - хранит длину строки. 255 символов хватит



segment readable writeable executable
include 'int_2_str.inc'
include 'str_2_int.inc'
start:

;        push    ebp
;        mov     ebp,esp
        mov     eax,[esp]     ;argc
        dec eax                 ; (-1) as there is "path" argument in addition to user arguments

  mov edi, msg5 ; строка хранит число аргументов в текстовом виде

;Переводим число аргументов в строку
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
;;;;;;;;;;;;;;;;; Получаем значения аргументов
  ;mov eax, [ebp + 12] 
  mov esi, [esp + 8]  ;1й аргумент - адрес его строки
  mov ecx, -1 ; счетчик цикла по полной
  ;получаем длину строки
  ;для этого сканируем пока не получим нулевой байт.

  strlen:
   inc ecx
     lodsb
     cmp al, 0
     jne strlen
; Вот теперь получили длину и начинаем перевод в число
  mov esi, [esp + 8]  ; адрес строки
  push ecx             ; длина строки уже в ecx, сохраняем для последующего вывода

; Переводим строку в число, т.к. знаем, что это число.
  call str_2_int
  ; получили в eax значене аргумента
  ;mov [msg5_sz], 1 ; сохраняем длину строки, показывающей число


   ;3rd print comment message for length
    mov eax,4
    mov ebx,1
    mov ecx,msg4
    mov edx,msg4_sz
    int 80h

   pop edx
   mov esi, [esp + 8]  ; адрес строки
   ;4th print arguments value
    mov eax,4
    mov ebx,1
    mov ecx,esi ;msg5
    ;mov dl, [msg5_sz]
    int 80h



exit:

	mov	eax,1           ; sys_exit
	xor	ebx,ebx         ; exit code == 0
	int	0x80            ; Вызов прерывания

