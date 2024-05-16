
_interrupt:

;FIRMWARE_SYA_ver_1_3_0.c,80 :: 		void interrupt(){
;FIRMWARE_SYA_ver_1_3_0.c,93 :: 		if((1 == IOCCF.B0) && (1 == IOCIE_bit)){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt2
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt2
L__interrupt116:
;FIRMWARE_SYA_ver_1_3_0.c,94 :: 		IOCCF.B0 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,95 :: 		interruptC0 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_1_3_0.c,96 :: 		}
L_interrupt2:
;FIRMWARE_SYA_ver_1_3_0.c,98 :: 		if((1 == IOCCF.B1) && (1 == IOCIE_bit)){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt5
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt5
L__interrupt115:
;FIRMWARE_SYA_ver_1_3_0.c,99 :: 		IOCCF.B1 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,100 :: 		interruptC1 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,101 :: 		}
L_interrupt5:
;FIRMWARE_SYA_ver_1_3_0.c,102 :: 		if((1 == IOCCF.B2) && (1 == IOCIE_bit)){
	BTFSS       IOCCF+0, 2 
	GOTO        L_interrupt8
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt8
L__interrupt114:
;FIRMWARE_SYA_ver_1_3_0.c,103 :: 		IOCCF.B2 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 2 
;FIRMWARE_SYA_ver_1_3_0.c,104 :: 		interruptC2 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC2+0, BitPos(_interruptC2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,105 :: 		LED = ~LED;
	BTG         LATA+0, 4 
;FIRMWARE_SYA_ver_1_3_0.c,106 :: 		}
L_interrupt8:
;FIRMWARE_SYA_ver_1_3_0.c,108 :: 		}
L_end_interrupt:
L__interrupt138:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_1_3_0.c,114 :: 		void main(){
;FIRMWARE_SYA_ver_1_3_0.c,116 :: 		InitInterrupt(); // MCU interrupt config
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,117 :: 		InitMCU();       // MCU pin/reg config
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,119 :: 		do{
L_main9:
;FIRMWARE_SYA_ver_1_3_0.c,120 :: 		Events();
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,121 :: 		}while((1 == IOCCF.B0) || (1 == IOCCF.B1) || (1 == IOCCF.B2));
	BTFSC       IOCCF+0, 0 
	GOTO        L_main9
	BTFSC       IOCCF+0, 1 
	GOTO        L_main9
	BTFSC       IOCCF+0, 2 
	GOTO        L_main9
L__main117:
;FIRMWARE_SYA_ver_1_3_0.c,123 :: 		while(1){
L_main14:
;FIRMWARE_SYA_ver_1_3_0.c,124 :: 		clock0 = 1;
	BSF         _clock0+0, BitPos(_clock0+0) 
;FIRMWARE_SYA_ver_1_3_0.c,125 :: 		current_state = next_state; // Maybe move this with Events
	MOVF        _next_state+0, 0 
	MOVWF       _current_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,126 :: 		FSM();
	CALL        _FSM+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,127 :: 		}
	GOTO        L_main14
;FIRMWARE_SYA_ver_1_3_0.c,129 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_FSM:

;FIRMWARE_SYA_ver_1_3_0.c,135 :: 		void FSM(){
;FIRMWARE_SYA_ver_1_3_0.c,137 :: 		switch(current_state){
	GOTO        L_FSM16
;FIRMWARE_SYA_ver_1_3_0.c,138 :: 		case 0: // S0 - Todo apagado
L_FSM18:
;FIRMWARE_SYA_ver_1_3_0.c,139 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,140 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,141 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,142 :: 		sn_GoTo = 0;
	BCF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_1_3_0.c,144 :: 		if((1 == sn_PosEdge_1) && (1 == clock0)){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM21
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM21
L__FSM136:
;FIRMWARE_SYA_ver_1_3_0.c,145 :: 		next_state = 7; // Si, pasamos a estado 6
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,146 :: 		}
	GOTO        L_FSM22
L_FSM21:
;FIRMWARE_SYA_ver_1_3_0.c,148 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,149 :: 		}
L_FSM22:
;FIRMWARE_SYA_ver_1_3_0.c,150 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,151 :: 		case 1: // S1 - Grupo de trabajo 1 110
L_FSM23:
;FIRMWARE_SYA_ver_1_3_0.c,152 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,153 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,154 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,155 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,156 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,157 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,159 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM26
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM26
L__FSM135:
;FIRMWARE_SYA_ver_1_3_0.c,161 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,163 :: 		}
	GOTO        L_FSM27
L_FSM26:
;FIRMWARE_SYA_ver_1_3_0.c,165 :: 		else if((1 == sn_PosEdge_2) && (1 == clock0)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM30
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM30
L__FSM134:
;FIRMWARE_SYA_ver_1_3_0.c,167 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,168 :: 		}
	GOTO        L_FSM31
L_FSM30:
;FIRMWARE_SYA_ver_1_3_0.c,171 :: 		next_state = 1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,172 :: 		}
L_FSM31:
L_FSM27:
;FIRMWARE_SYA_ver_1_3_0.c,173 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,174 :: 		case 2: // S2 - Grupo de trabajo 2 011
L_FSM32:
;FIRMWARE_SYA_ver_1_3_0.c,175 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,176 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,177 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,178 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,179 :: 		GT2 = 1;
	BSF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,180 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,182 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM35
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM35
L__FSM133:
;FIRMWARE_SYA_ver_1_3_0.c,184 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,185 :: 		}
	GOTO        L_FSM36
L_FSM35:
;FIRMWARE_SYA_ver_1_3_0.c,187 :: 		else if((1 == sn_PosEdge_2) && (1 == clock0)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM39
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM39
L__FSM132:
;FIRMWARE_SYA_ver_1_3_0.c,189 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,190 :: 		}
	GOTO        L_FSM40
L_FSM39:
;FIRMWARE_SYA_ver_1_3_0.c,193 :: 		next_state = 2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,194 :: 		}
L_FSM40:
L_FSM36:
;FIRMWARE_SYA_ver_1_3_0.c,195 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,196 :: 		case 3: // S3 - Grupo de trabajo 3 101
L_FSM41:
;FIRMWARE_SYA_ver_1_3_0.c,197 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,198 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,199 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,200 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,201 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,202 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,204 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM44
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM44
L__FSM131:
;FIRMWARE_SYA_ver_1_3_0.c,206 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,207 :: 		}
	GOTO        L_FSM45
L_FSM44:
;FIRMWARE_SYA_ver_1_3_0.c,209 :: 		else if((1 == sn_PosEdge_2) && (1 == clock0)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM48
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM48
L__FSM130:
;FIRMWARE_SYA_ver_1_3_0.c,211 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,212 :: 		}
	GOTO        L_FSM49
L_FSM48:
;FIRMWARE_SYA_ver_1_3_0.c,215 :: 		next_state = 3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,216 :: 		}
L_FSM49:
L_FSM45:
;FIRMWARE_SYA_ver_1_3_0.c,217 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,218 :: 		case 4: // S4 - Grupo de trabajo 4 111
L_FSM50:
;FIRMWARE_SYA_ver_1_3_0.c,219 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,220 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,222 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM53
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM53
L__FSM129:
;FIRMWARE_SYA_ver_1_3_0.c,223 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,224 :: 		}
	GOTO        L_FSM54
L_FSM53:
;FIRMWARE_SYA_ver_1_3_0.c,225 :: 		else if((1 == sn_NegEdge_2) && (1 == clock0)){
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_FSM57
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM57
L__FSM128:
;FIRMWARE_SYA_ver_1_3_0.c,227 :: 		next_state = 6;
	MOVLW       6
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,228 :: 		sn_GoTo = 1; // Ponemos en 1 la señal de transicion
	BSF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_1_3_0.c,229 :: 		}
	GOTO        L_FSM58
L_FSM57:
;FIRMWARE_SYA_ver_1_3_0.c,230 :: 		else if((1 == sn_PosEdge_3) && (1 == clock0)){
	BTFSS       _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
	GOTO        L_FSM61
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM61
L__FSM127:
;FIRMWARE_SYA_ver_1_3_0.c,231 :: 		next_state = 5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,232 :: 		}
	GOTO        L_FSM62
L_FSM61:
;FIRMWARE_SYA_ver_1_3_0.c,235 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,236 :: 		}
L_FSM62:
L_FSM58:
L_FSM54:
;FIRMWARE_SYA_ver_1_3_0.c,237 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,238 :: 		case 5:
L_FSM63:
;FIRMWARE_SYA_ver_1_3_0.c,239 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,240 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,241 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,242 :: 		if(((1 == sn_NegEdge_1) || (1 == sn_NegEdge_2)) && (1 == clock0)){
	BTFSC       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L__FSM126
	BTFSC       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L__FSM126
	GOTO        L_FSM68
L__FSM126:
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM68
L__FSM125:
;FIRMWARE_SYA_ver_1_3_0.c,243 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,244 :: 		}
	GOTO        L_FSM69
L_FSM68:
;FIRMWARE_SYA_ver_1_3_0.c,245 :: 		else if((1 == sn_NegEdge_3) && (1 == clock0)){
	BTFSS       _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
	GOTO        L_FSM72
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM72
L__FSM124:
;FIRMWARE_SYA_ver_1_3_0.c,246 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,247 :: 		}
	GOTO        L_FSM73
L_FSM72:
;FIRMWARE_SYA_ver_1_3_0.c,249 :: 		next_state = 5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,250 :: 		}
L_FSM73:
L_FSM69:
;FIRMWARE_SYA_ver_1_3_0.c,251 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,252 :: 		case 6: // S5 - Estado de transicion para flanco negativo 2
L_FSM74:
;FIRMWARE_SYA_ver_1_3_0.c,254 :: 		if((1 == sn_GoTo) && (1 == GT1) && (1 == clock0)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM77
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM77
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM77
L__FSM123:
;FIRMWARE_SYA_ver_1_3_0.c,255 :: 		next_state = 2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,256 :: 		}
	GOTO        L_FSM78
L_FSM77:
;FIRMWARE_SYA_ver_1_3_0.c,257 :: 		else if((1 == sn_GoTo) && (1 == GT2) && (1 == clock0)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM81
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM81
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM81
L__FSM122:
;FIRMWARE_SYA_ver_1_3_0.c,258 :: 		next_state = 3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,259 :: 		}
	GOTO        L_FSM82
L_FSM81:
;FIRMWARE_SYA_ver_1_3_0.c,260 :: 		else if((1 == sn_GoTo) && (1 == GT3) && (1 == clock0)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM85
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM85
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM85
L__FSM121:
;FIRMWARE_SYA_ver_1_3_0.c,261 :: 		next_state = 1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,262 :: 		}
	GOTO        L_FSM86
L_FSM85:
;FIRMWARE_SYA_ver_1_3_0.c,265 :: 		next_state = 5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,266 :: 		}
L_FSM86:
L_FSM82:
L_FSM78:
;FIRMWARE_SYA_ver_1_3_0.c,267 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,268 :: 		case 7: // S6 - Estado de transicion para flanco positivo
L_FSM87:
;FIRMWARE_SYA_ver_1_3_0.c,269 :: 		if(1 == sn_PosEdge_1){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM88
;FIRMWARE_SYA_ver_1_3_0.c,271 :: 		if((1 == GT1) && (1 == clock0)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM91
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM91
L__FSM120:
;FIRMWARE_SYA_ver_1_3_0.c,273 :: 		next_state = 2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,274 :: 		GT2 = 0; // DO NOT
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,275 :: 		GT3 = 0; // DELETE !!!!
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,276 :: 		}
	GOTO        L_FSM92
L_FSM91:
;FIRMWARE_SYA_ver_1_3_0.c,278 :: 		else if((1 == GT2) && (1 == clock0)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM95
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM95
L__FSM119:
;FIRMWARE_SYA_ver_1_3_0.c,280 :: 		next_state = 3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,281 :: 		GT1 = 0; // DO NOT
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,282 :: 		GT3 = 0; // DELETE !!!!
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,283 :: 		}
	GOTO        L_FSM96
L_FSM95:
;FIRMWARE_SYA_ver_1_3_0.c,285 :: 		else if((1 == GT3) && (1 == clock0)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM99
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM99
L__FSM118:
;FIRMWARE_SYA_ver_1_3_0.c,287 :: 		next_state = 1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,288 :: 		GT1 = 0; // DO NOT
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,289 :: 		GT2 = 0; // DELETE !!!!
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,290 :: 		}
	GOTO        L_FSM100
L_FSM99:
;FIRMWARE_SYA_ver_1_3_0.c,293 :: 		next_state = 7;
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,294 :: 		}
L_FSM100:
L_FSM96:
L_FSM92:
;FIRMWARE_SYA_ver_1_3_0.c,295 :: 		}
L_FSM88:
;FIRMWARE_SYA_ver_1_3_0.c,296 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,297 :: 		default:
L_FSM101:
;FIRMWARE_SYA_ver_1_3_0.c,298 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,299 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,300 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,301 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,302 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,303 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,304 :: 		current_state = 0;
	CLRF        _current_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,305 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,306 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,307 :: 		}
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
	GOTO        L_FSM63
	MOVF        _current_state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM74
	MOVF        _current_state+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM87
	GOTO        L_FSM101
L_FSM17:
;FIRMWARE_SYA_ver_1_3_0.c,309 :: 		}
L_end_FSM:
	RETURN      0
; end of _FSM

_Events:

;FIRMWARE_SYA_ver_1_3_0.c,315 :: 		void Events(){
;FIRMWARE_SYA_ver_1_3_0.c,317 :: 		if(1 == interruptC0){
	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events102
;FIRMWARE_SYA_ver_1_3_0.c,319 :: 		if(1 == SWITCH1){
	BTFSS       PORTC+0, 0 
	GOTO        L_Events103
;FIRMWARE_SYA_ver_1_3_0.c,321 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,322 :: 		sn_NegEdge_1 = 1;
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,323 :: 		}
	GOTO        L_Events104
L_Events103:
;FIRMWARE_SYA_ver_1_3_0.c,327 :: 		sn_PosEdge_1 = 1;
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,328 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,329 :: 		}
L_Events104:
;FIRMWARE_SYA_ver_1_3_0.c,330 :: 		interruptC0 = 0; // Limpiamos la bandera de interrupcion en C0
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_1_3_0.c,331 :: 		}
	GOTO        L_Events105
L_Events102:
;FIRMWARE_SYA_ver_1_3_0.c,333 :: 		else if(1 == interruptC1){
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events106
;FIRMWARE_SYA_ver_1_3_0.c,335 :: 		if(1 == SWITCH2){
	BTFSS       PORTC+0, 1 
	GOTO        L_Events107
;FIRMWARE_SYA_ver_1_3_0.c,337 :: 		sn_PosEdge_2 = 0;
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,338 :: 		sn_NegEdge_2 = 1;
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,339 :: 		}
	GOTO        L_Events108
L_Events107:
;FIRMWARE_SYA_ver_1_3_0.c,343 :: 		sn_PosEdge_2 = 1;
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,344 :: 		sn_NegEdge_2 = 0;
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,345 :: 		}
L_Events108:
;FIRMWARE_SYA_ver_1_3_0.c,346 :: 		interruptC1 = 0; // Limpiamos la bandera de interrupcion en C1
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,347 :: 		}
	GOTO        L_Events109
L_Events106:
;FIRMWARE_SYA_ver_1_3_0.c,348 :: 		else if(1 == interruptC2){
	BTFSS       _interruptC2+0, BitPos(_interruptC2+0) 
	GOTO        L_Events110
;FIRMWARE_SYA_ver_1_3_0.c,349 :: 		if(1 == SWITCH3){
	BTFSS       PORTC+0, 2 
	GOTO        L_Events111
;FIRMWARE_SYA_ver_1_3_0.c,350 :: 		sn_PosEdge_3 = 0;
	BCF         _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,351 :: 		sn_NegEdge_3 = 1;
	BSF         _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,352 :: 		}
	GOTO        L_Events112
L_Events111:
;FIRMWARE_SYA_ver_1_3_0.c,354 :: 		sn_PosEdge_3 = 1;
	BSF         _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,355 :: 		sn_NegEdge_3 = 0;
	BCF         _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,356 :: 		}
L_Events112:
;FIRMWARE_SYA_ver_1_3_0.c,357 :: 		interruptC2 = 0;
	BCF         _interruptC2+0, BitPos(_interruptC2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,358 :: 		}
	GOTO        L_Events113
L_Events110:
;FIRMWARE_SYA_ver_1_3_0.c,360 :: 		interruptC0 = 0;
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_1_3_0.c,361 :: 		interruptC1 = 0;
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,362 :: 		interruptC2 = 0;
	BCF         _interruptC2+0, BitPos(_interruptC2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,363 :: 		}
L_Events113:
L_Events109:
L_Events105:
;FIRMWARE_SYA_ver_1_3_0.c,364 :: 		return;
;FIRMWARE_SYA_ver_1_3_0.c,366 :: 		}
L_end_Events:
	RETURN      0
; end of _Events

_InitInterrupt:

;FIRMWARE_SYA_ver_1_3_0.c,372 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_1_3_0.c,374 :: 		PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       48
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_1_3_0.c,375 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_1_3_0.c,380 :: 		IOCCN = 0x07;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       7
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_1_3_0.c,381 :: 		IOCCP = 0x07;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
	MOVLW       7
	MOVWF       IOCCP+0 
;FIRMWARE_SYA_ver_1_3_0.c,382 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_1_3_0.c,383 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,384 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_1_3_0.c,386 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_1_3_0.c,392 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_1_3_0.c,394 :: 		ADCON0 = 0x08; // Desactivamos ADC
	MOVLW       8
	MOVWF       ADCON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,395 :: 		ANSELC = 0x00;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_1_3_0.c,396 :: 		ANSELE = 0x00;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_1_3_0.c,397 :: 		ANSELA = 0x00;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_1_3_0.c,398 :: 		ANSELD = 0x00;
	CLRF        ANSELD+0 
;FIRMWARE_SYA_ver_1_3_0.c,400 :: 		TRISC = 0x0F;  // Ponemos en modo de entrada a C0, C1, c2 Y c3, los demas como salida
	MOVLW       15
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_1_3_0.c,401 :: 		TRISD = 0x07;  // Ponemos en modo de entrada a D0 y D1
	MOVLW       7
	MOVWF       TRISD+0 
;FIRMWARE_SYA_ver_1_3_0.c,402 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_1_3_0.c,403 :: 		TRISA = 0x80;  //                ''                A
	MOVLW       128
	MOVWF       TRISA+0 
;FIRMWARE_SYA_ver_1_3_0.c,405 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_1_3_0.c,406 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;FIRMWARE_SYA_ver_1_3_0.c,407 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_1_3_0.c,408 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_1_3_0.c,410 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_1_3_0.c,411 :: 		LATD = 0x00;
	CLRF        LATD+0 
;FIRMWARE_SYA_ver_1_3_0.c,412 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_1_3_0.c,413 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_1_3_0.c,415 :: 		WPUC = 0x0F;   // Activamos el pull-up interno de C0 y C1
	MOVLW       15
	MOVWF       WPUC+0 
;FIRMWARE_SYA_ver_1_3_0.c,416 :: 		INLVLC = 0x0F; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       15
	MOVWF       INLVLC+0 
;FIRMWARE_SYA_ver_1_3_0.c,417 :: 		WPUD = 0x07;   // Activamos el pull-up interno de C0 y C1
	MOVLW       7
	MOVWF       WPUD+0 
;FIRMWARE_SYA_ver_1_3_0.c,418 :: 		INLVLD = 0x07; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       7
	MOVWF       INLVLD+0 
;FIRMWARE_SYA_ver_1_3_0.c,419 :: 		CM1CON0 = 0x00; // Desactivamos el comparador 1
	CLRF        CM1CON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,420 :: 		CM2CON0 = 0x00; // Desactivamos el comparador 2
	CLRF        CM2CON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,422 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
