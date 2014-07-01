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
#   $Id: bnf.y.rb 1941 2013-04-21 13:57:33Z okuma-top $
#++

class Generator
rule
# �ȥåץ�٥�ι�ʸ���Ǥ�component_description
all: component_description

# Expr
##########################  ��  ##########################
# K&R��ʸˡ(�ץ���ߥ󥰸���C ��2�� ��Ͽ)�Ȱ����ۤʤ�
# argument_expression_list(�ؿ�����), assignment_expression(����)���ʤ�
# ���� result �ϡ����٤������������Ǥ����̥���ܥ롢�������ǰʲ�������

primary_expression
        : namespace_identifier
		{ result = [ :IDENTIFIER, val[0] ] }     #1ok
        | TRUE
		{ result = [ :BOOL_CONSTANT, true ] }
        | FALSE
		{ result = [ :BOOL_CONSTANT, false ] }
        | INTEGER_CONSTANT
		{ result = [ :INTEGER_CONSTANT, val[0] ] }
        | FLOATING_CONSTANT
		{ result = [ :FLOATING_CONSTANT, val[0] ] }
        | OCTAL_CONSTANT
		{ result = [ :OCTAL_CONSTANT, val[0] ] }
        | HEX_CONSTANT
		{ result = [ :HEX_CONSTANT, val[0] ] }
        | CHARACTER_LITERAL
		{ result = [ :CHARACTER_LITERAL, val[0] ] }
        | string_literal_list
		{ result = [ :STRING_LITERAL_LIST, val[0] ] }
        | '(' expression ')'
		{ result = [ :PARENTHESES, val[1].get_elements ] }

string_literal_list
        : STRING_LITERAL
        | string_literal_list STRING_LITERAL
		{
			# Ϣ�ܤ���ʸ�����1�Ĥ�ʸ����ˤޤȤ��
			str = "\"" + val[0].val.gsub( /\"(.*)\"/, "\\1" ) + val[1].val.gsub( /\"(.*)\"/, "\\1" ) + "\""
			result = Token.new( str, val[0].file, val[0].lineno, val[0].col )
		}

# �ؿ��ƤӽФ��ȸ��֥��󥯥���ȡ��ǥ�����ȱ黻�Ҥ��ʤ�
postfix_expression
        : primary_expression
        | postfix_expression '[' expression ']'
		{ result = [ :OP_SUBSC, val[0], val[2] ] }
        | postfix_expression '.' IDENTIFIER
		{ result = [ :OP_DOT, val[0], val[2] ] }
        | postfix_expression '->' IDENTIFIER
		{ result = [ :OP_REF, val[0], val[2] ] }

# ���֥��󥯥���ȡ��ǥ�����ȱ黻�Ҥ��ʤ�
unary_expression
        : postfix_expression
        | unary_operator cast_expression
		{ result = [ val[0], val[1] ] }
        | SIZEOF unary_expression
		{ result = [ :OP_SIZEOF_EXPR, val[1] ] }
        | SIZEOF '(' type_name ')'
		{ result = [ :OP_SIZEOF_TYPE, val[1] ] }

unary_operator
        : '&'	{ result = :OP_U_AMP }
        | '*'	{ result = :OP_U_ASTER }
        | '+'	{ result = :OP_U_PLUS }
        | '-'	{ result = :OP_U_MINUS }
        | '~'	{ result = :OP_U_TILDE }
        | '!'	{ result = :OP_U_EXCLAM }

cast_expression
        : unary_expression
        | '(' type_name ')' cast_expression
		{  result = [ :CAST, val[1], val[3] ] }

multiplicative_expression
        : cast_expression
        | multiplicative_expression '*' cast_expression
		{ result = [ :OP_MULT, val[0], val[2] ]  }
        | multiplicative_expression '/' cast_expression
		{ result = [ :OP_DIV, val[0], val[2] ]  }
        | multiplicative_expression '%' cast_expression
		{ result = [ :OP_REMAIN, val[0], val[2] ]  }

additive_expression
        : multiplicative_expression
        | additive_expression '+' multiplicative_expression
		{ result = [ :OP_ADD, val[0], val[2] ]  }
        | additive_expression '-' multiplicative_expression
		{ result = [ :OP_SUB, val[0], val[2] ]  }

shift_expression
        : additive_expression
        | shift_expression '<<' additive_expression
		{ result = [ :OP_LSFT, val[0], val[2] ]  }
        | shift_expression '>>' additive_expression
		{ result = [ :OP_RSFT, val[0], val[2] ]  }

relational_expression
        : shift_expression
        | relational_expression '<' shift_expression
		{ result = [ :OP_LT, val[0], val[2] ]  }
        | relational_expression '>' shift_expression
		{ result = [ :OP_GT, val[0], val[2] ]  }
        | relational_expression '<=' shift_expression
		{ result = [ :OP_LE, val[0], val[2] ]  }
        | relational_expression '>=' shift_expression
		{ result = [ :OP_GE, val[0], val[2] ]  }

equality_expression
        : relational_expression
        | equality_expression '==' relational_expression
		{ result = [ :OP_EQ, val[0], val[2] ]  }
        | equality_expression '!=' relational_expression
		{ result = [ :OP_NE, val[0], val[2] ]  }

and_expression
        : equality_expression
        | and_expression '&' equality_expression
		{ result = [ :OP_AND, val[0], val[2] ]  }

exclusive_or_expression
        : and_expression
        | exclusive_or_expression '^' and_expression
		{ result = [ :OP_EOR, val[0], val[2] ]  }

inclusive_or_expression
        : exclusive_or_expression
        | inclusive_or_expression '|' exclusive_or_expression
		{ result = [ :OP_OR, val[0], val[2] ]  }

logical_and_expression
        : inclusive_or_expression
        | logical_and_expression '&&' inclusive_or_expression
		{ result = [ :OP_LAND, val[0], val[2] ]  }

logical_or_expression
        : logical_and_expression
        | logical_or_expression '||' logical_and_expression
		{ result = [ :OP_LOR, val[0], val[2] ]  }

conditional_expression
        : logical_or_expression
        | logical_or_expression '?' expression ':' conditional_expression
		{ result = [ :OP_CEX, val[0], val[2].get_elements, val[4] ]  }


# ����ޱ黻�Ҥ��Ȥ��ʤ�
expression
        : conditional_expression
		{
			result = Expression.new( val[0] )
			# result.print
		}

constant_expression
        : conditional_expression
		{
			result = Expression.new( val[0] )
			# result.print

			# res = result.eval_const( nil )
			# if res then
			#   puts "val: #{res}"
			# else
			#   puts "val: nil"
			# end
		}



# Types
##########################  ���  ##########################
# �����K&R�Ȱ����ۤʤ�

# declaration�ϥ����°���ǻȤ���
# K&R�Ȥΰ㤤: storage class������Ǥ��ʤ���������ά�Ǥ��ʤ�
declaration
        : type_specifier_qualifier_list init_declarator_list ';'
		{
			val[1].each { |i|	# i: Decl
				i.set_type( val[0] )
			}
			result = val[1]
		}

# declaration_specifiers�ϴؿ��Υѥ�᡼���ǻȤ��뤬��
# type_specifier_qualifier_list�ǽ�ʬ���⤷��ʤ�
# Oyama
# const, volatile ��ñ�ȤǷ��ˤʤ�ʤ��Τ��ѷ�
# const �� volatile ��Ʊ�魯�뤳�ȤϤʤ��Τǡ����֤�����Ǥ��ʤ��褦�ˤ���
# type_specifier �ⷫ�֤�����Ǥ���ɬ�פϤʤ� (singed �ʤ�ñ�ȤǷ��ˤϤʤ�ʤ�)
declaration_specifiers
        : type_specifier
        | type_qualifier type_specifier
		{
			val[1].set_qualifier( val[0] )
			result = val[1]
		}

init_declarator_list
        : init_declarator
		{ result = [val[0]] }
        | init_declarator_list ',' init_declarator
		{ result << val[2] }

init_declarator
        : declarator
        | declarator '=' initializer
		{ val[0].set_initializer( val[2] ) }

# INT8���鲼��K&R�ˤʤ�
# Oyama
# signed, unsigned ��ñ�ȤǷ��ˤʤ�ʤ��Τǡ���ʸ���ǤȤ���ʬΥ
type_specifier
        : VOID	{ result = VoidType.new }
        | FLOAT32_T	{ result = FloatType.new(32) }
        | DOUBLE64_T	{ result = FloatType.new(64) }
        | struct_specifier
        | enum_specifier
        | TYPE_NAME	{ result = DefinedType.new( val[0].val ) }
#        | IDENTIFIER	{ result = DefinedType.new( val[0].val ) }   # reduce/reduce conflict �������äƤ��ޤ�
        | sign_int_type
        | char_type
        | BOOL_T	{ result = BoolType.new }
#        | BOOL	{
#			Generator.warning( "W5001 bool: obsolete type. use bool_t"  )
#			result = BoolType.new
#		}
        | FLOAT	{
			Generator.warning( "W5002 float: obsolete type. use float32_t"  )
			result = FloatType.new(32)
		}
        | DOUBLE {
			Generator.warning( "W5003 double: obsolete type. use double64_t"  )
			result = FloatType.new(64)
		}

char_type
        : CHAR_T	{ result = IntType.new( -1 ) }
        | SCHAR_T
		{
			result = IntType.new( -1 )
			result.set_sign( :SIGNED, true )
		}
        | UCHAR_T
		{
			result = IntType.new( -1 )
			result.set_sign( :UNSIGNED, true )
		}

int_type
        : CHAR	{
			# Generator.warning( "W5004 char: obsolete type. use char_t"  )
			result = IntType.new( -11 )
		}
        | SHORT	{ result = IntType.new( -2 ) }
        | INT		{ result = IntType.new( -3 ) }
        | LONG	{ result = IntType.new( -4 ) }
#        | INTPTR	{ result = IntType.new( -5 ) }
        | INT8	{
			Generator.warning( "W5005 int8: obsolete. use int8_t"  )
			result = IntType.new(  8 )
		}
        | INT16	{
			Generator.warning( "W5006 int16: obsolete. use int16_t"  )
			result = IntType.new( 16 )
		}
        | INT32	{
			Generator.warning( "W5007 int32: obsolete. use int32_t"  )
			result = IntType.new( 32 )
		}
        | INT64
		{
			Generator.warning( "W5008 int64: obsolete. use int64_t"  )
			result = IntType.new( 64 )
		}
        | INT128
		{
			Generator.warning( "W5009 int64: obsolete. use int64_t"  )
			result = IntType.new( 128 )
		}
        | INT8_T	{ result = IntType.new( 8 ) }
        | INT16_T	{ result = IntType.new( 16 ) }
        | INT32_T	{ result = IntType.new( 32 ) }
        | INT64_T	{ result = IntType.new( 64 ) }
        | INT128_T	{ result = IntType.new( 128 ) }
        | UINT8_T
		{
			result = IntType.new( 8 )
			result.set_sign( :UNSIGNED, true )
		}
        | UINT16_T
		{
			result = IntType.new( 16 )
			result.set_sign( :UNSIGNED, true )
		}
        | UINT32_T
		{
			result = IntType.new( 32 )
			result.set_sign( :UNSIGNED, true )
		}
        | UINT64_T
		{
			result = IntType.new( 64 )
			result.set_sign( :UNSIGNED, true )
		}
        | UINT128_T
		{
			result = IntType.new( 128 )
			result.set_sign( :UNSIGNED, true )
		}

sign    # TECS �Ǥ� signed, unsigned ñ�ȤǤϷ��ˤǤ��ʤ�
        : SIGNED	{ result = :SIGNED }
        | UNSIGNED	{ result = :UNSIGNED }

# result[0] :CHAR �ʤɤΥȡ�����result[1] :CONST, :VOLATILE �ʤ�
sign_int_type
        : sign int_type
		{
			val[1].set_sign( val[0] )
			result = val[1]
		}
        | int_type

# K&R��struct_or_union_specifier���������뤬��union�ϻȤ��ʤ�
struct_specifier		# mikan
        : STRUCT struct_tag '{'
		{ StructType.set_define( true )  }
	   struct_declaration_list '}'
		{
			StructType.end_of_parse
			result = val[1]
		}
        | STRUCT
		{
			# tag ��̵����硢����̾��Ϳ����
			result = StructType.new( :"$TAG_#{@@no_struct_tag_num}" )
			@@no_struct_tag_num += 1
			StructType.set_define( true )
		}
	   '{' struct_declaration_list '}'
		{
			StructType.end_of_parse
			result = val[1]
		}
        | STRUCT struct_tag   # mikan struct_tag �� namespace �б���ɬ��
		{
			StructType.set_define( false )
			StructType.end_of_parse
			result = val[1]
		}

struct_declaration_list
        : struct_declaration
        | struct_declaration_list struct_declaration

struct_tag:
	IDENTIFIER
		{ result = StructType.new( val[0].val ) }

# �ݥ��󥿽����Ҥ��ɲ�
struct_declaration
        :                                type_specifier_qualifier_list struct_declarator_list ';'
		{
			val[1].each { |i|	# i: Decl
				i.set_type( val[0] )
				i.set_kind( :MEMBER )
				i.check
				StructType.new_member( i )
			}
			result = val[1]
		}
        | spec_L pointer_specifier_list spec_R type_specifier_qualifier_list struct_declarator_list ';'
		{
			val[4].each { |i|	# i: Decl
				i.set_type( val[3] )
				i.set_kind( :MEMBER )
  				i.set_specifier_list val[1]
				i.check
				StructType.new_member( i )
			}
			result = val[4]
		}

pointer_specifier_list
        : pointer_specifier                               { result = [ val[0] ] }
        | pointer_specifier_list ',' pointer_specifier    { result <<  val[2] }

pointer_specifier
        : STRING				{ result = [:STRING,-1] }
        | STRING   '(' expression ')'	{ result = [:STRING,val[2]] }
        | SIZE_IS  '(' expression ')'	{ result = [:SIZE_IS,val[2]] }
        | COUNT_IS '(' expression ')'	{ result = [:COUNT_IS,val[2]] }


# K&R��specifier_qualifier_list��Ʊ��
# ̾�����ޤ���路���ä��Τ�type_���դ���
type_specifier_qualifier_list
# Oyama type_specifier �򷫤��֤��ƻ��ꤹ�뤳�ȤϤʤ��ʤä� (sign_int_type �Ȥ��������
#        : type_specifier type_specifier_qualifier_list
        : type_specifier
        | type_qualifier type_specifier_qualifier_list
		{
			val[1].set_qualifier( val[0] )
			result = val[1]
		}
# mikan Oyama type_qualifier �����ǤϷ�����ˤʤ�ʤ� : ��ʸ���顼�Ȥ����ꡢ��̣���顼�Ȥ�����������
#        | type_qualifier


struct_declarator_list
        : struct_declarator
		{ result = [ val[0] ] }
        | struct_declarator_list ',' struct_declarator
		{ result << val[2] }

# �ӥåȥե�����ɤϻȤ��ʤ�
struct_declarator
        : declarator

# enum�μ�����ɲ�
enum_specifier		# mikan
        : enum_type            '{' enumerator_list '}'
        | enum_type IDENTIFIER '{' enumerator_list '}'
        | enum_type IDENTIFIER

enum_type
        : ENUM	{ result = EnumType.new( -1 ) }
        | ENUM8	{ result = EnumType.new( 8 ) }
        | ENUM16	{ result = EnumType.new( 16 ) }
        | ENUM32	{ result = EnumType.new( 32 ) }
        | ENUM64	{ result = EnumType.new( 64 ) }
        | ENUM128	{ result = EnumType.new( 128 ) }

enumerator_list
        : enumerator
        | enumerator_list ',' enumerator

enumerator
        : IDENTIFIER
        | IDENTIFIER '=' constant_expression

type_qualifier
        : CONST	{ result = :CONST }
        | VOLATILE	{ result = :VOLATILE }

declarator
        : pointer direct_declarator
		{
			val[1].set_type( val[0] )
			result = val[1]
		}
        | direct_declarator

direct_declarator		# mikan
        : IDENTIFIER
		{ result = Decl.new( val[0].val ) }
        | '(' declarator ')'
		{ result = val[1] }
        | direct_declarator '[' constant_expression ']'
		{
			val[0].set_type( ArrayType.new( val[2] ) )
			result = val[0]
		}
        | direct_declarator '[' ']'
		{
			val[0].set_type( ArrayType.new )
			result = val[0]
		}
        | direct_declarator '(' parameter_type_list ')'
		{
			val[0].set_type( FuncType.new( val[2] ) )
			result = val[0]
		}
#        | direct_declarator '(' identifier_list ')'  # ����ϲ��Τ����ɬ�ס� 060211
        | direct_declarator '(' ')'
		{
			Generator.warning( "W5010 need 'void' for no parameter"  )
			val[0].set_type( FuncType.new )
			result = val[0]
		}

pointer
        : '*'
		{ result = PtrType.new }
        | '*' type_qualifier
		{
			result = PtrType.new
			result.set_qualifier( val[1] )
		}
        | '*' pointer
		{
			val[1].set_type(PtrType.new)
			result = val[1]
		}
        | '*' type_qualifier pointer
		{
			ptrtype = PtrType.new
			ptrtype.set_qualifier( val[1] )
			val[2].set_type( ptrtype )
			result = val[2]
		}


parameter_type_list
        : parameter_list
        | parameter_list ',' '...'
		# mikan ����Ĺ�ѥ�᡼��

parameter_list
        : parameter_declaration
		{ result = ParamList.new( val[0] ) }
        | parameter_list ',' parameter_declaration
		{
			val[0].add_param( val[2] )
			# result = val[0] ����
		}


# �ѥ�᡼�������Ҥ��ɲ�
parameter_declaration
#        : spec_L parameter_specifier_list spec_R declaration_specifiers declarator
        : parameter_specifier_list_bracket declaration_specifiers  declarator
		{
			val[2].set_kind( :PARAMETER )
			paramdecl = ParamDecl.new( val[2], val[1], val[0] )
			val[2].check
			result = paramdecl
		}

	# �ʲ��ϥ��顼�Ȥ���
        | declaration_specifiers declarator # parameter_specifier �ʤ��ϰ���ʤ�
		{
			Generator.error( "G1001 need specifier for \'$1\'" , val[1].get_name )
			result = nil
		}
        | declaration_specifiers	# �������ʤ��ϡ��Ȥꤢ��������ʤ� 060210
		{
			unless val[0].instance_of?( VoidType ) then
				Generator.error( "G1002 need parameter name"  )
			end
			result = nil
		}
#        | '[' parameter_specifier_list ']' declaration_specifiers # Ʊ 060210
        | parameter_specifier_list_bracket declaration_specifiers # Ʊ 060210
		{
			unless val[1].instance_of?( VoidType ) then
				Generator.error( "G1003 need parameter name"  )
			end
			result = nil
		}

parameter_specifier_list_bracket
        :  spec_L parameter_specifier_list spec_R { result = val[1] }
#        :  '[' parameter_specifier_list  ']'  { result = val[1] }

parameter_specifier_list
        : parameter_specifier	{ result = val[0] }
        | parameter_specifier_list ',' parameter_specifier
		{ result = result + val[2] }

parameter_specifier
        : IN					{ result = [ [:IN]  ] }
        | OUT					{ result = [ [:OUT] ] }
        | INOUT					{ result = [ [:INOUT] ] }
        | SEND     '(' namespace_identifier ')'	{ result = [ [:SEND,   val[2]] ] }   #1ok allocator
        | RECEIVE  '(' namespace_identifier ')'	{ result = [ [:RECEIVE,val[2]] ] }   #1ok allocator
        | STRING				{ result = [ [:STRING,nil] ] }
        | STRING   '(' expression ')'	{ result = [ [:STRING,  val[2]] ] }
        | SIZE_IS  '(' expression ')'	{ result = [ [:SIZE_IS, val[2]] ] }
        | SIZE_IS  '(' expression ',' constant_expression ')'
		{
			result = [ [:SIZE_IS,val[2]], [:MAX_IS, val[4]] ]
		}
        | COUNT_IS '(' expression ')'	{ result = [ [:COUNT_IS,val[2]] ] }
        | NULLABLE		{ result = [ [:NULLABLE] ] }

#identifier_list       # 060211  ���Ѥˤʤä�
#        : IDENTIFIER
#        | identifier_list ',' IDENTIFIER

type_name
        : type_specifier_qualifier_list
        | type_specifier_qualifier_list abstract_declarator
		{
			if val[1] then
				val[1].set_type( val[0] )
				result = val[1]
			else
				# ���顼������ val[0] ���֤�
				result = val[0]
			end
		}
		# mikan abstract_declarator �� pointer �ʳ��ǤϤ��ޤ�ư���ʤ����Ȥꤢ���� '*' CAST �Τߵߤä�

abstract_declarator		# mikan
        : pointer
        | direct_abstract_declarator
        | pointer direct_abstract_declarator

direct_abstract_declarator
        : '(' abstract_declarator ')'
		{ result = val[1] }  # �ؿ��ݥ��󥿷���ߤ�
        | '[' ']'
		{
			Generator.error( "G1004 impossible array type"  )
			result = nil
		}
        | '[' constant_expression ']'
		{
			Generator.error( "G1005 impossible array type"  )
			result = nil
		}
        | direct_abstract_declarator '[' ']'
		{
			Generator.error( "G1006 impossible array type"  )
			result = nil
		}
        | direct_abstract_declarator '[' constant_expression ']'
		{
			Generator.error( "G1007 impossible array type"  )
			result = nil
		}
        | '(' ')'
		{
			Generator.error( "G1008 impossible function type"  )
			result = nil
		}
        | '(' parameter_type_list ')'
        | direct_abstract_declarator '(' ')'
		{
			Generator.warning( "W5011 need 'void' for no parameter"  )
			val[0].set_type( FuncType.new )
			result = val[0]
		}
        | direct_abstract_declarator '(' parameter_type_list ')'
		{
			val[0].set_type( FuncType.new( val[2] ) )
			result = val[0]
		}

# assignment_expression��constant_expression���ѹ�
initializer			# mikan
        : constant_expression
		{ result = val[0] }
        | '{' initializer_list '}'
		{ result = val[1] }
        | '{' initializer_list ',' '}'
		{ result = val[1] }
#        | C_EXP '(' STRING_LITERAL ')'
        | C_EXP '(' string_literal_list ')'
		{ result = C_EXP.new( val[2] ) }

initializer_list
        : initializer
		{
			result = [ val[0] ]
		}
        | initializer_list ',' initializer
		{
			val[0] << val[2]
			result = val[0]
		}


##########################  ���������CDL�ȼ�  ##########################

#�ȥåץ�٥�ι�ʸ��§
#����ݡ��ͥ�ȵ���
component_description
        :
        | component_description specified_statement

specified_statement
        : statement
        | spec_L statement_specifier_list spec_R statement
		{
			obj = val[3]
			if obj.kind_of?( Cell ) || obj.kind_of?( Signature ) || obj.kind_of?( Celltype ) || obj.kind_of?( CompositeCelltype )then
                                # cell, signature �ʳ��ϡ�����Ҥ��֤��ʤ�
			else
              Generator.get_statement_specifier   # ���ꥢ
              Generator.error( "G1009 unexpected specifier"  )
			end
		}
		# �����Ʊ�����Ҥ� composite_celltype �ˤ⤢��

statement
        : typedef
        | const_statement
        | namespace
        | signature
        | celltype
        | cell
        | composite_celltype
        | enum_specifier ';'
        | struct_specifier ';'
        | region
        | import
        | import_C
        | signature_plugin
        | error   # ���顼�����ݥ����

	
statement_specifier_list
        : statement_specifier
		{ Generator.add_statement_specifier val[0]	}
        | statement_specifier_list ',' statement_specifier
		{ Generator.add_statement_specifier val[2] }

statement_specifier
        : ALLOCATOR '(' alloc_list ')'                       # cell
		{ result = [ :ALLOCATOR, val[2] ] }
        | CONTEXT '(' string_literal_list ')'                # signature
		{ result = [ :CONTEXT, val[2].val ] }
        | DEVIATE                                            # signature
		{ result = [ :DEVIATE ] }
        | ID '(' constant_expression ')'                     # cell
		{ result = [ :ID, val[2] ] }
        | SINGLETON  { result = [:SINGLETON] }               # celltype, composite
        | IDX_IS_ID  { result = [:IDX_IS_ID] }               # celltype, composite
        | ACTIVE     { result = [:ACTIVE] }                  # celltype, composite
#        | GENERATE '(' plugin_name ',' STRING_LITERAL  ')'   # celltype, cell
        | GENERATE '(' plugin_name ',' plugin_arg  ')'   # celltype, cell
		{ result = [:GENERATE, val[2].val, val[4].val] }

alloc_list
        : alloc			{ result = [ val[0] ] }
        | alloc_list ',' alloc	{ result << val[2] }

alloc
        : IDENTIFIER '.' IDENTIFIER '.' IDENTIFIER '=' initializer
		{  result = [ :NORMAL_ALLOC, val[0], nil, val[2], val[4], val[6] ] }
        | IDENTIFIER '[' constant_expression ']' '.' IDENTIFIER '.' IDENTIFIER '=' initializer
		{  result = [ :NORMAL_ALLOC, val[0], val[2], val[5], val[7], val[9] ] }
#        | IDENTIFIER '.' IDENTIFIER '.' '*'        '=' initializer
#		{  result = [ val[0], val[ ], val[ ], val[ ] ] }
#        | IDENTIFIER '.' '*' '.' '*'               '=' initializer
#		{  result = [ val[0], val[ ], val[ ], val[ ] ] }

const_statement
        : declaration   # ������
		{
			val[0].each { |decl|
				decl.set_kind( :CONSTANT )
				Namespace.new_const_decl( decl )
				decl.check
			}
		}

import_C
        : IMPORT_C '(' STRING_LITERAL ')' ';'
		{
			@@import_C = true
			Import_C.new( val[2] )
			@@import_C = false
		}
        | IMPORT_C '(' STRING_LITERAL ',' STRING_LITERAL ')' ';'
		{
			@@import_C = true
			Import_C.new( val[2], val[4] )
			@@import_C = false
		}

import
        : IMPORT '(' STRING_LITERAL ')' ';'
		{ Import.new( val[2] ) }
        | IMPORT '(' AB_STRING_LITERAL ')' ';'
		{ Import.new( val[2], true ) }

signature_plugin
#        : GENERATE '(' plugin_name ',' namespace_identifier ',' STRING_LITERAL ')' ';'  #1ok signature plugin
        : GENERATE '(' plugin_name ',' namespace_identifier ',' plugin_arg ')' ';'  #1ok signature plugin
		{ Generate.new( val[2].val, val[4], val[6] ) }

typedef
        : TYPEDEF type_specifier_qualifier_list declarator_list ';'
		{
			val[2].each{ |i|       # i:Decl
				i.set_kind( :TYPEDEF )
    		}
			Typedef.new_decl_list( val[1], val[2] )
			val[2].each{ |i|       # i:Decl
				i.check
			}
		}
        | TYPEDEF '[' typedef_specifier ']' type_specifier_qualifier_list declarator_list ';'
		{
			val[5].each{ |i|       # i:Decl
				i.set_kind( :TYPEDEF )
			}
			Typedef.new_decl_list( val[4], val[5] )
			val[5].each{ |i|       # i:Decl
				i.check
			}
		}
		# mikan   typedef_specifier ̤����


typedef_specifier
        : STRING
        | STRING '(' expression ')'

declarator_list
        : declarator
		{ result = [ val[0] ] }
        | declarator_list ',' declarator
		{ result << val[2] }

namespace
        : NAMESPACE namespace_name '{' statement_list '}' ';'
		{val[1].end_of_parse}

namespace_name
        : IDENTIFIER
		{result = Namespace.new(val[0].val)}
		# namespace ���󥹥��󥹤� statement �򵭲������뤿�ᤳ��������

statement_list
        : specified_statement
        | statement_list specified_statement

namespace_identifier
        : IDENTIFIER		{ result = NamespacePath.new( val[0].val, false ) }
        | '::' IDENTIFIER	{ result = NamespacePath.new( val[1].val, true ) }
        | namespace_identifier '::' IDENTIFIER
		{ result = val[0].append!( val[2].val ) }

#�����˥���
signature
        : SIGNATURE signature_name '{' function_head_list '}' ';'
		{ result = val[1].end_of_parse( val[3] ) }

signature_name
        : IDENTIFIER
		{result = Signature.new( val[0].val ) }

function_head_list     # result:  function_head ������
        : function_head
		{ result = NamedList.new( val[0], "function" ) }
        | function_head_list function_head
		{ result = val[0].add_item( val[1] ) }

function_head
        :               type_specifier_qualifier_list declarator ';'
		{
			# val[1]: Decl
			if val[1].is_function? then
				result = FuncHead.new( val[1], val[0], false )
				val[1].set_kind :FUNCHEAD
				val[1].check
			else
				# mikan �ؿ��������ʲ��Υ�å������ˤʤ�
				Generator.error( "G1010 Not function"  )
				result = nil
			end
		}
        | spec_L ONEWAY spec_R type_specifier_qualifier_list declarator ';'
		{
			if val[4].is_function? then
				result = FuncHead.new( val[4], val[3], true )
			else
				Generator.error( "G1011 Not function"  )
				result = nil
			end
		}


#���륿����
celltype
        : CELLTYPE celltype_name '{' celltype_statement_list '}' ';'
		{
			val[1].end_of_parse
			result = val[1]
		}
#        | spec_L celltype_specifier_list spec_R CELLTYPE celltype_name '{' celltype_statement_list '}' ';'
#		{
#			val[4].set_specifier( val[1] )
#			val[4].end_of_parse
#		}

celltype_name
        : IDENTIFIER
		{ result = Celltype.new(val[0].val) }

#celltype_specifier_list
#        : celltype_specifier
#		{ result = [val[0]] }
#        | celltype_specifier_list ',' celltype_specifier
#		{ result << val[2] }

#celltype_specifier
#        : SINGLETON  { result = [:SINGLETON] }
#        | IDX_IS_ID  { result = [:IDX_IS_ID] }
#        | ACTIVE     { result = [:ACTIVE] }
#        | GENERATE '(' plugin_name ',' STRING_LITERAL  ')'
#		{ result = [:GENERATE, val[2].val, val[4].val] }

celltype_statement_list
        : specified_celltype_statement
        | celltype_statement_list specified_celltype_statement

specified_celltype_statement
        : celltype_statement
		{
			if val[0].kind_of? Port then
				Celltype.new_port( val[0] )
			end
		}
        | spec_L celltype_statement_specifier_list spec_R celltype_statement
		{
			if val[3].kind_of? Port then
				val[3].set_specifier val[1]  # ����������
				Celltype.new_port( val[3] )
			else
				# Port �ʳ��Ǥϻ���Ҥϥ��顼
				Generator.error( "G1012 $1 : cannot put specifier here" , val[1] )
			end
		}

celltype_statement
        : port
        | attribute
        | var
        | require
        | factory
#        | error       # ���顼�����ݥ����  (#513 ̵�¥롼�פ˴٤륱����������Τǡ������ǤΥ��顼�����ϼ����)

celltype_statement_specifier_list
        : celltype_statement_specifier
		{ result = [ val[0] ] }
        | celltype_statement_specifier_list ',' celltype_statement_specifier
		{ result << val[2] }

celltype_statement_specifier
        : INLINE { result = [ :INLINE ] }
        | ALLOCATOR '(' alloc_list2 ')'    { result = [ :ALLOCATOR, val[2] ] }
        | OPTIONAL { result = [ :OPTIONAL ] }

alloc_list2
        : alloc2			{ result = [ val[0] ] }    # �������Υ�����������
        | alloc				{ result = [ val[0] ] }    # ��������Υ�����������
        | alloc_list2 ',' alloc2	{ result << val[2] }
        | alloc_list2 ',' alloc		{ result << val[2] }

alloc2
        : IDENTIFIER '.' IDENTIFIER '=' initializer    # ������������ (�ǥХɥ������������)����
		{  result = [ :INTERNAL_ALLOC, val[0].val, val[2].val, val[4] ] }
        | IDENTIFIER '.' IDENTIFIER '<=' initializer   # ¿�ʥ�졼��ǥ����������������
		{  result = [ :RELAY_ALLOC, val[0].val, val[2].val, val[4] ] }


#�ƤӸ���������
port
        : port_type namespace_signature_name port_name ';'
		{ result = Port.new( val[2].val, val[1], val[0] ) }
        | port_type namespace_signature_name port_name '[' ']' ';'
		{ result = Port.new( val[2].val, val[1], val[0], "[]" ) }
        | port_type namespace_signature_name port_name '[' array_size ']' ';'
		{ result = Port.new(val[2].val, val[1], val[0], val[4]) }
        | port_type namespace_signature_name port_name '<=' namespace_identifier '.' IDENTIFIER ';'    #1ok reverse require
		{ result = Port.new( val[2].val, val[1], val[0], nil, val[4], val[ 6 ].val ) }

port_type
        : CALL	{ result = :CALL }
        | ENTRY	{ result = :ENTRY }

namespace_signature_name
        : namespace_identifier  #1ok
		{ result = val[0] }

port_name
        : IDENTIFIER

array_size
        : constant_expression


#°��
attribute
        : ATTRIBUTE '{' attribute_declaration_list '}' ';'
		{ result = nil }

attribute_declaration_list
        : attribute_declaration
		{ Celltype.new_attribute( val[0] ) }
        | attribute_declaration_list attribute_declaration
		{ Celltype.new_attribute( val[1] ) }


attribute_declaration
        :                             declaration
		{
			val[0].each{ |i|       # i:Decl
				i.set_kind( :ATTRIBUTE )
				i.check
			}
			result = val[0]
		}
        | spec_L attribute_specifier spec_R declaration
		{
			val[3].each{ |i|       # i:Decl
				i.set_kind( :ATTRIBUTE )   # ����������
				i.set_specifier_list( [val[1]] )
				i.check
			}
			result = val[3]
		}

attribute_specifier
        : OMIT     { result = [:OMIT] }
        | SIZE_IS  '(' expression ')'	{ result = [:SIZE_IS,val[2]] }


#�����ѿ�
var
        : VAR '{' var_declaration_list '}' ';'
		{ result = nil }

var_declaration_list
        : var_declaration
   		{ Celltype.new_var( val[0] ) }
        | var_declaration_list var_declaration
   		{ Celltype.new_var( val[1] ) }

var_declaration
        : declaration
		{
			val[0].each{ |i|       # i:Decl
				i.set_kind( :VAR )
				i.check
			}
		}
        | spec_L var_specifier spec_R declaration
		{
			val[3].each{ |i|       # i:Decl
				i.set_kind( :VAR )   # ����������
				i.set_specifier_list( [val[1]] )
				i.check
			}
			result = val[3]
		}

var_specifier
        : SIZE_IS  '(' expression ')'	{ result = [:SIZE_IS,val[2]] }


require
        : REQUIRE namespace_identifier '.' IDENTIFIER';'                            # mikan namespace #1
		{
			Celltype.new_require( val[1], val[3] )
		}
        | REQUIRE IDENTIFIER '=' namespace_identifier '.' IDENTIFIER';'             #1
		{
			Celltype.new_require( val[3], val[5], val[1].val )
		}

#�ե����ȥ�
factory
        : factory_head '{' factory_function_list '}' ';'

factory_head
        : FACTORY     { Factory.set_f_celltype( false ) }
        | CTFACTORY   { Factory.set_f_celltype( true ) }

factory_function_list
        :                                         # ��
        | factory_function_list factory_function

factory_function
        : factory_function_name '(' constant_expression ',' constant_expression  ')' ';'
		{ Factory.new( val[0].val, val[2], val[4], nil    ) }
        | factory_function_name '(' constant_expression ',' constant_expression ',' arg_list ')' ';'
		{ Factory.new( val[0].val, val[2], val[4], val[6] ) }

factory_function_name
        : IDENTIFIER

arg_list     # factory �� write �ؿ����軰�����ʹ�
        : IDENTIFIER
		{ result = [ [ :IDENTIFIER, val[0].val ] ] }
        | arg_list ',' IDENTIFIER
		{ result << [ :IDENTIFIER, val[2].val ] }
        | STRING_LITERAL
		{ result = [ [ :STRING_LITERAL, val[0].val ] ] }
        | arg_list ',' STRING_LITERAL
		{ result << [ :STRING_LITERAL, val[2].val ] }

#��������
cell
        : CELL namespace_celltype_name cell_name '{'
		{ Cell.new_def }
          join_list '}' ';'
		{ result = Cell.end_of_parse true }
        | CELL namespace_celltype_name cell_name ';'   # oyama �ץ�ȥ��������
			{ result = Cell.end_of_parse false }

namespace_celltype_name
        : namespace_identifier
		{ result = Cell.new(val[0]) }

cell_name
        : IDENTIFIER
		{ result = Cell.set_name(val[0].val) }

join_list
        :   # ����  061007
        | join_list specified_join

specified_join
        :  spec_L join_specifier_list spec_R join
		{ val[3].set_specifier_list( val[1] )  }
	|  join
		{ val[0].set_specifier_list( [] ) }

join_specifier_list
        : join_specifier_list ',' join_specifier
		{ result << val[2] }
        | join_specifier
		{ result = [val[0]] }

join_specifier
        : THROUGH '(' plugin_name ',' plugin_arg ')'
		{ result = [ :THROUGH, val[2], val[4] ] }

plugin_name
        : IDENTIFIER   { result = val[0] }

plugin_arg
#        : STRING_LITERAL
        : string_literal_list

join
#        : ca_name                     '=' expression ';'
#		{
#			result = Join.new( val[0].val, nil, val[2] )
#			Cell.new_join( result, true )
#		}
#        | ca_name '[' ']'             '=' expression ';'
        : ca_name '[' ']'             '=' expression ';'
		{
			result = Join.new( val[0].val,  -1, val[4] )
			Cell.new_join( result, true )
		 }
        | ca_name '[' array_index ']' '=' expression ';'
		{
			result = Join.new( val[0].val, val[2], val[5] )
			Cell.new_join( result, true )
		}
        | ca_name '=' initializer ';'
		{
			result = Join.new( val[0].val, nil, val[2] )
			Cell.new_join( result, true )
		}     # mikan ��¤�ν�����ʤ�
        | ca_name '=' COMPOSITE '.' IDENTIFIER ';'
		{
			result = Join.new( val[0].val, nil, [ :COMPOSITE, val[4] ] )
			Cell.new_join( result, true )
		}


ca_name	#  ca: callport, attribute 
        : IDENTIFIER

array_index
        : constant_expression


#ʣ���
composite_celltype
        : COMPOSITE composite_celltype_name '{' composite_celltype_statement_list '}' ';'
		{
			CompositeCelltype.end_of_parse
			result = val[1]
		}
#        | spec_L celltype_specifier_list spec_R COMPOSITE composite_celltype_name
#		'{' composite_celltype_statement_list '}' ';'
#		{
#			val[4].set_specifier( val[1] )
#			CompositeCelltype.end_of_parse
#		}

composite_celltype_name
        : IDENTIFIER
		{ result = CompositeCelltype.new(val[0].val) }

composite_celltype_statement_list
        : specified_composite_celltype_statement
        | composite_celltype_statement_list specified_composite_celltype_statement

specified_composite_celltype_statement
        : composite_celltype_statement
		{
			if val[0].kind_of?( Port ) then
				CompositeCelltype.new_port( val[0] )   # �ٱ䤷����Ͽ
			end
		}
        | spec_L composite_celltype_statement_specifier_list spec_R composite_celltype_statement
		{
			if val[3].kind_of?( Port ) then
				# port �ʳ� val[3] ��ͭ�����ͤ����äƤ��ʤ��Τǡ��ʲ��Υ᥽�åɤ�Ŭ�ѤǤ��ʤ�
				# ���� port, cell �ʳ��ϻ���Ҥ�����դ��ʤ�
				# �ʤ���������¾��ʸ�����Ҥ�����դ����ǽ��������Τǡ����ΰ��֤˵��Ҥ����
				val[3].set_specifier( Generator.get_statement_specifier )
				CompositeCelltype.new_port( val[3] )   # �ٱ䤷����Ͽ (set_specifier ��)
			elsif val[3].kind_of?( Cell ) then
				# Cell.end_of_parse �ˤ�����
			else
              Generator.get_statement_specifier   # ���ꥢ
              Generator.error( "G1013 unexpected specifier"  )
			end
		}

composite_celltype_statement
        : composite_port
        | composite_attribute
        | internal_cell
        | export_join
#        | error       # ���顼�����ݥ����  (#513 ̵�¥롼�פ˴٤륱����������Τǡ������ǤΥ��顼�����ϼ����)

composite_celltype_statement_specifier_list
        : composite_celltype_statement_specifier
		{
			Generator.add_statement_specifier val[0]
			result = [ val[0] ]
		}

composite_celltype_statement_specifier
        : ALLOCATOR '(' alloc_list2 ')'
		{ result = [ :ALLOCATOR, val[2] ] }

        | OPTIONAL
		{ result = [ :OPTIONAL ] }

composite_port
        : port
		{
			# CompositeCelltype.new_port( val[0] )
			result = val[0]
		}

#°��
composite_attribute
        : ATTRIBUTE '{' composite_attribute_declaration_list '}' ';'
		{ result = nil }

composite_attribute_declaration_list
        : attribute_declaration
		{ CompositeCelltype.new_attribute( val[0] ) }
        | composite_attribute_declaration_list attribute_declaration
		{ CompositeCelltype.new_attribute( val[1] ) }

internal_cell
        : CELL internal_namespace_celltype_name
             internal_cell_name '{'
		{ Cell.new_def }
             internal_join_list '}' ';'
		{ result = Cell.end_of_parse true }
        | CELL internal_namespace_celltype_name	internal_cell_name ';'
		{ result = Cell.end_of_parse false }


internal_namespace_celltype_name
        : namespace_identifier
		{ Cell.new(val[0],true) }

internal_cell_name
        : IDENTIFIER
		{ Cell.set_name(val[0].val) }


internal_join_list
        :   # ����  061007
        | internal_join_list specified_join
        | internal_join_list external_join

external_join  # cell ��˵��Ҥ���ƤӸ��γ������
        : internal_cell_elem_name '=>' COMPOSITE '.' export_name ';'
		{	Cell.external_join( val[0].val, val[4].val, true )	}
        | internal_cell_elem_name '=>' export_name ';'
		{	Cell.external_join( val[0].val, val[2].val, false )	}
        # ������ʸˡ�Ǥϡ��ƤӸ�¦�� cell �γ��˵��Ҥ��Ƥ���
        # ���λ��μ�����

export_join    # cell ���˵��Ҥ���������γ������
        : export_name '=>' internal_ref_cell_name '.' internal_cell_elem_name ';'
		{
			CompositeCelltype.new_join( val[0].val,
						val[2].val, val[4].val, :ENTRY )
		}
        | COMPOSITE '.' export_name '=>' internal_ref_cell_name '.' internal_cell_elem_name ';'
		{
			CompositeCelltype.new_join( val[2].val,
						val[4].val, val[6].val, :ENTRY )
		}

export_name
        : IDENTIFIER

internal_ref_cell_name
        : IDENTIFIER

internal_cell_elem_name
        : IDENTIFIER


region
        : spec_L region_specifier_list spec_R REGION region_name '{'  region_statement '}' ';'
		{ Region.end_of_parse }
        |                  REGION region_name '{'  region_statement '}' ';'
		{ Region.end_of_parse }


region_specifier_list
        : region_specifier
        | region_specifier_list ',' region_specifier

region_specifier
        : IN_THROUGH '(' plugin_name ',' plugin_arg ')'
		{ Region.new_in_through( val[2].val, val[4].val ) }
        | IN_THROUGH '(' ')'   # in ����
		{ Region.new_in_through }
        | OUT_THROUGH '(' plugin_name ',' plugin_arg ')'
		{ Region.new_out_through( val[2].val, val[4].val ) }
        | OUT_THROUGH '(' ')'  # out ����
		{ Region.new_out_through() }
        | TO_THROUGH '(' namespace_region_name ',' plugin_name ',' plugin_arg ')'
		{ Region.new_to_through( val[2], val[4].val, val[6].val ) }
        | TO_THROUGH '('namespace_region_name ')'  # to ����
		{ Region.new_to_through( val[2], nil, nil ) }
        | NODE
		{ Region.set_type( :NODE ) }
        | LINKUNIT
		{ Region.set_type( :LINKUNIT ) }
        | DOMAIN '(' IDENTIFIER ')'
		{ Region.set_type( :DOMAIN, val[2].val ) }
        | CLASS '(' IDENTIFIER ')'
		{ Region.set_type( :CLASS, val[2].val ) }

region_name
        : IDENTIFIER
		{ result = Region.new( val[0].val ) }

region_statement
        :
        | region_statement region_cell
        | region_statement region

region_cell
        : cell
        | spec_L region_cell_specifier_list spec_R cell

region_cell_specifier_list
        : region_cell_specifier
		{ Generator.add_statement_specifier val[0] }
        | region_cell_specifier_list region_cell_specifier
		{ Generator.add_statement_specifier val[2] }

region_cell_specifier
        : ALLOCATOR '(' alloc_list ')'
		{ result = [ :ALLOCATOR, val[2] ] }


namespace_region_name
         : :IDENTIFIER
		{ result = [ val[0].val ] }  # mikan ����Ǥ���ɬ�פϤʤ�
#        : namespace_identifier

# ����Ҥγ�� (in, out �ʤɤΥ�������ڤ��ؤ��Τ���ʬΥ)
spec_L
        : '['  { set_in_specifier }
spec_R
        : ']'  { unset_in_specifier }

end

---- inner

  RESERVED = {
    # keyword
    'namespace' => :NAMESPACE,
    'signature' => :SIGNATURE,
    'celltype' => :CELLTYPE,
    'cell' => :CELL,
    'attr' => :ATTRIBUTE,
    'var' => :VAR,
    'call' => :CALL,
    'entry' => :ENTRY,
    'composite' => :COMPOSITE,
    'require' => :REQUIRE,
    'factory' => :FACTORY,
    'FACTORY' => :CTFACTORY,
    'typedef' => :TYPEDEF,
    'struct' => :STRUCT,
    'region' => :REGION,
    'import' => :IMPORT,
    'import_C' => :IMPORT_C,
    'generate' => :GENERATE,

    # types
    'void'    => :VOID,

    'volatile'=> :VOLATILE,
    'const'   => :CONST,

    'signed'  => :SIGNED,
    'unsigned'=> :UNSIGNED,

    'int8_t'    => :INT8_T,
    'int16_t'   => :INT16_T,
    'int32_t'   => :INT32_T,
    'int64_t'   => :INT64_T,
    'int128_t'  => :INT128_T,
    'uint8_t'   => :UINT8_T,
    'uint16_t'  => :UINT16_T,
    'uint32_t'  => :UINT32_T,
    'uint64_t'  => :UINT64_T,
    'uint128_t' => :UINT128_T,

    'float32_t'   => :FLOAT32_T,
    'double64_t'  => :DOUBLE64_T,
    'bool_t'      => :BOOL_T,
    'char_t'  => :CHAR_T,
    'schar_t'  => :SCHAR_T,
    'uchar_t'  => :UCHAR_T,

    # unrecommened types
    'int'     => :INT,
#   'intptr'  => :INTPTR,
    'short'   => :SHORT,
    'long'    => :LONG,

    # obsolete types
    'char'    => :CHAR,
    'int8'    => :INT8,
    'int16'   => :INT16,
    'int32'   => :INT32,
    'int64'   => :INT64,
    'int128'  => :INT128,
    'float'   => :FLOAT,
    'double'  => :DOUBLE,
#   'bool'    => :BOOL,

    'enum'    => :ENUM,
    'enum8'   => :ENUM8,
    'enum16'  => :ENUM16,
    'enum32'  => :ENUM32,
    'enum64'  => :ENUM64,

    'true'    => :TRUE,
    'false'   => :FALSE,

    'C_EXP'   => :C_EXP
  }

  # ����� '[]' ��ǤΤ߻��ѤǤ��륭�����
  RESERVED2 = {
    # specifier
    'id' => :ID,

    # signature
    'context' => :CONTEXT,
    'deviate' => :DEVIATE,

    # celltype
    'singleton' => :SINGLETON,
    'idx_is_id' => :IDX_IS_ID,
    'active' => :ACTIVE,

    # port (entry)
    'inline' => :INLINE,

    # port (call)
    'optional' => :OPTIONAL,

    # attribute
    'omit' => :OMIT,

    # cell
    'allocator' => :ALLOCATOR,

    # FuncType
    'oneway' => :ONEWAY,

    # parameter (basic)
    'in' => :IN,
    'out' => :OUT,
    'inout' => :INOUT,
    'send' => :SEND,
    'receive' => :RECEIVE,

    # parameter 
    'size_is' => :SIZE_IS,
    'count_is' => :COUNT_IS,
    'string' => :STRING,
    'nullable' => :NULLABLE,

    'through' => :THROUGH,
    'in_through' => :IN_THROUGH,
    'out_through' => :OUT_THROUGH,
    'to_through' => :TO_THROUGH,

    'node' => :NODE,
    'linkunit' => :LINKUNIT ,
    'domain' => :DOMAIN,
    'class' => :CLASS,
  }

  # �Ƶ�Ū�ʥѡ����Τ���Υ����å�
  @@generator_nest = -1
  @@generator_stack = []
  @@current_locale = []

  # import_C ��Ǥ���
  @@import_C = false

  # ���٤Ƥι�ʸ���Ϥ���λ����
  @@b_end_all_parse = false

  # tag �ʤ� struct
  @@no_struct_tag_num = 0

  def self.parse( file_name, plugin = nil, b_reuse = false )
    # �ѡ������󥹥��󥹤�����(�̥ѡ������ɤ߹���)
    parser = Generator.new

    # plugin ���� import ����Ƥ������ plugin ����
    parser.set_plugin plugin

    # reuse �ե饰������
    parser.set_reuse b_reuse

    # cdl ��ѡ���
    parser.parse( [file_name] )

    # ���������ѡ��������å����᤹
    parser.finalize
  end

  def finalize

    # mikan Namespace.pop
    Namespace.pop
    Signature.pop
    Celltype.pop
    Cell.pop
    CompositeCelltype.pop
  end

  def set_plugin( plugin )
    @plugin = plugin
  end

  def self.get_plugin
    if @@generator_stack[@@generator_nest] then
      # tecsgen ������ cdl �� import �������� nil
      return @@generator_stack[@@generator_nest].get_plugin
    else
      return nil
    end
  end

  def get_plugin
    @plugin
  end

  def set_reuse( b_reuse )
    @b_reuse = b_reuse
  end

  def self.is_reuse?
    if @@generator_stack[@@generator_nest] then
      # tecsgen ������ cdl �� import �������� nil
      return @@generator_stack[@@generator_nest].is_reuse?
    else
      return false
    end
  end

  def is_reuse?
    @b_reuse
  end

  def parse(files)

    # mikan Namespace.push
    Namespace.push
    Signature.push
    Celltype.push
    Cell.push
    CompositeCelltype.push

    @@generator_nest += 1
    @@generator_stack[@@generator_nest] = self
    @in_specifier = false

    begin

      @q = []
      b_in_comment = false
      b_in_string = false

      # euc �Υ����Ȥ� utf8 �Ȥ��ư����ȡ������Ȥν�������������к�
      TECS_LANG::set_kcode_binary

      files.each {|file|
        lineno = 1
        begin
          string = ""
#2.0          IO.foreach(file) {|line|
          TECSIO.foreach(file) {|line|
            col = 1
#            line.rstrip!         ���Դޤ�ʸ����򰷤��褦�ˤʤä��Τǡ������Ƕ����������ʤ��ʤä�

            until line.empty?

              if b_in_comment
                case line
                  # �����Ƚ�λ
                when /\A\*\//
                  b_in_comment = false
                when /\A./
                  ;
                when /\s+/     # line.rstrip! ��ߤ᤿���� \n �ʤɤζ���ʸ���Ȥޤä�����롼�뤬ɬ�פˤʤä�
                  ;
                end
              elsif b_in_string
                if line =~ /\A(?:[^"\\]|\\.)*"/
                  string = "#{string}#{$&}"
                  @q <<  [:STRING_LITERAL, Token.new(string, file, lineno, col)]
                  b_in_string = false
                elsif line =~ /\A.*\\\n/     # ���� \n �� '.' �˥ޥå����ʤ�
                  string += $&
                elsif line =~ /\A.*\n/     # ���� \n �� '.' �˥ޥå����ʤ�
                  string += line
                  # ���ΰ��֤Ǥ� error �᥽�åɤϻȤ��ʤ� (token �ɽФ���)
                  puts "error: #{file} line #{lineno}: string literal has newline without escape"
                  @@n_error += 1
                end
              else
                case line
                # ���򡢥ץ�ץ����ǥ��쥯�ƥ���
                when /\A\s+/
                  ;
                # ���̻�
                when /\A[a-zA-Z_]\w*/
                  word = $&
                  @q << [RESERVED[word] || :IDENTIFIER, Token.new(word.intern, file, lineno, col)]
                # 16 �ʿ����
                when /\A0x[0-9A-Fa-f]+/
                  @q << [:HEX_CONSTANT, Token.new($&, file, lineno, col)]
                # 8 �ʿ����
                when /\A0[0-7]+/
                  @q << [:OCTAL_CONSTANT, Token.new($&, file, lineno, col)]
                # ��ư�������
                when /\A[0-9]+\.([0-9]*)?([Ee][+-]?[0-9]+)?/
                  @q << [:FLOATING_CONSTANT, Token.new($&, file, lineno, col)]
                # �������
                when /\A\d+/
                  @q << [:INTEGER_CONSTANT, Token.new($&.to_i, file, lineno, col)]
                # ʸ�����
                when /\A'(?:[^'\\]|\\.)'/
                  @q << [:CHARACTER_LITERAL, Token.new($&, file, lineno, col)]
                # ʸ����
#                "#include  #include #include \"../systask/logtask.cfg\"       �Ǹ�� " ˺��)��̵�¥롼��
#                when /\A"(?:[^"\\]+|\\.)*"/
                when /\A"(?:[^"\\]|\\.)*"/   # ����Ϥ��ޤ��Ԥ��褦��
                  @q << [:STRING_LITERAL, Token.new($&, file, lineno, col)]
                # ʸ���� (���Ԥ���)
                when /\A"(?:[^"\\]|\\.)*\\\n$/
                  string = $&
                  b_in_string = true
                # ʸ���� (���Ԥ���, escape �ʤ�)
                when /\A("(?:[^"\\]|\e\.)*)\n$/
                  string = $1 + "\\\n"
                  b_in_string = true
                  # ���ΰ��֤Ǥ� error �᥽�åɤϻȤ��ʤ� (token �ɽФ���) # mikan cdl_error �ǤϤʤ�
                  puts "error: #{file} line #{lineno}: string literal has newline without escape"
                  @@n_error += 1
                # ����̤ǰϤޤ줿ʸ����
                when /\A<[0-9A-Za-z_\. \/]+>/   # AB: angle bracke
                  @q << [:AB_STRING_LITERAL, Token.new($&, file, lineno, col)]
                # �ԥ�����
                when /\A\/\/.*$/
                  # �ɤ����Ф�����
                # �����ȳ���
                when /\A\/\*/
                  b_in_comment = true
                # '>>', '<<' �ʤ�
                when /\A>>/, /\A<</, /\A==/, /\A!=/, /\A\&\&/, /\A\|\|/
                  @q << [$&, Token.new($&, file, lineno, col)]
                when /\A::/, /\A=>/, /\A<=/, /\A>=/
                  @q << [$&, Token.new($&, file, lineno, col)]
                # '(', ')' �ʤɰ�ʸ���ε��桢�ޤ���̤�Τε���
                when /\A./
                  @q << [$&, Token.new($&, file, lineno, col)]
                else
                  raise
                end
              end

              line = $'
              col += $&.length
            end

            lineno += 1
          }

        rescue => evar
          Generator.error( "G1014 while open or reading \'$1\'" , file )
          if $debug then
            p puts( evar )
            pp $@
          end
        end
      }

      # ��λ�ΰ�
      @q << nil

      @yydebug = true
      do_parse

    ensure
      @@generator_nest -= 1
      TECS_LANG::reset_kcode
    end

  end

  def next_token
    token = @q.shift

    if token then
      @@current_locale[@@generator_nest] = token[1].locale

      if token[0] == :IDENTIFIER then
        # TYPE_NAME �ȡ�������ִ���
        if Namespace.is_typename?( token[1].val ) then
          token[0] = :TYPE_NAME
        elsif @in_specifier && RESERVED2[ token[1].val.to_s ] then
          # ����ҥ�����ɡ� '[', ']' ��ǤΤ�ͭ��)
          token[0] = RESERVED2[ token[1].val.to_s ]
        end
      end

      if $debug then     # 070107 token ̵�����������̤��ʤ��褦���� (through �б� -d �λ����㳰ȯ��) 
        locale = @@current_locale[@@generator_nest]
        if token then
          print( "#{locale[0]}: line #{locale[1]} : #{token[0]} '#{token[1].val}'\n" )
        else
          print( "#{locale[0]}: line #{locale[1]} : EOF\n" )
        end
      end
    else
      token = [ false, false ]
    end

    token
  end

  def on_error(t, v, vstack)
    # p t, token_to_str(t), vstack
    if token_to_str(t) == "$end" then
      Generator.error( "G1015 Unexpected EOF"  )
    else
      Generator.error( "G1016 syntax error near \'$1\'" , v.val )
    end
  end

  def self.current_locale
    @@current_locale[ @@generator_nest ]
  end

  @@n_error = 0
  @@n_warning = 0

  # ���Υ᥽�åɤϹ�ʸ���ϡ���̣���Ϥ���Τ߸ƽФ��ġʥ����������ǥ��顼ȯ������Ŭ�ڡ�
  def self.error( msg, *arg )
    locale = nil
    self.error2( locale, msg, *arg )
  end

  def self.error2( locale, msg, *arg )
    @@n_error += 1

    msg = TECSMsg.get_error_message( msg )
    # $1, $2, ... �� arg ���ִ�
    count = 1
    arg.each{ |a|
      str = TECSIO.str_code_convert( msg, a.to_s )
      msg.sub!( /\$#{count}/, str )
      count += 1
    }

    # import_C ����ǤΥ��顼��
    if @@import_C then
      C_parser.error( msg )
    else

      # Node �ε������� ���� (locale) ����Ѥ�����硢�ѹ���������١�
      # ����ȯ���ս�Ȱۤʤ���֤˥��顼���Ф뤿�ᡢ��ʸ������Υ��顼
      # �ϡ�������ΰ��֤���Ϥ��롥(new_XXX �� owner �������ǤΥ�����
      # ���򤹤�� owner �ι��ֹ椬�ФƤ��ޤ����ǡ����줬�����Ƥ���)

      if @@b_end_all_parse == false || locale == nil then
        locale = @@current_locale[ @@generator_nest ]
      end
      if locale then
        Console.puts "error: #{locale[0]}: line #{locale[1]} #{msg}"
      else
        Console.puts "error: #{msg}"
      end
    end
  end

  # ���Υ᥽�åɤϹ�ʸ���ϡ���̣���Ϥ���Τ߸ƽФ��ġʥ����������ǥ������˥�ȯ������Ŭ�ڡ�
  def self.warning( msg, *arg )
    locale = nil
    self.warning2( locale, msg, *arg )
  end

  def self.warning2( locale, msg, *arg )
    @@n_warning += 1

    msg = TECSMsg.get_warning_message( msg )
    # $1, $2, ... �� arg ���ִ�
    count = 1
    arg.each{ |a|
      str = TECSIO.str_code_convert( msg, a.to_s )
      msg.sub!( /\$#{count}/, str )
      count += 1
    }

    # import_C ����ǤΥ������˥󥰡�
    if @@import_C then
      C_parser.warning( msg )
    else
      if @@b_end_all_parse == false || locale == nil then
        locale = @@current_locale[ @@generator_nest ]
      end
      if locale then
        Console.puts "warning: #{locale[0]}: line #{locale[1]} #{msg}"
      else
        Console.puts "warning: #{msg}"
      end
    end
  end

  def self.get_n_error
    @@n_error
  end

  def self.get_n_warning
    @@n_warning
  end

  def self.get_nest
    @@generator_nest
  end

  #===  '[' specifier �Ϥ�
  def set_in_specifier
    # p "set_in_specifier"
    @in_specifier = true
  end

  #=== ']' specifier �����
  def unset_in_specifier
    # p "unset_in_specifier"
    @in_specifier = false
  end

  # statement_specifier �Ϲ�ʸ�������ǻ��Ȥ���������
  @@statement_specifier_stack = []
  def self.add_statement_specifier( ss )
    if( @@statement_specifier_stack[ @@generator_nest ] == nil )then
      @@statement_specifier_stack[ @@generator_nest ] = [ ss ]
    else
      @@statement_specifier_stack[ @@generator_nest ] << ss
    end
  end


  def self.get_statement_specifier
    spec_list = @@statement_specifier_stack[ @@generator_nest ]
    @@statement_specifier_stack[ @@generator_nest ] = nil
    return spec_list
  end

  #=== ���٤Ƥι�ʸ���Ϥ���λ�������Ȥ����
  def self.end_all_parse
    @@b_end_all_parse = true
  end

---- footer


# �ե����� => INCLUDE("header")������
Include = Hash.new {|hash, key| hash[key] = []}


class Token

  attr_accessor :val, :file, :lineno, :col

  def initialize(val, file, lineno, col)
    @val = val
    @file = file
    @lineno = lineno
    @col = col

  end

  def to_s
    @val.to_s
  end

  def to_sym
    @val.to_sym
  end

  def get_name
    @val
  end

  def locale
    [@file, @lineno, @col]
  end

  def eql?(other)
    if other.is_a? Symbol
      @val == other
    elsif other.is_a? Token
      @val == other.val
    elsif other.is_a? String
      @val.to_s == other
    else
      raise ArgumentError
    end
  end

  alias == eql?

  def show_tree( indent )
    indent.times { print "  " }
    print "#{@val}\n"
  end

end

#= TECSIO
#  Ruby2.0(1.9) �б���ȼ��Ƴ���������饹
#  SJIS �ʳ��Ǥϡ�ASCII-8BIT �Ȥ������Ϥ���
class TECSIO
  def self.foreach(file) # �֥�å����� { |line| }
    pr = Proc.new   # ���Υ᥽�åɤΥ֥�å������� pr ������
    if $b_no_kcode then
	  msg = "E".encode $Ruby19_File_Encode
      if( $Ruby19_File_Encode == "Shift_JIS" )

        # Shift JIS �ϡ����ä��� Windows-31J �Ȥ����ɤ߹��ޤ���Shift_JIS ���Ѵ������롥
        # ���������˴ޤޤ�� SJIS ����Ŭ�ڤ�ʸ�������ɤ� '?' �ޤ��� REPLACEMENT CHARACTER ���Ѵ�����롥
        # EUC �� UTF-8 �ǵ��Ҥ��줿 CDL �����ߤ��Ƥ��Ƥ⡢Ruby �㳰��ȯ�����뤳�Ȥʤ�������ʤ�뤳�Ȥ��Ǥ��롥
        # ʸ�������ɻ��꤬ SJIS �Ǥ��äơ�ʸ�����ƥ�����ˡ�ʸ�������ɤ�SJIS �ʳ����� ASCII ���ޤޤ�Ƥ����硢
        # Ruby 1.8 �� tecsgen �Ǥ�ʸ�������ɻ���˱ƶ��ʤ��������줿��Τ���Ruby 1.9 �ʹߤǤ� '?' ���֤�������ǽ�������롥

        mode = "r:Windows-31J"
      else
        mode = "r:#{$Ruby19_File_Encode}"
      end
      # mode = "r"
    else
	  msg = "E"
      mode = "r"
    end

    f = File.open( file, mode )
    begin
      f.each{ |line|
        # dbgPrint line
        line = str_code_convert( msg, line )
        pr.call( line )
      }
    ensure
      f.close
    end
  end

  #=== ʸ�������ɤ���㤹������פ�����
  # msg �� str ��ʸ�������ɤ���㤹���硢str �� msg ��ʸ�������ɤ��Ѵ�����
  # �Ѵ��ԲĤ�ʸ�������ɤ� '?' (utf-8 �ξ�� U+FFFD (REPLACEMENT CHARACTER )) ���Ѵ�
  #
  # ���Υ᥽�åɤϡ����顼��å��������ϤǤ���Ѥ���Ƥ��뤳�Ȥ���ա�
  #
  #msg_enc::Encode | String
  def self.str_code_convert( msg, str )
    if $b_no_kcode == false then
      return str                          # Ruby V1.8 �ޤ�
    end
    if msg.encoding != str.encoding then
      option = { :invalid => :replace, :undef => :replace }   # �㳰��ȯ����������'?' ���Ѵ�����(utf-8 �� 0xfffd)
      # return str.encode( msg.encoding, option )
      str = str.encode( "utf-8", option )
      return str.encode( msg.encoding, option )
    else
      return str
    end
  end
end
