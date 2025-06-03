.MODEL SMALL
.STACK 100H
.DATA
PROMPT DB 'ENTER A CHARACTER: $';
MSG_UPPER DB 'CONVERTED TO UPPER CASE: $';
MSG_LOWER DB 'CONVERTED TO LOWER CASE: $';
MSG_NOT_LETTER DB 'INPUT IS NOT A LETTER.$';
INPUT_CHAR DB ?;

.CODE
MAIN PROC
    MOV AX,@DATA ;
    MOV DS,AX;
     
    ;PRINT PROMPT 
    MOV AH,9;
    LEA DX,PROMPT;
    INT 21H;
    
    MOV AH,1;
    INT 21H;      
    MOV BL,AL;
    
    CMP BL, 'A';
    JB NOT_LETTER;
    CMP BL, 'Z';
    JBE UPPER_CASE;
    CMP BL, 'a';
    JB NOT_LETTER;
    CMP BL,'z'
    JA NOT_LETTER; 
    
    LOWER_CASE:
    ;CONVERT TO UPPER CASE
    AND BL,11011111B;   
    ;PRINT RESULT 
    MOV AH,2;
    MOV DL,0DH;
    INT 21H;
    MOV DL,0AH;
    INT 21H;
    MOV AH,9;
    LEA DX,MSG_UPPER;
    INT 21H;
    
    MOV AH,2;
    MOV DL,BL;
    INT 21H;
    JMP EXIT_PROGRAM;
    
    UPPER_CASE:
    ;CONVERT TO LOWER CASE
    OR BL,00100000B
    ;PRINT RESULT 
    MOV AH,2;
    MOV DL,0DH;
    INT 21H;
    MOV DL,0AH;
    INT 21H;
    MOV AH,9;
    LEA DX,MSG_LOWER;
    INT 21H;
    
    MOV AH,2;
    MOV DL,BL;
    INT 21H;
    JMP EXIT_PROGRAM;
    
    NOT_LETTER:
    ;PRINT ERROR MESSAGE  
    MOV AH,2;
    MOV DL,0DH;
    INT 21H;
    MOV DL,0AH;
    INT 21H;
    MOV AH,9
    LEA DX,MSG_NOT_LETTER;
    INT 21H;     
    
    
    EXIT_PROGRAM:
    MOV AH,4CH;
    INT 21H;
    
    MAIN ENDP
END MAIN
    
    
  
 
    
    
