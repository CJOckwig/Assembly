;; Assignment 7
;; Due: 11/11/2020
;; Caleb Ockwig
;; Description: The program finds the greatest common denominator for two numbers from user.
;;This program follows the following format:
;; while (M<>N)
;;if (N > M) then N = N – M else M = M – N;
;;	           GCD = N;

	INCLUDE PCMAC.INCLUDE
	.model small
	.586
	.STACK 100H
	.DATA
	PUBLIC main, GetMvar, GetNvar, Greatest_Common_Divisor, UserChoice
	Mvar	db 13, 10, "Please enter the First Number: ", "$"
	Nvar	db "Please enter the second number: ", "$"
	Results	db "The CGD(Greatest Common Factor) is: ", "$"
	choice	db 13, 10, "Would you like to try again?(y/n): ", "$"
	M		dw ?
	Mclone	dw ?
	N		dw ?
	Nclone	dw ?
	Uchoice db ?
	



	.CODE
	extrn PutDec:near
	extrn GetDec:near
	
main proc
	_begin
	
	mov ax, @data
	mov ds, ax
	
	call GetMvar
	call GetNvar
	call Greatest_Common_Divisor
	call UserChoice
	
	_exit 0
main endp



GetMvar proc

;;Gets M from user
	push ax; pushes on stack
	_PutStr Mvar
	call GetDec
	mov M, ax; loads M into ax
	pop ax; Empty register
	ret
GetMvar endp


;;Same as M but with N
GetNvar proc

	push ax
	_PutStr Nvar
	call GetDec; gets the value from the user 
	mov N, ax; moves the value entered into N
	pop ax
	ret
GetNvar endp




Greatest_Common_Divisor proc
	push bx
	push ax
	
	mov bx, N 
	mov ax, M
	mov Mclone, ax
	mov Nclone, bx
	
	cmp Nclone, ax;Compares M and N
	je print
	 
	cmp Mclone, 0
	jng Mneg
	jnl Mpos
	jmp done
	
Mneg:
	cmp Nclone, 0;if statement comparing negative N to 0
	je done
	jng bothneg
	neg Mclone
	jmp while_1; jump to the while
	
Mpos:
	cmp Nclone, 0; if statment comparing positive N to 0
	je done
	jnl while_1
	neg Nclone
	jmp while_1
	
bothneg:; makes both values negative
	neg Nclone
	neg Mclone
	jmp while_1;
	



while_1:
	mov ax, Mclone;
	mov bx, Nclone
	
	cmp Mclone, bx
	
	je done


	jnl Msubtr
	jng Nsubtr
	

Msubtr:
	sub Mclone, bx
	jmp while_1



	
Nsubtr:
	sub Nclone, ax
	jmp while_1
	
done:
	cmp M, 0
	jng checkM 
	jmp print 
	
checkM:
	cmp N, 0
	jng checkN ; checks if n is negative
	jmp print 
	
checkN:
	neg Nclone;  both are negative
	jmp print
	
print:
	_PutStr Results;   Prints results
	mov ax, Nclone
	call PutDec
	pop bx
	pop ax
	ret
Greatest_Common_Divisor endp


;;COLLECTS FROM USER
UserChoice proc
	_PutStr choice
	_GetCh
	mov  Uchoice, al
	cmp Uchoice, 109 
	jng UpperToLower
	jmp testing
	


;;UPPER CASE TO LOWER CASE
UpperToLower:
	add Uchoice, 32
	jmp testing
	


testing:


	cmp Uchoice, 110
	je Exit
	
	cmp Uchoice, 121
	je restart; restarting
	call UserChoice
	
restart:


	call main
Exit: 
	ret



UserChoice endp

end main