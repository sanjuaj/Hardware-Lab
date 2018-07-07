section .bss

digit1: resw 1
sum: resw 1
count: resw 1
array: resw 100
arlen: resw 1
temp: resw 1
square_sum: resw 1

section .data

msg2: db "Enter the elements: "
msglen2: equ $-msg2
newline: db 10
space: db 32
zero: db 30h
fmt1: db "\%d",0
fmt2: db "Square of the number is %\d",10

extern scanf
extern printf

;read1:

;push ebp

;mov ebp , esp

;sub esp , 2
;lea eax , [ ebp-2]
;push eax
;push fmt1
;call scanf
;mov ax, word [ebp-2]
;mov word[sum], ax
;mov esp , ebp
;pop ebp
;ret

;print1:

;push ebp

;mov ebp , esp

;sub esp , 2
;mov ax, word[sum]
;mov word[ebp-2], ax
;push fmt2
;call printf
;mov esp , ebp
;pop ebp
;ret

;main:

section .text
global _start
_start:

call read_array
call sum_of_squares

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

read_array:

pusha

mov ax, 10
mov word[temp], ax
mov word[arlen], ax
movzx ecx, ax

pusha
mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, msglen2
int 80h
popa

mov ebx, array

l4:

call read

mov ax, word[sum]
mov word[ebx],ax
add ebx, 2

loop l4

popa
ret

sum_of_squares:

pusha

mov esi, array
mov ecx, 10
mov word[square_sum], 0

l5:

lodsw

mov dx, 0
mov bx, ax
mul bx
add word[square_sum], ax

loop l5

mov ax,word[square_sum]
mov word[sum], ax
call print
call print_newline

popa
ret
