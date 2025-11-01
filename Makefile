.PHONEY: build

CC=clang
# https://cc65.github.io/
6502CC=cc65
6502ASM=ca65
6502LNK=ld65

# pixels
ASM=pix

all: clean build

setup:
#	https://cc65.github.io/
	sudo apt-get update
	sudo apt-get install cc65
	sudo apt-get install lld

setup_mac:
	brew update
	brew install cc65
	brew install lld

clean:
	rm -rf build

build: asm
	mkdir -p build
	$(CC) -std=c99 \
		-I$(PWD)/vendor \
		-Wall -Wextra -g -v \
		-o build/board \
		src/board.c src/fake6502.c

run:
	cd ./build/; \
	./board "./rom.bin"

asm:
	mkdir -p build
#	asm to object file
	$(6502ASM) --cpu 6502 \
		-o build/$(ASM).o \
		-W1 \
		examples/$(ASM).asm
#	object to binary file
#	-t none
	$(6502LNK) \
		-C src/mon.cfg \
		-o build/rom.bin \
		build/$(ASM).o
	rm build/$(ASM).o
#	binary file to c array to include (temp)
#	xxd -i build/rom.bin > src/rom.h
