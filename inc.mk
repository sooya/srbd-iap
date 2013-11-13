###########################################################
# GCC template makefile inc.mk
#
# On command line:
#
# make all = Make software.
# make clean = Clean out built project files.
#
# To rebuild project do "make clean" then "make all".
###########################################################

# model & sub model
MODEL = stm32f10x
SUBMDL = srbd-iap

ifeq ($(ComSpec),)
CROSS_COMPILE = /opt/CodeSourcery/eabi/arm-2012.03/bin/arm-none-eabi
else
SHELLCMD = cs-
CROSS_COMPILE = arm-none-eabi
endif

## Create ROM-Image (final)
RUN_MODE=ROM_RUN
## Create RAM-Image (debugging)
#RUN_MODE=RAM_RUN

# Define programs and commands.
SHELL = sh
CC = $(CROSS_COMPILE)-gcc
CPP = $(CROSS_COMPILE)-g++
AR = $(CROSS_COMPILE)-ar
LD = $(CROSS_COMPILE)-ld
OBJCOPY = $(CROSS_COMPILE)-objcopy
OBJDUMP = $(CROSS_COMPILE)-objdump
SIZE = $(CROSS_COMPILE)-size
NM = $(CROSS_COMPILE)-nm
REMOVE = $(SHELLCMD)rm -f
REMOVEDIR = $(SHELLCMD)rm -rf

CPU_SPEC = -march=armv7-m -mthumb -mthumb-interwork
#CPU_SPEC  += -mfloat-abi=soft
#CPU_SPEC  += -mfloat-abi=hard -mfpu=fpv4-sp-d16

## Output format. (can be ihex or binary)
## (binary i.e. for openocd and SAM-BA, hex i.e. for lpc21isp and uVision)
#FORMAT = ihex
FORMAT = binary

# Optimization level, can be [0, 1, 2, 3, s].
# 0 = turn off optimization. s = optimize for size.
# (Note: 3 is not always the best optimization level. See avr-libc FAQ.)
OPT = 2

# Debugging format.
# Native formats for GCC's -g are stabs [default], or dwarf-2.
#DEBUG = stabs
DEBUG = dwarf-2

# Place -D or -U options for C here
CDEFS =  -D$(RUN_MODE)

# Place -I options here
CINCS =

# Place -D or -U options for ASM here
ADEFS =  -D$(RUN_MODE)

# Compiler flags.
#  -g*:          generate debugging information
#  -O*:          optimization level
#  -f...:        tuning, see GCC manual and avr-libc documentation
#  -Wall...:     warning level
#  -Wa,...:      tell GCC to pass this to the assembler.
#    -adhlns...: create assembler listing
#
# Flags for C and C++ (arm-elf-gcc/arm-elf-g++)
CFLAGS = -g$(DEBUG)
CFLAGS += $(CDEFS) $(CINCS)
CFLAGS += -O$(OPT)
CFLAGS += -Wall -Wcast-align -Wimplicit
CFLAGS += -Wpointer-arith -Wswitch
CFLAGS += -Wredundant-decls -Wreturn-type -Wshadow -Wunused
#CFLAGS += -Wa,-adhlns=$(subst $(suffix $<),.lst,$<)
CFLAGS += $(patsubst %,-I%,$(EXTRAINCDIRS))

# flags only for C
CONLYFLAGS += -Wnested-externs

# Compiler flag to set the C Standard level.
# c89   - "ANSI" C
# gnu89 - c89 plus GCC extensions
# c99   - ISO C99 standard (not yet fully implemented)
# gnu99 - c99 plus GCC extensions
CONLYFLAGS += -std=gnu99

#warnings with:
CFLAGS += -Wcast-qual
CONLYFLAGS += -Wmissing-prototypes
CONLYFLAGS += -Wstrict-prototypes
CONLYFLAGS += -Wmissing-declarations

# output directory
LIB_DIR		:= $(TOP)/lib.$(SUBMDL)
OUT_DIR		:= obj.$(SUBMDL)
PRJ_LIBS	:=
