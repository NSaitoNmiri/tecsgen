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
#   $Id: componentobj.rb 1975 2013-06-16 07:34:59Z okuma-top $
#++

# STAGE:
# ���Υ��ƥʥ󥹾����Ϥ�����ʤ�
#  B    bnf.y.rb ����ƽФ����
#  P    parse �ʳ��ǸƽФ�����bnf.y.rb ����ľ�ܸƽФ����櫓�ǤϤʤ�������ʸ��������Ԥ���
#  S    P ���椫��ƽФ���뤬����ʸ����������櫓�ǤϤʤ���̣�����å�����
#  G    �����������ʤ����ʳ��ǡ���ʸ�ڤϴ����Ǥ��롥�Դ����ʤ饨�顼���Ǥ������Ƥ����
#                                                   factory �������� "format" �θ��ΰ���

# mikan �ʲ��� ruby �� mix in �Ǽ¸��Ǥ��뤫�⤷��ʤ�
# Nestable ��Ѿ�������硢���饹�ѿ��� Nestable �Τ�Τ���ͭ�������̤ˤ������ä���
# class Nestable
#   @@nest_stack_index = -1
#   @@nest_stack = []
#   @@current_object = nil
# 
#   def self.push
#     @@nest_stack_index += 1
#     @@nest_stack[ @nest_stack_index ] = @@current_object
#     @@current_object = nil
#   end
# 
#   def pop
#     @@current_object = @@nest_stack[ @@nest_stack_index ]
#     @nest_stack_index -= 1
#     if @@nest_stack_index < -1 then
#       raise TooManyRestore
#     end
#   end
# end
#

class Signature < NSBDNode  # < Nestable
#  @name:: Symbol
#  @global_name:: Symbol
#  @function_head_list:: NamedList : FuncHead �Υ��󥹥��󥹤�����
#  @func_name_to_id::  {String}  :  �ؿ�̾��ź���Ȥ�������� id �򵭲����롥id �� signature �νи����� (1����Ϥޤ�)
#  @context:: string : ����ƥ�����̾
#  @b_deviate:: bool: deviate : ��æ��pointer level mismatch ��Ф��ʤ���
#  @b_checked_as_allocator_signature:: bool:  �������������˥���Ȥ��ƥ����å��Ѥ�

  @@nest_stack_index = -1
  @@nest_stack = []
  @@current_object = nil

  def self.push
    @@nest_stack_index += 1
    @@nest_stack[ @@nest_stack_index ] = @@current_object
    @@current_object = nil
  end

  def self.pop
    @@current_object = @@nest_stack[ @@nest_stack_index ]
    @@nest_stack_index -= 1
    if @@nest_stack_index < -1 then
      raise "TooManyRestore"
    end
  end

  # STAGE: P
  # ���Υ᥽�åɤ� parse ��Τ߸ƤӽФ����
  def self.get_current
    @@current_object
  end

  #
  # STAGE: B
  def initialize( name )
    super()
    @name = name
    Namespace.new_signature( self )
    set_namespace_path # @NamespacePath ������
    if "#{Namespace.get_global_name}" == "" then
      @global_name = @name
    else
      @global_name = :"#{Namespace.get_global_name}_#{@name}"
    end

    @func_name_to_id = {}
    @context = nil
    @b_deviate = false
    @b_checked_as_allocator_signature = false
    @@current_object = self
    set_specifier_list( Generator.get_statement_specifier )
  end

  #
  # STAGE: B
  def end_of_parse( function_head_list )
    @function_head_list = function_head_list

    # id ����դ���
    id = 1
    function_head_list.get_items.each{ |f|
      @func_name_to_id[ f.get_name ] = id
      id += 1
    }

    @@current_object = nil
    return self
  end

  #=== Signature# signature �λ���Ҥ�����
  # STAGE: B
  #spec_list::      [ [ :CONTEXT,  String ], ... ]
  #                     s[0]        s[1]
  def set_specifier_list( spec_list )
    return if spec_list == nil  # ���ʤ�в��⤷�ʤ�

    spec_list.each { |s|
      case s[0]     # statement_specifier
      when :CONTEXT         # [context("non-task")] etc
        if @context then
          cdl_error( "S1001 context specifier duplicate"  )
        end
        # @context = s[1].gsub( /\A\"(.*)\"$/, "\\1" )
        @context = CDLString.remove_dquote s[1]
        case @context
        when "non-task", "task", "any"
        else
          cdl_warning( "W1001 \'$1\': unknown context type. usually specifiy task, non-task or any" , @context )
        end
      when :DEVIATE
        @b_deviate = true
      else
        cdl_error( "S1002 \'$1\': unknown specifier for signature" , s[0] )
      end
    }
  end

  def get_name
    @name
  end

  def get_global_name
    @global_name
  end

  def get_function_head_array
    if @function_head_list then
      return @function_head_list.get_items
    else
      return nil
    end
  end

  def get_function_head( func_name )
    return @function_head_list.get_item( func_name.to_sym )
  end

  #=== Signature# �ؿ�̾���� signature ��� id ������
  def get_id_from_func_name func_name
    @func_name_to_id[ func_name ]
  end

  #=== Signature# context ������
  # context ʸ������֤� "task", "non-task", "any"
  # ̤������Υǥե���ȤȤ��� task ���֤�
  def get_context
    if @context then
      return @context
    else
      return "task"
    end
  end

  #=== Signature# signaure �Τ��٤Ƥδؿ��Τ��٤ƤΥѥ�᡼���򤿤ɤ�
  #block:: �֥�å�������˼��
  # �֥�å���2�Ĥΰ�����������  Decl, ParamDecl     ( Decl: �ؿ��إå� )
  # Port ���饹�ˤ� each_param �������Ʊ��Ư����
  def each_param # �֥�å����� { |func_decl, param_decl| }
    fha = get_function_head_array                       # �ƤӸ��ޤ��ϼ������Υ����˥���δؿ�����
    return if fha == nil                                # nil �ʤ�ʸˡ���顼��ͭ���ͤ����ꤵ��ʤ��ä�

    pr = Proc.new   # ���Υ᥽�åɤΥ֥�å������� pr ������
    fha.each{ |fh|  # fh: FuncHead                      # �ؿ�������γƴؿ�Ƭ��
      fd = fh.get_declarator                            # fd: Decl  (�ؿ�Ƭ������Declarotor������)
      if fd.is_function? then                           # fd ���ؿ��Ǥʤ���С����Ǥ˥��顼
        fd.get_type.get_paramlist.get_items.each{ |par| # ���٤ƤΥѥ�᡼���ˤĤ���
          pr.call( fd, par )
        }
      end
    }
  end

  #=== Signature# �����ʥ������� �����˥��㤫�ƥ��Ȥ���
  # alloc, dealloc �ؿ�����Ĥ��ɤ������������������줾�졢�������ݥ��󥿡���������������ݥ��󥿤ؤΥݥ��󥿡��ʤ�
  def is_allocator?

    # �����������å�����
    if @b_checked_as_allocator_signature == true then
      return true
    end
    @b_checked_as_allocator_signature = true

    fha = get_function_head_array                       # �ƤӸ��ޤ��ϼ������Υ����˥���δؿ�����
    if fha == nil then                                  # nil �ʤ�ʸˡ���顼��ͭ���ͤ����ꤵ��ʤ��ä�
      return false
    end

    found_alloc = false; found_dealloc = false
    fha.each{ |fh|  # fh: FuncHead                      # �ؿ�������γƴؿ�Ƭ��
      fd = fh.get_declarator                            # fd: Decl  (�ؿ�Ƭ������Declarotor������)
      if fd.is_function? then                           # fd ���ؿ��Ǥʤ���С����Ǥ˥��顼
        func_name = fd.get_name.to_sym 
        if func_name == :alloc then
          found_alloc = true
          params = fd.get_type.get_paramlist.get_items
          if params then
            if ! params[0].instance_of?( ParamDecl ) ||
                ! params[0].get_type.get_original_type.kind_of?( IntType ) ||
                params[0].get_direction != :IN then
              # �������� int ���Ǥʤ�
              if ! params[0].instance_of?( ParamDecl ) ||
                  ! params[0].get_type.kind_of?( PtrType ) ||
                  ! params[0].get_type.get_type.kind_of?( PtrType ) ||
                  params[0].get_type.get_type.get_type.kind_of?( PtrType ) ||
                  params[0].get_direction != :OUT then
                # ���������ݥ��󥿷��Ǥ�ʤ�
                cdl_error3( @locale, "S1003 $1: \'alloc\' 1st parameter neither [in] integer type nor [out] double pointer type", @name )
              end
            elsif ! params[1].instance_of?( ParamDecl ) ||
                ! params[1].get_type.kind_of?( PtrType ) ||
                ! params[1].get_type.get_type.kind_of?( PtrType ) ||
                params[1].get_type.get_type.get_type.kind_of?( PtrType ) ||
                params[0].get_direction != :IN then
              # (��������������) ����������ݥ��󥿤Ǥʤ�
              cdl_error3( @locale, "S1004 $1: \'alloc\' 2nd parameter not [in] double pointer" , @name )
            end
          else
            cdl_error3( @locale, "S1005 $1: \'alloc\' has no parameter, unsuitable for allocator signature" , @name )
          end
        elsif func_name == :dealloc then
          found_dealloc = true
          params = fd.get_type.get_paramlist.get_items
          if params then
            if ! params[0].instance_of?( ParamDecl ) ||
                ! params[0].get_type.kind_of?( PtrType ) ||
                params[0].get_type.get_type.kind_of?( PtrType ) ||
                params[0].get_direction != :IN then
              cdl_error3( @locale, "S1006 $1: \'dealloc\' 1st parameter not [in] pointer type" , @name )
#            elsif params[1] != nil then    # ����������ϥ����å����ʤ�
#              cdl_error3( @locale, "S1007 Error message is changed to empty" )
#                 cdl_error3( @locale, "S1007 $1: \'dealloc\' cannot has 2nd parameter" , @name )
            end
          else
            cdl_error3( @locale, "S1008 $1: \'dealloc\' has no parameter, unsuitable for allocator signature" , @name )
          end
        end
        if found_alloc && found_dealloc then
          return true
        end
      end
    }
    if ! found_alloc then
      cdl_error3( @locale, "S1009 $1: \'alloc\' function not found, unsuitable for allocator signature" , @name )
    end
    if ! found_dealloc then
      cdl_error3( @locale, "S1010 $1: \'dealloc\' function not found, unsuitable for allocator signature" , @name )
    end
    return false
  end

  #=== Signature# ��æ����
  # ����� deviate �����ꤵ��Ƥ���� true 
  def is_deviate?
    @b_deviate
  end

  #=== Signature# Push Pop Allocator ��ɬ�פ���
  # Transparent RPC �ξ�� oneway ���� in ������(size_is, count_is, string �Τ����줫�ǽ����ˤ�����
  def need_PPAllocator?( b_opaque = false )
    fha = get_function_head_array                       # �ƤӸ��ޤ��ϼ������Υ����˥���δؿ�����
    fha.each{ |fh|
      fd = fh.get_declarator
      if fd.get_type.need_PPAllocator?( b_opaque ) then
        # p "#{fd.get_name} need_PPAllocator: true"
        @b_need_PPAllocator = true
        return true
      end
      # p "#{fd.get_name} need_PPAllocator: false"
    }
    return false
  end

  def show_tree( indent )
    indent.times { print "  " }
    puts "Signature: name: #{@name} context: #{@context} deviate : #{@b_deviate} PPAllocator: #{@b_PPAllocator} #{self}"
    (indent+1).times { print "  " }
    puts "namespace_path: #{@NamespacePath}"
    (indent+1).times { print "  " }
    puts "function head list:"
    @function_head_list.show_tree( indent + 2 )
  end

end

class Celltype < NSBDNode # < Nestable
# @name:: Symbol
# @global_name:: Symbol
# @name_list:: NamedList item: Decl (attribute, var), Port
# @port:: Port[]
# @attribute:: Decl[]
# @var:: Decl[]
# @require:: [[cp_name,Celltype|Cell,Port],...]
# @factory_list::   Factory[]
# @ct_factory_list::    Factory[] :    celltype factory
# @cell_list:: Cell[] : ����Τ� (V1.0.0.2 �ʹ�)
# @singleton:: bool
# @idx_is_id:: bool
# @active:: bool
# @b_reuse:: bool :  reuse ���ꤵ��� import ���줿(template ����)
# @generate:: [ Symbol, String, Plugin ]  = [ PluginName, option, Plugin ] Plugin ����������ɲä����
#
# @n_attribute_ro:: int >= 0    none specified
# @n_attribute_rw:: int >= 0    # of [rw] specified cells (obsolete)
# @n_attribute_omit : int >= 0  # of [omit] specified cells
# @n_var:: int >= 0
# @n_var_size_is:: int >= 0     # of [size_is] specified cells # mikan count_is
# @n_var_omit:: int >= 0        # of [omit] specified  cells # mikan var �� omit ��ͭ��
# @n_call_port:: int >= 0
# @n_call_port_array:: int >= 0
# @n_call_port_omitted_in_CB:: int >= 0   ��Ŭ���Ǿ�ά�����ƤӸ�
# @n_entry_port:: int >= 0
# @n_entry_port_array:: int >= 0
# @n_entry_port_inline:: int >= 0
# @n_cell_gen:: int >= 0  �������륻��ο���������������Ƭ�ǻ��Ф��롥��̣�����ʳ��Ǥϻ����Բ�
# @id_base:: Integer : cell �� ID �κǾ���(�����ͤ� @id_base + @n_cell)
#
# @b_cp_optimized:: bool : �ƤӸ���Ŭ���»�
# @plugin:: PluginObject      ���Υ��륿���פ��ץ饰����ˤ���������줿 CDL �����������줿����ͭ����
#                              generate �λ���� @generate �˥ץ饰�����ݻ������
#
# @included_header:: Hash :  include ���줿�إå��ե�����

  include PluginModule

  @@nest_stack_index = -1
  @@nest_stack = []
  @@current_object = nil

  def self.push
    @@nest_stack_index += 1
    @@nest_stack[ @@nest_stack_index ] = @@current_object
    @@current_object = nil
  end

  def self.pop
    @@current_object = @@nest_stack[ @@nest_stack_index ]
    @@nest_stack_index -= 1
    if @@nest_stack_index < -1 then
      raise "TooManyRestore"
    end
  end

  def initialize( name )
    super()
    @@current_object = self
    @name = name
    if "#{Namespace.get_global_name}" != "" then
      @global_name = :"#{Namespace.get_global_name}_#{@name}"
    else
      @global_name = name
    end

    @name_list = NamedList.new( nil, "symbol in celltype #{name}" )
    @port = []
    @attribute = []
    @var = []
    @require = []
    @factory_list = []
    @ct_factory_list = []
    @cell_list = []
    @singleton = false
    @active = false
    @generate = nil

    @n_attribute_ro = 0
    @n_attribute_rw = 0
    @n_attribute_omit = 0
    @n_var = 0
    @n_var_omit = 0
    @n_var_size_is = 0
    @n_call_port = 0
    @n_call_port_array = 0
    @n_call_port_omitted_in_CB = 0
    @n_entry_port = 0
    @n_entry_port_array = 0
    @n_entry_port_array_ns = 0
    @n_entry_port_inline = 0
    @n_cell_gen = 0

    @b_cp_optimized = false

    @plugin = Generator.get_plugin
      # plugin �ξ�� PluginObject ���֤����
    # ���� Generator ����ƽФ��줿 Generator ����ǥѡ�������Ӱ�̣�����å�����Ƥ���

    # if @plugin then
    #  # plugin ��������륻�륿���פϺ����ѤǤϤʤ�   #833 �Զ�罤��
    #  @b_reuse = false
    # else
      @b_reuse = Generator.is_reuse?
    # end

    if $idx_is_id then
      @idx_is_id = true
    else
      @idx_is_id = false
    end

    Namespace.new_celltype( self )
    set_namespace_path # @NamespacePath ������
    set_specifier_list( Generator.get_statement_specifier )

    @included_header = {}
  end

  def get_name
    @name
  end

  # Cell# end_of_parse
  def end_of_parse
    # °�����ѿ��Υ����å�
    check_attribute

    # ���������ƤӸ�����������
    generate_allocator_port

    # ��졼����������������������������
    @port.each { |p|
      p.set_allocator_instance
    }

    if @n_entry_port == 0 && @active == false && @factory_list.length == 0 &&
        ( @singleton && @ct_factory_list.length == 0 || ! @singleton )then
      cdl_warning( "W1002 $1: non-active celltype has no entry port & factory" , @name )
    end

    if @generate then
      celltype_plugin
    end

    @@current_object = nil
  end

  def self.new_port( port )
    @@current_object.new_port( port )
  end

  def new_port( port )
    port.set_owner self
    @port << port
    @name_list.add_item( port )
    if port.get_port_type == :CALL then
      @n_call_port += 1
      @n_call_port_array += 1 if port.get_array_size != nil
    else
      @n_entry_port += 1
      @n_entry_port_array += 1 if port.get_array_size != nil
      @n_entry_port_array_ns += 1 if port.get_array_size == "[]"
      @n_entry_port_inline += 1 if port.is_inline?
    end
    port.set_celltype self
  end

  def get_port_list
    @port
  end

  def self.new_attribute( attribute )
    @@current_object.new_attribute( attribute )
  end

  #=== Celltype# new_attribute for Celltype
  #attribute:: [Decl]
  def new_attribute( attribute )
    @attribute += attribute
    attribute.each { |a|
      a.set_owner self
      @name_list.add_item( a )
      if( a.is_omit? )then
        @n_attribute_omit += 1
      elsif( a.is_rw? )then
        @n_attribute_rw += 1
      else
        @n_attribute_ro += 1
      end
      if a.get_initializer then
        # ��Ͽ��˥����å����Ƥ�����ʤ���attr �򻲾ȤǤ��ʤ��Τǡ����ʻ��Ȥ��ʤ���
        a.get_type.check_init( @locale, a.get_identifier, a.get_initializer, :ATTRIBUTE )
      end
    }
  end

  #=== Celltype# celltype �� attribute/var �Υ����å�
  # STAGE:  S
  #
  # ���Υ᥽�åɤ� celltype �Υѡ�������λ���������ǸƽФ���롥
  def check_attribute
    # attribute �� size_is ���꤬�����������å�
    (@attribute+@var).each{ |a|
      if a.get_size_is then
        if ! a.get_type.kind_of?( PtrType ) then
          # size_is ���ݥ��󥿷��ʳ��˻��ꤵ�줿
          cdl_error( "S1011 $1: size_is specified for non-pointer type" , a.get_identifier )
        else

          # ���Ȥ����ѿ���¸�ߤ����׻���ǽ�ʷ��������å�����
          size = a.get_size_is.eval_const( @name_list )  # C_EXP �β�ǽ������
          init = a.get_initializer
          if init then
            if ! init.instance_of?( Array ) then
              # ������Ҥ�����ǤϤʤ�
              cdl_error( "S1012 $1: unsuitable initializer, need array initializer" , a.get_identifier )
            elsif size.kind_of?( Integer ) && size < init.length then
              # size_is ���ꤵ�줿�Ŀ����������Ҥ��������Ǥ�¿��
              cdl_error( "S1013 $1: too many initializer, $2 for $3" , a.get_identifier, init.length, size )
            # elsif a.get_size_is.eval_const( nil ) == nil  # C_EXP �β�ǽ������
            end

          end
        end
      else
        if a.get_type.kind_of?( PtrType ) then
          if a.get_initializer.instance_of?( Array ) ||
              ( a.get_initializer.instance_of?( Expression ) &&
                a.get_initializer.eval_const2(@name_list).instance_of?( Array ) ) then
            # size_is ���ꤵ��Ƥ��ʤ��ݥ��󥿤� Array �ǽ��������Ƥ����顢���顼
            cdl_error( "S9999 $1: non-size_is pointer cannot be initialized with array initializer" , a.get_identifier )
          end
        end
      end
    }
  end

  def get_attribute_list
    @attribute
  end

  #=== Celltype# ���������ƤӸ�������
  #    send, receive �����Υ���������ƽФ�����θƤӸ�������
  def generate_allocator_port
    @port.each { |port|
      # �ݡ��ȤΤ��٤ƤΥѥ�᡼����é��
      port.each_param { |port, fd, par|
        case par.get_direction                        # ��������������� (in, out, inout, send, receive )
        when :SEND, :RECEIVE
          if par.get_allocator then
            cp_name = :"#{port.get_name}_#{fd.get_name}_#{par.get_name}"     # ���������ƤӸ���̾��
            #           �ݡ���̾          �ؿ�̾         �ѥ�᡼��̾
            # alloc_sig_path = [ par.get_allocator.get_name ]  # mikan Namespace ���������ƤӸ��Υ����˥��� #1
            alloc_sig_path = par.get_allocator.get_namespace_path
            array_size = port.get_array_size            # �ƤӸ��ޤ��ϼ���������Υ�����
            created_port = Port.new( cp_name, alloc_sig_path, :CALL, array_size ) # �ƤӸ�������
            created_port.set_allocator_port( port, fd, par )
            if port.is_optional? then
              created_port.set_optional
            end
            new_port( created_port )                    # ���륿���פ˿������ƤӸ����ɲ�
          # else
          #  already error "not found or not signature" in class ParamDecl
          end
        end
      }
    }
  end

  def get_name_list
    @name_list
  end

  def self.new_var( var )
    @@current_object.new_var( var )
  end

  #=== Celltype# �����������ѿ�
  #var:: [Decl]
  def new_var( var )
    @var += var
    var.each { |i|     # i: Decl
      i.set_owner self
      if i.is_omit? then
        @n_var_omit += 1
      else
        @n_var += 1
      end
      @name_list.add_item( i )

      # size_is ���ꤵ�줿����? mikan  count_is
      if i.get_size_is then
        @n_var_size_is += 1
      end

      if i.get_initializer then
        i.get_type.check_init( @locale, i.get_identifier, i.get_initializer, :VAR, @name_list )
      end
    }
  end

  def get_var_list
    @var
  end

  #=== Celltype# celltype �λ���Ҥ�����
  def set_specifier_list( spec_list )
    return if spec_list == nil

    spec_list.each { |s|
      case s[0]
      when :SINGLETON
        @singleton = true
      when :IDX_IS_ID
        @idx_is_id = true
      when :ACTIVE
        @active = true
      when :GENERATE
        if @generate then
          cdl_error( "S1014 generate specifier duplicate"  )
        end
        @generate = [ s[1], s[2] ] # [ PluginName, "option" ]
      else
        cdl_error( "S1015 $1 cannot be specified for composite" , s[0] )
      end
    }
  end

  #
  def self.new_require( ct_or_cell_nsp, ep_name, cp_name = nil )
    @@current_object.new_require( ct_or_cell_nsp, ep_name.to_sym, cp_name )
  end

  def new_require( ct_or_cell_nsp, ep_name, cp_name )
    # Require: set_owner �����Τ��ʤ�
    obj = Namespace.find( ct_or_cell_nsp )    #1
    if obj.instance_of? Celltype then
      # Celltype ̾�ǻ���
      ct = obj
    elsif obj.instance_of? Cell then
      # Cell ̾�ǻ���
      ct = obj.get_celltype
    elsif obj == nil then
      cdl_error( "S1016 $1 not found" , ct_or_cell_nsp.get_path_str )
      return
    else
      cdl_error( "S1017 $1 : neither celltype nor cell" , ct_or_cell_nsp.get_path_str )
      return
    end

    if( ! ct.is_singleton? ) then
      # ���󥰥�ȥ�ǤϤʤ�
      cdl_error( "S1018 $1 : not singleton cell" , obj.get_name )
    end

    # ��������õ��
    obj2 = ct.find( ep_name )
    if( ( ! obj2.instance_of? Port ) || obj2.get_port_type != :ENTRY ) then
      cdl_error( "S1019 \'$1\' : not entry port" , ep_name )
      return
    elsif obj2.get_array_size then
      cdl_error( "S1020 \'$1\' : required port cannot be array" , ep_name )
      return
    end

    if obj2.get_signature == nil then
      # signature ��̤��������˥��顼
      return
    end

    require_call_port_prefix = :_require_call_port
    if cp_name == nil then
      # �ؿ�̾��ʣ�����å�
      @require.each{ |req|
        unless req[0].to_s =~ /^#{require_call_port_prefix}/ then
          next     # ̾������� require �ϴؿ�̾��ʣ�����å����ʤ�
        end
        port = req[2]
        if port.get_signature == obj2.get_signature then
          # Ʊ�� signature �ʤ��٤�Ʊ���ؿ�̾����ġ˸��̤˽Ф��ΤǤϤʤ����ޤȤ�ƥ��顼�Ȥ���
          cdl_error( "S1021 $1 : require cannot have same signature with \'$2\'" , obj2.get_name, port.get_name )
          next
        end
        port.get_signature.get_function_head_array.each{ |f|
          # mikan �����ϡ�namedList ����θ����ˤʤ�ʤ��Ρ��ʸ�Ψ��������
          obj2.get_signature.get_function_head_array.each{ |f2|
            if( f.get_name == f2.get_name ) then
              cdl_error( "S1022 $1.$2 : \'$3\' conflict function name in $4.$5" , obj.get_name, obj2.get_name, f.get_name, req[1].get_name, req[2].get_name )
            end
          }
        }
      }
    end

    if cp_name == nil then
      b_has_name = false
      cp_name = :"#{require_call_port_prefix}_#{ct.get_name}_#{obj2.get_name}"
    else
      b_has_name = true
    end
    # require ���ɲ�
    @require << [ cp_name, obj, obj2 ]  # [ lhs:cp_name, rhs:Celltype, rhs:Port ]

    # require port ���ɲ� (�ƤӸ��Ȥ����ɲä��롣������ require �򥻥åȤ��Ƥ���)
    port = Port.new( cp_name, obj2.get_signature.get_namespace_path, :CALL )
    port.set_require( b_has_name )
    self.new_port port
  end

  def self.new_factory( factory )
    @@current_object.new_factory( factory )
  end

  def new_factory( factory )
    factory.set_owner self
    if factory.get_f_celltype then
      @ct_factory_list << factory
    else
      @factory_list << factory
    end

    factory.check_arg( self )

  end

  #=== Celltype# ���륿���ץץ饰���� (generate �����)
  def celltype_plugin

    load_plugin( @generate[0], CelltypePlugin )

    plugin_name = @generate[0]
    option = @generate[1]
    plugin_object = nil
    eval_str = "plugin_object = #{plugin_name}.new( self, option )"
    if $verbose then
      print "new celltype : #{eval_str}\n"
    end

    begin
      eval( eval_str )     # plugin ������
      plugin_object.set_locale @locale
      @generate[ 2 ] = plugin_object
      generate_and_parse plugin_object
    rescue Exception => evar
      cdl_error( "S1023 $1: fail to new" , plugin_name )
      print "eval( #{eval_str} )\n"

      print_exception( evar )
    end
  end

  #=== Celltype# celltype �˿����� cell ���ɲ�
  #cell:: Cell
  # ����������򥻥륿���פ��ɲá�
  # ����ι�ʸ���κǸ�Ǥ��Υ᥽�ɤ�ƽФ���롥
  # ���󥰥�ȥ󥻥뤬Ʊ�� linkunit ��ʣ���ʤ��������å�
  def new_cell( cell )
    # Celltype �Ǥ� Cell �� set_owner ���ʤ�
    # ���󥰥�ȥ�ǡ��ץ�ȥ���������Ǥʤ���硢�����������оݥ꡼�����ξ��
    if @singleton  then
      @cell_list.each{ |c|
        if c.get_region.get_link_root == cell.get_region.get_link_root then
          cdl_error( "S1024 $1: multiple cell for singleton celltype" , @name )
        end
      }
    end
    @cell_list << cell
    if @plugin then
      @plugin.new_cell cell
    end
  end

  #=== Celltype# ���륿���פ� INIB ����Ĥ���
  # ���륿���פ� INIB ����Ĥ��ɤ�����Ƚ�ꤹ��
  # $rom == false �ΤȤ�:  INIB ������ʤ��� �ʤ��٤Ƥ� CB ���֤�����
  # $rom == true �ΤȤ���INIB ���֤�����Τ���ĤǤ�¸�ߤ���� INIB �����
  #   INIB ���֤�����Τ�
  #     attribute (omit �Τ�ΤϽ����������ͤǤ� rw �Τ�ΤϤʤ�)
  #     size_is ��ȼ�� var
  #     �ƤӸ��ʤ���������Ŭ�������פȤʤ��ΤϽ�����
  def has_INIB?
    return $rom && (@n_attribute_ro > 0 || @n_var_size_is > 0 || ( @n_call_port - @n_call_port_omitted_in_CB ) > 0 || @n_entry_port_array_ns > 0)
#    return $rom && (@n_attribute_ro > 0 || ( @n_call_port - @n_call_port_omitted_in_CB ) > 0)
  end

  #=== Celltype# ���륿���פ� CB ����Ĥ���
  # $rom == true �ΤȤ��������Τ�Τ��֤���롥�����ΰ�ĤǤ�¸�ߤ���� CB �����
  #   size_is �����ꤵ��Ƥ��ʤ� var
  #   rw ���ꤵ�줿 attribute (�����ͤǤ�¸�ߤ��ʤ�)
  # $rom == false �ΤȤ��������Τ�Τ��֤���롥�����ΰ�ĤǤ�¸�ߤ���� CB �����
  #   attribute
  #   var
  #   �ƤӸ��ʤ���������Ŭ�������פȤʤ��ΤϽ�����
  def has_CB?
    if $rom then
      return @n_attribute_rw > 0 || (@n_var-@n_var_size_is) > 0
      # return @n_attribute_rw > 0 || @n_var > 0
    else
      return @n_attribute_rw > 0 || @n_attribute_ro > 0 || @n_var > 0 || (@n_call_port-@n_call_port_omitted_in_CB) > 0 || @n_entry_port_array_ns > 0
    end
  end

  #=== Celltype# ��require �η�����������
  def create_reverse_require_join cell
    @port.each{ |p|
      p.create_reverse_require_join cell
    }
  end

  #=== Celltype# singleton ���������
  #region:: Region   : singleton ��õ�� Region
  # ��Υ���Ǥ�ᤤ��Τ��֤�
  # mikan ������ region ���ϰϤ� singleton ��õ��ɬ�פ�����
  def get_singleton_cell region
    cell = nil
    dist = 999999999 # mikan �����͡ʤ���Ͻ�ʬ������ۤɥǥ�������
    # require: celltype �ǻ���
    @cell_list.each{ |c|
      # ��ã��ǽ�ǺǤ�ᤤ�����õ����ʣ���� singleton �����뤫�⤷��ʤ���
      d = region.distance( c.get_region )
      #debug
      dbgPrint "distance #{d} from #{region.get_name} to #{c.get_name} in #{c.get_region.get_name}\n"
      if d != nil then
        if d < dist then
          cell = c
          dist = d
        end
      end
    }
    return cell
  end

  def find( name )
    @name_list.get_item( name )
  end

  #=== Celltype# ���륿���ץץ饰���������
  def get_celltype_plugin
    if @generate then
      return @generate[2]
    end
  end

  def get_global_name
    @global_name
  end

  def is_singleton?
    @singleton
  end

  def is_active?
    @active
  end

  #=== Celltype# �����ƥ��֤ǤϤʤ���
  # ���Υ᥽�åɤǤ� active ��¾�� factory (singleton �ˤ����Ƥ� FACTORY��ޤ�)���ʤ���� inactive �Ȥ���
  def is_inactive?
    if @active == false && @factory_list.length == 0 &&
        ( @singleton && @ct_factory_list.length == 0 || ! @singleton )then
      return true
    end
    return false
  end

  def get_id_base
    @id_base
  end

  def get_plugin
    @plugin
  end

  def get_require
    @require
  end

  #=== Celltype# ��������������ɬ�פ����뤫Ƚ��
  # ����θĿ��� 0 �ʤ饻�륿���ץ����ɤ���������
  def need_generate?
    @n_cell_gen > 0
  end

  #=== Celltype# require �ƤӸ��η���Ԥ�
  # ���륿���פ� require �ƤӸ��ˤĤ��ơ�����Ԥ�
  # ���뤬��������ʤ��������å���Ԥ�
  def set_require_join
    @require.each{ |req|
      cp_name = req[0]
      cell_or_ct = req[1]
      port = req[2]
      @cell_list.each{ |c|
        c.set_require_join( cp_name, cell_or_ct, port )
      }
    }
  end

  def get_cell_list
    @cell_list
  end

  #=== Celltype# inline �����������ʤ�����
  # ��������̵����硢���٤Ƥμ������� inline �ȤϤ��ʤ�
  def is_all_entry_inline?
    @n_entry_port == @n_entry_port_inline && @n_entry_port > 0
  end

  def show_tree( indent )
    indent.times { print "  " }
    puts "Celltype: name=#{@name} global_name=#{@global_name}"  
    (indent+1).times { print "  " }
    puts "active=#{@active}, singleton=#{@singleton}, idx_is_id=#{@idx_is_id} plugin=#{@plugin.class} reuse=#{@b_reuse}"
    (indent+1).times { print "  " }
    puts "namespace_path: #{@NamespacePath}"
    (indent+1).times { print "  " }
    puts "port:"
    @port.each { |i| i.show_tree( indent + 2 ) }
    (indent+1).times { print "  " }
    puts "attribute:"
    @attribute.each { |i| i.show_tree( indent + 2 ) }
    (indent+1).times { print "  " }
    puts "var:"
    @var.each { |i| i.show_tree( indent + 2 ) }
#    (indent+1).times { print "  " }
#    puts "require:"   mikan
#    @require.each { |i| i.show_tree( indent + 2 ) }
    (indent+1).times { print "  " }
    puts "factory:"
    @factory_list.each { |i| i.show_tree( indent + 2 ) }
    (indent+1).times { print "  " }
    puts "@n_attribute_ro #{@n_attribute_ro}"
    (indent+1).times { print "  " }
    puts "@n_attribute_rw #{@n_attribute_rw}"
# @n_attribute_omit : int >= 0  # of [omit] specified cells
# @n_var:: int >= 0
# @n_var_size_is:: int >= 0     # of [size_is] specified cells # mikan count_is
# @n_var_omit:: int >= 0        # of [omit] specified  cells # mikan var �� omit ��ͭ��
# @n_call_port:: int >= 0
# @n_call_port_array:: int >= 0
# @n_call_port_omitted_in_CB:: int >= 0   ��Ŭ���Ǿ�ά�����ƤӸ�
# @n_entry_port:: int >= 0
# @n_entry_port_array:: int >= 0
    (indent+1).times { print "  " }
    puts "@n_entry_port_inline #{@n_entry_port_inline}"
# @n_cell:: int >= 0  ������������Ƭ�ǻ��Ф��롥��̣�����ʳ��Ǥϻ����Բ�
# @id_base:: Integer : cell �� ID �κǾ���(�����ͤ� @id_base + @n_cell)

  end
end

class Cell < NSBDNode # < Nestable
# @name:: Symbol : composite celltype ����¦�Υ��󥹥��󥹤Ǥϳ��Υ���
# @global_name:: Symbol : C �ǻȤ���̾����namespace ��ޤ��
# @local_name:: str : cell celltype name { ... } �� name
# @celltype:: Celltype | CompositeCelltype
# @join_list:: NamedList
# @b_defined:: definition flag (false if only prototype )
# @b_duplicate:: bool:  definition duplicate
# @b_checked::   bool:  set_definition_join ���Ѥ�Ǥ����� true
# @require_joined_list:: {cp_name=>true}:  set_require_join ���Ѥ�Ǥ���ƤӸ��� true
# @f_ref:: refercenced from others
# @entry_array_max_subscript:: { @port=>Integer } : ���������������ź���κ����͡�ź��̵�������������б���
# @plugin::     Plugin: avialble if cell is generated by plugin generated cdl code.
# @referenced_port_list:: { Port => Integer } : �������λ��ȿ�
#                                               ���٤Ƥΰ�̣����(through, compositeŸ��)������ä�������ꤹ��
#                                               ��require �ݡ��Ȥ��Ф���ʣ���η�礬�ʤ��������å�����
# @generate:: [ Symbol, String, Plugin ]  = [ PluginName, option, Plugin ] Plugin ����������ɲä����
#
# composite �Τ��ᥤ�󥹥����ѿ�
# @in_composite:: bool : true if in composite celltype
# @compositecelltypejoin_list:: NamedList : item= CompositeCelltypeJoin ( if @in_composite )
# @f_cloned:: bool : true if cloned (instantiate of composite consist cell)
# @my_clone:: Cell : Composite cell �� in_composite = true �ξ��Τ�ͭ����ľ���� clone ����������
# @cell_list:: Cell[local_name] : Composite cell �� clone ������Υꥹ�� cell_list
# @cell_list2:: [ Cell ] : Composite cell �� clone ������Υꥹ�� cell_list
#                          @cell_list2 �� composite ��Ǥνи���  
#
# region �Τ���Υ��󥹥����ѿ�
# @region:: Region (°����region)
#
# allocator �Τ���Υ��󥹥����ѿ�
# @alloc_list::  [ [ NORMAL_ALLOC, ep_name, func_name, param_name, expr ], ... ]
#   ������¦�Υ��������ؤη��򵭲����ʲ��Υ᥽�åɤ��ɲä����
#      set_specifier �� cell ������˥����������ꤵ��Ƥ�����
#      create_relay_allocator_join �� ��졼���������ξ��
#
# ID �Τ���Υ��󥹥����ѿ���optimize.rb �ˤ������
# @id:: Integer : ����������ľ��������  (�ץ�ȥ���������ξ��� -1 �Τޤ�����)
# @id_specified::Integer : ���ꤵ�줿 id

=begin
# Cell ���饹�ϡ��ʲ��Τ�Τ򰷤�
# 1)���̤Υ���
# 2)composite ���륿���פΥ���
# 3)composite ���륿���פ���¦�Υ��� (@in_composite)   # composite ����¦�� composite ���륿���פΥ���⤢��
#
# 2) �� CellOfComposite ���饹�Ȥ���ʬ�����ۤ����褤���⤷��ʤ�
#    expand (composite �����Ÿ��) �� CellOfComposite �ˤΤ�ɬ�פʥ᥽�åɤǤ���
#    get_real_cell, get_real_port �ʤ� @celltype.instance_of?( CompositeCelltype ) ��Ƚ�꤬�ʤ����ä��ꤹ��
#    ������ʬΥ���Ƥ⡢���ƥʥ󥹤��٤��ϰϤ��ڤ�Υ����Ƥ��ޤ���˺��䤹���ʤ�����ȤΥȥ졼�ɥ��դ���
#
# 3) �� CellInCompoiste ���饹�Ȥ���ʬ�����ۤ����褤���⤷��ʤ�
#    @in_composite ��Ƚ�ꤷ�Ƥ���������ڤ�Υ���� (�嵭 2) ����ʬΥ���ưפǤϤʤ�)
#    clone_for_composite �� CellInCompoiste �ˤΤ�ɬ�פʥ᥽�åɤǤ���
#    ��������clone ��� Cell, CellOfComposite ���Ѳ�����ɬ�פ�����Τǡ�clone �ǤϤʤ� new ����������ѹ�����ɬ�פ�����
#
=end

  include PluginModule

  @@nest_stack_index = -1
  @@nest_stack = []
  @@current_object = nil

  # ������줿���٤ƤΥ���ʽи���. namespace �˱ƶ�����ʤ���
  @@cell_list = []     # composite �������Υ����ޤޤʤ�
  @@cell_list2 = []    # composite �������Υ����ޤ� (���Υ����ޤ�)
                       # ��̣���ϸ� make_cell_list2 �ˤ����ꤵ���

  def self.push
    @@nest_stack_index += 1
    @@nest_stack[ @@nest_stack_index ] = @@current_object
    @@current_object = nil
  end

  def self.pop
    @@current_object = @@nest_stack[ @@nest_stack_index ]
    @@nest_stack_index -= 1
    if @@nest_stack_index < -1 then
      raise "TooManyRestore"
    end
  end


  # composite �� clone ���줿��Ρʻ�¹�ޤǴޤ��
  # Join.change_rhs_port �ˤ� CompoisteCelltype ��� Join �η������ѹ�����ݤ˻���
  @@cloned_cell_list = {}
  ### mikan BUG @@cloned_cell_list �� composite �γ��ؤ��Ȥ˵������Ƥ��ʤ����ᡢƱ��̾���������˸����ȡ����ޤ�ư��ʤ�
  # change_rhs_port �μ����ϡ�����ʲ�꤯�ɤ����Ȥ򤹤�ɬ�פϤʤ��ä������դ˸���륻��̾�ˤϡ�composite �Υ���̾�����ˤĤʤ�������Ǥ褫�ä�

  def initialize( ct_path, in_composite = false )
    super()
    @region = Region.get_current

    # celltype ��plugin/¸�ߤ�����å�
    object = Namespace.find( ct_path )    #1
    if object == nil then
      # mikan celltype ��̾�����Դ��� "::ct1ct2" �ˤʤ�
      cdl_error( "S1027 \'$1\' celltype not found" , ct_path.get_path_str )
    elsif ! object.instance_of?( Celltype ) && ! object.instance_of?( CompositeCelltype ) then
      # mikan celltype ��̾�����Դ���
      cdl_error( "S1028 \'$1\' not celltype" , ct_path.get_path_str )
    else
      @celltype = object
    end

    @in_composite = in_composite
    if @in_composite then
      @compositecelltypejoin_list = NamedList.new( nil, "in cell '#{@name}'" )
      @plugin = nil
    else
      @compositecelltypejoin_list = nil
      @plugin = Generator.get_plugin
    end

    @@current_object = self
    @b_defined = false
    @f_ref     = false
    @f_cloned  = false
    @alloc_list = []
    @id = -1
    @id_specified = nil
    @b_duplicate = false
    @b_checked = false
    @require_joined_list = {}
    @entry_array_max_subscript = {}
    @referenced_port_list = {}

    @cell_list = {}
    @cell_list2 = []
  end

  def self.set_name( name )
    @@current_object.set_name( name )
  end

  def set_name( name )

    @name = name
    @local_name = name
    if "#{Namespace.get_global_name}" != "" then
      @global_name = :"#{Namespace.get_global_name}_#{name}"
    else
      @global_name = name
    end

    # ���λ����Ǥϥץ�ȥ����פ��������ʬ��ʤ��������ʻ��ȤΤ������Ͽ
    # set_f_def �Ǻ�����Ͽ���ʤ���
    # Celltype �ؤ���Ͽ�ϡ�end_of_parse �ǹԤ�
    if @in_composite then
      cell_prev = CompositeCelltype.find( name )
      if cell_prev == nil then
        CompositeCelltype.new_cell( self )
      end
    else
      # cell_prev = Namespace.find( [ name ] )   # �Ƥޤ��ܤ��ˤ���
      cell_prev = Namespace.get_current.find( name )
      if cell_prev == nil then
        Namespace.new_cell( self )
        set_namespace_path # @NamespacePath ������
      end
    end

    if cell_prev then
      if ! cell_prev.instance_of?( Cell ) then
        cdl_error( "S1029 $1 mismatch with previous one" , name )
        # celltype �����פ��Ƥ��뤫 ?
      elsif get_celltype != cell_prev.get_celltype then
        cdl_error( "S1030 $1: celltype mismatch with previous one" , name )
      else
        # region �����פ��Ƥ��뤫?
        if ! cell_prev.get_region.equal? get_region then
          cdl_error( "S1031 $1 region \'$2\' mismatch  with previous one \'$3\'" , name, @region.get_name, cell_prev.get_region.get_name )
        end

        @@current_object = cell_prev
        # ���λ����Ǥϡ��ޤ��ץ�ȥ���������������ʬ��ʤ�
        # ����������Ǥ��äơ����������ξ�硢��ʣ���顼�Ǥ���
      end
    end

    @join_list = NamedList.new( nil, "in cell '#{@name}'" )

    # debug
    dbgPrint "Cell new_cell: #{@global_name} #{@in_composite} #{self}\n"

    # �������������� @alloc_list ���ɲ�
    if @celltype.instance_of? CompositeCelltype then
      @celltype.get_internal_allocator_list.each{ |cell, cp_internal_name, port_name, fd_name, par_name, ext_alloc_ent|
        nsp = NamespacePath.new( @name, false )
        rhs = Expression.new( [:OP_DOT, [:IDENTIFIER, nsp], Token.new( ext_alloc_ent.to_s.to_sym, nil, nil, nil ) ] )  #1

        @alloc_list << [:NORMAL_ALLOC,port_name,nil,fd_name,par_name,rhs]
# print "add alloc_list: #{port_name}.#{fd_name}.#{par_name}=#{rhs.to_s}\n"
      }
    end
  end

  #=== Cell# cell �����
  # ����(join)�������ľ���˸ƤӽФ����
  def self.new_def
    @@current_object.new_def
  end

  #=== Cell# cell �����
  # ����(join)�������ľ���˸ƤӽФ����
  def new_def
    # �������Υ����å�
    if @b_defined == true then
      cdl_error( "S1032 $1: duplicate cell" , @name )
      dbgPrint "previous: #{@prev_locale[0]}: line #{@prev_locale[1]} '#{@name}' defined here\n"

      # ����ν�ʣ������顼�ν���
      # ��������ϼΤƤ�
      @join_list = NamedList.new( nil, "in cell '#{@name}'" )
    end

    @b_defined = true
    @prev_locale = @locale
  end

  def self.new_join( join, b_regular = false )
    @@current_object.new_join( join, b_regular )
  end

  #===  Cell# ��������������å�
  # STAGE:   P
  #
  #join::  Join : ���������
  #b_regular:: bool : �̾�ξ�� (bnf.y.rb)����ʤ�� true, ����ʳ�(allocator, require) �Ǥ� false
  def new_join( join, b_regular = false )
    join.set_owner self

    # composite �ο�ʸˡ�б���
    # composite ����Υ���ǡ�attribute ������Ǥ�����
    # cell ��� attr_ext = composite.attr; ��ʸ�����
    if @in_composite then
      if @celltype then
        if @celltype.find(join.get_name).instance_of?( Decl ) then # mikan a::b �ǻ��ꤵ��Ƥ�����Τ����顼�ˤʤ�ʤ�����
          rhs = join.get_rhs
          if rhs.instance_of? Expression then
            ele = rhs.get_elements
            if( ele[0]==:IDENTIFIER )then    #  attr = attr_ext �ʱ���ñ��ˤ��� #1
              if( CompositeCelltype.has_attribute?(ele[1].get_name ) )then    # mikan a::b.ePort �����顼�ˤʤ�ʤ�����
                ident = ele[1].get_name   # ���դ� attribute��
              else
                # ���դ� attribute �ˤʤ��ΤǤ���С�����ΤϤ�
                # ����ϲ����Ϥ� (cell �� join �ˤ���)
                ident = nil
              end
            else
              if join.get_rhs.eval_const2(nil) == nil then   # ������ǤϤʤ�����
                # ���դ���ñ��Υ���ܥ�Ǥʤ���硢�����ϰ����ʤ�
                cdl_error( "S1033 rhs expression is not supported. Only attribute is permitted on current version."  )
                return
              else
                # ����ϲ����Ϥ� (cell �� join �ˤ���)
                ident = nil
              end
            end

            if ident then
              # attr = attr; �Τ褦�ʻ��Ȥϥ��顼 (a = composite.a �Ȥ���ɬ�פ�����)
              if @celltype.find( ident ) then
                cdl_error( "S1034 $1 : cannot refer to $2\'s attribute here. Use \'composite.$3\' to refer to composite celltype\'s" , ident, @celltype.get_name, ident )
              end
            end
          elsif rhs.instance_of? Array then
            if rhs[0] == :COMPOSITE then   # ���դ� composite.attr �η���
              ident = rhs[1].to_sym
            else
              ident = nil    # ���դ� { 10, -10 } �η���
            end
          else
            ident = nil      # ���դ� C_EXP �η���
          end

          # ident �����Ĥ��ä��ʱ��դ�ñ��� ident��
          if ident then
            # composite �ε�ʸˡ�ι�ʸ�������Ϥ������볰�� attr_ext = Cell.attr; ��ʸ�ν������Ϥ�
            #                        export_name, internal_cell_name, internal_cell_elem_name
            decl = CompositeCelltype.new_join( ident, @name, join.get_name, :ATTRIBUTE )  # mikan a::b.ePort �����顼�ˤʤ�ʤ�����
            if ! decl.instance_of? Decl then
              return
            end
            ini = decl.get_initializer
            if ini == nil then
              return
            end
            # �ʲ��ε�ʸˡ�������Ϥ���
            # ��ʸˡ�Ǥ� cell �˽���ͤ�Ϳ���뤳�Ȥǡ�composite ��°���ν���ͤ���ꤹ�뤳�Ȥ��Ǥ���
            # attribute �ǻ��ꤵ�줿����ͤ� cell ��°���Ȥ��ƽ���������
            join.change_rhs( ini )
          else
            # ident ���ʤ��������
          end
        else
          # celltype ��°���Ȥ��ơ����� join ��̾�����ʤ�
          # �ʲ��� join.set_definition ����ǥ��顼�Ȥʤ�
        end
      else
        return    # celltype ���ʤ������Ǥ˥��顼
      end
    elsif join.get_rhs.instance_of? Array then
      rhs = join.get_rhs
      if rhs[0] == :COMPOSITE then
        # composite ����Ǥʤ��Τ� attr = composite.attr ���Ȥ�줿
        cdl_error( "S1035 composite : cannot specify out of composite celltype definition"  )
        return
      end
    end

    # �ʲ� composite ʸˡ�ѹ������餢�����

    # ���˺��դ�Ʊ��̾���ν������¸�ߤ��뤫��
    j = @join_list.get_item( join.get_name )   # mikan NamespacePath ���ѥ�����äƤ���
    if j.instance_of? Join then    # mikan �����Ǥ� j �� Join or Nil �ʳ��ϡ��ʤ��Ϥ�

      # debug
      dbgPrint "add_array_member: #{@name} port: #{j.get_port_name} rhs: #{j.get_rhs}, #{join.get_port_name} #{join.get_rhs}\n"
      # �ƤӸ�����ʤǤ���Ȳ��ꤷ�ơ����Ǥ��ɲ�
      j.add_array_member join

    else
      # join
      @join_list.add_item( join )
    end

    # if get_owner then   # error S1030 ȯ���� get_owner �����Ĥ���ʤ����㳰�ˤʤ�
    #   dbgPrint "Cell#new_join: #{get_owner.get_name}.#{@name}\n"
    # else
    #   dbgPrint "Cell#new_join: \"owner not fund\".#{@name}\n"
    # end
    if ! @in_composite then
     if join.get_cell
       dbgPrint "new_join: #{@name} #{@region.get_name} => #{join.get_cell.get_name} #{join.get_cell.get_region.get_path_string}\n"
     end
#     p "region: generate? #{@region.is_generate?}"
    end

  end

  def self.external_join( internal_cell_elem_name, export_name, b_composite )
    @@current_object.external_join( internal_cell_elem_name, export_name, b_composite )
  end

  #=== Cell# cell ��˵��Ҥ���ƤӸ��γ������
  # internal_cell_elem_name:: string : �ƤӸ�̾
  # export_name:: string: composite �γ����˸�������ƤӸ�̾
  #  �ƤӸ�������礹�롥
  #  ���Υ᥽�åɤϡ�composite ����� cell �Ǥ����ƤФ�ʤ���
  def external_join( internal_cell_elem_name, export_name, b_composite )

    # cCall => composite.cCall; �ǤϤʤ�����
    if( b_composite == false )then
      # cCall => cCall; �Τ褦�ʾ��
      if @celltype.find( export_name ) then
        cdl_error( "S1036 $1 : cannot refer to $2\'s here. Use \'composite.$3\' to refer to composite celltype\'s" , export_name, @celltype.get_name, export_name )
      end
    end
    # composite �ε�ʸˡ�ˤ����롢cell ���� cCall = Cell.cCall; �ι�ʸ�������Ϥ�
    CompositeCelltype.new_join( export_name, @name,  internal_cell_elem_name, :CALL )
  end

  def self.end_of_parse f_def
    cell = @@current_object
    cell.end_of_parse f_def
    @@current_object = nil
    return cell
  end

  def end_of_parse f_def
    set_specifier_list( Generator.get_statement_specifier )
    set_f_def f_def

    if @generate then
      cell_plugin
    end
  end

  #=== Cell# �ץ�ȥ��������(false)�����(true)��������
  #    ���Υ᥽�åɤϹ�ʸ���κǸ�˸ƽФ����
  #f_def::     bool     false if prototype, true if definition
  def set_f_def f_def
    if ! f_def then
      return
    end

    if ! @in_composite then
      if @celltype.instance_of? Celltype then
        @celltype.new_cell self
      end
      @@cell_list << self
    end
  end

  def set_f_ref
    dbgPrint "set_f_ref: #{@global_name}\n"
    @f_ref = true

    # composite ����������򻲾Ȥ��줿���Ȥˤ���
    # ���ΤȤ�������ʤ�����̤���ȤǤ���٤���Τޤǻ��Ȥ��줿���Ȥˤʤ�
    if @cell_list then
      @cell_list.each{ |cn,cell|
        cell.set_f_ref
      }
    end
  end

  #=== Cell# cell �λ���Ҥ�����
  # STAGE:  B
  #
  #    bnf.y.rb �� statement_specifiler_list
  #spec_list::      [ :ALLOCATOR, [ [ :NORMAL_ALLOC, ep_name, subscript, func_name, param_name, expr ], ... ] ]
  #                     s[0]      s[1]   a[0]        a[1]       a[2]        a[3]     a[4]       a[5]
  #    ����˻��ꤵ�줿�������������
  #    a[1] �� subscript �Ϥ��Υ᥽�åɤ���� Expression ���� Integer ��ɾ�������
  #    ������¦����������륢�������ƤӸ��η���������������
  #    �ƤӸ�¦�� Port �� create_allocator_join �ˤ�����
  #    ��졼���������ξ�� create_relay_allocator_join �ˤ�������
  def set_specifier_list( spec_list )
    return if spec_list == nil  # ���ʤ�в��⤷�ʤ�

    dbgPrint( "set_spec_list: #{@name}\n" )

    spec_list.each{ |s|
      case s[0]             # statement_specifier
      when :ALLOCATOR       # [allocator(ePort.func.param=allocCell.eA,ePort.func2.param=allocCell.eA)]
        s[1].each { |a|     # alloc_list : allocator �������� ',' �Ƕ��ڤ�줿��ʬ������
          cp_name = :"#{a[0+1]}_#{a[2+1]}_#{a[3+1]}"    # ���������ƤӸ���̾����'=' �κ��դ� '.' ���Ѥ��� '_' ��Ϣ��
          # p "#{a[0]} #{a[0+1]} #{a[2+1]} #{a[3+1]} #{cp_name}"
          if a[1+1] then
            subscript = a[1+1].eval_const nil
            a[1+1] = subscript
          else
            subscript = nil
          end
          # ���������ƤӸ��η�������
          join = Join.new( cp_name, subscript, a[4+1] )
          Cell.new_join( join )
          @alloc_list << a 
        }
      when :ID          # [id(0)]
        if ! s[1].instance_of? Expression then
          cdl_error( "S9999 $1 must be constant for id", s[1].to_s )
        else
          id = s[1].eval_const nil
          if id == nil || Integer(id) != id then
            cdl_error( "S9999 $1 must be constant for id", s[1].to_s )
          elsif id == 0 then
            cdl_error( "S9999 $1: id cannot be 0", s[1].to_s )
          else
            @id_specified = id
          end
        end
      when :GENERATE      # [generate(CellPlugin,"option")]
        if @generate then
          cdl_error( "S9999 generate specifier duplicate"  )
        end
        @generate = [ s[1], s[2] ] # [ PluginName, "option" ]
      else
          cdl_error( "S1039 \'$1\': unknown specifier for cell" , s[0] )
      end
    }
  end

  def get_allocator_list

    # ��̣�����å�(set_definition)����Ƥ��ʤ���
    # relay ���������ξ�硢����ΰ�̣�����å����Ԥ��Ƥ��ʤ��ȡ�@alloc_list ���������ʤ�
    if @b_checked == false then
      set_definition_join
    end
    @alloc_list
  end

  def get_specified_id
    @id_specified
  end

  #=== id ����Ҥ��ͤ�����
  # ���Υ᥽�åɤϡ��ץ饰����� cell ��������������椷�������Τ�����ߤ���
  # �̾�� id ����ҤǤϻȤäƤ��ʤ�
  def set_specified_id id
    if Integer( id ) != id || id <= 0 then
      cdl_error( "S9999 '$1' set_specified_id: id not positive integer '$2'", @name, id )
    elsif @id_specified then
      cdl_error( "S9999 '$1' set_specified_id: id duplicate", @name )
    else
      @id_specified = id
    end
  end

  #=== Cell# ���륿���ץץ饰���� (generate �����)
  def cell_plugin

    load_plugin( @generate[0], CellPlugin )

    plugin_name = @generate[0]
    option = @generate[1]
    plugin_object = nil
    eval_str = "plugin_object = #{plugin_name}.new( self, option )"
    if $verbose then
      print "new cell : #{eval_str}\n"
    end

    begin
      eval( eval_str )     # plugin ������
      plugin_object.set_locale @locale
      @generate[ 2 ] = plugin_object
      generate_and_parse plugin_object
    rescue Exception => evar
      cdl_error( "S9999 $1: fail to new" , plugin_name )
      print "eval( #{eval_str} )\n"

      print_exception( evar )
    end
  end

  def add_compositecelltypejoin join
    @compositecelltypejoin_list.add_item join
  end

  #=== Cell# cell �� composite ���륿���פΥ����Ѥ� clone ����
  #name::        string : �� cell ��̾��  (cell tComposite cell1 �Ǥ� cell1)
  #global_name:: string : �� cell �� global_name 
  #join_array::  Join[] : composite �� cell �� join �ǡ����� cell ���б�������
  #ct_name::     string : �ƥ���Υ��륿����̾
  #region::      Region : ���Υ��뤬°���� region
  #���Υ᥽�åɤ� CompositeCelltype �� expand ����ƽФ����
  def clone_for_composite( name, global_name, namespacePath, join_array, ct_name, region, plugin, locale )

    # debug
    dbgPrint "Cell#clone_for_composite : cloning: #{@name} #{global_name}  b_defined=#{@b_defined}\n"

    @my_clone = self.clone
    @@cloned_cell_list[ self ] = @my_clone

    # clone ��������������˻���̾�������Ĵ������

    @my_clone.set_cloned( name, global_name, namespacePath, join_array, ct_name, region, plugin, locale )

    # @celltype == nil �ϰ����˥��륿����̤������顼
    if @b_defined == true && @celltype != nil then
      if @celltype.instance_of?( Celltype ) then
        # celltype ����Ͽ�ʥ������������оݤȤʤ��
        @celltype.new_cell( @my_clone )
      end
    end

    return @my_clone
  end

  #=== Cell# clone ���줿����������˻���̾�������Ĵ������
  #name::        string : �� cell ��̾��  (cell tComposite cell1 �Ǥ� cell1)
  #global_name:: string : �� cell �� global_name
  #join_array::  Join[] : composite �� cell �� join �ǡ����� cell ���б�������
  #parent_ct_name:: string : �ƥ���Υ��륿����̾��composite ���륿���ס�
  #  ���Υ᥽�åɤϤ������ clone_for_composite ����ƽФ��졢clone ���줿�����������
  def set_cloned( name, global_name, namespacePath, join_array, parent_ct_name, region, plugin, locale )

    # debug
    dbgPrint "cell.set_cloned : global_name: #{global_name}  name: #{name}  @name: #{@name}\n"

    @global_name = :"#{global_name}_#{@name}"
    @name = :"#{name}_#{@name}"
    @NamespacePath = namespacePath.change_name @name
    @region = region
    @plugin = plugin
    @locale = locale

    @in_composite = false
    @b_checked = false
    @f_cloned = true

    # Namespace.new_cell( self )  # mikan namespace �б�
    region.new_cell( self )  # mikan  namespace �� cell ���֤��ʤ����Ȥ���

    # join_list : NamedList �� clone ����
    if @celltype then
      dbgPrint "set_cloned: #{@celltype.get_name} #{@name} #{region.get_name}\n"
    end
    @join_list = @join_list.clone_for_composite( parent_ct_name, name, locale )
    @referenced_port_list = {}

    @alloc_list = []
    @require_joined_list = {}
    @entry_array_max_subscript = {}
    @cell_list = {}
    @cell_list2 = []

    # ���Υ���Υ����Х�̾��Ϳ����
    # C_EXP ��$id$ �ִ��Ϥ��Υ����̾���ˤʤ�
    join_array.each { |j|
      @join_list.change_item j
    }

    # clone ���褦�Ȥ��륻�뤬 composit ���륿���ס�
    if @celltype.instance_of?( CompositeCelltype ) then
      # composite cell ��Ƶ�Ū��Ÿ��
      @cell_list, @cell_list2 = @celltype.expand( @name, @global_name, @NamespacePath, @join_list, @region, @plugin, @locale )
    end

  end

  #=== Cell# clone ���줿 cell �� join_list �α��դ��ѹ�
  #  �ƤӸ��α��դ� cell ��¾�� clone ���줿 cell ���ִ���
  def change_rhs_port

    # debug
    dbgPrint "Cell change_rhs_port: global_name: #{@global_name}\n"

    @join_list.get_items.each { |j|
      j.change_rhs_port( @@cloned_cell_list, @celltype )
    }

    if @celltype.instance_of?( CompositeCelltype ) then

      # ����ҤΥ���ˤĤ��Ƥ��ѹ�
      @cell_list.each{ |name,c|
        c.change_rhs_port
      }
    end
  end

  def get_f_def
    @b_defined
  end

  def get_f_ref
    if @f_ref then
      return true
    else
      return false
    end
  end

  def get_name
    @name
  end

  def get_local_name
    @local_name
  end

  def get_global_name
    @global_name
  end

  def get_region
    @region
  end

  def self.get_current
    @@current_object
  end

  #=== Cell# ��������륻�뤫��
  # ��Ŭ����������������ˡ��оݤȤʤ� region ��°������ true ���֤�
  def is_generate?
    if $generating_region == nil then
      # ��ʸ��ᡢ��̣�����ʳ��ǸƤФ����㳰ȯ��
      raise "is_generate? called before optimizing"
    end

    # print "Cell#is_generate?: #{@name} #{@region.get_name} #{$generating_region.get_name}\n"
    if $generating_region == @region.get_link_root then
      return true
    else
      return false
    end
  end

  #=== Cell# composite ������ʣ�����줿���뤫��
  # composite ����������Υ��� (@in_composite = true) �ǤϤʤ�
  def is_cloned?
    @f_cloned
  end

  #=== Cell# composite �����Υ��뤫��
  def is_in_composite?
    @in_composite
  end

  # composite cell �� port ���б����������� cell �� port ��̾���ʥ�󥯻���ɬ�פ�̾����
  def get_real_global_name port_name
    if @celltype.instance_of?( CompositeCelltype ) then

      # debug
      dbgPrint "get_real_global_name: cell name: #{@name} #{@local_name} #{@global_name} #{port_name}\n"
      @cell_list.each{ |n,c|
        dbgPrint "   name: #{n}\n"
        dbgPrint " get_name: #{c.get_name} local_name: #{c.get_local_name}\n"  if c
        dbgPrint "\n\n"
      }

      cj = @celltype.find_export( port_name )

      # debug
      dbgPrint " composite join name: #{cj.get_name}  cell: #{cj.get_cell_name}  cell elem: #{cj.get_cell_elem_name}\n"

      name = @cell_list[ "#{cj.get_cell_name}" ].get_real_global_name( cj.get_cell_elem_name )
      return name

    else
      # debug
      dbgPrint "  get_real_global_name: cell name: #{@global_name}\n"

      return @global_name
    end
  end

  #=== Cell# ����μ����� port_name ���Ф���ºݤΥ���̾��������̾�� '_' ��Ϣ��
  #    namespace ̾ + '_' + ����̾ + '_' + ������̾   �ʤ��Υ��뤬 composite �ʤ��Ÿ����Υ���̾��������̾��
  def get_real_global_port_name port_name

    # composite ����
    if @celltype.instance_of?( CompositeCelltype ) then

      # debug
      dbgPrint "get_real_global_port_name: cell name: #{@name} #{@local_name} #{@global_name} #{port_name}\n"
      @cell_list.each{ |n,c|
        dbgPrint "   name: #{n}\n"
        dbgPrint " get_name: #{c.get_name} local_name: #{c.get_local_name}\n"  if c
        dbgPrint "\n"
      }

      # ���륿������� port_name �� CompositeCelltypeJoin ��õ���ʥ����������ʳ��Ǥ�ɬ�����Ĥ����
      cj = @celltype.find_export( port_name )

      # debug
      dbgPrint "   composite join name: #{cj.get_name}  cell: #{cj.get_cell_name}  cell elem: #{cj.get_cell_elem_name}\n"

      # composite �������Υ�����Ф��Ƶ�Ū�� get_real_global_port_name ��Ŭ��
      name = @cell_list[ "#{cj.get_cell_name}" ].get_real_global_port_name( cj.get_cell_elem_name )
      return name

    else
      # debug
      dbgPrint "get_real_global_port_name:  cell name: #{@global_name}\n"

      return "#{@global_name}_#{port_name}"
    end
  end

  #=== Cell# PORT (celltype �����) ������
  def get_real_port( port_name )

    # composite ����
    if @celltype.instance_of?( CompositeCelltype ) then

      # ���륿������� port_name �� CompositeCelltypeJoin ��õ���ʥ����������ʳ��Ǥ�ɬ�����Ĥ����
      cj = @celltype.find_export( port_name )

      # composite �������Υ�����Ф��Ƶ�Ū�� get_real_port ��Ŭ��
      port = @cell_list[ "#{cj.get_cell_name}" ].get_real_port( cj.get_cell_elem_name )
      return port
    else

      return @celltype.find( port_name )
    end
  end

  #=== Cell# cell ������
  #    composite �Ǥʤ���м�ʬ���Ȥ��֤�
  def get_real_cell( port_name )

    # composite ����
    if @celltype.instance_of?( CompositeCelltype ) then

      # ���륿������� port_name �� CompositeCelltypeJoin ��õ���ʥ����������ʳ��Ǥ�ɬ�����Ĥ����
      cj = @celltype.find_export( port_name )

      # composite �������Υ�����Ф��Ƶ�Ū�� get_real_port ��Ŭ��
      cell = @cell_list[ "#{cj.get_cell_name}" ].get_real_cell( cj.get_cell_elem_name )
      return cell
    else

      return self
    end
  end


  #=== Cell# ��������port �λ��ȥ�����Ȥ򥢥åפ���
  #port_name:: Symbol  : �ݡ���̾
  def port_referenced port
    if @referenced_port_list[ port ] then
      @referenced_port_list[ port ] += 1
    else
      @referenced_port_list[ port ] = 1
    end

    # composite ����
    if @celltype.instance_of?( CompositeCelltype ) then

      # ���륿������� port_name �� CompositeCelltypeJoin ��õ���ʥ����������ʳ��Ǥ�ɬ�����Ĥ����
      cj = @celltype.find_export( port.get_name )

      dbgPrint " port_referenced: #{@celltype.get_name} #{@name} cj=#{cj&&(cj.get_name)||"nil"}\n"

      if cj then  # ���˥��顼
        # composite �������Υ�����Ф��Ƶ�Ū�� get_real_port ��Ŭ��
        cell = @cell_list[ "#{cj.get_cell_name}" ]
        if cell && cell.get_celltype then
          cell.port_referenced( cell.get_celltype.find( cj.get_cell_elem_name ) )
        end
      end
    end
  end

  def get_internal_port_name port_name
    if @celltype.instance_of?( CompositeCelltype ) then
      cj = @celltype.find_export( port_name )
#      return "#{@name}_#{cj.get_cell.get_internal_port_name cj.get_cell_elem_name}"
      return cj.get_cell.get_internal_port_name( cj.get_cell_elem_name )
    else

      # debug
      dbgPrint "  get_global_port_name: cell port: #{@global_name}_#{port_name}\n"

      return "#{@global_name}_#{port_name}"
    end
  end

  def get_celltype
    @celltype
  end

  def get_join_list
    @join_list
  end

  def set_id id
    @id = id
  end

  def get_id
    @id
  end

  def get_plugin
    @plugin
  end

  def get_cell_list2
    list = []
    @cell_list2.each{ |cell|
      list << cell
      list += cell.get_cell_list2
    }
    return list
  end

  #=== Cell# �����������ź���κ����ͤ�����
  def set_entry_port_max_subscript( port, num )
    dbgPrint( "set_entry_port_max_subscript: #{@name}.#{port.get_name}: #{num}\n" )
    subscript = @entry_array_max_subscript[port]

    if subscript == nil || num > subscript then
      @entry_array_max_subscript[port] = num
      set_entry_inner_port_max_subscript( port, num )
    end
  end

  #=== Cell# composite ����¦����μ����������ź���κ����ͤ�����
  def set_entry_inner_port_max_subscript( port, num )
    if @cell_list == nil then   # mikan ����ä�����ʤ���
      return    # �ץ�ȥ����������������Ƥ��ʤ��ơ���¦���뤬Ÿ������Ƥ��ʤ�
    end

    # composite ����¦�Υ��������
    if @celltype.instance_of? CompositeCelltype then
      cj = @celltype.find_export port.get_name
      if cj && @cell_list[ cj.get_cell_name.to_s ] then
        inner_cell = @cell_list[ cj.get_cell_name.to_s ]
        ct = inner_cell.get_celltype
        if ct then
          inner_port = ct.find( cj.get_cell_elem_name )
          inner_cell.set_entry_port_max_subscript( inner_port, num )
        end
      end
    end
  end

  #=== Cell# �����������ź���κ����ͤ��֤�
  # Ĺ���� +1 ����
  # 1�Ĥ�ʤ����� -1 ���֤�
  def get_entry_port_max_subscript( port )
    subscript = @entry_array_max_subscript[port]
    if subscript == nil then
      subscript = -1
    end
    return subscript
  end

  #=== Cell# ��졼���������η�������
  # �ƤӸ�¦�η��򸵤˼�����¦�η�������
  def create_relay_allocator_join

    # celltype ���ʤ���Х����å����ʤ��ʴ��˥��顼��
    return if @celltype == nil

    # relay allocator ������
    @celltype.get_port_list.each { |p|
      ail = p.get_allocator_instance
      if ail then
        dbgPrint "create_relay_allocator_join: #{@name}, #{p.get_name}\n"
        if p.get_array_size then
          # mikan relay allocator �� array ���б��Ǥ��Ƥ�褤�ΤǤϡ�
          cdl_error( "S1040 array not supported for relay allocator"  )
          next
        end
        ail.each{ |name,ai2|
          # ai2 = [ :INTERNAL_ALLOC|:RELAY_ALLOC, func_name, param_name, rhs_cp_name, rhs_func_name, rhs_param_name ]
          if ai2[0] == :RELAY_ALLOC then
            dbgPrint "create_relay_allocator_join: #{@name}, #{name}\n"
            # �ƤӸ�¦�η�����Ф�
            ja = @join_list.get_item( :"#{ai2[3]}_#{ai2[4]}_#{ai2[5]}" )
            if ja == nil then
              # ���Ĥ���ʤ����
              found = false
              
              # composite ��ǳ����˷�礵��Ƥ��뤫
              if @in_composite then
                @compositecelltypejoin_list.get_items.each { |cj|
                  dbgPrint( "create relay_allocator in_composite\n" )
                  dbgPrint("    #{cj.get_cell_name} #{@name} #{cj.get_cell_elem_name} #{ai2[3]}_#{ai2[4]}_#{ai2[5]}\n")
                  if cj.get_cell_name == @name &&
                      cj.get_cell_elem_name == :"#{ai2[3]}_#{ai2[4]}_#{ai2[5]}" then
                    found = true
                    dbgPrint "create_relay_allocator: found #{cj.get_cell_elem_name}\n"
                    break
                  end
                }
              end

              if found == false then
                cdl_error( "S1041 \'$1_$2_$3\': not joined. cannot create internal join for relay allocator" , ai2[3], ai2[4], ai2[5] )
                print( "      In cell #{get_name}\n" )
                # join ��̤���Ǥ��뤳�ȤΥ��顼�����٤Ǥ� (S1043)
              end
              next    # �Ǥ��ڤ�
            end

            b_export = false
            # composite ��Υ���ǥ������ݡ��Ȥ���Ƥ��뤫�����å�
            #  mikan �������ݡ���¦�ȡ�������¦�ǡ���졼�褬���פ��뤫�����å���ɬ��
            if @compositecelltypejoin_list then
              # export ����Ƥ��뤫Ĵ�٤�
              @compositecelltypejoin_list.get_items.each{ |cj|
                # °��̾�� composite �� export ����̾���ϰ��פ��뤫
                if p.get_name == cj.get_cell_elem_name then
                  print "export : #{p.get_name}\n"
                  b_export = true    # °���� export ����Ƥ���Τǡ��Ȥꤢ����̤������ȤϤ��ʤ�
                  break
                end
              }
              # 
            end

            # mikan ����
            am = nil
            if am then
              am.each{ |ja2|
                rhs = ja2.get_rhs
                subscript = ja2.get_subscript
                if b_export == false then
                  # CompositeCelltype �ξ�硢��¦�Υ��������������
                  join = Join.new( :"#{p.get_name}_#{ai2[1]}_#{ai2[2]}", subscript, rhs )
                  # p ( "#{p.get_name}_#{ai2[1]}_#{ai2[2]}", subscript, rhs )
                  new_join( join )
                  join.set_definition( @celltype.find(join.get_name) )
                  # mikan relay mismatch �����å����Ǥ��Ƥ��ʤ��ʲ����򻲾ȡ�
                end
                @alloc_list << [ :NORMAL_ALLOC, p.get_name, subscript, ai2[1], ai2[2], rhs ]
              }
            else
              if b_export == false then
                # CompositeCelltype �ξ�硢��¦�Υ��������������
                join = Join.new( :"#{p.get_name}_#{ai2[1]}_#{ai2[2]}", nil, ja.get_rhs )
                new_join( join )
                join.set_definition( @celltype.find(join.get_name) )
                if @celltype.instance_of? CompositeCelltype then
                  jr = @join_list.get_item( :"#{ai2[3]}_#{ai2[4]}_#{ai2[5]}" )
                  if jr.get_rhs_cell2 != join.get_rhs_cell2 || jr.get_rhs_port2 != join.get_rhs_port2 then
                    cdl_error( "S9999 \'$1\': relay mismatch \'$2\'",
                                      "#{p.get_name}_#{ai2[1]}_#{ai2[2]}",
                                      "#{ai2[3]}_#{ai2[4]}_#{ai2[5]}" )
                    # ������ composite �θƤӸ��ȼ������δ֤ǹԤ��٤�������������¿����³����Ƥ�����
                  else
                    dbgPrint "relay success:  #{p.get_name}_#{ai2[1]}_#{ai2[2]}=>#{ai2[3]}_#{ai2[4]}_#{ai2[5]} #{jr.get_rhs_cell2.get_name}.#{jr.get_rhs_port2} \n"
                  end
                end
              end
              @alloc_list << [ :NORMAL_ALLOC, p.get_name, nil, ai2[1], ai2[2], ja.get_rhs ]
            end
            dbgPrint "create_relay_allocator_join: #{p.get_name}_#{ai2[1]}_#{ai2[2]} #{ai2[3]}_#{ai2[4]}_#{ai2[5]}\n"
          end
        }
      end
    }
  end

  #=== Cell# @@cell_list2 ����
  # @@cell_list2 �ϡ��и���� composite ���ޤॻ��Υꥹ��
  def self.make_cell_list2
    @@cell_list.each{ |c|
      @@cell_list2 << c
      @@cell_list2 += c.get_cell_list2
    }
  end

  #=== Cell# reverse_require_join ����������
  def self.create_reverse_require_join
    @@cell_list2.each{ |c|
      ct = c.get_celltype
      # if c.is_generate? then
        if ct then
          # self �ؤθƤӸ�¦�η�������
          ct.create_reverse_require_join c
        end
      # end
    }
  end

  #=== Cell# ��������port �λ��ȥ�����Ȥ����ꤹ��
  # self �ϸƤӸ��Υ���
  # �Ƥ��襻��μ������λ��ȥ�����Ȥ򥢥åפ���
  def set_port_reference_count
    @join_list.get_items.each { |j|
      if j.get_definition.instance_of? Port then
        am = j.get_array_member2
        if am then             # �ƤӸ�����
          am.each { |j2|
            next if j2 == nil    # optional �ǰ���������Ƥ��륱����
            cell = j2.get_rhs_cell2
            next if cell == nil     # ���դ����Ĥ���ʤ��ä������˥��顼
            port = cell.get_celltype.find( j2.get_rhs_port2 )
            dbgPrint( "set_port_reference_count: #{@name}.#{j2.get_name} => #{cell.get_name}.#{port.get_name}\n")
            cell.port_referenced port
          }
        else
          cell = j.get_rhs_cell2
          next if cell == nil     # ���դ����Ĥ���ʤ��ä������˥��顼
          port = cell.get_celltype.find( j.get_rhs_port2 )
          dbgPrint( "set_port_reference_count: #{@name}.#{j.get_name} => #{cell.get_name}.#{port.get_name}\n")
          cell.port_referenced port
        end
      end
    }
  end

  #=== Cell# ���(Join)�Υ����å�
  #     Join �ϸƤӸ��η��ޤ��� attribute �ν����
  #
  #  mikan ���Υ᥽�åɤϡ��ʲ��Σ��ĤΥ����å�����ʤ뤬��ʬ�䤷���ۤ������Ŭ�ڤ�Ĺ���Υ᥽�åɤˤʤ�
  #  ����졼�������������� => create_relay_allocator_join
  #  ��̤���θƤӸ��Υ����å�
  #  ���ݥ��󥿷�������ǽ�����������Υ����å�
  #  ��̤�������°���Υ����å�
  def check_join

    # celltype ���ʤ���Х����å����ʤ��ʴ��˥��顼��
    return if @celltype == nil
    return if @b_defined == false
    return if @f_cloned == true    # ��������ˤĤ��Ƥϡ�composite ��������˥����å�����Ƥ���

    # debug
    # if @compositecelltypejoin_list then
    #   p "check_join"
    #   @compositecelltypejoin_list.get_items.each { |cj| p "#{cj.get_name} #{cj.get_name.object_id}" }
    # end

    # ̤���θƤӸ��Υ����å�
    @celltype.get_port_list.each { |p|

      # �ƤӸ��Ǥʤ���С������å����ʤ�
      next if p.get_port_type != :CALL

      # debug
      dbgPrint "check_join: #{@name} #{get_celltype.get_name} #{p.get_name}\n"

      # ���ꥹ�Ȥ��椫��ƤӸ�̾�˰��פ����Τ������
      j = @join_list.get_item( p.get_name )

      if j == nil then
        # ̤���θƤӸ�

        # composite celltype �������ξ�硢composite celltype �� export ����ƤӸ��˷�礵��Ƥ��뤫õ��
        found = false
        if @in_composite then
          # composite celltype �� export �����Τ��٤Ƥ���õ��
          # ��export �����Τα����ͤ���õ������� get_item �Ǥϥ����
          @compositecelltypejoin_list.get_items.each{ |cj|
            # �ƤӸ�̾�� composite �� export ����̾���ϰ��פ��뤫
            if p.get_name == cj.get_cell_elem_name then
              found = true
            end
          }
        end

        # �ƤӸ�����ξ�� optional �����Ƥ����Ǥ����������ʤ����ˡ����������
        if ! found && ! p.is_require? && ! p.is_optional? then
          if ! p.is_allocator_port? then
            cdl_error( "S1042 call port \'$1\' not initialized in cell \'$2\'" , p.get_name, @name )
          else
            cdl_error( "S1043 call port \'$1\' not initialized in cell \'$2\'. this call port is created by tecsgen. check allocator specifier" , p.get_name, @name )
          end
        end
      elsif p.get_array_size.kind_of? Integer then
        # ź������ƤӸ�����ξ�硢���٤Ƥ�ź�����Ǥ����������Ƥ��뤫�����å�����

        am = j.get_array_member2
        if( am )then
          # join ������

          # �ƤӸ���������Ǥ�������礭��
          length = p.get_array_size

          # ������礭�����ƤӸ���������ȷ������ǰ��פ��뤫��
          if am.length != length then
            if ! p.is_optional? || am.length >= length then
              # optional �ξ�硢���ǿ������ʤ�����Τ� OK
              cdl_error( "S1044 $1: array initializer too many or few, $2 for $3" , p.get_name, am.length, length )
            end

            # am �����Ǥ� nil ���ɲä��Ƥ��� (#_CPA_# �Υ������������������������ǿ�ʬ����)
            i = am.length
            while i < length
              am << nil
              i += 1
            end
          end

#          # �������Ǥ�ȴ�����ʤ��������å�
#          if am.length < length then  # �����ʤ������˥��顼�������ǤΤ����ϰϤǥ����å�
#            length = am.length
#          end
          i = 0
          while( i < length )
            if am[i] == nil then
              if ! p.is_optional? then
                cdl_error( "S1045 $1[$2]: not initialized" , p.get_name, i )
              end
            else
              # ��������ʤ��꡼�����ؤη�礫�����å�
              if ! @in_composite then
                am[i].check_region2
              end
            end
            i += 1
          end

        # else
        # join ��������Ǥ���С����˥��顼
        end
      elsif j.get_array_member then
        # ź���ʤ��ƤӸ�����ξ��
        am = j.get_array_member2
        length = am.length
        i = 0
        while i < length
          if am[i] == nil then
            if ! p.is_optional? then
              cdl_error( "S1046 $1[$2]: not initialized" , p.get_name, i )
            end
          end
          i += 1
        end

        # ��������ʤ��꡼�����ؤη�礫�����å�
        if ! @in_composite then
          am.each { |join|
            if join then
              join.check_region2
            end
          }
        end
      else
        # �ƤӸ�������פǤʤ����

        # ��������ʤ��꡼�����ؤη�礫�����å�
        if ! @in_composite then
          j.check_region2
        end

      end # j != nil
    }

    # �ݥ��󥿷�������ǽ�����������Υ����å�
    (@celltype.get_attribute_list+@celltype.get_var_list).each { |a|
      if a.get_size_is then

        if a.instance_of? CompositeCelltypeJoin then
          # ���˥��顼�ˤʤäƤ���
          # cdl_error( "S1047 size_is pointer cannot be exposed for composite attribute"  )
          next
        end

        if( ! a.get_type.kind_of?( PtrType ) ) then
          cdl_error( "S1048 $1: size_is specified for non-pointer type" , a.get_name )
        else
          size = a.get_size_is.eval_const( @join_list, @celltype.get_name_list )
          a.get_type.set_scs( a.get_size_is, nil, nil, nil, false )
          if( ! size.kind_of? Integer )then               # C_EXP �β�ǽ������
            # mikan ¿ʬ�����ǤΥ��顼ȯ�������ס�eval_const ������ѿ���¸�ߤ��ʤ���������Ŭ�ڤʤɤΥ��顼�ˤʤ�Ϥ�
            cdl_error( "S1049 $1: size_is arg not constant" , a.get_name )
          else
            j = @join_list.get_item( a.get_identifier )
            if j then
              ini = j.get_rhs
              if ini then
                if ! ini.instance_of?( Array ) then
                  cdl_error( "S1050 unsuitable initializer, need array initializer"  )
                elsif size < ini.length then
                  cdl_error( "S1051 too many initializer for array, $1 for $2" , ini.length, size )
                else
                  # a.get_type.set_scs( a.get_size_is, nil, nil )
                end
              end
            else
              # size_is ����������ǻ��ꤵ��Ƥ��ơ�������Ҥ����륿���פǻ��ꤵ��Ƥ��륱�����Υ����å�
              ini = a.get_initializer
              if ini.instance_of? Expression
                ini = ini.eval_const( @celltype.get_name_list )
              end
              if ini.instance_of? Array then
                if( ini.length > size )then
                  cdl_error( "S9999 too many initializer for array, $1 for $2" , ini.length, size )
                end
              end
            end
          end
        end
      else
        if ! a.instance_of? CompositeCelltypeJoin then
          # composite �� size_is ����Ǥ��ʤ�
          if a.get_type.kind_of?( PtrType ) then
            j = @join_list.get_item( a.get_identifier )
            if j && j.get_rhs.instance_of?( Array ) then
              ## size_is ���ꤵ��Ƥ��ʤ��ݥ��󥿤� Array �ǽ��������Ƥ����顢���顼�Ȥ���
              cdl_error( "S9999 $1: non-size_is pointer cannot be initialized with array initializer" , a.get_identifier )
            end
          end
        end
      end
    }

    # ̤�������°��������å�
    @celltype.get_attribute_list.each { |a|
      b_init = false
      # self.show_tree 1
      if a.get_initializer then                               # ���륿���פǽ��������Ƥ���
        b_init = true
        # @in_composite �� export ����Ƥ�����ˤϡ����ν���ͤϻȤ��ʤ�
        # export ����Ƥ��롢���ʤ��˴ؤ�餺�����������Ƥ��뤳�Ȥ��ݾڤ����
      elsif @join_list.get_item( a.get_name ) then            # ����ǽ��������Ƥ���
        b_init = true
      elsif @in_composite && @compositecelltypejoin_list then
        # °���� export ����Ƥ��뤫Ĵ�٤롣export ����Ƥ����̤������ȤϤ��ʤ�
        # mikan ��˥�������
        @compositecelltypejoin_list.get_items.each{ |cj|
          # °��̾�� composite �� export ����̾���ϰ��פ��뤫
          if a.get_name.to_sym == cj.get_cell_elem_name.to_sym then
            b_init = true    # °���� export ����Ƥ���Τǡ��Ȥꤢ����̤������ȤϤ��ʤ�
          end
        }
        if b_init then
          # size_is �ΰ������ޥå����뤫�����å�����
          # ��������� size_is �򥨥����ݡ��Ȥ��� size_is �ȥޥå����뤫�����å�����
          # ��������ȥ������ݡ��Ȥ�̾�����Ѥ��Ƥ����ǽ��������Τǡ���������� size_is ��̾�����Ѵ�������ǥ����å�����
          if a.get_size_is then
            ### p "attr: get_size_is"
            cj = @compositecelltypejoin_list.get_item a.get_name.to_sym
            if cj.get_port_decl.instance_of? Decl then
              ### p "attr: get_size_is 2"
              # cj_size_is �ϡ�������������� attr �� size_is
              cj_size_is = cj.get_port_decl.get_size_is
              if cj_size_is == nil then
                cdl_error( "S9999 \'$1\' has size_is but export attr \'$2\' doesn't have", a.get_name, cj.get_name )
              end
              exprs = a.get_size_is.to_s
              ### p "exprs : ", exprs
              remain = exprs
              inner_to_export = {}
			  ### exprs �˴ޤޤ�뼱�̻Ҥ�ȴ���Ф����б����� export �����̾����õ��
              while remain != "" && remain != nil
                ### p "remain ", remain
                remain =~ /([^\w]*)([_A-Za-z][\w\d]*)/   # �ѿ�̾ʸ�������Ф� 
				if $2 == nil then
						break
				end
                arg_name = $2.to_sym
                remain = $'
                ### p exprs, $1, $2, $'
                # size_is �˴ޤޤ���ѿ��ϡ�composite �� export ����Ƥ��뤫
                cj2 = nil
                @compositecelltypejoin_list.get_items.each{ |cj2t|
                  if cj2t.get_cell_elem_name == arg_name then
                    cj2 = cj2t
                  end
                }
                if cj2 == nil then
                  cdl_error( "S9999 \'$1\' size_is argument of \'$2\' not exported", a.get_name, cj.get_name )
                  next
                end
                if cj2.get_port_decl.instance_of? Decl then
                   decl2 = cj2.get_port_decl
                   # ������̾���ȳ�����̾�����б��ط��򵭲�
                   inner_to_export[arg_name] = decl2.get_name
                # else cj2 �� Port (���˥��顼)
                end
              end
              # ������̾��������̾�����ִ�
              inner_to_export.each{ |arg_name, exp_name|
                ### p "changing #{arg_name}=>#{exp_name}"
                # exprs.gsub!( Regexp.new("#{arg_name}[^0-9A-Za-z_]"), exp_name.to_s )
                exprs.gsub!( Regexp.new("#{arg_name}(\\W)"), exp_name.to_s+"\\1" )  # ʸ���������ˤʤ�������
                exprs.gsub!( Regexp.new("#{arg_name}\\Z"), exp_name.to_s )          # ʸ���������ˤ��륱����
              }
              ### p "changed: #{exprs} #{cj_size_is.to_s}"
              if exprs != cj_size_is.to_s then
                cdl_error( "S9999 \'$1\' size_is argument mismatch with exporting one \'$2\'", a.get_name, cj.get_name )
              end
            # else cj �� Port (���˥��顼)
            end
          end
        end    
      end

      if b_init == false then
          cdl_error( "S1052 attribute \'$1\' not initialized in cell \'$2\'" , a.get_name, @name )
      end
   
    }
  end

  #=== Cell# �� require ������å�����
  # �� require ���ꤵ�줿��������ʣ���η�礬�ʤ��������å�����
  # composite ���������� (f_cloned=true) ������å�����
  def check_reverse_require
    # celltype ���ʤ���Х����å����ʤ��ʴ��˥��顼��
    return if @celltype == nil
    return if @b_defined == false

    # p "check reverse require   #{@name}"
    # ��require ���ꤵ�줿��������ʣ���η�礬�ʤ��������å�
    @referenced_port_list.each{ |port,count|
      # p port.class, count
      # p port.get_name, port.get_port_type, port.get_signature.get_name
      if port.is_reverse_required? && count > 1 then
        cdl_warning( "W1009 $1: fixed join entry port has multi join", port.get_name )
      end
    }
  end

  #=== Cell# require �ƤӸ��η���Ԥ�
  #cp_name:: Symbol           : �ƤӸ�̾
  #cell_or_t:: Celltype|Cell  : celltype �� require �α��դǻ��ꤵ�줿���륿���פޤ��ϥ���
  #port::  Port               : celltype �� Port ���֥�������
  def set_require_join( cp_name, cell_or_ct, port )

    # set_require_join ��2�ٸƤӽФ����
    # 2���ܤ� post �����ɤ�����������       #####  ���ä��󸫹�碌�ʽ�ʣ���顼��ƨ����
    # if @require_joined_list[ cp_name ] then
    #   return
    # else
    #   @require_joined_list[ cp_name ] = true
    # end

    dbgPrint "set_require_join: #{@name}.#{cp_name} = #{cell_or_ct.get_name}.#{port.get_name}\n"

    if cell_or_ct.instance_of? Celltype then
      cell = cell_or_ct.get_singleton_cell @region
      if cell == nil then
        cdl_error( "S1025 not found reachable cell for require \'$1\' in celltype \'$2\'" , port.get_name, cell_or_ct.get_name )
        return
      end
    else
      # require: cell �ǻ���
      cell = cell_or_ct
      if @region.distance( cell.get_region ) == nil then
        cdl_error( "S1026 required cell \'$1\' not reachable" , cell.get_name )
      end
    end

    if @join_list.get_item( cp_name ) then
      cdl_warning( "W1003 $1 : require call port overridden in $2" , cp_name, @name )
    else
      # require �� join ������(�ƤӸ��η��)
#      rhs = Expression.new( [ :OP_DOT, [ :IDENTIFIER, Token.new( cell.get_name, nil, nil, nil ) ],
      nsp = NamespacePath.new( cell.get_name, false, cell.get_namespace )
      nsp.set_locale @locale
      rhs = Expression.new( [ :OP_DOT, [ :IDENTIFIER, nsp ],
                              Token.new( port.get_name, nil, nil, nil ) ] )   #1
      join = Join.new( cp_name, nil, rhs )
      self.new_join( join )

      join.set_definition( @celltype.find(join.get_name) )
    end
  end

  #=== Cell# Join �� definition ������ȥ����å�
  def set_definition_join
    return if @celltype == nil    # ���˥��顼���Ǥ��ڤ�
    return if @b_defined == false # �ץ�ȥ���������Τ�
    return if @b_checked == true  # ��������ʥ����å��˺Ѥ�

    dbgPrint "set_definition_join in #{@name}\n"

    # relay allocator �򤿤ɤäƺ������ʤ��褦����Ƭ�� @b_checked �� true �ˤ���
    @b_checked = true

    if ! @f_cloned then
      # compoiste ����Υ����󤵤줿��Τϡ�set_definition ����
      # ���� join �ϴ��� definition ����Ƥ���
      # ���Υ���ˤ����ơ����������å�����Ƥ���Τǡ���Ť˥����å�(throughŬ��)����Ƥ��ޤ�
      @join_list.get_items.each{ |join|
        dbgPrint " set_definition_join: checking #{@name}.#{join.get_name}\n"
        if join.get_array_member then
          port = @celltype.find(join.get_name)
          join.get_array_member2.each { |am|
            if am == nil then   # ̤���ξ�硢���顼�����å��� check_join
              if port && ! port.is_optional? then
                # �ƥ����Ѥ˥��顼��å���������
                # cdl_error( "TEMPORAL set_definition_join: uninitialized array member"  )
              end
              next
            end
            am.set_definition( port )
          }
        else
          join.set_definition( @celltype.find(join.get_name) )
        end
      }
    end

    # ��졼 join �� through �ץ饰����������ˤ����Ǥ��ʤ�
    # through ��˷���褬�����ؤ����� 
    create_relay_allocator_join

    # composite �����Ÿ��
    if ! @in_composite && ! @f_cloned && @celltype.instance_of?( CompositeCelltype ) then
      # composite ���륿������� composite ��Ÿ�����ʤ�
      # compoiste ����Ÿ����� composite ��Ÿ�����ʤ� (CompositeCelltype::expand ��ǺƵ�Ū�� expnad)
      expand
    end

    # celltype �� generate �����ꤵ�줵��Ƥ��뤫
    celltype_plugin = @celltype.get_celltype_plugin
    if celltype_plugin then
      begin
        celltype_plugin.new_cell self
      rescue Exception => evar
        cdl_error( "S1037 $1: celltype plugin fail to new_cell" , celltype_plugin.class.name )
        print_exception( evar )
      end
    end
  end

  #=== Cell# composite �����Ÿ��
  # ���Υ��뤬 composite ���륿����
  def expand

    #debug
    dbgPrint "expanding #{@name} #{@celltype.get_name}\n"

    # Ÿ�����줿����Υꥹ��
    @@cloned_cell_list = {}

    # composite celltype �� cell ��Ÿ��
    @cell_list, @cell_list2 = @celltype.expand( @name, @global_name, @NamespacePath, @join_list, @region, @plugin, @locale )

    # �ץ�ȥ����פ����Ȥ���Ƥ����硢�Ҥ⻲�Ȥ���Ƥ��뤳�Ȥˤ���
    if @f_ref then
      dbgPrint "expand: set_f_ref\n"
      set_f_ref
    end

    # �ƤӸ��α��դΥ���� clone ������Τ��ѹ�
    self.change_rhs_port

    # �ץ�ȥ�������������ꤵ��Ƥ�����Τ�ȿ�Ǥ���
    @entry_array_max_subscript.each{ |port,name|
      set_entry_inner_port_max_subscript( port, name )
    }
  end

  def show_tree( indent )
    indent.times { print "  " }
    puts "Cell: name: #{@name} in_composite: #{@in_composite} def: #{@b_defined} ref: #{@f_ref} cloned: #{@f_cloned}"
    (indent+1).times { print "  " }
    puts "Cell locale: #{@name}@#{@locale[0]}##{@locale[1]}"
    (indent+1).times { print "  " }
    puts "id: #{@id}  global_name: #{@global_name}  region: #{@region.get_name} plugin: #{@plugin.class.name} #{self}"
    (indent+1).times { print "  " }
    puts "namespace_path: #{@NamespacePath}"

    if @celltype then
      (indent+1).times { print "  " }
      puts "celltype: #{@celltype.get_name}"
    end
    @join_list.show_tree( indent + 1 )
    @entry_array_max_subscript.each{ |port, num|
      (indent+1).times { print "  " }
      puts "entry array #{port.get_name}: max subscript=#{num}"
    }
    if @cell_list then   # ������ @cell_list �� nil �ʤΤ� Bug
      (indent+1).times { print "  " }
      puts "cloned cell list:"
      @cell_list.each { |n,c|
        (indent+2).times { print "  " }
        puts "inner cell : #{n} = #{c.get_name}"
      }
    end
    if @compositecelltypejoin_list then
      @compositecelltypejoin_list.get_items.each{ |cj|
        cj.show_tree( indent+1 )
      }
    end
    if @alloc_list.length > 0 then
      (indent+1).times { print "  " }
      puts "allocator list: "
      @alloc_list.each { |a|
        cp_name = :"#{a[0+1]}_#{a[2+1]}_#{a[3+1]}"
        if a[1+1] then
          # subscript = "[#{a[1+1].eval_const nil}]"
          subscript = "[#{a[1+1]}]"
        else
          subscript = ""
        end
        # ���������ƤӸ��η�������
        (indent+2).times { print "  " }
        puts "#{cp_name}#{subscript} = #{a[4+1]}"
      }
    end
    @referenced_port_list.each{ |port,count|
      (indent+1).times { print "  " }
      puts( "#{port.get_name} : #{count} times referenced" )
    }
  end

end

class CompositeCelltype < NSBDNode # < Nestable
# @name:: str
# @global_name:: str
# @cell_list:: NamedList   Cell
# @export_name_list:: NamedList : CompositeCelltypeJoin
# @port_list:: CompositeCelltypeJoin[]
# @attr_list:: CompositeCelltypeJoin[]
# @b_singleton:: bool : 'singleton' specified
# @b_active:: bool : 'active' specified
# @real_singleton:: bool : has singleton cell in this composite celltype
# @real_active:: bool : has active cell in this composite celltype
# @name_list:: NamedList item: Decl (attribute), Port �������ݡ������
# @internal_allocator_list:: [ [cell, internal_cp_name, port_name, func_name, param_name, ext_alloc_ent], ... ]

  @@nest_stack_index = -1
  @@nest_stack = []
  @@current_object = nil

  def self.push
    @@nest_stack_index += 1
    @@nest_stack[ @@nest_stack_index ] = @@current_object
    @@current_object = nil
  end

  def self.pop
    @@current_object = @@nest_stack[ @@nest_stack_index ]
    @@nest_stack_index -= 1
    if @@nest_stack_index < -1 then
      raise "TooManyRestore"
    end
  end

  def initialize( name )
    super()
    @name = name
    @cell_list = NamedList.new( nil, "in composite celltype #{name}" )
    @export_name_list = NamedList.new( nil, "export in composite celltype #{name}" )
    @name_list = NamedList.new( nil, "in composite celltype #{name}" )
    @@current_object = self

    @b_singleton = false
    @real_singleton = nil
    @b_active = false
    @real_active = nil
    if "#{Namespace.get_global_name}" == "" then
      @global_name = @name
    else
      @global_name = :"#{Namespace.get_global_name}_#{@name}"
    end

    Namespace.new_compositecelltype( self )
    set_namespace_path # @NamespacePath ������

    @port_list = []
    @attr_list = []
    @internal_allocator_list = []
    set_specifier_list( Generator.get_statement_specifier )
  end

  def self.end_of_parse
    @@current_object.end_of_parse
    @@current_object = nil
  end

  # CompositeCelltype#end_of_parse
  def end_of_parse

    # singleton �˴ؤ�������å�
    if @b_singleton && @real_singleton == nil then
      cdl_warning( "W1004 $1 : specified singleton but has no singleton in this celltype" , @name )
    elsif ! @b_singleton && @real_singleton != nil then
      if ! @b_singleton then
        cdl_error( "S1053 $1 must be singleton. inner cell \'$2\' is singleton" , @name, @real_singleton.get_name )
      end
    end

    # active �˴ؤ�������å�
    if @b_active && @real_active == nil then
      cdl_error( "S1054 $1 : specified active but has no active in this celltype" , @name )
    elsif ! @b_active && @real_active != nil then
      cdl_error( "S1055 $1 must be active. inner cell \'$2\' is active" , @name, @real_active.get_name )
    end

    # @allocator_instance �����ꤹ��
    @name_list.get_items.each{ |n|
      if n.instance_of? Port then
        n.set_allocator_instance
      end
    }

    # ��졼���������� entry ¦
    @port_list.each{ |p|
      if p.get_port_type == :ENTRY then
        if p.get_allocator_instance == nil then
          next
        end

        p.get_allocator_instance.each{ |name,ai|
          if ai[0] == :RELAY_ALLOC then
            self.new_join( :"#{p.get_name}_#{ai[4]}_#{ai[5]}", p.get_cell_name, :"#{p.get_cell_elem_name}_#{ai[4]}_#{ai[5]}", :CALL )
          end
        }
      end
    }
    # mikan relay ��������ȴ���Ƥ��뤫�����å�����Ƥ��ʤ�

    # ��̣����
    @cell_list.get_items.each{ |c|
      c.set_definition_join
    }

    # cell ��̤���θƤӸ����ʤ��������å�
    @cell_list.get_items.each{ |c|
      c.check_join
      c.check_reverse_require
    }

    # �ƤӸ��η��ˤĤ��ơ�export ����������ξ�����ʤ��������å�
    # ��졼����������������������������
    @port_list.each{ |p|
      p.check_dup_init
    }

    # ���٤ƤΥ������ݡ���������б������ƤӸ�����������°����¸�ߤ��뤫�����å�
    @name_list.get_items.each{ |n|
      if( @export_name_list.get_item( n.get_name ) == nil )then
        cdl_error( "S1056 $1 : cannot export, nothing designated" , n.get_name )
      end
    }

    # �����������������ꤹ��
    @internal_allocator_list.each{ |cell, cp_internal_name, port_name, fd_name, par_name, ext_alloc_ent|
      res = ext_alloc_ent.get_allocator_rhs_elements( :INTERNAL_ALLOC )
      ep_name = res[0]
      cj = @export_name_list.get_item( ep_name )
      internal_alloc_name_from_port_def = cj.get_cell_name
      internal_alloc_ep_name_from_port_def = cj.get_cell_elem_name

      # puts "internal_allocator #{cell.get_name} #{cp_internal_name} #{port_name}.#{fd_name}.#{par_name}"
      cell.get_allocator_list.each{ |a|
        # puts "allocator_list of #{cell.get_name} #{a[0]} #{a[1]}.#{a[2]}.#{a[3]}.#{a[4]} #{a[5].to_s}"
        if cp_internal_name == :"#{a[1]}_#{a[3]}_#{a[4]}" then
          dbgPrint "internal_allocator {cp_internal_name} #{a[1]}_#{a[3]}_#{a[4]}\n"
          dbgPrint "internal_allocator: #{a[5]}, #{internal_alloc_name_from_port_def}.#{internal_alloc_ep_name_from_port_def}\n"
          if a[5].to_s != "#{internal_alloc_name_from_port_def}.#{internal_alloc_ep_name_from_port_def}" then
            cdl_error( "S9999 $1: allocator mismatch from $2's allocator", "#{port_name}.#{fd_name}.#{par_name}", cell.get_name  )
          end
        end
      }
    }
  end

 ### cell (CompositeCelltype)
  def self.new_cell( cell )
    @@current_object.new_cell( cell )

  end

  def new_cell( cell )
    cell.set_owner self  # Cell (in_omposite)
    @cell_list.add_item( cell )
    if cell.get_celltype then    # nil �ʤ�С����Ǥ˥��륿���פʤ����顼
      if cell.get_celltype.is_singleton? then
        @real_singleton = cell
      end
      if cell.get_celltype.is_active? then
        @real_active = cell
      end
    end
  end

 ### join
  def self.new_join( export_name, internal_cell_name,
			 internal_cell_elem_name, type )
    @@current_object.new_join( export_name, internal_cell_name,
					 internal_cell_elem_name, type )
    
  end

  #=== CompositeCelltype# CompositeCelltypeJoin �����
  #export_name:: Symbol : �����˸�������̾��
  #internal_cell_name:: Symbol : ��������̾
  #internal_cell_elem_name:: Symbol : �������������̾�ʸƤӸ�̾��������̾��°��̾�Τ����줫��
  #type::  :CALL, :ENTRY, :ATTRIBUTE �Τ����줫�ʹ�ʸ���ǤȤ��Ƥ���٤���Ρ�
  #RETURN:: Decl | Port : �������ݡ������
  # new_join ��
  #   cCall => composite.cCall;     (������)
  #   attr = composite.attr;        (������)
  #   composite.eEnt => cell2.eEnt; (���볰)
  # �ι�ʸ���Ǥνи����Ф��ƸƤӽФ����
  def new_join( export_name, internal_cell_name,
		 internal_cell_elem_name, type )

    dbgPrint "new_join: #{export_name} #{internal_cell_name} #{internal_cell_elem_name}\n"

    cell = @cell_list.get_item( internal_cell_name )
    if cell == nil then
      cdl_error( "S1057 $1 not found in $2" , internal_cell_name, @name )
      return
    end

    celltype = cell.get_celltype
    return if celltype == nil	# celltype == nil �ʤ餹�Ǥ˥��顼

    # ��������Υ��륿���פ����б����Ǥ�õ��
    # ���Υ᥽�åɤϡ���ʸ�塢�ƤӸ�����������°�������ҤǤ���ս꤫��ƽФ����
    # ��ʸ��θƽФ����֡ʵ��Ұ��֡ˤȡ����Ǥ��б�������Τ������å�
    obj = celltype.find( internal_cell_elem_name )
    if obj.instance_of?( Decl ) then
      if obj.get_kind == :VAR then
        cdl_error( "S1058 \'$1\' : cannot export var" , internal_cell_elem_name )
        return
      elsif type != :ATTRIBUTE then
        cdl_error( "S1059 \'$1\' : exporting attribute. write in cell or use \'=\' to export attribute" , export_name )
        # return ���Υ��顼���򤱤뤿��˽���³�Ԥ����դ��ä��Ƥߤ�
      end
    elsif obj.instance_of?( Port ) then
      if obj.get_port_type != type then
        cdl_error( "S1060 \'$1\' : port type mismatch. $2 type is allowed here." , export_name, type )
        # return ���Υ��顼���򤱤뤿��˽���³�Ԥ����դ��ä��Ƥߤ�
      end
    else
      cdl_error( "S1061 \'$1\' : not defined" , internal_cell_elem_name )
      dbgPrint "S1061 CompositeCelltypeJoin#new_join: #{export_name} => #{internal_cell_name}.#{internal_cell_elem_name} #{type}\n"
      return
    end

    # �������ݡ�������Ȱ��פ��뤫�ɤ��������å�
    obj2 = @name_list.get_item( export_name )
    if( obj2 == nil )then
      cdl_error( "S1062 $1 has no export definition" , export_name )
    elsif obj2.instance_of?( Decl ) then
      if( ! obj.instance_of? Decl )then
        cdl_error( "S1063 $1 is port but previously defined as an attribute" , export_name )
      elsif ! obj.get_type.equal? obj2.get_type then
        cdl_error( "S1064 $1 : type \'$2$3\' mismatch with pprevious definition\'$4$5\'" , export_name, obj.get_type.get_type_str, obj.get_type.get_type_str_post, obj2.get_type.get_type_str, obj2.get_type.get_type_str_post )
      end
    elsif obj2.instance_of?( Port ) then
      if( obj.instance_of? Port )then
        if( obj.get_port_type != obj2.get_port_type )then
          cdl_error( "S1065 $1 : port type $2 mismatch with previous definition $3" , export_name, obj.get_port_type, obj2.get_port_type )
        elsif obj.get_signature != obj2.get_signature then
          if obj.get_signature != nil && obj2.get_signature != nil then
            # nil �ʤ�д��˥��顼�ʤΤ���𤷤ʤ�
            cdl_error( "S1066 $1 : signature \'$2\' mismatch with previous definition \'$3\'" , export_name, obj.get_signature.get_name, obj2.get_signature.get_name )
          end
        elsif obj.get_array_size != obj2.get_array_size then
          cdl_error( "S1067 $1 : array size mismatch with previous definition" , export_name )
        elsif obj.is_optional? != obj2.is_optional? then
          cdl_error( "S1068 $1 : optional specifier mismatch with previous definition" , export_name )
        end
      else
        cdl_error( "S1069 $1 is an attribute but previously defined as a port" , export_name )
      end
    end

    join = CompositeCelltypeJoin.new( export_name, internal_cell_name,
				 internal_cell_elem_name, cell, obj2 )
    join.set_owner self   # CompositeCelltypeJoin
    cell.add_compositecelltypejoin join

    # debug
    dbgPrint "compositecelltype join: add #{cell.get_name} #{export_name} = #{internal_cell_name}.#{internal_cell_elem_name}\n"

    if obj.instance_of?( Decl ) then
      # attribute
      @attr_list << join
    else
      # call/entry port
      @port_list << join
    end

    # join �� @export_name_list ����Ͽ�ʽ�ʣ�����å��ȤȤ�ˡ���ǹԤ��� CompositeCelltypeJoin �� clone ���������
    if obj.instance_of?( Decl ) && @export_name_list.get_item( export_name ) then
      # ����¸�ߤ��롣�ɲä��ʤ��������ͤǤϡ�@export_name_list ��Ʊ��̾�����ޤޤ�뤳�Ȥ����롣
    elsif obj.instance_of?( Port ) && obj.get_port_type == :CALL && @export_name_list.get_item( export_name ) then
      # ����¸�ߤ��롣�ɲä��ʤ��������ͤǤϡ�@export_name_list ��Ʊ��̾�����ޤޤ�뤳�Ȥ����롣
    else
      @export_name_list.add_item( join )
    end

    # export ����ݡ��Ȥ˴ޤޤ�� send/receive �ѥ�᡼���Υ�������(allocator)�ƤӸ��򥻥�ȷ��
    if obj2.instance_of? Port then
      obj2.each_param{ |port, fd, par|
        case par.get_direction                        # ��������������� (in, out, inout, send, receive )
        when :SEND, :RECEIVE
          cp_name = :"#{port.get_name}_#{fd.get_name}_#{par.get_name}"     # ���������ƤӸ���̾��
          #            �ݡ���̾         �ؿ�̾         �ѥ�᡼��̾
          cp_internal_name = :"#{internal_cell_elem_name}_#{fd.get_name}_#{par.get_name}"

          # ��졼�������� or ���������������꤬�ʤ���Ƥ����硢���������ƤӸ����ɲä��ʤ�
          # ���λ����Ǥ� get_allocator_instance �Ǥ������ʤ����� tmp ������
          if port.get_allocator_instance_tmp then
            found = false
            port.get_allocator_instance_tmp.each { |s|
              if s[1] == fd.get_name && s[2] == par.get_name then
                found = true

                if s[0] == :INTERNAL_ALLOC then
                  # �������������ξ��    # mikan ����������Υ����ľ�뤹�롣�����Υݡ��Ȥ˲����٤�
                  @internal_allocator_list << [ cell, cp_internal_name, port.get_name, fd.get_name, par.get_name, s[3] ]
                end
              end
            }
            if found == true
              next
            end
          end

          # �������������ξ��
          new_join( cp_name, internal_cell_name, cp_internal_name, :CALL )
        end
      }
    end

    # �������ݡ���������֤�
    return obj2
  end

  def self.has_attribute? attr
    @@current_object.has_attribute? attr
  end

  def has_attribute? attr
    @name_list.get_item( attr ) != nil
  end

  def self.new_port port
    @@current_object.new_port port
  end

  #=== CompositeCelltype# new_port
  def new_port port
    port.set_owner self   # Port (CompositeCelltype)
    dbgPrint "new_port: #{@owner.get_name}.#{port.get_name}\n"
    @name_list.add_item port

    # export ����ݡ��Ȥ˴ޤޤ�� send/receive �ѥ�᡼���Υ��������ƤӸ��� export ���������ƥݡ��Ȥ��ɲ�
    # ���λ����Ǥ����������������ɤ���Ƚ�ǤǤ��ʤ��Τǡ��Ȥꤢ�����������Ƥ���
    port.each_param { |port, fd, par|
      case par.get_direction                        # ��������������� (in, out, inout, send, receive )
      when :SEND, :RECEIVE
        #### ��졼�������� or ���������������꤬�ʤ���Ƥ����硢���������ƤӸ����ɲä��ʤ�
        # ���������������꤬�ʤ���Ƥ����硢���������ƤӸ����ɲä��ʤ�
        # ���λ����Ǥ� get_allocator_instance �Ǥ������ʤ����� tmp ������
        if port.get_allocator_instance_tmp then
          found = false
          port.get_allocator_instance_tmp.each { |s|
            if s[0] == :INTERNAL_ALLOC && s[1] == fd.get_name && s[2] == par.get_name then
              found = true
              break
            end
          }
          if found == true
            next
          end
        end

        if par.get_allocator then
          cp_name = :"#{port.get_name}_#{fd.get_name}_#{par.get_name}"     # ���������ƤӸ���̾��
          #           �ݡ���̾          �ؿ�̾         �ѥ�᡼��̾
          alloc_sig_path = [ par.get_allocator.get_name ]  # mikan Namespace ���������ƤӸ��Υ����˥���
          array_size = port.get_array_size            # �ƤӸ��ޤ��ϼ���������Υ�����
          created_port = Port.new( cp_name, alloc_sig_path, :CALL, array_size ) # �ƤӸ�������
          created_port.set_allocator_port( port, fd, par )
          new_port( created_port )           # ���륿���פ˿������ƤӸ����ɲ�
        # else
        #   already error
        end
      end
    }
  end

  def self.new_attribute attr
    @@current_object.new_attribute attr
  end

  #=== CompositeCelltype# new_attribute for CompositeCelltype
  #attribute:: [Decl]
  def new_attribute( attribute )
    attribute.each { |a|
      a.set_owner self   # Decl (CompositeCelltype)
      # V1.1.0.10 composite �� attr �� size_is �ϲĤȤʤä�
      # if a.get_size_is then
      #  cdl_error( "S1070 $1: size_is pointer cannot be exposed for composite attribute" , a.get_name )
      # end
      @name_list.add_item( a )
      if a.get_initializer then
        a.get_type.check_init( @locale, a.get_identifier, a.get_initializer, :ATTRIBUTE )
      end
    }
  end

  #=== CompositeCelltype# ��require �η�����������
  def create_reverse_require_join cell
    @name_list.get_items.each{ |n|
      if n.instance_of? Port then
        n.create_reverse_require_join cell
      end
    }
  end

  # false : if not in celltype definition, nil : if not found in celltype
  def self.find( name )
    if @@current_object == nil then
      return false
    end
    @@current_object.find name
  end

  def find name
    dbgPrint "CompositeCelltype: find in composite: #{name}\n"
    cell = @cell_list.get_item( name )
    return cell if cell

    dbgPrint "CompositeCelltype: #{name}, #{@name_list.get_item( name )}\n"
    return @name_list.get_item( name )

    # �������
#    cj = @export_name_list.get_item( name )
#p "#{name}, #{cj.get_port_decl}"
#    if cj then
#      return cj.get_port_decl
#    else
#      return nil
#    end
  end

  #=== CompositeCelltype# export ���� CompositeCelltypeJoin ������
  #name:: string:
  # attribute �ξ�硢Ʊ��̾�����Ф�ʣ��¸�ߤ����ǽ�������뤬���ǽ�Τ�Τ����֤��ʤ�
  def find_export name
    return @export_name_list.get_item( name )
  end

  #=== CompositeCelltype# composite celltype �� cell ��Ÿ��
  #name:: string: Composite cell ��̾��
  #global_name:: string: Composite cell �� global name (C ����̾)
  #join_list:: NamedList : Composite cell ���Ф��� Join �� NamedList
  #RETURN:
  # [ { name => cell }, [ cell, ... ] ]
  #  ����� ���� ̾����clone���줿�������롢���� composite �νи���Υꥹ��
  def expand( name, global_name, namespacePath, join_list, region, plugin, locale )

    # debug
    dbgPrint "expand composite: #{@name} name: #{name}  global_name: #{global_name}\njoin_list:\n"
    join_list.get_items.each{ |j|
      dbgPrint "   #{j.get_name} #{j}\n"
    }
  
    # Ÿ���� clone ���줿����Υꥹ�ȡ����դ� Cell (composite �ξ�� composite �� cell �� clone)
    clone_cell_list = {}
    clone_cell_list2 = []

    #  composite �����Τ��٤Ƥ� cell �ˤĤ���
    @cell_list.get_items.each { |c|

      # debug
      dbgPrint "expand : cell #{c.get_name}\n"

      # Join ������
      ja = []

      # CompositeCelltype �� export ����ƤӸ�����������°���Υꥹ�ȤˤĤ���
      # @export_name_list.get_items.each{ |cj|	# cj: CompositeCelltypeJoin
      # �����ͤǤϡ�@export_name_list �����äƤ��ʤ� attr �����ꤦ��
      (@port_list+@attr_list).each{ |cj|	# cj: CompositeCelltypeJoin

        # debug
        dbgPrint "        cj : #{cj.get_name}\n"

        # CompositeCelltypeJoin (export) ���оݥ��뤫��
        if cj.match?( c ) then

          # �оݥ������ CompositeCelltype �� export ���� Join (attribute �ޤ��� call port)
          j = join_list.get_item( cj.get_name )

          # debug
          if j then
            dbgPrint "expand : parent cell: #{name} child cell: #{c.get_name}:  parent's export port: #{cj.get_name}  join: #{j.get_name} #{j}\n"
          else
            dbgPrint "expand : parent cell: #{name} child cell: #{c.get_name}:  parent's export port: #{cj.get_name}  join: nil\n"
          end

          if j then
            # �ƤӸ���°���ξ��
            #  ComositeCell �ѤΤ��(j) ���оݥ����Ѥ� clone (@through_list �⥳�ԡ������)
            # p "expand: cloning Join #{j.get_name} #{@name} #{name}"
            jc = j.clone_for_composite( @name, name, locale )
                                        # celltype_name, cell_name

            # debug
            # p "cn #{jc.get_name} #{cj.get_cell_elem_name}"

            # �оݥ���θƤӸ��ޤ���°����̾�����ѹ�
            jc.change_name( cj.get_cell_elem_name )

            # �оݥ�����Ф��� Join ������
            ja << jc
          end

          # debug
          dbgPrint "\n"
        end
      }

      # debug
      dbgPrint "expand : clone #{name}_#{c.get_name}\n"

      # ����� clone ������
#      clone_cell_list[ "#{name}_#{c.get_name}" ] =  c.clone_for_composite( name, global_name, ja )
      c2 =  c.clone_for_composite( name, global_name, namespacePath, ja, @name, region, plugin, locale )
      clone_cell_list[ "#{c.get_local_name}" ] = c2
      clone_cell_list2 << c2

    }

    clone_cell_list.each { |nm,c|
      dbgPrint "  cloned: #{nm} = #{c.get_global_name}\n"
      # join �� owner �� clone ���줿������ѹ����� V1.1.0.25
      c.get_join_list.get_items.each{ |j|
        j.set_cloned( clone_cell_list[ "#{c.get_local_name}" ] )
      }
    }
    return [ clone_cell_list, clone_cell_list2 ]
  end

  #=== CompositeCelltype ����ҥꥹ�Ȥ�����
  def set_specifier_list( spec_list )
    return if spec_list == nil

    spec_list.each { |s|
      case s[0]
      when :SINGLETON
        @b_singleton = true
      when :IDX_IS_ID
        cdl_warning( "W1005 $1 : idx_is_id is ineffective for composite celltype" , @name )
      when :ACTIVE
        @b_active = true
      else
        cdl_error( "S1071 $1 cannot be specified for composite" , s[0] )
      end
    }
  end

  def get_name
    @name
  end

  def get_port_list
    @port_list
  end

  def get_attribute_list
    @attr_list
  end

  def get_var_list
    []   # ����������֤�
  end

  def get_internal_allocator_list
    @internal_allocator_list
  end

  #== CompositeCelltype# generate ����Ҥξ���
  # CompositeCelltype �ˤ� generate ������Ǥ��ʤ��Τ� nil ���֤�
  # Celltype::@generate �򻲾ȤΤ���
  def get_celltype_plugin
    nil
  end

  def is_singleton?
    @b_singleton
  end

  def is_active?
    @b_active
  end

  #=== CompositeCelltype# �����ƥ��֤ǤϤʤ�
  # active �ǤϤʤ��˲ä������Ƥ���������Υ��륿���פ� inactive �ξ��� inactive
  # �������Υ��뤬 active �ޤ��� factory ����äƤ����
  def is_inactive?
    if @b_active == false then
      @cell_list.get_items.each{ |c|
        if c.get_celltype && c.get_celltype.is_inactive? == false then
          # c.get_celltype == nil �ξ��ϥ��륿����̤����Ǥ��Ǥ˥��顼
          return false
        end
      }
      return true
    else
      return false
    end
  end

  def get_id_base
    raise "get_id_base"
  end

  def show_tree( indent )
    indent.times { print "  " }
    puts "CompositeCelltype: name: #{@name}"
    (indent+1).times { print "  " }
    puts "active: #{@b_active}, singleton: #{@b_singleton}"
    @cell_list.show_tree( indent + 1 )
    (indent+1).times { print "  " }
    puts "name_list"
    @name_list.show_tree( indent + 2 )
    (indent+1).times { print "  " }
    puts "export_name_list"
    @export_name_list.show_tree( indent + 2 )
    if @internal_allocator_list.length > 0 then
      (indent+1).times { print "  " }
      puts "internal_allocator_list:"
      @internal_allocator_list.each{  |a|
        (indent+1).times { print "  " }
        puts "  #{a[0].get_name} #{a[1]} #{a[2]} #{a[3]} #{a[4]}"
      }
    end
  end

end



#== ��ʸ���ǡ�����ɽ�����饹�ʥ��륿���פθƤӸ�����������
class Port < BDNode
# @name::  str
# @signature:: Signature
# @port_type::  :CALL, :ENTRY
# @array_size:: nil: not array, "[]": sizeless, Integer: sized array
# @reverse_require_cell_path:: NamespacePath :     ��require�ƤӸ�����  mikan namespace (�ƤӸ��Τ߻����ǽ)
# @reverse_require_callport_name:: Symbol:  ��require�ƤӸ�����θƤӸ�̾
#
# set_allocator_port �ˤ�ä����ꤵ��롥���ꤵ�줿��硢���Υݡ��Ȥϥ��������ݡ��ȤǤ��롣
# @allocator_port:: Port : ���θƤӸ����Ǥ��븵�Ȥʤä��ƤӸ��ޤ��ϼ�����
# @allocator_func_decl:: Decl : ���θƤӸ����Ǥ��븵�Ȥʤä��ƤӸ��ޤ��ϼ������δؿ�
# @allocator_param_decl:: ParamDecl : ���θƤӸ����Ǥ��븵�Ȥʤä��ƤӸ��ޤ��ϼ������Υѥ�᡼��
#
# set_specifier �ˤ�ä����ꤵ���(
# @allocator_instance:: Hash : {"func_param" => [ :RELAY_ALLOC, func_name, param_name, rhs_cp_name, rhs_func_name, rhs_param_name ]}
#                                               [:INTERNAL_ALLOC, func_name, param_name, rhs_ep_name ]
# @allocator_instance_tmp:: Hash : {"func_param" => [:INTERNAL_ALLOC|:RELAY_ALLOC,  IDENTIFIER, IDENTIFIER, expression ],..}
#                                                                                    function    parameter   rhs
#
# @b_require:: bool : require �ˤ���������줿 call port �ξ�� true
# @b_has_name:: bool : require : ̾������Υꥯ�磻���ƤӸ�
# @b_inline:: bool : entry port �Τ�
# @b_optional:: bool : entry port �Τ�
#
# optimize::
# @celltype:: °���륻�륿����
#
# :CALL �ξ��κ�Ŭ��
# @b_VMT_useless:: bool                     # VMT �ؿ��ơ��֥����Ѥ��ʤ�
# @b_skelton_useless:: bool                 # ������ȥ�ؿ�����   (true �λ����������ؿ���ƽФ�)
# @b_cell_unique:: bool                     # �Ƥ����ͣ��Υ���
# @only_callee_port:: Port                  # ͣ��θƤ���ݡ���
# @only_callee_cell:: Cell                  # ͣ��θƤ��襻�� (@b_PEPDES_in_CB_useless = true �λ�ͭ��)
#
# :ENTRY �ξ��κ�Ŭ���ʸƤӸ���Ŭ����Ʊ���ѿ�̾����ѡ�
# @b_VMT_useless:: bool                     # VMT �ؿ��ơ��֥뤬����
# @b_skelton_useless:: bool                 # ������ȥ�ؿ�����

  def initialize( name, sig_path, port_type, array_size = nil, reverse_require_cell_path = nil, reverse_require_entry_port_name = nil )
    super()
    @name = name
    @port_type = port_type

    if array_size == "[]" then
#      if port_type == :ENTRY then
#        cdl_error( "S1072 $1: entry port: sizeless array not supported in current version" , name )
#      end
      @array_size = array_size
    elsif array_size then
      if array_size.kind_of? Expression then
        @array_size = array_size.eval_const(nil)
      else
        @array_size = array_size   # ����ϥ��������ƤӸ��ξ��ʸ��θƤӸ��Ǵ���ɾ���Ѥߡ�
      end
      if @array_size == nil then
        cdl_error( "S1073 Not constant expression $1" , array_size.to_s )
      end

      #if Integer( @array_size ) != @array_size || @array_size <= 0 then
      if ! @array_size.kind_of? Integer then
        cdl_error( "S1074 Not Integer $1" , array_size.to_s )
      end

    end

    object = Namespace.find( sig_path )    #1
    if object == nil then
      # mikan signature ��̾�����Դ���
      cdl_error( "S1075 \'$1\' signature not found" , sig_path )
    elsif ! object.instance_of?( Signature ) then
      # mikan signature ��̾�����Դ���
      cdl_error( "S1076 \'$1\' not signature" , sig_path )
    else
      @signature = object

    end

    # ��require
    @reverse_require_cell_path       = nil
    @reverse_require_entry_port_name = nil
    if reverse_require_cell_path then
      if port_type == :CALL then
        cdl_error( "S1152 $1 call port cannot have fixed join", @name )
      else
        @reverse_require_cell_path       = reverse_require_cell_path
        @reverse_require_entry_port_name = reverse_require_entry_port_name

        # ���������󤫡�
        if array_size then
          cdl_error( "S1153 $1: cannot be entry port array for fixed join port", @name )
        end

        # �ƤӸ��Υ��륿���פ�õ��
        ct_or_cell = Namespace.find( @reverse_require_cell_path )  #1
        if ct_or_cell.instance_of? Cell then
          ct = ct_or_cell.get_celltype
        elsif ct_or_cell.instance_of? Celltype then
          ct = ct_or_cell
          if ! ct.is_singleton? then
            cdl_error( "S1154 $1: must be singleton celltype for fixed join", @reverse_require_cell_path.to_s )
          end
        else
          ct = nil
          cdl_error( "S1155 $1: not celltype or not found", @reverse_require_cell_path.get_path_str)
        end

        if ct == nil then
          return    # ���˥��顼
        end

        # ź�����ʤ��θƤӸ����󤫡�
        port = ct.find( @reverse_require_entry_port_name )
        if port == nil || port.get_port_type != :CALL
          cdl_error( "S1156 $1: not call port or not found", @reverse_require_entry_port_name )
        else
          if port.get_array_size != "[]" then
            cdl_error( "S1157 $1: sized array or not array", @reverse_require_entry_port_name )
          end
        end

      end
    end

    @b_require = false
    @b_has_name = false
    @b_inline = false
    @b_optional = false
    reset_optimize
  end

  #=== Port#��Ŭ���˴ؤ����ѿ���ꥻ�åȤ���
  # Region ���Ȥ˺�Ŭ���Τ��ʤ����򤹤뤿�ᡢ�ꥻ�åȤ���
  def reset_optimize
    if @port_type == :CALL then
      # call port optimize
      @b_VMT_useless = false                     # VMT ���� (true �λ� VMT ��𤹤뤳�Ȥʤ��ƽФ�)
      @b_skelton_useless = false                 # ������ȥ�ؿ�����   (true �λ����������ؿ���ƽФ�)
      @b_cell_unique = false                     # ͣ��θƤ��襻��
      @only_callee_port = nil                    # ͣ��θƤ���ݡ���
      @only_callee_cell = nil                    # ͣ��θƤ��襻��
    else
      # entry port optimize
      if $unopt then
        # ��Ŭ���ʤ�
        @b_VMT_useless = false                     # VMT ���� (true �λ� VMT ��𤹤뤳�Ȥʤ��ƽФ�)
        @b_skelton_useless = false                 # ������ȥ�ؿ�����   (true �λ����������ؿ���ƽФ�)
      else
        # ��Ŭ������
        @b_VMT_useless = true                      # VMT ���� (true �λ� VMT ��𤹤뤳�Ȥʤ��ƽФ�)
        @b_skelton_useless = true                  # ������ȥ�ؿ�����   (true �λ����������ؿ���ƽФ�)
      end
    end
end

  def set_celltype celltype
    @celltype = celltype
  end

  def get_name
    @name
  end

  def get_port_type
    @port_type
  end

  def get_signature
    @signature
  end

  def get_array_size
    @array_size
  end

  def get_celltype
    @celltype
  end

  #=== Port# ���������ݡ��Ȥ�����
  #port:: Port : send/receive �Τ��ä��ƤӸ��ޤ��ϼ�����
  #fd:: Decl : �ؿ��� declarator
  #par:: ParamDecl : send/receive �Τ��ä�����
  # ���θƤӸ�������������Ȥˤʤä��ƤӸ��ޤ��ϼ������ξ��������
  def set_allocator_port( port, fd, par )
    @allocator_port = port
    @allocator_func_decl = fd
    @allocator_param_decl = par
  end

  def is_allocator_port?
    @allocator_port != nil
  end

  def get_allocator_port
    @allocator_port
  end

  def get_allocator_func_decl
    @allocator_func_decl
  end

  def get_allocator_param_decl
    @allocator_param_decl
  end

  def set_require( b_has_name )
    @b_require = true
    @b_has_name = b_has_name
  end

  def is_require?
    @b_require
  end

  #=== Port# require �ƤӸ���̾������ġ�
  # require ����
  def has_name?
    @b_has_name
  end

  def is_optional?
    @b_optional
  end

  def set_optional
    @b_optional = true
  end

  def set_VMT_useless                     # VMT �ؿ��ơ��֥����Ѥ��ʤ�
   @b_VMT_useless = true
  end

  def set_skelton_useless                 # ������ȥ�ؿ�����   (true �λ����������ؿ���ƽФ�)
    @b_skelton_useless = true
  end

  def set_cell_unique                     # �Ƥ��襻��ϰ�Ĥ���
    @b_cell_unique = true
  end

  #=== Port# �ƤӸ�/�������λ���Ҥ�����
  # inline, allocator �λ���
  def set_specifier spec_list
    spec_list.each { |s|
      case s[0]
      when :INLINE
        if @port_type == :CALL then
          cdl_error( "S1077 inline: cannot be specified for call port"  )
        end
        @b_inline = true
      when :OPTIONAL
        if @port_type == :ENTRY then
          cdl_error( "S1078 optional: cannot be specified for entry port"  )
        end
        @b_optional = true
      when :ALLOCATOR
        if @port_type == :CALL then
          cdl_error( "S1079 allocator: cannot be specified for call port"  )
        end
        if @allocator_instance_tmp then
          cdl_error( "S1080 duplicate allocator specifier"  )
        end
        @allocator_instance_tmp = s[1]
      else
        raise "unknown specifier #{s[0]}"
      end
    }
  end

  #=== Port# ��졼�����������������������Υ��󥹥��󥹤�����
  # �ƤӸ����������Ȳ�ǽ�ʤ褦�ˡ����륿���פβ��κǸ�ǹԤ�
  def set_allocator_instance
    if @allocator_instance_tmp == nil then
      return
    end

    @allocator_instance = {}
    @allocator_instance_tmp.each { |ai|
      direction = nil
      alloc_type = ai[0]
      # ai = [ :INTERNAL_ALLOC|:RELAY_ALLOC, func_name, param_name, rhs ]
      case alloc_type
      when :INTERNAL_ALLOC
        if ! @owner.instance_of? CompositeCelltype then # �ߥ����ɤ������ composite �Ǥʤ���ФȤ���
          cdl_error( "S1081 self allocator not supported yet"  )   # mikan ����ϥ��ݡ��Ȥ���Ƥ���Ϥ�����Ĵ�� 12/1/15
          next
        end
        # OK
      when :RELAY_ALLOC
        # OK
      when :NORMAL_ALLOC
        # ���������Τ� composite �μ������Ǳ��դ� "eEnt.func.param" �����ǻ��ꤵ��Ƥ������
        cdl_error( "S9999 $1 not suitable for lhs, suitable lhs: 'func.param'", "#{ai[1]}.#{ai[3]}.#{ai[4]}" )
        next
      else
        raise "Unknown allocator type #{ai[1]}"
      end

      # '=' ����(func_name,param_name)�ϼºߤ��뤫?
      if @signature then       # signature = nil �ʤ���˥��顼
        fh = @signature.get_function_head( ai[1] )
        if fh == nil then
          cdl_error( "S1082 function \'$1\' not found in signature" , ai[1] )
          next
        end
        decl = fh.get_declarator
        if ! decl.is_function? then
          next   # ���˥��顼
        end
        paramdecl = decl.get_type.get_paramlist.find( ai[2] )
        if paramdecl == nil then
          cdl_error( "S1083 \'$1\' not found in function \'$2\'" , ai[2], ai[1] )
          next
        end
        case paramdecl.get_direction
        when :SEND, :RECEIVE
          # OK
          direction = paramdecl.get_direction
        else
          cdl_error( "S1084 \'$1\' in function \'$2\' is not send or receive" , ai[2], ai[1] )
          next
        end
      end

      # ��ʣ���꤬�ʤ���?
      if @allocator_instance[ "#{@name}_#{ai[1]}_#{ai[2]}" ] then
        cdl_error( "S1085 duplicate allocator specifier for \'$1_$2\'" , ai[1], ai[2] )
      end

      # ���դΥ����å�
      case alloc_type
      when :INTERNAL_ALLOC

        ele = ai[3].get_elements
        if( ele[0] != :IDENTIFIER )then
          cdl_error( "S1086 $1: rhs not in 'allocator_entry_port' form", ai[3].to_s )
          next
        end

        ep_name = ele[1]   # ��������������̾
        ep = @owner.find ep_name.get_path[0]  # mikan "a::b"
        if ep == nil || ! ep.instance_of?( Port ) || ep.get_port_type != :ENTRY || ! ep.get_signature.is_allocator? then
          cdl_error( "S9999 $1 not found or not allocator entry port for for $2" , ep_name, ai[1] )
        end
        # ���ե����å������
        # ai2 = [ :INTERNAL_ALLOC, func_name, param_name, rhs_ep_name ]
        ai2 = [ ai[0], ai[1], ai[2], ep_name ]

      when :RELAY_ALLOC
        ele = ai[3].get_elements
        if( ele[0] != :OP_DOT ||
            ele[1][0] != :OP_DOT || ele[1][1][0] != :IDENTIFIER || ! ele[1][1][1].is_name_only? ||
            ! ele[1][2].instance_of?( Token ) || ! ele[2].instance_of?( Token ) )then   #1
          # [ :OP_DOT, [ :OP_DOT, [ :IDENTIFIER,  name_space_path ],  Token(1) ],  Token(2) ]
          #    ele[0]    ele[1][0]  ele[1][1][0]  ele[1][1][1]        ele[1][2]    ele[2]
          #      name_space_path.Token(1).Token(2) === call_port.func.param
          #  mikan Expression#analyze_cell_join_expression ���Ѽ����������֤�������٤�

          cdl_error( "S9999 rhs not in 'call_port.func.param' form for for $1_$2" , ai[1], ai[2] )   # S1086
          next
        end
        func_name = ele[1][2]; cp_name = ele[1][1][1].get_name; param_name = ele[2].to_sym
        cp = @owner.find cp_name    # ��졼������θƤӸ�
        if cp then
# mikan cp ���ƤӸ��Ǥ��뤳�ȤΥ����å���°���ξ��⤢���
# mikan ����������������ؤΥ�졼�ؤ��б� (�ƤӸ�����ƤӸ��ؤΥ�졼�Ϥ��ꤨ�ʤ�)  <=== ʸˡ�ˤ���������ʸƤӸ�¦�ǥ������������ꤵ����
          sig = cp.get_signature
          if sig && @signature then
            fh = @signature.get_function_head( func_name )
            if fh == nil then
              cdl_error( "S1087 function \'$1\' not found in signature \'$2\'" , func_name, sig.get_name )
              next
            end
            decl = fh.get_declarator
            if ! decl.is_function? then
              next   # ���˥��顼
            end
            paramdecl = decl.get_type.get_paramlist.find( param_name )
            if paramdecl == nil then
              cdl_error( "S1088 \'$1\' not found in function \'$2\'" , param_name, func_name )
              next
            end
            case paramdecl.get_direction
            when :SEND, :RECEIVE
              # OK
              if alloc_type == :RELAY_ALLOC && direction != paramdecl.get_direction then
                cdl_error( "S1089 relay allocator send/receive mismatch between $1.$2 and $3_$4.$5" , ai[1], ai[2], cp_name, func_name, param_name )
              end
            else
              cdl_error( "S1090 \'$1\' in function \'$2\' is not send or receive" , param_name, func_name )
              next
            end

            # else
            # sig == nil �ʤ�д��˥��顼
          end
        else
          if @celltype then
            ct_name = @celltype.get_name
          else
            ct_name = "(None)"
          end
          cdl_error( "S1091 call port \'$1\' not found in celltype $2" , cp_name, ct_name )
          next
        end
        # ���ե����å������
        # ai2 = [ :RELAY_ALLOC, func_name, param_name, rhs_cp_name, rhs_func_name, rhs_param_name ]
        ai2 = [ ai[0], ai[1], ai[2], cp_name, func_name, param_name ]
      end # case alloc_type

      @allocator_instance[ "#{@name}_#{ai[1]}_#{ai[2]}" ] = ai2
    }
  end

  def is_inline?
    @b_inline
  end

  def is_VMT_useless?                     # VMT �ؿ��ơ��֥����Ѥ��ʤ�
   @b_VMT_useless
  end

  def is_skelton_useless?                 # ������ȥ�ؿ�����   (true �λ����������ؿ���ƽФ�)
    @b_skelton_useless
  end

  def is_cell_unique?                     # �Ƥ���Υ���ϰ�ġ�
    @b_cell_unique
  end

  #=== Port# ��������Ŭ��������
  # ���μ������򻲾Ȥ���ƤӸ��� VMT, skelton ��ɬ�פȤ��Ƥ��뤫�ɤ���������
  # ��ĤǤ�ƤӸ���ɬ�פȤ��Ƥ���ʤ��ʤ�� b_*_useless �� false�˾��ϡ�
  # ���μ������κ�Ŭ���� false �Ȥ���
  def set_entry_VMT_skelton_useless( b_VMT_useless, b_skelton_useless )
    if ! b_VMT_useless then
      @b_VMT_useless = false
    end
    if ! b_skelton_useless then
      @b_skelton_useless = false
    end
  end

  #=== Port# ͣ��η���������
  # ��Ŭ���ǻ���
  #  b_VMT_useless == true || b_skelton_useless == true �λ������ꤵ���
  #  optional �ξ�� callee_cell, callee_port �� nil �Ȥʤ�
  def set_only_callee( callee_port, callee_cell )
    @only_callee_port = callee_port
    @only_callee_cell = callee_cell
  end

  #=== Port# ͣ��η����ݡ��Ȥ��֤�(composite�ξ��¥���)
  # optional �ƤӸ���̤���ξ�� nil ���֤�
  def get_real_callee_port
    if @only_callee_cell then
      return @only_callee_cell.get_real_port( @only_callee_port.get_name )
    end
  end

  #=== Port# ͣ��η���襻����֤�(composite�ξ��¥���)
  # optional �ƤӸ���̤���ξ�� nil ���֤�
  def get_real_callee_cell
    if @only_callee_cell then
      return @only_callee_cell.get_real_cell( @only_callee_port.get_name )
    end
  end

  def get_allocator_instance
    return @allocator_instance
  end

  def get_allocator_instance_tmp
    return @allocator_instance_tmp
  end

  #=== Port# ��require �η�����������
  def create_reverse_require_join cell
    if @reverse_require_cell_path == nil then
      return
    end

    # �ƤӸ������õ��
    ct_or_cell = Namespace.find( @reverse_require_cell_path )   # mikan namespace    #1
    if ct_or_cell.instance_of? Cell then
      cell2 = ct_or_cell
      ct = cell2.get_celltype
      if ct == nil then
        return    # ���˥��顼
      end
    elsif ct_or_cell.instance_of? Celltype then
      cell2 = ct_or_cell.get_singleton_cell( cell.get_region )
      if cell2 == nil then
        cdl_error( "S1158 $1: singleton cell not found for fixed join", ct_or_cell.get_name )
        return
      end
      ct = ct_or_cell
    else
      # ���˥��顼��̵��
      return
    end

    # ������������
    dbgPrint "create_reverse_require_join #{cell2.get_name}.#{@reverse_require_entry_port_name}[] = #{cell.get_name}.#{@name}"
    nsp = NamespacePath.new( cell.get_name, false, cell.get_namespace )
#    rhs = Expression.new( [ :OP_DOT, [ :IDENTIFIER, Token.new( cell.get_name, nil, nil, nil ) ],
    rhs = Expression.new( [ :OP_DOT, [ :IDENTIFIER, nsp ],
                            Token.new( @name, nil, nil, nil ) ] )   #1
    join = Join.new( @reverse_require_entry_port_name, -1, rhs )
    cell2.new_join( join )
    join.set_definition( ct.find(join.get_name) )

  end

  #=== Port# signature �Τ��٤Ƥδؿ��Τ��٤ƤΥѥ�᡼���򤿤ɤ�
  #block:: �֥�å�������Ȥ��Ƽ��(ruby ��ʸˡ�ǽ񤫤ʤ�)
  #  �֥�å���3�Ĥΰ�����������(Port, Decl,      ParamDecl)    Decl: �ؿ��إå�
  # Signature ���饹�ˤ� each_param �������Ʊ��Ư����
  def each_param # �֥�å�����{  |port, func_decl, param_decl| }
    return if @signature == nil                         # signature ̤����ʴ��˥��顼��
    fha = @signature.get_function_head_array            # �ƤӸ��ޤ��ϼ������Υ����˥���δؿ�����
    return if fha == nil                                # nil �ʤ�ʸˡ���顼��ͭ���ͤ����ꤵ��ʤ��ä�

    pr = Proc.new   # ���Υ᥽�åɤΥ֥�å������� pr ������
    port = self
    fha.each{ |fh|  # fh: FuncHead                      # �ؿ�������γƴؿ�Ƭ��
      fd = fh.get_declarator                            # fd: Decl  (�ؿ�Ƭ������Declarotor������)
      if fd.is_function? then                           # fd ���ؿ��Ǥʤ���С����Ǥ˥��顼
        fd.get_type.get_paramlist.get_items.each{ |par| # ���٤ƤΥѥ�᡼���ˤĤ���
          pr.call( port, fd, par )
        }
      end
    }
  end

  #=== Port# ��require���ꤵ��Ƥ��롩
  def is_reverse_required?
    @reverse_require_cell_path != nil
  end

  def show_tree( indent )
    indent.times { print "  " }
    puts "Port: name: #{@name} port_type: #{@port_type} require: #{@b_require} inline: #{@b_inline} optional: #{@b_optional}"
    (indent+1).times { print "  " }
    if @signature then
      puts "signature: #{@signature.get_name} #{@signature}"
    else
      puts "signature: NOT defined"
    end
    if @array_size == "[]" then
      (indent+1).times { print "  " }
      puts "array_size: not specified"
    elsif @array_size then
      (indent+1).times { print "  " }
      puts "array_size: #{@array_size}"
    end
    if @allocator_instance then
      (indent+1).times { print "  " }
      puts "allocator instance:"
      @allocator_instance.each { |b,a|
        (indent+2).times { print "  " }
        puts "#{a[0]} #{a[1]} #{b} "
        # a[3].show_tree( indent+3 )
      }
    end
    (indent+1).times { print "  " }
    if @port_type == :CALL then
      puts "VMT_useless : #{@b_VMT_useless}  skelton_useless : #{@b_skelton_useless}  cell_unique : #{@b_cell_unique}"
    else
      puts "VMT_useless : #{@b_VMT_useless}  skelton_useless : #{@b_skelton_useless}"
    end
  end

end

#== Namespace
#
# root namespace ������Region ���饹�Υ��󥹥��󥹤Ȥ������������
# root namespace �ϡ�root region ���ͤ뤿��
#
# @cell_list �� Region �ξ��ˤΤ߻��� (mikan @cell_list ��Ϣ�� Region �˰ܤ��٤�)
#
class Namespace < NSBDNode
# @name::  Symbol     # root �ξ�� "::" (String)
# @global_name:: str
# @name_list:: NamedList   Signature,Celltype,CompositeCelltype,Cell,Typedef,Namespace
# @struct_tag_list:: NamedList : StructType
# @namespace_list:: Namespace[] : Region �� Namespace �λҥ��饹�Ǥ��ꡢ�ޤޤ��
# @signature_list:: Sginature[]
# @celltype_list:: Celltype[]
# @compositecelltype_list:: CompositeCelltype[]
# @cell_list:: Cell[]
# @typedef_list:: Typedef[]
# @decl_list:: ( Typedef | StructType | EnumType )[]   ��¸�ط���������������ơ����֤ɤ��������˳�Ǽ mikan enum
# @const_decl_list:: Decl[]
# @cache_n_cells:: Integer :  get_n_cells �η�̤򥭥�å��夹��
# @cache_generating_region:: Region :  get_n_cells �η�̤򥭥�å��夹�뤷�Ƥ���꡼�����

  # mikan namespace �� push, pop

  # namespace �����ѤΥ����å�
  @@namespace_stack = []      # @@namespace_stack[0] = "::" (generator.rb)
  @@namespace_sp = -1

  # Generator �ͥ����ѤΥ����å� (namespace �����ѤΥ����å������椹��)
  @@nest_stack_index = -1
  @@nest_stack = []

  @@root_namespace = nil

  # Generator �ͥ����ѥ����å��� push, pop (���饹�᥽�å�)
  def self.push
    dbgPrint "push Namespace\n"
    @@nest_stack_index += 1
    @@nest_stack[ @@nest_stack_index ] = [ @@namespace_stack, @@namespace_sp ]
    if @@root_namespace then
      @@namespace_sp = 0
      @@namespace_stack[ @@namespace_sp ] = @@root_namespace
    end
  end

  def self.pop
    dbgPrint "pop Namespace\n"
    @@namespace_stack, @@namespace_sp = @@nest_stack[ @@nest_stack_index ]
    @@nest_stack_index -= 1
    if @@nest_stack_index < -1 then
      raise "TooManyRestore"
    end
  end

  # namespace �����ѥ����å��� push, pop (���󥹥��󥹥᥽�å�)
  def push ns
    @@namespace_sp += 1
    @@namespace_stack[ @@namespace_sp ] = self
    dbgPrint "Namespace.PUSH #{@@namespace_sp} #{@name}\n"
  end

  def pop
    dbgPrint "Namespace.POP #{@@namespace_sp} #{@name}\n"
    @@namespace_sp -= 1
    if @@namespace_sp < 0 then
      raise "StackUnderflow"
    end
  end

  def initialize( name )

    super()
    @name = name

    if( name == "::" )then
      if( @@root_namespace != nil )then
        # root �ϰ��Τ������Ǥ���
        raise "try to re-create root namespace"
      end
      @@root_namespace = self
      @NamespacePath = NamespacePath.new( name, true )
    else
      ns = @@namespace_stack[ @@namespace_sp ].find( name )
      if ns.kind_of? Namespace then
        dbgPrint "namespace: re-appear #{@name}\n"
        # ��Ͽ�Ѥ� namespace �κ���Ͽ
        ns.push ns
        return
      elsif ns then
        cdl_error( "S1151 $1: not namespace", @name )
        prev_locale = ns.get_locale
        puts "previous: #{prev_locale[0]}: line #{prev_locale[1]} \'#{name}\' defined here"
      end
      dbgPrint "namespace: 1st-appear #{@name}\n"
    end

    if @@namespace_sp >= 0 then   # root �Ͻ���
      @@namespace_stack[@@namespace_sp].new_namespace( self )
    end
    push self

    @global_name = Namespace.get_global_name    # stack ��Ͽ����
    @name_list = NamedList.new( nil, "symbol in namespace '#{@name}'" )
    @struct_tag_list = NamedList.new( nil, "struct tag" )

    @namespace_list = []
    @signature_list = []
    @celltype_list = []
    @compositecelltype_list = []
    @cell_list = []
    @typedef_list = []
    @decl_list = []
    @const_decl_list = []
    @cache_n_cells = nil
    @cache_generating_region = nil
    if @NamespacePath == nil then
      # root namespace �ξ�������� (�� namespace �����Ĥ��餺�㳰�ˤʤ�)
      set_namespace_path # @NamespacePath ������
    end
  end

  def end_of_parse
    pop
  end

  def get_name
    @name
  end

  #=== Namespace:: global_name ������
  # parse ��Τߤ��Υ᥽�åɤϻȤ���
  # STAGE: P
  def self.get_global_name    # parse ��ͭ��
    if @@namespace_sp <= 0 then
      return ""
    end

    path = @@namespace_stack[1].get_name.to_s
    i = 2
    while i <= @@namespace_sp
      path = path+"_"+@@namespace_stack[i].get_name.to_s
      i += 1
    end

    path
  end

  def get_global_name
    @global_name
  end

  #=== Namespace#����θĿ�������
  # �� region �� linkunit, node ���ꤵ��Ƥ���С��ޤ�ʤ����̤Υ��ñ�̡�
  # �ץ�ȥ���������Τ�ΤΤߤθĿ���ޤ�ʤ�
  # mikan namespace ���� cell ���֤��ʤ����ͤˤʤ�ȡ����Υ᥽�åɤ� Region �Τ�ΤǤ褤
  # mikan �嵭�ξ�� instance_of? Namespace �ξ��Ƚ������פȤʤ�
  def get_n_cells
    if @cache_generating_region == $generating_region then
      # ���Υ᥽�åɤϷ����֤��ƤӽФ���뤿�ᡢ��̤򥭥�å��夹��
      return @cache_n_cells
    end

    count = 0
    @cell_list.each{ |c|
      # ������ץ�ȥ���������������ϡ�new_cell ���ʳ���Ƚ�ǤǤ��ʤ����ᡢ������Ȥ��ʤ���
      if c.get_f_def == true then
        # print "get_n_cells: cell: #{c.get_name}\n"
        count += 1
      end
    }

    @namespace_list.each{ |ns|
      if ns.instance_of? Namespace then
        count += ns.get_n_cells
      else
        # ns �� Region �Ǥ���
        rt = ns.get_region_type
        # print "get_n_cells: region: #{ns.get_name}: #{rt}\n"
        if rt == :NODE || rt == :LINKUNIT then
          # �̤� linkunit �ʤΤǲû����ʤ�
        else
          count += ns.get_n_cells
        end
      end
    }

    @cache_generating_region = $generating_region
    @cache_n_cells = count
    return count
  end

  #=== Namespace.find : in_path �Ǽ�����륪�֥������Ȥ�õ��
  #in_path:: NamespacePath
  #in_path:: Array : �Ť�����
  #  path [ "::", "ns1", "ns2" ]   absolute
  #  path [ "ns1", "ns2" ]         relative
  def self.find( in_path )

    if in_path.instance_of? Array then
      # raise "Namespace.find: old fashion"

      path = in_path
      length = path.length
      return self.find_one( path[0] ) if length == 1

      name = path[0]
      if name == "::" then
        i = 1
        name = path[i]   # ��ʸŪ��ɬ��¸��
        object = @@root_namespace.find( name )  # root
      else
        # ���Хѥ�
        i = 0
        object = @@namespace_stack[@@namespace_sp].find_one( name ) # crrent
      end

    elsif in_path.instance_of? NamespacePath then
      path = in_path.get_path
      length = path.length

      if length == 0 then
        if in_path.is_absolute? then
          return @@root_namespace
        else
          raise "path length 0, not absolute"
        end
      end

      i = 0
      name = path[0]
      if in_path.is_absolute? then
        object = @@root_namespace.find( name )  # root
      else
        bns = in_path.get_base_namespace
        object = bns.find_one( name )           # crrent
      end
    else
      raise "unexpected path"
    end

    i += 1
    while i < length

      unless object.kind_of?( Namespace ) then
        # ���饹�᥽�å���� cdl_error ��ƤӽФ����ȤϤǤ��ʤ�
        # �ޤ������������б��塢���Τʹ��ֹ椬�Фʤ������������
        # cdl_error( "S1092 \'$1\' not namespace" , name )
        # ���Υ᥽�åɤ��� nil �����ä���� "not found" ���Ф�Τǡ������ǤϽФ��ʤ�
        return nil
      end

      object = object.find( path[i] )
      i += 1
    end

    return object
  end


  def find( name )
    @name_list.get_item(name)
  end

  #=== Namespace# namespace ����õ�������Ĥ���ʤ���п� namespace ����õ��
  def self.find_one( name )
    return @@namespace_stack[@@namespace_sp].find_one( name )
  end

  def find_one( name )

    object = find( name )
    # ����ϽФ���
    # dbgPrint "in '#{@name}' find '#{name}' object #{object ? object.class : "Not found"}\n"

    if object != nil then
      return object
    elsif @name != "::" then
      return @owner.find_one( name )
    else
      return nil
    end
  end

  def self.get_current
    @@namespace_stack[@@namespace_sp]
  end

  def self.find_tag( name )
    # mikan tag : namespace �� path ���б����ʤ�
    # namespace ����ˤ��äƤ⡢root namespace �ˤ����Τȸ��ʤ����
    # ��ä� ������ namespace ���麬�˸����ä�õ��
    i = @@namespace_sp
    while i >= 0
      res = @@namespace_stack[i].find_tag( name )
      if res then
        return res
      end
      i -= 1
    end
  end

  def find_tag( name )
    @struct_tag_list.get_item( name )
  end

 ### namespace
  def self.new_namespace( namespace )
    @@namespace_stack[@@namespace_sp].new_namespace( namespace )
  end

  def new_namespace( namespace )
    dbgPrint "new_namespace: #{@name}:#{self} #{namespace.get_name}:#{namespace} \n"
    namespace.set_owner self   # Namespace (Namespace)

    @name_list.add_item( namespace )
    @namespace_list << namespace
  end

 ### signature
  def self.new_signature( signature )
    @@namespace_stack[@@namespace_sp].new_signature( signature )
  end

  def new_signature( signature )
    signature.set_owner self   # Signature (Namespace)
    @name_list.add_item( signature )
    @signature_list << signature
  end

 ### celltype
  def self.new_celltype( celltype )
    @@namespace_stack[@@namespace_sp].new_celltype( celltype )
  end

  def new_celltype( celltype )
    celltype.set_owner self   # Celltype (Namespace)
    @name_list.add_item( celltype )
    @celltype_list << celltype
  end

 ### compositecelltype
  def self.new_compositecelltype( compositecelltype )
    @@namespace_stack[@@namespace_sp].new_compositecelltype( compositecelltype )
  end

  def new_compositecelltype( compositecelltype )
    compositecelltype.set_owner self   # CompositeCelltype (Namespace)
    @name_list.add_item( compositecelltype )
    @compositecelltype_list << compositecelltype
  end

 ### cell (Namespace)
  def self.new_cell( cell )
    @@namespace_stack[@@namespace_sp].new_cell( cell )
  end

  def new_cell( cell )
    dbgPrint "Namespace.new_cell: #{@NamespacePath.get_path_str}::#{cell.get_name}\n"
    cell.set_owner self   # Cell (Namespace)
    @name_list.add_item( cell )
    @cell_list << cell
  end

  #=== Namespace# ���Ȥ���Ƥ��뤬��̤����Υ����õ��
  # �ץ�ȥ���������������������Ƥ��ʤ��������򥨥顼�Ȥ���
  # ��ư��̤��祻��ˤĤ��Ʒٹ𤹤�
  def check_ref_but_undef
    @cell_list.each { |c|
      if ! c.get_f_def then   # Namespace �� @cell_list �ˤϥץ�ȥ����פ��ޤޤ�륱��������
        if c.get_f_ref then
          cdl_error( "S1093 $1 : undefined cell" , c.get_namespace_path.get_path_str )
        elsif $verbose then
          cdl_warning( "W1006 $1 : only prototype, unused and undefined cell" , c.get_namespace_path.get_path_str )
        end
      else
        dbgPrint "check_ref_but_undef: #{c.get_global_name}\n"
        ct = c.get_celltype
        # if c.get_f_ref == false && c.is_generate? && ct && ct.is_inactive? then
        if c.get_f_ref == false && ct && ct.is_inactive? then
          cdl_warning( "W1007 $1 : non-active cell has no entry join and no factory" , c.get_namespace_path.get_path_str )
        end
      end
    }
    @namespace_list.each { |n|
      n.check_ref_but_undef
    }
  end

  #=== Namespace# ����μ������λ��ȥ�����Ȥ����ꤹ��
  def set_port_reference_count
    @cell_list.each { |c|
      c.set_port_reference_count
    }
    @namespace_list.each { |n|
      n.set_port_reference_count
    }
  end

 ### struct
  def self.new_structtype( struct )
    @@namespace_stack[@@namespace_sp].new_structtype( struct )
  end

  def new_structtype( struct )
    # struct.set_owner self   # StructType (Namespace) # StructType �� BDNode �ǤϤʤ�
    dup = @struct_tag_list.get_item(struct.get_name)
    if dup != nil then
      if struct.same? dup then
        # Ʊ����Τ� typedef ���줿
        # p "#{struct.get_name}"
        return
      end
    end

    @struct_tag_list.add_item( struct )
    @decl_list << struct
  end

 ### typedef
  def self.new_typedef( typedef )
    @@namespace_stack[@@namespace_sp].new_typedef( typedef )
  end

  def new_typedef( typedef )
    typedef.set_owner self   # TypeDef (Namespace)
    dup = @name_list.get_item(typedef.get_name)
    if dup != nil then
      if typedef.get_declarator.get_type.get_type_str == dup.get_declarator.get_type.get_type_str &&
          typedef.get_declarator.get_type.get_type_str_post == dup.get_declarator.get_type.get_type_str_post then
        # Ʊ����Τ� typedef ���줿
        # ���������Τ� C �Ǵؿ��ݥ��󥿤� typedef ���Ƥ��륱����
        # �ʲ��Τ褦����Ť��������Ƥ������ type_specifier_qualifier_list �Ȥ��ư�����
        #    typedef long LONG; 
        #    typedef long LONG;
        # bnf.y.rb �Ǥ� declarator �� TYPE_NAME ������ʤ��Τǡ���������뤳�ȤϤʤ�
        # p "#{typedef.get_declarator.get_type.get_type_str} #{typedef.get_name} #{typedef.get_declarator.get_type.get_type_str_post}"
        return
      end
    end

    @name_list.add_item( typedef )
    @typedef_list << typedef
    @decl_list << typedef
  end

  def self.is_typename?( str )
    i = @@namespace_sp
    while i >= 0
      if @@namespace_stack[i].is_typename?( str ) then
        return true
      end
      i -= 1
    end
    false
  end

  def is_typename?( str )
    if @name_list.get_item( str ).instance_of?( Typedef ) then
      true
    else
      false
    end
  end

 ### const_decl
  def self.new_const_decl( decl )
    @@namespace_stack[@@namespace_sp].new_const_decl( decl )
  end

  def new_const_decl( decl )
    decl.set_owner self   # Decl (Namespace:const)
    if ! decl.is_const? then			# const �������Ƥ��뤳��
      if decl.is_type?( PtrType ) then
        cdl_error( "S1094 $1: pointer is not constant. check \'const\'" , decl.get_name )
      else
        cdl_error( "S1095 $1: not constant" , decl.get_name )
      end
    elsif ! decl.is_type?( IntType ) && ! decl.is_type?( FloatType ) &&
        ! decl.is_type?( BoolType ) && ! decl.is_type?( PtrType ) then
                                            # IntType, FloatType �Ǥ��뤳��
      cdl_error( "S1096 $1: should be int, float, bool or pointer type" , decl.get_name )
    elsif decl.get_initializer == nil then   # ����ͤ���Ĥ���
      cdl_error( "S1097 $1: has no initializer" , decl.get_name )
#    elsif decl.get_initializer.eval_const(nil) == nil then  #eval_const �� check_init �ǸƽФ����Τ���ť����å�
#                                            # mikan ����ͤ������Ф�Ŭ�ڤǤ��뤳��
#      cdl_error( "S1098 $1: has unsuitable initializer" , decl.get_name )
    else
      decl.get_type.check_init( @locale, decl.get_name, decl.get_initializer, :CONSTANT )
      @name_list.add_item( decl )
      @const_decl_list << decl
    end

  end

 ### region
  # def self.new_region( region )
  #   @@namespace_stack[@@namespace_sp].new_region( region )
  # end
# 
  # def new_region( region )
  #   region.set_owner self   # Rgion (Namespace)
  #   @name_list.add_item( region )
  # end

 ###

  #=== Namespace# ���٤ƤΥ���� require �ݡ��Ȥ�����
  def set_require_join
    @celltype_list.each{ |ct|
      ct.set_require_join
    }
    # ���٤Ƥ� namespace �ˤĤ��� require �ݡ��Ȥ򥻥å�
    @namespace_list.each{ |ns|
      ns.set_require_join
    }
  end

  #=== Namespace# Join �ؤ� definition ������ȥ����å�
  # ���륿���פ�°���뤹�٤ƤΥ�����Ф��Ƽ»�
  def set_definition_join
    # celltype �Υ����ɤ�����
    @cell_list.each { |c|
      dbgPrint "set_definition_join #{c.get_name}\n"
      c.set_definition_join
    }
    @namespace_list.each{ |ns|
      ns.set_definition_join
    }
  end

  #=== Namespace# ����η�������å�����
  def check_join
    @cell_list.each { |c|
      dbgPrint "check_join #{c.get_name}\n"
      c.check_join
      c.check_reverse_require
    }
    @namespace_list.each{ |ns|
      ns.check_join
    }
  end

  def show_tree( indent )
    indent.times { print "  " }
    puts "#{self.class}: name: #{@name} path: #{get_namespace_path.get_path_str}"
    @struct_tag_list.show_tree( indent + 1 )
    @name_list.show_tree( indent + 1 )
  end

end


class Join < BDNode
# @name:: string
# @subscript:: nil: not array, -1: subscript not specified, >=0: array_subscript
# @rhs:: Expression | initializer ( array of Expression | initializer (Expression | C_EXP) )
# @definition:: Port, Decl(attribute or var)
#
# available if definition is Port
# @cell_name:: string : ���դΥ����̾��
# @cell:: Cell  : ���դΥ���
# @celltype:: Celltype : ���դΥ��륿����
# @port_name:: string : ���դμ�����̾
# @port:: Port : ���դμ�����
# @array_member:: rhs array : available only for first appear in the same name
# @array_member2:: Join array : available only for first appear in the same name
#

# @through_list::  @cp_through_list + @region_through_list
#  �ʲ��ι�¤����ġ�@cp_through_list �ι�¤�϶��̡�
# @cp_through_list::  �ƤӸ��˻��ꤵ�줿 through
#   [ [plugin_name, cell_name, plugin_arg], [plugin_name2, cell_name2, plugin_arg], ... ]
# @region_through_list::  region �˻��ꤵ�줿 through
#   [ [plugin_name, cell_name, plugin_arg, region], [plugin_name2, cell_name2, plugin_arg, region2], ... ]
#
# @through_generated_list:: [Plugin_class object, ...]: @through_list ���б�
# @region_through_generated_list:: [Plugin_class object, ...]: @region_through_list ���б�
#

  include PluginModule


  #=== Join# �����
  #name:: string: ̾����°��̾���ƤӸ�̾��
  #subscript:: Nil=������, -1="[]", N="[N]"
  #rhs:: Expression: ���դμ�
  def initialize( name, subscript, rhs )
    # dbgPrint "Join#new: #{name}, #{subscript} #{rhs.eval_const(nil)}\n"
    dbgPrint "Join#new: #{name}, #{subscript}\n"

    super()
    @name = name
    if subscript.instance_of?( Expression ) then
       #mikan ����ź���������Ǥ��뤳�Ȥ�̤�����å�
       @subscript = subscript.eval_const(nil)
       if @subscript == nil then
         cdl_error( "S1099 array subscript not constant"  )
       end
    else
       @subscript = subscript
    end

    @rhs = rhs
    @definition = nil

    # �������Ǥ�����
    # �����ϡ���Ф����ǤΤ����ꤹ��Τ�Ŭ��
    # new_join �� add_array_member ����ǽ�����Ǥ� array_member ���Ф����ꤹ��
    if @subscript == -1 then
      @array_member  = [self]
      @array_member2 = [self]
    elsif @subscript != nil then
      @array_member = []
      @array_member2 = []
      @array_member[@subscript]  = self
      @array_member2[@subscript] = self
    end

    @through_list = []
    @cp_through_list = []
    @region_through_list = []
    @through_generated_list = []
    @region_through_generated_list = []
  end

  #===  Join# ���դ��б����� celltype ����������ꤹ��ȤȤ�˥����å�����
  # STAGE:   S
  #
  #     ������ǽ�������å�����
  #definition:: Decl (attribute,var�λ�) �ޤ��� Port (call�λ�) �ޤ��� nil (definition �����Ĥ���ʤ��ä���)

  def set_definition( definition )

    dbgPrint "set_definition: #{@owner.get_name}.#{@name} = #{definition.class}\n"

    # ��ť����å����ɻ�
    if @definition then
      # set_definition ����̤˹Ԥ��������ǡ���Ť˹Ԥ����ǽ��������ʰ۾�ǤϤʤ���
      # ��Ť� set_definition ���¹Ԥ����� through ����Ť�Ŭ�Ѥ���Ƥ��ޤ�
      # cdl_warning( "W9999 $1, internal error: set_definition duplicate", @name )
      return
    end

    @definition = definition

    # mikan �����͡������ͤη������å��ʤ�
    if @definition.instance_of?( Decl ) then
      check_var_init
    elsif @definition.instance_of?( Port ) then
      check_call_port_init
      if @definition.get_port_type == :CALL then   # :ENTRY �ʤ饨�顼��̵�뤷�ʤ�
        check_and_gen_through
        create_allocator_join  # through �ץ饰��������������Ǥʤ��ȡ��������Υ���Υ����������礷�Ƥ��ޤ�
      end
    elsif @definition == nil then
      cdl_error( "S1117 \'$1\' not in celltype", @name )
    else
      raise "UnknownToken"
    end
  end

  #=== Join# �ѿ��ν���������å�
  def check_var_init
    # attribute, var �ξ��
    if @definition.get_kind == :ATTRIBUTE then
#        check_cell_cb_init( definition.get_type, @rhs )
      # ���դǽ������ǽ�������å�
      @definition.get_type.check_init( @locale, @definition.get_identifier, @rhs, :ATTRIBUTE )
    elsif @definition.get_kind == :VAR then
      # var �Ͻ�����Ǥ��ʤ�
      cdl_error( "S1100 $1: cannot initialize var" , @name )
    else
      # Bug trap
      raise "UnknownDeclKind"
    end
  end

  #=== Join# �ƤӸ��ν���������å�
  def check_call_port_init
    ### Port

    # ���դϼ��������ʼ��������������褦�Ȥ��Ƥ���ˡ�
    if @definition.get_port_type == :ENTRY then
      cdl_error( "S1101 \'$1\' cannot initialize entry port" , @name )
      return
    end

#      # ����ź���������������å�
#      # �ƤӸ�������ǡ�������ʤ�ź���ʤ���ź���ʤ�����ʤ�ź���ʤ���ź����������ʤ�ź������
    as = @definition.get_array_size
    if ( @subscript == nil && as != nil ) then
      cdl_error( "S1102 $1: must specify array subscript here" , @name )
    elsif ( @subscript != nil && as == nil ) then
      cdl_error( "S1103 $1: cannot specify array subscript here" , @name )
    end
#    if @subscript == nil then
#      if as != nil then
#        cdl_error( "S1103 $1: need array subscript" , @name )
#      end
#    elsif @subscript == -1 then
#      if as != "[]" then
#        cdl_error( "S1104 $1: need array subscript number. ex. \'[0]\'" , @name )
#      end
#    else # @subscript >0
#      if as == nil then
#        cdl_error( "S1105 $1: cannot specify array subscript here" , @name )
#      elsif as == "[]" then
#        cdl_error( "S1106 $1: cannot specify array subscript number. use \'[]\'" , @name )
#      end
#    end

    # mikan Expression �� get_type �Ƿ�Ƴ�Ф������������ޡ���
    # mikan '=' �κ��դ����󤫤ɤ���̤�����å�
    #(1) '=' �α��դ� "Cell.ePort" �η�������
    #     �黻�Ҥ� "."  ���� "." �κ��դ� :IDENTIFIER
    #     "." �α��դϥ����å����� (synatax Ū�� :IDENTIFIER)
    #(2) "Cell" ��¸�ߤ��뤫����̾�������פ����ΤϤ��뤫��
    #(3) "Cell" �� cell ����
    #(4) "Cell" �� celltype ��ͭ������ (̵���ʤ���˥��顼��
    #(5) "ePort" �� "Cell" �� celltype ���¸�ߤ��뤫��
    #(6) "ePort" �� entry port ����
    #(7) signature �ϰ��פ��뤫

    # ���դ��ʤ��ʰ������ʳ��ǥ��顼��
    return unless @rhs

    # cCall = composite.cCall; �Υ����å������η�����°����
    # �ƤӸ��� export ����ˤ� cCall => composite.cCall; �η������Ѥ���
    if @rhs.instance_of?( Array ) == true && @rhs[0] == :COMPOSITE then
      cdl_error( "S1107 to export port, use \'cCall => composite.cCall\'"  )
      return
    elsif ! @rhs.instance_of?( Expression ) then
      raise "Unknown bug. specify -t to find problem in source"
    end

    # ���դ� Expression �����Ǥ���Ф�
    elements = @rhs.get_elements
    if elements[0] == :OP_SUBSC then  # ���ա�����������
      # elements = [ :OP_SUBSC, [ :OP_DOT, [ :IDENTIFIER, token ], token ], expression ]
      subscript = elements[2].eval_const(nil)  # �����������ź��
      elements  = elements[1]          # mikan ������ä����
      array     = true
    else
      array = false
    end

    # elements = [ :OP_DOT, [ :IDENTIFIER, token ], token ]
    if elements[0] != :OP_DOT || elements[1][0] != :IDENTIFIER then   #1
      cdl_error( "S1108 $1: rhs not \'Cell.ePort\' form" , @name )
      return
    end

    nsp = elements[1][1]      # NamespacePath
    @cell_name = nsp.get_name     # mikan ns::cellname �η����ι�θ
    @port_name = elements[2].val

    # composite ���������ʤ� object �Ϸ���� cell �������Ĥ���ʤ���� nil ���֤�
    # composite ��������ʤ� false ���֤�
    object = CompositeCelltype.find( @cell_name )
    if object == false then
#     mikan ���դ� namespace ���б����Ƥ��ʤ����ᡣ path �ˤ��� find
      # p nsp.get_path_str, nsp.get_path
      object = Namespace.find( nsp )    #1
      in_composite = false
    else
      if nsp.get_path.length != 1 then
        cdl_error( "$1 cannot have path", nsp.get_path_str )
      end
      in_composite = true
    end

    if object == nil then                                             # (2)
      cdl_error( "S1109 \'$1\' not found" , @cell_name )
    elsif ! object.instance_of?( Cell ) then                          # (3)
      cdl_error( "S1110 \'$1\' not cell" , @cell_name )
    else
      dbgPrint "set_definition: set_f_ref #{@owner.get_name}.#{@name} => #{object.get_name}\n"
      object.set_f_ref

      # ���դΥ���Υ��륿����
      celltype = object.get_celltype

      if celltype then                                                # (4)
        object2 = celltype.find( @port_name )
        if object2 == nil then                                        # (5)
          cdl_error( "S1111 \'$1\' not found" , @port_name )
        elsif ! object2.instance_of? Port \
             || object2.get_port_type != :ENTRY then                  # (6)
          cdl_error( "S1112 \'$1\' not entry port" , @port_name )
        elsif @definition.get_signature != object2.get_signature then # (7)
          cdl_error( "S1113 \'$1\' signature mismatch" , @port_name )
        elsif object2.get_array_size then
          # ����������

          unless array then
            # ���դ�ź�����꤬�ʤ��ä�
            cdl_error( "S1114 \'$1\' should be array" , @port_name )
          else

            as = object2.get_array_size
            if( as.kind_of?( Integer ) && as <= subscript )then
              # ������������礭�����Ф������դ�ź����Ʊ�����礭��
              cdl_error( "S1115 $1[$2]: subscript out of range (< $3)" , @port_name, subscript, as )
            else
              dbgPrint "Join OK #{@owner.get_name}.#{@name}[#{subscript}] = #{object.get_name}.#{@port_name} #{self}\n"
              @cell = object
              @celltype = celltype
              @port = object2
              # ���դΥ���μ����� object2 �򻲾ȺѤߤˤ���
              # object2: Port, @definition: Port
              @cell.set_entry_port_max_subscript( @port, subscript )
            end

            # debug
            dbgPrint "Join set_definition: rhs: #{@cell}  #{@cell.get_name if @cell}\n"

          end
        elsif array then
          # ����������Ǥʤ��Τ˱��դ�ź�����ꤵ��Ƥ���
          cdl_error( "S1116 \'$1\' entry port is not array" , @port_name )
        else
          dbgPrint "Join OK #{@owner.get_name}.#{@name} = #{object.get_name}.#{@port_name} #{self}\n"
          @cell = object
          @port = object2
          @celltype = celltype

          # ���դΥ��� object �μ����� object2 �򻲾ȺѤߤˤ���
          # object2: Port, @definition: Port

          # debug
          # p "rhs:  #{@cell}  #{@cell.get_name}"
        end  # end of port (object2) �����å�

        #else
        #  celltype == nil (���Ǥ˥��顼)
      end  # end of celltyep �����å�


      check_region( object )

    end  # end of cell (object) �����å�

  end

  #=== Join# ���������η�������
  #cell::  �ƤӸ��η����Υ���
  #
  # �����ǤϸƤӸ�¦����������륢�������ƤӸ��η�������
  # ������¦�� Cell �� set_specifier_list ������
  #  a[*] �����Ƥ� Cell �� set_specifier_list �򻲾�
  def create_allocator_join

    cell = get_rhs_cell2   # ���դΥ��������
    port = get_rhs_port2

    if( cell && cell.get_allocator_list ) then      # cell == nil �ʤ���˥��顼

      dbgPrint "create_allocator_join: #{@owner.get_name}.#{@name}=>#{cell ? cell.get_name : "nil"}\n"

      cell.get_allocator_list.each { |a|

        # ���դ�����ź��������
        elements = @rhs.get_elements
        if elements[0] == :OP_SUBSC then
          subscript = elements[2].eval_const(nil) # ������������ź����:OP_SUBSC ���������
        else
          subscript = nil
        end

        if( a[0+1] == port && a[1+1] == subscript )then
          # ̾���ΰ��פ����Τη�����������
          # ����­�ϡ����ӥ����å������
          cp_name = :"#{@name}_#{a[2+1]}_#{a[3+1]}"
          # p "creating allocator join #{cp_name} #{@subscript} #{a[1+1]}"
          join = Join.new( cp_name, @subscript, a[4+1] )

          #debug
          dbgPrint "create_allocator_join: #{@owner.get_name}.#{cp_name} [#{@subscript}] #{@name}\n"
          @owner.new_join join
        else
          dbgPrint "create_allocator_join:3 not #{@owner.get_name}.#{a[0+1]} #{@name}\n"
        end
      }
    end
  end

  #=== Join# �꡼�����֤η�������å�
  # �꡼�����֤� through �ˤ�� @region_through_list �κ���
  # �ºݤ������� check_and_gen_through �ǹԤ�
  def check_region( object )

    #debug
    dbgPrint "check_region #{@owner.get_name}.#{@name} => #{object.get_name}\n"

    # �ץ饰������������줿�ʤ��Ǥ��������ʤ�
    # ����ʤ��ȥץ饰�����������줿��ΤȤδ֤ǡ�̵�¤����������
##    if Generator.get_nest >= 1 then
##    if Generator.get_plugin then     # mikan �����ɬ�ס� (��̣�����ʳ��Ǥμ¹Ԥˤʤ�Τ���Ŭ��)
    if @owner.get_plugin.kind_of?( ThroughPlugin ) then
      # �ץ饰�����������줿����ξ�硢�������å��Τ�
      return
    end

    # region �Υ����å�
    r1 = @owner.get_region      # �ƤӸ������ region
    r2 = object.get_region      # ����������� region

    if ! r1.equal? r2 then      # Ʊ�� region �ʤ�ƽФ���ǽ

      # mikan namespace �б�
      f1 = r1.get_family_line
      len1 = f1.length
      f2 = r2.get_family_line
      len2 = f2.length

      # �԰��פˤʤ�Ȥ���ʷ���ˤ�õ��
      i = 1  # i = 0 �� :RootRegion �ʤΤ�ɬ������
      while( i < len1 && i < len2 )
        if( f1[i] != f2[i] )then
          break
        end
        i += 1
      end

      sibling_level = i     # ����Ȥʤ��٥롢�⤷���Ϥɤ��餫����������ä���٥�

      dbgPrint "sibling_level: #{i}\n"
      dbgPrint "from: #{f1[i].get_name}\n" if f1[i]
      dbgPrint "to: #{f2[i].get_name}\n" if f2[i]

      if f1[sibling_level] && f2[sibling_level] then
        b_to_through = true
      else
        b_to_through = false
      end


      # �Ƥ�¦�ˤĤ��ƸƤӸ��Υ�٥뤫�鷻���٥�ޤǡ�out_through ������å������������
      i = len1 -1
      if b_to_through then
        end_level = sibling_level
      else
        end_level = sibling_level - 1
      end
      while i > end_level
      # while i > sibling_level
      # while i >= sibling_level
        dbgPrint "going out from #{f1[i].get_name} level=#{i}\n"
        region_count = f1[i].next_out_through_count
        out_through_list = f1[i].get_out_through_list   # [ plugin_name, plugin_arg ]
        if out_through_list.length == 0 then
          cdl_error( "S1118 $1: going out from region \'$2\' not permitted" , @name, f1[i].get_name )
        end

        out_through_list.each { |ol|
          if ol[0] then    # plugin_name �����ꤵ��Ƥ��ʤ������Ͽ���ʤ�
            plugin_arg = CDLString.remove_dquote ol[1]
            through = [ ol[0], :"Join_out_through_", plugin_arg, f1[i], f1[i-1], :OUT_THROUGH, region_count]
            @region_through_list << through
          end
        }
        i -= 1
      end

      # �����٥�ˤ����ơ�to_through ������å������������
      if f1[sibling_level] && f2[sibling_level] then
        dbgPrint "going from #{f1[sibling_level].get_name} to #{f2[sibling_level].get_name}\n"
        found = 0
        region_count = f1[i].next_to_through_count( f2[sibling_level].get_name )   # to_through �� region �������
        f1[sibling_level].get_to_through_list.each { |t|
          if t[0][0] == f2[sibling_level].get_name then   # region ̾�����פ��뤫 ?
            if t[1] then    # plugin_name �����ꤵ��Ƥ��ʤ������Ͽ���ʤ�
              plugin_arg = CDLString.remove_dquote t[2]
              through = [ t[1], :"Join_to_through__", plugin_arg, f1[sibling_level], f2[sibling_level], :TO_THROUGH, region_count ]
              @region_through_list << through
            end
            found = 1
          end
        }
        if found == 0 then
          cdl_error( "S1119 $1: going from region \'$2\' to \'$3\' not permitted" , @name, f1[sibling_level].get_name, f2[sibling_level].get_name )
        end
      end

      # ����¦�ˤĤ��Ʒ����٥뤫�����¦�Υ�٥�ޤǡ�in_through ������å������������
      if b_to_through then
        i = sibling_level + 1      # to_through ��Ф���硢�ǽ�� in_through ��Ŭ�Ѥ��ʤ�
      else
        i = sibling_level
      end
      while i < len2
        dbgPrint "going in to #{f2[i].get_name} level=#{i}\n"
        region_count = f2[i].next_in_through_count
        in_through_list = f2[i].get_in_through_list   # [ plugin_name, plugin_arg ]
        if in_through_list.length == 0 then
          cdl_error( "S1120 $1: going in to region \'$2\' not permitted" , @name, f2[i].get_name )
        end
        in_through_list.each { |il|
          if il[0] then    # plugin_name �����ꤵ��Ƥ��ʤ������Ͽ���ʤ�
            plugin_arg = CDLString.remove_dquote il[1]
            through = [ il[0], :"Join_in_through_", plugin_arg, f2[i-1], f2[i],:IN_THROUGH, region_count ]
            @region_through_list << through
          end
        }
        i += 1
      end

    end
  end


  #=== Join# �������ʤ��꡼�����ؤη�礫�����å�
  # ���դΥ��뤬����������ʤ��꡼�����ˤ���Х��顼
  # ���դϡ��ץ饰�����������줿���뤬����С�������оݤȤ���
  def check_region2
    lhs_cell = @owner

    # �������ʤ��꡼�����Υ���ؤη�礫��
    # if join.get_cell && ! join.get_cell.is_generate? then
    # if get_rhs_cell && ! get_rhs_cell.is_generate? then # composite ���뤬�ץ���������ξ���㳰
    # print "Link root: (caller #{@owner.get_name}) '#{@owner.get_region.get_link_root.get_name}'"
    # print " #{@owner.get_region.get_link_root == get_rhs_region.get_link_root ? "==" : "!="} "
    # print "'#{get_rhs_region.get_link_root.get_name}'  (callee #{@cell_name})\n"

    if get_rhs_region then
      dbgPrint "check_region2 #{lhs_cell.get_name} => #{get_rhs_region.get_path_string}#{@rhs.to_s}\n"

      # if get_rhs_region.is_generate? != true then  #3
      if @owner.get_region.get_link_root != get_rhs_region.get_link_root then
        cdl_error( "S1121 \'$1\' in region \'$2\' cannot be directly joined $3 in  $4" , lhs_cell.get_name, lhs_cell.get_region.get_namespace_path.get_path_str, @rhs.to_s, get_rhs_region.get_namespace_path.get_path_str )
      end
    else
      # rhs �Υ��뤬¸�ߤ��ʤ��ä� (���˥��顼)
    end
  end

  def get_definition
    @definition
  end

  #=== Join# specifier ������
  # STAGE: B
  # set_specifier_list �ϡ�join �β��ϤκǸ�ǸƤӽФ����
  # through ����Ҥ�����
  #  check_and_gen_through ��ƽФ��ơ�through ����
  def set_specifier_list( specifier_list )

    specifier_list.each { |s|
      case s[0]
      when :THROUGH
        # set plugin_name
        plugin_name = s[1].to_s
        plugin_name[0] = "#{plugin_name[/^./].upcase}"     # ��Ƭʸ������ʸ���� : ruby �Υ��饹̾������

        # set cell_name
        cell_name = :"#{s[1].to_s}_"

        # set plugin_arg
        plugin_arg = CDLString.remove_dquote s[2].to_s
        # plugin_arg = s[2].to_s.gsub( /\A"(.*)/, '\1' )   # ����� "" �������
        # plugin_arg.sub!( /(.*)"\z/, '\1' )

        @cp_through_list << [ plugin_name, cell_name, plugin_arg ]
      end
    }

  end

  #=== Join# through �Υ����å�������
  # new_join ����� check_region �� region �֤� through �� @region_through �����ꤵ���
  # set_specifier �ǸƤӸ��η��ǻ��ꤵ�줿 through �� @cp_through ���ꤵ���
  # ���θ塢���Υ᥽�åɤ��ƤФ��
  # mikan Region#distance ��Region �ؤ��ɤ��夯�ޤǤ���ν���������
  def check_and_gen_through

    dbgPrint "check_and_gen_through #{@owner.get_name}.#{@name}\n"

    if ! @definition.instance_of? Port then
      cdl_error( "S1123 $1 : not port: \'through\' can be specified only for port" , @name )
      return
    end

    @through_list = @cp_through_list + @region_through_list
      # �夫�� @cp_through_list �� @region_through_list ��ʬ�������ᡢ���Τ褦�ʼ����ˤʤä�

    if @through_list then           # nil when the join is not Port
      len = @through_list.length    # through ��Ϣ�ܤ��Ƥ����
    else
      len = 0
    end
    cp_len = @cp_through_list.length

    if @owner.is_in_composite? && len > 0 then
      cdl_error( "S9999 cannot specify 'through' in composite in current version" )
      return
    end

    # Ϣ³���� through �ˤĤ��ơ�������¦�����˥������������᤹��
    i = len - 1
    while i >= 0

      through = @through_list[ i ]
      plugin_name           = through[ 0 ]
      generating_cell_name  = through[ 1 ]
      plugin_arg            = through[ 2 ]

      if i != len - 1 then

        begin
          next_cell_nsp       = @through_generated_list[ i + 1 ].get_cell_namespace_path
          next_port_name      = @through_generated_list[ i + 1 ].get_through_entry_port_name
        rescue Exception => evar
          cdl_error( "S1124 $1: plugin function failed: \'get_through_entry_port_name\'" , plugin_name )
          print_exception( evar )
          i -= 1
          next
        end

        next_cell = Namespace.find( next_cell_nsp )    #1
        if next_cell == nil then
          # p "next_cell_path: #{next_cell_nsp.get_path_str}"
          cdl_error( "S1125 $1: not generated cell \'$2\'" , @through_generated_list[ i + 1 ].class, next_cell_nsp.get_path_str )
          return
        end

      else
        # �Ǹ�Υ���ξ�硢���Υ����̾�����ݡ���̾
        next_cell      = @cell
        next_port_name = @port_name

        if next_cell == nil then
          # ����褬�ʤ�
          return
        end
      end

      if i >= cp_len then
        # region_through_list ��ʬ
        # region ���� @cell_name.@port_name �ؤ� through ���ʤ���õ��
        # rp = @through_list[i][3].find_cell_port_through_plugin( @cell_name, @port_name ) #762
        rp = @through_list[i][3].find_cell_port_through_plugin( @cell.get_global_name, @port_name )
           # @through_list[i] �� @region_through_list[i-cp_len] ��Ʊ��
        # ���Ѥ��ʤ��褦�ˤ���ˤϡ����Ĥ���ʤ��ä����Ȥˤ���Ф褤
        # rp = nil
      else
        # region �ʳ��Τ�Τ϶�ͭ���ʤ�
        # �ƤӸ�¦�˻��ꤵ��Ƥ��뤷��plugin_arg ���ۤʤ뤫�⤷��ʤ�
        rp = nil
      end

      if rp == nil then
        if( load_plugin( plugin_name, ThroughPlugin ) ) then
          gen_through_cell_code_and_parse( plugin_name, i, next_cell, next_port_name )
        end
      else
        # ���Ĥ��ä���Τ��Ѥ���
        @through_generated_list[ i ] = rp
      end

      if i >= cp_len then
        # @through_generated_list �Τ��� @region_through_list���б�������ʬ
        @region_through_generated_list[ i - cp_len ] = @through_generated_list[ i ]
        if rp == nil then
          # ����������Τ� region(@through_list[i][3]) �Υꥹ�Ȥ��ɲ�
          # @through_list[i][3].add_cell_port_through_plugin( @cell_name, @port_name, @through_generated_list[i] ) #762
          @through_list[i][3].add_cell_port_through_plugin( @cell.get_global_name, @port_name, @through_generated_list[i] )
        end
      end

      if i == 0 then
        # �Ǥ�ƤӸ�¦�Υ���ϡ�CDL ��η�礬�ʤ����ᡢ���Ȥ��줿���Ȥˤʤ�ʤ�
        # mikan namespace �б�
        # cell = Namespace.find( [ @through_generated_list[0].get_cell_name] )    #1
        if @through_generated_list[0] == nil then
          return  # plugin_object �������˼��Ԥ��Ƥ���
        end
        cell = Namespace.find( @through_generated_list[0].get_cell_namespace_path )    #1
        if cell.instance_of? Cell then
          cell.set_f_ref
        end
      end

      i -= 1
    end

  end

  @@through_count = { }
  def get_through_count name
    sym = name.to_sym
    if @@through_count[ sym ] then
      @@through_count[ sym ] += 1
    else
      @@through_count[ sym ] = 0
    end
    return @@through_count[ sym ]
  end

  #=== Join# through �ץ饰�����ƤӽФ��� CDL ����������ȤȤ�ˡ�import ����
  def gen_through_cell_code_and_parse( plugin_name, i, next_cell, next_port_name )

    through = @through_list[ i ]
    plugin_name           = through[ 0 ]
    generating_cell_name  = :"#{through[ 1 ]}_#{get_through_count through[ 1 ]}"
    plugin_arg            = through[ 2 ]
    if through[ 3 ] then
      # region �֤� through �ξ��
      @@start_region      = through[ 3 ]
      if next_cell.get_region.equal? @@start_region then
        @@end_region      = @@start_region
      else
        @@end_region      = through[ 4 ]
      end
      @@through_type      = through[ 5 ]
      @@region_count      = through[ 6 ]
    else
      # �ƤӸ��� through �ξ��
      @@start_region      = @owner.get_region    # �ƤӸ�¦����� region
      @@end_region        = next_cell.get_region # ���Υ���� region
      @@through_type      = :THROUGH             # �ƤӸ��� through ����
      @@region_count      = 0
    end
    @@plugin_creating_join = self

    caller_cell = @owner

    plugin_object = nil
    eval_str = "plugin_object = #{plugin_name}.new( '#{generating_cell_name}'.to_sym, plugin_arg.to_s, next_cell, '#{next_port_name}'.to_sym, @definition.get_signature, @celltype, caller_cell )"
    if $verbose then
      print "new through: #{eval_str}\n"
    end

    begin
      eval( eval_str )     # plugin ������
      plugin_object.set_locale @locale
    rescue Exception => evar
      cdl_error( "S1126 $1: fail to new" , plugin_name )
      if @celltype && @definition.get_signature && caller_cell && next_cell then
        print "signature: #{@definition.get_signature.get_name} from: #{caller_cell.get_name} to: #{next_cell.get_name} of celltype: #{@celltype.get_name}\n"
      end
      print "eval( #{eval_str} )\n"

      print_exception( evar )
      return 
    end

    @through_generated_list[ i ] = plugin_object

    # Region �˴ؤ�����������
    # �夫���ɲä����Τǡ�new �ΰ�����������
    # plugin_object.set_through_info( start_region, end_region, through_type )

    generate_and_parse plugin_object
  end

  #�ץ饰����ؤΰ������Ϥ��ʤ���Τ򡢰��Ū�˵������Ƥ���
  # �ץ饰����� initialize ����ǥ�����Хå��������ꤹ��
  @@plugin_creating_join = nil
  @@start_region = nil
  @@end_region = nil
  @@through_type = nil
  @@region_count = nil

  #=== Join# ThroughPlugin ���ɲþ�������ꤹ��
  # ���Υ᥽�åɤ� ThroughPlugin#initialize ����ƤӽФ����
  # plugin_object ����������ݤΰ����Ǥ���­���������ɲä���
  def self.set_through_info plugin_object
    plugin_object.set_through_info( @@start_region, @@end_region, @@through_type,
                                    @@plugin_creating_join,
                                    @@plugin_creating_join.get_cell,
                                    @@region_count )
  end

  def get_name
    @name
  end

  #=== Join#����ź��������
  # @subscript �������򻲾ȤΤ���
  def get_subscript
    @subscript
  end

  def get_cell_name         # ����������̾
    @cell_name
  end

  def get_celltype
    @celltype
  end

  def get_cell
    @cell
  end

  #=== Join# ���դμ¥��������
  #    �¥���Ȥ� through ���������줿��Ρ�composite �������ʤɼºݤ˷�礵�����
  #    ���Υ᥽�åɤϡ�get_rhs_port ���ФˤʤäƤ���
  #    ���Υ᥽�åɤϡ���̣�����ʳ��ǤϸƤӽФ��ƤϤʤ�ʤ� (�оݥ���ΰ�̣���Ϥ��Ѥ����ˤ���������̤��֤��ʤ�)
  def get_rhs_cell
    # through ���ꤢ�ꡩ
    if @through_list[0] then
      # mikan through ������������Τ� root namespace ����
      if @through_generated_list[0] then
        # cell = Namespace.find( [ "::", @through_generated_list[0].get_cell_name.to_sym ] )    #1
        cell = Namespace.find( @through_generated_list[0].get_cell_namespace_path )    #1
        # cell �� nil �ˤʤ�Τϥץ饰����� get_cell_namespace_path ���������ʤ�����
        # �ץ饰�������������ɤ����顼�ˤʤäƤ��롣
        # �Ǥ��ΰ����ץ饰����¿����С�cell == nil ��Ϥ����������褤��
        return cell.get_real_cell( @through_generated_list[0].get_through_entry_port_name )
      else
        return nil            # generate �˼��Ԥ��Ƥ���
      end
    elsif @cell then
      return @cell.get_real_cell( @port_name )
    else
      # ���դ�̤����ξ�� @cell �� nil (���˥��顼)
      return nil
    end
  end

  #=== Join# ���դΥ��������
  # ���դΥ�������롣��������composite Ÿ������Ƥ��ʤ�
  # composite Ÿ�����줿��Τ�����ˤ� get_rhs_cell ��Ȥ�
  # �ץ�ȥ����������������Ƥ��ʤ����ˤϡ������餷���Ȥ��ʤ�
  # ���Υ᥽�åɤ� get_rhs_port2 ���ФˤʤäƤ���
  def get_rhs_cell2
    # through ���ꤢ�ꡩ
    if @through_list[0] then
      # mikan through ������������Τ� root namespace ����
      # cell = Namespace.find( [ "::", @through_generated_list[0].get_cell_name ] )
      if @through_generated_list[0] then
        # cell = Namespace.find( [ @through_generated_list[0].get_cell_name ] )    #1
        cell = Namespace.find( @through_generated_list[0].get_cell_namespace_path )    #1
      else
        cell = @cell            # generate �˼��Ԥ��Ƥ���
      end
    else
      cell = @cell
    end

    return cell
  end

  #=== Join# ���դΥ���Υ꡼����������
  # ���դ�̤����ξ�硢nil ���֤�
  # composite �ξ�硢�¥���ǤϤʤ� composite cell �� region ���֤�(composite �Ϥ��٤�Ʊ�� region ��°����)
  # composite �� cell ���ץ�ȥ������������Ƥ���Ȥ� get_rhs_cell/get_real_cell �� ruby ���㳰�Ȥʤ�
  def get_rhs_region
    # through ���ꤢ�ꡩ
    if @through_list[0] then
      if @through_generated_list[0] then
        # mikan through ������������Τ� root namespace ����
        # cell = Namespace.find( [ "::", @through_generated_list[0].get_cell_name.to_sym ] )    #1
        cell = Namespace.find( @through_generated_list[0].get_cell_namespace_path )    #1
        if cell then
          return cell.get_region
        end
      else
        return nil       # generate �˼��Ԥ��Ƥ���
      end
    elsif @cell then
      return @cell.get_region
    end
    # ���դ�̤����ξ�� @cell �� nil (���˥��顼)
    return nil
  end

  def get_cell_global_name  # ����������̾�ʥ���ݥ��åȤʤ�Ÿ��������¦�Υ����

    # debug
    dbgPrint "cell get_cell_global_name:  #{@cell_name}\n"
    # @cell.show_tree( 1 )

    if @cell then
      return @cell.get_real_global_name( @port_name )
    else
      return "NonDefinedCell?"
    end

  end

  #===  Join# ���α��դμ�������̾��
  #     namespace ̾ + '_' + ����̾ + '_' + ������̾   �ʤ��Υ��뤬 composite �ʤ��Ÿ����Υ���̾��������̾��
  #subscript:: Integer  �ƤӸ�����λ�ź�� �ޤ��� nil �ƤӸ�����Ǥʤ���
  def get_port_global_name( subscript = nil )  # ������̾�ʥ���ݥ��åȤʤ�Ÿ��������¦�Υ����

    # debug
    dbgPrint "Cell get_port_global_name:  #{@cell_name}\n"

    # through ���ꤢ�ꡩ
    if @through_list[0] then

      # mikan through ������������Τ� root namespace ����
      # cell = Namespace.find( [ "::", @through_generated_list[0].get_cell_name.to_sym ] )    #1
      cell = Namespace.find( @through_generated_list[0].get_cell_namespace_path )    #1

      # through ���������줿����ǡ��ºݤ���³����륻���composite�ξ��������)�μ������� C ����̾��
      return cell.get_real_global_port_name( @through_generated_list[0].get_through_entry_port_name )
    else

      # �ºݤ���³����륻��μ������� C ����̾��
      if @cell then
        return @cell.get_real_global_port_name( @port_name )
      else
        return "UndefinedCellsPort?"
      end

    end

  end

  def get_port_name
    @port_name
  end

  def get_rhs
    @rhs
  end

  #=== Join# ���դΥݡ��Ȥ�����
  #    ���դ� composite �ξ��ϡ������ηҤ��륻��Υݡ���, through �ξ����������줿����Υݡ���
  #    ���Υ᥽�åɤ� get_rhs_cell ���ФˤʤäƤ���
  def get_rhs_port
    # through ���ꤢ�ꡩ
    if @through_list[0] then
      # mikan through ������������Τ� root namespace ����
      # through ���������줿�����õ��
#      cell = Namespace.find( [ "::", @through_generated_list[0].get_cell_name.to_sym ] )    #1
      cell = Namespace.find( @through_generated_list[0].get_cell_namespace_path )    #1
      # cell �Υץ饰������������줿�ݡ���̾�Υݡ��Ȥ�õ�� (composite �ʤ������ηҤ���ݡ���)
      return cell.get_real_port( @through_generated_list[0].get_through_entry_port_name )
    else
      # �ݡ��Ȥ��֤�(composite �ʤ������ηҤ���ݡ��Ȥ��֤�)
      return @cell.get_real_port( @port_name )
    end
  end

  #=== Join# ���դΥݡ��Ȥ�����
  # ���դΥݡ��Ȥ����롣
  # ����ϥץ�ȥ����������������Ƥ��ʤ����ˤϡ������餷���Ȥ��ʤ�
  def get_rhs_port2
    # through ���ꤢ�ꡩ
    if @through_list[0] then
      if @through_generated_list[0] then
        port = @through_generated_list[0].get_through_entry_port_name.to_sym
      else
        port = @port_name    # generate �˼��Ԥ��Ƥ���
      end
    else
      port = @port_name
    end

    return port
  end



  #=== Join# �ƤӸ������2���ܰʹߤ����Ǥ��ɲä���
  #     ���ֺǽ��������줿�������Ǥ������Ǥν���ͤ���������
  #     ���Υ᥽�åɤ�������ξ���ƽФ�����join ��ʣ���顼�ξ���
  #join2:: Join  �ƤӸ��������Ǥ� Join
  def add_array_member join2

    # subscript2: join2 �κ���ź��
    subscript2 = join2.get_subscript

    if @subscript == nil then		# not array : initialize duplicate
      # ������ξ�硢join ����ʣ���Ƥ���
      cdl_error( "S1127 \'$1\' duplicate", @name )
      # print "add_array_member2: #{@owner.get_name}\n"

    elsif @subscript >= 0 then
      # ź�����ꤢ��ξ��
      if( subscript2 == nil || subscript2 < 0 ) then
        # join2 ���դ�������ޤ���ź���ʤ�
        # �����԰���
        cdl_error( "S1128 \'$1\' inconsistent array definition", @name )
      elsif @array_member[subscript2] != nil then
        # Ʊ��ź������������Ѥ�
        cdl_error( "S1129 \'$1\' redefinition of subscript $2" ,@name, subscript2 )
      else
        # ź���ΰ��֤����Ǥ��ɲ�
        @array_member[subscript2] = join2.get_rhs
        @array_member2[subscript2] = join2
#        p "0:#{join2.get_rhs}"
      end

    else
      # ź������ʤ��ξ��
      if( subscript2 == nil || subscript2 >= 0 ) then
        # join2 ���դ�������ޤ���ź��ͭ
        # �����԰���
        cdl_error( "S1130 \'R1\' inconsistent array definition", @name )
      end

      # ź���ʤ�����ξ�硢�������Ǥ��ɲ�
      @array_member  << join2.get_rhs
      @array_member2 << join2
    end
  end

  def get_array_member
    @array_member
  end

  def get_array_member2
    @array_member2
  end

  def change_name name
    # debug
    dbgPrint "change_name: #{@name} to #{name}\n"

    @name = name

    if @array_member2 then
      i = 0
      while i < @array_member2.length
        if @array_member2[i] != self && @array_member[i] != nil then
          # @array_member2[i] �� nil �ˤʤ�Τ� optional �λ��ȡ�
          # Join �� initialize ��̵�̤� @array_member2 �����ꤵ��Ƥ�����
          # ̵�̤����ꤵ��Ƥ����ΤˤĤ��Ƥϡ��Ƶ�Ū�˸ƤӽФ�ɬ�פϤʤ���clone_for_composite �Ǥ��к����Ƥ����
          @array_member2[i].change_name( name )
        end
        i += 1
      end
    end
  end

  # composite cell ��Ÿ����������η��� clone ���������̾�����ѹ�
  def change_rhs_port( clone_cell_list, celltype )

    # debug
    if $debug then
      dbgPrint "change_rhs name: #{@name}  cell_name: #{@cell_name} #{@cell} #{self}\n"

      clone_cell_list.each{ |cell, ce|
        dbgPrint "change_rhs:  #{cell.get_name}=#{cell} : #{ce.get_name}\n"
      }
    end

    c = clone_cell_list[@cell]
    return if c == nil

    # debug
    dbgPrint "  cell_name:   #{@cell_name} => #{c.get_global_name}, #{c.get_name}\n"

    # @rhs �����Ƥ�Ĵ�����Ƥ����ʤ������Ƥϡ�subscript ������ơ��夫��Ȥ��Ƥ��ʤ���
    elements = @rhs.get_elements
    if elements[0] == :OP_SUBSC then  # ���ա�����������
      elements  = elements[1]
    end

    # ���դ���cell.ePort �η����Ǥʤ�
    if elements[0] != :OP_DOT || elements[1][0] != :IDENTIFIER then   #1
      return
    else
      # ����̾�� composite ������̾�����顢������̾���������ؤ���
      # elements[1][1] = Token.new( c.get_name, nil, nil, nil )
      elements[1][1] = NamespacePath.new( c.get_name, false, c.get_namespace )
    end

    @cell_name = c.get_name
    @cell = c
    # @definition = nil          # @definition ��ͭ���� �����å��ѤߡʤȤϡ����ʤ���

    if @array_member2 then

      # debug
      # p "array_member2.len : #{@array_member.length}"

      i = 0
      while i < @array_member2.length
        # @array_member2[i] �� nil �ˤʤ�Τ� optional �λ��ȡ�
        # Join �� initialize ��̵�̤� @array_member2 �����ꤵ��Ƥ�����
        # ̵�̤����ꤵ��Ƥ����ΤˤĤ��Ƥϡ��Ƶ�Ū�˸ƤӽФ�ɬ�פϤʤ���clone_for_composite �Ǥ��к����Ƥ����
        if @array_member2[i] != self && @array_member[i] != nil then
          @array_member2[i].change_rhs_port( clone_cell_list, celltype )
        end
        i += 1
      end
    end

  end

  #=== Join# composite �����Ѥ˥�����
  #cell_global_name:: string : �ƥ���Υ����Х�̾
  # ���դ� C_EXP �˴ޤޤ�� $id$, $cell$, $ct$ ���ִ�
  # �������ִ�����Τ� composite �� attribute �� C_EXP �� composite ���륿���פ���ӥ���̾���ִ����뤿��
  # ����������� C_EXP �⤳�����ִ�������
  # @through_list �ʤɤ⥳�ԡ������Τǡ����줬�ƤӽФ�������˳��ꤹ��ɬ�פ�����
  def clone_for_composite( ct_name, cell_name, locale, b_need_recursive = true )

    # debug
    dbgPrint "join.clone_for_composite : #{@name} #{@cell_name} #{self}\n"
    cl = self.clone

    if @array_member2 && b_need_recursive then
      cl.clone_array_member( @array_member, @array_member2, ct_name, cell_name, self, locale )
    end

    rhs = CDLInitializer.clone_for_composite( @rhs, ct_name, cell_name, locale )
    cl.change_rhs rhs

    # debug
    dbgPrint "join cloned : #{cl}\n"
    return cl
  end

  def clone_array_member( array_member, array_member2, ct_name, cell_name, prev, locale )
    # ����Υ��ԡ�����
    am  = array_member.clone
    am2 = array_member2.clone

    # �������ǤΥ��ԡ�����
    i = 0
    while i < am2.length
      if array_member2[i] == prev then
        # ��ʬ���ȤǤ���ʤΤǡ��ƽФ���̵�ºƵ��ƽФ��Ȥʤ��
        am2[i] = self
      elsif array_member2[i] then
        am2[i] = array_member2[i].clone_for_composite( ct_name, cell_name, locale, false )
      else
        # �����Υ��顼�� array_member2[i] �� nil �ˤʤäƤ���
      end

      # debug
      dbgPrint "clone_array_member: #{@name} #{am2[i]} #{array_member2[i]}\n"

      i += 1
    end

    # i = 0 �ϡ������Ǽ�ʬ���Ȥ�����
    # am2[0] = self

    @array_member  = am
    @array_member2 = am2

  end

  #=== Join# rhs �����촹����
  #rhs:: Expression | initializer
  # ���դ����촹���롥
  # ���Υ᥽�åɤϡ�composite �� cell ��°���ν���ͤ� attribute ���ͤ��֤�������Τ˻Ȥ���
  # ���Υ᥽�åɤ� composite ��� cell ��°���ν���ͤ�����ǤϤʤ����ˤʤä���硢���פˤʤ�
  def change_rhs rhs
    @rhs = rhs
  end

  #=== Join# clone ���줿 join �� owner ���ѹ�
  def set_cloned( owner )
    dbgPrint "Join#set_cloned: #{@name}  prev owner: #{@owner.get_name} new owner: #{owner.get_name}\n"
    @owner = owner
  end

  def show_tree( indent )
    indent.times { print "  " }
    puts "Join: name: #{@name} global_name: #{@global_name} owner: #{@owner.get_name} id: #{self}"
    if @subscript == nil then
    elsif @subscript >= 0 then
      (indent+1).times { print "  " }
      puts "subscript: #{@subscript}"
    else
      (indent+1).times { print "  " }
      puts "subscript: not specified"
    end
    (indent+1).times { print "  " }
    puts "rhs: "
    if @rhs.instance_of?( Array )then
      @rhs.each{ |i|
        if i.instance_of?( Array )then
          i.each{ |j|
            j.show_tree( indent + 3 )
          }
        elsif i.instance_of? Symbol then
          (indent+2).times { print "  " }
          print i
          print "\n"
        else
          i.show_tree( indent + 2 )
        end
      }
    else
      @rhs.show_tree( indent + 2 )
      (indent+1).times { print "  " }
      if @definition then
        puts "definition:"
        @definition.show_tree( indent + 2 )
      else
        puts "definition: not found"
      end
    end
    if @definition.instance_of?( Port ) then
      (indent+2).times { print "  " }
      if @cell then
        puts "cell: #{@cell_name} #{@cell}  port: #{@port_name}  cell_global_name: #{@cell.get_global_name}"
      else
        puts "cell: #{@cell_name} port: #{@port_name}  (cell not found)"
      end
    end
    if @through_list then
      i = 0
      @through_list.each { |t|
        (indent+2).times { print "  " }
        puts "through: plugin name :  '#{t[0]}' arg : '#{t[2]}'"
        if @through_generated_list[i] then
          @through_generated_list[i].show_tree( indent+3 )
        end
        i += 1
      }
    end
    if @array_member2 then
      (indent+1).times { print "  " }
      puts "array member:"
      i = 0
      @array_member2.each { |j|
        if j then
          (indent+2).times { print "  " }
          puts "[#{i}]: #{j.get_name}  id: #{j}"
          j.get_rhs.show_tree(indent+3)
          (indent+3).times { print "  " }
          puts "cell global name: #{j.get_cell_global_name}"
          (indent+3).times { print "  " }
          puts "port global name: #{j.get_port_global_name}"
        else
          (indent+2).times { print "  " }
          puts "[#{i}]: [optional]  id: #{j}"
        end
        i += 1
      }
    end
  end

end


# CLASS: CompositeCelltype �Ѥ� Join
# REM:   CompositeCelltype �� export ������
class CompositeCelltypeJoin < BDNode
# @export_name:: string     :  CompositeCelltype �� export ����̾���ʸƤӸ�����������°����
# @internal_cell_name:: string : CompositeCelltype �����Υ����̾��
# @internal_cell_elem_name:: string : CompositeCelltype �����Υ���θƤӸ�����������°����̾��
# @cell : Cell : Cell::  internal cell  : CompositeCelltyep �����Υ����in_composite�����
# @port_decl:: Port | Decl
# @b_pseudo: bool : 

  def initialize( export_name, internal_cell_name,
		 internal_cell_elem_name, cell, port_decl )
    super()
    @export_name = export_name
    @internal_cell_name = internal_cell_name
    @internal_cell_elem_name = internal_cell_elem_name
    @cell = cell
    @port_decl = port_decl

  end

  #=== CompositeCelltypeJoin# CompositeCelltypeJoin ���оݥ��뤫��
  #cell::  Cell �оݤ��ɤ��������å����륻��
  #
  #     CompositeCelltypeJoin �� cell ��̾�������פ��뤫�����å�����
  #     port_decl �����ꤵ�줿���ϡ������Ȥ��Ƥ��ʤ�
  def match?( cell, port_decl = nil )

    #debug
    if port_decl
      dbgPrint(  "match?"  )
      dbgPrintf( "  @cell:      %-20s      %08x\n", @cell.get_name, @cell.object_id )
      dbgPrintf( "  @port_decl: %-20s      %08x\n", @port_decl.get_name, @port_decl.object_id )
      dbgPrintf( "  cell:       %-20s      %08x\n", cell.get_name, cell.object_id )
      dbgPrintf( "  port_decl:  %-20s      %08x\n", port_decl.get_name, port_decl.object_id )
      dbgPrint(  "  cell_name: #{cell.get_name.class}=#{cell.get_name} cell_elem_name: #{port_decl.get_name.class}=#{port_decl.get_name}\n" )
      dbgPrint(  "  @cell_name: #{@cell.get_name.class}=#{@cell.get_name} cell_elem_name: #{@port_decl.get_name.class}=#{@port_decl.get_name}\n" )

    end

#    if @cell.equal?( cell ) && ( port_decl == nil || @port_decl.equal?( port_decl ) ) then
    # �ʤ� port_decl �����פ��ʤ���Фʤ�ʤ��ä���˺�줿��
    # recursive_composite ��̾���ΰ��פ��ѹ�   060917
    if((@cell.get_name == cell.get_name) && (port_decl == nil || @port_decl.get_name == port_decl.get_name))then
      true
    else
      false
    end
  end

  def check_dup_init
    return if get_port_type != :CALL

    if @cell.get_join_list.get_item @internal_cell_elem_name then
      cdl_error( "S1131 \'$1.$2\' has duplicate initializer" , @internal_cell_name, @internal_cell_elem_name )
    end
  end

  def get_name
    @export_name
  end

  def get_cell_name
    @internal_cell_name
  end

  def get_cell
    @cell
  end

  def get_cell_elem_name
    @internal_cell_elem_name
  end

  # @port_decl �� Port �ξ��Τ߸ƤӽФ��Ƥ褤
  def get_port_type
    if @port_decl then
      @port_decl.get_port_type
    end
  end

  def get_port_decl
    @port_decl
  end

  #=== CompositeCelltypeJoin#get_allocator_instance
  def get_allocator_instance
    if @port_decl.instance_of? Port then
      return @port_decl.get_allocator_instance
    elsif @port_decl
      raise "CompositeCelltypeJoin#get_allocator_instance: not port"
    else
      return nil
    end
  end

  # @port_decl �� Port �ξ��Τ߸ƤӽФ��Ƥ褤
  def is_require?
    if @port_decl then
      @port_decl.is_require?
    end
  end

  # @port_decl �� Port �ξ��Τ߸ƤӽФ��Ƥ褤
  def is_allocator_port?
    if @port_decl then
      @port_decl.is_allocator_port?
    end
  end

  # @port_decl �� Port �ξ��Τ߸ƤӽФ��Ƥ褤
  def is_optional?
    if @port_decl then
      @port_decl.is_optional?
    end
  end

  #=== CompositeCelltypeJoin# ���դ� Decl �ʤ�н�����ҡʼ��ˤ��֤�
  # ���Υ᥽�åɤ� Cell �� check_join �������ͥ����å��Τ���˸ƤӽФ����
  def get_initializer
    if @port_decl.instance_of? Decl then
      @port_decl.get_initializer
    end
  end

  def get_size_is
    if @port_decl.instance_of? Decl then
      @port_decl.get_size_is
    end
  end

  #=== CompositeCelltypeJoin# ���󥵥���������
  #RETURN:: nil: not array, "[]": �礭������ʤ�, Integer: �礭�����ꤢ��
  def get_array_size
    @port_decl.get_array_size
  end

  def show_tree( indent )
    indent.times { print "  " }
    puts "CompositeCelltypeJoin: export_name: #{@export_name} #{self}"
    (indent+1).times { print "  " }
    puts "internal_cell_name: #{@internal_cell_name}"
    (indent+1).times { print "  " }
    puts "internal_cell_elem_name: #{@internal_cell_elem_name}"
    if @port_decl then
      @port_decl.show_tree( indent + 1 )
    end
  end
end

class Factory < BDNode
# @name:: string
# @file_name:: string
# @format:: string
# @arg_list:: Expression �� elements ��Ʊ������ [ [:IDENTIFIER, String], ... ]
# @f_celltype:: bool : true: celltype factory, false: cell factory

  @@f_celltype = false

  def initialize( name, file_name, format, arg_list )
    super()
    @f_celltype = @@f_celltype

    case name
    when :write
      # write �ؿ�
      @name = name

      # write �ؿ�����������������ե�����̾
        # ����ɾ��������̾�ñ���ʸ����Ǥ��뤫�顢ñ���ʸ�����֤�����
      @file_name = file_name.eval_const(nil).val  # file_name : Expression
      if ! @file_name.instance_of?( String ) then
        # ʸ��������ǤϤʤ��ä�
        cdl_error( "S1132 $1: 1st parameter is not string(file name)" , @name )
        @file_name = nil
      end

      # write �ؿ�������������ե����ޥå�ʸ����
      @format    = format.eval_const(nil).val     # format : Expression
        # ����ɾ��������̾�ñ���ʸ����Ǥ��뤫�顢ñ���ʸ�����֤�����
      if ! @format.instance_of?( String ) then
        # ʸ��������ǤϤʤ��ä�
        cdl_error( "S1133 $1: 2nd parameter is not string(fromat)" , @name )
        @format = nil
      end

      # �軰�����ʹߤ�����ꥹ�ȤȤ��� mikan �����Υ����å�
      @arg_list = arg_list

    else
      cdl_error( "S1134 $1: unknown factory function" , name )
    end
    Celltype.new_factory( self )
  end

  def check_arg( celltype )
    if ! @arg_list then
      return
    end

    if @f_celltype then
      cdl_error( "S1135 celltype factory can\'t have parameter(s)"  )
      return
    end

    @arg_list.each{ |elements|

      case elements[0]
      when :IDENTIFIER  #1
        obj = celltype.find( elements[1] )
        if obj == nil then
          cdl_error( "S1136 \'$1\': not found" , elements[1] )
        elsif ! obj.instance_of?( Decl ) || obj.get_kind != :ATTRIBUTE then
          cdl_error( "S1137 \'$1\': not attribute" , elements[1] )
        end
      when :STRING_LITERAL
      else
        cdl_error( "S1138 internal error Factory.check_arg()"  )
      end

    }
  end

  def self.set_f_celltype( f_celltype )
    @@f_celltype = f_celltype
  end

  def get_f_celltype
    @f_celltype
  end

  def get_name
    @name
  end

  def get_file_name
    @file_name
  end

  def get_format
    @format
  end

  def get_arg_list
    @arg_list
  end

  def show_tree( indent )
    indent.times { print "  " }
    puts "Factory: name: #{@name}"
    if @arg_list then
      (indent+1).times { print "  " }
      puts "argument(s):"
      @arg_list.each { |l|
        (indent+2).times { print "  " }
        print "\"#{l}\"\n"
      }
    end
  end
end


#== Region ���饹
# 
# Region �� Namespace ��Ѿ����Ƥ���
# root region ���ü�ǡ�root namespace ��Ʊ���Ǥ���
#
# cell �� region ��°����
# region ��°���� cell �Υꥹ�Ȥ� Namespace ���饹�Υ��󥹥����ѿ��Ȥ��Ƶ��������
#
class Region < Namespace
# @name:: string
# @in_through_list:: [ [ plugin_name, plugin_arg ], ... ] : plungin_name = nil �λ� in �ػ�
# @out_through_list:: [ [ plugin_name, plugin_arg ], ... ] : plungin_name = nil �λ� out �ػ�
# @to_through_list:: [ [ dst_region, plugin_name, plugin_arg ], ... ]
# @cell_port_throug_plugin_list:: { "#{cell_name}.#{port_name}" => through_generated_list ������ }
#    ���� region ���� cell_name.port_name �ؤ� through �ץ饰������������줿���֥�������
# @region_type::Symbol : :NODE, :LINKUNIT, :DOMAIN, :CLASS
# @region_type_param::Symbol : domain, class ��̾��. node, linkunit �Ǥ� nil
# @link_root:: Region : linkUnit �κ��ä��Ȥʤ� region (node, linkunit �����ꤵ�줿 region)
# @family_line:: [ @region_root, ...,@region_me ]  �ȷ�
# @in_through_count:: Integer :  n ���ܤ� in_through ��� (n>=0)
# @out_through_count:: Integer : n ���ܤ� out_through ��� (n>=0)
# @to_through_count:: { :RegionName => Integer }: RegionName �ؤ� n ���ܤ� to_through ��� (n>=0)

  @@in_through_list  = []
  @@out_through_list = []
  @@to_through_list  = []
  @@region_type = nil
  @@region_type_param = nil

  @@link_roots = []

  def initialize( name )
    # mikan name �� Namespace ����
    # object = Namespace.find( [ name ] )   # �Ƥޤ��ܤ��ˤ���
    if name != "::" then
      object = Namespace.get_current.find( name )    #1
    else
      # root �꡼�����
      object = nil
      @@region_type = :NODE
    end

    @in_through_list    = @@in_through_list
    @out_through_list   = @@out_through_list
    @to_through_list    = @@to_through_list
    @region_type        = @@region_type
    @region_type_param  = @@region_type_param

    @@in_through_list   = []
    @@out_through_list  = []
    @@to_through_list   = []
    @@region_type       = nil
    @@region_type_param = nil

    @in_through_count = -1
    @out_through_count = -1
    @to_through_count = {}

    super( name )
    if object then

      if object.instance_of?( Region ) then
        dbgPrint "Region.new: re-appear #{@name}\n"

        # # Region path ������и��Ȱ��פ��뤫��
        # if @@region_stack[ @@region_stack_sp - 1 ] then
        #   my_path = @@region_stack[ @@region_stack_sp - 1 ].get_path_string.to_s + "." + @name.to_s
        # else
        #   my_path = @name.to_s
        # end
        # if my_path != object.get_path_string then
        #   cdl_error( "S1139 $1: region path mismatch. previous path: $2" , my_path, object.get_path_string )
        # end

        # �ƽи�
        # @@region_stack[@@region_stack_sp] = object

        # �ƽи����� specifier �����ꤵ��Ƥ��뤫��
        if( @in_through_list.length != 0 || @out_through_list.length != 0 || @to_through_list.length != 0 || @region_type != nil )then
          cdl_error( "S1140 $1: region specifier must place at first appearence" , name )
        end
        return

      else
        # ���顼�ѥ��ߡ����

        # �ۤʤ�Ʊ̾�Υ��֥������Ȥ�����Ѥ�
        cdl_error( "S1141 $1 duplication, previous one : $2" , name, object.class )
        # @@region_stack[@@region_stack_sp] = self    # ���顼������ region
      end
    else
      # ��и�
      dbgPrint "Region.new: #{@name}\n"
      set_region_family_line

      if @region_type == :NODE || @region_type == :LINKUNIT then
        dbgPrint "new LinkRoot: #{@name}\n"
        @@link_roots << self
      end
    end

    @cell_port_throug_plugin_list = {}

# p @name
# p @in_through_list
# p @out_through_list
# p @to_through_list

  end

  def self.end_of_parse
    Namespace.get_current.end_of_parse
  end

  def self.new_in_through( plugin_name = nil, plugin_arg = nil )
    @@in_through_list << [ plugin_name, plugin_arg ]
  end

  def self.new_out_through( plugin_name = nil, plugin_arg = nil )
    @@out_through_list << [ plugin_name, plugin_arg ]
  end

  def self.new_to_through( dst_region, plugin_name, plugin_arg )
    # p "New to_through #{dst_region}"
    @@to_through_list  << [ dst_region, plugin_name, plugin_arg ]
  end

  def self.set_type( type, param = nil )
    if @@region_type then
      Generator.error( "S9999 $1 region type specifier duplicate, previous $2", type, @@region_type )
    end
    @@region_type = type
    @@region_type_param = param
  end

  def set_region_family_line
    @family_line = []
    @link_root = nil

    # root namespace (root region) �� region type �� :NODE
    if @name == "::" then
      @region_type = :NODE
    end
    dbgPrint  "set_region_family_line: Region: #{@name}  \n"

    # @family_line ���������
    # @link_root ��ߤĤ���
    # (��̤ˤ��ɤäƤ��ä� Region �� node �ޤ��� linkunit �Τ����줫��˸��Ĥ��ä���Τ� @link_root �Ȥʤ�)
    # root namespace �� Region ���� node �ʤΤ�ɬ�� @link_root �ϸ��Ĥ���
    # mikan: self �� node, linkUnit �ξ�硢�����Ǵ��Ԥ����Ȥ�������ꤵ��ʤ����ᡢRegion#initialize �Ǻ�����
    obj = self
    while 1
      if obj.instance_of? Region then
        @family_line << obj
        if @link_root == nil then
          if obj.get_region_type == :NODE || obj.get_region_type == :LINKUNIT then
            @link_root = obj
          end
        end
      else
        # ����ʤ���� Namespace
        # namespace �β��� region ��������
      end

      # root namespace �ˤ��ɤ��失�н���
      break if obj.get_name == "::"

      obj = obj.get_owner
    end
    # print "#{@name}: linkRoot: #{@link_root.get_name}  (this can be wrong if #{@name} is node or linkunit, and corret later\n"
    @family_line.reverse!
  end

  def self.get_link_roots
    @@link_roots
  end

  def get_family_line
    @family_line
  end

  def get_in_through_list
    @in_through_list
  end

  def get_out_through_list
    @out_through_list
  end

  def get_to_through_list
    @to_through_list
  end

  def get_link_root
    @link_root
  end

  def get_path_string
    pstring = ""
    delim = ""
    @family_line.each{ |p|
      pstring = "#{pstring}#{delim}#{p.get_name}"
      delim = "."
    }
    dbgPrint "get_path_string: #{pstring}\n"
    pstring
  end

  def get_region_type
    @region_type
  end

  def get_name
    @name
  end

  def next_in_through_count
    @in_through_count += 1
  end

  def next_out_through_count
    @out_through_count += 1
  end

  def next_to_through_count( symRegionName )
    if @to_through_count[ symRegionName ] == nil then
      @to_through_count[ symRegionName ] = 0
    else
      @to_through_count[ symRegionName ] += 1
    end
  end

  #=== Region# ��ʸ������� region ������
  # ��ʸ������ Namespace (���뤤�ϻҥ��饹�� Region) �ξ�̤򤿤ɤä� Region �򸫤Ĥ���
  # cell �� namespace ���ˤ������Ȥ��Ǥ��ʤ���С��롼�פ�ޤ魯ɬ�פϤʤ�
  def self.get_current
    # @@region_stack[@@region_stack_sp]
    region = Namespace.get_current
    while 1
      if region.instance_of? Region
        break
      end
      region = region.get_owner
    end
    return region
  end

  #=== Region# through �ץ饰����ǡ����� region ���� cell_name.port_name �ؤΥץ饰���󥪥֥������Ȥ���Ͽ
  # mikan namesppace �б� (cell_name)
  def add_cell_port_through_plugin( cell_name, port_name, through_plugin_object )
    @cell_port_throug_plugin_list[ "#{cell_name}.#{port_name}" ] = through_plugin_object
  end

  def find_cell_port_through_plugin( cell_name, port_name )
    return @cell_port_throug_plugin_list[ "#{cell_name}.#{port_name}" ]
  end

  #=== Region# to_region �ؤε�Υ��unreachable �ʾ�� nil)
  # mikan Cell#check_and_gen_through ��Region �ؤ��ɤ��夯�ޤǤ���ν���������
  def distance( to_region )

    r1 = self                   # ��ȯ region
    r2 = to_region              # ��Ū region
    dist = 0

    if ! r1.equal? r2 then      # Ʊ�� region �ʤ�ƽФ���ǽ

      # mikan namespace �б�
      f1 = r1.get_family_line
      len1 = f1.length
      f2 = r2.get_family_line
      len2 = f2.length

      # �԰��פˤʤ�Ȥ���ʷ���ˤ�õ��
      i = 1  # i = 0 �� :RootRegion �ʤΤ�ɬ������
      while( i < len1 && i < len2 )
        if( f1[i] != f2[i] )then
          break
        end
        i += 1
      end

      sibling_level = i     # ����Ȥʤ��٥롢�⤷���Ϥɤ��餫����������ä���٥�

      # p "sibling_level: #{i}"
      # p "from: #{f1[i].get_name}" if f1[i]
      # p "to: #{f2[i].get_name}" if f2[i]

      # �Ƥ�¦�ˤĤ��ƸƤӸ��Υ�٥뤫�鷻���٥�ޤǡ�out_through ������å������������
      i = len1 -1
      while i >= sibling_level
        dbgPrint "going out from #{f1[i].get_name} level=#{i}\n"
        out_through_list = f1[i].get_out_through_list   # [ plugin_name, plugin_arg ]
        if out_through_list.length == 0 then
          return nil
        end
        i -= 1
        dist += 1
      end

      # �����٥�ˤ����ơ�to_through ������å������������
      if f1[sibling_level] && f2[sibling_level] then
        dbgPrint "going from #{f1[sibling_level].get_name} to #{f2[sibling_level].get_name}\n"
        found = 0
        f1[sibling_level].get_to_through_list.each { |t|
          if t[0][0] == f2[sibling_level].get_name then   # region ̾�����פ��뤫 ?
            found = 1
          end
        }
        if found == 0 then
          return nil
        end
        dist += 1
      end

      # ����¦�ˤĤ��Ʒ����٥뤫�����¦�Υ�٥�ޤǡ�in_through ������å������������
      i = sibling_level
      while i < len2
        dbgPrint "going in to #{f2[i].get_name} level=#{i}\n"
        in_through_list = f2[i].get_in_through_list   # [ plugin_name, plugin_arg ]
        if in_through_list.length == 0 then
          return nil
        end
        i += 1
        dist += 1
      end
    end

    dbgPrint "dsitance=#{dist} from #{r1.get_name} to #{r2.get_name}\n"

    return dist
  end

  def show_tree( indent )
    super
    (indent+1).times { print( "  " ) }
    puts "path: #{get_path_string}"
    (indent+1).times { print( "  " ) }
    puts "namespace: #{@namespace ? @namespace.get_name : "nil"}  owner: #{@owner.class}.#{@owner ? @owner.get_name : "nil"}"
  end
end

class Import_C < Node

  # �إå���̾��ʸ����Υꥹ��
  @@header_list = {}
  @@header_list2 = []
  @@define_list = {}

  #=== Import_C# import_C �������ʥإå��ե�����������
  #header:: Token : import_C ��������ʸ�����ƥ��ȡ�����
  #define:: Token : import_C ���������ʸ�����ƥ��ȡ�����
  def initialize( header, define = nil )
    super()
    # �إå��ե�����̾ʸ���󤫤������ "" �������
    # header = header.to_s.gsub( /\A"(.*)"\z/, '\1' )
    header = CDLString.remove_dquote header.to_s

    if define then
      # ����� "" �������
      # def_opt = define.to_s.gsub( /\A"(.*)/, '\1' )
      # def_opt.sub!( /(.*)"\z/, '\1' )
      def_opt = CDLString.remove_dquote define.to_s

      # "," �� -D ���֤�����
      def_opt = def_opt.gsub( /,/, " -D " )

      # ��Ƭ�� -D ������ # mikan ��Ŭ�ڤ� define ���Ϥ����ä���硢CPP ���˥��顼
      def_opt = def_opt.gsub( /^/, "-D " )

    end

    # ���ޥ�ɥ饤����ꤵ�줿 DEFINE 
    $define.each{ |define|
      if $IN_EXERB then
        q = ""
      else
        if define =~ /'/ then
          q = '"'
        else
          q = "'"
        end
      end
      def_opt = "#{def_opt} -D #{q}#{define}#{q}"
    }

    include_opt = ""
    found = false
    header_path = ""
    $import_path.each{ |path|
      include_opt = "#{include_opt} -I #{path}"
      if found == false then
        begin
          # �ե������ stat ���äƤߤ�(�ʤ�����㳰ȯ��)
          File.stat( "#{path}/#{header}" )

          # cdl �򸫤Ĥ��ä��ե�����ѥ��˺�����
          header_path = "#{path}/#{header}"
          found = true
        rescue
          found = false
        end
      end
    }

    if found == false then
      cdl_error( "S1142 $1 not found in search path" , header )
      return
    end

    # �ɹ��ߺѤߡ�
    if( @@header_list[ header ] ) then
      # ������� define �������Ȱۤʤ�
      if @@define_list[ header ].to_s != define.to_s then
        cdl_error( "S1143 import_C: arg2: mismatch with previous one"  )
      end
      # ������ˤ����ɤ߹��ޤʤ�
      return
    end

    # �إå��Υꥹ�Ȥ�Ͽ
    @@header_list[ header ] = header_path
    @@header_list2 << header
    @@define_list[ header ] = define

    begin
      tmp_C = "#{$gen}/tmp_C_src.c"
      file = File.open( tmp_C, "w" )
    rescue
      cdl_error( "S1144 $1: temporary C source: open error" , tmp_C )
    end

    begin
      print_defines file

      file.print( "#include \"#{header}\"\n" )
    rescue
      cdl_error( "S1145 $1: temporary C source: writing error" , tmp_C )
    ensure
      file.close
    end

    # CPP ������ tmp �ե�����̾
    tmp_header = header.gsub( /\//, "_" )
    tmp_header = "#{$gen}/tmp_#{tmp_header}"

    # CPP ���ޥ�ɥ饤������
    cmd = "#{$cpp} #{def_opt} #{include_opt} #{tmp_C}"

    begin
      if( $verbose )then
        puts "CPP: #{cmd}"
      end

      # �ץ�ץ��å����ޥ�ɤ� pipe �Ȥ��Ƴ���
          # cmd �� cygwin/Linux �Ǥ� bash(sh) ��ͳ�Ǽ¹Ԥ����
          # Exerb �ǤǤ� cmd.exe ��ͳ�Ǽ¹Ԥ����
          # ���κ��ϰ������� (), $, % �ʤɥ���������̤�ʸ����ɾ���˸����Τ����
      cpp = IO.popen( cmd, "r" )
      begin
        tmp_file = nil
        tmp_file = File.open( tmp_header, "w" )
        cpp.each { |line|
          line = line.gsub( /^#(.*)$/, '/* \1 */' )
          tmp_file.puts( line )
        }
      rescue
        cdl_error( "S1146 $1: error occured while CPP" , header )
      ensure
        tmp_file.close if tmp_file    # mikan File.open �˼��Ԥ����� tmp_file == nil ���ݾڤ���Ƥ��� ?
        cpp.close
      end
    rescue
      cdl_error( "S1147 $1: popen for CPP failed" , header )
    end

    # C ����Υѡ������󥹥��󥹤�����
    c_parser = C_parser.new

    # tmp_header ��ѡ���
    c_parser.parse( [tmp_header] )

    # ���������ѡ��������å����᤹
    c_parser.finalize

  end

  def print_defines file
    if ! $b_no_gcc_extension_support then
      
    file.print <<EOT

#ifndef TECS_NO_GCC_EXTENSION_SUPPORT

/*
 * these extension can be eliminated also by spefcifying option
 * --no-gcc-extension-support for tecsgen.
 */
#ifndef __attribute__
#define __attribute__(x)
#endif

#ifndef __extension__
#define __extension__
#endif

#ifndef __builtin_va_list
#define __builtin_va_list va_list
#endif

#ifndef __asm__
#define __asm__(x)
#endif

#endif /* TECS_NO_GCC_EXTENSION_SUPPORT */
EOT
    end

    file.print <<EOT

/* va_list is not supported in C_parser.y.rb */
typedef struct { int dummy; } va_list;

EOT
  end

  def self.get_header_list
    @@header_list
  end
  def self.get_header_list2
    @@header_list2
  end

end

class Import < Node
# @b_reuse::bool:       �����ѡ����륿���פ� template ��������
# @b_reuse_real::bool:  �ºݤ˺�����
# @cdl::      string:   import ���� CDL
# @cdl_path:: string:   CDL �Υѥ�
# @b_imported:: bool:   import ���줿(���ޥ�ɥ饤����ꤵ��Ƥ��ʤ�)

  # �إå���̾��ʸ����Υꥹ��  ź����expand �����ѥ����͡�Import
  @@import_list = {}

  @@nest_stack_index = -1
  @@nest_stack = []
  @@current_object = nil

  def self.push object
    @@nest_stack_index += 1
    @@nest_stack[ @@nest_stack_index ] = @@current_object
    @@current_object = object
  end

  def self.pop
    @@current_object = @@nest_stack[ @@nest_stack_index ]
    @@nest_stack_index -= 1
    if @@nest_stack_index < -1 then
      raise "TooManyRestore"
    end
  end

  #=== Import# import ��Ԥ�
  #cdl::      string   cdl �ؤΥѥ���"" �ǰϤޤ�Ƥ��뤳�Ȥ���
  #b_reuse::  bool     true: template ���������ʤ�
  def initialize( cdl, b_reuse = false, b_imported = true )
    Import.push self
    @b_imported = b_imported
    super()
    @@current_import = self
    # �إå��ե�����̾ʸ���󤫤������ "", <> �������n
    @cdl = cdl.to_s.gsub( /\A["<](.*)[">]\z/, '\1' )

    # �������ѥ�����õ��
    found = false
    @cdl_path = ""

    @b_reuse = b_reuse
    @b_reuse_real = @b_reuse || Generator.is_reuse?

    if Generator.get_plugin then
      # plugin ���� import ����Ƥ����� gen �򥵡����ѥ�����Ƭ�˲ä���
      search_path = [ $gen ] + $import_path
    else
      search_path = $import_path
    end

    search_path.each{ |path|
      dbgPrint "import: searching #{path}/#{@cdl}"
      begin
        # �ե������ stat ���äƤߤ�(�ʤ�����㳰ȯ��)
        File.stat( "#{path}/#{@cdl}" )

        # cdl �򸫤Ĥ��ä��ե�����ѥ��˺�����
        @cdl_path = "#{path}/#{@cdl}"
        found = true
        dbgPrint ": found\n"
        break
      rescue
        found = false
        dbgPrint ": not found\n"
      end
    }

    if found == false then
      cdl_error( "S1148 $1 not found in search path" , @cdl )
      return
    end

    # �ɹ��ߺѤߤʤ顢�ɹ��ޤʤ�
    prev = @@import_list[ File.expand_path( @cdl_path ) ]
    if( prev ) then
      if prev.is_reuse_real? != @b_reuse_real then
        cdl_warning( "W1008 $1: reuse designation mismatch with previous import" , @cdl )
      end
      return
    end

    # import �ꥹ�Ȥ�Ͽ
    @@import_list[ File.expand_path( @cdl_path ) ] = self

    # plugin ���� import ����Ƥ�����
    plugin = Generator.get_plugin

    # �ѡ������󥹥��󥹤�����(�̥ѡ������ɤ߹���)
    parser = Generator.new

    # plugin ���� import ����Ƥ������ plugin ����
    parser.set_plugin plugin

    # reuse �ե饰������
    parser.set_reuse @b_reuse_real

    # cdl ��ѡ���
    parser.parse( [@cdl_path] )

    # ���������ѡ��������å����᤹
    parser.finalize
    Import.pop
  end

  def self.get_list
    @@import_list
  end

  def get_cdl_path
    @cdl_path
  end

  def is_reuse_real?
    @b_reuse_real
  end

  def self.get_current
    @@current_object
  end

  def is_imported?
    @b_imported
  end

  #=== cdl ��̾�����֤�
  # �����ǻ��ꤵ��Ƥ��� cdl ̾�������ѥ���ޤ��ǽ��������
  def get_cdl_name
    @cdl
  end
end

#== generate: signature �ץ饰����Υ��ɤȼ¹�
class Generate < Node
#@plugin_name:: Symbol
#@signature_nsp:: NamespacePath
#@option::         String '"', '"' �ǰϤޤ�Ƥ���

  include PluginModule

  def initialize( plugin_name, signature_nsp, option )
    super()
    @plugin_name = plugin_name
    @signature_nsp = signature_nsp
    option = option.to_s    # option �� Token
    @option = option

    signature = Namespace.find( signature_nsp ) #mikan Namespace   #1
    if ! signature.instance_of? Signature then
      cdl_error( "S1149 $1 not signature" , signature_nsp )
      return
    end

    load_plugin( plugin_name, SignaturePlugin )

    plugin_object = nil
    eval_str = "plugin_object = #{plugin_name}.new( signature, option )"
    if $verbose then
      print "new through: #{eval_str}\n"
    end

    begin
      eval( eval_str )     # plugin ������
      plugin_object.set_locale @locale
    rescue Exception => evar
      cdl_error( "S1150 $1: fail to new" , plugin_name )
      print "eval( #{eval_str} )\n"

      print_exception( evar )
    end
    generate_and_parse plugin_object
  end
end

#== ̾�����֥ѥ�
class NamespacePath < Node
#@b_absolute::Bool
#@path::[ Symbol,... ]
#@namespace::Namespace:  @b_absolute == false �ΤȤ��������Ȥʤ� namespace

  #=== NamespacePath# initialize
  #ident::Symbol           �ǽ��̾��, ������ "::" �Τߤξ��� String
  #b_absolute:Bool         "::" �ǻϤޤäƤ����� true
  #namespace::Namespace    b_absolute = false ���ġ���ʸ����ʳ��ʳ��ǸƤӽФ����ϡ�ɬ�����ꤹ�뤳�� 
  def initialize( ident, b_absolute, namespace = nil )
    super()

    if ident == "::" then   # RootNamespace
      @path = []
      @b_absolute = true
    else
      @path = [ ident ]
      @b_absolute = b_absolute
    end

    if namespace then
      @namespace = namespace
      if b_absolute == true then
        raise "NamespacePath#initialize: naamespace specified for absolute path"
      end
    else
      if b_absolute == false then
        @namespace = Namespace.get_current
      else
        @namespace = nil
      end
    end
  end

  #=== NamespacePath# append ����
  #RETURN self
  # ���Υ᥽�åɤϡ����� NamespacePath ���֥������Ȥ��ѷ������֤�
  def append!( ident )
    @path << ident
    return self
  end
  #=== NamespacePath# append ����
  # ���Υ᥽�åɤϡ����� NamespacePath ���֥������Ȥ��ѷ����ʤ�
  #RETURN:: ʣ������ NamespacePath
  def append( ident )
    cl = self.clone
    cl.set_clone
    cl.append!( ident )
    return cl
  end

  def set_clone
    @path = @path.clone
  end

  def get_name
    @path[ @path.length - 1 ]
  end

  #=== NamespacePath#��������������̾�����ѹ�����
  def change_name name
    cl = self.clone
    cl.set_clone
    cl.change_name_no_clone name
    return cl
  end
  alias :change_name_clone :change_name

  #=== NamespacePath#̾�����ѹ�����
  # ���Υ��󥹥��󥹤򻲾Ȥ��뤹�٤Ƥ˱ƶ���Ϳ���뤳�Ȥ����
  def change_name_no_clone name
    @path[ @path.length - 1 ] = name
    nil
  end

  #=== NamespacePath:: path ʸ���������
  # CDL �Ѥ� path ʸ���������
  def to_s
    get_path_str
  end
  def get_path_str
    first = true
    if @b_absolute then
      path = "::"
    else
      path = ""
    end
    @path.each{ |n|
      if first then
        path = "#{path}#{n}"
        first = false
      else
        path += "::#{n}"
      end
    }
    return path
  end

  def is_absolute?
    @b_absolute
  end
  def is_name_only?
    @path.length == 1 && @b_absolute == false
  end

  #=== NamespacePath:: �ѥ���������֤�
  # is_absolute? true �ξ�硢�롼�Ȥ���Υѥ�
  #              false �ξ�硢base_namespace ���������
  # �롼�� namespace �ξ�硢Ĺ������������֤�
  #
  def get_path
    @path
  end

  #=== NamespacePath#�ե�ѥ���������֤�
  # �֤��줿�����񤭴����ƤϤʤ�ʤ�
  def get_full_path
    if @b_absolute then
      return @path
    else
      return @namespace.get_namespace_path.get_full_path.clone + @path
    end
  end

  #=== NamespacePath:: ���Хѥ��Υ١����Ȥʤ� namespace
  # is_absolute? == false �λ��Τ�ͭ�����ͤ��֤� (true �ʤ� nil)
  def get_base_namespace
    @namespace
  end

  #=== NamespacePath:: C ���쥰���Х�̾������
  def get_global_name
    if @b_absolute then
      global_name = ""
    else
      global_name = @namespace.get_global_name
    end

    @path.each{ |n|
      if global_name != "" then
        global_name = "#{global_name}_#{n}"
      else
        global_name = n.to_s
      end
    }
    global_name
  end

  #=== NamespacePath:: ʬ�򤷤� NamespacePath ���󥹥��󥹤���������
  #path_str:: String       : namespace �ޤ��� region �Υѥ� ex) "::path::A" , "::", "ident"
  #b_force_absolute:: Bool : "::" �ǻϤޤäƤ��ʤ����Ǥ����Хѥ��˰���
  #
  # NamespacePath ���̾ﹽʸ���Ϥ���ƺ��������
  # ���Υ᥽�åɤϡ����ץ����ʤɤǻ��ꤵ���ʸ�����ʬ�򤷤� NamespacePath ����������Τ��Ѥ���
  # �����å��Ϥ�뤤����Ŭ�ڤʥѥ�����ϡ���Ŭ�ڤ� NamespacePath �����������
  def self.analyze( path_str, b_force_absolute = false )

    if path_str == "::" then
      return self.new( "::", true )
    end

    pa = path_str.split( "::" )
    if pa[0] == "" then
      pa.shift
      b_absolute = true
    else
      if b_force_absolute then
        b_absolute = true
      else
        b_absolute = false
      end
    end

    if pa[0] then
      nsp = self.new( pa[0].to_sym, b_absolute )
    else
      nsp = self.new( "::", b_absolute )
    end
    pa.shift

    pa.each{ |a|
      if a then
        nsp.append! a.to_sym
      else
        nsp.append! "::"
      end
    }

    return nsp
  end

end

# �ʲ�ñ�Υƥ��ȥ�����
if $unit_test then
  root_namespace = Namespace.new("::")

  puts( "===== Unit Test: NamespacePath ===== (componentobj.rb)")
  a = NamespacePath.new( :"ABC", true )
  printf( "Path: %-10s global_name: %s\n", a.get_path_str, a.get_global_name )

  a.append( :"DEF" )
  printf( "Path: %-10s global_name: %s\n", a.get_path_str, a.get_global_name )

  a = NamespacePath.new( :"abc", false )
  printf( "Path: %-10s global_name: %s\n", a.get_path_str, a.get_global_name )

  a.append( :"def" )
  printf( "Path: %-10s global_name: %s\n", a.get_path_str, a.get_global_name )

  puts ""
end
