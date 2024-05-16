
_InitPIC:

;MyProject.c,14 :: 		void InitPIC() {
;MyProject.c,16 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;MyProject.c,18 :: 		ANSELC = 0; // Ponemos los pines del puerto C en modo digital
	CLRF        ANSELC+0 
;MyProject.c,19 :: 		ANSELE = 0; // Ponemos los pines del puerto E en modo digital
	CLRF        ANSELE+0 
;MyProject.c,20 :: 		ANSELA = 0; // Ponemos los pines del puerto A en modo digital
	CLRF        ANSELA+0 
;MyProject.c,22 :: 		TRISC = 0x03; // Indicamos que C0 y C1 en el puerto C quedan en modo entrada, los demas en modo salida
	MOVLW       3
	MOVWF       TRISC+0 
;MyProject.c,23 :: 		TRISE = 0x00; // Indicamos que el puerto E queda en modo salida
	CLRF        TRISE+0 
;MyProject.c,24 :: 		TRISA = 0x00; // Indicamos que el puerto A queda en modo salida
	CLRF        TRISA+0 
;MyProject.c,26 :: 		PORTC = 0x00; // Ponemos al puerto C en ceros
	CLRF        PORTC+0 
;MyProject.c,27 :: 		PORTE = 0x00; // Ponemos al puerto E en ceros
	CLRF        PORTE+0 
;MyProject.c,28 :: 		PORTA = 0x10; // Ponemos al puerto A en ceros
	MOVLW       16
	MOVWF       PORTA+0 
;MyProject.c,30 :: 		LATC = 0x00; // Establecemos en cero el registro del puerto C
	CLRF        LATC+0 
;MyProject.c,31 :: 		LATE = 0x00; // Establecemos en cero el registro del puerto E
	CLRF        LATE+0 
;MyProject.c,32 :: 		LATA = 0x10; // Establecemos en cero el registro del puerto A
	MOVLW       16
	MOVWF       LATA+0 
;MyProject.c,33 :: 		flag01 = 0;
	BCF         _flag01+0, BitPos(_flag01+0) 
;MyProject.c,35 :: 		}
L_end_InitPIC:
	RETURN      0
; end of _InitPIC

_watch:

;MyProject.c,37 :: 		void watch(){
;MyProject.c,47 :: 		if(RC0_bit){
	BTFSS       RC0_bit+0, BitPos(RC0_bit+0) 
	GOTO        L_watch0
;MyProject.c,48 :: 		flag01 = 1;
	BSF         _flag01+0, BitPos(_flag01+0) 
;MyProject.c,49 :: 		}
L_watch0:
;MyProject.c,51 :: 		}
L_end_watch:
	RETURN      0
; end of _watch

_main:

;MyProject.c,53 :: 		void main(){
;MyProject.c,55 :: 		InitPIC();
	CALL        _InitPIC+0, 0
;MyProject.c,56 :: 		watch();
	CALL        _watch+0, 0
;MyProject.c,58 :: 		if(flag01){
	BTFSS       _flag01+0, BitPos(_flag01+0) 
	GOTO        L_main1
;MyProject.c,59 :: 		A1 = 1;
	BSF         PORTE+0, 0 
;MyProject.c,60 :: 		}
L_main1:
;MyProject.c,62 :: 		while(A1==1){
	BTFSS       PORTE+0, 0 
	GOTO        L_main3
;MyProject.c,63 :: 		AR1 = AR1 + 1;
	INCF        _AR1+0, 1 
;MyProject.c,65 :: 		}
L_main3:
;MyProject.c,67 :: 		if(AR1 <= 5){
	MOVF        _AR1+0, 0 
	SUBLW       5
	BTFSS       STATUS+0, 0 
	GOTO        L_main4
;MyProject.c,68 :: 		LED = 0;
	BCF         PORTA+0, 4 
;MyProject.c,69 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
	DECFSZ      R11, 1, 1
	BRA         L_main5
	NOP
	NOP
;MyProject.c,70 :: 		LED = 1;
	BSF         PORTA+0, 4 
;MyProject.c,71 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	DECFSZ      R11, 1, 1
	BRA         L_main6
	NOP
	NOP
;MyProject.c,72 :: 		}
	GOTO        L_main7
L_main4:
;MyProject.c,74 :: 		LED = 0;
	BCF         PORTA+0, 4 
;MyProject.c,75 :: 		}
L_main7:
;MyProject.c,95 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
