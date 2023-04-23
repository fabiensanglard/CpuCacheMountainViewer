/* Use RISC-V cycle timer to compute cycles */
#ifdef __riscv

#include <stdio.h>
#include "counter.h"

static unsigned long long start_cycle;

unsigned long long get_cycle() {
    static unsigned long long val = 0;

#if __riscv_xlen == 32
    static unsigned long hi, hi1, lo;

    do {
        __asm__ volatile("csrr %0, timeh" : "=r"(hi));
        __asm__ volatile("csrr %0, time" : "=r"(lo));
        __asm__ volatile("csrr %0, timeh" : "=r"(hi1));
        /* hi != hi1 means `time` overflow during we get value,
         * so we must retry. */
    } while (hi != hi1);

    val = ((unsigned long long)hi << 32) | lo;
#else
    __asm__ volatile("csrr %0, time" : "=r"(val));
#endif

    return val;
}


void start_counter()
{
    start_cycle = get_cycle();
}

double get_counter()
{

    return (double)(get_cycle() - start_cycle);
}

#else
#error "Macro `__riscv` wasn't defined!"
#endif /* __riscv */
