.MODEL SMALL
.STACK 100H
.DATA
MSG1 DB 'BEFORE REVERSE: $'  ; Message before reversal
MSG2 DB 0DH, 0AH, 'AFTER REVERSE: $'  ; Message after reversal
PROMPT DB 'ENTER MAX NUMBER OF CHARACTERS (1 to 10): $'  ; Prompt for max input
MAX_INPUT DB 0   ; To store the user-specified maximum input

.CODE
MAIN PROC
    ; INITIALIZE DATA SEGMENT
    MOV AX, @DATA
    MOV DS, AX

    ; PRINT MESSAGE 1
    LEA DX, MSG1
    MOV AH, 9
    INT 21H

    ; INPUT CHARACTERS UNTIL MAX_INPUT
    MOV CL, 0          ; Set counter to zero (for the number of characters entered)
    MOV AL, [MAX_INPUT] ; Load max input value into AL

INPUT_LOOP:
    MOV AH, 1          ; Read a character
    INT 21H            ; DOS interrupt for input
    CMP AL, 0DH        ; Check if ENTER key is pressed
    JE DONE_INPUT      ; Jump to done if ENTER is pressed

    PUSH AX            ; Push the character onto the stack
    INC CL             ; Increment the character count
    CMP CL, AL         ; Compare counter with max input
    JAE DONE_INPUT     ; Exit loop if max input reached
    JMP INPUT_LOOP     ; Otherwise, repeat the input

DONE_INPUT:
    ; PRINT MESSAGE 2
    LEA DX, MSG2
    MOV AH, 9
    INT 21H

    ; POP AND DISPLAY CHARACTERS IN REVERSE ORDER
REVERSE_LOOP:
    POP AX
    MOV DL, AL
    MOV AH, 2
    INT 21H            ; Print character

    DEC CL             ; Decrement counter
    JNZ REVERSE_LOOP   ; Continue if counter is not zero

    ; TERMINATE PROGRAM
    MOV AH, 4CH
    INT 21H

END MAIN
MAIN ENDP
