; str_2_int
; Перевод строки в число побайтово
; INPUT
; ESI - address of string 	with decimal digits
; ECX - string length of ESI
; 
; OUTPUT
; EAX - decimal value of string


str_2_int:
	;mov ecx, 10
	push 0
	@@: ; Перебираем символы строки ESI
	   
	lodsb       ;  Загрузили байт в EAX из ESI
	sub al, 0x30  ; получили цифру
	pop edx        ; взяли предыдущее значение, умножили его на 10 и прибавили новую цифру
	imul edx, 10
	add dl, al
	push EDX       ; новое значение в стек
	loop @b        ; ecx уменьшается на 1
	
	pop eax        ; выровняли стек, положили значение в eax

	ret