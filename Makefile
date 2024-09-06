.PHONY: all clean check
.SUFFIXES:
.SUFFIXES: .asm .o .gb

BINDIR = bin
BINDIR_GB = $(BINDIR)/gb
BINDIR_DUCK = $(BINDIR)/duck
BIN_GB = $(BINDIR_GB)/supermarioland.gb
BIN_DUCK = $(BINDIR_DUCK)/supermarioland.duck

OBJ = obj
OBJ_GB = $(OBJ)/gb
OBJ_DUCK = $(OBJ)/duck

OBJECTS_RAW := bank0.o bank1.o bank2.o bank3.o music.o levels/enemy_locations.o

OBJECTS_GB = $(OBJECTS_RAW:%=$(OBJ_GB)/%)
OBJECTS_DUCK = $(OBJECTS_RAW:%=$(OBJ_DUCK)/%)

MKDIRS = $(BINDIR) $(OBJ_GB) $(OBJ_DUCK) $(OBJ_GB)/levels $(OBJ_DUCK)/levels $(BINDIR_GB) $(BINDIR_DUCK)

all: gb duck check

gb: $(BIN_GB) check

duck: $(BIN_DUCK)

clean:
	rm -rf $(BINDIR_GB) $(BINDIR_DUCK) $(OBJECTS_GB) $(OBJECTS_DUCK)

# Quietly check the hash of the newly built ROM to make sure any disassembled
# code matches the original
check: $(BIN_GB)
	@sha1sum -c --quiet rom.sha1

# Export everything for the moment, to make debugging easier
$(OBJ_GB)/%.o: %.asm
	@echo " ASM	$@"
	rgbasm  -l -E -h -o $@ $<

$(BIN_GB): $(OBJECTS_GB)
	@echo " LINK	$@"
	rgblink -d -n $*.sym -m $*.map -o $@ $^
	rgbfix -v $@


$(OBJ_DUCK)/%.o: %.asm
	@echo " ASM	$@"
	rgbasm  -DTARGET_MEGADUCK -l -E -h -o $@ $<

$(BIN_DUCK): $(OBJECTS_DUCK)
	@echo " LINK	$@"
	rgblink -d -n $(BINDIR_DUCK)/supermarioland.sym -m $(BINDIR_DUCK)/supermarioland.map -o $@ $^


# create necessary directories after Makefile is parsed but before build
# info prevents the command from being pasted into the makefile
$(info $(shell mkdir -p $(MKDIRS)))