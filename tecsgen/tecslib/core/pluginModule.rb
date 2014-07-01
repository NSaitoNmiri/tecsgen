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
#   $Id: pluginModule.rb 1937 2013-04-15 20:09:33Z okuma-top $
#++

#== �ץ饰�������ɤ���¦�Υ⥸�塼��
# @@loaded_plugin_list:: {Symbol=>Integer}
module PluginModule

  @@loaded_plugin_list = {}

  #=== �ץ饰�������ɤ���
  #return:: true : ������ false : ����
  #
  # ���Ǥ˥��ɤ���Ƥ����Τϡ���ʣ���ƥ��ɤ��ʤ�
  # load �����㳰�Ϥ��Υ᥽�åɤ���ǥ���å������ false ���֤����
  def load_plugin( plugin_name, superClass )

    dbgPrint "PluginModule: load_plugin: #{plugin_name}\n"
    begin
      unless @@loaded_plugin_list[ plugin_name.to_sym ] then
        @@loaded_plugin_list[ plugin_name.to_sym ] = 0
        if ( $verbose ) then
          print( "load '#{plugin_name}.rb'\n" )
        end
        # "#{plugin_name}.rb" ����ɡʥ����ƥ��ѤǤϤʤ��Τǡ�fatal ���顼�ˤ��ʤ���
        if require_tecsgen_lib( "#{plugin_name}.rb", false ) == false
          cdl_error( "P2001 $1.rb : fail to load plugin" , plugin_name )
          return false
        end
      end

      plSuper = nil
      # eval( "plSuper = #{plugin_name}.superclass" )
      eval( "plSuper = #{plugin_name}" )
      while plSuper != superClass && plSuper != nil
        plSuper = plSuper.superclass
      end
      if plSuper == nil then
        cdl_error( "P2002 $1: not kind of $2" ,  plugin_name, superClass.name )
        return false
      end
    rescue Exception => evar
      if $debug then
        p evar.class
        pp evar.backtrace
      end
      cdl_error( "P2003 $1: load failed" , plugin_name )
      return false
    end
    return true
  end

  #=== �ץ饰����� gen_cdl_file ��ƤӤ��� cdl �ե��������������������Ԥ�
  def generate_and_parse plugin_object
    if plugin_object == nil     # �ץ饰����Υ��ɤ˼��Ԥ��Ƥ���ʴ��˥��顼��
      return
    end
    plugin_name = plugin_object.class.name.to_sym
    if @@loaded_plugin_list[ plugin_name ] == nil
      raise "#{plugin_name} might have different name "
      # �ץ饰����Υե�����̾�ȡ��ץ饰����Υ��饹̾����㤹����
    end
    count = @@loaded_plugin_list[ plugin_name ]
    @@loaded_plugin_list[ plugin_name ] += 1
    tmp_file_name = "#{$gen}/tmp_#{plugin_name}_#{count}.cdl"

    begin
      tmp_file = CFile.open( tmp_file_name, "w" )
    rescue
      cdl_error( "P2004 $1: open error \'$2\'" , plugin_name, tmp_file_name )
    end
    dbgPrint "generate_and_parse: #{plugin_object.class}: gen_cdl_file\n"
    begin
      plugin_object.gen_cdl_file( tmp_file )
    rescue Exception => evar
      cdl_error( "P2005 $1: plugin error in gen_through_cell_code " , plugin_name )
      print_exception( evar )
    end
    begin
      tmp_file.close
    rescue
      cdl_error( "P2006 $1: close error \'$2\'" , plugin_name, tmp_file_name )
    end

    generator = Generator.new
    generator.set_plugin( plugin_object )
    generator.parse( [ tmp_file_name ] )
    generator.finalize
  end

  #=== �ץ饰���� CDL �� POST �����ɤ�����
  # tmp_plugin_post_code.cdl �ؤν���
  def self.gen_plugin_post_code file
    dbgPrint "PluginModule #{@@loaded_plugin_list}\n"
    @@loaded_plugin_list.each{ |plugin_name,count|
      dbgPrint "PluginModule: #{plugin_name}\n"
      eval_str = "#{plugin_name}.gen_post_code( file )"
      if $verbose then
        print "gen_plugin_post_code: #{eval_str}\n"
      end
      begin
        eval( eval_str )
      rescue Exception => evar
        Generator.error( "P2007 $1: fail to generate post code" , plugin_name )

        print_exception( evar )
      end
    }
  end

end
