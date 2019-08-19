%macro escribir 2

	mov eax,4
	mov ebx,1
	mov ecx,%1
	mov edx,%2
	int 80h
%endmacro

section .data
        msj1 db 'el numero que se repite mas es:'
  	len1 equ $ -msj1
	mensaje db 'los numeros de que estan en el archivo son: '
	len_mensaje equ $-mensaje

	archivo db '/home/cluster/Escritorio/NAMS/examen3/numeros.txt',0 ;-----pwd-->obtiene la ruta
      
	msj2 db 10, 'el resultado ha sido escrito en el disco duro.... por favor verifiquelo',10
	len_msj equ $- msj2
	archivo1 db '/home/cluster/Escritorio/NAMS/examen3/moda.txt',0 ;-----pwd-->obtiene la ruta

	msj3 db 10, "el mayor es: "
  	len3 equ $ -msj3
section .bss

	texto resb 25		; variable que almacena el contenido del archivo

	idarchivo resd 1 	; identificador que se obtiene del archivo, el archivo es el fisico
  	res resb 2
	may resb 2
	texto1 resb 10  		; variable que almacena 
	 			  		; el contenido del archivo
	idarchivo1 resd 1	; el identificador que se obtiene	
				  		; del archivo, es el archivo fisico
section .text

	global _start

_start:

	mov eax, 5		;servicio 5 para leer el archivo
	mov ebx, archivo	;direccion del archivo
	mov ecx,0 		;modo de acceso-->leer=0, escribir=1, leer y escribir=2
	mov edx,0 		;permite leer si esta craeado
	int 80h 

	test eax,eax		;instruccion de comparacion-->modifica el valor de las banderas
	jz salir

	mov dword[idarchivo], eax

	escribir mensaje, len_mensaje

	mov eax,3		;servicio 3 lectura	
	mov ebx,[idarchivo]	;unidad de entrada
	mov ecx,texto
	mov edx,25
	int 80h

	escribir texto , 25

	mov eax,6		;servicio 6 cerrar el archivo
	mov ebx,[idarchivo]
	mov ecx,0
	mov edx,0
	int 80h


 ;_____________Recorrido del arreglo_____________ 


;***************** elementos: 0 1 2 3 4 5 1 6 7 ******************

         mov esi,1                     ; aux=1  sirve para posiciones  
	 mov ecx,0                     ; aux=0  sirve para posiciones
	    comparar_elemento:         ; etiqueta para el primer elemento o elemento anterior a comparar
                mov al,[texto+ecx]     ; en la pociocion 0 al= tiene el valor del primer elemento que es 0
                mov edi,esi            ; edi=1 que es el valor de esi

                comparar_resto:        ; etiqueta del segundo elemento a comparar
                mov bl,[texto+edi]     ; bl tiene el valor del segundo elemento que es 1
                cmp al,bl              ; se compara al y bl--- si al=bl salta a la bandera jb imprimir
                je imprimir            ; se imprime el elemento en caso de que sean iguales
                 
                bucle:                 ; caso contrario se va al bucle
                  add edi,1   	       ; se incremeta edi a 2
                  cmp edi,9            ; se compara edi----si edi es monor a 9 salta a la bandera comparar_resto
                  jb comparar_resto    ; se ejecuta  esta bandera si edi es menor a 9
                  inc ecx              ; caso contrario ecx en incrementa a 1
                  add esi,1            ; esi se incrementa a 2
                  cmp ecx,9            ; se compara ecx----si ecx es menor a 9 salta a la bandera comparar_elemento
                  
                  jb comparar_elemento ; se activa la bandera si ecx es monor a 9
                  jmp salir            ; caso contrario hace un salto para salir del programa
                  
                

    ;_____________IMprime el mayor de todos los numero del areglo_______________
         imprimir:
            mov [res],al               ; se envia el valor del numro que se repite a la variable res
            escribir msj1,len1         ; mensaje de numero que se repite 
            escribir res,1             ; se imprime el numero que se repite



	;_____________Recorrido del arreglo_____________ Mayor de un arreglo    

	 
	 mov ecx,0          ;siver para obtener el valor de cada registro del arreglo 
         mov bl,0           ;alamacena el numero mas grande del arreglo
         
            comparar1:
            mov al, [texto + ecx]  ;almacenamo el valor de larreglo en la posocion 0 ...a=1
	    cmp al,bl                ;comparamo si al es menor que bl
	    jb bucle1                 ;se ejecuta blucle si al es menor que bl
	    mov bl,al                ;caso contratio bl es igual al  ...bl contendrá el numeor mayor 
           
         bucle1:
		inc ecx                ; cx se incrmenta en 1 sucesivamente hasta 5
		cmp ecx, 9           ; si cx es menor que el tamaño de arreglo
		jb comparar1          ; se ejecuta la etiqueta comparar


	    ;_____________IMprime el mayor de todos los numero del areglo_______________
         imprimir1:
            
            mov [may],bl
            escribir msj3,len3
            escribir may,1






        mov eax, 8 			;8 para escribir
	mov ebx, archivo1
	mov ecx, 1
	mov edx, 200h
	int 80h

	test eax, eax
	jz salir

	mov dword[idarchivo1], eax
	;Mesnaje
	escribir msj2,len_msj

	;se lee desde teclado
	
	
	;se envia al archivo el texto
	mov eax, 4
	mov ebx, [idarchivo1]
	mov ecx, res
	mov edx, 10
	int 80h
	


salir:

	mov eax,1
	int 80h
