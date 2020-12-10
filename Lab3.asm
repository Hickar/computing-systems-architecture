%include "io.inc"

;������������ ���������� �������� ������ ��

section .data
Arr times 250 dd -6FFFFFFFh ;���������� ������ �� 31-��������� �����
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
    JO handleOverflow
;���� ���������� ������������, �� ���������� ������� ��
;�������� edx, ������� ����� ������� ������� ���� �������� ��������
    INC ecx
    JMP findLoop
handleOverflow:
    MOV eax, eax
    JS handlePositiveOverflow
    SUB edx, 1b
    INC ecx
    JMP findLoop
handlePositiveOverflow:
    ADD edx, 1b
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
    PRINT_STRING "������� ��������������: "
    PRINT_DEC 4, [average]
    RET