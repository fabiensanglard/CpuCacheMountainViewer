CC = gcc
CFLAGS = -Wall 

SOURCES := clock.c fcyc2.c mountain.c

mountain: counter_$(ARCH).o $(SOURCES:.c=.o)
	$(CC) $(CFLAGS) -o mountain counter_$(ARCH).o $(SOURCES:.c=.o)

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

counter_$(ARCH).o: counter_alpha.c counter_x86.c counter_riscv.c
	@if [ "$(ARCH)" != "alpha" ] && [ "$(ARCH)" != "x86" ] && [ "$(ARCH)" != "riscv" ]; then \
		echo "Usage: make ARCH=<alpha,x86,riscv>"; exit 1; \
	fi
	$(CC) $(CFLAGS) -c -o $@ counter_$(ARCH).c

clean:
	rm -f mountain *.o *~
