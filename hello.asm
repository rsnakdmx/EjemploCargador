[BITS 16]					;Se define el tamaño del codigo
[ORG 0x7C00]			;Se indica al ensamblador donde colocara
								;el codigo en memoria tras haber sido cargado


mov si, HelloString	;Guarda la cadena en el registro SI (indice)
call PrintString		;Llamado a PrintString
jmp $						;Bucle infinito para detener ejecucion


PrintString:				;Etiqueta

next_character:		;Etiqueta
mov al, [si]			;Obtiene un caracter de la cadena
inc si						;Suma uno al apuntador del SI
or al, al					;Verifica si el valor siguiente es cero
jz exit_function 		;Si es cero entonces termina de imprimir
call PrintCharacter 	;Si no llama el procedimiento que imprime
jmp next_character 	;Regresa para imprimir el siguiente caracter

exit_function:			;Termina la ejecucion PrintString
ret							;Retorno


PrintCharacter:			;Etiqueta

mov ah, 0x0E			;Indica que se imprimira un caracter
mov bh, 0x00	
mov bl, 0x07			;Define el color del texto, en este caso gris

int 0x10					;Llamado a interrupcion
ret							;Retorno



;DATASEG
HelloString db 'Hola mundo!', 0		;Cadena a imprimir
TIMES 510 - ($ - $$) db 0				;Llena el resto del sector con 0's
DW 0xAA55									;Numero magico del bootloader
