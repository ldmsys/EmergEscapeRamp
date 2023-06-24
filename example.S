bits 16
org 0x7C00

xor ah, ah ; set video mode
mov al, 03h ; to 03h in order to clear screen
int 10h ; video call

mov si, colordb
call set_color

mov si, hello_world
call print

;int 18h ; for debug
jmp $ ; loop rather than cli-hlt; because Xen shuts down the VM

set_color:
    pusha
    mov ax, 0xB800 ; video memory base path
    mov es, ax
    xor bh, bh ; set bh to zero
    .loop1:
        lodsb ; get next byte
        cmp al, 00h ; 00h = exit
        je .ret
        mov cl, al ; startloc
        lodsb
        mov dl, al ; endloc
        lodsb
        mov dh, al ; color
    .loop2:
        mov bl, cl
        add bl, cl
        inc bl ; bl = cl * 2 + 1
        cbw ; bx = bh(00h) + bl
        mov BYTE [es:bx], dh ; set color of this door
        cmp cl, dl
        jge .loop1 ; coloring end if cl >= dl
        inc cl ; fill next door
        jmp .loop2
    .ret:
        popa
        ret

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


move_cursor:
    pusha
    mov ah, 02h ; set cursor's location
    int 10h ; video call
    popa
    ret

hello_world: db " Hello, World!", 0Ah, 00h
colordb: db 01h, 06h, 0Bh, 07h, 0Dh, 0Ah, 00h ;StartLoc, EndLoc, Color

times 510-($-$$) db 00h ; fill zero to fit 512 bytes
dw 0xAA55 ; boot signature
