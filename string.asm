; файл с полезными функциями

; Вычисляем длину.
; Результат в EAX
str_len:
     mov eax, dword msg2 ;dword
     dec eax
@@:
    inc eax
    cmp     byte [eax],0xA
    jne     @b
    sub     eax, dword msg2