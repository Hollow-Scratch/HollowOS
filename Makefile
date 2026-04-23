# config
CC = riscv64-elf-gcc

# -g for symbols
CFLAGS = -Wall -Wextra -O0 -g -ffreestanding -nostdlib -nostartfiles -mcmodel=medany
LDFLAGS = -T linker/linker.ld

# files
BOOT = boot/start.S
KERNEL = kernel/main.c

OBJS = build/start.o build/main.o

# build
all: build/kernel.elf

build/start.o: $(BOOT)
	@mkdir -p build
	$(CC) $(CFLAGS) -c $< -o $@

build/main.o: $(KERNEL)
	@mkdir -p build
	$(CC) $(CFLAGS) -c $< -o $@

build/kernel.elf: $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) $(LDFLAGS) -o $@

# run
run: build/kernel.elf
	qemu-system-riscv64 \
	-machine virt \
	-nographic \
	-bios none \
	-kernel build/kernel.elf \
	-serial mon:stdio

# debug
debug: build/kernel.elf
	qemu-system-riscv64 \
	-machine virt \
	-nographic \
	-bios none \
	-kernel build/kernel.elf \
	-serial mon:stdio \
	-S -gdb tcp::1234

gdb:
	riscv64-elf-gdb build/kernel.elf

# clean
clean:
	rm -rf build