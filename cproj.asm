.model small
.stack 100h
.386
.data
    prompt db "Enter a string: $"
    hbd db 10,13,"Enter 1 for binary, 2 for decimal and 3 for hexadecimal: $"
    string db 100 dup(0)
    dbin db 10,13,"The frequency in Binary is: $"
    dhex db 10,13,"The frequency in Hexadecimal is: $"
    ddec db 10,13,"The frequency in Decimal is: $"
    num db 127 dup(00)

.code
    frequency proc
        push cx
	mov di, offset num
	add di, bx
	mov ax, [di]
	inc ax
	mov [di], ax

       pop cx
       ret
   frequency endp
   
   clearfreq proc
   	push cx
   	mov cx, 127
   	mov di, offset num
   	clearfreq_l1:
   		mov ax, 0
   		mov [di], ax
   		inc di
   	loop clearfreq_l1;
   	pop cx
   	ret
   clearfreq endp

    decout proc       ;to display in decimal
        push cx
        push ax
        push dx
        push bx
        mov cx,0
        
        xor ax, ax
        mov al, dl
        
        xor dx, dx
        
        l1:
        	cmp ax, 0
        	je p1
        	
        	mov bx, 10
        	div bx
        	push dx
        	inc cx
        	xor dx, dx
        jmp l1
        
        p1:
        	cmp cx, 0
        	je decout_e
        	pop dx
        	add dx, 48
        	
        	mov ah, 02h
        	int 21h
        	
        	dec cx
        jmp p1
        
        decout_e:  
		mov dl, " "
		mov ah, 02
		int 21h
        
        pop cx
        pop dx
        pop bx
        pop ax
        ret
    decout endp

    binout proc    ;for binary output
        push cx
        push ax
        push dx
        push bx
        mov cx,0
        
        aga:
            mov bx,2d
            mov dx,0000
            div bx
            inc cx
            push dx
            cmp ax,0000
        jne aga
        mov ah,02
        disp:
            pop dx
            add dl,30h
            int 21h
            dec cx
        jnz disp
        pop cx
        pop dx
        pop bx
        pop ax
        ret
    binout endp

    hexout proc    ;for binary output
        push cx
       
    
        mov cx, 2
	again1:
	rol bl, 4
	mov dl, bl
	and dl, 0fh
	cmp dl, 9h
	jbe alpha
	add dl, 37h
	mov ah, 02
	int 21h
	jmp e

	alpha:
	add dl, 30h
	mov ah, 02
	int 21h
	e:
	dec cx
	jnz again1

        pop cx
       
        ret
hexout endp 

.code

            
        
main proc   
    mov ax, @data
    mov ds, ax
    
    call clearfreq

    mov dx, offset prompt ;printing "Enter a string: "
    mov ah,09h
    int 21h

    mov si, offset string
    input1:
        mov ah,01h
        int 21h 
        mov [si],al
        cmp al, 13
        je displaystr ;taking input till the $
        inc si
        jmp input1
        
	displaystr:
    
    mov dx, offset hbd ;printing "Enter b for binary, d for decimal and h for hexadecimal: $"
    mov ah,09h
    int 21h

    mov ah,01h  ;checking whether to display in binary, hexadecimal or decimal
    int 21h
    cmp al,"1"
    je display_binary
    cmp al,"3"
    je display_hexadecimal

    display_decimal:
        mov dx, offset ddec ;"The frequency in decimal is: $"
        mov ah,09h
        int 21h
       
	
	mov si, offset string
	lld:
		xor bx, bx
		mov bl,[si]
		cmp bl,13
		je ched		
		call frequency
        	inc si
        jmp lld
    
        ched:
        	mov si, offset string
        	dec_print_loop:
        		mov bl, [si]
        		cmp bl, 13
        		je terminate
        		
        		mov dl, [si]
			mov ah, 02h
			int 21h
			
			mov dl, ":"
			mov ah, 02h
			int 21h
			
        		xor bx, bx
        		xor di, di
        		xor dx, dx
        		
        		mov bl, [si]
        		mov di, offset num
        		add di, bx
        		mov dl, [di]
        		call decout
        		
        		inc si
        	jmp dec_print_loop

    display_binary:
        mov dx, offset dbin ;"The frequency in Binary is: $"
        mov ah,09h
        int 21h
        
        
        mov si, offset string
	llb:
		xor bx, bx
		mov bl,[si]
		cmp bl,13
		je cheb		
		call frequency
        	inc si
        jmp llb
    
        cheb:
        	mov si, offset string
        	bin_print_loop:
        		mov bl, [si]
        		cmp bl, 13
        		je terminate
        		
        		mov dl, [si]
			mov ah, 02h
			int 21h
			
			mov dl, ":"
			mov ah, 02h
			int 21h
			
        		xor bx, bx
        		xor di, di
        		xor dx, dx
        		
        		mov bl, [si]
        		mov di, offset num
        		add di, bx
        		mov dl, [di]
        		xor ax, ax
        		mov al, dl
        		call binout
        		
        		inc si
        	jmp bin_print_loop

    display_hexadecimal:
        mov dx, offset dhex ;"The frequency in hexadecimal is: $"
        mov ah,09h
        int 21h
        
        
        mov si, offset string
	llh:
		xor bx, bx
		mov bl,[si]
		cmp bl,13
		je cheh		
		call frequency
        	inc si
        jmp llh
    
        cheh:
        	mov si, offset string
        	hex_print_loop:
        		mov bl, [si]
        		cmp bl, 13
        		je terminate
        		
        		mov dl, [si]
			mov ah, 02h
			int 21h
			
			mov dl, ":"
			mov ah, 02h
			int 21h
			
        		xor bx, bx
        		xor di, di
        		xor dx, dx
        		
        		mov bl, [si]
        		mov di, offset num
        		add di, bx
        		mov dl, [di]
        		mov bl, dl
        		call hexout
        		
        		inc si
        	jmp hex_print_loop


terminate:
    mov ah,4ch
    int 21h
main endp
end main
