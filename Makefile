## For Linux, if compile for mac osx, comment out LIBS & CFLAGS below.
LIBS=-lpcre -lcrypto -lm -lpthread
CFLAGS=-ggdb -O3 -Wall

## Mac Homebrew `brew install pcre pcre++`
## Uncomment lines below for `make all`
# LIBS= -lpcre -lcrypto -lm -lpthread
# INCPATHS=-I$(shell brew --prefix)/include -I$(shell brew --prefix openssl)/include
# LIBPATHS=-L$(shell brew --prefix)/lib -L$(shell brew --prefix openssl)/lib
# CFLAGS=-ggdb -O3 -Wall -Qunused-arguments $(INCPATHS) $(LIBPATHS)

OBJS=lux-vanity.o lux-vanity-gpu.o luxgpuminer.o oclengine.o keyconv.o pattern.o util.o
PROGS=lux-vanity keyconv lux-vanity-gpu luxgpuminer

PLATFORM=$(shell uname -s)
ifeq ($(PLATFORM),Darwin)
	OPENCL_LIBS=-framework OpenCL
	LIBS+=-L/usr/local/opt/openssl/lib
	CFLAGS+=-I/usr/local/opt/openssl/include
else ifeq ($(PLATFORM),NetBSD)
	LIBS+=`pcre-config --libs`
	CFLAGS+=`pcre-config --cflags`
else
	OPENCL_LIBS=-lOpenCL
endif


most: lux-vanity keyconv lux-vanity-gpu

all: $(PROGS)

lux-vanity: lux-vanity.o pattern.o util.o
	$(CC) $^ -o $@ $(CFLAGS) $(LIBS)

lux-vanity-gpu: lux-vanity-gpu.o oclengine.o pattern.o util.o
	$(CC) $^ -o $@ $(CFLAGS) $(LIBS) $(OPENCL_LIBS)

luxgpuminer: luxgpuminer.o oclengine.o pattern.o util.o
	$(CC) $^ -o $@ $(CFLAGS) $(LIBS) $(OPENCL_LIBS) -lcurl

keyconv: keyconv.o util.o
	$(CC) $^ -o $@ $(CFLAGS) $(LIBS)

clean:
	rm -f $(OBJS) $(PROGS) $(TESTS)
