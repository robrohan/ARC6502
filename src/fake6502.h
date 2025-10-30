#ifndef H_FAKE6502
#define H_FAKE6502

#include <stdint.h>

/** A running total of the emulated cycle count.  */
// uint32_t clockticks6502;

/** A running total of the total emulated
 * instruction count. This is not related to
 * clock cycle timing.
 */
// uint32_t instructions;

/** Call this once before you begin execution. */
void reset6502();

/** Execute 6502 code up to the next specified
 * count of clock ticks.
 */
void exec6502(uint32_t tickcount);

/** Execute a single instruction. */
void step6502();

/** Trigger a hardware IRQ in the 6502 core. */
void irq6502();

/** Trigger an NMI in the 6502 core. */
void nmi6502();
 
/** Pass a pointer to a void function taking no
 * parameters. This will cause Fake6502 to call
 * that function once after each emulated
 * instruction.
 */
void hookexternal(void *funcptr);

#endif