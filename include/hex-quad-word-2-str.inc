; hex-quad-word-2-str.inc
; По аналогии с hex-dword-2-str.inc принимает 64-битное число как 2х32 и возвращает 17 символьную строку (включая \n)
;---------------------------------------------------------
; INPUT
; EAX - адрес 64-битного числа в памяти.
;
; OUTPUT
; EDI = выходной буфер - строка, представляющая hex данные

hex_quad_word_2_str:
