# Assembler and linker
AS=as
LD=ld

# Assembler and linker flags
ASFLAGS = -arch arm64
LDFLAGS = -e _start -arch arm64 -macosx_version_min 13.0.0 -syslibroot `xcrun --show-sdk-path` -lSystem

SRCS = $(wildcard src/*.s)
OBJS = $(patsubst src/%.s, obj/%.o, $(SRCS))

.PHONY: all
all: bin/%proj%

# Rule to link the object files and create executable
bin/%proj%: $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^

# Rule to assemble the source files
obj/%.o: src/%.s
	$(AS) $(ASFLAGS) -o $@ $<

.PHONY: clean
clean:
	rm $(OBJS) bin/%proj%

