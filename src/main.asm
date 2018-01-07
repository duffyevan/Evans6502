.segment "CODE"
.include "../kernelsrc/helpful_macros.mp"
.macro SEND address
	.local SEND_loop
	.local done
	LDX #$00
	SEND_loop:
	LDA address,x
	BEQ done
	STA SER_TX
	INX
	JMP SEND_loop
	done:
.endmacro

main:
	SEND message
	LDX #0
	loop:
	STX PERIPHERAL_SELECT1
	INX
	DELAY_Y $FF
	DELAY_Y $FF
	DELAY_Y $FF
	JMP loop

	BRK

.segment "DATA"
message:
	.byte "Hello World",$0a,$0
