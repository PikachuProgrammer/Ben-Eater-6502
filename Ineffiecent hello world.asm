PORTB = $6000
PORTA = $6001
DDRB = $6002
DDRA = $6003
    .org $8000
E = %10000000
RW = %01000000
RS = %00100000

reset:
;the first 2 lda's get the output chip ready to output information
  lda #$ff; set all pins on port B to output do-d7 on lcd
  sta DDRB
  lda #%11100000; set top 3 pins on port a to output RS/E/RW
  sta DDRA
  
  lda #%00111000;set8 bit mode 2 line display and 5*8 character display
  sta PORTB

  lda #0;Clear RS/RW/E bits
  sta PORTA
  
  lda #E;enables the lcd to listen to the output chip
  sta PORTA
  
  lda #0
  sta PORTA;Clear RS/RW/E bits
;Instruction sent
;New intruction being sent to the lcd module
  lda #%00001110;Turn display on Cursor on no blink
  sta PORTB

  lda #0;Clear RS/RW/E bits
  sta PORTA
  
  lda #E;enables the lcd to listen to the output chip
  sta PORTA
  
  lda #0
  sta PORTA;Clear RS/RW/E bits

;Instruction sent
;New intruction being sent to the lcd module
  lda #%00000110 ;incrementing the cursor and not shifting the display
  sta PORTB

  lda #0;Clear RS/RW/E bits
  sta PORTA
  
  lda #E;enables the lcd to listen to the output chip
  sta PORTA
  
  lda #0
  sta PORTA;Clear RS/RW/E bits
;Instruction sent
;New intruction being sent to the lcd module
  lda #'H'; Sends the letter H to the display
  sta PORTB

  lda #RS ;This part confuses me
  sta PORTA
  
  lda #(RS | E);enables the lcd to listen to the output chip
  sta PORTA
  
  lda #RS
  sta PORTA;Clear RS/RW/E bits

;Instruction sent
;New intruction being sent to the lcd module
  lda #'E'; Sends the letter H to the display
  sta PORTB

  lda #RS ;This part confuses me
  sta PORTA
  
  lda #(RS | E);enables the lcd to listen to the output chip
  sta PORTA
  
  lda #RS
  sta PORTA;Clear RS/RW/E bits

  ;Instruction sent
;New intruction being sent to the lcd module
  lda #'L'; Sends the letter H to the display
  sta PORTB

  lda #RS ;This part confuses me
  sta PORTA
  
  lda #(RS | E);enables the lcd to listen to the output chip
  sta PORTA
  
  lda #RS
  sta PORTA;Clear RS/RW/E bits
  ;Instruction sent
;New intruction being sent to the lcd module
  lda #'L'; Sends the letter H to the display
  sta PORTB

  lda #RS ;This part confuses me
  sta PORTA
  
  lda #(RS | E);enables the lcd to listen to the output chip
  sta PORTA
  
  lda #RS
  sta PORTA;Clear RS/RW/E bits
  ;Instruction sent
;New intruction being sent to the lcd module
  lda #'O'; Sends the letter H to the display
  sta PORTB

  lda #RS ;This part confuses me
  sta PORTA
  
  lda #(RS | E);enables the lcd to listen to the output chip
  sta PORTA
  
  lda #RS
  sta PORTA;Clear RS/RW/E bits

  ;Instruction sent
;New intruction being sent to the lcd module
  lda #'_'; Sends the letter H to the display
  sta PORTB

  lda #RS ;This part confuses me
  sta PORTA
  
  lda #(RS | E);enables the lcd to listen to the output chip
  sta PORTA
  
  lda #RS
  sta PORTA;Clear RS/RW/E bits
  ;Instruction sent
;New intruction being sent to the lcd module
  lda #'W'; Sends the letter H to the display
  sta PORTB

  lda #RS ;This part confuses me
  sta PORTA
  
  lda #(RS | E);enables the lcd to listen to the output chip
  sta PORTA
  
  lda #RS
  sta PORTA;Clear RS/RW/E bits
  ;Instruction sent
;New intruction being sent to the lcd module
  lda #'O'; Sends the letter H to the display
  sta PORTB

  lda #RS ;This part confuses me
  sta PORTA
  
  lda #(RS | E);enables the lcd to listen to the output chip
  sta PORTA
  
  lda #RS
  sta PORTA;Clear RS/RW/E bits

  ;Instruction sent
;New intruction being sent to the lcd module
  lda #'R'; Sends the letter H to the display
  sta PORTB

  lda #RS ;This part confuses me
  sta PORTA
  
  lda #(RS | E);enables the lcd to listen to the output chip
  sta PORTA
  
  lda #RS
  sta PORTA;Clear RS/RW/E bits
  ;Instruction sent
;New intruction being sent to the lcd module
  lda #'L'; Sends the letter H to the display
  sta PORTB

  lda #RS ;This part confuses me
  sta PORTA
  
  lda #(RS | E);enables the lcd to listen to the output chip
  sta PORTA
  
  lda #RS
  sta PORTA;Clear RS/RW/E bits
  ;Instruction sent
;New intruction being sent to the lcd module
  lda #'D'; Sends the letter H to the display
  sta PORTB

  lda #RS ;This part confuses me
  sta PORTA
  
  lda #(RS | E);enables the lcd to listen to the output chip
  sta PORTA
  
  lda #RS
  sta PORTA;Clear RS/RW/E bits
  ;Instruction sent
;New intruction being sent to the lcd module
  lda #'!'; Sends the letter H to the display
  sta PORTB

  lda #RS ;This part confuses me
  sta PORTA
  
  lda #(RS | E);enables the lcd to listen to the output chip
  sta PORTA
  
  lda #RS
  sta PORTA;Clear RS/RW/E bits
  ;Instruction sent


loop:
  jmp loop

  ror
  sta $6000


  .org $fffc
  .word reset
  .word $0000