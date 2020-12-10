%include "io.inc"

section .data
Arr times 250 dd 7FFFFFFFh ;Инициализируем массив из 31-разрядных чисел
average dd 0
size dw 250

section .text
global CMAIN

findAverage:
    MOV eax, 0
    MOV ecx, 0
    MOV edx, 0
findLoop:
    CMP ecx, [size]
    JE calculateAverage
    ADD eax, [ebx+4*ecx]
    JC handleOverflow
;если происходит переполнение, то прибавляется единица к
;регистру edx, который будет хранить старшие биты будущего делимого
    INC ecx
    JMP findLoop
handleOverflow:
    ADD edx, 1b
    INC ecx
    JMP findLoop
calculateAverage:
;Результат от деления 64-разрядного значения записывается в eax
    PRINT_STRING "Значение, записанной в дополнительный 32-битный регистр при переполнении: "
    NEWLINE
    PRINT_HEX 4, edx
    PRINT_STRING " = 111 1100 = 7 дополнительных бит"
;Для промежуточного результата понадобилось 32 + 7 = 39 бит
    NEWLINE
    NEWLINE
    DIV ecx
    MOV [average], eax
    RET

CMAIN:
    MOV ebx, Arr
    CALL findAverage
    PRINT_STRING "Среднее арифметическое: "
    PRINT_DEC 4, [average]
    RET