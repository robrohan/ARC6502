;======================================
; This is an example of setting a pixel
; with a color in a position on a 32x32
; stage
;======================================
.segment "ZEROPAGE"
.segment "BSS"
.segment "CODE"

start:
    JMP loop

; Inputs:
;   X = column (0-35)
;   Y = row (0-35)
;   A = color value
.include "set_pixel.asm"

loop:
    ; center
    LDX #$0F     ; Column  = 0 - 1F
    LDY #$0F     ; Row     = 0 - 1F
    LDA #$06     ; Color
    JSR set_pixel

    ; tl
    LDX #$00     ; Column  = 0 - 1F
    LDY #$00     ; Row     = 0 - 1F
    LDA #$06     ; Color
    JSR set_pixel

    ; tr
    LDX #$1F     ; Column  = 0 - 1F
    LDY #$00     ; Row     = 0 - 1F
    LDA #$06     ; Color
    JSR set_pixel

    ; bl
    LDX #$00     ; Column  = 0 - 1F
    LDY #$1F     ; Row     = 0 - 1F
    LDA #$06     ; Color
    JSR set_pixel

    ; br
    LDX #$1F     ; Column  = 0 - 1F
    LDY #$1F     ; Row     = 0 - 1F
    LDA #$06     ; Color
    JSR set_pixel

    JMP loop

.segment "VECTORS"
