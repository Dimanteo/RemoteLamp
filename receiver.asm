.equ DDRB = 0x17
.equ PINB = 0x16
.equ PORTB = 0x18
.equ GIMSK = 0x3b
.equ MCUCR] = 0x35
.equ SPL = 0x3d
rjmp reset
rjmp int0

reset:
	cli
	; ldi r16, 8
	; out DDRB, r16
	sbi DDRB, 4
	ldi r16, 0x2F
	out PORTB, r16
	; setup MCUCR
	ldi r16, 2
	out MCUCR, r16
	;setup GIMSK
	ldi r16, 64
	out GIMSK, r16
	sei
	rjmp wait

wait:
	rjmp wait


int0:
	cli
	;ldi r16, 16
	;out PINB, r16
	sbi PINB, 4
	sei
	reti