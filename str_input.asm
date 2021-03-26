format ELF executable 3
entry start

segment readable  writeable executable

start:

;call print_welcome

print_welcome:
    mov     eax,4                                 ; System call 'write'
    mov     ebx,1                                 ; 'stdout'
    mov     ecx,message                           ; Address of message
    mov     edx,message_length                    ; Length  of message
    int     0x80                                  ; All system calls are done via this interrupt

read_input:
    mov     eax,3                                 ; System call 'read'
    mov     ebx,0                                 ; 'stdin'
    mov     ecx,input                             ; address to save input to
    ;add     ecx,line_feed
    mov     edx,input_length + 1                      ; 1
    int     0x80

str_len:

        mov     eax, input  ;  адрес массива input, адрес 1-го элемента массива
        dec     eax
@@:                          ; anonymous label
        inc     eax
        cmp     byte [eax],0xA; если (dst == src), то ZF=1, в остальных случаях ZF=0
        mov     edx, [eax]
        jne     @b           ; Прыжок (возврат) на ближайшую ПРЕДЫДУЩУЮ (backward) анонимную метку
        sub     eax, input  ; Вычитаем из текущего адреса начальный, получаем длину строки.
;        ret                ; subtracts the source operand from the destination operand and replaces the destination operand with the result.

    push eax ; сохраняем значение длины строки в стек
    ;pop ebx

print_result:                                     ; 2 strings
    mov     eax,4                                 ; System call 'write'
    mov     ebx,1                                 ; 'stdout'
    mov     ecx,response                          ; Address of message
    mov     edx,response_length                   ; Length  of message
    int     0x80                                  ; All system calls are done via this interrupt

    mov     eax,4                                 ; System call 'write'
    mov     ebx,1                                 ; 'stdout'
    mov     ecx,input                             ; Address of message
    mov     edx,25                                ; Length  of message
    int     0x80                                  ; All system calls are done via this interrupt

    
print_length:
    pop ebx
    mov dword [str_l], ebx
    ;mov fs, esi
    ;mov esi, str_l_2
    ;add fs, dword [esi]

    mov eax,4
    mov ebx,1
    mov ecx,final_str
    mov edx,50
    int     0x80
  ;  pop ebx
  ;  mov [str_l], ebx 

_exit:
    mov     eax,1                                 ; System call 'exit'
    xor     ebx,ebx                               ; Exitcode: 0 ('xor ebx,ebx' saves time; 'mov ebx, 0' would be slower)
    int     0x80

;segment readable writeable
    input           rb 25; ,0xA ; 0xA is ascii for line feed
    ;line_feed       db 0xA
    input_length    db '25'

;segment readable
    message         db 'Please enter a char: ' 
    message_length  = $-message

    response        db 'You entered: ' 
    response_length = $-response

    final_str:
    ;str_mess        
    db 'length is '
    str_l           dd ?
    str_l_2         db 'symbols'
    db 0Dh,0Ah ;end
    ;str_mess_sz = $ - str_mess
