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
#   $Id: SharedRPCPlugin.rb 1926 2013-02-02 06:16:04Z okuma-top $
#++

require_tecsgen_lib "lib/GenTransparentMarshaler.rb"
require_tecsgen_lib "lib/GenParamCopy.rb"

#= SharedRPC �ץ饰����
# SharedRPC �����ͥ����������
# �ץ饰��������� GenTransparentMarshaler ����

# mikan through plugin: namespace ����θ����Ƥ��ʤ�
# ��������Ѥ����硢�ʲ��Τ褦�� toppers_jsp.cdl sChannel.cdl ����ꤹ��ɬ�פ�����
# tecsgen toppers_jsp.cdl sChannel.cdl your_description.cdl

# �ʲ���������»����
#  �ƤӸ����Ƥ���Υ���ǥ�����char, short, int_t, long_t, intptr_t �Υ�������Ʊ��
#  ͭ��桢̵���ǥ�������Ʊ��

class SharedRPCPlugin < ThroughPlugin

  attr_reader :region
  @@shared_channel_list = {}
  include GenTransparentMarshaler
  include GenParamCopy

  #=== RPCPlugin �� initialize
  #  ������ ThroughPlugin (plugin.rb) �򻲾�
  def initialize( cell_name, plugin_arg, next_cell, next_cell_port_name, signature, celltype, caller_cell )

    # mikan �ץ饰���󥪥ץ���������԰��פΥ����å� task_priority, 

    super
    initialize_transparent_marshaler cell_name

    # ���ץ����GenTransparentMarshaler ����
    @plugin_arg_check_proc_tab = RPCPluginArgProc
    @channelCellName = ""     # nil �ˤ��Ƥ���
    parse_plugin_arg

    @shared_channel_ct_name = :"tSharedRPCPlugin_#{@channelCelltype}"
    @shared_channel_ct_file_name = "#{$gen}/#{@shared_channel_ct_name}.cdl"
    @rpc_channel_celltype_name = :"tSharedRPCPlugin_#{@TDRCelltype}_#{@channelCelltype}_#{@signature.get_global_name}"
    @rpc_channel_celltype_file_name = "#{$gen}/#{@rpc_channel_celltype_name}.cdl"

    @shared_channel_cell = @channelCellName
    if @shared_channel_cell == "" then
      cdl_error( "SharedRPCPlugin: need channelCellName option" )
    end

    if @@shared_channel_list[ @shared_channel_cell ] == nil then
      # ���
      @@shared_channel_list[ @shared_channel_cell ] = [ self ]
    else
      # �����ܰʹ�
      @@shared_channel_list[ @shared_channel_cell ] << self
    end
    @sub_channel_no = ( @@shared_channel_list[ @shared_channel_cell ].length ) -1

    if @region != @@shared_channel_list[ @shared_channel_cell ][0].region then
      # ��Фȥ꡼������԰��� (��Фϡ���ʬ���Ȥȥ����å�����롣̵�̤����������Τ�����)
      cdl_error( "SharedRPCPlugin: preferred region mismatch current: #{@region.get_name} previous: #{@@shared_channel_list[ @shared_channel_cell ][0].region.get_name}")
    else
      dbgPrint "SahredRPCPlugin: Region: #{@region.get_name}, #{@@shared_channel_list[ @shared_channel_cell ][0].region.get_name}\n"
    end

    if @signature.need_PPAllocator? then
      if @PPAllocatorSize == nil then
        cdl_error( "PPAllocatorSize must be speicified for oneway [in] array" )
      end
    end

  end

  # def set_through_info( start_region, end_region, through_type )
  #   super
  #  
  # end

  def gen_plugin_decl_code( file )

    # ���Υ��륿���ס�Ʊ�������˥���ˤϴ�����������Ƥ��뤫��
    if @@generated_celltype[ @shared_channel_ct_name ] == nil then
      @@generated_celltype[ @shared_channel_ct_name ] = [ self ]
    else
      @@generated_celltype[ @shared_channel_ct_name ] << self
    end

    if @@generated_celltype[ @ct_name ] == nil then
      @@generated_celltype[ @ct_name ] = [ self ]
    else
      @@generated_celltype[ @ct_name ] << self
    end

    gen_marshaler_celltype
    # Ʊ�����Ƥ����ٽ񤯲�ǽ������ (AppFile ���Բ�)

    if @signature.need_PPAllocator? then
      alloc_call_port = "  call sPPAllocator cPPAllocator;\n"
      alloc_call_port_join = "  cPPAllocator => composite.cPPAllocator;\n"
    else
      alloc_call_port = ""
      alloc_call_port_join = ""
    end

    f = CFile.open( @rpc_channel_celltype_file_name, "w" )
    # Ʊ�����Ƥ����ٽ񤯲�ǽ������ (AppFile ���Բ�)

    f.print <<EOT
import( "#{@marshaler_celltype_file_name}" );

composite #{@rpc_channel_celltype_name} {
  /* Interface */
  call  #{@signature.get_namespace_path} #{@call_port_name};
  entry #{@signature.get_namespace_path} eThroughEntry;
  call  sTDR       cTDR;
  call  sEventflag cEventflag;
  entry sUnmarshalerMain  eUnmarshalAndCallFunction;
#{alloc_call_port}
  [optional]
    call sSemaphore cLockChannel;

  /* Implementation */
  cell #{@marshaler_celltype_name} #{@signature.get_global_name}_marshaler{
    cTDR         => composite.cTDR;
    cEventflag   => composite.cEventflag;
    cLockChannel => composite.cLockChannel;
  };
  cell #{@unmarshaler_celltype_name} #{@signature.get_global_name}_unmarshaler{
    cTDR         => composite.cTDR;
    cEventflag   => composite.cEventflag;
    cServerCall  => composite.#{@call_port_name};
#{alloc_call_port_join}  };
  composite.eThroughEntry => #{@signature.get_global_name}_marshaler.eClientEntry;
  composite.eUnmarshalAndCallFunction => #{@signature.get_global_name}_unmarshaler.eUnmarshalAndCallFunction;
};
EOT
    # mikan stackSize option & �ǿ� tecs_package �б�

    f.close

    f = CFile.open( "#{$gen}/#{@shared_channel_ct_name}.cdl", "w" )
    # Ʊ�����Ƥ����ٽ񤯲�ǽ������ (AppFile ���Բ�)

    f.print <<EOT
[active]
composite #{@shared_channel_ct_name} {
  /* Interface */
  entry  sSemaphore eSemaphore[];
  call   sUnmarshalerMain  cUnmarshalAndCallFunction[];

  entry  sDataqueue eDataqueue;
  entry  sTDR       eTDR;
  entry  sEventflag eEventflag;

  attr {
    PRI    priority;
  };

  /* Implementation */
  cell #{@channelCelltype} Channel{
  };
  cell tSemaphore Semaphore {count = 1; attribute = C_EXP("TA_NULL");};
  cell tRPCSharedTaskMain RPCSharedTaskMain {
    cUnmarshalAndCallFunction => composite.cUnmarshalAndCallFunction;
    cServerSideTDR            = Channel.eTDR;
  };
  cell tRPCSharedChannelMan RPCChannelMan {
    cSemaphore                = Semaphore.eSemaphore;
    cClientSideTDR            = Channel.eTDR;
  };
  cell tTask RPCSharedTask {
    cBody = RPCSharedTaskMain.eMain;
    taskAttribute = C_EXP("TA_ACT");
    stackSize = 4096;
    priority = composite.priority;
  };
  composite.eTDR           => Channel.eTDR;
  composite.eEventflag     => Channel.eEventflag;
  composite.eSemaphore     => RPCChannelMan.eSemaphore;
  composite.eDataqueue     => Channel.eDataqueue;
};
EOT
    f.close

  end

  #===  through cell �����ɤ�����
  #
  #
  def gen_through_cell_code( file )

    gen_plugin_decl_code( file )

    file.print <<EOT
import( "#{@rpc_channel_celltype_file_name}" );
import( "#{$gen}/#{@shared_channel_ct_name}.cdl" );
EOT

    # nest = @next_cell.get_region.gen_region_str_pre file
    nest = @region.gen_region_str_pre file
    indent_str = "  " * nest

    # �����õ��
    # path =["::",@next_cell.get_name]
    # cell = Namespace.find( path )
    cell = Namespace.find( @next_cell.get_namespace_path )

    # PPAllocator ��ɬ�פ�?
    if @signature.need_PPAllocator? then
      if @sub_channel_no == 0 then
        file.print <<EOT
#{indent_str}cell tPPAllocator PPAllocator_#{@shared_channel_cell}{
#{indent_str}  heapSize = #{@PPAllocatorSize};
#{indent_str}};
EOT
      end

      ppallocator_join = "#{indent_str}  cPPAllocator = PPAllocator_#{@shared_channel_cell}.ePPAllocator;\n"
    else
      ppallocator_join = ""
    end

    # ��ͭ������̿������ͥ�������Υץ�ȥ��������
    file.print <<EOT
#{indent_str}cell #{@shared_channel_ct_name} #{@shared_channel_cell};
EOT

    # ��������Ʒ�礴�ȤΥ��������

    # ���������λ��꤬���뤫��
    if cell.get_allocator_list.length > 0 then

      file.print "#{indent_str}[allocator("

      delim = ""
      cell.get_allocator_list.each do |type, eport, subsc, func, buf, alloc|

        file.print delim
        delim = ",\n#{indent_str}           "        # �ǽ��ԤˤϽФ��ʤ�

        if subsc then        # ����ź��
          subsc_str = '[#{subsc}]'
        else
          subsc_str = ""
        end

        eport = "eThroughEntry" #RPC�μ�����̾���ѹ�
        file.print  "#{eport}#{subsc_str}.#{func}.#{buf} = #{alloc}"
      end

      file.puts ")]"
    end

    # �������Τ�����
    file.print <<EOT
#{indent_str}cell #{@rpc_channel_celltype_name} #{@cell_name} {
#{indent_str}  #{@call_port_name} = #{@next_cell.get_name}.#{@next_cell_port_name};
#{indent_str}  cTDR         = #{@shared_channel_cell}.eTDR;
#{indent_str}  cEventflag   = #{@shared_channel_cell}.eEventflag;
#{indent_str}  cLockChannel =  #{@shared_channel_cell}.eSemaphore[#{@sub_channel_no}];
#{ppallocator_join}#{indent_str}};
EOT
    @region.gen_region_str_post file
  end

  #=== ���Υ����ɤ�����
  #�ץ饰����θ��Υ����ɤ�����
  #file:: File: 
  def self.gen_post_code( file )
    file.print "/* '#{self.name}' post code */\n"
    @@shared_channel_list.each{ |chan_name,plugin_obj|
      plugin_obj[0].gen_post_code( file, plugin_obj )
    }
  end

  #=== ���Υ����ɤ�����
  # plugin_obj[0] ����ɽ���ƽ��Ϥ���ʥ��󥹥����ѿ��˥������������������
  def gen_post_code( file, plugin_obj )

    chan_name = @shared_channel_cell

    nest = @region.gen_region_str_pre file
    indent_str = "  " * nest

    # ��ͭ����Ƥ����̿������ͥ������
    # �ƥץ饰���󥤥󥹥��󥹤Ǥ� @shared_channel_ct_name �Ȥ��Ƶ������Ƥ���
    file.print "#{indent_str}cell tSharedRPCPlugin_#{@channelCelltype} #{chan_name} {\n"
    plugin_obj.each{ |po|
      file.print <<EOT
#{indent_str}    cUnmarshalAndCallFunction[] = #{@cell_name}.eUnmarshalAndCallFunction;
EOT
    }
    file.printf "#{indent_str}    priority = #{@task_priority};\n#{indent_str}};\n"
    @region.gen_region_str_post file

  end

end

