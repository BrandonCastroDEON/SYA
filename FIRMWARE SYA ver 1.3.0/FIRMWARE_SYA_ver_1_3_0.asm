
_M1On:

;FIRMWARE_SYA_ver_1_3_0.c,90 :: 		void M1On(){M1 = 1;}
	BSF         LATA+0, 5 
L_end_M1On:
	RETURN      0
; end of _M1On

_M1Off:

;FIRMWARE_SYA_ver_1_3_0.c,91 :: 		void M1Off(){M1 = 0;}
	BCF         LATA+0, 5 
L_end_M1Off:
	RETURN      0
; end of _M1Off

_M2On:

;FIRMWARE_SYA_ver_1_3_0.c,92 :: 		void M2On(){M2 = 1;}
	BSF         LATE+0, 0 
L_end_M2On:
	RETURN      0
; end of _M2On

_M2Off:

;FIRMWARE_SYA_ver_1_3_0.c,93 :: 		void M2Off(){M2 = 0;}
	BCF         LATE+0, 0 
L_end_M2Off:
	RETURN      0
; end of _M2Off

_M3On:

;FIRMWARE_SYA_ver_1_3_0.c,94 :: 		void M3On(){M3 = 1;}
	BSF         LATE+0, 1 
L_end_M3On:
	RETURN      0
; end of _M3On

_M3Off:

;FIRMWARE_SYA_ver_1_3_0.c,95 :: 		void M3Off(){M3 = 0;}
	BCF         LATE+0, 1 
L_end_M3Off:
	RETURN      0
; end of _M3Off

_interrupt:

;FIRMWARE_SYA_ver_1_3_0.c,101 :: 		void interrupt(){
;FIRMWARE_SYA_ver_1_3_0.c,103 :: 		if(PIR0.TMR0IF){
	BTFSS       PIR0+0, 5 
	GOTO        L_interrupt0
;FIRMWARE_SYA_ver_1_3_0.c,104 :: 		TMR0H = 0x3C;      // Timer para cada segundo y medio?
	MOVLW       60
	MOVWF       TMR0H+0 
;FIRMWARE_SYA_ver_1_3_0.c,105 :: 		TMR0L = 0xB0;      //
	MOVLW       176
	MOVWF       TMR0L+0 
;FIRMWARE_SYA_ver_1_3_0.c,106 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,107 :: 		counter++;
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
;FIRMWARE_SYA_ver_1_3_0.c,108 :: 		if(counter >= 200){
	MOVLW       128
	XORWF       _counter+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt147
	MOVLW       200
	SUBWF       _counter+0, 0 
L__interrupt147:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt1
;FIRMWARE_SYA_ver_1_3_0.c,109 :: 		LED = ~LED;
	BTG         LATA+0, 4 
;FIRMWARE_SYA_ver_1_3_0.c,110 :: 		Events();
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,111 :: 		PIE0.TMR0IE = 0;
	BCF         PIE0+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,112 :: 		counter = 0;
	CLRF        _counter+0 
	CLRF        _counter+1 
;FIRMWARE_SYA_ver_1_3_0.c,113 :: 		}
L_interrupt1:
;FIRMWARE_SYA_ver_1_3_0.c,114 :: 		}
L_interrupt0:
;FIRMWARE_SYA_ver_1_3_0.c,115 :: 		if(PIR4.TMR1IF){
	BTFSS       PIR4+0, 0 
	GOTO        L_interrupt2
;FIRMWARE_SYA_ver_1_3_0.c,116 :: 		TMR1H = 0xEC;
	MOVLW       236
	MOVWF       TMR1H+0 
;FIRMWARE_SYA_ver_1_3_0.c,117 :: 		TMR1L = 0x78;
	MOVLW       120
	MOVWF       TMR1L+0 
;FIRMWARE_SYA_ver_1_3_0.c,118 :: 		PIR4.TMR1IF = 0;
	BCF         PIR4+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,119 :: 		counter1++;
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
;FIRMWARE_SYA_ver_1_3_0.c,120 :: 		if(counter1 >= 1000){
	MOVLW       128
	XORWF       _counter1+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt148
	MOVLW       232
	SUBWF       _counter1+0, 0 
L__interrupt148:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt3
;FIRMWARE_SYA_ver_1_3_0.c,121 :: 		M4 = ~M4;
	BTG         LATE+0, 2 
;FIRMWARE_SYA_ver_1_3_0.c,122 :: 		counter1 = 0;
	CLRF        _counter1+0 
	CLRF        _counter1+1 
;FIRMWARE_SYA_ver_1_3_0.c,123 :: 		}
L_interrupt3:
;FIRMWARE_SYA_ver_1_3_0.c,124 :: 		}
L_interrupt2:
;FIRMWARE_SYA_ver_1_3_0.c,125 :: 		if(1 == IOCCF.B0){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt4
;FIRMWARE_SYA_ver_1_3_0.c,126 :: 		IOCCF.B0 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,127 :: 		interruptC0 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	MOVLW       1
	MOVWF       _interruptC0+0 
	MOVLW       0
	MOVWF       _interruptC0+1 
;FIRMWARE_SYA_ver_1_3_0.c,128 :: 		Delay_ms(100);
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
;FIRMWARE_SYA_ver_1_3_0.c,129 :: 		if(1 == SWITCH1){
	BTFSS       PORTC+0, 0 
	GOTO        L_interrupt6
;FIRMWARE_SYA_ver_1_3_0.c,130 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,131 :: 		sn_NegEdge_1 = 1;
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,132 :: 		interruptC0 = 0;
	CLRF        _interruptC0+0 
	CLRF        _interruptC0+1 
;FIRMWARE_SYA_ver_1_3_0.c,133 :: 		}
	GOTO        L_interrupt7
L_interrupt6:
;FIRMWARE_SYA_ver_1_3_0.c,135 :: 		sn_GoToGT = 1;
	MOVLW       1
	MOVWF       _sn_GoToGT+0 
	MOVLW       0
	MOVWF       _sn_GoToGT+1 
;FIRMWARE_SYA_ver_1_3_0.c,136 :: 		sn_PosEdge_1 = 1;
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,137 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,138 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,139 :: 		interruptC0 = 0;
	CLRF        _interruptC0+0 
	CLRF        _interruptC0+1 
;FIRMWARE_SYA_ver_1_3_0.c,140 :: 		if(!SWITCH2){
	BTFSC       PORTC+0, 1 
	GOTO        L_interrupt8
;FIRMWARE_SYA_ver_1_3_0.c,141 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,142 :: 		if(!SWITCH3){
	BTFSC       PORTC+0, 2 
	GOTO        L_interrupt9
;FIRMWARE_SYA_ver_1_3_0.c,143 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,144 :: 		}
	GOTO        L_interrupt10
L_interrupt9:
;FIRMWARE_SYA_ver_1_3_0.c,146 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,147 :: 		}
L_interrupt10:
;FIRMWARE_SYA_ver_1_3_0.c,148 :: 		}
	GOTO        L_interrupt11
L_interrupt8:
;FIRMWARE_SYA_ver_1_3_0.c,150 :: 		next_state = s7;
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,151 :: 		if(!SWITCH3){
	BTFSC       PORTC+0, 2 
	GOTO        L_interrupt12
;FIRMWARE_SYA_ver_1_3_0.c,152 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,153 :: 		}
	GOTO        L_interrupt13
L_interrupt12:
;FIRMWARE_SYA_ver_1_3_0.c,155 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,156 :: 		}
L_interrupt13:
;FIRMWARE_SYA_ver_1_3_0.c,157 :: 		}
L_interrupt11:
;FIRMWARE_SYA_ver_1_3_0.c,158 :: 		}
L_interrupt7:
;FIRMWARE_SYA_ver_1_3_0.c,160 :: 		}
L_interrupt4:
;FIRMWARE_SYA_ver_1_3_0.c,162 :: 		if(1 == IOCCF.B1){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt14
;FIRMWARE_SYA_ver_1_3_0.c,163 :: 		IOCCF.B1 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,164 :: 		interruptC1 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	MOVLW       1
	MOVWF       _interruptC1+0 
	MOVLW       0
	MOVWF       _interruptC1+1 
;FIRMWARE_SYA_ver_1_3_0.c,165 :: 		Delay_ms(100);
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
;FIRMWARE_SYA_ver_1_3_0.c,166 :: 		if(1 == SWITCH2){
	BTFSS       PORTC+0, 1 
	GOTO        L_interrupt16
;FIRMWARE_SYA_ver_1_3_0.c,167 :: 		sn_PosEdge_2 = 0;
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,168 :: 		sn_NegEdge_2 = 1;
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,169 :: 		interruptC1 = 0;
	CLRF        _interruptC1+0 
	CLRF        _interruptC1+1 
;FIRMWARE_SYA_ver_1_3_0.c,170 :: 		if(!SWITCH1){
	BTFSC       PORTC+0, 0 
	GOTO        L_interrupt17
;FIRMWARE_SYA_ver_1_3_0.c,171 :: 		sn_GoToGT = 1;
	MOVLW       1
	MOVWF       _sn_GoToGT+0 
	MOVLW       0
	MOVWF       _sn_GoToGT+1 
;FIRMWARE_SYA_ver_1_3_0.c,172 :: 		}
L_interrupt17:
;FIRMWARE_SYA_ver_1_3_0.c,173 :: 		}
	GOTO        L_interrupt18
L_interrupt16:
;FIRMWARE_SYA_ver_1_3_0.c,175 :: 		sn_PosEdge_2 = 1;
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,176 :: 		sn_NegEdge_2 = 0;
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,177 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,178 :: 		interruptC1 = 0;
	CLRF        _interruptC1+0 
	CLRF        _interruptC1+1 
;FIRMWARE_SYA_ver_1_3_0.c,179 :: 		if(!SWITCH3){
	BTFSC       PORTC+0, 2 
	GOTO        L_interrupt19
;FIRMWARE_SYA_ver_1_3_0.c,180 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,181 :: 		}
	GOTO        L_interrupt20
L_interrupt19:
;FIRMWARE_SYA_ver_1_3_0.c,183 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,184 :: 		}
L_interrupt20:
;FIRMWARE_SYA_ver_1_3_0.c,185 :: 		}
L_interrupt18:
;FIRMWARE_SYA_ver_1_3_0.c,187 :: 		}
L_interrupt14:
;FIRMWARE_SYA_ver_1_3_0.c,189 :: 		if(1 == IOCCF.B2){
	BTFSS       IOCCF+0, 2 
	GOTO        L_interrupt21
;FIRMWARE_SYA_ver_1_3_0.c,190 :: 		IOCCF.B2 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 2 
;FIRMWARE_SYA_ver_1_3_0.c,191 :: 		interruptC2 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	MOVLW       1
	MOVWF       _interruptC2+0 
	MOVLW       0
	MOVWF       _interruptC2+1 
;FIRMWARE_SYA_ver_1_3_0.c,192 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_interrupt22:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt22
	DECFSZ      R12, 1, 1
	BRA         L_interrupt22
	DECFSZ      R11, 1, 1
	BRA         L_interrupt22
	NOP
	NOP
;FIRMWARE_SYA_ver_1_3_0.c,193 :: 		if(1 == SWITCH3){
	BTFSS       PORTC+0, 2 
	GOTO        L_interrupt23
;FIRMWARE_SYA_ver_1_3_0.c,194 :: 		sn_PosEdge_3 = 0;
	BCF         _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,195 :: 		sn_NegEdge_3 = 1;
	BSF         _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,196 :: 		interruptC2 = 0;
	CLRF        _interruptC2+0 
	CLRF        _interruptC2+1 
;FIRMWARE_SYA_ver_1_3_0.c,197 :: 		if(!SWITCH1){
	BTFSC       PORTC+0, 0 
	GOTO        L_interrupt24
;FIRMWARE_SYA_ver_1_3_0.c,198 :: 		sn_GoToGT = 1;
	MOVLW       1
	MOVWF       _sn_GoToGT+0 
	MOVLW       0
	MOVWF       _sn_GoToGT+1 
;FIRMWARE_SYA_ver_1_3_0.c,199 :: 		sn_error = 1;
	MOVLW       1
	MOVWF       _sn_error+0 
	MOVLW       0
	MOVWF       _sn_error+1 
;FIRMWARE_SYA_ver_1_3_0.c,200 :: 		}
L_interrupt24:
;FIRMWARE_SYA_ver_1_3_0.c,201 :: 		if(!SWITCH2){
	BTFSC       PORTC+0, 1 
	GOTO        L_interrupt25
;FIRMWARE_SYA_ver_1_3_0.c,202 :: 		sn_GoTo = 1;
	MOVLW       1
	MOVWF       _sn_GoTo+0 
	MOVLW       0
	MOVWF       _sn_GoTo+1 
;FIRMWARE_SYA_ver_1_3_0.c,203 :: 		}
L_interrupt25:
;FIRMWARE_SYA_ver_1_3_0.c,204 :: 		}
	GOTO        L_interrupt26
L_interrupt23:
;FIRMWARE_SYA_ver_1_3_0.c,206 :: 		sn_PosEdge_3 = 1;
	BSF         _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,207 :: 		sn_NegEdge_3 = 0;
	BCF         _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,208 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,209 :: 		interruptC2 = 0;
	CLRF        _interruptC2+0 
	CLRF        _interruptC2+1 
;FIRMWARE_SYA_ver_1_3_0.c,210 :: 		}
L_interrupt26:
;FIRMWARE_SYA_ver_1_3_0.c,212 :: 		}
L_interrupt21:
;FIRMWARE_SYA_ver_1_3_0.c,214 :: 		}
L_end_interrupt:
L__interrupt146:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_1_3_0.c,220 :: 		void main(){
;FIRMWARE_SYA_ver_1_3_0.c,222 :: 		InitSystems();
	CALL        _InitSystems+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,224 :: 		while(1){
L_main27:
;FIRMWARE_SYA_ver_1_3_0.c,226 :: 		current_state = next_state; // Maybe move this with Events
	MOVF        _next_state+0, 0 
	MOVWF       _current_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,227 :: 		FSM();
	CALL        _FSM+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,228 :: 		}
	GOTO        L_main27
;FIRMWARE_SYA_ver_1_3_0.c,230 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_FSM:

;FIRMWARE_SYA_ver_1_3_0.c,236 :: 		void FSM(){
;FIRMWARE_SYA_ver_1_3_0.c,237 :: 		switch(current_state){
	GOTO        L_FSM29
;FIRMWARE_SYA_ver_1_3_0.c,238 :: 		case s0:
L_FSM31:
;FIRMWARE_SYA_ver_1_3_0.c,239 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,240 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,241 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,243 :: 		if(1 == sn_PosEdge_1){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM32
;FIRMWARE_SYA_ver_1_3_0.c,244 :: 		next_state = s7;
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,245 :: 		}
	GOTO        L_FSM33
L_FSM32:
;FIRMWARE_SYA_ver_1_3_0.c,247 :: 		}
L_FSM33:
;FIRMWARE_SYA_ver_1_3_0.c,248 :: 		break;
	GOTO        L_FSM30
;FIRMWARE_SYA_ver_1_3_0.c,249 :: 		case s1:
L_FSM34:
;FIRMWARE_SYA_ver_1_3_0.c,250 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,251 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,252 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,253 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,254 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,255 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,256 :: 		if(1 == sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM35
;FIRMWARE_SYA_ver_1_3_0.c,258 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,259 :: 		}
	GOTO        L_FSM36
L_FSM35:
;FIRMWARE_SYA_ver_1_3_0.c,260 :: 		else if(1 == sn_PosEdge_2){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM37
;FIRMWARE_SYA_ver_1_3_0.c,261 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,262 :: 		}
	GOTO        L_FSM38
L_FSM37:
;FIRMWARE_SYA_ver_1_3_0.c,264 :: 		}
L_FSM38:
L_FSM36:
;FIRMWARE_SYA_ver_1_3_0.c,265 :: 		break;
	GOTO        L_FSM30
;FIRMWARE_SYA_ver_1_3_0.c,266 :: 		case s2:
L_FSM39:
;FIRMWARE_SYA_ver_1_3_0.c,267 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,268 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,269 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,270 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,271 :: 		GT2 = 1;
	BSF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,272 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,273 :: 		if(1 == sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM40
;FIRMWARE_SYA_ver_1_3_0.c,274 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,275 :: 		}
	GOTO        L_FSM41
L_FSM40:
;FIRMWARE_SYA_ver_1_3_0.c,276 :: 		else if(1 == sn_PosEdge_2){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM42
;FIRMWARE_SYA_ver_1_3_0.c,277 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,278 :: 		}
	GOTO        L_FSM43
L_FSM42:
;FIRMWARE_SYA_ver_1_3_0.c,280 :: 		}
L_FSM43:
L_FSM41:
;FIRMWARE_SYA_ver_1_3_0.c,281 :: 		break;
	GOTO        L_FSM30
;FIRMWARE_SYA_ver_1_3_0.c,282 :: 		case s3:
L_FSM44:
;FIRMWARE_SYA_ver_1_3_0.c,283 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,284 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,285 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,286 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,287 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,288 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,289 :: 		if(1 == sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM45
;FIRMWARE_SYA_ver_1_3_0.c,290 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,291 :: 		}
	GOTO        L_FSM46
L_FSM45:
;FIRMWARE_SYA_ver_1_3_0.c,292 :: 		else if(1 == sn_PosEdge_2){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM47
;FIRMWARE_SYA_ver_1_3_0.c,293 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,294 :: 		}
	GOTO        L_FSM48
L_FSM47:
;FIRMWARE_SYA_ver_1_3_0.c,296 :: 		}
L_FSM48:
L_FSM46:
;FIRMWARE_SYA_ver_1_3_0.c,297 :: 		break;
	GOTO        L_FSM30
;FIRMWARE_SYA_ver_1_3_0.c,298 :: 		case s4:
L_FSM49:
;FIRMWARE_SYA_ver_1_3_0.c,299 :: 		sn_GoTo = 1;
	MOVLW       1
	MOVWF       _sn_GoTo+0 
	MOVLW       0
	MOVWF       _sn_GoTo+1 
;FIRMWARE_SYA_ver_1_3_0.c,300 :: 		if((1 == GT1) && (0 == GT2) && (0 == GT3)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM52
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM52
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM52
L__FSM138:
;FIRMWARE_SYA_ver_1_3_0.c,301 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,302 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,303 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,304 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,305 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,306 :: 		}
	GOTO        L_FSM53
L_FSM52:
;FIRMWARE_SYA_ver_1_3_0.c,307 :: 		else if((1 == GT2) && (0 == GT1) && (0 == GT3)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM56
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM56
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM56
L__FSM137:
;FIRMWARE_SYA_ver_1_3_0.c,308 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,309 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,310 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,311 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,312 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,313 :: 		}
	GOTO        L_FSM57
L_FSM56:
;FIRMWARE_SYA_ver_1_3_0.c,314 :: 		else if((1 == GT3) && (0 == GT1) && (0 == GT2)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM60
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM60
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM60
L__FSM136:
;FIRMWARE_SYA_ver_1_3_0.c,315 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,316 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,317 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,318 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,319 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,320 :: 		}
L_FSM60:
L_FSM57:
L_FSM53:
;FIRMWARE_SYA_ver_1_3_0.c,321 :: 		if(1 == sn_NegEdge_2){
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_FSM61
;FIRMWARE_SYA_ver_1_3_0.c,322 :: 		next_state = s7;
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,323 :: 		}
	GOTO        L_FSM62
L_FSM61:
;FIRMWARE_SYA_ver_1_3_0.c,324 :: 		else if(1 == sn_PosEdge_3){
	BTFSS       _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
	GOTO        L_FSM63
;FIRMWARE_SYA_ver_1_3_0.c,325 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,326 :: 		}
	GOTO        L_FSM64
L_FSM63:
;FIRMWARE_SYA_ver_1_3_0.c,328 :: 		}
L_FSM64:
L_FSM62:
;FIRMWARE_SYA_ver_1_3_0.c,329 :: 		break;
	GOTO        L_FSM30
;FIRMWARE_SYA_ver_1_3_0.c,330 :: 		case s5:
L_FSM65:
;FIRMWARE_SYA_ver_1_3_0.c,331 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,332 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,333 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,334 :: 		if(1 == sn_NegEdge_3){
	BTFSS       _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
	GOTO        L_FSM66
;FIRMWARE_SYA_ver_1_3_0.c,335 :: 		next_state = s6;
	MOVLW       6
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,336 :: 		}
	GOTO        L_FSM67
L_FSM66:
;FIRMWARE_SYA_ver_1_3_0.c,338 :: 		}
L_FSM67:
;FIRMWARE_SYA_ver_1_3_0.c,339 :: 		break;
	GOTO        L_FSM30
;FIRMWARE_SYA_ver_1_3_0.c,340 :: 		case s6:
L_FSM68:
;FIRMWARE_SYA_ver_1_3_0.c,341 :: 		if(sn_GoTo){
	MOVF        _sn_GoTo+0, 0 
	IORWF       _sn_GoTo+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM69
;FIRMWARE_SYA_ver_1_3_0.c,342 :: 		if((1 == GT1) && (0 == GT2) && (0 == GT3)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM72
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM72
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM72
L__FSM135:
;FIRMWARE_SYA_ver_1_3_0.c,343 :: 		GT2 = 1;
	BSF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,344 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,345 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,346 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,347 :: 		}
	GOTO        L_FSM73
L_FSM72:
;FIRMWARE_SYA_ver_1_3_0.c,348 :: 		else if((1 == GT2) && (0 == GT1) && (0 == GT3)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM76
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM76
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM76
L__FSM134:
;FIRMWARE_SYA_ver_1_3_0.c,349 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,350 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,351 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,352 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,353 :: 		}
	GOTO        L_FSM77
L_FSM76:
;FIRMWARE_SYA_ver_1_3_0.c,354 :: 		else if((1 == GT3) && (0 == GT1) && (0 == GT2)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM80
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM80
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM80
L__FSM133:
;FIRMWARE_SYA_ver_1_3_0.c,355 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,356 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,357 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,358 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,359 :: 		}
	GOTO        L_FSM81
L_FSM80:
;FIRMWARE_SYA_ver_1_3_0.c,361 :: 		}
L_FSM81:
L_FSM77:
L_FSM73:
;FIRMWARE_SYA_ver_1_3_0.c,362 :: 		}
	GOTO        L_FSM82
L_FSM69:
;FIRMWARE_SYA_ver_1_3_0.c,363 :: 		else if(sn_error){
	MOVF        _sn_error+0, 0 
	IORWF       _sn_error+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM83
;FIRMWARE_SYA_ver_1_3_0.c,364 :: 		next_state = s7;
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,365 :: 		}
	GOTO        L_FSM84
L_FSM83:
;FIRMWARE_SYA_ver_1_3_0.c,367 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,368 :: 		}
L_FSM84:
L_FSM82:
;FIRMWARE_SYA_ver_1_3_0.c,369 :: 		break;
	GOTO        L_FSM30
;FIRMWARE_SYA_ver_1_3_0.c,370 :: 		case s7:
L_FSM85:
;FIRMWARE_SYA_ver_1_3_0.c,371 :: 		clock0 = 0;
	CLRF        _clock0+0 
	CLRF        _clock0+1 
;FIRMWARE_SYA_ver_1_3_0.c,372 :: 		if(sn_GoToGT){
	MOVF        _sn_GoToGT+0, 0 
	IORWF       _sn_GoToGT+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM86
;FIRMWARE_SYA_ver_1_3_0.c,373 :: 		if((1 == GT1) && (0 == GT2) && (0 == GT3)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM89
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM89
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM89
L__FSM132:
;FIRMWARE_SYA_ver_1_3_0.c,374 :: 		next_state = s2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,375 :: 		}
	GOTO        L_FSM90
L_FSM89:
;FIRMWARE_SYA_ver_1_3_0.c,376 :: 		else if((1 == GT2) && (0 == GT1) && (0 == GT3)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM93
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM93
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM93
L__FSM131:
;FIRMWARE_SYA_ver_1_3_0.c,377 :: 		next_state = s3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,378 :: 		}
	GOTO        L_FSM94
L_FSM93:
;FIRMWARE_SYA_ver_1_3_0.c,379 :: 		else if((1 == GT3) && (0 == GT1) && (0 == GT2)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM97
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM97
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM97
L__FSM130:
;FIRMWARE_SYA_ver_1_3_0.c,380 :: 		next_state = s1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,381 :: 		}
L_FSM97:
L_FSM94:
L_FSM90:
;FIRMWARE_SYA_ver_1_3_0.c,382 :: 		}
	GOTO        L_FSM98
L_FSM86:
;FIRMWARE_SYA_ver_1_3_0.c,384 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,385 :: 		}
L_FSM98:
;FIRMWARE_SYA_ver_1_3_0.c,386 :: 		break;
	GOTO        L_FSM30
;FIRMWARE_SYA_ver_1_3_0.c,387 :: 		default:
L_FSM99:
;FIRMWARE_SYA_ver_1_3_0.c,388 :: 		current_state = s0;
	CLRF        _current_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,389 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,390 :: 		break;
	GOTO        L_FSM30
;FIRMWARE_SYA_ver_1_3_0.c,391 :: 		}
L_FSM29:
	MOVF        _current_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM31
	MOVF        _current_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM34
	MOVF        _current_state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM39
	MOVF        _current_state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM44
	MOVF        _current_state+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM49
	MOVF        _current_state+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM65
	MOVF        _current_state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM68
	MOVF        _current_state+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM85
	GOTO        L_FSM99
L_FSM30:
;FIRMWARE_SYA_ver_1_3_0.c,393 :: 		}
L_end_FSM:
	RETURN      0
; end of _FSM

_Events:

;FIRMWARE_SYA_ver_1_3_0.c,399 :: 		void Events(){
;FIRMWARE_SYA_ver_1_3_0.c,400 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,401 :: 		sn_NegEdge_2 = 0;
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,402 :: 		sn_NegEdge_3 = 0;
	BCF         _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,403 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,404 :: 		sn_PosEdge_2 = 0;
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,405 :: 		sn_PosEdge_3 = 0;
	BCF         _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,449 :: 		switch(SWITCH1){
	GOTO        L_Events100
;FIRMWARE_SYA_ver_1_3_0.c,450 :: 		case 0:
L_Events102:
;FIRMWARE_SYA_ver_1_3_0.c,451 :: 		next_state = s1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,452 :: 		switch(SWITCH2){
	GOTO        L_Events103
;FIRMWARE_SYA_ver_1_3_0.c,453 :: 		case 0:
L_Events105:
;FIRMWARE_SYA_ver_1_3_0.c,454 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,455 :: 		switch(SWITCH3){
	GOTO        L_Events106
;FIRMWARE_SYA_ver_1_3_0.c,456 :: 		case 0:
L_Events108:
;FIRMWARE_SYA_ver_1_3_0.c,457 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,458 :: 		break;
	GOTO        L_Events107
;FIRMWARE_SYA_ver_1_3_0.c,459 :: 		case 1:
L_Events109:
;FIRMWARE_SYA_ver_1_3_0.c,460 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,461 :: 		break;
	GOTO        L_Events107
;FIRMWARE_SYA_ver_1_3_0.c,462 :: 		}
L_Events106:
	BTFSS       PORTC+0, 2 
	GOTO        L_Events108
	BTFSC       PORTC+0, 2 
	GOTO        L_Events109
L_Events107:
;FIRMWARE_SYA_ver_1_3_0.c,463 :: 		break;
	GOTO        L_Events104
;FIRMWARE_SYA_ver_1_3_0.c,464 :: 		case 1:
L_Events110:
;FIRMWARE_SYA_ver_1_3_0.c,465 :: 		switch(SWITCH3){
	GOTO        L_Events111
;FIRMWARE_SYA_ver_1_3_0.c,466 :: 		case 0:
L_Events113:
;FIRMWARE_SYA_ver_1_3_0.c,467 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,468 :: 		break;
	GOTO        L_Events112
;FIRMWARE_SYA_ver_1_3_0.c,469 :: 		case 1:
L_Events114:
;FIRMWARE_SYA_ver_1_3_0.c,470 :: 		next_state = s1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,471 :: 		break;
	GOTO        L_Events112
;FIRMWARE_SYA_ver_1_3_0.c,472 :: 		}
L_Events111:
	BTFSS       PORTC+0, 2 
	GOTO        L_Events113
	BTFSC       PORTC+0, 2 
	GOTO        L_Events114
L_Events112:
;FIRMWARE_SYA_ver_1_3_0.c,473 :: 		break;
	GOTO        L_Events104
;FIRMWARE_SYA_ver_1_3_0.c,474 :: 		}
L_Events103:
	BTFSS       PORTC+0, 1 
	GOTO        L_Events105
	BTFSC       PORTC+0, 1 
	GOTO        L_Events110
L_Events104:
;FIRMWARE_SYA_ver_1_3_0.c,475 :: 		break;
	GOTO        L_Events101
;FIRMWARE_SYA_ver_1_3_0.c,476 :: 		case 1:
L_Events115:
;FIRMWARE_SYA_ver_1_3_0.c,477 :: 		switch(SWITCH2){
	GOTO        L_Events116
;FIRMWARE_SYA_ver_1_3_0.c,478 :: 		case 0:
L_Events118:
;FIRMWARE_SYA_ver_1_3_0.c,479 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,480 :: 		switch(SWITCH3){
	GOTO        L_Events119
;FIRMWARE_SYA_ver_1_3_0.c,481 :: 		case 0:
L_Events121:
;FIRMWARE_SYA_ver_1_3_0.c,482 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,483 :: 		break;
	GOTO        L_Events120
;FIRMWARE_SYA_ver_1_3_0.c,484 :: 		case 1:
L_Events122:
;FIRMWARE_SYA_ver_1_3_0.c,485 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,486 :: 		break;
	GOTO        L_Events120
;FIRMWARE_SYA_ver_1_3_0.c,487 :: 		}
L_Events119:
	BTFSS       PORTC+0, 2 
	GOTO        L_Events121
	BTFSC       PORTC+0, 2 
	GOTO        L_Events122
L_Events120:
;FIRMWARE_SYA_ver_1_3_0.c,488 :: 		break;
	GOTO        L_Events117
;FIRMWARE_SYA_ver_1_3_0.c,489 :: 		case 1:
L_Events123:
;FIRMWARE_SYA_ver_1_3_0.c,490 :: 		switch(SWITCH3){
	GOTO        L_Events124
;FIRMWARE_SYA_ver_1_3_0.c,491 :: 		case 0:
L_Events126:
;FIRMWARE_SYA_ver_1_3_0.c,492 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,493 :: 		break;
	GOTO        L_Events125
;FIRMWARE_SYA_ver_1_3_0.c,494 :: 		case 1:
L_Events127:
;FIRMWARE_SYA_ver_1_3_0.c,495 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,496 :: 		break;
	GOTO        L_Events125
;FIRMWARE_SYA_ver_1_3_0.c,497 :: 		}
L_Events124:
	BTFSS       PORTC+0, 2 
	GOTO        L_Events126
	BTFSC       PORTC+0, 2 
	GOTO        L_Events127
L_Events125:
;FIRMWARE_SYA_ver_1_3_0.c,498 :: 		break;
	GOTO        L_Events117
;FIRMWARE_SYA_ver_1_3_0.c,499 :: 		}
L_Events116:
	BTFSS       PORTC+0, 1 
	GOTO        L_Events118
	BTFSC       PORTC+0, 1 
	GOTO        L_Events123
L_Events117:
;FIRMWARE_SYA_ver_1_3_0.c,500 :: 		break;
	GOTO        L_Events101
;FIRMWARE_SYA_ver_1_3_0.c,501 :: 		}
L_Events100:
	BTFSS       PORTC+0, 0 
	GOTO        L_Events102
	BTFSC       PORTC+0, 0 
	GOTO        L_Events115
L_Events101:
;FIRMWARE_SYA_ver_1_3_0.c,508 :: 		return;
;FIRMWARE_SYA_ver_1_3_0.c,510 :: 		}
L_end_Events:
	RETURN      0
; end of _Events

_InitSystems:

;FIRMWARE_SYA_ver_1_3_0.c,516 :: 		void InitSystems(){
;FIRMWARE_SYA_ver_1_3_0.c,517 :: 		Delay_ms(1000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_InitSystems128:
	DECFSZ      R13, 1, 1
	BRA         L_InitSystems128
	DECFSZ      R12, 1, 1
	BRA         L_InitSystems128
	DECFSZ      R11, 1, 1
	BRA         L_InitSystems128
	NOP
;FIRMWARE_SYA_ver_1_3_0.c,518 :: 		InitInterrupt();
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,519 :: 		InitMCU();
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,520 :: 		Delay_ms(1000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_InitSystems129:
	DECFSZ      R13, 1, 1
	BRA         L_InitSystems129
	DECFSZ      R12, 1, 1
	BRA         L_InitSystems129
	DECFSZ      R11, 1, 1
	BRA         L_InitSystems129
	NOP
;FIRMWARE_SYA_ver_1_3_0.c,521 :: 		Events();
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,522 :: 		}
L_end_InitSystems:
	RETURN      0
; end of _InitSystems

_InitInterrupt:

;FIRMWARE_SYA_ver_1_3_0.c,528 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_1_3_0.c,530 :: 		PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       48
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_1_3_0.c,531 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_1_3_0.c,533 :: 		T0CON0 = 0x90;
	MOVLW       144
	MOVWF       T0CON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,534 :: 		T0CON1 = 0x40;
	MOVLW       64
	MOVWF       T0CON1+0 
;FIRMWARE_SYA_ver_1_3_0.c,535 :: 		TMR0H = 0x3C;
	MOVLW       60
	MOVWF       TMR0H+0 
;FIRMWARE_SYA_ver_1_3_0.c,536 :: 		TMR0L = 0xB0;
	MOVLW       176
	MOVWF       TMR0L+0 
;FIRMWARE_SYA_ver_1_3_0.c,538 :: 		IOCCN = 0x07;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       7
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_1_3_0.c,539 :: 		IOCCP = 0x07;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
	MOVLW       7
	MOVWF       IOCCP+0 
;FIRMWARE_SYA_ver_1_3_0.c,540 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_1_3_0.c,541 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,543 :: 		PIE4 = 0x02;
	MOVLW       2
	MOVWF       PIE4+0 
;FIRMWARE_SYA_ver_1_3_0.c,544 :: 		PIR4 = 0x00;
	CLRF        PIR4+0 
;FIRMWARE_SYA_ver_1_3_0.c,546 :: 		T1CON = 0x03;   // ~7, ~6, ![5, 4], ~3, ~2, #1(RD16), #0(ON)
	MOVLW       3
	MOVWF       T1CON+0 
;FIRMWARE_SYA_ver_1_3_0.c,547 :: 		T1GCON = 0x00;  // !7, !6, !5, !4, !3, !2, ~1, ~0
	CLRF        T1GCON+0 
;FIRMWARE_SYA_ver_1_3_0.c,548 :: 		TMR1CLK = 0x01; // ~7, ~6, ~5, ~4, [!3, !2, !1, #0] = Fosc/4
	MOVLW       1
	MOVWF       TMR1CLK+0 
;FIRMWARE_SYA_ver_1_3_0.c,549 :: 		TMR1 = 0xEC78;   // Timer para
	MOVLW       120
	MOVWF       TMR1+0 
	MOVLW       236
	MOVWF       TMR1+1 
;FIRMWARE_SYA_ver_1_3_0.c,550 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_1_3_0.c,552 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_1_3_0.c,558 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_1_3_0.c,560 :: 		ADCON0 = 0x08; // Desactivamos ADC
	MOVLW       8
	MOVWF       ADCON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,561 :: 		ANSELC = 0x00;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_1_3_0.c,562 :: 		ANSELE = 0x00;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_1_3_0.c,563 :: 		ANSELA = 0x00;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_1_3_0.c,564 :: 		ANSELD = 0x00;
	CLRF        ANSELD+0 
;FIRMWARE_SYA_ver_1_3_0.c,566 :: 		TRISC = 0x0F;  // Ponemos en modo de entrada a C0, C1, c2 Y c3, los demas como salida
	MOVLW       15
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_1_3_0.c,567 :: 		TRISD = 0x07;  // Ponemos en modo de entrada a D0 y D1
	MOVLW       7
	MOVWF       TRISD+0 
;FIRMWARE_SYA_ver_1_3_0.c,568 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_1_3_0.c,569 :: 		TRISA = 0x80;  //                ''                A
	MOVLW       128
	MOVWF       TRISA+0 
;FIRMWARE_SYA_ver_1_3_0.c,571 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_1_3_0.c,572 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;FIRMWARE_SYA_ver_1_3_0.c,573 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_1_3_0.c,574 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_1_3_0.c,576 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_1_3_0.c,577 :: 		LATD = 0x00;
	CLRF        LATD+0 
;FIRMWARE_SYA_ver_1_3_0.c,578 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_1_3_0.c,579 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_1_3_0.c,583 :: 		WPUD = 0x07;   // Activamos el pull-up interno de C0 y C1
	MOVLW       7
	MOVWF       WPUD+0 
;FIRMWARE_SYA_ver_1_3_0.c,584 :: 		INLVLD = 0x07; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       7
	MOVWF       INLVLD+0 
;FIRMWARE_SYA_ver_1_3_0.c,585 :: 		CM1CON0 = 0x00; // Desactivamos el comparador 1
	CLRF        CM1CON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,586 :: 		CM2CON0 = 0x00; // Desactivamos el comparador 2
	CLRF        CM2CON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,587 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,588 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,589 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,591 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
