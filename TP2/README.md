nasm -f elf64 suma_uno_v2.asm -o procesar_gini_via_stack.o
gcc -c connection-py-c-ass.c -o procesar_gini.o
gcc -shared -o converter.so procesar_gini.o procesar_gini_via_stack.o
