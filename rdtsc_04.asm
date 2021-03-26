
; rdtsc loads the current value of the processor's time stamp counter 
; from the 64-bit MSR into the EDX and EAX registers. 
; The processor increments the time stamp counter MSR every clock cycle 
; and resets it to 0 whenever the processor is reset.
;
; rdtsc_04
; Другой способ формирования адреса в esi (экономия в 3 байта)
; смотрим на [esi+16/20/24/] 

format ELF executable 3
entry start

segment readable executable
;include 'file.inc'
start:
mov esi, somedata
;;;;;;;;;;;;; CREATE FILE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov eax,0x08            ; create file
mov ebx,f               ; ebx filename
mov ecx,0x1b4           ; permissions value S_IRWXU
int 80h
; EAX=3 - file descriptor number ? Yeah
;mov ebx,eax              ; file descriptor to ebx
push eax ; store file descriptor
rdtsc ;
	mov ebx,EAX
	mov ecx,EDX 
rdtsc ; get new values for ticks
    ;prepare string of data
    mov [esi],ecx
    ;add esi, 4
    mov [esi+4], ebx
    ;add esi, 4
    mov [esi+8], edx
    ;add esi, 4
    mov [esi+12], eax
    ;;; addendum
    ;add esi, 4

    mov [esi+16], dword 0xf1f2f3f4
    ;add esi, 4
    ;inc esi
    ;inc esi
    ;inc esi
    ;inc esi

    mov [esi+20], dword 0x12345678
    ;mov [esi+24], dword 0xABCDEFBC


;;; now esi has all data
    ;; now write to file values
pop ebx
;;;;;;;;;;;;; WRITE TO FILE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov eax, 0x04           ; write to file
;pop ebx
mov ecx,somedata        ; address of data 
mov edx,sz              ; size (amount) of data
int 80h
; -EFAULT	ecx is outside your accessible address space.

;;;;;;;;;;;;; CLOSE FILE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov eax,06h            ; close file
int 80h

    ; now exit 
   	mov	eax,1           ; sys_exit
	xor	ebx,ebx         ; exit code == 0
	int	0x80            ; Вызов прерывания



segment readable writeable
msg db 'Done!',0xA
msg_size = $-msg

f db 'rdtsc.bin',0

sz = 32
somedata rb 32
;sz = $ - somedata

 