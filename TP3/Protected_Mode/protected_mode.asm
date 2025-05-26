[BITS 16]
[ORG 0x7C00]

start:
    cli
    lgdt [gdt_descriptor]

    ; Activar PE bit en CR0
    mov eax, cr0
    or eax, 1
    mov cr0, eax

    ; Salto lejano al modo protegido
    jmp 0x08:protected_mode

; ----------------------------
; GDT
; ----------------------------
gdt_start:
    dq 0x0000000000000000

    ; Descriptor de código (base=0, límite=FFFFF, 4KB gran, código ejecutable y legible)
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 0x9A
    db 0xCF
    db 0x00

    ; Descriptor de datos (base=0, límite=FFFFF, 4KB gran, datos legibles)
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 0x92
    db 0xCF
    db 0x00

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

; ----------------------------
; Código en modo protegido
; ----------------------------
[BITS 32]
protected_mode:
    ; Cargar selectores de segmento
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov ss, ax

    ; Intentar escribir a memoria protegida
    mov dword [0x00100000], 0x22222222

hang:
    jmp hang

; Relleno hasta 512 bytes (sector)
times 510 - ($ - $$) db 0
dw 0xAA55
