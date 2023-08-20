# EmergEscapeRamp
![Changwon_Tunnel_Emerg_Escape_Ramp](https://github.com/ldmsys/x86-bootloader-template/assets/16889349/f16cf07d-86ee-4d78-a651-57a3248d3cbc)

(An Emergency escape ramp located at exit of Changwon Tunnel, Seongsan-gu, Changwon, Gyeongsangnam-do, Republic of Korea.)

...for APM 1.1 compliant computers. This requests system shutdown to APM.

Especially useful when virt-manager has been deadlocked and all you can do is rebooting the computer.

## Usage
> $ nasm escape.S -f bin -o escape.bin
>
> $ qemu-img convert -O vpc escape.bin escape.vhd
>
> $ qemu-system-i386 -m 128 -hda escape.vhd

## Acknowledgement
 * [TECH Help!](http://www.techhelpmanual.com/29-advance_power_management__apm__functions.html) by Flambeaux Software, Inc. - for amazing APM API documentation

## License
[Unlicense](./UNLICENSE).
