; This is your structure
struc  my_date
    .day: resw 1
    .month: resw 1
    .year: resd 1
endstruc

section .text
    global ages

; void ages(int len, struct my_date* present, struct my_date* dates, int* all_ages);
ages:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; present
    mov     edi, [ebp + 16] ; dates
    mov     ecx, [ebp + 20] ; all_ages
    ;; DO NOT MODIFY

    ;; TODO: Implement ages
    ;; FREESTYLE STARTS HERE

    ;;am interschimbat continutul lui edx cu cel al lui ecx
    ;;in eax am retinut diferenta dintre anul curent si cel 
    ;;al nasterii
    ;;apoi am comparat lunile si in functie de rezultatul
    ;;comparatiei am ajuns sa comparam si zilele sau pur
    ;;si simplu scadem un an din eax

    xchg edx , ecx
for_loop:
    mov eax , [esi+my_date.year]
    sub eax , [edi+(ecx-1)*8+my_date.year]
    mov bx , [edi+(ecx-1)*8+my_date.month]
    cmp bx , [esi+my_date.month]
    jle skip
    dec eax
    jmp end_loop

skip:   
    jne end_loop
    mov bx , [edi+(ecx-1)*8+my_date.day]
    cmp bx , [esi+my_date.day]
    jle end_loop
    dec eax

end_loop:
    cmp eax , 0
    jge skip2
    mov eax , 0

skip2:
    mov [edx+(ecx-1)*4] , eax
    loop for_loop



    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
