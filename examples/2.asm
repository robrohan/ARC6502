;======================================
; This is trying to create a version of
; data sample #2
;
; ZP layout
; $2000    $DF/$DE  Current pointer to screen memory
; $0000    $DB/$DA  Pointer last writing screen memory
; Color    $D4,$D5  FG Color, BG Color
; X2,Y2    $D2,$D3  X2,Y2 Second drawing position
; X1,Y1    $D0,$D1  X1,Y1 Drawing position
; C1,C2    $C0,$C1  Counter 1, Counter 2
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
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; fill screen
    LDA #$00
    STA $D0           ; set X1
    STA $D1           ; set Y1
    LDA #$04
    STA $D2           ; set X2 (W)
    STA $D3           ; set Y2 (H)
    LDA #$08
    STA $D4           ; set Color
    JSR box

    LDA #$02          ; set X1
    STA $D0
    LDA #$00          ; set Y1
    STA $D1
    LDA #$01          ; set X2 (W)
    STA $D2
    LDA #$00          ; set Y2 (H)
    STA $D3
    LDA #$06
    STA $D4           ; set Color
    JSR box

    RTS

.segment "VECTORS"