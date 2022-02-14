;;Assignment 8
;;Caleb Ockwig
;;due 11/25/20 - late 12/9/20
;; Use a user generated input to show the inputs on screen. Negative numbers will stop program
;;

		include pcmac.Inc
		.model small
			.586
			.stack 100h
        .data
input  	db 		'Enter a number for the array: ', '$'
msg1		db 		'Each # represents ', '$'
msg2		db		' units', 10, 13, '$'
msg3		db		' unit', 10, 13, '$'

ary 		dw		?
num			dw		?
highNum		dw		?
value		dw		?
max 		db		12
buffer		db		26 DUP (?)
        .code
		Main	proc
		_Begin
		mov  ax,@data
		mov  ds,ax 
		extrn PutDec:near
		extrn GetDec:near
		lea 	bx,buffer
		call 	numIn
		mov		bx, offset buffer
		call top
		call ast
		mov		bx, offset buffer
		call	output
		
		
		
 		_EXIT 0
		Main	endp
		
	numIn Proc
		push bp
		push cx ;; loads into cx register
		push dx
	
		mov ary, 0;;load 0 into array
	
	while_1:
		_PutStr input ;;	 ENTER NUMBER input from user
		call GetDec	  ;;    COLLECS DECIMAL FROM USER
		cmp ax, 0	  ;;	CHECKS IF ZERO
		jl end_while_1	


		mov cx, ary
		cmp cx, 12 ;;greater than 12?
		jge end_while_1;;ends if greater than 12
		mov [bx], al
		add bx, 2
		inc ary
		jmp while_1 ;; restarts loop



	end_while_1:
		mov ax, [bx]
		call PutDec
		mov ax, ary
		pop dx
		pop cx;; empties registers
		pop bp
		ret

	numIn endp

	top proc
			mov highNum, 3
			mov cx,ary
			sub si,si
	top3:	
			mov ax,[bx+si]
			cmp ax, highNum
			jg highest
			jle sort
	highest:	
			mov highNum, ax
			jmp sort
	sort:
			inc si
			inc si
			dec cx
			jnz top3
			ret
	top endp
	
	astr	proc
			push ax
			mov value, 1
			mov ax, highNum
			cmp highNum, 80
			jl done1
			jge newVal


	newVal:
			add ax, 80 
			cwd
			mov bx, 80
			idiv bx
			mov value, ax
			call PutDec
			jmp done


	done1:		
			_PutStr msg1
			sub ax, ax
			mov ax, value
			call PutDec ;; prints value from ax regsiter
			_PutStr msg3
			pop ax ;; clears ax register
			ret


	done:	_PutStr msg1
			sub ax, ax
			mov ax, value
			call PutDec
			_PutStr msg2
			pop ax
			ret

	astr endp
	

	output	proc
			mov cx,ary
			sub si
			sub si;;retraces back two spots


	top2:		
			mov ax,[bx+si]
			cwd
			idiv value
			mov num, ax


	while_2:	
			_putCh '#' ;;prints the character
			dec num
			cmp num, 0
			jg while_2
			jle exit_while_2


	exit_while_2:
			inc si
			inc si ;;moves forward two spaces in register
			dec cx
			dec cx;; lowers cx register two spots
			_putCh 10, 13
			jnz top2
			ret


	output	endp


        END Main 
