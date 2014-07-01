# -*- coding: euc-jp -*-
#
#  TECS Generator
#      Generator for TOPPERS Embedded Component System
#  
#   Copyright (C) 2008-2013 by TOPPERS Project
#--
#   �嵭����Ԥϡ��ʲ���(1)��(4)�ξ������������˸¤ꡤ�ܥ��եȥ���
#   �����ܥ��եȥ���������Ѥ�����Τ�ޤࡥ�ʲ�Ʊ���ˤ���ѡ�ʣ������
#   �ѡ������ۡʰʲ������ѤȸƤ֡ˤ��뤳�Ȥ�̵���ǵ������롥
#   (1) �ܥ��եȥ������򥽡��������ɤη������Ѥ�����ˤϡ��嵭������
#       ��ɽ�����������Ѿ�浪��Ӳ�����̵�ݾڵ��꤬�����Τޤޤη��ǥ���
#       ����������˴ޤޤ�Ƥ��뤳�ȡ�
#   (2) �ܥ��եȥ������򡤥饤�֥������ʤɡ�¾�Υ��եȥ�������ȯ�˻�
#       �ѤǤ�����Ǻ����ۤ�����ˤϡ������ۤ�ȼ���ɥ�����ȡ�����
#       �ԥޥ˥奢��ʤɡˤˡ��嵭�����ɽ�����������Ѿ�浪��Ӳ���
#       ��̵�ݾڵ����Ǻܤ��뤳�ȡ�
#   (3) �ܥ��եȥ������򡤵�����Ȥ߹���ʤɡ�¾�Υ��եȥ�������ȯ�˻�
#       �ѤǤ��ʤ����Ǻ����ۤ�����ˤϡ����Τ����줫�ξ�����������
#       �ȡ�
#     (a) �����ۤ�ȼ���ɥ�����ȡ����Ѽԥޥ˥奢��ʤɡˤˡ��嵭����
#         �ɽ�����������Ѿ�浪��Ӳ�����̵�ݾڵ����Ǻܤ��뤳�ȡ�
#     (b) �����ۤη��֤��̤�������ˡ�ˤ�äơ�TOPPERS�ץ������Ȥ�
#         ��𤹤뤳�ȡ�
#   (4) �ܥ��եȥ����������Ѥˤ��ľ��Ū�ޤ��ϴ���Ū�������뤤���ʤ�»
#       ������⡤�嵭����Ԥ����TOPPERS�ץ������Ȥ����դ��뤳�ȡ�
#       �ޤ����ܥ��եȥ������Υ桼���ޤ��ϥ���ɥ桼������Τ����ʤ���
#       ͳ�˴�Ť����ᤫ��⡤�嵭����Ԥ����TOPPERS�ץ������Ȥ�
#       ���դ��뤳�ȡ�
#  
#   �ܥ��եȥ������ϡ�̵�ݾڤ��󶡤���Ƥ����ΤǤ��롥�嵭����Ԥ�
#   ���TOPPERS�ץ������Ȥϡ��ܥ��եȥ������˴ؤ��ơ�����λ�����Ū
#   ���Ф���Ŭ������ޤ�ơ������ʤ��ݾڤ�Ԥ�ʤ����ޤ����ܥ��եȥ���
#   �������Ѥˤ��ľ��Ū�ޤ��ϴ���Ū�������������ʤ�»���˴ؤ��Ƥ⡤��
#   ����Ǥ�����ʤ���
#  
#   $Id: messages_file_ja_JP.rb 1925 2013-01-20 05:55:58Z okuma-top $
#++


# File Messages for ja_JP
class TECSMsg

## generate.rb ##

@@comment = {}

# MSg.note
@@comment[ :note ] = " * ���Υե������ tecsgen �ˤ�꼫ư��������ޤ���
 * ���Υե�������Խ����ƻ��Ѥ��뤳�Ȥϡ��տޤ���Ƥ��ޤ���
"

@@comment[ :preamble_note ] = "/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
"

@@comment[ :postamble_note ] = "/* #[<POSTAMBLE>]#
 *   �����겼����������ؿ���񤭤ޤ�
 * #[</POSTAMBLE>]#*/
"

@@comment[ :template_note ] = "/*
 * ���Υե������ tecsgen �ˤ��ƥ�ץ졼�ȤȤ��Ƽ�ư��������ޤ���
 * ���Υե�������Խ����ƻ��Ѥ��뤳�Ȥ��տޤ���Ƥ��ޤ���
 * tecsgen �κƼ¹Ԥˤ���񤭤���Ƥ��ޤ����ᡢ�̾�
 *   gen/%s_template.c => src/%s.c
 * �Τ褦��̾��, �ե�������ѹ����Ƥ��齤�����ޤ�
 */
"

@@comment[ :inline_template_note ] = "/*
 * ���Υե������ tecsgen �ˤ��ƥ�ץ졼�ȤȤ��Ƽ�ư��������ޤ���
 * ���Υե�������Խ����ƻ��Ѥ��뤳�Ȥ��տޤ���Ƥ��ޤ���
 * tecsgen �κƼ¹Ԥˤ���񤭤���Ƥ��ޤ����ᡢ�̾�
 *   gen/%s_inline_template.h => src/%s_inline.h
 * �Τ褦��̾��, �ե�������ѹ����Ƥ��齤�����ޤ�
 */
"

@@comment[ :Makefile_note ] = "# ���Υե������ tecsgen �ˤ�꼫ư��������ޤ���
# Makefile.temp �� gen �ΰ�ľ�Υǥ��쥯�ȥ�˰ܤ��ƻ��Ѥ��ޤ�
#  % mv Makefile.temp Makefile
# 
# clean �Υǥե����ư��� $(GEN_DIR)/Makefile.* �������ޤ�
#
# ���Υե������ GNU make �� gcc ���Ѥ� POSIX �Ķ���ư���⥸�塼���ӥ�ɤ���Τ�Ŭ�ڤʤ褦����������Ƥ��ޤ�
# vpath, CFLAGS, OTHER_OBJS �ʤɤ�Ĵ������ɬ�פ����뤫�⤷��ޤ���
# ¾�δĶ��䥿�����åȤξ�硢���Υե�����򸵤��ѹ�����ɬ�פ�����ޤ�

"

@@comment[ :oneway_ercd_note ] = "/* oneway �ξ�� E_OK �����֤��ޤ��� */"
@@comment[ :ercd_note ] = "/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */"

@@comment[ :IMP_comment ] = "\n/* import_C �ˤ�� import �����إå� %s */\n"
@@comment[ :MVAR_comment ] = "# �ѿ� %s\n"
@@comment[ :MRUL_comment ] = "# �롼�� %s\n"
@@comment[ :TCM_comment ] = "# �ƥ�ץ졼�ȥ����ɤǥ᡼�����Ƥߤ��� %s\n"
@@comment[ :MDEP_comment ] = "\n# depend �� include %s\n"
@@comment[ :SD_comment ] = "/* �����˥���ǥ�������ץ� %s */\n"
@@comment[ :SFT_comment ] = "/* �����˥���ؿ��ơ��֥� %s */\n"
# @@comment[ :IRTH_comment ] = "/* ��󥿥���إå� %s */\n"
@@comment[ :UDF_comment ] = "/* inline �Τ���� undef %s */\n"
@@comment[ :IGH_comment ] = "/* �����Х�إå� %s */\n"
@@comment[ :ISH_comment ] = "/* �����˥���إå� %s */\n"
@@comment[ :ICT_comment ] = "/* ��Ŭ���Τ��Ỳ�Ȥ��륻�륿���פ� CB ������������� %s */\n"
@@comment[ :NIDB_comment ] = "ID �Υ١��� "
@@comment[ :NCEL_comment ] = "����θĿ�"
@@comment[ :CVI_comment ] = "/* IDX�������������å��ޥ��� %s */\n"
@@comment[ :CVIA_comment ] = "/* IDX�������������å��ޥ����û�̷��� %s */\n"
@@comment[ :NCPA_comment ] = "/* �ƤӸ�������礭��������ޥ��� %s */\n"
@@comment[ :NEPA_comment ] = "/* ������������礭��������ޥ��� %s */\n"
@@comment[ :TOCP_comment ] = "/* optional �ƤӸ���ƥ��Ȥ���ޥ��� %s */\n"
@@comment[ :TOCPA_comment ] = "/* optional �ƤӸ���ƥ��Ȥ���ޥ����û�̷��� %s */\n"
@@comment[ :GCB_comment ] = "\n/* ����CB������ޥ��� %s */\n"
@@comment[ :GCBA_comment ] = "\n/* ����CB������ޥ���(û�̷�) %s */\n"
@@comment[ :CCT_comment ] = "/* CELLCB ��(û�̷�) %s */\n"
@@comment[ :CTIXA_comment ] = "/* ���륿���פ�IDX��(û�̷�) %s */\n"
@@comment[ :AAM_comment ] = "\n/* °�����������ޥ��� %s */\n"
@@comment[ :VAM_comment ] = "\n/* var ���������ޥ��� %s */\n"
@@comment[ :AAMA_comment ] = "\n/* °�����������ޥ���(û�̷�) %s */\n"
@@comment[ :VAMA_comment ] = "\n/* var ���������ޥ���(û�̷�) %s */\n"
@@comment[ :CPM_comment ] = " /* �ƤӸ��ؿ��ޥ��� %s */\n"
@@comment[ :CPMA_comment ] = "/* �ƤӸ��ؿ��ޥ����û�̷���%s */\n"
@@comment[ :EPM_comment ] = "\n/* �������ؿ��ޥ����û�̷��� %s */\n"
@@comment[ :CTIX_comment ] = "\n/* ���륿���פ�IDX�� %s */\n"
@@comment[ :EPP_comment ] = "\n/* �������ؿ��ץ�ȥ�������� %s */\n"
@@comment[ :EPSP_comment ] = "\n/* ������������ȥ�ؿ��ץ�ȥ����������VMT���׺�Ŭ���ˤ�껲�Ȥ����Ρ� %s */\n"
@@comment[ :INL_comment ] = "/* inline �إå��� include %s */\n"
@@comment[ :CIP_comment ] = "/* ���� INIB ����� %s */\n"
@@comment[ :CCTPA_comment ] = "/* ���� CB ����� %s */\n"
@@comment[ :CCDP_comment ] = "/* ���� CB (���ߡ�)����� %s */\n"
@@comment[ :CCTPO_comment ] = "/* ���� CB ����� %s */\n"
@@comment[ :SCP_comment ] = "/* ���󥰥�ȥ󥻥� CB �ץ�ȥ�������� %s */\n"
@@comment[ :DCI_comment ] = "\n/* CB ��¸�ߤ��ʤ���INIB �� CB ������˻��Ѥ��뤿��� define %s */\n"
@@comment[ :FEC_comment ] = "/* ���ƥ졼�������� (FOREACH_CELL)������ %s */\n"
@@comment[ :DAL_comment ] = "/* deallocate �ޥ��� %s */\n"
@@comment[ :NFEC_comment ] = "/* ���ƥ졼�������� (FOREACH_CELL)������(CB,INIB ��¸�ߤ��ʤ�) %s */\n"
@@comment[ :CIM_comment ] = "/* CB ������ޥ��� %s */\n"
@@comment[ :EDT_comment ] = "/* �������ǥ�������ץ��� %s */\n"
@@comment[ :EPSF_comment ] = "/* ������������ȥ�ؿ� %s */\n"
@@comment[ :EPSFT_comment ] = "/* ������������ȥ�ؿ��ơ��֥� %s */\n"
@@comment[ :CPEPD_comment ] = "/* �ƤӸ��λ��Ȥ���������ǥ�������ץ�(�ºݤη�����㤷�����) %s */\n"
@@comment[ :CPA_comment ] = "/* �ƤӸ����� %s */\n"
@@comment[ :CIC_comment ] = "/* CB ����������� %s */\n"
@@comment[ :AVAI_comment ] = "/* °�����ѿ������� %s */\n"
@@comment[ :AVI_comment ] = "/* �ѿ�(��¤�Ρ�����)����� %s */\n"
@@comment[ :INIB_comment ] = "/* ���� INIB %s */\n"
@@comment[ :CB_comment ] = "/* ���� CB %s */\n"
@@comment[ :EPD_comment ] = "/* �������ǥ�������ץ� %s */\n"
@@comment[ :PAC_comment ] = "/* �ץ�ȥ�����������ѿ�������򤳤��˽񤭤ޤ� %s */\n"
@@comment[ :CAAM_comment ] = " *\n * °�����������ޥ��� %s\n"
@@comment[ :CAAMI_comment ] = " *\n * °�����������ޥ��� %s\n"
@@comment[ :TYP_comment ] = " *\n * �� %s\n * CELLCB ��  : %s\n * CELLIDX �� : %s\n"
@@comment[ :TCPF_comment ] = " * �ƤӸ��ؿ� %s\n"
@@comment[ :TEPF_comment ] = "/* �������ؿ� %s */\n"
@@comment[ :TEFB_comment ] = "\t/* �����˽������Τ򵭽Ҥ��ޤ� %s */\n"

end
