section .bss

string: resw 100
temp: resw 100
char1: resw 1
strlen: resw 1
sum: resw 1
count: resw 1
digit: resw 1
count1: resw 1
temp1: resw 1
largest: resw 1
f: resw 1
temp2: resw 1

section .data

msg1: db "Enter the string: "
msglen1: equ $-msg1
newline: db 10
zero: db 48

section .text
global _start
_start:

call read_string
call print_string
call find_largest
mov ax, word[largest]
mov word[sum], ax
call print

mov eax, 1
mov ebx, 0
int 80h

read_string:

pusha

pusha
mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, msglen1
int 80h
popa

mov edi, string
mov word[strlen], 0
cld

l1:
cld

;pusha
mov eax, 3
mov ebx, 0
mov ecx, char1
mov edx, 1
int 80h
;popa

;cmp word[char1], 32
;je exit1
cmp word[char1], 10
je exit1

mov ax, word[char1]
stosw

inc word[strlen]

jmp l1
exit1:

mov ax, 10
stosw
;mov ebx, string

popa 
ret

print_string:

pusha
mov esi, string

l2:

cld
lodsw

cmp ax, 10
je exit2

mov word[char1], ax

pusha
mov eax, 4
mov ebx, 1
mov ecx, char1
mov edx, 1
int 80h
popa


jmp l2

exit2:

mov eax, 4
mov ebx, 1
mov ecx, newline
mov edx, 1
int 80h

popa
ret

print:

pusha

mov word[count], 0

cmp word[sum], 0
jne l3

pusha
mov eax, 4
mov ebx, 1
mov ecx, zero
mov edx, 1
int 80h
popa

jmp exit3

l3:

cmp word[sum], 0
je l4

mov ax, word[sum]
mov dx, 0
mov bx, 10
div bx
mov word[sum], ax

push dx
inc word[count]
jmp l3

l4:

cmp word[count], 0
je exit3

pop dx
mov word[digit], dx
add word[digit], 30h

pusha
mov eax, 4
mov ebx, 1
mov ecx, digit
mov edx, 1
int 80h
popa

dec word[count]
jmp l4

exit3:

mov eax, 4
mov ebx, 1
mov ecx, newline
mov edx, 1
int 80h

popa
ret

find_largest:

pusha

mov esi, string
mov ebx, temp
mov word[largest], 0
mov word[count1], 0
mov word[temp2], 0
jmp l6

l5:
inc word[temp2]
cmp word[temp2], 1
je l6
mov cx, word[count1]
cmp word[largest], cx
jg l6
mov word[largest], cx

l6:
mov word[count1], 0

big_alpha:

cld
lodsw

cmp ax, 10
je exit4
cmp ax, 90
jng l5

mov word[temp1], ax
call check

cmp word[f], 1
je big_alpha

;mov ebx, edi

mov word[ebx], ax
add ebx, 2

;mov edi, ebx

inc word[count1]
jmp big_alpha

exit4:
popa
ret

check:

pusha

mov edi, temp
;mov ax, word[temp1]
mov cx, word[count1]

l7:
cmp cx, 0
je not_found

cld
scasw
je found

dec cx
jmp l7

found:
mov word[f], 1
popa
ret

not_found:
mov word[f], 0
popa
ret