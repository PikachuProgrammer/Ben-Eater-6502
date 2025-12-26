PORTB = $6000
PORTA = $6001
DDRB = $6002
DDRA = $6003

value = $0200 ; Stores the adress in which the right half of the number is stored
mod10 = $0202 ; Stores the modulus of the number when divided by 10
message = $0204 

E  = %10000000
RW = %01000000
RS = %00100000
  .org $8000

reset:
  ldx #$ff
  txs

  lda #%11111111 ; Set all pins on port B to output
  sta DDRB
  lda #%11100000 ; Set top 3 pins on port A to output
  sta DDRA

  lda #%00111000 ; Set 8-bit mode; 2-line display; 5x8 font
  jsr lcd_instruction
  lda #%00001110 ; Display on; cursor on; blink off
  jsr lcd_instruction
  lda #%00000110 ; Increment and shift cursor; don't shift display
  jsr lcd_instruction
  lda #$00000001 ; Clear display
  jsr lcd_instruction

  lda #0
  sta message
; Initialize number to be the number to convert
  lda number
  sta value
  lda number + 1
  sta value + 1

divide:
; Initialize the remainder to zero
  lda #0
  sta mod10
  sta mod10 + 1
  clc
  

  ldx #16
divloop:
; Rotate the quotient and the remainder
  rol value
  rol value + 1
  rol mod10
  rol mod10 + 1

  ;subtract 10 from mod10
  sec
  lda mod10
  sbc #10
  tay ; save low byte in Y
  lda mod10 + 1
  sbc #0
  bcc ignore_result ; branch if the dividend < divisor
  sty mod10
  sta mod10 + 1

ignore_result:
  dex
  bne divloop
  rol value
  rol value + 1

  lda mod10
  clc
  adc #'0'
  jsr push_char



  lda value
  ora value + 1
  bne divide ;branch if value != 0

  ldx #0
print:
  lda message,x
  beq loop
  jsr print_char
  inx
  jmp print


loop:
  jmp loop


number: .word 1967

push_char:
   pha ; Save the character on the stack
   ldy #0
   
   lda message,y
   tax
   pla 
   sta message,y
   iny
   txa
   pha
   bne char_loop

char_loop:
    lda message,y
    tax
    pla 
    sta message,y
    iny
    txa
    pha
    bne char_loop
    
    pla
    sta message,y

    rts

lcd_wait:
  pha
  lda #%00000000  ; Port B is input
  sta DDRB
lcdbusy:
  lda #RW
  sta PORTA
  lda #(RW | E)
  sta PORTA
  lda PORTB
  and #%10000000
  bne lcdbusy

  lda #RW
  sta PORTA
  lda #%11111111  ; Port B is output
  sta DDRB
  pla
  rts

lcd_instruction:
  jsr lcd_wait
  sta PORTB
  lda #0         ; Clear RS/RW/E bits
  sta PORTA
  lda #E         ; Set E bit to send instruction
  sta PORTA
  lda #0         ; Clear RS/RW/E bits
  sta PORTA
  rts

print_char:
  jsr lcd_wait
  sta PORTB
  lda #RS         ; Set RS; Clear RW/E bits
  sta PORTA
  lda #(RS | E)   ; Set E bit to send instruction
  sta PORTA
  lda #RS         ; Clear E bits
  sta PORTA
  rts

  .org $fffc
  .word reset
  .word $0000