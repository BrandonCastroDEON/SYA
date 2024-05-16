
_blink:

;one.c,27 :: 		void blink(){
;one.c,29 :: 		for(i=0;i<4;i++){
	CLRF        R1 
L_blink0:
	MOVLW       4
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_blink1
;one.c,30 :: 		LED = ~LED;
	BTG         PORTA+0, 4 
;one.c,31 :: 		Delay_ms(80);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_blink3:
	DECFSZ      R13, 1, 1
	BRA         L_blink3
	DECFSZ      R12, 1, 1
	BRA         L_blink3
	DECFSZ      R11, 1, 1
	BRA         L_blink3
;one.c,29 :: 		for(i=0;i<4;i++){
	INCF        R1, 1 
;one.c,32 :: 		}
	GOTO        L_blink0
L_blink1:
;one.c,33 :: 		}
L_end_blink:
	RETURN      0
; end of _blink

_interrupt:

;one.c,35 :: 		void interrupt(){
;one.c,38 :: 		IOCIF_bit = 0;
	BCF         IOCIF_bit+0, BitPos(IOCIF_bit+0) 
;one.c,39 :: 		RC0_READ = PORTC;
	MOVF        PORTC+0, 0 
	MOVWF       _RC0_READ+0 
	MOVLW       0
	MOVWF       _RC0_READ+1 
;one.c,40 :: 		RC0_READ = RC0_READ >> 7;
	MOVLW       7
	MOVWF       R0 
	MOVF        R0, 0 
L__interrupt11:
	BZ          L__interrupt12
	RRCF        _RC0_READ+1, 1 
	RRCF        _RC0_READ+0, 1 
	BCF         _RC0_READ+1, 7 
	ADDLW       255
	GOTO        L__interrupt11
L__interrupt12:
;one.c,42 :: 		A1 = 1;
	BSF         PORTA+0, 5 
;one.c,56 :: 		}
L_end_interrupt:
L__interrupt10:
	RETFIE      1
; end of _interrupt

_InitMCU:

;one.c,58 :: 		void InitMCU(){
;one.c,60 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;one.c,62 :: 		ANSELC = 0; // Ponemos los pines del puerto C en modo digital
	CLRF        ANSELC+0 
;one.c,63 :: 		ANSELE = 0; // Ponemos los pines del puerto E en modo digital
	CLRF        ANSELE+0 
;one.c,64 :: 		ANSELA = 0; // Ponemos los pines del puerto A en modo digital
	CLRF        ANSELA+0 
;one.c,66 :: 		TRISC = 0x03; // Indicamos que C0 y C1 en el puerto C quedan en modo entrada, los demas en modo salida
	MOVLW       3
	MOVWF       TRISC+0 
;one.c,67 :: 		TRISE = 0x00; // Indicamos que el puerto E queda en modo salida
	CLRF        TRISE+0 
;one.c,68 :: 		TRISA = 0x00; // Indicamos que el puerto A queda en modo salida
	CLRF        TRISA+0 
;one.c,70 :: 		PORTC = 0x00; // Ponemos al puerto C en ceros
	CLRF        PORTC+0 
;one.c,71 :: 		PORTE = 0x00; // Ponemos al puerto E en ceros
	CLRF        PORTE+0 
;one.c,72 :: 		PORTA = 0x10; // Ponemos al puerto A en ceros
	MOVLW       16
	MOVWF       PORTA+0 
;one.c,74 :: 		LATC = 0x00; // Establecemos en cero el registro del puerto C
	CLRF        LATC+0 
;one.c,75 :: 		LATE = 0x00; // Establecemos en cero el registro del puerto E
	CLRF        LATE+0 
;one.c,76 :: 		LATA = 0x10; // Establecemos en cero el registro del puerto A
	MOVLW       16
	MOVWF       LATA+0 
;one.c,78 :: 		bool_once = TRUE;
	BSF         _flags+0, 0 
;one.c,80 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU

_InitInterrupt:

;one.c,82 :: 		void InitInterrupt(){
;one.c,83 :: 		PIE0.IOCIE = 1;
	BSF         PIE0+0, 4 
;one.c,84 :: 		PIR0.IOCIF = 0;
	BCF         PIR0+0, 4 
;one.c,85 :: 		IOCCP0_bit = 0;
	BCF         IOCCP0_bit+0, BitPos(IOCCP0_bit+0) 
;one.c,86 :: 		IOCCF0_bit = 0;
	BCF         IOCCF0_bit+0, BitPos(IOCCF0_bit+0) 
;one.c,87 :: 		GIE_bit = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;one.c,88 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_main:

;one.c,90 :: 		void main() {
;one.c,92 :: 		InitMCU();
	CALL        _InitMCU+0, 0
;one.c,93 :: 		InitInterrupt();
	CALL        _InitInterrupt+0, 0
;one.c,95 :: 		blink();
	CALL        _blink+0, 0
;one.c,97 :: 		do{
L_main4:
;one.c,98 :: 		Delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_main7:
	DECFSZ      R13, 1, 1
	BRA         L_main7
	DECFSZ      R12, 1, 1
	BRA         L_main7
	NOP
;one.c,99 :: 		}while(1);
	GOTO        L_main4
;one.c,109 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
