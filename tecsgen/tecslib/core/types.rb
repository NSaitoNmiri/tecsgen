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
#   $Id: types.rb 1975 2013-06-16 07:34:59Z okuma-top $
#++

#= @type �������˻��ķ��Τ���Υ⥸�塼��
#  @b_cloned::Bool  : true if @type is cloned
#
# ���Υ⥸�塼��� DefinedType, PtrType, ArrayType �� include �����
# ������ typedef ���줿���� Decl �����ǤΤ� clone ����Ф褤�Τ�����get_type, get_original_type ��
# ���Ф��줿�Ȥ���set_scs, set_qualifier ���줿�Ȥ���̵���� clone ���� (̵�̤˥������Ѥ���)
# ��������clone ����Τϰ��ΤߤǤ��� (��� clone ������̤η��򻲾Ȥ��Ƥ��ޤ�)
#
# initialize �� clone ���Ƥ⡢��ͭ����Ƥ���Ȥ��� clone ����ʤ�
#
module HasType
  def initHasType
    @b_cloned = false
  end

  #=== HasType# @type �򥯥��󤹤�
  def clone_type
    if @b_cloned == false then
      @type = @type.clone
      @b_cloned = true
    end
  end
end

class Type < Node
# @b_const    : bool
# @b_volatile : bool

  def initialize
    super
  end

  def set_qualifier( qualifier )
    case qualifier
    when :CONST
      if @b_const then
        cdl_error( "T1001 const duplicate"  )
      end
      @b_const = true
    when :VOLATILE
      if @b_volatile then
        cdl_error( "T1002 volatile duplicate"  )
      end
      @b_volatile = true
    else
      raise "Unknown qualifier #{qualifier}"
    end
  end

  def is_const?
    if @b_const then
      return true
    else
      return false
    end
  end

  def is_volatile?
    if @b_volatile then
      return true
    else
      return false
    end
  end

  def is_void?
    if self.kind_of? DefinedType then
      return @type.is_void?
    elsif self.kind_of? VoidType then
      return true
    else
      return false
    end
  end

  #=== size_is, count_is, string ������
  # �������饹�ǥ����С��饤�ɤ���ʥǥե���ȤǤϥ��顼��
  def set_scs( size, count, string, max = nil, b_nullable = false )
    str = ""
    delim = ""
    if size then
      str = "size_is"
      delim = ", "
    end
    if count then
      str = "#{str}#{delim}count_is"
      delim = ", "
    end
    if string then
      str = "#{str}#{delim}string"
      delim = ", "
    end
    if b_nullable then
      str = "#{str}#{delim}nullable"
      delim = ", "
    end
    cdl_error( "T1003 $1: unsuitable specifier for $2" , str, self.class )
  end

  def clear_max
    raise "clear_max called: #{self.class}"
  end

  def get_type_str
    str = ""
    if @b_const then
      str = "#{str}const "
    end
    if @b_volatile then
      str = "#{str}volatile "
    end
    return str
  end

  #=== ��������å�
  #    �����ʷ�������ɤ����������å�����
  def check
    # ���˸�꤬����С����顼ʸ������֤�
  end

  #=== struct �� tag ������å�
  #    �����ʷ�������ɤ����������å�����
  #kind:: Decl �� @kind �򻲾�
  def check_struct_tag kind
    # tag ��¸�ߤ��ʤ���Х��顼����Ϥ���
    # ���󷿤Ǥϡ����Ǥη���Ƶ�Ū�˥����å�
    # �ݥ��󥿷��Ǥϡ��ؤ���� tag �����å��Ϥ��ʤ�
    # �ؿ����Ǥϥѥ�᡼���ꥹ�ȤΤ��٤ƤˤĤ��ƹԤ�
  end

  #===  �������ǽ�������å�
  #     attribute �ʤɽ������ǽ�������å�����ʷ����Ф������ʽ�����Ҥ�Ϳ�����Ƥ��뤫��
  #ident::        string                �������ѿ�̿
  #initialize::   Expression, Array of initializer or C_EXP
  #               �����͡�C_EXP ��Ϳ������Τ� IntType �ξ��Τ�
  #kind::         symbol (:ATTRIBUTE, :VAR, :CONSTNAT )
  #attribute::    NameList              kind == :VAR �ΤȤ����ȤǤ��� attribute
  #
  #     locale ���������Ȥ��Ƽ��Τϡ��ʲ�����ͳ�ˤ�롣
  #     ���Υ᥽�åɤϡ��ѿ��ؤ��������Ԥ���ֹԡפ��Ф��ƸƤӽФ���뤬��
  #     Type ���饹�Υ��󥹥��󥹤ϡ��ѿ���������줿�ֹԡפ򵭲����Ƥ��롣
  #
  # STAGE: S
  def check_init( locale, ident, initializer, kind, attribute = nil )
    #
  end

  #=== const_val �����η��˥��㥹�Ȥ���
  # �������饹�ǥ����С��饤�ɤ��Ƥ��ʤ��ȥ��顼
  def cast( const_val )
    cdl_error( "T1004 cannot cast to $1" , self.class )
  end

  #=== �������פ��뤫�Υ����å�
  # ��̾�λ��̤ǥ����å���
  # typedef ���줿������̤ǰ��פ򸫤뤿�ᡢ���η���Ʊ���Ǥⷿ̾���ۤʤ���԰��פȤʤ�
  def equal? type2
    return ( get_type_str == type2.get_type_str ) && ( get_type_str_post == type2.get_type_str_post )
  end

  #=== bit size ������
  # IntType, FloatType �ʳ���0
  def get_bit_size
    return 0
  end

  #=== ���η�������
  # typedef ���줿���ξ�硢���θ��η����֤�.
  # ����ʳ��ϡ���ʬ���Ȥ��֤���
  # (DefinedType �Ǥ��ܥ᥽�åɤ������С��饤�ɤ����)
  def get_original_type
    return self
  end

  #=== �����˥ݥ��󥿷������
  # �ݥ��󥿷����ޤ��ϥݥ��󥿷����Ф���Ĺ�¤�Ρ��ޤ������Ǥ��ݥ��󥿷����������
  def has_pointer?
    false
  end

  #=== size_is, count_is, string ���ꤵ�줿�ݥ��󥿤���Ĥ�
  # size_is, count_is, string ���ꤵ�줿�ݥ��󥿷����ޤ��Ϥ������Ф˻��Ĺ�¤�Ρ��ޤ��Ϥ��������Ǥ˻�������
  def has_sized_pointer?
    false
  end
  
  #=== Ĺ������Τʤ� string �����
  # �ʤ�����Τʤ� string ���ꤵ�줿�ݥ��󥿷����ޤ��Ϥ������Ф˻��Ĺ�¤�Ρ��ޤ��Ϥ�������Ǥ˻�������
  def has_unsized_string?
    false
  end

  def show_tree indent
    indent.times { print "  " }
    puts "const: #{@b_const} volatile: #{@b_volatile}"
    indent.times { print "  " }
    puts "has_pointer: #{has_pointer?} has_sized_pointer: #{has_sized_pointer?} has_unsized_string: #{has_unsized_string?}"
  end
end

class DefinedType < Type
#  @type_name::string
#  @typedef::Typedef
#  @type:: kind_of Type

  include HasType

  def initialize( type_name )
    super()
    @type_name = type_name

    # mikan type_name �� path �ˤʤäƤ��ʤ��������
    @typedef = Namespace.find( [ type_name ] )  #1

#    if @type.class != Typedef then
#      raise NotTypedef
    #    end
    if @typedef == nil then
      cdl_error( "T1005 \'$1\' not defined" , type_name )
    elsif @typedef.class != Typedef then
      cdl_error( "T1006 \'$1\' not type name. expecting type name here" , type_name )
    end
    @type = @typedef.get_declarator.get_type
    initHasType
  end

  def get_type
    clone_type
    return @type
  end

  def get_type_str
    "#{super}#{@type_name}"
  end

  def get_type_str_post
    ""
  end

  def get_size
    return @type.get_size
  end

  def is_nullable?
    return @type.is_nullable?
  end

  #=== qualifier(const, volatile) ������
  def set_qualifier( qualifier )
    clone_type
    @type.set_qualifier( qualifier )
    super
  end

  def set_scs( size, count, string, max = nil, b_nullable = false )
    clone_type
    @type.set_scs( size, count, string, max, b_nullable )
  end

  def clear_max
    @type.clear_max
  end

  def get_original_type
    clone_type
    return @type.get_original_type
  end

  def check	# ��̣Ū��꤬����С�ʸ������֤�
    nil    # typedef ���ʳ��ǰ�̣�����å�����Ƥ���
  end

  def check_init( locale, ident, initializer, kind, attribute = nil )
    get_type.check_init( locale, ident, initializer, kind, attribute )
  end

  #=== �����˥ݥ��󥿷������
  # �ݥ��󥿷����ޤ��ϥݥ��󥿷����Ф���Ĺ�¤�Ρ��ޤ������Ǥ��ݥ��󥿷����������
  def has_pointer?
    @type.has_pointer?
  end

  #=== size_is, count_is, string ���ꤵ�줿�ݥ��󥿤���Ĥ�
  # size_is, count_is, string ���ꤵ�줿�ݥ��󥿷����ޤ��Ϥ������Ф˻��Ĺ�¤�Ρ��ޤ��Ϥ��������Ǥ˻�������
  def has_sized_pointer?
    @type.has_sized_pointer?
  end
  
  #=== Ĺ������Τʤ� string �����
  # �ʤ�����Τʤ� string ���ꤵ�줿�ݥ��󥿷����ޤ��Ϥ������Ф˻��Ĺ�¤�Ρ��ޤ��Ϥ�������Ǥ˻�������
  def has_unsized_string?
    @type.has_unsized_string?
  end

  def show_tree( indent )
    indent.times { print "  " }
    if @typedef == nil then
      puts "DefinedType: #{@type_name} is missing, const: #{@b_const} volatile: #{@b_volatile}"
    else
      puts "DefinedType: #{@type_name}, const: #{@b_const} volatile: #{@b_volatile}"
    end
    super( indent + 1 )
    @typedef.show_tree( indent + 1 )
    @type.show_tree( indent + 1 )
  end
end

class VoidType < Type

  def check	# ��̣Ū��꤬����С�ʸ������֤�
    nil
  end

  def check_init( locale, ident, initializer, kind, attribute = nil )
    cdl_error2( locale, "T1007 $1: void type variable cannot have initializer" , ident )
  end

  def get_type_str
    "#{super}void"
  end

  def get_type_str_post
    ""
  end

  def show_tree( indent )
    indent.times { print "  " }
    puts "VoidType"
    super( indent + 1 )
  end
end

class BoolType < Type

  def check	# ��̣Ū��꤬����С�ʸ������֤�
    nil
  end

  def get_type_str
    "#{super}bool_t"
  end

  def get_type_str_post
    ""
  end

  def show_tree( indent )
    indent.times { print "  " }
    puts "BoolType"
    super( indent + 1 )
  end
end

class IntType < Type
#  @bit_size::		-11: char, -1: char_t, -2: short, -3: int, -4: long, -5: long long
#			8, 16, 32, 64, 128
#  @sign::		:SIGNED, :UNSIGNED, nil
#  @b_sign::            true: set_sign �ˤ����椬���ꤵ�줿

  def initialize( bit_size )
    super()
    @bit_size = bit_size
#    if bit_size != -1 && bit_size != -11 then
#      @sign = :SIGNED  # set default
#    else
      @sign = nil
#    end
  end

  def set_sign( sign, b_uint = false )
    if @b_sign then
      if @sign != sign then
        cdl_error( "T1008 ambigous signed or unsigned"   )
      end
    elsif b_uint == false && @bit_size > 0 then
      if sign == :SIGNED then
        cdl_warning( "W2001 signed int$1_t: obsolete. use int$2_t" , @bit_size, @bit_size )
      else
        cdl_warning( "W2002 unsinged int$1_t: obsolete. use uint$2_t" , @bit_size, @bit_size )
      end
    end

    @sign = sign
    @b_sign = true
  end

  def check	# ��̣Ū��꤬����С�ʸ������֤�
    nil
  end

  def check_init( locale, ident, initializer, kind, attribute = nil )
    val = initializer  # C_EXP, Array
    if val.instance_of?( Expression ) then
      val = val.eval_const2( nil, attribute )
      # ɾ���η�� C_EXP �� Array �Ȥʤ��ǽ��������
    end

    if val.instance_of? Token then    # StringVal Ƴ���ˤ�ꡢ��Ϥ� Token ����ʤ��Ϥ�
      # val �� Token �ξ�� == �α��դ� String ���ȥ��顼�򵯤��� (#198)
      cdl_error2( locale, "T1009 $1: $2: not integer" , ident, val )
      return
    elsif val.is_a? C_EXP then
      # #192 var �� attribute �򻲾Ȥ���attribute �α��դ� C_EXP �ξ��
      # const �α��դ� C_EXP �ξ���
      return
    elsif val.kind_of? FloatVal then
      cdl_error2( locale, "T1011 $1: need cast to assign float to integer" , ident )
      return
    elsif val.instance_of? Array then
      cdl_error2( locale, "T1017 $1: unsuitable initializer for scalar type" , ident )
      return
    elsif val == nil then
      cdl_error2( locale, "T1010 $1: initializer is not constant" , ident )
      return
    end

    if ! val.kind_of? IntegerVal then
      cdl_error2( locale, "T1012 $1: $2: not integer" , ident, val )
      return
    end

    val = val.to_i
    max = get_max
    min = get_min
    dbgPrint "sign=#{@sign} ident=#{ident} val=#{val} max=#{max} min=#{min}\n"

    if max != nil then
      if val > max then
        if @sign == :SIGNED || @sign == nil then
          cdl_error2( locale, "T1013 $1: too large (max=$2)" , ident, max )
        else
          cdl_error2( locale, "T1016 $1: too large (max=$2)" , ident, max )
        end
      end
    end

    if min != nil then
      if val < min
        if @sign == :SIGNED || @sign == nil then
          cdl_error2( locale, "T1014 $1: too large negative value (min=$2)" , ident, min )
        else
          cdl_error2( locale, "T1015 $1: negative value for unsigned" , ident )
        end
      end
    end
  end

  #=== IntType# �����͡��Ǿ��ͤ�����å����ƥ���åפ���
  # ���㥹�ȱ黻��Ԥ�
  #in_val:: IntegerVal, FloatVal:  ���η��˥��㥹�Ȥ�����
  #from_type:: Symbol:  :IntType, :FloatType  IntType �ξ��ϥӥåȿ��ǥ���åס�FloatType �ξ��Ϻ����ͤǥ���å�
  def check_and_clip( in_val, from_type = :IntType )
    bit_size = get_bit_size
    if bit_size == -1 then
      bit_size = 8
    end
    val = in_val.to_i
    if get_max && val > get_max then
      if from_type == :IntType then
        rval = ((1 << bit_size)-1) & val   # bit ���ǥ���å�
      else
        rval = get_max                         # �����ͤǥ���å� (FloatType)
      end
      cdl_warning( "W2003 $1: too large to cast to $2, clipped($3)" , in_val, get_type_str, rval )
    elsif get_min && val < get_min then
      if from_type == :IntType then
        rval = ((1 << bit_size)-1) & val
      else
        rval = get_min
      end
      if @sign == :SIGNED || @sign == nil then
        cdl_warning( "W2004 $1: too small to cast to $2, clipped($3)" , in_val, get_type_str, rval )
      else    # @sign == :UNSIGNED || @sign == nil (char �ξ��)
        cdl_warning( "W2005 $1: negative value for unsigned: convert to $2" , in_val, rval )
      end
    else
      rval = val
    end
    return rval
  end

  def get_min
    if @sign == :SIGNED || @sign == nil then
      if @bit_size == -1 then
        bit_sz = 8   # char_t �ϡ�ͭ���˰���
      else
        bit_sz = @bit_size
      end
      case bit_sz
      when 8, 16, 32, 64, 128
        return  - ( 1 << ( bit_sz - 1 ))
      else # -1, -2, -3, -4, -5, -11
        return nil
      end
    else   # @sign == :UNSIGNED
      return 0
    end
  end

  def get_max
    if @bit_size == -1 then
      if @sign == nil then
        return 255   # char_t �ϡ�̵���˰���
      else
        bit_sz = 8
      end
    else
      bit_sz = @bit_size
    end
    if @sign == :SIGNED || @sign == nil then
      case bit_sz
      when 8, 16, 32, 64, 128
        return ( 1 << ( bit_sz - 1 )) -1
      else # -1, -2, -3, -4, -5, -11
        return nil
      end
    else   # @sign == :UNSIGNED
      case bit_sz
      when 8, 16, 32, 64, 128
        return ( 1 << bit_sz ) - 1
      else # -2, -3, -4, -5, -11
        return nil
      end
    end
  end

  #=== IntType# C ����ˤ����뷿̾�ʽ������դ���
  def get_type_str
    str = super

    if @sign == :UNSIGNED then
      sign = "u"
    end

    # NEW_MODE
    sign = ""
    signL = ""
    if @b_sign then
      case @sign
      when :SIGNED
        sign = ""
        signL = "signed "
      when :UNSIGNED
        sign = "u"
        signL = "unsigned "
      end
    end

    case @bit_size
    when -1      # char_t ��
      if @sign == :SIGNED then
        sign = "s"
      end
      str = "#{str}#{sign}char_t"
    when -11     # char ��(obsolete)
      str = "#{str}#{signL}char"
    when -2      # short ��
      str = "#{str}#{signL}short"
    when -3      # int ��
      str = "#{str}#{signL}int"
    when -4      # long ��
      str = "#{str}#{signL}long"
    when -5      # long long ��
      str = "#{str}#{sign}long long"
    when 8, 16, 32, 64, 128     # int16, int32, int64, int128 ��
      str = "#{str}#{sign}int#{@bit_size}_t"
    end

    return str
  end

  #=== IntType# C ����ˤ����뷿̾�ʸ���ʸ�����
  def get_type_str_post
    ""
  end

  #=== IntType#bit_size ������
  #    �֤�����ͤ� @bit_size �λ��ͤ򻲾�
  def get_bit_size
    return @bit_size
  end

  #=== IntType# sign ������
  # @sign �������򻲾�
  def get_sign
    @sign
  end

  def show_tree( indent )
    indent.times { print "  " }
    puts "IntType bit_size: #{@bit_size} sign: #{@sign} const: #{@b_const} volatile: #{@b_volatile}"
    super( indent + 1 )
  end
end

class FloatType < Type
#  @bit_size::         32, 64, (80)

  def initialize( bit_size )
    super()
    @bit_size = bit_size
  end

  def check	# ��̣Ū��꤬����С�ʸ������֤�
    nil
  end

  # mikan Float ���� C_EXP �б� (generate.rb �ˤ��ѹ�ɬ��)
  def check_init( locale, ident, initializer, kind, attribute = nil )
    # �����Ф������ͤ˸�꤬����С����顼ʸ������֤�
    val = initializer
    if val.instance_of?( Expression ) then
      val = val.eval_const2( nil, attribute )
      # ɾ���η�� C_EXP �� Array �Ȥʤ��ǽ��������
    end

    if val.instance_of? Token then
      # val �� Token �ξ�� == �α��դ� String ���ȥ��顼�򵯤���
      cdl_error2( locale, "T1018 $1: $2: not number" , ident, val )
      return
    elsif val.instance_of? Array then
      cdl_error2( locale, "T1020 $1: unsuitable initializer for scalar type" , ident )
      return
    elsif val.instance_of? C_EXP then
      return
    elsif val == nil then
      cdl_error2( locale, "T1019 $1: initializer is not constant" , ident )
      return
    elsif ! val.kind_of?( IntegerVal ) && ! val.kind_of?( FloatVal ) then
      cdl_error2( locale, "T9999 $1: not number" , ident )
      return
    end
    # else
    #   cdl_error2( locale, "T1020 $1: unsuitable initializer for scalar type" , ident )
    #   return
    # end
    return
  end

  def get_type_str
    str = super

    case @bit_size
    when 32
      str = "#{str}float32_t"
    when 64
      str = "#{str}double64_t"
    end
    return str
  end

  def get_type_str_post
    ""
  end

  def get_bit_size
    @bit_size
  end

  def show_tree( indent )
    indent.times { print "  " }
    puts "FloatType bit_size: #{@bit_size} qualifier: #{@qualifier}"
    super( indent + 1 )
  end
end

class EnumType < Type # mikan
#  @bit_size::		-1: enum
#			8, 16, 32, 64, 128
#  @element::		[]
#  @element_val::	[]

  def initialize( bit_size )
    super()
    @bit_size = bit_size
  end

  def check
   # mikan enum check
  end

  def show_tree( indent )
    indent.times { print "  " }
    puts "EnumType bit_size: #{@bit_size} qualifier: #{@qualifier}"
    super( indent + 1 )
    # mikan element
  end
end

class StructType < Type
#  @tag::
#  @b_define::  true if define, false if refer
#  @members_decl:: NamedList
#  @definition:: StructType
#  @b_has_pointer_member:: bool : ���Ф˥ݥ��󥿷�������
#  @b_has_sized_pointer_member:: bool : ���Ф˥ݥ��󥿷�������
#  @b_has_unsized_string_member:: bool : ���Ф˥ݥ��󥿷�������

  @@structtype_current_stack = []
  @@structtype_current_sp = -1

  def initialize( tag = nil )
    super()
    @tag = tag
    @@structtype_current_sp += 1
    @@structtype_current_stack[@@structtype_current_sp] = self
    @b_has_pointer_member = false
    @b_has_sized_pointer_member = false
    @b_has_unsized_string_member = false
  end

  def self.set_define( b_define )
    @@structtype_current_stack[@@structtype_current_sp].set_define( b_define )
  end

  def set_define( b_define )
    @b_define = b_define
    if @b_define then
      @members_decl = NamedList.new( nil, "in struct #{@tag}" )
      # if @tag then    ��Ͽ�����ߥ󥰤򽪤����ѹ� V1.0.2.19
      #  Namespace.new_structtype( self )
      # end
    else
      @definition = Namespace.find_tag( @tag )
      # check_struct_tag �˰ܤ� V1.0.2.19
      # if @definition == nil then
      #  cdl_error( "T1021 \'$1\': struct not defined" , @tag )
      # end
    end
  end

  def self.new_member( member_decl )
    @@structtype_current_stack[@@structtype_current_sp].new_member( member_decl )
  end

  def new_member( member_decl )
    member_decl.set_owner self   # Decl (StructType)
    @members_decl.add_item( member_decl )
    if member_decl.get_type.has_pointer?
      @b_has_pointer_member = true
    end
    if member_decl.get_type.has_sized_pointer?
      @b_has_sized_pointer_member = true
    end
    if member_decl.get_type.has_unsized_string?
      @b_has_unsized_string_member = true
    end
  end

  def check	# ��̣Ū��꤬����С�ʸ������֤�
    nil
  end

  #=== ��¤�ΤΥ���������å�
  #  declarator �λ����ǥ����å�����
  #kind:: Decl �� @kind �򻲾�
  def check_struct_tag kind
    if @tag == nil
      return
    end

    st = Namespace.find_tag( @tag )
    if st == nil then
      cdl_error( "T1022 struct $1: not defined" , @tag )
    end
  end

  # mikan Float ���� C_EXP �б� (generate.rb �ˤ��ѹ�ɬ��)
  def check_init( locale, ident, initializer, kind, attribute = nil )

    st = Namespace.find_tag( @tag )
    if st == nil then
      cdl_error2( locale, "T1023 struct $1: not defined" , @tag )
      return
    end

    # ������Ҥ����ξ�硢���ʥ����ˤ����פ��뤫�����å�
    if initializer.instance_of?( Expression ) then
      t = initializer.get_type( attribute )
      # print "Check init #{t.class} #{t.get_name}\n"
      if ! t.kind_of?( StructType ) then
        if t then
          str = t.get_type_str
        else
          str = "unknown"
        end
        cdl_error2( locale, "T9999 $1: initializer type mismatch. '$2' & '$3'" , ident, get_type_str, str )
      elsif @tag != t.get_name then
        cdl_error2( locale, "T9999 $1: struct tag mismatch $2 and $3" , ident, @tag, t.get_name )
      end
      initializer = initializer.eval_const( attribute )
    end

    if initializer.instance_of?( Array ) then
      i = 0
      st.get_members_decl.get_items.each { |d|
        if initializer[i] then
          d.get_type.check_init( locale, "#{ident}.#{d.get_identifier}", initializer[i], kind )
        end
        i += 1
      }
    else
      cdl_error2( locale, "T1024 $1: unsuitable initializer for struct" , ident )
    end
  end

  def self.end_of_parse()
    @@structtype_current_stack[@@structtype_current_sp].end_of_parse
    @@structtype_current_sp -= 1
  end

  def end_of_parse()
    if @members_decl == nil   # @b_define = false �ޤ��ϥ��С��Τʤ���¤�Ρʥ��顼��
      return
    end
    @members_decl.get_items.each{ |md|
      size = md.get_size_is
      if size then
        val = size.eval_const( @members_decl )
        if val == nil then
          type = size.get_type( @members_decl )
          if ! type.kind_of?( IntType ) then
            cdl_error( "T1025 size_is argument is not integer type"  )
          end
        end
      end
      count = md.get_count_is
      if count then
        val = count.eval_const( @members_decl )
        if val == nil then
          type = count.get_type( @members_decl )
          if ! type.kind_of?( IntType ) then
            cdl_error( "T1026 count_is argument is not integer type"  )
          end
        end
      end
      string = md.get_string
      if string == -1 then
        # Ĺ������ʤ�
      elsif string then
        val = string.eval_const( @members_decl )
        if val == nil then
          type = string.get_type( @members_decl )
          if ! type.kind_of?( IntType ) then
            cdl_error( "T1027 string argument is not integer type"  )
          end
        end
      end
    }

    if @b_define then
      if @tag then
        Namespace.new_structtype( self )
      end
    end
  end

  def get_name
    @tag
  end

  def get_type_str      # mikan struct get_type_str
    str = super

    if @tag then
      # typedef struct tag StructType; �η����ξ��
      # struct �����Τϡ��̤����������
      return "#{str}struct #{@tag} "

    else
      # typedef struct { int a; } StructType; �η����ξ��
      str += "struct {\n"
      @members_decl.get_items.each{ |i|
        str += sprintf( "    %-8s %s%s;\n", "#{i.get_type.get_type_str}", "#{i.get_name}", "#{i.get_type.get_type_str_post}" )
      }
      str += "} "

      return str

    end
  end

  def get_type_str_post
    ""
  end

  def get_members_decl
    return @members_decl if @members_decl

    st = Namespace.find_tag( @tag )
    if st then
      return st.get_members_decl
    end

    return nil
  end

  def has_pointer?
    if @definition
      return @definition.has_pointer?
    else
      return @b_has_pointer_member
    end
  end

  def has_sized_pointer?
    if @definition
      return @definition.has_sized_pointer?
    else
      return @b_has_sized_pointer_member
    end
  end
  
  def has_unsized_string?
    if @definition
      return @definition.has_unsized_string?
    else
      return @b_has_unsized_string_member
    end
  end

  #=== Ʊ����¤�Τ��ɤ��������å�����
  # tag �Υ����å��ϹԤ�ʤ�
  # ���٤ƤΥ��Ф�̾���ȷ������פ��뤳�Ȥ��ǧ����
  def same? another
    md = another.get_members_decl
    if @members_decl == nil || md == nil
      return false
    end

    md1 = @members_decl.get_items
    md2 = md.get_items
    if( md1.length != md2.length )
      return false
    end

    i = 0
    while i < md1.length
      if md1[i].get_name != md2[i].get_name ||
          md1[i].get_type.get_type_str != md2[i].get_type.get_type_str ||
          md1[i].get_type.get_type_str_post != md2[i].get_type.get_type_str_post
        return false
      end
      i += 1
    end

    return true
  end

  def show_tree( indent )
    indent.times { print "  " }
    puts "StructType tag: #{@tag} qualifier: #{@qualifier} has_pointer: #{@b_has_pointer_member}"
    super( indent + 1 )
    if @b_define then
      @members_decl.show_tree( indent + 1 )
    end
  end
end

class FuncType < Type
#  @paramlist::  ParamList
#  @type:: return type : PtrType, ArrayType, FuncType, IntType, FloatType, ...
#  @b_oneway:: bool: true, false
#  @has_in:: bool :  has [in] parameter
#  @has_inout:: bool : has [inout] parameter
#  @has_out:: bool : has [out] parameter
#  @has_send:: bool : has [send] parameter
#  @has_receive:: bool : has [receive] parameter

  def initialize( paramlist = nil )
    super()

    @has_in = false
    @has_inout = false
    @has_out = false
    @has_send = false
    @has_receive = false

    @paramlist = paramlist
    @b_oneway = false
    if paramlist then
      paramlist.check_param
    else
      @paramlist = ParamList.new( nil )
    end
    @paramlist.set_owner self  # ParamList
    @paramlist.get_items.each{ |p|
      case p.get_direction
      when :IN
        @has_in = true
      when :INOUT
        @has_inout = true
      when :OUT
        @has_out = true
      when :SEND
        @has_send = true
      when :RECEIVE
        @has_receive = true
      else
        raise "unkown direction"
      end
    }

  end

  def check	# ��̣Ū��꤬����С�ʸ������֤�
    if @type.class == ArrayType then	# ������֤��ؿ�
      return "function returning array"
    elsif @type.class == FuncType then	# �ؿ����֤��ؿ�
      return "function returning function"
    end
    return @type.check   # �ؿ��� return ���뷿�Υ����å�

    # �ѥ�᡼���η��Υ����å��� ParamList#check_param �ǹԤ�
  end

  def check_struct_tag kind
    @type.check_struct_tag kind
    # ParamDecl �Ǥ�����å������Τǡ������Ǥϥ����å����ʤ�
    # @paramlist.check_struct_tag kind
  end

  def check_init( locale, ident, initializer, kind, attribute = nil )
    cdl_error2( locale, "T1028 $1: cannot initialize function pointer" , ident )
    return
  end

  def set_type( type )
    unless @type then
      @type = type
    else
      @type.set_type( type )
    end
  end

  #=== return type ���֤�
  #
  # return type ���֤�
  # get_return_type �Ȥ��٤����ä�
  def get_type
    @type
  end

  def get_type_str
    return @type.get_type_str
  end

  def get_type_str_post
    # ���������֤� (��������̾����ޤ�ʤ�)
    @paramlist.to_str( false )
  end

  def get_paramlist
    @paramlist
  end

  def set_oneway( b_oneway )
    @b_oneway = b_oneway

    if ( ( @type.get_type_str != "ER" && @type.get_type_str != "void" ) || @type.get_type_str_post != "" ) then
      cdl_error( "T1029 oneway function cannot return type \'$1$2\', \'void\' or \'ER\' is permitted" , @type.get_type_str, @type.get_type_str_post )
    end

    if @paramlist then
      @paramlist.get_items.each{ |p|
        if p.get_direction != :IN && p.get_direction != :SEND then
          cdl_error( "T1030 oneway function cannot have $1 parameter for \'$2\'" , p.get_direction, p.get_name )
        end
      }
    end
  end

  def is_oneway?
    @b_oneway
  end

  #=== Push Pop Allocator ��ɬ�פ���
  # Transparent RPC �ξ�� oneway ���� in ������(size_is, count_is, string �Τ����줫�ǽ����ˤ�����
  def need_PPAllocator?( b_opaque = false )
    if @b_oneway || b_opaque then
      return @paramlist.need_PPAllocator?( b_opaque )
    else
      return false
    end
  end

  #=== �ѥ�᡼���� in, inout, out, send, receive ����Ĥ�
  def has_in?
    @has_in
  end
  def has_inout?
    @has_inout
  end
  def has_out?
    @has_out
  end
  def has_send?
    @has_send
  end
  def has_receive?
    @has_receive
  end

  #=== ���������Υѥ�᡼������Ĥ�
  def has_inward?
    @has_in || @has_inout || @has_send
  end
  #=== ���������Υѥ�᡼������Ĥ�
  def has_outward?
    @has_inout || @has_out || @has_receive
  end

  def show_tree( indent )
    indent.times { print "  " }
    if @b_oneway then
      puts "FunctType:  oneway: true"
    else
      puts "FunctType:  oneway: false"
    end
    super( indent + 1 )
    if @paramlist then
      @paramlist.show_tree( indent + 1 )
    end
    (indent+1).times { print "  " }
    puts "return type:"
    @type.show_tree( indent + 2 )
  end
end

class ArrayType < Type
#  @type:: element type :  ArrayType, FuncType, IntType, FloatType, ...
#  @subscript:: Expression, nil if '[]'

  include HasType

  def initialize( subscript = nil )
    super()
    @subscript = subscript
    initHasType
  end

  def set_type( type )
    unless @type then
      @type = type
    else
      @type.set_type( type )
    end
  end

  #=== Array#qualifier(const, volatile) ������
  def set_qualifier( qualifier )
    clone_type
    @type.set_qualifier( qualifier )
    super
  end

  # �������Ǥ� const �ʤ� const
  def is_const?
    @type.is_const?
  end

  # �������Ǥ� volatile �ʤ� volatile
  def is_volatile?
    @type.is_volatile?
  end

  def get_type
    @type
  end

  def get_subscript
    @subscript
  end

  def get_type_str
    return "#{@type.get_type_str}"
  end

  def get_type_str_post
    if @subscript
      "[#{@subscript.eval_const(nil)}]#{@type.get_type_str_post}"
    else
      "[]#{@type.get_type_str_post}"
    end
    # "[#{@subscript.to_s}]#{@type.get_type_str_post}"
  end

  def check	# ��̣Ū��꤬����С�ʸ������֤�
    if @type.class == FuncType then		# �ؿ�������
      return "array of function"
    elsif @type.class == ArrayType then	# ź���ʤ����������
      unless @type.get_subscript then
        return "subscript not specified"
      end
    end

    return @type.check    # �������Ǥη�������å�
  end

  def check_struct_tag kind
    @type.check_struct_tag kind
  end

  def check_init( locale, ident, initializer, kind, attribute = nil )
    if ( initializer.instance_of?( Array ) ) then
      index = 0
      initializer.each{ |i|
        @type.check_init( locale, "#{ident}[#{index}]", i, kind, attribute = nil )
        index += 1
      }
    else
      cdl_error2( locale, "T1031 $1: unsuitable initializer for array" , ident )
    end
  end

  def has_pointer?
    @type.has_pointer?
  end

  def has_sized_pointer?
    @type.has_sized_pointer?
  end

  def has_unsized_string?
    @type.has_unsized_string?
  end

  def show_tree( indent )
    indent.times { print "  " }
    puts "ArrayType:"
    super( indent + 1 )
    (indent+1).times { print "  " }
    puts "type:"
    @type.show_tree( indent + 2 )
    (indent+1).times { print "  " }
    puts "subscript:"
    if @subscript then
      @subscript.show_tree( indent + 2 )
    else
      (indent+2).times { print "  " }
      puts "no subscript"
    end
  end
end

class PtrType < Type
#  @type:: refer to : PtrType, FuncType, ArrayType, IntType, FloatType, ...
#  @size:: Expr, or nil if not specified
#  @count:: Expr, or nil if not specified
#  @string:: Expr or -1(if size not specified) ��string ������, or nil if not specified

  include HasType

  def initialize( referto = nil )
    super()
    @type   = referto
    @size   = nil
    @count  = nil
    @string = nil
    initHasType
  end

  def set_type( type )
    unless @type then
      @type = type
    else
      @type.set_type( type )	# ����� type ������
    end
  end

  def get_type_str
    if @type.kind_of?( ArrayType ) || @type.kind_of?( FuncType ) then
      parenthes = "("
    else
      parenthes = ""
    end
    return "#{@type.get_type_str}#{parenthes}*"
  end

  def get_type_str_post
    if @type.kind_of?( ArrayType ) || @type.kind_of?( FuncType ) then
      parenthes = ")"
    else
      parenthes = ""
    end
    "#{parenthes}#{@type.get_type_str_post}"
  end

  def check	# ��̣Ū��꤬����С�ʸ������֤�
    return nil if @type == nil
    @type.check
  end

  def check_struct_tag kind
    if kind != :MEMBER  # ��¤�Υ��С��ξ�硢�ݥ��󥿤���ι�¤�Υ���������å����ʤ�
      @type.check_struct_tag kind
    end
  end

  def check_init( locale, ident, initializer, kind, attribute = nil )
    if ( initializer.instance_of?( Expression ) ) then
      val = initializer.eval_const2( nil, attribute )
      if val.kind_of? PointerVal then
        type = val.get_type  # PtrType
        t1 = self
        t2 = type
        while( t1.kind_of?( PtrType ) && t2.kind_of?( PtrType ) )
          t1 = t1.get_type
          t2 = t2.get_type
          if ( t1.class == t2.class ) && ( t1.get_bit_size == t2.get_bit_size ) then
          elsif ( t1.kind_of?( CDefinedType) || t2.kind_of?( CDefinedType ) )&& t1.get_type_str == t2.get_type_str && t1.get_type_str_post && t2.get_type_str_post then
            # int8_t �ʤɤ��������� .h ���������Ƥ��륱����
          else
            cdl_error2( locale, "T1032 $1: incompatible pointer type" , ident )
            break
          end
        end
      elsif val.kind_of? IntegerVal then
        if val.to_i != 0 then
          cdl_error2( locale, "T1033 $1: need cast to assign integer to pointer" , ident )
        end
      elsif val.kind_of? StringVal then
        # ʸ�������
        # mikan L"wide string"
        if @type.get_bit_size != -1 && @type.get_bit_size != -11 then  # -1: char_t
          cdl_error2( locale, "T1034 $1: unsuitable string constant" , ident )
        end
      elsif ( val.instance_of?( Array ) ) then
        i = 0
        val.each { |ini|
          @type.check_init( locale, "#{ident}[#{i}]", ini, kind, attribute = nil )
          i += 1
        }
      elsif val.instance_of?( C_EXP ) then

      else
        cdl_error2( locale, "T1035 $1: unsuitable initializer for pointer" , ident )
      end
    elsif ( initializer.instance_of?( Array ) ) then
      i = 0
      initializer.each { |ini|
        @type.check_init( locale, "#{ident}[#{i}]", ini, kind, attribute = nil )
        i += 1
      }
    elsif( initializer.instance_of?( C_EXP ) ) then

    else
      cdl_error2( locale, "T1036 $1: unsuitable initializer for pointer" , ident )
    end
  end

  def get_referto
    clone_type
    @type
  end

  def set_scs( size, count, string, max, b_nullable )
    @size = size
    @count = count
    @max = max
    @b_nullable = b_nullable

    # string �ϺǤ⺸¦�� ptr �˺��Ѥ���
    if @type.kind_of?( PtrType ) then
      # ptr_level �� 2 �ʾ�Ǥ��뤳�Ȥ� ParamDecl#initializer �ǥ����å������
      clone_type
      @type.set_scs( nil, nil, string, max, b_nullable )
    elsif @type.kind_of?( VoidType ) && ( size || count || string ) then
      str = ""
      if size then
        str = "size_is"
      end
      if count then
        if str then
          str += ", "
        end
        str += "count_is"
      end
      if string then
        if str then
          str += ", "
        end
        str += "string"
      end

      cdl_error( "T9999 $1 specified for void pointer type", str )
    else
      @string = string
    end
  end

  def clear_max
    @max = nil
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

  #=== PtrType# size_is �κ�����
  def get_max
    @max
  end

  def is_nullable?
    return @b_nullable
  end

  def get_type
    clone_type
    @type
  end

  def has_pointer?
    true
  end

  def has_sized_pointer?
    @size != nil || @count != nil || @string.instance_of?( Expression ) || @type.has_sized_pointer?
  end

  def has_unsized_string?
    @string == -1 || @type.has_unsized_string?
  end

  def show_tree( indent )
    indent.times { print "  " }
    puts "PtrType: qualifier:#{@qualifier}, nullable:#{@b_nullable}"
    super( indent + 1 )
    (indent+1).times { print "  " }
    if @size then
      print "size:#{@size.to_s}, "
    else
      print "size:nil, "
    end
    if @max then
      print "max:#{@size.to_s}, "
    else
      print "max:nil, "
    end
    if @count then
      print "count:#{@count.to_s}, "
    else
      print "count:nil, "
    end
    if @string then
      if @string.instance_of?( Expression ) then
        print "string:#{@string.to_s}\n"
      else
        print "string:yes\n"
      end
    else
      print "string:nil\n"
    end

    (indent+1).times { print "  " }
    puts "type:"
    @type.show_tree( indent + 2 )
  end

end

# �ʲ�ñ�Υƥ��ȥ�����
if $unit_test then
  puts( "===== Unit Test: IntType ===== (types.rb)")
  sizes = [ 8, 16, 32, 64 ]
  sizes.each{ |n|
    int = IntType.new n
    printf( "%8s  max: %d  min:%d\n", "int#{n}_t", int.get_max, int.get_min )
  }
  puts ""
end
