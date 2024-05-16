
_interrupt:

;timer.c,36 :: 		void interrupt(){
;timer.c,38 :: 		if(PIR0.TMR0IF){
	BTFSS       PIR0+0, 5 
	GOTO        L_interrupt0
;timer.c,39 :: 		TMR0H = 0xE1;
	MOVLW       225
	MOVWF       TMR0H+0 
;timer.c,40 :: 		TMR0L = 0x7A;
	MOVLW       122
	MOVWF       TMR0L+0 
;timer.c,42 :: 		if(LATCH){
	BTFSS       PORTC+0, 0 
	GOTO        L_interrupt1
;timer.c,43 :: 		cuenta++;
	INFSNZ      _cuenta+0, 1 
	INCF        _cuenta+1, 1 
;timer.c,44 :: 		if(cuenta >= 50){
	MOVLW       128
	XORWF       _cuenta+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt15
	MOVLW       50
	SUBWF       _cuenta+0, 0 
L__interrupt15:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt2
;timer.c,45 :: 		flag01 = 1;
	BSF         _flag01+0, BitPos(_flag01+0) 
;timer.c,46 :: 		cuenta = 0;
	CLRF        _cuenta+0 
	CLRF        _cuenta+1 
;timer.c,47 :: 		}
L_interrupt2:
;timer.c,48 :: 		}
L_interrupt1:
;timer.c,49 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;timer.c,50 :: 		}
L_interrupt0:
;timer.c,52 :: 		}
L_end_interrupt:
L__interrupt14:
	RETFIE      1
; end of _interrupt

_main:

;timer.c,54 :: 		void main() {
;timer.c,56 :: 		InitMCU();
	CALL        _InitMCU+0, 0
;timer.c,57 :: 		InitInterrupt();
	CALL        _InitInterrupt+0, 0
;timer.c,58 :: 		flag01 = 0;
	BCF         _flag01+0, BitPos(_flag01+0) 
;timer.c,59 :: 		cuenta = 0;
	CLRF        _cuenta+0 
	CLRF        _cuenta+1 
;timer.c,61 :: 		while(1){
L_main3:
;timer.c,62 :: 		estado = 0;
	BCF         _estado+0, BitPos(_estado+0) 
;timer.c,63 :: 		if(flag01){
	BTFSS       _flag01+0, BitPos(_flag01+0) 
	GOTO        L_main5
;timer.c,64 :: 		estado++;
	CLRF        R0 
	BTFSC       _estado+0, BitPos(_estado+0) 
	INCF        R0, 1 
	MOVLW       0
	MOVWF       R1 
	INFSNZ      R0, 1 
	INCF        R1, 1 
	BTFSC       R0, 0 
	GOTO        L__main17
	BCF         _estado+0, BitPos(_estado+0) 
	GOTO        L__main18
L__main17:
	BSF         _estado+0, BitPos(_estado+0) 
L__main18:
;timer.c,65 :: 		estado = estado << 1;
	CLRF        R2 
	BTFSC       _estado+0, BitPos(_estado+0) 
	INCF        R2, 1 
	CLRF        R0 
	INCF        R0, 1 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVF        R2, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__main19:
	BZ          L__main20
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__main19
L__main20:
	BTFSC       R0, 0 
	GOTO        L__main21
	BCF         _estado+0, BitPos(_estado+0) 
	GOTO        L__main22
L__main21:
	BSF         _estado+0, BitPos(_estado+0) 
L__main22:
;timer.c,66 :: 		if((estado == 0xf0000) && (LATCH == 1)){
	BTFSC       _estado+0, BitPos(_estado+0) 
	GOTO        L_main8
	BTFSS       PORTC+0, 0 
	GOTO        L_main8
L__main12:
;timer.c,67 :: 		flag02 = 1;
	BSF         _flag02+0, BitPos(_flag02+0) 
;timer.c,68 :: 		LPLACA = ~LPLACA;
	BTG         LATA+0, 4 
;timer.c,69 :: 		}
	GOTO        L_main9
L_main8:
;timer.c,71 :: 		flag02 = 0;
	BCF         _flag02+0, BitPos(_flag02+0) 
;timer.c,72 :: 		}
L_main9:
;timer.c,73 :: 		}
L_main5:
;timer.c,74 :: 		if(flag02){
	BTFSS       _flag02+0, BitPos(_flag02+0) 
	GOTO        L_main10
;timer.c,75 :: 		ACT1 = ~ACT1;
	BTG         LATA+0, 5 
;timer.c,76 :: 		ACT2 = ~ACT2;
	BTG         LATE+0, 0 
;timer.c,77 :: 		ACT3 = ~ACT3;
	BTG         LATE+0, 1 
;timer.c,78 :: 		ACT4 = ~ACT4;
	BTG         LATE+0, 2 
;timer.c,79 :: 		}
	GOTO        L_main11
L_main10:
;timer.c,81 :: 		ACT1 = 0;
	BCF         LATA+0, 5 
;timer.c,82 :: 		ACT2 = 0;
	BCF         LATE+0, 0 
;timer.c,83 :: 		ACT3 = 0;
	BCF         LATE+0, 1 
;timer.c,84 :: 		ACT4 = 0;
	BCF         LATE+0, 2 
;timer.c,85 :: 		}
L_main11:
;timer.c,86 :: 		}
	GOTO        L_main3
;timer.c,88 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_InitInterrupt:

;timer.c,90 :: 		void InitInterrupt(){
;timer.c,92 :: 		T0CON0 = 0x90;
	MOVLW       144
	MOVWF       T0CON0+0 
;timer.c,93 :: 		T0CON1 = 0x46;
	MOVLW       70
	MOVWF       T0CON1+0 
;timer.c,94 :: 		PIE0.TMR0IE = 1;
	BSF         PIE0+0, 5 
;timer.c,95 :: 		TMR0H = 0xE1;
	MOVLW       225
	MOVWF       TMR0H+0 
;timer.c,96 :: 		TMR0L = 0x7A;
	MOVLW       122
	MOVWF       TMR0L+0 
;timer.c,98 :: 		INTCON = 0xC0;
	MOVLW       192
	MOVWF       INTCON+0 
;timer.c,100 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;timer.c,102 :: 		void InitMCU(){
;timer.c,104 :: 		ADCON1 = 0x0F; // Desactivamos los valores TTL para el PIC
	MOVLW       15
	MOVWF       ADCON1+0 
;timer.c,106 :: 		ANSELC = 0; // Puerto A en digital
	CLRF        ANSELC+0 
;timer.c,107 :: 		ANSELE = 0; // Puerto E en digital
	CLRF        ANSELE+0 
;timer.c,108 :: 		ANSELA = 0; // Puerto A en digital
	CLRF        ANSELA+0 
;timer.c,110 :: 		TRISC = 0x03; // C0 y C1 quedan como entradas, los demas en salidas
	MOVLW       3
	MOVWF       TRISC+0 
;timer.c,111 :: 		TRISE = 0x00; // Puerto E como salida
	CLRF        TRISE+0 
;timer.c,112 :: 		TRISA = 0x00; // Puerto A como salida
	CLRF        TRISA+0 
;timer.c,114 :: 		PORTC = 0x00; // Dejamos C0 en linea alta
	CLRF        PORTC+0 
;timer.c,115 :: 		PORTA = 0x00; // Dejamos A4 en linea alta y los demas en linea baja
	CLRF        PORTA+0 
;timer.c,116 :: 		PORTE = 0x00; // Puerto E en linea baja
	CLRF        PORTE+0 
;timer.c,118 :: 		LATC = 0x00; // Dejamos el registro de C0 en linea alta
	CLRF        LATC+0 
;timer.c,119 :: 		LATE = 0x00; // Dejamos el registro del puerto E en linea baja
	CLRF        LATE+0 
;timer.c,120 :: 		LATA = 0x00; // Dejamos el registro de A4 en linea alta
	CLRF        LATA+0 
;timer.c,121 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
