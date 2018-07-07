section .bss

digit1: resw 1 
sum: resw 1
count: resw 1
array: resw 100
arlen: resw 1
temp: resw 1
check: resw 1
fact: resw 1

section .data

msg2: db "Enter the element: "
msglen2: equ $-msg2
newline: db 10
space: db 32
first: dw 0
second: dw 1
zero: dw "0"

section .text
global _start
_start:

mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, msglen2
int 80h

call read

mov bx , word[sum]

mov word[fact], bx
call factorial
mov ax, word[fact]
mov word[sum], ax
call print
call print_newline

mov eax, 1
mov ebx, 0
int 80h


print_space:

pusha

mov eax, 4
mov ebx, 1
mov ecx, space
mov edx, 1
int 80h

popa
ret

print_newline:

pusha

mov eax, 4
mov ebx, 1
mov ecx, newline
mov edx, 1
int 80h

popa
ret

read:

pusha

mov word[sum], 0

l1:

mov eax, 3
mov ebx, 0
mov ecx, digit1
mov edx, 1
int 80h

cmp word[digit1], 32
je exit1

cmp word[digit1], 10
je exit1

sub word[digit1], 30h

mov ax, word[sum]
mov dx, 10
mul dx
add ax, word[digit1]
mov word[sum], ax

jmp l1
exit1:

popa 
ret

print:

pusha

mov word[count], 0
cmp word[sum], 0
jne l2
pusha
mov eax, 4
mov ebx, 1
mov ecx, zero
mov edx, 1
int 80h
popa
jmp exit2

l2:

cmp word[sum], 0
je l3

mov dx, 0
mov ax, word[sum]
mov bx, 10
div bx
mov word[sum], ax

push dx
inc word[count]
jmp l2

l3:

cmp word[count], 0
je exit2

pop dx
mov word[digit1], dx
add word[digit1], 30h

mov eax, 4
mov ebx, 1
mov ecx, digit1
mov edx, 1
int 80h

dec word[count]
jmp l3

exit2:

popa
ret


factorial:

pusha 
cmp bx, 0
je exit0
cmp bx,1
je exito
dec bx
call factorial
mov dx, 0
mov ax,word[fact]
mul bx
mov word[fact], ax
exito:
popa
ret
exit0:
mov word[fact], 1
jmp exito