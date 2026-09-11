# MazdakOS

MazdakOS is a small educational operating system project for learning how a computer boots into a custom kernel and how low-level software interacts directly with x86 hardware.

Version **v0.1** is intentionally small. It boots through a Multiboot-compatible bootloader, switches into a simple 32-bit kernel entry path, initializes a stack, calls a freestanding C++ kernel, and writes text directly to the VGA text buffer.

## Current status — v0.1

Implemented:

- Multiboot header
- 32-bit x86 startup code
- Assembly entry point
- Freestanding C++ kernel entry point
- Basic stack setup
- VGA text-mode output
- Basic kernel initialization message

Not implemented yet:

- Keyboard input
- Interrupt Descriptor Table (IDT)
- Hardware interrupts
- Command shell
- Dynamic memory management
- Timer driver
- Filesystem
- User-mode programs

These are planned features and are not presented as completed functionality.

## Project structure

```text
MazdakOS/
├── boot/
│   └── boot.asm
├── kernel/
│   └── kernel.cpp
├── linker.ld
├── Makefile
├── README.md
└── .gitignore
```

## How it works

The boot process in v0.1 is:

1. A Multiboot-compatible bootloader such as GRUB loads the kernel.
2. Execution begins at `_start` in `boot/boot.asm`.
3. The assembly code initializes the stack.
4. `_start` calls the C++ function `kernel_main`.
5. The kernel clears the VGA text buffer at physical address `0xB8000`.
6. The kernel prints a short startup message.
7. Control returns to the assembly code, which halts the CPU.

## Build requirements

The Makefile expects a cross-compiler toolchain so the kernel is not accidentally linked against the host operating system.

Typical tools:

- `nasm`
- `i686-elf-g++`
- GRUB utilities (`grub-file`, `grub-mkrescue`)
- `xorriso`
- `qemu-system-i386`

The exact package names depend on the host operating system.

## Build

```bash
make
```

The kernel binary is generated at:

```text
build/mazdakos.bin
```

To verify the Multiboot header:

```bash
make check
```

To build a bootable ISO:

```bash
make iso
```

To run it in QEMU:

```bash
make run
```

## Expected output

After booting, the VGA text screen should display:

```text
MazdakOS v0.1
----------------
32-bit x86 freestanding C++ kernel
Kernel initialized successfully.
```

## Technical notes

### Multiboot

The kernel contains the Multiboot magic value, flags, and checksum expected by compatible bootloaders.

### Freestanding C++

The kernel is compiled without a normal hosted C++ runtime. Features such as exceptions and RTTI are disabled, and the code does not depend on the standard library.

### VGA text mode

Text is written directly into VGA text memory at:

```text
0xB8000
```

Each VGA text cell is represented by two bytes: one byte for the character and one byte for its color attributes.

## Roadmap

Planned development order:

1. Keyboard driver
2. Interrupt Descriptor Table (IDT)
3. Basic command shell
4. Memory management
5. Programmable Interval Timer
6. Simple filesystem
7. User-mode programs

Each roadmap item will only be moved into the implemented feature list after it exists in the code and has been tested.

## Learning goals

MazdakOS is an educational project. The main goal is to understand:

- the early boot process
- x86 execution at a low level
- assembly/C++ interaction
- freestanding software development
- memory-mapped hardware access
- how an operating system kernel grows from a minimal entry point

## License

This project is currently provided for educational and portfolio purposes.
