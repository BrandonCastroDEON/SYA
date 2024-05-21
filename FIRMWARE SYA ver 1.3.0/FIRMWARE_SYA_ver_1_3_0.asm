
_interrupt:

;FIRMWARE_SYA_ver_1_3_0.c,91 :: 		void interrupt(){
;FIRMWARE_SYA_ver_1_3_0.c,104 :: 		if((1 == IOCCF.B0) && (1 == IOCIE_bit)){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt2
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt2
L__interrupt133:
;FIRMWARE_SYA_ver_1_3_0.c,105 :: 		IOCCF.B0 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,106 :: 		interruptC0 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_1_3_0.c,107 :: 		}
L_interrupt2:
;FIRMWARE_SYA_ver_1_3_0.c,109 :: 		if((1 == IOCCF.B1) && (1 == IOCIE_bit)){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt5
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt5
L__interrupt132:
;FIRMWARE_SYA_ver_1_3_0.c,110 :: 		IOCCF.B1 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,111 :: 		interruptC1 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,112 :: 		}
L_interrupt5:
;FIRMWARE_SYA_ver_1_3_0.c,113 :: 		if((1 == IOCCF.B2) && (1 == IOCIE_bit)){
	BTFSS       IOCCF+0, 2 
	GOTO        L_interrupt8
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt8
L__interrupt131:
;FIRMWARE_SYA_ver_1_3_0.c,114 :: 		IOCCF.B2 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 2 
;FIRMWARE_SYA_ver_1_3_0.c,115 :: 		interruptC2 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC2+0, BitPos(_interruptC2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,116 :: 		LED = ~LED;
	BTG         LATA+0, 4 
;FIRMWARE_SYA_ver_1_3_0.c,117 :: 		}
L_interrupt8:
;FIRMWARE_SYA_ver_1_3_0.c,119 :: 		}
L_end_interrupt:
L__interrupt161:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_1_3_0.c,125 :: 		void main(){
;FIRMWARE_SYA_ver_1_3_0.c,127 :: 		InitInterrupt(); // MCU interrupt config
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,128 :: 		InitMCU();       // MCU pin/reg config
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,130 :: 		do{
L_main9:
;FIRMWARE_SYA_ver_1_3_0.c,131 :: 		Events();
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,132 :: 		}while((1 == IOCCF.B0) || (1 == IOCCF.B1) || (1 == IOCCF.B2));
	BTFSC       IOCCF+0, 0 
	GOTO        L_main9
	BTFSC       IOCCF+0, 1 
	GOTO        L_main9
	BTFSC       IOCCF+0, 2 
	GOTO        L_main9
L__main134:
;FIRMWARE_SYA_ver_1_3_0.c,134 :: 		while(1){
L_main14:
;FIRMWARE_SYA_ver_1_3_0.c,135 :: 		current_state = next_state; // Maybe move this with Events
	MOVF        _next_state+0, 0 
	MOVWF       _current_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,136 :: 		FSM();
	CALL        _FSM+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,137 :: 		}
	GOTO        L_main14
;FIRMWARE_SYA_ver_1_3_0.c,139 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_FSM:

;FIRMWARE_SYA_ver_1_3_0.c,145 :: 		void FSM(){
;FIRMWARE_SYA_ver_1_3_0.c,146 :: 		clock0 = 1;
	BSF         _clock0+0, BitPos(_clock0+0) 
;FIRMWARE_SYA_ver_1_3_0.c,147 :: 		switch(current_state){
	GOTO        L_FSM16
;FIRMWARE_SYA_ver_1_3_0.c,148 :: 		case s0:
L_FSM18:
;FIRMWARE_SYA_ver_1_3_0.c,149 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,150 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,151 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,152 :: 		sn_GoTo = 0;
	BCF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_1_3_0.c,153 :: 		if((1 == sn_PosEdge_1) && (1 == clock0)){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM21
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM21
L__FSM159:
;FIRMWARE_SYA_ver_1_3_0.c,154 :: 		next_state = s7;
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,155 :: 		}
	GOTO        L_FSM22
L_FSM21:
;FIRMWARE_SYA_ver_1_3_0.c,157 :: 		}
L_FSM22:
;FIRMWARE_SYA_ver_1_3_0.c,158 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,159 :: 		case s1:
L_FSM23:
;FIRMWARE_SYA_ver_1_3_0.c,160 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,161 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,162 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,163 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,164 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,165 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,167 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM26
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM26
L__FSM158:
;FIRMWARE_SYA_ver_1_3_0.c,169 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,170 :: 		}
	GOTO        L_FSM27
L_FSM26:
;FIRMWARE_SYA_ver_1_3_0.c,171 :: 		else if((1 == sn_PosEdge_2) && (1 == clock0)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM30
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM30
L__FSM157:
;FIRMWARE_SYA_ver_1_3_0.c,172 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,173 :: 		}
	GOTO        L_FSM31
L_FSM30:
;FIRMWARE_SYA_ver_1_3_0.c,175 :: 		}
L_FSM31:
L_FSM27:
;FIRMWARE_SYA_ver_1_3_0.c,176 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,177 :: 		case s2:
L_FSM32:
;FIRMWARE_SYA_ver_1_3_0.c,178 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,179 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,180 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,181 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,182 :: 		GT2 = 1;
	BSF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,183 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,184 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM35
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM35
L__FSM156:
;FIRMWARE_SYA_ver_1_3_0.c,185 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,186 :: 		}
	GOTO        L_FSM36
L_FSM35:
;FIRMWARE_SYA_ver_1_3_0.c,187 :: 		else if((1 == sn_PosEdge_2) && (1 == clock0)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM39
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM39
L__FSM155:
;FIRMWARE_SYA_ver_1_3_0.c,188 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,189 :: 		}
	GOTO        L_FSM40
L_FSM39:
;FIRMWARE_SYA_ver_1_3_0.c,191 :: 		}
L_FSM40:
L_FSM36:
;FIRMWARE_SYA_ver_1_3_0.c,192 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,193 :: 		case s3:
L_FSM41:
;FIRMWARE_SYA_ver_1_3_0.c,194 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,195 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,196 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,197 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,198 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,199 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,200 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM44
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM44
L__FSM154:
;FIRMWARE_SYA_ver_1_3_0.c,201 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,202 :: 		}
	GOTO        L_FSM45
L_FSM44:
;FIRMWARE_SYA_ver_1_3_0.c,203 :: 		else if((1 == sn_PosEdge_2) && (1 == clock0)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM48
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM48
L__FSM153:
;FIRMWARE_SYA_ver_1_3_0.c,204 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,205 :: 		}
	GOTO        L_FSM49
L_FSM48:
;FIRMWARE_SYA_ver_1_3_0.c,207 :: 		}
L_FSM49:
L_FSM45:
;FIRMWARE_SYA_ver_1_3_0.c,208 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,209 :: 		case s4:
L_FSM50:
;FIRMWARE_SYA_ver_1_3_0.c,210 :: 		if((1 == GT1) && ((0 == GT2) || (0 == GT3))){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM55
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L__FSM152
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L__FSM152
	GOTO        L_FSM55
L__FSM152:
L__FSM151:
;FIRMWARE_SYA_ver_1_3_0.c,211 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,212 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,213 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,214 :: 		}
	GOTO        L_FSM56
L_FSM55:
;FIRMWARE_SYA_ver_1_3_0.c,215 :: 		else if((1 == GT2) && ((0 == GT1) || (0 == GT3))){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM61
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L__FSM150
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L__FSM150
	GOTO        L_FSM61
L__FSM150:
L__FSM149:
;FIRMWARE_SYA_ver_1_3_0.c,216 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,217 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,218 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,219 :: 		}
	GOTO        L_FSM62
L_FSM61:
;FIRMWARE_SYA_ver_1_3_0.c,220 :: 		else if((1 == GT3) && ((0 == GT1) || (0 == GT2))){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM67
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L__FSM148
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L__FSM148
	GOTO        L_FSM67
L__FSM148:
L__FSM147:
;FIRMWARE_SYA_ver_1_3_0.c,221 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,222 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,223 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,224 :: 		}
L_FSM67:
L_FSM62:
L_FSM56:
;FIRMWARE_SYA_ver_1_3_0.c,225 :: 		LED = ~LED;
	BTG         LATA+0, 4 
;FIRMWARE_SYA_ver_1_3_0.c,226 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM70
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM70
L__FSM146:
;FIRMWARE_SYA_ver_1_3_0.c,227 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,228 :: 		}
	GOTO        L_FSM71
L_FSM70:
;FIRMWARE_SYA_ver_1_3_0.c,229 :: 		else if((1 == sn_NegEdge_2) && (1 == clock0)){
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_FSM74
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM74
L__FSM145:
;FIRMWARE_SYA_ver_1_3_0.c,230 :: 		next_state = s7;
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,231 :: 		sn_GoTo = 1;
	BSF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_1_3_0.c,232 :: 		}
	GOTO        L_FSM75
L_FSM74:
;FIRMWARE_SYA_ver_1_3_0.c,233 :: 		else if((1 == sn_PosEdge_3) && (1 == clock0)){
	BTFSS       _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
	GOTO        L_FSM78
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM78
L__FSM144:
;FIRMWARE_SYA_ver_1_3_0.c,234 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,235 :: 		}
	GOTO        L_FSM79
L_FSM78:
;FIRMWARE_SYA_ver_1_3_0.c,237 :: 		}
L_FSM79:
L_FSM75:
L_FSM71:
;FIRMWARE_SYA_ver_1_3_0.c,238 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,239 :: 		case s5:
L_FSM80:
;FIRMWARE_SYA_ver_1_3_0.c,240 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,241 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,242 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,243 :: 		if(((1 == sn_NegEdge_1) || (1 == sn_NegEdge_2)) && (1 == clock0)){
	BTFSC       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L__FSM143
	BTFSC       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L__FSM143
	GOTO        L_FSM85
L__FSM143:
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM85
L__FSM142:
;FIRMWARE_SYA_ver_1_3_0.c,244 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,245 :: 		}
	GOTO        L_FSM86
L_FSM85:
;FIRMWARE_SYA_ver_1_3_0.c,246 :: 		else if((1 == sn_NegEdge_3) && (1 == clock0)){
	BTFSS       _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
	GOTO        L_FSM89
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM89
L__FSM141:
;FIRMWARE_SYA_ver_1_3_0.c,247 :: 		next_state = s6;
	MOVLW       6
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,248 :: 		}
	GOTO        L_FSM90
L_FSM89:
;FIRMWARE_SYA_ver_1_3_0.c,250 :: 		}
L_FSM90:
L_FSM86:
;FIRMWARE_SYA_ver_1_3_0.c,251 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,252 :: 		case s6:
L_FSM91:
;FIRMWARE_SYA_ver_1_3_0.c,253 :: 		if((1 == sn_GoTo) && (1 == GT1) && (1 == clock0)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM94
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM94
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM94
L__FSM140:
;FIRMWARE_SYA_ver_1_3_0.c,254 :: 		GT2 = 1;
	BSF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,255 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,256 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,257 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,258 :: 		}
	GOTO        L_FSM95
L_FSM94:
;FIRMWARE_SYA_ver_1_3_0.c,259 :: 		else if((1 == sn_GoTo) && (1 == GT2) && (1 == clock0)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM98
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM98
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM98
L__FSM139:
;FIRMWARE_SYA_ver_1_3_0.c,260 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,261 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,262 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,263 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,264 :: 		}
	GOTO        L_FSM99
L_FSM98:
;FIRMWARE_SYA_ver_1_3_0.c,265 :: 		else if((1 == sn_GoTo) && (1 == GT3) && (1 == clock0)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM102
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM102
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM102
L__FSM138:
;FIRMWARE_SYA_ver_1_3_0.c,266 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,267 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,268 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,269 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,270 :: 		}
	GOTO        L_FSM103
L_FSM102:
;FIRMWARE_SYA_ver_1_3_0.c,272 :: 		}
L_FSM103:
L_FSM99:
L_FSM95:
;FIRMWARE_SYA_ver_1_3_0.c,273 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,274 :: 		case s7:
L_FSM104:
;FIRMWARE_SYA_ver_1_3_0.c,275 :: 		if(1 == sn_PosEdge_1){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM105
;FIRMWARE_SYA_ver_1_3_0.c,276 :: 		if((1 == GT1) && (1 == clock0)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM108
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM108
L__FSM137:
;FIRMWARE_SYA_ver_1_3_0.c,277 :: 		next_state = s2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,278 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,279 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,280 :: 		}
	GOTO        L_FSM109
L_FSM108:
;FIRMWARE_SYA_ver_1_3_0.c,281 :: 		else if((1 == GT2) && (1 == clock0)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM112
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM112
L__FSM136:
;FIRMWARE_SYA_ver_1_3_0.c,282 :: 		next_state = s3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,283 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,284 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,285 :: 		}
	GOTO        L_FSM113
L_FSM112:
;FIRMWARE_SYA_ver_1_3_0.c,286 :: 		else if((1 == GT3) && (1 == clock0)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM116
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM116
L__FSM135:
;FIRMWARE_SYA_ver_1_3_0.c,287 :: 		next_state = s1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,288 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,289 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,290 :: 		}
	GOTO        L_FSM117
L_FSM116:
;FIRMWARE_SYA_ver_1_3_0.c,292 :: 		}
L_FSM117:
L_FSM113:
L_FSM109:
;FIRMWARE_SYA_ver_1_3_0.c,293 :: 		}
L_FSM105:
;FIRMWARE_SYA_ver_1_3_0.c,294 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,295 :: 		default:
L_FSM118:
;FIRMWARE_SYA_ver_1_3_0.c,296 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,297 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,298 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,299 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,300 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,301 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,302 :: 		current_state = s0;
	CLRF        _current_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,303 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,304 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,305 :: 		}
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
	GOTO        L_FSM80
	MOVF        _current_state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM91
	MOVF        _current_state+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM104
	GOTO        L_FSM118
L_FSM17:
;FIRMWARE_SYA_ver_1_3_0.c,307 :: 		}
L_end_FSM:
	RETURN      0
; end of _FSM

_Events:

;FIRMWARE_SYA_ver_1_3_0.c,313 :: 		void Events(){
;FIRMWARE_SYA_ver_1_3_0.c,315 :: 		if(1 == interruptC0){
	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events119
;FIRMWARE_SYA_ver_1_3_0.c,317 :: 		if(1 == SWITCH1){
	BTFSS       PORTC+0, 0 
	GOTO        L_Events120
;FIRMWARE_SYA_ver_1_3_0.c,319 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,320 :: 		sn_NegEdge_1 = 1;
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,321 :: 		}
	GOTO        L_Events121
L_Events120:
;FIRMWARE_SYA_ver_1_3_0.c,325 :: 		sn_PosEdge_1 = 1;
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,326 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,327 :: 		}
L_Events121:
;FIRMWARE_SYA_ver_1_3_0.c,328 :: 		interruptC0 = 0; // Limpiamos la bandera de interrupcion en C0
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_1_3_0.c,329 :: 		}
	GOTO        L_Events122
L_Events119:
;FIRMWARE_SYA_ver_1_3_0.c,331 :: 		else if(1 == interruptC1){
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events123
;FIRMWARE_SYA_ver_1_3_0.c,333 :: 		if(1 == SWITCH2){
	BTFSS       PORTC+0, 1 
	GOTO        L_Events124
;FIRMWARE_SYA_ver_1_3_0.c,335 :: 		sn_PosEdge_2 = 0;
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,336 :: 		sn_NegEdge_2 = 1;
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,337 :: 		}
	GOTO        L_Events125
L_Events124:
;FIRMWARE_SYA_ver_1_3_0.c,341 :: 		sn_PosEdge_2 = 1;
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,342 :: 		sn_NegEdge_2 = 0;
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,343 :: 		}
L_Events125:
;FIRMWARE_SYA_ver_1_3_0.c,344 :: 		interruptC1 = 0; // Limpiamos la bandera de interrupcion en C1
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,345 :: 		}
	GOTO        L_Events126
L_Events123:
;FIRMWARE_SYA_ver_1_3_0.c,346 :: 		else if(1 == interruptC2){
	BTFSS       _interruptC2+0, BitPos(_interruptC2+0) 
	GOTO        L_Events127
;FIRMWARE_SYA_ver_1_3_0.c,347 :: 		if(1 == SWITCH3){
	BTFSS       PORTC+0, 2 
	GOTO        L_Events128
;FIRMWARE_SYA_ver_1_3_0.c,348 :: 		sn_PosEdge_3 = 0;
	BCF         _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,349 :: 		sn_NegEdge_3 = 1;
	BSF         _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,350 :: 		}
	GOTO        L_Events129
L_Events128:
;FIRMWARE_SYA_ver_1_3_0.c,352 :: 		sn_PosEdge_3 = 1;
	BSF         _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,353 :: 		sn_NegEdge_3 = 0;
	BCF         _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,354 :: 		}
L_Events129:
;FIRMWARE_SYA_ver_1_3_0.c,355 :: 		interruptC2 = 0;
	BCF         _interruptC2+0, BitPos(_interruptC2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,356 :: 		}
	GOTO        L_Events130
L_Events127:
;FIRMWARE_SYA_ver_1_3_0.c,358 :: 		interruptC0 = 0;
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_1_3_0.c,359 :: 		interruptC1 = 0;
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,360 :: 		interruptC2 = 0;
	BCF         _interruptC2+0, BitPos(_interruptC2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,361 :: 		}
L_Events130:
L_Events126:
L_Events122:
;FIRMWARE_SYA_ver_1_3_0.c,362 :: 		return;
;FIRMWARE_SYA_ver_1_3_0.c,364 :: 		}
L_end_Events:
	RETURN      0
; end of _Events

_InitInterrupt:

;FIRMWARE_SYA_ver_1_3_0.c,370 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_1_3_0.c,372 :: 		PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       48
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_1_3_0.c,373 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_1_3_0.c,378 :: 		IOCCN = 0x07;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       7
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_1_3_0.c,379 :: 		IOCCP = 0x07;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
	MOVLW       7
	MOVWF       IOCCP+0 
;FIRMWARE_SYA_ver_1_3_0.c,380 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_1_3_0.c,381 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,382 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_1_3_0.c,384 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_1_3_0.c,390 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_1_3_0.c,392 :: 		ADCON0 = 0x08; // Desactivamos ADC
	MOVLW       8
	MOVWF       ADCON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,393 :: 		ANSELC = 0x00;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_1_3_0.c,394 :: 		ANSELE = 0x00;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_1_3_0.c,395 :: 		ANSELA = 0x00;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_1_3_0.c,396 :: 		ANSELD = 0x00;
	CLRF        ANSELD+0 
;FIRMWARE_SYA_ver_1_3_0.c,398 :: 		TRISC = 0x0F;  // Ponemos en modo de entrada a C0, C1, c2 Y c3, los demas como salida
	MOVLW       15
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_1_3_0.c,399 :: 		TRISD = 0x07;  // Ponemos en modo de entrada a D0 y D1
	MOVLW       7
	MOVWF       TRISD+0 
;FIRMWARE_SYA_ver_1_3_0.c,400 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_1_3_0.c,401 :: 		TRISA = 0x80;  //                ''                A
	MOVLW       128
	MOVWF       TRISA+0 
;FIRMWARE_SYA_ver_1_3_0.c,403 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_1_3_0.c,404 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;FIRMWARE_SYA_ver_1_3_0.c,405 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_1_3_0.c,406 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_1_3_0.c,408 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_1_3_0.c,409 :: 		LATD = 0x00;
	CLRF        LATD+0 
;FIRMWARE_SYA_ver_1_3_0.c,410 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_1_3_0.c,411 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_1_3_0.c,413 :: 		WPUC = 0x0F;   // Activamos el pull-up interno de C0 y C1
	MOVLW       15
	MOVWF       WPUC+0 
;FIRMWARE_SYA_ver_1_3_0.c,414 :: 		INLVLC = 0x0F; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       15
	MOVWF       INLVLC+0 
;FIRMWARE_SYA_ver_1_3_0.c,415 :: 		WPUD = 0x07;   // Activamos el pull-up interno de C0 y C1
	MOVLW       7
	MOVWF       WPUD+0 
;FIRMWARE_SYA_ver_1_3_0.c,416 :: 		INLVLD = 0x07; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       7
	MOVWF       INLVLD+0 
;FIRMWARE_SYA_ver_1_3_0.c,417 :: 		CM1CON0 = 0x00; // Desactivamos el comparador 1
	CLRF        CM1CON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,418 :: 		CM2CON0 = 0x00; // Desactivamos el comparador 2
	CLRF        CM2CON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,420 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
