# MazdakOS v0.1

MazdakOS v0.1 is the first minimal bootable version of the project.

## Included

- Multiboot-compatible header
- 32-bit x86 assembly entry point
- 16 KiB kernel stack
- Freestanding C++ kernel entry point
- VGA text-mode screen clearing
- VGA text output
- Basic initialization message
- Linker script for a 1 MiB kernel load address
- Makefile targets for build, Multiboot verification, ISO creation, and QEMU

## Current limitations

This release does not yet contain keyboard input, interrupts, a shell, memory allocation, timer support, a filesystem, or user-mode execution.

The purpose of v0.1 is to establish and understand the boot-to-kernel path before adding more complex subsystems.
