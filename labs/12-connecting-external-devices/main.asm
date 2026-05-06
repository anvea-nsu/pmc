.include "m168def.inc"

.cseg
.org 0x0000
    jmp RESET

RESET:
    ldi r16, high(RAMEND)
    out SPH, r16
    ldi r16, low(RAMEND)
    out SPL, r16

    ldi r16, 0x0F
    out DDRB, r16

    ldi r16, 0x0F
    out PORTB, r16

    clr r16
    out DDRC, r16

    ldi r16, 0x07
    out PORTC, r16

    ldi r16, 0x7F
    out DDRD, r16

    clr r16
    out PORTD, r16

MAIN:
    ldi r16, 0b00001110
    out PORTB, r16
    rcall SMALL_DELAY
    in r17, PINC

    sbrs r17, 0
    rjmp SHOW_1
    sbrs r17, 1
    rjmp SHOW_2
    sbrs r17, 2
    rjmp SHOW_3

    ldi r16, 0b00001101
    out PORTB, r16
    rcall SMALL_DELAY
    in r17, PINC

    sbrs r17, 0
    rjmp SHOW_4
    sbrs r17, 1
    rjmp SHOW_5
    sbrs r17, 2
    rjmp SHOW_6

    ldi r16, 0b00001011
    out PORTB, r16
    rcall SMALL_DELAY
    in r17, PINC

    sbrs r17, 0
    rjmp SHOW_7
    sbrs r17, 1
    rjmp SHOW_8
    sbrs r17, 2
    rjmp SHOW_9

    ldi r16, 0b00000111
    out PORTB, r16
    rcall SMALL_DELAY
    in r17, PINC

    sbrs r17, 1
    rjmp SHOW_0

    clr r18
    out PORTD, r18
    rjmp MAIN

SHOW_0:
    ldi r18, 0b00111111
    out PORTD, r18
    rjmp MAIN

SHOW_1:
    ldi r18, 0b00000110
    out PORTD, r18
    rjmp MAIN

SHOW_2:
    ldi r18, 0b01011011
    out PORTD, r18
    rjmp MAIN

SHOW_3:
    ldi r18, 0b01001111
    out PORTD, r18
    rjmp MAIN

SHOW_4:
    ldi r18, 0b01100110
    out PORTD, r18
    rjmp MAIN

SHOW_5:
    ldi r18, 0b01101101
    out PORTD, r18
    rjmp MAIN

SHOW_6:
    ldi r18, 0b01111101
    out PORTD, r18
    rjmp MAIN

SHOW_7:
    ldi r18, 0b00000111
    out PORTD, r18
    rjmp MAIN

SHOW_8:
    ldi r18, 0b01111111
    out PORTD, r18
    rjmp MAIN

SHOW_9:
    ldi r18, 0b01101111
    out PORTD, r18
    rjmp MAIN

SMALL_DELAY:
    ldi r20, 50
D1:
    dec r20
    brne D1
    ret