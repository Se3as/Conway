section .data
    
    hop db 10, 0
    one db '1', 0
    zero db '0', 0
    blanc db ' ', 0
    none db '9', 0



    grid db 1, 1 ,0, 0, 0
            db 0, 0, 0, 1, 0
            db 0, 1, 0, 0, 0
            db 1, 1, 1, 1, 1
            db 0, 1, 1, 0, 1

section .text
    global _start


_start:
    call printer

    call deadspace




    call check_neighbours



    call ejected


printer:
    xor esi, esi

print_row:
    cmp esi, 5
    jge printed

    xor edi, edi

print_col:
    cmp edi, 5
    jge next_row

    ; indice del arr[][]
    mov ebx, esi
    imul ebx, 5
    add ebx, edi

    ; analizo si es 0 y salto o 1 e imprimo
    mov al, [grid + ebx]
    cmp al, 0
    je print_zero

    ; era 1
    mov eax, 4      
    mov ebx, 1      
    mov ecx, one
    mov edx, 1
    int 0x80

    ; Imprimir espacio
    mov eax, 4
    mov ebx, 1
    mov ecx, blanc
    mov edx, 1
    int 0x80


    jmp advance_col


print_zero:
    mov eax, 4      
    mov ebx, 1     
    mov ecx, zero
    mov edx, 1
    int 0x80

    ; Imprimir espacio
    mov eax, 4
    mov ebx, 1
    mov ecx, blanc
    mov edx, 1
    int 0x80


advance_col:
    inc edi
    jmp print_col


next_row:
    mov eax, 4      
    mov ebx, 1       
    mov ecx, hop
    mov edx, 1
    int 0x80

    inc esi
    jmp print_row

printed:
    ret






; OTRA COSA
check_neighbours:
    xor esi, esi
    xor edi, edi
    xor eax, eax
    xor ebx, ebx

    mov esi, 0  ; X de el array[][]
    mov edi, 0  ; Y de el array[][]

    call delimiter



right_neighbour:
    ; calcula el indice ne el arr[][]
    mov eax, esi
    imul eax, 5
    add eax, edi

    ;BUSCAR A LA DERECHA
    ; arr[x + 1][y]
    inc eax

    cmp eax, 0
    jl left_neighbour

    cmp eax, 24
    jg left_neighbour

    ; buscar 1
    mov al, [grid + eax]
    cmp al, 1
    
    ; si es 0
    jne right_zero
    ; si es 1
    je right_one


left_neighbour:
    ;BUSCAR A LA IZQUIERDA
    ; arr[x - 1][y]
    mov eax, esi
    imul eax, 5
    add eax, edi

    dec eax

    cmp eax, 0
    jl upper_neighbour

    cmp eax, 24
    jg upper_neighbour


    ; buscar 1 
    mov al, [grid + eax]
    cmp al, 1
    ; si es 0
    jne left_zero
    ; si es 1
    je left_one


upper_neighbour:
    ;BUSCAR ARRIBA
    ; arr[x][y - 1]
    mov eax, esi
    imul eax, 5
    add eax, edi

    sub eax, 5

    cmp eax, 0
    jl down_neighbour

    cmp eax, 24
    jg down_neighbour


    ; buscar 1 
    mov al, [grid + eax]
    cmp al, 1
    ; si es 0
    jne up_zero
    ; si es 1
    je up_one


down_neighbour:
    ;BUSCAR ABAJO
    ; arr[x][y + 1]
    mov eax, esi
    imul eax, 5
    add eax, edi

    add eax, 5

    cmp eax, 0
    jl up_right_neighbour

    cmp eax, 24
    jg up_right_neighbour


    ; buscar 1 
    mov al, [grid + eax]
    cmp al, 1
    ; si es 0
    jne down_zero
    ; si es 1
    je down_one


up_right_neighbour:
    ;BUSCAR ARRIBA DERECHA
    ; arr[x + 1][y - 1]
    mov eax, esi
    imul eax, 5
    add eax, edi

    sub eax, 4

    cmp eax, 0
    jl up_left_neighbour

    cmp eax, 24
    jg up_left_neighbour


    ; buscar 1 
    mov al, [grid + eax]
    cmp al, 1
    ; si es 0
    jne up_right_zero
    ; si es 1
    je up_right_one



up_left_neighbour:
    ;BUSCAR ARRIBA IZQUIERDA
    ; arr[x - 1][y - 1]
    mov eax, esi
    imul eax, 5
    add eax, edi

    sub eax, 6

    cmp eax, 0
    jl down_right_neighbour

    cmp eax, 24
    jg down_right_neighbour


    ; buscar 1 
    mov al, [grid + eax]
    cmp al, 1
    ; si es 0
    jne up_left_zero
    ; si es 1
    je up_left_one


down_right_neighbour:
    ;BUSCAR ABAJO DERECHA
    ; arr[x + 1][y + 1]
    mov eax, esi
    imul eax, 5
    add eax, edi

    add eax, 6

    cmp eax, 0
    jl outlander

    cmp eax, 24
    jg outlander


    ; buscar 1 
    mov al, [grid + eax]
    cmp al, 1
    ; si es 0
    jne down_left_zero
    ; si es 1
    je down_left_one


down_left_neighbour:
    ;BUSCAR ABAJO IZQUIERDA
    ; arr[x - 1][y + 1]
    mov eax, esi
    imul eax, 5
    add eax, edi

    add eax, 4

    cmp eax, 0
    jl outlander

    cmp eax, 24
    jg outlander


    ; buscar 1 
    mov al, [grid + eax]
    cmp al, 1
    ; si es 0
    jne down_left_zero
    ; si es 1
    je down_left_one


right_zero:
    mov eax, 4      
    mov ebx, 1     
    mov ecx, zero
    mov edx, 1
    int 0x80

    mov eax, 4      
    mov ebx, 1       
    mov ecx, hop
    mov edx, 1
    int 0x80

    call left_neighbour

right_one:
    mov eax, 4      
    mov ebx, 1     
    mov ecx, one
    mov edx, 1
    int 0x80

    mov eax, 4      
    mov ebx, 1       
    mov ecx, hop
    mov edx, 1
    int 0x80

    call left_neighbour


left_zero:
    mov eax, 4      
    mov ebx, 1     
    mov ecx, zero
    mov edx, 1
    int 0x80

    mov eax, 4      
    mov ebx, 1       
    mov ecx, hop
    mov edx, 1
    int 0x80

    call upper_neighbour
    

left_one:
    mov eax, 4      
    mov ebx, 1     
    mov ecx, one
    mov edx, 1
    int 0x80

    mov eax, 4      
    mov ebx, 1       
    mov ecx, hop
    mov edx, 1
    int 0x80

    call upper_neighbour


up_zero:
    mov eax, 4      
    mov ebx, 1     
    mov ecx, zero
    mov edx, 1
    int 0x80

    mov eax, 4      
    mov ebx, 1       
    mov ecx, hop
    mov edx, 1
    int 0x80

    call down_neighbour
    

up_one:
    mov eax, 4      
    mov ebx, 1     
    mov ecx, one
    mov edx, 1
    int 0x80

    mov eax, 4      
    mov ebx, 1       
    mov ecx, hop
    mov edx, 1
    int 0x80

    call down_neighbour



down_zero:
    mov eax, 4      
    mov ebx, 1     
    mov ecx, zero
    mov edx, 1
    int 0x80

    mov eax, 4      
    mov ebx, 1       
    mov ecx, hop
    mov edx, 1
    int 0x80

    call up_right_neighbour
    

down_one:
    mov eax, 4      
    mov ebx, 1     
    mov ecx, one
    mov edx, 1
    int 0x80

    mov eax, 4      
    mov ebx, 1       
    mov ecx, hop
    mov edx, 1
    int 0x80

    call up_right_neighbour



up_right_zero:
    mov eax, 4      
    mov ebx, 1     
    mov ecx, zero
    mov edx, 1
    int 0x80

    mov eax, 4      
    mov ebx, 1       
    mov ecx, hop
    mov edx, 1
    int 0x80

    call up_left_neighbour
    ;call ejected


up_right_one:
    mov eax, 4      
    mov ebx, 1     
    mov ecx, one
    mov edx, 1
    int 0x80

    mov eax, 4      
    mov ebx, 1       
    mov ecx, hop
    mov edx, 1
    int 0x80

    ;call ejected
    call up_left_neighbour


up_left_zero:
    mov eax, 4      
    mov ebx, 1     
    mov ecx, zero
    mov edx, 1
    int 0x80

    mov eax, 4      
    mov ebx, 1       
    mov ecx, hop
    mov edx, 1
    int 0x80

    call down_right_neighbour
    ;call ejected



up_left_one:
    mov eax, 4      
    mov ebx, 1     
    mov ecx, one
    mov edx, 1
    int 0x80

    mov eax, 4      
    mov ebx, 1       
    mov ecx, hop
    mov edx, 1
    int 0x80

    call down_right_neighbour
    ;call ejected



down_right_zero:
    mov eax, 4      
    mov ebx, 1     
    mov ecx, zero
    mov edx, 1
    int 0x80

    mov eax, 4      
    mov ebx, 1       
    mov ecx, hop
    mov edx, 1
    int 0x80

    call down_left_neighbour
    ;call ejected

down_right_one:
    mov eax, 4      
    mov ebx, 1     
    mov ecx, one
    mov edx, 1
    int 0x80

    mov eax, 4      
    mov ebx, 1       
    mov ecx, hop
    mov edx, 1
    int 0x80

    call down_left_neighbour
    ;call ejected

down_left_zero:
    mov eax, 4      
    mov ebx, 1     
    mov ecx, zero
    mov edx, 1
    int 0x80

    mov eax, 4      
    mov ebx, 1       
    mov ecx, hop
    mov edx, 1
    int 0x80

    call ejected


down_left_one:
    mov eax, 4      
    mov ebx, 1     
    mov ecx, one
    mov edx, 1
    int 0x80

    mov eax, 4      
    mov ebx, 1       
    mov ecx, hop
    mov edx, 1
    int 0x80

    call ejected






delimiter:
    ; si row < 0 esta afuera
    cmp esi, 0
    jl outlander

    ; si col < 0 esta afuera
    cmp edi, 0
    jl outlander

    ; si row > 4 esta afuera
    cmp esi, 4
    jg outlander

    ; si col > 4 esta afuera
    cmp edi, 4
    jg outlander

    ret


outlander:
    mov eax, 4      
    mov ebx, 1       
    mov ecx, none
    mov edx, 1
    int 0x80

    call deadspace

    call ejected



deadspace:
    mov eax, 4      
    mov ebx, 1       
    mov ecx, hop
    mov edx, 1
    int 0x80

    ret

ejected:
    mov eax, 1
    xor ebx, ebx
    int 0x80