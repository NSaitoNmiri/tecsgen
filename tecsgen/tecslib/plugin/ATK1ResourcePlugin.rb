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
class ATK1ResourcePlugin < CelltypePlugin
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

  file2 = CFile.open( "#{$gen}/RESOURCE_tecsgen.oil", "w" )
  file3 = CFile.open( "#{$gen}/#{@celltype.get_name}_factory.h", "w" )

  # RESOURCE
  @celltype.get_cell_list.each { |cell|

    if cell.is_generate?

      str = cell.get_name

      if str.to_s == "RES_SCHEDULER" then

        cell.set_specified_id( 1 )

      else

        file3.print "DeclareResource( #{cell.get_name} );\n"

        file2.print "\tRESOURCE #{cell.get_name} {\n"

        # PROPERTY
        join = cell.get_join_list.get_item( :property )
        if join then
          str = join.get_rhs.to_s.gsub(/^"(.*)"$/, '\1')

          if str == "LINKED" then
            file2.print "\t\tRESOURCEPROPERTY = #{str} {\n"
            join2 = cell.get_join_list.get_item( :linkedResource )
            str2 = join2.get_rhs.to_s.gsub(/^"(.*)"$/, '\1')
            file2.print "\t\t\tLINKEDRESOURCE = #{str2};\n"
            file2.print "\t\t};\n"
          else
            file2.print "\t\tRESOURCEPROPERTY = #{str};\n"
          end
        end

        file2.print "\t};\n"
        file2.print "\n"

      end

    end
  }

  file2.close
  file3.close

  end

end
