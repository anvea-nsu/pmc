.include "m168Adef.inc"

.org 0x0000
    rjmp main

main:
    ldi r16, 10

    ldi r26, low(0x0100)
    ldi r27, high(0x0100)

init:
    ldi r17, 0
    ldi r18, 1

    rjmp designate

designate:
    cpi r17, 10
    brge find

    st X+, r18
    lsl r18

    inc r17
    rjmp designate

find:
    ldi r17, 0

    ldi r19, 32 ; element for find is 32

    ldi r26, low(0x0100)
    ldi r27, high(0x0100)

    rjmp loop

loop:
    cpi r17, 10
    brge finish

    ld r18, X+
    cp r18, r19
    breq save

    inc r17
    rjmp loop

save:
    mov r20, r17
    rjmp finish
  
finish:
    rjmp finish
