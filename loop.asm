section	.bss
   num resb 1
section	.text
   global _start        ;must be declared for using gcc
	
_start:	                ;tell linker entry point
   mov ecx,10
   mov eax, 1
   add eax, '0'
l1:
   push ecx 
   mov [num], eax
   mov eax, 4
   mov ebx, 1
   mov ecx, num        
   mov edx, 1        
   int 0x80	
   mov eax, [num]
   inc eax
   pop ecx
   loop l1
	
   mov eax,1             ;system call number (sys_exit)
   int 0x80              ;call kernel



