# このファイルは tecsgen により自動生成されました
# Makefile.temp は gen の一つ上のディレクトリに移して使用します
#  % mv Makefile.temp Makefile
# 
# clean のデフォルト動作は $(GEN_DIR)/Makefile.* を削除します

# 変数 #_MVAR_#
TARGET = opaqueRPC-rClient.exe
TIMESTAMP = tecsgen.timestamp
TECSGEN_EXE = tecsgen
BASE_DIR = ../
CC = gcc
CFLAGS = -O2 -I .. -I $(BASE_DIR). -I $(BASE_DIR)../cygwin -I $(BASE_DIR)../../tecs -I $(BASE_DIR)../../tecs/rpc -I $(GEN_DIR) -D "Inline=static inline" -D __extension__= -D RPC_DEBUG -D NBOTDR_LITTLEENDIAN -D NBOTDR_INT_BIT=32 -D NBOTDR_INTPTR_BIT=32  -D NBOTDR_LONG_BIT=32  -D NBOTDR_SHORT_BIT=16
LD = gcc
LDFLAGS = 
GEN_DIR = $(BASE_DIR)gen/rClient
SRC_DIR = $(BASE_DIR)src
OTHER_OBJS = vasyslog.o                     # Add objects out of tecs care.

vpath %.c $(SRC_DIR) $(GEN_DIR) $(BASE_DIR)../cygwin $(BASE_DIR)../../tecs/rpc
vpath %.h $(SRC_DIR) $(GEN_DIR) $(BASE_DIR)../cygwin $(BASE_DIR)../../tecs/rpc

# ルール #_MRUL_#
no_target :
	@echo "no target specified"
	@echo "at first or when edit .cdl files, do below"
	@echo "% make tecs"
	@echo "at second, do below"
	@echo "% make all"
	@echo "to clean"
	@echo "% make clean"

all : $(TARGET)


# depend を include #_MDEP_#
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
 
tSocketClient.o : tSocketClient.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tAlloc.o : tAlloc.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tSimpleClient.o : tSimpleClient.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tTracePlugin_sSimple.o : tTracePlugin_sSimple.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tOpaqueMarshaler_sSimple.o : tOpaqueMarshaler_sSimple.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
