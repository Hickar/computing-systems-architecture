%include "io.inc"

;������������ ���������� �������� ������ ��

section .data
Arr times 250 dd 7FFFFFFFh ;���������� ������ �� 31-��������� �����
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
;���� ���������� ������������, �� ������������ ������� �
;�������� edx, ������� ����� ������� ������� ���� �������� ��������
    INC ecx
    JMP findLoop
handleOverflow:
    ADD edx, 1b
    INC ecx
    JMP findLoop
calculateAverage:
;��������� �� ������� 64-������� ����� ������������ � eax
    PRINT_STRING "��������, ���������� � �������������� 32-������ ������� ��� ������������: "
    NEWLINE
    PRINT_HEX 4, edx
    PRINT_STRING " = 111 1100 = 7 �������������� ���"
;��� �������������� ���������� ������������� 32 + 7 = 39 ���
    NEWLINE
    NEWLINE
    DIV ecx
    MOV [average], eax
    RET

CMAIN:
    mov ebp, esp; for correct debugging
    MOV ebx, Arr
    CALL findAverage
    PRINT_STRING "������� ��������������: "
    PRINT_DEC 4, [average]
    RET