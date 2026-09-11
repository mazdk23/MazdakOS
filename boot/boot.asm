; MazdakOS boot.asm
; Multiboot-compatible 32-bit x86 entry point.
; NASM syntax.

BITS 32

MAGIC    equ 0x1BADB002
FLAGS    equ 0x00000003
CHECKSUM equ -(MAGIC + FLAGS)

section .multiboot
align 4
    dd MAGIC
    dd FLAGS
    dd CHECKSUM

section .bss
align 16
stack_bottom:
    resb 16384
stack_top:

section .text
global _start
extern kernel_main

_start:
    ; GRUB places the Multiboot magic in EAX and the Multiboot info pointer in EBX.
    ; For v0.1 we do not use those values yet.

    mov esp, stack_top

    ; Clear the direction flag so string operations move forward.
    cld

    ; Call the freestanding C++ kernel entry point.
    call kernel_main

.hang:
    cli
    hlt
    jmp .hang
