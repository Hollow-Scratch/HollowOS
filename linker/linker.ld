ENTRY(_start)

SECTIONS
{
    . = 0x80000000;

    .text : {
        *(.text*)
    }

    .rodata : {
        *(.rodata*)
    }

    .data : {
        *(.data*)
    }

    .bss : {
        __bss_start = .;
        *(.bss*)
        __bss_end = .;
    }

    . = ALIGN(16);
    stack_bottom = .;
    . += 4096;   /* 4KB stack */
    stack_top = .;
}