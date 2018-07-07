section .bss

digit0: resb 1
digit1: resb 1
array: resb 50            ;Array to store 50 elements of 1 byte each.
num: resb 1
temp: resb 1
ele: resb 1
junk: resb 1
digit2: resb 1
digit3: resb 1


section .data

msg1: db "Enter the number of elements : "
size1: equ $-msg1
msg2: db "Enter a number:"
size2: equ $-msg2
msg_even: db "No. of even numbers: "
size_even: equ $-msg_even
msg_odd: db "No. of odd numbers: "
size_odd: equ $-msg_odd
countere: db 0
countero: db 0

section .text
global _start
_start:

;Printing the message to enter the size

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, size1
int 80h

;Reading the number

mov eax, 3
mov ebx, 0
mov ecx, digit1
mov edx, 1
int 80h

mov eax, 3
mov ebx, 0
mov ecx, digit0
mov edx, 1
int 80h

mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h

sub byte[digit1], 30h
sub byte[digit0], 30h

mov al, byte[digit1]
mov dl, 10
mul dl
add al, byte[digit0]
mov byte[num],al
mov byte[temp], al
mov ebx, array

reading:

cmp byte[temp], 0
jng after_reading

push ebx             ;Preserving The value of ebx in stack

;Printing the message to enter each element

mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, size2
int 80h

;Reading the number
mov eax, 3
mov ebx, 0
mov ecx, digit1
mov edx, 1
int 80h

mov eax, 3
mov ebx, 0
mov ecx, digit0
mov edx, 1
int 80h

mov eax, 3
mov ebx, 0
mov ecx, junk
mov edx, 1
int 80h

sub byte[digit1], 30h
sub byte[digit0], 30h

mov al, byte[digit1]
mov dl, 10
mul dl
add al, byte[digit0]

;al now contains the number

pop ebx
mov byte[ebx], al
add ebx, 1
dec byte[temp]
jmp reading

after_reading:

cmp byte[num], 0
je print

;Comparing loop variable
;Loop using branch statements

movzx ecx, byte[num]
mov ebx, array

searching:

;push ecx

movzx ax, byte[ebx]
mov dl, 2
div dl
cmp ah, 0
je even

odd:
inc byte[countero]
jmp next

even:
inc byte[countere]
jmp next

next:

add ebx, 1

;pop ecx
;dec ecx
;cmp ecx, 0
dec byte[num]
cmp byte[num], 0
jg searching
;loop searching

print:

mov eax, 4
mov ebx, 1
mov ecx, msg_even
mov edx, size_even
int 80h

movzx ax, byte[countere]
mov dl, 10
div dl
mov byte[digit1], al
mov byte[digit0], ah

add byte[digit0], 30h
add byte[digit1], 30h

mov eax, 4
mov ebx, 1
mov ecx, digit1
mov edx, 1
int 80h

mov eax, 4
mov ebx, 1
mov ecx, digit0
mov edx, 1
int 80h

mov byte[junk], 10

mov eax, 4
mov ebx, 1
mov ecx, junk
mov edx, 1
int 80h

mov eax, 4
mov ebx, 1
mov ecx, msg_odd
mov edx, size_odd
int 80h

movzx ax, byte[countero]
mov dl, 10
div dl
mov byte[digit1], al
mov byte[digit0], ah

add byte[digit0], 30h
add byte[digit1], 30h

mov eax, 4
mov ebx, 1
mov ecx, digit1
mov edx, 1
int 80h

mov eax, 4
mov ebx, 1
mov ecx, digit0
mov edx, 1
int 80h

mov byte[junk], 10

mov eax, 4
mov ebx, 1
mov ecx, junk
mov edx, 1
int 80h

exit:

mov eax, 1
mov ebx, 0
int 80h