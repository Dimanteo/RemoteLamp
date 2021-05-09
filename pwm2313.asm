.equ DDRD = 0x11
.equ PIND = 0x10
.equ PORTD = 0x12
.equ DDRB = 0x17
.equ PORTB = 0x18
.equ PINB = 0x16
.equ GIMSK = 0x3b
.equ MCUCR = 0x35
.equ TCCR0A = 0x30
.equ TCCR0B = 0x33
.equ OCR0A = 0x36
.equ TIMSK = 0x39
.CSEG
rjmp RESET
nop
nop
nop
nop
nop
nop ;overflow
nop
nop
nop
nop
nop
nop
rjmp T0COMPA; cmp match

RESET:
        cli
        ser r17
        ;setup timer
        ldi r16, 0x3
        out TCCR0A, r16
        ldi r16, 0x5
        out TCCR0B, r16
        out OCR0A, r17  ; 0xFF
        ldi r16, 1
        out TIMSK, r16
        ;setup ports
        out DDRB, r17
        out PORTB, r17
        sei
        rjmp wait

wait:
        rjmp wait

T0COMPA:
        cli
        inc r18
        cpi r18, 5
        brne noaction
        ; toggle pin
        out PINB, r17
        clr r18
noaction:
        sei
        reti
