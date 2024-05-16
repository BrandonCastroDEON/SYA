
_interrupt:

;two.c,40 :: 		void interrupt(){
;two.c,42 :: 		if (TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_interrupt0
;two.c,43 :: 		TMR0H = 0xFF;
	MOVLW       255
	MOVWF       TMR0H+0 
;two.c,44 :: 		TMR0L = 0xF7;
	MOVLW       247
	MOVWF       TMR0L+0 
;two.c,45 :: 		if(ACT1){
	BTFSS       LATA+0, 5 
	GOTO        L_interrupt1
;two.c,46 :: 		if(bool_interrupt){
	BTFSS       _flags+0, 1 
	GOTO        L_interrupt2
;two.c,47 :: 		LPLACA = 0;
	BCF         LATA+0, 4 
;two.c,48 :: 		AR1 = AR1 + 1;
	MOVLW       1
	ADDWF       _AR1+0, 1 
	MOVLW       0
	ADDWFC      _AR1+1, 1 
	ADDWFC      _AR1+2, 1 
	ADDWFC      _AR1+3, 1 
;two.c,49 :: 		bool_interrupt = FALSE;
	BCF         _flags+0, 1 
;two.c,50 :: 		}
L_interrupt2:
;two.c,51 :: 		}
L_interrupt1:
;two.c,52 :: 		if(ACT2){
	BTFSS       LATE+0, 0 
	GOTO        L_interrupt3
;two.c,53 :: 		if(bool_interrupt){
	BTFSS       _flags+0, 1 
	GOTO        L_interrupt4
;two.c,54 :: 		LPLACA = 0;
	BCF         LATA+0, 4 
;two.c,55 :: 		AR2 = AR2 + 1;
	MOVLW       1
	ADDWF       _AR2+0, 1 
	MOVLW       0
	ADDWFC      _AR2+1, 1 
	ADDWFC      _AR2+2, 1 
	ADDWFC      _AR2+3, 1 
;two.c,56 :: 		bool_interrupt = FALSE;
	BCF         _flags+0, 1 
;two.c,57 :: 		}
L_interrupt4:
;two.c,58 :: 		}
L_interrupt3:
;two.c,59 :: 		TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;two.c,60 :: 		}
L_interrupt0:
;two.c,68 :: 		}
L_end_interrupt:
L__interrupt27:
	RETFIE      1
; end of _interrupt

_main:

;two.c,74 :: 		void main() {
;two.c,76 :: 		InitMCU(); // Iniciamos la configuracion del MCU
	CALL        _InitMCU+0, 0
;two.c,77 :: 		InitInterrupt(); // Iniciamos la configuracion del interrupt
	CALL        _InitInterrupt+0, 0
;two.c,79 :: 		AR1 = 0;
	CLRF        _AR1+0 
	CLRF        _AR1+1 
	CLRF        _AR1+2 
	CLRF        _AR1+3 
;two.c,80 :: 		AR2 = 0;
	CLRF        _AR2+0 
	CLRF        _AR2+1 
	CLRF        _AR2+2 
	CLRF        _AR2+3 
;two.c,82 :: 		if(stop >= 80){
	MOVLW       128
	XORWF       _stop+3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main29
	MOVLW       0
	SUBWF       _stop+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main29
	MOVLW       0
	SUBWF       _stop+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main29
	MOVLW       80
	SUBWF       _stop+0, 0 
L__main29:
	BTFSS       STATUS+0, 0 
	GOTO        L_main5
;two.c,83 :: 		ACT2 = ~ACT2;
	BTG         LATE+0, 0 
;two.c,84 :: 		}
L_main5:
;two.c,87 :: 		while(1){
L_main6:
;two.c,88 :: 		watchdog(); // Iniciamos la rutina de polling para el estado de la bandera
	CALL        _watchdog+0, 0
;two.c,91 :: 		if(flag01 == 1){
	BTFSS       _flag01+0, BitPos(_flag01+0) 
	GOTO        L_main8
;two.c,92 :: 		MUX(); // Iniciamos la rutina del chequeo para el registro
	CALL        _MUX+0, 0
;two.c,95 :: 		switch(multi){
	GOTO        L_main9
;two.c,96 :: 		case 0:
L_main11:
;two.c,97 :: 		ACT1 = ~ACT1;
	BTG         LATA+0, 5 
;two.c,98 :: 		break;
	GOTO        L_main10
;two.c,99 :: 		case 1:
L_main12:
;two.c,100 :: 		ACT2 = ~ACT2;
	BTG         LATE+0, 0 
;two.c,101 :: 		break;
	GOTO        L_main10
;two.c,102 :: 		}
L_main9:
	MOVF        _multi+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
	MOVF        _multi+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main12
L_main10:
;two.c,109 :: 		}
	GOTO        L_main13
L_main8:
;two.c,112 :: 		ACT1 = 0;
	BCF         LATA+0, 5 
;two.c,113 :: 		ACT2 = 0;
	BCF         LATE+0, 0 
;two.c,114 :: 		ACT3 = 0;
	BCF         LATE+0, 1 
;two.c,115 :: 		ACT4 = 0;
	BCF         LATE+0, 2 
;two.c,116 :: 		}
L_main13:
;two.c,117 :: 		}
	GOTO        L_main6
;two.c,119 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_watchdog:

;two.c,125 :: 		void watchdog(){
;two.c,127 :: 		while(1){
L_watchdog14:
;two.c,129 :: 		if(1 == LATCH)continue;
	BTFSS       PORTC+0, 0 
	GOTO        L_watchdog16
	GOTO        L_watchdog14
L_watchdog16:
;two.c,131 :: 		if(0 == LATCH){
	BTFSC       PORTC+0, 0 
	GOTO        L_watchdog17
;two.c,132 :: 		flag01 = 1; // Ponemos la bandera en 1
	BSF         _flag01+0, BitPos(_flag01+0) 
;two.c,133 :: 		}
L_watchdog17:
;two.c,135 :: 		}
L_watchdog15:
;two.c,136 :: 		}
L_end_watchdog:
	RETURN      0
; end of _watchdog

_MUX:

;two.c,142 :: 		void MUX(){
;two.c,144 :: 		if(AR2 > AR1){
	MOVLW       128
	XORWF       _AR1+3, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _AR2+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MUX32
	MOVF        _AR2+2, 0 
	SUBWF       _AR1+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MUX32
	MOVF        _AR2+1, 0 
	SUBWF       _AR1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MUX32
	MOVF        _AR2+0, 0 
	SUBWF       _AR1+0, 0 
L__MUX32:
	BTFSC       STATUS+0, 0 
	GOTO        L_MUX18
;two.c,145 :: 		multi = 0;
	CLRF        _multi+0 
;two.c,146 :: 		}
	GOTO        L_MUX19
L_MUX18:
;two.c,148 :: 		multi = 1;
	MOVLW       1
	MOVWF       _multi+0 
;two.c,149 :: 		}
L_MUX19:
;two.c,151 :: 		}
L_end_MUX:
	RETURN      0
; end of _MUX

_blink:

;two.c,157 :: 		void blink(){
;two.c,159 :: 		while(flag01 == 1){
	BTFSS       _flag01+0, BitPos(_flag01+0) 
	GOTO        L_blink21
;two.c,162 :: 		for(i = 0; i < 4; i++){
	CLRF        R1 
L_blink22:
	MOVLW       4
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_blink23
;two.c,163 :: 		LPLACA = ~LPLACA; // Cambio de estado del LED de la placa
	BTG         LATA+0, 4 
;two.c,164 :: 		Delay_ms(50);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_blink25:
	DECFSZ      R13, 1, 1
	BRA         L_blink25
	DECFSZ      R12, 1, 1
	BRA         L_blink25
	DECFSZ      R11, 1, 1
	BRA         L_blink25
;two.c,162 :: 		for(i = 0; i < 4; i++){
	INCF        R1, 1 
;two.c,165 :: 		}
	GOTO        L_blink22
L_blink23:
;two.c,167 :: 		}
L_blink21:
;two.c,169 :: 		}
L_end_blink:
	RETURN      0
; end of _blink

_InitInterrupt:

;two.c,175 :: 		void InitInterrupt(){
;two.c,177 :: 		PIE0 = 0x10; // Registro Peripheral Interrupt Enable (Bit 4 IOCIE)
	MOVLW       16
	MOVWF       PIE0+0 
;two.c,178 :: 		IOCCF = 0x00; // Seteo en 0 el registro del Interrupt on Change on PORTC Flag
	CLRF        IOCCF+0 
;two.c,179 :: 		IOCCN = 0x00; // Seteo en 0 el registro del Interrupt on Change on PORTC Flag
	CLRF        IOCCN+0 
;two.c,180 :: 		IOCCP = 0x00; // Seteo en 0 el registro del Interrupt on Change on PORTC Flag
	CLRF        IOCCP+0 
;two.c,181 :: 		T0CON0 = 0x90;
	MOVLW       144
	MOVWF       T0CON0+0 
;two.c,182 :: 		T0CON1 = 0x46;
	MOVLW       70
	MOVWF       T0CON1+0 
;two.c,183 :: 		TMR0H = 0xFF;
	MOVLW       255
	MOVWF       TMR0H+0 
;two.c,184 :: 		TMR0L = 0xF7;
	MOVLW       247
	MOVWF       TMR0L+0 
;two.c,185 :: 		INTCON = 0xC0; // Registro INTCON (Bit 7 y 6; GIE y PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;two.c,186 :: 		TMR0IE_bit = 1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;two.c,188 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;two.c,194 :: 		void InitMCU(){
;two.c,196 :: 		ADCON1 = 0x0F; // Desactivamos los valores TTL para el PIC
	MOVLW       15
	MOVWF       ADCON1+0 
;two.c,198 :: 		ANSELC = 0; // Puerto A en digital
	CLRF        ANSELC+0 
;two.c,199 :: 		ANSELE = 0; // Puerto E en digital
	CLRF        ANSELE+0 
;two.c,200 :: 		ANSELA = 0; // Puerto A en digital
	CLRF        ANSELA+0 
;two.c,202 :: 		TRISC = 0x03; // C0 y C1 quedan como entradas, los demas en salidas
	MOVLW       3
	MOVWF       TRISC+0 
;two.c,203 :: 		TRISE = 0x00; // Puerto E como salida
	CLRF        TRISE+0 
;two.c,204 :: 		TRISA = 0x00; // Puerto A como salida
	CLRF        TRISA+0 
;two.c,206 :: 		PORTC = 0x01; // Dejamos C0 en linea alta
	MOVLW       1
	MOVWF       PORTC+0 
;two.c,207 :: 		PORTA = 0x10; // Dejamos A4 en linea alta y los demas en linea baja
	MOVLW       16
	MOVWF       PORTA+0 
;two.c,208 :: 		PORTE = 0x00; // Puerto E en linea baja
	CLRF        PORTE+0 
;two.c,210 :: 		LATC = 0x01; // Dejamos el registro de C0 en linea alta
	MOVLW       1
	MOVWF       LATC+0 
;two.c,211 :: 		LATE = 0x00; // Dejamos el registro del puerto E en linea baja
	CLRF        LATE+0 
;two.c,212 :: 		LATA = 0x10; // Dejamos el registro de A4 en linea alta
	MOVLW       16
	MOVWF       LATA+0 
;two.c,219 :: 		bool_once = TRUE; // Seteo del estado de la variable de ejecucion de una sola vez
	BSF         _flags+0, 0 
;two.c,220 :: 		bool_interrupt = TRUE;
	BSF         _flags+0, 1 
;two.c,221 :: 		flag01 = 0; // Seteo de la bandera 1 en 0
	BCF         _flag01+0, BitPos(_flag01+0) 
;two.c,222 :: 		flag02 = 0;
	BCF         _flag02+0, BitPos(_flag02+0) 
;two.c,224 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
