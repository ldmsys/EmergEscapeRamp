bits 16
org 0x7C00

mov si, prompt
call print

xor ah, ah ; wait until any key
int 16h ; invoke keyboard services

; Reference: http://www.techhelpmanual.com/29-advance_power_management__apm__functions.html

mov ax, 0x5300 ; APM lookup
xor bx, bx
int 15h ; check for APM availability

jc failed ; if cf == cy?

cmp bx, 0x504d ; is bx == 'PM'?
jne failed

cmp ax, 0x0101 ; is ax >= 0x0101?
jl failed

shr cl, 3
and cl, 1
cmp cl, 1 ; if cx's third bit set?
je failed

mov ax, 0x5301 ; APM registration
xor bx, bx
int 15h ; call

jc failed ; if cf == cy?

mov ax, 0x5307 ; set power state
mov bx, 1 ; all devices by apm bios
mov cx, 3 ; power state off
int 15h ; if this succeed, following statements will never be executed.
 
failed:
mov si, failprompt
call print

xor ah, ah ; wait until any key
int 16h ; invoke keyboard services

jmp 0xFFFF:0 ; reboot
jmp $ ; this should never executed

print:
    pusha
    xor bh, bh ; we won't use page number

    .loop:
        lodsb
        cmp al, 00h ; '\0' = exit
        je .ret
        cmp al, 0Ah ; '\n' = newline
        je .newline
        mov ah, 0Eh ; write character 
        int 10h ; video call
        jmp .loop

    .newline:
        mov ah, 03h ; get cursor's location
        int 10h ; video call
        mov ah, 02h ; move cursor's location
        xor dl, dl ; set row to zero
        inc dh ; increase column
        int 10h ; video call
        jmp .loop
    
    .ret:
        popa
        ret


prompt: db "Emergency Escape Ramp (@ldmsys)", 0Ah, 0Ah, "Press any key to shutdown, Ctrl-Alt-Delete for restart...", 00h
failprompt: db "If you seeing this message, shutdown failed.", 0Ah, "Press any key to restart...", 00h

times 510-($-$$) db 00h ; fill zero to fit 512 bytes
dw 0xAA55 ; boot signature
