#ifndef H_LIB6502
#define H_LIB6502

#include "fake6502.h"
#include <stdint.h>
#include <stdio.h>
#include <string.h>

#define MAX_ROM_SIZE 0x8000

////////////////////////////
uint8_t zp[0x0100];
uint8_t stack[0x0100];
uint8_t ram[0x2000];
uint8_t io[0x6000];
////////////////////////////
uint8_t rom[MAX_ROM_SIZE];
////////////////////////////

uint8_t read6502(uint16_t address);
void write6502(uint16_t address, uint8_t value);
size_t loadROM(uint8_t* ptr);
uint8_t* runROM(uint16_t max_cycles);

#endif