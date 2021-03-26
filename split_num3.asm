;---------------------------------------------
; Split Number Demo 3
; Copyright (C) by ManHunter / PCL
; http://www.manhunter.ru
;---------------------------------------------

format PE GUI 4.0
entry start

include 'win32a.inc'

;---------------------------------------------

section '.data' data readable writeable

szTtl1  db 'Example',0
szTtl2  db 'Size of code',0
buff    rb 500h

;---------------------------------------------

section '.code' code readable executable

start:
        stdcall split_num,buff,1234567890
        invoke  MessageBox,0,buff,szTtl1,0
        stdcall split_num,buff,zSize
        invoke  MessageBox,0,buff,szTtl2,0

        invoke  ExitProcess,0

;--------------------------------------------------------------------
; Процедура преобразования числа в строку с разделением на разряды
;--------------------------------------------------------------------
; Параметры:
;   lpBuff - указатель на строку, куда будет записан результат
;   dNum - число для преобразования
;--------------------------------------------------------------------
proc split_num lpBuff:DWORD, dNum:DWORD
        pusha

        mov     eax,[dNum]
        xor     esi,esi
        xor     ecx,ecx
        push    ecx
        inc     ecx
.loc_loop:
        ; Получить следующую цифру
        xor     edx,edx
        mov     ebx,10
        div     ebx
        add     dl,'0'
        push    edx
        inc     ecx

        ; Все цифры сохранили?
        or      eax,eax
        jz      .loc_store

        ; Нужен разделитель разрядов?
        inc     esi
        cmp     esi,3
        jne     @f
        mov     dl,','
        push    edx
        inc     ecx
        xor     esi,esi
@@:
        jmp     .loc_loop

.loc_store:
        mov     edi,[lpBuff]
        cld
@@:
        pop     eax
        stosb
        loop    @b

        popa
        ret
endp

zSize = $-split_num

;---------------------------------------------

section '.idata' import data readable writeable

  library kernel32,'kernel32.dll',\
          user32,'user32.dll'

  include 'api\kernel32.inc'
  include 'api\user32.inc'

