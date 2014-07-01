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
#   $Id: value.rb 1925 2013-01-20 05:55:58Z okuma-top $
#++

#= BaseVal ��������ư�����ʤɤ��ͤ򰷤����饹�δ��쥯�饹
#
# TECS �� CDL �ǰ����ͤϡ��ʲ���ʬ�व���
# ������
# ����ư����
# ��ʸ����
# ���֡�����
# �������ʹ�¤�Ρ�����ˤ� C_EXP �Ϥ����Ǥϰ���ʤ�
#
# ���Υ��饹������Ѥߤα黻�Ҥϡ����顼�Ȥʤ�
# ���ˤ��黻��ǽ�ʾ�硢�黻�Ҥ򥪡��С��饤�ɤ���
#
class BaseVal < Node
  def ~@
    unsupport "~"
  end
  def -@
    unsupport "unary -"
  end
  def +@
    unsupport "unary +"
  end
  def not # ! val
    unsupport "!"
  end

  def * val
    unsupport "*"
  end
  def / val
    unsupport "/"
  end
  def % val
    unsupport "%"
  end
  def + val
    unsupport "+"
  end
  def - val
    unsupport "-"
  end
  def << val
    unsupport "<<"
  end
  def >> val
    unsupport ">>"
  end
  def > val
    unsupport ">"
  end
  def < val
    unsupport "<"
  end
  def >= val
    unsupport ">="
  end
  def <= val
    unsupport "<="
  end
  def eq val # == val
    unsupport "=="
  end
  def neq val # != val
    unsupport "!="
  end
  def & val
    unsupport "&"
  end
  def ^ val
    unsupport "^"
  end
  def | val
    unsupport "|"
  end
  def lAND val  # && val
    unsupport "&&"
  end
  def lOR val   # || val
    unsupport "||"
  end
  def cast( type )
    unsupport "CAST"
  end

  def unsupport op
    cdl_error( "V1001 $1: unable for $2" , op, self.class )
  end

  def to_s
    raise "to_s not overridden"
  end

  def to_b
    cdl_error( "V1002 $1: cannot cast to bool (implicitly)" , self.class )
    false
  end
  def to_i
    cdl_error( "V1003 $1: cannot cast to integer (implicitly)" , self.class )
    1
  end
  def to_f
    cdl_error( "V1004 $1: cannot cast to float (implicitly)" , self.class )
    1.0
  end
end

#= Pointer �� (IntegerVal �� Pointer ��)
#
# �ݥ����ͤϡ�CDL ��ľ����������뤳�ȤϤʤ�
# �����ͤΥ��㥹�ȱ黻�ˤ�����������
class PointerVal < BaseVal
#@int_val:: IntegerVal: IntegerVal �Ǥʤ��ƤϤʤ�ʤ�
#@ptr_type:: PtrType: �ݥ��󥿤λؤ���η�

  def initialize( int_val, ptr_type )
    super()
    @int_val = int_val
    @ptr_type = ptr_type
  end

  #=== �ݥ��󥿤λؤ���η�������
  # PointerVal ���ѤΥ᥽�å�
  def get_type
    @ptr_type
  end

  def cast type
    t = type.get_original_type   # typedef �θ�������
    if t.kind_of? IntType then
      val = t.check_and_clip( @int_val, :IntType )
      return IntegerVal.new( val )
    elsif t.kind_of? FloatType then
      cdl_error( "V1005 Cannot cast pointer to float"  )
      return FloatVal.new( @int_val )
    elsif t.kind_of? PtrType then
      return PointerVal.new( @int_val, type )
    else
      cdl_error( "V1006 pointer value cannot cast to $1" , type.class )
      return nil
    end
  end

  def to_s
    "(#{@ptr_type.get_type_str}#{@ptr_type.get_type_str_post})#{sprintf("0x%X", @int_val)}"
  end

  def to_b
    cdl_error( "V1007 convert pointer value to bool"  )
    false
  end
  def to_i
    cdl_error( "V1008 convert pointer value to integer without cast"  )
    @val.to_i
  end
end

#= IntegerVal: �����ͤ򰷤����饹
class IntegerVal < BaseVal
#@val:: Integer: value
#@str:: string: literal
#@sign:: Symbol: :SIGNED | :UNSIGNED
#@size:: Symbol: :NORMAL | :SHORT | :LONG | :LONGLONG

  def initialize( val, str = nil, sign = :SIGNED, size = :NORMAL )
    super()
    @val = val.to_i
    @str = str
    @sign = sign
    @size = size
  end

  def ~@
    IntegerVal.new( ~ @val )
  end
  def -@
    IntegerVal.new( - @val )
  end
  def +@
    self
  end
  def not # !
      BoolVal.new( self.to_b )
  end

  def * val
    if val.kind_of? FloatVal then
      return FloatVal.new( @val.to_f * val.to_f )
    else
      return IntegerVal.new( @val * val.to_i )
    end
  end
  def / val
    if val.kind_of? FloatVal then
      v2 = val.to_f   # to_f ��2��ɾ�����ʤ�
      if v2 == 0.0 then
        cdl_error( "V1009 / : divieded by zero"  )
        return FloatVal.new( 1.0 )
      end
      return FloatVal.new( @val.to_f / v2 )
    else
      v2 = val.to_i   # to_i ��2��ɾ�����ʤ�
      if v2 == 0 then
        cdl_error( "V1010 / : divieded by zero"  )
        return IntegerVal.new( 1 )
      end
      return IntegerVal.new( @val / v2 )
    end
  end
  def % val
    if val.kind_of? FloatVal then
      v2 = val.to_f   # to_f ��2��ɾ�����ʤ�
      if v2 == 0.0 then
        cdl_error( "V1011 % : divieded by zero"  )
        return FloatVal.new( 1.0 )
      end
      return FloatVal.new( @val.to_f % v2 )
    else
      v2 = val.to_i   # to_i ��2��ɾ�����ʤ�
      if v2 == 0 then
        cdl_error( "V1012 % : divieded by zero"  )
        return IntegerVal.new( 1 )
      end
      return IntegerVal.new( @val % v2 )
    end
  end
  def + val
    if val.kind_of? FloatVal then
      return FloatVal.new( @val.to_f + val.to_f )
    else
      return IntegerVal.new( @val + val.to_i )
    end
  end
  def - val
    if val.kind_of? FloatVal then
      return FloatVal.new( @val.to_f - val.to_f )
    else
      return IntegerVal.new( @val - val.to_i )
    end
  end
  def << val
    return IntegerVal.new( @val << val.to_i )
  end
  def >> val
    return IntegerVal.new( @val >> val.to_i )
  end
  def > val
    if val.kind_of? FloatVal then
      return BoolVal.new( @val.to_f > val.to_f )
    else
      return BoolVal.new( @val > val.to_i )
    end
  end
  def < val
    if val.kind_of? FloatVal then
      return BoolVal.new( @val.to_f < val.to_f )
    else
      return BoolVal.new( @val < val.to_i )
    end
  end
  def >= val
    if val.kind_of? FloatVal then
      return BoolVal.new( @val.to_f >= val.to_f )
    else
      return BoolVal.new( @val >= val.to_i )
    end
  end
  def <= val
    if val.kind_of? FloatVal then
      return BoolVal.new( @val.to_f <= val.to_f )
    else
      return BoolVal.new( @val <= val.to_i )
    end
  end
  def eq val # == val
    if val.kind_of? FloatVal then
      return BoolVal.new( @val.to_f == val.to_f )
    else
      return BoolVal.new( @val == val.to_i )
    end
  end
  def neq val # != val
    if val.kind_of? FloatVal then
      return BoolVal.new( @val.to_f != val.to_f )
    else
      return BoolVal.new( @val != val.to_i )
    end
  end
  def & val
    IntegerVal.new( @val & val.to_i )
  end
  def ^ val
    IntegerVal.new( @val ^ val.to_i )
  end
  def | val
    IntegerVal.new( @val | val.to_i )
  end
  def lAND val  # && val
    BoolVal.new( self.to_b && val.to_b )
  end
  def lOR val   # || val
    BoolVal.new( self.to_b || val.to_b )
  end
  def cast( type )
    t = type.get_original_type   # typedef �θ�������
    if t.kind_of? IntType then
      val = t.check_and_clip( @val, :IntType )
      return IntegerVal.new( val )
    elsif t.kind_of? FloatType then
      return FloatVal.new( @val )
    elsif t.kind_of? PtrType then
      return PointerVal.new( @val, type )
    elsif t.kind_of? BoolType then
      return BoolVal.new( @val.to_b )
    else
      cdl_error( "V1013 integer value cannot cast to $1" , type.class )
      return nil
    end
  end

  def to_s
    if @str then
      @str
    else
      @val.to_s
    end
  end
  def to_b
    @val != 0
  end
  def to_i
    @val
  end
  def to_f
    @val.to_f
  end
end

#= BoolVal: bool �ͤ򰷤����饹
class BoolVal < BaseVal
#@val:: bool: true, false

  def initialize( val )
    super()
    if val == true || val == false
      @val = val
    elsif val.to_i != 0
      @val = true
    else
      @val = false
    end
    # raise "No boolean val" if val != true && val != false
  end

  def not # ! val
      BoolVal.new( ! @val )
  end
  def eq val # == val
    if val.kind_of? BoolVal then
      return BoolVal.new( self.to_i == val.to_i )
    else
      cdl_error( "V1014 comparing bool value with \'$1\'" , val.class )
      return BoolVal.new( false )
    end
  end
  def neq val # != val
    if val.kind_of? BoolVal then
      return BoolVal.new( self.to_i != val.to_i )
    else
      cdl_error( "V1015 comparing bool value with \'$1\'" , val.class )
      return BoolVal.new( false )
    end
  end
  def lAND val  # && val
    BoolVal.new( self.to_b && val.to_b )
  end
  def lOR val   # || val
    BoolVal.new( self.to_b || val.to_b )
  end
  def cast( type )
    t = type.get_original_type   # typedef �θ�������
    if @val then
      val = 1
    else
      val = 0
    end
    if t.kind_of? IntType then
      return IntegerVal.new( val )
    elsif t.kind_of? FloatType then
      return FloatVal.new( val )
    elsif t.kind_of? BoolType then
      return self
    else
      cdl_error( "V1016 bool value cannot cast to $1" , type.class )
      return nil
    end
  end

  def to_s
    if @val
      return "true"
    else
      return "false"
    end
  end
  def to_b
    @val
  end
  def to_i
    return 0 if @val == false
    return 1
  end
  def to_f
    return 0.0 if @val == false
    return 1.0
  end

  attr_reader :val
end

#= FloatVal: �¿��ͤ򰷤����饹
class FloatVal < BaseVal
#@val:: Float
  def initialize( val )
    super()
    @val = val.to_f
  end

  def -@
    FloatVal.new( - @val )
  end
  def +@
    self
  end
  def * val
    FloatVal.new( @val * val.to_f )
  end
  def / val
    v2 = val.to_f   # to_f ��2��ɾ�����ʤ�
    if v2 == 0.0 then
      cdl_error( "V1017 / : divieded by zero"  )
      return FloatVal.new( 1.0 )
    end
    return FloatVal.new( @val.to_f / v2 )
  end
  def % val
    v2 = val.to_f   # to_f ��2��ɾ�����ʤ�
    if v2 == 0.0 then
      cdl_error( "V1018 % : divieded by zero"  )
      return FloatVal.new( 1.0 )
    end
    return FloatVal.new( @val.to_f % v2 )
  end
  def + val
    FloatVal.new( @val + val.to_f )
  end
  def - val
    FloatVal.new( @val - val.to_f )
  end
  def > val
    BoolVal.new( @val > val.to_f )
  end
  def < val
    BoolVal.new( @val < val.to_f )
  end
  def >= val
    BoolVal.new( @val >= val.to_f )
  end
  def <= val
    BoolVal.new( @val <= val.to_f )
  end
  def eq val # == val
    BoolVal.new( @val == val.to_f )
  end
  def neq val # != val
    BoolVal.new( @val != val.to_f )
  end
  def cast( type )
    t = type.get_original_type   # typedef �θ�������
    if t.kind_of? IntType then
      val = t.check_and_clip( @val, :FloatType )
      return IntegerVal.new( val )
    elsif t.kind_of? FloatType then
      return self
    else
      cdl_error( "V1019 floating value cannot cast to $1" , type )
      return self
    end
  end

  def to_b
    cdl_error( "V1020 convert floating value to bool without cast"  )
    @val.to_i
  end
  def to_i
    cdl_error( "V1021 convert floating value to integer without cast"  )
    @val.to_i
  end
  def to_s
    @val.to_s
  end
  def to_f
    @val
  end
end

#= ʸ�����ƥ��򰷤����饹
class StringVal < BaseVal
#@str:: Token:
#@specifier:: Symbol: :WIDE, :NORMAL

  def initialize( str, spec = :NORMAL )
    super()
    @str = str
    @specifier = spec   # mikan L"str" wide ʸ����̤�б�
  end

  #===
  #
  # string �� cast �ϤǤ��ʤ� mikan �ݥ��󥿷��ؤ� cast �ϤǤ���٤�
  def cast type
    t = type.get_original_type   # typedef �θ�������
    if t.kind_of? IntType then
      cdl_error( "V1022 string cannot cast to integer"  )
    elsif t.kind_of? FloatType then
      cdl_error( "V1023 string cannot cast to float"  )
    elsif t.kind_of? PtrType then
      cdl_error( "V1024 string cannot cast to pointer"  )
    else
      cdl_error( "V1025 string cannot cast to $1" , type )
    end
  end
    
  def to_s
    @str.to_s
  end

  def val
    @str.to_s   # Token �ǰ����Ƥ���̾�� (val ����Ф�)
  end
end
