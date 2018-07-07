section .bss

string: resw 100
char1: resw 1
strlen: resw 1

section .data

msg1: db "Enter the string: "
msglen1: equ $-msg1
newline: db 10

section .text
global _start
_start:

call read_string
call print_string

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

mov ebx, string
mov word[strlen], 0

l1:

pusha
mov eax, 3
mov ebx, 0
mov ecx, char1
mov edx, 1
int 80h
popa

;cmp word[char1], 32
;je exit1
cmp word[char1], 10
je exit1
cmp word[char1], 'A'
je l1
cmp word[char1], 'I'
je l1

mov ax, word[char1]
mov word[ebx], ax

add ebx, 2
inc word[strlen]

jmp l1
exit1:

mov word[ebx], 10
;mov ebx, string

popa 
ret

print_string:

pusha
mov ebx, string

l2:

cmp word[ebx], 10
je exit2

mov ax, word[ebx]
mov word[char1], ax

pusha
mov eax, 4
mov ebx, 1
mov ecx, char1
mov edx, 1
int 80h
popa

add ebx, 2
jmp l2

exit2:

mov eax, 4
mov ebx, 1
mov ecx, newline
mov edx, 1
int 80h

popa
ret