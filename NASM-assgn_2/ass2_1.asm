section .bss

digit0: resb 1
digit1: resb 1
array: resb 50            ;Array to store 50 elements of 1 byte each.
;counter: resb 1
num: resb 1
temp: resb 1
ele: resb 1
junk: resb 1
digit2: resb 1
digit3: resb 1
no1: resb 1
no2: resb 1

section .data

msg1: db "Enter the number of elements : "
size1: equ $-msg1
msg2: db "Enter a number:"
size2: equ $-msg2
msg3: db "Enter the factors:"
size3: equ $-msg3
msg_multiple: db "Multiples : ",10
size_multiple: equ $-msg_multiple
msg_no_multiple: db "No multiples found"
size_no_multiple: equ $-msg_no_multiple
counter: db 0

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
cmp byte[temp], 0
jg reading

;Comparing loop variable
;Loop using branch statements

mov eax, 4
mov ebx, 1
mov ecx, msg3
mov edx, size3
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

mov eax, 3
mov ebx, 0
mov ecx, digit3
mov edx, 1
int 80h

mov eax, 3
mov ebx, 0
mov ecx, digit2
mov edx, 1
int 80h

mov eax, 3
mov ebx, 0
mov ecx, junk
mov edx, 1
int 80h

sub byte[digit1], 30h
sub byte[digit0], 30h
sub byte[digit3], 30h
sub byte[digit2], 30h

mov al, byte[digit1]
mov dl, 10
mul dl
add al, byte[digit0]
mov byte[no1], al

mov al, byte[digit3]
mov dl, 10
mul dl
add al, byte[digit2]
mov byte[no2], al

;movzx ecx, byte[num]
;mov ecx, dword[num]
mov ebx, array
;mov byte[counter], 0

searching:
;push ecx

movzx ax, byte[ebx]
mov dl, byte[no1]
div dl
cmp ah, 0
jne next

second:
movzx ax, byte[ebx]
mov dl, byte[no2]
div dl
cmp ah, 0
jne next

push ebx

cmp byte[counter], 0
jne print

mov eax, 4
mov ebx, 1
mov ecx, msg_multiple
mov edx, size_multiple
int 80h

inc byte[counter]

print:

pop ebx

movzx ax, byte[ebx]
mov dl, 10
div dl

push ebx

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

pop ebx

next:

add ebx, 1

;pop ecx
;dec ecx
;cmp ecx, 0
dec byte[num]
cmp byte[num], 0
jg searching
;loop searching

cmp byte[counter], 0
je no_multiple

exit:

mov eax, 1
mov ebx, 0
int 80h

no_multiple:

mov eax, 4
mov ebx, 1
mov ecx, msg_no_multiple
mov edx, size_no_multiple
int 80h

jmp exit