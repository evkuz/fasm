; Try read from file
; scans data with lodsd and observe them in debugger
format ELF executable 3
entry start
;*********** here the variables ***********************
segment readable writeable
f db 'c.bin',0 ; 0 обязательно.
hexstr db 9
somedata rb 36
sz = 36


segment readable executable
include '%FASM_DIR%/include/int_2_str.inc'
include '%FASM_DIR%/include/hex-dword-2-str.inc'
start:
;;;;;;;;;;;;; CREATE FILE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;mov eax,0x08            ; create file
;mov ebx,f               ; ebx filename
;mov ecx,0x1b4           ; permissions value
;int 80h

;;;;;;;;;;;;; OPEN FILE ;;;;;;;;;;;;;;;;;;;;;;;;
mov eax,0x05
mov ebx,f
mov ecx,0 ; O_RDONLY        =       00
mov edx,0  ; file already exists so no more options

int 80h

mov ebx,eax              ; file descriptor to ebx
;;;;;;;;;;;;; READ FROM FILE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov eax, 0x03           ; read from file
mov ecx,somedata        ; address of data 
mov edx,sz              ; size (amount) of data
int 80h

;;;;;;;;;;;;; CLOSE FILE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov eax,06h            ; close file
int 80h

;;;;;;;;;;; output data to console
;mov ecx, 36
;mov esi, somedata
;lodsd
;lodsd

    mov eax, dword [somedata + 4]
    mov edi, hexstr
    call hex_dword_2_str
    ;mov edi, hexstr
    ;mov [edi + 8], byte 0xA
    mov [hexstr +8], byte 0xA

    mov eax,4
    mov ebx,1
    mov ecx, hexstr
    mov edx,9
    int 0x80





;;;;;;;;;;;;; EXIT  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov eax,1
int 80h

