###########################################################
# GCC template makefile rule.mk
#
# On command line:
#
# make all = Make software.
# make clean = Clean out built project files.
#
# To rebuild project do "make clean" then "make all".
###########################################################

ifndef CROSS_COMPILE
$(error CROSS_COMPILE is not defined, Please include 'inc.mk' first)
endif

# Add target processor to flags.
ALL_CFLAGS = $(CPU_SPEC) -I. $(CFLAGS) $(GENDEPFLAGS)
ALL_ASFLAGS = $(CPU_SPEC) -I. -x assembler-with-cpp $(ASFLAGS)

# Define all object files.
COBJ      = $(addprefix $(OUT_DIR)/,$(SRC:.c=.o))
AOBJ      = $(addprefix $(OUT_DIR)/,$(ASRC:.S=.o))
CPPOBJ  = $(addprefix $(OUT_DIR)/,$(CPPSRC:.cpp=.o))

# Display size of file.
HEXSIZE = $(SIZE) --target=$(FORMAT) $(TARGET).hex
ELFSIZE = $(SIZE) -A $(TARGET).elf

sizeinfo:
	$(ELFSIZE)

# Display compiler version information.
gccversion :
	@$(CC) --version

# Create output directories.
createdirs:
	@echo create directory $(OUT_DIR)
ifeq ($(ComSpec),)
	$(shell [ -d ${OUT_DIR} ] || mkdir ${OUT_DIR})
else
	@md $(OUT_DIR) >NUL 2>&1 || echo "" >NUL
endif


# Create final output file (.hex) from ELF output file.
%.hex: %.elf
	$(OBJCOPY) -O $(FORMAT) $< $@

# Create final output file (.bin) from ELF output file.
%.bin: %.elf
	$(OBJCOPY) -O $(FORMAT) $< $@


# Create extended listing file from ELF output file.
# testing: option -C
%.lss: %.elf
	$(OBJDUMP) -h -S -C $< > $@


# Create a symbol table from ELF output file.
%.sym: %.elf
	$(NM) -n $< > $@

# Link: create ELF output file from object files.
.SECONDARY : $(TARGET).elf
.PRECIOUS : $(AOBJ) $(COBJ) $(CPPOBJ)
%.elf:  $(AOBJ) $(COBJ) $(CPPOBJ) $(PRJ_LIBS)
#	$(LD) -X -N $^ $(LDFLAGS) --output $@
	$(CC) $(ALL_CFLAGS)  $^ --output $@ $(LDFLAGS)
#	$(CPP) $(ALL_CFLAGS) $^ --output $@ $(LDFLAGS)

# Compile: create object files from C source files. ARM/Thumb
$(COBJ) : $(OUT_DIR)/%.o : %.c
	$(CC) -c $(ALL_CFLAGS) $(CONLYFLAGS) $< -o $@

# Compile: create object files from C++ source files. ARM/Thumb
$(CPPOBJ) : $(OUT_DIR)/%.o : %.cpp
	$(CPP) -c $(ALL_CFLAGS) $(CPPFLAGS) $< -o $@

# Compile: create assembler files from C source files. ARM/Thumb
## does not work - TODO - hints welcome
##$(COBJ) : %.S : %.c
##	$(CC) -S $(ALL_CFLAGS) $< -o $@

# Assemble: create object files from assembler source files. ARM/Thumb
$(AOBJ) : $(OUT_DIR)/%.o : %.S
	$(CC) -c $(ALL_ASFLAGS) $< -o $@


clean:
	@echo Cleaning project:
	$(REMOVE) $(COBJ) $(CPPOBJ) $(AOBJ)
	$(REMOVEDIR) .dep $(OUT_DIR) $(LIB_DIR) .doc
	$(REMOVE) $(TARGET).hex
	$(REMOVE) $(TARGET).bin
	$(REMOVE) $(TARGET).elf
	$(REMOVE) $(TARGET).map
	$(REMOVE) $(TARGET).sym
	$(REMOVE) $(TARGET).lnk
	$(REMOVE) $(TARGET).lss

# Include the dependency files.
ifeq ($(ComSpec),)
-include $(shell mkdir .dep 2>/dev/null) $(wildcard .dep/*)
endif

# Listing of phony targets.
.PHONY : all finish end sizeinfo gccversion createdirs build elf hex bin lss sym clean
