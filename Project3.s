		AREA Lab1Project3, CODE, READONLY
		ENTRY
		EXPORT __main

__main
	MOV R0, #3
	CMP R0, #0
	B endWithZero
	CMP R0, #1
	B endWithOne
	BL Fibonacci
	END

endWithZero
	MOV R0, #0
	END

endWithOne
	MOV R0, #1
	END

Fibonacci
	PUSH {LR}
	MOV R1, #0
	MOV R2, #1
	MOV R3, #1
	B FibonacciCal
	
FibonacciCal
	CMP R3, R0
	BEQ EndFibonacci
	ADD R3, R3, #1
	PUSH {R3}
	ADD R3, R1, R2
	MOV R1, R2
	MOV R2, R3
	POP {R3}
	B FibonacciCal
	
EndFibonacci
	POP {LR}
	BX LR
	
