# -*- coding: euc-jp -*-
#
#  TECS Generator Cell-type plugin
#      for TOPPERS Embedded Component System
#  
#   Copyright (C) 2008-2013 by TOPPERS Project TECS-WG
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
#   $Id
#++

#== celltype �ץ饰����ζ��̤οƥ��饹
class ATK1AlarmPlugin < CelltypePlugin
#@celltype:: Celltype
#@option:: String     :���ץ����ʸ����

  #signature::     Celltype        �����˥���ʥ��󥹥��󥹡�
  def initialize( celltype, option )
    super
  end

  #===  CDL �ե����������
  #      typedef, signature, celltype, cell �Υ����ɤ�����
  #      ��ʣ�����������ƤϤʤ�ʤ�
  #      ���Ǥ���������Ƥ�����Ͻ��Ϥ��ʤ����ȡ�
  #      �⤷����Ʊ̾�� import �ˤ�ꡢ��ʣ���򤱤뤳�ȡ�
  #file::        FILE       ��������ե�����
#  def gen_cdl_file file
#  end

  def new_cell cell
  end

  #===  �������ؿ�������(C����)����������
  #     ���Υ᥽�åɤ�̤����ξ�硢�����ͥ졼���ϼ������ؿ��Υƥ�ץ졼�Ȥ���������
  #     ���Υ᥽�åɤ�����Ѥߤξ�硢�ʥƥ�ץ졼�ȤǤϤʤ����ѹ�����ɬ�פΤʤ��˥��륿���ץ����ɤ���������
  #file::           FILE        ������ե�����
  #b_singleton::    bool        true if singleton
  #ct_name::        Symbol
  #global_ct_name:: string
  #sig_name::       string
  #ep_name::        string
  #func_name::      string
  #func_global_name:: string
  #func_type::      class derived from Type
#  def gen_ep_func_body( file, b_singleton, ct_name, global_ct_name, sig_name, ep_name, func_name, func_global_name, func_type, params )
#  end

  def gen_factory file

  file2 = CFile.open( "#{$gen}/ALARM_tecsgen.oil", "w" )

    # ALARM
    @celltype.get_cell_list.each { |cell|

    if cell.is_generate?

      file2.print "\tALARM #{cell.get_name} {\n"

      # COUNTER
      join = cell.get_join_list.get_item( :counter )
      if join then
        str = join.get_rhs.to_s.gsub(/^"(.*)"$/, '\1')
        file2.print "\t\tCOUNTER = #{str};\n"
      end

      # ACTION
      join = cell.get_join_list.get_item( :action )
      if join then
        str = join.get_rhs.to_s.gsub(/^"(.*)"$/, '\1')
      end

      case str
      when "SETEVENT"
        file2.print "\t\tACTION = #{str} {\n"
        join2 = cell.get_join_list.get_item( :task )
        if join2 then
          str = join2.get_rhs.to_s.gsub(/^"(.*)"$/, '\1')
          file2.print "\t\t\tTASK = #{str};\n"
        end
        join2 = cell.get_join_list.get_item( :event )
        if join2 then
          str = join2.get_rhs.to_s.gsub(/^"(.*)"$/, '\1')
          file2.print "\t\t\tEVENT = #{str};\n"
        end
        file2.print "\t\t};\n"
      when "ACTIVATETASK"
        file2.print "\t\tACTION = #{str} {\n"
        join2 = cell.get_join_list.get_item( :task )
        if join2 then
          str = join2.get_rhs.to_s.gsub(/^"(.*)"$/, '\1')
          file2.print "\t\t\tTASK = #{str};\n"
        end
        file2.print "\t\t};\n"
      when "ALARMCALLBACK"
        file2.print "\t\tACTION = #{str} {\n"
        join2 = cell.get_join_list.get_item( :callbackName )
        if join2 then
          str = join2.get_rhs.to_s
          file2.print "\t\t\tALARMCALLBACKNAME = #{str};\n"
        end
        file2.print "\t\t};\n"
      else
      end

      # AUTOSTART
      join = cell.get_join_list.get_item( :autoStart )
      if join then
        str = join.get_rhs.to_s
      end

      if str == "TRUE" then
        file2.print "\t\tAUTOSTART = TRUE {\n"
        join2 = cell.get_join_list.get_item( :alarmTime )
        if join2 then
        str = join2.get_rhs.to_s
        file2.print "\t\t\tALARMTIME = #{str};\n"
        end
        join2 = cell.get_join_list.get_item( :cycleTime )
        if join2 then
          str = join2.get_rhs.to_s
          file2.print "\t\t\tCYCLETIME = #{str};\n"
        end
        join2 = cell.get_join_list.get_item( :appMode )
        delim = ""
        if join2 then
          join2.get_rhs.each { |mode|
            str = mode.to_s.gsub(/^"(.*)"$/, '\1')
            file2.print "\t\t\tAPPMODE = #{str};\n"
            delim = ";"
          }
        end
        file2.print "\t\t};\n"
      else
        file2.print "\t\tAUTOSTART = FALSE;\n"
      end

      file2.print "\t};\n"
      file2.print "\n"

    end
  }

  file2.close

  # �ɵ����뤿��� AppFile ��Ȥ���ʸ���������Ѵ�����ʤ���
  file = AppFile.open( "#{$gen}/tAlarm_tecsgen.c" )
  file.print "\n/* Generated by ATK1AlarmPlugin */\n"
  @celltype.get_cell_list.each { |cell|
    if cell.is_generate?
      name_array = @celltype.get_name_array( cell )
      join2 = cell.get_join_list.get_item( :callbackName )
      if join2 then
        str = join2.get_rhs.to_s.gsub(/^"(.*)"$/, '\1')
        file.print <<EOT
ALARMCALLBACK( #{str} );
ALARMCALLBACK( #{str} )
{
    CELLCB *p_cellcb = #{name_array[8]};
    cBody_main();
}

EOT
      end
    end
  }

  file.close

  end

end
