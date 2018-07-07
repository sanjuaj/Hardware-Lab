section .data
msg1: db "Enter string : "
len1: equ $-msg1
msg2: db "Enter word to be replaced : "
len2: equ $-msg2
msg3: db "Enter new word : "
len3: equ $-msg3
strlen: dw 0
new_line: db 10

section .bss
t: resw 1
string: resw 1000
rword: resw 100
nword: resw 100
nstring: resw 1000
fl: resw 1
l: resd 1

section .text
global _start
_start:

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, len1
int 80h

mov edi, string

read1:
mov eax, 3
mov ebx, 0
mov ecx, t
mov edx, 1
int 80h

cmp byte[t], 10
je endr1

inc word[strlen]

mov ax, word[t]
STOSW

jmp read1
endr1:
mov word[edi], 0

mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, len2
int 80h

mov edi, rword

read2:
mov eax, 3
mov ebx, 0
mov ecx, t
mov edx, 1
int 80h

cmp byte[t], 10
je endr2

mov ax, word[t]
STOSW

jmp read2
endr2:
mov word[edi], 0

mov eax, 4
mov ebx, 1
mov ecx, msg3
mov edx, len3
int 80h

mov edi, nword

read3:

mov eax, 3
mov ebx, 0
mov ecx, t
mov edx, 1
int 80h

cmp byte[t], 10
je endr3

mov ax, word[t]
STOSW

jmp read3
endr3:
mov word[edi], 0
mov edi, string
mov ebp, nstring

func:

mov ax,word[edi]

cmp ax, 0
je endf

cmp ax, ' '
jne l1

add edi, 2
jmp func

l1:

check_word:
mov dword[l], edi
mov esi, rword
mov word[fl], 0

loop:
mov ax, word[edi]

cmp ax, ' '
je endl

mov bx, word[esi]

cmp ax, bx
je if1

else1:
mov word[fl], 1

if1:
add edi, 2
add esi, 2

cmp ax, 0
je endl

jmp loop
endl:

cmp word[esi], 0
je cont

mov word[fl], 1

cont:
cmp word[fl], 0
je if2

else2:

mov esi, dword[l]

loop2:
mov ax, word[esi]
mov word[ebp], ax

add ebp, 2
add esi, 2

cmp esi, edi
jb loop2
mov word[ebp],' '
add ebp, 2
jmp l2

if2:

mov esi, nword

loop3:
mov ax, word[esi]

cmp ax, 0
je endl3

mov word[ebp], ax

add esi, 2
add ebp, 2

jmp loop3
endl3:
mov word[ebp], ' '
add ebp, 2
l2:

jmp func
endf:
mov word[ebp], 0

mov esi, nstring

printing:
LODSW

cmp ax, 0
je endp

mov word[t], ax

mov eax, 4
mov ebx, 1
mov ecx, t
mov edx, 1
int 80h

jmp printing
endp:
mov eax, 4
mov ebx, 1
mov ecx, new_line
mov edx, 1
int 80h

end:

mov eax, 1
mov ebx, 0
int 80h
