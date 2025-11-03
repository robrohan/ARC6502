#include "fake6502.h"
#include <stdint.h>
#include <stdio.h>
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "stb_image_write.h"

////////////////////////////
uint8_t zp[0x0100];
uint8_t stack[0x0100];
uint8_t ram[0x2000];
uint8_t io[0x6000];
////////////////////////////
uint8_t rom[0x8000];
////////////////////////////

uint8_t read6502(uint16_t address)
{
    // When 6502 resets, it looks at this location to find
    // where to start from. Need to build this into ROM somehow
    if (address == 0xFFFC)
        return 0x00;
    if (address == 0xFFFD)
        return 0x80;

    if (address <= 0x00FF)
    {
        return zp[address];
    }
    else if (address <= 0x01FF)
    {
        return stack[address - 0x0100];
    }
    else if (address >= 0x0200 && address < 0x2000)
    {
        return ram[address - 0x2000];
    }
    else if (address >= 0x2000 && address < 0x8000)
    {
        return io[address - 0x2000];
    }
    else
    {
        return rom[address - 0x8000];
    }
    return 0;
}

void write6502(uint16_t address, uint8_t value)
{
    if (address <= 0x00FF)
    {
        zp[address] = value;
    }
    else if (address <= 0x01FF)
    {
        stack[address - 0x0100] = value;
    }
    else if (address >= 0x0200 && address < 0x2000)
    {
        ram[address - 0x2000] = value;
    }
    else if (address >= 0x2000 && address < 0x8000)
    {
        io[address - 0x2000] = value;
    }
    else
    {
        // really, you shouldn't be able to write to ROM
        rom[address - 0x8000] = value;
    }
}

int main(int argc, char **argv)
{
    if (argc < 2)
    {
        printf("Missing ROM image\n");
        return 1;
    }

    FILE *ptr;
    ptr = fopen(argv[1], "rb");
    fread(rom, sizeof(rom), 1, ptr);

    reset6502();
    for (int i = 0; i < 100000; i++)
    {
        step6502();
    }

    int w = 32;
    int h = 32;
    int err = stbi_write_png("output.png", w, h, 1, io, 256);
    if (err != 1)
    {
        printf("Write PNG didn't work %d \n", err);
        return 1;
    }

    return 0;
}
