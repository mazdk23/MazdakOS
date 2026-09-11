# MazdakOS v0.2

## Experimental x86 Operating System Kernel

MazdakOS is an educational operating system kernel project created to
explore low-level programming, operating system concepts, and computer
architecture.

The goal of this project is to understand how software interacts with
computer hardware by building system components from the ground up.

------------------------------------------------------------------------

## Project Goals

MazdakOS v0.2 focuses on moving from a simple kernel output prototype
toward an interactive operating system environment.

Main objectives:

-   Keyboard input support
-   Terminal system
-   Basic command shell
-   Improved kernel structure
-   Better separation between system components

------------------------------------------------------------------------

## Current Version

### MazdakOS v0.2 - Interactive Kernel Prototype

Planned features:

-   x86 boot process
-   VGA text-mode output
-   Keyboard driver
-   Terminal interface
-   Basic shell commands

------------------------------------------------------------------------

## Technologies

-   C++
-   x86 Assembly
-   NASM
-   GRUB Multiboot
-   QEMU
-   GNU development tools

------------------------------------------------------------------------

## Project Structure

    MazdakOS/

    ├── boot/
    │   └── boot.asm

    ├── kernel/
    │   ├── kernel.cpp
    │   ├── terminal.cpp
    │   └── keyboard.cpp

    ├── Makefile
    ├── README.md
    └── .gitignore

------------------------------------------------------------------------

## Architecture Overview

    Hardware
       |
       v
    Bootloader (GRUB)
       |
       v
    Kernel Entry
       |
       v
    Terminal System
       |
       v
    Keyboard Input
       |
       v
    Shell

------------------------------------------------------------------------

## Future Roadmap

### v0.3

-   Interrupt Descriptor Table (IDT)
-   Hardware interrupts
-   Timer support

### v0.4

-   Memory management
-   Heap allocation
-   Paging concepts

### v0.5

-   Basic filesystem concepts

### v1.0

-   Graphical interface
-   Window system
-   User applications

------------------------------------------------------------------------

## Building and Running

The project is developed for x86 architecture.

Required tools:

-   Cross compiler for x86
-   NASM
-   GRUB tools
-   QEMU

Example:

``` bash
make
qemu-system-i386 -cdrom MazdakOS.iso
```

------------------------------------------------------------------------

## Educational Purpose

MazdakOS is not intended to replace existing operating systems.

The purpose of this project is learning:

-   How computers boot
-   How kernels communicate with hardware
-   How operating systems manage resources
-   How low-level software is designed

------------------------------------------------------------------------

## Developer

Mazdak Alikarami

Interests: - Operating Systems - Systems Programming - Computer
Architecture - Software Development

GitHub: https://github.com/mazdk23

Project: https://github.com/mazdk23/MazdakOS
