
; rdtsc loads the current value of the processor's time stamp counter 
; from the 64-bit MSR into the EDX and EAX registers. 
; The processor increments the time stamp counter MSR every clock cycle 
; and resets it to 0 whenever the processor is reset.

format ELF executable 3
entry start

segment readable executable

start:
	rdtsc ;
	push EAX
	push EDX 
	nop
	nop
    nop
	nop
    rdtsc ;
    pop edx; edx 1st
    pop eax ; eax lastb
    ;call show_message

    ; now exit 
   	mov	eax,1           ; sys_exit
	xor	ebx,ebx         ; exit code == 0
	int	0x80            ; Вызов прерывания



segment readable writeable

msg db 'Hello world!',0xA
msg_size = $-msg
