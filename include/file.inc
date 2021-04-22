; File operations
; - create file

; - write gets parameters:
;   file descriptor    in eax
;   pointer to data    "somedata" in ecx
;   pointer to data size "sz" in bytes in edx


;   ;;;;;;;;;;;;; CREATE FILE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov eax,0x08            ; create file
;mov ebx,f               ; ebx filename
;mov ecx,0x1b4           ; permissions value
int 80h


;;;;;;;;;;;;; WRITE TO FILE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov eax, 0x04           ; write to file
mov ebx,eax             ; file descriptor to ebx
;mov ecx,somedata        ; address of data 
;mov edx,sz              ; size (amount) of data
int 80h
;;;;;;;;;;;;; CLOSE FILE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov eax,06h            ; close file
int 80h