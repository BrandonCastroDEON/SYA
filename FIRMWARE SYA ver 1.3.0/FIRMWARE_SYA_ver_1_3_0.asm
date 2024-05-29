
_M1On:

;FIRMWARE_SYA_ver_1_3_0.c,88 :: 		void M1On(){M1 = 1;}
	BSF         LATA+0, 5 
L_end_M1On:
	RETURN      0
; end of _M1On

_M1Off:

;FIRMWARE_SYA_ver_1_3_0.c,89 :: 		void M1Off(){M1 = 0;}
	BCF         LATA+0, 5 
L_end_M1Off:
	RETURN      0
; end of _M1Off

_M2On:

;FIRMWARE_SYA_ver_1_3_0.c,90 :: 		void M2On(){M2 = 1;}
	BSF         LATE+0, 0 
L_end_M2On:
	RETURN      0
; end of _M2On

_M2Off:

;FIRMWARE_SYA_ver_1_3_0.c,91 :: 		void M2Off(){M2 = 0;}
	BCF         LATE+0, 0 
L_end_M2Off:
	RETURN      0
; end of _M2Off

_M3On:

;FIRMWARE_SYA_ver_1_3_0.c,92 :: 		void M3On(){M3 = 1;}
	BSF         LATE+0, 1 
L_end_M3On:
	RETURN      0
; end of _M3On

_M3Off:

;FIRMWARE_SYA_ver_1_3_0.c,93 :: 		void M3Off(){M3 = 0;}
	BCF         LATE+0, 1 
L_end_M3Off:
	RETURN      0
; end of _M3Off

_interrupt:

;FIRMWARE_SYA_ver_1_3_0.c,99 :: 		void interrupt(){
;FIRMWARE_SYA_ver_1_3_0.c,101 :: 		if(PIR0.TMR0IF){
	BTFSS       PIR0+0, 5 
	GOTO        L_interrupt0
;FIRMWARE_SYA_ver_1_3_0.c,102 :: 		TMR0H = 0x3C;      // Timer para cada segundo y medio?
	MOVLW       60
	MOVWF       TMR0H+0 
;FIRMWARE_SYA_ver_1_3_0.c,103 :: 		TMR0L = 0xB0;      //
	MOVLW       176
	MOVWF       TMR0L+0 
;FIRMWARE_SYA_ver_1_3_0.c,104 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,105 :: 		counter++;
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
;FIRMWARE_SYA_ver_1_3_0.c,106 :: 		if(counter >= 200){
	MOVLW       128
	XORWF       _counter+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt138
	MOVLW       200
	SUBWF       _counter+0, 0 
L__interrupt138:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt1
;FIRMWARE_SYA_ver_1_3_0.c,107 :: 		LED = ~LED;
	BTG         LATA+0, 4 
;FIRMWARE_SYA_ver_1_3_0.c,109 :: 		PIE0.TMR0IE = 0;
	BCF         PIE0+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,110 :: 		counter = 0;
	CLRF        _counter+0 
	CLRF        _counter+1 
;FIRMWARE_SYA_ver_1_3_0.c,111 :: 		}
L_interrupt1:
;FIRMWARE_SYA_ver_1_3_0.c,112 :: 		}
L_interrupt0:
;FIRMWARE_SYA_ver_1_3_0.c,113 :: 		if(PIR4.TMR1IF){
	BTFSS       PIR4+0, 0 
	GOTO        L_interrupt2
;FIRMWARE_SYA_ver_1_3_0.c,114 :: 		TMR1H = 0xEC;
	MOVLW       236
	MOVWF       TMR1H+0 
;FIRMWARE_SYA_ver_1_3_0.c,115 :: 		TMR1L = 0x78;
	MOVLW       120
	MOVWF       TMR1L+0 
;FIRMWARE_SYA_ver_1_3_0.c,116 :: 		PIR4.TMR1IF = 0;
	BCF         PIR4+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,117 :: 		counter1++;
	MOVLW       1
	ADDWF       _counter1+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _counter1+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _counter1+0 
	MOVF        R1, 0 
	MOVWF       _counter1+1 
;FIRMWARE_SYA_ver_1_3_0.c,118 :: 		if(counter1 >= 1000){
	MOVLW       128
	XORWF       _counter1+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt139
	MOVLW       232
	SUBWF       _counter1+0, 0 
L__interrupt139:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt3
;FIRMWARE_SYA_ver_1_3_0.c,119 :: 		M4 = ~M4;
	BTG         LATE+0, 2 
;FIRMWARE_SYA_ver_1_3_0.c,120 :: 		counter1 = 0;
	CLRF        _counter1+0 
	CLRF        _counter1+1 
;FIRMWARE_SYA_ver_1_3_0.c,121 :: 		}
L_interrupt3:
;FIRMWARE_SYA_ver_1_3_0.c,122 :: 		}
L_interrupt2:
;FIRMWARE_SYA_ver_1_3_0.c,123 :: 		if(1 == IOCCF.B0){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt4
;FIRMWARE_SYA_ver_1_3_0.c,124 :: 		IOCCF.B0 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,125 :: 		interruptC0 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	MOVLW       1
	MOVWF       _interruptC0+0 
	MOVLW       0
	MOVWF       _interruptC0+1 
;FIRMWARE_SYA_ver_1_3_0.c,126 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_interrupt5:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt5
	DECFSZ      R12, 1, 1
	BRA         L_interrupt5
	DECFSZ      R11, 1, 1
	BRA         L_interrupt5
	NOP
	NOP
;FIRMWARE_SYA_ver_1_3_0.c,127 :: 		if(1 == SWITCH1){
	BTFSS       PORTC+0, 0 
	GOTO        L_interrupt6
;FIRMWARE_SYA_ver_1_3_0.c,128 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,129 :: 		sn_NegEdge_1 = 1;
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,130 :: 		interruptC0 = 0;
	CLRF        _interruptC0+0 
	CLRF        _interruptC0+1 
;FIRMWARE_SYA_ver_1_3_0.c,131 :: 		}
	GOTO        L_interrupt7
L_interrupt6:
;FIRMWARE_SYA_ver_1_3_0.c,133 :: 		sn_PosEdge_1 = 1;
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,134 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,135 :: 		next_state = s7;
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,136 :: 		interruptC0 = 0;
	CLRF        _interruptC0+0 
	CLRF        _interruptC0+1 
;FIRMWARE_SYA_ver_1_3_0.c,137 :: 		if(!SWITCH2){
	BTFSC       PORTC+0, 1 
	GOTO        L_interrupt8
;FIRMWARE_SYA_ver_1_3_0.c,138 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,139 :: 		if(!SWITCH3){
	BTFSC       PORTC+0, 2 
	GOTO        L_interrupt9
;FIRMWARE_SYA_ver_1_3_0.c,140 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,141 :: 		}
	GOTO        L_interrupt10
L_interrupt9:
;FIRMWARE_SYA_ver_1_3_0.c,143 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,144 :: 		}
L_interrupt10:
;FIRMWARE_SYA_ver_1_3_0.c,145 :: 		}
	GOTO        L_interrupt11
L_interrupt8:
;FIRMWARE_SYA_ver_1_3_0.c,147 :: 		next_state = s7;
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,148 :: 		if(!SWITCH3){
	BTFSC       PORTC+0, 2 
	GOTO        L_interrupt12
;FIRMWARE_SYA_ver_1_3_0.c,149 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,150 :: 		}
	GOTO        L_interrupt13
L_interrupt12:
;FIRMWARE_SYA_ver_1_3_0.c,152 :: 		next_state = s7;
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,153 :: 		}
L_interrupt13:
;FIRMWARE_SYA_ver_1_3_0.c,154 :: 		}
L_interrupt11:
;FIRMWARE_SYA_ver_1_3_0.c,155 :: 		}
L_interrupt7:
;FIRMWARE_SYA_ver_1_3_0.c,157 :: 		}
L_interrupt4:
;FIRMWARE_SYA_ver_1_3_0.c,159 :: 		if(1 == IOCCF.B1){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt14
;FIRMWARE_SYA_ver_1_3_0.c,160 :: 		IOCCF.B1 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,161 :: 		interruptC1 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	MOVLW       1
	MOVWF       _interruptC1+0 
	MOVLW       0
	MOVWF       _interruptC1+1 
;FIRMWARE_SYA_ver_1_3_0.c,162 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_interrupt15:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt15
	DECFSZ      R12, 1, 1
	BRA         L_interrupt15
	DECFSZ      R11, 1, 1
	BRA         L_interrupt15
	NOP
	NOP
;FIRMWARE_SYA_ver_1_3_0.c,163 :: 		if(1 == SWITCH2){
	BTFSS       PORTC+0, 1 
	GOTO        L_interrupt16
;FIRMWARE_SYA_ver_1_3_0.c,164 :: 		sn_PosEdge_2 = 0;
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,165 :: 		sn_NegEdge_2 = 1;
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,166 :: 		interruptC1 = 0;
	CLRF        _interruptC1+0 
	CLRF        _interruptC1+1 
;FIRMWARE_SYA_ver_1_3_0.c,167 :: 		}
	GOTO        L_interrupt17
L_interrupt16:
;FIRMWARE_SYA_ver_1_3_0.c,169 :: 		sn_PosEdge_2 = 1;
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,170 :: 		sn_NegEdge_2 = 0;
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,171 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,172 :: 		interruptC1 = 0;
	CLRF        _interruptC1+0 
	CLRF        _interruptC1+1 
;FIRMWARE_SYA_ver_1_3_0.c,173 :: 		if(!SWITCH3){
	BTFSC       PORTC+0, 2 
	GOTO        L_interrupt18
;FIRMWARE_SYA_ver_1_3_0.c,174 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,175 :: 		}
	GOTO        L_interrupt19
L_interrupt18:
;FIRMWARE_SYA_ver_1_3_0.c,177 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,178 :: 		}
L_interrupt19:
;FIRMWARE_SYA_ver_1_3_0.c,179 :: 		}
L_interrupt17:
;FIRMWARE_SYA_ver_1_3_0.c,181 :: 		}
L_interrupt14:
;FIRMWARE_SYA_ver_1_3_0.c,183 :: 		if(1 == IOCCF.B2){
	BTFSS       IOCCF+0, 2 
	GOTO        L_interrupt20
;FIRMWARE_SYA_ver_1_3_0.c,184 :: 		IOCCF.B2 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 2 
;FIRMWARE_SYA_ver_1_3_0.c,185 :: 		interruptC2 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	MOVLW       1
	MOVWF       _interruptC2+0 
	MOVLW       0
	MOVWF       _interruptC2+1 
;FIRMWARE_SYA_ver_1_3_0.c,186 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_interrupt21:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt21
	DECFSZ      R12, 1, 1
	BRA         L_interrupt21
	DECFSZ      R11, 1, 1
	BRA         L_interrupt21
	NOP
	NOP
;FIRMWARE_SYA_ver_1_3_0.c,187 :: 		if(1 == SWITCH3){
	BTFSS       PORTC+0, 2 
	GOTO        L_interrupt22
;FIRMWARE_SYA_ver_1_3_0.c,188 :: 		sn_PosEdge_3 = 0;
	BCF         _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,189 :: 		sn_NegEdge_3 = 1;
	BSF         _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,190 :: 		interruptC2 = 0;
	CLRF        _interruptC2+0 
	CLRF        _interruptC2+1 
;FIRMWARE_SYA_ver_1_3_0.c,191 :: 		}
	GOTO        L_interrupt23
L_interrupt22:
;FIRMWARE_SYA_ver_1_3_0.c,193 :: 		sn_PosEdge_3 = 1;
	BSF         _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,194 :: 		sn_NegEdge_3 = 0;
	BCF         _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,195 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,196 :: 		interruptC2 = 0;
	CLRF        _interruptC2+0 
	CLRF        _interruptC2+1 
;FIRMWARE_SYA_ver_1_3_0.c,197 :: 		}
L_interrupt23:
;FIRMWARE_SYA_ver_1_3_0.c,199 :: 		}
L_interrupt20:
;FIRMWARE_SYA_ver_1_3_0.c,201 :: 		}
L_end_interrupt:
L__interrupt137:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_1_3_0.c,207 :: 		void main(){
;FIRMWARE_SYA_ver_1_3_0.c,209 :: 		InitSystems();
	CALL        _InitSystems+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,211 :: 		while(1){
L_main24:
;FIRMWARE_SYA_ver_1_3_0.c,213 :: 		current_state = next_state; // Maybe move this with Events
	MOVF        _next_state+0, 0 
	MOVWF       _current_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,214 :: 		FSM();
	CALL        _FSM+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,215 :: 		}
	GOTO        L_main24
;FIRMWARE_SYA_ver_1_3_0.c,217 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_FSM:

;FIRMWARE_SYA_ver_1_3_0.c,223 :: 		void FSM(){
;FIRMWARE_SYA_ver_1_3_0.c,224 :: 		switch(current_state){
	GOTO        L_FSM26
;FIRMWARE_SYA_ver_1_3_0.c,225 :: 		case s0:
L_FSM28:
;FIRMWARE_SYA_ver_1_3_0.c,226 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,227 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,228 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,229 :: 		if(1 == sn_PosEdge_1){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM29
;FIRMWARE_SYA_ver_1_3_0.c,230 :: 		next_state = s7;
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,231 :: 		}
	GOTO        L_FSM30
L_FSM29:
;FIRMWARE_SYA_ver_1_3_0.c,233 :: 		}
L_FSM30:
;FIRMWARE_SYA_ver_1_3_0.c,234 :: 		break;
	GOTO        L_FSM27
;FIRMWARE_SYA_ver_1_3_0.c,235 :: 		case s1:
L_FSM31:
;FIRMWARE_SYA_ver_1_3_0.c,236 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,237 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,238 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,239 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,240 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,241 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,242 :: 		if(1 == sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM32
;FIRMWARE_SYA_ver_1_3_0.c,244 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,245 :: 		}
	GOTO        L_FSM33
L_FSM32:
;FIRMWARE_SYA_ver_1_3_0.c,246 :: 		else if(1 == sn_PosEdge_2){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM34
;FIRMWARE_SYA_ver_1_3_0.c,247 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,248 :: 		}
	GOTO        L_FSM35
L_FSM34:
;FIRMWARE_SYA_ver_1_3_0.c,250 :: 		}
L_FSM35:
L_FSM33:
;FIRMWARE_SYA_ver_1_3_0.c,251 :: 		break;
	GOTO        L_FSM27
;FIRMWARE_SYA_ver_1_3_0.c,252 :: 		case s2:
L_FSM36:
;FIRMWARE_SYA_ver_1_3_0.c,253 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,254 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,255 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,256 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,257 :: 		GT2 = 1;
	BSF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,258 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,259 :: 		if(1 == sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM37
;FIRMWARE_SYA_ver_1_3_0.c,260 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,261 :: 		}
	GOTO        L_FSM38
L_FSM37:
;FIRMWARE_SYA_ver_1_3_0.c,262 :: 		else if(1 == sn_PosEdge_2){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM39
;FIRMWARE_SYA_ver_1_3_0.c,263 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,264 :: 		}
	GOTO        L_FSM40
L_FSM39:
;FIRMWARE_SYA_ver_1_3_0.c,266 :: 		}
L_FSM40:
L_FSM38:
;FIRMWARE_SYA_ver_1_3_0.c,267 :: 		break;
	GOTO        L_FSM27
;FIRMWARE_SYA_ver_1_3_0.c,268 :: 		case s3:
L_FSM41:
;FIRMWARE_SYA_ver_1_3_0.c,269 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,270 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,271 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,272 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,273 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,274 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,275 :: 		if(1 == sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM42
;FIRMWARE_SYA_ver_1_3_0.c,276 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,277 :: 		}
	GOTO        L_FSM43
L_FSM42:
;FIRMWARE_SYA_ver_1_3_0.c,278 :: 		else if(1 == sn_PosEdge_2){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM44
;FIRMWARE_SYA_ver_1_3_0.c,279 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,280 :: 		}
	GOTO        L_FSM45
L_FSM44:
;FIRMWARE_SYA_ver_1_3_0.c,282 :: 		}
L_FSM45:
L_FSM43:
;FIRMWARE_SYA_ver_1_3_0.c,283 :: 		break;
	GOTO        L_FSM27
;FIRMWARE_SYA_ver_1_3_0.c,284 :: 		case s4:
L_FSM46:
;FIRMWARE_SYA_ver_1_3_0.c,285 :: 		if((1 == GT1) && (0 == GT2) && (0 == GT3)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM49
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM49
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM49
L__FSM129:
;FIRMWARE_SYA_ver_1_3_0.c,286 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,287 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,288 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,289 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,290 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,291 :: 		}
	GOTO        L_FSM50
L_FSM49:
;FIRMWARE_SYA_ver_1_3_0.c,292 :: 		else if((1 == GT2) && (0 == GT1) && (0 == GT3)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM53
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM53
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM53
L__FSM128:
;FIRMWARE_SYA_ver_1_3_0.c,293 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,294 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,295 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,296 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,297 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,298 :: 		}
	GOTO        L_FSM54
L_FSM53:
;FIRMWARE_SYA_ver_1_3_0.c,299 :: 		else if((1 == GT3) && (0 == GT1) && (0 == GT2)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM57
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM57
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM57
L__FSM127:
;FIRMWARE_SYA_ver_1_3_0.c,300 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,301 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,302 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,303 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,304 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,305 :: 		}
L_FSM57:
L_FSM54:
L_FSM50:
;FIRMWARE_SYA_ver_1_3_0.c,306 :: 		if(1 == sn_NegEdge_2){
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_FSM58
;FIRMWARE_SYA_ver_1_3_0.c,307 :: 		next_state = s7;
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,308 :: 		}
	GOTO        L_FSM59
L_FSM58:
;FIRMWARE_SYA_ver_1_3_0.c,309 :: 		else if(1 == sn_PosEdge_3){
	BTFSS       _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
	GOTO        L_FSM60
;FIRMWARE_SYA_ver_1_3_0.c,310 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,311 :: 		}
	GOTO        L_FSM61
L_FSM60:
;FIRMWARE_SYA_ver_1_3_0.c,313 :: 		}
L_FSM61:
L_FSM59:
;FIRMWARE_SYA_ver_1_3_0.c,314 :: 		break;
	GOTO        L_FSM27
;FIRMWARE_SYA_ver_1_3_0.c,315 :: 		case s5:
L_FSM62:
;FIRMWARE_SYA_ver_1_3_0.c,316 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,317 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,318 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,319 :: 		if(1 == sn_NegEdge_3){
	BTFSS       _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
	GOTO        L_FSM63
;FIRMWARE_SYA_ver_1_3_0.c,320 :: 		next_state = s6;
	MOVLW       6
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,321 :: 		}
	GOTO        L_FSM64
L_FSM63:
;FIRMWARE_SYA_ver_1_3_0.c,323 :: 		}
L_FSM64:
;FIRMWARE_SYA_ver_1_3_0.c,324 :: 		break;
	GOTO        L_FSM27
;FIRMWARE_SYA_ver_1_3_0.c,325 :: 		case s6:
L_FSM65:
;FIRMWARE_SYA_ver_1_3_0.c,326 :: 		if((1 == GT1) && (0 == GT2) && (0 == GT3)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM68
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM68
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM68
L__FSM126:
;FIRMWARE_SYA_ver_1_3_0.c,327 :: 		GT2 = 1;
	BSF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,328 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,329 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,330 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,331 :: 		}
	GOTO        L_FSM69
L_FSM68:
;FIRMWARE_SYA_ver_1_3_0.c,332 :: 		else if((1 == GT2) && (0 == GT1) && (0 == GT3)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM72
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM72
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM72
L__FSM125:
;FIRMWARE_SYA_ver_1_3_0.c,333 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,334 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,335 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,336 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,337 :: 		}
	GOTO        L_FSM73
L_FSM72:
;FIRMWARE_SYA_ver_1_3_0.c,338 :: 		else if((1 == GT3) && (0 == GT1) && (0 == GT2)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM76
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM76
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM76
L__FSM124:
;FIRMWARE_SYA_ver_1_3_0.c,339 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,340 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,341 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,342 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,343 :: 		}
	GOTO        L_FSM77
L_FSM76:
;FIRMWARE_SYA_ver_1_3_0.c,345 :: 		}
L_FSM77:
L_FSM73:
L_FSM69:
;FIRMWARE_SYA_ver_1_3_0.c,346 :: 		break;
	GOTO        L_FSM27
;FIRMWARE_SYA_ver_1_3_0.c,347 :: 		case s7:
L_FSM78:
;FIRMWARE_SYA_ver_1_3_0.c,348 :: 		clock0 = 0;
	CLRF        _clock0+0 
	CLRF        _clock0+1 
;FIRMWARE_SYA_ver_1_3_0.c,349 :: 		if((1 == GT1) && (0 == GT2) && (0 == GT3)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM81
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM81
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM81
L__FSM123:
;FIRMWARE_SYA_ver_1_3_0.c,350 :: 		next_state = s2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,351 :: 		}
	GOTO        L_FSM82
L_FSM81:
;FIRMWARE_SYA_ver_1_3_0.c,352 :: 		else if((1 == GT2) && (0 == GT1) && (0 == GT3)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM85
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM85
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM85
L__FSM122:
;FIRMWARE_SYA_ver_1_3_0.c,353 :: 		next_state = s3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,354 :: 		}
	GOTO        L_FSM86
L_FSM85:
;FIRMWARE_SYA_ver_1_3_0.c,355 :: 		else if((1 == GT3) && (0 == GT1) && (0 == GT2)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM89
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM89
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM89
L__FSM121:
;FIRMWARE_SYA_ver_1_3_0.c,356 :: 		next_state = s1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,357 :: 		}
L_FSM89:
L_FSM86:
L_FSM82:
;FIRMWARE_SYA_ver_1_3_0.c,358 :: 		break;
	GOTO        L_FSM27
;FIRMWARE_SYA_ver_1_3_0.c,359 :: 		default:
L_FSM90:
;FIRMWARE_SYA_ver_1_3_0.c,360 :: 		current_state = s0;
	CLRF        _current_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,361 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,362 :: 		break;
	GOTO        L_FSM27
;FIRMWARE_SYA_ver_1_3_0.c,363 :: 		}
L_FSM26:
	MOVF        _current_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM28
	MOVF        _current_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM31
	MOVF        _current_state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM36
	MOVF        _current_state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM41
	MOVF        _current_state+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM46
	MOVF        _current_state+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM62
	MOVF        _current_state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM65
	MOVF        _current_state+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM78
	GOTO        L_FSM90
L_FSM27:
;FIRMWARE_SYA_ver_1_3_0.c,365 :: 		}
L_end_FSM:
	RETURN      0
; end of _FSM

_Events:

;FIRMWARE_SYA_ver_1_3_0.c,371 :: 		void Events(){
;FIRMWARE_SYA_ver_1_3_0.c,372 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,373 :: 		sn_NegEdge_2 = 0;
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,374 :: 		sn_NegEdge_3 = 0;
	BCF         _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,375 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,376 :: 		sn_PosEdge_2 = 0;
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,377 :: 		sn_PosEdge_3 = 0;
	BCF         _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,421 :: 		switch(SWITCH1){
	GOTO        L_Events91
;FIRMWARE_SYA_ver_1_3_0.c,422 :: 		case 0:
L_Events93:
;FIRMWARE_SYA_ver_1_3_0.c,423 :: 		next_state = s1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,424 :: 		switch(SWITCH2){
	GOTO        L_Events94
;FIRMWARE_SYA_ver_1_3_0.c,425 :: 		case 0:
L_Events96:
;FIRMWARE_SYA_ver_1_3_0.c,426 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,427 :: 		switch(SWITCH3){
	GOTO        L_Events97
;FIRMWARE_SYA_ver_1_3_0.c,428 :: 		case 0:
L_Events99:
;FIRMWARE_SYA_ver_1_3_0.c,429 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,430 :: 		break;
	GOTO        L_Events98
;FIRMWARE_SYA_ver_1_3_0.c,431 :: 		case 1:
L_Events100:
;FIRMWARE_SYA_ver_1_3_0.c,432 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,433 :: 		break;
	GOTO        L_Events98
;FIRMWARE_SYA_ver_1_3_0.c,434 :: 		}
L_Events97:
	BTFSS       PORTC+0, 2 
	GOTO        L_Events99
	BTFSC       PORTC+0, 2 
	GOTO        L_Events100
L_Events98:
;FIRMWARE_SYA_ver_1_3_0.c,435 :: 		break;
	GOTO        L_Events95
;FIRMWARE_SYA_ver_1_3_0.c,436 :: 		case 1:
L_Events101:
;FIRMWARE_SYA_ver_1_3_0.c,437 :: 		switch(SWITCH3){
	GOTO        L_Events102
;FIRMWARE_SYA_ver_1_3_0.c,438 :: 		case 0:
L_Events104:
;FIRMWARE_SYA_ver_1_3_0.c,439 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,440 :: 		break;
	GOTO        L_Events103
;FIRMWARE_SYA_ver_1_3_0.c,441 :: 		case 1:
L_Events105:
;FIRMWARE_SYA_ver_1_3_0.c,442 :: 		next_state = s1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,443 :: 		break;
	GOTO        L_Events103
;FIRMWARE_SYA_ver_1_3_0.c,444 :: 		}
L_Events102:
	BTFSS       PORTC+0, 2 
	GOTO        L_Events104
	BTFSC       PORTC+0, 2 
	GOTO        L_Events105
L_Events103:
;FIRMWARE_SYA_ver_1_3_0.c,445 :: 		break;
	GOTO        L_Events95
;FIRMWARE_SYA_ver_1_3_0.c,446 :: 		}
L_Events94:
	BTFSS       PORTC+0, 1 
	GOTO        L_Events96
	BTFSC       PORTC+0, 1 
	GOTO        L_Events101
L_Events95:
;FIRMWARE_SYA_ver_1_3_0.c,447 :: 		break;
	GOTO        L_Events92
;FIRMWARE_SYA_ver_1_3_0.c,448 :: 		case 1:
L_Events106:
;FIRMWARE_SYA_ver_1_3_0.c,449 :: 		switch(SWITCH2){
	GOTO        L_Events107
;FIRMWARE_SYA_ver_1_3_0.c,450 :: 		case 0:
L_Events109:
;FIRMWARE_SYA_ver_1_3_0.c,451 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,452 :: 		switch(SWITCH3){
	GOTO        L_Events110
;FIRMWARE_SYA_ver_1_3_0.c,453 :: 		case 0:
L_Events112:
;FIRMWARE_SYA_ver_1_3_0.c,454 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,455 :: 		break;
	GOTO        L_Events111
;FIRMWARE_SYA_ver_1_3_0.c,456 :: 		case 1:
L_Events113:
;FIRMWARE_SYA_ver_1_3_0.c,457 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,458 :: 		break;
	GOTO        L_Events111
;FIRMWARE_SYA_ver_1_3_0.c,459 :: 		}
L_Events110:
	BTFSS       PORTC+0, 2 
	GOTO        L_Events112
	BTFSC       PORTC+0, 2 
	GOTO        L_Events113
L_Events111:
;FIRMWARE_SYA_ver_1_3_0.c,460 :: 		break;
	GOTO        L_Events108
;FIRMWARE_SYA_ver_1_3_0.c,461 :: 		case 1:
L_Events114:
;FIRMWARE_SYA_ver_1_3_0.c,462 :: 		switch(SWITCH3){
	GOTO        L_Events115
;FIRMWARE_SYA_ver_1_3_0.c,463 :: 		case 0:
L_Events117:
;FIRMWARE_SYA_ver_1_3_0.c,464 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,465 :: 		break;
	GOTO        L_Events116
;FIRMWARE_SYA_ver_1_3_0.c,466 :: 		case 1:
L_Events118:
;FIRMWARE_SYA_ver_1_3_0.c,467 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,468 :: 		break;
	GOTO        L_Events116
;FIRMWARE_SYA_ver_1_3_0.c,469 :: 		}
L_Events115:
	BTFSS       PORTC+0, 2 
	GOTO        L_Events117
	BTFSC       PORTC+0, 2 
	GOTO        L_Events118
L_Events116:
;FIRMWARE_SYA_ver_1_3_0.c,470 :: 		break;
	GOTO        L_Events108
;FIRMWARE_SYA_ver_1_3_0.c,471 :: 		}
L_Events107:
	BTFSS       PORTC+0, 1 
	GOTO        L_Events109
	BTFSC       PORTC+0, 1 
	GOTO        L_Events114
L_Events108:
;FIRMWARE_SYA_ver_1_3_0.c,472 :: 		break;
	GOTO        L_Events92
;FIRMWARE_SYA_ver_1_3_0.c,473 :: 		}
L_Events91:
	BTFSS       PORTC+0, 0 
	GOTO        L_Events93
	BTFSC       PORTC+0, 0 
	GOTO        L_Events106
L_Events92:
;FIRMWARE_SYA_ver_1_3_0.c,480 :: 		return;
;FIRMWARE_SYA_ver_1_3_0.c,482 :: 		}
L_end_Events:
	RETURN      0
; end of _Events

_InitSystems:

;FIRMWARE_SYA_ver_1_3_0.c,488 :: 		void InitSystems(){
;FIRMWARE_SYA_ver_1_3_0.c,489 :: 		Delay_ms(1000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_InitSystems119:
	DECFSZ      R13, 1, 1
	BRA         L_InitSystems119
	DECFSZ      R12, 1, 1
	BRA         L_InitSystems119
	DECFSZ      R11, 1, 1
	BRA         L_InitSystems119
	NOP
;FIRMWARE_SYA_ver_1_3_0.c,490 :: 		InitInterrupt();
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,491 :: 		InitMCU();
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,492 :: 		Delay_ms(1000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_InitSystems120:
	DECFSZ      R13, 1, 1
	BRA         L_InitSystems120
	DECFSZ      R12, 1, 1
	BRA         L_InitSystems120
	DECFSZ      R11, 1, 1
	BRA         L_InitSystems120
	NOP
;FIRMWARE_SYA_ver_1_3_0.c,493 :: 		Events();
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,494 :: 		}
L_end_InitSystems:
	RETURN      0
; end of _InitSystems

_InitInterrupt:

;FIRMWARE_SYA_ver_1_3_0.c,500 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_1_3_0.c,502 :: 		PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       48
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_1_3_0.c,503 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_1_3_0.c,505 :: 		T0CON0 = 0x90;
	MOVLW       144
	MOVWF       T0CON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,506 :: 		T0CON1 = 0x40;
	MOVLW       64
	MOVWF       T0CON1+0 
;FIRMWARE_SYA_ver_1_3_0.c,507 :: 		TMR0H = 0x3C;
	MOVLW       60
	MOVWF       TMR0H+0 
;FIRMWARE_SYA_ver_1_3_0.c,508 :: 		TMR0L = 0xB0;
	MOVLW       176
	MOVWF       TMR0L+0 
;FIRMWARE_SYA_ver_1_3_0.c,510 :: 		IOCCN = 0x07;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       7
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_1_3_0.c,511 :: 		IOCCP = 0x07;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
	MOVLW       7
	MOVWF       IOCCP+0 
;FIRMWARE_SYA_ver_1_3_0.c,512 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_1_3_0.c,513 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,515 :: 		PIE4 = 0x02;
	MOVLW       2
	MOVWF       PIE4+0 
;FIRMWARE_SYA_ver_1_3_0.c,516 :: 		PIR4 = 0x00;
	CLRF        PIR4+0 
;FIRMWARE_SYA_ver_1_3_0.c,518 :: 		T1CON = 0x03;   // ~7, ~6, ![5, 4], ~3, ~2, #1(RD16), #0(ON)
	MOVLW       3
	MOVWF       T1CON+0 
;FIRMWARE_SYA_ver_1_3_0.c,519 :: 		T1GCON = 0x00;  // !7, !6, !5, !4, !3, !2, ~1, ~0
	CLRF        T1GCON+0 
;FIRMWARE_SYA_ver_1_3_0.c,520 :: 		TMR1CLK = 0x01; // ~7, ~6, ~5, ~4, [!3, !2, !1, #0] = Fosc/4
	MOVLW       1
	MOVWF       TMR1CLK+0 
;FIRMWARE_SYA_ver_1_3_0.c,521 :: 		TMR1 = 0xEC78;   // Timer para
	MOVLW       120
	MOVWF       TMR1+0 
	MOVLW       236
	MOVWF       TMR1+1 
;FIRMWARE_SYA_ver_1_3_0.c,522 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_1_3_0.c,524 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_1_3_0.c,530 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_1_3_0.c,532 :: 		ADCON0 = 0x08; // Desactivamos ADC
	MOVLW       8
	MOVWF       ADCON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,533 :: 		ANSELC = 0x00;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_1_3_0.c,534 :: 		ANSELE = 0x00;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_1_3_0.c,535 :: 		ANSELA = 0x00;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_1_3_0.c,536 :: 		ANSELD = 0x00;
	CLRF        ANSELD+0 
;FIRMWARE_SYA_ver_1_3_0.c,538 :: 		TRISC = 0x0F;  // Ponemos en modo de entrada a C0, C1, c2 Y c3, los demas como salida
	MOVLW       15
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_1_3_0.c,539 :: 		TRISD = 0x07;  // Ponemos en modo de entrada a D0 y D1
	MOVLW       7
	MOVWF       TRISD+0 
;FIRMWARE_SYA_ver_1_3_0.c,540 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_1_3_0.c,541 :: 		TRISA = 0x80;  //                ''                A
	MOVLW       128
	MOVWF       TRISA+0 
;FIRMWARE_SYA_ver_1_3_0.c,543 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_1_3_0.c,544 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;FIRMWARE_SYA_ver_1_3_0.c,545 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_1_3_0.c,546 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_1_3_0.c,548 :: 		LATC = 0x07;   // Dejamos en cero el registro del puerto C
	MOVLW       7
	MOVWF       LATC+0 
;FIRMWARE_SYA_ver_1_3_0.c,549 :: 		LATD = 0x00;
	CLRF        LATD+0 
;FIRMWARE_SYA_ver_1_3_0.c,550 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_1_3_0.c,551 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_1_3_0.c,555 :: 		WPUD = 0x07;   // Activamos el pull-up interno de C0 y C1
	MOVLW       7
	MOVWF       WPUD+0 
;FIRMWARE_SYA_ver_1_3_0.c,556 :: 		INLVLD = 0x07; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       7
	MOVWF       INLVLD+0 
;FIRMWARE_SYA_ver_1_3_0.c,557 :: 		CM1CON0 = 0x00; // Desactivamos el comparador 1
	CLRF        CM1CON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,558 :: 		CM2CON0 = 0x00; // Desactivamos el comparador 2
	CLRF        CM2CON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,559 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,560 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,561 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,563 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
