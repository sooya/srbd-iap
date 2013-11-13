###########################################################
# GCC template makefile
###########################################################

COMMONLIB_ASRC	 =
COMMONLIB_SRC	 = common.c
COMMONLIB_SRC	 += download.c
COMMONLIB_SRC	 += upload.c
COMMONLIB_SRC	 += ymodem.c

EXTRAINCDIRS += $(TOP)/common

ASRC		+= $(COMMONLIB_ASRC)
SRC		+= $(COMMONLIB_SRC)
