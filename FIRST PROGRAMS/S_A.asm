
_main:

;S_A.c,6 :: 		void main() {
;S_A.c,8 :: 		ADCON1 = 0x0F; // Desactivamos los niveles TTL del PIC
	MOVLW       15
	MOVWF       ADCON1+0 
;S_A.c,10 :: 		ANSELC = 0; // Ponemos los pines del puerto C en modo digital
	CLRF        ANSELC+0 
;S_A.c,11 :: 		ANSELE = 0; // Ponemos los pines del puerto E en modo digital
	CLRF        ANSELE+0 
;S_A.c,12 :: 		ANSELA = 0; // Ponemos los pines del puerto A en modo digital
	CLRF        ANSELA+0 
;S_A.c,14 :: 		TRISC = 0x03; // Indicamos que C0 y C1 en el puerto C quedan en modo entrada, los demas en modo salida
	MOVLW       3
	MOVWF       TRISC+0 
;S_A.c,15 :: 		TRISE = 0x00; // Indicamos que el puerto E queda en modo salida
	CLRF        TRISE+0 
;S_A.c,16 :: 		TRISA = 0x00; // Indicamos que el puerto A queda en modo salida
	CLRF        TRISA+0 
;S_A.c,18 :: 		PORTC = 0x00; // Ponemos al puerto C en ceros
	CLRF        PORTC+0 
;S_A.c,19 :: 		PORTE = 0x00; // Ponemos al puerto E en ceros
	CLRF        PORTE+0 
;S_A.c,20 :: 		PORTA = 0x00; // Ponemos al puerto A en ceros
	CLRF        PORTA+0 
;S_A.c,22 :: 		LATC = 0x00; // Establecemos en cero el registro del puerto C
	CLRF        LATC+0 
;S_A.c,23 :: 		LATE = 0x00; // Establecemos en cero el registro del puerto E
	CLRF        LATE+0 
;S_A.c,24 :: 		LATA = 0x00; // Establecemos en cero el registro del puerto A
	CLRF        LATA+0 
;S_A.c,26 :: 		AR1 = 0; // Reiniciamos los registros del actuador 1 en cero
	CLRF        _AR1+0 
	CLRF        _AR1+1 
;S_A.c,27 :: 		AR2 = 0; // Reiniciamos los registros del actuador 2 en cero
	CLRF        _AR2+0 
	CLRF        _AR2+1 
;S_A.c,29 :: 		do{
L_main0:
;S_A.c,32 :: 		if(RC0_bit == 0){
	BTFSC       RC0_bit+0, BitPos(RC0_bit+0) 
	GOTO        L_main3
;S_A.c,33 :: 		Flag01 = 1; // Ponemos en 1 la bandera si el sensor 1 fue activado
	BSF         _Flag01+0, BitPos(_Flag01+0) 
;S_A.c,35 :: 		}
	GOTO        L_main4
L_main3:
;S_A.c,37 :: 		else if(RC0_bit == 1){
	BTFSS       RC0_bit+0, BitPos(RC0_bit+0) 
	GOTO        L_main5
;S_A.c,38 :: 		Flag01 = 0; // Ponemos en 0 la bandera si el sensor 1 fue desactivado
	BCF         _Flag01+0, BitPos(_Flag01+0) 
;S_A.c,40 :: 		}
L_main5:
L_main4:
;S_A.c,43 :: 		if(RC1_bit == 0){
	BTFSC       RC1_bit+0, BitPos(RC1_bit+0) 
	GOTO        L_main6
;S_A.c,44 :: 		Flag02 = 1; // Ponemos en 1 la bandera si el sensor 2 fue activado
	BSF         _Flag02+0, BitPos(_Flag02+0) 
;S_A.c,46 :: 		}
	GOTO        L_main7
L_main6:
;S_A.c,48 :: 		else if(RC1_bit == 1){
	BTFSS       RC1_bit+0, BitPos(RC1_bit+0) 
	GOTO        L_main8
;S_A.c,49 :: 		Flag02 = 0; // Ponemos en 0 la bandera si el sensor 2 fue desactivado
	BCF         _Flag02+0, BitPos(_Flag02+0) 
;S_A.c,51 :: 		}
L_main8:
L_main7:
;S_A.c,57 :: 		Delay_ms(100); // Delay de 100 ms para que el cambio en la bandera sea hecho
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main9:
	DECFSZ      R13, 1, 1
	BRA         L_main9
	DECFSZ      R12, 1, 1
	BRA         L_main9
	DECFSZ      R11, 1, 1
	BRA         L_main9
	NOP
	NOP
;S_A.c,60 :: 		if(Flag01 = 1 && RC0_bit == 0){
	BTFSC       RC0_bit+0, BitPos(RC0_bit+0) 
	GOTO        L_main11
	MOVLW       1
	MOVWF       R0 
	GOTO        L_main10
L_main11:
	CLRF        R0 
L_main10:
	BTFSC       R0, 0 
	GOTO        L__main27
	BCF         _Flag01+0, BitPos(_Flag01+0) 
	GOTO        L__main28
L__main27:
	BSF         _Flag01+0, BitPos(_Flag01+0) 
L__main28:
	BTFSS       _Flag01+0, BitPos(_Flag01+0) 
	GOTO        L_main12
;S_A.c,63 :: 		if(AR1 > AR2){
	MOVF        _AR1+1, 0 
	SUBWF       _AR2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main29
	MOVF        _AR1+0, 0 
	SUBWF       _AR2+0, 0 
L__main29:
	BTFSC       STATUS+0, 0 
	GOTO        L_main13
;S_A.c,66 :: 		LATE = 0x02;
	MOVLW       2
	MOVWF       LATE+0 
;S_A.c,67 :: 		AR2 = AR2 + 1; // Incrementamos en 1 el contador del actuador 2
	INFSNZ      _AR2+0, 1 
	INCF        _AR2+1, 1 
;S_A.c,69 :: 		Flag01 = 0;
	BCF         _Flag01+0, BitPos(_Flag01+0) 
;S_A.c,70 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main14:
	DECFSZ      R13, 1, 1
	BRA         L_main14
	DECFSZ      R12, 1, 1
	BRA         L_main14
	DECFSZ      R11, 1, 1
	BRA         L_main14
	NOP
	NOP
;S_A.c,72 :: 		}
	GOTO        L_main15
L_main13:
;S_A.c,77 :: 		LATE = 0x01;
	MOVLW       1
	MOVWF       LATE+0 
;S_A.c,78 :: 		AR1 = AR1 + 1; // Incrementamos en 1 el contador del actuador 1
	INFSNZ      _AR1+0, 1 
	INCF        _AR1+1, 1 
;S_A.c,79 :: 		RA4_bit = 1; // LED de Debug
	BSF         RA4_bit+0, BitPos(RA4_bit+0) 
;S_A.c,80 :: 		Flag01 = 0;
	BCF         _Flag01+0, BitPos(_Flag01+0) 
;S_A.c,81 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main16:
	DECFSZ      R13, 1, 1
	BRA         L_main16
	DECFSZ      R12, 1, 1
	BRA         L_main16
	DECFSZ      R11, 1, 1
	BRA         L_main16
	NOP
	NOP
;S_A.c,83 :: 		}
L_main15:
;S_A.c,86 :: 		if(Flag02 = 1 && RC1_bit == 0){
	BTFSC       RC1_bit+0, BitPos(RC1_bit+0) 
	GOTO        L_main18
	MOVLW       1
	MOVWF       R0 
	GOTO        L_main17
L_main18:
	CLRF        R0 
L_main17:
	BTFSC       R0, 0 
	GOTO        L__main30
	BCF         _Flag02+0, BitPos(_Flag02+0) 
	GOTO        L__main31
L__main30:
	BSF         _Flag02+0, BitPos(_Flag02+0) 
L__main31:
	BTFSS       _Flag02+0, BitPos(_Flag02+0) 
	GOTO        L_main19
;S_A.c,89 :: 		LATE = 0x03;
	MOVLW       3
	MOVWF       LATE+0 
;S_A.c,91 :: 		AR1 = AR1 + 1; // Incrementamos en 1 el contador del actuador 1
	INFSNZ      _AR1+0, 1 
	INCF        _AR1+1, 1 
;S_A.c,92 :: 		AR2 = AR2 + 1; // Incrementamos en 1 el contador del actuador 2
	INFSNZ      _AR2+0, 1 
	INCF        _AR2+1, 1 
;S_A.c,94 :: 		}
	GOTO        L_main20
L_main19:
;S_A.c,96 :: 		else if(Flag02 = 0 && RC1_bit == 1){
	BCF         _Flag02+0, BitPos(_Flag02+0) 
	BTFSS       _Flag02+0, BitPos(_Flag02+0) 
	GOTO        L_main21
;S_A.c,98 :: 		if(AR1 > AR2){
	MOVF        _AR1+1, 0 
	SUBWF       _AR2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main32
	MOVF        _AR1+0, 0 
	SUBWF       _AR2+0, 0 
L__main32:
	BTFSC       STATUS+0, 0 
	GOTO        L_main22
;S_A.c,100 :: 		LATE = 0x02;
	MOVLW       2
	MOVWF       LATE+0 
;S_A.c,102 :: 		AR2 = AR2 + 1; // Se le suma 1 al contador del registro del actuador 2
	INFSNZ      _AR2+0, 1 
	INCF        _AR2+1, 1 
;S_A.c,104 :: 		}
	GOTO        L_main23
L_main22:
;S_A.c,108 :: 		LATE = 0x01;
	MOVLW       1
	MOVWF       LATE+0 
;S_A.c,110 :: 		AR1 = AR1 + 1; // Se le suma 1 al contador del registro del actuador 1
	INFSNZ      _AR1+0, 1 
	INCF        _AR1+1, 1 
;S_A.c,112 :: 		}
L_main23:
;S_A.c,114 :: 		}
L_main21:
L_main20:
;S_A.c,116 :: 		}
	GOTO        L_main24
L_main12:
;S_A.c,118 :: 		else if (Flag01 = 0 && RC0_bit == 1){
	BCF         _Flag01+0, BitPos(_Flag01+0) 
	BTFSS       _Flag01+0, BitPos(_Flag01+0) 
	GOTO        L_main25
;S_A.c,120 :: 		LATE =  0x00;
	CLRF        LATE+0 
;S_A.c,121 :: 		Flag01 = 0;
	BCF         _Flag01+0, BitPos(_Flag01+0) 
;S_A.c,124 :: 		}
L_main25:
L_main24:
;S_A.c,126 :: 		} while(1);
	GOTO        L_main0
;S_A.c,128 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
