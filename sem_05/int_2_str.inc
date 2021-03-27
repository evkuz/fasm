; Input
; EAX = int value to convert but not the pointer
; EDI = address of the result, i.e. pointer to the sting having digitals as symbols
; Output:
; EDX = string length value
; None
int_to_string:
    xor   ebx, ebx        ; clear the ebx, I will use as counter for stack pushes
.push_chars:
    xor edx, edx          ; clear edx
    mov ecx, 10           ; ecx is divisor, devide by 10
    div ecx               ; devide edx by ecx, result in eax remainder in edx
    add edx, 0x30         ; add 0x30 to edx convert int => ascii
    push edx              ; push result to stack
    inc ebx               ; increment my stack push counter
    test eax, eax         ; is eax 0?
    jnz .push_chars       ; if eax not 0 repeat

    xor edx,edx
.pop_chars:
    inc edx
    pop eax               ; pop result from stack into eax
    stosb                 ; store contents of eax at the address of num which is in EDI
    dec ebx               ; decrement my stack push counter
    cmp ebx, 0            ; check if stack push counter is 0
    jg .pop_chars         ; not 0 repeat
    mov eax, 0x0a
    stosb                 ; add line feed
    inc edx               ; EDX = full length with line feed
    ret                   ; return to main