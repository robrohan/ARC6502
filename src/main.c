#include "libboard.h"

#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "stb_image_write.h"

int main(int argc, char **argv)
{
    uint8_t local_rom[0x8000];

    if (argc < 2)
    {
        printf("Missing ROM image\n");
        return 1;
    }

    FILE *ptr;
    ptr = fopen(argv[1], "rb");
    fread(local_rom, sizeof(local_rom), 1, ptr);
    loadROM((uint8_t*)local_rom);

    uint8_t* local_io = runROM(100000);

    // Note: this is the full io memory location and needs to be
    // limited down when we dump to the test image.
    uint8_t w = 32;
    uint8_t h = 32;
    uint8_t err = stbi_write_png("output.png", w, h, 1, local_io, 256);
    if (err != 1)
    {
        printf("Write PNG didn't work %d \n", err);
        return 1;
    }

    return 0;
}
