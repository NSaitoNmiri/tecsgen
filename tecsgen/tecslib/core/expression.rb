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
#   $Id: expression.rb 1930 2013-03-10 08:13:25Z okuma-top $
#++

class Expression < Node
#  @elements   # array

  def initialize( elements )
    super()
    @elements = elements
  end

  def print
    # puts "expr: #{@elements}"
    puts "expr_string: #{to_s}"
  end

  #=== Expression# to_s
  # C ���쥽����������ʸ��������� (globa_name)
  def to_s
    elements_to_s( @elements )
  end

  #=== Expression# to_str
  # C ���쥽����������ʸ��������� (globa_name)
  def to_str( name_list, pre, post )
    elements_to_s( @elements, name_list, pre, post )
  end

  #=== Expression#to_CDL_str
  # CDL ɽ����ʸ���������
  def to_CDL_str
    return to_s
  end

  #=== ������Ȥ���ɾ������(�ȥ饤���Ƥߤ�)
  #
  # ���Υ᥽�åɤϡ��������ɾ������
  # ��attribute, var �ν������
  # ��size_is, count_is ����
  # �������ź��
  #
  # name_list(NamedList|Nil): �����黲�Ȳ�ǽ�ʥꥹ�ȡ�
  # NamedList �����Ǥ�  size_is, count_is �ΰ���ɾ���ξ�� ParamDecl (�ؿ�������)
  #
  # name_list2(NamedList|Nil) : NamedList �����Ǥ� Decl (attribute, var) �Ǥ��롥��ά�� nil
  # 
  # RETURN: ɾ�����������ɾ���Ǥ��ʤ��ä����� nil ���֤�
  #
  # ���� get_type �ǡ�ɾ�����������Ȥ��Ƶ����ʤ��Ȥ��˻��ѤǤ����
  # Array ���֤��Τ� attr{ int *a = {1, 2, 3}; int *b = a; }; �� b �α��դ�ɾ���������

  def eval_const( name_list, name_list2 = nil )
    val = elements_eval_const( @elements, name_list, name_list2, 0 )
    if val.kind_of? IntegerVal then
      return val.to_i
    elsif val.kind_of? FloatVal then
      return val.to_f
    elsif val.kind_of? BoolVal then
      return val.to_i
    elsif val.kind_of? PointerVal then
      return val.to_i           # mikan ���顼 V1008 ��ȯ�����Ƥ��ޤ�
      # elsif val.kind_of? EnumVal then
      # enum mikan
    else
      # C_EXP, Array �ޤ��� nil �����Τޤ��֤�
      return val
    end
  end

  #=== ������Ȥ���ɾ������2(�ȥ饤���Ƥߤ�)
  #
  # IntegerVal, FloatVal �򤽤Τޤ��֤���eval_const �Ǥ� Integer, Float ���Ѵ���
  def eval_const2( name_list, name_list2 = nil, nest = 0 )
    val = elements_eval_const( @elements, name_list, name_list2, nest )
  end

  #=== ���η���ɾ������
  #
  # eval_const ���ͤ������ʤ���硢����Ƴ�в�ǽ�Ǥ���з�������
  # param ��ޤ����������ͤ�����ʤ������������뤳�ȤϤǤ���
  # ̤����ѿ���ޤ�����ϡ����뤳�Ȥ��Ǥ��ʤ� (���ߡ���������֤�)
  def get_type( namedList )        # ̾�����֤� NamedList �����
    elements_get_type( @elements, namedList )
  end

  def check_dir_for_param( namedList, dir, spec )
    elements_check_dir_for_param( @elements, namedList, dir, spec )
  end

  def get_elements
    @elements
  end

  def show_tree( indent )
    # mikan override ���Ƥ��ޤä� print ��ƽФ���ˡ���狼��ʤ��ΤǤ�������
    str = ""
    indent.times { str += "  " }
    puts "#{str}#{to_s}"
  end

## private

  #=== ����ʸ������Ѵ�
  #name_list:: attribute (Celltype::@attribute_list), struct �� @member_list ���ꤷ�Ƥ���
  def elements_to_s( elements, name_list = nil, pre = nil, post = nil )
    if elements.instance_of? Token then
      return elements.to_s    # OP_DOT, OP_REF �α���
    end

    case elements[0]
    when :IDENTIFIER
      nsp = elements[1]
      if nsp.is_name_only? && name_list && name_list.get_item( nsp.get_name ) then
        return "#{pre}#{nsp.get_name}#{post}"
      else
        # return  elements[1].get_global_name
        return nsp.get_path_str
      end
    when :INTEGER_CONSTANT, :FLOATING_CONSTANT, :OCTAL_CONSTANT, :HEX_CONSTANT, :CHARACTER_LITERAL, :STRING_LITERAL_LIST, :BOOL_CONSTANT
      return  elements[1].to_s
    when :PARENTHESES
      return "(#{elements_to_s(elements[1],name_list,pre,post)})"
    when :OP_SUBSC
      return "#{elements_to_s(elements[1],name_list,pre,post)}[#{elements[2].to_s}]"
    when :OP_DOT
      return "#{elements_to_s(elements[1],name_list,pre,post)}.#{elements_to_s(elements[2],name_list,pre,post)}"
    when :OP_REF
      return "#{elements_to_s(elements[1],name_list,pre,post)}->#{elements_to_s(elements[2],name_list,pre,post)}"
    when :OP_SIZEOF_EXPR
      return "sizeof(#{elements_to_s(elements[1],name_list,pre,post)})"
    when :OP_SIZEOF_TYPE
      return "sizeof(#{elements[1]}) mikan"
    when :OP_U_AMP
      return "&#{elements_to_s(elements[1],name_list,pre,post)}"
    when :OP_U_ASTER
      return "*#{elements_to_s(elements[1],name_list,pre,post)}"
    when :OP_U_PLUS
      return "+#{elements_to_s(elements[1],name_list,pre,post)}"
    when :OP_U_MINUS
      return "-#{elements_to_s(elements[1],name_list,pre,post)}"
    when :OP_U_TILDE
      return "~#{elements_to_s(elements[1],name_list,pre,post)}"
    when :OP_U_EXCLAM
      return "!#{elements_to_s(elements[1],name_list,pre,post)}"
    when :CAST
      return "(#{elements[1].get_type_str})#{elements_to_s(elements[2],name_list,pre,post)}"
    when :OP_MULT
      return "#{elements_to_s(elements[1],name_list,pre,post)}*#{elements_to_s(elements[2],name_list,pre,post)}"
    when :OP_DIV
      return "#{elements_to_s(elements[1],name_list,pre,post)}/#{elements_to_s(elements[2],name_list,pre,post)}"
    when :OP_REMAIN
      return "#{elements_to_s(elements[1],name_list,pre,post)}%#{elements_to_s(elements[2],name_list,pre,post)}"
    when :OP_ADD
      return "#{elements_to_s(elements[1],name_list,pre,post)}+#{elements_to_s(elements[2],name_list,pre,post)}"
    when :OP_SUB
      return "#{elements_to_s(elements[1],name_list,pre,post)}-#{elements_to_s(elements[2],name_list,pre,post)}"
    when :OP_LSFT
      return "#{elements_to_s(elements[1],name_list,pre,post)}<<#{elements_to_s(elements[2],name_list,pre,post)}"
    when :OP_RSFT
      return "#{elements_to_s(elements[1],name_list,pre,post)}>>#{elements_to_s(elements[2],name_list,pre,post)}"
    when :OP_LT
      return "#{elements_to_s(elements[1],name_list,pre,post)}<#{elements_to_s(elements[2],name_list,pre,post)}"
    when :OP_GT
      return "#{elements_to_s(elements[1],name_list,pre,post)}>#{elements_to_s(elements[2],name_list,pre,post)}"
    when :OP_LE
      return "#{elements_to_s(elements[1],name_list,pre,post)}<=#{elements_to_s(elements[2],name_list,pre,post)}"
    when :OP_GE
      return "#{elements_to_s(elements[1],name_list,pre,post)}>=#{elements_to_s(elements[2],name_list,pre,post)}"
    when :OP_EQ
      return "#{elements_to_s(elements[1],name_list,pre,post)}==#{elements_to_s(elements[2],name_list,pre,post)}"
    when :OP_NE
      return "#{elements_to_s(elements[1],name_list,pre,post)}!=#{elements_to_s(elements[2],name_list,pre,post)}"
    when :OP_AND
      return "#{elements_to_s(elements[1],name_list,pre,post)}&#{elements_to_s(elements[2],name_list,pre,post)}"
    when :OP_EOR
      return "#{elements_to_s(elements[1],name_list,pre,post)}^#{elements_to_s(elements[2],name_list,pre,post)}"
    when :OP_OR
      return "#{elements_to_s(elements[1],name_list,pre,post)}|#{elements_to_s(elements[2],name_list,pre,post)}"
    when :OP_LAND
      return "#{elements_to_s(elements[1],name_list,pre,post)}&&#{elements_to_s(elements[2],name_list,pre,post)}"
    when :OP_LOR
      return "#{elements_to_s(elements[1],name_list,pre,post)}||#{elements_to_s(elements[2],name_list,pre,post)}"
    when :OP_CEX
      return "#{elements_to_s(elements[1],name_list,pre,post)}?#{elements_to_s(elements[2],name_list,pre,post)}:#{elements_to_s(elements[3],name_list,pre,post)}"
    else
      raise "Unknown expression element: #{elemets[0]}. try -t and please report"
    end
    return ""
  end

  # �����(elements)��ɾ������
  #
  # ���Υ᥽�åɤ� Expression ���饹�Υ᥽�åɤǤ���ɬ�פϤʤ��ʴؿ����Ǥ����
  #
  # elements �ϼ�������
  #
  # name_list, name_list2 �� eval_const �򻲾�
  #
  # RETURN: ɾ�����������ɾ���Ǥ��ʤ��ä����� nil ���֤�

  MAX_NEST_LEVEL = 64    # �ʰפΥ롼�׸��Сʻ��ȤΥͥ��Ȥ� 64 �ޤǵ��Ĥ����
  def elements_eval_const( elements, name_list, name_list2 = nil, nest = nil )

    case elements[0]
    when :IDENTIFIER
      nsp = elements[1]

      # #809 �ν��������� (�̤����꤬��褷����Ƥ��ʤ�)
      # nest += 1     # ���Ȥ��롼�פˤʤäƤ��ʤ����Υ����å�
      #               # mikan �����˥롼�פ��Ƥ��뤫�ɤ����ǤϤʤ���ñ���¿���λ��Ȥ򷫤��֤��Ƥ��뤳�Ȥ�Ƚ�ꤷ�Ƥ���
      # if nest > MAX_NEST_LEVEL then
      #   cdl_error( "E9999: '$1' too many reference (maybe loop) max=$1" , nsp.to_s, MAX_NEST_LEVEL )
      #   return
      # end
      if nsp.is_name_only? then
        if name_list then
          object = name_list.get_item( nsp.get_name )
        end

        if object == nil && name_list2 then
          object = name_list2.get_item( nsp.get_name )
        end
      end

      # ���Ĥ���ʤ��������������õ��
      if object == nil then
        object = Namespace.find( nsp )# mikan namespace ���б� #1
      end

# ���μ����ϡ��⤦�������������٤�
# ���줬�ƽФ����Τϡ��ʲ��ξ��
#   ��attribute, var �α��ռ���ɾ��
#   ��size_is ������ɾ�����ؿ��ѥ�᡼���ξ���attribute, var �ξ�礬����
# �ʲ��Υ��顼�����å��Ǥϡ�����餬���ä���ˤʤäƸ��򸡽Ф��褦�Ȥ��Ƥ���

      # IDENTIFIER �ϸ��Ĥ���ʤ��ä���
      if object == nil then
        cdl_error( "E1001 $1: not found" , nsp.get_path_str )
        # raise  "E1001"  # bug trap
        return nil
      elsif object.instance_of?( Join ) then
        # Join �ξ�硧 cell ����� attribute, var, call �Τɤ줫�����Ĥ��ä�
        # Decl (attribute, var) �Ǥʤ���
        if ! object.get_definition.instance_of?( Decl ) then
          cdl_error( "E1002 $1: not constant (port)" , nsp.get_path_str )
          return nil
        end
        return object.get_rhs.eval_const2( name_list, name_list2, nest )
      elsif ! object.instance_of?( Decl ) then
        # Decl �Ǥʤ���硧 ����Ǥ�ʤ�
        if ( ! object.instance_of?( ParamDecl ) ) then
                                                      # mikan paramdecl ��̵�뤹��
                                                      # ParamList ����ƤФ줿�Ȥ�
          cdl_error( "E1003 $1: not constant" , nsp.get_path_str )
        else
          # ParamDecl
          object.referenced
        end
        return nil
      else # Decl
        object.referenced
        if object.get_initializer == nil then
          # ������Ҥ�¸�ߤ��ʤ��ѿ�   # mikan �����ؤ���Τϡ��̾濫�ꤨ�ʤ��Ϥ���̤���ڡ�
          return IntegerVal.new( 0 )
        else
          # Decl �α��դ�ɾ��
          # mikan size_is �����˸�����ѿ��η���Ŭ�ڤ��Υ����å�����
          if object.get_initializer.instance_of?( Expression ) || object.get_initializer.instance_of?( C_EXP ) then
            return object.get_initializer.eval_const2( name_list, name_list2, nest )
          else
            # Array �ξ��
            return object.get_initializer
          end
        end
      end
    when :BOOL_CONSTANT
      if( elements[1].instance_of?( TrueClass ) )then
        return BoolVal.new( true )
      elsif( elements[1].instance_of?( FalseClass ) )then
        return  BoolVal.new( false )
      else
        throw( "BOOL constant error" )
      end
    when :INTEGER_CONSTANT
      return IntegerVal.new( elements[1].val )
    when :FLOATING_CONSTANT
      return FloatVal.new( elements[1].val )
    when :OCTAL_CONSTANT
      return IntegerVal.new( elements[1].val.oct, elements[1].val )
    when :HEX_CONSTANT
      return IntegerVal.new( elements[1].val.hex, elements[1].val )
    when :CHARACTER_LITERAL
      str =  elements[1].val.gsub(/'/, "" )
#2.0      if str.jlength == 1
      if $b_no_kcode then
        len = str.length
      else
        len = str.jlength
      end
      if len == 1 then
        sum = 0
        str.each_byte { |b| sum = sum * 256 + b }
        return IntegerVal.new( sum, elements[1].val )
      else
#2.0        if str[0] == 92 then
        if str[0] == 92 || str[0] == "\\" then
          case str[1]
#2.0          when 48 # '0'
          when 48, "0" # '0'
            return IntegerVal.new( 0, elements[1].val )
#2.0          when 110 # 'n'
          when 110, "n" # 'n'
            return IntegerVal.new( 10, elements[1].val )
#2.0          when 114 # 'r'
          when 114, "r" # 'r'
            return IntegerVal.new( 13, elements[1].val )
#2.0          when 116 # 't'
          when 116, "t" # 't'
            return IntegerVal.new( 15, elements[1].val )
#2.0          when 92 # '\\'
          when 92, '\\' # '\\'
            return IntegerVal.new( 92, elements[1].val )
          end
        end
      end
#2.0      printf( "c=%c\n", str[1] )
      printf( "len=%d c=%c\n", len, str[1] )
      raise Error

    when :STRING_LITERAL_LIST
      return  StringVal.new( elements[1] )
    when :PARENTHESES
      return elements_eval_const( elements[1], name_list, name_list2, nest );
    when :OP_SUBSC
      cdl_error( "E1004 cannot evaluate \'[]\' operator"  )
      return nil
    when :OP_DOT
      cdl_error( "E1005 cannot evaluate \'.\' operator"  )
      return nil
    when :OP_REF
      cdl_error( "E1006 cannot evaluate \'->\' operator"  )
      return nil
    when :OP_SIZEOF_EXPR
      cdl_error( "E1007 cannot evaluate \'sizeof\' operator"  )
      return nil
    when :OP_SIZEOF_TYPE
      cdl_error( "E1008 cannot evaluate \'sizeof\' operator"  )
      return nil
    when :OP_U_AMP
      cdl_error( "E1009 cannot evaluate \'&\' operator"  )
      return nil
    when :OP_U_ASTER
      # cdl_error( "E1010 cannot evaluate \'*\' operator"  )
      val = elements_eval_const(elements[1], name_list, name_list2, nest)
      return nil if ! evaluable?( val )
      return val
    when :OP_U_PLUS
      val = elements_eval_const(elements[1], name_list, name_list2, nest)
      return nil if ! evaluable?( val )
      if val.respond_to?( "+@" ) then
        return + val
      else
        cdl_error( "E1011 cannot evaluate unary + for $1" , val.class )
        return nil
      end
    when :OP_U_MINUS
      val = elements_eval_const(elements[1], name_list, name_list2, nest)
      return nil if ! evaluable?( val )
      if val.respond_to?( "-@" ) then
        return - val
      else
        return nil
      end
    when :OP_U_TILDE
      val = elements_eval_const(elements[1], name_list, name_list2, nest)
      return nil if ! evaluable?( val )
# p "val.respond_to?( \"-@\" )=#{val.respond_to?( "-@" )} #{val.class}"
# p "val.respond_to?( \"~@\" )=#{val.respond_to?( "~@" )}"
#2.0      if val.respond_to?( "~@" ) then  # Ruby 1.9, 2.0 preview �ǤǤ��㳰��ȯ�����Ƥ��ޤ�
      if val.kind_of? IntegerVal then
        return ~ val
      else
        return nil
      end
    when :OP_U_EXCLAM
      val = elements_eval_const(elements[1], name_list, name_list2, nest)
      return nil if ! evaluable?( val )
      val = val.cast( BoolType.new )
      if val.respond_to?( "not" ) then
        return val.not
      else
        return nil
      end
      return nil
    when :CAST
      val = elements_eval_const(elements[2], name_list, name_list2, nest)
      # return nil if val == nil
      return nil if ! evaluable?( val )
      return val.cast( elements[1] )
    when :OP_MULT
      lhs = elements_eval_const(elements[1], name_list, name_list2, nest)
      rhs = elements_eval_const(elements[2], name_list, name_list2, nest)
      # return nil if( rhs == nil || lhs == nil )
      return nil if ! evaluable?( rhs, lhs )
      return lhs * rhs
    when :OP_DIV
      lhs = elements_eval_const(elements[1], name_list, name_list2, nest)
      rhs = elements_eval_const(elements[2], name_list, name_list2, nest)
      # return nil if( rhs == nil || lhs == nil )
      return nil if ! evaluable?( rhs, lhs )
      return lhs / rhs
    when :OP_REMAIN
      lhs = elements_eval_const(elements[1], name_list, name_list2, nest)
      rhs = elements_eval_const(elements[2], name_list, name_list2, nest)
      # return nil if( rhs == nil || lhs == nil )
      return nil if ! evaluable?( rhs, lhs )
      return lhs % rhs
    when :OP_ADD
      lhs = elements_eval_const(elements[1], name_list, name_list2, nest)
      rhs = elements_eval_const(elements[2], name_list, name_list2, nest)
      # return nil if( rhs == nil || lhs == nil )
      return nil if ! evaluable?( rhs, lhs )
      return lhs + rhs
    when :OP_SUB
      lhs = elements_eval_const(elements[1], name_list, name_list2, nest)
      rhs = elements_eval_const(elements[2], name_list, name_list2, nest)
      # return nil if( rhs == nil || lhs == nil )
      return nil if ! evaluable?( rhs, lhs )
      return lhs - rhs
    when :OP_LSFT
      lhs = elements_eval_const(elements[1], name_list, name_list2, nest)
      rhs = elements_eval_const(elements[2], name_list, name_list2, nest)
      # return nil if( rhs == nil || lhs == nil )
      return nil if ! evaluable?( rhs, lhs )
      return lhs << rhs
    when :OP_RSFT
      lhs = elements_eval_const(elements[1], name_list, name_list2, nest)
      rhs = elements_eval_const(elements[2], name_list, name_list2, nest)
      # return nil if( rhs == nil || lhs == nil )
      return nil if ! evaluable?( rhs, lhs )
      return lhs >> rhs
    when :OP_LT
      lhs = elements_eval_const(elements[1], name_list, name_list2, nest)
      rhs = elements_eval_const(elements[2], name_list, name_list2, nest)
      # return nil if( rhs == nil || lhs == nil )
      return nil if ! evaluable?( rhs, lhs )
      return lhs < rhs
    when :OP_GT
      lhs = elements_eval_const(elements[1], name_list, name_list2, nest)
      rhs = elements_eval_const(elements[2], name_list, name_list2, nest)
      # return nil if( rhs == nil || lhs == nil )
      return nil if ! evaluable?( rhs, lhs )
      return lhs > rhs
    when :OP_LE
      lhs = elements_eval_const(elements[1], name_list, name_list2, nest)
      rhs = elements_eval_const(elements[2], name_list, name_list2, nest)
      # return nil if( rhs == nil || lhs == nil )
      return nil if ! evaluable?( rhs, lhs )
      return lhs <= rhs
    when :OP_GE
      lhs = elements_eval_const(elements[1], name_list, name_list2, nest)
      rhs = elements_eval_const(elements[2], name_list, name_list2, nest)
      # return nil if( rhs == nil || lhs == nil )
      return nil if ! evaluable?( rhs, lhs )
      return lhs >= rhs
    when :OP_EQ
      lhs = elements_eval_const(elements[1], name_list, name_list2, nest)
      rhs = elements_eval_const(elements[2], name_list, name_list2, nest)
      # return nil if( rhs == nil || lhs == nil )
      return nil if ! evaluable?( rhs, lhs )
      return lhs.eq( rhs )
    when :OP_NE
      lhs = elements_eval_const(elements[1], name_list, name_list2, nest)
      rhs = elements_eval_const(elements[2], name_list, name_list2, nest)
      # return nil if( rhs == nil || lhs == nil )
      return nil if ! evaluable?( rhs, lhs )
      return lhs.neq( rhs )
    when :OP_AND
      lhs = elements_eval_const(elements[1], name_list, name_list2, nest)
      rhs = elements_eval_const(elements[2], name_list, name_list2, nest)
      # return nil if( rhs == nil || lhs == nil )
      return nil if ! evaluable?( rhs, lhs )
      return lhs & rhs
    when :OP_EOR
      lhs = elements_eval_const(elements[1], name_list, name_list2, nest)
      rhs = elements_eval_const(elements[2], name_list, name_list2, nest)
      # return nil if( rhs == nil || lhs == nil )
      return nil if ! evaluable?( rhs, lhs )
      return lhs ^ rhs
    when :OP_OR
      lhs = elements_eval_const(elements[1], name_list, name_list2, nest)
      rhs = elements_eval_const(elements[2], name_list, name_list2, nest)
      # return nil if( rhs == nil || lhs == nil )
      return nil if ! evaluable?( rhs, lhs )
      return lhs | rhs
    when :OP_LAND
      lhs = elements_eval_const(elements[1], name_list, name_list2, nest)
      rhs = elements_eval_const(elements[2], name_list, name_list2, nest)
      # return nil if( rhs == nil || lhs == nil )
      return nil if ! evaluable?( rhs, lhs )
      return lhs.lAND( rhs )
    when :OP_LOR
      lhs = elements_eval_const(elements[1], name_list, name_list2, nest)
      rhs = elements_eval_const(elements[2], name_list, name_list2, nest)
      # return nil if( rhs == nil || lhs == nil )
      return nil if ! evaluable?( rhs, lhs )
      return lhs.lOR( rhs )
    when :OP_CEX
      lhs = elements_eval_const(elements[1], name_list, name_list2, nest)
      mhs = elements_eval_const(elements[2], name_list, name_list2, nest)
      rhs = elements_eval_const(elements[3], name_list, name_list2, nest)
      # return nil if( rhs == nil || mhs == nil || lhs == nil )
      return nil if ! evaluable?( rhs, mhs, lhs )
      if lhs.cast( BoolType.new ).val then
          return mhs
      else
          return rhs
      end
    end
    return nil
  end

  def elements_get_type( elements, namedList )
    type = elements_get_type_sub( elements, namedList )
    # �֤��줿���� DefinedType �ξ�� ���η����֤�
    if type.kind_of?( DefinedType ) then
      type = type.get_type
    end
    return type
  end

  def elements_get_type_sub( elements, namedList )
    case elements[0]
    when :IDENTIFIER
      nsp = elements[1]
      if nsp.is_name_only? then
        paramdecl = namedList.get_item( nsp.get_name )
      else
        paramdecl = nil
      end
      unless paramdecl then
        cdl_error( "E1012 $1: not found in parameter list" , nsp.get_path_str )
        return IntType.new(32)        # dummy result
      end
      return paramdecl.get_type
# mikan get_type
#    when :INTEGER_CONSTANT
#    when :FLOATING_CONSTANT
#    when :OCTAL_CONSTANT
#    when :HEX_CONSTANT
#    when :CHARACTER_LITERAL
#    when :STRING_LITERAL_LIST
#    when :PARENTHESES
#    when :OP_SUBSC
#    when :OP_DOT
#    when :OP_REF
#    when :OP_SIZEOF_EXPR
#    when :OP_SIZEOF_TYPE
#    when :OP_U_AMP
    when :OP_U_ASTER
      type = elements_get_type( elements[1], namedList )
      unless type.kind_of?( PtrType ) then
        cdl_error( "E1013 \'*\': operand is not pointer value"  )
        return IntType.new( 8 )    # IntType ���֤��Ƥ���
      end
      return type.get_referto

    when :OP_U_PLUS, :OP_U_MINUS
      # mikan operand ��Ŭ�ڤʷ��������å����Ƥ��ʤ�
      return elements_get_type( elements[1], namedList )

    when :OP_ADD, :OP_SUB, :OP_MULT, :OP_DIV, :OP_REMAIN
      # mikan operand ��Ŭ�ڤʷ��������å����Ƥ��ʤ������դη�����Ѥ��Ƥ���
      return elements_get_type( elements[1], namedList )

    when :OP_U_TILDE
      # mikan operand �������������å����Ƥ��ʤ�
      return elements_get_type( elements[1], namedList )
    when :OP_AND, :OP_EOR, :OP_OR, :OP_LSFT, :OP_RSFT
      # mikan operand �������������å����Ƥ��ʤ�
      return BoolType.new
    when :OP_U_EXCLAM
      # mikan operand �������������å����Ƥ��ʤ�
      return BoolType.new

    when :OP_LT, :OP_GT, :OP_LE, :OP_GE, :OP_EQ, :OP_NE, :OP_LAND, :OP_LOR, :OP_CEX, :CAST
      cdl_error( "E1014 $1: elements_get_type: sorry not supported" , elements[0] )
    end

    return nil
  end

  # ���� size_is, count_is, string �ΰ����Ǥ�����������Υ����å�
  def elements_check_dir_for_param( elements, namedList, dir, spec )
   # dir �� ���ΰ���������
   # direct: size_is �ʤɤΰ������ѿ�������

    case elements[0]
    when :IDENTIFIER
      nsp = elements[1]
      if nsp.is_name_only? then
        paramdecl = namedList.get_item( nsp.get_name )
      else
        paramdecl = nil
      end

      return unless paramdecl      # if nil already error in element_get_type

      direct = paramdecl.get_direction
      judge = false
      case spec
      when "size_is", "string"
        case dir
        when :IN, :OUT, :INOUT, :SEND
          judge = true if ( direct == :IN || direct == :INOUT )
          req_direct = "in or inout"
        when :RECEIVE
          judge = true if ( direct == :OUT || direct == :INOUT )
          req_direct = "out or inout"
        end

      when "count_is"
        case dir
        when :IN, :SEND
          judge = true if ( direct == :IN || direct == :INOUT )
          req_direct = "in or inout"
        when :OUT, :RECEIVE     # mikan out �� count_is �Τ߻��ꤵ��Ƥ����� in �Ǥʤ��ƤϤʤ�ʤ�
          judge = true if ( direct == :OUT || direct == :INOUT )
          req_direct = "out or inout"
        when :INOUT
          judge = true if ( direct == :INOUT )
          req_direct = "inout"
        end
      end

      if judge == false then
        cdl_error( "E1015 \'$1\': direction mismatch for $2, $3 required" , nsp.get_path_str, spec, req_direct )
      end

    when :INTEGER_CONSTANT, :FLOATING_CONSTANT, :OCTAL_CONSTANT, :HEX_CONSTANT, :CHARACTER_LITERAL, :STRING_LITERAL_LIST
      return true

    # ñ��黻��
    when :OP_U_ASTER, :OP_SIZEOF_EXPR, :OP_SIZEOF_TYPE, :OP_U_PLUS, :OP_U_MINUS, :OP_U_TILDE, :OP_U_EXCLAM, :CAST, :OP_U_AMP, :PARENTHESES,
      elements_check_dir_for_param( elements[1], namedList, dir, spec )

    # 2��黻��
    when :OP_SUBSC, :OP_DOT, :OP_REF, :OP_MULT, :OP_DIV, :OP_REMAIN, :OP_ADD, :OP_SUB, :OP_LSFT, :OP_RSFT, :OP_LT, :OP_GT, :OP_LE, :OP_GE, :OP_EQ, :OP_NE, :OP_AND, :OP_EOR, :OP_OR, :OP_LAND, :OP_LOR
      return elements_check_dir_for_param( elements[1], namedList, dir, spec ) && elements_check_dir_for_param( elements[2], namedList, dir, spec )

    # 3��黻��
    when :OP_CEX
      return elements_check_dir_for_param( elements[1], namedList, dir, spec ) && elements_check_dir_for_param( elements[2], namedList, dir, spec ) && elements_check_dir_for_param( elements[3], namedList, dir, spec )

    else
      cdl_error( "E1016 $1: elements_check_dir_for_param: sorry not supported" , elements[0] )
    end

  end

  #Express# get_allocator_rhs_elem
  #alloc_type::Symbol  :NORMAL_ALLOC|:INTERNAL_ALLOC|:RELAY_ALLOC
  #����������������Ҥα��դȤ��������������å��������������ʬ�򤷤��ͤ��֤�
  #return:
  #  :NORMAL_ALLOC      [ cell_nsp, ep_name ]               # rhs = cell_nsp.ep_name    ex) Alloc.eAlloc
  #  :INTERNAL_ALLOC    [ ep_name ]                         # rhs = ep_name             ex) eAlloc
  #  :RELAY_ALLOC       [ cp_name, func_name, param_name ]  # rhs = cp_name.func_name.param_name
  def get_allocator_rhs_elements( alloc_type )
    ele = @elements
    case alloc_type 
    when :NORMAL_ALLOC
      if ele[0] != :OP_DOT || ele[1][0] != :IDENTIFIER then   #1
        cdl_error( "E9999 $1: rhs not \'Cell.ePort\' form" , to_s )
        return nil
      end
      cell_nsp  = elements[1][1]
      port_name = elements[2].val
      return [ cell_nsp, port_name ]
    when :INTERNAL_ALLOC
      if( ele[0] == :IDENTIFIER )then
        if ele[1].is_name_only? then
          return [ ele[1].get_path[0] ]  # mikan a::b
        else
          cdl_error( "E9999 $1: namespace cannot be specified", ele[1].to_s )
        end
      else
        cdl_error( "S1086 $1: rhs not in 'allocator_entry_port' form", ele[1].to_s )
      end
    when :RELAY_ALLOC
      if( ele[0] != :OP_DOT ||
          ele[1][0] != :OP_DOT || ele[1][1][0] != :IDENTIFIER || ! ele[1][1][1].is_name_only? ||
          ! ele[1][2].instance_of?( Token ) || ! ele[2].instance_of?( Token ) )then   #1
        cdl_error( "E9999 rhs not in 'call_port.func.param' form for for $1_$2" , ai[1], ai[2] )   # S1086
      end
      func_name = ele[1][2]; cp_name = ele[1][1][1].get_name; param_name = ele[2].to_sym
      return [ cp_name, func_name, param_name ]
    end
    return  nil
  end

  #Expression#Expression �Υ�������������
  def clone_for_composite
    cl = self.clone
    elements = clone_elements @elements
    cl.set_elements elements
    return cl
  end

  #Expression#elements �Υ���������
  #elements::Array
  # ���Υ᥽�åɤϡ�Array �Υǥ����ץ��ԡ���Ԥ�
  def clone_elements elements
    elements = elements.clone
    elements.map!{ |ele|
      if ele.instance_of? Array
        clone_elements ele
      else
        ele
      end
    }
    return elements
  end

  def set_elements elements
    @elements = elements
  end

  #=== Expression#������μ�����Ϥ���
  # Cell.eEntry  => [ :OP_DOT, [ :IDENTIFIER, token ], token ]
  # Cell[expression].eEntry [ :OP_SUBSC, [ :OP_DOT, [ :IDENTIFIER, token ], token ], expression ]
  # Return: [ NamespacePath(cell_name), Integer(subscript), Token(port_name)]
  def analyze_cell_join_expression
    # ���դ� Expression �����Ǥ���Ф�
    elements = @elements
    if elements[0] == :OP_SUBSC then  # ���ա�����������
      # elements = [ :OP_SUBSC, [ :OP_DOT, [ :IDENTIFIER, token ], token ], expression ]
      subscript = elements[2].eval_const(nil)  # �����������ź��
      elements  = elements[1]          # mikan ������ä����
    end

    # elements = [ :OP_DOT, [ :IDENTIFIER, token ], token ]
    if elements[0] != :OP_DOT || elements[1][0] != :IDENTIFIER then   #1
      return nil
    end

    nsp = elements[1][1]         # NamespacePath
    port_name = elements[2].val

    return [ nsp, subscript, port_name]
  end

  #=== Expression# ����ؤη��μ�����������
  #nsp:: NamespacePath
  #subscript:: Integer
  #port_name:: Symbol
  # analyze_cell_join_expression ���ФˤʤäƤ���
  def self.create_cell_join_expression( nsp, subscript, port_name )
    if ! port_name.instance_of?( Symbol ) then
      raise "port_name: not Symbol"
    end

    if subscript then
      elements = [ :OP_SUBSC, [ :OP_DOT, [ :IDENTIFIER, nsp ],
                                Token.new( port_name, nil, nil, nil ) ],
                   Expression.create_integer_constant( subscript, @locale ) ]
    else
      elements = [ :OP_DOT, [ :IDENTIFIER, nsp ], Token.new( port_name, nil, nil, nil ) ]
    end
    return Expression.new( elements )
  end

  #=== Expression#��������μ�����������
  #val:: Integer : �͡� ����
  def self.create_integer_constant( val, locale )
    if val != Integer( val ) || val < 0 then
      raise "create_integer_constant: not integer or negative: #{val}"
    end
    Expression.new( [ :INTEGER_CONSTANT, Token.new( val, nil, nil, nil ) ] )
  end

  #=== Expression#ñ��μ��̻Ҥμ�����Ϥ���
  # Identifier  => [ :IDENTIFIER, token ]
  # Return: NamespacePath(Identifier)
  def analyze_single_identifier
    # ���դ� Expression �����Ǥ���Ф�
    elements = @elements
    if elements[0] == :IDENTIFIER
      return elements[1]
    else
      return nil
    end
  end

  #=== Expression#
  #nsp:: NamespacePath :  ���Ȥ����μ��̻�
  def self.create_single_identifier( nsp, locale )
    if ! nsp.instance_of?( NamespacePath ) then
      raise "create_single_identifier: not NamespacePath: #{nsp.to_s}"
    end
    Expression.new( [ :IDENTIFIER, nsp ] )
  end

  #=== ɾ����ǽ�������å�����
  #*v:: ���Ѹİ�����Ǥ�դη���
  # ���٤Ƥ� BaseVal �λҥ��饹���͡ˤǤ���С�ɾ����ǽ��Ƚ�Ǥ���
  def evaluable?( *v )
    v.each{ |val|
      if ! val.kind_of?( BaseVal ) then
        return false
      end
    }
    return true
  end

  private :elements_to_s, :elements_eval_const,  :elements_get_type

end


class C_EXP < Node
# @c_exp_string : string

  #c_exp_string::String
  #b_renew::Bool  : true �ʤ� C_EXP �� clone �����ʥ��������׽������򤷤ʤ���
  def initialize( c_exp_string, b_renew = false )
    if b_renew then
      @c_exp_string = c_exp_string
    else
      # ����� " �������
      # str = c_exp_string.to_s.sub( /^\"(.*)\"$/, "\\1" )
      str = CDLString.remove_dquote c_exp_string.to_s
      @c_exp_string = CDLString.escape str
    end
  end

  #=== composite �Ѥ� C_EXP �� clone ����
  #ct_name::
  #cell_name::
  # composite �� attribute �˸���� C_EXP ��ʸ�����ִ������������ʤ�����
  # ����ʸ�����ִ��ϡ���̣����ʳ��ǹԤ���
  # ¾�� C_EXP ��ʸ�����ִ��ϡ������������ʳ��ǹԤ���
  def clone_for_composite( ct_name, cell_name, locale )
    dbgPrint "C_EXP: #{ct_name} #{cell_name} #{@c_exp_string}\n"

    @locale = locale
    str = @c_exp_string.gsub( /(^|[^\$])\$ct\$/, "\\1#{ct_name}" )
    str = str.          gsub( /(^|[^\$])\$cell\$/, "\\1#{cell_name}" )
    str = str.          gsub( /(^|[^\$])\$id\$/, "\\1#{ct_name}_#{cell_name}" )
    return C_EXP.new( str, true )
  end

  def get_c_exp_string
    @c_exp_string
  end

  #=== C_EXP ��ɾ������
  # C_EXP �ΰ�����ʸ������֤�
  # ���� C_EXP �� eval_const �����оݤǤϤʤ������ص��� eval_const ���б�
  def eval_const( name_list, name_list2 = nil )
     return self
  end
  def eval_const2( name_list, name_list2 = nil, nest = nil )
     return self
  end

  def to_s
    @c_exp_string
  end

  def to_CDL_str
    return "C_EXP( \"#{to_s}\" )"
  end

  def show_tree( indent )
    indent.times { print "  " }
    puts "C_EXP: #{@c_exp_string}"
  end
end

