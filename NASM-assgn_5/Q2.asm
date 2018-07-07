section .bss

string: resw 100
temp: resw 100
char1: resw 1
strlen: resw 1
temp1: resw 1
p: resw 1
temp3: resw 1

section .data

msg1: db "Enter the string: "
msglen1: equ $-msg1
newline: db 10
no: db "No "
nolen: equ $-no
yes: db "Yes "
yeslen: equ $-yes

section .text
global _start
_start:

call read_string
call find_pallindrome

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

print_pallindrome:

pusha

sub esi, 2
add edi, 2
l2:

;cmp esi, edi
;je exit2
cmp esi, edi
jg exit2

cld
lodsw


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

find_pallindrome:

pusha
mov esi, string


l3:

cld
lodsw

mov word[temp1], ax
cmp word[temp1], 10
je exit3

mov edi, string
mov ax, word[strlen]
mov edx, 2
mul edx
add edi, eax
sub edi, 2

mov ecx, esi
mov esi, edi
mov edi, ecx

l4:

std
lodsw

cmp word[temp1], ax
jne l4

mov ecx, esi
mov esi, edi
mov edi, ecx

mov dword[temp3], edi
add dword[temp3], 2
;add edi, 2
cmp dword[temp3], esi
jl l3

call check_pallindrome
cmp word[p], 1
je pallindrome

not_pallindrome:
;jmp l4
jmp l3

pallindrome:

mov eax, 4
mov ebx, 1
mov ecx, yes
mov edx, yeslen
int 80h

call print_pallindrome
popa
ret

exit3:

mov eax, 4
mov ebx, 1
mov ecx, no
mov edx, nolen
int 80h

mov eax, 4
mov ebx, 1
mov ecx, newline
mov edx, 1
int 80h

popa
ret

check_pallindrome:
pusha

;add edi, 2
;sub esi, 2

l5:

cmp esi, edi
jg pallin
cmp esi, edi
je pallin

cld
lodsw
mov bx, ax

mov ecx, esi
mov esi, edi
mov edi, ecx

std
lodsw

mov ecx, esi
mov esi, edi
mov edi, ecx

cmp bx, ax
jne n_pallin
jmp l5

pallin:
mov word[p], 1
popa
ret

n_pallin:
mov word[p], 0
popa
ret