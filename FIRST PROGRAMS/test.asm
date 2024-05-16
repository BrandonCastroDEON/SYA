
_interrupt:

;test.c,12 :: 		void interrupt(){
;test.c,15 :: 		if (PIR0.TMR0IF){
	BTFSS       PIR0+0, 5 
	GOTO        L_interrupt0
;test.c,16 :: 		TMR0L = 0x3B;                              // Se carga la cuenta inicial en 65285 para 1ms.
	MOVLW       59
	MOVWF       TMR0L+0 
;test.c,17 :: 		TMR0H = 0xF6;                              // ''
	MOVLW       246
	MOVWF       TMR0H+0 
;test.c,18 :: 		cuenta++;
	MOVLW       1
	ADDWF       _cuenta+0, 1 
	MOVLW       0
	ADDWFC      _cuenta+1, 1 
	ADDWFC      _cuenta+2, 1 
	ADDWFC      _cuenta+3, 1 
;test.c,19 :: 		if(LATCH){
	BTFSS       PORTC+0, 0 
	GOTO        L_interrupt1
;test.c,20 :: 		if(cuenta >= 100){
	MOVLW       128
	XORWF       _cuenta+3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt5
	MOVLW       0
	SUBWF       _cuenta+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt5
	MOVLW       0
	SUBWF       _cuenta+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt5
	MOVLW       100
	SUBWF       _cuenta+0, 0 
L__interrupt5:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt2
;test.c,21 :: 		ACT1 = ~ACT1;
	BTG         LATA+0, 5 
;test.c,22 :: 		}
L_interrupt2:
;test.c,23 :: 		cuenta = 0;
	CLRF        _cuenta+0 
	CLRF        _cuenta+1 
	CLRF        _cuenta+2 
	CLRF        _cuenta+3 
;test.c,24 :: 		}
L_interrupt1:
;test.c,25 :: 		PIR0.TMR0IF = 0;                           // Reinicio de la bandera del bit de interrupción.
	BCF         PIR0+0, 5 
;test.c,26 :: 		}
L_interrupt0:
;test.c,28 :: 		}
L_end_interrupt:
L__interrupt4:
	RETFIE      1
; end of _interrupt

_main:

;test.c,30 :: 		void main() {
;test.c,32 :: 		ANSELC = 0; // Puerto A en digital
	CLRF        ANSELC+0 
;test.c,33 :: 		ANSELE = 0; // Puerto E en digital
	CLRF        ANSELE+0 
;test.c,34 :: 		ANSELA = 0; // Puerto A en digital
	CLRF        ANSELA+0 
;test.c,36 :: 		TRISC = 0x03; // C0 y C1 quedan como entradas, los demas en salidas
	MOVLW       3
	MOVWF       TRISC+0 
;test.c,37 :: 		TRISE = 0x00; // Puerto E como salida
	CLRF        TRISE+0 
;test.c,38 :: 		TRISA = 0x00; // Puerto A como salida
	CLRF        TRISA+0 
;test.c,40 :: 		PORTC = 0x01; // Dejamos C0 en linea alta
	MOVLW       1
	MOVWF       PORTC+0 
;test.c,41 :: 		PORTA = 0x10; // Dejamos A4 en linea alta y los demas en linea baja
	MOVLW       16
	MOVWF       PORTA+0 
;test.c,42 :: 		PORTE = 0x00; // Puerto E en linea baja
	CLRF        PORTE+0 
;test.c,44 :: 		LATC = 0x01; // Dejamos el registro de C0 en linea alta
	MOVLW       1
	MOVWF       LATC+0 
;test.c,45 :: 		LATE = 0x00; // Dejamos el registro del puerto E en linea baja
	CLRF        LATE+0 
;test.c,46 :: 		LATA = 0x10; // Dejamos el registro de A4 en linea alta
	MOVLW       16
	MOVWF       LATA+0 
;test.c,48 :: 		InitInterrupt();
	CALL        _InitInterrupt+0, 0
;test.c,50 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_InitInterrupt:

;test.c,52 :: 		void InitInterrupt(){
;test.c,54 :: 		INTCON = 0xC0;
	MOVLW       192
	MOVWF       INTCON+0 
;test.c,56 :: 		T0CON0 = 0x90;                                        // Timer0 Enable - Timer de 16 bits
	MOVLW       144
	MOVWF       T0CON0+0 
;test.c,57 :: 		T0CON1 = 0x46;                                        // Clock Source Fosc/4 - Prescaler 64
	MOVLW       70
	MOVWF       T0CON1+0 
;test.c,58 :: 		PIE0 = 0x20;                                          // TMR0 Enable Interrupt
	MOVLW       32
	MOVWF       PIE0+0 
;test.c,59 :: 		TMR0L = 0x3B;                                         // La cuenta inicia en 65285 para 1ms, Prescaler 64
	MOVLW       59
	MOVWF       TMR0L+0 
;test.c,60 :: 		TMR0H = 0xF6;                                         // ''
	MOVLW       246
	MOVWF       TMR0H+0 
;test.c,62 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt
