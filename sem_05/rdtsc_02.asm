
; rdtsc loads the current value of the processor's time stamp counter 
; from the 64-bit MSR into the EDX and EAX registers. 
; The processor increments the time stamp counter MSR every clock cycle 
; and resets it to 0 whenever the processor is reset.
;
; ReaDTimeStampCounter - > rdtsc
;
; rdtsc_02 
; - Записываем данные от rdtsc  + дополнительно фиксированные байты.
; - Смотрим, как эти байты записаны в файл.
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
push eax
rdtsc ;
	mov ebx,EAX
	mov ecx,EDX 
rdtsc ; get new values for ticks
    ;prepare string of data
    
    mov [esi],ecx
    inc esi
    mov [esi], ebx
    inc esi
    mov [esi], edx
    inc esi
    mov [esi + 4], eax
    ;;; addendum
    inc esi

    mov [esi], dword 0xffffffff
    inc esi
    inc esi
    inc esi
    inc esi
    mov [esi], dword 0x12345678


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
sz = 16
somedata rb 16
;sz = $ - somedata

 