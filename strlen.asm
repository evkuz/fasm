;-----------------------------------------------------
; Функция получения длины строки
;-----------------------------------------------------
; pStr - указатель на строку ASCIIZ
; На выходе: EAX - длина строки без учета завершающего
; нулевого байта
;-----------------------------------------------------

format PE console
entry _start         ;Обозначаем fasm-у, что начинаем здесь

include 'win32a.inc' ;Win32 функции

; Constants
my_z_str: db ".123456789_",0

output_message: db "The string 'my_z_str' has %d symbols length",0


;-----------------------------------------------------
; pStr - указатель на строку ASCIIZ
; На выходе: EAX - длина строки без учета завершающего
; нулевого байта
;-----------------------------------------------------

proc    _mystrlen pStr:DWORD
        mov     eax, [pStr]  ;  адрес массива pStr, адрес 1-го элемента массива
        dec     eax
@@:                          ; anonymous label
        inc     eax
        cmp     byte [eax],0 ; если (dst == src), то ZF=1, в остальных случаях ZF=0
        jne     @b           ; Прыжок (возврат) на ближайшую ПРЕДЫДУЩУЮ (backward) анонимную метку
        sub     eax, [pStr]  ; Вычитаем из текущего адреса начальный, получаем длину строки.
        ret
endp

_start:

        push my_z_str
        call _mystrlen 

        
        push eax             ; Длина строки в байтах
        push output_message  ; 2 аргумент для  `printf` это сама строка вывода
 
        call [printf]        ; Выводим в консоль значение, сохраненное в  EAX.

        push 0        ; Be nice and let the system know that everything  
                      ; completed without any errors (like `return 0` in C/C++).
        

        call [ExitProcess] ; Go back to the calling procedure (system, whatever)

section '.idata' import data readable
 
library kernel32, 'kernel32.dll', \
        msvcrt,'msvcrt.dll'

import kernel32, \
       ExitProcess,'ExitProcess'
 
import  msvcrt, \
        printf, 'printf'