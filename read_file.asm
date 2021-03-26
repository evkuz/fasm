; Try read from file
; scans data with lodsd and observe them in debugger
format ELF executable 3
entry start

segment readable executable
include 'int_2_str.inc'
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

;;;;;;;;;;; output data to console
mov ecx, 8
mov esi, somedata
repnz lodsd 
;call int_to_string


;;;;;;;;;;;;; CLOSE FILE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov eax,06h            ; close file
int 80h



;;;;;;;;;;;;; EXIT  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov eax,1
int 80h

;*********** here the variables ***********************
segment readable writeable
f db 'c.bin',0 ; 0 обязательно.
somedata rb 32
sz = 32
