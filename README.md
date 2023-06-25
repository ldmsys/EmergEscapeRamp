# EmergEscapeRamp
![Changwon_Tunnel_Emerg_Escape_Ramp](https://github.com/ldmsys/x86-bootloader-template/assets/16889349/f16cf07d-86ee-4d78-a651-57a3248d3cbc)

(An Emergency escape ramp located at exit of Changwon Tunnel, Seongsan-gu, Changwon, Gyeongsangnam-do, Republic of Korea.)

...for QEMU/KVM (such as virt-manager).

## Usage
> $ nasm escape.S -f bin -o escape.bin
>
> $ qemu-img convert -O vpc escape.bin escape.vhd
>
> $ qemu-system-i386 -m 128 -hda escape.vhd

## To-dos
 * [ ] Make it work on every ACPI-compliant computers

## Acknowledgement
 * [OSDev Wiki Shutdown Article](https://wiki.osdev.org/Shutdown) Thank OSDev contributors for mentioning QEMU-specific shutdown method!

## License
[Unlicense](./UNLICENSE).
