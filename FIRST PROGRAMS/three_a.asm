
_main:

;three_a.c,45 :: 		void main() {
;three_a.c,47 :: 		InitMCU(); // Inicio MCU (seteo de pines y registros de bits)
	CALL        _InitMCU+0, 0
;three_a.c,48 :: 		InitInterrupt();
	CALL        _InitInterrupt+0, 0
;three_a.c,49 :: 		bool_once = TRUE; // Seteo del estado de la variable de ejecucion de una sola vez
	BSF         _flags+0, 0 
;three_a.c,51 :: 		while(1){
L_main0:
;three_a.c,52 :: 		watchdog(); // Inicio de la funcion observadora
	CALL        _watchdog+0, 0
;three_a.c,55 :: 		if((flag_switch == 1) && (LATCH == 0)){
	BTFSS       _flag_switch+0, BitPos(_flag_switch+0) 
	GOTO        L_main4
	BTFSC       PORTC+0, 0 
	GOTO        L_main4
L__main29:
;three_a.c,57 :: 		if(AR1P > AR2P){
	MOVLW       128
	XORWF       _AR2P+3, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _AR1P+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main31
	MOVF        _AR1P+2, 0 
	SUBWF       _AR2P+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main31
	MOVF        _AR1P+1, 0 
	SUBWF       _AR2P+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main31
	MOVF        _AR1P+0, 0 
	SUBWF       _AR2P+0, 0 
L__main31:
	BTFSC       STATUS+0, 0 
	GOTO        L_main5
;three_a.c,58 :: 		ACT2 = 1; // Si, entonces enciende actuador 2
	BSF         LATE+0, 0 
;three_a.c,59 :: 		AR2 = AR2P + 1; // Se suma el registro historico mas 1 al registro actual
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
;three_a.c,60 :: 		}
	GOTO        L_main6
L_main5:
;three_a.c,62 :: 		else if(AR1P < AR2P){
	MOVLW       128
	XORWF       _AR1P+3, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _AR2P+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main32
	MOVF        _AR2P+2, 0 
	SUBWF       _AR1P+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main32
	MOVF        _AR2P+1, 0 
	SUBWF       _AR1P+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main32
	MOVF        _AR2P+0, 0 
	SUBWF       _AR1P+0, 0 
L__main32:
	BTFSC       STATUS+0, 0 
	GOTO        L_main7
;three_a.c,63 :: 		ACT1 = 1; // Si, entonces enciende actuador 1
	BSF         LATA+0, 5 
;three_a.c,64 :: 		AR1 = AR1P + 1; // Se suma el registro historico mas 1 al registro actual
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
;three_a.c,65 :: 		}
L_main7:
L_main6:
;three_a.c,67 :: 		if(AR1P == AR1){
	MOVF        _AR1P+3, 0 
	XORWF       _AR1+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main33
	MOVF        _AR1P+2, 0 
	XORWF       _AR1+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main33
	MOVF        _AR1P+1, 0 
	XORWF       _AR1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main33
	MOVF        _AR1P+0, 0 
	XORWF       _AR1+0, 0 
L__main33:
	BTFSS       STATUS+0, 2 
	GOTO        L_main8
;three_a.c,68 :: 		LPLACA = ~LPLACA; // Cambia de estado al LED de la placa
	BTG         LATA+0, 4 
;three_a.c,69 :: 		}
L_main8:
;three_a.c,70 :: 		}
	GOTO        L_main9
L_main4:
;three_a.c,73 :: 		ACT1 = 0;   // Apagamos todos los actuadores
	BCF         LATA+0, 5 
;three_a.c,74 :: 		ACT2 = 0;
	BCF         LATE+0, 0 
;three_a.c,75 :: 		AR1P = AR1; // Registramos el valor del registro actual en el registro historico
	MOVF        _AR1+0, 0 
	MOVWF       _AR1P+0 
	MOVF        _AR1+1, 0 
	MOVWF       _AR1P+1 
	MOVF        _AR1+2, 0 
	MOVWF       _AR1P+2 
	MOVF        _AR1+3, 0 
	MOVWF       _AR1P+3 
;three_a.c,76 :: 		AR2P = AR2;
	MOVF        _AR2+0, 0 
	MOVWF       _AR2P+0 
	MOVF        _AR2+1, 0 
	MOVWF       _AR2P+1 
	MOVF        _AR2+2, 0 
	MOVWF       _AR2P+2 
	MOVF        _AR2+3, 0 
	MOVWF       _AR2P+3 
;three_a.c,77 :: 		AR1 = 0;    // Reiniciamos los registros actuales de los actuadores
	CLRF        _AR1+0 
	CLRF        _AR1+1 
	CLRF        _AR1+2 
	CLRF        _AR1+3 
;three_a.c,78 :: 		AR2 = 0;
	CLRF        _AR2+0 
	CLRF        _AR2+1 
	CLRF        _AR2+2 
	CLRF        _AR2+3 
;three_a.c,79 :: 		}
L_main9:
;three_a.c,80 :: 		}
	GOTO        L_main0
;three_a.c,82 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_RMUX:

;three_a.c,88 :: 		void RMUX(){
;three_a.c,92 :: 		if(AR1 > AR1P){
	MOVLW       128
	XORWF       _AR1P+3, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _AR1+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__RMUX35
	MOVF        _AR1+2, 0 
	SUBWF       _AR1P+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__RMUX35
	MOVF        _AR1+1, 0 
	SUBWF       _AR1P+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__RMUX35
	MOVF        _AR1+0, 0 
	SUBWF       _AR1P+0, 0 
L__RMUX35:
	BTFSC       STATUS+0, 0 
	GOTO        L_RMUX12
;three_a.c,93 :: 		flag_A1 = 1; // Ponemos una bandera para el actuador 1
	BSF         _flag_A1+0, BitPos(_flag_A1+0) 
;three_a.c,94 :: 		AR1P = 0; // Reiniciamos el registro historico del actuador 1
	CLRF        _AR1P+0 
	CLRF        _AR1P+1 
	CLRF        _AR1P+2 
	CLRF        _AR1P+3 
;three_a.c,95 :: 		}
L_RMUX12:
;three_a.c,96 :: 		if(AR2 > AR2P){
	MOVLW       128
	XORWF       _AR2P+3, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _AR2+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__RMUX36
	MOVF        _AR2+2, 0 
	SUBWF       _AR2P+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__RMUX36
	MOVF        _AR2+1, 0 
	SUBWF       _AR2P+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__RMUX36
	MOVF        _AR2+0, 0 
	SUBWF       _AR2P+0, 0 
L__RMUX36:
	BTFSC       STATUS+0, 0 
	GOTO        L_RMUX13
;three_a.c,97 :: 		flag_A2 = 1; // Ponemos una bandera para el actuador 2
	BSF         _flag_A2+0, BitPos(_flag_A2+0) 
;three_a.c,98 :: 		AR2P = 0; // Reiniciamos el registro historico del actuador 2
	CLRF        _AR2P+0 
	CLRF        _AR2P+1 
	CLRF        _AR2P+2 
	CLRF        _AR2P+3 
;three_a.c,99 :: 		}
L_RMUX13:
;three_a.c,101 :: 		}
L_RMUX11:
;three_a.c,103 :: 		}
L_end_RMUX:
	RETURN      0
; end of _RMUX

_SM:

;three_a.c,109 :: 		void SM(){
;three_a.c,111 :: 		if(ACT1){
	BTFSS       LATA+0, 5 
	GOTO        L_SM14
;three_a.c,113 :: 		if(bool_once){
	BTFSS       _flags+0, 0 
	GOTO        L_SM15
;three_a.c,114 :: 		AR1++; // Aumentamos el registro del actuador 1
	MOVLW       1
	ADDWF       _AR1+0, 1 
	MOVLW       0
	ADDWFC      _AR1+1, 1 
	ADDWFC      _AR1+2, 1 
	ADDWFC      _AR1+3, 1 
;three_a.c,115 :: 		ACT3 = ~ACT3; // Cambiamos de estado el actuador 3
	BTG         LATE+0, 1 
;three_a.c,116 :: 		bool_once = FALSE; // Terminamos la ejecucion
	BCF         _flags+0, 0 
;three_a.c,117 :: 		}
L_SM15:
;three_a.c,118 :: 		}
L_SM14:
;three_a.c,120 :: 		if(ACT2){
	BTFSS       LATE+0, 0 
	GOTO        L_SM16
;three_a.c,122 :: 		if(bool_once){
	BTFSS       _flags+0, 0 
	GOTO        L_SM17
;three_a.c,123 :: 		AR2++; // Aumentamos el registro del actuador 2
	MOVLW       1
	ADDWF       _AR2+0, 1 
	MOVLW       0
	ADDWFC      _AR2+1, 1 
	ADDWFC      _AR2+2, 1 
	ADDWFC      _AR2+3, 1 
;three_a.c,124 :: 		ACT4 = ~ACT4; // Cambiamos de estado el actuador 4
	BTG         LATE+0, 2 
;three_a.c,125 :: 		bool_once = FALSE; // Terminamos la ejecucion
	BCF         _flags+0, 0 
;three_a.c,126 :: 		}
L_SM17:
;three_a.c,127 :: 		}
L_SM16:
;three_a.c,129 :: 		}
L_end_SM:
	RETURN      0
; end of _SM

_blink:

;three_a.c,135 :: 		void blink(){
;three_a.c,137 :: 		while(flag_switch){
	BTFSS       _flag_switch+0, BitPos(_flag_switch+0) 
	GOTO        L_blink19
;three_a.c,140 :: 		for(i = 0; i < 4; i++){
	CLRF        R1 
L_blink20:
	MOVLW       4
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_blink21
;three_a.c,141 :: 		LPLACA = ~LPLACA; // Cambio de estado del LED de la placa
	BTG         LATA+0, 4 
;three_a.c,142 :: 		Delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       69
	MOVWF       R12, 0
	MOVLW       169
	MOVWF       R13, 0
L_blink23:
	DECFSZ      R13, 1, 1
	BRA         L_blink23
	DECFSZ      R12, 1, 1
	BRA         L_blink23
	DECFSZ      R11, 1, 1
	BRA         L_blink23
	NOP
	NOP
;three_a.c,140 :: 		for(i = 0; i < 4; i++){
	INCF        R1, 1 
;three_a.c,143 :: 		}
	GOTO        L_blink20
L_blink21:
;three_a.c,145 :: 		}
L_blink19:
;three_a.c,147 :: 		}
L_end_blink:
	RETURN      0
; end of _blink

_watchdog:

;three_a.c,153 :: 		void watchdog(){
;three_a.c,155 :: 		while(1){
L_watchdog24:
;three_a.c,157 :: 		if(1 == LATCH)continue;
	BTFSS       PORTC+0, 0 
	GOTO        L_watchdog26
	GOTO        L_watchdog24
L_watchdog26:
;three_a.c,159 :: 		if(0 == LATCH){
	BTFSC       PORTC+0, 0 
	GOTO        L_watchdog27
;three_a.c,160 :: 		Delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       69
	MOVWF       R12, 0
	MOVLW       169
	MOVWF       R13, 0
L_watchdog28:
	DECFSZ      R13, 1, 1
	BRA         L_watchdog28
	DECFSZ      R12, 1, 1
	BRA         L_watchdog28
	DECFSZ      R11, 1, 1
	BRA         L_watchdog28
	NOP
	NOP
;three_a.c,161 :: 		flag_switch = 1; // Ponemos la bandera en 1
	BSF         _flag_switch+0, BitPos(_flag_switch+0) 
;three_a.c,163 :: 		}
L_watchdog27:
;three_a.c,165 :: 		}
L_watchdog25:
;three_a.c,166 :: 		}
L_end_watchdog:
	RETURN      0
; end of _watchdog

_InitInterrupt:

;three_a.c,172 :: 		void InitInterrupt(){
;three_a.c,174 :: 		PIE0 = 0x10; // Registro Peripheral Interrupt Enable (Bit 4 IOCIE)
	MOVLW       16
	MOVWF       PIE0+0 
;three_a.c,175 :: 		IOCCF = 0x00; // Seteo en 0 el registro del Interrupt on Change on PORTC Flag
	CLRF        IOCCF+0 
;three_a.c,176 :: 		IOCCN = 0x00; // Seteo en 0 el registro del Interrupt on Change on PORTC Flag
	CLRF        IOCCN+0 
;three_a.c,177 :: 		IOCCP = 0x00; // Seteo en 0 el registro del Interrupt on Change on PORTC Flag
	CLRF        IOCCP+0 
;three_a.c,182 :: 		INTCON = 0xC0; // Registro INTCON (Bit 7 y 6; GIE y PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;three_a.c,185 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;three_a.c,191 :: 		void InitMCU(){
;three_a.c,193 :: 		ADCON1 = 0x0F; // Desactivamos los valores TTL para el PIC
	MOVLW       15
	MOVWF       ADCON1+0 
;three_a.c,195 :: 		ANSELC = 0; // Puerto A en digital
	CLRF        ANSELC+0 
;three_a.c,196 :: 		ANSELE = 0; // Puerto E en digital
	CLRF        ANSELE+0 
;three_a.c,197 :: 		ANSELA = 0; // Puerto A en digital
	CLRF        ANSELA+0 
;three_a.c,199 :: 		TRISC = 0x03; // C0 y C1 quedan como entradas, los demas en salidas
	MOVLW       3
	MOVWF       TRISC+0 
;three_a.c,200 :: 		TRISE = 0x00; // Puerto E como salida
	CLRF        TRISE+0 
;three_a.c,201 :: 		TRISA = 0x00; // Puerto A como salida
	CLRF        TRISA+0 
;three_a.c,203 :: 		PORTC = 0x00; // Dejamos C0 en linea alta
	CLRF        PORTC+0 
;three_a.c,204 :: 		PORTA = 0x10; // Dejamos A4 en linea alta y los demas en linea baja
	MOVLW       16
	MOVWF       PORTA+0 
;three_a.c,205 :: 		PORTE = 0x00; // Puerto E en linea baja
	CLRF        PORTE+0 
;three_a.c,207 :: 		LATC = 0x00; // Dejamos el registro de C0 en linea alta
	CLRF        LATC+0 
;three_a.c,208 :: 		LATE = 0x00; // Dejamos el registro del puerto E en linea baja
	CLRF        LATE+0 
;three_a.c,209 :: 		LATA = 0x10; // Dejamos el registro de A4 en linea alta
	MOVLW       16
	MOVWF       LATA+0 
;three_a.c,216 :: 		bool_interrupt = TRUE;
	BSF         _flags+0, 1 
;three_a.c,217 :: 		flag_switch = 0; // Seteo de la bandera 1 en 0
	BCF         _flag_switch+0, BitPos(_flag_switch+0) 
;three_a.c,219 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
