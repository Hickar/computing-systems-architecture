%include "io.inc"

section .data
Arr times 250 dd -3FFFFFFh;
average dd 0
size dw 250
tmp dw 0

section .text
global CMAIN

;eax - аккумулятор
;ebx - указатель на n-ый элемент массива
;ecx - значение итерации цикла
;edx - регистр, хранящий значение старших 32 бит при переполнении
;esi - временно хранит значение, которое в последствии прибавляется/вычитается к/из аккумулятора
findAverage:
    MOV eax, 0
    MOV ecx, 0
    MOV edx, 0
findLoop:
    CMP ecx, [size]
    JE calculateAverage
    MOV esi, [ebx+4*ecx]
    CMP esi, 0
    JNS handlePositive
handleNegative:
    NEG esi
    SUB eax, esi
    SBB edx, 0
    INC ecx
    JMP findLoop
handlePositive:
    ADD eax, esi
    ADC edx, 0
    INC ecx
    JMP findLoop
calculateAverage:
    IDIV ecx
    MOV [average], eax
    RET

CMAIN:
    MOV ebp, esp; for correct debugging
    MOV ebx, Arr
    CALL findAverage
    PRINT_STRING "Среднее арифметическое: "
    PRINT_DEC 4, [average]
    RET