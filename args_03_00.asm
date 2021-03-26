;
; - Выводим количество аргументов командной строки. т.е фактически количество опций вводимой команды
; - Выводим Первый аргумент
; - Выделяем память под массив данных (буфер), копируем туда данные, записываем буфер в файл.

format ELF executable 3
entry start


segment readable executable
include 'int_2_str.inc'
include 'str_2_int.inc'
start:


;	mov	eax,4
;	mov	ebx,1
;	mov	ecx,msg1
;	mov	edx,msg1_size
;	int	0x80

; now read input
;  mov eax, 3
;  mov ebx, 0
;  mov ecx, msg2
;  mov edx, max_len
;  int 0x80


;push ebp
;mov ebp, esp
;mov eax, [esp +4]
;mov ebx, [esp +8]

        push    ebp
        mov     ebp,esp
        mov     eax,[ebp+4]     ;argc
        dec eax                 ; (-1) as there is "path" argument in addition to user arguments

        mov esi, [ebp + 12]
        ;sub     ebx,1
        ;jz      usage


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
  ;mov eax, [ebp + 12] ;1й аргумент - адрес его строки
  mov esi, [ebp + 12]
  mov ecx, -1 ; счетчик цикла по полной
  ;получаем длину строки
  ;для этого сканируем пока не получим нулевой байт.

  strlen:
   inc ecx
     lodsb
     cmp al, 0
     jne strlen
; Вот теперь получили длину и начинаем перевод в число
  mov esi, [ebp + 12]
  push ecx  ; Сохраняем длину строки
  mov dword [msg5_sz], ecx
  
   ;3rd print comment message for length
    mov eax,4
    mov ebx,1
    mov ecx,msg4
    mov edx,msg4_sz
    int 80h

   pop edx
   ;4th print arguments value
    mov eax,4
    mov ebx,1
    mov ecx,esi ;msg5
    mov dl, [msg5_sz]
    int 80h



; определяем длину строки агрумента
; но КАК ???
  pop ecx
  call str_2_int
  ; получили в eax значене аргумента
  ; в нашем случае это размер файла, в байтах
  mov [buf_sz], eax
  
  ; выделяем память заданного размера.

mov edi, mystr
xor eax,eax
stosd
mov eax, [buf_sz]; 0x2710
stosd
mov eax, 3
stosd
mov eax, 0x22

stosd
mov eax, -1
stosd
mov eax, 0
stosd

mov eax,90
mov ebx, mystr
int 80h
; По завершении вызова получаем в eax указатель на область памяти заданного размера.
mov [buf], eax
mov ecx, [buf_sz]  ; задаем счетчик циклов
shr ecx, 2         ; делим на 4

mov ebx, [buf]       ; записываем начало массива
mov eax, [counter] ; задаем начальное значене счетчика циклов
@@:

  
  mov [ebx], eax     ; записали по новому адресу новое значение
  add eax, 4         ; увеличили адрес на 4 байта (следующее значение counter)
  add ebx, 4 ; добавили смещение, увеличили адрес
  loop @b


  ; БУфер получили, осталость записать в файл.
;;;;;;;;;;;;; CREATE FILE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov eax,0x08            ; create file
mov ebx, FilePath       ; ebx filename
mov ecx,0x1b4           ; permissions value
int 80h

mov ebx,eax             ; file descriptor to ebx
;;;;;;;;;;;;; WRITE TO FILE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov eax, 0x04           ; write to file
mov ecx,buf          ; address of data 
mov edx,[buf_sz]   ; size (amount) of data in bytes
int 80h
;;;;;;;;;;;;; CLOSE FILE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov eax,06h            ; close file
int 80h





   ;next print input string itself
	;mov	eax,4
	;mov	ebx,1
	;mov	ecx,msg2
	;mov	dl,  [msg2_sz]
	;int	0x80
   



exit:

	mov	eax,1           ; sys_exit
	xor	ebx,ebx         ; exit code == 0
	int	0x80            ; Вызов прерывания

segment readable writeable

FilePath db 'rnd_data.bin',0 ;
msg1 db 'Enter some text : '
msg1_size = $-msg1

msg2 rb 255
msg2_sz rb 1 ; резервируем 1 байт под значение длины

msg3 db 'your arguments number is     : '
msg3_sz = $ - msg3
max_len db '255'

msg4 db 'your arguments are : '
msg4_sz = $ - msg4

buf dd 0 ; здесь адрес начала буфера.
buf_sz dd 0;
counter     dd 0           ; счетчик цикла для случайных чисел


msg5_sz db 1 ; 1 байт - хранит длину строки. 255 символов хватит
msg5 rb 255    ; 5 символов - строка, показывающая число

mystr rd 6