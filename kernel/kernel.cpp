// MazdakOS kernel.cpp
// Minimal freestanding C++ kernel for 32-bit x86.

#include <stdint.h>
#include <stddef.h>

namespace {

constexpr uint16_t VGA_WIDTH = 80;
constexpr uint16_t VGA_HEIGHT = 25;
constexpr uint8_t VGA_COLOR_LIGHT_GREY = 7;
constexpr uint8_t VGA_COLOR_BLACK = 0;

volatile uint16_t* const VGA_MEMORY =
    reinterpret_cast<volatile uint16_t*>(0xB8000);

size_t terminal_row = 0;
size_t terminal_column = 0;
uint8_t terminal_color =
    static_cast<uint8_t>(VGA_COLOR_LIGHT_GREY | (VGA_COLOR_BLACK << 4));

constexpr uint16_t make_vga_entry(char c, uint8_t color) {
    return static_cast<uint16_t>(static_cast<uint8_t>(c)) |
           (static_cast<uint16_t>(color) << 8);
}

void terminal_clear() {
    for (size_t y = 0; y < VGA_HEIGHT; ++y) {
        for (size_t x = 0; x < VGA_WIDTH; ++x) {
            const size_t index = y * VGA_WIDTH + x;
            VGA_MEMORY[index] = make_vga_entry(' ', terminal_color);
        }
    }

    terminal_row = 0;
    terminal_column = 0;
}

void terminal_newline() {
    terminal_column = 0;

    if (terminal_row + 1 < VGA_HEIGHT) {
        ++terminal_row;
    }
}

void terminal_put_char(char c) {
    if (c == '\n') {
        terminal_newline();
        return;
    }

    const size_t index = terminal_row * VGA_WIDTH + terminal_column;
    VGA_MEMORY[index] = make_vga_entry(c, terminal_color);

    ++terminal_column;

    if (terminal_column >= VGA_WIDTH) {
        terminal_newline();
    }
}

void terminal_write(const char* text) {
    for (size_t i = 0; text[i] != '\0'; ++i) {
        terminal_put_char(text[i]);
    }
}

} // namespace

extern "C" void kernel_main() {
    terminal_clear();

    terminal_write("MazdakOS v0.1\n");
    terminal_write("----------------\n");
    terminal_write("32-bit x86 freestanding C++ kernel\n");
    terminal_write("Kernel initialized successfully.\n");

    // There is no scheduler or interrupt-driven idle loop yet.
    // The boot assembly code halts the CPU after kernel_main returns.
}
