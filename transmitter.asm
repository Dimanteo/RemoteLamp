; INT0 - PD2
; out - PB0
.equ DDRD = 0x11
.equ PIND = 0x10
.equ PORTD = 0x12
.equ DDRB = 0x17
.equ PORTB = 0x18
.equ PINB = 0x16
.equ GIMSK = 0x3b
.equ MCUCR = 0x35
rjmp reset
rjmp int0

reset:
        cli
        ;setup D
        clr r16
        out DDRD, r16
        ser r16
        out PORTD, r16
        ;setup B
        ser r16
        out DDRB, r16
        clr r16
        out PORTB, r16
        ; setup MCUCR 0010--10
        ldi r16, 0x22
        out MCUCR, r16
        ;setup GIMSK
        ldi r16, 64
        out GIMSK, r16
        sei
        rjmp wait

wait:
        ;sleep
        rjmp wait


int0:
        cli
        sbi PINB, 0
        sei
        reti
