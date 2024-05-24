
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
;FIRMWARE_SYA_ver_1_3_0.c,111 :: 		if((1 == IOCCF.B0) && (1 == IOCIE_bit)){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt2
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt2
L__interrupt113:
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
L_interrupt2:
;FIRMWARE_SYA_ver_1_3_0.c,132 :: 		if((1 == IOCCF.B1) && (1 == IOCIE_bit)){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt5
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt5
L__interrupt112:
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
L_interrupt5:
;FIRMWARE_SYA_ver_1_3_0.c,153 :: 		if((1 == IOCCF.B2) && (1 == IOCIE_bit)){
	BTFSS       IOCCF+0, 2 
	GOTO        L_interrupt8
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt8
L__interrupt111:
;FIRMWARE_SYA_ver_1_3_0.c,154 :: 		IOCCF.B2 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 2 
;FIRMWARE_SYA_ver_1_3_0.c,155 :: 		interruptC2 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	MOVLW       1
	MOVWF       _interruptC2+0 
	MOVLW       0
	MOVWF       _interruptC2+1 
;FIRMWARE_SYA_ver_1_3_0.c,156 :: 		Events();
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,168 :: 		}
L_interrupt8:
;FIRMWARE_SYA_ver_1_3_0.c,173 :: 		}
L_end_interrupt:
L__interrupt141:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_1_3_0.c,179 :: 		void main(){
;FIRMWARE_SYA_ver_1_3_0.c,181 :: 		InitSystems();
	CALL        _InitSystems+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,187 :: 		while(1){
L_main9:
;FIRMWARE_SYA_ver_1_3_0.c,189 :: 		current_state = next_state; // Maybe move this with Events
	MOVF        _next_state+0, 0 
	MOVWF       _current_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,190 :: 		FSM();
	CALL        _FSM+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,191 :: 		}
	GOTO        L_main9
;FIRMWARE_SYA_ver_1_3_0.c,193 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_FSM:

;FIRMWARE_SYA_ver_1_3_0.c,199 :: 		void FSM(){
;FIRMWARE_SYA_ver_1_3_0.c,200 :: 		clock0 = 1;
	MOVLW       1
	MOVWF       _clock0+0 
	MOVLW       0
	MOVWF       _clock0+1 
;FIRMWARE_SYA_ver_1_3_0.c,201 :: 		switch(current_state){
	GOTO        L_FSM11
;FIRMWARE_SYA_ver_1_3_0.c,202 :: 		case s0:
L_FSM13:
;FIRMWARE_SYA_ver_1_3_0.c,203 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,204 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,205 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,206 :: 		sn_GoTo = 0;
	CLRF        _sn_GoTo+0 
	CLRF        _sn_GoTo+1 
;FIRMWARE_SYA_ver_1_3_0.c,207 :: 		if((1 == sn_PosEdge_1) && (1 == clock0)){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM16
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM144
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM144:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM16
L__FSM132:
;FIRMWARE_SYA_ver_1_3_0.c,208 :: 		next_state = s7;
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,209 :: 		}
	GOTO        L_FSM17
L_FSM16:
;FIRMWARE_SYA_ver_1_3_0.c,211 :: 		}
L_FSM17:
;FIRMWARE_SYA_ver_1_3_0.c,212 :: 		break;
	GOTO        L_FSM12
;FIRMWARE_SYA_ver_1_3_0.c,213 :: 		case s1:
L_FSM18:
;FIRMWARE_SYA_ver_1_3_0.c,214 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,215 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,216 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,217 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,218 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,219 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,221 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM21
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM145
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM145:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM21
L__FSM131:
;FIRMWARE_SYA_ver_1_3_0.c,223 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,224 :: 		}
	GOTO        L_FSM22
L_FSM21:
;FIRMWARE_SYA_ver_1_3_0.c,225 :: 		else if((1 == sn_PosEdge_2) && (1 == clock0)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM25
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM146
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM146:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM25
L__FSM130:
;FIRMWARE_SYA_ver_1_3_0.c,226 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,227 :: 		}
	GOTO        L_FSM26
L_FSM25:
;FIRMWARE_SYA_ver_1_3_0.c,229 :: 		}
L_FSM26:
L_FSM22:
;FIRMWARE_SYA_ver_1_3_0.c,230 :: 		break;
	GOTO        L_FSM12
;FIRMWARE_SYA_ver_1_3_0.c,231 :: 		case s2:
L_FSM27:
;FIRMWARE_SYA_ver_1_3_0.c,232 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,233 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,234 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,235 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,236 :: 		GT2 = 1;
	BSF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,237 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,238 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM30
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM147
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM147:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM30
L__FSM129:
;FIRMWARE_SYA_ver_1_3_0.c,239 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,240 :: 		}
	GOTO        L_FSM31
L_FSM30:
;FIRMWARE_SYA_ver_1_3_0.c,241 :: 		else if((1 == sn_PosEdge_2) && (1 == clock0)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM34
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM148
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM148:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM34
L__FSM128:
;FIRMWARE_SYA_ver_1_3_0.c,242 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,243 :: 		}
	GOTO        L_FSM35
L_FSM34:
;FIRMWARE_SYA_ver_1_3_0.c,245 :: 		}
L_FSM35:
L_FSM31:
;FIRMWARE_SYA_ver_1_3_0.c,246 :: 		break;
	GOTO        L_FSM12
;FIRMWARE_SYA_ver_1_3_0.c,247 :: 		case s3:
L_FSM36:
;FIRMWARE_SYA_ver_1_3_0.c,248 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,249 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,250 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,251 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,252 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,253 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,254 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM39
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM149
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM149:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM39
L__FSM127:
;FIRMWARE_SYA_ver_1_3_0.c,255 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,256 :: 		}
	GOTO        L_FSM40
L_FSM39:
;FIRMWARE_SYA_ver_1_3_0.c,257 :: 		else if((1 == sn_PosEdge_2) && (1 == clock0)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM43
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM150
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM150:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM43
L__FSM126:
;FIRMWARE_SYA_ver_1_3_0.c,258 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,259 :: 		}
	GOTO        L_FSM44
L_FSM43:
;FIRMWARE_SYA_ver_1_3_0.c,261 :: 		}
L_FSM44:
L_FSM40:
;FIRMWARE_SYA_ver_1_3_0.c,262 :: 		break;
	GOTO        L_FSM12
;FIRMWARE_SYA_ver_1_3_0.c,263 :: 		case s4:
L_FSM45:
;FIRMWARE_SYA_ver_1_3_0.c,264 :: 		if((1 == GT1) && (0 == GT2) && (0 == GT3)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM48
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM48
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM48
L__FSM125:
;FIRMWARE_SYA_ver_1_3_0.c,265 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,266 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,267 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,268 :: 		}
	GOTO        L_FSM49
L_FSM48:
;FIRMWARE_SYA_ver_1_3_0.c,269 :: 		else if((1 == GT2) && (0 == GT1) && (0 == GT3)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM52
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM52
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM52
L__FSM124:
;FIRMWARE_SYA_ver_1_3_0.c,270 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,271 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,272 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,273 :: 		}
	GOTO        L_FSM53
L_FSM52:
;FIRMWARE_SYA_ver_1_3_0.c,274 :: 		else if((1 == GT3) && (0 == GT1) && (0 == GT2)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM56
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM56
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM56
L__FSM123:
;FIRMWARE_SYA_ver_1_3_0.c,275 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,276 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,277 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,278 :: 		}
L_FSM56:
L_FSM53:
L_FSM49:
;FIRMWARE_SYA_ver_1_3_0.c,279 :: 		if((1 == sn_NegEdge_2) && (1 == clock0)){
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_FSM59
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM151
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM151:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM59
L__FSM122:
;FIRMWARE_SYA_ver_1_3_0.c,280 :: 		next_state = s7;
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,281 :: 		}
	GOTO        L_FSM60
L_FSM59:
;FIRMWARE_SYA_ver_1_3_0.c,282 :: 		else if((1 == sn_PosEdge_3) && (1 == clock0)){
	BTFSS       _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
	GOTO        L_FSM63
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM152
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM152:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM63
L__FSM121:
;FIRMWARE_SYA_ver_1_3_0.c,283 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,284 :: 		}
	GOTO        L_FSM64
L_FSM63:
;FIRMWARE_SYA_ver_1_3_0.c,286 :: 		}
L_FSM64:
L_FSM60:
;FIRMWARE_SYA_ver_1_3_0.c,287 :: 		break;
	GOTO        L_FSM12
;FIRMWARE_SYA_ver_1_3_0.c,288 :: 		case s5:
L_FSM65:
;FIRMWARE_SYA_ver_1_3_0.c,289 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,290 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,291 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,292 :: 		if((1 == sn_NegEdge_3) && (1 == clock0)){
	BTFSS       _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
	GOTO        L_FSM68
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM153
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM153:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM68
L__FSM120:
;FIRMWARE_SYA_ver_1_3_0.c,293 :: 		sn_GoTo = 1;
	MOVLW       1
	MOVWF       _sn_GoTo+0 
	MOVLW       0
	MOVWF       _sn_GoTo+1 
;FIRMWARE_SYA_ver_1_3_0.c,294 :: 		next_state = s6;
	MOVLW       6
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,295 :: 		}
	GOTO        L_FSM69
L_FSM68:
;FIRMWARE_SYA_ver_1_3_0.c,297 :: 		}
L_FSM69:
;FIRMWARE_SYA_ver_1_3_0.c,298 :: 		break;
	GOTO        L_FSM12
;FIRMWARE_SYA_ver_1_3_0.c,299 :: 		case s6:
L_FSM70:
;FIRMWARE_SYA_ver_1_3_0.c,300 :: 		if((1 == sn_GoTo) && (1 == GT1) && (1 == clock0)){
	MOVLW       0
	XORWF       _sn_GoTo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM154
	MOVF        _sn_GoTo+0, 0 
	XORLW       1
L__FSM154:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM73
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM73
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM155
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM155:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM73
L__FSM119:
;FIRMWARE_SYA_ver_1_3_0.c,301 :: 		GT2 = 1;
	BSF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,302 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,303 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,304 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,305 :: 		}
	GOTO        L_FSM74
L_FSM73:
;FIRMWARE_SYA_ver_1_3_0.c,306 :: 		else if((1 == sn_GoTo) && (1 == GT2) && (1 == clock0)){
	MOVLW       0
	XORWF       _sn_GoTo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM156
	MOVF        _sn_GoTo+0, 0 
	XORLW       1
L__FSM156:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM77
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM77
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM157
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM157:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM77
L__FSM118:
;FIRMWARE_SYA_ver_1_3_0.c,307 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,308 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,309 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,310 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,311 :: 		}
	GOTO        L_FSM78
L_FSM77:
;FIRMWARE_SYA_ver_1_3_0.c,312 :: 		else if((1 == sn_GoTo) && (1 == GT3) && (1 == clock0)){
	MOVLW       0
	XORWF       _sn_GoTo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM158
	MOVF        _sn_GoTo+0, 0 
	XORLW       1
L__FSM158:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM81
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM81
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM159
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM159:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM81
L__FSM117:
;FIRMWARE_SYA_ver_1_3_0.c,313 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,314 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,315 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,316 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,317 :: 		}
	GOTO        L_FSM82
L_FSM81:
;FIRMWARE_SYA_ver_1_3_0.c,319 :: 		}
L_FSM82:
L_FSM78:
L_FSM74:
;FIRMWARE_SYA_ver_1_3_0.c,320 :: 		break;
	GOTO        L_FSM12
;FIRMWARE_SYA_ver_1_3_0.c,321 :: 		case s7:
L_FSM83:
;FIRMWARE_SYA_ver_1_3_0.c,322 :: 		if((1 == GT1) && (0 == GT2) && (0 == GT3)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM86
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM86
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM86
L__FSM116:
;FIRMWARE_SYA_ver_1_3_0.c,323 :: 		next_state = s2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,324 :: 		}
	GOTO        L_FSM87
L_FSM86:
;FIRMWARE_SYA_ver_1_3_0.c,325 :: 		else if((1 == GT2) && (0 == GT1) && (0 == GT3)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM90
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM90
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM90
L__FSM115:
;FIRMWARE_SYA_ver_1_3_0.c,326 :: 		next_state = s3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,327 :: 		}
	GOTO        L_FSM91
L_FSM90:
;FIRMWARE_SYA_ver_1_3_0.c,328 :: 		else if((1 == GT3) && (0 == GT1) && (0 == GT2)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM94
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM94
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM94
L__FSM114:
;FIRMWARE_SYA_ver_1_3_0.c,329 :: 		next_state = s1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,330 :: 		}
L_FSM94:
L_FSM91:
L_FSM87:
;FIRMWARE_SYA_ver_1_3_0.c,331 :: 		break;
	GOTO        L_FSM12
;FIRMWARE_SYA_ver_1_3_0.c,332 :: 		default:
L_FSM95:
;FIRMWARE_SYA_ver_1_3_0.c,333 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,334 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,335 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,336 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,337 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,338 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,339 :: 		current_state = s0;
	CLRF        _current_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,340 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,341 :: 		break;
	GOTO        L_FSM12
;FIRMWARE_SYA_ver_1_3_0.c,342 :: 		}
L_FSM11:
	MOVF        _current_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM13
	MOVF        _current_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM18
	MOVF        _current_state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM27
	MOVF        _current_state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM36
	MOVF        _current_state+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM45
	MOVF        _current_state+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM65
	MOVF        _current_state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM70
	MOVF        _current_state+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM83
	GOTO        L_FSM95
L_FSM12:
;FIRMWARE_SYA_ver_1_3_0.c,344 :: 		}
L_end_FSM:
	RETURN      0
; end of _FSM

_Events:

;FIRMWARE_SYA_ver_1_3_0.c,350 :: 		void Events(){
;FIRMWARE_SYA_ver_1_3_0.c,351 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_Events96:
	DECFSZ      R13, 1, 1
	BRA         L_Events96
	DECFSZ      R12, 1, 1
	BRA         L_Events96
	DECFSZ      R11, 1, 1
	BRA         L_Events96
	NOP
	NOP
;FIRMWARE_SYA_ver_1_3_0.c,353 :: 		if(1 == interruptC0){
	MOVLW       0
	XORWF       _interruptC0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Events161
	MOVF        _interruptC0+0, 0 
	XORLW       1
L__Events161:
	BTFSS       STATUS+0, 2 
	GOTO        L_Events97
;FIRMWARE_SYA_ver_1_3_0.c,355 :: 		if(1 == SWITCH1){
	BTFSS       PORTC+0, 0 
	GOTO        L_Events98
;FIRMWARE_SYA_ver_1_3_0.c,357 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,358 :: 		sn_NegEdge_1 = 1;
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,359 :: 		}
	GOTO        L_Events99
L_Events98:
;FIRMWARE_SYA_ver_1_3_0.c,363 :: 		sn_PosEdge_1 = 1;
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,364 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,365 :: 		}
L_Events99:
;FIRMWARE_SYA_ver_1_3_0.c,366 :: 		interruptC0 = 0; // Limpiamos la bandera de interrupcion en C0
	CLRF        _interruptC0+0 
	CLRF        _interruptC0+1 
;FIRMWARE_SYA_ver_1_3_0.c,367 :: 		}
	GOTO        L_Events100
L_Events97:
;FIRMWARE_SYA_ver_1_3_0.c,369 :: 		else if(1 == interruptC1){
	MOVLW       0
	XORWF       _interruptC1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Events162
	MOVF        _interruptC1+0, 0 
	XORLW       1
L__Events162:
	BTFSS       STATUS+0, 2 
	GOTO        L_Events101
;FIRMWARE_SYA_ver_1_3_0.c,371 :: 		if(1 == SWITCH2){
	BTFSS       PORTC+0, 1 
	GOTO        L_Events102
;FIRMWARE_SYA_ver_1_3_0.c,373 :: 		sn_PosEdge_2 = 0;
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,374 :: 		sn_NegEdge_2 = 1;
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,375 :: 		}
	GOTO        L_Events103
L_Events102:
;FIRMWARE_SYA_ver_1_3_0.c,379 :: 		sn_PosEdge_2 = 1;
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,380 :: 		sn_NegEdge_2 = 0;
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,381 :: 		}
L_Events103:
;FIRMWARE_SYA_ver_1_3_0.c,382 :: 		interruptC1 = 0; // Limpiamos la bandera de interrupcion en C1
	CLRF        _interruptC1+0 
	CLRF        _interruptC1+1 
;FIRMWARE_SYA_ver_1_3_0.c,383 :: 		}
	GOTO        L_Events104
L_Events101:
;FIRMWARE_SYA_ver_1_3_0.c,384 :: 		else if((1 == interruptC2) || (0 == SWITCH3)){
	MOVLW       0
	XORWF       _interruptC2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Events163
	MOVF        _interruptC2+0, 0 
	XORLW       1
L__Events163:
	BTFSC       STATUS+0, 2 
	GOTO        L__Events133
	BTFSS       PORTC+0, 2 
	GOTO        L__Events133
	GOTO        L_Events107
L__Events133:
;FIRMWARE_SYA_ver_1_3_0.c,385 :: 		if(1 == SWITCH3){
	BTFSS       PORTC+0, 2 
	GOTO        L_Events108
;FIRMWARE_SYA_ver_1_3_0.c,386 :: 		sn_PosEdge_3 = 0;
	BCF         _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,387 :: 		sn_NegEdge_3 = 1;
	BSF         _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,388 :: 		}
	GOTO        L_Events109
L_Events108:
;FIRMWARE_SYA_ver_1_3_0.c,390 :: 		sn_PosEdge_3 = 1;
	BSF         _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,391 :: 		sn_NegEdge_3 = 0;
	BCF         _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,392 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,393 :: 		}
L_Events109:
;FIRMWARE_SYA_ver_1_3_0.c,394 :: 		interruptC2 = 0;
	CLRF        _interruptC2+0 
	CLRF        _interruptC2+1 
;FIRMWARE_SYA_ver_1_3_0.c,395 :: 		}
	GOTO        L_Events110
L_Events107:
;FIRMWARE_SYA_ver_1_3_0.c,397 :: 		interruptC0 = 0;
	CLRF        _interruptC0+0 
	CLRF        _interruptC0+1 
;FIRMWARE_SYA_ver_1_3_0.c,398 :: 		interruptC1 = 0;
	CLRF        _interruptC1+0 
	CLRF        _interruptC1+1 
;FIRMWARE_SYA_ver_1_3_0.c,399 :: 		interruptC2 = 0;
	CLRF        _interruptC2+0 
	CLRF        _interruptC2+1 
;FIRMWARE_SYA_ver_1_3_0.c,400 :: 		}
L_Events110:
L_Events104:
L_Events100:
;FIRMWARE_SYA_ver_1_3_0.c,401 :: 		return;
;FIRMWARE_SYA_ver_1_3_0.c,403 :: 		}
L_end_Events:
	RETURN      0
; end of _Events

_InitSystems:

;FIRMWARE_SYA_ver_1_3_0.c,409 :: 		void InitSystems(){
;FIRMWARE_SYA_ver_1_3_0.c,410 :: 		InitMCU();
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,411 :: 		InitInterrupt();
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,412 :: 		}
L_end_InitSystems:
	RETURN      0
; end of _InitSystems

_InitInterrupt:

;FIRMWARE_SYA_ver_1_3_0.c,418 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_1_3_0.c,420 :: 		PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       48
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_1_3_0.c,421 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_1_3_0.c,426 :: 		IOCCN = 0x07;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       7
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_1_3_0.c,427 :: 		IOCCP = 0x07;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
	MOVLW       7
	MOVWF       IOCCP+0 
;FIRMWARE_SYA_ver_1_3_0.c,428 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_1_3_0.c,429 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,430 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_1_3_0.c,432 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_1_3_0.c,438 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_1_3_0.c,440 :: 		ADCON0 = 0x08; // Desactivamos ADC
	MOVLW       8
	MOVWF       ADCON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,441 :: 		ANSELC = 0x00;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_1_3_0.c,442 :: 		ANSELE = 0x00;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_1_3_0.c,443 :: 		ANSELA = 0x00;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_1_3_0.c,444 :: 		ANSELD = 0x00;
	CLRF        ANSELD+0 
;FIRMWARE_SYA_ver_1_3_0.c,446 :: 		TRISC = 0x0F;  // Ponemos en modo de entrada a C0, C1, c2 Y c3, los demas como salida
	MOVLW       15
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_1_3_0.c,447 :: 		TRISD = 0x07;  // Ponemos en modo de entrada a D0 y D1
	MOVLW       7
	MOVWF       TRISD+0 
;FIRMWARE_SYA_ver_1_3_0.c,448 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_1_3_0.c,449 :: 		TRISA = 0x80;  //                ''                A
	MOVLW       128
	MOVWF       TRISA+0 
;FIRMWARE_SYA_ver_1_3_0.c,451 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_1_3_0.c,452 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;FIRMWARE_SYA_ver_1_3_0.c,453 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_1_3_0.c,454 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_1_3_0.c,456 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_1_3_0.c,457 :: 		LATD = 0x00;
	CLRF        LATD+0 
;FIRMWARE_SYA_ver_1_3_0.c,458 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_1_3_0.c,459 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_1_3_0.c,463 :: 		WPUD = 0x07;   // Activamos el pull-up interno de C0 y C1
	MOVLW       7
	MOVWF       WPUD+0 
;FIRMWARE_SYA_ver_1_3_0.c,464 :: 		INLVLD = 0x07; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       7
	MOVWF       INLVLD+0 
;FIRMWARE_SYA_ver_1_3_0.c,465 :: 		CM1CON0 = 0x00; // Desactivamos el comparador 1
	CLRF        CM1CON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,466 :: 		CM2CON0 = 0x00; // Desactivamos el comparador 2
	CLRF        CM2CON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,467 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,469 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
