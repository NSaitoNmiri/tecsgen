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
#   $Id: GenOpaqueMarshaler.rb 1926 2013-02-02 06:16:04Z okuma-top $
#++

#== GenOpaqueMarshaler
# OpaqueRPCPlugin, sharedOpaqueRPCPlugin ���̤����Ǥ򽸤᤿�⥸�塼��
module GenOpaqueMarshaler

  # �ץ饰�������̾�� Proc
  RPCPluginArgProc = {
    "clientChannelCelltype" => Proc.new { |obj,rhs| obj.set_clientChannelCelltype rhs },
    "serverChannelCelltype" => Proc.new { |obj,rhs| obj.set_serverChannelCelltype rhs },
    "clientChannelCell" => Proc.new { |obj,rhs| obj.set_clientChannelCell rhs },
    "serverChannelCell" => Proc.new { |obj,rhs| obj.set_serverChannelCell rhs },
    "clientChannelInitializer" => Proc.new { |obj,rhs| obj.set_clientChannelInitializer rhs },
    "serverChannelInitializer" => Proc.new { |obj,rhs| obj.set_serverChannelInitializer rhs },
    "clientSemaphoreCelltype" => Proc.new { |obj,rhs| obj.set_clientSemaphoreCelltype rhs },
    "clientSemaphoreInitializer" => Proc.new { |obj,rhs| obj.set_clientSemaphoreInitializer rhs },
    "clientErrorHandler" => Proc.new { |obj,rhs| obj.set_clientErrorHandler rhs },
    "serverErrorHandler" => Proc.new { |obj,rhs| obj.set_serverErrorHandler rhs },
    "TDRCelltype"     => Proc.new { |obj,rhs| obj.set_TDRCelltype rhs },
    "PPAllocatorSize" => Proc.new { |obj,rhs| obj.set_PPAllocatorSize rhs },
    "substituteAllocator"  => Proc.new { |obj,rhs| obj.set_substituteAllocator rhs },
    "noServerChannelOpenerCode"  => Proc.new { |obj,rhs| obj.set_noServerChannelOpenerCode rhs },
    "taskCelltype"    => Proc.new { |obj,rhs| obj.set_taskCelltype rhs },
    "taskPriority"    => Proc.new { |obj,rhs| obj.set_taskPriority rhs },
    "stackSize"      => Proc.new { |obj,rhs| obj.set_stackSize rhs },
  }

  ##### �ץ饰������������å��ؿ�

  #=== �ץ饰������� taskPriority �Υ����å�
  def set_taskPriority( rhs )
    @taskPriority = rhs
  end

  #=== �ץ饰������� serverChannelCelltype �Υ����å�
  def set_serverChannelCelltype( rhs )
    @serverChannelCelltype = rhs.to_sym
    # path = [ "::", @serverChannelCelltype ]
    # obj = Namespace.find( path )
    nsp = NamespacePath.analyze( @serverChannelCelltype.to_s )
    obj = Namespace.find( nsp )
    if ! obj.instance_of?( Celltype ) && ! obj.instance_of?( CompositeCelltype ) then
      cdl_error( "RPCPlugin: serverChannelCelltype '#{rhs}' not celltype or not defined" )
    end
  end

  #=== �ץ饰������� clientChannelCelltype �Υ����å�
  def set_clientChannelCelltype( rhs )
    @clientChannelCelltype = rhs.to_sym
    # path = [ "::", @clientChannelCelltype ]
    # obj = Namespace.find( path )
    nsp = NamespacePath.analyze( @clientChannelCelltype.to_s )
    obj = Namespace.find( nsp )
    if ! obj.instance_of?( Celltype ) && ! obj.instance_of?( CompositeCelltype ) then
      cdl_error( "RPCPlugin: clientChanneclCelltype '#{rhs}' not celltype or not defined" )
    end
  end

  #=== �ץ饰������� serverChannelCell �Υ����å�
  def set_serverChannelCell( rhs )
    @serverChannelCell = rhs.to_sym
    # ChannelCell �ϥץ饰�������������뤿�ᡢ�����Ǥϥ����å��Ǥ��ʤ�
    # path = [ "::", @serverChannelCell ]
    # obj = Namespace.find( path )
    # if ! obj.instance_of?( Cell ) then
    #   cdl_error( "RPCPlugin: serverChanneclCell '#{rhs}' not cell or not defined" )
    # end
  end

  #=== �ץ饰������� clientChannelCell �Υ����å�
  def set_clientChannelCell( rhs )
    @clientChannelCell = rhs.to_sym
    # ChannelCell �ϥץ饰�������������뤿�ᡢ�����Ǥϥ����å��Ǥ��ʤ�
    # path = [ "::", @clientChannelCell ]
    # obj = Namespace.find( path )
    # if ! obj.instance_of?( Cell ) then
    #   cdl_error( "RPCPlugin: clientChanneclCell '#{rhs}' not cell or not defined" )
    # end
  end

  #=== �ץ饰������� serverChannelInitializer �Υ����å�
  def set_serverChannelInitializer( rhs )
    @serverChannelInitializer = rhs.to_sym
  end

  #=== �ץ饰������� clientChannelInitializer �Υ����å�
  def set_clientChannelInitializer( rhs )
    @clientChannelInitializer = rhs.to_sym
  end

  #=== ������������ taskCellype �Υ����å�
  def set_taskCelltype( rhs )
    @taskCelltype = rhs.to_sym
    # path = [ "::", @taskCelltype ]
    # obj = Namespace.find( path )
    nsp = NamespacePath.analyze( @taskCelltype.to_s )
    obj = Namespace.find( nsp )
    if ! obj.instance_of?( Celltype ) && ! obj.instance_of?( CompositeCelltype ) then
      cdl_error( "RPCPlugin: taskCelltype '#{rhs}' not celltype or not defined" )
    end
  end

  #=== ������������ stack\size �Υ����å�
  def set_stackSize( rhs )
    @stackSize = rhs
  end

  #=== �ץ饰������� PPAllocatorSize �Υ����å�
  def set_PPAllocatorSize( rhs )
    @PPAllocatorSize = rhs
  end

  #=== �ץ饰������� TDRCelltype �Υ����å�
  def set_TDRCelltype( rhs )
    @TDRCelltype = rhs.to_sym
    # path = [ "::", @TDRCelltype ]
    # obj = Namespace.find( path )
    nsp = NamespacePath.analyze( @TDRCelltype.to_s )
    obj = Namespace.find( nsp )
    if ! obj.instance_of?( Celltype ) && ! obj.instance_of?( CompositeCelltype ) then
      cdl_error( "RPCPlugin: TDRCelltype '#{rhs}' not celltype or not found" )
    end
  end

  #=== �ץ饰������� substituteAllocator �Υ����å�
  # ���ץ������������ʲ��η����Ǥ��뤳�Ȥ�����å�
  #     substituteAllocator(Alloc.eAlloc=>Subst.eAlloc,Alloc2.eAlloc=>Subst2.eAlloc)
  def set_substituteAllocator( rhs )
    #str::String : �˲������ʥޥå������Ĥ�ˤʤ�ˡ�str.empty? �Ƕ��ˤʤä����Ȥ�����å��Ǥ���
    #regexp::Regexp : ���Ԥ���ȡ�����˥ޥå���������ɽ���� "\A" �лϤ��
    #expected::String: ���Ԥ���ȡ�����regexp ���и����ʤ��ä����˥��顼��å������Ȥ���ɽ��
    def optparse (str,regexp,expected)
      str.strip!
      token = nil
      res = str.sub!( regexp ){ |matched|  token = matched;  "" }
      if ! token then
        cdl_error( "syntax error in substituteAllocator option near '#{str}', expected '#{expected}'" )
      end
      return token
    end

    opt = rhs.dup
    ident_rexpr = /\A(\w[\w\d]*)/

    # "Alloc.eAlloc=>CAlloc.eAlloc" �η����ˤʤäƤ��뤳�Ȥ�����å�
    while true
      lhs_alloc_cell = optparse( opt, ident_rexpr, "allocator cell name" )
      break if ! lhs_alloc_cell

      res = optparse( opt, /\A\./, "." )
      break if ! res

      lhs_alloc_ent = optparse( opt, ident_rexpr, "allocator cell entry name" )
      break if ! lhs_alloc_ent

      res = optparse( opt, /\A\=\>/, "=>" )
      break if ! res

      rhs_alloc_cell = optparse( opt, ident_rexpr, "allocator cell name" )
      break if ! rhs_alloc_cell

      res = optparse( opt, /\A\./, "." )
      break if ! res

      rhs_alloc_ent = optparse( opt, ident_rexpr, "allocator cell entry name" )
      break if ! rhs_alloc_ent

#  �����Ǥϡ����դΥ����å��ϤǤ��ʤ������դΥ�����������ȤȤʤ�
#      path = [ "::", rhs_alloc_cell.to_sym ]   # mikan namespace
#      obj = Namespace.find( path )
#      if ! obj.instance_of?( Cell ) || obj.get_region.get_path_string != @clientRegion then
#        cdl_error( "RPCPlugin: substituteAllocator: '#{rhs_alloc_cell}' not cell or not found in client region" )
#      else
#        ct = obj.get_celltype
#        if ct #  nil �ʤ���˥��顼
#          ent = ct.find rhs_alloc_ent
#          if ! ent.instance_of? Port || ent.get_port_type != :ENTRY || ent.get_signature == nil || ! ent.get_signature.is_allocator?
#            cdl_error( "RPCPlugin: substituteAllocator: '#{rhs_alloc_cell}.#{rhs_alloc_ent}' not entry port or not have alllocator signature" )
#          end
#        end
#      end

      @substituteAllocator[ "#{lhs_alloc_cell}.#{lhs_alloc_ent}".to_sym ] =
        [ lhs_alloc_cell, lhs_alloc_ent, rhs_alloc_cell, rhs_alloc_ent ]

# p "substituteAllocator: #{lhs_alloc_cell}.#{lhs_alloc_ent}=>#{rhs_alloc_cell}.#{rhs_alloc_ent}"

      break if opt.empty?

      res = optparse( opt, /\A\,/, "," )
      break if ! res
    end

  end

  #=== �ץ饰������� noServerChannelOpenerCode �Υ����å�
  def set_noServerChannelOpenerCode( rhs )
    rhs = rhs.to_sym
    if rhs == :true
      @noServerChannelOpenerCode = true
    elsif rhs == :false then
      @noServerChannelOpenerCode = false
    else
      cdl_error( "RPCPlugin: specify true or false for noServerChannelOpenerCode" )
    end
  end

  #=== �ץ饰������� clientSemaphoreCelltype �Υ����å�
  def set_clientSemaphoreCelltype rhs
    @semaphoreCelltype = rhs.to_sym
    nsp = NamespacePath.analyze( @semaphoreCelltype.to_s )
    obj = Namespace.find( nsp )
    if ! obj.instance_of?( Celltype ) && ! obj.instance_of?( CompositeCelltype ) then
      cdl_error( "RPCPlugin: clientSemaphoreCelltype '#{rhs}' not celltype or not defined" )
    end
  end

  #=== �ץ饰������� clientSemaphoreInitializer �Υ����å�
  def set_clientSemaphoreInitializer rhs
    @semaphoreInitializer = rhs.to_sym
  end

  #=== �ץ饰������� clientErrorHandler �Υ����å�
  def set_clientErrorHandler rhs
    @clientErrorHandler = rhs.to_sym
  end

  #=== �ץ饰������� serverErrorHandler �Υ����å�
  def set_serverErrorHandler rhs
    @serverErrorHandler = rhs.to_sym
  end


  #===  �����̾��������
  # ThroughPlugin::get_cell_name plugin.rb �򥪡��С��饤��
  def get_cell_name
    @cell_name
    # @clientChannelCell
  end

  #=== marshaler �Υ��륿����̾�����ꤹ��
  def initialize_opaque_marshaler

    # ���ץ�������ꤵ����ѿ��Υǥե���Ȥ�����
    @taskPriority = 11
    @stackSize  = 4096
    @serverChannelCelltype = :"tSocketServer"
    @clientChannelCelltype = :"tSocketClient"
    @serverChannelCell = :"#{@cell_name}Server"
    @clientChannelCell = :"#{@cell_name}Client"
    @serverChannelInitializer = subst_name( "portNo=8931+$count$;" ).to_sym
    @clientChannelInitializer = subst_name( "portNo=8931+$count$; serverAddr=\"127.0.0.1\"; " ).to_sym
    @taskCelltype = :"tTask"
    @PPAllocatorSize = nil
    # @TDRCelltype  = :"tTDR"   # "tNBOTDR" ���ѹ���ͽ��
    @TDRCelltype  = :"tNBOTDR"
    @substituteAllocator = {}
    @noServerChannelOpenerCode = false
    @semaphoreCelltype = :"tSemaphore"
    @semaphoreInitializer = :"count = 1; attribute = C_EXP( \"TA_NULL\" ); ";
    @clientErrorHandler = nil
    @serverErrorHandler = nil
    @b_genOpener = false
    @taskMainCelltype = :"tRPCDedicatedTaskMain"

    @marshaler_celltype_name = :"tOpaqueMarshaler_#{@signature.get_global_name}"
    @unmarshaler_celltype_name = :"tOpaqueUnmarshaler_#{@signature.get_global_name}"
    @marshaler_celltype_file_name = "#{$gen}/#{@marshaler_celltype_name}.cdl"

    # signature ���б��Ǥ��ʤ���Τ�����å�
    @signature.each_param{ |func_decl, param_decl|
      if param_decl.get_direction == :OUT then
        if param_decl.get_count && ! param_decl.get_size then
          cdl_error( "#{@signature.get_namespace_path}.#{func_decl.get_name}.#{param_decl.get_name}: size_is must be specified for out parameter of Opaque RPC" )
        end
        if param_decl.get_string == -1 then
          cdl_error( "#{@signature.get_namespace_path}.#{func_decl.get_name}.#{param_decl.get_name}: string length must be specified for out parameter of Opaque RPC" )
        end
      end
    }
  end

  #=== GenOpaqueMarshaler# Opener Code ���������Υ����å�
  def check_opener_code
    # �����С������ͥ륻�륿���פ� entry sServerChannelOpener eOpener ����Ĥ��ɤ���������å�
    # mikan entry �� (call �Ǥʤ���) ������å����Ƥ��ʤ�
    # scct = Namespace.find ["::", @serverChannelCelltype] # mikan namespace
    nsp = NamespacePath.analyze( @serverChannelCelltype.to_s )
    scct = Namespace.find nsp
    if scct then
      obj = scct.find( :"eOpener" )
      if obj.instance_of? Port then
        if obj.get_signature.get_name.to_sym == :sServerChannelOpener then
          if @noServerChannelOpenerCode == false then
            @b_genOpener = true
            @taskMainCelltype = :"tRPCDedicatedTaskMainWithOpener"
          end
        end
      end
    end
    if @noServerChannelOpenerCode == false && @taskMainCelltype != :"tRPCDedicatedTaskMainWithOpener" then
      cdl_warning( "O9999 ServerChannelOpener code not generated, not found 'entry sServerChannelOpener eOpener'")
    end
  end

  #=== GenOpaqueMarshaler# PPAllocator ��ɬ����������å�����
  def check_PPAllocator
    if @signature.need_PPAllocator?(true) then
      if @PPAllocatorSize == nil then
        cdl_error( "PPAllocatorSize must be speicified for size_is array" )
      end
    end
  end

  ##### 

  def gen_marshaler_celltype
    f = CFile.open( @marshaler_celltype_file_name, "w" )
    # Ʊ�����Ƥ����ٽ񤯲�ǽ������ (AppFile ���Բ�)

    if @PPAllocatorSize then
      alloc_call_port = "  call sPPAllocator cPPAllocator;\n"
    else
      alloc_call_port = ""
    end

    f.print <<EOT

celltype #{@marshaler_celltype_name} {
  entry #{@signature.get_namespace_path} eClientEntry;
  call sTDR       cTDR;
  [optional]
    call sSemaphore cLockChannel;
  [optional]
    call sRPCErrorHandler cErrorHandler;
};
celltype #{@unmarshaler_celltype_name} {
  call #{@signature.get_namespace_path} cServerCall;
  call  sTDR       cTDR;
  [optional]
    call sRPCErrorHandler cErrorHandler;
  entry sUnmarshalerMain  eService;
#{alloc_call_port}};
EOT
    f.close
  end

  #===  �������ؿ������Υ����ɤ�������Ƭ�������������ӽ��ϡ�
  #ct_name:: Symbol    (through �ץ饰������������줿) ���륿����̾ ��Symbol �Ȥ��������Ƥ���ʤ餷����
  def gen_ep_func_body( file, b_singleton, ct_name, global_ct_name, sig_name, ep_name, func_name, func_global_name, func_type, params )

    # unmarshaler ���饹��?
    if ct_name == @unmarshaler_celltype_name.to_sym then
      gen_ep_func_body_unmarshal( file, b_singleton, ct_name, global_ct_name, sig_name, ep_name, func_name, func_global_name, func_type, params )
    else
      gen_ep_func_body_marshal( file, b_singleton, ct_name, global_ct_name, sig_name, ep_name, func_name, func_global_name, func_type, params )
    end
  end

  #===  marshal �����ɤ�����
  def gen_ep_func_body_marshal( file, b_singleton, ct_name, global_ct_name, sig_name, ep_name, func_name, func_global_name, func_type, params )

    b_void = false
    b_ret_er = false

    # �ؿ�������ͤθ��η�������(typedef ����Ƥ�����)
    type = func_type.get_type.get_original_type

    # ����͵����Ѥ��ѿ�����ϡ�void ���δؿ��ǤϽ��Ϥ��ʤ���
    if ! type.is_void? then
      file.print( "\t#{func_type.get_type.get_type_str}\t\tretval_;\n" )
      if func_type.get_type.kind_of?( DefinedType ) && ( func_type.get_type.get_type_str == "ER" || func_type.get_type.get_type_str == "ER_INT" ) then
        b_ret_er = true
      end
    else
      b_void = true
    end

    file.print( "\tER\t\tercd_;\n" )
    file.print( "\tint16_t\tstate_;\n" )

    # �ؿ� ID �������͡�
    func_id = "FUNCID_#{@signature.get_global_name}_#{func_name}".upcase
    fid = @signature.get_id_from_func_name( func_name )
    file.print( "\tint16_t\tfunc_id_ = #{func_id};	/* (id of '#{func_name}') = #{fid}*/\n" )

    # ���󥰥�ȥ�Ǥʤ�����
    if ! b_singleton then

      # singleton �Ǥʤ���� p_cellcb ���������ɤ����
      file.print <<EOT
	#{ct_name}_CB *p_cellcb;

	if( VALID_IDX( idx ) ){
		p_cellcb = GET_CELLCB(idx);
EOT

      # ���顼���֤�����
      if b_ret_er then
        file.print <<EOT
	}else{
		return ERCD( E_RPC, E_ID );
	}
EOT
      else
        file.print <<EOT
	}else{
		/* ���顼���������ɤ򤳤��˵��� */
	}

EOT
      end
    end

    if func_type.has_receive? then
      file.print "	/* initialize receive parameters */\n"
      params.each{ |param|
        if param.get_direction == :RECEIVE then
          file.print "	*#{param.get_name} = 0;\n"
        end
      }
    end

    # channel lock ������
    file.print <<EOT

	/* Channel Lock */
	SET_RPC_STATE( state_, RPCSTATE_CLIENT_GET_SEM );
	if( is_cLockChannel_joined() )
		cLockChannel_wait();
EOT

    # SOP ������
    file.print "	/* SOP������ */\n"
    file.print "	SET_RPC_STATE( state_, RPCSTATE_CLIENT_SEND_SOP );\n"
    file.print "	if( ( ercd_ = cTDR_sendSOP( true ) ) != E_OK )\n"
    file.print "		goto error_reset;\n"

    # func_id ������
    file.print "	/* �ؿ� id ������ */\n"
    file.print "	if( ( ercd_ = cTDR_putInt16( func_id_ ) ) != E_OK )\n"
    file.print "		goto error_reset;\n"

    # p "celltype_name, sig_name, func_name, func_global_name"
    # p "#{ct_name}, #{sig_name}, #{func_name}, #{func_global_name}"

    b_get = false    # marshal �ʤ� put
    b_marshal = true  # marshal

    # in �����������Ϥ����
    if func_type.has_inward? then
      file.print "	/* ���ϰ������� */\n"
      file.print "	SET_RPC_STATE( state_, RPCSTATE_CLIENT_SEND_BODY );\n"
      print_params( params, file, 1, b_marshal, b_get, true, "eClientEntry", func_name )
      print_params( params, file, 1, b_marshal, b_get, false, "eClientEntry", func_name )
    end

    if ! func_type.is_oneway? then
      b_continue = "true"
    else
      b_continue = "false"
    end
    file.print "	/* EOP�����Сʥѥ��åȤ��ݤ������� */\n"
    file.print "	SET_RPC_STATE( state_, RPCSTATE_CLIENT_SEND_EOP );\n"
    file.print "	if( (ercd_=cTDR_sendEOP(#{b_continue})) != E_OK )\n"
    file.print "		goto error_reset;\n\n"

    # send �Υ����ǥ�������
    if func_type.has_send? then
      file.print "	/* dealloc send parameter while executing */\n"
      file.print "	SET_RPC_STATE( state_, RPCSTATE_CLIENT_EXEC );\n"
      dir = :SEND; nest = 1; dealloc_cp = "eClientEntry_#{func_name}"
      dealloc_for_params( params, file, nest, dir, dealloc_cp )
      file.print "\n"
    end

    if ! func_type.is_oneway? then

      file.print "	/* �ѥ��åȤλϤޤ������å� */\n"
      file.print "	SET_RPC_STATE( state_, RPCSTATE_CLIENT_RECV_SOP );\n"
      file.print "	if( (ercd_=cTDR_receiveSOP( true )) != E_OK )\n"
      file.print "		goto error_reset;\n"

      b_get = true     # marshaler �� get
      file.print "	/* ����ͤμ������ */\n"
      print_param( "retval_", func_type.get_type, file, 1, :RETURN, nil, nil, b_get )

      if func_type.has_outward? then
        if b_ret_er then
          indent_level = 2
          file.print "	if( MERCD( retval_ ) != E_RPC ){\n"
        else
          indent_level = 1
        end
        indent = "	" * indent_level

        file.print "#{indent}/* �����ͤμ������ */\n"
        file.print "#{indent}SET_RPC_STATE( state_, RPCSTATE_CLIENT_RECV_BODY );\n"
        print_params( params, file, indent_level, b_marshal, b_get, true, "eClientEntry", func_name )
        print_params( params, file, indent_level, b_marshal, b_get, false, "eClientEntry", func_name )

        if b_ret_er then
          file.print "	}\n"
        end
      end

      file.print "\n	/* �ѥ��åȤν���������å� */\n"
      file.print "	SET_RPC_STATE( state_, RPCSTATE_CLIENT_RECV_EOP );\n"
      file.print "	if( (ercd_=cTDR_receiveEOP(false)) != E_OK )\n"  # b_continue = false
      file.print "		goto error_reset;\n"

    end # ! func_type.is_oneway?

    # channel lock ������
    file.print <<EOT
	/* Channel Unlock */
	SET_RPC_STATE( state_, RPCSTATE_CLIENT_RELEASE_SEM );
	if( is_cLockChannel_joined() )
		cLockChannel_signal();
EOT

    if( b_void == false )then
      # �ƤӸ�������ͤ�꥿����
      file.print( "	return retval_;\n" )
    else
      file.print( "	return;\n" )
    end

    file.print <<EOT

error_reset:
EOT
    # send �Υ����ǥ�������
    if func_type.has_send? then
      file.print "	/* dealloc send parameter */\n"
      file.print "	if( state_ < RPCSTATE_CLIENT_EXEC ){\n"
      dir = :SEND; nest = 2; dealloc_cp = "eClientEntry_#{func_name}"
      dealloc_for_params( params, file, nest, dir, dealloc_cp )
      file.print "	}\n"
    end

    # receive �Υ����ǥ�������
    if func_type.has_receive? then
      file.print( "	/* receive parameter */\n" )
      dir = :RECEIVE; nest = 1; dealloc_cp = "eClientEntry_#{func_name}"
      dealloc_for_params( params, file, nest, dir, dealloc_cp, true )
    end

    file.print <<EOT
	if( MERCD( ercd_ ) != E_RESET )
		(void)cTDR_reset();
EOT

    # channel lock ������
    file.print <<EOT
	/* Channel Unlock */
	if( is_cLockChannel_joined() )
		cLockChannel_signal();

	if( ercd_ != E_OK && is_cErrorHandler_joined() )
		cErrorHandler_errorOccured( func_id_, ercd_, state_ );
EOT

    if( b_ret_er != false )then
      # �ƤӸ�������ͤ�꥿����
      file.print( "	return ERCD( E_RPC, MERCD( ercd_ ) );\n" )
    else
      file.print( "	return;\n" )
    end

  end

  #===  unmarshal �����ɤ�����
  def gen_ep_func_body_unmarshal( file, b_singleton, ct_name, global_ct_name, sig_name, ep_name, func_name, func_global_name, func_type, params )

    b_ret_er = true

    # func_id �����륳���ɤ�����
    file.print <<EOT

	int16_t	func_id_;
	ER		ercd_ = E_OK;
	int16_t	state_;

	#{ct_name}_CB *p_cellcb;

	if( VALID_IDX( idx ) ){
		p_cellcb = GET_CELLCB(idx);
EOT

    if b_ret_er then
        file.print <<EOT
	}else{
		return;
	}
EOT
    else
        file.print <<EOT
	}else{
		/* ���顼���������ɤ򤳤��˵��� */
	}
EOT
    end

    file.print <<EOT

#ifdef RPC_DEBUG
	syslog(LOG_INFO, "Entering RPC service loop" );
#endif

	/* SOP�Υ����å� */
	SET_RPC_STATE( state_, RPCSTATE_SERVER_RECV_SOP );
	if( (ercd_=cTDR_receiveSOP( false )) != E_OK )
		goto error_reset;
	/* func_id �μ��� */
	if( (ercd_=cTDR_getInt16( &func_id_ )) != E_OK )
		goto error_reset;

#ifdef RPC_DEBUG
	syslog(LOG_INFO, "unmarshaler task: func_id: %d", func_id_ );
#endif
	switch( func_id_ ){
EOT

    # signature �˴ޤޤ�� ���٤Ƥδؿ��ˤĤ���
    @signature.get_function_head_array.each { |f|
      f_name = f.get_name
      f_type = f.get_declarator.get_type
      func_id = "FUNCID_#{@signature.get_global_name}_#{f_name}".upcase
      fid = @signature.get_id_from_func_name( f_name )

      file.print "	case #{func_id}:		/* (id of '#{f_name}') = #{fid} */ \n"
      file.print "		ercd_ = tOpaqueUnmarshaler_#{@signature.get_global_name}_#{f_name}( p_cellcb, &state_ );\n"
      file.print "		break;\n"

    } #

    if @PPAllocatorSize then
      ppallocator_dealloc_str = "	/* PPAllocator �Τ��٤Ƥ���� */\n	cPPAllocator_dealloc_all();"
    else
      ppallocator_dealloc_str = ""
    end

    file.print <<EOT
	default:
		syslog(LOG_INFO, "unmarshaler task: ERROR: unknown func_id: %d", func_id_ );
		ercd_ = E_ID;
	};
error_reset:
#{ppallocator_dealloc_str}
	if( MERCD( ercd_ ) != E_RESET )
		(void)cTDR_reset();

	if( ercd_ != E_OK && is_cErrorHandler_joined() ){
		if( (ercd_ = cErrorHandler_errorOccured( func_id_, ercd_, state_ )) != E_OK )
			return ercd_;
	} else {
		return ercd_;
	}
EOT

  end

  #=== PREAMBLE ���Υ���������
  # ����ޡ�����饻�륿���פξ�硢����ޡ������ؿ��Υץ�ȥ��������������
  def gen_preamble file, b_singleton, ct_name, global_name
    if ct_name != @unmarshaler_celltype_name.to_sym then
      return
    end

    # string.h �� include (memset, strlen �Τ���)
    file.print "/* header file (strlen, memset) */\n"
    file.print "#include\t<string.h>\n\n"

    file.print "/* ����ޡ������ؿ��Υץ�ȥ�������� */\n"
    # signature �˴ޤޤ�� ���٤Ƥδؿ��ˤĤ���
    @signature.get_function_head_array.each { |f|
      f_name = f.get_name
      f_type = f.get_declarator.get_type
      id = @signature.get_id_from_func_name( f_name )
      file.print "static ER  tOpaqueUnmarshaler_#{@signature.get_global_name}_#{f_name}(CELLCB *p_cellcb, int16_t *state);\t/* func_id: #{id} */\n"
    }
    file.print "\n"
  end

  #=== POSTAMBLE ���Υ���������
  # ����ޡ�����饻�륿���פξ�硢�ġ��Υ���ޡ������ؿ�������
  def gen_postamble file, b_singleton, ct_name, global_name
    if ct_name != @unmarshaler_celltype_name.to_sym then
      return
    end

    file.print "\n/*** ����ޡ������ؿ� ***/\n\n"
    @signature.get_function_head_array.each { |f|
      f_name = f.get_name
      f_type = f.get_declarator.get_type
      id = @signature.get_id_from_func_name( f_name )

      # �ؿ����֤��ͤ���Ĥ�?
      b_ret_er = false
      init_retval = ""
      if f_type.get_type.is_void? then
        b_void = true
      else
        b_void = false
        if f_type.get_type.get_type_str == "ER" || f_type.get_type.get_type_str == "ER_INT" then
          b_ret_er = true
          init_retval = " = E_OK"
        end
      end

      file.print <<EOT
/*
 * name:    #{f_name}
 * func_id: #{id} 
 */
EOT
      file.print "static ER\n"
      file.print "tOpaqueUnmarshaler_#{@signature.get_global_name}_#{f_name}(CELLCB *p_cellcb, int16_t *state_)\t\t\n"
      file.print "{\n"
      file.print "	ER      ercd_;\n"

      # �����������ѿ������
      param_list = f.get_declarator.get_type.get_paramlist.get_items
           # FuncHead->  Decl->    FuncType->ParamList
      param_list.each{ |par|
        name = par.get_name
        type = par.get_type.get_original_type

        dir = par.get_direction
        if( dir == :RECEIVE )then
          # type �� PtrType �ǡ���������������
          type = type.get_type
        end
        if( dir == :SEND || dir == :RECEIVE )then
          init = " = 0"
        else
          init = ""
        end

        if type.kind_of? ArrayType then
          type = type.get_type
          aster = "(*"
          aster2 = ")"
        else
          aster = ""
          aster2 = ""
        end

        type_str = type.get_type_str.gsub( /\bconst\b */, "" ) # "const" �򳰤�
        file.printf( "	%-12s %s%s%s%s%s;\n", type_str, aster, name, aster2, type.get_type_str_post, init )
      }

      if ! b_void then
        file.printf( "	%-12s retval_%s%s;\n", f_type.get_type.get_type_str, f_type.get_type.get_type_str_post, init_retval )
      end

      # in �����������Ϥ�����
      file.print "\n	/* ���ϰ������� */\n"
      file.print "	SET_RPC_STATE( *state_, RPCSTATE_SERVER_RECV_BODY );\n"
      b_get = true    # unmarshal �Ǥ� get
      b_marshal  = false
      print_params( param_list, file, 1, b_marshal, b_get, true, "cServerCall", f_name )
      print_params( param_list, file, 1, b_marshal, b_get, false, "cServerCall", f_name )

      # �ѥ��åȤμ�����λ
      file.print "	/* �ѥ��åȽ���������å� */\n"
      file.print "	SET_RPC_STATE( *state_, RPCSTATE_SERVER_RECV_EOP );\n"
      if ! f_type.is_oneway? then
        b_continue = "true"
      else
        b_continue = "false"
      end
      file.print "	if( (ercd_=cTDR_receiveEOP(#{b_continue})) != E_OK )\n"
      file.print "		goto error_reset;\n\n"

      # out �Υ���򥢥�����
      dir = :OUT; alloc_cp = "cPPAllocator_alloc"; alloc_cp_extra = nil; nest = 1
      alloc_for_params( param_list, file, nest, dir, alloc_cp, alloc_cp_extra )

      # �оݴؿ���ƽФ�
      file.print "	/* �оݴؿ��θƽФ� */\n"
      file.print "	SET_RPC_STATE( *state_, RPCSTATE_SERVER_EXEC );\n"
      if b_void then
        file.print( "	cServerCall_#{f_name}(" )
      else
        file.print( "	retval_ = cServerCall_#{f_name}(" )
      end

      delim = " "
      param_list.each{ |par|
        file.print delim
        delim = ", "
        if par.get_direction == :RECEIVE then
          file.print "&"
        end
        file.print par.get_name
      }
      file.print( " );\n" )

      # ����͡����ϰ����μ��襳���ɤ�����

      # oneway �ξ����ϡ�����ͤ�̵����������Ԥ��ʤ�����Ʊ���ʸƽФ���
      if ! f.is_oneway? then

        file.print "\n	/* SOP������ */\n"
        file.print "	SET_RPC_STATE( *state_, RPCSTATE_SERVER_SEND_SOP );\n"

        file.print "	if( ( ercd_ = cTDR_sendSOP( false ) ) != E_OK )\n"
        file.print "		goto error_reset;\n"

        b_get = false     # unmarshaler �� put
        if( ! b_void )then
          file.print "	/* ����ͤ����� */\n"
          print_param( "retval_", f_type.get_type, file, 1, :RETURN, nil, nil, b_get )
        end

        if f_type.has_outward? then
          if b_ret_er then
            indent_level = 2
            file.print "	if( MERCD( retval_ ) != E_RPC ){\n"
          else
            indent_level = 1
          end
          indent = "	" * indent_level

          file.print "#{indent}/* �����ͤ����� */\n"
          file.print "#{indent}SET_RPC_STATE( *state_, RPCSTATE_SERVER_SEND_BODY );\n"
          print_params( param_list, file, indent_level, b_marshal, b_get, true, "cServerCall", f_name )
          print_params( param_list, file, indent_level, b_marshal, b_get, false, "cServerCall", f_name )

          # receive �Υ����ǥ�������
          if f_type.has_receive? then
            file.print "#{indent}/* dealloc receive parameter */\n"
            dir = :RECEIVE; dealloc_cp = "cServerCall_#{f_name}"
            dealloc_for_params( param_list, file, indent_level, dir, dealloc_cp )
          end

          if b_ret_er then
            file.print "	}\n"
          end
        end

        file.print "	/* �ѥ��åȤν������ݤ������� */\n"
        file.print "	SET_RPC_STATE( *state_, RPCSTATE_SERVER_SEND_EOP );\n"
        file.print "	if( (ercd_=cTDR_sendEOP(false)) != E_OK )\n"  # b_continue = false
        file.print "		goto error_reset;\n"
      end  # ! f.is_oneway?

      file.print "	return E_OK;\n"
      file.print <<EOT

error_reset:
EOT
      # send �Υꥻ�å��ѥǥ�������
      if f_type.has_send? then
        file.print "	/* dealloc send parameter */\n"
        file.print "	if( *state_ < RPCSTATE_SERVER_EXEC ){\n"
        dir = :SEND; indent_level = 2; dealloc_cp = "cServerCall_#{f_name}"
        dealloc_for_params( param_list, file, indent_level, dir, dealloc_cp, true )
        file.print "	}\n"
      end

      # receive �Υ����ǥ�������
      if f_type.has_receive? && b_ret_er then
        file.print "	/* dealloc receive parameter */\n"
        file.print "	if( MERCD( retval_ ) != E_RPC ){\n"
        dir = :RECEIVE; indent_level = 2; dealloc_cp = "cServerCall_#{f_name}"
        dealloc_for_params( param_list, file, indent_level, dir, dealloc_cp )
        file.print "	}\n"
      end

      file.print "	return ERCD( E_RPC, MERCD( ercd_ ) );\n"
      file.print "}\n\n"

      # �����ʸġ��δؿ��ˤǤϥ��顼�ϥ�ɥ顼�ϸƤӽФ��ʤ����ƤӸ��ʥ����С��Υᥤ��ؿ��ˤǸƤӽФ���
    }
  end
 

  #b_marshal:: bool
  #b_get:: bool
  #  b_marshal = true  && b_get == false   :  �ޡ����������ϰ�������
  #  b_marshal = true  && b_get == true    :  �ޡ������ǽ��ϰ�������
  #  b_marshal = false && b_get == false   :  ����ޡ����������ϰ�������
  #  b_marshal = false && b_get == true    :  ����ޡ������ǽ��ϰ�������
  #b_referenced:: size_is, count_is, string �ǻ��Ȥ���Ƥ����Τ����
  def print_params( params, file, nest, b_marshal, b_get, b_referenced, port_name, func_name )
    params.each{ |param|
# p "#{param.get_name}:  b_marshal: #{b_marshal} b_get: #{b_get}"
      if ! ( b_referenced == param.is_referenced? ) then
        next
      end

      dir = param.get_direction
      if( b_get == false && b_marshal == true || b_get == true && b_marshal == false  )then
        case dir
        when :IN, :INOUT
          alloc_cp = "cPPAllocator_alloc"
          alloc_cp_extra = nil
          print_param( param.get_name, param.get_type, file, nest, dir, nil, nil, b_get, alloc_cp, alloc_cp_extra )
        when :SEND
          alloc_cp = "#{port_name}_#{func_name}_#{param.get_name}_alloc"
          alloc_cp_extra = nil
          print_param( param.get_name, param.get_type, file, nest, dir, nil, nil, b_get, alloc_cp, alloc_cp_extra )
        end
      else
        case dir
        when :OUT, :INOUT
          alloc_cp = nil        # inout �� b_get==true&&b_marsha==true �ΤȤ��������������ɤ�����
          alloc_cp_extra = nil
          print_param( param.get_name, param.get_type, file, nest, dir, nil, nil, b_get, alloc_cp, alloc_cp_extra )
        when :RECEIVE
          alloc_cp = "#{port_name}_#{func_name}_#{param.get_name}_alloc"
          alloc_cp_extra = nil
          if b_get then
            outer = "(*"         # �ޡ������¦�Ǥϡ��ݥ��󥿤� (send �����) ���¿��
            outer2 = ")"
          else
            outer = nil          # ����ޡ������¦�Ǥϡ��ݥ��󥿤���ĳ�����Ƥ���
            outer2 = nil
          end
          type = param.get_type.get_referto
          print_param( param.get_name, type, file, nest, dir, outer, outer2, b_get, alloc_cp, alloc_cp_extra )
        end
      end
    }
  end

  #=== �������������ɤ����� (out �Υ���ޡ��������)
  def alloc_for_params( params, file, nest, dir, alloc_cp, alloc_cp_extra )
    params.each{ |param|
      dir = param.get_direction
      if dir == :OUT then
        alloc_for_param( param.get_name, param.get_type, file, nest, nil, nil, alloc_cp, alloc_cp_extra )
      end
    }
  end

  #=== �������������ɤ����� (out �Υ���ޡ�������Ѹ��̥ѥ�᡼��������)
  def alloc_for_param( name, type, file, nest, outer, outer2, alloc_cp, alloc_cp_extra )
    org_type = type.get_original_type
    case org_type
    when PtrType
      indent = "\t" * nest
      count = type.get_count; size = type.get_size; string = type.get_string
      if count || size || string then
        loop_counter_type = IntType.new(16)   # mikan ���� size_is, count_is �ΰ����η��Ȥ���
        if count then
          len = type.get_count.to_s
        elsif size then
          len = type.get_size.to_s
        elsif string then
          if  type.get_string.instance_of? Expression then
            len = type.get_string.to_s
          else
            raise "unsuscripted string used for out parameter #{name}"
          end
        end

        # size_is �� max ���꤬�����硢length �� max ��Ķ���Ƥ��뤫�����å����륳���ɤ�����
        if org_type.get_max != nil && string == nil then
          file.print "#{indent}if( #{len} > #{type.get_max} ){\t/* GenOpaqueMarshaler max check 2 */\n"
          file.print "#{indent}	ercd_ = E_PAR;\n"
          file.print "#{indent}	goto error_reset;\n"
          file.print "#{indent}}\n"
        end

        file.print <<EOT
#{indent}if((ercd_=#{alloc_cp}(sizeof(#{type.get_type.get_type_str}#{type.get_type.get_type_str_post})*#{len},(void **)&#{outer}#{name}#{outer2}#{alloc_cp_extra}))!=E_OK)\t/* GenOpaqueMarshaler 1 */
#{indent}	goto error_reset;
EOT

        if type.get_type.kind_of? PtrType then
          file.print "#{indent}{\n"
          file.print "#{indent}	#{loop_counter_type.get_type_str}  i__#{nest}, length__#{nest} = #{len};\n"
          file.print "#{indent}	for( i__#{nest} = 0; i__#{nest} < length__#{nest}; i__#{nest}++ ){\n"
          alloc_for_param( name, type.get_type, file, nest + 2, outer, "#{outer2}[i__#{nest}]", alloc_cp, alloc_cp_extra )
          file.print "#{indent}	}\n"
          file.print "#{indent}}\n"
        end

      else
        file.print <<EOT
#{indent}if((ercd_=#{alloc_cp}(sizeof(#{type.get_type.get_type_str}#{type.get_type.get_type_str_post}),(void **)&#{outer}#{name}#{outer2}#{alloc_cp_extra}))!=E_OK)\t/* GenOpaqueMarshaler 2 */
#{indent}	goto error_reset;
EOT
      end
    end
  end

  #=== �����ΰ��ǥ������ȥ����ɤ�����
  # send���ޡ������κǸ塢receive������ޡ������κǸ�ǰ�礷�ư�����ǥ������Ȥ���
  def dealloc_for_params( params, file, nest, dir, dealloc_cp, b_reset = false )
    if b_reset then
      reset_str = "_reset"
    else
      reset_str = ""
    end

    params.each{ |param|
      if dir == param.get_direction then
        indent = "\t" * nest
        type = param.get_type.get_original_type
        aster = ""
        if dir == :RECEIVE then
          type = type.get_type.get_original_type   # �ݥ��󥿤��ĳ���
          if b_reset then
            aster = "*"
          end
        end
        count = type.get_count; size = type.get_size
        if (size || count) && type.get_type.has_pointer? then
          if count then
            len = ", #{type.get_count.to_s}"
          elsif size then
            len = ", #{type.get_size.to_s}"
          end
        else
          len = ""
        end
        cp = "#{dealloc_cp}_#{param.get_name}_dealloc#{reset_str}".upcase
        file.print "#{indent}#{cp}(#{aster}#{param.get_name}#{len});\n"
      end
    }
  end

end
