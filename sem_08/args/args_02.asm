;
; - Выводим количество аргументов командной строки - параметр argc. т.е фактически количество опций вводимой команды
;   argc всегда считает еще и путь к программе, поэтому это учитываем.
; - Выводим Первый аргумент

format ELF executable 3
entry start
segment readable writeable

msg1 db 'Enter some text : '
msg1_size = $-msg1

msg2 rb 255
msg2_sz rb 1 ; резервируем 1 байт под значение длины

msg3 db 'your arguments number (argc-1) is : '
msg3_sz = $ - msg3
max_len db '255'

msg4 db 'your 1st argument is  : '
msg4_sz = $ - msg4

msg5 rb 255    ; 5 символов - строка, показывающая число
msg5_sz db 1 ; 1 байт - хранит длину строки. 255 символов хватит


;inc dl            ; Увеличиваем на 1 для сохранения символа '\cr'
    
segment readable writeable executable
include '%FASM_DIR%/include/int_2_str.inc'
include '%FASM_DIR%/include/str_2_int.inc'
start:

        push    ebp
        mov     ebp,esp
        mov     eax,[ebp + 4]   ; Это argc -  хранит число аргументов
        dec eax                 ; (-1) as there is "path" argument in addition to user arguments

mov edi, msg5 ; строка отображает число аргументов в текстовом виде

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
  mov esi, [ebp + 12]  ;1й аргумент - адрес его строки
  mov ecx, -1 ; счетчик цикла предварительно
  ;получаем длину строки
  ;для этого сканируем пока не получим нулевой байт.

  strlen:
   inc ecx
     lodsb
     cmp al, 0
     jne strlen

  push ecx             ; длина строки уже в ecx, сохраняем для последующего вывода
; Вот теперь получили длину и начинаем вывод данных


  ;3rd print comment message for length
   mov eax,4
   mov ebx,1
   mov ecx,msg4
   mov edx,msg4_sz
   int 80h

   pop edx  ; Сохраняем длину строки в edx
   ;inc edx  ; добавляем место для перевода строки ... так не работает, нет перевода строки.
  
  ;4th print arguments value
  ; Выводим 1й аргумент. Это и так строка. ДОбавляем к ней символ перевода строки. 
   mov edi, [ebp + 12]  ; Сохранили адрес 1-го аргумента
   add edi, edx         ; Добавляем к началу длину строки, теперь edi указывает на конец строки.   
   add edx, 1           ; добавляем место для перевода строки
   mov eax, 0xA
   stosb
   
   mov edi, [ebp + 12]
  
   ;4th print arguments value
   mov eax,4
   mov ebx,1
   mov ecx,edi
   ;mov dl, [msg5_sz]
   int 80h



exit:

	mov	eax,1           ; sys_exit
	xor	ebx,ebx         ; exit code == 0
	int	0x80            ; Вызов прерывания

