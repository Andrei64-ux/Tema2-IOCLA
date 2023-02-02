section .data
    extern len_cheie, len_haystack

section .text
    extern printf
    global columnar_transposition

;; void columnar_transposition(int key[], char *haystack, char *ciphertext);
columnar_transposition:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha 

    mov edi, [ebp + 8]   ;key
    mov esi, [ebp + 12]  ;haystack
    mov ebx, [ebp + 16]  ;ciphertext
    ;; DO NOT MODIFY

    ;; TODO: Implment columnar_transposition
    ;; FREESTYLE STARTS HERE
    mov eax, 0
    mov ecx, 0

    ;;Am retinut in eax un contor pentru
    ;;elementele din ciphertext , iar in ecx
    ;;un contor pentru a parcurge vectorul key[]
    ;;Am comparat elementele din key[] cu lungimea
    ;;plaintext-ului 
    ;;Am adaugat pe stiva registrul edx pentru a-l 
    ;;avea nemodificat si am folosit din edx doar dl
    ;;al carui continut il scriam in ciphertext la 
    ;;indexul respectiv

for_loop:
    cmp ecx , [len_cheie]
    jge end_for
    mov edx, [edi + 4*ecx]

while:
    cmp edx, [len_haystack]
    jge end_while
        
    push edx
    mov dl, [esi + edx]
    mov [ebx + eax], dl
    pop edx
    inc eax
    add edx , [len_cheie]
    jmp while

end_while:
    inc ecx
    jmp for_loop

end_for:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY