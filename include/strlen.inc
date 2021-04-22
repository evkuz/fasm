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