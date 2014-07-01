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
#   $Id: messages_console_ja_JP.rb 1925 2013-01-20 05:55:58Z okuma-top $
#++


# Console Messages for ja_JP
class TECSMsg

###
# ���顼��å�����
@@error_message = {}

### C_parser.y.rb
# B1001 need parameter name"
@@error_message[ :"B1001" ] = "�ѥ�᡼��̾��ɬ�פǤ�" 

# B1002 while open or reading \'$1\'"
@@error_message[ :"B1002" ] = "\'$1\' �Υ����ץ�ޤ����ɤ߹��ߤ˼��Ԥ��ޤ���" 

# B1003 Unexpected EOF"
@@error_message[ :"B1003" ] = "ͽ�����ʤ� EOF �Ǥ�"

# B1004 syntax error near \'$1\'"
@@error_message[ :"B1004" ] = "\'$1\' �ն�ι�ʸ���顼�Ǥ�"

### ctypes.rb
# C1001 $1: mismatch, suitable for integer types"
@@error_message[ :"C1001" ] = "$1: ���礷�Ƥ��ޤ���, �������������Ŭ���Ƥ��ޤ�"

# C1002 $1 not compatible with previous one $2"
@@error_message[ :"C1002" ] = "$1 �Ϥ�������Τ�ΤǤ��� $2 ��ξΩ���ޤ���"

# C1003 $1 & $2 incompatible  (\'long double\' not support)"
@@error_message[ :"C1003" ] = "$1 �ڤ� $2 ��ξΩ���ޤ��� (\'long double\' ��̤���ݡ���)"

# C1004 $1: qualifier respecified. previous one: $2"
@@error_message[ :"C1004" ] = "$1: �����Ҥ����ٻ��ꤵ��ޤ���. �������ν�����: $2"

### expression.rb
# E1001 $1: not found"
@@error_message[ :"E1001" ] = "$1: ���Ĥ���ޤ���"

# E1002 $1: not constant (port)"
@@error_message[ :"E1002" ] = "$1: ����ǤϤ���ޤ��� (port)"

# E1003 $1: not constant"
@@error_message[ :"E1003" ] = "$1: ����ǤϤ���ޤ���"

# E1004 cannot evaluate \'[]\' operator"
@@error_message[ :"E1004" ] = "\'[]\' �黻�Ҥ�ɾ���Ǥ��ޤ���"

# E1005 cannot evaluate \'.\' operator"
@@error_message[ :"E1005" ] = "\'.\' �黻�Ҥ�ɾ���Ǥ��ޤ���"

# E1006 cannot evaluate \'->\' operator"
@@error_message[ :"E1006" ] = "\'->\' �黻�Ҥ�ɾ���Ǥ��ޤ���"

# E1007 cannot evaluate \'sizeof\' operator"
@@error_message[ :"E1007" ] = "\'sizeof\' �黻�Ҥ�ɾ���Ǥ��ޤ���"

# E1008 cannot evaluate \'sizeof\' operator"
@@error_message[ :"E1008" ] = "\'sizeof\' �黻�Ҥ�ɾ���Ǥ��ޤ���"

# E1009 cannot evaluate \'&\' operator"
@@error_message[ :"E1009" ] = "\'&\' �黻�Ҥ�ɾ���Ǥ��ޤ���"

# E1010 cannot evaluate \'*\' operator"
@@error_message[ :"E1010" ] = "\'*\' �黻�Ҥ�ɾ���Ǥ��ޤ���"

# E1011 cannot evaluate unary + for $1"
@@error_message[ :"E1011" ] = "$1 ���Ф���ñ��� + ��ɾ���Ǥ��ޤ���"

# E1012 $1: not found in parameter list"
@@error_message[ :"E1012" ] = "$1: �ѥ�᡼���ꥹ�Ȥ���˸��Ĥ���ޤ���"

# E1013 \'*\': operand is not pointer value"
@@error_message[ :"E1013" ] = "\'*\': ���ڥ��ɤϥݥ����ͤǤϤ���ޤ���"

# E1014 $1: elements_get_type: sorry not supported"
@@error_message[ :"E1014" ] = "$1: elements_get_type: ����������ޤ��󡥥��ݡ��Ȥ���Ƥ��ޤ���"

# E1015 \'$1\': direction mismatch for $2, $3 required"
@@error_message[ :"E1015" ] = "\'$1\': $2 ���Ф������������礷�Ƥ��ޤ���$3 ��ɬ�פǤ�"

# E1016 $1: elements_check_dir_for_param: sorry not supported"
@@error_message[ :"E1016" ] = "$1: elements_check_dir_for_param: ����������ޤ��󡥥��ݡ��Ȥ���Ƥ��ޤ���"

### bnf.y.rb
# G1001 need specifier for \'$1\'"
@@error_message[ :"G1001" ] = "\'$1\' ���Ф������Ҥ�ɬ�פǤ�"

# G1002 need parameter name"
@@error_message[ :"G1002" ] = "�ѥ�᡼��̾��ɬ�פǤ�"

# G1003 need parameter name"
@@error_message[ :"G1003" ] = "�ѥ�᡼��̾��ɬ�פǤ�"

# G1004 impossible array type 0"
@@error_message[ :"G1004" ] = "�������ʤ����� 0 �Ǥ�"

# G1005 impossible array type 1"
@@error_message[ :"G1005" ] = "�������ʤ����� 1 �Ǥ�"

# G1006 impossible array type 2"
@@error_message[ :"G1006" ] = "�������ʤ����� 2 �Ǥ�"

# G1007 impossible array type 3"
@@error_message[ :"G1007" ] = "�������ʤ����� 3 �Ǥ�"

# G1008 impossible function type"
@@error_message[ :"G1008" ] = "�������ʤ��ؿ����Ǥ�"

# G1009 unexpected specifier"
@@error_message[ :"G1009" ] = "ͽ�����ʤ�����ҤǤ�"

# G1010 Not function"
@@error_message[ :"G1010" ] = "�ؿ��ǤϤ���ޤ���"

# G1011 Not function"
@@error_message[ :"G1011" ] = "�ؿ��ǤϤ���ޤ���"

# G1012 $1 : cannot put specifier here"
@@error_message[ :"G1012" ] = "$1 : �����˻���Ҥ��֤����ȤϤǤ��ޤ���"

# G1013 unexpected specifier"
@@error_message[ :"G1013" ] = "ͽ�����ʤ�����ҤǤ�"

# G1014 while open or reading \'$1\'"
@@error_message[ :"G1014" ] = "\'$1\' �Υ����ץ�ޤ����ɤ߹��ߤ˼��Ԥ��ޤ���"

# G1015 Unexpected EOF"
@@error_message[ :"G1015" ] = "ͽ�����ʤ� EOF �Ǥ�"

# G1016 syntax error near \'$1\'"
@@error_message[ :"G1016" ] = "\'$1\' �ն�ι�ʸ���顼�Ǥ�"

### plugin.rb
# P1001 plugin arg: cannot find identifier in $1"
@@error_message[ :"P1001" ] = "plugin arg: $1 ����˼��̻Ҥ򸫤Ĥ��뤳�Ȥ��Ǥ��ޤ���"

# P1002 plugin arg: expecting \'=\' not \'$1\'"
@@error_message[ :"P1002" ] = "plugin arg: \'$1\' �ǤϤʤ� \'=\' ��ɬ�פǤ�"

# P1003 plugin arg: unexpected $1"
@@error_message[ :"P1003" ] = "plugin arg: ͽ�����ʤ� $1 �Ǥ�"

# P1004 $1: unknown plugin argument\'s identifier\n  $2 are acceptable for RPCPlugin."
@@error_message[ :"P1004" ] = "$1: �����ʥץ饰��������μ��̻�\n  $2 �� RPC �ץ饰������Ф��Ƽ��������ǽ�Ǥ�"

### pluginModule.rb
# P2001 $1.rb : fail to load plugin"
@@error_message[ :"P2001" ] = "$1.rb : �ץ饰������ɤ߹��ߤ˼��Ԥ��ޤ���"

# P2002 $1: not kind of $2"
@@error_message[ :"P2002" ] = "$1: $2 �ΰ��ǤϤ���ޤ���"

# P2003 $1: load failed"
@@error_message[ :"P2003" ] = "$1: �ɤ߹��ߤ˼��Ԥ��ޤ���"

# P2004 $1: open error \'$2\'"
@@error_message[ :"P2004" ] = "$1: �����ץ󥨥顼 \'$2\' ��ȯ�����ޤ���"

# P2005 $1: plugin error in gen_through_cell_code "
@@error_message[ :"P2005" ] = "$1: gen_through_cell_code ��Υץ饰���󥨥顼��ȯ�����ޤ���"

# P2006 $1: close error \'$2\'"
@@error_message[ :"P2006" ] = "$1: \'$2\' �Υ��������顼��ȯ�����ޤ���"

# P2007 $1: fail to generate post code"
@@error_message[ :"P2007" ] = "$1: �ݥ��ȥ����ɤ������˼��Ԥ��ޤ���"

### componentobj.rb
# S1001 context specifier duplicate"
@@error_message[ :"S1001" ] = "����ƥ����Ȼ���Ҥ���ʣ���Ƥ��ޤ�"

# S1002 \'$1\': unknown specifier for signature"
@@error_message[ :"S1002" ] = "\'$1\': �����˥�����Ф��������ʻ���ҤǤ�"

# S1003 $1: \'alloc\' 1st parameter neither [in] integer type nor [out] double pointer type
@@error_message[ :"S1003" ] = "$1: \'alloc\' �ؿ�����1�ѥ�᡼���� in ���������Ǥ� out ����ťݥ��󥿷��Ǥ⤢��ޤ���"

# S1004 $1: \'alloc\' 2nd parameter not [in] double pointer"
@@error_message[ :"S1004" ] = "$1: \'alloc\' �ؿ�����2�ѥ�᡼���� in �Υݥ��󥿤ؤΥݥ��󥿤ǤϤ���ޤ���"

# S1005 $1: \'alloc\' has no parameter, unsuitable for allocator signature"
@@error_message[ :"S1005" ] = "$1: \'alloc\' �ؿ����ѥ�᡼������äƤ��ޤ��󡥥������������˥�����Ф�����Ŭ���Ǥ���"

# S1006 $1: \'dealloc\' 1st parameter not [in] pointer type"
@@error_message[ :"S1006" ] = "$1: \'dealloc\' �ؿ�����1�ѥ�᡼���� in �Υݥ��󥿷��ǤϤ���ޤ���"

# S1007 "
     # S1007 $1: \'dealloc\' cannot has 2nd parameter"
# @@error_message[ :"S1007" ] = "$1: \'dealloc\' �ؿ�����2�ѥ�᡼������Ĥ��Ȥ��Ǥ��ޤ���"

# S1008 $1: \'dealloc\' has no parameter, unsuitable for allocator signature"
@@error_message[ :"S1008" ] = "$1: \'dealloc\' �ؿ����ѥ�᡼������äƤ��ޤ��󡥥������������˥�����Ф�����Ŭ���Ǥ���"

# S1009 $1: \'alloc\' function not found, unsuitable for allocator signature"
@@error_message[ :"S1009" ] = "$1: \'alloc\' �ؿ������Ĥ���ޤ��󡥥������������˥�����Ф�����Ŭ���Ǥ���"

# S1010 $1: \'dealloc\' function not found, unsuitable for allocator signature"
@@error_message[ :"S1010" ] = "$1: \'dealloc\' �ؿ������Ĥ���ޤ��󡥥������������˥�����Ф�����Ŭ���Ǥ���"

# S1011 $1: size_is specified for non-pointer type"
@@error_message[ :"S1011" ] = "$1: ��ݥ��󥿷����Ф��� size_is �����ꤵ��ޤ���"

# S1012 $1: unsuitable initializer, need array initializer"
@@error_message[ :"S1012" ] = "$1: ��Ŭ���ʽ�����ҤǤ�������ν�����Ҥ�ɬ�פǤ���"

# S1013 $1: too many initializer, $2 for $3"
@@error_message[ :"S1013" ] = "$1: ������Ҥ�¿�����ޤ���$3 �Ȥ���Ȥ���� $2 �Ȥ��ޤ�����"

# S1014 generate specifier duplicate"
@@error_message[ :"S1014" ] = "generate ����Ҥ���ʣ���ޤ�����"

# S1015 $1 cannot be specified for composite"
@@error_message[ :"S1015" ] = "$1 ��ʣ�祻����Ф��ƻ���Ǥ��ޤ���"

# S1016 $1 not found"
@@error_message[ :"S1016" ] = "$1 �����Ĥ���ޤ���"

# S1017 $1 : neither celltype nor cell"
@@error_message[ :"S1017" ] = "$1 : ���륿���פǤ⥻��Ǥ⤢��ޤ���"

# S1018 $1 : not singleton cell"
@@error_message[ :"S1018" ] = "$1 : ���󥰥�ȥ󥻥�ǤϤ���ޤ���"

# S1019 \'$1\' : not entry port"
@@error_message[ :"S1019" ] = "\'$1\' : �������ǤϤ���ޤ���"

# S1020 \'$1\' : required port cannot be array"
@@error_message[ :"S1020" ] = "\'$1\' : �׵ᤵ�줿��(port)������˽���ޤ���"

# S1021 $1 : require cannot have same signature with \'$2\'"
@@error_message[ :"S1021" ] = "$1 : �ꥯ�磻���� \'$2\' ��Ʊ�������˥������Ĥ��Ȥ�����ޤ���"

# S1022 $1.$2 : \'$3\' conflict function name in $4.$5"
@@error_message[ :"S1022" ] = "$1.$2 : \'$3\' �� $4.$5 �ˤ�����ؿ�̾�Ⱦ��ͤ��Ƥ��ޤ���"

# S1023 $1: fail to new"
@@error_message[ :"S1023" ] = "$1: new �˼��Ԥ��ޤ�����"

# S1024 $1: multiple cell for singleton celltype"
@@error_message[ :"S1024" ] = "$1: ���󥰥�ȥ󥻥륿���פ��Ф�ʣ���Υ��뤬¸�ߤ��ޤ���"

# S1025 not found reachable cell for require \'$1\' in celltype \'$2\'"
@@error_message[ :"S1025" ] = "���륿���� \'$2\' ��Υꥯ�磻�� \'$1\' ����ã��ǽ�ʥ��뤬���Ĥ���ޤ���"

# S1026 required cell \'$1\' not reachable"
@@error_message[ :"S1026" ] = "ɬ�פȤ���륻�� \'$1\' ����ã��ǽ�ǤϤ���ޤ���"

# S1027 \'$1\' celltype not found"
@@error_message[ :"S1027" ] = "���륿���� \'$1\' �����Ĥ���ޤ���"

# S1028 \'$1\' not celltype"
@@error_message[ :"S1028" ] = "\'$1\' �ϥ��륿���פǤϤ���ޤ���"

# S1029 $1 mismatch with previous one"
@@error_message[ :"S1029" ] = "$1 ����������Τ�Τ����礷�Ƥ��ޤ���"

# S1030 $1: celltype mismatch with previous one"
@@error_message[ :"S1030" ] = "$1: ���륿���פ���������Τ�Τ����礷�Ƥ��ޤ���"

# S1031 $1 region \'$2\' mismatch  with previous one \'$3\'"
@@error_message[ :"S1031" ] = "���� $1 �Υ꡼����� \'$2\' �Ϥ�������Υ꡼����� \'$3\' �����礷�Ƥ��ޤ���"

# S1032 $1: duplicate cell"
@@error_message[ :"S1032" ] = "$1: ���뤬��ʣ���Ƥ��ޤ�"

# S1033 rhs expression is not supported. Only attribute is permitted on current version."
@@error_message[ :"S1033" ] = "���ռ��ϥ��ݡ��Ȥ���Ƥ��ޤ���°���Τߤ����ߤΥС������ǻ��ѤǤ��ޤ���"

# S1034 $1 : cannot refer to $2\'s attribute here. Use \'composite.$3\' to refer to composite celltype\'s"
@@error_message[ :"S1034" ] = "$1 : �����Ǥ� $2 ��°���򻲾ȤǤ��ޤ���. ʣ�祻�륿���פ�°���򻲾Ȥ��뤿�� \'composite.$3\' �򤪻Ȥ�����������"

# S1035 composite : cannot specify out of composite celltype definition"
@@error_message[ :"S1035" ] = "composite : ʣ�祻�륿��������γ�¦�Ǥϻ���Ǥ��ޤ���"

# S1036 $1 : cannot refer to $2\'s here. Use \'composite.$3\' to refer to composite celltype\'s"
@@error_message[ :"S1036" ] = "$1 : �����Ǥ�$2�Τ�Τ򻲾ȤǤ��ޤ���ʣ�祻�륿���פΤ�Τ򻲾Ȥ��뤿�� \'composite.$3\' �򤪻Ȥ�����������"

# S1037 $1: celltype plugin fail to new_cell"
@@error_message[ :"S1037" ] = "$1: ���륿���ץץ饰���� new_cell �˼��Ԥ��ޤ�����"

# S1038 $1.$2: self allocator not supported for array entry port"
@@error_message[ :"S1038" ] = "$1.$2: ����ե��������ϼ�����������Ф��ƥ��ݡ��Ȥ���Ƥ��ޤ���"

# S1039 \'$1\': unknown specifier for cell"
@@error_message[ :"S1039" ] = "\'$1\': ������Ф��������ʻ���ҤǤ���"

# S1040 array not supported for relay allocator"
@@error_message[ :"S1040" ] = "����ϥ�졼�����������Ф��ƥ��ݡ��Ȥ���Ƥ��ޤ���"

# S1041 \'$1_$2_$3\': not joined. cannot create internal join for relay allocator"
@@error_message[ :"S1041" ] = "\'$1_$2_$3\': ��礵��ޤ���. ��졼�����������Ф����������������Ǥ��ޤ���"

# S1042 call port \'$1\' not initialized in cell \'$2\'"
@@error_message[ :"S1042" ] = "�ƤӸ� \'$1\' �ϥ��� \'$2\' ����ǽ��������ޤ���"

# S1043 call port \'$1\' not initialized in cell \'$2\'. this call port is created by tecsgen. check allocator specifier"
@@error_message[ :"S1043" ] = "�ƤӸ� \'$1\' �ϥ��� \'$2\' ����ǽ��������ޤ��󡥤��θƤӸ��� tecsgen �ˤ����������ޤ���������������Ҥ��ǧ���Ƥ���������"

# S1044 $1: array initializer too many or few, $2 for $3"
@@error_message[ :"S1044" ] = "$1: ����ν�����Ҥ�¿�����뤫�ޤ��Ͼ��ʤ����ޤ���$3 �Ȥ���Ȥ���� $2 �ˤ��ޤ�����"

# S1045 $1[$2]: not initialized"
@@error_message[ :"S1045" ] = "$1[$2]: ���������ޤ���"

# S1046 $1[$2]: not initialized"
@@error_message[ :"S1046" ] = "$1[$2]: ���������ޤ���"

# S1047 size_is pointer cannot be exposed for composite attribute"
@@error_message[ :"S1047" ] = "size_is ����ꤵ�줿�ݥ����ѿ��ϡ�ʣ�祻�륿���פ�°��̾�˴ؤ��Ƥϡ������ظ������뤳�Ȥ��Ǥ��ޤ���"

# S1048 $1: size_is specified for non-pointer type"
@@error_message[ :"S1048" ] = "$1: size_is ����ݥ��󥿷����Ф��ƻ��ꤵ��ޤ�����"

# S1049 $1: size_is arg not constant"
@@error_message[ :"S1049" ] = "$1: size_is ����������ǤϤ���ޤ���"

# S1050 unsuitable initializer, need array initializer"
@@error_message[ :"S1050" ] = "��Ŭ���ʽ�����ҤǤ�������ν�����Ҥ�ɬ�פǤ���"

# S1051 too many initializer for array, $1 for $2"
@@error_message[ :"S1051" ] = "������Ф��������Ҥ�¿�����ޤ���$2 �Ȥ���Ȥ���� $1 �ˤ��ޤ�����"

# S1052 attribute \'$1\' not initialized in cell \'$2\'"
@@error_message[ :"S1052" ] = "°�� \'$1\' �ϥ��� \'$2\' ����ǽ��������ޤ���"

# S1053 $1 must be singleton. inner cell \'$2\' is singleton"
@@error_message[ :"S1053" ] = "$1 �ϥ��󥰥�ȥ�Ǥ���ɬ�פ�����ޤ����������� \'$2\' �ϥ��󥰥�ȥ�Ǥ���"

# S1054 $1 : specified active but has no active in this celltype"
@@error_message[ :"S1054" ] = "$1 : �����ƥ��֤˻��ꤵ��ޤ����������Υ��륿���פ���ˤϥ����ƥ��֤ʥ��뤬����ޤ���"

# S1055 $1 must be active. inner cell \'$2\' is active"
@@error_message[ :"S1055" ] = "$1 �� active �Ǥ���ɬ�פ�����ޤ�. �������� \'$2\' �������ƥ��֤Ǥ���"

# S1056 $1 : cannot export, nothing designated"
@@error_message[ :"S1056" ] = "$1 : �����˸������뤳�Ȥ��Ǥ��ޤ��󡥲�����ꤵ��Ƥ��ޤ���"

# S1057 $1 not found in $2"
@@error_message[ :"S1057" ] = "$1 �� $2 ����˸��Ĥ���ޤ���"

# S1058 \'$1\' : cannot export var"
@@error_message[ :"S1058" ] = "\'$1\' : �ѿ������˸������뤳�Ȥ��Ǥ��ޤ���"

# S1059 \'$1\' : exporting attribute. write in cell or use \'=\' to export attribute"
@@error_message[ :"S1059" ] = "\'$1\' : °����������Ƥ��ޤ�. �������˵��Ҥ��뤫�ޤ���°���θ����Τ���� \'=\' ��ȤäƲ�������"

# S1060 \'$1\' : port type mismatch. $2 type is allowed here."
@@error_message[ :"S1060" ] = "\'$1\' : ��(port)�η������礷�Ƥ��ޤ���. �����Ǥ� $2 �������ѤǤ��ޤ���"

# S1061 \'$1\' : not defined"
@@error_message[ :"S1061" ] = "\'$1\' : �������Ƥ��ޤ���"

# S1062 $1 has no export definition"
@@error_message[ :"S1062" ] = "$1 �ˤϳ������������ޤ���"

# S1063 $1 is port but previously defined as an attribute"
@@error_message[ :"S1063" ] = "$1 �ϸ�(port)�Ǥ�������������°���Ȥ����������ޤ�����"

# S1064 $1 : type \'$2$3\' mismatch with pprevious definition\'$4$5\'"
@@error_message[ :"S1064" ] = "$1 : �� \'$2$3\' �Ϥ����������� \'$4$5\' �����礷�Ƥޤ���"

# S1065 $1 : port type $2 mismatch with previous definition $3"
@@error_message[ :"S1065" ] = "$1 : ��(port)�� $2 �Ϥ����������� $3 �����礷�Ƥ��ޤ���"

# S1066 $1 : signature \'$2\' mismatch with previous definition \'$3\'"
@@error_message[ :"S1066" ] = "$1 : �����˥��� \'$2\' �Ϥ����������� \'$3\' �����礷�Ƥ��ޤ���"

# S1067 $1 : array size mismatch with previous definition"
@@error_message[ :"S1067" ] = "$1 : ����Υ������������������������礷�Ƥ��ޤ���"

# S1068 $1 : optional specifier mismatch with previous definition"
@@error_message[ :"S1068" ] = "$1 : ���ץ���ʥ�ʻ���Ҥ������������������礷�Ƥ��ޤ���"

# S1069 $1 is an attribute but previously defined as a port"
@@error_message[ :"S1069" ] = "$1 ��°���Ǥ������������˸�(port)�Ȥ����������ޤ�����"

# S1070 $1: size_is pointer cannot be exposed for composite attribute"
@@error_message[ :"S1070" ] = "$1: size_is ����ꤵ�줿�ݥ����ѿ��ϡ�ʣ�祻�륿���פ�°��̾�˴ؤ��Ƥϡ��������뤳�Ȥ��Ǥ��ޤ���"

# S1071 $1 cannot be specified for composite"
@@error_message[ :"S1071" ] = "$1 ��ʣ�祻����Ф��ƻ���Ǥ��ޤ���"

# S1072 $1: entry port: sizeless array not supported in current version"
@@error_message[ :"S1072" ] = "$1: ������: ���ߤ��ǤǤϥ�����̤���������ϥ��ݡ��Ȥ���Ƥ��ޤ���"

# S1073 Not constant expression $1"
@@error_message[ :"S1073" ] = "$1 ��������ǤϤ���ޤ���"

# S1074 Not Integer $1"
@@error_message[ :"S1074" ] = "$1 �������ǤϤ���ޤ���"

# S1075 \'$1\' signature not found"
@@error_message[ :"S1075" ] = "\'$1\' �����˥��㤬���Ĥ���ޤ���"

# S1076 \'$1\' not signature"
@@error_message[ :"S1076" ] = "\'$1\' �ϥ����˥���ǤϤ���ޤ���"

# S1077 inline: cannot be specified for call port"
@@error_message[ :"S1077" ] = "inline: �ƤӸ����Ф��ƻ���Ǥ��ޤ���"

# S1078 optional: cannot be specified for entry port"
@@error_message[ :"S1078" ] = "optional: ���������Ф��ƻ���Ǥ��ޤ���"

# S1079 allocator: cannot be specified for call port"
@@error_message[ :"S1079" ] = "allocator: �ƤӸ����Ф��ƻ���Ǥ��ޤ���"

# S1080 duplicate allocator specifier"
@@error_message[ :"S1080" ] = "������������Ҥ���ʣ���Ƥ��ޤ���"

# S1081 self allocator not supported yet"
@@error_message[ :"S1081" ] = "����ե��������Ϥޤ����ݡ��Ȥ���Ƥ��ޤ���"

# S1082 function \'$1\' not found in signature"
@@error_message[ :"S1082" ] = "�ؿ� \'$1\' �������˥���Ǹ��Ĥ���ޤ���"

# S1083 \'$1\' not found in function \'$2\'"
@@error_message[ :"S1083" ] = "\'$1\' ���ؿ� \'$2\' �Ǹ��Ĥ���ޤ���"

# S1084 \'$1\' in function \'$2\' is not send or receive"
@@error_message[ :"S1084" ] = "\'$2\' ��� \'$1\' �����ܻ���� send �ޤ��� receive �ǤϤ���ޤ���"

# S1085 duplicate allocator specifier for \'$1_$2\'"
@@error_message[ :"S1085" ] = "\'$1_$2\' ���Ф����ʣ����������������ҤǤ���"

# S1086 rhs not call_port.func.param for $1_$2"
@@error_message[ :"S1086" ] = "$1_$2 ���Ф��� not call_port.func.param �η����ǤϤ���ޤ���"

# S1087 function \'$1\' not found in signature \'$2\'"
@@error_message[ :"S1087" ] = "�ؿ� \'$1\' �������˥��� \'$2\' ����˸��Ĥ���ޤ���"

# S1088 \'$1\' not found in function \'$2\'"
@@error_message[ :"S1088" ] = "\'$1\' ���ؿ� \'$2\' ����˸��Ĥ���ޤ���"

# S1089 relay allocator send/receive mismatch between $1.$2 and $3_$4.$5"
@@error_message[ :"S1089" ] = "��졼�������� send/receive �� $1.$2 �ڤ� $3_$4.$5 �δ֤����礷�Ƥ��ޤ���"

# S1090 \'$1\' in function \'$2\' is not send or receive"
@@error_message[ :"S1090" ] = "�ؿ� \'$2\' ��� \'$1\' �� send �ޤ��� receive �ǤϤ���ޤ���"

# S1091 call port \'$1\' not found in celltype $2"
@@error_message[ :"S1091" ] = "�ƤӸ� \'$1\' �����륿���� $2 ����˸��Ĥ���ޤ���"

# S1092 \'$1\' not namespace"
@@error_message[ :"S1092" ] = "\'$1\' �ϥ͡��ॹ�ڡ����ǤϤ���ޤ���"

# S1093 $1 : undefined cell"
@@error_message[ :"S1093" ] = "$1 : ̤����Υ���Ǥ�"

# S1094 $1: pointer is not constant. check \'const\'"
@@error_message[ :"S1094" ] = "$1: �ݥ��󥿤�����ǤϤ���ޤ���\'const\' ���ǧ���Ƥ�������"

# S1095 $1: not constant"
@@error_message[ :"S1095" ] = "$1: ����ǤϤ���ޤ���"

# S1096 $1: should be int, float, bool or pointer type"
@@error_message[ :"S1096" ] = "$1: int, float, bool �ޤ��ϥݥ��󥿷��Ǥ���ɬ�פ�����ޤ�"

# S1097 $1: has no initializer"
@@error_message[ :"S1097" ] = "$1: ������Ҥ���äƤ��ޤ���"

# S1098 $1: has unsuitable initializer"
@@error_message[ :"S1098" ] = "$1: ��Ŭ���ʽ�����Ҥ�����ޤ���"

# S1099 array subscript not constant"
@@error_message[ :"S1099" ] = "����ź��������ǤϤ���ޤ���"

# S1100 $1: cannot initialize var"
@@error_message[ :"S1100" ] = "$1: �ѿ��������Ǥ��ޤ���"

# S1101 \'$1\' cannot initialize entry port"
@@error_message[ :"S1101" ] = "\'$1\' �������������Ǥ��ޤ���"

# S1102 $1: must specify array subscript here"
@@error_message[ :"S1102" ] = "$1: �����Ǥ�����ź������ꤹ��ɬ�פ�����ޤ���"

# S1103 $1: need array subscript"
@@error_message[ :"S1103" ] = "$1: ����ź����ɬ�פǤ���"

# S1104 $1: need array subscript number. ex. \'[0]\'"
@@error_message[ :"S1104" ] = "$1: ����ź���ο��ͤ�ɬ�פǤ���(��) \'[0]\'"

# S1105 $1: cannot specify array subscript here"
@@error_message[ :"S1105" ] = "$1: �����Ǥ�����ź������ꤹ�뤳�Ȥ��Ǥ��ޤ���"

# S1106 $1: cannot specify array subscript number. use \'[]\'"
@@error_message[ :"S1106" ] = "$1: ����ź���ο��ͤ���ꤹ�뤳�Ȥ�����ޤ���\'[]\' �򤪻Ȥ�����������"

# S1107 to export port, use \'cCall => composite.cCall\'"
@@error_message[ :"S1107" ] = "��(port)�����˸������뤿��, \'cCall => composite.cCall\' �򤪻Ȥ�����������"

# S1108 $1: rhs not \'Cell.ePort\' form"
@@error_message[ :"S1108" ] = "$1: ���դ� \'Cell.ePort\' �η����ǤϤ���ޤ���"

# S1109 \'$1\' not found"
@@error_message[ :"S1109" ] = "\'$1\' �����Ĥ���ޤ���"

# S1110 \'$1\' not cell"
@@error_message[ :"S1110" ] = "\'$1\' ����ǤϤ���ޤ���"

# S1111 \'$1\' not found"
@@error_message[ :"S1111" ] = "\'$1\' �����Ĥ���ޤ���"

# S1112 \'$1\' not entry port"
@@error_message[ :"S1112" ] = "\'$1\' �������ǤϤ���ޤ���"

# S1113 \'$1\' signature mismatch"
@@error_message[ :"S1113" ] = "\'$1\' �����˥��㤬���礷�Ƥ��ޤ���"

# S1114 \'$1\' should be array"
@@error_message[ :"S1114" ] = "\'$1\' ����Ǥ���ɬ�פ�����ޤ���"

# S1115 $1[$2]: subscript out of range (< $3)"
@@error_message[ :"S1115" ] = "$1[$2]: �����ź�����ϰϳ����ͤǤ���(< $3)"

# S1116 \'$1\' entry port is not array"
@@error_message[ :"S1116" ] = "\'$1\' ������������ǤϤ���ޤ���"

# S1117 \'$1\' not in celltype"
@@error_message[ :"S1117" ] = "\'$1\' �ϥ��륿������ˤ���ޤ���"

# S1118 $1: going out from region \'$2\' not permitted"
@@error_message[ :"S1118" ] = "$1: �꡼����� $2 ���� out ���뤳�Ȥ��Ǥ��ޤ���"

# S1119 $1: going from region \'$2\' to \'$3\' not permitted"
@@error_message[ :"S1119" ] = "$1: �꡼����� $2 ����꡼����� $3�ط��Ǥ��ޤ���"

# S1120 $1: going in to region \'$2\' not permitted"
@@error_message[ :"S1120" ] = "$1: �꡼����� \'$2\' �� in ���뤳�Ȥ��Ǥ��ޤ���"

# S1121 \'$1\' in region \'$2\' cannot be directly joined $3 in  $4"
@@error_message[ :"S1121" ] = "�꡼����� \'$2\' ��� \'$1\' ��ľ�� $4 ��� $3 �˷��Ǥ��ޤ���"

# S1122 $1 : not port: \'through\' can be specified only for port"
@@error_message[ :"S1122" ] = "$1 :��(port) �ǤϤ���ޤ���: \'through\' �ϸ�(port)���Ф��ƤΤ߻���Ǥ��ޤ���"

# S1123 $1 : not port: \'through\' can be specified only for port"
@@error_message[ :"S1123" ] = "$1 :��(port) �ǤϤ���ޤ���: \'through\' �ϸ�(port)���Ф��ƤΤ߻���Ǥ��ޤ���"

# S1124 $1: plugin function failed: \'get_through_entry_port_name\'"
@@error_message[ :"S1124" ] = "$1: �ץ饰����ؿ������Ԥ��ޤ�����: \'get_through_entry_port_name\'"

# S1125 $1: not generated cell \'$2\'"
@@error_message[ :"S1125" ] = "$1: �������줿���� \'$2\' �ǤϤ���ޤ���"

# S1126 $1: fail to new"
@@error_message[ :"S1126" ] = "$1: new �˼��Ԥ��ޤ�����"

# S1127 \'$1\' duplicate"
@@error_message[ :"S1127" ] = "\'$1\' ����ʣ���Ƥ��ޤ���"

# S1128 \'$1\' inconsistent array definition"
@@error_message[ :"S1128" ] = "\'$1\' �ϰ�Ӥ��ʤ���������Ǥ���"

# S1129 \'$1\' redefinition of subscript $1"
@@error_message[ :"S1129" ] = "\'$1\' ������ź�� $1 �κ�����Ǥ���"

# S1130 \'$1\' inconsistent array definition"
@@error_message[ :"S1130" ] = "\'$1\' �ϰ�Ӥ��ʤ���������Ǥ���"

# S1131 \'$1.$2\' has duplicate initializer"
@@error_message[ :"S1131" ] = "\'$1.$2\' �ˤϽ�ʣ����������Ҥ�����ޤ���"

# S1132 $1: 1st parameter is not string(file name)"
@@error_message[ :"S1132" ] = "$1: ��1�ѥ�᡼���� string(�ե�����̾) �ǤϤ���ޤ���"

# S1133 $1: 2nd parameter is not string(fromat)"
@@error_message[ :"S1133" ] = "$1: ��2�ѥ�᡼���� string(�ե�����̾) �ǤϤ���ޤ���"

# S1134 $1: unknown factory function"
@@error_message[ :"S1134" ] = "$1: �����ʥե����ȥ�ؿ��Ǥ���"

# S1135 celltype factory can\'t have parameter(s)"
@@error_message[ :"S1135" ] = "���륿���ץե����ȥ�ϥѥ�᡼������Ĥ��Ȥ��Ǥ��ޤ���"

# S1136 \'$1\': not found"
@@error_message[ :"S1136" ] = "\'$1\': ���Ĥ���ޤ���"

# S1137 \'$1\': not attribute"
@@error_message[ :"S1137" ] = "\'$1\': °���ǤϤ���ޤ���"

# S1138 internal error Factory.check_arg()"
@@error_message[ :"S1138" ] = "Factory.check_arg() ���������顼�Ǥ���"

# S1139 $1: region path mismatch. previous path: $2"
@@error_message[ :"S1139" ] = "$1: �꡼�����ѥ������礷�Ƥ��ޤ��󡥰����Υѥ�: $2"

# S1140 $1: region specifier must place at first appearence"
@@error_message[ :"S1140" ] = "$1: �꡼��������ҤϺǽ�����֤���ɬ�פ�����ޤ���"

# S1141 $1 duplication, previous one : $2"
@@error_message[ :"S1141" ] = "$1 ����ʣ���Ƥ��ޤ�, �������� : $2"

# S1142 $1 not found in search path"
@@error_message[ :"S1142" ] = "$1 �������ѥ�����˸��Ĥ���ޤ���"

# S1143 import_C: arg2: mismatch with previous one"
@@error_message[ :"S1143" ] = "import_C: arg2: �����Τ�Τ����礷�Ƥ��ޤ���"

# S1144 $1: temporary C source: open error"
@@error_message[ :"S1144" ] = "$1: ���Ū�� C ������: �����ץ󥨥顼�Ǥ���"

# S1145 $1: temporary C source: writing error"
@@error_message[ :"S1145" ] = "$1: ���Ū�� C ������: ����ߥ��顼�Ǥ���"

# S1146 $1: error occured while CPP"
@@error_message[ :"S1146" ] = "$1: CPP �¹���˥��顼��ȯ�����ޤ�����"

# S1147 $1: popen for CPP failed"
@@error_message[ :"S1147" ] = "$1: CPP���Ф��� popen �����Ԥ��ޤ�����"

# S1148 $1 not found in search path"
@@error_message[ :"S1148" ] = "$1 �������ѥ�����˸��Ĥ���ޤ���"

# S1149 $1 not signature"
@@error_message[ :"S1149" ] = "$1 �����˥���ǤϤ���ޤ���"

# S1150 $1: fail to new"
@@error_message[ :"S1150" ] = "$1: new �˼��Ԥ��ޤ�����"

# S1151 $1: not namespace"
@@error_message[ :"S1151" ] = "$1: �͡��ॹ�ڡ����ǤϤ���ޤ���"

# S1152 $1: call port cannot have fixed join"
@@error_message[ :"S1152" ] = "$1: �ƤӸ��ϸ��������Ĥ��Ȥ��Ǥ��ޤ���"

# "S1153 $1: cannot be entry port array for fixed join port"
@@error_message[ :"S1153" ] = "$1: ������θ����Ф������������Ϥ������ޤ���"

# "S1154 $1: must be singleton celltype for fixed join"
@@error_message[ :"S1154" ] = "$1: ��������Ф��륷�󥰥�ȥ󥻥륿���פǤ���ɬ�פ�����ޤ���"

# "S1155 $1: not celltype or not found"
@@error_message[ :"S1155" ] = "$1: ���륿���פǤϤʤ����ޤ��ϸ��Ĥ���ޤ���"

# "S1156 $1: not call port or not found"
@@error_message[ :"S1156" ] = "$1: �ƤӸ��ǤϤʤ����ޤ��ϸ��Ĥ���ޤ���"

# "S1157 $1: sized array or not array"
@@error_message[ :"S1157" ] = "$1: ���������ꤵ�줿���󤫤ޤ�������ǤϤ���ޤ���"

# "S1158 $1: singleton cell not found for fixed join"
@@error_message[ :"S1158" ] = "$1: ���󥰥�ȥ󥻥뤬��������Ф��Ƹ��Ĥ���ޤ���"

### syntaxobj.rb
# S2001 \'$1\' duplicate $2"
@@error_message[ :"S2001" ] = "\'$1\': ��ʣ���Ƥ��ޤ� ($2)"

# S2002 $1: $2"
@@error_message[ :"S2002" ] = "$1: $2"

# S2003 $1: $2 cannot have initializer"
@@error_message[ :"S2003" ] = "$1: $2 �Ͻ�����Ҥ��Ĥ��Ȥ��Ǥ��ޤ���"

# S2004 $1: array subscript must be specified or omit"
@@error_message[ :"S2004" ] = "$1: ����ź���ϻ��ꤵ��뤫�ޤ��Ͼ�ά�����ɬ�פ�����ޤ���"

# S2005 $1: array subscript must be specified"
@@error_message[ :"S2005" ] = "$1: ����ź���ϻ��ꤵ���ɬ�פ�����ޤ���"

# S2006 \'$1\' function"
@@error_message[ :"S2006" ] = "\'$1\' �ؿ��Ǥ���"

# S2007 \'$1\' $2"
@@error_message[ :"S2007" ] = "\'$1\' $2"

# S2008 $1: inconsitent with previous one"
@@error_message[ :"S2008" ] = "$1: �����Τ�ΤȰ�Ӥ��Ƥ��ޤ���"

# S2009 $1: not found or not signature"
@@error_message[ :"S2009" ] = "$1: ���Ĥ���ʤ����ޤ��ϥ����˥���ǤϤ���ޤ���"

# S2010 $1: not allocator signature"
@@error_message[ :"S2010" ] = "$1: �������������˥���ǤϤ���ޤ���"

# S2011 size_is duplicate"
@@error_message[ :"S2011" ] = "size_is ����ʣ���Ƥ��ޤ���"

# S2012 count_is duplicate"
@@error_message[ :"S2012" ] = "count_is ����ʣ���Ƥ��ޤ���"

# S2013 string duplicate"
@@error_message[ :"S2013" ] = "string ����ʣ���Ƥ��ޤ���"

# S2014 $1 need pointer or more pointer"
@@error_message[ :"S2014" ] = "$1 �ϰ�İʾ�Υݥ��󥿤�ɬ�פǤ���"

# S2015 $1 must be const for \'in\' parameter $2"
@@error_message[ :"S2015" ] = "'$1' �� \'in\' �ѥ�᡼�� $2 ���Ф�������Ǥ���ɬ�פ�����ޤ���"

# S2016 $1 can not be const for $2 parameter"
@@error_message[ :"S2016" ] = "'$1' �� $2 �ѥ�᡼�����Ф����������Ǥ��ޤ��� "

# S2017 size_is argument is not integer type"
@@error_message[ :"S2017" ] = "size_is �������������ǤϤ���ޤ���"

# S2018 \'$1\' size_is parameter not integer"
@@error_message[ :"S2018" ] = "\'$1\' size_is �ѥ�᡼���������ǤϤ���ޤ���"

# S2019 \'$1\' size_is parameter negative or zero"
@@error_message[ :"S2019" ] = "\'$1\' size_is �ѥ�᡼��������ޤ��ϥ���Ǥ���"

# S2020 count_is argument is not integer type"
@@error_message[ :"S2020" ] = "count_is �������������ǤϤ���ޤ���"

# S2021 \'$1\' count_is parameter not integer"
@@error_message[ :"S2021" ] = "\'$1\' count_is �ѥ�᡼�����������ǤϤ���ޤ���"

# S2022 \'$1\' count_is parameter negative or zero"
@@error_message[ :"S2022" ] = "\'$1\' count_is �ѥ�᡼��������ޤ��ϥ���Ǥ���"

# S2023 string argument is not integer type"
@@error_message[ :"S2023" ] = "string �������������ǤϤ���ޤ���"

# S2024 \'$1\' string parameter not integer"
@@error_message[ :"S2024" ] = "\'$1\' string �ѥ�᡼�����������ǤϤ���ޤ���"

# S2025 \'$1\' string parameter negative or zero"
@@error_message[ :"S2025" ] = "\'$1\' string �ѥ�᡼��������ޤ��ϥ���Ǥ���"

### types.rb
# T1001 const duplicate"
@@error_message[ :"T1001" ] = "const ����ʣ���Ƥ��ޤ���"

# T1002 volatile duplicate"
@@error_message[ :"T1002" ] = "volatile ����ʣ���Ƥ��ޤ���"

# T1003 $1: unsuitable specifier for $2"
@@error_message[ :"T1003" ] = "$1: $2 ���Ф�����Ŭ�ڤʻ���ҤǤ���"

# T1004 cannot cast to $1"
@@error_message[ :"T1004" ] = "$1 �إ��㥹�ȤǤ��ޤ���"

# T1005 \'$1\' not defined"
@@error_message[ :"T1005" ] = "\'$1\' ���������Ƥ��ޤ���"

# T1006 \'$1\' not type name. expecting type name here"
@@error_message[ :"T1006" ] = "\'$1\' �Ϸ�̾�ǤϤ���ޤ��󡥤����Ϸ�̾��ɬ�פǤ���"

# T1007 $1: void type variable cannot have initializer"
@@error_message[ :"T1007" ] = "$1: void ���ѿ��Ͻ�����Ҥ��Ĥ��Ȥ��Ǥ��ޤ���"

# T1008 ambigous signed or unsigned"
@@error_message[ :"T1008" ] = "����դ��Ǥ��뤫�ޤ������̵���Ǥ��뤫��ۣ��Ǥ���"

# T1009 $1: $2: not integer"
@@error_message[ :"T1009" ] = "$1: $2: �����ǤϤ���ޤ���"

# T1010 $1: initializer is not constant"
@@error_message[ :"T1010" ] = "$1: ������Ҥ�����ǤϤ���ޤ���"

# T1011 $1: need cast to assign float to integer"
@@error_message[ :"T1011" ] = "$1: ��ư�������������������س�����ƤΤ���˥��㥹�Ȥ�ɬ�פǤ���"

# T1012 $1: $2: not integer"
@@error_message[ :"T1012" ] = "$1: $2: �����ǤϤ���ޤ���"

# T1013 $1: too large (max=$2)"
@@error_message[ :"T1013" ] = "$1: �ͤ��礭�����ޤ� (max=$2)"

# T1014 $1: too large negative value (min=-$2)"
@@error_message[ :"T1014" ] = "$1: ����������ͤ��礭�����ޤ���(min=-$2)"

# T1015 $1: negative value for unsigned"
@@error_message[ :"T1015" ] = "$1: ���̵�����������Ф�����ͤ����Ѥ���Ƥ��ޤ���"

# T1016 $1: too large (max=$2)"
@@error_message[ :"T1016" ] = "$1: �ͤ��礭�����ޤ���(max=$2)"

# T1017 $1: unsuitable initializer for scalar type"
@@error_message[ :"T1017" ] = "$1: �����顼�����Ф�����Ŭ���ʽ�����ҤǤ���"

# T1018 $1: $2: not number"
@@error_message[ :"T1018" ] = "$1: $2: ���ͤǤϤ���ޤ���"

# T1019 $1: initializer is not constant"
@@error_message[ :"T1019" ] = "$1: ������Ҥ�����ǤϤ���ޤ���"

# T1020 $1: unsuitable initializer for scalar type"
@@error_message[ :"T1020" ] = "$1: �����顼�����Ф�����Ŭ���ʽ�����ҤǤ���"

# T1021 \'$1\': struct not defined"
@@error_message[ :"T1021" ] = "\'$1\': ��¤�Τ��������Ƥ��ޤ���"

# T1022 struct $1: not defined"
@@error_message[ :"T1022" ] = "��¤�� $1: �������Ƥ��ޤ���"

# T1023 struct $1: not defined"
@@error_message[ :"T1023" ] = "��¤�� $1: �������Ƥ��ޤ���"

# T1024 $1: unsuitable initializer for struct"
@@error_message[ :"T1024" ] = "$1: ��¤�Τ��Ф�����Ŭ���ʽ�����ҤǤ���"

# T1025 size_is argument is not integer type"
@@error_message[ :"T1025" ] = "size_is ���� ���������ǤϤ���ޤ���"

# T1026 count_is argument is not integer type"
@@error_message[ :"T1026" ] = "count_is ���� ���������ǤϤ���ޤ���"

# T1027 string argument is not integer type"
@@error_message[ :"T1027" ] = "string �������������ǤϤ���ޤ���"

# T1028 $1: cannot initialize function pointer"
@@error_message[ :"T1028" ] = "$1: �ؿ��ݥ��󥿤��������뤳�ȤϤǤ��ޤ���"

# T1029 oneway function cannot return type \'$1$2\', \'void\' or \'ER\' is permitted"
@@error_message[ :"T1029" ] = "�������ؿ��Ϸ� \'$1$2\' ���֤����Ȥ��Ǥ��ޤ���\'void\' �ޤ��� \'ER\' �����ѤǤ��ޤ���"

# T1030 oneway function cannot have $1 parameter for \'$2\'"
@@error_message[ :"T1030" ] = "�������ؿ��� \'$2\' �Τ���� $1 �ѥ�᡼������Ĥ��Ȥ��Ǥ��ޤ���"

# T1031 $1: unsuitable initializer for array"
@@error_message[ :"T1031" ] = "$1: ������Ф�����Ŭ���ʽ�����ҤǤ���"

# T1032 $1: incompatible pointer type"
@@error_message[ :"T1032" ] = "$1: �ߴ����Τʤ��ݥ��󥿷��Ǥ���"

# T1033 $1: need cast to assign integer to pointer"
@@error_message[ :"T1033" ] = "$1: ��������ݥ��󥿤س�����Ƥ뤿��ˤϥ��㥹�Ȥ�ɬ�פǤ���"

# T1034 $1: unsuitable string constant"
@@error_message[ :"T1034" ] = "$1: ��Ŭ����ʸ��������Ǥ���"

# T1035 $1: unsuitable initializer for pointer"
@@error_message[ :"T1035" ] = "$1: �ݥ��󥿤��Ф�����Ŭ���ʽ�����ҤǤ���"

# T1036 $1: unsuitable initializer for pointer"
@@error_message[ :"T1036" ] = "$1: �ݥ��󥿤��Ф�����Ŭ���ʽ�����ҤǤ���"

# TEMPORAL set_definition_join: uninitialized array member"
@@error_message[ :"TEMPORAL" ] = "set_definition_join: ������Ф����������Ƥ��ޤ���"

# V1001 $1: unable for $2"
@@error_message[ :"V1001" ] = "$1: unable for $2"

# V1002 $1: cannot cast to bool (implicitly)"
@@error_message[ :"V1002" ] = "$1: �֡��뷿�ؤ�(����Ū��)���㥹�Ȥ�Ԥ����Ȥ��Ǥ��ޤ���"

# V1003 $1: cannot cast to integer (implicitly)"
@@error_message[ :"V1003" ] = "$1: �������ؤ�(����Ū��)���㥹�Ȥ�Ԥ����Ȥ��Ǥ��ޤ���"

# V1004 $1: cannot cast to float (implicitly)"
@@error_message[ :"V1004" ] = "$1: ��ư���������ؤ�(����Ū��)���㥹�Ȥ�Ԥ����Ȥ��Ǥ��ޤ���"

# V1005 Cannot cast pointer to float"
@@error_message[ :"V1005" ] = "�ݥ��󥿷�����ư���������إ��㥹�Ȥ�Ԥ����Ȥ��Ǥ��ޤ���"

# V1006 pointer value cannot cast to $1"
@@error_message[ :"V1006" ] = "�ݥ����ͤ� $1 �إ��㥹�Ȥ�Ԥ����Ȥ��Ǥ��ޤ���"

# V1007 convert pointer value to bool"
@@error_message[ :"V1007" ] = "�ݥ����ͤ�֡��뷿���Ѵ����ޤ�����"

# V1008 convert pointer value to integer without cast"
@@error_message[ :"V1008" ] = "�ݥ����ͤ򥭥㥹��̵�������������Ѵ����ޤ�����"

# V1009 / : divieded by zero"
@@error_message[ :"V1009" ] = "/ : ����������顼�Ǥ���"

# V1010 / : divieded by zero"
@@error_message[ :"V1010" ] = "/ : ����������顼�Ǥ���"

# V1011 % : divieded by zero"
@@error_message[ :"V1011" ] = "% : ����������顼�Ǥ���"

# V1012 % : divieded by zero"
@@error_message[ :"V1012" ] = "% : ����������顼�Ǥ���"

# V1013 integer value cannot cast to $1"
@@error_message[ :"V1013" ] = "�����ͤ� $1 �إ��㥹�Ȥ�Ԥ����Ȥ��Ǥ��ޤ���"

# V1014 comparing bool value with \'$1\'"
@@error_message[ :"V1014" ] = "�֡����ͤ� \'$1\' ����Ӥ��ޤ�����"

# V1015 comparing bool value with \'$1\'"
@@error_message[ :"V1015" ] = "�֡����ͤ� \'$1\' ����Ӥ��ޤ�����"

# V1016 bool value cannot cast to $1"
@@error_message[ :"V1016" ] = "�֡����ͤ� $1 �إ��㥹�Ȥ�Ԥ����Ȥ��Ǥ��ޤ���"

# V1017 / : divieded by zero"
@@error_message[ :"V1017" ] = "/ : ����������顼�Ǥ���"

# V1018 % : divieded by zero"
@@error_message[ :"V1018" ] = "% : ����������顼�Ǥ���"

# V1019 floating value cannot cast to $1"
@@error_message[ :"V1019" ] = "��ư�������ͤ� $1 �ؤΥ��㥹�Ȥ�Ԥ����Ȥ��Ǥ��ޤ���"

# V1020 convert floating value to bool without cast"
@@error_message[ :"V1020" ] = "��ư�������ͤ򥭥㥹��̵���ǥ֡��뷿���Ѵ����ޤ�����"

# V1021 convert floating value to integer without cast"
@@error_message[ :"V1021" ] = "��ư���������򥭥㥹��̵�������������Ѵ����ޤ�����"

# V1022 string cannot cast to integer"
@@error_message[ :"V1022" ] = "ʸ������������˥��㥹�ȤǤ��ޤ���"

# V1023 string cannot cast to float"
@@error_message[ :"V1023" ] = "ʸ�������ư���������˥��㥹�ȤǤ��ޤ���"

# V1024 string cannot cast to pointer"
@@error_message[ :"V1024" ] = "ʸ����ϥݥ��󥿷��˥��㥹�ȤǤ��ޤ���"

# V1025 string cannot cast to $1"
@@error_message[ :"V1025" ] = "ʸ����� $1 �˥��㥹�ȤǤ��ޤ���"

###
# warning ��å�����
@@warning_message = {}

### componentobj.rb
# W1001 \'$1\': unknown context type. usually specifiy task, non-task or any"
@@warning_message[ :"W1001" ] = "\'$1\': �����ʥ���ƥ����ȷ��Ǥ����̾� task, non-task �ޤ��� any ����ꤷ�Ʋ�������"

# W1002 $1: non-active celltype has no entry port & factory"
@@warning_message[ :"W1002" ] = "$1: �󥢥��ƥ��֤ʥ��륿���פ��������ڤӥե����ȥ����äƤ��ޤ���"

# W1003 $1 : require call port overridden in $2"
@@warning_message[ :"W1003" ] = "$1 : �ꥯ�磻���ƤӸ��� $2 �ǥ����С��饤�ɤ���ޤ�����"

# W1004 $1 : specified singleton but has no singleton in this celltype"
@@warning_message[ :"W1004" ] = "$1 : specified singleton but has no singleton in this celltype"

# W1005 $1 : idx_is_id is ineffective for composite celltype"
@@warning_message[ :"W1005" ] = "$1 : idx_is_id ��ʣ�祻�륿���פ��Ф��Ƥ�̵���Ǥ���"

# W1006 $1 : only prototype, unused and undefined cell"
@@warning_message[ :"W1006" ] = "$1 : �ץ�ȥ����פΤߡ�̤���ѡ�����̤����Υ���Ǥ���"

# W1007 $1 : non-active cell has no entry join and no factory"
@@warning_message[ :"W1007" ] = "$1 : �󥢥��ƥ��֥���˼������η��ڤӥե����ȥ꤬����ޤ���"

# W1008 $1: reuse designation mismatch with previous import"
@@warning_message[ :"W1008" ] = "$1: �ƻ��Ѥλؼ��������Υ���ݡ��ȤΤ����礷�ޤ���"

# "W1009 $1: fixed join entry port has multi join"
@@warning_message[ :"W1009" ] = "$1: �������������ʣ���η�����äƤ��ޤ���"

### types.rb
# W2001 signed int$1_t: obsolete. use int$2_t"
@@warning_message[ :"W2001" ] = "signed int$1_t: �侩����ޤ���int$2_t �򤪻Ȥ�����������"

# W2002 unsinged int$1_t: obsolete. use uint$2_t"
@@warning_message[ :"W2002" ] = "unsinged int$1_t: �侩����ޤ���uint$2_t �򤪻Ȥ�����������"

# W2003 $1: too large to cast to $2, clipped($3)"
@@warning_message[ :"W2003" ] = "$1: $2 �إ��㥹�Ȥ���Τ��礭�����ޤ����ڤ�ͤ�ޤ���($3)"

# W2004 $1: too small to cast to $2, clipped($3)"
@@warning_message[ :"W2004" ] = "$1: $2 �إ��㥹�Ȥ���Τ˾��������ޤ����ڤ�ͤ�ޤ���($3)"

# W2005 $1: negative value for unsigned: convert to $2"
@@warning_message[ :"W2005" ] = "$1: ���̵�����������Ф�������ͤǤ� : $2 ���Ѵ����ޤ�����"

### syntaxobj.rb
# W3001 $1: duplicate"
@@warning_message[ :"W3001" ] = "$1: ��ʣ���Ƥ��ޤ���"

# W3002 $1: this string might cause buffer over run"
@@warning_message[ :"W3002" ] = "$1: ����ʸ����ϥХåե��������С�����������������⤷��ޤ���"

# W3003 $1 pointer level mismatch"
@@warning_message[ :"W3003" ] = "$1 �ݥ��󥿡���٥��������Ǥ���"

### bnf.y.rb
# W5001 bool: obsolete type. use bool_t"
@@warning_message[ :"W5001" ] = "bool: �侩����ʤ��ǡ������Ǥ���bool_t �򤪻Ȥ�����������"

# W5002 float: obsolete type. use float32_t"
@@warning_message[ :"W5002" ] = "float: �侩����ʤ��ǡ������Ǥ���float32_t �򤪻Ȥ�����������"

# W5003 double: obsolete type. use double64_t"
@@warning_message[ :"W5003" ] = "double: �侩����ʤ��ǡ������Ǥ���double64_t �򤪻Ȥ�����������"

# W5004 char: obsolete type. use char_t"
@@warning_message[ :"W5004" ] = "char: �侩����ʤ��ǡ������Ǥ���char_t �򤪻Ȥ�����������"

# W5005 int8: obsolete. use int8_t"
@@warning_message[ :"W5005" ] = "int8: �侩����ޤ���int8_t �򤪻Ȥ�����������"

# W5006 int16: obsolete. use int16_t"
@@warning_message[ :"W5006" ] = "int16: �侩����ޤ���int16_t �򤪻Ȥ�����������"

# W5007 int32: obsolete. use int32_t"
@@warning_message[ :"W5007" ] = "int32: �侩����ޤ���int32_t �򤪻Ȥ�����������"

# W5008 int64: obsolete. use int64_t"
@@warning_message[ :"W5008" ] = "int64: �侩����ޤ���int64_t �򤪻Ȥ�����������"

# W5009 int64: obsolete. use int64_t"
@@warning_message[ :"W5009" ] = "int64: �侩����ޤ���int64_t �򤪻Ȥ�����������"

# W5010 need 'void' for no parameter"
@@warning_message[ :"W5010" ] = "�ѥ�᡼����¸�ߤ��ʤ���� 'void' ��ɬ�פǤ�"

# W5011 need 'void' for no parameter"
@@warning_message[ :"W5011" ] = "�ѥ�᡼����¸�ߤ��ʤ���� 'void' ��ɬ�פǤ�"

### C_parser.y.rb
# W6001 need 'void' for no parameter"
@@warning_message[ :"W6001" ] = "�ѥ�᡼����¸�ߤ��ʤ���� 'void' ��ɬ�פǤ�"

# W6002 need 'void' for no parameter"
@@warning_message[ :"W6002" ] = "�ѥ�᡼����¸�ߤ��ʤ���� 'void' ��ɬ�פǤ�"

# W6003 need 'void' for no parameter"
@@warning_message[ :"W6003" ] = "�ѥ�᡼����¸�ߤ��ʤ���� 'void' ��ɬ�פǤ�"

# W6004 need 'void' for no parameter"
@@warning_message[ :"W6004" ] = "�ѥ�᡼����¸�ߤ��ʤ���� 'void' ��ɬ�פǤ�"

end
