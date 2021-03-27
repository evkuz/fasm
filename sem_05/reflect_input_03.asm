; count string length example
; Рабочий вариант. ПО сравнению с reflect_input_01 здесь получилось сэкономить место. Аж 3 байта :)
; - Строка 93, выделяем под ячейку памяти, хранящую длину строки 1 байт, т.к. предполагаем, что 
;   пользователь введет не более 255 символов
; 
; - Строка 31, записывваем в msg2_sz число размером в 1 байт
; - Строка 75, при формировании системного вызова пишем в dl 1 байт, вместо 4 байт в EDX и все работает !!!

format ELF executable 3
entry start

segment readable writeable executable

start:

	mov	eax,4
	mov	ebx,1
	mov	ecx,msg1
	mov	edx,msg1_size
	int	0x80

; now read input
  mov eax, 3
  mov ebx, 0
  mov ecx, msg2
  mov edx, max_len
  int 0x80

; По завершении системного вызова Чтение имеем в регистре eax длину строки, 
; веденную пользователем.
; Поэтому сразу сохраняем эту длину здесь.
mov [msg2_sz], byte al
;push eax
;pop eax
 ; Получили строку, оканчивающуюся на \n, вычисляем длину
 ; Значение длины будет в EAX
 ; compute input size
  
str_len:
     mov eax, dword msg2 ;dword
     dec eax
@@:
    inc eax
    cmp     byte [eax],0xA  ; '\n'
    jne     @b
    
    sub     eax, dword msg2
    
    
; Имеем на выходе: EAX - длина строки без учета завершающего
; нулевого байта, либо символа \n
 ;   inc al
 ;   mov [msg2_sz], byte al
 ;   mov ebx, dword msg2_sz
    ;push EAX

    

 ;now reflect input 
   ;1st print comment message
	mov	eax,4
	mov	ebx,1
	mov	ecx,msg3
	mov	edx,msg3_sz
	int	0x80
	
   ;next print input string itself
	mov	eax,4
	mov	ebx,1
	mov	ecx,msg2
	;;;;;;;;;;;;; так не работает
	;xor edx,edx
	;mov edx, dword [msg2_sz]
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; так работает
	mov	dl,  [msg2_sz]
	;так работает
	;pop edx
	int	0x80


exit:

	mov	eax,1           ; sys_exit
	xor	ebx,ebx         ; exit code == 0
	int	0x80            ; Вызов прерывания

segment readable writeable

msg1 db 'Enter some text : '
msg1_size = $-msg1

msg2 rb 255
msg2_sz rb 1 ; резервируем 1 байт под значение длины

msg3 db 'you entered     : '
msg3_sz = $ - msg3
max_len db '255'
