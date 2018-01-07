BIN=../cc65/bin
AS=$(BIN)/ca65 $(DEF_SYMS)
CC=$(BIN)/cc65 -t none --inline-stdfuncs -Oi
OBJS=$(patsubst src/%,objs/%, $(patsubst %.asm,%.o, $(wildcard src/*.asm)))
KOBJS=$(patsubst kernelsrc/%,objs/%, $(patsubst %.asm,%.o, $(wildcard kernelsrc/*.asm)))
ALLOBJS=$(KOBJS) $(OBJS)

ifneq ("$(wildcard kernel.rom)","")
#Programming Parts
B_IN_FILE:=$(shell wc -c < kernel.rom)
B_TO_PAD:=$(shell expr 32768 - $(B_IN_FILE))
ROM_DEVICE=AT28C256
endif

all: kernel.rom

kernel.rom: $(ALLOBJS)
	$(BIN)/ld65 --config ./link.ld $^

objs/%.o: src/%.asm
	$(AS) -U -o $@ $^

objs/%.o: kernelsrc/%.asm
	$(AS) -o $@ $^

program: kernel.rom
	echo "Padding kernel.rom with $(B_TO_PAD) bytes"
	dd if=/dev/zero bs=1 count=$(B_TO_PAD) >> kernel.rom
	echo "Programming Device..."
	minipro -p $(ROM_DEVICE) -w $(FILE)

clean:
	rm -rf *.bin *.rom *.hex *.o objs/*.o
