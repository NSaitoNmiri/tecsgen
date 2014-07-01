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
#   $Id: SharedOpaqueRPCPlugin.rb 1926 2013-02-02 06:16:04Z okuma-top $
#++

require_tecsgen_lib "lib/GenOpaqueMarshaler.rb"
require_tecsgen_lib "lib/GenParamCopy.rb"

#= SharedOpaqueRPC �ץ饰����
# SharedOpaqueRPC �����ͥ����������
# �ץ饰��������� GenTransparentMarshaler ����

# mikan through plugin: namespace ����θ����Ƥ��ʤ�
# ��������Ѥ����硢�ʲ��Τ褦�� toppers_jsp.cdl sChannel.cdl ����ꤹ��ɬ�פ�����
# tecsgen toppers_jsp.cdl sChannel.cdl your_description.cdl

# �ʲ���������»����
#  �ƤӸ����Ƥ���Υ���ǥ�����char, short, int_t, long_t, intptr_t �Υ�������Ʊ��
#  ͭ��桢̵���ǥ�������Ʊ��

class SharedOpaqueRPCPlugin < ThroughPlugin

  # �����ͥ��ͭ����ץ饰���󥪥֥������ȤؤΥϥå���ꥹ��
  @@shared_channel_list = {}    # { chan_name => [ Plugin_obj0, Plugin_Obj1, ... ] }

  attr_reader :cell_name, :start_region, :end_region
  include GenOpaqueMarshaler
  include GenParamCopy

  # SharedOpaqueRPCPlugin ���ѤΥ��ץ����
  SharedOpaqueRPCPluginArgProc = RPCPluginArgProc.dup  # ʣ�����äƸ����ѹ����ʤ��褦�ˤ���
  SharedOpaqueRPCPluginArgProc[ "sharedChannelName"  ] = Proc.new { |obj,rhs| obj.set_sharedChannelName rhs }

  #=== RPCPlugin �� initialize
  #  ������ ThroughPlugin (plugin.rb) �򻲾�
  def initialize( cell_name, plugin_arg, next_cell, next_cell_port_name, signature, celltype, caller_cell )
    super
    initialize_opaque_marshaler
    @entry_port_name = :"eClientEntry"   # Marshaler �μ�����̾ (through ����������)

    # ���ץ����GenOpaqueMarshaler ����
    @plugin_arg_check_proc_tab = SharedOpaqueRPCPluginArgProc
    @sharedChannelName = nil
    parse_plugin_arg
    check_opener_code
    check_PPAllocator

    @shared_channel_ct_name = :"tSharedOpaqueRPCPluginChannel_tTDR"
    @shared_channel_server_ct_name = :"#{@shared_channel_ct_name}_Server"
    @shared_channel_client_ct_name = :"#{@shared_channel_ct_name}_Client"
    @shared_channel_ct_file_name = "#{$gen}/#{@shared_channel_ct_name}.cdl"
    if @sharedChannelName == nil then
      cdl_error( "'sharedChannelName' option: mandatory")
    else
      @shared_channel_cell = @sharedChannelName
    end

    if @@shared_channel_list[ @shared_channel_cell ] == nil then
      @@shared_channel_list[ @shared_channel_cell ] = [ self ]
    else
      @@shared_channel_list[ @shared_channel_cell ] << self
    end
    @sub_channel_no = ( @@shared_channel_list[ @shared_channel_cell ].length ) -1

    prev_start = @@shared_channel_list[ @shared_channel_cell ][0].start_region
    if @start_region != prev_start then
      # ��Ф� start �꡼������԰��� (��Фϡ���ʬ���Ȥȥ����å�����롣̵�̤����������Τ�����)
      cdl_error( "SharedRPCPlugin: start region mismatch current: #{@region.get_name} previous: #{prev_start.get_name}")
    end

    prev_end = @@shared_channel_list[ @shared_channel_cell ][0].end_region
    if @end_region != prev_end then
      # ��Ф� end �꡼������԰���  (��Фϡ���ʬ���Ȥȥ����å�����롣̵�̤����������Τ�����)
      cdl_error( "SharedRPCPlugin: end region mismatch current: #{@region.get_name} previous: #{prev_end.get_name}")
    end

  end

  # def set_through_info( start_region, end_region, through_type )
  #   super
  # end

  #=== �ץ饰������� sharedChannelCell �Υ����å�
  def set_sharedChannelName( rhs )
    @sharedChannelName = rhs
    # path = [ "::", rhs ]
    # obj = Namespace.find( path )
    # if ! obj.instance_of?( Cell ) then
    #   cdl_error( "SharedOpaqueRPCPlugin: sharedChannelName '#{rhs}' not cell" )
    # end
  end

  def gen_plugin_decl_code( file )

    # ���Υ��륿���ס�Ʊ�������˥���ˤϴ�����������Ƥ��뤫��
    if @@generated_celltype[ @shared_channel_server_ct_name ] == nil then
      @@generated_celltype[ @shared_channel_server_ct_name ] = [ self ]
    else
      @@generated_celltype[ @shared_channel_server_ct_name ] << self
    end

    gen_marshaler_celltype

    # Ʊ�����Ƥ����ٽ񤯲�ǽ������ (AppFile ���Բ�)

    if @PPAllocatorSize then
      alloc_call_port = "  call sPPAllocator cPPAllocator;\n"
      alloc_call_port_join = "  cPPAllocator => composite.cPPAllocator;\n"
    else
      alloc_call_port = ""
      alloc_call_port_join = ""
    end

    f = CFile.open( @shared_channel_ct_file_name, "w" )
    # Ʊ�����Ƥ����ٽ񤯲�ǽ������ (AppFile ���Բ�)

    f.print <<EOT

/* Shared Channel Celltype for Client */
composite #{@shared_channel_client_ct_name} {
  entry  sTDR       eTDR;
  entry  sSemaphore eSemaphore[];
  call   sChannel   cClientChannel;

  cell tTDR TDR {
    cChannel => composite.cClientChannel;
  };
  cell tSemaphore Semaphore {
    count = 1;
    attribute = C_EXP("TA_NULL");
  };
  cell tRPCSharedChannelMan SharedChannelMan{
    cSemaphore             = Semaphore.eSemaphore;
    cClientSideTDR         = TDR.eTDR;
  };
  composite.eSemaphore     => SharedChannelMan.eSemaphore;
  composite.eTDR           => TDR.eTDR;
};

/* Shared Channel Celltype for Server */
[active]
composite #{@shared_channel_server_ct_name} {
  entry  sTDR       eTDR;
  call   sChannel   cServerChannel;
  call   sUnmarshalerMain  cUnmarshalAndCallFunction[];
  call   sServerChannelOpener cOpener;
  attr {
    PRI    priority;
  };

  cell tTDR TDR {
    cChannel => composite.cServerChannel;
  };
  cell tRPCSharedTaskMainWithOpener RPCSharedTaskMain {
    cUnmarshalAndCallFunction => composite.cUnmarshalAndCallFunction;
    cServerSideTDR = TDR.eTDR;
    cOpener => composite.cOpener;
  };
  cell tTask Task {
    cBody = RPCSharedTaskMain.eMain;
    taskAttribute = C_EXP("TA_ACT");
    stackSize = 4096;
    priority = composite.priority;
  };
  composite.eTDR           => TDR.eTDR;
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

import( "#{@marshaler_celltype_file_name}" );
import( "#{@shared_channel_ct_file_name}" );
EOT

#    nest = @caller_cell.get_region.gen_region_str_pre file
    nest = @start_region.gen_region_str_pre file
    indent_str = "  " * nest

    # �����õ��
    # path =["::",@next_cell.get_name]
    # cell = Namespace.find( path )
    cell = Namespace.find( @next_cell.get_namespace_path )

    # ��ͭ������̿������ͥ�������Υץ�ȥ��������
    file.print <<EOT
#{indent_str}cell #{@shared_channel_client_ct_name} #{@shared_channel_cell};
EOT

    # �ޡ�����饻��������ʥ������������ɤ����������
    # ���������λ��꤬���뤫��
    if cell.get_allocator_list.length > 0 then

      file.print "#{indent_str}[allocator("

      delim = ""
      cell.get_allocator_list.each do |type, eport, subsc, func, buf, alloc|

        alloc_str = alloc.to_s
        subst = @substituteAllocator[alloc_str.to_sym]

        if subst then
          alloc_str = subst[2]+"."+subst[3]
        end

        file.print delim
        delim = ",\n#{indent_str}           "        # �ǽ��ԤˤϽФ��ʤ�

        if subsc then        # ����ź��
          subsc_str = '[#{subsc}]'
        else
          subsc_str = ""
        end

        eport = @entry_port_name #RPC�μ�����̾���ѹ�
        file.print  "#{eport}#{subsc_str}.#{func}.#{buf} = #{alloc_str}"
      end

      file.puts ")]"
    end

    # �ޡ�����饻����������
    file.print <<EOT
/* OpaqueRPC Marshaler Cell */
#{indent_str}cell #{@marshaler_celltype_name} #{@cell_name} {
#{indent_str}  cTDR         = #{@shared_channel_cell}.eTDR;
#{indent_str}  cLockChannel = #{@shared_channel_cell}.eSemaphore[#{@sub_channel_no}];
#{indent_str}};
EOT
    # @caller_cell.get_region.gen_region_str_post file
    @start_region.gen_region_str_post file

    # ����ޡ�����饻��ν���
    # �������Τ�����
    nest = @end_region.gen_region_str_pre file

    file.print <<EOT
/* Server Channel Cell prototype */
#{indent_str}cell #{@shared_channel_server_ct_name} #{@sharedChannelName}_Server;

EOT

    # PPAllocator ��ɬ�פ�?
    if @PPAllocatorSize then
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

    file.print <<EOT
#{indent_str}cell #{@unmarshaler_celltype_name} #{@cell_name}_Server {
#{indent_str}  cTDR         = #{@shared_channel_cell}_Server.eTDR;
#{indent_str}  cServerCall  = #{@next_cell.get_namespace_path.get_path_str}.#{@next_cell_port_name};
#{ppallocator_join}#{indent_str}};
EOT
    @end_region.gen_region_str_post file

  end

  #=== post ������(CDL) ������
  # �ץ饰����θ�Υ����ɤ�����
  #file:: File: 
  def self.gen_post_code( file )

    file.print "/* '#{self.name}' post code */\n"

    @@shared_channel_list.each{ |chan_name,plugin_obj_array|
      file.print "/* '#{chan_name}' shared channel */\n"
      plugin_obj_array[0].gen_post_code( file, plugin_obj_array )
    }

  end

  #=== post ������(CDL) ������
  # ��ͭ�����ͥ����������
  # ���Υ᥽�åɤϡ������ͥ��ͭ����ǽ�Υץ饰���󥪥֥������ȤΤ߸ƤӽФ����
  def gen_post_code( file, plugin_obj_array )

    # ��ͭ����Ƥ����̿������ͥ������
    # �ƥץ饰���󥤥󥹥��󥹤Ǥ� @shared_channel_ct_name �Ȥ��Ƶ������Ƥ���
    # region = @caller_cell.get_region
    nest = @start_region.gen_region_str_pre file
    indent_str = "  " * nest
    file.print <<EOT
#{indent_str}cell #{@shared_channel_client_ct_name} #{@sharedChannelName} {
#{indent_str}    cClientChannel = #{@clientChannelCell}.eC0;
#{indent_str}};
EOT
    @start_region.gen_region_str_post file

    nest = @end_region.gen_region_str_pre file
    indent_str = "  " * nest
    file.print "#{indent_str}cell #{@shared_channel_server_ct_name} #{@sharedChannelName}_Server {\n"
      file.print <<EOT
#{indent_str}    cServerChannel = #{@serverChannelCell}.eC1;
#{indent_str}    cOpener        = #{@serverChannelCell}.eOpener;
EOT
    plugin_obj_array.each{ |po|
      file.print <<EOT
#{indent_str}    cUnmarshalAndCallFunction[] = #{po.cell_name}_Server.eService;
EOT
    }
    file.printf <<EOT
#{indent_str}    priority = #{@taskPriority};
#{indent_str}};
EOT
    @end_region.gen_region_str_post file

  end
end


