section .bss

string: resw 100
char1: resw 1
strlen: resw 1

section .data

msg1: db "Enter the string: "
msglen1: equ $-msg1
msg2: db "Pallindrome", 10
msglen2: equ $-msg2
msg3: db "Not pallindrome", 10
msglen3: equ $-msg3
newline: db 10
p: dw 1

section .text
global _start
_start:

call read_string
call check_pallindrome

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

;big_alpha:
;cmp word[char1], 65
;jl next1
;cmp word[char1], 90
;jg next1
;add word[char1], 32

next1:
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

check_pallindrome:

pusha

mov ebx, string
mov word[p], 1

l3:

cmp word[ebx], 10
je next

mov ax, word[ebx]
push ax

add ebx, 2
jmp l3

next:

mov ebx, string

l4:

cmp word[ebx], 10
je pallindrome

pop ax

cmp ax, word[ebx]
jne not_pallindrome

add ebx, 2
jmp l4

pallindrome:

cmp word[p], 1
jne not_pallin

mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, msglen2
int 80h

popa
ret

not_pallindrome:

mov word[p], 0
add ebx, 2
jmp l4

not_pallin:

mov eax, 4
mov ebx, 1
mov ecx, msg3
mov edx, msglen3
int 80h

popa
ret