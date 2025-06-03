.MODEL SMALL
.STACK 100H
.DATA 
MSG1 DB 'TYPE A CHARACTER:$';
MSG2 DB 0DH,0AH, 'THE ASCII CODE OF $';
MSG3 DB 'IN BINARY IS $';
MSG4 DB 0DH,0AH, 'THE NUMBER OF 1 BITS IS $';

.CODE   
MAIN PROC
    ; INITIALIZE DATA SEGMENT
    MOV AX, @DATA         
    MOV DS, AX             
    
    ; PRINT MESSAGE 1
    LEA DX, MSG1           
    MOV AH, 9             
    INT 21H               
    
    ; TAKE INPUT
    MOV AH, 1             
    INT 21H             
    
    XOR BX, BX; CLEAR BX REGISTER        
    MOV BL, AL; STORE THE INPUT INTO BL REGISTER             
    
    ; PRINT MESSAGE 2
    LEA DX, MSG2           
    MOV AH, 9              
    INT 21H               
    
    ; DISPLAY ASCII CODE
    MOV DL, BL; STORE THE INPUT INTO DL REGISTER             
    MOV AH, 2;DISPLAY THE INPUT             
    INT 21H               
    
    ; PRINT MESSAGE 3
    LEA DX, MSG3           
    MOV AH, 9              
    INT 21H               
    
    ; BINARY CONVERSION
    MOV CX, 8; LOOP SET TO 8 FOR 8 BITS            
    MOV BH, 0; CLEAR BH TO STORE THE COUNT OF 1 BITS          
    
BINARY:
    SHL BL, 1; SHIFT BL LEFT BY 1 BITS,MSB GOES TO CF           
    JNC ZERO; IF CF=0 THEN JUMP TO ZERO LABEL              
    INC BH;IF CF=1 THEN INCREMENT BH 1-BIT COUNTER               
    MOV DL, 31H;LOAD THE ASCII VALUE OF FIRST CHARACTER            
    JMP DISPLAY;JUMP TO THE DISPLAY LABEL           
    
ZERO:
    MOV DL, 30H;STORE ASCII VALUE OF 0           
    
DISPLAY:
    ;PRINT THE ASCII VALUE
    MOV AH, 2              
    INT 21H                
    
    LOOP BINARY;GO TO THE BINARY LABEL           
    
    ; DISPLAY COUNT OF 1 BITS
    ADD BH, 30H;CONVERT COUNT OF 1-BITS INTO BH TO ASCII
    ;PRINT MESSAGE 4          
    LEA DX, MSG4        
    MOV AH, 9           
    INT 21H             
    ;PRINT THE NUMBER OF BH
    MOV DL, BH             
    MOV AH, 2              
    INT 21H              
    
    ; EXIT PROGRAM
    MOV AH, 4CH          
    INT 21H               
    
END MAIN
MAIN ENDP
