.PHONY: all clean check
.SUFFIXES:
.SUFFIXES: .asm .o .gb

INCDIR = inc

BINDIR = bin

BINDIR_GB        = $(BINDIR)/gb
BINDIR_DUCK      = $(BINDIR)/duck
BINDIR_DUCK_MBC5 = $(BINDIR)/duck_mbc5

BIN_GB        = $(BINDIR_GB)/supermarioland.gb
BIN_DUCK      = $(BINDIR_DUCK)/supermarioland_md2.duck
BIN_DUCK_MBC5 = $(BINDIR_DUCK_MBC5)/supermarioland_mbc5.duck

OBJ = obj
OBJ_GB        = $(OBJ)/gb
OBJ_DUCK      = $(OBJ)/duck
OBJ_DUCK_MBC5 = $(OBJ)/duck_mbc5

OBJECTS_RAW := bank0.o bank1.o bank2.o bank3.o music.o levels/enemy_locations.o

OBJECTS_GB        = $(OBJECTS_RAW:%=$(OBJ_GB)/%)
OBJECTS_DUCK      = $(OBJECTS_RAW:%=$(OBJ_DUCK)/%)
OBJECTS_DUCK_MBC5 = $(OBJECTS_RAW:%=$(OBJ_DUCK_MBC5)/%)

MKDIRS = $(BINDIR) $(OBJ_GB) $(OBJ_DUCK) $(OBJ_DUCK_MBC5) $(OBJ_GB)/levels $(OBJ_DUCK)/levels $(OBJ_DUCK_MBC5)/levels $(BINDIR_GB) $(BINDIR_DUCK) $(BINDIR_DUCK_MBC5)

all: gb duck duck_mbc5 check

gb: $(BIN_GB) check

duck: $(BIN_DUCK)

duck_mbc5: $(BIN_DUCK_MBC5)

clean:
	rm -rf $(BINDIR_GB) $(BINDIR_DUCK) $(BINDIR_DUCK_MBC5) $(OBJECTS_GB) $(OBJECTS_DUCK) $(OBJECTS_DUCK_MBC5)

# Quietly check the hash of the newly built ROM to make sure any disassembled
# code matches the original
check: $(BIN_GB)
	@sha1sum -c --quiet rom.sha1

# Export everything for the moment, to make debugging easier
$(OBJ_GB)/%.o: %.asm $(INCDIR)/settings.inc $(INCDIR)/hardware.inc # Make sure inc files trigger rebuilds
	@echo " ASM	$@"
	rgbasm  -l -E -h -o $@ $<

$(BIN_GB): $(OBJECTS_GB)
	@echo " LINK	$@"
	rgblink -d -n $*.sym -m $*.map -o $@ $^
	rgbfix -v $@


$(OBJ_DUCK)/%.o: %.asm $(INCDIR)/settings.inc $(INCDIR)/hardware.inc # Make sure inc files trigger rebuilds
	@echo " ASM	$@"
	rgbasm  -DTARGET_MEGADUCK -l -E -h -o $@ $<

$(BIN_DUCK): $(OBJECTS_DUCK)
	@echo " LINK	$@"
	rgblink -d -n $(BINDIR_DUCK)/supermarioland_md2.sym -m $(BINDIR_DUCK)/supermarioland_md2.map -o $@ $^


$(OBJ_DUCK_MBC5)/%.o: %.asm $(INCDIR)/settings.inc $(INCDIR)/hardware.inc # Make sure inc files trigger rebuilds
	@echo " ASM	$@"
	rgbasm  -DTARGET_MEGADUCK -DMEGADUCK_MBC5 -l -E -h -o $@ $<

$(BIN_DUCK_MBC5): $(OBJECTS_DUCK_MBC5)
	@echo " LINK	$@"
	rgblink -d -n $(BINDIR_DUCK_MBC5)/supermarioland_mbc5.sym -m $(BINDIR_DUCK_MBC5)/supermarioland_mbc5.map -o $@ $^

romusage:
	romusage $(BINDIR_DUCK)/supermarioland_md2.map -g -sRp

# create necessary directories after Makefile is parsed but before build
# info prevents the command from being pasted into the makefile
$(info $(shell mkdir -p $(MKDIRS)))
