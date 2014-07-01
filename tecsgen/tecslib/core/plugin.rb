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
#   $Id: plugin.rb 1951 2013-05-01 08:48:13Z okuma-top $
#++

#== class �⥸�塼��
# ThroughPlugin, SignaturePlugin, CelltypePlugin �� include ����
class Plugin < Node
#@error_backlog:: [msg1, msg2, ... ]   @locale �����ꤵ�������ȯ���������顼

  PluginArgProc = {
    "silent"  => Proc.new { |obj,rhs| obj.set_silent rhs },
  }

  def initialize
    super
    @b_silent = false
    @locale = nil       # set_locale ���ƤӽФ����ޤ� nil �Ȥʤ�
    @error_backlog = []
  end

  #=== Plugin#cdl_error
  # set_locale ���ƤӽФ����ޤ� @error_backlog ����¸����α����
  def cdl_error *arg
    if @locale then
      Generator.error2( @locale, *arg )
    else
      @error_backlog << arg
    end
  end

  #=== locale �����ꤹ��
  # Node �� initialize �� locale �����ꤹ�뤬��plugin �� parse �Ȥ�
  # �ۤʤ륿���ߥ� new ����뤿�ᡢlocale ������ꤹ��
  # ���Υ᥽�åɤ�2�ٸƤӽФ��� @error_backlog �Υ��顼��2�ٽ��Ϥ���Ƥ��ޤ�
  def set_locale locale
    @locale = locale
    @error_backlog.each { |arg|
      Generator.error2( locale, *arg )
    }
  end

### ��̣�����ʳ��ǸƤӽФ����᥽�å� ###
  #===  CDL �ե����������
  #      typedef, signature, celltype, cell �Υ����ɤ�����
  #      ��ʣ�����������ƤϤʤ�ʤ�
  #      ���Ǥ���������Ƥ�����Ͻ��Ϥ��ʤ����ȡ�
  #      �⤷����Ʊ̾�� import �ˤ�ꡢ��ʣ���򤱤뤳�ȡ�
  #file::        FILE       ��������ե�����
  def gen_cdl_file file
  end


### ���������ʳ��ǸƤӽФ����᥽�å� ###
  #=== �ץ饰����� gen_ep_func ���󶡤��뤫
  # gen_ep_func ���   �� �ƥ�ץ졼�ȤǤϤʤ������륿���ץ�����(tCelltype.c)������ 
  # gen_ep_func ̤��� �� �ƥ�ץ졼��(tCelltype_templ.c)������
  def gen_ep_func?
    self.class.method_defined?( :gen_ep_func_body )
  end

  #===  �������ؿ�������(C����)����������
  #     �ץ饰����ξ�硢�ѹ�����ɬ�פΤʤ����륿���ץ����ɤ���������
  #     ���Υ᥽�åɤ�̤����Ǥ���С��ץ饰����ϥ��륿���ץ����ɤ��������ʤ� (�̾��̤�ƥ�ץ졼�Ȥ���������)
  #      gen_cdl_file ������������줿���륿���פ��Ф��ƸƤӽФ����
  #file::           FILE        ������ե����� (tCelltype.c)
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

  #===  �������ؿ��� preamble (C����)����������
  #     ɬ�פʤ� preamble ���˽��Ϥ���
  #      gen_cdl_file ����Ǥ��������줿���륿���פ��Ф��ƸƤӽФ����
  #file::           FILE        ������ե�����
  #b_singleton::    bool        true if singleton
  #ct_name::        Symbol
  #global_ct_name:: string
  def gen_preamble( file, b_singleton, ct_name, global_ct_name )
    # �ǥե���ȤǤϲ�����Ϥ��ʤ�
  end

  #===  �������ؿ��� postamble (C����)����������
  #     ɬ�פʤ� postamble ���˽��Ϥ���
  #      gen_cdl_file ������������줿���륿���פ��Ф��ƸƤӽФ����
  #file::           FILE        ������ե�����
  #b_singleton::    bool        true if singleton
  #ct_name::        Symbol
  #global_ct_name:: string
  def gen_postamble( file, b_singleton, ct_name, global_ct_name )
    # �ǥե���ȤǤϲ�����Ϥ��ʤ�
  end

  #=== gen_cdl_file ������������줿���륿���פ˿��������뤬�������줿
  # �ɤΥ��륿���פ��� cell.get_celltype ��ʬ����
  #
  #file::           FILE        ������ե�����
  #b_singleton::    bool        true if singleton
  #ct_name::        Symbol
  #global_ct_name:: string
  def new_cell cell
    # �ǥե���ȤǤϲ��⤷�ʤ�
  end

### �ץ饰��������β�� ###
  def parse_plugin_arg
    arg = @plugin_arg_str.dup

    # ���Ԥ�ä�
    arg.gsub!( /\\\n/, "" )

    while arg != ""

      # ���ζ����ɤ����Ф�
      arg.sub!( /\A\s*(?:\\\n)*\s*(.*)/, '\1')

      #  ���̻Ҽ���
      if arg =~ /\A[a-zA-Z_]\w*/ then
        ident = $~
        arg = $'
      else
        cdl_error( "P1001 plugin arg: cannot find identifier in $1" , arg )
        return
      end
      
      # ���ζ����ɤ����Ф�
      arg.sub!( /\A\s*(?:\\\n)*\s*(.*)/, '\1')

      if arg =~ /=/ then
        arg = $'
      else
        cdl_error( "P1002 plugin arg: expecting \'=\' not \'$1\'" , arg )
        return
      end

      # ���ζ����ɤ����Ф�
      arg.sub!( /\A\s*(?:\\\n)*\s*(.*)/, '\1')

      # ����ʸ����
      if arg =~ /\A\\"(.*?)\\"\s*,/ then      # \"  \" �ǰϤޤ�Ƥ�����
        rhs = $1
        remain = $'
      elsif arg =~ /\A%(.*?)%\s*,/ then      # %   % �ǰϤޤ�Ƥ�����
        rhs = $1
        remain = $'
      elsif arg =~ /\A!(.*?)!\s*,/ then    # $   $ �ǰϤޤ�Ƥ�����
        rhs = $1
        remain = $'
      elsif arg =~ /\A'(.*?)'\s*,/ then    # $   $ �ǰϤޤ�Ƥ�����
        rhs = $1
        remain = $'
      elsif  arg =~ /\A\\"(.*?)\\"\s*,/ then  # || �ˤ� [,$] �ˤ�Ǥ��ʤ��ä�
        rhs = $1
        remain = $'
      # elsif arg =~ /\A(.*?)\s*$/ then
      elsif arg =~ /\A\\"(.*?)\\"\s*\z/ then      # \"  \" �ǰϤޤ�Ƥ�����
        rhs = $1
        remain = $'
      elsif arg =~ /\A%(.*?)%\s*\z/ then      # %   % �ǰϤޤ�Ƥ�����
        rhs = $1
        remain = $'
      elsif arg =~ /\A!(.*?)!\s*\z/ then    # $   $ �ǰϤޤ�Ƥ�����
        rhs = $1
        remain = $'
      elsif arg =~ /\A'(.*?)'\s*\z/ then    # $   $ �ǰϤޤ�Ƥ�����
        rhs = $1
        remain = $'
      elsif  arg =~ /\A\\"(.*?)\\"\s*\z/ then  # || �ˤ� [,$] �ˤ�Ǥ��ʤ��ä�
        rhs = $1
        remain = $'
      elsif arg =~ /\A(.*?),/ then
        rhs = $1
        remain = $'
        # ���ζ����ɤ����Ф�
        rhs.sub!( /\A\s*(.*)\s*\z/, '\1')
      elsif arg =~ /\A(.*?)\s*\z/ then
        rhs = $1
        remain = $'
      else
        cdl_error( "P1003 plugin arg: unexpected $1" , arg )
        return
      end

      # 0ʸ����ʸ����� to_sym ������㳰ȯ������ΤǶ���ʸ���Ȥ���
      if rhs == "" then
        rhs = " "
      end

      arg = remain         # arg �λĤ����ʬ
      arg.sub!( /\A\s*(?:\\\n)*\s*(.*)/, '\1')      # ���ζ����ɤ����Ф�

      # \ �򳰤�
      rhs = rhs.gsub( /\\(.)/, "\\1" )   # ������ $' ���Ѥ�뤳�Ȥ���ա�
      # print "parse_plugin_arg:  #{ident} #{rhs}\n"
      @plugin_arg_list[ ident ] = rhs

      check_plugin_arg( ident, rhs )
    end
    # @plugin_arg_list.each{|i,r|  print "ident: #{i}  rhs: #{r}\n" }
  end

  #=== �ץ饰�������������å�����
  # @plugin_arg_check_proc_tab �˽��äƥץ饰�������������å�������
  # �Ť���ˡ���ҥ��饹�ǥ����С��饤�ɤ����������̻Ҥ��������������å�����
  #ident:: string: �������̻�
  #rhs:: string: ����ʸ����
  def check_plugin_arg( ident, rhs )

    dbgPrint "check_plugin_arg: #{ident} #{rhs.to_str}\n"
    proc = nil
    if @plugin_arg_check_proc_tab  then
      proc = @plugin_arg_check_proc_tab[ident.to_s]
    end
    if proc == nil then
      proc = PluginArgProc[ ident.to_s ]
    end
    if proc.instance_of? Proc then
      dbgPrint "calling: #{self.class.name}.#{proc.to_s}\n"
      proc.call( self, rhs )
    else
      params = ""
      delim = ""
      @plugin_arg_check_proc_tab.each{ |j,p|
        params = "#{params}#{delim}#{j}"
        delim = ", "
      }
      cdl_error( "P1004 $1: unknown plugin argument\'s identifier\n  $2 are acceptible for RPCPlugin." , ident, params )
    end
  end

  #=== �ץ饰����Υ�å���������
  def print_msg( msg )
    if @b_silent == true then
      return
    end
    print msg
  end

  #=== �ץ饰������� silent
  def set_silent rhs
    if rhs == "true" || rhs == nil then
      @b_silent = true
    end
  end
end

#== ����ʸ����� EUC ������ϥե������ convert ����
# tecsgen �Υ����������ɤ� EUC �ǵ��Ҥ���Ƥ���
# ����򡢽��ϥե������ʸ�������ɤ��Ѵ����ƽ��Ϥ���
#
# generate.rb �ǽ��Ϥ����Τ� message.rb ���Ѵ����Ƥ���
# generate.rb �ǽ��Ϥ����Τ� APPFile ���饹����Ѥ��Ƥ���
# mikan: CFile �ǽ��Ϥ�����Τ� factory ���ɵ��Ǥ��ʤ� (cdl �ե�����ξ�硢�ɵ��Ǥ��Ƥ��̣���ʤ�)
class CFile
  def self.open( path, mode )
    CFile.new( path, mode )
  end

  def initialize( path, mode )
    if $b_no_kcode then 
      mode += ":" + $Ruby19_File_Encode
    end
    @file = File.open( path, mode )
  end

  def print str
    if $b_no_kcode && $KCONV_CONSOLE == Kconv::BINARY then 
      @file.print( str )
    else
      @file.print( str.kconv( $KCONV_CDL, $KCONV_TECSGEN ) )
    end
  end

  def puts str
    if $b_no_kcode && $KCONV_CONSOLE == Kconv::BINARY then 
      @file.print( str )
    else
      @file.print( str.kconv( $KCONV_CDL, $KCONV_TECSGEN ) )
    end
    @file.print( "\n" )
  end

  def printf( format, *arg )
    if $b_no_kcode && $KCONV_CONSOLE == Kconv::BINARY then 
      @file.print( sprintf( format, *arg ) )
    else
      @file.print( sprintf( format, *arg ).kconv( $KCONV_CDL, $KCONV_TECSGEN ) )
    end
  end

  def close
    @file.close
  end
end
