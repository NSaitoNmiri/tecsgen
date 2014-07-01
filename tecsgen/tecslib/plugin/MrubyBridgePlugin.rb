# -*- coding: euc-jp -*-
#
#  mruby => TECS bridge
#  
#   Copyright (C) 2008-2013 by TOPPERS Project
#
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
#   $Id: MrubyBridgePlugin.rb 1975 2013-06-16 07:34:59Z okuma-top $
#

# Todo:
# ����������
#  gen_cdl_file
#    �֥�å���������륿���� (�����˥��㤴��)
#       @@init_celltypes �˵�Ͽ
#    �֥�å����륿���� (�����˥��㤴��)
#       @@celltypes �˵�Ͽ
#    ��¤�Υ��륿����
#       @@struct_list �˵�Ͽ
#  new_cell
#    TECS ���������(�ץ�ȥ��������)
#       @@VM_init_cells �˵�Ͽ
#       @@VM_struct_list �˵�Ͽ
#       @@VM_ptr_list �˵�Ͽ
#  gen_post_code
#    ��¤�ν��������
#    �ݥ��󥿽��������
#    TECS ���������
#
#   ep_func �κ���
#     signature, �ݥ��󥿡���¤�� �� �������������mruby VM �ؤ���Ͽ
#     �ݥ���
#   preamble �κ���
#     �ݥ��󥿡���¤�� �� ���������ѥ����ɤ�����
#     signature �� �֥�å��ؿ��Υץ�ȥ��������
#   postamble �κ���
#     signature �� �֥�å��ؿ������

class MrubyBridgePlugin < SignaturePlugin

  # �ץ饰�������̾ => Proc
  MrubyBridgePluginArgProc = { 
      "ignoreUnsigned" => Proc.new { |obj,rhs| obj.set_ignoreUnsigned rhs },
      "include" => Proc.new { |obj,rhs| obj.set_include rhs },
      "exclude" => Proc.new { |obj,rhs| obj.set_exclude rhs },
  }

  @@celltypes = { }             # {celltype_name => [ BridgePlugin �Υ��󥹥��󥹤����� }
  @@init_celltypes = { }        # {celltype_name => [ BridgePlugin �Υ��󥹥��󥹤����� }
  @@struct_list = { }           # {struct_name=>StructType}
  @@ptr_list = { }              # {ptr_celltype_name=> @@TYPE_MAP ���б�������}
  @@VM_list = { }               # VM_name => true
  @@VM_celltypes = {  }             # VM_name => { @celltype_name => ��������� }
  @@VM_struct_list = { }           # {name=>StructType}
  @@VM_ptr_list = { }              # { VM_name => {name=> @@TYPE_MAP ���б�������} }
  @@TYPE_MAP = {           # type_str   class             GET_SET
    :char_t            => [:char_t,    "Char",     :Char,  :INT   ],
    :uchar_t           => [:uchar_t,   "UChar",    :Char,  :INT   ],
    :schar_t           => [:schar_t,   "SChar",    :Char,  :INT   ],

    :bool_t            => [:bool_t,    "Bool",     :Bool,  :BOOL  ],
    :int8_t            => [:int8_t,    "Int8",     :Int,   :INT   ],
    :int16_t           => [:int16_t,   "Int16",    :Int,   :INT   ],
    :int32_t           => [:int32_t,   "Int32",    :Int,   :INT   ],
    :int64_t           => [:int64_t,   "Int64",    :Int,   :INT   ],
    :uint8_t           => [:uint8_t,   "UInt8",    :Int,   :INT   ],
    :uint16_t          => [:uint16_t,  "UInt16",   :Int,   :INT   ],
    :uint32_t          => [:uint32_t,  "UInt32",   :Int,   :INT   ],
    :uint64_t          => [:uint64_t,  "UInt64",   :Int,   :INT   ],

    :int               => [:int,       "Int",      :Int,  :INT   ], 
    :char              => [:char,      "Char",     :Char, :INT   ],    # char �� char_t �Ȥ��ư���
    :short             => [:short,     "Short",    :Int,  :INT   ],
    :long              => [:long,      "Long",     :Int,  :INT   ],

    :"unsigned char"   => [:uchar_t,   "UChar",         :Char, :INT   ],
    :"unsigned int"    => [:"unsigned int",   "UInt",   :Int,  :INT   ],
    :"unsigned short"  => [:"unsigned short", "UShort", :Int,  :INT   ],
    :"unsigned long"   => [:"unsigned long",  "ULong",  :Int,  :INT   ],
    :"signed char"     => [:schar_t,   "SChar",    :Char,  :INT   ],
    :"signed int"      => [:int,       "Int",      :Int,   :INT   ],
    :"signed short"    => [:short,     "Short",    :Int,   :INT   ],
    :"signed long"     => [:long,      "Long",     :Int,   :INT   ],

    :float32_t         => [:float32_t, "Float32",  :Float, :FLOAT ],
    :double64_t        => [:double64_t,"Double64", :Float, :FLOAT ],

    :float             => [:float,     "Float32",  :Float, :FLOAT ],
    :double            => [:double,    "Double64", :Float, :FLOAT ]
  }

  # included  or excluded functions

  ### ���ɤ��줿�����Ǽ¹Ԥ���� ###

  # -I �� $(TECSPATH)/mruby ���ɲ�
  # TECSGEN::Makefile.add_obj "$(MRUBY_MAIN_OBJ)"
  TECSGEN::Makefile.add_ldflag "-lmruby -L$(MRUBYPATH)/lib -lm"
  TECSGEN::Makefile.add_search_path "$(MRUBYPATH)/include"
  TECSGEN::Makefile.add_var "MRUBYPATH",      "..",  "CHANGE this into suitable path"
  # TECSGEN::Makefile.add_var "MRUBY_MAIN_OBJ", "$(_TECS_OBJ_DIR)tecs_mruby.o", "CHANGE this if your have your main"


  #=== �ץ饰���󥤥󥹥��󥹤ν����
  # ����͡������η������Ѳ�ǽ�ʤ�Τ������å�����
  #
  def initialize( signature, option )
    super

    @b_ignoreUnsigned = false
    @includes = []
    @excludes = []
    @struct_list = { }
    @ptr_list = { }

    @plugin_arg_check_proc_tab = MrubyBridgePluginArgProc
    parse_plugin_arg

    @celltype_name = :"t#{@signature.get_global_name}"
    @init_celltype_name = :"#{@celltype_name}_Initializer"
        # this variable is sometimes not used. rhs coded directry.
    @class_name = :"T#{@signature.get_global_name}"

    @func_head_array = []
    if @includes.length > 0 && @excludes.length > 0 then
      cdl_error( "MRB1011 both include && exclude are specified" )
    end

    if signature.get_function_head_array == nil then
      return   # ������ʸˡ���顼ȯ��
    end

    signature.get_function_head_array.each{ |func_head|
      if @includes.length > 0 then
        if @includes.index func_head.get_name then
          dbgPrint "MrubyBridgePlugin: #{func_head.get_name} INCLUDED\n"
          @func_head_array << func_head
        else
          dbgPrint "MrubyBridgePlugin: #{func_head.get_name} NOT included\n"
        end
      elsif @excludes.length > 0 then
        if @excludes.index( func_head.get_name ) == nil then
          dbgPrint "MrubyBridgePlugin: #{func_head.get_name} NOT excluded\n"
          @func_head_array << func_head
        else
          dbgPrint "MrubyBridgePlugin: #{func_head.get_name} EXCLUDED\n"
        end
      else
        @func_head_array << func_head
      end
    }

    if @func_head_array.length == 0 then
      cdl_error( "MRB1012 '$1' no function remained by exclude", @signature.get_name )
    end

    check_name_and_return_type @func_head_array
    check_parameter_type @func_head_array

  end

  #=== check function name & return type
  def check_name_and_return_type func_head_array
    b_init = false; b_init_cell = false
    func_head_array.each{ |func_head|
      if( func_head.get_name == :initialize )then
        cdl_warning( "MRW2001 initialize: internally defined. change to initialize_cell in ruby" )
        b_init = true
      elsif( func_head.get_name == :initialize_cell )then
        b_init_cell = true
      end
      rtype = func_head.get_return_type.get_original_type
      case rtype
      when BoolType, IntType, FloatType, VoidType
      else
        cdl_error( "MRB1001 cannot return type $1", rtype.get_type_str )
      end
    }
    if( b_init && b_init_cell )then
      cdl_warning( "MRB1002 initialize: internally defined. change to initialize_cell in ruby" )
    end
  end

  #=== check paramter type
  def check_parameter_type func_head_array
    # check type of parameters
    func_head_array.each{ |fh|
      fh.get_paramlist.get_items.each{ |param_decl|
        case param_decl.get_direction
        when :SEND, :RECEIVE
          cdl_error( "MRB1003 $1: $2 parameter cannot be used in mruby Bridge",  param_decl.get_name, param_decl.get_direction.to_s.downcase )
        end
        type = param_decl.get_type
        type_org = type.get_original_type
        type_str = type.get_type_str + type.get_type_str_post

        b_ng = false
        case type_org
        when IntType
          case  type_org.get_bit_size
          when 8, 16, 32, 64
          when -1, -2, -3, -4, -11
          else
            b_ng = true
          end
        when BoolType
        when FloatType
        when PtrType
          ttype_org = type_org.get_type       # �ݥ��󥿤λؤ��Ƥ�����η�
          ttype = ttype_org.get_original_type # �嵭�� typedef ����Ƥ����硢���η�
          register_ptr_type ttype_org

          if( type_org.get_string.to_s == "-1" ) then
            case param_decl.get_direction
            when :OUT, :INOUT
              cdl_error( "MRB9999 string specifier without length cannot be used for out & inout parameter")
            end
          end

          case ttype
          when IntType
            bit_size = ttype.get_bit_size
            # if  bit_size < 0 && bit_size != -1 then
            #   b_ng = true
            # end
          when FloatType
          when BoolType
          when StructType
            if( type_org.get_size || type_org.get_string || type_org.get_count ) then
              cdl_error( "MRB1004 $1: size_is, count_is, string cannot be specified for struct pointer", param_decl.get_name )
            end
            check_struct_member ttype_org
          else
            b_ng = true
          end
        when StructType
          check_struct_member type_org
        else  # ArrayType, FuncType, EnumType, VoidType
          b_ng = true
        end
        if b_ng then
          cdl_error( "MRB1005 $1: type $2 cannot be used in mruby Bridge", param_decl.get_name, type_str )
        end
      }
    }
  end

  #=== ��¤�ΤΥ��С��η��Υ����å�
  def check_struct_member struct_type
    #p "tag name:#{struct_type.get_name}"
    # sttype = Namespace.find_tag( struct_type.get_name )
    sttype = struct_type.get_original_type
    if sttype.get_name == nil then
      cdl_error( "MRB10007 tagless-struct cannot be handled")
    end
    sttype.get_members_decl.get_items.each { |d|
      t = d.get_type.get_original_type
      case t
      when IntType, FloatType, BoolType
      else
        cdl_error( "MRB1006 $1: type $2 not allowed for struct member", d.get_name, d.get_type.get_type_str + d.get_type.get_type_str_post )
      end
    }
    st_name = :"t{}"
    if @struct_list[ sttype.get_name ] == nil then
      # print_msg "  MrubyBridgePlugin: [struct]   #{struct_type.get_type_str} => class TECS::Struct#{sttype.get_name}\n"
      print "  MrubyBridgePlugin: [struct]   #{struct_type.get_type_str} => class TECS::Struct#{sttype.get_name}\n"
      @struct_list[ sttype.get_name ] = sttype
    end
  end

  def register_ptr_type ttype
    t_org = ttype.get_original_type
    tment = get_type_map_ent t_org
    if tment == nil then
      return
      cdl_error( "MRB1008 unknown pointer type '$1'", ttype.get_type_str )
    end
    ptr_celltype_name = :"t#{tment[1]}Pointer"
    if @@ptr_list[ ptr_celltype_name ] == nil then
      # print_msg "  MrubyBridgePlugin: [pointer]  #{ttype.get_type_str}* => class TECS::#{tment[1]}Pointer\n"
      print "  MrubyBridgePlugin: [pointer]  #{ttype.get_type_str}* => class TECS::#{tment[1]}Pointer\n"
      @@ptr_list[ ptr_celltype_name ] = tment
    end
    if @ptr_list[ ptr_celltype_name ] == nil then
      @ptr_list[ ptr_celltype_name ] = tment
    end
  end

  def get_type_map_ent ttype
    # structure type is registerd in check_struct_member
    if ttype.kind_of? StructType
      return
    end
    tstr = ttype.get_type_str.sub( /const /, "" )    # const ��̵��
    tstr = tstr.sub( /volatile /, "" )               # volatile ��̵��
    if @b_ignoreUnsigned then
      tstr = tstr.sub( /unsigned /, "" )             # volatile ��̵��
      tstr = tstr.sub( /uint/, "int" )               # volatile ��̵��
      tstr = tstr.sub( /[cs]char/, "char" )          # volatile ��̵��
    end
    return @@TYPE_MAP[ tstr.to_sym ]
  end

  #===  CDL �ե����������
  #      typedef, signature, celltype, cell �����ɤ�����
  #file::        FILE       ��������ե�����
  def gen_cdl_file(file)

    # �֥�å����륿���פ�����
    if @@celltypes[ @celltype_name ] == nil then
      @@celltypes[ @celltype_name ] = [ self ]
      @@init_celltypes[ @init_celltype_name ] = true
      print_msg <<EOT
  MrubyBridgePlugin: [signature] #{@signature.get_namespace_path} => [celltype] nMruby::#{@celltype_name} => [class] TECS::#{@class_name}
EOT

      file.print <<EOT
import( <mruby.cdl> );

/****  Ruby => TECS Bridge Celltype (MBP500) ****/
namespace nMruby{
    // bridge celltype
    [idx_is_id,active]   // not actually active, to avoid warning W1002, W1007
    celltype #{@celltype_name} {
        call #{@signature.get_namespace_path.to_s} cTECS;
        attr {
            [omit]
            char_t *VMname = "VM";
        };
    };
    // bridge initializer celltype
    celltype #{@init_celltype_name} {
        entry sInitializeTECSBridge eInitialize;
    };
};
EOT

      # ��¤�Υ��륿���פ�����
      @struct_list.each{ |name, sttype|
        if @@struct_list[ name ] == nil then
          file.print <<EOT
namespace nMruby{
    [singleton]
    celltype #{name} {
        entry sInitializeTECSBridge eInitialize;
    };
};
EOT
          @@struct_list[ name ] = sttype
        end
      }

    else
      cdl_warning( "MRBW001 MrubyBridgePlugin: signature '$1' duplicate. ignored current one", @signature.get_namespace_path )
      @@celltypes[ @celltype_name ] << self
    end
  end

  #=== gen_cdl_file ������������륿���פ� ���������뤬������줿
  # cell �Υ��륿���פ�̾���� @celltype_name
  def new_cell cell
    if cell.get_celltype.get_name != @celltype_name then
      return
    end

    join = cell.get_join_list.get_item :VMname
    if join then
      vm_name = CDLString.remove_dquote(join.get_rhs.to_s).to_sym
    else
      vm_name = :"VM"
    end

    if @@VM_list[ vm_name ] == nil then
      @@VM_list[ vm_name ] = true

      initializer_celltype_cdl = "#{$gen}/#{cell.get_name}Initializer.cdl"
      file = CFile.open( initializer_celltype_cdl, "w" )

      # TECS ���������(�ץ�ȥ��������)
      print_msg "  MrubyBridgePlugin: join your VM's cInitialize to #{vm_name}_TECSInitializer.eInitialize\n"

      file.print <<EOT

  // prototype of TECSInitializer (MBP510)
  cell nMruby::tTECSInitializer #{vm_name}_TECSInitializer;
EOT
      file.close

      Generator.parse( initializer_celltype_cdl, self )
    end

    if @@VM_celltypes[ vm_name ] then
      vma = @@VM_celltypes[ vm_name ]

      if vma[ @celltype_name ] then
        vma[ @celltype_name ] << cell
      else
        vma[ @celltype_name ] = [cell]
        @@VM_celltypes[ vm_name ] = vma
      end
    else
      vma = { }
      vma[ @celltype_name ] = [cell]
      @@VM_celltypes[ vm_name ] = vma
    end

    @struct_list.each{ |stname, sttype|
      if @@VM_struct_list[ vm_name ] then
        @@VM_struct_list[ vm_name ][ sttype.get_name ] = sttype
      else
        @@VM_struct_list[ vm_name ] = { sttype.get_name => sttype }
      end
    }
    @ptr_list.each{ |ptr_celltype_name, tment|
      if @@VM_ptr_list[ vm_name ] then
        @@VM_ptr_list[ vm_name ][ ptr_celltype_name ] = tment
      else
        @@VM_ptr_list[ vm_name ] = { ptr_celltype_name => tment }
      end
    }

  end

  #=== �ץ饰���� CDL �� POST �����ɤ�����
  # tmp_plugin_post_code.cdl �ؤν���
  def self.gen_post_code file

#     file.print <<EOT
# namespace nMruby {
# EOT
# 
#     @@ptr_list.each{ |name,tment|
#       file.print <<EOT
# 
#     // MBP600
#     [singleton]
#     celltype #{name} {
#         entry  sInitializeTECSBridge eInitialize;
#     };
# EOT
#     }
# 
#     file.print <<EOT
# };
# EOT

# gen_post_code ���������� celltype �� gen_ep_func ���ƤӽФ���ʤ� #847
#    @@struct_list.each{ |name,sttype|
#      file.print <<EOT
#
#    [singleton]
#    celltype #{name} {
#        entry  sInitializeTECSBridge eInitialize;
#    };
#EOT
#    }

    file.print "  // MBP601\n"
    @@VM_celltypes.each{ |vm_name, instance_list|
      instance_list.each { |celltype_name, array|
        cell = array[0]
	if cell.get_celltype then
	  ct_name = cell.get_celltype.get_name
        file.print <<EOT
  cell nMruby::#{ct_name}_Initializer #{vm_name}_#{ct_name}_Initializer{ };
EOT
        end
      }
    }

    file.print "  // MBP602\n"
    @@ptr_list.each{ |name,tment|
      file.print <<EOT
  cell nMruby::#{name} C#{name} { };
EOT
    }

    file.print "  // MBP603\n"
    @@struct_list.each{ |name,sttype|
      file.print <<EOT
  cell nMruby::#{name} C#{name} { };
EOT
    }

    if @@VM_celltypes == nil
      raise "are0"
    end
    @@VM_celltypes.each{ |vm_name, instance_list|
      file.print "  /* === VM #{vm_name} === (MBP610) */\n"
      init_cell_name = "#{vm_name}_TECSInitializer"

      file.print "  cell nMruby::tTECSInitializer #{init_cell_name} {\n"

      instance_list.each { |celltype_name, array|
        array.each{ |cell|
          ct_name = cell.get_celltype.get_name
          file.print "    cInitialize[] = #{vm_name}_#{ct_name}_Initializer.eInitialize;\n"
        }
      }
      if @@VM_ptr_list[vm_name] then
        @@VM_ptr_list[vm_name].each{ |name, tment|
          file.print "    cInitialize[] = C#{name}.eInitialize;\n"
        }
      end
      if @@VM_struct_list[vm_name] then
        @@VM_struct_list[vm_name].each{ |name, sttype|
          file.print "    cInitialize[] = C#{name}.eInitialize;\n"
        }
      end
      file.print "  };"
    }
    
  end

  ####### �ʲ������������ʳ� ######

  #===  �������ؿ������Υ����ɤ�������Ƭ�������������ӽ��ϡ�
  #ct_name:: Symbol    (�ץ饰������������줿) ���륿����̾ ��Symbol �Ȥ��������Ƥ���
  def gen_ep_func_body( file, b_singleton, ct_name, global_ct_name, sig_name, ep_name, func_name, func_global_name, func_type, params )
    if @@celltypes[ ct_name ] then
      gen_ep_func_body_bridge( file, b_singleton, ct_name, global_ct_name, sig_name, ep_name, func_name, func_global_name, func_type, params )
    elsif @@init_celltypes[ ct_name ] then
      gen_ep_func_body_bridge_init( file, b_singleton, ct_name, global_ct_name, sig_name, ep_name, func_name, func_global_name, func_type, params )
    elsif @@ptr_list[ ct_name ] then
      gen_ep_func_body_ptr( file, b_singleton, ct_name, global_ct_name, sig_name, ep_name, func_name, func_global_name, func_type, params )
    elsif @@struct_list[ ct_name ] then
      gen_ep_func_body_struct( file, b_singleton, ct_name, global_ct_name, sig_name, ep_name, func_name, func_global_name, func_type, params )
    else
      raise "Unknown #{ct_name}"
    end
  end

  def gen_ep_func_body_bridge( file, b_singleton, ct_name, global_ct_name, sig_name, ep_name, func_name, func_global_name, func_type, params )
    raise "unexpected "
  end

  def gen_ep_func_body_bridge_init( file, b_singleton, ct_name, global_ct_name, sig_name, ep_name, func_name, func_global_name, func_type, params )
    file.print <<EOT
    CELLCB *p_cellcb = GET_CELLCB( idx );  /* no error check */     /* MBP700 */
    struct RClass	*rc;

    rc = mrb_define_class_under( mrb, TECS, \"#{@class_name}\", mrb->object_class );
    mrb_define_method( mrb, rc, "initialize", MrubyBridge_#{@celltype_name}_initialize, ARGS_REQ(1) );
    MRB_SET_INSTANCE_TT(rc, MRB_TT_DATA);
EOT

    @func_head_array.each{ |f|
      if ! f.is_function? then
        next
      end
      if f.get_name != :initialize then
        func_name = f.get_name
      else
        func_name = :initialize_cell
      end

      ret_type = f.get_return_type
      n_param = 0
      f.get_paramlist.get_items.each{ |param|
        case param.get_direction
        when :IN, :INOUT, :OUT
          n_param += 1
        when :SEND, :RECEIVE
          raise "send, receive"
        end
      }
      if n_param > 0 then
        p_str = "ARGS_REQ( #{n_param} )"
      else
        p_str = "ARGS_NONE()"
      end
      file.print <<EOT
	mrb_define_method( mrb, rc, "#{func_name}", MrubyBridge_#{@celltype_name}_#{func_name}, #{p_str} );
EOT
    }
  end

  def gen_ep_func_body_ptr( file, b_singleton, ct_name, global_ct_name, sig_name, ep_name, func_name, func_global_name, func_type, params )
    
    t = @@ptr_list[ct_name]
    type = t[1]
    file.print <<EOT
	struct RClass *a;                                /* MBP710 */

    a = mrb_define_class_under(mrb, TECS, "#{type}Pointer", mrb->object_class);
    MRB_SET_INSTANCE_TT(a, MRB_TT_DATA);

    mrb_define_method(mrb, a, "initialize",      #{type}Pointer_initialize,   ARGS_REQ(1));
    mrb_define_method(mrb, a, "[]",              #{type}Pointer_aget,         ARGS_REQ(1));
    mrb_define_method(mrb, a, "value",           #{type}Pointer_get_val,      ARGS_NONE());
    mrb_define_method(mrb, a, "[]=",             #{type}Pointer_aset,         ARGS_REQ(2));
    mrb_define_method(mrb, a, "value=",          #{type}Pointer_set_val,      ARGS_REQ(1));
    mrb_define_method(mrb, a, "size",            #{type}Pointer_size,         ARGS_NONE());
    mrb_define_method(mrb, a, "length",          #{type}Pointer_size,         ARGS_NONE());
EOT

    if t[2] == :Char then
      file.print <<EOT
	mrb_define_method(mrb, a, "to_s",            CharPointer_to_s, ARGS_NONE());
	mrb_define_method(mrb, a, "from_s",          CharPointer_from_s, ARGS_REQ(1));
EOT
    end
  end

  def gen_ep_func_body_struct( file, b_singleton, ct_name, global_ct_name, sig_name, ep_name, func_name, func_global_name, func_type, params )
    tag = ct_name
    structType = @@struct_list[ tag ]
    file.print  <<EOT
	struct RClass *a;                                /* MBP720 */

	a = mrb_define_class_under(mrb, TECS, "Struct#{tag}", mrb->object_class);
	MRB_SET_INSTANCE_TT(a, MRB_TT_DATA);

	mrb_define_method(mrb, a, "initialize", Struct_#{tag}_initialize, ARGS_NONE());
EOT

      structType.get_members_decl.get_items.each{ |d|
        file.print "  STRUCT_INIT_MEMBER( #{tag}, #{d.get_name} )\n"
      }
  end

  #===  �������ؿ��� preamble (C����)����������
  #     ɬ�פʤ� preamble ���˽��Ϥ���
  #file::           FILE        ������ե�����
  #b_singleton::    bool        true if singleton
  #ct_name::        Symbol
  #global_ct_name:: string
  def gen_preamble( file, b_singleton, ct_name, global_ct_name )
    if @@celltypes[ ct_name ] then
      gen_preamble_mruby( file, b_singleton, ct_name, global_ct_name )
      gen_preamble_instance( file, b_singleton, ct_name, global_ct_name )
      gen_preamble_instance_initialize( file, b_singleton, ct_name, global_ct_name )
      gen_preamble_bridge_func( file, b_singleton, ct_name, global_ct_name )
    elsif @@init_celltypes[ ct_name ] then
      gen_preamble_mruby( file, b_singleton, ct_name, global_ct_name )
      gen_preamble_instance_proto( file, b_singleton, ct_name, global_ct_name )
    elsif @@ptr_list[ ct_name ] then
      gen_preamble_ptr( file, b_singleton, ct_name, global_ct_name )
    elsif @@struct_list[ ct_name ] then
      gen_preamble_struct( file, b_singleton, ct_name, global_ct_name )
    else
      raise "Unknown #{ct_name}"
    end
  end

  def gen_preamble_mruby( file, b_singleton, ct_name, global_ct_name )
    file.print <<EOT
/* MBP: MrubyBridgePlugin: MBP000 */
#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "mruby/string.h"
#include "TECSPointer.h"
#include "TECSStruct.h"

#if defined(_WIN32) || defined(__WIN32__) || defined(__CYGWIN__)
#define DLLEXPORT __declspec(dllexport)
#else
#define DLLEXPORT
#endif

#ifndef NULL
#define NULL 0
#endif
EOT
  end

  def gen_preamble_instance( file, b_singleton, ct_name, global_ct_name )
    file.print <<EOT

/* RData MBP001 */
static void 
#{@celltype_name}_free( mrb_state *mrb, void *p )
{
	if( p )
		(void)mrb_free( mrb, p );
}

/* RData MBP002 */
struct mrb_data_type data_type_#{@celltype_name} =
{
	"#{@celltype_name}",
	#{@celltype_name}_free
};

/* RData MBP003 */
struct tecs_#{@celltype_name} {
    CELLCB  *cbp;
};

/* name_to_cbp MBP010 */
const struct name_to_cbp_#{@celltype_name} {
    char   *name;    /* Cell Name */
    CELLCB *cbp;
} Name_to_cbp_#{@celltype_name}[] = {
EOT

    # mikan namespace
    nsp = NamespacePath.new( :nMruby, true )
    nsp.append! ct_name
    ct = Namespace.find nsp

    ct.get_cell_list.each{ |cell|
      if cell.is_generate? then
        name_array = ct.get_name_array( cell )
        file.print "\t{ \"#{cell.get_name}\", #{name_array[8]} },\n"
      end
    }

    file.print <<EOT
\t{ 0, 0 },
};

EOT

  end

  def gen_preamble_ptr( file, b_singleton, ct_name, global_ct_name )
    tment = @@ptr_list[ ct_name ]
    file.print <<EOT

GET_SET_#{tment[3]}( #{tment[1]}, #{tment[0]} )
POINTER_CLASS( #{tment[1]}, #{tment[0]} )
EOT
  end

  def gen_preamble_struct( file, b_singleton, ct_name, global_ct_name )
    tag = ct_name
    structType = @@struct_list[ tag ]
    file.print <<EOT
/* struct #{tag} */
STRUCT_CLASS( #{tag} )
EOT

    structType.get_members_decl.get_items.each{ |d|
      type = d.get_type.get_original_type
      case type
      when IntType, CIntType
        bit_size = type.get_bit_size
        case bit_size
        when -11, -1
          tType = "Char"
          ttype = "char"
        when -2
          tType = "Short"
          ttype = "short"
        when -3
          tType = "Int"
          ttype = "int"
        when -4
          tType = "Long"
          ttype = "long"
        when -5
          tType = "IntPtr"
          ttype = "intptr"
        when 8, 16, 32, 64
          tType = "Int#{bit_size}"
          ttype = "int#{bit_size}"
        else
            raise "cannot handle bit_size #{bit_size}"
        end
        file.print "MEMBER_GET_SET_INT( #{tag}, #{d.get_name}, #{tType}, #{ttype} )\n"
      when FloatType, CFloatType
        file.print "MEMBER_GET_SET_FLOAT( #{tag}, #{d.get_name} )\n"
      else
        raise "cannot handle type"
      end
    }

  end

  def gen_preamble_instance_proto( file, b_singleton, ct_name, global_ct_name )
    file.print <<EOT
//  Prototype MBP400
mrb_value  MrubyBridge_#{@celltype_name}_initialize( mrb_state *mrb, mrb_value self);
EOT

    @func_head_array.each{ |f|
      if ! f.is_function? then
        next
      end
      if f.get_name != :initialize then
        func_name = f.get_name
      else
        func_name = :initialize_cell
      end

      ret_type  = f.get_return_type
      ret_type0 = f.get_return_type.get_original_type
      b_void    = ret_type0.is_void?
      plist     = f.get_paramlist.get_items

      file.print <<EOT
mrb_value  MrubyBridge_#{@celltype_name}_#{func_name}( mrb_state *mrb, mrb_value self );
EOT
    }
  end

  def gen_preamble_instance_initialize( file, b_singleton, ct_name, global_ct_name )
    file.print <<EOT

/* MBP100 */
mrb_value
MrubyBridge_#{@celltype_name}_initialize( mrb_state *mrb, mrb_value self)
{
	mrb_value	name;
	struct tecs_#{@celltype_name} *tecs_cb;
	const struct name_to_cbp_#{@celltype_name} *ntc;

	/* set DATA_TYPE earlier to avoid SEGV */
	DATA_TYPE( self ) = &data_type_#{@celltype_name};

	mrb_get_args(mrb, "o", &name );
	if( mrb_type( name ) != MRB_TT_STRING ){
		mrb_raise(mrb, E_NAME_ERROR, "cell name not string");
	}
	for( ntc = &Name_to_cbp_#{@celltype_name}[0]; ntc->name != NULL; ntc++ ){
		if( strcmp( ntc->name, RSTRING_PTR( name ) ) == 0 )
			break;
	}
	if( ntc->name == 0 ){
		mrb_raise(mrb, E_ARGUMENT_ERROR, "cell not found");
	}
	tecs_cb = (struct tecs_#{@celltype_name} *)mrb_malloc(mrb, sizeof(struct tecs_#{@celltype_name}) );
	tecs_cb->cbp = ntc->cbp;
	DATA_PTR( self ) = (void *)tecs_cb;

	return self;
}
EOT
  end

  def gen_preamble_bridge_func( file, b_singleton, ct_name, global_ct_name )

    @func_head_array.each{ |f|
      if ! f.is_function? then
        next
      end
      if f.get_name != :initialize then
        func_name = f.get_name
      else
        func_name = :initialize_cell
      end

      ret_type  = f.get_return_type
      ret_type0 = f.get_return_type.get_original_type
      b_void    = ret_type0.is_void?
      plist     = f.get_paramlist.get_items

      file.print <<EOT

/* bridge function (MBP101) */
mrb_value
MrubyBridge_#{ct_name}_#{func_name}( mrb_state *mrb, mrb_value self )
{
	/* cellcbp (MBP105) */
	CELLCB	*p_cellcb = ((struct tecs_#{@celltype_name} *)DATA_PTR(self))->cbp;
EOT
      
      file.print "	/* variables for return & parameter (MBP110) */\n"
      if ! b_void then
        file.print "	", ret_type.get_type_str, "\tret_val", ret_type.get_type_str_post, ";\n"
      end
      arg_str = ""
      n_param  = 0
      n_scalar = 0
      n_ptr    = 0
      n_struct = 0
      plist.each{ |param|
        case param.get_direction
        when :IN, :INOUT, :OUT
          type = param.get_type.get_original_type
          case type
          when IntType
            file.print "	mrb_int	mrb_", param.get_name, ";\n"
            file.print "	#{param.get_type.get_type_str}	#{param.get_name}#{param.get_type.get_type_str_post};\n"
            arg_str += "i"
            n_param += 1
            n_scalar += 1
          when FloatType
            file.print "	mrb_float	mrb_", param.get_name, ";\n"
            file.print "	#{param.get_type.get_type_str}	#{param.get_name}#{param.get_type.get_type_str_post};\n"
            arg_str += "f"
            n_param += 1
            n_scalar += 1
          when BoolType
            file.print "	mrb_value	mrb_", param.get_name, ";\n"
            file.print "	#{param.get_type.get_type_str}	#{param.get_name}#{param.get_type.get_type_str_post};\n"
            arg_str += "o"
            n_param += 1
            n_scalar += 1
          when PtrType
            file.print "	mrb_value	mrb_", param.get_name, ";\n"
            file.print "	#{param.get_type.get_type_str}	#{param.get_name}#{param.get_type.get_type_str_post};\n"
            arg_str += "o"
            n_param += 1
            n_ptr += 1
          when StructType
            file.print "	mrb_value	mrb_", param.get_name, ";\n"
            file.print "	#{param.get_type.get_type_str}	*#{param.get_name}#{param.get_type.get_type_str_post};\n"
            arg_str += "o"
            n_param += 1
            n_struct += 1
          else
            raise "Unkown type"
          end
        end
      }

      if n_param > 0 then
        file.print "	/* retrieve arguments (MBP111) */\n"
        file.print "	mrb_get_args(mrb, \"#{arg_str}\""
        plist.each{ |param|
          case param.get_direction
          when :IN, :INOUT, :OUT
            type = param.get_type.get_original_type
            case type
            when IntType
              file.print ", &mrb_", param.get_name
            when FloatType
              file.print ", &mrb_", param.get_name
            when BoolType
              file.print ", &mrb_", param.get_name
            when PtrType
              file.print ", &mrb_", param.get_name
            when StructType
              file.print ", &mrb_", param.get_name
            else
              raise "Unkown type"
            end
          end
        }
        file.print " );\n"

        if n_scalar > 0 || n_struct > 0 then
          file.print "	/* convert mrb to C (MBP112) */\n"
        end
        plist.each{ |param|
          case param.get_direction
          when :IN, :INOUT, :OUT
            type = param.get_type.get_original_type
            case type
            when IntType
              ttype = type.get_original_type
              tment = get_type_map_ent ttype
              file.print "	VALCHECK_#{tment[1]}( mrb, mrb_#{param.get_name} );\n"
              file.print "	#{param.get_name} = (#{param.get_type.get_type_str})mrb_#{param.get_name};\n"
            when FloatType
              file.print "	#{param.get_name} = (#{param.get_type.get_type_str})mrb_#{param.get_name};\n"
            when BoolType
              file.print "	#{param.get_name} = mrb_test( mrb_#{param.get_name} );\n"
            when PtrType
              ttype = type.get_type.get_original_type
              case ttype
              when StructType
                file.print "	CHECK_STRUCT( #{ttype.get_name}, mrb_#{param.get_name} );\n"
                file.print "	#{param.get_name} = (struct #{ttype.get_name}*)DATA_PTR(mrb_#{param.get_name});\n"
              when IntType
              when FloatType
              when BoolType
              else
                raise "cannot handle type"
              end
            when StructType
              file.print "	CHECK_STRUCT( #{type.get_name}, mrb_#{param.get_name} );\n"
              file.print "	#{param.get_name} = (struct #{type.get_name}*)DATA_PTR(mrb_#{param.get_name});\n"
            else
              raise( "canot treat class" )
            end
          end
        }

        if n_ptr > 0 then
          file.print "	/* convert mrb to C for pointer types (MBP113) */\n"
        end
        plist.each{ |param|
          case param.get_direction
          when :IN, :INOUT, :OUT
            type = param.get_type.get_original_type
            case type
            when IntType
            when FloatType
            when BoolType
            when PtrType
              case type.get_type.get_original_type
              when StructType
              when IntType
                ptrMrb2C file, type, param
              when FloatType
                ptrMrb2C file, type, param
              when BoolType
                ptrMrb2C file, type, param
              else
                raise "cannot handle type"
              end
            when StructType
            else
              raise( "canot treat class" )
            end
          end
        }

      end

      file.print "	/* calling target (MBP120) */\n"
      if ! b_void then
        file.print "	ret_val = "
      else
        file.print "	"
      end
      delim = ""
      file.print "cTECS_", f.get_name, "( "
      plist.each{ |param|
        if param.get_type.get_original_type.kind_of? StructType then
          aster = "*"
        else
          aster = ""
        end
        file.print delim, aster, param.get_name
        delim = ", "
      }
      file.print " );\n"
      
      file.print "	/* return (MBP130) */\n"
      case ret_type0
      when BoolType
        file.print "	return ret_val ? mrb_true_value() : mrb_false_value();\n"
      when IntType
        file.print "	return mrb_fixnum_value( ret_val );\n"
      when FloatType
        file.print "	return mrb_float_value( ret_val );\n"
      when VoidType
        file.print "	return  mrb_nil_value();\n"
      else
        raise "unknown type"
      end

      file.print "}\n"
    }
  end

  def ptrMrb2C file, type, param
    ttype = type.get_type.get_original_type
    tment = get_type_map_ent ttype
    tstr = tment[1]
=begin
    case ttype
    when IntType
      bit_size = ttype.get_bit_size
      case bit_size
      when -1, -11
        tstr = "Char"
      when 8, 16, 32, 64
        tstr = "Int#{bit_size}"
      when -2
        tstr = "Short"
      when -3
        tstr = "Int"
      when -4
        tstr = "Long"
      when -5
        tstr = "IntPtr"
      else
        raise "not handle type"
      end
    when FloatType
      if ttype.get_bit_size == 32 then
        tstr = "Float32"
      else
        tstr = "Double64"
      end
    when BoolType
      tstr = "Bool"
    when StructType
      raise "not handle type 2 #{ttype}"
    else
      raise "not handle type 2 #{ttype}"
    end
=end
    if( param.get_size ) then
      sz_str = param.get_size.to_s
    elsif param.get_string then      # mikan �Ȥꤢ���� size_is �� string ��Ʊ������ (��ťݥ���) �Ϥʤ�
      sz_str = param.get_string.to_s
    else
      sz_str = "1"
    end
    # unsigned ���ξ��ˤ� cast ��ɬ��
    if ttype.get_original_type.get_type_str != param.get_type.get_type.get_type_str then
      cast_str = "(#{param.get_type.get_type_str})"
    else
      cast_str = ""
    end

    modify = ""
    case param.get_direction
    when :OUT, :INOUT
      case tstr
      when "Char", "SChar", "UChar"
        modify = "Mod"
      end
    end

    # file.print "	CHECK_POINTER( #{tstr}, mrb_#{param.get_name}, #{sz_str} );\n"
    # file.print "	#{param.get_name} = #{cast_str}((struct #{tstr}PointerBody*)(DATA_PTR(mrb_#{param.get_name})))->buf;\n"
    file.print "	#{param.get_name} = CheckAndGet#{tstr}Pointer#{modify}( mrb, mrb_#{param.get_name}, #{sz_str} );\n"
  end

  def get_celltype_name
    @celltype_name
  end

  #=== �ץ饰������� ignoreUnsigned
  def set_ignoreUnsigned rhs
    if rhs == "true" || rhs == nil then
      @b_ignoreUnsigned = true
    end
  end
  #=== �ץ饰������� include
  def set_include rhs
    funcs = rhs.split ','
    funcs.each{ |rhs_func|
      found = false
      rhs_func.gsub!( /\s/, "" )
      @signature.get_function_head_array.each{ |a|
        if rhs_func.to_sym == a.get_name then
          found = true
        end
      }
      if found == false then
        cdl_error( "MRB1009 include function '$1' not found in signagture '$2'", rhs, @signature.get_name )
      else
        @includes << rhs_func.to_sym
      end
    }
  end
  #=== �ץ饰������� exclude
  def set_exclude rhs
    funcs = rhs.split ','
    funcs.each{ |rhs_func|
      found = false
      rhs_func.gsub!( /\s/, "" )
      @signature.get_function_head_array.each{ |a|
        if rhs_func.to_sym == a.get_name then
          found = true
        end
      }
      if found == false then
        cdl_error( "MRB1010 exclude function '$1' not found in signagture '$2", rhs, @signature.get_name )
      else
        @excludes << rhs_func.to_sym
      end
    }
  end
end

