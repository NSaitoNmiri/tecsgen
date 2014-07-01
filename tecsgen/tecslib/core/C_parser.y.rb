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
#   $Id: C_parser.y.rb 1955 2013-05-05 07:26:10Z okuma-top $
#++

class C_parser
rule
# �ȥåץ�٥�ι�ʸ���Ǥ� C_parser
all: C_parser

# Expr
##########################  ��  ##########################
# K&R��ʸˡ(�ץ���ߥ󥰸���C ��2�� ��Ͽ)�Ȱ����ۤʤ�
# argument_expression_list(�ؿ�����), assignment_expression(����)���ʤ�
# ���� result �ϡ����٤������������Ǥ����̥���ܥ롢�������ǰʲ�������

primary_expression
        : namespace_identifier
		{ result = [ :IDENTIFIER, val[0] ] }     #1ok
#        : IDENTIFIER	# mikan namespace �ؤ��б�
#		{ result = [ :IDENTIFIER, val[0] ] }
#        | TRUE
#		{ result = [ :BOOL_CONSTANT, true ] }
#        | FALSE
#		{ result = [ :BOOL_CONSTANT, false ] }
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
		{ result << val[1] }

# �ؿ��ƤӽФ��ȸ��֥��󥯥���ȡ��ǥ�����ȱ黻�Ҥ��ʤ�
postfix_expression
        : primary_expression
        | primary_expression '(' argument_list ')'
        | postfix_expression '[' expression ']'
		{ result = [ :OP_SUBSC, val[0], val[2] ] }
        | postfix_expression '.' IDENTIFIER
		{ result = [ :OP_DOT, val[0], val[2] ] }
        | postfix_expression '->' IDENTIFIER
		{ result = [ :OP_REF, val[0], val[2] ] }
        | postfix_expression '++'	{ result = val[0] }   # ++, -- ��̵�뤹��
        | postfix_expression '--'	{ result = val[0] }

argument_list
        :
        | expression
        | argument_list ',' expression


# ���֥��󥯥���ȡ��ǥ�����ȱ黻�Ҥ��ʤ�
unary_expression
        : postfix_expression
        | unary_operator cast_expression
		{ result = [ val[0], val[1] ] }
        | SIZEOF unary_expression
		{ result = [ :OP_SIZEOF_EXPR, val[1] ] }
        | SIZEOF '(' type_name ')'
		{ result = [ :OP_SIZEOF_TYPE, val[1] ] }
		| '++' unary_expression			{ result = val[1] }   # ++, -- ��̵�뤹��
		| '--' unary_expression			{ result = val[1] }

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
#			res = result.eval_const( nil )

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
        : declaration_specifiers init_declarator_list ';'
#        : type_specifier_qualifier_list init_declarator_list ';'

# declaration_specifiers�ϴؿ��Υѥ�᡼���ǻȤ��뤬��
# type_specifier_qualifier_list�ǽ�ʬ���⤷��ʤ�

declaration_specifiers
        : storage_class_list type_specifier    # storage_class ��̵��
		{	result = val[1]		}
        | storage_class_list type_qualifier type_specifier
		{
			val[2].set_qualifier( val[1] )
			result = val[2]
		}
        | type_specifier
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
        : VOID	{ result = CVoidType.new }
        | FLOAT	{ result = CFloatType.new(32) }
        | DOUBLE	{ result = CFloatType.new(64) }
        | BOOL	{ result = CBoolType.new }
        | struct_specifier
        | union_specifier	{ result = CVoidType.new }  # void ��������줿�Ȥ���
        | enum_specifier	{ result = CVoidType.new }  # void ��������줿�Ȥ���
        | TYPE_NAME	{ result = CDefinedType.new( val[0].val ) }
        | sign
        | int_type
        | sign int_type    # C �������ʸˡ�Ǥ� int signed �������뤬�������Ǥ� NG
		{
			val[1].set_sign( val[0].get_sign )
			result = val[1]
		}

int_type
        : CHAR	{ result = CIntType.new(-11 ) }
        | SHORT	{ result = CIntType.new( -2 ) }
        | INT		{ result = CIntType.new( -3 ) }
        | LONG	{ result = CIntType.new( -4 ) }
        | LONG	LONG { result = CIntType.new( -5 ) }

sign
        : SIGNED
		{
			result = CIntType.new( -3 )
			result.set_sign :SIGNED
		}
        | UNSIGNED
		{
			result = CIntType.new( -3 )
			result.set_sign :UNSIGNED
		}

# mikan K&R��struct_or_union_specifier���������뤬��union�ϻȤ��ʤ�, bit field �ˤ��б����ʤ�
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
			result = CStructType.new()
			StructType.set_define( true )
		}
	   '{' struct_declaration_list '}'
		{
			StructType.end_of_parse
			result = val[1]
[]		}
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
		{ result = CStructType.new( val[0].val ) }

# �ݥ��󥿽����Ҥ��ɲ�
struct_declaration
        : declaration_specifiers struct_declarator_list ';'
#        :                                type_specifier_qualifier_list struct_declarator_list ';'
		{
			val[1].each { |i|	# i: Decl
				i.set_type( val[0] )
				i.set_kind( :MEMBER )
				i.check
				CStructType.new_member( i )
			}
			result = val[1]
		}
        | union_specifier ';'                       # ̵̾
        | struct_specifier ';'                       # ̵̾



# K&R��specifier_qualifier_list��Ʊ��
# ̾�����ޤ���路���ä��Τ�type_���դ���
type_specifier_qualifier_list
        : type_specifier
		{
			if val[0].instance_of? Symbol then
			  # :SIGNED, :UNSIGNED �Τ����줫
			  result = CIntType.new(-3)
			  result.set_sign( val[0] )
			else
			  # IntType, FloatType, ...
			  result = val[0]
			end
		}
#        | type_specifier type_specifier_qualifier_list
#		{
#			# �嵭����Ӳ�����§�ˤ�ꡢval[1] �� Symbol �ˤʤ뤳�ȤϤʤ�
#			result = val[1].merge val[0]
#		}
        | type_specifier_qualifier_list type_specifier
		{
			# �嵭����Ӳ�����§�ˤ�ꡢval[1] �� Symbol �ˤʤ뤳�ȤϤʤ�
			result = val[1].merge val[0]
		}
        | type_qualifier
		{
			# :VOLATILE, :CONST �Τ����줫
			result = CIntType.new(-3)
			result.set_qualifier( val[0] )
		}
#        | type_qualifier type_specifier_qualifier_list
#		{
#			val[1].set_qualifier( val[0] )
#			result = val[1]
#		}
        | type_specifier_qualifier_list type_qualifier
		{
			val[0].set_qualifier( val[1] )
			result = val[0]
		}

struct_declarator_list
        : struct_declarator
		{ result = [ val[0] ] }
        | struct_declarator_list ',' struct_declarator
		{ result << val[2] }

# �ӥåȥե�����ɤϻȤ��ʤ�
struct_declarator
        : declarator



union_specifier
        : UNION union_tag '{' union_declaration_list '}'
        | UNION '{' union_declaration_list '}'
        | UNION union_tag   # mikan struct_tag �� namespace �б���ɬ��

union_declaration_list
        : union_declaration
        | union_declaration_list union_declaration

union_tag:
	IDENTIFIER

union_declaration
        : declaration_specifiers union_declarator_list ';'
		| union_specifier ';'                       # ̵̾
		| struct_specifier ';'                      # ̵̾

union_declarator_list
        : union_declarator
        | union_declarator_list ',' union_declarator

# �ӥåȥե�����ɤϻȤ��ʤ�
union_declarator
        : declarator



# enum�μ�����ɲ�
enum_specifier		# mikan
        : enum_type            '{' enumerator_list '}'
        | enum_type IDENTIFIER '{' enumerator_list '}'
        | enum_type IDENTIFIER

enum_type
        : ENUM	{ result = CEnumType.new( -1 ) }
#        | ENUM8	{ result = CEnumType.new( 8 ) }
#        | ENUM16	{ result = CEnumType.new( 16 ) }
#        | ENUM32	{ result = CEnumType.new( 32 ) }
#        | ENUM64	{ result = CEnumType.new( 64 ) }
#        | ENUM128	{ result = CEnumType.new( 128 ) }

enumerator_list
        : enumerator
        | enumerator_list ',' enumerator

enumerator
        : IDENTIFIER
        | IDENTIFIER '=' constant_expression

type_qualifier
        : CONST	{ result = :CONST }
        | VOLATILE	{ result = :VOLATILE }
#        | EXTERN	{ result = :EXTERN }

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
        | TYPE_NAME      # �ؿ��ݥ��󥿷��� typedef �������ξ��
                         # Namespace::new_typedef �ˤ�̵�뤹��
		{ result = Decl.new( val[0].val ) }
        | '(' declarator ')'
		{ result = val[1] }
        | direct_declarator '[' constant_expression ']'
		{
			val[0].set_type( CArrayType.new( val[2] ) )
			result = val[0]
		}
        | direct_declarator '[' ']'
		{
			val[0].set_type( CArrayType.new )
			result = val[0]
		}
        | direct_declarator '(' parameter_type_list ')'
		{
		# 	Generator.warning( "W6001 need 'void' for no parameter"  )
			val[0].set_type( CFuncType.new )
			result = val[0]
		}

#        | direct_declarator '(' identifier_list ')'  # ����ϲ��Τ����ɬ�ס� 060211
        | direct_declarator '(' ')'
		{
		# 	Generator.warning( "W6002 need 'void' for no parameter"  )
			val[0].set_type( CFuncType.new )
			result = val[0]
		}

pointer
        : '*'
		{ result = CPtrType.new }
        | '*' type_qualifier
		{
			result = CPtrType.new
			result.set_qualifier( val[1] )
		}
        | '*' pointer
		{
			val[1].set_type(CPtrType.new)
			result = val[1]
		}
        | '*' type_qualifier pointer
		{
			ptrtype = CPtrType.new
			ptrtype.set_qualifier( val[1] )
			val[2].set_type( ptrtype )
			result = val[2]
		}


parameter_type_list
        : parameter_list
        | parameter_list ',' '.' '.' '.'
		# mikan ����Ĺ�ѥ�᡼��,  ... �δ֤Υ��ڡ������������ʼ�ȴ����

parameter_list
        : parameter_declaration
#		{ result = ParamList.new( val[0] ) }
        | parameter_list ',' parameter_declaration
#		{
#			val[0].add_param( val[2] )
#			# result = val[0] ����
#		}


# �ѥ�᡼�������Ҥ��ɲ�
parameter_declaration
        : declaration_specifiers declarator
#		{
#			decl = ParamDecl.new( val[1], val[0], [] )
#			val[1].set_kind( :PARAMETER )
#			result = decl
#		}

	# �ʲ��ϥ��顼�Ȥ���
#        | declaration_specifiers	# �������ʤ��ϡ��Ȥꤢ��������ʤ� 060210
#		{
#			unless val[0].kind_of?( VoidType ) then
#				Generator.error( "B1001 need parameter name"  )
#			end
#			result = nil
#		}
        | declaration_specifiers abstract_declarator	# �������ʤ�
        | declaration_specifiers						# �������ʤ�


#identifier_list       # 060211  ���Ѥˤʤä�
#        : IDENTIFIER
#        | identifier_list ',' IDENTIFIER

type_name
        : type_specifier_qualifier_list
        | type_specifier_qualifier_list abstract_declarator

abstract_declarator		# mikan
        : pointer
        | direct_abstract_declarator
        | pointer direct_abstract_declarator

direct_abstract_declarator
        : '(' abstract_declarator ')'
        | '[' ']'
        | '[' constant_expression ']'
        | direct_abstract_declarator '[' ']'
        | direct_abstract_declarator '[' constant_expression ']'
        | '(' ')'
		{
			Generator.warning( "W6003 need 'void' for no parameter"  )
		}
        | '(' parameter_type_list ')'
        | direct_abstract_declarator '(' ')'
		{
			Generator.warning( "W6004 need 'void' for no parameter"  )
		}
        | direct_abstract_declarator '(' parameter_type_list ')'

# assignment_expression��constant_expression���ѹ�
initializer			# mikan
        : constant_expression
		{ result = val[0] }
        | '{' initializer_list '}'
		{ result = val[1] }
        | '{' initializer_list ',' '}'
		{ result = val[1] }
	| C_EXP '(' STRING_LITERAL ')'
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
C_parser
        :
        | C_parser extension_statement

extension_statement
        : statement
        | EXTENSION statement

statement
        : typedef
        | func_def
        | enum_specifier ';'
        | struct_specifier ';'
        | declaration
        | ';'
        | error   # ���顼�����ݥ����

typedef
        : TYPEDEF type_specifier_qualifier_list declarator_list ';'
		{			val[2].each{ |i| i.set_kind( :TYPEDEF ) }
			Typedef.new_decl_list( val[1], val[2] )
		}
        | TYPEDEF type_specifier_qualifier_list ';'
                # �������ξ�� (���������ؿ��ݥ��󥿷��ξ�硢��������ʤ���
                # CType::merge �ˤ�̵�뤹��

declarator_list
        : declarator
		{ result = [ val[0] ] }
        | declarator_list ',' declarator
		{ result << val[2] }

func_def
        : declaration_specifiers declarator compoundstatement

infunc_statement_list
        :
        | infunc_statement_list infunc_statement

infunc_statement
        : declaration
        | ifstatement
        | whilestatement
        | dowhilestatement
        | forstatement
        | switchstatement
        | labelstatement
        | compoundstatement
        | gotostatement
        | expressionstatement
        | ';'

ifstatement
        : IF '(' expression ')' infunc_statement
        | IF '(' expression ')' infunc_statement ELSE infunc_statement

whilestatement
        : WHILE '(' expression ')' infunc_statement

dowhilestatement
        : DO infunc_statement WHILE '(' expression ')' ';'

forstatement
        : FOR '(' expression ';' expression ';' expression ')' infunc_statement

switchstatement
        : SWITCH '(' expression ')'  infunc_statment

labelstatement
        : IDENTIFIER ':' infunc_statement
        | CASE constant_expression ':' infunc_statement
        | DEFAULT ':' infunc_statement

compoundstatement
        : '{' infunc_statement_list '}'

gotostatement
        : GOTO IDENTIFIER ';'
        | CONTINUE ';'
        | BREAK ';'
        | RETURN expression ';'

expressionstatement
        : expression ';'
        | unary_expression assignment_operator expression ';'

assignment_operator
        : '='
        | '+='
        | '-='
        | '*='
        | '/='
        | '%='
        | '<<='
        | '>>='
        | '&='
        | '|='
        | '^='

storage_class_list
        : storage_class
        | storage_class_list  storage_class

storage_class
        : __INLINE__
        | INLINE
        | __INLINE
        | EXTERN
        | STATIC
        | AUTO
        | REGISTER

namespace_identifier
        : IDENTIFIER		{ result = NamespacePath.new( val[0].val, false ) }
        | '::' IDENTIFIER	{ result = NamespacePath.new( val[1].val, true ) }
        | namespace_identifier '::' IDENTIFIER
		{ result = val[0].append!( val[2].val ) }

end

---- inner

  RESERVED = {
    # keyword
    'typedef' => :TYPEDEF,
    'struct' => :STRUCT,
    'union' => :UNION,
    'sizeof' => :SIZEOF,

    # specifier
    # types
    'void'    => :VOID,
    'char'    => :CHAR,
    'short'   => :SHORT,

    'volatile'=> :VOLATILE,
    'const'   => :CONST,
    'extern'   => :EXTERN,

    'long'    => :LONG,
    'float'   => :FLOAT,
    'double'  => :DOUBLE,
    'signed'  => :SIGNED,
    'unsigned'=> :UNSIGNED,

    'int'     => :INT,
    'enum'    => :ENUM,

    'if'      => :IF,
    'else'    => :ELSE,
    'while'   => :WHILE,
    'do'      => :DO,
    'for'     => :FOR,
    'case'    => :CASE,
    'default' => :DEFAULT,
    'goto'    => :GOTO,
    'continue' => :CONTINUE,
    'break'   => :BREAK,
    'return'  => :RETURN,
    '__inline__'  => :__INLINE__,
    'inline'  => :INLINE,
    '__inline'  => :__INLINE,
    'static'  => :STATIC,
    'register' => :REGISTER,
    'auto'    => :AUTO,
    '__extension__'    => :EXTENSION,

  }

  @@generator_nest = -1
  @@generator_stack = []
  @@current_locale = []

  def finalize

    # mikan Namespace.pop
    Celltype.pop
    Cell.pop
    CompositeCelltype.pop
    Region.pop

  end

  def set_plugin( plugin )
    @plugin = plugin
  end

  def self.get_plugin
    @@generator_stack[@@generator_nest].get_plugin
  end

  def get_plugin
    @plugin
  end

  def parse(files)

    # mikan Namespace.push
    Celltype.push
    Cell.push
    CompositeCelltype.push
    Region.push

    @@generator_nest += 1
    @@generator_stack[@@generator_nest] = self

   begin

    @q = []
    comment = false

    # euc �Υ����Ȥ� utf8 �Ȥ��ư����ȡ������Ȥν�������������к�
    TECS_LANG::set_kcode_binary

    # 800U, 0xffLL �ʤ� (������ƥ��˶��̤ν�����)
    integer_qualifier = "([Uu][Ll][Ll]|[Uu][Ll]|[Uu]|[Ll][Ll]|[Ll])?"

    files.each {|file|
      lineno = 1
     begin
#2.0       IO.foreach(file) {|line|
       TECSIO.foreach(file) {|line|
        col = 1
        line.rstrip!

        until line.empty?

          if comment
            case line
            # �����Ƚ�λ
            when /\A\*\//
              comment = false
            when /\A./
              ;
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
            when /\A0x[0-9A-Fa-f]+#{integer_qualifier}/
              @q << [:HEX_CONSTANT, Token.new($&, file, lineno, col)]
            # 8 �ʿ����
            when /\A0[0-7]+#{integer_qualifier}/
              @q << [:OCTAL_CONSTANT, Token.new($&, file, lineno, col)]
            # ��ư�������
            when /\A[0-9]+\.([0-9]*)?([Ee][+-]?[0-9]+)?/
              @q << [:FLOATING_CONSTANT, Token.new($&, file, lineno, col)]
            # �������
            when /\A\d+#{integer_qualifier}/
            # when /\A\d+/
              @q << [:INTEGER_CONSTANT, Token.new($&.to_i, file, lineno, col)]
            # ʸ��
            when /\A'(?:[^'\\]|\\.)'/
              @q << [:CHARACTER_LITERAL, Token.new($&, file, lineno, col)]
            # ʸ����
#              "#include  #include #include \"../systask/logtask.cfg\"       �Ǹ�� " ˺��)��̵�¥롼��
#            when /\A"(?:[^"\\]+|\\.)*"/
            when /\A"(?:[^"\\]|\\.)*"/   # ����Ϥ��ޤ��Ԥ��褦��
              @q << [:STRING_LITERAL, Token.new($&, file, lineno, col)]
            # �ԥ�����
            when /\A\/\/.*$/
              # �ɤ����Ф�����
            # �����ȳ���
            when /\A\/\*/
              comment = true
            when /\A>>=/, /\A<<=/, /\A>>/,  /\A<</
              @q << [$&, Token.new($&, file, lineno, col)]
            when /\A\+=/, /\A\-=/, /\A\*=/, /\A\/=/, /\A%=/, /\A&=/, /\A\|=/, /\A\^=/
              @q << [$&, Token.new($&, file, lineno, col)]
            when /\A::/, /\A==/, /\A!=/, /\A>=/, /\A<=/, /\A\->/, /\A\+\+/, /\A\-\-/
              @q << [$&, Token.new($&, file, lineno, col)]
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

     rescue
       Generator.error( "B1002 while open or reading \'$1\'" , file )
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

      # TYPE_NAME �ȡ�������֤�����
      if token[0] == :IDENTIFIER && Namespace.is_typename?( token[1].val ) then
        token[0] = :TYPE_NAME
      end

      if $debug then     # 070107 token ̵�����������̤��ʤ��褦���� (through �б� -d �λ����㳰ȯ��) 
        locale = @@current_locale[@@generator_nest]
        if token then
          print( "#{locale[0]}: line #{locale[1]} : '#{token[1].val}'\n" )
        else
          print( "#{locale[0]}: line #{locale[1]} : EOF\n" )
        end
      end
    end

    token
  end

  def on_error(t, v, vstack)
    if v == "$" then
     Generator.error( "B1003 Unexpected EOF"  )
    else
     Generator.error( "B1004 syntax error near \'$1\'" , v.val )
    end

  end

  def self.current_locale
    @@current_locale[ @@generator_nest ]
  end

  @@n_error = 0
  @@n_warning = 0

  # ���Υ᥽�åɤϹ�ʸ���ϡ���̣���Ϥ���Τ߸ƽФ��ġʥ����������ǥ��顼ȯ������Ŭ�ڡ�
  def self.error( msg )
    @@n_error += 1
    locale = @@current_locale[ @@generator_nest ]

    if locale then
      Console.puts "error: #{locale[0]}: line #{locale[1]} #{msg}"
    else
      Console.puts "error: #{msg}"
    end
  end

  # ���Υ᥽�åɤϹ�ʸ���ϡ���̣���Ϥ���Τ߸ƽФ��ġʥ����������ǥ������˥�ȯ������Ŭ�ڡ�
  def self.warning( msg )
    @@n_warning += 1
    locale = @@current_locale[ @@generator_nest ]
    Console.puts "warning: #{locale[0]}: line #{locale[1]} #{msg}"
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

---- footer

