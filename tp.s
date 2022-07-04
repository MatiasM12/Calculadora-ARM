.data

input_usuario: .asciz "adios"
mensaje_error: .asciz "Lo siento, mis respuestas son limitadas"
text_result:   .asciz "##########"
operacion:     .byte 0
num1:          .int 0
num2:	       .int 0
resultado:     .int 0
resto:         .int 0
mensaje_despedida: .asciz "Adios!\n"

.text
.global main

main:
	ldr r4,=num1
	ldr r5,[r4]
	ldr r8,=num2
	ldr r9,[r8]
	ldr r10,=resultado
	ldr r11,[r10]
	ldr r6,=operacion
	ldr r12,[r6]
	mov r0, #0

	@mov r7, #3					@obtine la cadena y la  guarda en  r1
	@mov r0,#0
	@mov r2, #8
	ldr r1,=input_usuario
	@swi 0
	mov r3,#0
	mov r2, #0

	leer_input_usuario:


			ldrb r3,[r1]			@recorre cadena
			add r1, #1
			cmp r3, #00			@se fija que no sea el ultimo
			beq imprimir			@salta a cuenta
			cmp r3, #0x29			@compara para ver si es mayor que 29
			bhi es_cuenta			@salta a cuenta
			sub r3, #0x20			@resto para ver si es un espacio
			cmp r3, #0x00			@compara  para ver si es espacio
			beq espacio			@salta a operacion
			bal es_salir			@sale si es incorrecto lo ingresado
			bal leer_input_usuario		@vuelve al principio

	es_cuenta:

			cmp r3, #0x39			@compara si es  menor que 39 es un un numero
			bls obtener_operacion		@salra a operacion
			cmp r3, #0x39
			bhi es_salir
			cmp r3,  #0x29
			bls es_salir

	suma:						@mueve el operando a r6 dependiendo cuan sea
			mov r6, r3
			cmp r7, #1
			beq leer_input_usuario
			bal es_salir

	resta:
			mov r6,r3
			cmp r7,#1
			beq leer_input_usuario
			bal es_salir

	multiplicacion:
			mov r6, r3
			cmp r7,#1
			beq  leer_input_usuario
			bal es_salir

	espacio:
			mov r2, #1
			mov r0, #0
			mov r7,#1
			bal leer_input_usuario


	una_sifra:					@multiplica el numero para obetner las sifras de n1 y la guarda
			cmp r2, #0
			bls numero1
			bal numero2

	dos_sifras:
			mov r7, #10
			cmp r2, #0
			bls numero1
			bal numero2

	tres_sifras:
			mov r7,  #10
			cmp r2, #0
			bls numero1
			bal numero2

	numero1:
			mul r5, r7
			add r5, r3
			bal leer_input_usuario

	numero2:
			mul r9, r7
			add r9, r3
			bal leer_input_usuario

	obtener_operacion:				@compara para saber la ubicacion del num



			cmp r3,#0x2a			@se fija si es un operando
			beq multiplicacion
			cmp r3,#0x2b
			beq suma
			cmp r3,#0x2d
			beq resta
			cmp r3,#0x2f
			beq division

			sub r3, #0x30			@se fija si es un numero y salta a sifras
			add r0, #1
			cmp r0, #1
			beq una_sifra
			cmp r0, #2
			beq dos_sifras
			cmp r0, #3
			beq tres_sifras
			bal resolver_operacion


	resolver_operacion:


	division:


	imprimir:


	convertir_texto:



	es_salir:
		mov r0,#1
		ldr r1,=mensaje_error
		mov r7,#41
		mov r7,#4
		swi 0
