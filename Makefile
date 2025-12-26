naren: naren.c m.S
	riscv64-unknown-elf-gcc -O0 -nostdlib -march=rv32i -mabi=ilp32 -Wl, -Tm.ld m.s naren.c -o main.elf
	riscv64-unknown-elf-objcopy -O binary main.elf main.bin

assembly: naren.c
	riscv64-unknown-elf-gcc -O0 -nostdlib -march=rv32i -mabi=ilp32 -Wl, -Tm.ld naren.c -S


compile: m.s m.ld
	riscv64-unknown-elf-gcc -O0 -ggdb -nostdlib -march=rv32i -mabi=ilp32 -Wl, -Tm.ld m.s -o main.elf
	riscv64-unknown-elf-objcopy -O binary main.elf main.bin

printbinay: mian.bin
	xxd -e -c 4 -g 4 main.bin

startqemu: main.elf
	qemu-system-riscv32 -S -M virt -nographic -bios none -kernal main.elf -gdb tcp:1234

clean:
	rm -rf *.out *.bin *.elf