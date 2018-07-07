section .data
msg: db 'Enter array length ' ,0Ah
msgl: equ $-msg
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
temp2: resw 1
temp3: resw 1
temp1: resw 1
temp4: resw 1
temp6: resw 1
tem1: resw 1
tem2: resw 1
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
t1: resw 1
array: resw 50


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

call rotate

movzx ecx, word[n]
mov ebx, array
mov word[temp6], 1
jmp arrayprint


arrayprint:
mov ax, word[ebx]
mov word[sum],ax

call print
inc word[temp6]
mov ax, word[temp6]
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
mov word[temp6], 1
jmp bak

exit:
mov eax, 1
mov ebx, 0
int 80h



rotate:
pusha
mov word[i],0
fori:

call swap
inc word[i]

mov ax, word[m]
cmp ax, word[i]
ja fori

popa 
ret



swap:
pusha
mov ax, word[i]

mov word[temp4], 0
mov word[temp2], 0
mov ebx, array
mov ax, word[i]
mov cx, word[m]
mul cx
mov cx, word[i]
add ax, cx
mov cx, 2
mul cx
mov word[temp4], ax
add ebx, dword[temp4]

mov ax, word[ebx]
mov word[temp4], ax

mov ebx, array
mov ax, word[i]
mov cx, word[m]
mul cx
mov cx, word[i]
sub ax, cx
dec ax
mov cx, word[m]
add ax, cx
mov cx, 2
mul cx
mov word[temp2], ax
add ebx, dword[temp2]

mov ax, word[ebx]
mov word[temp2], ax
mov ax, word[temp4]
mov word[ebx], ax
mov ebx, array

mov ax, word[i]
mov cx, word[m]
mul cx
mov cx, word[i]
add ax, cx
mov cx, 2
mul cx
mov word[temp4], ax
add ebx, dword[temp4]
mov ax, word[temp2]
mov word[ebx], ax
ex:
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

