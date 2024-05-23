
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
L__interrupt116:
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
L__interrupt115:
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
L__interrupt114:
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
;FIRMWARE_SYA_ver_1_3_0.c,170 :: 		}
L_end_interrupt:
L__interrupt144:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_1_3_0.c,176 :: 		void main(){
;FIRMWARE_SYA_ver_1_3_0.c,178 :: 		InitSystems();
	CALL        _InitSystems+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,180 :: 		do{
L_main9:
;FIRMWARE_SYA_ver_1_3_0.c,181 :: 		}while((1 == IOCCF.B0) || (1 == IOCCF.B1) || (1 == IOCCF.B2));
	BTFSC       IOCCF+0, 0 
	GOTO        L_main9
	BTFSC       IOCCF+0, 1 
	GOTO        L_main9
	BTFSC       IOCCF+0, 2 
	GOTO        L_main9
L__main117:
;FIRMWARE_SYA_ver_1_3_0.c,183 :: 		while(1){
L_main14:
;FIRMWARE_SYA_ver_1_3_0.c,185 :: 		current_state = next_state; // Maybe move this with Events
	MOVF        _next_state+0, 0 
	MOVWF       _current_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,186 :: 		FSM();
	CALL        _FSM+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,187 :: 		}
	GOTO        L_main14
;FIRMWARE_SYA_ver_1_3_0.c,189 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_FSM:

;FIRMWARE_SYA_ver_1_3_0.c,195 :: 		void FSM(){
;FIRMWARE_SYA_ver_1_3_0.c,196 :: 		clock0 = 1;
	MOVLW       1
	MOVWF       _clock0+0 
	MOVLW       0
	MOVWF       _clock0+1 
;FIRMWARE_SYA_ver_1_3_0.c,197 :: 		switch(current_state){
	GOTO        L_FSM16
;FIRMWARE_SYA_ver_1_3_0.c,198 :: 		case s0:
L_FSM18:
;FIRMWARE_SYA_ver_1_3_0.c,199 :: 		M1Off();
	CALL        _M1Off+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,200 :: 		M2Off();
	CALL        _M2Off+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,201 :: 		M3Off();
	CALL        _M3Off+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,202 :: 		sn_GoTo = 0;
	CLRF        _sn_GoTo+0 
	CLRF        _sn_GoTo+1 
;FIRMWARE_SYA_ver_1_3_0.c,203 :: 		if((1 == sn_PosEdge_1) && (1 == clock0)){
	MOVLW       0
	XORWF       _sn_PosEdge_1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM147
	MOVF        _sn_PosEdge_1+0, 0 
	XORLW       1
L__FSM147:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM21
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM148
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM148:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM21
L__FSM136:
;FIRMWARE_SYA_ver_1_3_0.c,204 :: 		next_state = s7;
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,205 :: 		}
	GOTO        L_FSM22
L_FSM21:
;FIRMWARE_SYA_ver_1_3_0.c,207 :: 		}
L_FSM22:
;FIRMWARE_SYA_ver_1_3_0.c,208 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,209 :: 		case s1:
L_FSM23:
;FIRMWARE_SYA_ver_1_3_0.c,210 :: 		M1On();
	CALL        _M1On+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,211 :: 		M2Off();
	CALL        _M2Off+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,212 :: 		M3Off();
	CALL        _M3Off+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,213 :: 		GT1 = 1;
	MOVLW       1
	MOVWF       _GT1+0 
	MOVLW       0
	MOVWF       _GT1+1 
;FIRMWARE_SYA_ver_1_3_0.c,214 :: 		GT2 = 0;
	CLRF        _GT2+0 
	CLRF        _GT2+1 
;FIRMWARE_SYA_ver_1_3_0.c,215 :: 		GT3 = 0;
	CLRF        _GT3+0 
	CLRF        _GT3+1 
;FIRMWARE_SYA_ver_1_3_0.c,217 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	MOVLW       0
	XORWF       _sn_NegEdge_1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM149
	MOVF        _sn_NegEdge_1+0, 0 
	XORLW       1
L__FSM149:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM26
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM150
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM150:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM26
L__FSM135:
;FIRMWARE_SYA_ver_1_3_0.c,219 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,220 :: 		}
	GOTO        L_FSM27
L_FSM26:
;FIRMWARE_SYA_ver_1_3_0.c,221 :: 		else if((1 == sn_PosEdge_2) && (1 == clock0)){
	MOVLW       0
	XORWF       _sn_PosEdge_2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM151
	MOVF        _sn_PosEdge_2+0, 0 
	XORLW       1
L__FSM151:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM30
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM152
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM152:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM30
L__FSM134:
;FIRMWARE_SYA_ver_1_3_0.c,222 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,223 :: 		}
	GOTO        L_FSM31
L_FSM30:
;FIRMWARE_SYA_ver_1_3_0.c,225 :: 		}
L_FSM31:
L_FSM27:
;FIRMWARE_SYA_ver_1_3_0.c,226 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,227 :: 		case s2:
L_FSM32:
;FIRMWARE_SYA_ver_1_3_0.c,228 :: 		M1Off();
	CALL        _M1Off+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,229 :: 		M2On();
	CALL        _M2On+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,230 :: 		M3Off();
	CALL        _M3Off+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,231 :: 		GT1 = 0;
	CLRF        _GT1+0 
	CLRF        _GT1+1 
;FIRMWARE_SYA_ver_1_3_0.c,232 :: 		GT2 = 1;
	MOVLW       1
	MOVWF       _GT2+0 
	MOVLW       0
	MOVWF       _GT2+1 
;FIRMWARE_SYA_ver_1_3_0.c,233 :: 		GT3 = 0;
	CLRF        _GT3+0 
	CLRF        _GT3+1 
;FIRMWARE_SYA_ver_1_3_0.c,234 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	MOVLW       0
	XORWF       _sn_NegEdge_1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM153
	MOVF        _sn_NegEdge_1+0, 0 
	XORLW       1
L__FSM153:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM35
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM154
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM154:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM35
L__FSM133:
;FIRMWARE_SYA_ver_1_3_0.c,235 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,236 :: 		}
	GOTO        L_FSM36
L_FSM35:
;FIRMWARE_SYA_ver_1_3_0.c,237 :: 		else if((1 == sn_PosEdge_2) && (1 == clock0)){
	MOVLW       0
	XORWF       _sn_PosEdge_2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM155
	MOVF        _sn_PosEdge_2+0, 0 
	XORLW       1
L__FSM155:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM39
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM156
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM156:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM39
L__FSM132:
;FIRMWARE_SYA_ver_1_3_0.c,238 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,239 :: 		}
	GOTO        L_FSM40
L_FSM39:
;FIRMWARE_SYA_ver_1_3_0.c,241 :: 		}
L_FSM40:
L_FSM36:
;FIRMWARE_SYA_ver_1_3_0.c,242 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,243 :: 		case s3:
L_FSM41:
;FIRMWARE_SYA_ver_1_3_0.c,244 :: 		M1Off();
	CALL        _M1Off+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,245 :: 		M2Off();
	CALL        _M2Off+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,246 :: 		M3On();
	CALL        _M3On+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,247 :: 		GT1 = 0;
	CLRF        _GT1+0 
	CLRF        _GT1+1 
;FIRMWARE_SYA_ver_1_3_0.c,248 :: 		GT2 = 0;
	CLRF        _GT2+0 
	CLRF        _GT2+1 
;FIRMWARE_SYA_ver_1_3_0.c,249 :: 		GT3 = 1;
	MOVLW       1
	MOVWF       _GT3+0 
	MOVLW       0
	MOVWF       _GT3+1 
;FIRMWARE_SYA_ver_1_3_0.c,250 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	MOVLW       0
	XORWF       _sn_NegEdge_1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM157
	MOVF        _sn_NegEdge_1+0, 0 
	XORLW       1
L__FSM157:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM44
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM158
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM158:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM44
L__FSM131:
;FIRMWARE_SYA_ver_1_3_0.c,251 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,252 :: 		}
	GOTO        L_FSM45
L_FSM44:
;FIRMWARE_SYA_ver_1_3_0.c,253 :: 		else if((1 == sn_PosEdge_2) && (1 == clock0)){
	MOVLW       0
	XORWF       _sn_PosEdge_2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM159
	MOVF        _sn_PosEdge_2+0, 0 
	XORLW       1
L__FSM159:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM48
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM160
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM160:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM48
L__FSM130:
;FIRMWARE_SYA_ver_1_3_0.c,254 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,255 :: 		}
	GOTO        L_FSM49
L_FSM48:
;FIRMWARE_SYA_ver_1_3_0.c,257 :: 		}
L_FSM49:
L_FSM45:
;FIRMWARE_SYA_ver_1_3_0.c,258 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,259 :: 		case s4:
L_FSM50:
;FIRMWARE_SYA_ver_1_3_0.c,260 :: 		if((1 == GT1) && (0 == GT2) && (0 == GT3)){
	MOVLW       0
	XORWF       _GT1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM161
	MOVF        _GT1+0, 0 
	XORLW       1
L__FSM161:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM53
	MOVLW       0
	XORWF       _GT2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM162
	MOVF        _GT2+0, 0 
	XORLW       0
L__FSM162:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM53
	MOVLW       0
	XORWF       _GT3+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM163
	MOVF        _GT3+0, 0 
	XORLW       0
L__FSM163:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM53
L__FSM129:
;FIRMWARE_SYA_ver_1_3_0.c,261 :: 		M1On();
	CALL        _M1On+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,262 :: 		M2On();
	CALL        _M2On+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,263 :: 		M3Off();
	CALL        _M3Off+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,264 :: 		}
	GOTO        L_FSM54
L_FSM53:
;FIRMWARE_SYA_ver_1_3_0.c,265 :: 		else if((1 == GT2) && (0 == GT1) && (0 == GT3)){
	MOVLW       0
	XORWF       _GT2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM164
	MOVF        _GT2+0, 0 
	XORLW       1
L__FSM164:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM57
	MOVLW       0
	XORWF       _GT1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM165
	MOVF        _GT1+0, 0 
	XORLW       0
L__FSM165:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM57
	MOVLW       0
	XORWF       _GT3+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM166
	MOVF        _GT3+0, 0 
	XORLW       0
L__FSM166:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM57
L__FSM128:
;FIRMWARE_SYA_ver_1_3_0.c,266 :: 		M1Off();
	CALL        _M1Off+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,267 :: 		M2On();
	CALL        _M2On+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,268 :: 		M3On();
	CALL        _M3On+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,269 :: 		}
	GOTO        L_FSM58
L_FSM57:
;FIRMWARE_SYA_ver_1_3_0.c,270 :: 		else if((1 == GT3) && (0 == GT1) && (0 == GT2)){
	MOVLW       0
	XORWF       _GT3+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM167
	MOVF        _GT3+0, 0 
	XORLW       1
L__FSM167:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM61
	MOVLW       0
	XORWF       _GT1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM168
	MOVF        _GT1+0, 0 
	XORLW       0
L__FSM168:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM61
	MOVLW       0
	XORWF       _GT2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM169
	MOVF        _GT2+0, 0 
	XORLW       0
L__FSM169:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM61
L__FSM127:
;FIRMWARE_SYA_ver_1_3_0.c,271 :: 		M1On();
	CALL        _M1On+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,272 :: 		M2Off();
	CALL        _M2Off+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,273 :: 		M3On();
	CALL        _M3On+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,274 :: 		}
L_FSM61:
L_FSM58:
L_FSM54:
;FIRMWARE_SYA_ver_1_3_0.c,275 :: 		if((1 == sn_NegEdge_2) && (1 == clock0)){
	MOVLW       0
	XORWF       _sn_NegEdge_2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM170
	MOVF        _sn_NegEdge_2+0, 0 
	XORLW       1
L__FSM170:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM64
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM171
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM171:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM64
L__FSM126:
;FIRMWARE_SYA_ver_1_3_0.c,276 :: 		next_state = s7;
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,277 :: 		}
	GOTO        L_FSM65
L_FSM64:
;FIRMWARE_SYA_ver_1_3_0.c,278 :: 		else if((1 == sn_PosEdge_3) && (1 == clock0)){
	MOVLW       0
	XORWF       _sn_PosEdge_3+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM172
	MOVF        _sn_PosEdge_3+0, 0 
	XORLW       1
L__FSM172:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM68
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM173
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM173:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM68
L__FSM125:
;FIRMWARE_SYA_ver_1_3_0.c,279 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,280 :: 		}
	GOTO        L_FSM69
L_FSM68:
;FIRMWARE_SYA_ver_1_3_0.c,282 :: 		}
L_FSM69:
L_FSM65:
;FIRMWARE_SYA_ver_1_3_0.c,283 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,284 :: 		case s5:
L_FSM70:
;FIRMWARE_SYA_ver_1_3_0.c,285 :: 		M1On();
	CALL        _M1On+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,286 :: 		M2On();
	CALL        _M2On+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,287 :: 		M3On();
	CALL        _M3On+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,288 :: 		if((1 == sn_NegEdge_3) && (1 == clock0)){
	MOVLW       0
	XORWF       _sn_NegEdge_3+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM174
	MOVF        _sn_NegEdge_3+0, 0 
	XORLW       1
L__FSM174:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM73
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM175
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM175:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM73
L__FSM124:
;FIRMWARE_SYA_ver_1_3_0.c,289 :: 		sn_GoTo = 1;
	MOVLW       1
	MOVWF       _sn_GoTo+0 
	MOVLW       0
	MOVWF       _sn_GoTo+1 
;FIRMWARE_SYA_ver_1_3_0.c,290 :: 		next_state = s6;
	MOVLW       6
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,291 :: 		}
	GOTO        L_FSM74
L_FSM73:
;FIRMWARE_SYA_ver_1_3_0.c,293 :: 		}
L_FSM74:
;FIRMWARE_SYA_ver_1_3_0.c,294 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,295 :: 		case s6:
L_FSM75:
;FIRMWARE_SYA_ver_1_3_0.c,296 :: 		if((1 == sn_GoTo) && (1 == GT1) && (1 == clock0)){
	MOVLW       0
	XORWF       _sn_GoTo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM176
	MOVF        _sn_GoTo+0, 0 
	XORLW       1
L__FSM176:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM78
	MOVLW       0
	XORWF       _GT1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM177
	MOVF        _GT1+0, 0 
	XORLW       1
L__FSM177:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM78
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM178
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM178:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM78
L__FSM123:
;FIRMWARE_SYA_ver_1_3_0.c,297 :: 		GT2 = 1;
	MOVLW       1
	MOVWF       _GT2+0 
	MOVLW       0
	MOVWF       _GT2+1 
;FIRMWARE_SYA_ver_1_3_0.c,298 :: 		GT3 = 0;
	CLRF        _GT3+0 
	CLRF        _GT3+1 
;FIRMWARE_SYA_ver_1_3_0.c,299 :: 		GT1 = 0;
	CLRF        _GT1+0 
	CLRF        _GT1+1 
;FIRMWARE_SYA_ver_1_3_0.c,300 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,301 :: 		}
	GOTO        L_FSM79
L_FSM78:
;FIRMWARE_SYA_ver_1_3_0.c,302 :: 		else if((1 == sn_GoTo) && (1 == GT2) && (1 == clock0)){
	MOVLW       0
	XORWF       _sn_GoTo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM179
	MOVF        _sn_GoTo+0, 0 
	XORLW       1
L__FSM179:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM82
	MOVLW       0
	XORWF       _GT2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM180
	MOVF        _GT2+0, 0 
	XORLW       1
L__FSM180:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM82
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM181
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM181:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM82
L__FSM122:
;FIRMWARE_SYA_ver_1_3_0.c,303 :: 		GT2 = 0;
	CLRF        _GT2+0 
	CLRF        _GT2+1 
;FIRMWARE_SYA_ver_1_3_0.c,304 :: 		GT1 = 0;
	CLRF        _GT1+0 
	CLRF        _GT1+1 
;FIRMWARE_SYA_ver_1_3_0.c,305 :: 		GT3 = 1;
	MOVLW       1
	MOVWF       _GT3+0 
	MOVLW       0
	MOVWF       _GT3+1 
;FIRMWARE_SYA_ver_1_3_0.c,306 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,307 :: 		}
	GOTO        L_FSM83
L_FSM82:
;FIRMWARE_SYA_ver_1_3_0.c,308 :: 		else if((1 == sn_GoTo) && (1 == GT3) && (1 == clock0)){
	MOVLW       0
	XORWF       _sn_GoTo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM182
	MOVF        _sn_GoTo+0, 0 
	XORLW       1
L__FSM182:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM86
	MOVLW       0
	XORWF       _GT3+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM183
	MOVF        _GT3+0, 0 
	XORLW       1
L__FSM183:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM86
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM184
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM184:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM86
L__FSM121:
;FIRMWARE_SYA_ver_1_3_0.c,309 :: 		GT1 = 1;
	MOVLW       1
	MOVWF       _GT1+0 
	MOVLW       0
	MOVWF       _GT1+1 
;FIRMWARE_SYA_ver_1_3_0.c,310 :: 		GT2 = 0;
	CLRF        _GT2+0 
	CLRF        _GT2+1 
;FIRMWARE_SYA_ver_1_3_0.c,311 :: 		GT3 = 0;
	CLRF        _GT3+0 
	CLRF        _GT3+1 
;FIRMWARE_SYA_ver_1_3_0.c,312 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,313 :: 		}
	GOTO        L_FSM87
L_FSM86:
;FIRMWARE_SYA_ver_1_3_0.c,315 :: 		}
L_FSM87:
L_FSM83:
L_FSM79:
;FIRMWARE_SYA_ver_1_3_0.c,316 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,317 :: 		case s7:
L_FSM88:
;FIRMWARE_SYA_ver_1_3_0.c,318 :: 		if((1 == GT1) && (1 == clock0)){
	MOVLW       0
	XORWF       _GT1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM185
	MOVF        _GT1+0, 0 
	XORLW       1
L__FSM185:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM91
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM186
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM186:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM91
L__FSM120:
;FIRMWARE_SYA_ver_1_3_0.c,319 :: 		next_state = s2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,320 :: 		GT2 = 0;
	CLRF        _GT2+0 
	CLRF        _GT2+1 
;FIRMWARE_SYA_ver_1_3_0.c,321 :: 		GT3 = 0;
	CLRF        _GT3+0 
	CLRF        _GT3+1 
;FIRMWARE_SYA_ver_1_3_0.c,322 :: 		}
	GOTO        L_FSM92
L_FSM91:
;FIRMWARE_SYA_ver_1_3_0.c,323 :: 		else if((1 == GT2) && (1 == clock0)){
	MOVLW       0
	XORWF       _GT2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM187
	MOVF        _GT2+0, 0 
	XORLW       1
L__FSM187:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM95
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM188
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM188:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM95
L__FSM119:
;FIRMWARE_SYA_ver_1_3_0.c,324 :: 		next_state = s3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,325 :: 		GT1 = 0;
	CLRF        _GT1+0 
	CLRF        _GT1+1 
;FIRMWARE_SYA_ver_1_3_0.c,326 :: 		GT3 = 0;
	CLRF        _GT3+0 
	CLRF        _GT3+1 
;FIRMWARE_SYA_ver_1_3_0.c,327 :: 		}
	GOTO        L_FSM96
L_FSM95:
;FIRMWARE_SYA_ver_1_3_0.c,328 :: 		else if((1 == GT3) && (1 == clock0)){
	MOVLW       0
	XORWF       _GT3+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM189
	MOVF        _GT3+0, 0 
	XORLW       1
L__FSM189:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM99
	MOVLW       0
	XORWF       _clock0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM190
	MOVF        _clock0+0, 0 
	XORLW       1
L__FSM190:
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM99
L__FSM118:
;FIRMWARE_SYA_ver_1_3_0.c,329 :: 		next_state = s1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,330 :: 		GT1 = 0;
	CLRF        _GT1+0 
	CLRF        _GT1+1 
;FIRMWARE_SYA_ver_1_3_0.c,331 :: 		GT2 = 0;
	CLRF        _GT2+0 
	CLRF        _GT2+1 
;FIRMWARE_SYA_ver_1_3_0.c,332 :: 		}
	GOTO        L_FSM100
L_FSM99:
;FIRMWARE_SYA_ver_1_3_0.c,334 :: 		}
L_FSM100:
L_FSM96:
L_FSM92:
;FIRMWARE_SYA_ver_1_3_0.c,335 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,336 :: 		default:
L_FSM101:
;FIRMWARE_SYA_ver_1_3_0.c,337 :: 		GT1 = 0;
	CLRF        _GT1+0 
	CLRF        _GT1+1 
;FIRMWARE_SYA_ver_1_3_0.c,338 :: 		GT2 = 0;
	CLRF        _GT2+0 
	CLRF        _GT2+1 
;FIRMWARE_SYA_ver_1_3_0.c,339 :: 		GT3 = 1;
	MOVLW       1
	MOVWF       _GT3+0 
	MOVLW       0
	MOVWF       _GT3+1 
;FIRMWARE_SYA_ver_1_3_0.c,340 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,341 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,342 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,343 :: 		current_state = s0;
	CLRF        _current_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,344 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,345 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,346 :: 		}
L_FSM16:
	MOVF        _current_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM18
	MOVF        _current_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM23
	MOVF        _current_state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM32
	MOVF        _current_state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM41
	MOVF        _current_state+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM50
	MOVF        _current_state+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM70
	MOVF        _current_state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM75
	MOVF        _current_state+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM88
	GOTO        L_FSM101
L_FSM17:
;FIRMWARE_SYA_ver_1_3_0.c,348 :: 		}
L_end_FSM:
	RETURN      0
; end of _FSM

_Events:

;FIRMWARE_SYA_ver_1_3_0.c,354 :: 		void Events(){
;FIRMWARE_SYA_ver_1_3_0.c,356 :: 		if(1 == interruptC0){
	MOVLW       0
	XORWF       _interruptC0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Events192
	MOVF        _interruptC0+0, 0 
	XORLW       1
L__Events192:
	BTFSS       STATUS+0, 2 
	GOTO        L_Events102
;FIRMWARE_SYA_ver_1_3_0.c,358 :: 		if(1 == SWITCH1){
	BTFSS       PORTC+0, 0 
	GOTO        L_Events103
;FIRMWARE_SYA_ver_1_3_0.c,360 :: 		sn_PosEdge_1 = 0;
	CLRF        _sn_PosEdge_1+0 
	CLRF        _sn_PosEdge_1+1 
;FIRMWARE_SYA_ver_1_3_0.c,361 :: 		sn_NegEdge_1 = 1;
	MOVLW       1
	MOVWF       _sn_NegEdge_1+0 
	MOVLW       0
	MOVWF       _sn_NegEdge_1+1 
;FIRMWARE_SYA_ver_1_3_0.c,362 :: 		}
	GOTO        L_Events104
L_Events103:
;FIRMWARE_SYA_ver_1_3_0.c,366 :: 		sn_PosEdge_1 = 1;
	MOVLW       1
	MOVWF       _sn_PosEdge_1+0 
	MOVLW       0
	MOVWF       _sn_PosEdge_1+1 
;FIRMWARE_SYA_ver_1_3_0.c,367 :: 		sn_NegEdge_1 = 0;
	CLRF        _sn_NegEdge_1+0 
	CLRF        _sn_NegEdge_1+1 
;FIRMWARE_SYA_ver_1_3_0.c,368 :: 		}
L_Events104:
;FIRMWARE_SYA_ver_1_3_0.c,369 :: 		interruptC0 = 0; // Limpiamos la bandera de interrupcion en C0
	CLRF        _interruptC0+0 
	CLRF        _interruptC0+1 
;FIRMWARE_SYA_ver_1_3_0.c,370 :: 		}
	GOTO        L_Events105
L_Events102:
;FIRMWARE_SYA_ver_1_3_0.c,372 :: 		else if(1 == interruptC1){
	MOVLW       0
	XORWF       _interruptC1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Events193
	MOVF        _interruptC1+0, 0 
	XORLW       1
L__Events193:
	BTFSS       STATUS+0, 2 
	GOTO        L_Events106
;FIRMWARE_SYA_ver_1_3_0.c,374 :: 		if(1 == SWITCH2){
	BTFSS       PORTC+0, 1 
	GOTO        L_Events107
;FIRMWARE_SYA_ver_1_3_0.c,376 :: 		sn_PosEdge_2 = 0;
	CLRF        _sn_PosEdge_2+0 
	CLRF        _sn_PosEdge_2+1 
;FIRMWARE_SYA_ver_1_3_0.c,377 :: 		sn_NegEdge_2 = 1;
	MOVLW       1
	MOVWF       _sn_NegEdge_2+0 
	MOVLW       0
	MOVWF       _sn_NegEdge_2+1 
;FIRMWARE_SYA_ver_1_3_0.c,378 :: 		}
	GOTO        L_Events108
L_Events107:
;FIRMWARE_SYA_ver_1_3_0.c,382 :: 		sn_PosEdge_2 = 1;
	MOVLW       1
	MOVWF       _sn_PosEdge_2+0 
	MOVLW       0
	MOVWF       _sn_PosEdge_2+1 
;FIRMWARE_SYA_ver_1_3_0.c,383 :: 		sn_NegEdge_2 = 0;
	CLRF        _sn_NegEdge_2+0 
	CLRF        _sn_NegEdge_2+1 
;FIRMWARE_SYA_ver_1_3_0.c,384 :: 		}
L_Events108:
;FIRMWARE_SYA_ver_1_3_0.c,385 :: 		interruptC1 = 0; // Limpiamos la bandera de interrupcion en C1
	CLRF        _interruptC1+0 
	CLRF        _interruptC1+1 
;FIRMWARE_SYA_ver_1_3_0.c,386 :: 		}
	GOTO        L_Events109
L_Events106:
;FIRMWARE_SYA_ver_1_3_0.c,387 :: 		else if(1 == interruptC2){
	MOVLW       0
	XORWF       _interruptC2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Events194
	MOVF        _interruptC2+0, 0 
	XORLW       1
L__Events194:
	BTFSS       STATUS+0, 2 
	GOTO        L_Events110
;FIRMWARE_SYA_ver_1_3_0.c,388 :: 		if(1 == SWITCH3){
	BTFSS       PORTC+0, 2 
	GOTO        L_Events111
;FIRMWARE_SYA_ver_1_3_0.c,389 :: 		sn_PosEdge_3 = 0;
	CLRF        _sn_PosEdge_3+0 
	CLRF        _sn_PosEdge_3+1 
;FIRMWARE_SYA_ver_1_3_0.c,390 :: 		sn_NegEdge_3 = 1;
	MOVLW       1
	MOVWF       _sn_NegEdge_3+0 
	MOVLW       0
	MOVWF       _sn_NegEdge_3+1 
;FIRMWARE_SYA_ver_1_3_0.c,391 :: 		}
	GOTO        L_Events112
L_Events111:
;FIRMWARE_SYA_ver_1_3_0.c,393 :: 		sn_PosEdge_3 = 1;
	MOVLW       1
	MOVWF       _sn_PosEdge_3+0 
	MOVLW       0
	MOVWF       _sn_PosEdge_3+1 
;FIRMWARE_SYA_ver_1_3_0.c,394 :: 		sn_NegEdge_3 = 0;
	CLRF        _sn_NegEdge_3+0 
	CLRF        _sn_NegEdge_3+1 
;FIRMWARE_SYA_ver_1_3_0.c,395 :: 		}
L_Events112:
;FIRMWARE_SYA_ver_1_3_0.c,396 :: 		interruptC2 = 0;
	CLRF        _interruptC2+0 
	CLRF        _interruptC2+1 
;FIRMWARE_SYA_ver_1_3_0.c,397 :: 		}
	GOTO        L_Events113
L_Events110:
;FIRMWARE_SYA_ver_1_3_0.c,399 :: 		interruptC0 = 0;
	CLRF        _interruptC0+0 
	CLRF        _interruptC0+1 
;FIRMWARE_SYA_ver_1_3_0.c,400 :: 		interruptC1 = 0;
	CLRF        _interruptC1+0 
	CLRF        _interruptC1+1 
;FIRMWARE_SYA_ver_1_3_0.c,401 :: 		interruptC2 = 0;
	CLRF        _interruptC2+0 
	CLRF        _interruptC2+1 
;FIRMWARE_SYA_ver_1_3_0.c,402 :: 		}
L_Events113:
L_Events109:
L_Events105:
;FIRMWARE_SYA_ver_1_3_0.c,403 :: 		return;
;FIRMWARE_SYA_ver_1_3_0.c,405 :: 		}
L_end_Events:
	RETURN      0
; end of _Events

_InitSystems:

;FIRMWARE_SYA_ver_1_3_0.c,411 :: 		void InitSystems(){
;FIRMWARE_SYA_ver_1_3_0.c,412 :: 		InitMCU();
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,413 :: 		InitInterrupt();
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,414 :: 		}
L_end_InitSystems:
	RETURN      0
; end of _InitSystems

_InitInterrupt:

;FIRMWARE_SYA_ver_1_3_0.c,420 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_1_3_0.c,422 :: 		PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       48
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_1_3_0.c,423 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_1_3_0.c,428 :: 		IOCCN = 0x07;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       7
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_1_3_0.c,429 :: 		IOCCP = 0x07;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
	MOVLW       7
	MOVWF       IOCCP+0 
;FIRMWARE_SYA_ver_1_3_0.c,430 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_1_3_0.c,431 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,432 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_1_3_0.c,434 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_1_3_0.c,440 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_1_3_0.c,442 :: 		ADCON0 = 0x08; // Desactivamos ADC
	MOVLW       8
	MOVWF       ADCON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,443 :: 		ANSELC = 0x00;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_1_3_0.c,444 :: 		ANSELE = 0x00;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_1_3_0.c,445 :: 		ANSELA = 0x00;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_1_3_0.c,446 :: 		ANSELD = 0x00;
	CLRF        ANSELD+0 
;FIRMWARE_SYA_ver_1_3_0.c,448 :: 		TRISC = 0x0F;  // Ponemos en modo de entrada a C0, C1, c2 Y c3, los demas como salida
	MOVLW       15
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_1_3_0.c,449 :: 		TRISD = 0x07;  // Ponemos en modo de entrada a D0 y D1
	MOVLW       7
	MOVWF       TRISD+0 
;FIRMWARE_SYA_ver_1_3_0.c,450 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_1_3_0.c,451 :: 		TRISA = 0x80;  //                ''                A
	MOVLW       128
	MOVWF       TRISA+0 
;FIRMWARE_SYA_ver_1_3_0.c,453 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_1_3_0.c,454 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;FIRMWARE_SYA_ver_1_3_0.c,455 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_1_3_0.c,456 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_1_3_0.c,458 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_1_3_0.c,459 :: 		LATD = 0x00;
	CLRF        LATD+0 
;FIRMWARE_SYA_ver_1_3_0.c,460 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_1_3_0.c,461 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_1_3_0.c,465 :: 		WPUD = 0x07;   // Activamos el pull-up interno de C0 y C1
	MOVLW       7
	MOVWF       WPUD+0 
;FIRMWARE_SYA_ver_1_3_0.c,466 :: 		INLVLD = 0x07; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       7
	MOVWF       INLVLD+0 
;FIRMWARE_SYA_ver_1_3_0.c,467 :: 		CM1CON0 = 0x00; // Desactivamos el comparador 1
	CLRF        CM1CON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,468 :: 		CM2CON0 = 0x00; // Desactivamos el comparador 2
	CLRF        CM2CON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,470 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
