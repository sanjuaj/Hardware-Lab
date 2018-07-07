section .data
msg: db 'Enter array length of first matrix' ,0Ah
msgl: equ $-msg
msg2: db 'Enter array length of second matrix' ,0Ah
msgl2: equ $-msg2
msg7: db 'Arrays cannot be multiplied' ,0Ah
msgl7: equ $-msg7
msg1: db 'Enter element '
msgl1: equ $-msg1
msg3: db ' ' 
msgl3: equ $-msg3
msg4: db '', 0Ah 
msgl4: equ $-msg4


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
t2: resd 1
t3: resw 1
t4: resw 1
t5: resw 1
t6: resw 1
t40: resw 1
t41: resd 1
t42: resd 1
t7: resw 1
t8: resw 1
t9: resw 1
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
m1: resw 1
p: resw 1
q1: resw 1
r: resw 1
r1: resw 1
k: resw 1
s: resw 1
t1: resw 1
count: resw 1
array: resw 200
array1: resw 200
array2: resw 200


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
mov word[m1], ax
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
mov ecx, msg2
mov edx,msgl2
int 80h

call read
mov ax,word[d5]
mov word[q1], ax
call read
mov ax, word[d5]
mov word[s], ax
mov word[r], ax
mov word[r1], ax
mov bx, word[q1]
mul bx
mov word[temp], ax
mov word[num], ax
mov word[num1], ax
mov word[s], ax
mov ax,word[p]
cmp ax,word[q1]
jne quit
mov ebx, array1
reading1:
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
jnl reading1


call multiply
mov ax, word[m]
mov cx, word[r]
mul cx
mov word[count], ax

call arrayprint



jmp exit




quit:
mov eax, 4
mov ebx, 1
mov ecx, msg7
mov edx,msgl7
int 80h
jmp exit



exit:
mov eax, 1
mov ebx, 0
int 80h


multiply:
pusha
mov word[i],0
fori:
mov ax, word[r]
mov word[t3], ax
mov word[j], 0
forj:
mov ax, word[q1]
mov word[t7], ax
mov word[k], 0
mov word[t40],0
fork:
call swap
inc word[k]
mov cx, word[t7]
cmp cx, word[k]
ja fork
call move
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

swap:
pusha
mov word[t5], 0
mov word[t2], 0
mov ebx, array
mov ax, word[i]
mov cx, word[p]
mul cx
mov cx, word[k]
add ax, cx
mov cx, 2
mul cx
mov word[t5], ax
add ebx, dword[t5]

mov ax, word[ebx]
mov word[t5], ax
mov ebx, array1
mov ax, word[k]
mov cx, word[r]
mul cx
mov cx, word[j]
add ax, cx
mov cx, 2
mul cx
mov word[t2], ax
add ebx, dword[t2]
mov ax, word[ebx]
mov word[t2], ax

mov ax, word[t2]
mov cx, word[t5]
mul cx
add word[t40], ax
popa 
ret

swap2:
pusha
mov ax, word[i]
mov cx,word[r1]
mul cx
mov cx, word[j]
add ax, cx
mov cx, 2
mul cx
mov word[t42],ax
mov ebx, array2
add ebx, dword[t42]
mov ax, word[ebx]
mov word[sum], ax
call print
popa 
ret





move:
pusha
mov ebx, array2
mov ax, word[i]
mov cx, word[r]
mul cx
mov cx, word[j]
add ax, cx
mov cx, 2
mul cx
mov word[t41], ax
add ebx, dword[t41]
mov ax, word[t40]
mov word[ebx], ax
popa 
ret


arrayprint:
pusha
mov word[i],0
fori4:
mov ax, word[r1]
mov word[t3], ax
mov word[j], 0
forj4:
call swap2
inc word[j]
mov cx, word[t3]
cmp cx, word[j]
ja forj4
mov eax, 4
mov ebx, 1
mov ecx, msg4
mov edx, msgl4
int 80h
inc word[i]
mov ax, word[m1]
cmp ax, word[i]
ja fori4
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
