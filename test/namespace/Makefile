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
TARGET = namespace.exe
TIMESTAMP = tecsgen.timestamp
TECSGEN_EXE = tecsgen
BASE_DIR = .
CC = gcc
CFLAGS = -I ../cygwin -I ../../tecs -I $(GEN_DIR) -D "Inline=static inline"
LD = gcc
LDFLAGS = 
GEN_DIR = $(BASE_DIR)/gen
SRC_DIR = $(BASE_DIR)/src
_TECS_OBJ_DIR = $(GEN_DIR)/
#   _TECS_OBJ_DIR   # should be end with '/'

vpath %.c $(SRC_DIR) $(GEN_DIR)  ../cygwin
vpath %.h $(SRC_DIR) $(GEN_DIR)  ../cygwin

OTHER_OBJS =                       # Add objects out of tecs care.
# OTHER_OBJS = $(_TECS_OBJ_DIR)vasyslog.o

# �롼�� #_MRUL_#
allall: tecs
	make all

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
	$(TECSGEN_EXE)  -I ../cygwin namespace.cdl
	touch $(TIMESTAMP)

# generic target for objs
$(_TECS_OBJ_DIR)%.o : %.c
	$(CC) -c $(CFLAGS) -o $@ $<

tKernel.o : tKernel.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tAppl.o : tAppl.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
tOSEKAppl.o : tOSEKAppl.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
nAlloc_tAlloc.o : nAlloc_tAlloc.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
TOPPERS_tKernel.o : TOPPERS_tKernel.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
TOPPERS_tAppl.o : TOPPERS_tAppl.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
OSEK_tKernel.o : OSEK_tKernel.c
	$(CC) -c $(CFLAGS) -o $@ $<
 