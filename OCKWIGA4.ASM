;Name:  Caleb Ockwig
;Class: CSC 314
;Assign: Current Assign Number 4
;Due:Due date: 10/20/21
;Description: This program will convert a temperature given in celsius and 
; convert it to farenheit using the formula F = (9/5)C+32


; Tested using the following values. Checked with google for conversions accuracy
; -40 C = -40 F
;   0 C =  32 F
;  32 C =  89 F
; 100 C = 212 F

include PCMAC.INC
	.MODEL SMALL
	.586
	.STACK 100h

	.DATA
	
	Message DB 'Please enter your current temperature in Celsius: ','$'
	Newline DB 13,10,'$'
	Message2 DB 'The current temperature in farenheit is ', '$'
	Celsius DW ?	
	Farenheit DW ?
	
	.CODE
	extrn GetDec:near ; collects number from user.
	extrn PutDec:near
	
TEMP PROC
	_BEGIN
	
	_PutStr Message
	call GetDec
	mov Celsius, ax
	cwd
	
	mov bx, 9
	imul bx  			; F = C * 9
	
	mov bx, 5
	idiv bx  			; F = C * 9 / 5
	
	ADD ax, 32			; F = C * 9 / 5 + 32. Complete Answer.
	mov farenheit, ax
	
	_PutStr Message2 ; Destroyed ax register
	mov ax, farenheit
	call PutDec 
	
	
	_Exit 0	
	
TEMP ENDP

	END TEMP
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	