.segment "KERNEL"
.export MATH_WORKING_REGISTER=0

.export _multiply_AX
.export _multiply_AY
.export _divide_AY
.export _divide_AX

_multiply_AX:
	STA MATH_WORKING_REGISTER
	LDA #0
	_multiply_AX_loop:
	ADC MATH_WORKING_REGISTER
	DEX
	BNE _multiply_AX_loop
	RTS

_multiply_AY:
	STA MATH_WORKING_REGISTER
	LDA #0
	_multiply_AY_loop:
	ADC MATH_WORKING_REGISTER
	DEY
	BNE _multiply_AY_loop
	RTS

_divide_AY:
	STY MATH_WORKING_REGISTER
	LDY #$0      ;reset y to MATH_WORKING_REGISTER
	SEC      ;set carry
	_divide_AY1:
	SBC MATH_WORKING_REGISTER   ;subtract divisor from divedend
	BCC _multiply_AY   ;if carry cleared, meaning subtraction went below MATH_WORKING_REGISTER
	INY      ;increment y to increase quotient
	BNE _divide_AY1
	_divide_AYRet:
	RTS

_divide_AX:
	STX MATH_WORKING_REGISTER
	LDX #$0      ;reset X to MATH_WORKING_REGISTER
	SEC      ;set carrX
	_divide_AX1:
	SBC MATH_WORKING_REGISTER   ;subtract divisor from divedend
	BCC _divide_AXRet   ;if carrX cleared, meaning subtraction went below 0
	INX      ;increment X to increase quotient
	BNE _divide_AX1
	_divide_AXRet:
	RTS