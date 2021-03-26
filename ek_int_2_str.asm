; Input
; EAX = pointer to the int to convert
; EDI = address of the result
; Output:
; None
format ELF executable 3
entry start

segment readable writeable executable
include 'int_2_str.inc'

start:

   mov edi, msg2
   mov eax, 0x3118; 12568; 
   call int_to_string ; integer to string

   mov [msg2_size], dl
   ;mov eax, 0x0A
   ;stosb

   output_result:
   mov  eax,4
   mov ebx,1
   mov ecx,msg1
   mov edx,msg1_size
   int 0x80

   mov  eax,4
   mov ebx,1
   mov ecx,msg2
   mov dl, [msg2_size]
   int 0x80



   exit:

    mov eax,1           ; sys_exit
    xor ebx,ebx         ; exit code == 0
    int 0x80            ; Вызов прерывания





segment readable writeable

msg1 db 'Output integer as text : '
msg1_size = $-msg1    

msg2 rb 255
msg2_size rb 1