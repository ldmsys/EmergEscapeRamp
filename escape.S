bits 16
org 0x7C00

mov si, prompt
call print

xor ah, ah ; wait until any key
int 16h ; invoke keyboard services

; Source: https://wiki.osdev.org/Shutdown
mov dx, 0xB004 ; Emergency Escape (QEMU)
mov ax, 0x2000
out dx, ax
mov dx, 0x0604 ; Emergency Escape (QEMU-newer)
out dx, ax
mov dx, 0x4004 ; Emergency Escape (VirtualBox)
mov ax, 0x3400
out dx, ax

mov si, failprompt
call print

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


prompt: db "Emergency Escape Ramp (for QEMU/KVM, @ldmsys)", 0Ah, 0Ah, "Press any key to shutdown, Ctrl-Alt-Delete for restart...", 00h
failprompt: db "If you seeing this message, shutdown failed.", 0Ah, "Press any key to restart...", 00h

times 510-($-$$) db 00h ; fill zero to fit 512 bytes
dw 0xAA55 ; boot signature
