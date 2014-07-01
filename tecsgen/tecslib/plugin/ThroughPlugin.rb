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
#   $Id: ThroughPlugin.rb 1937 2013-04-15 20:09:33Z okuma-top $
#++

# mikan through plugin: namespace ����θ����Ƥ��ʤ�

#==  ���롼�ץ饰����ζ��̤οƥ��饹������ �ʲ��⤻���˥��롼���륻����������륹�롼�ץ饰����
#    ���롼�ץ饰����� ThroughPlugin �λҥ��饹�Ȥ����������
class ThroughPlugin < Plugin
#@cell_name::      Symbol             �������륻��̾��ʣ����������������硢������¦�Υ����
#@plugin_arg_str:: string             through �ǻ��ꤵ�줿����
#@next_cell:: Cell                    �ƤӸ����礹�륻��
#@next_cell_port_name:: Symbol       �ƤӸ����礹�������̾��
#@signature::      Signature          �����˥���
#@celltype::       Celltype           �Ƥ���Υ���Υ��륿����. through ��Ϣ�ܤ����硢�ǽ�Ū�ʸƤ���Υ���Υ��륿����
#@entry_port_name::Symbol             �������륻��μ�����̾  "eThroughEntry"
#@call_port_name:: Symbol             �������륻��θƤӸ�̾  "cCall"
#@ct_name::        Symbol             �������륻��Υ��륿����̾   "t#{self.class.name}_#{@signature.get_global_name}"
#@plugin_arg_list:: Hash              �ץ饰���������ѡ���������̤Υϥå����ѿ�
#@caller_cell::    Cell               �ƤӸ��Υ��롥through �ץ饰����Ϣ�ܤ�����Ǥϡ��Ǥ�ƤӸ��Υ��롥($source$)
#                                     through �ץ饰���󤬹�ή���륱�����Ǥϡ�1���ܤθƤӸ�����Τ߰����Ȥ���Ϳ������
#                                     ���ä� TracePlugin �θƤӸ���Ƚ�̤����Ѥ�����ϡ��ۤʤ�ƤӸ�����ƤФ���ǽ�������뤳�Ȥ���դ��ʤ��ƤϤʤ�ʤ�
#@callee_cell:: Cell                  �Ƥ���Υ���($destination$)
#@plugin_arg_check_proc_tab:: [string => Proc]  �ץ饰�������̾�ͥ����å��ؿ�
# �ʲ����ѿ��ϡ�initialize �ǤϤʤ����夫�����ꤵ���
#@start_@region::  Region             �Ϥޤ�Υ꡼����� caller_cell �Υ꡼�����Ȥϰۤʤ��ǽ�������� ($start_region$)
#@end_region::  Region                �����Υ꡼����� next_cell �Υ꡼�����Ȥϰۤʤ��ǽ�������� ($end_region$)
#@region:: Region                     @start_region �� @end_region �Τ����줫�ǡ�cell ���֤��Τ����ޤ����꡼����� ($preferred_region$)
#@through_type:: Symbol              :THROUGH, :TO_THROUGH, :IN_THROUGH, :OUT_THROUGH �Τ����줫

  # ���� Plugin �������������륿���פΥꥹ��
  @@generated_celltype = {}

  #=== ThroughPlugin �ν����
  #     through �����ꤵ�줿�������������Ԥ���
  #         ������Ǥϡ����ꤵ�줿������Ͽ�����α���
  #cell_name::      Symbol             �������٤�����̾�ʼ���¦��
  #plugin_arg::     string             through �ǻ��ꤵ�줿����
  #next_cell::      Cell               �ƤӸ�����³���륻��
  #next_cell_port_name:: Symbol        �ƤӸ�����³���������̾��
  #signature::      Signature          �����˥���
  #celltype::       Celltype           ���륿���� (�Ƥ���Υ���Υ��륿����)
  #caller_cell::    Cell               �ƤӸ��Υ��롥@caller_cell �ι�򻲾�
  def initialize( cell_name, plugin_arg, next_cell, next_cell_port_name, signature, celltype, caller_cell )
    super()
    @cell_name = cell_name                      # �������٤�����̾�ʼ�����¦�Υ���̾��
                                                # ���θƤ�����̥�������������硢����̾������Ƭ���Ȥ��٤�
    @next_cell = next_cell                      # �Ƥ���Υ���
    @next_cell_port_name = next_cell_port_name
    @signature = signature
    @entry_port_name = :"eThroughEntry"
    @call_port_name = :"cCall"
    @ct_name = :"t#{self.class.name}_#{@signature.get_global_name}"
    @celltype = celltype
    @plugin_arg_str = plugin_arg
    @plugin_arg_list = {}                       # �ץ饰���������ѡ���������̤Υϥå����ѿ�
    @caller_cell     = caller_cell
    Join.set_through_info self                  # �������Ϥ�ʤ�(�夫���ɲä��줿)��Τ� set_through_info �����ꤵ���
    print( "#{self.class.name}.new( '#{cell_name}', '#{plugin_arg}', '#{next_cell.get_name}', '#{next_cell_port_name}', #{celltype.get_name} )\n" )
  end

  #=== ��������ꤹ��
  # ��ͭ�����ͥ�ξ�� caller_cell, next_cell �Τ������ region �Ǥ�ʤ�������������
  # �夫���ɲä����Τ� initialize �ΰ����ǤϤʤ����̥᥽�åɤ�����
  # ���Υ᥽�åɤϡ������С��饤�ɤ��ʤ��Ǥ�������
  # Join �� ThrougPlugin �δ֤�Ϣ���Ѥǡ�����Ȥ�������ɲä�����ǽ�������뤿��
  # ���Υ᥽�åɤ� V1.C.0.34 �ǰ��֤���ư���졢ThroughPlugin#initialize �ǸƤӽФ����
  def set_through_info( start_region, end_region, through_type, join, callee_cell, count )
    @start_region = start_region
    @end_region = end_region
    @through_type = through_type
    @join = join
    @callee_cell = callee_cell
    @count = count

    # preferred_region ������
    case through_type
    when :IN_THROUGH, :THROUGH
      @region = end_region
    when :OUT_THROUGH, :TO_THROUGH
      @region = start_region
    else
      raise "Unknown through_type #{through_type}"
    end
  end

  #===  �����̾��������
  def get_cell_name
    @cell_name
  end

  #=== NamespacePath ������
  # �������륻��� namespace path ����������
  def get_cell_namespace_path
#    nsp = @region.get_namespace.get_namespace_path
    nsp = @region.get_namespace_path
    return nsp.append( @cell_name )
  end

  #===  �������줿����μ�������̾��������
  def get_through_entry_port_name
    @entry_port_name
  end

  #===  ��������ɤ�����
  #      typedef, signature, celltype �ʤɡ�cell �ʳ��ˤΥ����ɤ�����
  #          ��ʣ�����������ƤϤʤ�ʤ��ʤ��Ǥ���������Ƥ�����Ͻ��Ϥ��ʤ����ȡ�
  #file::        FILE       ��������ե�����
  def gen_plugin_decl_code( file )

    # ���Υ��륿���ס�Ʊ�������˥���ˤϴ�����������Ƥ��뤫��
    if @@generated_celltype[ @ct_name ] == nil then
      @@generated_celltype[ @ct_name ] = [ self ]
    else
      @@generated_celltype[ @ct_name ] << self
      return
    end

    file2 = CFile.open( "#{$gen}/#{@ct_name}.cdl", "w" )

    send_receive = []
    if @signature != nil then
      @signature.each_param{ |fd,param|
        dir =param.get_direction
        case dir
        when :SEND, :RECEIVE
          send_receive << [ dir, fd, param ]
        end
      }
    end

    file2.print <<EOT
celltype #{@ct_name} {
EOT

    if send_receive.length > 0 then
      file2.print "  [ allocator(\n"
      delim = ""
      send_receive.each { |a|
        file2.print "#{delim}\t#{a[1].get_name}.#{a[2].get_name}<=#{@call_port_name}.#{a[1].get_name}.#{a[2].get_name}"
        delim = ",\n"
      }
      file2.print "\n  )]\n"
    end

    file2.print <<EOT
  entry #{@signature.get_namespace_path} #{@entry_port_name};
  call  #{@signature.get_namespace_path} #{@call_port_name};
};
EOT
    file2.close

    file.print "import( \"#{$gen}/#{@ct_name}.cdl\" );\n"
  end

  #=== CDL �ե����������
  #file::     FILE    ��������ե�����
  def gen_cdl_file( file )
    gen_plugin_decl_code( file )
    gen_through_cell_code( file )
  end

  #===  ���륳���ɤ�����
  #     through ����ˤ�������륻�륳����(CDL)����������
  #file::        FILE       ��������ե�����
  def gen_through_cell_code( file )

    nest = @region.gen_region_str_pre file
    nest_str = "  " * nest

    file.print <<EOT
#{nest_str}cell #{@ct_name} #{@cell_name} {
#{nest_str}  #{@call_port_name} = #{@next_cell.get_namespace_path.get_path_str}.#{@next_cell_port_name};
#{nest_str}};
EOT
    @region.gen_region_str_post file

  end

  #=== ���Υ����ɤ�����
  #�ץ饰����θ��Υ����� (CDL) ������
  #file:: File: 
  def self.gen_post_code( file )
    # ʣ���Υץ饰����� post_code ����ĤΥե�����˴ޤޤ�뤿�ᡢ�ʲ��Τ褦�ʸ��Ф���Ĥ��뤳��
    # file.print "/* '#{self.class.name}' post code */\n"
  end

  #===  �������ؿ�������(C����)����������
  #     �̾�Ǥ���С������ͥ졼���ϼ������ؿ��Υƥ�ץ졼�Ȥ���������
  #     �ץ饰����ξ�硢�ѹ�����ɬ�פΤʤ����륿���ץ����ɤ���������
  #file::           FILE        ������ե�����
  #b_singleton::    bool        true if singleton
  #ct_name::        Symbol
  #global_ct_name:: string
  #sig_name::       string
  #ep_name::        string
  #func_name::      string
  #func_global_name:: string
  #func_type::      class derived from Type
  def gen_ep_func_body( file, b_singleton, ct_name, global_ct_name, sig_name, ep_name, func_name, func_global_name, func_type, params )

    ret_type = func_type.get_type
    b_ret_void = ret_type.is_void?

    if ! b_ret_void then
      file.print( "  #{ret_type.get_type_str}  retval;\n" )
    end

    if ! b_singleton then

      file.print <<EOT
  #{ct_name}_CB    *p_cellcb;
  if( VALID_IDX( idx ) ){
    p_cellcb = #{global_ct_name}_GET_CELLCB(idx);
  }else{
     /* ���顼���������ɤ򤳤��˵��� */
  }

EOT
    end

    # p "celltype_name, sig_name, func_name, func_global_name"
    # p "#{ct_name}, #{sig_name}, #{func_name}, #{func_global_name}"

    delim = ""
    if ! b_ret_void then
      file.print( "  retval = " )
    end

    file.print( "#{@call_port_name}_#{func_name}(" )

#    if ( ! b_singleton ) then
#      file.print( " tecs_this" )
#      delim = ","
#    end

    params.each{ |param|
      file.printf( "#{delim} #{param.get_name}" )
      delim = ","
    }

    file.print( " );\n" )

    if ! b_ret_void then
      file.print( "  return retval;\n" )
    end
  end

  #=== Through �ץ饰����ΰ�����̾�����ִ�����
  def check_plugin_arg( ident, rhs )
    rhs = subst_name rhs
    super( ident, rhs )
  end

  #=== ThroughPlugin#̾�����ִ�
  # �ץ饰���󥪥ץ����������ʸ������ִ�����
  #   $source$       �� �ƤӸ��Υ���̾
  #   $destination$  �� �Ƥ���Υ���̾
  #   $SOURCE$       �� �ƤӸ��Υ���̾ (�꡼�����̾�� '_' ��Ϣ�뤷�� global_name)
  #   $DESTINATION$  �� �Ƥ���Υ���̾ (�꡼�����̾�� '_' ��Ϣ�뤷�� global_name)
  #   $next$         �� ���Υ���̾
  #                     ʣ���� through ���Ĥʤ��äƤ����硢�������������
  #   $NEXT$         �� ���Υ���̾ (�꡼�����̾�� '_' ��Ϣ�뤷�� global_name)
  #                     ʣ���� through ���Ĥʤ��äƤ����硢�������������
  #   $start_region$ �� $source$ �Υ����¸�ߤ��� region (global_name)
  #   $end_region$   �� $destination$ �Υ����¸�ߤ��� region (global_name)
  #   $preferred_region$  �� Ŭ�ڤ� region (global_name), start_region �ޤ��� end_region
  #   $count$        �� region �֤� through ��Ŭ�ѿ�
  #   $$             �� $ ���ִ�
  def subst_name( str )
    # ����̾���ִ�
    str = str.gsub( /(^|[^\$])\$source\$/, "\\1#{@caller_cell.get_name}" )
    str = str.gsub( /(^|[^\$])\$destination\$/, "\\1#{@callee_cell.get_name}" )
    str = str.gsub( /(^|[^\$])\$SOURCE\$/, "\\1#{@caller_cell.get_global_name}" )
    str = str.gsub( /(^|[^\$])\$DESTINATION\$/, "\\1#{@callee_cell.get_global_name}" )
    str = str.gsub( /(^|[^\$])\$next\$/, "\\1#{@next_cell.get_name}" )
    str = str.gsub( /(^|[^\$])\$NEXT\$/, "\\1#{@next_cell.get_global_name}" )
    # region ̾���ִ�
    str = str.gsub( /(^|[^\$])\$start_region\$/, "\\1#{@start_region.get_global_name}" )
    str = str.gsub( /(^|[^\$])\$end_region\$/, "\\1#{@end_region.get_global_name}" )
    str = str.gsub( /(^|[^\$])\$preferred_region\$/, "\\1#{@region.get_global_name}" )
    str = str.gsub( /(^|[^\$])\$count\$/, "\\1#{@count}" )

    str = str.gsub( /\$\$/, "\$" )                       # $$ �� $ ���ִ�

    return str
  end

  def show_tree( indent )
    indent.times { print "  " }
    puts "Plugin: celltype: #{@ct_name} cell: #{@cell_name}"
    (indent+1).times { print "  " }
    puts "next: signature: #{@signature.get_namespace_path} call = #{@next_cell.get_name}.#{@next_cell_port_name}"
  end
end

