#include<p18f4550.inc>

lp_cnt1 	set 0x00
lp_cnt2 	set 0x01

			org 0x00
			goto start
			org 0x08
			retfie
			org 0x18
			retfie
			
dup_nop		macro kk
			variable i
i = 0
			while i < kk
			nop
i += 1
			endw
			endm
			



DELAY 		MOVLW D'80'
			MOVWF lp_cnt2,A
AGAIN1		MOVLW D'250'
			MOVWF lp_cnt1,A
AGAIN2 		dup_nop D'247'
			DECFSZ lp_cnt1,F,A
			BRA AGAIN2
			DECFSZ lp_cnt2,F,A
			BRA AGAIN1
			NOP
			RETURN
			
			


;MAIN PROGRAM

start		SETF 	TRISB,A ;CONFIGURE SWITCH 
			CLRF  	TRISD, A
			CLRF  	TRISC, A
CHECK		CALL  	KEYPAD 
			BRA   	CHECK1
CHECK1		BTFSS 	PORTB,0 ;CHECK SW1 CONDITION
			BRA 	BUZZER
CHECK2		BTFSC 	PORTB,1 ;CHECK SW2 CONDITION
			BRA 	CHECK
			CALL 	BUZZER
			CALL	DELAY
			CALL 	BUZZER
;___________________________________________________________________________
BUZZER 	    BSF 	PORTC,2,A
            CALL 	DELAY
            BCF 	PORTC,2,A
            return
;___________________________________________________________________________
;SUBROUTINE FOR KEYPAD

KEYPAD		SETF  TRISB, A
	    	BSF   PORTD, 7, A
			BCF   PORTD, 4, A
			BTFSC PORTB, 0, A	
			BRA   KEYPAD2
			MOVLW 0x01
			MOVWF PORTD, A

KEYPAD2	    BSF   PORTD, 7, A
			BCF   PORTD, 4, A
			BTFSC PORTB, 1, A
			BRA   KEYPAD3
			MOVLW 0x02
			MOVWF PORTD, A

KEYPAD3	    BSF   PORTD, 7, A
			BCF   PORTD, 4, A
			BTFSC PORTB, 2, A
			BRA   KEYPAD4
			MOVLW 0x03
			MOVWF PORTD, A

KEYPAD4	    BSF   PORTD, 4, A
			BCF   PORTD, 5, A
			BTFSC PORTB, 0, A	
			BRA   KEYPAD5
			MOVLW 0x04
			MOVWF PORTD, A

KEYPAD5	    BSF   PORTD, 4, A
			BCF   PORTD, 5, A
			BTFSC PORTB, 1, A
			BRA   KEYPAD6
			MOVLW 0x05
			MOVWF PORTD, A

KEYPAD6	    BSF   PORTD, 4, A
			BCF   PORTD, 5, A
			BTFSC PORTB, 2, A
			BRA   KEYPAD7
			MOVLW 0x06
			MOVWF PORTD, A

KEYPAD7	    BSF   PORTD, 5, A
			BCF   PORTD, 6, A
			BTFSC PORTB, 0, A
			BRA   KEYPAD8
			MOVLW 0x07
			MOVWF PORTD, A

KEYPAD8	    BSF   PORTD, 5, A
			BCF   PORTD, 6, A
			BTFSC PORTB, 1, A
			BRA   KEYPAD9
			MOVLW 0x08
			MOVWF PORTD, A

KEYPAD9     BSF   PORTD, 5, A
			BCF   PORTD, 6, A
			BTFSC PORTB, 2, A
			BRA   KEYPADSTAR
			MOVLW 0x09
			MOVWF PORTD, A

KEYPADSTAR  BSF   PORTD, 6, A
			BCF   PORTD, 7, A
			BTFSC PORTB, 0, A
			BRA   KEYPAD0 
			MOVLW 0x00
			MOVWF PORTD, A

KEYPAD0     BSF   PORTD, 6, A
			BCF   PORTD, 7, A
			BTFSC PORTB, 1, A
			BRA   KEYPAD#
			MOVLW 0x00
			MOVWF PORTD, A
			
KEYPAD#     BSF   PORTD, 6, A
			BCF   PORTD, 7, A
			BTFSC PORTB, 2, A
			BRA   SHOW
			MOVLW 0x04
			MOVWF PORTD, A

SHOW		RETURN			 
			NOP
			END










