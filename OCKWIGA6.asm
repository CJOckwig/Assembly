
;Name:  Caleb Ockwig
;Class: CSC 314
;Assign: Current Assign Number 6
;Due:Due date: 11/15/21
;Description: This program will move a given character across the screen and back [1-3] if illegal, loop
; 			
include PCMAC.INC
	.MODEL SMALL
	.586
	.STACK 100h

	.DATA
	Char_Prompt DB 'Please enter a character to move across the screen: ','$'
	Int_Prompt  DB 'Please enter a number 1-3 inclusive:','$'
	newLine     DB 13,10,'$';
	
	User_Char DB '?'
	User_Num  DW '1'
	
	.CODE
	extrn GetDec:near ; collects number from user.
	extrn PutDec:near
	
	
MAIN PROC
	_BEGIN
	_PutStr Char_Prompt
	_PutCh User_Char
	

MAIN ENDP

	

DELAY PROC 

Delay_1:
	push cx
		mov cx, 1000
		dec cx
		jnz Delay_1
		nop
		pop cx
		ret
DELAY ENDP

END MAIN