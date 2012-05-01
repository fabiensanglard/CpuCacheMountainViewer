CC = gcc
CFLAGS = -Wall 

mountain: mountain.c fcyc2.c clock.c
	$(CC) $(CFLAGS) -o mountain mountain.c fcyc2.c clock.c 

clean:
	rm -f mountain *.o *~


