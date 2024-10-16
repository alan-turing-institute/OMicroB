include ../../../../etc/Makefile.conf

DEVICE ?= microbit2

TARGETS := water.elf water.hex

all: $(TARGETS)

$(TARGETS): water.ml
	$(BIN)/omicrob -v -device=$(DEVICE) $^ -o $@

clean:
	rm -f *.cmi *.cmo *.byte *.c *.arm_o *.elf *.arm_elf *.hex
