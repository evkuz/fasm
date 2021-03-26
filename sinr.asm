;---------------------------------------
;
; Command line arguments via FASM & GCC (Linux32)
; Calculate SIN rad from prompt input
; (c)2018 S.A.R
;
; Compile: fasm sinr.asm
; Link   : gcc -m32 sinr.o -s -o sinr
; Usage  : sinr v1 v2 vn (single-spaced)
;
;---------------------------------------
        format ELF
        public main

        extrn printf
        extrn atof

        section '.data' writeable
frmt    db 'sinr(%#+.4f) = %#+.6f',0ah,0
usge    db 0ah,' Usage: sinr v1 v2 vn (single-spaced)',0ah,0ah,0
val1    dq 0.0
val2    dq 0.0



        section '.text' executable

main:
        push    ebp
        mov     ebp,esp
        mov     ebx,[ebp+8]     ;argc
        sub     ebx,1
        jz      usage
        mov     esi,[ebp+12]    ;array of argument pointers
        add     esi,4           ;skip prog's name
more:   mov     edi,[esi]
        call    strlengthd
        mov     byte[edi+edx],0
        push    edi
        call    atof
        add     esp,4
        fst     [val1]
        fsin
        fstp    [val2]
        finit
        push    dword[val2+4]
        push    dword[val2]
        push    dword[val1+4]
        push    dword[val1]
        push    frmt
        call    printf
        add     esp,4*5
        add     esi,4           ;next string pointer
        sub     ebx,1           ;argument countdown
        jnz     more
        leave
        ret
usage:  push    usge
        call    printf
        leave
        ret
        
strlengthd:
        push    edi
        mov     al,0
        cmp     ebx,1
        je      skip
        mov     al,20h
skip:   mov     ecx,-1
        repne   scasb
        mov     edx,-2
        sub     edx,ecx
        pop     edi
        ret
        
