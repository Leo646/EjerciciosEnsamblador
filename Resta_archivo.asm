%macro escribir 2
	mov eax,4
	mov ebx,1
	mov ecx,%1
	mov edx,%2
	int 80h
%endmacro




section .data
	mensaje db "Leer un archivo en el disco duro",10
	len_mensaje equ $-mensaje
	
	archivo1 db "/home/cluster/Escritorio/NAMS/archivos/archivo1.txt",0
	
	archivo2 db "/home/cluster/Escritorio/NAMS/archivos/archivo2.txt",0
	suma db ' '


section .bss
	texto resb 15			;variable que almacenara el contenido del archivo
        texto1 resb 15			;variable que almacenara el contenido del archivo
	idarchivo1 resd 1            ;identificador que se obtiene el archivo, es el archivo fisico
	idarchivo2 resd 1 
	

section .text
	global _start

_start:

	;****proceso para abrir el archivo*****

	mov eax,5   ;servicio para abrir el archivo
	mov ebx,archivo1    ;la direccion del archivo
	mov ecx,0          ;Modo de acceso  0 = read only
	mov edx,0          ;permisos: permite leer si esta creado
	int 80h 
	test eax,eax
        mov dword[idarchivo1],eax
 	
	mov eax,5   ;servicio para abrir el archivo
	mov ebx,archivo2    ;la direccion del archivo
	mov ecx,0          ;Modo de acceso  0 = read only
	mov edx,0          ;permisos: permite leer si esta creado
	int 80h 
	test eax,eax
	
	
	mov dword[idarchivo2],eax

	escribir mensaje,len_mensaje

	

;****leer archivo****
	mov eax,3               ;servicio 3: letura
	mov ebx,[idarchivo1]     ;unidad de entrada
	mov ecx,texto           ;contenido
	mov edx,15
	int 80h
        
	mov eax,3               ;servicio 3: letura
	mov ebx,[idarchivo2]     ;unidad de entrada
	mov ecx,texto1           ;contenido
	mov edx,15
	int 80h

;*****imprimir el contenido***

	escribir texto,15
	escribir texto1,15


;*****cerrar el archivo****
	mov eax,6
	mov ebx,[idarchivo1]
	mov ecx,0
	mov edx,0
	int 80h
	
        mov eax,6
	mov ebx,[idarchivo2]
	mov ecx,0
	mov edx,0
	int 80h

;******suma de archivo********
	mov ecx, 3 ; numero de digitos de cada operando
	mov esi, 2 ; fuente indice
	clc        ; permite poner la bamdera del carri en 0 o apagada, siempre hay que poner para que empiecen las banderas apagadas
	

ciclo_suma:
	;al ser cadena se empieza con 0
	mov al,[texto+esi]  ; las uma se la hace en la parte baja y nos colocamos en la ultima posicion
	sbb al,[texto1+esi]  ; adc activa el carri.... hace l suma normal + el carry, es decir al(7)+n2+esi(6)+cf
        
	aas		 ; ajusta la suma cuando exite un carri
			 ; suma a AL 6 digitos y AH 1 suma el acarreo
			 ; se aplica despues de una suma con carreo 
			 ; y suma el contenido de la bandera de carry 
			 ; al primer operando y despues al segundo
	
	
	pushf		;push flat, guarda el estado de todas las banderas ala pila, es necesario ver el orden de las banderas
	or al, 30h      ;convierte de un caracter a un decimal, es similar sub al,'0'
	popf		; restaura le estado de las baderas de la pila hacia las banderas

       	mov[suma+esi],al
        dec esi
        loop ciclo_suma
       
	escribir suma,3
	

      




	mov eax, 1
	mov ebx, 0
	int 80H
