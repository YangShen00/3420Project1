		AREA Myprog, CODE, READONLY
		ENTRY
		EXPORT __main

;don't change these addresses!
PCR22 	  EQU 0x4004A058 ;PORTB_PCR22  address
SCGC5 	  EQU 0x40048038 ;SIM_SCGC5    address
PDDR 	  EQU 0x400FF054 ;GPIOB_PDDR   address
PCOR 	  EQU 0x400FF048 ;GPIOB_PCOR   address
PSOR      EQU 0x400FF044 ;GPIOB_PSOR   address

ten		  EQU 0x00000400 ; 1 << 10
eight     EQU 0x00000100 ; 1 << 8
twentytwo EQU 0x00400000 ; 1 << 22

__main
	
	BL Fib

EndWithNeg
	MOV R2, #0
	B MorseDigit

EndWithZero
	MOV R2, #0
	B MorseDigit

EndWithOne
	MOV R2, #1
	B MorseDigit

Fib
	MOV R0, #6 ; Change variable n here
	CMP R0, #0
	BLT EndWithNeg
	CMP R0, #0
	BEQ EndWithZero
	CMP R0, #1
	BEQ EndWithOne
	
	PUSH {LR}
	MOV R1, #0
	MOV R2, #1
	MOV R3, #1
	B FibonacciCal
	
FibonacciCal
	CMP R3, R0
	BEQ MorseDigit
	ADD R3, R3, #1
	PUSH {R3}
	ADD R3, R1, R2
	MOV R1, R2
	MOV R2, R3
	POP {R3}
	B FibonacciCal

; void MorseDigit(int n) 
; R2 is the variable n that stores the value from the function fib()

MorseDigit
		MOV R0, R2
		MOV R1, #3000
		MOV R2, #3000
		BL LEDSETUP
		
		CMP R0, #0
		BEQ ZERO
		CMP R0, #1
		BEQ ONE
		CMP R0, #2
		BEQ TWO
		CMP R0, #3
		BEQ THREE
		CMP R0, #4
		BEQ FOUR
		CMP R0, #5
		BEQ FIVE
		CMP R0, #6
		BEQ SIX
		CMP R0, #7
		BEQ SEVEN
		CMP R0, #8
		BEQ EIGHT
		CMP R0, #9
		BEQ NINE

ONE
				BL DOT
				BL DASH
				BL DASH
				BL DASH
				BL DASH
				B forever

TWO
				BL DOT
				BL DOT
				BL DASH
				BL DASH
				BL DASH
				B forever

THREE
				BL DOT
				BL DOT
				BL DOT
				BL DASH
				BL DASH
				B forever


FOUR
				BL DOT
				BL DOT
				BL DOT
				BL DOT
				BL DASH
				B forever

FIVE
				BL DOT
				BL DOT
				BL DOT
				BL DOT
				BL DOT
				B forever

SIX
				BL DASH
				BL DOT
				BL DOT
				BL DOT
				BL DOT
				B forever

SEVEN
				BL DASH
				BL DASH
				BL DOT
				BL DOT
				BL DOT
				B forever

EIGHT
				BL DASH
				BL DASH
				BL DASH
				BL DOT
				BL DOT
				B forever

NINE
				BL DASH
				BL DASH
				BL DASH
				BL DASH
				BL DOT
				B forever

ZERO			BL DASH
				BL DASH
				BL DASH
				BL DASH
				BL DASH
				B forever


DOT
				PUSH {LR}
				BL LEDON
				B loop1
loop1
				B loop1sub
loop1sub
				SUBS R2, #1
				BNE loop1sub
				MOV R2, #3000
				SUBS R1, #3
				BNE loop1
				BL LEDOFF
				MOV R1, #3000
				BL BLANK
				POP{LR}
				BX LR

DASH
				PUSH{LR}
				BL LEDON
				B loop2
loop2
				B loop2sub
loop2sub
				SUBS R2, #1
				BNE loop2sub
				MOV R2, #3000
				SUBS R1, #1
				BNE loop2
				BL LEDOFF
				MOV R1, #3000
				BL BLANK
				POP{LR}
				BX LR


BLANK
				PUSH{LR}
loopnop
				B loopnopsub
loopnopsub
				SUBS R2, #1
				BNE loopnopsub
				MOV R2, #3000
				SUBS R1, #3
				BNE loopnop
				POP{LR}
				MOV R1, #3000
				BX LR


; Call this function first to set up the LED
LEDSETUP
				PUSH  {R4, R5} ; To preserve R4 and R5
				LDR   R4, =ten ; Load the value 1 << 10
				LDR		R5, =SCGC5
				STR		R4, [R5]
				
				LDR   R4, =eight
				LDR   R5, =PCR22
				STR   R4, [R5]
				
				LDR   R4, =twentytwo
				LDR   R5, =PDDR
				STR   R4, [R5]
				POP   {R4, R5}
				BX    LR

; The functions below are for you to use freely      
LEDON				
				PUSH  {R4, R5}
				LDR   R4, =twentytwo
				LDR   R5, =PCOR
				STR   R4, [R5]
				POP   {R4, R5}
				BX    LR
LEDOFF				
				PUSH  {R4, R5}
				LDR   R4, =twentytwo
				LDR   R5, =PSOR
				STR   R4, [R5]
				POP   {R4, R5}
				BX    LR
				
forever
			B		forever						; wait here forever	
			END