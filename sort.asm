.include "8515def.inc" ; include the device-specific header file

.def temp = R16         ; define a temporary register to hold a value during swapping

.org 0x0000             ; set the program start address to 0x0000

Main:
    ldi r28, high(RAMEND) ; initialize the stack pointer
    out SPH, r28
    ldi r28, low(RAMEND)
    out SPL, r28

    ldi r20, 113        ; load the starting address of the sequence (0x71 = 113 in decimal)
    ldi r21, 0          ; set the initial offset to zero
    ldi r22, 10         ; set the number of elements in the sequence
    dec r22             ; decrease the count by 1 to use it as a loop counter later

OuterLoop:
    mov r23, r22        ; copy the outer loop counter to a temporary register
    InnerLoop:
        ldd r24, Z+     ; load the current value to register R24
        ldd r25, Z+     ; load the next value to register R25
        cp r24, r25     ; compare R24 with R25
        brcs Skip       ; jump to Skip if R24 is less than or equal to R25
        mov temp, r24   ; swap R24 and R25 using the temporary register
        mov r24, r25
        mov r25, temp
        st Z+, r25      ; store the swapped value back to the sequence
        dec Z           ; decrement Z to point to the previous element
        st Z+, r24
        Skip:
        dec r23         ; decrease the inner loop counter
        brne InnerLoop  ; jump back to InnerLoop if it's not zero
    dec r22             ; decrease the outer loop counter
    brne OuterLoop      ; jump back to OuterLoop if it's not zero

    ; after the outer loop finishes, the sequence is sorted in ascending order
    ; you can add your own code to display the sorted sequence or use it for further processing

End:
    jmp End            ; infinite loop

    .end               ; end of the program
