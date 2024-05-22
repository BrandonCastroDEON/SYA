
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
L__interrupt136:
;FIRMWARE_SYA_ver_1_3_0.c,112 :: 		IOCCF.B0 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,113 :: 		interruptC0 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_1_3_0.c,114 :: 		if(1 == interruptC0){
	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_interrupt3
;FIRMWARE_SYA_ver_1_3_0.c,116 :: 		if(1 == SWITCH1){
	BTFSS       PORTC+0, 0 
	GOTO        L_interrupt4
;FIRMWARE_SYA_ver_1_3_0.c,118 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,119 :: 		sn_NegEdge_1 = 1;
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,120 :: 		}
	GOTO        L_interrupt5
L_interrupt4:
;FIRMWARE_SYA_ver_1_3_0.c,124 :: 		sn_PosEdge_1 = 1;
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,125 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,126 :: 		}
L_interrupt5:
;FIRMWARE_SYA_ver_1_3_0.c,127 :: 		interruptC0 = 0; // Limpiamos la bandera de interrupcion en C0
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_1_3_0.c,128 :: 		}
L_interrupt3:
;FIRMWARE_SYA_ver_1_3_0.c,129 :: 		}
L_interrupt2:
;FIRMWARE_SYA_ver_1_3_0.c,131 :: 		if((1 == IOCCF.B1) && (1 == IOCIE_bit)){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt8
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt8
L__interrupt135:
;FIRMWARE_SYA_ver_1_3_0.c,132 :: 		IOCCF.B1 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,133 :: 		interruptC1 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,135 :: 		if(1 == interruptC1){
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_interrupt9
;FIRMWARE_SYA_ver_1_3_0.c,137 :: 		if(1 == SWITCH2){
	BTFSS       PORTC+0, 1 
	GOTO        L_interrupt10
;FIRMWARE_SYA_ver_1_3_0.c,139 :: 		sn_PosEdge_2 = 0;
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,140 :: 		sn_NegEdge_2 = 1;
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,141 :: 		}
	GOTO        L_interrupt11
L_interrupt10:
;FIRMWARE_SYA_ver_1_3_0.c,145 :: 		sn_PosEdge_2 = 1;
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,146 :: 		sn_NegEdge_2 = 0;
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,147 :: 		}
L_interrupt11:
;FIRMWARE_SYA_ver_1_3_0.c,148 :: 		interruptC1 = 0; // Limpiamos la bandera de interrupcion en C1
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,149 :: 		}
L_interrupt9:
;FIRMWARE_SYA_ver_1_3_0.c,150 :: 		}
L_interrupt8:
;FIRMWARE_SYA_ver_1_3_0.c,151 :: 		if((1 == IOCCF.B2) && (1 == IOCIE_bit)){
	BTFSS       IOCCF+0, 2 
	GOTO        L_interrupt14
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt14
L__interrupt134:
;FIRMWARE_SYA_ver_1_3_0.c,152 :: 		IOCCF.B2 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 2 
;FIRMWARE_SYA_ver_1_3_0.c,153 :: 		interruptC2 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC2+0, BitPos(_interruptC2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,154 :: 		if(1 == interruptC2){
	BTFSS       _interruptC2+0, BitPos(_interruptC2+0) 
	GOTO        L_interrupt15
;FIRMWARE_SYA_ver_1_3_0.c,155 :: 		if(1 == SWITCH3){
	BTFSS       PORTC+0, 2 
	GOTO        L_interrupt16
;FIRMWARE_SYA_ver_1_3_0.c,156 :: 		sn_PosEdge_3 = 0;
	BCF         _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,157 :: 		sn_NegEdge_3 = 1;
	BSF         _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,158 :: 		}
	GOTO        L_interrupt17
L_interrupt16:
;FIRMWARE_SYA_ver_1_3_0.c,160 :: 		sn_PosEdge_3 = 1;
	BSF         _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,161 :: 		sn_NegEdge_3 = 0;
	BCF         _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,162 :: 		}
L_interrupt17:
;FIRMWARE_SYA_ver_1_3_0.c,163 :: 		interruptC2 = 0;
	BCF         _interruptC2+0, BitPos(_interruptC2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,164 :: 		}
L_interrupt15:
;FIRMWARE_SYA_ver_1_3_0.c,165 :: 		}
L_interrupt14:
;FIRMWARE_SYA_ver_1_3_0.c,167 :: 		}
L_end_interrupt:
L__interrupt167:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_1_3_0.c,173 :: 		void main(){
;FIRMWARE_SYA_ver_1_3_0.c,175 :: 		InitSystems();
	CALL        _InitSystems+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,177 :: 		LED = ~LED;
	BTG         LATA+0, 4 
;FIRMWARE_SYA_ver_1_3_0.c,179 :: 		do{
L_main18:
;FIRMWARE_SYA_ver_1_3_0.c,180 :: 		}while((1 == IOCCF.B0) || (1 == IOCCF.B1) || (1 == IOCCF.B2));
	BTFSC       IOCCF+0, 0 
	GOTO        L_main18
	BTFSC       IOCCF+0, 1 
	GOTO        L_main18
	BTFSC       IOCCF+0, 2 
	GOTO        L_main18
L__main137:
;FIRMWARE_SYA_ver_1_3_0.c,182 :: 		while(1){
L_main23:
;FIRMWARE_SYA_ver_1_3_0.c,184 :: 		current_state = next_state; // Maybe move this with Events
	MOVF        _next_state+0, 0 
	MOVWF       _current_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,185 :: 		FSM();
	CALL        _FSM+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,186 :: 		}
	GOTO        L_main23
;FIRMWARE_SYA_ver_1_3_0.c,188 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_FSM:

;FIRMWARE_SYA_ver_1_3_0.c,194 :: 		void FSM(){
;FIRMWARE_SYA_ver_1_3_0.c,195 :: 		clock0 = 1;
	BSF         _clock0+0, BitPos(_clock0+0) 
;FIRMWARE_SYA_ver_1_3_0.c,196 :: 		switch(current_state){
	GOTO        L_FSM25
;FIRMWARE_SYA_ver_1_3_0.c,197 :: 		case s0:
L_FSM27:
;FIRMWARE_SYA_ver_1_3_0.c,198 :: 		M1Off();
	CALL        _M1Off+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,199 :: 		M2Off();
	CALL        _M2Off+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,200 :: 		M3Off();
	CALL        _M3Off+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,201 :: 		sn_GoTo = 0;
	BCF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_1_3_0.c,202 :: 		if((1 == sn_PosEdge_1) && (1 == clock0)){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM30
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM30
L__FSM159:
;FIRMWARE_SYA_ver_1_3_0.c,203 :: 		next_state = s7;
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,204 :: 		}
	GOTO        L_FSM31
L_FSM30:
;FIRMWARE_SYA_ver_1_3_0.c,206 :: 		}
L_FSM31:
;FIRMWARE_SYA_ver_1_3_0.c,207 :: 		break;
	GOTO        L_FSM26
;FIRMWARE_SYA_ver_1_3_0.c,208 :: 		case s1:
L_FSM32:
;FIRMWARE_SYA_ver_1_3_0.c,209 :: 		M1On();
	CALL        _M1On+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,210 :: 		M2Off();
	CALL        _M2Off+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,211 :: 		M3Off();
	CALL        _M3Off+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,212 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,213 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,214 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,216 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM35
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM35
L__FSM158:
;FIRMWARE_SYA_ver_1_3_0.c,218 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,219 :: 		}
	GOTO        L_FSM36
L_FSM35:
;FIRMWARE_SYA_ver_1_3_0.c,220 :: 		else if((1 == sn_PosEdge_2) && (1 == clock0)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM39
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM39
L__FSM157:
;FIRMWARE_SYA_ver_1_3_0.c,221 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,222 :: 		}
	GOTO        L_FSM40
L_FSM39:
;FIRMWARE_SYA_ver_1_3_0.c,224 :: 		}
L_FSM40:
L_FSM36:
;FIRMWARE_SYA_ver_1_3_0.c,225 :: 		break;
	GOTO        L_FSM26
;FIRMWARE_SYA_ver_1_3_0.c,226 :: 		case s2:
L_FSM41:
;FIRMWARE_SYA_ver_1_3_0.c,227 :: 		M1Off();
	CALL        _M1Off+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,228 :: 		M2On();
	CALL        _M2On+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,229 :: 		M3Off();
	CALL        _M3Off+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,230 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,231 :: 		GT2 = 1;
	BSF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,232 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,233 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM44
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM44
L__FSM156:
;FIRMWARE_SYA_ver_1_3_0.c,234 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,235 :: 		}
	GOTO        L_FSM45
L_FSM44:
;FIRMWARE_SYA_ver_1_3_0.c,236 :: 		else if((1 == sn_PosEdge_2) && (1 == clock0)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM48
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM48
L__FSM155:
;FIRMWARE_SYA_ver_1_3_0.c,237 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,238 :: 		}
	GOTO        L_FSM49
L_FSM48:
;FIRMWARE_SYA_ver_1_3_0.c,240 :: 		}
L_FSM49:
L_FSM45:
;FIRMWARE_SYA_ver_1_3_0.c,241 :: 		break;
	GOTO        L_FSM26
;FIRMWARE_SYA_ver_1_3_0.c,242 :: 		case s3:
L_FSM50:
;FIRMWARE_SYA_ver_1_3_0.c,243 :: 		M1Off();
	CALL        _M1Off+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,244 :: 		M2Off();
	CALL        _M2Off+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,245 :: 		M3On();
	CALL        _M3On+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,246 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,247 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,248 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,249 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM53
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM53
L__FSM154:
;FIRMWARE_SYA_ver_1_3_0.c,250 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,251 :: 		}
	GOTO        L_FSM54
L_FSM53:
;FIRMWARE_SYA_ver_1_3_0.c,252 :: 		else if((1 == sn_PosEdge_2) && (1 == clock0)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM57
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM57
L__FSM153:
;FIRMWARE_SYA_ver_1_3_0.c,253 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,254 :: 		}
	GOTO        L_FSM58
L_FSM57:
;FIRMWARE_SYA_ver_1_3_0.c,256 :: 		}
L_FSM58:
L_FSM54:
;FIRMWARE_SYA_ver_1_3_0.c,257 :: 		break;
	GOTO        L_FSM26
;FIRMWARE_SYA_ver_1_3_0.c,258 :: 		case s4:
L_FSM59:
;FIRMWARE_SYA_ver_1_3_0.c,259 :: 		if((1 == GT1) && (0 == GT2) && (0 == GT3)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM62
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM62
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM62
L__FSM152:
;FIRMWARE_SYA_ver_1_3_0.c,260 :: 		M1On();
	CALL        _M1On+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,261 :: 		M2On();
	CALL        _M2On+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,262 :: 		M3Off();
	CALL        _M3Off+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,263 :: 		}
	GOTO        L_FSM63
L_FSM62:
;FIRMWARE_SYA_ver_1_3_0.c,264 :: 		else if((1 == GT2) && (0 == GT1) && (0 == GT3)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM66
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM66
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM66
L__FSM151:
;FIRMWARE_SYA_ver_1_3_0.c,265 :: 		M1Off();
	CALL        _M1Off+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,266 :: 		M2On();
	CALL        _M2On+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,267 :: 		M3On();
	CALL        _M3On+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,268 :: 		}
	GOTO        L_FSM67
L_FSM66:
;FIRMWARE_SYA_ver_1_3_0.c,269 :: 		else if((1 == GT3) && (0 == GT1) && (0 == GT2)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM70
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM70
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM70
L__FSM150:
;FIRMWARE_SYA_ver_1_3_0.c,270 :: 		M1On();
	CALL        _M1On+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,271 :: 		M2Off();
	CALL        _M2Off+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,272 :: 		M3On();
	CALL        _M3On+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,273 :: 		}
L_FSM70:
L_FSM67:
L_FSM63:
;FIRMWARE_SYA_ver_1_3_0.c,274 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM73
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM73
L__FSM149:
;FIRMWARE_SYA_ver_1_3_0.c,275 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,276 :: 		}
	GOTO        L_FSM74
L_FSM73:
;FIRMWARE_SYA_ver_1_3_0.c,277 :: 		else if((1 == sn_NegEdge_2) && (1 == clock0)){
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_FSM77
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM77
L__FSM148:
;FIRMWARE_SYA_ver_1_3_0.c,278 :: 		next_state = s7;
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,279 :: 		}
	GOTO        L_FSM78
L_FSM77:
;FIRMWARE_SYA_ver_1_3_0.c,280 :: 		else if((1 == sn_PosEdge_3) && (1 == clock0)){
	BTFSS       _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
	GOTO        L_FSM81
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM81
L__FSM147:
;FIRMWARE_SYA_ver_1_3_0.c,281 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,282 :: 		}
	GOTO        L_FSM82
L_FSM81:
;FIRMWARE_SYA_ver_1_3_0.c,284 :: 		}
L_FSM82:
L_FSM78:
L_FSM74:
;FIRMWARE_SYA_ver_1_3_0.c,285 :: 		break;
	GOTO        L_FSM26
;FIRMWARE_SYA_ver_1_3_0.c,286 :: 		case s5:
L_FSM83:
;FIRMWARE_SYA_ver_1_3_0.c,287 :: 		M1On();
	CALL        _M1On+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,288 :: 		M2On();
	CALL        _M2On+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,289 :: 		M3On();
	CALL        _M3On+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,290 :: 		if(((1 == sn_NegEdge_1) || (1 == sn_NegEdge_2)) && (1 == clock0)){
	BTFSC       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L__FSM146
	BTFSC       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L__FSM146
	GOTO        L_FSM88
L__FSM146:
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM88
L__FSM145:
;FIRMWARE_SYA_ver_1_3_0.c,291 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,292 :: 		}
	GOTO        L_FSM89
L_FSM88:
;FIRMWARE_SYA_ver_1_3_0.c,293 :: 		else if((1 == sn_NegEdge_3) && (1 == clock0)){
	BTFSS       _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
	GOTO        L_FSM92
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM92
L__FSM144:
;FIRMWARE_SYA_ver_1_3_0.c,294 :: 		sn_GoTo = 1;
	BSF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_1_3_0.c,295 :: 		next_state = s6;
	MOVLW       6
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,296 :: 		}
	GOTO        L_FSM93
L_FSM92:
;FIRMWARE_SYA_ver_1_3_0.c,298 :: 		}
L_FSM93:
L_FSM89:
;FIRMWARE_SYA_ver_1_3_0.c,299 :: 		break;
	GOTO        L_FSM26
;FIRMWARE_SYA_ver_1_3_0.c,300 :: 		case s6:
L_FSM94:
;FIRMWARE_SYA_ver_1_3_0.c,301 :: 		if((1 == sn_GoTo) && (1 == GT1) && (1 == clock0)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM97
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM97
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM97
L__FSM143:
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
	GOTO        L_FSM98
L_FSM97:
;FIRMWARE_SYA_ver_1_3_0.c,307 :: 		else if((1 == sn_GoTo) && (1 == GT2) && (1 == clock0)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM101
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM101
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM101
L__FSM142:
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
	GOTO        L_FSM102
L_FSM101:
;FIRMWARE_SYA_ver_1_3_0.c,313 :: 		else if((1 == sn_GoTo) && (1 == GT3) && (1 == clock0)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM105
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM105
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM105
L__FSM141:
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
	GOTO        L_FSM106
L_FSM105:
;FIRMWARE_SYA_ver_1_3_0.c,320 :: 		}
L_FSM106:
L_FSM102:
L_FSM98:
;FIRMWARE_SYA_ver_1_3_0.c,321 :: 		break;
	GOTO        L_FSM26
;FIRMWARE_SYA_ver_1_3_0.c,322 :: 		case s7:
L_FSM107:
;FIRMWARE_SYA_ver_1_3_0.c,323 :: 		if(1 == sn_PosEdge_1){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM108
;FIRMWARE_SYA_ver_1_3_0.c,324 :: 		if((1 == GT1) && (1 == clock0)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM111
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM111
L__FSM140:
;FIRMWARE_SYA_ver_1_3_0.c,325 :: 		next_state = s2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,326 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,327 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,328 :: 		}
	GOTO        L_FSM112
L_FSM111:
;FIRMWARE_SYA_ver_1_3_0.c,329 :: 		else if((1 == GT2) && (1 == clock0)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM115
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM115
L__FSM139:
;FIRMWARE_SYA_ver_1_3_0.c,330 :: 		next_state = s3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,331 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,332 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,333 :: 		}
	GOTO        L_FSM116
L_FSM115:
;FIRMWARE_SYA_ver_1_3_0.c,334 :: 		else if((1 == GT3) && (1 == clock0)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM119
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM119
L__FSM138:
;FIRMWARE_SYA_ver_1_3_0.c,335 :: 		next_state = s1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,336 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,337 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,338 :: 		}
	GOTO        L_FSM120
L_FSM119:
;FIRMWARE_SYA_ver_1_3_0.c,340 :: 		}
L_FSM120:
L_FSM116:
L_FSM112:
;FIRMWARE_SYA_ver_1_3_0.c,341 :: 		}
L_FSM108:
;FIRMWARE_SYA_ver_1_3_0.c,342 :: 		break;
	GOTO        L_FSM26
;FIRMWARE_SYA_ver_1_3_0.c,343 :: 		default:
L_FSM121:
;FIRMWARE_SYA_ver_1_3_0.c,344 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,345 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,346 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,347 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,348 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,349 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,350 :: 		current_state = s0;
	CLRF        _current_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,351 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,352 :: 		break;
	GOTO        L_FSM26
;FIRMWARE_SYA_ver_1_3_0.c,353 :: 		}
L_FSM25:
	MOVF        _current_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM27
	MOVF        _current_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM32
	MOVF        _current_state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM41
	MOVF        _current_state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM50
	MOVF        _current_state+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM59
	MOVF        _current_state+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM83
	MOVF        _current_state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM94
	MOVF        _current_state+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM107
	GOTO        L_FSM121
L_FSM26:
;FIRMWARE_SYA_ver_1_3_0.c,355 :: 		}
L_end_FSM:
	RETURN      0
; end of _FSM

_Events:

;FIRMWARE_SYA_ver_1_3_0.c,361 :: 		void Events(){
;FIRMWARE_SYA_ver_1_3_0.c,363 :: 		if(1 == interruptC0){
	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events122
;FIRMWARE_SYA_ver_1_3_0.c,365 :: 		if(1 == SWITCH1){
	BTFSS       PORTC+0, 0 
	GOTO        L_Events123
;FIRMWARE_SYA_ver_1_3_0.c,367 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,368 :: 		sn_NegEdge_1 = 1;
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,369 :: 		}
	GOTO        L_Events124
L_Events123:
;FIRMWARE_SYA_ver_1_3_0.c,373 :: 		sn_PosEdge_1 = 1;
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,374 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,375 :: 		}
L_Events124:
;FIRMWARE_SYA_ver_1_3_0.c,376 :: 		interruptC0 = 0; // Limpiamos la bandera de interrupcion en C0
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_1_3_0.c,377 :: 		}
	GOTO        L_Events125
L_Events122:
;FIRMWARE_SYA_ver_1_3_0.c,379 :: 		else if(1 == interruptC1){
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events126
;FIRMWARE_SYA_ver_1_3_0.c,381 :: 		if(1 == SWITCH2){
	BTFSS       PORTC+0, 1 
	GOTO        L_Events127
;FIRMWARE_SYA_ver_1_3_0.c,383 :: 		sn_PosEdge_2 = 0;
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,384 :: 		sn_NegEdge_2 = 1;
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,385 :: 		}
	GOTO        L_Events128
L_Events127:
;FIRMWARE_SYA_ver_1_3_0.c,389 :: 		sn_PosEdge_2 = 1;
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,390 :: 		sn_NegEdge_2 = 0;
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,391 :: 		}
L_Events128:
;FIRMWARE_SYA_ver_1_3_0.c,392 :: 		interruptC1 = 0; // Limpiamos la bandera de interrupcion en C1
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,393 :: 		}
	GOTO        L_Events129
L_Events126:
;FIRMWARE_SYA_ver_1_3_0.c,394 :: 		else if(1 == interruptC2){
	BTFSS       _interruptC2+0, BitPos(_interruptC2+0) 
	GOTO        L_Events130
;FIRMWARE_SYA_ver_1_3_0.c,395 :: 		if(1 == SWITCH3){
	BTFSS       PORTC+0, 2 
	GOTO        L_Events131
;FIRMWARE_SYA_ver_1_3_0.c,396 :: 		sn_PosEdge_3 = 0;
	BCF         _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,397 :: 		sn_NegEdge_3 = 1;
	BSF         _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,398 :: 		}
	GOTO        L_Events132
L_Events131:
;FIRMWARE_SYA_ver_1_3_0.c,400 :: 		sn_PosEdge_3 = 1;
	BSF         _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,401 :: 		sn_NegEdge_3 = 0;
	BCF         _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,402 :: 		}
L_Events132:
;FIRMWARE_SYA_ver_1_3_0.c,403 :: 		interruptC2 = 0;
	BCF         _interruptC2+0, BitPos(_interruptC2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,404 :: 		}
	GOTO        L_Events133
L_Events130:
;FIRMWARE_SYA_ver_1_3_0.c,406 :: 		interruptC0 = 0;
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_1_3_0.c,407 :: 		interruptC1 = 0;
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,408 :: 		interruptC2 = 0;
	BCF         _interruptC2+0, BitPos(_interruptC2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,409 :: 		}
L_Events133:
L_Events129:
L_Events125:
;FIRMWARE_SYA_ver_1_3_0.c,410 :: 		return;
;FIRMWARE_SYA_ver_1_3_0.c,412 :: 		}
L_end_Events:
	RETURN      0
; end of _Events

_InitSystems:

;FIRMWARE_SYA_ver_1_3_0.c,418 :: 		void InitSystems(){
;FIRMWARE_SYA_ver_1_3_0.c,419 :: 		InitInterrupt();
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,420 :: 		InitMCU();
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,421 :: 		}
L_end_InitSystems:
	RETURN      0
; end of _InitSystems

_InitInterrupt:

;FIRMWARE_SYA_ver_1_3_0.c,427 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_1_3_0.c,429 :: 		PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       48
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_1_3_0.c,430 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_1_3_0.c,435 :: 		IOCCN = 0x07;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       7
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_1_3_0.c,436 :: 		IOCCP = 0x07;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
	MOVLW       7
	MOVWF       IOCCP+0 
;FIRMWARE_SYA_ver_1_3_0.c,437 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_1_3_0.c,438 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,439 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_1_3_0.c,441 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_1_3_0.c,447 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_1_3_0.c,449 :: 		ADCON0 = 0x08; // Desactivamos ADC
	MOVLW       8
	MOVWF       ADCON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,450 :: 		ANSELC = 0x00;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_1_3_0.c,451 :: 		ANSELE = 0x00;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_1_3_0.c,452 :: 		ANSELA = 0x00;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_1_3_0.c,453 :: 		ANSELD = 0x00;
	CLRF        ANSELD+0 
;FIRMWARE_SYA_ver_1_3_0.c,455 :: 		TRISC = 0x0F;  // Ponemos en modo de entrada a C0, C1, c2 Y c3, los demas como salida
	MOVLW       15
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_1_3_0.c,456 :: 		TRISD = 0x07;  // Ponemos en modo de entrada a D0 y D1
	MOVLW       7
	MOVWF       TRISD+0 
;FIRMWARE_SYA_ver_1_3_0.c,457 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_1_3_0.c,458 :: 		TRISA = 0x80;  //                ''                A
	MOVLW       128
	MOVWF       TRISA+0 
;FIRMWARE_SYA_ver_1_3_0.c,460 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_1_3_0.c,461 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;FIRMWARE_SYA_ver_1_3_0.c,462 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_1_3_0.c,463 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_1_3_0.c,465 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_1_3_0.c,466 :: 		LATD = 0x00;
	CLRF        LATD+0 
;FIRMWARE_SYA_ver_1_3_0.c,467 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_1_3_0.c,468 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_1_3_0.c,472 :: 		WPUD = 0x07;   // Activamos el pull-up interno de C0 y C1
	MOVLW       7
	MOVWF       WPUD+0 
;FIRMWARE_SYA_ver_1_3_0.c,473 :: 		INLVLD = 0x07; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       7
	MOVWF       INLVLD+0 
;FIRMWARE_SYA_ver_1_3_0.c,474 :: 		CM1CON0 = 0x00; // Desactivamos el comparador 1
	CLRF        CM1CON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,475 :: 		CM2CON0 = 0x00; // Desactivamos el comparador 2
	CLRF        CM2CON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,477 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
