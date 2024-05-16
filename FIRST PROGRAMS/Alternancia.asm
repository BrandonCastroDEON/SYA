
_main:

	MOVLW       15
	MOVWF       ADCON1+0 
	MOVLW       3
	MOVWF       TRISC+0 
	CLRF        TRISE+0 
	CLRF        PORTC+0 
	CLRF        PORTE+0 
	CLRF        LATC+0 
	CLRF        LATE+0 
L_main0:
	MOVLW       PORTC+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTC+0)
	MOVWF       FARG_Button_port+1 
	CLRF        FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	MOVLW       1
	MOVWF       FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main3
	BSF         _Flag01+0, BitPos(_Flag01+0) 
L_main3:
	MOVLW       PORTC+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTC+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       1
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	MOVLW       1
	MOVWF       FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main4
	BSF         _Flag02+0, BitPos(_Flag02+0) 
L_main4:
	BTFSS       _Flag01+0, BitPos(_Flag01+0) 
	GOTO        L_main7
	MOVLW       PORTC+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTC+0)
	MOVWF       FARG_Button_port+1 
	CLRF        FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main7
L__main15:
	MOVLW       128
	XORWF       _AR2+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _AR1+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main17
	MOVF        _AR1+0, 0 
	SUBWF       _AR2+0, 0 
L__main17:
	BTFSC       STATUS+0, 0 
	GOTO        L_main8
	MOVLW       2
	MOVWF       LATE+0 
	GOTO        L_main9
L_main8:
	MOVLW       1
	MOVWF       LATE+0 
L_main9:
	BTFSS       _Flag02+0, BitPos(_Flag02+0) 
	GOTO        L_main12
	MOVLW       PORTC+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTC+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       1
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main12
L__main14:
	MOVLW       3
	MOVWF       LATE+0 
L_main12:
	GOTO        L_main13
L_main7:
	CLRF        LATE+0 
L_main13:
	GOTO        L_main0
L_end_main:
	GOTO        $+0
; end of _main
