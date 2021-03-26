; Try write to file
format ELF executable 3
entry start

segment readable executable

start:
;;;;;;;;;;;;; CREATE FILE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov eax,0x08            ; create file
mov ebx,f               ; ebx filename
mov ecx,0x1b4           ; permissions value
int 80h

mov ebx,eax              ; file descriptor to ebx
;;;;;;;;;;;;; WRITE TO FILE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov eax, 0x04           ; write to file
mov ecx,somedata        ; address of data 
mov edx,sz              ; size (amount) of data
int 80h
;;;;;;;;;;;;; CLOSE FILE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov eax,06h            ; close file
int 80h
;;;;;;;;;;;;; EXIT  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov eax,1
int 80h

;*********** here the variables ***********************
segment readable writeable
f db 'mylog.txt',0
somedata db 'just some text for logging !!!!', 0xA; \n
sz = $-somedata
