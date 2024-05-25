
_M1On:

;FIRMWARE_SYA_ver_1_3_0.c,87 :: 		void M1On(){M1 = 1;}
	BSF         LATA+0, 5 
L_end_M1On:
	RETURN      0
; end of _M1On

_M1Off:

;FIRMWARE_SYA_ver_1_3_0.c,88 :: 		void M1Off(){M1 = 0;}
	BCF         LATA+0, 5 
L_end_M1Off:
	RETURN      0
; end of _M1Off

_M2On:

;FIRMWARE_SYA_ver_1_3_0.c,89 :: 		void M2On(){M2 = 1;}
	BSF         LATE+0, 0 
L_end_M2On:
	RETURN      0
; end of _M2On

_M2Off:

;FIRMWARE_SYA_ver_1_3_0.c,90 :: 		void M2Off(){M2 = 0;}
	BCF         LATE+0, 0 
L_end_M2Off:
	RETURN      0
; end of _M2Off

_M3On:

;FIRMWARE_SYA_ver_1_3_0.c,91 :: 		void M3On(){M3 = 1;}
	BSF         LATE+0, 1 
L_end_M3On:
	RETURN      0
; end of _M3On

_M3Off:

;FIRMWARE_SYA_ver_1_3_0.c,92 :: 		void M3Off(){M3 = 0;}
	BCF         LATE+0, 1 
L_end_M3Off:
	RETURN      0
; end of _M3Off

_interrupt:

;FIRMWARE_SYA_ver_1_3_0.c,98 :: 		void interrupt(){
;FIRMWARE_SYA_ver_1_3_0.c,100 :: 		if(PIR0.TMR0IF){
	BTFSS       PIR0+0, 5 
	GOTO        L_interrupt0
;FIRMWARE_SYA_ver_1_3_0.c,101 :: 		TMR0H = 0x3C;      // Timer para cada segundo y medio?
	MOVLW       60
	MOVWF       TMR0H+0 
;FIRMWARE_SYA_ver_1_3_0.c,102 :: 		TMR0L = 0xB0;      //
	MOVLW       176
	MOVWF       TMR0L+0 
;FIRMWARE_SYA_ver_1_3_0.c,103 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,104 :: 		counter++;
	MOVLW       1
	ADDWF       _counter+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _counter+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _counter+0 
	MOVF        R1, 0 
	MOVWF       _counter+1 
;FIRMWARE_SYA_ver_1_3_0.c,105 :: 		if(counter >= 100){
	MOVLW       128
	XORWF       _counter+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt136
	MOVLW       100
	SUBWF       _counter+0, 0 
L__interrupt136:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt1
;FIRMWARE_SYA_ver_1_3_0.c,106 :: 		LED = ~LED;
	BTG         LATA+0, 4 
;FIRMWARE_SYA_ver_1_3_0.c,107 :: 		Events();
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,108 :: 		counter = 0;
	CLRF        _counter+0 
	CLRF        _counter+1 
;FIRMWARE_SYA_ver_1_3_0.c,109 :: 		}
L_interrupt1:
;FIRMWARE_SYA_ver_1_3_0.c,110 :: 		}
L_interrupt0:
;FIRMWARE_SYA_ver_1_3_0.c,111 :: 		if((1 == IOCCF.B0) && (1 == IOCIE_bit)){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt4
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt4
L__interrupt108:
;FIRMWARE_SYA_ver_1_3_0.c,112 :: 		IOCCF.B0 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,113 :: 		interruptC0 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	MOVLW       1
	MOVWF       _interruptC0+0 
	MOVLW       0
	MOVWF       _interruptC0+1 
;FIRMWARE_SYA_ver_1_3_0.c,114 :: 		Events();
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,130 :: 		}
L_interrupt4:
;FIRMWARE_SYA_ver_1_3_0.c,132 :: 		if((1 == IOCCF.B1) && (1 == IOCIE_bit)){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt7
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt7
L__interrupt107:
;FIRMWARE_SYA_ver_1_3_0.c,133 :: 		IOCCF.B1 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,134 :: 		interruptC1 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	MOVLW       1
	MOVWF       _interruptC1+0 
	MOVLW       0
	MOVWF       _interruptC1+1 
;FIRMWARE_SYA_ver_1_3_0.c,135 :: 		Events();
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,152 :: 		}
L_interrupt7:
;FIRMWARE_SYA_ver_1_3_0.c,154 :: 		if((1 == IOCCF.B2) && (1 == IOCIE_bit)){
	BTFSS       IOCCF+0, 2 
	GOTO        L_interrupt10
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt10
L__interrupt106:
;FIRMWARE_SYA_ver_1_3_0.c,155 :: 		IOCCF.B2 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 2 
;FIRMWARE_SYA_ver_1_3_0.c,156 :: 		interruptC2 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	MOVLW       1
	MOVWF       _interruptC2+0 
	MOVLW       0
	MOVWF       _interruptC2+1 
;FIRMWARE_SYA_ver_1_3_0.c,157 :: 		Events();
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,169 :: 		}
L_interrupt10:
;FIRMWARE_SYA_ver_1_3_0.c,174 :: 		}
L_end_interrupt:
L__interrupt135:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_1_3_0.c,180 :: 		void main(){
;FIRMWARE_SYA_ver_1_3_0.c,182 :: 		InitSystems();
	CALL        _InitSystems+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,188 :: 		while(1){
L_main11:
;FIRMWARE_SYA_ver_1_3_0.c,190 :: 		current_state = next_state; // Maybe move this with Events
	MOVF        _next_state+0, 0 
	MOVWF       _current_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,191 :: 		FSM();
	CALL        _FSM+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,192 :: 		}
	GOTO        L_main11
;FIRMWARE_SYA_ver_1_3_0.c,194 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_FSM:

;FIRMWARE_SYA_ver_1_3_0.c,200 :: 		void FSM(){
;FIRMWARE_SYA_ver_1_3_0.c,201 :: 		clock0 = 1;
	MOVLW       1
	MOVWF       _clock0+0 
	MOVLW       0
	MOVWF       _clock0+1 
;FIRMWARE_SYA_ver_1_3_0.c,202 :: 		switch(current_state){
	GOTO        L_FSM13
;FIRMWARE_SYA_ver_1_3_0.c,203 :: 		case s0:
L_FSM15:
;FIRMWARE_SYA_ver_1_3_0.c,204 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,205 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,206 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,207 :: 		sn_GoTo = 0;
	CLRF        _sn_GoTo+0 
	CLRF        _sn_GoTo+1 
;FIRMWARE_SYA_ver_1_3_0.c,208 :: 		if((1 == sn_PosEdge_1) && (1 == clock0)){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM18
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM139
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM139:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM18
L__FSM127:
;FIRMWARE_SYA_ver_1_3_0.c,209 :: 		next_state = s7;
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,210 :: 		}
	GOTO        L_FSM19
L_FSM18:
;FIRMWARE_SYA_ver_1_3_0.c,212 :: 		}
L_FSM19:
;FIRMWARE_SYA_ver_1_3_0.c,213 :: 		break;
	GOTO        L_FSM14
;FIRMWARE_SYA_ver_1_3_0.c,214 :: 		case s1:
L_FSM20:
;FIRMWARE_SYA_ver_1_3_0.c,215 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,216 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,217 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,218 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,219 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,220 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,222 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM23
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM140
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM140:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM23
L__FSM126:
;FIRMWARE_SYA_ver_1_3_0.c,224 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,225 :: 		}
	GOTO        L_FSM24
L_FSM23:
;FIRMWARE_SYA_ver_1_3_0.c,226 :: 		else if((1 == sn_PosEdge_2) && (1 == clock0)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM27
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM141
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM141:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM27
L__FSM125:
;FIRMWARE_SYA_ver_1_3_0.c,227 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,228 :: 		}
	GOTO        L_FSM28
L_FSM27:
;FIRMWARE_SYA_ver_1_3_0.c,230 :: 		}
L_FSM28:
L_FSM24:
;FIRMWARE_SYA_ver_1_3_0.c,231 :: 		break;
	GOTO        L_FSM14
;FIRMWARE_SYA_ver_1_3_0.c,232 :: 		case s2:
L_FSM29:
;FIRMWARE_SYA_ver_1_3_0.c,233 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,234 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,235 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,236 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,237 :: 		GT2 = 1;
	BSF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,238 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,239 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM32
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM142
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM142:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM32
L__FSM124:
;FIRMWARE_SYA_ver_1_3_0.c,240 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,241 :: 		}
	GOTO        L_FSM33
L_FSM32:
;FIRMWARE_SYA_ver_1_3_0.c,242 :: 		else if((1 == sn_PosEdge_2) && (1 == clock0)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM36
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM143
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM143:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM36
L__FSM123:
;FIRMWARE_SYA_ver_1_3_0.c,243 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,244 :: 		}
	GOTO        L_FSM37
L_FSM36:
;FIRMWARE_SYA_ver_1_3_0.c,246 :: 		}
L_FSM37:
L_FSM33:
;FIRMWARE_SYA_ver_1_3_0.c,247 :: 		break;
	GOTO        L_FSM14
;FIRMWARE_SYA_ver_1_3_0.c,248 :: 		case s3:
L_FSM38:
;FIRMWARE_SYA_ver_1_3_0.c,249 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,250 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,251 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,252 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,253 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,254 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,255 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM41
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM144
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM144:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM41
L__FSM122:
;FIRMWARE_SYA_ver_1_3_0.c,256 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,257 :: 		}
	GOTO        L_FSM42
L_FSM41:
;FIRMWARE_SYA_ver_1_3_0.c,258 :: 		else if((1 == sn_PosEdge_2) && (1 == clock0)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM45
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM145
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM145:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM45
L__FSM121:
;FIRMWARE_SYA_ver_1_3_0.c,259 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,260 :: 		}
	GOTO        L_FSM46
L_FSM45:
;FIRMWARE_SYA_ver_1_3_0.c,262 :: 		}
L_FSM46:
L_FSM42:
;FIRMWARE_SYA_ver_1_3_0.c,263 :: 		break;
	GOTO        L_FSM14
;FIRMWARE_SYA_ver_1_3_0.c,264 :: 		case s4:
L_FSM47:
;FIRMWARE_SYA_ver_1_3_0.c,265 :: 		if((1 == GT1) && (0 == GT2) && (0 == GT3)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM50
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM50
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM50
L__FSM120:
;FIRMWARE_SYA_ver_1_3_0.c,266 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,267 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,268 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,269 :: 		}
	GOTO        L_FSM51
L_FSM50:
;FIRMWARE_SYA_ver_1_3_0.c,270 :: 		else if((1 == GT2) && (0 == GT1) && (0 == GT3)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM54
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM54
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM54
L__FSM119:
;FIRMWARE_SYA_ver_1_3_0.c,271 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,272 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,273 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,274 :: 		}
	GOTO        L_FSM55
L_FSM54:
;FIRMWARE_SYA_ver_1_3_0.c,275 :: 		else if((1 == GT3) && (0 == GT1) && (0 == GT2)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM58
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM58
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM58
L__FSM118:
;FIRMWARE_SYA_ver_1_3_0.c,276 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,277 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,278 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,279 :: 		}
L_FSM58:
L_FSM55:
L_FSM51:
;FIRMWARE_SYA_ver_1_3_0.c,280 :: 		if((1 == sn_NegEdge_2) && (1 == clock0)){
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_FSM61
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM146
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM146:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM61
L__FSM117:
;FIRMWARE_SYA_ver_1_3_0.c,281 :: 		next_state = s7;
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,282 :: 		}
	GOTO        L_FSM62
L_FSM61:
;FIRMWARE_SYA_ver_1_3_0.c,283 :: 		else if((1 == sn_PosEdge_3) && (1 == clock0)){
	BTFSS       _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
	GOTO        L_FSM65
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM147
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM147:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM65
L__FSM116:
;FIRMWARE_SYA_ver_1_3_0.c,284 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,285 :: 		}
	GOTO        L_FSM66
L_FSM65:
;FIRMWARE_SYA_ver_1_3_0.c,287 :: 		}
L_FSM66:
L_FSM62:
;FIRMWARE_SYA_ver_1_3_0.c,288 :: 		break;
	GOTO        L_FSM14
;FIRMWARE_SYA_ver_1_3_0.c,289 :: 		case s5:
L_FSM67:
;FIRMWARE_SYA_ver_1_3_0.c,290 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,291 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,292 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,293 :: 		if((1 == sn_NegEdge_3) && (1 == clock0)){
	BTFSS       _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
	GOTO        L_FSM70
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM148
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM148:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM70
L__FSM115:
;FIRMWARE_SYA_ver_1_3_0.c,294 :: 		sn_GoTo = 1;
	MOVLW       1
	MOVWF       _sn_GoTo+0 
	MOVLW       0
	MOVWF       _sn_GoTo+1 
;FIRMWARE_SYA_ver_1_3_0.c,295 :: 		next_state = s6;
	MOVLW       6
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,296 :: 		}
	GOTO        L_FSM71
L_FSM70:
;FIRMWARE_SYA_ver_1_3_0.c,298 :: 		}
L_FSM71:
;FIRMWARE_SYA_ver_1_3_0.c,299 :: 		break;
	GOTO        L_FSM14
;FIRMWARE_SYA_ver_1_3_0.c,300 :: 		case s6:
L_FSM72:
;FIRMWARE_SYA_ver_1_3_0.c,301 :: 		if((1 == sn_GoTo) && (1 == GT1) && (1 == clock0)){
	MOVLW       0
	XORWF       _sn_GoTo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM149
	MOVF        _sn_GoTo+0, 0 
	XORLW       1
L__FSM149:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM75
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM75
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM150
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM150:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM75
L__FSM114:
;FIRMWARE_SYA_ver_1_3_0.c,302 :: 		GT2 = 1;
	BSF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,303 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,304 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,305 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,306 :: 		}
	GOTO        L_FSM76
L_FSM75:
;FIRMWARE_SYA_ver_1_3_0.c,307 :: 		else if((1 == sn_GoTo) && (1 == GT2) && (1 == clock0)){
	MOVLW       0
	XORWF       _sn_GoTo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM151
	MOVF        _sn_GoTo+0, 0 
	XORLW       1
L__FSM151:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM79
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM79
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM152
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM152:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM79
L__FSM113:
;FIRMWARE_SYA_ver_1_3_0.c,308 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,309 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,310 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,311 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,312 :: 		}
	GOTO        L_FSM80
L_FSM79:
;FIRMWARE_SYA_ver_1_3_0.c,313 :: 		else if((1 == sn_GoTo) && (1 == GT3) && (1 == clock0)){
	MOVLW       0
	XORWF       _sn_GoTo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM153
	MOVF        _sn_GoTo+0, 0 
	XORLW       1
L__FSM153:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM83
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM83
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM154
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM154:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM83
L__FSM112:
;FIRMWARE_SYA_ver_1_3_0.c,314 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,315 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,316 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,317 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,318 :: 		}
	GOTO        L_FSM84
L_FSM83:
;FIRMWARE_SYA_ver_1_3_0.c,320 :: 		}
L_FSM84:
L_FSM80:
L_FSM76:
;FIRMWARE_SYA_ver_1_3_0.c,321 :: 		break;
	GOTO        L_FSM14
;FIRMWARE_SYA_ver_1_3_0.c,322 :: 		case s7:
L_FSM85:
;FIRMWARE_SYA_ver_1_3_0.c,323 :: 		if((1 == GT1) && (0 == GT2) && (0 == GT3)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM88
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM88
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM88
L__FSM111:
;FIRMWARE_SYA_ver_1_3_0.c,324 :: 		next_state = s2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,325 :: 		}
	GOTO        L_FSM89
L_FSM88:
;FIRMWARE_SYA_ver_1_3_0.c,326 :: 		else if((1 == GT2) && (0 == GT1) && (0 == GT3)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM92
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM92
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM92
L__FSM110:
;FIRMWARE_SYA_ver_1_3_0.c,327 :: 		next_state = s3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,328 :: 		}
	GOTO        L_FSM93
L_FSM92:
;FIRMWARE_SYA_ver_1_3_0.c,329 :: 		else if((1 == GT3) && (0 == GT1) && (0 == GT2)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM96
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM96
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM96
L__FSM109:
;FIRMWARE_SYA_ver_1_3_0.c,330 :: 		next_state = s1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,331 :: 		}
L_FSM96:
L_FSM93:
L_FSM89:
;FIRMWARE_SYA_ver_1_3_0.c,332 :: 		break;
	GOTO        L_FSM14
;FIRMWARE_SYA_ver_1_3_0.c,333 :: 		default:
L_FSM97:
;FIRMWARE_SYA_ver_1_3_0.c,334 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,335 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,336 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,337 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,338 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,339 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,340 :: 		current_state = s0;
	CLRF        _current_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,341 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,342 :: 		break;
	GOTO        L_FSM14
;FIRMWARE_SYA_ver_1_3_0.c,343 :: 		}
L_FSM13:
	MOVF        _current_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM15
	MOVF        _current_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM20
	MOVF        _current_state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM29
	MOVF        _current_state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM38
	MOVF        _current_state+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM47
	MOVF        _current_state+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM67
	MOVF        _current_state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM72
	MOVF        _current_state+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM85
	GOTO        L_FSM97
L_FSM14:
;FIRMWARE_SYA_ver_1_3_0.c,345 :: 		}
L_end_FSM:
	RETURN      0
; end of _FSM

_Events:

;FIRMWARE_SYA_ver_1_3_0.c,351 :: 		void Events(){
;FIRMWARE_SYA_ver_1_3_0.c,352 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_Events98:
	DECFSZ      R13, 1, 1
	BRA         L_Events98
	DECFSZ      R12, 1, 1
	BRA         L_Events98
	DECFSZ      R11, 1, 1
	BRA         L_Events98
	NOP
	NOP
;FIRMWARE_SYA_ver_1_3_0.c,354 :: 		if(1 == SWITCH1){
	BTFSS       PORTC+0, 0 
	GOTO        L_Events99
;FIRMWARE_SYA_ver_1_3_0.c,356 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,357 :: 		sn_NegEdge_1 = 1;
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,358 :: 		interruptC0 = 0; // Limpiamos la bandera de interrupcion en C0
	CLRF        _interruptC0+0 
	CLRF        _interruptC0+1 
;FIRMWARE_SYA_ver_1_3_0.c,359 :: 		}
	GOTO        L_Events100
L_Events99:
;FIRMWARE_SYA_ver_1_3_0.c,363 :: 		sn_PosEdge_1 = 1;
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,364 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,365 :: 		interruptC0 = 0; // Limpiamos la bandera de interrupcion en C0
	CLRF        _interruptC0+0 
	CLRF        _interruptC0+1 
;FIRMWARE_SYA_ver_1_3_0.c,366 :: 		}
L_Events100:
;FIRMWARE_SYA_ver_1_3_0.c,368 :: 		if(1 == SWITCH2){
	BTFSS       PORTC+0, 1 
	GOTO        L_Events101
;FIRMWARE_SYA_ver_1_3_0.c,370 :: 		sn_PosEdge_2 = 0;
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,371 :: 		sn_NegEdge_2 = 1;
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,372 :: 		interruptC1 = 0; // Limpiamos la bandera de interrupcion en C1
	CLRF        _interruptC1+0 
	CLRF        _interruptC1+1 
;FIRMWARE_SYA_ver_1_3_0.c,373 :: 		}
	GOTO        L_Events102
L_Events101:
;FIRMWARE_SYA_ver_1_3_0.c,377 :: 		sn_PosEdge_2 = 1;
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,378 :: 		sn_NegEdge_2 = 0;
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,379 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,380 :: 		interruptC1 = 0; // Limpiamos la bandera de interrupcion en C1
	CLRF        _interruptC1+0 
	CLRF        _interruptC1+1 
;FIRMWARE_SYA_ver_1_3_0.c,381 :: 		}
L_Events102:
;FIRMWARE_SYA_ver_1_3_0.c,382 :: 		if(1 == SWITCH3){
	BTFSS       PORTC+0, 2 
	GOTO        L_Events103
;FIRMWARE_SYA_ver_1_3_0.c,383 :: 		sn_PosEdge_3 = 0;
	BCF         _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,384 :: 		sn_NegEdge_3 = 1;
	BSF         _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,385 :: 		interruptC2 = 0;
	CLRF        _interruptC2+0 
	CLRF        _interruptC2+1 
;FIRMWARE_SYA_ver_1_3_0.c,386 :: 		}
	GOTO        L_Events104
L_Events103:
;FIRMWARE_SYA_ver_1_3_0.c,388 :: 		sn_PosEdge_3 = 1;
	BSF         _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,389 :: 		sn_NegEdge_3 = 0;
	BCF         _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,390 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,391 :: 		interruptC2 = 0;
	CLRF        _interruptC2+0 
	CLRF        _interruptC2+1 
;FIRMWARE_SYA_ver_1_3_0.c,392 :: 		}
L_Events104:
;FIRMWARE_SYA_ver_1_3_0.c,393 :: 		return;
;FIRMWARE_SYA_ver_1_3_0.c,395 :: 		}
L_end_Events:
	RETURN      0
; end of _Events

_InitSystems:

;FIRMWARE_SYA_ver_1_3_0.c,401 :: 		void InitSystems(){
;FIRMWARE_SYA_ver_1_3_0.c,402 :: 		InitInterrupt();
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,403 :: 		InitMCU();
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,404 :: 		}
L_end_InitSystems:
	RETURN      0
; end of _InitSystems

_InitInterrupt:

;FIRMWARE_SYA_ver_1_3_0.c,410 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_1_3_0.c,412 :: 		PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       48
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_1_3_0.c,413 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_1_3_0.c,414 :: 		T0CON0 = 0x90;
	MOVLW       144
	MOVWF       T0CON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,415 :: 		T0CON1 = 0x40;
	MOVLW       64
	MOVWF       T0CON1+0 
;FIRMWARE_SYA_ver_1_3_0.c,416 :: 		TMR0H = 0x3C;
	MOVLW       60
	MOVWF       TMR0H+0 
;FIRMWARE_SYA_ver_1_3_0.c,417 :: 		TMR0L = 0xB0;
	MOVLW       176
	MOVWF       TMR0L+0 
;FIRMWARE_SYA_ver_1_3_0.c,418 :: 		IOCCN = 0x07;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       7
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_1_3_0.c,419 :: 		IOCCP = 0x07;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
	MOVLW       7
	MOVWF       IOCCP+0 
;FIRMWARE_SYA_ver_1_3_0.c,420 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_1_3_0.c,421 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,422 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_1_3_0.c,424 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_1_3_0.c,430 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_1_3_0.c,432 :: 		ADCON0 = 0x08; // Desactivamos ADC
	MOVLW       8
	MOVWF       ADCON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,433 :: 		ANSELC = 0x00;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_1_3_0.c,434 :: 		ANSELE = 0x00;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_1_3_0.c,435 :: 		ANSELA = 0x00;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_1_3_0.c,436 :: 		ANSELD = 0x00;
	CLRF        ANSELD+0 
;FIRMWARE_SYA_ver_1_3_0.c,438 :: 		TRISC = 0x0F;  // Ponemos en modo de entrada a C0, C1, c2 Y c3, los demas como salida
	MOVLW       15
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_1_3_0.c,439 :: 		TRISD = 0x07;  // Ponemos en modo de entrada a D0 y D1
	MOVLW       7
	MOVWF       TRISD+0 
;FIRMWARE_SYA_ver_1_3_0.c,440 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_1_3_0.c,441 :: 		TRISA = 0x80;  //                ''                A
	MOVLW       128
	MOVWF       TRISA+0 
;FIRMWARE_SYA_ver_1_3_0.c,443 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_1_3_0.c,444 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;FIRMWARE_SYA_ver_1_3_0.c,445 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_1_3_0.c,446 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_1_3_0.c,448 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_1_3_0.c,449 :: 		LATD = 0x00;
	CLRF        LATD+0 
;FIRMWARE_SYA_ver_1_3_0.c,450 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_1_3_0.c,451 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_1_3_0.c,455 :: 		WPUD = 0x07;   // Activamos el pull-up interno de C0 y C1
	MOVLW       7
	MOVWF       WPUD+0 
;FIRMWARE_SYA_ver_1_3_0.c,456 :: 		INLVLD = 0x07; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       7
	MOVWF       INLVLD+0 
;FIRMWARE_SYA_ver_1_3_0.c,457 :: 		CM1CON0 = 0x00; // Desactivamos el comparador 1
	CLRF        CM1CON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,458 :: 		CM2CON0 = 0x00; // Desactivamos el comparador 2
	CLRF        CM2CON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,459 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,460 :: 		Delay_ms(200);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_InitMCU105:
	DECFSZ      R13, 1, 1
	BRA         L_InitMCU105
	DECFSZ      R12, 1, 1
	BRA         L_InitMCU105
	DECFSZ      R11, 1, 1
	BRA         L_InitMCU105
	NOP
	NOP
;FIRMWARE_SYA_ver_1_3_0.c,462 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
