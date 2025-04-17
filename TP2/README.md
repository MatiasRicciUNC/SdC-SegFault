# Proyecto: Integración de Python, C y Ensamblador

Este proyecto demuestra la integración de tres lenguajes de programación: **Python**, **C** y **Ensambler NASM**, a través de una arquitectura en capas que permite procesar datos utilizando la pila (`stack`) y devolver el resultado a un programa de alto nivel.

## 🧠 Descripción

El sistema sigue la siguiente lógica:

1. Python obtiene o genera un valor `float`.
2. Python llama a una biblioteca compartida (`.so`) escrita en C.
3. La función en C convierte el valor y lo pasa por `stack` a una rutina en ensamblador.
4. La rutina en ASM convierte el valor a entero, le suma 1, y lo devuelve a C.
5. C retorna el valor a Python.
6. Python muestra el resultado por la terminal y lo envia a traves de ntfy.sh.

## 📁 Estructura del Proyecto

📦 Codigos 
┣ 📜 suma_uno_v2.asm # Rutina en NASM que suma 1 a un número entero 
┣ 📜 connection-py-c-ass.c # Función en C que conecta Python con ASM 
┣ 📜 converter.so # Biblioteca compartida resultante 
┣ 📜 main.py # Script principal en Python 
┗ 📜 README.md # Este archivo


## 🛠️ Compilación

Antes de ejecutar el script de Python, se deben compilar los archivos `.asm` y `.c` y generar la biblioteca compartida:

```bash
nasm -f elf64 suma_uno_v2.asm -o procesar_gini_via_stack.o
gcc -c connection-py-c-ass.c -o procesar_gini.o
gcc -shared -o converter.so procesar_gini.o procesar_gini_via_stack.o
```

## ▶️ Ejecución
Luego de compilar, ejecutá el script de Python:

```bash
python3 main.py
```
Este script:

- Carga la biblioteca converter.so usando ctypes.

- Envía un número float para ser procesado.

- Recibe el número procesado y lo imprime o lo envía por curl a un servicio como ntfy.sh.