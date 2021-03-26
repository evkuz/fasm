;-----------------------------------------------------
; ������� ��������� ����� ������
;-----------------------------------------------------
; pStr - ��������� �� ������ ASCIIZ
; �� ������: EAX - ����� ������ ��� ����� ������������
; �������� �����
;-----------------------------------------------------

format PE console
entry _start         ;���������� fasm-�, ��� �������� �����

include 'win32a.inc' ;Win32 �������

; Constants
my_z_str: db ".123456789_",0

output_message: db "The string 'my_z_str' has %d symbols length",0


;-----------------------------------------------------
; pStr - ��������� �� ������ ASCIIZ
; �� ������: EAX - ����� ������ ��� ����� ������������
; �������� �����
;-----------------------------------------------------

proc    _mystrlen pStr:DWORD
        mov     eax, [pStr]  ;  ����� ������� pStr, ����� 1-�� �������� �������
        dec     eax
@@:                          ; anonymous label
        inc     eax
        cmp     byte [eax],0 ; ���� (dst == src), �� ZF=1, � ��������� ������� ZF=0
        jne     @b           ; ������ (�������) �� ��������� ���������� (backward) ��������� �����
        sub     eax, [pStr]  ; �������� �� �������� ������ ���������, �������� ����� ������.
        ret
endp

_start:

        push my_z_str
        call _mystrlen 

        
        push eax             ; ����� ������ � ������
        push output_message  ; 2 �������� ���  `printf` ��� ���� ������ ������
 
        call [printf]        ; ������� � ������� ��������, ����������� �  EAX.

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