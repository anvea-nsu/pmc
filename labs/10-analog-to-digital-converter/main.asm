.include "m168Adef.inc"

.cseg
.org 0x0000
    jmp reset

reset:
    ldi r16, high(RAMEND)
    out SPH, r16
    ldi r16, low(RAMEND)
    out SPL, r16

    ldi r16, 0xFF
    out DDRD, r16

    ldi r16, (1 << REFS0) | (1 << ADLAR)
    sts ADMUX, r16


    ldi r16, (1 << ADEN) | (1 << ADPS2) | (1 << ADPS1) | (1 << ADPS0)
    sts ADCSRA, r16

main_loop:
    lds r16, ADCSRA
    ori r16, (1 << ADSC)
    sts ADCSRA, r16

wait_adc:
    lds r16, ADCSRA
    sbrc r16, ADSC
    rjmp wait_adc

    lds r18, ADCL
    lds r17, ADCH
    out PORTD, r17

    rjmp main_loop
