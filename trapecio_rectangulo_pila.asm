section .data

	asterisco db  "*"
	nueva_linea db 10, " "


section .text
	global _start
		_start:

		mov ecx, 10    		;contador en y
		mov ebx, 10		;contador en x
		
		l1:
		;permite llamar al procedimeinto imprimir enter
			push ecx
			push ebx
			call imprimir_enter
			pop ecx                 ;ecx=1 es el ultimo valor en guardarse
		 	mov ebx, ecx
			push ebx

		l2:
						; premite llamar al procedimiento llamada asterisco
			push ecx			;ecx=1 		
			call imprimir_asteriscos    ; ecx=*
			pop ecx			
			loop l2
		
			pop ebx
			pop ecx
			inc ebx
			loop l1
			jmp salir


		imprimir_asteriscos:
			mov eax, 4
			mov ebx, 1
			mov ecx,asterisco
			mov edx, 1
			int 80h
			ret		; permite continuar en la ultima inturccion que se quedo
		
		imprimir_enter:
			mov eax, 4
			mov ebx, 1
			mov ecx, nueva_linea
			mov edx, 1
			int 80h
			ret
	
		salir:
		 
 		mov eax, 1
		mov ebx, 0
		int 80h
















	
			
