;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

set_pixel:
    LDA $DE           ; reset X
    STA $DA

    LDA $DF           ; load video offset
    ADC $D1           ; add the Y value
    STA $DB           ; put it in cursor pos

    LDY $D0           ; load X pos
    LDA $D4           ; reload the color
    STA ($DA), Y      ; draw to the video address

    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

x1=$D0
y1=$D1
x2=$D2
y2=$D3
color=$D4

box:
    ;; x1, y1 the position, top left
    ;; x2, y1 and how big it is (w,h)
    LDA $DF         ; reset writing pointer
    STA $DB
    LDA $DE
    STA $DA         ; $2000

    LDA $DB         ; get the drawing pointer
    ADC y1          ; set counter to
    ADC y2
    STA $C1         ; offset + (y1 + y2)

    LDA $DB         ; start drawing y
    ADC y1
    STA $DB         ; offset + y1

    LDA x2
    STA $C0         ; $A + $05 (5)

draw_row:
    ;;;; draw a row
    LDA color         ; set the color
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    LDY x1          ; $DA will have everything
    STA ($DA), Y    ; 16bit address

    INC $DA
    LDA $DA
    CMP $C0
    BNE draw_row
next_row:
    LDA #$00
    STA $DA         ; reset to column 0

    INC $DB         ; increment high byte
    LDA $DB         ; load high byte
    CMP $C1        ; compare high byte
    BNE draw_row

    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
