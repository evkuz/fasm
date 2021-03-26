;In assembly language, the easiest way is to set up the ESI and EDI registers to point 
;to the start and end of the string, then loop. 
;At each iteration, you increment ESI and decrement ;EDI. The result looks something like this:

mov ecx, helloLen
mov eax, hello
mov esi, eax  ; esi points to start of string

add eax, ecx  ; Добавили к адресу длину, получили адрес конца строки
mov edi, eax
dec edi       ; edi points to end of string
shr ecx, 1    ; ecx is count (length/2)
jz done       ; if string is 0 or 1 characters long, done
reverseLoop:
mov al, [esi] ; load characters
mov bl, [edi]
mov [esi], bl ; and swap
mov [edi], al
inc esi       ; adjust pointers
dec edi
dec ecx       ; and loop
jnz reverseLoop