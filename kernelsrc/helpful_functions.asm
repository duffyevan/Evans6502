.segment "KERNEL"

.import PERIPHERAL_SELECT1

.macro LED_X output
	LDX output
	STX PERIPHERAL_SELECT1
.endmacro

.macro DELAY_X loops
	.local loop
	LDX loops
	loop:
	DEX
	BNE loop
.endmacro

.macro DELAY_Y loops
	.local loop
	LDY loops
	loop:
	DEY
	BNE loop
.endmacro

.macro PUSH_ALL
	PHA ; push A
	TXA
	PHA ; push X
	TYA
	PHA ; push Y
.endmacro

.macro POP_ALL
	PLA ; POP Y
	TAY
	PLA ; POP X
	TAX
	PLA ; POP A
.endmacro

.macro INITIALIZE_STACK_WARM
	PHA
	TXA
	LDX #$6000
	TXS
	TAX
	PHA	
.endmacro

.macro INITIALIZE_STACK_COLD
	LDX #$6000
	TXS
.endmacro

.macro INITIALIZE_CPU
	SEI ;disable interrupts (set interrupt disable flag)
	CLD ;turn decimal mode off
.endmacro

_push_registers:
	PHA ; push A
	TXA
	PHA ; push X
	TYA
	PHA ; push Y
	RTS

_pop_registers:
	PLA ; POP Y
	TAY
	PLA ; POP X
	TAX
	PLA ; POP A
	RTS