.segment "KERNEL"

.export SER_RX=$6000
.export SER_TX=$6001
.export SER_FLAGS=$6002

.export _transmit_x
.export _transmit_a
.export _transmit_y
.export _recieve_x
.export _recieve_a
.export _recieve_y
.export _read_serial_flags

_transmit_x:
	STX SER_TX
	RTS

_transmit_a:
	STA SER_TX
	RTS

_transmit_y:
	STY SER_TX
	RTS


_recieve_x:
	LDX SER_RX
	RTS

_recieve_a:
	LDA SER_RX
	RTS

_recieve_y:
	LDY SER_RX
	RTS

_read_serial_flags:
	LDX SER_FLAGS
	RTS

_put_chr:
	STA SER_TX
	RTS

_get_chr:
	LDA SER_RX
	RTS

