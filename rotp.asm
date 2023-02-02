section .text
    global rotp

;; void rotp(char *ciphertext, char *plaintext, char *key, int len);
rotp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; ciphertext
    mov     esi, [ebp + 12] ; plaintext
    mov     edi, [ebp + 16] ; key
    mov     ecx, [ebp + 20] ; len
    ;; DO NOT MODIFY

    ;; TODO: Implment rotp
    ;; FREESTYLE STARTS HERE
    
    ;;am pus in ebx un contor care incepe de la 0
    ;;am folosit registrul al pentru a parcurge caracter cu caracter
    ;;am aplicat xor si am mutat in edx rezultatul
    
    mov ebx , 0
for_loop:
    mov al , [esi+ebx]
    xor al , [edi+ecx-1]
    mov [edx+ebx] , al
    inc ebx
    loop for_loop

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY