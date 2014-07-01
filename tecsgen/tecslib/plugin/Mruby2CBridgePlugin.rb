# -*- coding: euc-jp -*-
#
#  mruby => TECS bridge
#  
#   Copyright (C) 2008-2013 by TOPPERS Project
#
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
#   $Id: Mruby2CBridgePlugin.rb 1951 2013-05-01 08:48:13Z okuma-top $
#

class Mruby2CBridgePlugin < SignaturePlugin
  @@signature_list = { }

  def initialize( signature, option )
    super

    @celltype_name = :"t#{@signature.get_global_name}"
    @class_name = :"T#{@signature.get_global_name}"

    parse_plugin_arg
  end

  def gen_cdl_file( file )
    if( @@signature_list.length == 0 )then
      print_msg "  Mruby2CBridgePlugin: [initialize function] 'void initializeBridge( mrb_state *mrb )' must be called from VM.\n"
      c2tecs = "generate( C2TECSBridgePlugin, nMruby::sInitializeBridge, \"silent=true\" );\n"
    end

    if @@signature_list[ @signature.get_global_name ] then
      @@signature_list[ @signature.get_global_name ] << self
      cdl_warning( "MRCW001 signature '$1' duplicate. ignored current one", @signature.get_namespace_path )
      return
    end

    @@signature_list[ @signature.get_global_name ] = [self]
    print_msg "  Mruby2CBridgePlugin: [object creattion]    object = TECS::#{@class_name}.new( 'C#{@signature.get_global_name}' )\n"
    print_msg "  Mruby2CBridgePlugin: [function call]       result = object.function( params )  # substitute 'function' and params \n"

    cf = CFile.open( "#{$gen}/Mruby2C_tsInitializerBridge.cdl", "w")
    cf.print <<EOT
cell nC2TECS::tnMruby_sInitializeBridge C2TECS_tsInitializeBridge{
    cCall = VM_TECSInitializer.eInitialize;
};
EOT
    cf.close

    file.print <<EOT
generate( MrubyBridgePlugin, #{@signature.get_namespace_path}, "silent=true" );
generate( TECS2CBridgePlugin, #{@signature.get_namespace_path}, "silent=true" );
#{c2tecs}
cell nMruby::t#{@signature.get_name} C#{@signature.get_name}{
    cTECS = TECS2C_#{@signature.get_name}.eEnt;
};
cell nTECS2C::t#{@signature.get_name} TECS2C_#{@signature.get_name}{};

import( "Mruby2C_tsInitializerBridge.cdl" );
EOT

  end
end
