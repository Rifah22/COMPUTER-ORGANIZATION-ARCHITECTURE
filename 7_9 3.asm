.MODEL SMALL
.STACK 100H

.DATA
msg1 db 'TYPE A CHARACTER: $'
msg2 db 0AH,0DH,'THE ASCII CODE OF $'
msg3 db ' IN HEX IS: $'
newline db 0Dh, 0Ah, '$'

.CODE
MAIN PROC
    MOV AX, @DATA    ; Load the data segment address
    MOV DS, AX

input_loop:           ; Start of input loop
    ; Display message to prompt for input
    LEA DX, msg1
    MOV AH, 9
    INT 21H

    ; Read a character from the user
    MOV AH, 1         ; Function to take single character input
    INT 21H           ; Store the input character in AL
    MOV BL, AL        ; Copy the input to BL for further processing

    ; Check for carriage return (Enter key)
    CMP BL, 0DH       ; Compare with ASCII value of carriage return
    JE end_program    ; If carriage return, exit the program

    ; Display "THE ASCII CODE OF "
    LEA DX, msg2
    MOV AH, 9
    INT 21H

    ; Display the entered character
    MOV DL, BL        ; Move the input character to DL
    MOV AH, 2         ; Function to display a single character
    INT 21H

    ; Display " IN HEX IS: "
    LEA DX, msg3
    MOV AH, 9
    INT 21H

    ; Convert and display the ASCII code in hex
    MOV CX, 2         ; We need to display two hexadecimal digits
convert_to_hex:
    MOV DL, BL        ; Move the ASCII code to DL
    SHR DL, 4         ; Extract the higher nibble on the first iteration
    JC skip_low       ; Skip clearing if already handling lower nibble
    AND BL, 0FH       ; Extract the lower nibble on the second iteration
skip_low:
    CMP DL, 9         ; Check if the digit is 0-9
    JBE add_num       ; If true, add '0'
    ADD DL, 7         ; Else, add 'A' - 10
add_num:
    ADD DL, 30H       ; Convert to ASCII
    MOV AH, 2         ; Function to display a single character
    INT 21H

    ROL BL, 4         ; Rotate BL left to shift between high and low nibbles
    LOOP convert_to_hex ; Loop for the next nibble

    ; Print newline after displaying hex code
    LEA DX, newline
    MOV AH, 9
    INT 21H

    JMP input_loop    ; Repeat the input process

end_program:           ; End of the program
    MOV AH, 4CH       ; Terminate program
    INT 21H
MAIN ENDP
END MAIN
