###########################################################
# GCC template makefile
#
# On command line:
#
# make all = Make software.
# make clean = Clean out built project files.
#
# To rebuild project do "make clean" then "make all".
###########################################################

#TOP := $(shell pwd)
TOP := .

include $(TOP)/inc.mk

# Target file name (without extension).
TARGET = $(SUBMDL)

# List C source files here
SRC =

# List C++ source files here.
CPPSRC =

# List Assembler source files here.
# just support capital .S
ASRC =


SUB_DIRS :=
SUB_DIRS += arch
SUB_DIRS +=  common

SUB_DIRS := $(addprefix $(TOP)/,$(SUB_DIRS))

vpath %.c $(SUB_DIRS)
vpath %.S $(SUB_DIRS)

#include all sub directories makefile
sinclude $(addsuffix /Makefile.inc,$(SUB_DIRS))

# List of include file path
#     Each directory must be seperated by a space.
EXTRAINCDIRS += $(TOP)/inc

# List of library file path
#     Each directory must be seperated by a space.
EXTRA_LIBDIRS =

# List of library file
#    Each library-name must be seperated by a space.
#    To add libxyz.a, libabc.a and libefsl.a:
#    EXTRA_LIBS = xyz abc efsl
EXTRA_LIBS =

LIBC_LIB = -L $(shell dirname `$(CC) $(ALL_CFLAGS) -print-file-name=libc.a`) -lc
MATH_LIB = -L $(shell dirname `$(CC) $(ALL_CFLAGS) -print-file-name=libm.a`) -lm
LIBGCC_LIB += -L $(shell dirname `$(CC) $(ALL_CFLAGS) -print-libgcc-file-name`) -lgcc
# CPLUSPLUS_LIB = -lstdc++

# Linker flags.
#  -Wl,...:     tell GCC to pass this to linker.
#    -Map:      create map file
#    --cref:    add cross reference to  map file
#LDFLAGS = -Map=$(TARGET).map --cref

LDFLAGS = -nostartfiles -Wl,-Map=$(TARGET).map,--cref
#LDFLAGS += $(MATH_LIB) $(LIBGCC_LIB) $(LIBC_LIB)
#LDFLAGS += $(CPLUSPLUS_LIB)
LDFLAGS += $(patsubst %,-L%,$(EXTRA_LIBDIRS))
LDFLAGS += $(patsubst %,-l%,$(EXTRA_LIBS))

# Set Linker-Script Depending On Selected Memory and Controller
ifeq ($(RUN_MODE),RAM_RUN)
LDFLAGS +=-Tarch/$(MODEL)/$(SUBMDL)-RAM.ld
else
LDFLAGS +=-Tarch/$(MODEL)/$(SUBMDL)-ROM.ld
endif

# Default target.
all: gccversion createdirs build sizeinfo

ifeq ($(FORMAT),ihex)
build: elf hex lss sym
hex: $(TARGET).hex
IMGEXT=hex
else
ifeq ($(FORMAT),binary)
build: elf bin lss sym
lss: $(TARGET).lss
bin: $(TARGET).bin
sym: $(TARGET).sym
IMGEXT=bin
else
$(error "please check output-format $(FORMAT)")
endif
endif

doc:
	doxygen doc.mk

.PHONY : all build hex bin doc

include $(TOP)/rule.mk
