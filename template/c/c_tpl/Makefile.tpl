CC=clang
CFLAGS=-Iinclude -std=c89 -g -O0

SRCS = $(wildcard src/*.c)
OBJS = $(patsubst src/%.c, obj/%.o, $(SRCS))

.PHONY: all
all: bin/%proj%

bin/%proj%: $(OBJS)
	$(CC) -o $@ $^

obj/%.o: src/%.c
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm $(OBJS) bin/%proj%

