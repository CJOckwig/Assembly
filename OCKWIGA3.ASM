;Name:  Caleb Ockwig
;Class: CSC 314
;Assign: Current Assign Number 3
;Due:Due date: 10/8/21
;Description:This program collects the current date from the OS and prints it
;  			 in the form of "Today's date is MM/DD/YYYY"
;
;For future Caleb: 
; testing through dosbox is 'masm filename'
; link 'filename,,,util'
; 'filename'

	include PCMAC.INC
	.MODEL SMALL
	.586
	.STACK 100h

	.DATA 
	
	message1 DB "Today's Date is: ",'$'
	day   DB ?;initializes storage.
	month DB ?
	year  DW ?
	
	.CODE
	extrn PutDec:near

DATE PROC
	_Begin ; Macro contained in PCMAC

	mov ah, 2Ah ; Collects current date from OS
	int 21h
	;DH = month
	;DL = Day [0,31]
	;CX = Year;
	;AL = day of week [0,6]
	mov month, DH
	mov day, DL
	
	mov year, CX
	
	_PutStr message1
	
	mov ah, 00h
	mov al, month
	call PutDec ; Prints the Month
				; PutDec expects one word of memory in the ax register so ah
				; will be cleared and month is loaded into the al register.
	
	_PutCh '/'
	
	mov ah, 00h ;Same principle as before but with day instead of month
	mov al, day
	call PutDec ; Prints the day
	
	_PutCh '/'
	
	mov ax, year ;year is already a word of memory therefore not necessary to
				 ; clear ah.
	call PutDec ;Prints the year

	_Exit 0	
	
DATE ENDP

	END DATE