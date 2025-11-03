;======================================
; This is an example of setting a pixel
; with a color in a position on a 32x32
; stage
;======================================
.segment "ZEROPAGE"
.segment "BSS"
.segment "CODE"

start:
    ; Set the video memory address
    LDA #$20
    STA $DF
    JMP loop

.include "set_pixel.asm"

loop:
    ; center
    LDA #$0F
    STA $D0           ; set X
    STA $D1           ; set Y
    LDA #$06
    STA $D4           ; set Color
    JSR set_pixel

    ; tl
    LDA #$00
    STA $D0           ; set X
    STA $D1           ; set Y
    LDA #$06
    STA $D4           ; set Color
    JSR set_pixel

    ; tr
    LDA #$1F
    STA $D0           ; set X
    LDA #$00
    STA $D1           ; set Y
    LDA #$06
    STA $D4           ; set Color
    JSR set_pixel

    ; bl
    LDA #$00
    STA $D0           ; set X
    LDA #$1F
    STA $D1           ; set Y
    LDA #$06
    STA $D4           ; set Color
    JSR set_pixel

    ; br
    LDA #$1F
    STA $D0           ; set X
    STA $D1           ; set Y
    LDA #$06
    STA $D4           ; set Color
    JSR set_pixel

    JMP loop

.segment "VECTORS"
