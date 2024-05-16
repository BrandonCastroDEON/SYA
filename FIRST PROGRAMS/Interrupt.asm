
_interrupt:

;Interrupt.c,11 :: 		void interrupt(){
;Interrupt.c,14 :: 		IOCCF = 0x00;
	CLRF        IOCCF+0 
;Interrupt.c,15 :: 		PORTC_READ = PORTC;
	MOVF        PORTC+0, 0 
	MOVWF       _PORTC_READ+0 
	MOVLW       0
	MOVWF       _PORTC_READ+1 
;Interrupt.c,17 :: 		if(PIR0.IOCIF == 1){
	BTFSS       PIR0+0, 4 
	GOTO        L_interrupt0
;Interrupt.c,18 :: 		if(PORTC_READ == 0x01){
	MOVLW       0
	XORWF       _PORTC_READ+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt7
	MOVLW       1
	XORWF       _PORTC_READ+0, 0 
L__interrupt7:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt1
;Interrupt.c,19 :: 		LPLACA = 0;
	BCF         LATA+0, 4 
;Interrupt.c,20 :: 		}
L_interrupt1:
;Interrupt.c,21 :: 		IOCCF = 0x00;
	CLRF        IOCCF+0 
;Interrupt.c,22 :: 		}
L_interrupt0:
;Interrupt.c,23 :: 		}
L_end_interrupt:
L__interrupt6:
	RETFIE      1
; end of _interrupt

_main:

;Interrupt.c,25 :: 		void main() {
;Interrupt.c,27 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;Interrupt.c,29 :: 		ANSELC = 0;
	CLRF        ANSELC+0 
;Interrupt.c,30 :: 		ANSELA = 0;
	CLRF        ANSELA+0 
;Interrupt.c,32 :: 		TRISC = 0x01; // C0 y C1 quedan como entradas, los demas en salidas
	MOVLW       1
	MOVWF       TRISC+0 
;Interrupt.c,33 :: 		TRISA = 0x00; // Puerto A como salida
	CLRF        TRISA+0 
;Interrupt.c,35 :: 		PORTC = 0x00; // Dejamos C0 en linea alta
	CLRF        PORTC+0 
;Interrupt.c,36 :: 		PORTA = 0x10; // Dejamos A4 en linea alta y los demas en linea baja
	MOVLW       16
	MOVWF       PORTA+0 
;Interrupt.c,38 :: 		LATC = 0x00; // Dejamos el registro de C0 en linea alta
	CLRF        LATC+0 
;Interrupt.c,39 :: 		LATA = 0x10; // Dejamos el registro de A4 en linea alta
	MOVLW       16
	MOVWF       LATA+0 
;Interrupt.c,41 :: 		INTCON.IPEN = 0;
	BCF         INTCON+0, 5 
;Interrupt.c,42 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;Interrupt.c,44 :: 		PIR0.IOCIF = 0;
	BCF         PIR0+0, 4 
;Interrupt.c,45 :: 		PIE0.IOCIE = 0;
	BCF         PIE0+0, 4 
;Interrupt.c,47 :: 		IOCCF = 0x00;
	CLRF        IOCCF+0 
;Interrupt.c,48 :: 		IOCCP = 0xFF;
	MOVLW       255
	MOVWF       IOCCP+0 
;Interrupt.c,49 :: 		IOCCN = 0xFF;
	MOVLW       255
	MOVWF       IOCCN+0 
;Interrupt.c,50 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;Interrupt.c,52 :: 		WPUC = 0xFF;
	MOVLW       255
	MOVWF       WPUC+0 
;Interrupt.c,54 :: 		while(1){
L_main2:
;Interrupt.c,55 :: 		Delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	NOP
;Interrupt.c,56 :: 		}
	GOTO        L_main2
;Interrupt.c,58 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
