
_interrupt:

;FIRMWARE_SYA_ver_1_3_0.c,86 :: 		void interrupt(){
;FIRMWARE_SYA_ver_1_3_0.c,99 :: 		if((1 == IOCCF.B0) && (1 == IOCIE_bit)){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt2
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt2
L__interrupt128:
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
L__interrupt127:
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
L__interrupt126:
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
L__interrupt150:
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
L__main129:
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
L__FSM148:
;FIRMWARE_SYA_ver_1_3_0.c,150 :: 		next_state = 7; // Si, pasamos a estado 6
	MOVLW       7
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
L__FSM147:
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
L__FSM146:
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
L__FSM145:
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
L__FSM144:
;FIRMWARE_SYA_ver_1_3_0.c,192 :: 		next_state = 4;
	MOVLW       4
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
L__FSM143:
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
L__FSM142:
;FIRMWARE_SYA_ver_1_3_0.c,213 :: 		next_state = 4;
	MOVLW       4
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
;FIRMWARE_SYA_ver_1_3_0.c,220 :: 		switch(GT1){
	GOTO        L_FSM51
;FIRMWARE_SYA_ver_1_3_0.c,221 :: 		case 0:
L_FSM53:
;FIRMWARE_SYA_ver_1_3_0.c,222 :: 		switch(GT2){
	GOTO        L_FSM54
;FIRMWARE_SYA_ver_1_3_0.c,223 :: 		case 0:
L_FSM56:
;FIRMWARE_SYA_ver_1_3_0.c,224 :: 		switch(GT3){
	GOTO        L_FSM57
;FIRMWARE_SYA_ver_1_3_0.c,225 :: 		case 0:
L_FSM59:
;FIRMWARE_SYA_ver_1_3_0.c,226 :: 		break;
	GOTO        L_FSM58
;FIRMWARE_SYA_ver_1_3_0.c,227 :: 		case 1:
L_FSM60:
;FIRMWARE_SYA_ver_1_3_0.c,228 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,229 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,230 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,231 :: 		break;
	GOTO        L_FSM58
;FIRMWARE_SYA_ver_1_3_0.c,232 :: 		}
L_FSM57:
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM59
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM60
L_FSM58:
;FIRMWARE_SYA_ver_1_3_0.c,233 :: 		break;
	GOTO        L_FSM55
;FIRMWARE_SYA_ver_1_3_0.c,234 :: 		case 1:
L_FSM61:
;FIRMWARE_SYA_ver_1_3_0.c,235 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,236 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,237 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,238 :: 		break;
	GOTO        L_FSM55
;FIRMWARE_SYA_ver_1_3_0.c,239 :: 		}
L_FSM54:
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM56
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM61
L_FSM55:
;FIRMWARE_SYA_ver_1_3_0.c,240 :: 		break;
	GOTO        L_FSM52
;FIRMWARE_SYA_ver_1_3_0.c,241 :: 		case 1:
L_FSM62:
;FIRMWARE_SYA_ver_1_3_0.c,242 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,243 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,244 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,245 :: 		break;
	GOTO        L_FSM52
;FIRMWARE_SYA_ver_1_3_0.c,246 :: 		}
L_FSM51:
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM53
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM62
L_FSM52:
;FIRMWARE_SYA_ver_1_3_0.c,248 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM65
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM65
L__FSM141:
;FIRMWARE_SYA_ver_1_3_0.c,249 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,250 :: 		}
	GOTO        L_FSM66
L_FSM65:
;FIRMWARE_SYA_ver_1_3_0.c,251 :: 		else if((1 == sn_NegEdge_2) && (1 == clock0)){
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_FSM69
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM69
L__FSM140:
;FIRMWARE_SYA_ver_1_3_0.c,253 :: 		next_state = 1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,254 :: 		sn_GoTo = 1; // Ponemos en 1 la señal de transicion
	BSF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_1_3_0.c,255 :: 		}
	GOTO        L_FSM70
L_FSM69:
;FIRMWARE_SYA_ver_1_3_0.c,256 :: 		else if((1 == sn_PosEdge_3) && (1 == clock0)){
	BTFSS       _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
	GOTO        L_FSM73
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM73
L__FSM139:
;FIRMWARE_SYA_ver_1_3_0.c,257 :: 		next_state = 5; // cambiar
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,258 :: 		}
	GOTO        L_FSM74
L_FSM73:
;FIRMWARE_SYA_ver_1_3_0.c,261 :: 		}
L_FSM74:
L_FSM70:
L_FSM66:
;FIRMWARE_SYA_ver_1_3_0.c,262 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,263 :: 		case 5:
L_FSM75:
;FIRMWARE_SYA_ver_1_3_0.c,264 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,265 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,266 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,267 :: 		if(((1 == sn_NegEdge_1) || (1 == sn_NegEdge_2)) && (1 == clock0)){
	BTFSC       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L__FSM138
	BTFSC       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L__FSM138
	GOTO        L_FSM80
L__FSM138:
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM80
L__FSM137:
;FIRMWARE_SYA_ver_1_3_0.c,268 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,269 :: 		}
	GOTO        L_FSM81
L_FSM80:
;FIRMWARE_SYA_ver_1_3_0.c,270 :: 		else if((1 == sn_NegEdge_3) && (1 == clock0)){
	BTFSS       _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
	GOTO        L_FSM84
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM84
L__FSM136:
;FIRMWARE_SYA_ver_1_3_0.c,271 :: 		next_state = 6;
	MOVLW       6
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,272 :: 		}
	GOTO        L_FSM85
L_FSM84:
;FIRMWARE_SYA_ver_1_3_0.c,274 :: 		}
L_FSM85:
L_FSM81:
;FIRMWARE_SYA_ver_1_3_0.c,275 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,276 :: 		case 6: // S5 - Estado de transicion para flanco negativo 2
L_FSM86:
;FIRMWARE_SYA_ver_1_3_0.c,278 :: 		if((1 == sn_GoTo) && (1 == GT1) && (1 == clock0)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM89
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM89
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM89
L__FSM135:
;FIRMWARE_SYA_ver_1_3_0.c,279 :: 		GT2 = 1;
	BSF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,280 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,281 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,282 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,283 :: 		}
	GOTO        L_FSM90
L_FSM89:
;FIRMWARE_SYA_ver_1_3_0.c,284 :: 		else if((1 == sn_GoTo) && (1 == GT2) && (1 == clock0)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM93
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM93
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM93
L__FSM134:
;FIRMWARE_SYA_ver_1_3_0.c,285 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,286 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,287 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,288 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,289 :: 		}
	GOTO        L_FSM94
L_FSM93:
;FIRMWARE_SYA_ver_1_3_0.c,290 :: 		else if((1 == sn_GoTo) && (1 == GT3) && (1 == clock0)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM97
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM97
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM97
L__FSM133:
;FIRMWARE_SYA_ver_1_3_0.c,291 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,292 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,293 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,294 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,295 :: 		}
	GOTO        L_FSM98
L_FSM97:
;FIRMWARE_SYA_ver_1_3_0.c,298 :: 		}
L_FSM98:
L_FSM94:
L_FSM90:
;FIRMWARE_SYA_ver_1_3_0.c,299 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,300 :: 		case 7: // S6 - Estado de transicion para flanco positivo
L_FSM99:
;FIRMWARE_SYA_ver_1_3_0.c,301 :: 		if(1 == sn_PosEdge_1){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM100
;FIRMWARE_SYA_ver_1_3_0.c,303 :: 		if((1 == GT1) && (1 == clock0)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM103
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM103
L__FSM132:
;FIRMWARE_SYA_ver_1_3_0.c,305 :: 		next_state = 2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,306 :: 		GT2 = 0; // DO NOT
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,307 :: 		GT3 = 0; // DELETE !!!!
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,308 :: 		}
	GOTO        L_FSM104
L_FSM103:
;FIRMWARE_SYA_ver_1_3_0.c,310 :: 		else if((1 == GT2) && (1 == clock0)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM107
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM107
L__FSM131:
;FIRMWARE_SYA_ver_1_3_0.c,312 :: 		next_state = 3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,313 :: 		GT1 = 0; // DO NOT
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,314 :: 		GT3 = 0; // DELETE !!!!
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,315 :: 		}
	GOTO        L_FSM108
L_FSM107:
;FIRMWARE_SYA_ver_1_3_0.c,317 :: 		else if((1 == GT3) && (1 == clock0)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM111
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM111
L__FSM130:
;FIRMWARE_SYA_ver_1_3_0.c,319 :: 		next_state = 1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,320 :: 		GT1 = 0; // DO NOT
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,321 :: 		GT2 = 0; // DELETE !!!!
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,322 :: 		}
	GOTO        L_FSM112
L_FSM111:
;FIRMWARE_SYA_ver_1_3_0.c,325 :: 		}
L_FSM112:
L_FSM108:
L_FSM104:
;FIRMWARE_SYA_ver_1_3_0.c,326 :: 		}
L_FSM100:
;FIRMWARE_SYA_ver_1_3_0.c,327 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,328 :: 		default:
L_FSM113:
;FIRMWARE_SYA_ver_1_3_0.c,329 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,330 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,331 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,332 :: 		GT1A = 1;
	BSF         _GT1A+0, BitPos(_GT1A+0) 
;FIRMWARE_SYA_ver_1_3_0.c,333 :: 		GT2A = 1;
	BSF         _GT2A+0, BitPos(_GT2A+0) 
;FIRMWARE_SYA_ver_1_3_0.c,334 :: 		GT3A = 1;
	BSF         _GT3A+0, BitPos(_GT3A+0) 
;FIRMWARE_SYA_ver_1_3_0.c,335 :: 		GT4 = 0;
	BCF         _GT4+0, BitPos(_GT4+0) 
;FIRMWARE_SYA_ver_1_3_0.c,336 :: 		GT5 = 0;
	BCF         _GT5+0, BitPos(_GT5+0) 
;FIRMWARE_SYA_ver_1_3_0.c,337 :: 		GT6 = 0;
	BCF         _GT6+0, BitPos(_GT6+0) 
;FIRMWARE_SYA_ver_1_3_0.c,338 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,339 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,340 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,341 :: 		current_state = 0;
	CLRF        _current_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,342 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,343 :: 		break;
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_1_3_0.c,344 :: 		}
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
	GOTO        L_FSM75
	MOVF        _current_state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM86
	MOVF        _current_state+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM99
	GOTO        L_FSM113
L_FSM17:
;FIRMWARE_SYA_ver_1_3_0.c,346 :: 		}
L_end_FSM:
	RETURN      0
; end of _FSM

_Events:

;FIRMWARE_SYA_ver_1_3_0.c,352 :: 		void Events(){
;FIRMWARE_SYA_ver_1_3_0.c,354 :: 		if(1 == interruptC0){
	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events114
;FIRMWARE_SYA_ver_1_3_0.c,356 :: 		if(1 == SWITCH1){
	BTFSS       PORTC+0, 0 
	GOTO        L_Events115
;FIRMWARE_SYA_ver_1_3_0.c,358 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,359 :: 		sn_NegEdge_1 = 1;
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,360 :: 		}
	GOTO        L_Events116
L_Events115:
;FIRMWARE_SYA_ver_1_3_0.c,364 :: 		sn_PosEdge_1 = 1;
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,365 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,366 :: 		}
L_Events116:
;FIRMWARE_SYA_ver_1_3_0.c,367 :: 		interruptC0 = 0; // Limpiamos la bandera de interrupcion en C0
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_1_3_0.c,368 :: 		}
	GOTO        L_Events117
L_Events114:
;FIRMWARE_SYA_ver_1_3_0.c,370 :: 		else if(1 == interruptC1){
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events118
;FIRMWARE_SYA_ver_1_3_0.c,372 :: 		if(1 == SWITCH2){
	BTFSS       PORTC+0, 1 
	GOTO        L_Events119
;FIRMWARE_SYA_ver_1_3_0.c,374 :: 		sn_PosEdge_2 = 0;
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,375 :: 		sn_NegEdge_2 = 1;
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,376 :: 		}
	GOTO        L_Events120
L_Events119:
;FIRMWARE_SYA_ver_1_3_0.c,380 :: 		sn_PosEdge_2 = 1;
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,381 :: 		sn_NegEdge_2 = 0;
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,382 :: 		}
L_Events120:
;FIRMWARE_SYA_ver_1_3_0.c,383 :: 		interruptC1 = 0; // Limpiamos la bandera de interrupcion en C1
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,384 :: 		}
	GOTO        L_Events121
L_Events118:
;FIRMWARE_SYA_ver_1_3_0.c,385 :: 		else if(1 == interruptC2){
	BTFSS       _interruptC2+0, BitPos(_interruptC2+0) 
	GOTO        L_Events122
;FIRMWARE_SYA_ver_1_3_0.c,386 :: 		if(1 == SWITCH3){
	BTFSS       PORTC+0, 2 
	GOTO        L_Events123
;FIRMWARE_SYA_ver_1_3_0.c,387 :: 		sn_PosEdge_3 = 0;
	BCF         _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,388 :: 		sn_NegEdge_3 = 1;
	BSF         _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,389 :: 		}
	GOTO        L_Events124
L_Events123:
;FIRMWARE_SYA_ver_1_3_0.c,391 :: 		sn_PosEdge_3 = 1;
	BSF         _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,392 :: 		sn_NegEdge_3 = 0;
	BCF         _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,393 :: 		}
L_Events124:
;FIRMWARE_SYA_ver_1_3_0.c,394 :: 		interruptC2 = 0;
	BCF         _interruptC2+0, BitPos(_interruptC2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,395 :: 		}
	GOTO        L_Events125
L_Events122:
;FIRMWARE_SYA_ver_1_3_0.c,397 :: 		interruptC0 = 0;
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_1_3_0.c,398 :: 		interruptC1 = 0;
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,399 :: 		interruptC2 = 0;
	BCF         _interruptC2+0, BitPos(_interruptC2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,400 :: 		}
L_Events125:
L_Events121:
L_Events117:
;FIRMWARE_SYA_ver_1_3_0.c,401 :: 		return;
;FIRMWARE_SYA_ver_1_3_0.c,403 :: 		}
L_end_Events:
	RETURN      0
; end of _Events

_InitInterrupt:

;FIRMWARE_SYA_ver_1_3_0.c,409 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_1_3_0.c,411 :: 		PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       48
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_1_3_0.c,412 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_1_3_0.c,417 :: 		IOCCN = 0x07;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       7
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_1_3_0.c,418 :: 		IOCCP = 0x07;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
	MOVLW       7
	MOVWF       IOCCP+0 
;FIRMWARE_SYA_ver_1_3_0.c,419 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_1_3_0.c,420 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,421 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_1_3_0.c,423 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_1_3_0.c,429 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_1_3_0.c,431 :: 		ADCON0 = 0x08; // Desactivamos ADC
	MOVLW       8
	MOVWF       ADCON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,432 :: 		ANSELC = 0x00;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_1_3_0.c,433 :: 		ANSELE = 0x00;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_1_3_0.c,434 :: 		ANSELA = 0x00;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_1_3_0.c,435 :: 		ANSELD = 0x00;
	CLRF        ANSELD+0 
;FIRMWARE_SYA_ver_1_3_0.c,437 :: 		TRISC = 0x0F;  // Ponemos en modo de entrada a C0, C1, c2 Y c3, los demas como salida
	MOVLW       15
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_1_3_0.c,438 :: 		TRISD = 0x07;  // Ponemos en modo de entrada a D0 y D1
	MOVLW       7
	MOVWF       TRISD+0 
;FIRMWARE_SYA_ver_1_3_0.c,439 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_1_3_0.c,440 :: 		TRISA = 0x80;  //                ''                A
	MOVLW       128
	MOVWF       TRISA+0 
;FIRMWARE_SYA_ver_1_3_0.c,442 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_1_3_0.c,443 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;FIRMWARE_SYA_ver_1_3_0.c,444 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_1_3_0.c,445 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_1_3_0.c,447 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_1_3_0.c,448 :: 		LATD = 0x00;
	CLRF        LATD+0 
;FIRMWARE_SYA_ver_1_3_0.c,449 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_1_3_0.c,450 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_1_3_0.c,452 :: 		WPUC = 0x0F;   // Activamos el pull-up interno de C0 y C1
	MOVLW       15
	MOVWF       WPUC+0 
;FIRMWARE_SYA_ver_1_3_0.c,453 :: 		INLVLC = 0x0F; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       15
	MOVWF       INLVLC+0 
;FIRMWARE_SYA_ver_1_3_0.c,454 :: 		WPUD = 0x07;   // Activamos el pull-up interno de C0 y C1
	MOVLW       7
	MOVWF       WPUD+0 
;FIRMWARE_SYA_ver_1_3_0.c,455 :: 		INLVLD = 0x07; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       7
	MOVWF       INLVLD+0 
;FIRMWARE_SYA_ver_1_3_0.c,456 :: 		CM1CON0 = 0x00; // Desactivamos el comparador 1
	CLRF        CM1CON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,457 :: 		CM2CON0 = 0x00; // Desactivamos el comparador 2
	CLRF        CM2CON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,459 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
