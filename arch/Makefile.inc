###########################################################
# GCC template makefile
###########################################################

SUB_ARCH := $(MODEL) STM32F10x_StdPeriph_Driver/src
#SUB_ARCH += STM32_USB-FS-Device_Driver/src
SUB_ARCH := $(addprefix $(TOP)/arch/,$(SUB_ARCH))

vpath %.c $(SUB_ARCH)
vpath %.S $(SUB_ARCH)

sinclude $(addsuffix /Makefile.inc,$(SUB_ARCH))

EXTRAINCDIRS += $(TOP)/arch/cmsis/include
EXTRAINCDIRS += $(TOP)/arch/include
EXTRAINCDIRS += $(TOP)/arch/STM32F10x_StdPeriph_Driver/inc
#EXTRAINCDIRS += $(TOP)/arch/STM32_USB-FS-Device_Driver/inc


ARCH_ASRC	 =
ARCH_SRC	 = main.c

ASRC		+= $(ARCH_ASRC)
SRC		+= $(ARCH_SRC)
