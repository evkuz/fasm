#define USE_STRLEN 0                                    ; Use strlen to find string length?

__declspec(naked) uint8_t* string_rev(uint8_t* s)
{
    __asm
    {
              mov    eax, dword ptr[esp + 4]            ; Get the address of string
              test   eax, eax                           ; Been passed a null pointer?
              jz     lp_3
#if (USE_STRLEN)
              push   eax                                ; Push string address onto stack
              call   strlen
              pop    ecx                                ; Pop our string back off the stack
              xchg   ecx, eax                           ; String length in eax
#else
              or     ecx, 0ffffffffh                    ; Start ecx at -1
        lp_1:
              inc    ecx
              test   byte ptr[eax + ecx], 0ffh          ; Test string byte for zero
              jnz    lp_1                               ; ecx = string length

#endif
              lea    edx, dword ptr[eax + ecx - 1]      ; edx = last character in string
              and    ecx, -2                            ; Is string 1 character or less?
              jz     lp_3
        lp_2:
              mov    cl, byte ptr[edx]
              mov    ch, byte ptr[eax]
              mov    byte ptr[eax], cl
              mov    byte ptr[edx], ch
              inc    eax
              dec    edx
              cmp    edx, eax                           ; Loop while one pointer is less
              ja     lp_2                               ; than the other (equiv. len/2)
        lp_3:
              ret                                       ; Reversed string in eax
    }
}