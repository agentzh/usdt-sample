.PHONY: all clean

OBJS=test.o
CC=gcc

all: test

test: test.o test_provider.o
	$(CC) -o $@ $^

test.o: test.c test_provider.h
	$(CC) -c $<

test_provider.h: test_provider.d
	dtrace -xnolibs -h -o $@ -s test_provider.d

test_provider.o: test_provider.d $(OBJS)
	dtrace -xnolibs -G -o $@ -s $< $(OBJS)

install: all
	cp test.d /usr/lib/dtrace/

clean:
	rm -f *.o test_provider.h

