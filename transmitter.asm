; ATtiny 2313
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
.equ CLKPR = 0x26
.CSEG
rjmp RESET
rjmp INT0
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

; r15 - 0
; r16 - temporary
; r17 - FF
; r18 - timer out/cmp value
; r19 - TIMSK state
; r20 - package counter
; Output signal goes to port B

RESET:
        cli
        ser r17
        clr r15
        ; clock setup
        ldi r16, 128
        out CLKPR, r16
        out CLKPR, r15
        ; setup MCUCR 0010--10
        ldi r16, 0x22
        out MCUCR, r16
        ;setup GIMSK
        ldi r16, 64
        out GIMSK, r16
        ;setup ports
        out DDRB, r17
        out PORTB,r15
        out DDRD, r15
        out PORTD, r17
        ;setup timer
        ldi r16, 2
        out TCCR0A, r16
        out TCCR0B, r15
        ldi r16, 1
        out TIMSK, r16
        clr r20
        ; OCR0A setup
        clr r18
        out OCR0A, r18
        ldi r16, 1
        out TCCR0B, r16
        sei
        rjmp wait

wait:
        rjmp wait

T0COMPA:
        cli
        cpi r18, 20
        ldi r18, 20
        ser r16
        brne noaction
        ldi r18, 123
        clr r16
        inc r20
noaction:
        out OCR0A, r18
        out PORTB, r16
        cpi r20, 10
        brne return
        clr r20
        out TCCR0B, r15
return:
        sei
        reti

INT0:
        cli
        clr r20
        ; OCR0A setup
        clr r18
        out OCR0A, r18
        ldi r16, 1
        out TCCR0B, r16
        sei
        reti