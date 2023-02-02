;; defining constants, you can use these as immediate values in your code
CACHE_LINES  EQU 100
CACHE_LINE_SIZE EQU 8
OFFSET_BITS  EQU 3
TAG_BITS EQU 29 ; 32 - OFSSET_BITS

section .text
    global load
    extern printf

;; void load(char* reg, char** tags, char cache[CACHE_LINES][CACHE_LINE_SIZE], char* address, int to_replace);
load:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; address of reg
    mov ebx, [ebp + 12] ; tags
    mov ecx, [ebp + 16] ; cache
    mov edx, [ebp + 20] ; address
    mov edi, [ebp + 24] ; to_replace (index of the cache line that needs to be replaced in case of a cache MISS)
    ;; DO NOT MODIFY

    ;; TODO: Implment load
    ;; FREESTYLE STARTS HERE
    
    mov esi, edx
    shr esi, 3
    push esi ;; se afla la -> [ebp - 36] => tag-ul adresei
    
    mov esi, edx
    and esi, 7
    push esi ;; se afla la -> [ebp - 40] => index
    
    mov esi, 0
    push esi ;; se afla la -> [ebp - 44] => o variabila ok 0 sau 1
    
    push esi ;; se afla la -> [ebp - 48] => un contor i

    ;;verificam cazul CACHE HIT
start_search:
    cmp DWORD [ebp-48] , CACHE_LINES    ;; compar i cu nr de linii
    jge end_search
    
    ;;compar elementul de la tags[i] cu
    ;;tag-ul adresei
    mov esi , [ebp - 48] ;; esi = i
    mov esi , [ebx + esi] ;; esi = tags[i]
    cmp esi, [ebp - 36]
    jne not_found
    
    ;;ok devine 1
    mov DWORD [ebp - 44], 1

    ;;in registrul reg avem elementul din 
    ;;matricea cache de pe pozitiile i si index
    mov esi, [ebp - 48]
    shl esi, 3
    add esi, [ebp - 40]
    movzx esi, BYTE [ecx + esi]
    mov [eax], esi
    jmp end_search

    ;;daca nu exista egalitate intre tags[i]
    ;;si tag-ul adresei
not_found:
    inc DWORD [ebp-48]
    
    jmp start_search

    ;;verificam cazul CACHE MISS
end_search:
    cmp DWORD [ebp-44] , 0
    jne end_func
    
    mov DWORD [ebp-48] , 0

    ;;adaugam pe stiva eax , pentru a-i pastra
    ;;continutul , dar si pentru a obtine un alt
    ;;registru de care sa ne folosim
    ;;La elementul de pe pozitia to_replace si i
    ;;adaugam tag-ul adresei shiftat la stanga cu 3
    ;;adunat cu 1
start_copy:
    cmp DWORD [ebp-48] , CACHE_LINE_SIZE
    jge end_copy

    push eax
            
    mov eax, edi
    shl eax, 3
    add eax, [ebp - 48]
            
    mov esi, [ebp-36]
    shl esi, 3
    add esi, [ebp - 48]
    movzx esi, BYTE [esi]

    xchg eax , esi
    mov BYTE [ecx + esi], al
    pop eax

    inc DWORD [ebp-48]
    jmp start_copy

    ;;la indexul to_replace din tags 
    ;;punem tag-ul adresei
end_copy:
    mov esi, [ebp - 36]
    mov [ebx + edi], esi
    
    mov esi, [ebp-36]
    shl esi, 3
    add esi, [ebp - 40]
    
    push ebx
    mov bl , [esi]
    mov [eax], bl
    pop ebx

    ;;readucem stiva in starea initiala
end_func:
    add esp , 16
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY


