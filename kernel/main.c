#include <stdint.h>

#define UART0 0x10000000L

static inline void uart_putc(char c) {
    *(volatile uint8_t*)(UART0) = c;
}

void uart_puts(const char* s) {
    while (*s) {
        if (*s == '\n') {
            uart_putc('\r');  // important for proper newline
        }
        uart_putc(*s++);
    }
}

void kmain(void) {
    uart_puts("Hello, World from HollowOS!\n");

    while (1) {
        // keep running
    }
}