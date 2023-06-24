# x86 Bootloader Template
This repository is template for creating x86 bootloader, or testing x86 instructions.

The example code contains simple bootloader for saying colorful "Hello, World" in real mode.

## Usage
> $ nasm example.S -f bin -o example.bin
>
> $ qemu-img convert -O vpc example.bin example.vhd
>
> $ qemu-system-i386 -m 128 -hda example.vhd

## License
[Unlicense](./UNLICENSE). Of a course, you can apply whatever license do you prefer.
