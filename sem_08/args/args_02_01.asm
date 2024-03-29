;
; Выводим количество аргументов командной строки. т.е фактически количество опций вводимой команды
; Выводим Первый аргумент
; 
; используем код arg_val.inc как пример экономии кода.
; см. стр. 75 dl там неслучайно.

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

msg4 db 'your arguments are : '
msg4_sz = $ - msg4

msg5 rb 255    ; 5 символов - строка, показывающая число
msg5_sz db 1   ; 1 байт - хранит длину строки. 255 символов хватит



segment readable writeable executable
include '%FASM_DIR%/include/int_2_str.inc'
;include 'str_2_int.inc'
include '%FASM_DIR%/include/arg_val.inc'
start:


        push    ebp
        mov     ebp,esp
        mov     eax,[ebp+4]     ;argc
        dec eax                 ; (-1) as there is "path" argument in addition to user arguments
        ;sub     ebx,1
        ;jz      usage
        mov ecx, [ebp + 12]

  mov edi, msg5

; По завершении системного вызова Чтение имеем в регистре eax длину строки, 
; веденную пользователем.
; Поэтому сразу сохраняем эту длину здесь.
;mov [msg2_sz], byte al


call int_to_string
mov [msg5_sz], dl ; сохраняем длину строки, показывающей число

;now reflect input 
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
  mov eax, [ebp + 12]  ;1й аргумент - адрес его строки
  call get_arg_val
  mov [msg5_sz], cl ; сохраняем длину строки, показывающей число

  push ecx

  
   ;3rd print comment message for length
    mov eax,4
    mov ebx,1
    mov ecx,msg4
    mov edx,msg4_sz
    int 80h

   pop edx ; взяли длину строки, хранящей 1й аргумент

   ; Добавляем к 1му аргументу (Это и так строка) символ перевода строки. 
   mov edi, [ebp + 12]  ; Сохранили адрес 1-го аргумента
   add edi, edx         ; Добавляем к началу длину строки, теперь edi указывает на конец строки.   
   mov eax, 0xA
   stosb

   mov edi, [ebp + 12]

 ;4th print arguments value
    mov eax,4
    mov ebx,1
    mov ecx, edi
    add edx, 1           ; добавляем место для перевода строки  ;mov dl, [msg5_sz]
    int 80h



exit:

	mov	eax,1           ; sys_exit
	xor	ebx,ebx         ; exit code == 0
	int	0x80            ; Вызов прерывания

