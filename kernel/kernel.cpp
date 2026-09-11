extern "C" void kernel_main() {
    volatile char* video = (volatile char*)0xB8000;
    const char* text = "MazdakOS v0.2 Shell Prototype";

    for (int i = 0; text[i]; i++) {
        video[i * 2] = text[i];
        video[i * 2 + 1] = 0x07;
    }
}
