

%macro escribir 2 	;numero de parametros que va a recibir
	mov eax,4
	mov ebx,1
	mov ecx,%1      ; etiqueta de memoria donde se va imprimir 
	mov edx,%2      ; catidad de digitos a imprimir
	int 80h
%endmacro
%macro lectura     2 	;numero de parametros que va a recibir
	mov eax,3
	mov ebx,2
	mov ecx,%1      ; etiqueta de memoria donde se va imprimir 
	mov edx,%2      ; catidad de digitos a imprimir
	int 80h
%endmacro

section .data
  msj db "ingrese los numeros",10
  len equ $ -msj
  
  msj1 db "el menor es: "
  len1 equ $ -msj1
   
  ent db " ",10
  lenEnt equ $ -ent
 
  
  arreglo db 0,0,0,0,0
  tamaArre equ $ -arreglo


section .bss
   res resb 2
   


section .text
	global _start
	_start:
      
        escribir msj,len


    ;_______________registros del arreglo____________________________________

        mov esi,arreglo      ; almacena la posicion del primer elemento de arreglo				
        mov edi,0            ; indica la posicion donde nos encotramo con respecto al tamaño del arreglo


    ;__________________ ingresar los elementos al arreglo___________________    
        leer_arreglo:
 	   lectura res,2
	   mov al,[res]     ; movemos los numeros a al
           sub al,'0'       ; se transforma el caracter a numero
           mov [esi],al     ; movemos el valor a la posicion de memoria donde queremos colocarlo
                            ; lo coloca en la promera posicion... en la posicion 1
           add esi,1        ; se incrementa esi en 1
           add edi,1        ; se incrementa 1
           
           cmp edi,tamaArre  ;se compara edi con tamArre(contiene la longitud del arreglo)
                             ; si edi es menor que TamArre
           jb leer_arreglo   ; se ejecutal la etiqueta leer




    ;_____________Recorrido del arreglo_____________ Menor de un arreglo   
 
	 mov ecx,0          ;siver para obtener el valor de cada registro del arreglo 
         mov bl,9           ;almacena el numero mas pequeño del arreglo
         comparar2:
            mov al, [arreglo + ecx]  ;almacenamo el valor de larreglo en la posocion 0 ...a=1
	    cmp al,bl                ;comparamo si al es mayor que bl
	    ja bucle2                 ;se ejecuta blucle si al es menor que bl
	    mov bl,al                ;caso contratio bl es igual al  ...bl contendrá el numeor menor 
         bucle2:
	    inc ecx                ; cx se incrmenta en 1 sucesivamente hasta 5
	    cmp ecx, tamaArre      ; si cx es menor que el tamaño de arreglo
	    jb comparar2          ; se ejecuta la etiqueta comparar


         imprimir2:
            add bl,'0'
            mov [res],bl
            escribir ent,lenEnt
            escribir msj1,len1
            escribir res,1
	salir:
            mov eax,1
            mov ebx,0
	    int 80h


