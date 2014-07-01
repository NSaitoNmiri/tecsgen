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
#   $Id: ctypes.rb 1925 2013-01-20 05:55:58Z okuma-top $
#++

# CType �� C_parser ���������뷿�򰷤� CIntType, CFloatType �ʤɤ� include ������
# CIntType �� IntType ��Ѿ�����ʤɡ�C �η��Ǥ� TECS �η���Ѿ�����
module CType

  #=== ��ʸ���� type_specifier ��ʣ�����ꤵ��Ƥ������ merge ����
  def merge another

    # p "self: #{self.class} kind_of( IntType ): #{self.kind_of?( IntType )}  another: #{another.class}"

    if another.instance_of? Symbol then
      # ������ Symbol �� :SIGNED, :UNSIGNED �Τ����줫

      # CIntType ����
      if self.instance_of? CIntType then
        self.set_sign another
        return self
      else
        cdl_error( "C1001 $1: mismatch, suitable for int types" , another )
        return self
      end
    elsif self.instance_of?( CIntType ) && another.instance_of?( CIntType )then
      if another.get_bit_size != -3 then
        # self �� int ����another �� bit_size �� (int �ʳ��Ǥ����)������ˤ���
        @bit_size = another.get_bit_size
      end

      if another.get_sign then
        # another �� sign �����ꤵ��Ƥ���С�������Τ�Τ���Ѥ��� mikan ̷��Υ����å�
        @sign = another.get_sign
      end

#      if another.get_qualifier then
#        # another �� qualifier �����ꤵ��Ƥ���С�������Τ�Τ���Ѥ��� mikan ̷��Υ����å�
#        @qualifier = another.get_qualifier
#      end
      if another.is_const? then
        @b_const = true
      end
      if another.is_volatile? then
        @b_volatile = true
      end

      return self
    elsif self.instance_of?( CDefinedType ) then
      if self.get_type.get_type_str == another.get_type_str &&
          self.get_type.get_type_str_post == another.get_type_str_post
        # p "typedef #{another.get_type_str} #{self.get_type_str}#{another.get_type_str_post} ;"
      else
        cdl_error( "C1002 $1 not compatible with previous one $2" , self.get_type_str, another.get_type_str )
      end
      return self
    else
      # mikan long double
      cdl_error( "C1003 $1 & $2 incompatible  (\'long double\' not support)" , self.class, another.class )
      return self
    end
  end

  #=== qualifier �����ꤹ��
  #     ���� Type ���饹�Ǥ�̷������å����ʤ���TECS�������ʸˡ�ǤϽ�ʣ����Ǥ��ʤ������
  def set_qualifier( qual )

    # extern ��̵�뤹��
    if qual == :EXTERN then
      return
    end

    if @qualifier then
      cdl_error( "C1004 $1: qualifier redefined. previous one: $2" , qual, @qualifier )
    end
    super( qual )
  end

end

class CDefinedType < DefinedType

  include CType

  def initialize( type_name )
    super( type_name )
  end
end

class CVoidType < VoidType

  include CType

end

class CBoolType < BoolType

  include CType

end

class CIntType < IntType

  include CType

  def initialize( bit_size )
    #p super.class   mikan super.class �� Symbol �����ʤ���
    super( bit_size )
  end

  def get_bit_size
    @bit_size
  end

  def get_sign
    @sign
  end
end

class CFloatType < FloatType

  include CType

  def initialize( bit_size )
    super
  end

end

class CEnumType < EnumType # mikan

  include CType

  def initialize( bit_size )
    super( bit_size )
  end

end

class CStructType < StructType

  include CType


  def initialize( tag = nil )
    super( tag )
  end
end

class CFuncType < FuncType

  include CType

  def initialize( paramlist = nil )
    super( paramlist )
  end

end

class CArrayType < ArrayType

  include CType

  def initialize( subscript = nil )
    super( subscript )
  end
end

class CPtrType < PtrType

  include CType

  def initialize( referto = nil )
    super( referto )
  end

end
