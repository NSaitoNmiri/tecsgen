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
#   $Id: syntaxobj.rb 1975 2013-06-16 07:34:59Z okuma-top $
#++

# mikan ruby �� symbol ��ʸ����λȤ�ʬ�����ɤ����Ƥ⤦�ޤ������ʤ����Ȥ���������Τ� name.to_sym ������뤳�Ȥˤ���

#== Node
#
# Node ��ľ�ܤλҥ��饹�� C_EXP, Type, BaseVal, BDNode(�ۤȤ�ɤΤ�Τ� BDNode �λҥ��饹)
# Node �� (BDNode�ˤ�) ����ʤ����: Token, Import, Import_C, Generate
#
# owner ������ʤ���Τ� Node �Ȥʤ�
# ���顼�ϡ�cdl_error ���̤�����𤹤� (��̣���Ϥ���ʸ���ϸ�˹Ԥ�����ˤϡ����ֹ椬���������ϤǤ���
# 

class Node
#@locale::    [@file, @lineno, @col]

  def initialize
    @locale = Generator.current_locale
  end

  #=== ���顼����Ϥ���
  def cdl_error( message, *arg )
    Generator.error2( @locale, message, *arg )
  end

  #=== ���顼����Ϥ���
  #locale:: Array(locale info) : ��ʸ�������̵�뤵���
  def cdl_error2( locale, message, *arg )
    Generator.error2( locale, message, *arg )
  end

  #=== ���顼����Ϥ���
  #locale:: Array(locale info)
  # ��ʸ������ cdl_error2 �Ǥ� locale ��̵�뤵��뤿�ᡢ�̤� locale ����Ϥ���
  def cdl_error3( locale, message, *arg )
    Generator.error(  message, *arg )
    Console.puts "check: #{locale[0]}: line #{locale[1]} for above error"
  end

  #=== �������˥󥰽��Ϥ���
  def cdl_warning( message, *arg )
    Generator.warning2( @locale, message, *arg )
  end

  #=== �������˥󥰽��Ϥ���
  def cdl_warning2( locale, message, *arg )
    Generator.warning2( locale, message, *arg )
  end

  def get_locale
    @locale
  end

  def set_locale locale
    @locale = locale
  end
end

#== ������ Node (Bi Direction Node)
#
#  Node �λҥ��饹
#  owner Node ���黲�Ȥ���Ƥ����� (owner �ؤΥ�󥯤���Ф���)
#
#  get_owner ����������
#    FuncHead => Signature
#    Decl => Namespace(const), Typedef(typedef),
#            Celltype, CompositeCelltype(attr,var)
#            Struct(member), ParamDecl(parameter), FuncHead(funchead)
#    Signature, Celltype, CompositeCelltype, Typedef => Namespace
#,   Namespace => Namespace, Generator.class (root Namespace �ξ��)
#    Cell => Region, CompositeCelltype(in_composite)
#    Port => Celltype, Composite
#    Factory => Celltype
#    Join => Cell
#    CompositeCelltypeJoin => CompositeCelltype
#    Region => Region, 
#    ParamDecl => ParamList
#    ParamList => FuncHead
#    Expression => Namespace
#    ��Ⱦ�Τ�Τ� new_* �᥽�åɤ� owner Node ����ã�����
#    ���Υ᥽�åɤ��ƤӽФ��줿�Ȥ��� owner Node ����Ͽ�����
#    new_* ���ʤ���Ρ�
#            Decl(parameter), ParamDecl, ParamList, FuncHead, Expression 
#
#    Expression �ϡ�owner Node �Ȥʤ��Τ�¿�����뤬����¤������Ǥ��뤿��
#    Expression ��������줿�Ȥ��� Namespace �� owner Node �Ȥ���
#    StructType �� Type �ΰ��ʤΤ� owner ������ʤ�
#
class BDNode < Node
#@owner::Node
#@NamespacePath:: NamespacePath
#@Generator::
#@import::Import :  

  def initialize
    super
    @owner = nil
    @NamespacePath = nil
    @import = Import.get_current

  end

  #=== owner �����ꤹ��
  def set_owner owner
    dbgPrint "set_owner: #{owner.class.name}\n"
    @owner = owner
  end

  #=== owner ������
  # class �������򻲾�
  def get_owner
    if @owner == nil
      raise "Node have no owner #{self.class.name} #{get_name}"
    end
    @owner
  end
end

#== Namespace ̾����� BDNode
# Namespace(Region), Signature, Celltype, CompositeCelltype, Cell
class NSBDNode < BDNode

  def initialize
    super
  end

  #=== °���� namespace ������
  # owner �� namespace �ˤ��ɤ��夯�ޤǾ�ˤ��ɤ�
  def get_namespace
    if @owner.kind_of? Namespace
      return @owner
    elsif @owner != nil then
      return @owner.get_namespace
    else
      # @owner == nil �ʤ� "::"
      if @name != "::" then
        raise "non-root namespace has no owner #{self.class.name}##{@name} #{self}"
      end
      return nil
    end
  end

  def set_namespace_path
    ns = get_namespace
    if ns then
      @NamespacePath = ns.get_namespace_path.append( get_name )
    else
      raise "get_namespace_path: no namespace found"
    end
  end

  #=== NamespacePath ������
  def get_namespace_path
    return @NamespacePath
  end

  def is_imported?
    if @import then
      return @import.is_imported?
    else
      return false    # mikan: �� @import �� nil �ˤʤ륱�������ɵ�Ǥ��Ƥ��ʤ�
    end
  end
end

class NamedList
#  @names:: {} of items
#  @items:: [] of items : item �� CLASS �� get_name �᥽�åɤ���Ĥ��� get_name ������ͤ� Symbol �Ǥʤ��ƤϤʤ�ʤ�
#                         NamedList �� clone_for_composite ������ϡ�item �ˤ�᥽�åɤ�ɬ��
#  @type:: string	���顼��å�����

  def initialize( item, type )
    @names = {}
    @items = []
    @type = type
    add_item( item )
  end

  #=== ���Ǥ�ä���
  # parse ���������ǲä��뤳��(���򵭲�����)
  def add_item( item )

    if item then
      assert_name item
      name = item.get_name
      prev = @names[name]
      if prev then
        Generator.error( "S2001 \'$1\' duplicate $2" , name, @type )
        prev_locale = prev.get_locale
        puts "previous: #{prev_locale[0]}: line #{prev_locale[1]} \'#{name}\' defined here"
        return self
      end

      @names[name]=item
      @items << item
    end

    return self
  end

  def change_item( item )
    assert_name item
    name = item.get_name

    prev_one = @names[name]
    @names[name]=item

    @items = @items - [ prev_one ]
    @items << item
  end

  def del_item( item )
    assert_name item
    name = item.get_name
    @names.delete name

    @items = @items - [ item ]
  end

  def get_item( name )
    if ! name.kind_of? Symbol
      print "get_item: '#{name}', items are below\n"
      @names.each{ |nm,item|
        p nm
      }
      raise "get_item: #{name}: not Symbol"
    end
    if name then
      return @names[name.to_sym]
    else
      return nil
    end
  end

  def get_items
    return @items
  end

  #=== composite cell �� clone ������������(JOIN) �� clone ����
  #
  # mikan ���Υ᥽�åɤ� Join ���ò�����Ƥ���Τ� NamedList ����ʬΥ���٤�
  def clone_for_composite( ct_name, cell_name, locale )
    cl = self.clone
    cl.set_cloned( ct_name, cell_name, locale )
    return cl
  end

  #=== clone ���줿 NamedList ���󥹥��󥹤λ��Ȥ�����(item)�� clone
  #
  # mikan ���Υ᥽�åɤ� Join ���ò�����Ƥ���Τ� NamedList ����ʬΥ���٤�
  def set_cloned( ct_name, cell_name, locale )
    items = []
    names = {}
    @items.each { |i|
      dbgPrint "NamedList clone #{ct_name}, #{cell_name}, #{i.get_name}\n"

      cl = i.clone_for_composite( ct_name, cell_name, locale )
      names[cl.get_name] = cl
      items << cl
    }
    @items = items
    @names = names
  end

  def assert_name item
    if ! item.get_name.kind_of? Symbol
      raise "Not symbol for NamedList item"
    end
  end

  def show_tree( indent )
    @items.each { |i|
      i.show_tree( indent )
    }
  end

end

class Typedef < BDNode
# @declarator:: Decl

  def self.new_decl_list( type_spec_qual_list, decl_list )
    decl_list.each { |decl|
       Typedef.new( type_spec_qual_list, decl )
    }
  end

  def initialize( type_spec_qual_list, decl )
    super()
    decl.set_type( type_spec_qual_list )
    @declarator = decl
    decl.set_owner self    # Decl(Typedef)

    Namespace.new_typedef( self )
  end

  def get_name
    @declarator.get_name
  end

  def get_declarator
    @declarator
  end

  def show_tree( indent )
    indent.times { print "  " }
    puts "Typedef:"
    @declarator.show_tree( indent + 1 )
  end
end

#== �ؿ�Ƭ��
# signature ����Ͽ�����ؿ�
class FuncHead <BDNode
#  @declarator:: Decl

  def initialize( declarator, type, b_oneway )
    super()
    declarator.set_type( type )
    @declarator = declarator
    @declarator.set_owner self  # Decl (FuncHead)

    if @declarator.get_type.kind_of?( FuncType ) then
      if b_oneway then
        @declarator.get_type.set_oneway( b_oneway )
      end
    end
    @declarator.get_type.check_struct_tag :FUNCHEAD

    # check if return type is pointer
    if declarator.get_type.kind_of? FuncType then
      if declarator.get_type.get_type.get_original_type.kind_of?( PtrType ) &&
          Signature.get_current.is_deviate? == false then
        cdl_warning( "W9999 $1 pointer type has returned. specify deviate or stop return pointer" , @declarator.get_identifier )
      end
    end
  end

  def get_name
    @declarator.get_name
  end

  def get_declarator
    @declarator
  end

  def is_oneway?
    if @declarator.is_function? then
      return @declarator.get_type.is_oneway?
    end
    return false
  end

  def is_function?
    @declarator.is_function?
  end

  #=== FuncHead# �ؿ���̾�����֤�
  def get_name
    return @declarator.get_name
  end

  #=== FuncHead# �ؿ�������ͤη����֤�
  # types.rb ���������Ƥ��뷿
  # �ؿ��إå�������Ȥ����Դ����ʾ�� nil ���֤�
  def get_return_type
    if is_function? then
      return @declarator.get_type.get_type
    end
  end

  #=== FuncHead# �ؿ��ΰ����Υꥹ�Ȥ��֤�
  # ParamList ���֤�
  # �ؿ��إå�������Ȥ����Դ����ʾ�� nil ���֤�
  def get_paramlist
    if is_function? then
      return @declarator.get_type.get_paramlist
    end
  end

  def show_tree( indent )
    indent.times { print "  " }
    puts "FuncHead:"
    @declarator.show_tree( indent + 1 )
  end
end

#=== ���
# @kind �Ǽ������Ƽ�����
class Decl < BDNode

# @identifer:: String
# @global_name:: String | nil : String(@kind=TYPEDEF||:CONSTANT), nil(@kind=����¾)
#                set_kind �ˤ����ꤵ���
# @type:: ArrayType, FuncType, PtrType, IntType, StructType
#         VoidType, FloatType, DefinedType, BoolType
# @initializer:: constant_expression, mikan { initlist }
# @kind:: :VAR, :ATTRIBUTE, :PARAMETER, :TYPEDEF, :CONSTANT, :MEMBER, :FUNCHEAD(signature�δؿ����)
# @b_referenced:: bool
#
# �ʲ��ϡ�@kind �� :VAR, :ATTRIBUTE �ΤȤ���ͭ��
# @rw:: bool     # �Ť�ʸˡ�Ǥ� attr �˻����ǽ���ä��ʾä��ˤ� generate �ν�����ɬ�ס�
# @omit:: bool
# �ʲ��ϡ�@kind �� :VAR, :ATTRIBUTE, :MEMBER �ΤȤ���ͭ��
# @size_is:: Expression or nil unless specified
# �ʲ��ϡ�@kind �� :MEMBER �ΤȤ���ͭ��
# @count_is:: Expression or nil unless specified
#             attr, var �ξ�硢count_is �ϻ���Ǥ��ʤ�
# @string:: Expression, -1 (length not specified) or nil (not specified)
#
# mikan  ParamDecl �����̤��ߤ�������MemberDecl, AttrDecl �ʤɤ�ʬ����٤���(��)

  def initialize( identifier )
    super()
    @identifier = identifier
    @rw = false
    @omit = false
    @size_is = nil
    @count_is = nil
    @string  = nil
    @b_referenced  = false
  end

  def set_initializer( initializer )
    @initializer = initializer
  end

  def get_initializer
    @initializer
  end

  def is_function?
    if @type.class == FuncType then
      return true
    else
      return false
    end
  end

  #== Decl �ΰ�̣Ū��������å�����
  def check
    # return nil if @type == nil

    # ��¤�Υ��������å��ʥݥ��󥿷����鹽¤�Τ����Ȥ���Ƥ�����ϡ�������¸�ߤ�����å����ʤ���
    @type.check_struct_tag @kind

    # ���Υ����å���Ԥ�
    res = @type.check
    if res then
      cdl_error( "S2002 $1: $2" , @identifier, res )
    end

    # ���פν�����Ҥ�����å�����
    if @initializer then
      case @kind
      when :PARAMETER, :TYPEDEF, :MEMBER, :FUNCHEAD
        cdl_error( "S2003 $1: $2 cannot have initializer" , @identifier, @kind.to_s.downcase )
      when :VAR, :ATTRIBUTE, :CONSTANT
        # p @initializer  �����Ǥ�������ǽ���ɤ����������å����ʤ�
        # :VAR, :ATTRIBUTE, :CONSTANT �Ϥ��줾��ǥ����å�����
        # return @type.check_init( @identifier, @initializer, @kind )
      else
        raise "unknown kind in Delc::check"
      end
    end

    if( @type.kind_of? ArrayType ) && ( @type.get_subscript == nil ) && ( @omit == false ) then
      if @kind == :ATTRIBUTE then
        cdl_error( "S2004 $1: array subscript must be specified or omit" , @identifier )
      elsif @kind == :VAR || @kind == :MEMBER then
        cdl_error( "S2005 $1: array subscript must be specified" , @identifier )
      end
    end

    return nil
  end

  #== �ݥ��󥿥�٥������
  # ����͡�
  #   ��ݥ����ѿ�   = 0
  #   �ݥ����ѿ�     = 1
  #   ��ťݥ����ѿ� = 2
  def get_ptr_level
    level = 0
    type = @type
    while 1
      if type.kind_of?( PtrType ) then
        level += 1
        type = type.get_referto
#      elsif type.kind_of?( ArrayType ) then  # ź���ʤ�����ϥݥ��󥿤Ȥߤʤ�
#        if type.get_subscript == nil then
#          level += 1
#          type = type.get_type
#        else
#          break
#        end
        # mikan �ݥ��󥿤�ź����������Υݥ��󥿥�٥�ϣ��Ǥ褤��
      elsif type.kind_of?( DefinedType ) then
        type = type.get_type
        # p "DefinedType: #{type} #{type.class}"
      else
        break
      end
    end
    return level
  end

  def get_name
    @identifier
  end

  def get_global_name
    @global_name
  end

  def set_type( type )
    unless @type then
      @type = type
    else
      @type.set_type( type )             # �դ�����
    end
  end

  def get_type
    @type
  end

  def get_identifier
    @identifier
  end

  # STAGE: B
  def set_kind( kind )
    @kind = kind
    case kind
    when :TYPEDEF, :CONSTANT
      if Namespace.get_global_name.to_s == "" then
        @global_name = @identifier
      else
        @global_name = :"#{Namespace.get_global_name}_#{@identifier}"
      end
    else
      @global_name = nil
    end
  end

  def get_kind
    @kind
  end

  def set_specifier_list( spec_list )
    spec_list.each{  |spec|
      case spec[0]
      when :RW
        @rw = true
      when :OMIT
        @omit = true
      when :SIZE_IS
        @size_is = spec[1]
      when :COUNT_IS
        @count_is = spec[1]
      when :STRING
        @string = spec[1]
      else
        raise "Unknown specifier #{spec[0]}"
      end
    }

    if @size_is || @count_is || @string
        @type.set_scs( @size_is, @count_is, @string, nil, false )
    end
  end

  def is_rw?
    @rw
  end

  def is_omit?
    @omit
  end

  def get_size_is
    @size_is
  end

  def get_count_is
    @count_is
  end

  def get_string
    @string
  end

  def referenced
    @b_referenced = true
  end

  def is_referenced?
    @b_referenced
  end

  def is_type?( type )
    t = @type
    while 1
      if t.kind_of?( type ) then
        return true
      elsif t.kind_of?( DefinedType ) then
        t = t.get_type
      else
        return false
      end
    end
  end

  def is_const?
    type = @type
    while 1
      if type.is_const? then
        return true
      elsif type.kind_of?( DefinedType ) then
        type = type.get_type
      else
        return false
      end
    end
  end

  def show_tree( indent )
    indent.times { print "  " }
    puts "Declarator: name: #{@identifier} kind: #{@kind} global_name: #{@global_name}"
    (indent+1).times { print "  " }
    puts "type:"
    @type.show_tree( indent + 2 )
    if @initializer then
      (indent+1).times { print "  " }
      puts "initializer:"
      @initializer.show_tree( indent + 2 )
    else
      (indent+1).times { print "  " }
      puts "initializer: no"
    end
    (indent+1).times { print "  " }
    puts "size_is: #{@size_is.to_s}, count_is: #{@count_is.to_s}, string: #{@string.to_s} referenced: #{@b_referenced} "
   
  end

end

# �ؿ��ѥ�᡼�������
class ParamDecl < BDNode

# @declarator:: Decl:  Token, ArrayType, FuncType, PtrType
# @direction:: :IN, :OUT, :INOUT, :SEND, :RECEIVE
# @size:: Expr   (size_is ����)
# @count:: Expr   (count_is ����)
# @max:: Expr (size_is ���������)
# @b_nullable:: Bool : nullable 
# @string:: Expr or -1(if size not specified) ��string ������
# @allocator:: Signature of allocator
# @b_ref:: bool : size_is, count_is, string_is �����Ȥ��ƻ��Ȥ���Ƥ���
#
# 1. �ؿ����Ǥʤ�����
# 2. �������ʾ������Ǥ��äƺǤ���¦�ʳ���ź�������뤳��
# 3. in, out, ..., size_is, count_is, ... �ν�ʣ���꤬�ʤ�����
# 4. �ݥ��󥿥�٥뤬Ŭ�ڤʤ���

  def initialize( declarator, specifier, param_specifier )
    super()
    @declarator = declarator
    @declarator.set_owner self  # Decl (ParamDecl)
    @declarator.set_type( specifier )
    @param_specifier = param_specifier
    @b_ref = false
    @b_nullable = false

    if @declarator.is_function? then		# (1)
      cdl_error( "S2006 \'$1\' function" , get_name )
      return
    end

    res = @declarator.check
    if res then					# (2)
      cdl_error( "S2007 \'$1\' $2" , get_name, res )
      return
    end

    @param_specifier.each { |i|
      case i[0]                                     # (3)
      when :IN, :OUT, :INOUT, :SEND, :RECEIVE
        if @direction == nil then
          @direction = i[0]
        elsif i[0] == @direction then
          cdl_warning( "W3001 $1: duplicate" , i[0] )
          next
        else
          cdl_error( "S2008 $1: inconsitent with previous one" , i[0] )
          next
        end

        case i[0]
        when :SEND, :RECEIVE
          @allocator = Namespace.find( i[1] )   #1
          if ! @allocator.instance_of?( Signature ) then
            cdl_error( "S2009 $1: not found or not signature" , i[1] )
            next
          elsif ! @allocator.is_allocator? then
            # cdl_error( "S2010 $1: not allocator signature" , i[1] )
          end
        end

      when :SIZE_IS
        if @size then
          cdl_error( "S2011 size_is duplicate"  )
        else
          @size = i[1]
        end
      when :COUNT_IS
        if @count then
          cdl_error( "S2012 count_is duplicate"  )
        else
          @count = i[1]
        end
      when :STRING
        if @string then
          cdl_error( "S2013 string duplicate"  )
        elsif i[1] then
          @string = i[1]
        else
          @string = -1
        end
      when :MAX_IS
        # size_is �ǽ�ʣ�����å������
        @max = i[1]
      when :NULLABLE
        # if ! @declarator.get_type.kind_of?( PtrType ) then
        #  cdl_error( "S9999 '$1' nullable specified for non-pointer type", @declarator.get_name )
        # else
          @b_nullable = true
        # end
      end

    }

    if @direction == nil then
      cdl_error( "S2014 No direction specified. [in/out/inout/send/receive]"  )
    end

    if ( @direction == :OUT || @direction == :INOUT ) && @string == -1 then
      cdl_warning( "W3002 $1: this string might cause buffer over run" , get_name )
    end

    # mikan �ݥ��󥿤������ź��ͭ�ˤΥ�٥뤬��
    ptr_level = @declarator.get_ptr_level

    # p "ptr_level: #{@declarator.get_identifier} #{ptr_level}"
    # p @declarator

    if !(@size||@count||@string) then	    # (4)
      req_level = 1
    elsif (@size||@count)&&@string then
      req_level = 2
    else
      req_level = 1
    end

    if @direction == :RECEIVE then
      req_level += 1
    end

    # p "req_level: #{req_level} ptr_level: #{ptr_level}"
    if ptr_level < req_level && ! ( @direction == :IN && req_level == 1 && ptr_level == 0) then
      cdl_error( "S2014 $1 need pointer or more pointer" , @declarator.get_identifier )
    elsif ptr_level > req_level then
      # note: ��ʸ�����ʳ��Ǽ¹ԤΤ��� get_current ��
      if Signature.get_current == nil || Signature.get_current.is_deviate? == false then
        cdl_warning( "W3003 $1 pointer level mismatch" , @declarator.get_identifier )
      end
    end

    type = @declarator.get_type
    while type.kind_of?( DefinedType )
      type = type.get_original_type
    end

    if ptr_level > 0 then
      # size_is, count_is, string �򥻥å�
      if @direction == :RECEIVE && ptr_level > 1 then
        type.get_type.set_scs( @size, @count, @string, @max, @b_nullable )
      else
        type.set_scs( @size, @count, @string, @max, @b_nullable )
      end

#p ptr_level
#type.show_tree 1

      # �ݥ��󥿤��ؤ��Ƥ�����Υǡ�����������
      i = 0
      t2 = type
      while i < ptr_level
        t2 = t2.get_referto
        while t2.kind_of?( DefinedType )
          t2 = t2.get_original_type
        end
        i += 1
      end

# p @declarator.get_name
# t2.show_tree 1
# p t2.is_const?

      # const ������Ŭ�ڤ������å�
      if @direction == :IN then
        if ! t2.is_const? then
          cdl_error( "S2015 '$1' must be const for \'in\' parameter $2" , get_name, type.class )
        end
      else
        if t2.is_const? then
          cdl_error( "S2016 '$1' can not be const for $2 parameter" , get_name, @direction )
        end
      end
    else
      # ��ݥ��󥿥�����
      if @size != nil || @count != nil || @string != nil || @max != nil || @b_nullable then
        type.set_scs( @size, @count, @string, @max, @b_nullable )
      end
    end

#    if ptr_level > 0 && @direction == :IN then
#      if type.is_const != :CONST
#    end

    # p self

  end

  def check_struct_tag kind
    @declarator.get_type.check_struct_tag :PARAMETER
  end

  def get_name
    @declarator.get_name
  end

  def get_size
    @size
  end

  def get_count
    @count
  end

  def get_string
    @string
  end

  def get_max
    @max
  end

  def clear_max
    # p "clear_max: #{@declarator.get_name} #{@max.to_s}"
    @max = nil
    @declarator.get_type.clear_max
  end

  def is_nullable?
    @b_nullable
  end

  def get_type
    @declarator.get_type
  end

  def get_direction
    @direction
  end

  def get_declarator
    @declarator
  end

  def get_allocator
    @allocator
  end

  def referenced
    @b_ref = true
  end

  def is_referenced?
    @b_ref
  end

  #=== PPAllocator ��ɬ�פ�
  # Transparent RPC �ξ�� in �� size_is, count_is, string �Τ����줫�����ꤵ��Ƥ����� oneway �Ǥ� PPAllocator ��ɬ��
  # Transparent PC �� oneway ���ɤ����ϡ������Ǥ�Ƚ�Ǥ��ʤ��Τ�����Ƚ�Ǥ�ɬ��
  # Opaque RPC �ξ�� size_is, count_is, string �Τ����줫�����ꤵ��Ƥ����硢PPAllocator ��ɬ��
  def need_PPAllocator?( b_opaque = false )
    if ! b_opaque then
#      if @direction == :IN && ( @size || @count || @string ) then
      if @direction == :IN && @declarator.get_type.get_original_type.kind_of?( PtrType ) then
        return true
      end
    else
      if (@direction == :IN || @direction == :OUT || @direction == :INOUT ) &&
          @declarator.get_type.get_original_type.kind_of?( PtrType ) then
        return true
      end
    end
    return false
  end

  def show_tree( indent )
    indent.times { print "  " }
    puts "ParamDecl: direction: #{@direction}"
    @declarator.show_tree( indent + 1 )
    if @size then
      (indent+1).times { print "  " }
      puts "size:"
      @size.show_tree( indent + 2 )
    end
    if @count then
      (indent+1).times { print "  " }
      puts "count:"
      @count.show_tree( indent + 2 )
    end
    if @string then
      (indent+1).times { print "  " }
      puts "string:"
      if @string == -1 then
       (indent+2).times { print "  " }
        puts "size is not specified"
      else
        @string.show_tree( indent + 2 )
      end
    end
    if @allocator then
      (indent+1).times { print "  " }
      puts "allocator: signature: #{@allocator.get_name}"
    end    
  end
end

# �ؿ��ѥ�᡼���ꥹ��
class ParamList < BDNode
# @param_list:: NamedList : item: ParamDecl

  def initialize( paramdecl )
    super()
    @param_list = NamedList.new( paramdecl, "parameter" )
    @param_list.get_items.each { |paramdecl|
      paramdecl.set_owner self   # ParamDecl
    }
  end

  def add_param( paramdecl )
    @param_list.add_item( paramdecl )
    paramdecl.set_owner self   # ParamDecl
  end

  def get_items
    @param_list.get_items
  end

  #=== size_is, count_is, string �ΰ����μ�������å�
  # �ѿ����������Ȳ�ǽ�ʤ��ᡢ�ؿ�Ƭ���ι�ʸ��᤬����ä���˥����å�����
  def check_param
    @param_list.get_items.each { |i|
      next if i == nil                      # i == nil : ���顼��

      if i.get_type.class == VoidType then
        # ñ��� void ���Ϥ����ˤϤ��ʤ�
        cdl_error( "S9999 '$1' parameter cannot be void type", i.get_name )
      end

      size = i.get_size			# Expression
      if size then
        val = size.eval_const( @param_list )
        if val == nil then			# ������Ǥʤ�����
          # mikan �ѿ���ޤ༰��ñ����ѿ��Τ� OK
          type = size.get_type( @param_list )
          unless type.kind_of?( IntType ) then
            cdl_error( "S2017 size_is argument is not integer type"  )
          else
            size.check_dir_for_param( @param_list, i.get_direction, "size_is" )
          end
        else
          if val != Integer( val ) then
            cdl_error( "S2018 \'$1\' size_is parameter not integer" , i.get_declarator.get_identifier )
          elsif val <= 0 then
            cdl_error( "S2019 \'$1\' size_is parameter negative or zero" , i.get_declarator.get_identifier )
          end
        end
      end

      max = i.get_max
      if max then
        val2 = max.eval_const( @param_list )
        if val2 == nil then
          cdl_error( "S9999 '$1' max (size_is 2nd parameter) not constant", i.get_name )
        elsif val2 != Integer( val2 ) || val2 <= 0 then
          cdl_error( "S9999 '$1' max (size_is 2nd parameter) negative or zero, or not integer", i.get_name )
        end
      end

      if val != nil && val2 != nil then
        if val < val2 then
          cdl_warning( "W9999 '$1' size_is always lower than max. max is ignored", i.get_name )
          i.clear_max
        else
          cdl_error( "S9999 '$1' both size_is and max are const. size_is larger than max", i.get_name )
        end
      end

      count = i.get_count			# Expression
      if count then
        val = count.eval_const( @param_list )
        if val == nil then			# ������Ǥʤ�����
          # mikan �ѿ���ޤ༰��ñ����ѿ��Τ� OK
          type = count.get_type( @param_list )
          unless type.kind_of?( IntType ) then
            cdl_error( "S2020 count_is argument is not integer type"  )
          else
            count.check_dir_for_param( @param_list, i.get_direction, "count_is" )
          end
        else
          if val != Integer( val ) then
            cdl_error( "S2021 \'$1\' count_is parameter not integer" , i.get_declarator.get_identifier )
          elsif val <= 0 then
            cdl_error( "S2022 \'$1\' count_is parameter negative or zero" , i.get_declarator.get_identifier )
          end
        end
      end

      string = i.get_string			# Expression
      if string != -1 && string then
        val = string.eval_const( @param_list )
        if val == nil then			# ������Ǥʤ�����
          # mikan �ѿ���ޤ༰��ñ����ѿ��Τ� OK
          type = string.get_type( @param_list )
          unless type.kind_of?( IntType ) then
            cdl_error( "S2023 string argument is not integer type"  )
          else
            string.check_dir_for_param( @param_list, i.get_direction, "string" )
          end
        else
          if val != Integer( val ) then
            cdl_error( "S2024 \'$1\' string parameter not integer" , i.get_declarator.get_identifier )
          elsif val <= 0 then
            cdl_error( "S2025 \'$1\' string parameter negative or zero" , i.get_declarator.get_identifier )
          end
        end
      end
    }
  end

  def check_struct_tag kind
    @param_list.get_items.each{ |p|
      p.check_struct_tag kind
    }
  end

  #=== Push Pop Allocator ��ɬ�פ���
  # Transparent RPC �ξ�� (oneway ����) in ������(size_is, count_is, string �Τ����줫�ǽ����ˤ�����
  def need_PPAllocator?( b_opaque = false )
    @param_list.get_items.each { |i|
      if i.need_PPAllocator?( b_opaque ) then
        return true
      end
    }
    false
  end

  def find( name )
    @param_list.get_item( name )
  end

  #== ParamList# ʸ����
  #b_name:: Bool: �ѥ�᡼��̾��ޤ��
  def to_str( b_name )
    str = "("
    delim = ""
    @param_list.get_items.each{ |paramdecl|
      decl = paramdecl.get_declarator
      str += delim + decl.get_type
      if b_name then
        str += " " + decl.get_name
      end
      str += decl.get_type_post
      delim = ", "
    }
    str += ")"
  end

  def show_tree( indent )
    indent.times { print "  " }
    puts "ParamList:"
    @param_list.show_tree( indent + 1 )
  end
end

#== CDL ��ʸ�����ƥ��򰷤�����Υ��饹
# CDL ��ʸ�����ƥ�뤽�Τ�ΤǤϤʤ�
class CDLString
  # ����������ʸ�����Ѵ�
  def self.escape str
    str = str.dup
    str.gsub!( /\\a/, "\x07" )
    str.gsub!( /\\b/, "\x08" )
    str.gsub!( /\\f/, "\x0c" )
    str.gsub!( /\\n/, "\x0a" )
    str.gsub!( /\\r/, "\x0d" )
    str.gsub!( /\\t/, "\x08" )
    str.gsub!( /\\v/, "\x0b" )
    str.gsub!( /(\\[Xx][0-9A-Fa-f]{1,2})/, '{printf \"\\1\"}' )
    str.gsub!( /(\\[0-7]{1,3})/, '{printf \"\\1\"}' )
    str.gsub!( /\\(.)/, "\\1" )   # mikan ̤����Υ��������ץ������󥹤��Ѵ����Ƥ��ޤ� (gcc V3.4.4 �ǤϷٹ𤬽Ф����)
    return str
  end

  #=== CDLString#����� " �������
  def self.remove_dquote str
    s = str.sub( /\A"/, "" )
    s.sub!( /"\z/, "" )
    return s
  end
end

#== CDL �ν�����Ҥ򰷤�����Υ��饹
# CDL �ν�����Ҥ��Τ�ΤǤϤʤ�
class CDLInitializer
  #=== ������ҤΥ�����
  # ������Ҥ� Expression, C_EXP, Array �Τ����줫
  def self.clone_for_composite( rhs, ct_name, cell_name, locale )
    if rhs.instance_of? C_EXP then
      # C_EXP �� clone ����ȤȤ���ִ�
      rhs = rhs.clone_for_composite( ct_name, cell_name, locale )
    elsif rhs.instance_of? Expression then
      rhs = rhs.clone_for_composite
    elsif rhs.instance_of? Array then
      rhs = clone_for_compoiste_array( rhs, ct_name, cell_name, locale )
    else
      raise "unknown rhs for join"
    end
    return rhs
  end

  #=== ������ҡ�����ˤΥ�����
  # ���Ǥ� clone_for_composite ����Ĥ�Τ���
  def self.clone_for_compoiste_array( array, ct_name, cell_name, locale )
    # "compoiste.identifier" �ξ�� (CDL �Ȥ��Ƥϸ��)
    if array[0] == :COMPOSITE then
      return array.clone
    end

    new_array = array.map{ |m|
      clone_for_composite( m, ct_name, cell_name, locale )
    }
    return new_array
  end
end
