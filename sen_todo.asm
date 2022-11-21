	__CONFIG _CP_OFF & _WDT_OFF & _PWRTE_ON & _XT_OSC & _BODEN_OFF & _LVP_OFF
	INCLUDE<P16F877A.INC>
	CBLOCK .32
	PORCENTAJE
	TEMPL
	TEMPH
	MOSTRAR
	MAXTH
	MAXTL
	MINTH
	MINTL
	MAXH
	MAXL
	MINH
	MINL
	COMPARAR
	POS
	TECLA
	CC
	C0
	C1
	CC2
	CC3
	COMANDO
	CONFI
	H
	L
	NUMERO_RS232
	ENDC
	#DEFINE VEN PORTC,5
	#DEFINE BOM PORTC,7
	#DEFINE CAL PORTC,6
	ORG 00H
	GOTO INICIO
	ORG 04H
	GOTO INTERRUPCION
TABLA_CARACTER
	ADDWF PCL,F
	RETLW '1'
	RETLW '2'
	RETLW '3'
	RETLW 'A'
	RETLW '4'
	RETLW '5'
	RETLW '6'
	RETLW 'B'
	RETLW '7'
	RETLW '8'
	RETLW '9'
	RETLW 'C'
	RETLW '*'
	RETLW '0'
	RETLW '#'
	RETLW 'D'
	
ERROR_PARAMETROS
	CALL	LCD_BORRA
	CALL	LCD_CURSORON
	CALL	LCD_CURSORINC
	CALL	LCD_FILA1
	MOVLW  'E'
	CALL	LCD_CARACTER
	MOVLW  'R'
	CALL	LCD_CARACTER
	MOVLW  'R'
	CALL	LCD_CARACTER
	MOVLW  'O'
	CALL	LCD_CARACTER
	MOVLW  'R'
	CALL	LCD_CARACTER
	CALL	LCD_FILA2
	MOVLW  'P'
	CALL	LCD_CARACTER
	MOVLW  'A'
	CALL	LCD_CARACTER
	MOVLW  'R'
	CALL	LCD_CARACTER
	MOVLW  'A'
	CALL	LCD_CARACTER
	MOVLW  'M'
	CALL	LCD_CARACTER
	MOVLW  'E'
	CALL	LCD_CARACTER
	MOVLW  'T'
	CALL	LCD_CARACTER
	MOVLW  'R'
	CALL	LCD_CARACTER
	MOVLW  'O'
	CALL	LCD_CARACTER
	MOVLW  'S'
	CALL	LCD_CARACTER
	RETURN
	
ESPERAR_LEVANTAR_DEDO
	BCF PORTB,0
	BCF PORTB,1
	BCF PORTB,2
	BCF PORTB,3
	CALL RETARDO_10MS
	MOVF PORTB,W
	MOVWF COMPARAR
	MOVLW B'11110000'
	ANDWF COMPARAR,F
	SWAPF COMPARAR,F
	MOVLW D'15'
	SUBWF COMPARAR,W
	BTFSS STATUS,Z
	GOTO ESPERAR_LEVANTAR_DEDO
	RETURN
INTERRUPCION
	BTFSS INTCON,RBIF
	GOTO FIN_INTERRUPCION
	CLRF POS
		
	BCF PORTB,0
	BSF PORTB,1
	BSF PORTB,2
	BSF PORTB,3
	BTFSS PORTB,4
	GOTO ENCONTRO_TECLA
	INCF POS,F
	BTFSS PORTB,5
	GOTO ENCONTRO_TECLA
	INCF POS,F
	BTFSS PORTB,6
	GOTO ENCONTRO_TECLA
	INCF POS,F
	BTFSS PORTB,7
	GOTO ENCONTRO_TECLA
	INCF POS,F
	
	BSF PORTB,0
	BCF PORTB,1
	BSF PORTB,2
	BSF PORTB,3
	BTFSS PORTB,4
	GOTO ENCONTRO_TECLA
	INCF POS,F
	BTFSS PORTB,5
	GOTO ENCONTRO_TECLA
	INCF POS,F
	BTFSS PORTB,6
	GOTO ENCONTRO_TECLA
	INCF POS,F
	BTFSS PORTB,7
	GOTO ENCONTRO_TECLA
	INCF POS,F
	
	BSF PORTB,0
	BSF PORTB,1
	BCF PORTB,2
	BSF PORTB,3
	BTFSS PORTB,4
	GOTO ENCONTRO_TECLA
	INCF POS,F
	BTFSS PORTB,5
	GOTO ENCONTRO_TECLA
	INCF POS,F
	BTFSS PORTB,6
	GOTO ENCONTRO_TECLA
	INCF POS,F
	BTFSS PORTB,7
	GOTO ENCONTRO_TECLA
	INCF POS,F
	
	BSF PORTB,0
	BSF PORTB,1
	BSF PORTB,2
	BCF PORTB,3
	BTFSS PORTB,4
	GOTO ENCONTRO_TECLA
	INCF POS,F
	BTFSS PORTB,5
	GOTO ENCONTRO_TECLA
	INCF POS,F
	BTFSS PORTB,6
	GOTO ENCONTRO_TECLA
	INCF POS,F

ENCONTRO_TECLA
	MOVF POS,W
	CALL TABLA_CARACTER
	MOVWF TECLA
	
	MOVLW '*'
	SUBWF TECLA,W
	BTFSS STATUS,Z
	GOTO NO_ES_ASTERISCO
	MOVLW D'1'
	MOVWF CONFI
	GOTO A1
NO_ES_ASTERISCO
	MOVLW '#'
	SUBWF TECLA,W
	BTFSS STATUS,Z
	GOTO COMANDO_
	CLRF CONFI
	GOTO A1
COMANDO_
	MOVF CONFI,F
	BTFSC STATUS,Z
	GOTO A1
	MOVF COMANDO,F
	BTFSS STATUS,Z
	GOTO COMANDO_NO_0
	MOVLW 'A'
	SUBWF TECLA,W
	BTFSS STATUS,Z
	GOTO NO_A

	CALL	LCD_BORRA
	CALL	LCD_CURSORON
	CALL	LCD_CURSORINC
	CALL	LCD_FILA1
	MOVLW  'T'
	CALL	LCD_CARACTER
	MOVLW  'E'
	CALL	LCD_CARACTER
	MOVLW  'M'
	CALL	LCD_CARACTER
	MOVLW  'P'
	CALL	LCD_CARACTER
	MOVLW  'E'
	CALL	LCD_CARACTER
	MOVLW  'R'
	CALL	LCD_CARACTER
	MOVLW  'A'
	CALL	LCD_CARACTER
	MOVLW  'T'
	CALL	LCD_CARACTER
	MOVLW  'U'
	CALL	LCD_CARACTER
	MOVLW  'R'
	CALL	LCD_CARACTER
	MOVLW  'A'
	CALL	LCD_CARACTER
	CALL	LCD_CARACTER
	CALL	LCD_FILA2
	MOVLW  'M'
	CALL	LCD_CARACTER
	MOVLW  'A'
	CALL	LCD_CARACTER
	MOVLW  'X'
	CALL	LCD_CARACTER
	MOVLW  'I'
	CALL	LCD_CARACTER
	MOVLW  'M'
	CALL	LCD_CARACTER
	MOVLW  'A'
	CALL	LCD_CARACTER
	MOVLW  '='
	CALL	LCD_CARACTER
	MOVLW D'1'
	MOVWF COMANDO	
	CLRF CC
	MOVLW 'A'
	MOVWF C0
	GOTO A1

NO_A
	
	MOVLW 'B'
	SUBWF TECLA,W
	BTFSS STATUS,Z
	GOTO NO_B
	
	CALL	LCD_BORRA
	CALL	LCD_CURSORON
	CALL	LCD_CURSORINC
	CALL	LCD_FILA1
	MOVLW  'T'
	CALL	LCD_CARACTER
	MOVLW  'E'
	CALL	LCD_CARACTER
	MOVLW  'M'
	CALL	LCD_CARACTER
	MOVLW  'P'
	CALL	LCD_CARACTER
	MOVLW  'E'
	CALL	LCD_CARACTER
	MOVLW  'R'
	CALL	LCD_CARACTER
	MOVLW  'A'
	CALL	LCD_CARACTER
	MOVLW  'T'
	CALL	LCD_CARACTER
	MOVLW  'U'
	CALL	LCD_CARACTER
	MOVLW  'R'
	CALL	LCD_CARACTER
	MOVLW  'A'
	CALL	LCD_CARACTER
	CALL	LCD_CARACTER
	CALL	LCD_FILA2
	MOVLW  'M'
	CALL	LCD_CARACTER
	MOVLW  'I'
	CALL	LCD_CARACTER
	MOVLW  'N'
	CALL	LCD_CARACTER
	MOVLW  'I'
	CALL	LCD_CARACTER
	MOVLW  'M'
	CALL	LCD_CARACTER
	MOVLW  'A'
	CALL	LCD_CARACTER
	MOVLW  '='
	CALL	LCD_CARACTER
	MOVLW D'1'
	MOVWF COMANDO	
	CLRF CC
	MOVLW 'B'
	MOVWF C0
	GOTO A1
NO_B
	MOVLW 'C'
	SUBWF TECLA,W
	BTFSS STATUS,Z
	GOTO NO_C
	
	CALL	LCD_BORRA
	CALL	LCD_CURSORON
	CALL	LCD_CURSORINC
	CALL	LCD_FILA1
	MOVLW  'L'
	CALL	LCD_CARACTER
	MOVLW  'U'
	CALL	LCD_CARACTER
	MOVLW  'M'
	CALL	LCD_CARACTER
	MOVLW  'I'
	CALL	LCD_CARACTER
	MOVLW  'N'
	CALL	LCD_CARACTER
	MOVLW  'O'
	CALL	LCD_CARACTER
	MOVLW  'S'
	CALL	LCD_CARACTER
	MOVLW  'I'
	CALL	LCD_CARACTER
	MOVLW  'D'
	CALL	LCD_CARACTER
	MOVLW  'A'
	CALL	LCD_CARACTER
	MOVLW  'D'
	CALL	LCD_CARACTER

	CALL	LCD_FILA2
	MOVLW  'M'
	CALL	LCD_CARACTER
	MOVLW  'A'
	CALL	LCD_CARACTER
	MOVLW  'X'
	CALL	LCD_CARACTER
	MOVLW  'I'
	CALL	LCD_CARACTER
	MOVLW  'M'
	CALL	LCD_CARACTER
	MOVLW  'A'
	CALL	LCD_CARACTER
	MOVLW D'1'
	MOVWF COMANDO
	CLRF CC
	MOVLW 'C'
	MOVWF C0
	GOTO A1

NO_C
	MOVLW 'D'
	SUBWF TECLA,W
	BTFSS STATUS,Z
	GOTO A1
	
	CALL	LCD_BORRA
	CALL	LCD_CURSORON
	CALL	LCD_CURSORINC
	CALL	LCD_FILA1
	MOVLW  'L'
	CALL	LCD_CARACTER
	MOVLW  'U'
	CALL	LCD_CARACTER
	MOVLW  'M'
	CALL	LCD_CARACTER
	MOVLW  'I'
	CALL	LCD_CARACTER
	MOVLW  'N'
	CALL	LCD_CARACTER
	MOVLW  'O'
	CALL	LCD_CARACTER
	MOVLW  'S'
	CALL	LCD_CARACTER
	MOVLW  'I'
	CALL	LCD_CARACTER
	MOVLW  'D'
	CALL	LCD_CARACTER
	MOVLW  'A'
	CALL	LCD_CARACTER
	MOVLW  'D'
	CALL	LCD_CARACTER

	CALL	LCD_FILA2
	MOVLW  'M'
	CALL	LCD_CARACTER
	MOVLW  'I'
	CALL	LCD_CARACTER
	MOVLW  'N'
	CALL	LCD_CARACTER
	MOVLW  'I'
	CALL	LCD_CARACTER
	MOVLW  'M'
	CALL	LCD_CARACTER
	MOVLW  'A'
	CALL	LCD_CARACTER
	MOVLW '='
	CALL LCD_CARACTER
	MOVLW D'1'
	MOVWF COMANDO
	CLRF CC
	MOVLW 'D'
	MOVWF C0
	GOTO A1

	
COMANDO_NO_0
	MOVLW D'47'
	SUBWF TECLA,W
	BTFSS STATUS,C
	GOTO A1
	MOVLW D'59'
	SUBWF TECLA,W
	BTFSC STATUS,C
	GOTO A1
	INCF CC,F
	MOVLW D'1'
	SUBWF CC,W
	BTFSS STATUS,Z
	GOTO CC_NO_1
	MOVF TECLA,W
	MOVWF C1
	MOVF C1,W
	CALL LCD_CARACTER
	GOTO A1
	
CC_NO_1
	MOVLW D'2'
	SUBWF CC,W
	BTFSS STATUS,Z
	GOTO CC_NO_2
	MOVF TECLA,W
	MOVWF CC2
	MOVF CC2,W
	CALL LCD_CARACTER
	GOTO A1
CC_NO_2
	MOVLW D'3'
	SUBWF CC,W
	BTFSS STATUS,Z
	GOTO A1
	MOVF TECLA,W
	MOVWF CC3
	MOVF CC3,W
	CALL LCD_CARACTER
	CALL RETARDO_500MS
	;CLRF H
	;CLRF L
CALCULO_C1_C2_C3
	CLRF MOH
	MOVLW D'100'
	MOVWF MOL
	MOVLW D'48'
	SUBWF C1,W
	MOVWF MRL
	CALL MULTIP_16X8
	MOVF R0,W
	MOVWF L
	MOVF R1,W
	MOVWF H
	
	CLRF MOH
	MOVLW D'10'
	MOVWF MOL
	MOVLW D'48'
	SUBWF CC2,W
	MOVWF MRL
	CALL MULTIP_16X8
	MOVF R0,W
	ADDWF L,F
	MOVF R1,W
	ADDWF H,F
	
	MOVLW D'48'
	SUBWF CC3,W
	ADDWF L,F
	BTFSC STATUS,C
	INCF H,F
	
	;;;;; CALCULO DATOH DATOL
	MOVLW 'A'
	SUBWF C0,W
	BTFSS STATUS,Z
	GOTO NO_ES_MAX_TEMP
	CLRF COMANDO
	CLRF CC
	MOVLW D'4'
	CALL EEPROM_DIRECCION
	MOVF H,W
	CALL EEPROM_ESCRIBIR
	MOVLW D'5'
	CALL EEPROM_DIRECCION
	MOVF L,W
	CALL EEPROM_ESCRIBIR
	GOTO CAMBIO_OK
NO_ES_MAX_TEMP
	MOVLW 'B'
	SUBWF C0,W
	BTFSS STATUS,Z
	GOTO NO_ES_MIN_TEMP
	CLRF COMANDO
	CLRF CC
	MOVLW D'6'
	CALL EEPROM_DIRECCION
	MOVF H,W
	CALL EEPROM_ESCRIBIR
	MOVLW D'7'
	CALL EEPROM_DIRECCION
	MOVF L,W
	CALL EEPROM_ESCRIBIR
	GOTO CAMBIO_OK
NO_ES_MIN_TEMP
	MOVLW 'C'
	SUBWF C0,W
	BTFSS STATUS,Z
	GOTO NO_ES_MAX_LUM
	CLRF COMANDO
	CLRF CC
	MOVLW D'0'
	CALL EEPROM_DIRECCION
	MOVF H,W
	CALL EEPROM_ESCRIBIR
	MOVLW D'1'
	CALL EEPROM_DIRECCION
	MOVF L,W
	CALL EEPROM_ESCRIBIR
	GOTO CAMBIO_OK
NO_ES_MAX_LUM
	MOVLW 'D'
	SUBWF C0,W
	BTFSS STATUS,Z
	GOTO A1
	CLRF COMANDO
	CLRF CC
	MOVLW D'2'
	CALL EEPROM_DIRECCION
	MOVF H,W
	CALL EEPROM_ESCRIBIR
	MOVLW D'3'
	CALL EEPROM_DIRECCION
	MOVF L,W
	CALL EEPROM_ESCRIBIR
	GOTO CAMBIO_OK
CAMBIO_OK
	
	CALL	LCD_BORRA
	CALL	LCD_CURSORON
	CALL	LCD_CURSORINC
	CALL	LCD_FILA1
	MOVLW  'C'
	CALL	LCD_CARACTER
	MOVLW  'A'
	CALL	LCD_CARACTER
	MOVLW  'M'
	CALL	LCD_CARACTER
	MOVLW  'B'
	CALL	LCD_CARACTER
	MOVLW  'I'
	CALL	LCD_CARACTER
	MOVLW  'O'
	CALL	LCD_CARACTER
	MOVLW  ' '
	CALL	LCD_CARACTER
	MOVLW  'O'
	CALL	LCD_CARACTER
	MOVLW  'K'
	CALL	LCD_CARACTER
	GOTO A1	
A1
	CALL ESPERAR_LEVANTAR_DEDO	
	BCF INTCON,RBIF
FIN_INTERRUPCION
	RETFIE
INICIO
	BSF STATUS,RP0
	BCF STATUS,RP1
	MOVLW B'10000100'
	MOVWF ADCON1
	MOVLW B'00000101'
	MOVWF TRISC
	CLRF TRISD
	CLRF TRISE
	MOVLW D'255'
	MOVWF TRISA
	MOVLW B'11110000'
	MOVWF TRISB
	MOVLW B'00100000'
	MOVWF OPTION_REG
	BCF STATUS,RP0
	CALL	LCD_INICIALIZA
	CLRF PORCENTAJE
	
	BCF PORTB,0
	BCF PORTB,1
	BCF PORTB,2
	BCF PORTB,3
	MOVLW B'11100000'
	MOVWF PORTC
	CLRF PORTD
	CLRF PORTE
	CLRF CC
	CLRF COMANDO
	CLRF CONFI
	CLRF INTCON
	CALL ESPERAR_LEVANTAR_DEDO;;;;;; QUITARLO DEPRONTOOOOOO
	
	
	MOVLW D'0'
	CALL EEPROM_DIRECCION
	CALL EEPROM_LEER
	SUBLW D'255'
	BTFSS STATUS,Z
	GOTO EPROM_L_BIEN
	MOVLW D'1'
	CALL EEPROM_DIRECCION
	CALL EEPROM_LEER
	SUBLW D'255'
	BTFSS STATUS,Z
	GOTO EPROM_L_BIEN
	MOVLW D'2'
	CALL EEPROM_DIRECCION
	CALL EEPROM_LEER
	SUBLW D'255'
	BTFSS STATUS,Z
	GOTO EPROM_L_BIEN
	MOVLW D'3'
	CALL EEPROM_DIRECCION
	CALL EEPROM_LEER
	SUBLW D'255'
	BTFSS STATUS,Z
	GOTO EPROM_L_BIEN
	
	MOVLW D'0'
	CALL EEPROM_DIRECCION
	MOVLW D'2'
	CALL EEPROM_ESCRIBIR
	MOVLW D'1'
	CALL EEPROM_DIRECCION
	MOVLW D'238'
	CALL EEPROM_ESCRIBIR
	MOVLW D'2'
	CALL EEPROM_DIRECCION
	MOVLW D'0'
	CALL EEPROM_ESCRIBIR
	MOVLW D'3'
	CALL EEPROM_DIRECCION
	MOVLW D'250'
	CALL EEPROM_ESCRIBIR
EPROM_L_BIEN	

	MOVLW D'4'
	CALL EEPROM_DIRECCION
	CALL EEPROM_LEER
	SUBLW D'255'
	BTFSS STATUS,Z
	GOTO EPROM_T_BIEN
	MOVLW D'5'
	CALL EEPROM_DIRECCION
	CALL EEPROM_LEER
	SUBLW D'255'
	BTFSS STATUS,Z
	GOTO EPROM_T_BIEN
	MOVLW D'6'
	CALL EEPROM_DIRECCION
	CALL EEPROM_LEER
	SUBLW D'255'
	BTFSS STATUS,Z
	GOTO EPROM_T_BIEN
	MOVLW D'7'
	CALL EEPROM_DIRECCION
	CALL EEPROM_LEER
	SUBLW D'255'
	BTFSS STATUS,Z
	GOTO EPROM_T_BIEN
	
	MOVLW D'4'
	CALL EEPROM_DIRECCION
	MOVLW D'0'
	CALL EEPROM_ESCRIBIR
	MOVLW D'5'
	CALL EEPROM_DIRECCION
	MOVLW D'100'
	CALL EEPROM_ESCRIBIR
	MOVLW D'6'
	CALL EEPROM_DIRECCION
	MOVLW D'0'
	CALL EEPROM_ESCRIBIR
	MOVLW D'7'
	CALL EEPROM_DIRECCION
	MOVLW D'10'
	CALL EEPROM_ESCRIBIR
EPROM_T_BIEN
	
	
	BSF INTCON,RBIE;CAMBIO DE B4-B7
	;BSF INTCON,T0IE;TRM0
	;MOVLW D'255'
	;MOVWF TMR0
	BSF INTCON,GIE ;INTERRUPCION GENERAL
PRINCIPAL
	MOVF CONFI,F
	BTFSC STATUS,Z
	GOTO SENSORES ;CERO SENSORES
	SLEEP
	GOTO PRINCIPAL
SENSORES
	BTFSS PORTC,3
	GOTO TECLADO
	
	MOVLW D'10'
	CALL RS232_ESCRIBE
	MOVLW D'13'
	CALL RS232_ESCRIBE
	MOVLW 'A'
	CALL RS232_ESCRIBE
	MOVLW '='
	CALL RS232_ESCRIBE
	MOVLW 'M'
	CALL RS232_ESCRIBE
	MOVLW 'A'
	CALL RS232_ESCRIBE
	MOVLW 'X'
	CALL RS232_ESCRIBE
	MOVLW ' '
	CALL RS232_ESCRIBE
	MOVLW 'T'
	CALL RS232_ESCRIBE
	MOVLW 'E'
	CALL RS232_ESCRIBE
	MOVLW 'M'
	CALL RS232_ESCRIBE
	MOVLW D'10'
	CALL RS232_ESCRIBE
	MOVLW D'13'
	CALL RS232_ESCRIBE
	MOVLW 'B'
	CALL RS232_ESCRIBE
	MOVLW '='
	CALL RS232_ESCRIBE
	MOVLW 'M'
	CALL RS232_ESCRIBE
	MOVLW 'I'
	CALL RS232_ESCRIBE
	MOVLW 'N'
	CALL RS232_ESCRIBE
	MOVLW ' '
	CALL RS232_ESCRIBE
	MOVLW 'T'
	CALL RS232_ESCRIBE
	MOVLW 'E'
	CALL RS232_ESCRIBE
	MOVLW 'M'
	CALL RS232_ESCRIBE
	MOVLW D'10'
	CALL RS232_ESCRIBE
	MOVLW D'13'
	CALL RS232_ESCRIBE
	MOVLW 'C'
	CALL RS232_ESCRIBE
	MOVLW '='
	CALL RS232_ESCRIBE
	MOVLW 'M'
	CALL RS232_ESCRIBE
	MOVLW 'A'
	CALL RS232_ESCRIBE
	MOVLW 'X'
	CALL RS232_ESCRIBE
	MOVLW ' '
	CALL RS232_ESCRIBE
	MOVLW 'L'
	CALL RS232_ESCRIBE
	MOVLW 'U'
	CALL RS232_ESCRIBE
	MOVLW 'M'
	CALL RS232_ESCRIBE
	MOVLW D'10'
	CALL RS232_ESCRIBE
	MOVLW D'13'
	CALL RS232_ESCRIBE
	MOVLW 'D'
	CALL RS232_ESCRIBE
	MOVLW '='
	CALL RS232_ESCRIBE
	MOVLW 'M'
	CALL RS232_ESCRIBE
	MOVLW 'I'
	CALL RS232_ESCRIBE
	MOVLW 'N'
	CALL RS232_ESCRIBE
	MOVLW ' '
	CALL RS232_ESCRIBE
	MOVLW 'L'
	CALL RS232_ESCRIBE
	MOVLW 'U'
	CALL RS232_ESCRIBE
	MOVLW 'M'
	CALL RS232_ESCRIBE
	MOVLW D'10'
	CALL RS232_ESCRIBE
	MOVLW D'13'
	CALL RS232_ESCRIBE
	MOVLW 'E'
	CALL RS232_ESCRIBE
	MOVLW '='
	CALL RS232_ESCRIBE
	MOVLW 'S'
	CALL RS232_ESCRIBE
	MOVLW 'A'
	CALL RS232_ESCRIBE
	MOVLW 'L'
	CALL RS232_ESCRIBE
	MOVLW 'I'
	CALL RS232_ESCRIBE
	MOVLW 'R'
	CALL RS232_ESCRIBE
	MOVLW D'10'
	CALL RS232_ESCRIBE
	MOVLW D'13'
	CALL RS232_ESCRIBE
LEER_RS232

	CALL RS232_LEE
	MOVWF NUMERO_RS232
	CALL RS232_ESCRIBE
	MOVLW D'65'
	SUBWF NUMERO_RS232,W
	BTFSS STATUS,Z
	GOTO NO_ES_A
	MOVLW ' '
	CALL RS232_ESCRIBE
	MOVLW 'M'
	CALL RS232_ESCRIBE
	MOVLW 'A'
	CALL RS232_ESCRIBE
	MOVLW 'X'
	CALL RS232_ESCRIBE
	MOVLW ' '
	CALL RS232_ESCRIBE
	MOVLW 'T'
	CALL RS232_ESCRIBE
	MOVLW 'E'
	CALL RS232_ESCRIBE
	MOVLW 'M'
	CALL RS232_ESCRIBE
	MOVLW 'P'
	CALL RS232_ESCRIBE
	MOVLW 'E'
	CALL RS232_ESCRIBE
	MOVLW 'R'
	CALL RS232_ESCRIBE
	MOVLW 'A'
	CALL RS232_ESCRIBE
	MOVLW 'T'
	CALL RS232_ESCRIBE
	MOVLW 'U'
	CALL RS232_ESCRIBE
	MOVLW 'R'
	CALL RS232_ESCRIBE
	MOVLW 'A'
	CALL RS232_ESCRIBE
	MOVLW '='
	CALL RS232_ESCRIBE
	MOVLW 'A'
	MOVWF C0
	GOTO EVALUAR_NUMERO
NO_ES_A
	MOVLW D'66'
	SUBWF NUMERO_RS232,W
	BTFSS STATUS,Z
	GOTO NO_ES_B
	MOVLW ' '
	CALL RS232_ESCRIBE
	MOVLW 'M'
	CALL RS232_ESCRIBE
	MOVLW 'I'
	CALL RS232_ESCRIBE
	MOVLW 'N'
	CALL RS232_ESCRIBE
	MOVLW ' '
	CALL RS232_ESCRIBE
	MOVLW 'T'
	CALL RS232_ESCRIBE
	MOVLW 'E'
	CALL RS232_ESCRIBE
	MOVLW 'M'
	CALL RS232_ESCRIBE
	MOVLW 'P'
	CALL RS232_ESCRIBE
	MOVLW 'E'
	CALL RS232_ESCRIBE
	MOVLW 'R'
	CALL RS232_ESCRIBE
	MOVLW 'A'
	CALL RS232_ESCRIBE
	MOVLW 'T'
	CALL RS232_ESCRIBE
	MOVLW 'U'
	CALL RS232_ESCRIBE
	MOVLW 'R'
	CALL RS232_ESCRIBE
	MOVLW 'A'
	CALL RS232_ESCRIBE
	MOVLW '='
	CALL RS232_ESCRIBE
	MOVLW 'B'
	MOVWF C0
	GOTO EVALUAR_NUMERO
NO_ES_B
	MOVLW D'67'
	SUBWF NUMERO_RS232,W
	BTFSS STATUS,Z
	GOTO NO_ES_C
	MOVLW ' '
	CALL RS232_ESCRIBE
	MOVLW 'M'
	CALL RS232_ESCRIBE
	MOVLW 'A'
	CALL RS232_ESCRIBE
	MOVLW 'X'
	CALL RS232_ESCRIBE
	MOVLW ' '
	CALL RS232_ESCRIBE
	MOVLW 'L'
	CALL RS232_ESCRIBE
	MOVLW 'U'
	CALL RS232_ESCRIBE
	MOVLW 'M'
	CALL RS232_ESCRIBE
	MOVLW 'I'
	CALL RS232_ESCRIBE
	MOVLW 'N'
	CALL RS232_ESCRIBE
	MOVLW 'O'
	CALL RS232_ESCRIBE
	MOVLW 'S'
	CALL RS232_ESCRIBE
	MOVLW 'I'
	CALL RS232_ESCRIBE
	MOVLW 'D'
	CALL RS232_ESCRIBE
	MOVLW 'A'
	CALL RS232_ESCRIBE
	MOVLW 'D'
	CALL RS232_ESCRIBE
	MOVLW '='
	CALL RS232_ESCRIBE
	MOVLW 'C'
	MOVWF C0
	GOTO EVALUAR_NUMERO
NO_ES_C
	MOVLW D'68'
	SUBWF NUMERO_RS232,W
	BTFSS STATUS,Z
	GOTO NO_ES_D
	MOVLW ' '
	CALL RS232_ESCRIBE
	MOVLW 'M'
	CALL RS232_ESCRIBE
	MOVLW 'I'
	CALL RS232_ESCRIBE
	MOVLW 'N'
	CALL RS232_ESCRIBE
	MOVLW ' '
	CALL RS232_ESCRIBE
	MOVLW 'L'
	CALL RS232_ESCRIBE
	MOVLW 'U'
	CALL RS232_ESCRIBE
	MOVLW 'M'
	CALL RS232_ESCRIBE
	MOVLW 'I'
	CALL RS232_ESCRIBE
	MOVLW 'N'
	CALL RS232_ESCRIBE
	MOVLW 'O'
	CALL RS232_ESCRIBE
	MOVLW 'S'
	CALL RS232_ESCRIBE
	MOVLW 'I'
	CALL RS232_ESCRIBE
	MOVLW 'D'
	CALL RS232_ESCRIBE
	MOVLW 'A'
	CALL RS232_ESCRIBE
	MOVLW 'D'
	CALL RS232_ESCRIBE
	MOVLW '='
	CALL RS232_ESCRIBE
	MOVLW 'D'
	MOVWF C0
	GOTO EVALUAR_NUMERO
NO_ES_D
	MOVLW D'69'
	SUBWF NUMERO_RS232,W
	BTFSS STATUS,Z
	GOTO LEER_RS232
	GOTO PRINCIPAL
	
EVALUAR_NUMERO
	
	CALL RS232_LEE
	MOVWF CEN
	MOVLW D'48'
	SUBWF CEN,W
	BTFSS STATUS,C
	GOTO EVALUAR_NUMERO
	MOVLW D'58'
	SUBWF CEN,W
	BTFSC STATUS,C
	GOTO EVALUAR_NUMERO
	MOVF CEN,W
	CALL RS232_ESCRIBE
	
EVALUAR_NUMEROC2
	CALL RS232_LEE
	MOVWF DEC
	MOVLW D'48'
	SUBWF DEC,W
	BTFSS STATUS,C
	GOTO EVALUAR_NUMEROC2
	MOVLW D'58'
	SUBWF DEC,W
	BTFSC STATUS,C
	GOTO EVALUAR_NUMEROC2
	MOVF DEC,W
	CALL RS232_ESCRIBE
	
EVALUAR_NUMERO_C3
	CALL RS232_LEE
	MOVWF UNI
	MOVLW D'48'
	SUBWF UNI,W
	BTFSS STATUS,C
	GOTO EVALUAR_NUMERO_C3
	MOVLW D'58'
	SUBWF UNI,W
	BTFSC STATUS,C
	GOTO EVALUAR_NUMERO_C3
	MOVF UNI,W
	CALL RS232_ESCRIBE
	
	CLRF L
	CLRF H
	
	MOVF UNI,W
	MOVWF CC3
	MOVF DEC,W
	MOVWF CC2
	MOVF CEN,W
	MOVWF C1
	CALL CALCULO_C1_C2_C3	
	GOTO PRINCIPAL
TECLADO

	CLRF COMANDO
	CLRF CC
	
	;0=MAXH LUM
	;1=MAXL LUM
	;2=MINH LUM
	;3=MINL LUM
	;4=MAXTH TEM
	;5=MAXTL TEM
	;6=MINTH TEM
	;7=MINTL TEM
	MOVLW D'0'
	CALL EEPROM_DIRECCION
	CALL EEPROM_LEER
	MOVWF MAXH
	MOVLW D'1'
	CALL EEPROM_DIRECCION
	CALL EEPROM_LEER
	MOVWF MAXL
	MOVLW D'2'
	CALL EEPROM_DIRECCION
	CALL EEPROM_LEER
	MOVWF MINH
	MOVLW D'3'
	CALL EEPROM_DIRECCION
	CALL EEPROM_LEER
	MOVWF MINL
	
	MOVLW D'4'
	CALL EEPROM_DIRECCION
	CALL EEPROM_LEER
	MOVWF MAXTH
	MOVLW D'5'
	CALL EEPROM_DIRECCION
	CALL EEPROM_LEER
	MOVWF MAXTL
	MOVLW D'6'
	CALL EEPROM_DIRECCION
	CALL EEPROM_LEER
	MOVWF MINTH
	MOVLW D'7'
	CALL EEPROM_DIRECCION
	CALL EEPROM_LEER
	MOVWF MINTL
	
	MOVF MINTH,W
	SUBWF MAXTH,W
	BTFSC STATUS,Z
	GOTO EVALUAR_L_TEMP
	MOVF MINTH,W
	SUBWF MAXTH,W
	BTFSS STATUS,C
	GOTO ERROR_PARAMETROS_TEM
	GOTO EVALUAR_SENSOR_LUM
EVALUAR_L_TEMP
	MOVF MINTL,W
	SUBWF MAXTL,W
	BTFSC STATUS,Z
	GOTO ERROR_PARAMETROS_TEM
	MOVF MINTL,W
	SUBWF MAXTL,W
	BTFSC STATUS,C
	GOTO EVALUAR_SENSOR_LUM
	
ERROR_PARAMETROS_TEM
	CALL ERROR_PARAMETROS
	MOVLW  'T'
	CALL	LCD_CARACTER
	MOVLW  'E'
	CALL	LCD_CARACTER
	MOVLW  'M'
	CALL	LCD_CARACTER
	MOVLW  'P'
	CALL	LCD_CARACTER
	CALL RETARDO_1S
	MOVLW D'48'
	ADDWF MINTL,W
	CALL LCD_CARACTER
	CALL RETARDO_1S
	
	
	MOVLW D'4'
	CALL EEPROM_DIRECCION
	MOVLW D'0'
	CALL EEPROM_ESCRIBIR
	MOVLW D'5'
	CALL EEPROM_DIRECCION
	MOVLW D'100'
	CALL EEPROM_ESCRIBIR
	MOVLW D'6'
	CALL EEPROM_DIRECCION
	MOVLW D'0'
	CALL EEPROM_ESCRIBIR
	MOVLW D'7'
	CALL EEPROM_DIRECCION
	MOVLW D'10'
	CALL EEPROM_ESCRIBIR
	
EVALUAR_SENSOR_LUM
	MOVF MINH,W
	SUBWF MAXH,W
	BTFSC STATUS,Z
	GOTO EVALUAR_L_LUM
	MOVF MINH,W
	SUBWF MAXH,W
	BTFSS STATUS,C
	GOTO ERROR_PARAMETROS_LUM
	GOTO PARAMETROS_BIEN
EVALUAR_L_LUM
	MOVF MINL,W
	SUBWF MAXL,W
	BTFSC STATUS,Z
	GOTO ERROR_PARAMETROS_LUM
	MOVF MINL,W
	SUBWF MAXL,W
	BTFSC STATUS,C
	GOTO PARAMETROS_BIEN

ERROR_PARAMETROS_LUM
	CALL ERROR_PARAMETROS
	MOVLW  'L'
	CALL	LCD_CARACTER
	MOVLW  'U'
	CALL	LCD_CARACTER
	MOVLW  'M'
	CALL	LCD_CARACTER
	CALL RETARDO_1S
	
	MOVLW D'0'
	CALL EEPROM_DIRECCION
	MOVLW D'2'
	CALL EEPROM_ESCRIBIR
	MOVLW D'1'
	CALL EEPROM_DIRECCION
	MOVLW D'238'
	CALL EEPROM_ESCRIBIR
	MOVLW D'2'
	CALL EEPROM_DIRECCION
	MOVLW D'0'
	CALL EEPROM_ESCRIBIR
	MOVLW D'3'
	CALL EEPROM_DIRECCION
	MOVLW D'250'
	CALL EEPROM_ESCRIBIR
	
PARAMETROS_BIEN
	CALL	LCD_BORRA
	CALL	LCD_CURSORON
	CALL	LCD_CURSORINC
	MOVLW B'10000011'
	MOVWF ADCON0
	CALL LEER_CONVER
	MOVF DATOL,W
	MOVWF DIVIDENDOL	
	MOVF DATOH,W
	MOVWF DIVIDENDOH
	MOVLW D'61'
	MOVWF DIVISOR
	CALL DIVI_16_8
	MOVF COCIENTEL,W
	MOVWF MOL
	MOVF COCIENTEH,W
	MOVWF MOH
	MOVLW D'125'
	MOVWF MRL
	CALL MULTIP_16X8
	MOVF R0,W
	MOVWF DATOL
	MOVF R1,W
	MOVWF DATOH
	CALL BYTE_MCDU
	
	BSF BOM
	MOVF DATOH,W
	SUBWF MINH,W
	BTFSC STATUS,Z
	GOTO EVALUAR_MAX_L
	MOVF DATOH,W
	SUBWF MINH,W
	BTFSC STATUS,C
	BCF BOM
	GOTO SEGUIR_BOM
EVALUAR_MAX_L
	MOVF DATOL,W
	SUBWF MINL,W
	BTFSC STATUS,C
	BCF BOM
SEGUIR_BOM

	CALL	LCD_BORRA
	CALL	LCD_CURSORON
	CALL	LCD_CURSORINC
	CALL	LCD_FILA1
	MOVLW  'L'
	CALL	LCD_CARACTER
	MOVLW  'U'
	CALL	LCD_CARACTER
	MOVLW  'M'
	CALL	LCD_CARACTER
	MOVLW  'I'
	CALL	LCD_CARACTER
	MOVLW  'N'
	CALL	LCD_CARACTER
	MOVLW  'O'
	CALL	LCD_CARACTER
	MOVLW  'S'
	CALL	LCD_CARACTER
	MOVLW  'I'
	CALL	LCD_CARACTER
	MOVLW  'D'
	CALL	LCD_CARACTER
	MOVLW  'A'
	CALL	LCD_CARACTER
	MOVLW  'D'
	CALL	LCD_CARACTER
	MOVLW  '='
	CALL	LCD_CARACTER
	MOVLW  .48
	ADDWF MIL,W
	CALL	LCD_CARACTER
	MOVLW  .48
	ADDWF CEN,W
	CALL	LCD_CARACTER
	MOVLW  .48
	ADDWF DEC,W
	CALL	LCD_CARACTER
	MOVLW  .48
	ADDWF UNI,W
	CALL	LCD_CARACTER
	
	MOVLW B'10001011'
	MOVWF ADCON0
	CALL LEER_CONVER
	MOVF DATOL,W
	MOVWF TEMPL
	MOVF DATOH,W
	MOVWF TEMPH
	BTFSS STATUS,Z
	GOTO POSITIVO
	MOVLW .82
	SUBWF TEMPL,W
	BTFSS STATUS,C	
	GOTO NEGATIVO
	GOTO POSITIVO	
POSITIVO
	MOVLW .82
	SUBWF TEMPL,F
	BTFSS STATUS,C
	DECF TEMPH,F
	BCF STATUS,C
	RRF TEMPH,F
	RRF TEMPL,F
	BCF STATUS,C
	RRF TEMPH,F
	RRF TEMPL,F
	MOVF TEMPL,W
	MOVWF DATOL
	MOVF TEMPH,W
	MOVWF DATOH
	CALL BYTE_MCDU
	MOVLW .43
	MOVWF MOSTRAR
	
	BSF CAL
	MOVF DATOH,W
	SUBWF MINTH,W
	BTFSC STATUS,Z
	GOTO EVALUAR_MIN_T
	MOVF DATOH,W
	SUBWF MINTH,W
	BTFSC STATUS,C
	BCF CAL
	GOTO SEGUIR_CAL
EVALUAR_MIN_T
	MOVF DATOL,W
	SUBWF MINTL,W
	BTFSC STATUS,C
	BCF CAL
SEGUIR_CAL
	
	BSF VEN
	MOVF DATOH,W
	SUBWF MAXTH,W
	BTFSC STATUS,Z
	GOTO EVALUAR_MAX_T
	MOVF DATOH,W
	SUBWF MAXTH,W
	BTFSS STATUS,C
	BCF VEN
	GOTO SEGUIR_VEN
EVALUAR_MAX_T
	MOVF DATOL,W
	SUBWF MAXTL,W
	BTFSS STATUS,C
	BCF VEN
SEGUIR_VEN
	
	GOTO MCP9701
NEGATIVO
	BCF STATUS,C
	RRF TEMPL,F
	BCF STATUS,C
	RRF TEMPL,F
	MOVF TEMPL,W
	SUBLW .20
	MOVWF DATO
	CALL BYTE_CDU
	MOVLW .45
	MOVWF MOSTRAR
	BCF CAL
MCP9701
	CALL	LCD_FILA2
	MOVLW  'T'
	CALL	LCD_CARACTER
	MOVLW  'E'
	CALL	LCD_CARACTER
	MOVLW  'M'
	CALL	LCD_CARACTER
	MOVLW  'P'
	CALL	LCD_CARACTER
	MOVLW  'E'
	CALL	LCD_CARACTER
	MOVLW  'R'
	CALL	LCD_CARACTER
	MOVLW  'A'
	CALL	LCD_CARACTER
	MOVLW  'T'
	CALL	LCD_CARACTER
	MOVLW  'U'
	CALL	LCD_CARACTER
	MOVLW  'R'
	CALL	LCD_CARACTER
	MOVLW  'A'
	CALL	LCD_CARACTER
	MOVLW  '='
	CALL	LCD_CARACTER
	MOVF MOSTRAR,W
	CALL	LCD_CARACTER
	MOVLW  .48
	ADDWF CEN,W
	CALL	LCD_CARACTER
	MOVLW  .48
	ADDWF DEC,W
	CALL	LCD_CARACTER
	MOVLW  .48
	ADDWF UNI,W
	CALL	LCD_CARACTER
	CALL RETARDO_1S
	CALL RETARDO_1S
	
	CALL	LCD_BORRA
	CALL	LCD_CURSORON
	CALL	LCD_CURSORINC
	CALL	LCD_FILA1
	MOVLW  'L'
	CALL	LCD_CARACTER
	MOVLW  'M'
	CALL	LCD_CARACTER
	MOVLW  'A'
	CALL	LCD_CARACTER
	MOVLW  'X'
	CALL	LCD_CARACTER
	MOVLW  '='
	CALL	LCD_CARACTER
	
	MOVF MAXL,W
	MOVWF DATOL
	MOVF MAXH,W
	MOVWF DATOH
	CALL BYTE_MCDU
	MOVLW  .48
	ADDWF CEN,W
	CALL	LCD_CARACTER
	MOVLW  .48
	ADDWF DEC,W
	CALL	LCD_CARACTER
	MOVLW  .48
	ADDWF UNI,W
	CALL	LCD_CARACTER
	
	MOVLW  ' '
	CALL	LCD_CARACTER
	MOVLW  'M'
	CALL	LCD_CARACTER
	MOVLW  'I'
	CALL	LCD_CARACTER
	MOVLW  'N'
	CALL	LCD_CARACTER
	MOVLW  '='
	CALL	LCD_CARACTER
	
	MOVF MINL,W
	MOVWF DATOL
	MOVF MINH,W
	MOVWF DATOH
	CALL BYTE_MCDU
	MOVLW  .48
	ADDWF CEN,W
	CALL	LCD_CARACTER
	MOVLW  .48
	ADDWF DEC,W
	CALL	LCD_CARACTER
	MOVLW  .48
	ADDWF UNI,W
	CALL	LCD_CARACTER
	
	CALL	LCD_FILA2
	MOVLW  'T'
	CALL	LCD_CARACTER
	MOVLW  'M'
	CALL	LCD_CARACTER
	MOVLW  'A'
	CALL	LCD_CARACTER
	MOVLW  'X'
	CALL	LCD_CARACTER
	MOVLW  '='
	CALL	LCD_CARACTER
	
	MOVF MAXTL,W
	MOVWF DATOL
	MOVF MAXTH,W
	MOVWF DATOH
	CALL BYTE_MCDU
	MOVLW  .48
	ADDWF CEN,W
	CALL	LCD_CARACTER
	MOVLW  .48
	ADDWF DEC,W
	CALL	LCD_CARACTER
	MOVLW  .48
	ADDWF UNI,W
	CALL	LCD_CARACTER
	
	MOVLW  ' '
	CALL	LCD_CARACTER
	MOVLW  'M'
	CALL	LCD_CARACTER
	MOVLW  'I'
	CALL	LCD_CARACTER
	MOVLW  'N'
	CALL	LCD_CARACTER
	MOVLW  '='
	CALL	LCD_CARACTER
	
	MOVF MINTL,W
	MOVWF DATOL
	MOVF MINTH,W
	MOVWF DATOH
	CALL BYTE_MCDU
	MOVLW  .48
	ADDWF CEN,W
	CALL	LCD_CARACTER
	MOVLW  .48
	ADDWF DEC,W
	CALL	LCD_CARACTER
	MOVLW  .48
	ADDWF UNI,W
	CALL	LCD_CARACTER
	
	CALL RETARDO_1S
	CALL RETARDO_1S
	
	GOTO PRINCIPAL
	
	INCLUDE<RETARDOS.INC>
	INCLUDE<VISUALIZAR.INC>
	INCLUDE<LCD8BIT.INC>
	INCLUDE<EPROM.INC>
	INCLUDE<RS232.INC>
	END