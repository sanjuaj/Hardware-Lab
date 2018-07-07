section .bss

string: resw 100
temp: resw 1
char1: resw 1
strlen: resw 1

section .data

msg1: db "Enter the string: "
msglen1: equ $-msg1
newline: db 10
space: db 32

section .text
global _start
_start:

call read_string
;call print_string
call reverse

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

print_word:

pusha
;mov edi, string
;add edi, esi
add esi, 4

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

print_last:

pusha
;mov edi, string
;add edi, esi
add esi, 2

l4:

cld
lodsw

cmp ax, 32
je exit4
cmp ax, 10
je exit4

mov word[char1], ax

pusha
mov eax, 4
mov ebx, 1
mov ecx, char1
mov edx, 1
int 80h
popa


jmp l4

exit4:

mov eax, 4
mov ebx, 1
mov ecx, newline
mov edx, 1
int 80h

popa
ret

reverse:

pusha

mov esi, string
movzx eax, word[strlen]
mov edx, 2
mul edx
add esi, eax
sub esi, 2
mov ax, word[strlen]
mov word[temp], ax
;sub ecx, 2

l3:

cmp word[temp], 0
je exit3

std
lodsw

cmp word[temp], 1
jne ni
call print_last
ni:
cmp ax, 32
jne ne
no:
call print_word
ne:
dec word[temp]
jmp l3

exit3:

popa
ret