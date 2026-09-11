PROJECT := mazdakos
BUILD_DIR := build
ISO_DIR := $(BUILD_DIR)/iso

AS := nasm
CXX := i686-elf-g++
LD := i686-elf-g++

ASFLAGS := -f elf32
CXXFLAGS := -std=gnu++17 -ffreestanding -O2 -Wall -Wextra \
            -fno-exceptions -fno-rtti -fno-stack-protector
LDFLAGS := -T linker.ld -ffreestanding -O2 -nostdlib

BOOT_OBJ := $(BUILD_DIR)/boot.o
KERNEL_OBJ := $(BUILD_DIR)/kernel.o
KERNEL_BIN := $(BUILD_DIR)/$(PROJECT).bin
ISO_FILE := $(BUILD_DIR)/$(PROJECT).iso

.PHONY: all clean run iso check

all: $(KERNEL_BIN)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BOOT_OBJ): boot/boot.asm | $(BUILD_DIR)
	$(AS) $(ASFLAGS) $< -o $@

$(KERNEL_OBJ): kernel/kernel.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(KERNEL_BIN): $(BOOT_OBJ) $(KERNEL_OBJ) linker.ld
	$(LD) $(LDFLAGS) -o $@ $(BOOT_OBJ) $(KERNEL_OBJ) -lgcc

check: $(KERNEL_BIN)
	grub-file --is-x86-multiboot $(KERNEL_BIN)

iso: $(KERNEL_BIN)
	mkdir -p $(ISO_DIR)/boot/grub
	cp $(KERNEL_BIN) $(ISO_DIR)/boot/$(PROJECT).bin
	printf 'menuentry "MazdakOS" {\n    multiboot /boot/$(PROJECT).bin\n    boot\n}\n' \
		> $(ISO_DIR)/boot/grub/grub.cfg
	grub-mkrescue -o $(ISO_FILE) $(ISO_DIR)

run: iso
	qemu-system-i386 -cdrom $(ISO_FILE)

clean:
	rm -rf $(BUILD_DIR)
