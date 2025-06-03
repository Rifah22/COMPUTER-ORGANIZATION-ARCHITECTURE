.model small
.stack 100H
.data
  
msg db "Enter two character: $"                      
input db ?                                               

.code
main proc

    mov ax,@data                
    mov ds,ax

    
    mov ah,9                    
    lea dx,msg          
    int 21h                      
    
    mov ah,1
    int 21h                    
    mov input[0],al
    
    mov ah,1
    int 21h                    
    mov input[1],al                                  

    
    mov ah,2                    
    mov dl,10                   
    int 21h 
    mov dl,13                   
    int 21h
    
    mov ah,2                   
    mov dl,input[0] 
    int 21h 
    mov dl,input[1] 
    int 21h                                  

    mov dl, 10                   
    int 21h
    mov dl, 13                   
    int 21h
    
    mov ah,2                   
    mov dl,input[0] 
    int 21h 
    mov dl,input[1] 
    int 21h                       

    Exit:
    mov ah, 4ch                  
    int 21h                      
    main endp
end main

    






