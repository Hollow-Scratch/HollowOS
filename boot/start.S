.section .text
.global _start

_start:
    # Disable interrupts
    csrw mie, zero

    # Setup stack
    la sp, stack_top

    # Clear BSS
    la t0, __bss_start
    la t1, __bss_end

1:
    bge t0, t1, 2f
    sw zero, 0(t0)
    addi t0, t0, 4
    j 1b

2:
    # Call kernel
    call kmain

3:
    j 3b