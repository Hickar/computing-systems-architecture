%include "io.inc"

section .data
min dw 0

section .text
global CMAIN

findMin:
    CMP ecx, 2
    JE findMinDW
    CMP ecx, 4
    JE findMinDD
    PRINT_STRING "Неверно указан тип числа: "
    PRINT_DEC 4, ecx
    NEWLINE
    RET

findMinDW:
    CMP ax, dx
    JL xMinDW
    MOV [min], dx
    JMP findMinEndDW
xMinDW:
    MOV [min], ax
findMinEndDW:
    PRINT_STRING "Минимум (2 байта): "
    PRINT_DEC 4, [min]
    NEWLINE
    RET

findMinDD:
    CMP eax, edx
    JL xMinDD
    MOV [min], edx
    JMP findMinEndDD
xMinDD:
    MOV [min], eax
findMinEndDD:
    PRINT_STRING "Минимум (4 байта): "
    PRINT_DEC 4, [min]
    NEWLINE
    RET

CMAIN:
    MOV eax, 4
    MOV edx, 6
    MOV ecx, 2
    CALL findMin
    
    MOV eax, 10
    MOV edx, 5
    MOV ecx, 4
    CALL findMin
    
;вызов функции, тестирующий защиту "от дурака"
    MOV eax, 1
    MOV edx, 2
    MOV ecx, 3
    CALL findMin
    
    RET