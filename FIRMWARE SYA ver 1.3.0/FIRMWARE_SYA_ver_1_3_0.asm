
_interrupt:

;FIRMWARE_SYA_ver_1_3_0.c,86 :: 		void interrupt(){
;FIRMWARE_SYA_ver_1_3_0.c,99 :: 		if((1 == IOCCF.B0) && (1 == IOCIE_bit)){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt2
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt2
L__interrupt148:
;FIRMWARE_SYA_ver_1_3_0.c,100 :: 		IOCCF.B0 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,101 :: 		interruptC0 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_1_3_0.c,102 :: 		}
L_interrupt2:
;FIRMWARE_SYA_ver_1_3_0.c,104 :: 		if((1 == IOCCF.B1) && (1 == IOCIE_bit)){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt5
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt5
L__interrupt147:
;FIRMWARE_SYA_ver_1_3_0.c,105 :: 		IOCCF.B1 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,106 :: 		interruptC1 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,107 :: 		}
L_interrupt5:
;FIRMWARE_SYA_ver_1_3_0.c,108 :: 		if((1 == IOCCF.B2) && (1 == IOCIE_bit)){
	BTFSS       IOCCF+0, 2 
	GOTO        L_interrupt8
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt8
L__interrupt146:
;FIRMWARE_SYA_ver_1_3_0.c,109 :: 		IOCCF.B2 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 2 
;FIRMWARE_SYA_ver_1_3_0.c,110 :: 		interruptC2 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC2+0, BitPos(_interruptC2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,111 :: 		LED = ~LED;
	BTG         LATA+0, 4 
;FIRMWARE_SYA_ver_1_3_0.c,112 :: 		}
L_interrupt8:
;FIRMWARE_SYA_ver_1_3_0.c,114 :: 		}
L_end_interrupt:
L__interrupt176:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_1_3_0.c,120 :: 		void main(){
;FIRMWARE_SYA_ver_1_3_0.c,122 :: 		InitInterrupt(); // MCU interrupt config
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,123 :: 		InitMCU();       // MCU pin/reg config
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,125 :: 		do{
L_main9:
;FIRMWARE_SYA_ver_1_3_0.c,126 :: 		Events();
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,127 :: 		}while((1 == IOCCF.B0) || (1 == IOCCF.B1) || (1 == IOCCF.B2));
	BTFSC       IOCCF+0, 0 
	GOTO        L_main9
	BTFSC       IOCCF+0, 1 
	GOTO        L_main9
	BTFSC       IOCCF+0, 2 
	GOTO        L_main9
L__main149:
;FIRMWARE_SYA_ver_1_3_0.c,129 :: 		while(1){
L_main14:
;FIRMWARE_SYA_ver_1_3_0.c,130 :: 		current_state = next_state; // Maybe move this with Events
	MOVF        _next_state+0, 0 
	MOVWF       _current_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,131 :: 		FSM();
	CALL        _FSM+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,132 :: 		}
	GOTO        L_main14
;FIRMWARE_SYA_ver_1_3_0.c,134 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_FSM:

;FIRMWARE_SYA_ver_1_3_0.c,140 :: 		void FSM(){
;FIRMWARE_SYA_ver_1_3_0.c,141 :: 		clock0 = 1;
	BSF         _clock0+0, BitPos(_clock0+0) 
;FIRMWARE_SYA_ver_1_3_0.c,142 :: 		switch(current_state){
	GOTO        L_FSM16
;FIRMWARE_SYA_ver_1_3_0.c,143 :: 		case 0: // S0 - Todo apagado
L_FSM18:
;FIRMWARE_SYA_ver_1_3_0.c,144 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,145 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,146 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,147 :: 		sn_GoTo = 0;
	BCF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_1_3_0.c,149 :: 		if((1 == sn_PosEdge_1) && (1 == clock0)){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM21
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM21
L__FSM174:
;FIRMWARE_SYA_ver_1_3_0.c,150 :: 		next_state = 9; // Si, pasamos a estado 6
	MOVLW       9
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,151 :: 		}
	GOTO        L_FSM22
L_FSM21:
;FIRMWARE_SYA_ver_1_3_0.c,153 :: 		}
L_FSM22:
;FIRMWARE_SYA_ver_1_3_0.c,154 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,155 :: 		case 1: // S1 - Grupo de trabajo 1 110
L_FSM23:
;FIRMWARE_SYA_ver_1_3_0.c,156 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,157 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,158 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,159 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,160 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,161 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,163 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM26
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM26
L__FSM173:
;FIRMWARE_SYA_ver_1_3_0.c,165 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,167 :: 		}
	GOTO        L_FSM27
L_FSM26:
;FIRMWARE_SYA_ver_1_3_0.c,169 :: 		else if((1 == sn_PosEdge_2) && (1 == clock0)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM30
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM30
L__FSM172:
;FIRMWARE_SYA_ver_1_3_0.c,171 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,172 :: 		}
	GOTO        L_FSM31
L_FSM30:
;FIRMWARE_SYA_ver_1_3_0.c,175 :: 		}
L_FSM31:
L_FSM27:
;FIRMWARE_SYA_ver_1_3_0.c,176 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,177 :: 		case 2: // S2 - Grupo de trabajo 2 011
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
;FIRMWARE_SYA_ver_1_3_0.c,185 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM35
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM35
L__FSM171:
;FIRMWARE_SYA_ver_1_3_0.c,187 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,188 :: 		}
	GOTO        L_FSM36
L_FSM35:
;FIRMWARE_SYA_ver_1_3_0.c,190 :: 		else if((1 == sn_PosEdge_2) && (1 == clock0)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM39
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM39
L__FSM170:
;FIRMWARE_SYA_ver_1_3_0.c,192 :: 		next_state = 5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,193 :: 		}
	GOTO        L_FSM40
L_FSM39:
;FIRMWARE_SYA_ver_1_3_0.c,196 :: 		}
L_FSM40:
L_FSM36:
;FIRMWARE_SYA_ver_1_3_0.c,197 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,198 :: 		case 3: // S3 - Grupo de trabajo 3 101
L_FSM41:
;FIRMWARE_SYA_ver_1_3_0.c,199 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,200 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,201 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,202 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,203 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,204 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,206 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM44
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM44
L__FSM169:
;FIRMWARE_SYA_ver_1_3_0.c,208 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,209 :: 		}
	GOTO        L_FSM45
L_FSM44:
;FIRMWARE_SYA_ver_1_3_0.c,211 :: 		else if((1 == sn_PosEdge_2) && (1 == clock0)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM48
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM48
L__FSM168:
;FIRMWARE_SYA_ver_1_3_0.c,213 :: 		next_state = 6;
	MOVLW       6
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,214 :: 		}
	GOTO        L_FSM49
L_FSM48:
;FIRMWARE_SYA_ver_1_3_0.c,217 :: 		}
L_FSM49:
L_FSM45:
;FIRMWARE_SYA_ver_1_3_0.c,218 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,219 :: 		case 4: // S4 - Grupo de trabajo 4 111
L_FSM50:
;FIRMWARE_SYA_ver_1_3_0.c,220 :: 		if(1 == GT1A){ //  Maybe change them to while
	BTFSS       _GT1A+0, BitPos(_GT1A+0) 
	GOTO        L_FSM51
;FIRMWARE_SYA_ver_1_3_0.c,221 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,222 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,223 :: 		GT1A = 0;
	BCF         _GT1A+0, BitPos(_GT1A+0) 
;FIRMWARE_SYA_ver_1_3_0.c,224 :: 		}
	GOTO        L_FSM52
L_FSM51:
;FIRMWARE_SYA_ver_1_3_0.c,226 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,227 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,228 :: 		GT1A = 1;
	BSF         _GT1A+0, BitPos(_GT1A+0) 
;FIRMWARE_SYA_ver_1_3_0.c,229 :: 		}
L_FSM52:
;FIRMWARE_SYA_ver_1_3_0.c,230 :: 		GT4 = 1;
	BSF         _GT4+0, BitPos(_GT4+0) 
;FIRMWARE_SYA_ver_1_3_0.c,231 :: 		GT5 = 0;
	BCF         _GT5+0, BitPos(_GT5+0) 
;FIRMWARE_SYA_ver_1_3_0.c,232 :: 		GT6 = 0;
	BCF         _GT6+0, BitPos(_GT6+0) 
;FIRMWARE_SYA_ver_1_3_0.c,234 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM55
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM55
L__FSM167:
;FIRMWARE_SYA_ver_1_3_0.c,235 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,236 :: 		}
	GOTO        L_FSM56
L_FSM55:
;FIRMWARE_SYA_ver_1_3_0.c,237 :: 		else if((1 == sn_NegEdge_2) && (1 == clock0)){
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_FSM59
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM59
L__FSM166:
;FIRMWARE_SYA_ver_1_3_0.c,239 :: 		next_state = 1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,240 :: 		sn_GoTo = 1; // Ponemos en 1 la señal de transicion
	BSF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_1_3_0.c,241 :: 		}
	GOTO        L_FSM60
L_FSM59:
;FIRMWARE_SYA_ver_1_3_0.c,242 :: 		else if((1 == sn_PosEdge_3) && (1 == clock0)){
	BTFSS       _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
	GOTO        L_FSM63
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM63
L__FSM165:
;FIRMWARE_SYA_ver_1_3_0.c,243 :: 		next_state = 7; // cambiar
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,244 :: 		}
	GOTO        L_FSM64
L_FSM63:
;FIRMWARE_SYA_ver_1_3_0.c,247 :: 		}
L_FSM64:
L_FSM60:
L_FSM56:
;FIRMWARE_SYA_ver_1_3_0.c,248 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,249 :: 		case 5:
L_FSM65:
;FIRMWARE_SYA_ver_1_3_0.c,250 :: 		if(1 == GT2A){
	BTFSS       _GT2A+0, BitPos(_GT2A+0) 
	GOTO        L_FSM66
;FIRMWARE_SYA_ver_1_3_0.c,251 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,252 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,253 :: 		GT2A = 0;
	BCF         _GT2A+0, BitPos(_GT2A+0) 
;FIRMWARE_SYA_ver_1_3_0.c,254 :: 		}
	GOTO        L_FSM67
L_FSM66:
;FIRMWARE_SYA_ver_1_3_0.c,256 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,257 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,258 :: 		GT2A = 1;
	BSF         _GT2A+0, BitPos(_GT2A+0) 
;FIRMWARE_SYA_ver_1_3_0.c,259 :: 		}
L_FSM67:
;FIRMWARE_SYA_ver_1_3_0.c,260 :: 		GT4 = 0;
	BCF         _GT4+0, BitPos(_GT4+0) 
;FIRMWARE_SYA_ver_1_3_0.c,261 :: 		GT5 = 1;
	BSF         _GT5+0, BitPos(_GT5+0) 
;FIRMWARE_SYA_ver_1_3_0.c,262 :: 		GT6 = 0;
	BCF         _GT6+0, BitPos(_GT6+0) 
;FIRMWARE_SYA_ver_1_3_0.c,264 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM70
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM70
L__FSM164:
;FIRMWARE_SYA_ver_1_3_0.c,265 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,266 :: 		}
	GOTO        L_FSM71
L_FSM70:
;FIRMWARE_SYA_ver_1_3_0.c,267 :: 		else if((1 == sn_NegEdge_2) && (1 == clock0)){
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_FSM74
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM74
L__FSM163:
;FIRMWARE_SYA_ver_1_3_0.c,269 :: 		next_state = 2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,270 :: 		sn_GoTo = 1; // Ponemos en 1 la señal de transicion
	BSF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_1_3_0.c,271 :: 		}
	GOTO        L_FSM75
L_FSM74:
;FIRMWARE_SYA_ver_1_3_0.c,272 :: 		else if((1 == sn_PosEdge_3) && (1 == clock0)){
	BTFSS       _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
	GOTO        L_FSM78
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM78
L__FSM162:
;FIRMWARE_SYA_ver_1_3_0.c,273 :: 		next_state = 7; // cambiar
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,274 :: 		}
	GOTO        L_FSM79
L_FSM78:
;FIRMWARE_SYA_ver_1_3_0.c,277 :: 		}
L_FSM79:
L_FSM75:
L_FSM71:
;FIRMWARE_SYA_ver_1_3_0.c,278 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,279 :: 		case 6:
L_FSM80:
;FIRMWARE_SYA_ver_1_3_0.c,280 :: 		if(1 == GT3A){
	BTFSS       _GT3A+0, BitPos(_GT3A+0) 
	GOTO        L_FSM81
;FIRMWARE_SYA_ver_1_3_0.c,281 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,282 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,283 :: 		GT3A = 0;
	BCF         _GT3A+0, BitPos(_GT3A+0) 
;FIRMWARE_SYA_ver_1_3_0.c,284 :: 		}
	GOTO        L_FSM82
L_FSM81:
;FIRMWARE_SYA_ver_1_3_0.c,286 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,287 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,288 :: 		GT3A = 1;
	BSF         _GT3A+0, BitPos(_GT3A+0) 
;FIRMWARE_SYA_ver_1_3_0.c,289 :: 		}
L_FSM82:
;FIRMWARE_SYA_ver_1_3_0.c,290 :: 		GT4 = 0;
	BCF         _GT4+0, BitPos(_GT4+0) 
;FIRMWARE_SYA_ver_1_3_0.c,291 :: 		GT5 = 0;
	BCF         _GT5+0, BitPos(_GT5+0) 
;FIRMWARE_SYA_ver_1_3_0.c,292 :: 		GT6 = 1;
	BSF         _GT6+0, BitPos(_GT6+0) 
;FIRMWARE_SYA_ver_1_3_0.c,294 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM85
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM85
L__FSM161:
;FIRMWARE_SYA_ver_1_3_0.c,295 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,296 :: 		}
	GOTO        L_FSM86
L_FSM85:
;FIRMWARE_SYA_ver_1_3_0.c,297 :: 		else if((1 == sn_NegEdge_2) && (1 == clock0)){
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_FSM89
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM89
L__FSM160:
;FIRMWARE_SYA_ver_1_3_0.c,299 :: 		next_state = 3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,300 :: 		sn_GoTo = 1; // Ponemos en 1 la señal de transicion
	BSF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_1_3_0.c,301 :: 		}
	GOTO        L_FSM90
L_FSM89:
;FIRMWARE_SYA_ver_1_3_0.c,302 :: 		else if((1 == sn_PosEdge_3) && (1 == clock0)){
	BTFSS       _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
	GOTO        L_FSM93
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM93
L__FSM159:
;FIRMWARE_SYA_ver_1_3_0.c,303 :: 		next_state = 7; // cambiar
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,304 :: 		}
	GOTO        L_FSM94
L_FSM93:
;FIRMWARE_SYA_ver_1_3_0.c,307 :: 		}
L_FSM94:
L_FSM90:
L_FSM86:
;FIRMWARE_SYA_ver_1_3_0.c,308 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,309 :: 		case 7:
L_FSM95:
;FIRMWARE_SYA_ver_1_3_0.c,310 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,311 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,312 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,313 :: 		if(((1 == sn_NegEdge_1) || (1 == sn_NegEdge_2)) && (1 == clock0)){
	BTFSC       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L__FSM158
	BTFSC       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L__FSM158
	GOTO        L_FSM100
L__FSM158:
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM100
L__FSM157:
;FIRMWARE_SYA_ver_1_3_0.c,314 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,315 :: 		}
	GOTO        L_FSM101
L_FSM100:
;FIRMWARE_SYA_ver_1_3_0.c,316 :: 		else if((1 == sn_NegEdge_3) && (1 == clock0)){
	BTFSS       _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
	GOTO        L_FSM104
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM104
L__FSM156:
;FIRMWARE_SYA_ver_1_3_0.c,317 :: 		next_state = 8;
	MOVLW       8
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,318 :: 		}
	GOTO        L_FSM105
L_FSM104:
;FIRMWARE_SYA_ver_1_3_0.c,320 :: 		}
L_FSM105:
L_FSM101:
;FIRMWARE_SYA_ver_1_3_0.c,321 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,322 :: 		case 8: // S5 - Estado de transicion para flanco negativo 2
L_FSM106:
;FIRMWARE_SYA_ver_1_3_0.c,324 :: 		if((1 == sn_GoTo) && (1 == GT4) && (1 == clock0)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM109
	BTFSS       _GT4+0, BitPos(_GT4+0) 
	GOTO        L_FSM109
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM109
L__FSM155:
;FIRMWARE_SYA_ver_1_3_0.c,325 :: 		next_state = 5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,326 :: 		}
	GOTO        L_FSM110
L_FSM109:
;FIRMWARE_SYA_ver_1_3_0.c,327 :: 		else if((1 == sn_GoTo) && (1 == GT5) && (1 == clock0)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM113
	BTFSS       _GT5+0, BitPos(_GT5+0) 
	GOTO        L_FSM113
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM113
L__FSM154:
;FIRMWARE_SYA_ver_1_3_0.c,328 :: 		next_state = 6;
	MOVLW       6
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,329 :: 		}
	GOTO        L_FSM114
L_FSM113:
;FIRMWARE_SYA_ver_1_3_0.c,330 :: 		else if((1 == sn_GoTo) && (1 == GT6) && (1 == clock0)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM117
	BTFSS       _GT6+0, BitPos(_GT6+0) 
	GOTO        L_FSM117
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM117
L__FSM153:
;FIRMWARE_SYA_ver_1_3_0.c,331 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,332 :: 		}
	GOTO        L_FSM118
L_FSM117:
;FIRMWARE_SYA_ver_1_3_0.c,335 :: 		}
L_FSM118:
L_FSM114:
L_FSM110:
;FIRMWARE_SYA_ver_1_3_0.c,336 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,337 :: 		case 9: // S6 - Estado de transicion para flanco positivo
L_FSM119:
;FIRMWARE_SYA_ver_1_3_0.c,338 :: 		if(1 == sn_PosEdge_1){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM120
;FIRMWARE_SYA_ver_1_3_0.c,340 :: 		if((1 == GT1) && (1 == clock0)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM123
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM123
L__FSM152:
;FIRMWARE_SYA_ver_1_3_0.c,342 :: 		next_state = 2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,343 :: 		GT2 = 0; // DO NOT
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,344 :: 		GT3 = 0; // DELETE !!!!
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,345 :: 		}
	GOTO        L_FSM124
L_FSM123:
;FIRMWARE_SYA_ver_1_3_0.c,347 :: 		else if((1 == GT2) && (1 == clock0)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM127
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM127
L__FSM151:
;FIRMWARE_SYA_ver_1_3_0.c,349 :: 		next_state = 3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,350 :: 		GT1 = 0; // DO NOT
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,351 :: 		GT3 = 0; // DELETE !!!!
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,352 :: 		}
	GOTO        L_FSM128
L_FSM127:
;FIRMWARE_SYA_ver_1_3_0.c,354 :: 		else if((1 == GT3) && (1 == clock0)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM131
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM131
L__FSM150:
;FIRMWARE_SYA_ver_1_3_0.c,356 :: 		next_state = 1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,357 :: 		GT1 = 0; // DO NOT
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,358 :: 		GT2 = 0; // DELETE !!!!
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,359 :: 		}
	GOTO        L_FSM132
L_FSM131:
;FIRMWARE_SYA_ver_1_3_0.c,362 :: 		}
L_FSM132:
L_FSM128:
L_FSM124:
;FIRMWARE_SYA_ver_1_3_0.c,363 :: 		}
L_FSM120:
;FIRMWARE_SYA_ver_1_3_0.c,364 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,365 :: 		default:
L_FSM133:
;FIRMWARE_SYA_ver_1_3_0.c,366 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,367 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,368 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,369 :: 		GT1A = 1;
	BSF         _GT1A+0, BitPos(_GT1A+0) 
;FIRMWARE_SYA_ver_1_3_0.c,370 :: 		GT2A = 1;
	BSF         _GT2A+0, BitPos(_GT2A+0) 
;FIRMWARE_SYA_ver_1_3_0.c,371 :: 		GT3A = 1;
	BSF         _GT3A+0, BitPos(_GT3A+0) 
;FIRMWARE_SYA_ver_1_3_0.c,372 :: 		GT4 = 0;
	BCF         _GT4+0, BitPos(_GT4+0) 
;FIRMWARE_SYA_ver_1_3_0.c,373 :: 		GT5 = 0;
	BCF         _GT5+0, BitPos(_GT5+0) 
;FIRMWARE_SYA_ver_1_3_0.c,374 :: 		GT6 = 0;
	BCF         _GT6+0, BitPos(_GT6+0) 
;FIRMWARE_SYA_ver_1_3_0.c,375 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,376 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,377 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,378 :: 		current_state = 0;
	CLRF        _current_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,379 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,380 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,381 :: 		}
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
	GOTO        L_FSM65
	MOVF        _current_state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM80
	MOVF        _current_state+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM95
	MOVF        _current_state+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM106
	MOVF        _current_state+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM119
	GOTO        L_FSM133
L_FSM17:
;FIRMWARE_SYA_ver_1_3_0.c,383 :: 		}
L_end_FSM:
	RETURN      0
; end of _FSM

_Events:

;FIRMWARE_SYA_ver_1_3_0.c,389 :: 		void Events(){
;FIRMWARE_SYA_ver_1_3_0.c,391 :: 		if(1 == interruptC0){
	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events134
;FIRMWARE_SYA_ver_1_3_0.c,393 :: 		if(1 == SWITCH1){
	BTFSS       PORTC+0, 0 
	GOTO        L_Events135
;FIRMWARE_SYA_ver_1_3_0.c,395 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,396 :: 		sn_NegEdge_1 = 1;
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,397 :: 		}
	GOTO        L_Events136
L_Events135:
;FIRMWARE_SYA_ver_1_3_0.c,401 :: 		sn_PosEdge_1 = 1;
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,402 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,403 :: 		}
L_Events136:
;FIRMWARE_SYA_ver_1_3_0.c,404 :: 		interruptC0 = 0; // Limpiamos la bandera de interrupcion en C0
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_1_3_0.c,405 :: 		}
	GOTO        L_Events137
L_Events134:
;FIRMWARE_SYA_ver_1_3_0.c,407 :: 		else if(1 == interruptC1){
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events138
;FIRMWARE_SYA_ver_1_3_0.c,409 :: 		if(1 == SWITCH2){
	BTFSS       PORTC+0, 1 
	GOTO        L_Events139
;FIRMWARE_SYA_ver_1_3_0.c,411 :: 		sn_PosEdge_2 = 0;
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,412 :: 		sn_NegEdge_2 = 1;
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,413 :: 		}
	GOTO        L_Events140
L_Events139:
;FIRMWARE_SYA_ver_1_3_0.c,417 :: 		sn_PosEdge_2 = 1;
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,418 :: 		sn_NegEdge_2 = 0;
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,419 :: 		}
L_Events140:
;FIRMWARE_SYA_ver_1_3_0.c,420 :: 		interruptC1 = 0; // Limpiamos la bandera de interrupcion en C1
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,421 :: 		}
	GOTO        L_Events141
L_Events138:
;FIRMWARE_SYA_ver_1_3_0.c,422 :: 		else if(1 == interruptC2){
	BTFSS       _interruptC2+0, BitPos(_interruptC2+0) 
	GOTO        L_Events142
;FIRMWARE_SYA_ver_1_3_0.c,423 :: 		if(1 == SWITCH3){
	BTFSS       PORTC+0, 2 
	GOTO        L_Events143
;FIRMWARE_SYA_ver_1_3_0.c,424 :: 		sn_PosEdge_3 = 0;
	BCF         _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,425 :: 		sn_NegEdge_3 = 1;
	BSF         _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,426 :: 		}
	GOTO        L_Events144
L_Events143:
;FIRMWARE_SYA_ver_1_3_0.c,428 :: 		sn_PosEdge_3 = 1;
	BSF         _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,429 :: 		sn_NegEdge_3 = 0;
	BCF         _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,430 :: 		}
L_Events144:
;FIRMWARE_SYA_ver_1_3_0.c,431 :: 		interruptC2 = 0;
	BCF         _interruptC2+0, BitPos(_interruptC2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,432 :: 		}
	GOTO        L_Events145
L_Events142:
;FIRMWARE_SYA_ver_1_3_0.c,434 :: 		interruptC0 = 0;
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_1_3_0.c,435 :: 		interruptC1 = 0;
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,436 :: 		interruptC2 = 0;
	BCF         _interruptC2+0, BitPos(_interruptC2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,437 :: 		}
L_Events145:
L_Events141:
L_Events137:
;FIRMWARE_SYA_ver_1_3_0.c,438 :: 		return;
;FIRMWARE_SYA_ver_1_3_0.c,440 :: 		}
L_end_Events:
	RETURN      0
; end of _Events

_InitInterrupt:

;FIRMWARE_SYA_ver_1_3_0.c,446 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_1_3_0.c,448 :: 		PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       48
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_1_3_0.c,449 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_1_3_0.c,454 :: 		IOCCN = 0x07;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       7
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_1_3_0.c,455 :: 		IOCCP = 0x07;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
	MOVLW       7
	MOVWF       IOCCP+0 
;FIRMWARE_SYA_ver_1_3_0.c,456 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_1_3_0.c,457 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,458 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_1_3_0.c,460 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_1_3_0.c,466 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_1_3_0.c,468 :: 		ADCON0 = 0x08; // Desactivamos ADC
	MOVLW       8
	MOVWF       ADCON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,469 :: 		ANSELC = 0x00;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_1_3_0.c,470 :: 		ANSELE = 0x00;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_1_3_0.c,471 :: 		ANSELA = 0x00;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_1_3_0.c,472 :: 		ANSELD = 0x00;
	CLRF        ANSELD+0 
;FIRMWARE_SYA_ver_1_3_0.c,474 :: 		TRISC = 0x0F;  // Ponemos en modo de entrada a C0, C1, c2 Y c3, los demas como salida
	MOVLW       15
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_1_3_0.c,475 :: 		TRISD = 0x07;  // Ponemos en modo de entrada a D0 y D1
	MOVLW       7
	MOVWF       TRISD+0 
;FIRMWARE_SYA_ver_1_3_0.c,476 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_1_3_0.c,477 :: 		TRISA = 0x80;  //                ''                A
	MOVLW       128
	MOVWF       TRISA+0 
;FIRMWARE_SYA_ver_1_3_0.c,479 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_1_3_0.c,480 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;FIRMWARE_SYA_ver_1_3_0.c,481 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_1_3_0.c,482 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_1_3_0.c,484 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_1_3_0.c,485 :: 		LATD = 0x00;
	CLRF        LATD+0 
;FIRMWARE_SYA_ver_1_3_0.c,486 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_1_3_0.c,487 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_1_3_0.c,489 :: 		WPUC = 0x0F;   // Activamos el pull-up interno de C0 y C1
	MOVLW       15
	MOVWF       WPUC+0 
;FIRMWARE_SYA_ver_1_3_0.c,490 :: 		INLVLC = 0x0F; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       15
	MOVWF       INLVLC+0 
;FIRMWARE_SYA_ver_1_3_0.c,491 :: 		WPUD = 0x07;   // Activamos el pull-up interno de C0 y C1
	MOVLW       7
	MOVWF       WPUD+0 
;FIRMWARE_SYA_ver_1_3_0.c,492 :: 		INLVLD = 0x07; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       7
	MOVWF       INLVLD+0 
;FIRMWARE_SYA_ver_1_3_0.c,493 :: 		CM1CON0 = 0x00; // Desactivamos el comparador 1
	CLRF        CM1CON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,494 :: 		CM2CON0 = 0x00; // Desactivamos el comparador 2
	CLRF        CM2CON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,496 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
