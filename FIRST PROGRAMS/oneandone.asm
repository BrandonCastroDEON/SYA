
_main:

	CLRF        ANSELA+0 
	CLRF        ANSELC+0 
	CLRF        ANSELE+0 
	MOVLW       3
	MOVWF       TRISC+0 
	CLRF        TRISE+0 
	CLRF        TRISA+0 
	CLRF        PORTA+0 
	CLRF        PORTE+0 
	CLRF        PORTC+0 
	CLRF        LATC+0 
	CLRF        LATE+0 
	CLRF        LATA+0 
	MOVLW       1
	MOVWF       _AR1+0 
	CLRF        _AR2+0 
L_main0:
	MOVLW       255
	SUBWF       _AR2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main2
	BSF         _OF+0, BitPos(_OF+0) 
	MOVLW       1
	MOVWF       _AR1+0 
	CLRF        _AR2+0 
	GOTO        L_main3
L_main2:
	BCF         _OF+0, BitPos(_OF+0) 
L_main3:
	BTFSC       RC0_bit+0, BitPos(RC0_bit+0) 
	GOTO        L_main4
	BSF         _Flag01+0, BitPos(_Flag01+0) 
	BSF         RA4_bit+0, BitPos(RA4_bit+0) 
	GOTO        L_main5
L_main4:
	BCF         _Flag01+0, BitPos(_Flag01+0) 
L_main5:
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	DECFSZ      R11, 1, 1
	BRA         L_main6
	NOP
	NOP
L_main7:
	BTFSS       _Flag01+0, BitPos(_Flag01+0) 
	GOTO        L_main9
	MOVLW       2
	MOVWF       LATE+0 
	INCF        _AR2+0, 1 
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main10:
	DECFSZ      R13, 1, 1
	BRA         L_main10
	DECFSZ      R12, 1, 1
	BRA         L_main10
	DECFSZ      R11, 1, 1
	BRA         L_main10
	NOP
	NOP
	GOTO        L_main11
L_main9:
	BTFSS       _Flag01+0, BitPos(_Flag01+0) 
	GOTO        L_main14
	MOVF        _AR2+0, 0 
	SUBWF       _AR1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main14
L__main17:
	MOVLW       1
	MOVWF       LATE+0 
	INCF        _AR1+0, 1 
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main15:
	DECFSZ      R13, 1, 1
	BRA         L_main15
	DECFSZ      R12, 1, 1
	BRA         L_main15
	DECFSZ      R11, 1, 1
	BRA         L_main15
	NOP
	NOP
	GOTO        L_main16
L_main14:
	CLRF        LATE+0 
	BSF         RA4_bit+0, BitPos(RA4_bit+0) 
L_main16:
L_main11:
	GOTO        L_main7
L_end_main:
	GOTO        $+0
; end of _main
