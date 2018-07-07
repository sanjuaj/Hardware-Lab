section .bss

string: resw 100
char1: resw 1
strlen: resw 1
count: resw 1
count1:resw 1
sum: resw 1
largest: resw 1
digit: resw 1
l_add: resd 1

section .data

msg1: db "Enter the string: "
msglen1: equ $-msg1
newline: db 10
space: db 32
zero: db 30h

section .text
global _start
_start:

call read_string
call find_largest
mov ax, word[largest]
mov word[sum], ax
call print
call print_largest

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

l7:

cld
lodsw

cmp ax, 10
je exit6

mov word[char1], ax

pusha
mov eax, 4
mov ebx, 1
mov ecx, char1
mov edx, 1
int 80h
popa


jmp l7

exit6:

mov eax, 4
mov ebx, 1
mov ecx, newline
mov edx, 1
int 80h

popa
ret

print_word:

pusha
;sub esi, 2
cmp word[esi], 10
je 18
sub esi, 2
l18:
movzx eax, word[largest]
mov ebx, 2
mul ebx
;mov edi, string
;add edi, esi
sub esi, eax
;sub esi, 2

l2:

cld
lodsw

cmp ax, 32
je exit2
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
mov ecx, space
mov edx, 1
int 80h

popa
ret

print_lastword:

pusha

movzx eax, word[largest]
mov ebx, 2
mul ebx
;mov edi, string
;add edi, esi
sub esi, eax

l19:

cld
lodsw

cmp ax, 32
je exit7
cmp ax, 10
je exit7

mov word[char1], ax

pusha
mov eax, 4
mov ebx, 1
mov ecx, char1
mov edx, 1
int 80h
popa


jmp l19

exit7:

mov eax, 4
mov ebx, 1
mov ecx, space
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
mov word[largest], 0
mov word[count1], 0
movzx ecx, word[strlen]

l5:

cld 
lodsw

cmp ax, 32
jne l6
l8:
mov bx, word[count1]
mov word[count1], 0
cmp word[largest], bx
jg l13
mov word[largest], bx
loop l5

l6:
inc word[count1]
l13:
loop l5
mov bx, word[count1]
cmp word[largest], bx
jg l14
mov word[largest], bx
l14:
popa
ret

print_largest:

pusha

mov esi, string
mov word[count1], 0
movzx ecx, word[strlen]
;mov dword[l_add], esi

l9:

cld 
lodsw

cmp ax, 32
jne l10
mov bx, word[count1]
mov word[count1], 0
cmp word[largest], bx
jne l15
call print_word

loop l9

l10:
inc word[count1]
l15:
loop l9

mov bx, word[count1]
cmp word[largest], bx
jne l16
call print_lastword
l16:

popa
ret
