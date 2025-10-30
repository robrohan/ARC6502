;======================================
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
; Clobbers: A, and uses $00/$01 as pointer
set_pixel:
    ;                                scratch  ZP 1
    STX $02           ; Store X (column) into ZP 2
    STY $03           ; Store Y (row) into    ZP 3
    STA $04           ; Save color into       ZP 4

    LDX #0            ; Clear X register to use for storing the result

    ; Multiply by 32 (Y << 5)
    LDA $03         ; Load Y value
    ADC #$20        ; video memory starts at $2000
    STA $03         ; Store result of Y * 32 (screen offset)

    LDY #$00
    LDA $04             ; reload the color
    STA ($02), Y

    RTS

loop:
    ; center
    LDX #$0F     ; Column  = 0 - 1F
    LDY #$0F     ; Row     = 0 - 1F
    LDA #$FF     ; Color
    JSR set_pixel

    ; tl
    LDX #$00     ; Column  = 0 - 1F
    LDY #$00     ; Row     = 0 - 1F
    LDA #$FF     ; Color
    JSR set_pixel

    ; tr
    LDX #$1F     ; Column  = 0 - 1F
    LDY #$00     ; Row     = 0 - 1F
    LDA #$FF     ; Color
    JSR set_pixel

    ; bl
    LDX #$00     ; Column  = 0 - 1F
    LDY #$1F     ; Row     = 0 - 1F
    LDA #$FF     ; Color
    JSR set_pixel

    ; br
    LDX #$1F     ; Column  = 0 - 1F
    LDY #$1F     ; Row     = 0 - 1F
    LDA #$FF     ; Color
    JSR set_pixel

    JMP loop

.segment "VECTORS"
