section .data
msg: db 'Enter array length ' ,0Ah
msgl: equ $-msg
msg1: db 'Enter element '
msgl1: equ $-msg1
msg3: db ' ' 
msgl3: equ $-msg3
msg4: db '', 0Ah 
msgl4: equ $-msg4
msg6: db '1.Rotate clockwise ' ,0Ah
msgl6: equ $-msg6
msg7: db '2.Rotate anti clockwise ' ,0Ah
msgl7: equ $-msg7

section .bss
d1: resw 1
d2: resw 1
d3: resw 1
d4: resw 1
d5: resw 1
d6: resw 1
junk: resw 1
temp: resw 1
i: resw 1
j: resw 1
rot: resw 1
t2: resd 1
t3: resw 1
t4: resw 1
t6: resw 1
ten: resw 1
sum: resw 1
digit: resw 1
beg: resw 1
mid: resw 1
end: resw 1
tem: resw 1
num: resw 1
num1: resw 1
n: resw 1
m: resw 1
p: resw 1
array: resw 200
array1: resw 50


section .text
global _start
_start:
mov eax, 4
mov ebx, 1
mov ecx, msg
mov edx,msgl
int 80h

call read
mov ax,word[d5]
mov word[m], ax
call read
mov ax, word[d5]
mov word[n], ax
mov word[p], ax
mov bx, word[m]
mul bx
mov word[temp], ax
mov word[num], ax
mov word[num1], ax
mov word[n], ax
mov ebx, array
reading:
push ebx
mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx,msgl1
int 80h

call read
mov ax,word[d5]
pop ebx
mov word[ebx], ax
add ebx, 2
dec word[temp]
cmp word[temp] , 1
jnl reading


mov eax, 4
mov ebx, 1
mov ecx, msg6
mov edx,msgl6
int 80h

mov eax, 4
mov ebx, 1
mov ecx, msg7
mov edx,msgl7
int 80h

mov eax, 3
mov ebx, 0
mov ecx, rot
mov edx, 1
int 80h
sub word[rot], 30h


call rotate
movzx ecx, word[n]
mov ebx, array1
mov word[t6], 1
jmp arrayprint


arrayprint:
mov ax, word[ebx]
mov word[sum],ax

call print
inc word[t6]
mov ax, word[t6]
cmp ax, word[m]
ja change
bak:
add ebx, 2
loop arrayprint

jmp exit

change:
push ecx
push ebx
mov eax,4
mov ebx,1
mov ecx,msg4
mov edx,msgl4
int 80h
pop ebx
pop ecx
mov word[t6], 1
jmp bak

exit:
mov eax, 1
mov ebx, 0
int 80h



rotate:
pusha
mov word[i],0
fori:
mov ax, word[p]
mov word[t3], ax
mov word[j], 0
forj:
cmp word[rot], 2
je ca
call swap
ca1:
inc word[j]
mov cx, word[t3]
cmp cx, word[j]
ja forj

inc word[i]
mov ax, word[m]
cmp ax, word[i]
ja fori
popa 
ret


ca:
call swap2
jmp ca1





swap:
pusha
mov ax, word[i]

mov word[t4], 0
mov word[t2], 0
mov ebx, array
mov ax, word[i]
mov cx, word[p]
mul cx
mov cx, word[j]
add ax, cx
mov cx, 2
mul cx
mov word[t4], ax
add ebx, dword[t4]

mov ax, word[ebx]
mov word[t4], ax
mov ebx, array1
mov ax, word[j]
mov cx, word[m]
mul cx
mov cx, word[i]
sub ax, cx
dec ax
mov cx, word[m]
add ax, cx
mov cx, 2
mul cx
mov word[t2], ax
add ebx, dword[t2]
mov ax, word[t4]
mov word[ebx], ax

mov ebx, array

ex:
popa 
ret

swap2:
pusha
mov ax, word[i]

mov word[t4], 0
mov word[t2], 0
mov ebx, array
mov ax, word[i]
mov cx, word[p]
mul cx
mov cx, word[j]
add ax, cx
mov cx, 2
mul cx
mov word[t4], ax
add ebx, dword[t4]

mov ax, word[ebx]
mov word[t4], ax
mov ebx, array1
mov ax, word[m]
mov cx, word[j]
sub ax, cx
dec ax
mov cx, word[p]
mul cx
mov cx, word[i]
add ax, cx
mov cx, 2
mul cx
mov word[t2], ax
add ebx, dword[t2]
mov ax, word[t4]
mov word[ebx], ax

mov ebx, array

ex1:
popa 
ret


read:
pusha
mov eax, 3
mov ebx, 0
mov ecx, d5
mov edx, 1
int 80h
sub word[d5], 30h
jmp t
t:
mov ax,word[d5]
mov word[tem], ax
mov eax, 3
mov ebx, 0
mov ecx, d6
mov edx, 1
int 80h
cmp word[d6], 10
je end1
cmp word[d6], 20h
je end1
jmp q
q:
sub word[d6], 30h
mov ax, word[tem]
mov bx,10
mul bx
mov bx, word[d6]
add ax,bx
mov word[d5], ax 
jmp t

end1:
popa
ret 

print:
pusha
mov word[ten],1
mov dx,0
mov ax,word[sum]
mov cx,10
div cx
mov word[temp],ax

tens:
cmp word[temp],0
je printfirst

mov dx,0
mov ax,word[temp]
mov cx,10
div cx
mov word[temp],ax

mov ax,word[ten]
mov bx,10
mul bx
mov word[ten],ax

jmp tens

printfirst:

mov dx,0
mov ax,word[sum]
mov cx,word[ten]
div cx

mov word[digit],ax
mov word[sum],dx
add word[digit],30h

mov eax,4
mov ebx,1
mov ecx,digit
mov edx,1
int 80h

cmp word[ten],1
je printend

mov dx,0
mov ax,word[ten]
mov cx,10
div cx
mov word[ten],ax

jmp printfirst
printend:

mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,msgl3
int 80h

popa
ret
