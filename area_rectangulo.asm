section .data
	
	
	msj1 db "Ingrese la base",10,0
	len1 equ $-msj1
        msj2 db "Ingrese la altura",10,0
	len2 equ $-msj2
	resultado db 10,'el area de rectangulo es: '
	len3 equ $-resultado

section .bss
      	bas resb 2
        alt resb 2
	area resb 2

section .text
	global _start
		_start:


		mov eax, 4
		mov ebx, 1
		mov ecx, msj1
	 	mov edx, len1	
		int 80H

		mov eax,3
		mov ebx,2
		mov ecx,bas
		mov edx,2
		int 80h

		mov eax, 4

		mov ebx, 1
		mov ecx, msj2
	 	mov edx, len2	
		int 80H

                mov eax,3
		mov ebx,2
		mov ecx,alt
		mov edx,2
		int 80h
		mov eax, 4
calculo:
		mov al,[bas]
		mov bl,[alt]
		sub al,'0'
		sub bl,'0'
		mul bl
		add al,'0'
		mov [area],al

		mov eax, 4
		mov ebx, 2
		mov ecx, resultado
	 	mov edx, len3	
		int 80H

		mov eax, 4
		mov ebx, 1
		mov ecx, area
	 	mov edx, 10	
		int 80H
		

		jmp salir

salir: 
		mov eax,1
		mov ebx,0
		int 80h
