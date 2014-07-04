org 100h
jmp START

;This infinite loop reads a one character symbol from the keyboard and echoes it to the screen.
;Then calls OPERAND to find if it is true(1) or false(0) that the symbol is an operand.
;The '1' or '0' rv is sent to the screen and the screen advances to a new line. 
;Kill this infinite loop by clicking the window's x button

START:
mov ah, 07h		 ;Read symbol 
int 21h			 ;from keyboard. 
mov ah, 02h		 ;Echo 
mov dl, al		 ;symbol
int 21h			 ;to screen

push dx			 ;Push p1. The previous "mov dl, al" moved symbol into dl. 
call OPERAND	 ;Call OPERAND to find if input symbol is an operator.
pop dx			 ;This loads dl with rv (1 0r 0) to be echoed to screen.
mov ah, 02h	     ;Send rv
int 21h			 ;to screen

;Advance screen to new print line
mov ah, 02h
mov dl,0Dh
int 21h
mov dl,0Ah
int 21h
	 
jmp START		 ;Jump to START of infinite loop

push ax							
push cx							
push bp							

mov bp, sp						

mov ax, [bp+08h]						
sub al, 30h
mov cx, 9							
	 
jmp WHILE_CONDITION             
WHILE_TOP:                      
dec cx							
WHILE_CONDITION:
cmp ax, cx						
je FOUND  
cmp cx, 0
jnz WHILE_TOP						

cmp cx, 0							
je END_IF
FOUND:							
mov cx, 1							
END_IF:

;this line makes 0 into '0' and 1 into '1' so they will print to the screen in ascii
add cx,30h		

mov [bp+08h], cx
 
;Restore registers subrtn used
pop bp							
pop cx					
pop ax
			
ret
OPERAND ENDP