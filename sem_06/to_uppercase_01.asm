
; convert string to upper case 
; Changed table length and counter size to variables (st. 37, 38) 

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


 ; Получили строку, оканчивающуюся на \n
 ; Значение длины будет в EAX
  mov [msg2_sz], al
  ;mov ecx, eax
 ;;;;;;;;;;;;;;;;;;; Transform to uppercase  ;;;;;;;;;;;;;;;
    mov esi, msg2
    mov ebx, table_up
 @@: ; Перебираем символы введенной строки
    mov edi, table_low ; Каждый раз проходим строку с начала.
    ;mov ebx, table_up

    mov edx, sz_tbl_up; длина таблицы XLAT (отсчёт с нуля) 25 + 33
    mov ecx, sz_tbl_up +1 ; количество символов в таблице. (счетчик)
    lodsb ; загружаем байт строки пользователя в EAX (из esi)
    cmp al, 0xA ; Конец строки ? 
    JE __out    ; Если "ДА", то идем на __out
    repne scasb ; сравнивам eax c алфавитом, т.е. с каждым символом из edi - table_low. 
                ; Повторение прекращается, когда одно из условий, означенных в 
                ; префиксе (тут "ne"), перестает выполняться, т.е. повторяем пока НЕ равно, а как РАВНО так прекращаем.
                
;Вот тут у нас edi на нужной позиции. 
;меняем на символ из table_upp
 ;mov al, edi ; кладем заменяемый байт в al 
 
     jcxz next
      sub dl,cl
      mov al,dl
      XLATB

next:    
      dec esi
      mov [esi], al
      inc esi
      jmp @b

__out: ;now reflect input 
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
	mov	dl,[msg2_sz]
	int	0x80



exit:

	mov	eax,1           ; sys_exit
	xor	ebx,ebx         ; exit code == 0
	int	0x80            ; Вызов прерывания

segment readable writeable

msg1 db 'Enter some text : '
msg1_size = $-msg1

msg3 db 'Your upper case : '
msg3_sz = $ - msg3
max_len db '255'

; АБВГДЕЁЖЗИКЛМНОПРСТУФХЦЧШЩЫЪЬЭЮЯ
; абвгдеёжзиклмнопрстуфхцчшщыъьэюя
table_up    db  'ABCDEFGHIJKLMNOPQRSTUVWXYZ'  ;набор кодируемых символов
sz_tbl_up = $ - table_up

table_low   db  'abcdefghijklmnopqrstuvwxyz'  ;таблица замены для XLATB

msg2 rb 255
msg2_sz rb 1 ; резервируем 1 байт под значение длины

