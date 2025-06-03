.model small
.stack 100H
.data
a db 'Assembly Language$'
.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,9 
    lea dx,a
    int 21h
    
    mov ah,2
    mov dl,10
    int 21h
    
    mov dl,13
    int 21h
    
    mov cx,6
    mov ah,2
    mov dl,4
    
    level1: 
    add dl,'0'
    mov ah,2
    int 21h 
    sub dl,'0'
    inc dl
    loop level1
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main
    






