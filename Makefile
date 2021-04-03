CC	?= gcc

CFLAGS	:= -O3 -Wall
CFLAGS 	+= $(shell pkg-config libnspire --cflags)

CFLAGS_OSXFUSE := -DFUSE_USE_VERSION=26
CFLAGS_OSXFUSE += $(shell pkg-config fuse --cflags)

LIBS	:= $(shell pkg-config fuse --libs)
#LIBS	+= -ework CoreServices -framework IOKit
LIBS	+= $(shell pkg-config libnspire --libs)

TARGETS = nspire.o dir.o file.o stat.o

%.o: %.c
	$(CC) -c $(CFLAGS_OSXFUSE) $(CFLAGS) -o $@ $<

all: nspire

nspire: $(TARGETS)
	$(CC) -o $@ $(CFLAGS) $^ $(LIBS)

clean:
	rm -f $(TARGETS) *.o
