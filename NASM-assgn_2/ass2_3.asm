section .bss

digit0: resb 1
digit1: resb 1
array: resb 50            ;Array to store 50 elements of 1 byte each.
element: resb 1
num: resb 1
temp: resb 1
temp1: resb 1
ele: resb 1
junk: resb 1

section .data

msg1: db "Enter the number of elements : "
size1: equ $-msg1
msg2: db "Enter a number:"
size2: equ $-msg2
i: db 0
j: db 0

section .text
global _start
_start:

;Printing the message to enter the number

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
mov byte[num], al
mov al, byte[digit0]
add byte[num], al

mov al, byte[num]
mov byte[temp], al
mov al, byte[num]
mov byte[temp1], al
mov byte[i], al
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
;Reading the number to be searched :.....

mov ebx, array
dec byte[i]

loop1:

mov ebx, array
cmp byte[i], 0
je out3

mov byte[j], 0
;mov al, byte[i]

loop2:

mov ebx, array
mov al, byte[i]
mov cl, byte[j]
cmp byte[j], al
je n

move:
cmp cl, 0
je out2
inc ebx
dec cl
jmp move

out2:
mov dl, byte[ebx]
inc ebx
cmp byte[ebx], dl
ja swap

a:
inc byte[j]
jmp loop2

n:
dec byte[i]
jmp loop1

swap:

mov cl, byte[ebx]
mov byte[ebx], dl
dec ebx
mov byte[ebx], cl
jmp a

out3:

mov ebx, array


out1:

cmp byte[temp1], 0
je exit

movzx ax, byte[ebx]
mov dl, 10
div dl
mov byte[digit1], al
mov byte[digit0], ah

push ebx

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
inc ebx
dec byte[temp1]
jmp out1

exit:

mov eax, 1
mov ebx, 0
int 80h

