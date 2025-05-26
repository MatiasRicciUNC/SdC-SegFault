## Protected Mode

### Compilar con
nasm -f bin protected_mode.asm -o main.img


### Correr en QEMU
qemu-system-i386 -fda main.img


### Debug con GDB
qemu-system-i386 -fda main.img -S -gdb tcp::1234 -monitor stdio


En otra terminal
gdb
(gdb) target remote localhost:1234
(gdb) set architecture i386
(gdb) break *0x7C00
(gdb) continue


