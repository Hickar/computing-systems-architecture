%include "io.inc"

%macro printValue 2
    PUSH edx
    MOV edx, %1
    MOV [temp], edx
    PRINT_STRING %2
    PRINT_DEC [temp]
    POP edx
%endmacro

section .data
Arr dw 7, 8, 6, 1, 3, 2, 6, 2
size dw 7
min dw 0
maxIndex dw 0
temp dw 0

section .text
global CMAIN

; ax - хранит промежуточное значение минимума
; ebx - указатель на n-ый элемент массива
; cx - хранит количество циклов
findMin:
    MOV ebx, Arr+2
    MOV cx, [Arr]
    MOV ax, [ebx]
compareMin:
    CMP ax, [ebx]
    JL loopMin
    MOV ax, [ebx]
loopMin:
    ADD ebx, 2
    DEC cx
    JNZ compareMin
printMin:
    MOV [min], ax
    PRINT_STRING "Минимум: "
    PRINT_DEC [min]
    NEWLINE
    XOR eax, eax
    XOR ebx, ebx
    XOR ecx, ecx
    RET
    
selectionSort:
    ;ebx - указатель на n-ый элемент массива
    ;cx - размер массива
    ;esi - i
    ;edi - j
    ;ax, dx - хранят сравниваемые элементы массива
    MOV ebx, Arr+2 ;arr[]
    MOV cx, [Arr]
    DEC cx ;size - 1
    MOV esi, 0 ;i
    MOV edi, 0 ;j
outerLoopSort:
    CMP si, cx
    JE sortEnd
    MOV [maxIndex], si ;maxIndex = i
    MOV di, si
    ADD di, 1
    PUSH cx
    MOV cx, [Arr]
    CALL innerLoopSort
    POP cx
    INC si
    JMP outerLoopSort
sortEnd:
    RET
innerLoopSort:
    CMP di, cx 
    JE swapSort
    PUSH ecx
compareSort:
    ;на время освобождаем cx для хранения в нёи maxIndex
    MOV cx, [maxIndex]
    MOV ax, [ebx+2*edi] ;arr[j]
    MOV dx, [ebx+2*ecx] ;arr[maxIndex]
    INC di
    POP ecx
    CMP ax, dx
    JNG innerLoopSort
    DEC di
    MOV [maxIndex], di
    JMP innerLoopSort
swapSort:
    ;освобождаем edi для хранения в нём временной переменной
    PUSH di
    PUSH cx
    MOV di, 0
    MOV cx, [maxIndex]
    MOV ax, [ebx+2*esi] ;arr[i] 
    MOV dx, [ebx+2*ecx] ;arr[maxIndex]
    MOV di, ax ;c = a
    MOV [ebx+2*esi], dx ;a = b
    MOV [ebx+2*ecx], di ;b = c
    POP di
    POP cx
    RET
    
printArray:
    MOV ebx, Arr+2
    MOV cx, 0
loopPrint:
    CMP cx, [size]
    JE loopPrintEnd
    MOV eax, [ebx+2*ecx]
    MOV [temp], eax
    PRINT_DEC [temp]
    PRINT_STRING " "
    INC ecx
    CMP ecx, [size]
    JMP loopPrint
loopPrintEnd:
    RET
    

CMAIN:
    CALL findMin
    PRINT_STRING "Неупорядоченный массив: "
    CALL printArray
    CALL selectionSort
    PRINT_STRING "Упорядоченный массив: "
    CALL printArray
    
    MOV eax, 1
    MOV ebx, 0
    RET