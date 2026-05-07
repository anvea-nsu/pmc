.include "m168Adef.inc"

.CSEG
.ORG 0x0
    rjmp RESET

.ORG INT_VECTORS_SIZE
RESET:
    ldi  r16, HIGH(RAMEND)
    out  SPH, r16
    ldi  r16, LOW(RAMEND)
    out  SPL, r16

    ldi  r16, 0xFF
    out  DDRD, r16
    ldi  r16, 0x00
    out  PORTD, r16

    ldi  r16, 0x03
    out  DDRB, r16
    ldi  r16, 0x00
    out  PORTB, r16

    ; --- Инициализация АЦП ---
    ; ADMUX: REFS0=1 (опорное = AVCC), ADLAR=0 (правое выравнивание), MUX=0000 (канал ADC0)
    ldi  r16, (1 << REFS0)
    sts  ADMUX, r16
    ; ADCSRA: ADEN=1 (включить АЦП), ADPS2:0=111 (делитель 128)
    ldi  r16, (1 << ADEN) | (1 << ADPS2) | (1 << ADPS1) | (1 << ADPS0)
    sts  ADCSRA, r16
MAIN_LOOP:
    lds  r16, ADCSRA
    ori  r16, (1 << ADSC)
    sts  ADCSRA, r16
ADC_WAIT:
    lds  r16, ADCSRA
    sbrc r16, ADSC              ; Пропустить следующую команду если ADSC = 0
    rjmp ADC_WAIT

    lds  r17, ADCL              ; Биты 7-0
    lds  r18, ADCH              ; Биты 9-8 (в битах 1-0)

    out  PORTD, r17             ; PORTD
    out  PORTB, r18             ; PORTB (PB1:PB0)

    rjmp MAIN_LOOP

.DSEG
.ORG SRAM_START
