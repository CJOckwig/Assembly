;CALEB OCKWIG
;CSC 314
;Assignment 2
;This is an introductory assignment designed to show the rudimentary funtctions of the 3 segment code model
;The goal was to print you name as well as your favorite artist or music.
;The key aspects were loading registers, creating designated data segmets (Specifically MessageName and MessageMusic) and loading them from memory


		.Model SMALL
		.586
		
		.STACK 100h ;Allocating 256 bytes of memory
		 
		.DATA
		 
MessageName DB 'Hello, my name is Caleb Ockwig', 13, 10, '$'; loads MessageName with the phrase listed

MessageMusic DB 'The album Im currently listening to is Glass Beach', 13, 10, '$'

		.CODE
		
HELLO 	PROC		
		mov ax, @data
		mov ds, ax
		mov dx, OFFSET MessageName	; Load name message into dx register
		mov ah, 9h		 			; DISPLAY STRING LOADED IN DX
		int 21h						; standard call MS/PCDOS
		mov dx, OFFSET MessageMusic ; Load music message in dx register
		int 21h 					; 9h is still loaded in ah register
		mov al, 0					; No more instructions for compiler
		mov ah, 4ch 				; Exit back to PCDOS
		int 21h						; loads the 'return 0' command. End of instructions.
		
		
HELLO 	ENDP
	
		END Hello ; Tells Where to start execution