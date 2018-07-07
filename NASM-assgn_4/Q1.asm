section .bss

string: resw 100
char1: resw 1
strlen: resw 1

section .data

msg1: db "Enter the string: "
msglen1: equ $-msg1
msg2: db "No. of vowels: "
msglen2: equ $-msg2
newline: db 10
v_count: dw 0

section .text
global _start
_start:

call read_string
call count_vowels

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

count_vowels:

pusha
mov ebx, string

l2:

cmp word[ebx], 10
je exit2

cmp word[ebx], 'A'
je inc_count
cmp word[ebx], 'a'
je inc_count
cmp word[ebx], 'E'
je inc_count
cmp word[ebx], 'e'
je inc_count
cmp word[ebx], 'I'
je inc_count
cmp word[ebx], 'i'
je inc_count
cmp word[ebx], 'O'
je inc_count
cmp word[ebx], 'o'
je inc_count
cmp word[ebx], 'U'
je inc_count
cmp word[ebx], 'u'
je inc_count

next:

add ebx, 2
jmp l2

inc_count:

inc word[v_count]
jmp next

exit2:

mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, msglen2
int 80h

add word[v_count], 30h

mov eax, 4
mov ebx, 1
mov ecx, v_count
mov edx, 1
int 80h

mov eax, 4
mov ebx, 1
mov ecx, newline
mov edx, 1
int 80h

popa
ret