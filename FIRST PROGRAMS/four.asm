
_main:

;four.c,45 :: 		void main() {
;four.c,47 :: 		InitMCU(); // Inicio MCU (seteo de pines y registros de bits)
	CALL        _InitMCU+0, 0
;four.c,48 :: 		InitInterrupt();
	CALL        _InitInterrupt+0, 0
;four.c,49 :: 		bool_once = TRUE; // Seteo del estado de la variable de ejecucion de una sola vez
	BSF         _flags+0, 0 
;four.c,51 :: 		while(1){
L_main0:
;four.c,52 :: 		watchdog(); // Inicio de la funcion observadora
	CALL        _watchdog+0, 0
;four.c,53 :: 		Delay_ms(20);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	NOP
	NOP
;four.c,56 :: 		if((flag_switch == 1) && (LATCH == 0)){
	BTFSS       _flag_switch+0, BitPos(_flag_switch+0) 
	GOTO        L_main5
	BTFSC       PORTC+0, 0 
	GOTO        L_main5
L__main30:
;four.c,58 :: 		if(AR1P > AR2P){
	MOVLW       128
	XORWF       _AR2P+3, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _AR1P+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main32
	MOVF        _AR1P+2, 0 
	SUBWF       _AR2P+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main32
	MOVF        _AR1P+1, 0 
	SUBWF       _AR2P+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main32
	MOVF        _AR1P+0, 0 
	SUBWF       _AR2P+0, 0 
L__main32:
	BTFSC       STATUS+0, 0 
	GOTO        L_main6
;four.c,59 :: 		ACT2 = 1; // Si, entonces enciende actuador 2
	BSF         LATE+0, 0 
;four.c,60 :: 		AR2 = AR2P + 1; // Se suma el registro historico mas 1 al registro actual
	MOVLW       1
	ADDWF       _AR2P+0, 0 
	MOVWF       _AR2+0 
	MOVLW       0
	ADDWFC      _AR2P+1, 0 
	MOVWF       _AR2+1 
	MOVLW       0
	ADDWFC      _AR2P+2, 0 
	MOVWF       _AR2+2 
	MOVLW       0
	ADDWFC      _AR2P+3, 0 
	MOVWF       _AR2+3 
;four.c,61 :: 		}
	GOTO        L_main7
L_main6:
;four.c,63 :: 		else if(AR1P < AR2P){
	MOVLW       128
	XORWF       _AR1P+3, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _AR2P+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main33
	MOVF        _AR2P+2, 0 
	SUBWF       _AR1P+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main33
	MOVF        _AR2P+1, 0 
	SUBWF       _AR1P+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main33
	MOVF        _AR2P+0, 0 
	SUBWF       _AR1P+0, 0 
L__main33:
	BTFSC       STATUS+0, 0 
	GOTO        L_main8
;four.c,64 :: 		ACT1 = 1; // Si, entonces enciende actuador 1
	BSF         LATA+0, 5 
;four.c,65 :: 		AR1 = AR1P + 1; // Se suma el registro historico mas 1 al registro actual
	MOVLW       1
	ADDWF       _AR1P+0, 0 
	MOVWF       _AR1+0 
	MOVLW       0
	ADDWFC      _AR1P+1, 0 
	MOVWF       _AR1+1 
	MOVLW       0
	ADDWFC      _AR1P+2, 0 
	MOVWF       _AR1+2 
	MOVLW       0
	ADDWFC      _AR1P+3, 0 
	MOVWF       _AR1+3 
;four.c,66 :: 		}
L_main8:
L_main7:
;four.c,68 :: 		if(AR1P == AR1){
	MOVF        _AR1P+3, 0 
	XORWF       _AR1+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main34
	MOVF        _AR1P+2, 0 
	XORWF       _AR1+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main34
	MOVF        _AR1P+1, 0 
	XORWF       _AR1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main34
	MOVF        _AR1P+0, 0 
	XORWF       _AR1+0, 0 
L__main34:
	BTFSS       STATUS+0, 2 
	GOTO        L_main9
;four.c,69 :: 		LPLACA = ~LPLACA; // Cambia de estado al LED de la placa
	BTG         LATA+0, 4 
;four.c,70 :: 		}
L_main9:
;four.c,71 :: 		}
	GOTO        L_main10
L_main5:
;four.c,74 :: 		ACT1 = 0;   // Apagamos todos los actuadores
	BCF         LATA+0, 5 
;four.c,75 :: 		ACT2 = 0;
	BCF         LATE+0, 0 
;four.c,76 :: 		AR1P = AR1; // Registramos el valor del registro actual en el registro historico
	MOVF        _AR1+0, 0 
	MOVWF       _AR1P+0 
	MOVF        _AR1+1, 0 
	MOVWF       _AR1P+1 
	MOVF        _AR1+2, 0 
	MOVWF       _AR1P+2 
	MOVF        _AR1+3, 0 
	MOVWF       _AR1P+3 
;four.c,77 :: 		AR2P = AR2;
	MOVF        _AR2+0, 0 
	MOVWF       _AR2P+0 
	MOVF        _AR2+1, 0 
	MOVWF       _AR2P+1 
	MOVF        _AR2+2, 0 
	MOVWF       _AR2P+2 
	MOVF        _AR2+3, 0 
	MOVWF       _AR2P+3 
;four.c,78 :: 		AR1 = 0;    // Reiniciamos los registros actuales de los actuadores
	CLRF        _AR1+0 
	CLRF        _AR1+1 
	CLRF        _AR1+2 
	CLRF        _AR1+3 
;four.c,79 :: 		AR2 = 0;
	CLRF        _AR2+0 
	CLRF        _AR2+1 
	CLRF        _AR2+2 
	CLRF        _AR2+3 
;four.c,80 :: 		}
L_main10:
;four.c,81 :: 		}
	GOTO        L_main0
;four.c,83 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_RMUX:

;four.c,89 :: 		void RMUX(){
;four.c,93 :: 		if(AR1 > AR1P){
	MOVLW       128
	XORWF       _AR1P+3, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _AR1+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__RMUX36
	MOVF        _AR1+2, 0 
	SUBWF       _AR1P+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__RMUX36
	MOVF        _AR1+1, 0 
	SUBWF       _AR1P+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__RMUX36
	MOVF        _AR1+0, 0 
	SUBWF       _AR1P+0, 0 
L__RMUX36:
	BTFSC       STATUS+0, 0 
	GOTO        L_RMUX13
;four.c,94 :: 		flag_A1 = 1; // Ponemos una bandera para el actuador 1
	BSF         _flag_A1+0, BitPos(_flag_A1+0) 
;four.c,95 :: 		AR1P = 0; // Reiniciamos el registro historico del actuador 1
	CLRF        _AR1P+0 
	CLRF        _AR1P+1 
	CLRF        _AR1P+2 
	CLRF        _AR1P+3 
;four.c,96 :: 		}
L_RMUX13:
;four.c,97 :: 		if(AR2 > AR2P){
	MOVLW       128
	XORWF       _AR2P+3, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _AR2+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__RMUX37
	MOVF        _AR2+2, 0 
	SUBWF       _AR2P+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__RMUX37
	MOVF        _AR2+1, 0 
	SUBWF       _AR2P+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__RMUX37
	MOVF        _AR2+0, 0 
	SUBWF       _AR2P+0, 0 
L__RMUX37:
	BTFSC       STATUS+0, 0 
	GOTO        L_RMUX14
;four.c,98 :: 		flag_A2 = 1; // Ponemos una bandera para el actuador 2
	BSF         _flag_A2+0, BitPos(_flag_A2+0) 
;four.c,99 :: 		AR2P = 0; // Reiniciamos el registro historico del actuador 2
	CLRF        _AR2P+0 
	CLRF        _AR2P+1 
	CLRF        _AR2P+2 
	CLRF        _AR2P+3 
;four.c,100 :: 		}
L_RMUX14:
;four.c,102 :: 		}
L_RMUX12:
;four.c,104 :: 		}
L_end_RMUX:
	RETURN      0
; end of _RMUX

_SM:

;four.c,110 :: 		void SM(){
;four.c,112 :: 		if(ACT1){
	BTFSS       LATA+0, 5 
	GOTO        L_SM15
;four.c,114 :: 		if(bool_once){
	BTFSS       _flags+0, 0 
	GOTO        L_SM16
;four.c,115 :: 		AR1++; // Aumentamos el registro del actuador 1
	MOVLW       1
	ADDWF       _AR1+0, 1 
	MOVLW       0
	ADDWFC      _AR1+1, 1 
	ADDWFC      _AR1+2, 1 
	ADDWFC      _AR1+3, 1 
;four.c,116 :: 		ACT3 = ~ACT3; // Cambiamos de estado el actuador 3
	BTG         LATE+0, 1 
;four.c,117 :: 		bool_once = FALSE; // Terminamos la ejecucion
	BCF         _flags+0, 0 
;four.c,118 :: 		}
L_SM16:
;four.c,119 :: 		}
L_SM15:
;four.c,121 :: 		if(ACT2){
	BTFSS       LATE+0, 0 
	GOTO        L_SM17
;four.c,123 :: 		if(bool_once){
	BTFSS       _flags+0, 0 
	GOTO        L_SM18
;four.c,124 :: 		AR2++; // Aumentamos el registro del actuador 2
	MOVLW       1
	ADDWF       _AR2+0, 1 
	MOVLW       0
	ADDWFC      _AR2+1, 1 
	ADDWFC      _AR2+2, 1 
	ADDWFC      _AR2+3, 1 
;four.c,125 :: 		ACT4 = ~ACT4; // Cambiamos de estado el actuador 4
	BTG         LATE+0, 2 
;four.c,126 :: 		bool_once = FALSE; // Terminamos la ejecucion
	BCF         _flags+0, 0 
;four.c,127 :: 		}
L_SM18:
;four.c,128 :: 		}
L_SM17:
;four.c,130 :: 		}
L_end_SM:
	RETURN      0
; end of _SM

_blink:

;four.c,136 :: 		void blink(){
;four.c,138 :: 		while(flag_switch){
	BTFSS       _flag_switch+0, BitPos(_flag_switch+0) 
	GOTO        L_blink20
;four.c,141 :: 		for(i = 0; i < 4; i++){
	CLRF        R1 
L_blink21:
	MOVLW       4
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_blink22
;four.c,142 :: 		LPLACA = ~LPLACA; // Cambio de estado del LED de la placa
	BTG         LATA+0, 4 
;four.c,143 :: 		Delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       69
	MOVWF       R12, 0
	MOVLW       169
	MOVWF       R13, 0
L_blink24:
	DECFSZ      R13, 1, 1
	BRA         L_blink24
	DECFSZ      R12, 1, 1
	BRA         L_blink24
	DECFSZ      R11, 1, 1
	BRA         L_blink24
	NOP
	NOP
;four.c,141 :: 		for(i = 0; i < 4; i++){
	INCF        R1, 1 
;four.c,144 :: 		}
	GOTO        L_blink21
L_blink22:
;four.c,146 :: 		}
L_blink20:
;four.c,148 :: 		}
L_end_blink:
	RETURN      0
; end of _blink

_watchdog:

;four.c,154 :: 		void watchdog(){
;four.c,156 :: 		while(1){
L_watchdog25:
;four.c,158 :: 		if(1 == LATCH)continue;
	BTFSS       PORTC+0, 0 
	GOTO        L_watchdog27
	GOTO        L_watchdog25
L_watchdog27:
;four.c,160 :: 		if(0 == LATCH){
	BTFSC       PORTC+0, 0 
	GOTO        L_watchdog28
;four.c,161 :: 		Delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       69
	MOVWF       R12, 0
	MOVLW       169
	MOVWF       R13, 0
L_watchdog29:
	DECFSZ      R13, 1, 1
	BRA         L_watchdog29
	DECFSZ      R12, 1, 1
	BRA         L_watchdog29
	DECFSZ      R11, 1, 1
	BRA         L_watchdog29
	NOP
	NOP
;four.c,162 :: 		flag_switch = 1; // Ponemos la bandera en 1
	BSF         _flag_switch+0, BitPos(_flag_switch+0) 
;four.c,164 :: 		}
L_watchdog28:
;four.c,166 :: 		}
L_watchdog26:
;four.c,167 :: 		}
L_end_watchdog:
	RETURN      0
; end of _watchdog

_InitInterrupt:

;four.c,173 :: 		void InitInterrupt(){
;four.c,175 :: 		PIE0 = 0x10; // Registro Peripheral Interrupt Enable (Bit 4 IOCIE)
	MOVLW       16
	MOVWF       PIE0+0 
;four.c,176 :: 		IOCCF = 0x00; // Seteo en 0 el registro del Interrupt on Change on PORTC Flag
	CLRF        IOCCF+0 
;four.c,177 :: 		IOCCN = 0x00; // Seteo en 0 el registro del Interrupt on Change on PORTC Flag
	CLRF        IOCCN+0 
;four.c,178 :: 		IOCCP = 0x00; // Seteo en 0 el registro del Interrupt on Change on PORTC Flag
	CLRF        IOCCP+0 
;four.c,183 :: 		INTCON = 0xC0; // Registro INTCON (Bit 7 y 6; GIE y PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;four.c,186 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;four.c,192 :: 		void InitMCU(){
;four.c,194 :: 		ADCON1 = 0x0F; // Desactivamos los valores TTL para el PIC
	MOVLW       15
	MOVWF       ADCON1+0 
;four.c,196 :: 		ANSELC = 0; // Puerto A en digital
	CLRF        ANSELC+0 
;four.c,197 :: 		ANSELE = 0; // Puerto E en digital
	CLRF        ANSELE+0 
;four.c,198 :: 		ANSELA = 0; // Puerto A en digital
	CLRF        ANSELA+0 
;four.c,200 :: 		TRISC = 0x03; // C0 y C1 quedan como entradas, los demas en salidas
	MOVLW       3
	MOVWF       TRISC+0 
;four.c,201 :: 		TRISE = 0x00; // Puerto E como salida
	CLRF        TRISE+0 
;four.c,202 :: 		TRISA = 0x00; // Puerto A como salida
	CLRF        TRISA+0 
;four.c,204 :: 		PORTC = 0x00; // Dejamos C0 en linea alta
	CLRF        PORTC+0 
;four.c,205 :: 		PORTA = 0x10; // Dejamos A4 en linea alta y los demas en linea baja
	MOVLW       16
	MOVWF       PORTA+0 
;four.c,206 :: 		PORTE = 0x00; // Puerto E en linea baja
	CLRF        PORTE+0 
;four.c,208 :: 		LATC = 0x00; // Dejamos el registro de C0 en linea alta
	CLRF        LATC+0 
;four.c,209 :: 		LATE = 0x00; // Dejamos el registro del puerto E en linea baja
	CLRF        LATE+0 
;four.c,210 :: 		LATA = 0x10; // Dejamos el registro de A4 en linea alta
	MOVLW       16
	MOVWF       LATA+0 
;four.c,217 :: 		bool_interrupt = TRUE;
	BSF         _flags+0, 1 
;four.c,218 :: 		flag_switch = 0; // Seteo de la bandera 1 en 0
	BCF         _flag_switch+0, BitPos(_flag_switch+0) 
;four.c,220 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
