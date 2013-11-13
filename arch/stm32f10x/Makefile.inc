###########################################################
# GCC template makefile
###########################################################

STM32F10X_ASRC	 = startup_stm32f10x_md.S
STM32F10X_SRC	 =
STM32F10X_SRC	 += stm32f10x_it.c
STM32F10X_SRC	 += system_stm32f10x.c

ASRC		+= $(STM32F10X_ASRC)
SRC		+= $(STM32F10X_SRC)
