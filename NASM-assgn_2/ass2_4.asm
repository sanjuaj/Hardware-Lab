section .bss
a:resw 100
d:resw 1
sum:resw 1
temp:resw 1
n:resw 1
n1:resw 1
n2:resw 1
t:resw 1
z:resw 1
i:resw 1
j:resd 1
t2:resd 1
section .text
global _start:
_start:

call read
mov ax,word[sum]
mov word[n],ax
mov word[temp],ax
mov cx,word[n]
mul cx
mov word[z],ax

call arrread

mov word[i],0
mov ebx,a
mov ax,word[n]

mov cx,2
mul cx
mov word[n],ax
mov word[t2],ax
label:
mov ax,word[i]
mov word[j],ax
add ebx,dword[j]
mov ax,word[ebx]
mov word[n1],ax
sub ebx,dword[j]
add ebx,dword[t2]
sub ebx,2
sub ebx,dword[j]
mov ax,word[ebx]
mov word[n2],ax
call swap
mov ax,word[n2]
mov word[ebx],ax
add ebx,2
add ebx,dword[j]
sub ebx,dword[t2]
add ebx,dword[j]
mov ax,word[n1]
mov word[ebx],ax
add word[i],2
mov ax,word[n]
cmp word[i],ax
je exits
mov ax,word[temp]
mov cx,word[i]
mul cx
mov ebx,a
mov word[j],ax
add ebx,dword[j]
jmp label


exits:
push ebx
mov word[d],10
mov eax,4
mov ebx,1
mov ecx,d
mov edx,1
int 80h
pop ebx

mov ax,word[temp]
mov word[n],ax
mov ebx,a
exitl:
mov ax,word[ebx]
call prin
push ebx
mov word[d],20h
mov eax,4
mov ebx,1
mov ecx,d
mov edx,1
int 80h
pop ebx
stepi:
dec word[z]
cmp word[z],0
je exit
mov dx,0
mov ax,word[z]
mov cx,word[n]
div cx
cmp dx,0
jne w
push ebx
mov word[d],10
mov eax,4
mov ebx,1
mov ecx,d
mov edx,1
int 80h
pop ebx



w:
add ebx,2
jmp exitl

exit:
mov eax,1
mov ebx,0
int 80h
 




















read:
pusha
mov word[sum],0
read1:
mov eax,3
mov ebx,0
mov ecx,d
mov edx,1
int 80h

cmp word[d],10
je exitr
cmp word[d],20h
je exitr
sub word[d],30h
mov ax,word[sum]
mov cx,10
mul cx
add ax,word[d]
mov word[sum],ax
jmp read1
exitr:
popa
ret

arrread:
pusha
mov ebx,a
movzx ecx,word[z]
aread1:
push ecx
push ebx
call read
mov ax,word[sum]
pop ebx
mov word[ebx],ax

add ebx,2
pop ecx
loop aread1
exita:
popa
ret

prin:
pusha
mov word[temp],0
prin1:
mov dx,0
mov cx,10
div cx
push dx
inc word[temp]
cmp ax,0
je prin2
jmp prin1
prin2:
pop dx
push ebx
mov word[d],dx
add word[d],30h
mov eax,4
mov ebx,1
mov ecx,d
mov edx,1
int 80h
pop ebx
dec word[temp]
cmp word[temp],0
je exitp
jmp prin2
exitp:
popa
ret

swap:
pusha
mov ax,word[n1]
mov cx,word[n2]
mov word[n1],cx
mov word[n2],ax
popa
ret


