%include "io.inc"

section .data
max dw 0

section .text
global CMAIN

findMax:
    CMP ecx, 2
    JE findMaxDW
    CMP ecx, 4
    JE findMaxDD
    PRINT_STRING "Неверно указан тип числа: "
    PRINT_DEC 4, ecx
    NEWLINE
    RET

findMaxDW:
    CMP ax, dx
    JG xMaxDW
    MOV [max], dx
    JMP findMaxEndDW
xMaxDW:
    MOV [max], ax
findMaxEndDW:
    PRINT_STRING "Максимум (2 байта): "
    PRINT_DEC 4, [max]
    NEWLINE
    RET

findMaxDD:
    CMP eax, edx
    JG xMaxDD
    MOV [max], edx
    JMP findMaxEndDD
xMaxDD:
    MOV [max], eax
findMaxEndDD:
    PRINT_STRING "Максимум (4 байта): "
    PRINT_DEC 4, [max]
    NEWLINE
    RET

CMAIN:
    MOV eax, 4
    MOV edx, 6
    MOV ecx, 2
    CALL findMax
    
    MOV eax, 10
    MOV edx, 5
    MOV ecx, 4
    CALL findMax
    
;вызов функции, тестирующий защиту "от дурака"
    MOV eax, 1
    MOV edx, 2
    MOV ecx, 3
    CALL findMax
    
    RET