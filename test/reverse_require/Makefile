# ���Υե������ tecsgen �ˤ�꼫ư��������ޤ���
# Makefile.temp �� gen �ΰ�ľ�Υǥ��쥯�ȥ�˰ܤ��ƻ��Ѥ��ޤ�
#  % mv Makefile.temp Makefile
# 
# clean �Υǥե����ư��� $(GEN_DIR)/Makefile.* �������ޤ�

# �ѿ� #_MVAR_#
TARGET = rr.exe
TIMESTAMP = tecsgen.timestamp
TECSGEN_EXE = tecsgen
CC = gcc
CFLAGS = -I . -I gen -I ../cygwin -I ../../tecs
LD = gcc
LDFLAGS = 
GEN_DIR = gen
SRC_DIR = src
vpath %.c $(SRC_DIR) $(GEN_DIR)

vpath %.h $(SRC_DIR) $(GEN_DIR)

# �롼�� #_MRUL_#
no_target :
	@echo "no target specified"
	@echo "at first or when edit .cdl files, do below"
	@echo "% make tecs"
	@echo "at second, do below"
	@echo "% make all"
	@echo "to clean"
	@echo "% make clean"

all : $(TARGET) 


# depend �� include #_MDEP_#
-include gen/Makefile.tecsgen
-include gen/Makefile.depend

$(TARGET) : $(TIMESTAMP) $(CELLTYPE_COBJS) $(TECSGEN_COBJS) $(PLUGIN_COBJS)
	$(LD) $(LDFLAGS) -o $(TARGET) $(TECSGEN_COBJS) $(CELLTYPE_COBJS) $(PLUGIN_COBJS)


clean :
	rm -rf $(GEN_DIR)
	rm -f $(TECS_COBJS)
	rm -f $(TARGET)
	rm -f $(TIMESTAMP)

tecs : $(TIMESTAMP)

$(TIMESTAMP) : $(TECS_IMPORTS)
	$(TECSGEN_EXE)  -I ../cygwin -I ../../tecs rr.cdl
	touch $(TIMESTAMP)

tInitializer.o : tInitializer.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tCelltype.o : tCelltype.c
	$(CC) -c $(CFLAGS) -o $@ $<
 