
; rdtsc loads the current value of the processor's time stamp counter 
; from the 64-bit MSR into the EDX and EAX registers. 
; The processor increments the time stamp counter MSR every clock cycle 
; and resets it to 0 whenever the processor is reset.
;
; rdtsc_05
; Добавили подсчет разницы между двума rdtsc. 
; Преобразовали эту разницу в строку
; Вывели строку.
;
; rdtsc_06 
; Убрал создание двоичного файла *.bin
;
; rdtsc_07 
; Включаем serializig через rdscp
; можно отследить факт смены ядра на многоядерных системах при помощи инструкции RDTSCP, которая, работая аналогично RDTSC, 
; дополнительно возвращает в регистре ECX номер логического процессора.
;
format ELF executable 3
entry start

segment readable executable
;include 'file.inc'
include 'int_2_str.inc'
start:
mov esi, somedata
mov edi, d_val
rdtscp ; 
  mov [cpu_1], cl
	mov ebx,EAX
	mov ecx,EDX 
rdtscp ; get new values for ticks
    ;prepare string of data
    mov [cpu_2], cl
    mov [esi],ecx
    mov [esi+4], ebx
    mov [esi+8], edx
    mov [esi+12], eax

; now calculate difference of ticks
    sub eax, ebx
    call int_to_string
    mov [sz_d_val], dl

;;;; output difference as string
  ; mov eax,4
  ; mov ebx,1
  ; mov ecx,diff
  ; mov edx,sz_diff
  ; int 0x80

   mov eax,4
   mov ebx,1
   mov ecx,d_val
   mov dl, [sz_d_val]
   int 0x80

  

   mov eax,4
   mov ebx,1
   mov ecx, cpu_1_val
   mov dl, [sz_d_val]
   int 0x80






    ; now exit 
  mov	eax,1           ; sys_exit
	xor	ebx,ebx         ; exit code == 0
	int	0x80            ; Вызов прерывания



segment readable writeable
msg db 'Done!',0xA
msg_size = $-msg

f db 'rdtsc.bin',0
diff db 'The difference in ticks is : '
sz_diff = $ - diff
sz = 32
somedata rb 32
;sz = $ - somedata
d_val rb 5
sz_d_val rb 1
cpu_1 rb 1
cpu_2 rb 2

 