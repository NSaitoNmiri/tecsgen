# ���Υե������ tecsgen �ˤ�꼫ư��������ޤ���
# Makefile.temp �� gen �ΰ�ľ�Υǥ��쥯�ȥ�˰ܤ��ƻ��Ѥ��ޤ�
#  % mv Makefile.temp Makefile
# 
# clean �Υǥե����ư��� $(GEN_DIR)/Makefile.* �������ޤ�
#
# ���Υե������ GNU make �� gcc ���Ѥ� POSIX �Ķ���ư���⥸�塼���ӥ�ɤ���Τ�Ŭ�ڤʤ褦����������Ƥ��ޤ�
# vpath, CFLAGS, OTHER_OBJS �ʤɤ�Ĵ������ɬ�פ����뤫�⤷��ޤ���
# ¾�δĶ��䥿�����åȤξ�硢���Υե�����򸵤��ѹ�����ɬ�פ�����ޤ�

# �ѿ� #_MVAR_#
TARGET = rpc_test.exe
TIMESTAMP = tecsgen.timestamp
TECSGEN_EXE = tecsgen
BASE_DIR = .
CC = gcc
CFLAGS = -I $(BASE_DIR)/. -I $(BASE_DIR)/../cygwin -I $(BASE_DIR)/../../tecs -I $(BASE_DIR)/../../tecs/rpc -I $(GEN_DIR) -D "Inline=static inline"
LD = gcc
LDFLAGS = -lpthread
GEN_DIR = $(BASE_DIR)/gen
SRC_DIR = $(BASE_DIR)/src
_TECS_OBJ_DIR = $(GEN_DIR)/
#   _TECS_OBJ_DIR   # should be end with '/'

vpath %.c $(SRC_DIR) $(GEN_DIR)  ../cygwin ../../tecs ../../tecs/rpc
vpath %.h $(SRC_DIR) $(GEN_DIR)  ../cygwin ../../tecs ../../tecs/rpc

OTHER_OBJS =                       # Add objects out of tecs care.
# OTHER_OBJS = $(_TECS_OBJ_DIR)vasyslog.o

# �롼�� #_MRUL_#
allall: tecs
	make all     # in order to include generated Makefile.tecsgen & Makefile.depend

all : $(TARGET)


# depend �� include #_MDEP_#
-include $(GEN_DIR)/Makefile.tecsgen
-include $(GEN_DIR)/Makefile.depend

$(TARGET) : $(TIMESTAMP) $(CELLTYPE_COBJS) $(TECSGEN_COBJS) $(PLUGIN_COBJS) $(OTHER_OBJS)
	$(LD) -o $(TARGET) $(TECSGEN_COBJS) $(CELLTYPE_COBJS) $(PLUGIN_COBJS) $(OTHER_OBJS) $(LDFLAGS)

clean :
	rm -f $(CELLTYPE_COBJS) $(TECSGEN_COBJS) $(PLUGIN_COBJS) $(OTHER_OBJS) $(TARGET)  $(TIMESTAMP)
	rm -rf $(GEN_DIR)

tecs : $(TIMESTAMP)

$(TIMESTAMP) : $(TECS_IMPORTS)
	$(TECSGEN_EXE)  -I ../cygwin -I ../../tecs -I ../../tecs/rpc rpc_test.cdl
	touch $(TIMESTAMP)

# generic target for objs
$(_TECS_OBJ_DIR)%.o : %.c
	$(CC) -c $(CFLAGS) -o $@ $<

tTask.o : tTask.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tKernel.o : tKernel.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tSemaphore.o : tSemaphore.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tEventflag.o : tEventflag.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tDataqueuePeer.o : tDataqueuePeer.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tSysLog.o : tSysLog.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tTDR.o : tTDR.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tRPCSharedChannelMan.o : tRPCSharedChannelMan.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tRPCSharedTaskMain.o : tRPCSharedTaskMain.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tPPAllocator.o : tPPAllocator.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tDataqueueAdaptor.o : tDataqueueAdaptor.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tAlloc.o : tAlloc.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tSample.o : tSample.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tSimple.o : tSimple.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tMarshaler_sSample.o : tMarshaler_sSample.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tUnmarshaler_sSample.o : tUnmarshaler_sSample.c
	$(CC) -c $(CFLAGS) -o $@ $<
 