        B main

ipA     DEFW 0 ; Store the read IP here
ipB     DEFW 0 ; Store the read IP here
ipC     DEFW 0 ; Store the read IP here
ipD     DEFW 0 ; Store the read IP here

fs		DEFB ".",0
enterIP DEFB "Please enter your IP address: ",0
newline DEFB "\n",0
errorM  DEFB "\nYou have entered an invalid IP address!\n",0
ipAddress
        DEFB "You entered the IP address: ",0

        ALIGN
main    
		MOV R7,#0
		ADR R0,enterIP
		SWI 3
		B dlc
		SWI 2
errorOut
		ADR R0,errorM
		SWI 3
		SWI 2
ipOut
		LDR R0,ipA
		CMP R0,#255
		BGT errorOut
		LDR R0,ipB
		CMP R0,#255
		BGT errorOut
		LDR R0,ipC
		CMP R0,#255
		BGT errorOut
		LDR R0,ipD
		CMP R0,#255
		BGT errorOut
		ADR R0,newline
		SWI 3
		ADR R0,ipAddress
		SWI 3
		LDR R0,ipA
		SWI 4
		ADR R0,fs
		SWI 3
		LDR R0,ipB
		SWI 4
		ADR R0,fs
		SWI 3
		LDR R0,ipC
		SWI 4
		ADR R0,fs
		SWI 3
		LDR R0,ipD
		SWI 4
		SWI 2
desloopes
		CMP R7,#0
		BEQ first
		CMP R7,#1
		BEQ second
		CMP R7,#2
		BEQ third
		CMP R7,#3
		BEQ fourth
dlc
		CMP R7,#4
		BEQ finish
		BL readInt
		B desloopes
first
		ADR R3,ipA
		MOV R10,R1
		BL storePart
		ADD R7,R7,#1
		B dlc
second
		ADR R3,ipB
		MOV R11,R1
		BL storePart
		ADD R7,R7,#1
		B dlc
third
		ADR R3,ipC
		MOV R12,R1
		BL storePart
		ADD R7,R7,#1
		B dlc
fourth
		ADR R3,ipD
		MOV R13,R1
		BL storePart
		ADD R7,R7,#1
		B dlc
finish
		SWI 3
		CMP R10,#46
		BNE errorOut
		CMP R11,#46
		BNE errorOut
		CMP R12,#46
		BNE errorOut
		CMP R13,#10
		BNE errorOut
		B ipOut
storePart
		STR R0,[R3]
		MOV PC,R14

readInt	MOV	R2,#10
		MOV R1,#0
		B riloop
ric		MUL R1,R1,R2
		ADD R1,R1,R0
riloop	SWI 1
		SWI 0
		SUB R0,R0,#48
		CMP R0,#9
		BLS	ric

		EOR	R0,R1,R0
		EOR R1,R0,R1
		EOR	R0,R1,R0
		ADD R1,R1,#48
		MOV PC,R14