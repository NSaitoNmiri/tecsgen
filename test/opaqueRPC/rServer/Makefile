# ���Υե������ tecsgen �ˤ�꼫ư��������ޤ���
# Makefile.temp �� gen �ΰ�ľ�Υǥ��쥯�ȥ�˰ܤ��ƻ��Ѥ��ޤ�
#  % mv Makefile.temp Makefile
# 
# clean �Υǥե����ư��� $(GEN_DIR)/Makefile.* �������ޤ�

# �ѿ� #_MVAR_#
TARGET = opaqueRPC-rServer.exe
TIMESTAMP = tecsgen.timestamp
TECSGEN_EXE = tecsgen
CC = gcc -O2
CFLAGS = -I .. -I ../../cygwin -I ../../../tecs -I ../../../tecs/rpc -I $(GEN_DIR) -D __extension__= -D "Inline=static inline" -D RPC_DEBUG
LD = gcc
LDFLAGS = 
GEN_DIR = ../gen/rServer
SRC_DIR = ../src
OTHER_OBJS = vasyslog.o                     # Add objects out of tecs care.

vpath %.c $(SRC_DIR) $(GEN_DIR) ../../cygwin ../../../tecs/rpc
vpath %.h $(SRC_DIR) $(GEN_DIR) ../../cygwin ../../../tecs/rpc

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
-include $(GEN_DIR)/Makefile.tecsgen
-include $(GEN_DIR)/Makefile.depend

$(TARGET) : $(CELLTYPE_COBJS) $(TECSGEN_COBJS) $(PLUGIN_COBJS) $(OTHER_OBJS)
	$(LD) $(LDFLAGS) -o $(TARGET) $(TECSGEN_COBJS) $(CELLTYPE_COBJS) $(PLUGIN_COBJS) $(OTHER_OBJS) -lpthread

clean :
	rm -f $(CELLTYPE_COBJS) $(TECSGEN_COBJS) $(PLUGIN_COBJS) $(OTHER_OBJS) $(TARGET) 

tecs:
	@echo "run 'make tecs' in root region"

tSysLog.o : tSysLog.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tTask.o : tTask.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tKernel.o : tKernel.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tTDR.o : tTDR.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tRPCDedicatedTaskMainWithOpener.o : tRPCDedicatedTaskMainWithOpener.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tPPAllocator.o : tPPAllocator.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tSocketServer.o : tSocketServer.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tAlloc.o : tAlloc.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tSimpleServer.o : tSimpleServer.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tTracePlugin_sSimple.o : tTracePlugin_sSimple.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tOpaqueUnmarshaler_sSimple.o : tOpaqueUnmarshaler_sSimple.c
	$(CC) -c $(CFLAGS) -o $@ $<
 