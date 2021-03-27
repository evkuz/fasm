; Input
; ESI = welcome message for user input 
; EDX = length of welcome mesasge
;
; EDI = address of user input string
; Output:
; EAX string length value
; None
get_user_input:

  mov eax, 4
  mov ebx, 0
  mov ecx, esi
  ;mov edx, 255 ; max_length
  int 0x80


; now read input
  mov eax, 3
  mov ebx, 0
  mov ecx, esi ; Да, тоже esi, тк. предыдущее значение уже не нужно.
  mov edx, 255 ; max_length
  int 0x80
; Now eax has input string length
  ret

