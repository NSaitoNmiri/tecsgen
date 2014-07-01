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
#   $Id: OpaqueRPCPlugin.rb 1926 2013-02-02 06:16:04Z okuma-top $
#++

# �ʲ���������»����
#  �ƤӸ����Ƥ���Υ���ǥ�����char, short, int_t, long_t, intptr_t �Υ�������Ʊ��
#  ͭ��桢̵���ǥ�������Ʊ��

require_tecsgen_lib "lib/GenOpaqueMarshaler.rb"
require_tecsgen_lib "lib/GenParamCopy.rb"

class OpaqueRPCPlugin < ThroughPlugin

  include GenOpaqueMarshaler
  include GenParamCopy

  # OpaqueRPCPlugin ���ѤΥ��ץ����
  OpaqueRPCPluginArgProc = RPCPluginArgProc.dup  # ʣ�����äƸ����ѹ����ʤ��褦�ˤ���
  OpaqueRPCPluginArgProc[ "noClientSemaphore"  ] = Proc.new { |obj,rhs| obj.set_noClientSemaphore rhs }

  #=== RPCPlugin �� initialize
  #  ������ ThroughPlugin (plugin.rb) �򻲾�
  def initialize( cell_name, plugin_arg, next_cell, next_cell_port_name, signature, celltype, caller_cell )
    super
    @b_noClientSemaphore = false
    initialize_opaque_marshaler

    @plugin_arg_check_proc_tab = OpaqueRPCPluginArgProc
    parse_plugin_arg
    check_opener_code
    check_PPAllocator

    print "OpaqueRPCPlugin: #{@clientChannelCell}\n"

    @rpc_server_channel_celltype_name = "tOpaqueRPCPlugin_#{@TDRCelltype}_#{@serverChannelCelltype}_#{@signature.get_global_name}"
    @rpc_server_channel_celltype_file_name = "#{$gen}/#{@rpc_server_channel_celltype_name}.cdl"
    @rpc_client_channel_celltype_name = "tOpaqueRPCPlugin_#{@TDRCelltype}_#{@clientChannelCelltype}_#{@signature.get_global_name}"
    @rpc_client_channel_celltype_file_name = "#{$gen}/#{@rpc_client_channel_celltype_name}.cdl"
  end

  def gen_plugin_decl_code( file )

    gen_marshaler_celltype

    # �����ͥ� composite ���륿���פ�����
    #  �������������줿 CDL �ե�����ϡ�tecsgen ��ľ�� import ����ΤǤϤʤ�
    #  ���륳���ɤ� CDL ���� import �����

    f = CFile.open( @rpc_client_channel_celltype_file_name, "w" )
    # Ʊ�����Ƥ����ٽ񤯲�ǽ������ (AppFile ���Բ�)

    f.print <<EOT
import( "#{@marshaler_celltype_file_name}" );

/* RPC Client side composite celltype */
composite #{@rpc_client_channel_celltype_name} {
  /* marshaler entry port */
  entry #{@signature.get_namespace_path} eThroughEntry;
  call  sChannel cChannel;
  [optional]
    call sRPCErrorHandler cErrorHandler;
  [optional]
    call sSemaphore cLockChannel;

  cell #{@TDRCelltype} TDR {
    cChannel => composite.cChannel;
  };
  cell #{@marshaler_celltype_name} Marshaler{
    cTDR = TDR.eTDR;
    cErrorHandler => composite.cErrorHandler;
    cLockChannel  => composite.cLockChannel;
  };

  composite.eThroughEntry => Marshaler.eClientEntry;
};
EOT
    f.close

    if @PPAllocatorSize then
      alloc_cell = "  cell tPPAllocator PPAllocator {\n    heapSize = #{@PPAllocatorSize};\n  };\n"
      alloc_call_port_join = "    cPPAllocator = PPAllocator.ePPAllocator;\n"
    else
      alloc_cell = ""
      alloc_call_port_join = ""
    end

    f = CFile.open( @rpc_server_channel_celltype_file_name, "w" )
    # Ʊ�����Ƥ����ٽ񤯲�ǽ������ (AppFile ���Բ�)

    f.print <<EOT
import( "#{@marshaler_celltype_file_name}" );

/* RPC Server side composite celltype */
composite #{@rpc_server_channel_celltype_name} {
  /* Interface */
  call  #{@signature.get_namespace_path} #{@call_port_name};
  call  sChannel   cChannel;
  [optional]
    call sRPCErrorHandler cErrorHandler;
  entry sUnmarshalerMain  eService;

  /* Implementation */
  cell #{@TDRCelltype} TDR {
    cChannel => composite.cChannel;
  };
#{alloc_cell}  cell #{@unmarshaler_celltype_name} Unmarshaler{
    cTDR        = TDR.eTDR;
    cErrorHandler => composite.cErrorHandler;
    cServerCall => composite.#{@call_port_name};
#{alloc_call_port_join}  };
  composite.eService => Unmarshaler.eService;
};
EOT

    f.close
  end

  #===  through cell �����ɤ�����
  #
  #
  def gen_through_cell_code( file )

    gen_plugin_decl_code( file )

    # �����õ��
    # path =["::",@next_cell.get_name]  # mikan namespace
    # cell = Namespace.find( path )
    cell = Namespace.find( @next_cell.get_namespace_path )

    file.print <<EOT
import( "#{@rpc_client_channel_celltype_file_name}" );
import( "#{@rpc_server_channel_celltype_file_name}" );

EOT

    ##### ���饤�����¦�Υ�������� #####
    nest = @start_region.gen_region_str_pre file
    nest_str = "  " * nest

    # ���ޥե�������
    if @b_noClientSemaphore == false then
      file.print <<EOT

#{nest_str}  //  Semaphore for Multi-task use ("specify noClientSemaphore" option to delete this)
#{nest_str}  cell #{@semaphoreCelltype} #{@serverChannelCell}_Semaphore{
#{nest_str}    #{@semaphoreInitializer}
#{nest_str}  };
EOT
    end

    # ���饤�����¦�����ͥ� (TINET, Socket �ʤ�)������
    file.print <<EOT
#{nest_str}  //  Client Side Channel
#{nest_str}  cell #{@clientChannelCelltype} #{@clientChannelCell}{
#{nest_str}    #{@clientChannelInitializer}
#{nest_str}  };

#{nest_str}  //  Marshaler
EOT

    # ���ޥե��η��ʸ
    if @b_noClientSemaphore == false then
      semaphore = "#{nest_str}    cLockChannel = #{@serverChannelCell}_Semaphore.eSemaphore;\n"
    else
      semaphore = ""
    end

    ### ���饤�����¦�����ͥ� (�ޡ������+TDR)������ ###
    # ���������λ��꤬���뤫��
    if cell.get_allocator_list.length > 0 then

      file.print nest_str
      file.print "[allocator("

      delim = ""
      cell.get_allocator_list.each do |type, eport, subsc, func, buf, alloc|

        alloc_str = alloc.to_s
        subst = @substituteAllocator[alloc_str.to_sym]
        if subst then
          alloc_str = subst[2]+"."+subst[3]
        end

        file.print delim
        delim = ",\n"        # �ǽ��ԤˤϽФ��ʤ�

        if subsc then        # ����ź��
          subsc_str = '[#{subsc}]'
        else
          subsc_str = ""
        end

        eport = "eThroughEntry" #RPC�μ�����̾���ѹ�
        file.print nest_str
        file.print  "#{eport}#{subsc_str}.#{func}.#{buf} = #{alloc_str}"
      end

      file.puts ")]"
    end

    if @clientErrorHandler then
      clientErrorHandler_str = "#{nest_str}    cErrorHandler = #{@clientErrorHandler};\n"
    else
      clientErrorHandler_str = ""
    end

    file.print <<EOT
#{nest_str}  cell #{@rpc_client_channel_celltype_name} #{@cell_name} {
#{nest_str}    cChannel = #{@clientChannelCell}.eC0;
#{clientErrorHandler_str}#{semaphore}#{nest_str}  };

EOT
    ### END: ���饤�����¦�����ͥ� (�ޡ������+TDR)������ ###

    @start_region.gen_region_str_post file
    file.print "\n\n"

    ##### �����С�¦�Υ�������� #####
    nest = @end_region.gen_region_str_pre file
    nest_str = "  " * nest

    if @serverErrorHandler then
      serverErrorHandler_str = "#{nest_str}    cErrorHandler = #{@serverErrorHandler};\n"
    else
      serverErrorHandler_str = ""
    end

    if @b_genOpener then
      opener = "#{nest_str}    cOpener       = #{@serverChannelCell}.eOpener;\n"
    else
      opener = ""
    end

    # �����С�¦�����ͥ� (TINET, Socket �ʤ�)
    file.print <<EOT

#{nest_str}  //  Server Side Channel
#{nest_str}  cell #{@serverChannelCelltype} #{@serverChannelCell}{
#{nest_str}    #{@serverChannelInitializer}
#{nest_str}  };
EOT

    # �����С�¦�����ͥ� (����ޡ������+TDR)
    file.print <<EOT

#{nest_str}  //  Unmarshaler
#{nest_str}  cell #{@rpc_server_channel_celltype_name} #{@serverChannelCell}_Unmarshaler {
#{nest_str}    cChannel = #{@serverChannelCell}.eC1;
#{nest_str}    #{@call_port_name} = #{@next_cell.get_namespace_path.get_path_str}.#{@next_cell_port_name};
#{serverErrorHandler_str}#{nest_str}  };
EOT

    # �����С�¦�������ᥤ��
    file.print <<EOT

#{nest_str}  //  Unmarshaler Task Main
#{nest_str}  cell #{@taskMainCelltype} #{@serverChannelCell}_TaskMain {
#{nest_str}    cMain         = #{@serverChannelCell}_Unmarshaler.eService;
#{opener}#{nest_str}  };
EOT

    # �����С�¦������
    file.print <<EOT

#{nest_str}  //  Unmarshaler Task
#{nest_str}  cell #{@taskCelltype} #{@serverChannelCell}_Task {
#{nest_str}    cBody         = #{@serverChannelCell}_TaskMain.eMain;
#{nest_str}    priority      = #{@taskPriority};
#{nest_str}    stackSize     = #{@stackSize};
#{nest_str}    taskAttribute = C_EXP( "TA_ACT" );  /* mikan : marshaler task starts at beginning */
#{nest_str}  };
EOT
    @end_region.gen_region_str_post file
  end

  #=== �ץ饰������� noClientSemaphore �Υ����å�
  def set_noClientSemaphore rhs
    rhs = rhs.to_sym
    if rhs == :true then
      @b_noClientSemaphore = true
    elsif rhs == :false then
      @b_noClientSemaphore = false
    else
      cdl_error( "RPCPlugin: specify true or false for noClientSemaphore" )
    end
  end
end


