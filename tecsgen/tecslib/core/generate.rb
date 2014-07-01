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
#   $Id: generate.rb 1951 2013-05-01 08:48:13Z okuma-top $
#++

def ifdef_macro_only f
  f.print <<EOT
#ifndef TOPPERS_MACRO_ONLY

EOT
end

def ifndef_macro_only f
  f.print <<EOT
#ifndef TOPPERS_MACRO_ONLY

EOT
end

def endif_macro_only f
  f.print <<EOT
#endif /* TOPPERS_MACRO_ONLY */

EOT
end

def ifndef_cb_type_only f
  f.print <<EOT
#ifndef TOPPERS_CB_TYPE_ONLY

EOT
end

def ifdef_cb_type_only f
  f.print <<EOT
#ifdef TOPPERS_CB_TYPE_ONLY

EOT
end

def endif_cb_type_only f
  f.print <<EOT
#endif /* TOPPERS_CB_TYPE_ONLY */

EOT
end


def print_note( f, b_complete = true )
  if b_complete
    f.print "/*\n"
  else
    f.print " *\n"
  end
  f.print TECSMsg.get( :note )
  if b_complete
    f.print " */\n"
  else
    f.print " *\n"
  end
end

def print_Makefile_note f
  f.print TECSMsg.get( :Makefile_note )
end


def print_indent( f, n )
  f.print "    " * n
end

# celltype_private.h ������

class Namespace
  def generate

    begin
      # root namespace �ʤ�� makefile ����Ϥ���(�����륿���פ˴ؤ���Τ���)
      # ��˽��Ϥ���
      if @name == "::" then

        gen_makefile_template
        gen_makefile_tecsgen
        if $generating_region.get_n_cells == 0 then
          dbgPrint "only makefile_template #{@name}\n"
          return
        end
      end

      dbgPrint "generating region: #{$generating_region.get_name} namespace=#{@name} gen_dir=#{$gen}\n"
      # global_tecsgen.h (typedef, struct, const) ������
      gen_global_header

      # signature �Υ����ɤ�����
      @signature_list.each { |s|
        s.generate
      }

      # celltype �Υ����ɤ�����
      @celltype_list.each { |t|
        t.generate
      }

      # ���֥͡��ॹ�ڡ����Υ����ɤ�����
      @namespace_list.each { |n|
        n.generate
      }

    rescue => evar
      # �⤷�����å��ȥ졼�����Ф�ޤǤ����֤�������褦�ʤ�С����򥳥��ȥ����Ȥ��Ƥߤ�٤�
      cdl_error( "H1001 tecsgen: fatal internal error during code generation"  )
      print_exception( evar )
    end
  end

  def generate_post

    if $generating_region.get_n_cells == 0 then
      return
    end

    begin
      # global_tecsgen.h (typedef, struct, const) �ν����Υ����ɥ���������
      gen_global_header_post

      # signature �Υ����ɤ�����
      @signature_list.each { |s|
        s.generate_post
      }

      # celltype �Υ����ɤ�����
      @celltype_list.each { |t|
        t.generate_post
      }

      # ���֥͡��ॹ�ڡ����Υ����ɤ�����
      @namespace_list.each { |n|
        n.generate_post
      }

    rescue => evar
      cdl_error( "H1002 tecsgen: fatal internal error during post code generation"  )
      print_exception( evar )
    end
  end

###  
  def gen_global_header

    # global_tecs.h ������
    f = AppFile.open( "#{$gen}/global_tecsgen.h" )

    if @name == "::" then
      print_note f

      # �����ɥ����ɤ����
      f.print <<EOT
#ifndef GLOBAL_TECSGEN_H
#define GLOBAL_TECSGEN_H

EOT

      # import_C �ǻ��ꤵ�줿�إå��ե������ #include �����
      if Import_C.get_header_list2.length > 0 then
        # �إå� include �ν���
        f.printf TECSMsg.get( :IMP_comment ), "#_IMP_#"
        Import_C.get_header_list2.each{ |h|
          f.printf( "#include \"#{h}\"\n" )
        }
        f.printf( "/**/\n\n" )
      end

      ifndef_macro_only f
    end

    # typedef, struct, enum ������
    @decl_list.each { |d|

      # d �� Typedef, StructType, EnumType �Τ����줫
      if d.instance_of?( Typedef ) then

        # Typedef �ξ�硢declarator �� @type ����CType �Ǥʤ���
        if ! d.get_declarator.get_type.kind_of?( CType ) then
          d.gen_gh f
        end
      elsif ! d.kind_of?( CType ) then

        # CType �ǤϤʤ� (StructType �ޤ��� EnumType)
        d.gen_gh f
#     else
#       �����˳�������Τ� CStructType, CEnumType
      end
    }

    if @name == "::" then

      if $ram_initializer then

        gen_celltype_names( f, "extern void ", "_CB_initialize();\n", false )
        gen_celltype_names( f, "extern void ", "_CB_initialize();\n", true )
        f.print "\n#define INITIALZE_TECSGEN() \\\n"
        gen_celltype_names( f, "\t", "_CB_initialize();\\\n", false )
        gen_celltype_names( f, "\t", "_CB_initialize();\\\n", true )
        f.print( "/* INITIALIZE_TECSGEN terminator */\n\n" )
      end

      endif_macro_only f
    end

    # const ������  mikan
    @const_decl_list.each { |d|
      f.printf( "#define %-14s ((%s%s)%s)\n", d.get_global_name,
                d.get_type.get_type_str, d.get_type.get_type_str_post,
                d.get_initializer.eval_const2(nil) )
    }

    f.close

  end

  def gen_global_header_post

    # global_tecs.h �򳫤�
    f = AppFile.open( "#{$gen}/global_tecsgen.h" )

    if @name == "::" then
      f.print <<EOT

#endif /* GLOBAL_TECSGEN_H */
EOT
    end

    f.close

  end

  #=== Makefile.tecsgen, Makefile.templ �ν���
  # �����륿����̾����Ϥ�����ʬ�����
  #    ���ܥ᥽�åɤ� root namespace ���Ф��ƸƽФ���
  #     �ġ��Υ��륿���פΥ᡼���롼��� Celltype ���饹�ǽ���
  def gen_makefile
    gen_makefile_template
    gen_makefile_tecsgen
  end

  def gen_makefile_template

    return if $generate_no_template

    ### Makefile.templ ������
    f = AppFile.open( "#{$gen}/Makefile.templ" )

    print_Makefile_note f

    # Makefile ���ѿ��ν���
    f.printf TECSMsg.get( :MVAR_comment ), "#_MVAR_#"

    # TARGET �ν��� (������ $target �� region ̾����� .exe ���ղ�)
    target = $target
    if $generating_region != @@root_namespace then
      # �� region �Υ�󥯥������åȤξ��
      target += "-#{$generating_region.get_global_name}"
    end
    target += ".exe"
    f.print "TARGET = #{target}\n"
    f.print "TIMESTAMP = tecsgen.timestamp\n"

    f.print "TECSGEN_EXE = tecsgen\n"

    if $generating_region == @@root_namespace then
      f.print "BASE_DIR = .\n"
      vpath_lead = ""
    else
      f.print "BASE_DIR = ..\n"
      vpath_lead = "../"
    end

    f.print "CC = gcc\n"

    f.print "CFLAGS ="
    search_path = $import_path + TECSGEN::Makefile.get_search_path
    search_path.each{ |path|
      if TECSGEN.is_absolute_path? path then
        f.print( TECSGEN.subst_tecspath " -I #{path}" )
      else
        f.print " -I $(BASE_DIR)/#{path}"
      end
    }
    f.print " -I $(GEN_DIR)"
    $define.each{ |define| f.print " -D #{define}" }
    f.print ' -D "Inline=static inline"'
    vpath_add = ""
    search_path.each{ |path|
      if path != "." then
        if TECSGEN.is_absolute_path? path then
          vpath_add += " " + TECSGEN.subst_tecspath( path )
        else
          vpath_add += " " + vpath_lead + path
        end
      end
    }
    objs_add = ""
    TECSGEN::Makefile.get_objs.each{ |obj| objs_add += " " + obj }
    ld_flag_add = ""
    TECSGEN::Makefile.get_ldflags.each{ |ldflag| ld_flag_add += " " + ldflag }
    var_add = ""
    comments = TECSGEN::Makefile.get_var_comments
    TECSGEN::Makefile.get_vars.each{ |var, val|
      if comments[ var ] then
        comment = ""
        comments[ var ].each{ |com| comment += " " + com }
        var_add += "#" + comment + "\n"
      end
      var_add += var.to_s + " ="
      val.each{ |v|
        var_add += " " + v
      }
      var_add += "\n"
    }
    if var_add != "" then
      var_add = "\n# Additional VARS\n" + var_add
    end
    pre_tecsgen_target = ""
    TECSGEN::Makefile.get_pre_tecsgen_target{ |target| pre_tecsgen_target += " " + target }
    post_tecsgen_target = ""
    TECSGEN::Makefile.get_post_tecsgen_target{ |target| post_tecsgen_target += " " + target }

    f.print <<EOT

LD = gcc
LDFLAGS =#{ld_flag_add}
GEN_DIR = $(BASE_DIR)/#{$gen}
SRC_DIR = $(BASE_DIR)/src
_TECS_OBJ_DIR = $(GEN_DIR)/
#   _TECS_OBJ_DIR   # should end with '/'
PRE_TECSGEN_TARGET =#{pre_tecsgen_target}
POST_TECSGEN_TARGET =#{post_tecsgen_target}

vpath %.c $(SRC_DIR) $(GEN_DIR) #{vpath_add}
vpath %.h $(SRC_DIR) $(GEN_DIR) #{vpath_add}

OTHER_OBJS =#{objs_add}                      # Add objects out of tecs care.
# OTHER_OBJS = $(_TECS_OBJ_DIR)vasyslog.o
#{var_add}
EOT

    # make �롼��ν���
    f.printf( TECSMsg.get( :MRUL_comment), "#_MRUL_#" )

    f.print <<EOT
allall: tecs
\tmake all     # in order to include generated Makefile.tecsgen & Makefile.depend

EOT

    if $generating_region.get_n_cells != 0 then
      all_target = "$(TARGET)"
    else
      all_target = ""
    end

    if $generating_region == @@root_namespace then
      if Region.get_link_roots.length > 1 then
        all_target += " sub_regions"
      end
      timestamp = " $(TIMESTAMP)"
    else
      timestamp = ""
    end

    f.print "all : #{all_target}\n\n"
    f.printf TECSMsg.get( :MDEP_comment ), "#_MDEP_#"
    f.print "-include $(GEN_DIR)/Makefile.tecsgen\n"
    if $generating_region.get_n_cells != 0 then
      # Makefile.depend �� include
      f.print "-include $(GEN_DIR)/Makefile.depend\n\n"

      f.print "$(TARGET) :#{timestamp} $(CELLTYPE_COBJS) $(TECSGEN_COBJS) $(PLUGIN_COBJS) $(OTHER_OBJS)\n"
      f.print "	$(LD) -o $(TARGET) $(TECSGEN_COBJS) $(CELLTYPE_COBJS) $(PLUGIN_COBJS) $(OTHER_OBJS) $(LDFLAGS)\n"
    end

    if Region.get_link_roots.length > 1 && $generating_region == @@root_namespace then
      f.print "\nsub_regions:$(TIMESTAMP)\n"
      Region.get_link_roots.each {|region|
        if region.get_global_name != "" then  # Root region: ���� Makefile ����
          f.print "\tcd #{region.get_global_name}; make all\n"
        end
      }
      f.print "\n"
    end

    # clean: �������å�
    f.print "clean :\n"
    if $generating_region == @@root_namespace then
      Region.get_link_roots.each {|region|
        if region.get_global_name != "" then  # Root region: ���� Makefile ����
          f.print "\tcd #{region.get_global_name}; make clean\n"
        end
      }
    end
	f.print "	rm -f $(CELLTYPE_COBJS) $(TECSGEN_COBJS) $(PLUGIN_COBJS) $(OTHER_OBJS) $(TARGET) #{timestamp}\n"
    if $generating_region == @@root_namespace then
      f.print "	rm -rf $(GEN_DIR)\n"
    end
    f.print "\n"

    # tecs: �������å�
    if $generating_region == @@root_namespace then
      f.print "tecs : $(PRE_TECSGEN_TARGET) $(TIMESTAMP) $(POST_TECSGEN_TARGET)\n\n"
      f.print "$(TIMESTAMP) : $(TECS_IMPORTS)\n"
      f.print "	$(TECSGEN_EXE) #{TECSGEN.subst_tecspath( $arguments, true )}\n"
      f.print "	touch $(TIMESTAMP)\n\n"
      f.print "# generic target for objs\n"
      f.print "$(_TECS_OBJ_DIR)%.o : %.c\n"
      f.print "	$(CC) -c $(CFLAGS) -o $@ $<\n\n"

    else
      f.print "tecs:\n"
      f.print "\t@echo \"run 'make tecs' in root region\"\n\n"
    end

    f.close
  end

  def gen_makefile_tecsgen
    ### Makefile.tecsgen ������
    f = AppFile.open( "#{$gen}/Makefile.tecsgen" )

    f.print( "TECS_IMPORT_CDLS =" )
    Import.get_list.each{ |cdl_expand_path, import|
      path = import.get_cdl_path
      if TECSGEN.is_absolute_path? path then
        path = TECSGEN.subst_tecspath path
      end
      f.print " "
      f.print( path )
    }
    f.print( "\n" )
    f.print( "TECS_IMPORT_HEADERS =" )
    Import_C.get_header_list.each{ |header,path|
      if TECSGEN.is_absolute_path? path then
        path = TECSGEN.subst_tecspath path
      end
      f.print " "
      f.print path
    }
    f.print "\n\n"

    f.print "TECS_IMPORTS = $(TECS_IMPORT_CDLS) $(TECS_IMPORT_HEADERS)\n\n"

    f.print( "TECSGEN_COBJS = \\\n" )
    gen_celltype_names( f, "	$(_TECS_OBJ_DIR)", "_tecsgen.o \\\n", false )
    f.print( "# TECSGEN_COBJS terminator\n\n" )

    f.print( "PLUGIN_COBJS = \\\n" )
    gen_celltype_names( f, "	$(_TECS_OBJ_DIR)", "_tecsgen.o \\\n", true )
    gen_celltype_names( f, "	$(_TECS_OBJ_DIR)", ".o \\\n", true, false )
    f.print( "# PLUGIN_COBJS terminator\n\n" )

    f.print( "CELLTYPE_COBJS = \\\n" )
    gen_celltype_names( f, "	$(_TECS_OBJ_DIR)", ".o \\\n", false, false )
    f.print( "# CELLTYPE_COBJS terminator\n\n" )

    f.print( "TECS_COBJS = $(TECSGEN_COBJS) $(PLUGIN_COBJS) $(CELLTYPE_COBJS)\n\n" )

    f.print( "TECSGEN_SRCS = \\\n" )
    gen_celltype_names( f, "	$(GEN_DIR)/", "_tecsgen.c \\\n", false )
    f.print( "# TECSGEN_SRCS terminator\n\n" )

    f.print( "PLUGIN_SRCS = \\\n" )
    gen_celltype_names( f, "	$(GEN_DIR)/", "_tecsgen.c \\\n", true )
    gen_celltype_names( f, "	$(GEN_DIR)/", ".c \\\n", true, false )
    f.print( "# PLUGIN_SRCS terminator\n\n" )

    f.close

  end

  #=== ���٤ƤΥ��륿���פ�̾�������
  #f::       FILE:   ������ե�����
  #prepend:: string: ����ʸ����
  #append::  string: ����ʸ����
  #b_plguin::  bool:   plugin �ˤ���������줿���륿���פ����
  ##b_inline_only::  bool:   true �ʤ�� inline �� entry port �ΤߤΥ��륿���פ�ޤ��
  #b_inline_only::  bool:   true �ʤ�� inline �� entry port �Τߡ����ĥ��󥢥��ƥ��֤ʥ��륿���פ�ޤ��
  #  namespace "::" ����ƽФ����
  def gen_celltype_names( f, prepend, append, b_plugin, b_inline_only = true )
    dbgPrint "gen_celltype_names #{@name}\n"

    str = ""
    @celltype_list.each { |ct|
      next if ! ct.need_generate?
#      next if b_inline_only == false && ct.is_all_entry_inline?
      next if b_inline_only == false && ct.is_all_entry_inline? && ! ct.is_active?
      if ( b_plugin && ct.get_plugin ) || ( ! b_plugin && ! ct.get_plugin ) then
        f.print " #{prepend}#{ct.get_global_name}#{append}"
      end
    }
    @namespace_list.each { |ns|
      ns.gen_celltype_names( f, prepend, append, b_plugin, b_inline_only )
    }

    return str
  end

end

class Typedef
  def gen_gh f

#    print "Typedef.gen_gh\n"
#    show_tree 1

    f.printf( "typedef %-14s %s%s;\n",
		"#{@declarator.get_type.get_type_str}",
		"#{@declarator.get_name}",
		"#{@declarator.get_type.get_type_str_post}")
  end
end

class StructType < Type
  def gen_gh f

#    print "StructType.gen_gh\n"
#    show_tree 1

    if ! @b_define then
      return
    end

    f.print "struct #{@tag} {\n"

    @members_decl.get_items.each{ |i|
      f.printf( "                %-14s %s%s;\n", "#{i.get_type.get_type_str}", "#{i.get_name}", "#{i.get_type.get_type_str_post}" )
    }

    f.print "};\n"

  end
end

class Signature

  def generate
    generate_signature_header
  end

  def generate_post
    generate_signature_header_post
  end

  def generate_signature_header
    f = AppFile.open("#{$gen}/#{@global_name}_tecsgen.h")

    print_note f
    gen_sh_guard f
    gen_sh_info f

    ifndef_macro_only f
    gen_sh_func_tab f
    endif_macro_only f
    gen_sh_func_id f

    f.close
  end

  def generate_signature_header_post
    f = AppFile.open("#{$gen}/#{@global_name}_tecsgen.h")
    gen_sh_endif f
    f.close
  end


#####  signature header

  def gen_sh_guard f
    f.print("#ifndef #{@global_name}_TECSGEN_H\n")
    f.print("#define #{@global_name}_TECSGEN_H\n\n")
  end

  def gen_sh_info f
    f.print <<EOT
/*
 * signature   :  #{@name}
 * global name :  #{@global_name}
 * context     :  #{get_context}
 */

EOT
  end

  def gen_sh_func_tab f

    # �����˥���ǥ�������ץ��ν���
    f.printf TECSMsg.get(:SD_comment), "#_SD_#"
    f.print "struct tag_#{@global_name}_VDES {\n"
    f.print "    struct tag_#{@global_name}_VMT *VMT;\n"
    f.print "};\n\n"

    # �����˥���ؿ��ơ��֥�ν���
    f.printf TECSMsg.get(:SFT_comment), "#_SFT_#"
    f.print( "struct tag_#{@global_name}_VMT {\n" )
    get_function_head_array.each{ |fun|
      f.print "    "
      functype = fun.get_declarator.get_type
      f.printf( "%-14s", functype.get_type_str )

      f.print( " (*#{fun.get_name}__T)(" )
      f.print( " struct tag_#{@global_name}_VDES *edp" ) unless @singleton

      if functype.get_paramlist then
        items = functype.get_paramlist.get_items
        len = items.length
      else
        # ������ nil �ˤʤ�Τϡ������ʤ��λ��� void ���ʤ��ä����
        items = []
        len = 0
      end

      i = 0
      items.each{ |param|
        f.print ", "
        f.print( param.get_type.get_type_str )
        f.print( " " )
        f.print( param.get_name )
        f.print( param.get_type.get_type_str_post )
        i += 1
      }
      f.print " );\n"
    }

    f.print "};\n"
  end

  #=== Signature# �ؿ��� ID �� define �����
  def gen_sh_func_id f
    f.print "/* function id */\n"
    get_function_head_array.each{ |fun|
      f.printf( "#define\tFUNCID_%-31s (%d)\n", "#{@global_name}_#{fun.get_name}".upcase, get_id_from_func_name( fun.get_name ) )
    }
    f.print "\n"
  end

  def gen_sh_endif f
    f.print("#endif /* #{@global_name}_TECSGEN_H */\n")
  end

end

class Celltype

  def generate

    if need_generate?    # ����Τʤ����륿���פ��������ʤ�

      generate_private_header
      generate_factory_header
      generate_cell_code
      generate_template_code
      generate_inline_template_code
      generate_celltype_factory_code
      generate_cell_factory_code
      generate_makefile

    elsif $generate_all_template   # �ƥ�ץ졼�ȥ������������ץ����

      generate_template_code
      generate_inline_template_code

      # generate_makefile_template �� Makefile ���ɵ������Τ����顢�ƤӽФ��ʤ�

    end

  end

  def generate_post
    return if ! need_generate?    # ����Τʤ����륿���פ��������ʤ�

    generate_private_header_post
    generate_factory_header_post
  end

  def generate_private_header

    f = AppFile.open("#{$gen}/#{@global_name}_tecsgen.h")

    print_note f

    gen_ph_guard f
    gen_ph_info f
    gen_ph_include f
	#
    ifndef_macro_only f
    f.print  <<EOT
#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */
EOT
    gen_ph_typedef_idx f          # mikan ���Ȥ����Τ��Ǥ��Ƥ��ʤ�
    f.print  <<EOT
#ifdef __cplusplus
}
#endif /* __cplusplus */
EOT
    endif_macro_only f
	#
    gen_ph_include_cb_type f

    if @n_entry_port_inline == 0 then
      # inline ���ʤ���� CB_TYPE_ONLY �Ȥ���
      # inline ����ξ�硢���ä��� define ���Ƥ����ơ���Ǥ��٤� undef ����
      ifndef_cb_type_only f
    end

    gen_ph_base f
    gen_ph_valid_idx f
    gen_ph_n_cp f                 if @n_call_port_array > 0
    gen_ph_n_ep f                 if @n_entry_port_array > 0
    gen_ph_test_optional_call_port f
    gen_ph_get_cellcb f
    gen_ph_attr_access f          if @n_attribute_rw > 0 || @n_attribute_ro > 0 || @n_var > 0
    gen_ph_cp_fun_macro f         if @n_call_port > 0
#    gen_ph_abstract_ep_des_type f

    if @n_entry_port_inline == 0 then
      endif_cb_type_only f
    end

    ifndef_macro_only f

    f.print  <<EOT
#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */
EOT

    gen_ph_cell_cb_type f
    gen_ph_INIB_as_CB f
    gen_ph_extern_cell f          # ���륿���ץ��륳���ɰʳ��ϻ��Ȥ��ʤ�
    # gen_ph_typedef_idx f          # mikan ���Ȥ����Τ��Ǥ��Ƥ��ʤ�
    gen_ph_ep_fun_prototype f

    f.print  <<EOT
#ifdef __cplusplus
}
#endif /* __cplusplus */
EOT

    endif_macro_only f

    # û�̷��ʤɤΥޥ������
    if @n_entry_port_inline == 0 then
      ifndef_cb_type_only f
    end
    gen_ph_valid_idx_abbrev f
    gen_ph_get_cellcb_abbrev f
    gen_ph_attr_access_abbrev f   if @n_attribute_rw > 0 || @n_attribute_ro > 0 || @n_var > 0
    gen_ph_cp_fun_macro_abbrev f  if @n_call_port > 0
    gen_ph_test_optional_call_port_abbrev f
    gen_ph_ep_fun_macro f         if @n_entry_port > 0
    gen_ph_foreach_cell f         # FOREACH �ޥ���ν���
    gen_ph_cb_initialize_macro f   # CB ������ޥ���ν��ϡ����񤷤ʤ��Τ� ram_initializer �ե饰�˴ؤ�餺����
    gen_ph_dealloc_code f, ""
    gen_ph_dealloc_code f, "_RESET"
    if @n_entry_port_inline == 0 then
      endif_cb_type_only f
    end

    f.close
  end

  def generate_private_header_post

    f = AppFile.open("#{$gen}/#{@global_name}_tecsgen.h")

    ifndef_macro_only f
    gen_ph_inline f
    endif_macro_only f

    if @n_entry_port_inline > 0 then
      ifdef_cb_type_only f
      f.printf TECSMsg.get( :UDF_comment ), "#_UDF_#"
      f.print "#undef VALID_IDX\n"
      f.print "#undef GET_CELLCB\n"
      f.print "#undef CELLCB\n"
      f.print "#undef CELLIDX\n"
      f.print "#undef #{@name}_IDX\n"

      f.print "#undef FOREACH_CELL\n"
      f.print "#undef END_FOREACH_CELL\n"
      f.print "#undef INITIALIZE_CB\n"
      f.print "#undef SET_CB_INIB_POINTER\n"

      @attribute.each { |a|
        f.print( "#undef ATTR_#{a.get_name}\n" )
        f.print( "#undef #{@global_name}_ATTR_#{a.get_name}\n" )
        f.print( "#undef #{@global_name}_GET_#{a.get_name}\n" )
      }
      @var.each { |v|
        f.print( "#undef VAR_#{v.get_name}\n" )
        f.print( "#undef VAR_#{v.get_name}\n" )
        f.print( "#undef #{@global_name}_VAR_#{v.get_name}\n" )
        f.print( "#undef #{@global_name}_GET_#{v.get_name}\n" )
        f.print( "#undef #{@global_name}_SET_#{v.get_name}\n" )
      }
      @port.each { |p|
        next if p.get_port_type != :CALL
        p.get_signature.get_function_head_array.each{ |fun|
          f.print( "#undef #{@global_name}_#{p.get_name}_#{fun.get_name}\n" )
          if ! p.is_require? || p.has_name? then
            f.print( "#undef #{p.get_name}_#{fun.get_name}\n" )
          else
            f.print( "#undef #{fun.get_name}\n" )
          end
        }
      }
      @port.each { |p|
        next if p.get_port_type != :ENTRY
        p.get_signature.get_function_head_array.each{ |fun|
          f.print( "#undef #{p.get_name}_#{fun.get_name}\n" )
        }
      }

      gen_ph_dealloc_code( f, "", true )
      gen_ph_dealloc_code( f, "_RESET", true )

      endif_cb_type_only f
    end

    gen_ph_endif f

    f.close
  end

  #=== CELLTYPE_tecsgen.c ������
  def generate_cell_code
    f = AppFile.open("#{$gen}/#{@global_name}_tecsgen.c")

    print_note f
    gen_cell_private_header f
    gen_cell_factory_header f
    gen_cell_ep_des_type f
    gen_cell_skel_fun f
    gen_cell_fun_table f
    gen_cell_ep_vdes f
    gen_cell_ep_vdes_array f
    gen_cell_cb_out_init f         # INITIALIZE_CB �ǻ��Ȥ���뤿�� ram_initializer=false �Ǥ�ä��ʤ�
    gen_cell_cb f
    gen_cell_ep_des f
    if $ram_initializer then
      gen_cell_cb_initialize_code f
    end

    f.close
  end

#####  celltype header

  def gen_ph_guard f
    f.print("#ifndef #{@global_name}_TECSGEN_H\n")
    f.print("#define #{@global_name}_TECSGEN_H\n\n")
  end

  def gen_ph_info f

    yn_idx_is_id = "no"
    yn_idx_is_id = "yes"  if @idx_is_id
    yn_singleton = "no"
    yn_singleton = "yes"  if @singleton
    yn_rom       = "no"
    yn_rom       = "yes"  if $rom
    # @singleton = false    # mikan singleton  060827

    f.print <<EOT
/*
 * celltype    :  #{@name}
 * global name :  #{@global_name}
 * idx_is_id   :  #{yn_idx_is_id}
 * singleton   :  #{yn_singleton}
 * has_CB      :  #{has_CB?}
 * has_INIB    :  #{has_INIB?}
 * rom         :  #{yn_rom}
 */

EOT
  end

  def gen_ph_include f
    # ��󥿥���إå��� include
#    f.printf TECSMsg.get( :IRTH_comment), "#_IRTH_#"
#    f.print "#include \"tecs.h\"\n\n"

    # �����Х�إå��� include
    f.printf TECSMsg.get( :IGH_comment ), "#_IGH_#"
    f.print "#include \"global_tecsgen.h\"\n\n"

    # �����˥���إå��� include
    f.printf TECSMsg.get( :ISH_comment ), "#_ISH_#"
    @port.each { |p|
      hname = "#{p.get_signature.get_global_name}_tecsgen.h".to_sym
      if header_included?( hname ) == false then
        f.print "#include \"#{hname}\"\n"
      end
    }
    f.print "\n"
  end

  def gen_ph_include_cb_type f

    if ! @b_cp_optimized then
      return
    end

    # ��Ŭ���Τ��Ỳ�Ȥ��륻�륿���פ� CB �������������
    # _CB_TYPE_ONLY ������������ include ����
    f.printf( TECSMsg.get( :ICT_comment ), "#_ICT_#" )

    f.print( "#ifndef  TOPPERS_CB_TYPE_ONLY\n" )
    f.print( "#define  #{@global_name}_CB_TYPE_ONLY\n" )
    f.print( "#define TOPPERS_CB_TYPE_ONLY\n" )
    f.print( "#endif  /* TOPPERS_CB_TYPE_ONLY */\n" )

    @port.each { |p|
      next if p.get_port_type != :CALL

      if p.is_skelton_useless? || p.is_cell_unique? || p.is_VMT_useless? then
        # ��Ŭ�������� (optimize) # ������ȥ����פʤ�
        p2 = p.get_real_callee_port
        if p2 then
          ct = p2.get_celltype
          hname = "#{ct.get_global_name}_tecsgen.h".to_sym
          if header_included?( hname ) == false then
            f.print( "#include \"#{hname}\"\n" )
          end
        # else
          # optional ��̤���
        end
      end

    }
    f.print( "#ifdef  #{@global_name}_CB_TYPE_ONLY\n" )
    f.print( "#undef TOPPERS_CB_TYPE_ONLY\n" )
    f.print( "#endif /* #{@global_name}_CB_TYPE_ONLY */\n" )

#    @port.each { |p|
#      next if p.get_port_type != :CALL
#      if p.is_skelton_useless? || p.is_cell_unique? || p.is_VMT_useless? then
#        # ��Ŭ�������� (optimize) # ������ȥ����פʤ�
#        p2 = p.get_real_callee_port
#        ct = p2.get_celltype
#        ct.gen_ph_typedef_idx f
#        ct.gen_ph_INIB_as_CB f
#        ct.gen_ph_extern_cell f
#        f.print "\n"
#      end
#    }

  end


  def gen_ph_base f
    return if @singleton

    # ID �δ������ӸĿ��� define �����
    f.printf("#define %-20s %10s  /* %s #_NIDB_# */\n", "#{@global_name}_ID_BASE", "(#{@id_base})", TECSMsg.get(:NIDB_comment))
    f.printf("#define %-20s %10s  /* %s  #_NCEL_# */\n\n", "#{@global_name}_N_CELL", "(#{@n_cell_gen})", TECSMsg.get(:NCEL_comment))
  end

  def gen_ph_valid_idx f
    return if @singleton

    # mikan  ��Ŭ��
    # IDX �����������å��ޥ���ν���
    f.printf( TECSMsg.get( :CVI_comment ), "#_CVI_#" )
    if @idx_is_id then
      f.print("#define #{@global_name}_VALID_IDX(IDX) (#{@global_name}_ID_BASE <= (IDX) && (IDX) < #{@global_name}_ID_BASE+#{@name}_N_CELL)\n\n")
    else
      f.print("#define #{@global_name}_VALID_IDX(IDX) (1)\n\n")
    end

  end

  def gen_ph_valid_idx_abbrev f
    return if @singleton

    # IDX �����������å��ޥ����û�̷��ˤν���
    f.printf( TECSMsg.get( :CVIA_comment ), "#_CVIA_#")
    f.print("#define VALID_IDX(IDX)  #{@global_name}_VALID_IDX(IDX)\n\n")

  end

  #=== �ƤӸ�������礭��������ޥ���ν���
  #
  #���륿���ץإå��ظƤӸ��θĿ������
  def gen_ph_n_cp f

    b_comment = false
    @port.each { |p|
      next if p.get_port_type != :CALL
      next if p.get_array_size == nil

      if ! b_comment then
        f.printf( TECSMsg.get( :NCPA_comment ), "#_NCPA_#" )
        b_comment = true
      end

      if p.get_array_size != "[]" then       # ����Ĺ����
        f.print( "#define N_CP_#{p.get_name}    (#{p.get_array_size})\n" )
        f.print( "#define NCP_#{p.get_name}     (#{p.get_array_size})\n" )
      else                                   # ����Ĺ����
        if @singleton then
          if has_INIB? then
            inib = "INIB"
          else
            inib = "CB"
          end
          f.print( "#define N_CP_#{p.get_name}  (#{@global_name}_SINGLE_CELL_#{inib}.n_#{p.get_name})\n" )
          f.print( "#define NCP_#{p.get_name}   (#{@global_name}_SINGLE_CELL_#{inib}.n_#{p.get_name})\n" )
          # mikan singleton �ʤ�С�����Ĺ���Ǥ���
        else
          if has_CB? && has_INIB? then
            inib = "->_inib"
          else
            inib = ""
          end
          f.print( "#define N_CP_#{p.get_name}(p_that)  ((p_that)#{inib}->n_#{p.get_name})\n" )
          f.print( "#define NCP_#{p.get_name}           (N_CP_#{p.get_name}(p_cellcb))\n" )
        end
      end
    }
  end

  #=== ������������礭��������ޥ���ν���
  #
  #���륿���ץإå��ؼ������θĿ������
  def gen_ph_n_ep f

    b_comment = false
    @port.each { |p|
      next if p.get_port_type != :ENTRY
      next if p.get_array_size == nil

      if ! b_comment then
        f.printf( TECSMsg.get( :NEPA_comment ), "#_NEPA_#" )
        b_comment = true
      end

      if p.get_array_size != "[]" then       # ����Ĺ����
        f.print( "#define NEP_#{p.get_name}     (#{p.get_array_size})\n" )
      else                                   # ����Ĺ����
        if @singleton then
          if has_INIB? then
            inib = "INIB"
          else
            inib = "CB"
          end
          f.print( "#define NEP_#{p.get_name}   (#{@global_name}_SINGLE_CELL_#{inib}.n_#{p.get_name})\n" )
          # mikan singleton �ʤ�С�����Ĺ���Ǥ���
        else
          if has_CB? && has_INIB? then
            inib = "->_inib"
          else
            inib = ""
          end
          f.print( "#define NEP_#{p.get_name}           ((p_cellcb)#{inib}->n_#{p.get_name})\n" )
        end
      end
    }
  end

  #=== optional �ʸƤӸ�����礵��Ƥ��뤫�ƥ��Ȥ��륳���ɤ�����
  def gen_ph_test_optional_call_port f
    b_comment = false

    if @singleton then
      if has_INIB? then
        inib = "INIB"
      else
        inib = "CB"
      end
    else
      if has_CB? && has_INIB? then
        inib = "->_inib"
      else
        inib = ""
      end
    end

    @port.each { |p|
      next if p.get_port_type != :CALL
      next if ! p.is_optional?

      if b_comment == false then
        f.printf( TECSMsg.get( :TOCP_comment ), "#_TOCP_#" )
        b_comment = true
      end

      if p.get_array_size == nil then
        f.print( "#define #{@global_name}_is_#{p.get_name}_joined(p_that) \\\n" )
      else
        f.print( "#define #{@global_name}_is_#{p.get_name}_joined(p_that,subscript) \\\n" )
      end

      # �ؿ�̾�ν���(ɸ�ࡧ�������ǥ�������ץ����� VMT �δؿ�̾����Ŭ�����������ؿ� or �������ǥ�������ץ�)
      # mikan  �����Ĥʤ��äƤ��뤫�ɤ����� (1) ��Ƚ�ꤹ��
      if ! p.is_VMT_useless? then
        # ɸ�ॳ����
        if p.get_array_size == nil then
          if @singleton then
            f.print( "\t  (#{@global_name}_SINGLE_CELL_#{inib}.#{p.get_name}!=0)\n" )
          else
            f.print( "\t  ((p_that)#{inib}->#{p.get_name}!=0)\n" )
          end
        else
          # ����ξ��
          if @singleton then
            f.print( "\t  ((#{@global_name}_SINGLE_CELL_#{inib}.#{p.get_name}!=0) \\\n" )
            f.print( "\t  &&(#{@global_name}_SINGLE_CELL_#{inib}.#{p.get_name}[subscript]!=0))\n" )
          else
            f.print( "\t  (((p_that)#{inib}->#{p.get_name}!=0)\\\n" )
            f.print( "\t  &&((p_that)#{inib}->#{p.get_name}[subscript]!=0))\n" )
          end
        end
      else
        # ��Ŭ�������� (optimize) # VMT ���ס��������Ǥ��٤�Ʊ����
        p2 = p.get_real_callee_port
        if p2 then
          ct = p2.get_celltype
          if p.is_skelton_useless? then
            # �������ؿ���ľ�ܸƽФ�
            f.print( "\t  (1)\n" )
          else
            # ������������ȥ�ؿ���ľ�ܸƽФ�
            f.print( "\t  (1)\n" )
          end
        else
          # optional ��̤���
          f.print( "\t  (0)    /* not joined */\n" )
        end
      end
    }
  end

  #=== optional �ʸƤӸ�����礵��Ƥ��뤫�ƥ��Ȥ��륳���ɤ�������û�̷���
  def gen_ph_test_optional_call_port_abbrev f
    b_comment = false

    @port.each { |p|
      next if p.get_port_type != :CALL
      next if ! p.is_optional?

      if b_comment == false then
        f.printf( TECSMsg.get( :TOCPA_comment ), "#_TOCPA_#" )
        b_comment = true
      end

      if p.get_array_size == nil then
        f.print( "#define is_#{p.get_name}_joined()\\\n\t\t#{@global_name}_is_#{p.get_name}_joined(p_cellcb)\n" )
      else
        f.print( "#define is_#{p.get_name}_joined(subscript)\\\n" )
        f.print( "\t\t#{@global_name}_is_#{p.get_name}_joined(p_cellcb,subscript)\n" )
      end
    }
  end

  #=== CELLCB �ؤΥݥ��󥿤�����ޥ�������
  #   ���륿���ץإå��ؽ���
  def gen_ph_get_cellcb f
    f.printf( TECSMsg.get( :GCB_comment ), "#_GCB_#" )
    if ( ! has_CB? && ! has_INIB? ) || @singleton then
      f.print( "#define #{@global_name}_GET_CELLCB(idx) ((void *)0)\n" )
    elsif @idx_is_id then   # mikan ñ��Υ���ξ��κ�Ŭ��, idx_is_id �Ǥʤ����
      f.print( "#define #{@global_name}_GET_CELLCB(idx) (&#{@global_name}_CB_tab[(idx) - #{@global_name}_ID_BASE])\n" )
    else
      f.print( "#define #{@global_name}_GET_CELLCB(idx) (idx)\n" )
    end
  end

  #=== CELLCB �ؤΥݥ��󥿤�����ޥ����û�̷��ˤ����
  #  ���륿���ץإå��ؽ���
  def gen_ph_get_cellcb_abbrev f
    f.printf( TECSMsg.get( :GCBA_comment ), "#_GCBA_#" )
    f.print("#define GET_CELLCB(idx)  #{@global_name}_GET_CELLCB(idx)\n\n")

    f.printf( TECSMsg.get( :CCT_comment ), "#_CCT_#" )
    f.print( "#define CELLCB\t#{@global_name}_CB\n\n" )

    f.printf( TECSMsg.get( :CTIXA_comment ), "#_CTIXA_#" )
    f.print( "#define CELLIDX\t#{@global_name}_IDX\n\n" )

    if @name != @global_name then
      f.print( "#define #{@name}_IDX  #{@global_name}_IDX\n" )
    end
  end

  #===  attribute, var �򥢥���������ޥ�������
  #    ���륿���ץإå��ؽ���
  def gen_ph_attr_access f
    if @n_attribute_rw > 0 || @n_attribute_ro > 0 then
      f.printf( TECSMsg.get( :AAM_comment ), "#_AAM_#" )
    end

    @attribute.each { |a|

      next if a.is_omit?

      # mikan const_value �ξ��
      f.print( "#define " )
      if @singleton then
        if has_INIB? then
          inib = "INIB"
        else
          inib = "CB"
        end
        f.printf( "%-20s", "#{@global_name}_ATTR_#{a.get_name}" )
        f.print( "\t(#{@global_name}_SINGLE_CELL_#{inib}.#{a.get_name})\n" )
        # mikan �����Ǥ� cell �ǤϤʤ� celltype ��̾��
      else
        if ! a.is_rw? && has_CB? && has_INIB? then
          inib = "->_inib"
        else
          inib = ""
        end
        f.printf( "%-20s", "#{@global_name}_ATTR_#{a.get_name}( p_that )" )
        f.print( "\t((p_that)#{inib}->#{a.get_name})\n" )
      end
    }
    f.print( "\n" )

    @attribute.each { |a|

      next if a.is_omit?

      if @singleton then
        if has_INIB? then
          inib = "INIB"
        else
          inib = "CB"
        end
      else
        if ! a.is_rw? && has_CB? && has_INIB? then
          inib = "->_inib"
        else
          inib = ""
        end
      end

      # mikan const_value �ξ��
      f.print( "#define " )
      if @singleton then
        f.printf( "%-20s", "#{@global_name}_GET_#{a.get_name}()" )
        f.print( "\t(#{@global_name}_SINGLE_CELL_#{inib}.#{a.get_name})\n" )
        # mikan �����Ǥ� cell �ǤϤʤ� celltype ��̾��
      else
        f.printf( "%-20s", "#{@global_name}_GET_#{a.get_name}(p_that)" )
        f.print( "\t((p_that)#{inib}->#{a.get_name})\n" )
      end

      if a.is_rw? then
        f.print( "#define " )
        if @singleton then
          f.printf( "%-20s", "#{@global_name}_SET_#{a.get_name}(val)" )
          f.print( "\t(#{@global_name}_SINGLE_CELL_#{inib}.#{a.get_name} = (val))\n" )
          # mikan �����Ǥ� cell �ǤϤʤ� celltype ��̾��
        else
          f.printf( "%-20s", "#{@global_name}_SET_#{a.get_name}(p_that,val)" )
          f.print( "\t((p_that)#{inib}->#{a.get_name}=(val))\n" )
        end
      end

    }
    f.print( "\n" )

    if @n_var > 0 then
      f.printf( TECSMsg.get( :VAM_comment ), "#_VAM_#" )
    end

    @var.each { |v|

      next if v.is_omit?

      if @singleton then
        if v.get_size_is && has_INIB? then
          inib = "INIB"
        else
          inib = "CB"
        end
      else
        if v.get_size_is && has_CB? && has_INIB? then
          inib = "->_inib"
        else
          inib = ""
        end
      end

      # mikan const_value �ξ��
      f.print( "#define " )
      if @singleton then
        f.printf( "%-20s", "#{@global_name}_VAR_#{v.get_name}" )
        f.print( "\t(#{@global_name}_SINGLE_CELL_#{inib}.#{v.get_name})\n" )
        # mikan �����Ǥ� cell �ǤϤʤ� celltype ��̾��
      else
        f.printf( "%-20s", "#{@global_name}_VAR_#{v.get_name}(p_that)" )
        f.print( "\t((p_that)#{inib}->#{v.get_name})\n" )
      end
    }
    f.print( "\n" )
    @var.each { |v|

      next if v.is_omit?

      # mikan const_value �ξ��
      f.print( "#define " )
      if @singleton then
        f.printf( "%-20s", "#{@global_name}_GET_#{v.get_name}()" )
        f.print( "\t(#{@global_name}_SINGLE_CELL_CB.#{v.get_name})\n" )
        # mikan �����Ǥ� cell �ǤϤʤ� celltype ��̾��
      else
        f.printf( "%-20s", "#{@global_name}_GET_#{v.get_name}(p_that)" )
        f.print( "\t((p_that)->#{v.get_name})\n" )
      end

      f.print( "#define " )
      if @singleton then
        f.printf( "%-20s", "#{@global_name}_SET_#{v.get_name}(val)" )
        f.print( "\t(#{@global_name}_SINGLE_CELL_CB.#{v.get_name}=(val))\n" )
        # mikan �����Ǥ� cell �ǤϤʤ� celltype ��̾��
      else
        f.printf( "%-20s", "#{@global_name}_SET_#{v.get_name}(p_that,val)" )
        f.print( "\t((p_that)->#{v.get_name}=(val))\n" )
      end
    }
    f.print( "\n" )

  end

  #===  attribute/var ���������ޥ����û�̷��˥����ɤ�����
  def gen_ph_attr_access_abbrev f
    if @n_attribute_rw > 0 || @n_attribute_ro > 0 then
      f.printf( TECSMsg.get( :AAMA_comment ), "#_AAMA_#" )
    end

    @attribute.each { |a|
      next if a.is_omit?

      # mikan const_value �ξ��
      f.print( "#define " )
      f.printf( "%-20s", "ATTR_#{a.get_name}" )
      f.print( " #{@global_name}_ATTR_#{a.get_name}" )
      if ! @singleton then
        f.print( "( p_cellcb )" )
      end
      f.print "\n"
    }
    f.print( "\n" )

    if @n_var > 0 then
      f.printf( TECSMsg.get( :VAMA_comment ), "#_VAMA_#" )
    end

    @var.each { |v|
      next if v.is_omit?

      # mikan const_value �ξ��
      f.print( "#define " )
      f.printf( "%-20s", "VAR_#{v.get_name}" )
      f.print( " #{@global_name}_VAR_#{v.get_name}" )
      if ! @singleton then
        f.print( "( p_cellcb )" )
      end
      f.print( "\n" )
    }
    f.print( "\n" )

  end

  def gen_ph_cp_fun_macro f
    if @n_call_port >0 then
      f.printf( TECSMsg.get( :CPM_comment ) , "#_CPM_#" )
    end

    if @singleton then
      if has_INIB? then
        inib = "INIB"
      else
        inib = "CB"
      end
    else
      if has_CB? && has_INIB? then
        inib = "->_inib"
      else
        inib = ""
      end
    end

    @port.each { |p|
      next if p.get_port_type != :CALL

      p.get_signature.get_function_head_array.each{ |fun|
        f.print( "#define #{@global_name}_#{p.get_name}_#{fun.get_name}(" )
        ft = fun.get_declarator.get_type
        delim = ""

        if ! @singleton then
          f.print( "#{delim} p_that" )
          delim = ","
        end

        if p.get_array_size then
          f.print( "#{delim} subscript" )
          delim = ","
        end

        ft.get_paramlist.get_items.each{ |param|
          f.print( "#{delim} #{param.get_name}" )
          delim = ","
        }
        f.print( " ) \\\n" )

        subsc = ""
        subsc = "[subscript]" if p.get_array_size
        delim = ""

        # �ؿ�̾�ν���(ɸ�ࡧ�������ǥ�������ץ����� VMT �δؿ�̾����Ŭ�����������ؿ� or �������ǥ�������ץ�)
        if ! p.is_VMT_useless? then
          # ɸ�ॳ����
          if @singleton then
            f.print( "\t  #{@global_name}_SINGLE_CELL_#{inib}.#{p.get_name}" )
          else
            f.print( "\t  (p_that)#{inib}->#{p.get_name}" )
          end
          f.print( "#{subsc}->VMT->#{fun.get_name}__T( \\\n" )
        else
          # ��Ŭ�������� (optimize) # VMT ����
          p2 = p.get_real_callee_port
          if p2 then
            ct = p2.get_celltype
            if p.is_skelton_useless? then
              # �������ؿ���ľ�ܸƽФ�
              f.print( "\t  #{ct.get_global_name}_#{p2.get_name}_#{fun.get_name}( \\\n" )
            else
              # ������������ȥ�ؿ���ľ�ܸƽФ�
              f.print( "\t  #{ct.get_global_name}_#{p2.get_name}_#{fun.get_name}_skel( \\\n" )
            end
          else
            # optional ��̤���
            f.print( "\t  ((#{fun.get_declarator.get_type.get_type.get_type_str} (*)()" )
            f.print( "#{fun.get_declarator.get_type.get_type.get_type_str_post})0)()\n" )
            f.print( "\t  /* optional no entry port joined */\n" )
            if ! p.is_optional? then
              raise "unjoined but not optional celltype: #{@name} #{p.get_name}"
            end
          end
        end

        b_join = true    # optional �Ƿ�礷�Ƥ��ʤ���� false

        # ����������ν���(ɸ�ࡧ�������ǥ�������ץ�����Ŭ����IDX �ʤ�)
        if ! p.is_skelton_useless? && ! p.is_cell_unique? then
          # ɸ�ॳ����
          if @singleton then
            f.print( "\t  #{@global_name}_SINGLE_CELL_#{inib}.#{p.get_name}#{subsc}" )
            delim = ","
          else
            f.print( "\t   (p_that)#{inib}->#{p.get_name}#{subsc}" )
            delim = ","
          end
        else
          # ��Ŭ�������� (optimize) # ������ȥ�����
          c2 = p.get_real_callee_cell               # ͣ��Υ���(�Ǥʤ����⤢�롢ʣ�����뤬������)
          p2 = p.get_real_callee_port               # ͣ��Υݡ���(�Ǥʤ����ϡ��ʤ�)
          if p2 then
            ct = p2.get_celltype                    # �Ƥ���Υ��륿����
            if ! ct.is_singleton? then
              if ct.has_CB? || ct.has_INIB? then
                if p.is_cell_unique? then
                  name_array = ct.get_name_array( c2 )
                  f.print( "\t   #{name_array[7]}" )
                else
                  # CELLCB IDX ���Ϥ� (ɸ�ॳ���ɤ�Ʊ���������������ϰۤʤ�)
                  # p.is_skelton_useless? == true/false �Ȥ��Ʊ��
                  f.print( "\t   (p_that)#{inib}->#{p.get_name}#{subsc}" )
                end
              else
                f.print( "\t   (#{ct.get_global_name}_IDX)0" )
              end
              delim = ","
            else
              f.print( "\t   " )
            end
          else
            # optional ��̤���
            b_join = false
          end
        end

        if b_join then
          ft.get_paramlist.get_items.each{ |param|
            f.print( "#{delim} (#{param.get_name})" )
            delim = ","
          }
          f.print( " )\n" )
        end
      }
    }
    f.print( "\n" )
  end

  #=== send/receive �Ǽ�����ä������ΰ�� dealloc ����ޥ�������
  #f:: File
  #b_undef:: bool : true = #undef �����ɤ�����,  false = #define �����ɤ�����
  def  gen_ph_dealloc_code( f, append_name, b_undef = false )
    b_msg = false
    @port.each{ |p|
      p.each_param{ |port, fd, par|
        case par.get_direction                        # ��������������� (in, out, inout, send, receive )
        when :SEND
          # next if port.get_port_type == :CALL
          type = par.get_declarator.get_type
          pre = "("
          post = ")"
        when :RECEIVE
          # next if port.get_port_type == :ENTRY
          type = par.get_declarator.get_type.get_type
#          pre = "(*"
#          post = ")"
          pre = "("
          post = ")"
        else
          next
        end

        #                      �ݡ���̾         �ؿ�̾         �ѥ�᡼��̾
        dealloc_func_name = "#{port.get_name}_#{fd.get_name}_#{par.get_name}_dealloc"
        dealloc_macro_name = dealloc_func_name.upcase
        name = par.get_name

        if b_undef == false
          if (type.get_size || type.get_count) && type.get_type.has_pointer?
            count_str = "count__"
            count_str2 = ", count__"
          else
            count_str = nil
            count_str2 = nil
          end
          if ! b_msg
            f.print "\n"
            f.printf TECSMsg.get( :DAL_comment ), "#_DAL_#  #{append_name}"
            b_msg = true
          end
          f.print "#define #{dealloc_macro_name}#{append_name}(#{name}#{count_str2})"
          if append_name == "_RESET" then
            gen_dealloc_code_for_type( f, type, dealloc_func_name, pre, name, post, 0, true, count_str )
          else
            gen_dealloc_code_for_type( f, type, dealloc_func_name, pre, name, post, 0, false, count_str )
          end
          f.print "\n"
        else
          f.print "#undef #{dealloc_macro_name}#{append_name}\n"
        end
      }
    }
  end

  def gen_ph_cp_fun_macro_abbrev f
    if @n_call_port >0 then
      f.printf( TECSMsg.get( :CPMA_comment ), "#_CPMA_#" )
    end

    @port.each { |p|
      next if p.get_port_type != :CALL

      p.get_signature.get_function_head_array.each{ |fun|
        if ! p.is_require? || p.has_name? then
          f.print( "#define #{p.get_name}_#{fun.get_name}(" )
        else
          f.print( "#define #{fun.get_name}(" )
        end
        ft = fun.get_declarator.get_type
        delim = ""

#        if ! @singleton then
#          f.print( "#{delim} p_that" )
#          delim = ","
#        end

        if p.get_array_size then
          f.print( "#{delim} subscript" )
          delim = ","
        end

        ft.get_paramlist.get_items.each{ |param|
          f.print( "#{delim} #{param.get_name}" )
          delim = ","
        }
        f.print( " ) \\\n" )

        f.print( "                      #{@global_name}_#{p.get_name}_#{fun.get_name}(" )
        ft = fun.get_declarator.get_type
        delim = ""

        if ! @singleton then
          f.print( "#{delim} p_cellcb" )
          delim = ","
        end

        if p.get_array_size then
          f.print( "#{delim} subscript" )
          delim = ","
        end

        ft.get_paramlist.get_items.each{ |param|
          f.print( "#{delim} #{param.get_name}" )
          delim = ","
        }
        f.print( " ) \n" )
      }
    }
    f.print( "\n" )
  end

  def gen_ph_ep_fun_macro f
    if @n_entry_port >0 then
      f.printf( TECSMsg.get( :EPM_comment ), "#_EPM_#" )
    end

    @port.each { |p|
      next if p.get_port_type != :ENTRY

      p.get_signature.get_function_head_array.each{ |fun|
        f.printf( "#define %-16s %s\n",
                  "#{p.get_name}_#{fun.get_name}",
                  "#{@global_name}_#{p.get_name}_#{fun.get_name}" )
      }
    }
    f.print( "\n" )

  end

  def gen_ph_typedef_idx f
    f.printf( TECSMsg.get( :CTIX_comment ), "#_CTIX_#" )
    if @idx_is_id then
      f.print( "typedef ID #{@global_name}_IDX;\n" )
    else
      if has_CB? then
        f.print( "typedef struct tag_#{@global_name}_CB *#{@global_name}_IDX;\n" )
      elsif has_INIB? then
        f.print( "typedef const struct tag_#{@global_name}_INIB *#{@global_name}_IDX;\n" )
      else
        f.print( "typedef int   #{@global_name}_IDX;\n" )
      end
    end

  end

  def gen_ph_idx_type f
    if @idx_is_id then
      f.print( "ID" )
    else
      if has_CB? then
        f.print( "struct tag_#{@global_name}_CB *" )
      elsif has_INIB? then
        # f.print( "struct tag_#{@global_name}_INIB *" )  # const ����Ϥ��Ƥ��ʤ�
        f.print( "const struct tag_#{@global_name}_INIB *" )
      else
        f.print( "int" )
      end
    end

  end

  def gen_ph_ep_fun_prototype f
    if @n_entry_port >0 then
      f.printf( TECSMsg.get( :EPP_comment ), "#_EPP_#" )
    end

    @port.each { |p|
      next if p.get_port_type != :ENTRY

      f.print( "/* #{p.get_signature.get_global_name} */\n" )

      p.get_signature.get_function_head_array.each{ |fun|
        if p.is_inline? then
          f.print( "Inline " )
        end
        functype = fun.get_declarator.get_type
        f.printf( "%-12s", functype.get_type_str )

        f.print( " #{@global_name}_#{p.get_name}_#{fun.get_name}(" )
        if @singleton then
           delim = ""
        else
          f.print( "#{@global_name}_IDX idx" )
          delim = ","
        end

        if p.get_array_size then
          f.print( "#{delim} int_t subscript" )     # mikan singleton ���� ',' �λ���
          delim = ","
        end

        if functype.get_paramlist then
          items = functype.get_paramlist.get_items
          len = items.length
        else
          # ������ nil �ˤʤ�Τϡ������ʤ��λ��� void ���ʤ��ä����
          items = []
          len = 0
        end
        i = 0
        items.each{ |param|
          f.print "#{delim} "
          delim = ","
          f.print( param.get_type.get_type_str )
          f.print( " " )
          f.print( param.get_name )
          f.print( param.get_type.get_type_str_post )
          i += 1
        }
        f.print( ");\n" )

      }
    }

    # ������������ȥ�ؿ��Υץ�ȥ�������������
    if @n_entry_port >0 then
      f.printf( TECSMsg.get( :EPSP_comment ), "#_EPSP_#" )
    end
    @port.each { |p|
      next if p.get_port_type != :ENTRY
      if p.is_skelton_useless? || ! p.is_VMT_useless? then    # ��������Ŭ��
#        f.print( "/* #{p.get_name} : omitted by entry port optimize */\n" )
        next
      end

      f.print( "/* #{p.get_name} */\n" )

      p.get_signature.get_function_head_array.each{ |fun|
        functype = fun.get_declarator.get_type
        f.printf "%-14s", functype.get_type_str

        f.print " #{@global_name}_#{p.get_name}_#{fun.get_name}_skel("
        f.print " struct tag_#{p.get_signature.get_global_name}_VDES *epd"
        delim = ","

        if functype.get_paramlist then
          items = functype.get_paramlist.get_items
          len = items.length
        else
          # ������ nil �ˤʤ�Τϡ������ʤ��λ��� void ���ʤ��ä����
          items = []
          len = 0
        end
        i = 0
        items.each{ |param|
          f.print "#{delim} "
          delim = ","
          f.print param.get_type.get_type_str
          f.print " "
          f.print param.get_name
          f.print param.get_type.get_type_str_post
          i += 1
        }
        f.print ");\n"
      }
    }
    f.print( "\n" )
  end

  def gen_ph_cell_cb_type f

    if ( $rom )then
      # ������� ROM, �ѿ����� RAM

      if has_INIB? then

        f.printf( TECSMsg.get( :CIP_comment ), "#_CIP_#" )
        f.print( "typedef const struct tag_#{@global_name}_INIB {\n" )

        gen_cell_cb_type_port f
        gen_cell_cb_type_attribute( f, :INIB )

        f.print( "}  #{@global_name}_INIB;\n" )

      end

      if has_CB? then
        f.printf( TECSMsg.get( :CCTPA_comment ), "#_CCTPA_#" )
        f.print( "typedef struct tag_#{@global_name}_CB {\n" )
        if has_INIB? then
          f.print "    #{@global_name}_INIB  *_inib;\n"
        end
        gen_cell_cb_type_attribute( f, :CB )
        gen_cell_cb_type_var f
        f.print( "}  #{@global_name}_CB;\n" )
      end

      if ! has_CB? && ! has_INIB? then
        f.printf( TECSMsg.get( :CCDP_comment ), "#_CCDP_#" )
        f.print( "typedef struct tag_#{@global_name}_CB {\n" )
        f.print( "    int  dummy;\n" )
        f.print( "} #{@global_name}_CB;\n" )
     end

    else
      # ���� RAM
      f.printf( TECSMsg.get( :CCTPO_comment ), "#_CCTPO_#" )

      f.print( "typedef struct tag_#{@global_name}_CB {\n" )

      gen_cell_cb_type_port f
      gen_cell_cb_type_attribute( f, :CB )
      gen_cell_cb_type_var f

      f.print( "}  #{@global_name}_CB;\n" )
    end
  end


  #===   attribute �η��������
  #inib_cb::  :INIB �ޤ��� :CB
  def gen_cell_cb_type_attribute( f, inib_cb )
    if inib_cb == :INIB && @n_attribute_ro > 0 then
      f.print "    /* attribute(RO) #_ATO_# */ \n"
    elsif inib_cb == :CB then
      if $rom then
        if @n_attribute_rw > 0 then
          f.print "    /* attribute(RW) #_ATW_# */ \n"
        end
      else
        if @n_attribute_rw > 0 || @n_attribute_ro > 0 then
          f.print "    /* attribute #_AT_# */ \n"
        end
      end
    end

    @attribute.each{ |a|
      next if a.is_omit?
      next if inib_cb == :INIB && a.is_rw?
      next if has_INIB? && inib_cb == :CB && ! a.is_rw?

      if a.get_type.kind_of?( PtrType ) && ! a.get_type.is_const? && a.get_size_is then
        const_str = "const "
      else
        const_str = ""
      end
      f.print "    "
      f.printf( "#{const_str}%-14s", a.get_type.get_type_str )
      f.print " #{a.get_name}#{a.get_type.get_type_str_post};\n"
    }
    @var.each { |v|
      next if v.is_omit?
      next if v.get_size_is == nil
      next if $rom && inib_cb == :CB      # size_is ���ꤵ�줿��Τ� INIB �ˤΤ߽��Ϥ���

      f.print "    "
      f.printf( "%-14s", v.get_type.get_type_str )
      f.print " #{v.get_name}#{v.get_type.get_type_str_post};\n"
    }
  end

  def gen_cell_cb_type_var f
    # �ѿ��ν���
    if @n_var > 0 then
      f.print "    /* var #_VA_# */ \n"
    end

    @var.each{ |v|

      next if v.is_omit?
      next if v.get_size_is != nil    # size_is ���ꤵ�줿 var �� attribute �ؽ��Ϥ���

      f.print "    "
      f.printf( "%-14s", v.get_type.get_type_str )
      f.print " #{v.get_name}#{v.get_type.get_type_str_post};\n"
    }
  end

  def gen_cell_cb_type_port f
    gen_cell_cb_type_call_port f
    gen_cell_cb_type_entry_port f
  end

  def gen_cell_cb_type_call_port f
    # �ƤӸ�
    if @n_call_port >0 then
      f.print "    /* call port #_TCP_# */ \n"
    end

    @port.each{ |p|
      next if p.get_port_type != :CALL
      ptr = ''
      ptr = '*' if p.get_array_size

      if ! p.is_cell_unique? then
        if ! p.is_skelton_useless? then
          # ɸ���
          f.print( "    struct tag_#{p.get_signature.get_global_name}_VDES #{ptr}*#{p.get_name;};\n" )
          if p.get_array_size == "[]" then
            f.print( "    int_t n_#{p.get_name};\n" )
          end
        else
          # ��Ŭ�� skelton �ؿ���ƽФ��ʤ�(�������ؿ���ľ�ܸƽФ�)
          # �Ƥ��襻�륿���פ� CB �� IDX ��
          if p.get_real_callee_cell then
            f.print( "    " )
            p.get_real_callee_cell.get_celltype.gen_ph_idx_type f
            f.print( " #{ptr}#{p.get_name;};\n" )
            # ��߻��Ȥ������ơ�typedef ��������Ȥ�ʤ�
            # f.print( "    #{p.get_real_callee_cell.get_celltype.get_global_name}_IDX #{ptr}#{p.get_name;};\n" )
            if p.get_array_size == "[]" then
              f.print( "    int_t n_#{p.get_name};\n" )
            end
          #else
          #  optional ��̤���
          end
        end
      # else
        # ��Ŭ�� ��Ĥ������뤬�ʤ���硢�������ǥ�������ץ��ޤ��ϼ���¦�� IDX �ϸƤӸ��ؿ��ޥ���������ޤ��
      end
    }
  end

  #=== Celltype#����������ź���򵭲������ѿ������
  def gen_cell_cb_type_entry_port f
    # �ƤӸ�
    if @n_entry_port >0 then
      f.print "    /* call port #_NEP_# */ \n"
    end

    @port.each{ |p|
      if p.get_port_type == :ENTRY && p.get_array_size == "[]"
        f.print( "    int_t n_#{p.get_name};\n" )
      end
    }
  end

  def gen_ph_extern_cell f
    if @singleton then
      f.printf( TECSMsg.get( :SCP_comment ),  "#_SCP_#" )
      if has_CB? then
        f.print "extern  #{@global_name}_CB  #{@global_name}_SINGLE_CELL_CB;\n"
      end
      if has_INIB? then
        f.print "extern  #{@global_name}_INIB  #{@global_name}_SINGLE_CELL_INIB;\n"
      end

#     @ordered_cell_list.each{ |c|
#        f.print "extern  #{@global_name}_CB  #{@global_name}_#{c.get_name}_CB;\n"
#      }

      f.print "\n"
    else
      f.print "extern #{@global_name}_CB  #{@global_name}_CB_tab[];\n"

    end
  end

  def gen_ph_INIB_as_CB f

    if ! has_CB? && has_INIB? then
      f.printf( TECSMsg.get( :DCI_comment ),  "#_DCI_#" )
      f.print "#define #{@global_name}_CB_tab           #{@global_name}_INIB_tab\n"
      f.print "#define #{@global_name}_SINGLE_CELL_CB   #{@global_name}_SINGLE_CELL_INIB\n"
      f.print "#define #{@global_name}_CB               #{@global_name}_INIB\n"
      f.print "#define tag_#{@global_name}_CB           tag_#{@global_name}_INIB\n"
      f.print "\n"
    end

  end

  #===  ���ƥ졼�������� (FOREACH_CELL)������
  #      singleton �ǤϽ��Ϥ��ʤ�
  def gen_ph_foreach_cell f

    return if @singleton

    if has_CB? || has_INIB? then

      f.printf( TECSMsg.get( :FEC_comment ), "#_FEC_#" )

      f.print <<EOT
#define FOREACH_CELL(i,p_cb)   \\
    for( (i) = 0; (i) < #{@global_name}_N_CELL; (i)++ ){ \\
       (p_cb) = &#{@global_name}_CB_tab[i];

#define END_FOREACH_CELL   }

EOT
    else
      f.printf( TECSMsg.get( :NFEC_comment ), "#_NFEC_#" )
      f.print <<EOT
#define FOREACH_CELL(i,p_cb)   \\
    for((i)=0;(i)<0;(i)++){

#define END_FOREACH_CELL   }

EOT
    end
  end


  #===  �ѿ�var�����������
  #
  def gen_ph_cb_initialize_macro f

    f.printf( TECSMsg.get( :CIM_comment ), "#_CIM_#" )

    @var.each { |v|
      init = v.get_initializer
      if init.instance_of? Array then
        type = v.get_type
        if( type.kind_of? PtrType )then
          # PtrType �� ArrayType �ˤ����ؤ���

          # ������Ҥ����ǿ��Ȥ��� (��� 0 �Ǥ���)
          t2 = ArrayType.new( Expression.create_integer_constant( init.length, nil ) )
          t2.set_type( type.get_type )
          type = t2
        end
        f.print "extern const #{type.get_type_str} #{@global_name}_#{v.get_name}_VAR_INIT#{type.get_type_str_post};\n"
      end
    }
    if @singleton then
      arg = "()"
      p_that = ""
      that = "#{@global_name}_SINGLE_CELL_CB."
    else
      arg = "(p_that)"
      p_that = "(p_that)"
      that = "(p_that)->"
    end

    if @n_cell_gen > 0 then
      f.print "#define INITIALIZE_CB#{arg}"
      @var.each { |v|
        init = v.get_initializer
        next if init == nil

        type = v.get_type.get_original_type
        f.print "\\\n"
        if init.instance_of? Array then
          if(type.kind_of?( ArrayType ) || type.kind_of?( PtrType ))then
            pre = "&"
            post = "[0]"
          elsif type.kind_of? StructType then
            pre = "&"
            post = ""
#          elsif type.kind_of? PtrType then
#            pre = ""
#            post = ""
          end
          f.print "\tmemcpy((void*)#{pre}#{@global_name}_VAR_#{v.get_name}#{p_that}#{post}, (void*)#{pre}#{@global_name}_#{v.get_name}_VAR_INIT#{post}, sizeof(#{@global_name}_#{v.get_name}_VAR_INIT));"
        elsif init.instance_of? C_EXP then
          f.print "\t#{that}#{v.get_name} = #{init.get_c_exp_string};"
        else
          pre = "#{get_global_name}_ATTR_"
          if @singleton then
            post = ""
          else
            post = "#{p_that}"
          end
          f.print "\t#{that}#{v.get_name} = #{init.to_str( @name_list, pre, post )};"
        end
      }
      f.print "\n"

      f.print "#define SET_CB_INIB_POINTER(i,p_that)\\\n"
      if has_CB? && has_INIB? then
        if @singleton then
          f.print "\t#{that}_inib = &#{@global_name}_SINGLE_CELL_INIB;\n\n"
        else
          f.print "\t#{that}_inib = &#{@global_name}_INIB_tab[(i)];\n\n"
        end
      else
        f.print "\t/* empty */\n"
      end

    # else
    #   ���뤬��Ĥ�ʤ���н��Ϥ��ʤ�
    end

  end


  def gen_ph_inline f
    # inline �ݡ��Ȥ���ĤǤ⤢��С�inline.h �� include
    if @n_entry_port_inline > 0 then
      f.printf( TECSMsg.get( :INL_comment ), "#_INL_#" )
      f.print( "#include \"#{@global_name}_inline.h\"\n\n" )
    end
  end

  def gen_ph_endif f
    f.print("#endif /* #{@global_name}_TECSGEN_H */\n")
  end


##### celltype factory header
  def generate_factory_header

    f = AppFile.open("#{$gen}/#{@global_name}_factory.h")
    f.print("#ifndef #{@name}_FACTORY_H\n")
    f.print("#define #{@name}_FACTORY_H\n")
    f.close
  end

  def generate_factory_header_post

    f = AppFile.open("#{$gen}/#{@global_name}_factory.h")

    plugin_obj = get_celltype_plugin
    if plugin_obj
      plugin_obj.gen_factory f
    end

    f.print("#endif /* #{@name}_FACTORY_H */\n")
    f.close
  end


#####  celltype glue code
  def gen_cell_private_header f
    f.print "#include \"#{@global_name}_tecsgen.h\"\n\n"
  end

  def gen_cell_factory_header f
    f.print "#include \"#{@global_name}_factory.h\"\n\n"
  end

  def gen_cell_ep_des_type f
    if @n_entry_port > 0 then
      f.printf( TECSMsg.get( :EDT_comment ), "#_EDT_#" )
    end

    @port.each { |p|
      next if p.get_port_type != :ENTRY
      if p.is_skelton_useless?    # ��������Ŭ��
        f.print( "/* #{p.get_name} : omitted by entry port optimize */\n" )
        next
      end

      f.print( "/* #{p.get_name} */\n" )
      f.print( "struct tag_#{@global_name}_#{p.get_name}_DES {\n" )
      f.print( "    const struct tag_#{p.get_signature.get_global_name}_VMT *vmt;\n" )
      if has_CB? || has_INIB? then
        f.print( "    #{@name}_IDX  idx;\n" )
      else
        # CB �� INIB ��¸�ߤ��ʤ� (�Τǡ�idx �Ȥ��������ǽ�������Ƥ���)
        f.print( "    int           idx;\n" )
      end
      if p.get_array_size then
        f.print( "    int_t  subscript;\n" )
      end
      f.print( "};\n\n" )
    }

  end

  def gen_cell_skel_fun f
    if @n_entry_port >0 then
      f.printf( TECSMsg.get( :EPSF_comment ), "#_EPSF_#" )
    end

    @port.each { |p|
      next if p.get_port_type != :ENTRY
      if p.is_skelton_useless? then    # ��������Ŭ��
        f.print( "/* #{p.get_name} : omitted by entry port optimize */\n" )
        next
      end

      f.print( "/* #{p.get_name} */\n" )

      p.get_signature.get_function_head_array.each{ |fun|
        functype = fun.get_declarator.get_type
        f.printf "%-14s", functype.get_type_str

        f.print " #{@global_name}_#{p.get_name}_#{fun.get_name}_skel("
        f.print " struct tag_#{p.get_signature.get_global_name}_VDES *epd"
        delim = ","

        if functype.get_paramlist then
          items = functype.get_paramlist.get_items
          len = items.length
        else
          # ������ nil �ˤʤ�Τϡ������ʤ��λ��� void ���ʤ��ä����
          items = []
          len = 0
        end
        i = 0
        items.each{ |param|
          f.print "#{delim} "
          delim = ","
          f.print param.get_type.get_type_str
          f.print " "
          f.print param.get_name
          f.print param.get_type.get_type_str_post
          i += 1
        }
        f.print ")\n"

        f.print "{\n"
        if ( ! @singleton || p.get_array_size != nil ) then
          f.print "    struct tag_#{@global_name}_#{p.get_name}_DES *lepd\n"
          f.print "        = (struct tag_#{@global_name}_#{p.get_name}_DES *)epd;\n"
        end

        if functype.get_type_str == "void" then # mikan "void" �� typedef ��̤�б�
          f.print "    "
        else
          f.print "    return "
        end

        f.print "#{@global_name}_#{p.get_name}_#{fun.get_name}("
        if @singleton then
          delim = ""
        else
          f.print " lepd->idx"
          delim = ","
        end

        if p.get_array_size then
          f.print "#{delim} lepd->subscript"
          delim = ","
        end

        items.each{ |param|
          f.print "#{delim} "
          delim = ","
          f.print param.get_name
          i += 1
        }
        f.print " );\n"

        f.print "}\n"
      }
    }
    f.print( "\n" )
  end

  def gen_cell_fun_table f
    if @n_entry_port >0 then
      f.printf( TECSMsg.get( :EPSFT_comment ), "#_EPSFT_#" )
    end

    @port.each { |p|
      next if p.get_port_type != :ENTRY
      if p.is_VMT_useless? then    # ��������Ŭ��
        f.print "/* #{p.get_name} : omitted by entry port optimize */\n"
        next
      end

      f.print "/* #{p.get_name} */\n"

      f.print "static const struct tag_#{p.get_signature.get_global_name}_VMT"
      f.print " #{@global_name}_#{p.get_name}_MT = {\n"

      p.get_signature.get_function_head_array.each{ |fun|
        f.print "    #{@global_name}_#{p.get_name}_#{fun.get_name}_skel,\n"
      }

      f.print "};\n"
    }
    f.print "\n"

  end

  def gen_cell_ep_vdes f
    if @n_cell_gen  >0 then
      f.printf( TECSMsg.get( :CPEPD_comment ), "#_CPEPD_#" )
    end

    # ���Υ��륿���פΤ��٤ƤΥ���ˤĤ���
    @ordered_cell_list.each{ |c|
      if c.is_generate? then                           # �����оݤ���

        # ���Υꥹ�� (NamedList)
        jl = c.get_join_list

        # ���Ƥη��ꥹ�ȤˤĤ���
        jl.get_items.each{ |j|

          # ���դ����������
          definition = j.get_definition

          # �ƤӸ��ǤϤʤ�������°����
          next unless definition.instance_of? Port

          port = find j.get_name # celltype �� Port (������˺�Ŭ�����󤬤���)
          next if port.is_cell_unique?

          # �������Ǥ�����ʼ���������Ǥʤ���� nil ���֤��
          am = j.get_array_member2

          # �ƤӸ�����?
          if am  then
            i = 0
            while( i < am.length )
              j = am[i]
              if j then
                e = am[i].get_rhs

                if am[i].get_cell.get_celltype == self then
                  # Ʊ�����륿���פط�礷�Ƥ�����(VDES �Ǥ� type conflict �ˤʤ�)
                  p = am[i].get_rhs_port
                  des_type = "const struct tag_#{@global_name}_#{p.get_name}_DES"
                else
                  des_type = "struct tag_#{definition.get_signature.get_global_name}_VDES"
                end

                # ���դ� Expression ���鼰�����Ǥ�����
                elements = e.get_elements

                # ���դϼ��������󤫡�
                if elements[0] == :OP_SUBSC then

                  # ������������ź���� :OP_SUBSC ���������
                  subscript = elements[2].eval_const(nil)

                  # ������ elements[0] �� :OP_DOT
                  elements = elements[1]             # mikan elements[2]: ��������

                  f.printf( "extern %s %s%d;\n",
                            des_type,
                            "#{j.get_port_global_name(i)}_des",
                            subscript)
                else
                  f.printf( "extern %s %s;\n",
                            des_type,
                            "#{j.get_port_global_name(i)}_des")
                end
              #else if j == nil
              #  optioanl ���������Ǥ����������Ƥ��ʤ�
              end
              i += 1
            end
          else
            elements = j.get_rhs.get_elements
            if j.get_cell.get_celltype == self then
              # Ʊ�����륿���פط�礷�Ƥ�����(VDES �Ǥ� type conflict �ˤʤ�)
              p = j.get_rhs_port
              des_type = "const struct tag_#{@global_name}_#{p.get_name}_DES"
            else
              des_type = "struct tag_#{definition.get_signature.get_global_name}_VDES"
            end


            if elements[0] == :OP_SUBSC then
              # ����������
              subscript = elements[2].eval_const(nil)
              elements = elements[1]             # mikan elements[2]: ��������
              f.printf( "extern %s %s%d;\n",
                        des_type,
                        "#{j.get_port_global_name}_des",
                        subscript)
            else
              f.printf( "extern %s %s;\n",
                        des_type,
                        "#{j.get_port_global_name}_des" )
            end
          end
          # mikan   cell �� namespace ̤�б���Join �� Cell ���֥������Ȥ�����Ƥ���ɬ�פ���
        }

        f.print "\n"
      end
    }
  end

  def gen_cell_ep_vdes_array f
    if @n_cell_gen >0 then
      f.printf( TECSMsg.get( :CPA_comment ), "#_CPA_#" )   # mikan �ƤӸ�����̵������ФƤ��ޤ�
    end

    @ordered_cell_list.each{ |c|
      if c.is_generate? then
        jl = c.get_join_list
        jl.get_items.each{ |j|
          definition = j.get_definition
          next unless definition.instance_of? Port
          # port = definition    # definition �� composite �� Port �������뤳�Ȥ�����
          port = find j.get_name # celltype �� Port (������˺�Ŭ�����󤬤���)
          next if port.is_cell_unique?

          am = j.get_array_member2
          if am  then
            # ���դ�����

            if ! port.is_skelton_useless? then
              f.printf( "struct %s *%s_%s[] = {\n",
                        "tag_#{port.get_signature.get_global_name}_VDES",
                        "#{c.get_global_name}",
                        "#{j.get_name}" )
            else

#              ������ȥ�ؿ����׺�Ŭ���ξ�硢��������ϻ��Ȥ���ʤ�
              f.printf( "%s_IDX  %s_%s[] = {\n",
                        "#{j.get_celltype.get_global_name}",
                        "#{c.get_global_name}",
                        "#{j.get_name}" )
            end
            if port.get_array_size == "[]" then
              length = am.length
            else
              length = port.get_array_size
            end
            # am.each { |j|
            i = 0
            while i < length
              j = am[i]
              i += 1

              if j then
                # Ʊ�쥻�륿���פη��ξ�硢VDES ���ؤΥ��㥹�Ȥ�ɬ��
                if j.get_rhs_cell.get_celltype == self then
                  definition = j.get_definition
                  des_type_cast = "(struct tag_#{definition.get_signature.get_global_name}_VDES *)"
                else
                  des_type_cast = ""
                end

                e = j.get_rhs
                elements = e.get_elements
                if elements[0] == :OP_SUBSC then
                  # ��������ξ��(��Ŭ���Ϥʤ�)
                  subscript = elements[2].eval_const(nil)
                  elements = elements[1]             # mikan elements[2]: ��������
                  f.printf( "    %s%d,\n",
                            "#{des_type_cast}&#{j.get_port_global_name}_des",
                            subscript)
                  # p "1: #{j.get_port_global_name}_des"
                  # p "2: #{j.get_cell_global_name}_#{j.get_port_name}_des"

                else
                  # ����������ξ�� */
                  if ! port.is_skelton_useless? then
                    f.printf( "    %s,\n",
                              "#{des_type_cast}&#{j.get_port_global_name}_des" )
                  else
                    cell = j.get_rhs_cell
                    name_array = cell.get_celltype.get_name_array( cell )
                    f.printf( "    #{name_array[7]},\n" )
                  end
                end
              else
                # optional �ǸƤӸ��������Ǥ����������Ƥ��ʤ�
                f.printf( "    0,\n" )
              end
            # }
            end
            # mikan   cell �� namespace ̤�б���Join �� Cell ���֥������Ȥ�����Ƥ���ɬ�פ���
            f.print "};\n"
          end
        }

        f.print "\n"
      end
    }
  end

  #=== CB ����������ץ���������
  def gen_cell_cb_initialize_code f
    f.printf( TECSMsg.get( :CIC_comment ), "#_CIC_#" )
    f.print <<EOT
void
#{@global_name}_CB_initialize()
{
EOT
    if @singleton then
      f.print <<EOT
	SET_CB_INIB_POINTER(i,p_cb)
	INITIALIZE_CB()
EOT
    else
      f.print <<EOT
    #{@global_name}_CB	*p_cb;
	int		i;
	FOREACH_CELL(i,p_cb)
		SET_CB_INIB_POINTER(i,p_cb)
		INITIALIZE_CB(p_cb)
	END_FOREACH_CELL
EOT
    end

    f.print <<EOT
}
EOT
  end

  # === CB/INIB �γ��ǽ����������ѿ��ν���
  def gen_cell_cb_out_init f

    # ���뤬�ʤ���С����Ϥ��ʤ�
    if @n_cell_gen == 0 then
      return
    end

    f.printf( TECSMsg.get( :AVAI_comment ), "#_AVAI_#" )
    # attribute, var �Υݥ��󥿷��λ��Ȥ������������
    @ordered_cell_list.each{ |c|
      next if  ! c.is_generate?

      name_array = get_name_array( c )

      ct = c.get_celltype
      jl = c.get_join_list

      # attribute, var �Υݥ����ѿ�������ˤ�������������Ρ���������
      av_list = ct.get_attribute_list + ct.get_var_list
      if av_list.length != 0 then
        av_list.each{ |a|    # a: Decl
          j = jl.get_item( a.get_identifier )
          if j then
            init = j.get_rhs
          else
            init = a.get_initializer
          end

          if( a.is_type?( PtrType ) && ( (init && init.instance_of?( Array )) || init == nil ) )then
            ptr_type = a.get_type
            size = ptr_type.get_size

            if size then
              # ����ɾ������(attribute, var �˴ޤޤ���ѿ��򻲾Ȳ�ǽ)
              sz = size.eval_const( c.get_join_list, c.get_celltype.get_name_list )
              # �����������ʤ��� (�ѿ���ޤޤʤ����ˤ���)  �Դ����ʷ��� Token ������ (���顼ȯ�����ʤ�����)
              size = Expression.new( [:INTEGER_CONSTANT, Token.new(sz, nil, 0, 0)] )
              array_type = ArrayType.new( size )
              type = a.get_type.get_referto
              if ! type.is_const? && a.get_kind == :ATTRIBUTE then
                type.set_qualifier :CONST
              end
              array_type.set_type( type )
              if a.get_kind == :ATTRIBUTE then
                f.print "const "
              end
              f.printf( "#{a.get_type.get_referto.get_type_str} #{name_array[3]}_#{a.get_identifier}_INIT[%d]#{a.get_type.get_referto.get_type_str_post}", sz )
								# name_array[3]: cell_CB_INIT
              if !( $ram_initializer && a.get_kind == :VAR ) then
                # -R (ram initializer ����) �ξ�� var �Ͻ���������ɤ���Ϥ��ʤ�
                if( init )then
                  str = " = #{gen_cell_cb_init( f, c, name_array, array_type, init, a.get_identifier, 1, true )}"
                  str = str.sub( /\}$/, "};\n" )
                else
                  str = ";\n"
                end
                f.print( str )
              else
                f.print( ";\n" )
              end
            end
          end
        }
      end
    }

    # var ��{ }�ǰϤޤ줿����ͻ��꤬���뤫Ĵ�٤�
    n_init = 0
    @var.each { |v|
      init = v.get_initializer
      if init && init.instance_of?( Array ) then
        n_init += 1
      end
    }

    if n_init > 0 then
      f.printf( TECSMsg.get( :AVI_comment ), "#_AVI_#" )
      @var.each { |v|
        init = v.get_initializer
        if init && init.instance_of?( Array ) then
          type = v.get_type.get_original_type

          if( type.kind_of? PtrType )then
            # PtrType �� ArrayType �ˤ����ؤ���

            # ������Ҥ����ǿ������Ȥ���ʸ�� 0)
            t2 = ArrayType.new( Expression.create_integer_constant( init.length, nil ) )
            t2.set_type( type.get_type )
            type = t2
          end

          c = @ordered_cell_list[0]   # ���� cell (�ºݤˤϻȤ��ʤ�)
          name_array = get_name_array( c )
          f.print "const #{type.get_type_str}\t#{@global_name}_#{v.get_name}_VAR_INIT#{type.get_type_str_post} = "
          if type.kind_of? StructType then
            # celltype �� default �ν���ͤ���
            str = gen_cell_cb_init( f, c, name_array, type, init, v.get_identifier, 1, true )
          elsif( type.kind_of?( PtrType ) || type.kind_of?( ArrayType ) ) then
            str = "{ "
            type = type.get_type
            # mikan �ݥ��󥿤ǤϤʤ������󷿤Ȥ��ʤ��ȡ��ݥ����ѿ����ΰ��ʬ��»����
            init.each { |i|
              str += gen_cell_cb_init( f, c, name_array, type, i, v.get_identifier, 1, true )
              str += ", "
            }
            str += "}"
          else
            p type.class
            raise "Unknown Type"
          end
          f.print str
          f.print ";\n"
        end
      }
      f.print "\n"
    end

  end

  def gen_cell_cb f
    if has_INIB? then
      if @n_cell_gen > 0 then
        f.printf( TECSMsg.get( :INIB_comment ), "#_INIB_#" )
      end
      if @singleton then
        f.print "#{@global_name}_INIB #{@global_name}_SINGLE_CELL_INIB = \n"
        indent = 0
      else
        f.print "#{@global_name}_INIB #{@global_name}_INIB_tab[] = {\n"
        indent = 1
      end

      @ordered_cell_list.each{ |c|
        next if ! c.is_generate?

        name_array = get_name_array( c )

        unless @singleton then
          print_indent( f, indent )
          f.print "/* cell: #{name_array[2]}:  #{name_array[1]} id=#{c.get_id} */\n"
			    # name_array[2]: cell_CB_name
        end

        print_indent( f, indent )
        f.print "{\n"

        gen_cell_cb_port( c, indent, f, name_array )
        gen_cell_cb_attribute( c, indent, f, name_array, :INIB )

        unless @singleton then
          # 1 �Ĥ� cell INIB �ν����
          f.print( "    },\n" )
        end
      }
      f.print( "};\n" )
    end  # has_INIB?

    if has_CB? then
      if @n_cell_gen >0 then
        f.printf( TECSMsg.get( :CB_comment ),  "#_CB_#" )
      end

      # RAM initializer ����Ѥ��ʤ����ޤ��� ROM �����ʤ�
      if $ram_initializer == false || $rom == false then
        if @singleton then
          f.print "struct tag_#{@global_name}_CB #{@global_name}_SINGLE_CELL_CB = \n"
          indent = 0
        else
          f.print "struct tag_#{@global_name}_CB #{@global_name}_CB_tab[] = {\n"
          indent = 1
        end

        @ordered_cell_list.each{ |c|
          next if ! c.is_generate?

          name_array = get_name_array( c )

          unless @singleton then
            print_indent( f, indent )
            f.print "/* cell: #{name_array[2]}:  #{name_array[1]} id=#{c.get_id} */\n"
            # name_array[2]: cell_CB_name
          end

          print_indent( f, indent )
          f.print "{\n"

          if has_INIB? then
            print_indent( f, indent + 1 )
            f.printf( "&%-39s /* _inib */\n", "#{name_array[5]}," )
          end

          if ! has_INIB? then
            gen_cell_cb_port( c, indent, f, name_array )
          end

          gen_cell_cb_attribute( c, indent, f, name_array, :CB )
          gen_cell_cb_var( c, indent, f, name_array )

          unless @singleton then
            # 1 �Ĥ� cell CB �ν����
            f.print( "    },\n" )
          end
        }
        f.print( "};\n" )
      else
        if @singleton then
          f.print "struct tag_#{@global_name}_CB #{@global_name}_SINGLE_CELL_CB;\n"
          indent = 0
        else
          f.print "struct tag_#{@global_name}_CB #{@global_name}_CB_tab[#{@n_cell_gen}];\n"
          indent = 1
        end
      end
    end  # has_CB?
  end


  #=== name_array ������
  # IN:   cell  : Cell
  #       index : CB, INIB �����ź��
  # RETURN: name_array
  #   name_array[0] = @name           # celltype name
  #   name_array[1] = cell.get_name   # cell name
  #   name_array[2] = cell_CB_name    # cell_CB_name
  #   name_array[3] = cell_CB_INIT    # cell_CB_INIT # CB �γ�¦�ǽ������ɬ�פ������̾��
  #   name_array[4] = cell_CB_proto   # CB name for prototype
  #   name_array[5] = cell_INIB       # INIB name
  #   name_array[6] = cell_ID         # ID
  #   name_array[7] = cell_IDX        # IDX
  #   name_array[8] = cell_CBP        # CB pointer
  #   name_array[9] = @global_name    # celltype global name
  #   name_array[10] = cell.get_global_name # cell global name
  
  def get_name_array( cell )

    if @singleton then
      cell_CB_name = "#{@global_name}_SINGLE_CELL_CB"
      cell_CB_INIT = cell_CB_name
      cell_CB_proto = "#{@global_name}_SINGLE_CELL_CB"
      cell_INIB_name = "#{@global_name}_SINGLE_CELL_INIB"
      cell_ID = 0
      cell_IDX = "&#{cell_CB_name}"
    else
      index = cell.get_id - cell.get_celltype.get_id_base
      cell_CB_name = "#{@global_name}_CB_tab[#{index}]"
      cell_CB_INIT = "#{@global_name}_#{cell.get_name}_CB"
      cell_CB_proto = "#{@global_name}_CB_tab[]"
      cell_INIB_name = "#{@global_name}_INIB_tab[#{index}]"
      cell_ID = cell.get_id
    end
    if @idx_is_id then
      cell_IDX = cell_ID
    else
      cell_IDX = "&#{cell_CB_name}"
    end

    if ! has_CB? && ! has_INIB? then
      cell_CBP = "NULL"    # CB �� INIB ��ʤ���� NULL ���ִ�
    else
      cell_CBP = "&#{cell_CB_name}"
    end

    name_array = []
    name_array[0] = @name           # celltype name
    name_array[1] = cell.get_name   # cell name
    name_array[2] = cell_CB_name    # cell_CB_name
    name_array[3] = cell_CB_INIT    # cell_CB_INIT
    name_array[4] = cell_CB_proto   # CB name for prototype
    name_array[5] = cell_INIB_name  # cell INIB name
    name_array[6] = cell_ID         # cell ID
    name_array[7] = cell_IDX        # cell IDX
    name_array[8] = cell_CBP        # cell CBP
    name_array[9] = @global_name    # celltype global name
    name_array[10] = cell.get_global_name # cell global name

    return name_array
  end

  #=== attribute �� size_is ���ꤵ�줿 var (�ݥ���)�ν�����ǡ��������
  #
  # ROM �����ݡ��Ȥ�̵ͭ������ӽ����оݤ� CB �� INIB ���ˤ����Ϥ�������Ƥ��ۤʤ�
  def gen_cell_cb_attribute( cell, indent, f, name_array, cb_inib )
    ct = self
    jl = cell.get_join_list

    if cb_inib == :INIB then
      return if @n_attribute_ro == 0 && @n_var_size_is == 0
      print_indent( f, indent + 1 )
      f.print "/* attribute(RO) */ \n"
    elsif $rom then  # && cb_inib == CB
      # CB �� rw �� var
      return if @n_attribute_rw == 0
      print_indent( f, indent + 1 )
      f.print "/* attribute(RW) */ \n"
    else  # cb_inib == CB && $rom == false
      # CB ������
      return if @n_attribute_rw == 0 && @n_attribute_ro == 0 && @n_var_size_is == 0
      print_indent( f, indent + 1 )
      f.print "/* attribute */ \n"
    end

    attribute = ct.get_attribute_list
    attribute.each{ |a|              # a: Decl
      next if a.is_omit?
      if cb_inib == :INIB && a.is_rw? == true then
        # $rom == true �Ǥ�������������ʤ�
        next
      elsif cb_inib == :CB && $rom && ! a.is_rw? then
        next
      end

      j = jl.get_item( a.get_identifier )
      if j then
        # cell �ν���ͻ��ꤢ��
        gen_cell_cb_init( f, cell, name_array, a.get_type, j.get_rhs, a.get_identifier, indent + 1 )
      elsif a.get_initializer then
        # celltype �� default �ν���ͤ���
        gen_cell_cb_init( f, cell, name_array, a.get_type, a.get_initializer, a.get_identifier, indent + 1 )
      else
        # �����̤����
        gen_cell_cb_init( f, cell, name_array, a.get_type, nil, a.get_identifier, indent + 1 )
      end
    }
    @var.each{ |v|
      next if v.is_omit?
      next if v.get_size_is == nil   # size_is ���꤬������ attribute �ΰ����Ȥ��ƽ���

      if v.get_initializer && $ram_initializer == false then
        gen_cell_cb_init( f, cell, name_array, v.get_type, v.get_initializer, v.get_identifier, indent + 1 )
      else
        # �����̤���� �ޤ��� RAM initializer ����
        gen_cell_cb_init( f, cell, name_array, v.get_type, nil, v.get_identifier, indent + 1 )
      end
    }
  end

  #=== var �ν�����ǡ��������
  def gen_cell_cb_var( cell, indent, f, name_array )
    jl = cell.get_join_list
    var = get_var_list
    if @n_var - @n_var_size_is > 0 then
      print_indent( f, indent + 1 )
      f.print "/* var */ \n"
      var.each{ |v|

        next if v.is_omit?
        next if v.get_size_is      # size_is ���꤬������ attribute �ΰ����Ȥ��ƽ���

        if v.get_initializer && $ram_initializer == false then
          gen_cell_cb_init( f, cell, name_array, v.get_type, v.get_initializer, v.get_identifier, indent + 1 )
        else
          # �����̤���� �ޤ��� RAM initializer ����
          gen_cell_cb_init( f, cell, name_array, v.get_type, nil, v.get_identifier, indent + 1 )
        end
      }
    end
  end

  def gen_cell_cb_port( cell, indent, f, name_array )
    gen_cell_cb_call_port( cell, indent, f, name_array )
    gen_cell_cb_entry_port( cell, indent, f, name_array )
  end

  #=== �ƤӸ��ν���������ɤ�����
  def gen_cell_cb_call_port( cell, indent, f, name_array )
    jl = cell.get_join_list

    port = get_port_list
    if @n_call_port != 0 then
      print_indent( f, indent + 1 )
      f.print "/* call port #_CP_# */ \n"
      port.each{ |p|
        next if p.get_port_type != :CALL
        next if p.is_cell_unique?        # ��Ŭ����ñ�쥻��ǸƤӸ��ޥ���������ޤ���

        j = jl.get_item( p.get_name )
        print_indent( f, indent + 1 )

        # debug
        if j == nil then
          # optional �ƤӸ�
          # cdl_error( "H1003 internal error: cell \'$1\' port \'$2\': initializer not found\n" , cell.get_name, p.get_name )
          # exit( 1 )
          f.printf( "%-40s /* #_CCP5_# */\n",  "0," )
          if p.get_array_size == "[]" then
            # ź����ά�θƤӸ�����
            print_indent( f, indent + 1 )
            f.printf( "%-40s /* %s #_CCP6_# */\n", "0,", "length of #{p.get_name} (n_#{p.get_name})" )
          end
          next
        end

        elements = j.get_rhs.get_elements
        am = j.get_array_member2
        if am then
          # �ƤӸ�����ξ��
          f.printf( "%-40s /* #_CCP3_# */\n",  "#{cell.get_global_name}_#{j.get_name}," )
          if p.get_array_size == "[]" then
            # ź����ά�θƤӸ�����
            print_indent( f, indent + 1 )
            f.printf( "%-40s /* %s #_CCP4_# */\n", "#{am.length},", "length of #{p.get_name} (n_#{p.get_name})" )
          end
        else
          # Ʊ�쥻�륿���פη��ξ�硢VDES ���ؤΥ��㥹�Ȥ�ɬ��
          #print "CCP0/CCP1 #{p.get_name}, #{j.get_rhs_cell.get_celltype.get_name}, #{@name}\n"
          if j.get_rhs_cell.get_celltype == self then
            definition = j.get_definition
            des_type_cast = "(struct tag_#{definition.get_signature.get_global_name}_VDES *)"
          else
            des_type_cast = ""
          end

          if elements[0] == :OP_SUBSC then    # mikan elements ����
            # ����������ξ��
            subscript = elements[2].eval_const(nil)
            elements = elements[1]           # mikan elements[2]: ��������
            f.printf( "%-40s /* %s #_CCP0_# */\n",
                      # "&#{j.get_cell_global_name}_#{j.get_port_name}_des#{subscript},",
                      "#{des_type_cast}&#{j.get_port_global_name}_des#{subscript},",
                      p.get_name )
          else
            # �ƤӸ�����Ǥ⡢����������Ǥ�ʤ�
            if ! p.is_skelton_useless? then
              f.printf( "%-40s /* %s #_CCP1_# */\n",
                        "#{des_type_cast}&#{j.get_port_global_name}_des,",
                        p.get_name )
            else
              # ������ȥ����׺�Ŭ����CB (INIB) �ؤΥݥ��󥿤��������
              c = j.get_rhs_cell                    # �Ƥ��襻��
              ct = c.get_celltype                   # �Ƥ��襻�륿����
              if ct.has_INIB? || ct.has_CB? then
                name_array = ct.get_name_array( c )   # �Ƥ��襻�륿���פ� name_array ������
                f.printf( "%-40s /* %s #_CCP2_# */\n", "#{name_array[7]},", p.get_name )
              else
                # �Ƥ���� CB �� INIB ������ʤ���NULL �˽������
                f.printf( "%-40s /* %s #_CCP2_# */\n", "0,", p.get_name )
              end
            end
          end
        end

      }
      end
  end

  #=== �������ν���������ɤ�����
  def gen_cell_cb_entry_port( cell, indent, f, name_array )
    jl = cell.get_join_list

    port = get_port_list
    if @n_call_port != 0 then
      print_indent( f, indent + 1 )
      f.print "/* entry port #_EP_# */ \n"
      @port.each{ |p|
        if p.get_port_type == :ENTRY && p.get_array_size == "[]"
          print_indent( f, indent + 1 )
          f.printf( "%-40s /*  #_EEP_# */\n", "#{cell.get_entry_port_max_subscript( p )}," )
        end
      }
    end
  end

  #=== ����� attribute �ν���ͤ����
  #
  #f_get_str:: true �ξ�硢ʸ������֤���false �ξ�硢�ե����� f �˽��Ϥ��롥
  # ʸ������֤��Ȥ��������� ',' �ϴޤޤ�ʤ���
  # �ե�����ؽ��Ϥ���Ȥ��������� ',' �����Ϥ���롥��¤�����ǡ��������Ǥν���ͤ���Ϥ���� ',' ����Ť˽��Ϥ���롥
  # �����������Ǥϡ��ե�����ؽ��Ϥ��뤳�ȤϤʤ�
  #
  def gen_cell_cb_init( f, cell, name_array, type, init, identifier, indent, f_get_str = false )

    cell_CB_name = name_array[2]
    cell_CB_INIT = name_array[3]

    while type.kind_of?( DefinedType )
      type = type.get_type
    end

    if ( init == nil ) then

      if f_get_str then
        # �����̤����
        if type.kind_of?( BoolType ) then
          str = "false"   # formerly tecs_false
        elsif type.kind_of?( IntType ) then
          str = "0"
        elsif type.kind_of?( FloatType ) then
          str = "0.0"
        elsif type.kind_of?( EnumType ) then
          str = "0"
        elsif type.kind_of?( ArrayType ) then
          str = "{}"
        elsif type.kind_of?( StructType ) then
          str = "{}"
        elsif type.kind_of?( PtrType ) then
          if type.get_size then
            str = "#{cell_CB_INIT}_#{identifier}_INIT"
          else
            str = "0"
          end
        else
          raise "UnknownType"
        end
        return str
      else
        # �����̤����
        if type.kind_of?( BoolType ) then
          f.print "    " * indent
          f.printf( "%-40s /* %s */\n", "false,", identifier )   # formerly tecs_false
        elsif type.kind_of?( IntType ) then
          f.print "    " * indent
          f.printf( "%-40s /* %s */\n", "0,", identifier )
        elsif type.kind_of?( FloatType ) then
          f.print "    " * indent
          f.printf( "%-40s /* %s */\n", "0.0,", identifier )
        elsif type.kind_of?( EnumType ) then
          f.print "    " * indent
          f.printf( "%-40s /* %s */\n", "0,", identifier )
        elsif type.kind_of?( ArrayType ) then
          f.print "    " * indent
          f.printf( "%-40s /* %s */\n", "{},", identifier )
        elsif type.kind_of?( StructType ) then
          f.print "    " * indent
          f.printf( "%-40s /* %s */\n", "{},", identifier )
        elsif type.kind_of?( PtrType ) then
          if type.get_size then
            f.print "    " * indent
            f.printf( "%-40s /* %s */\n", "#{cell_CB_INIT}_#{identifier}_INIT,", identifier )
          else
            f.print "    " * indent
            f.printf( "%-40s /* %s */\n", "0,", identifier )
          end
        else
          raise "UnknownType"
        end
      end
      return
    end    

    # ���Υ᥽�åɤ� Celltype �Τ�ΤǤ���ɬ�פ�̵���ʾ��³���ΤǤ������֤���
    # ����ͻ��ꤢ��
    if type.kind_of?( BoolType ) then
      if init.instance_of?( C_EXP ) then
        init_str = subst_name( init.get_c_exp_string, name_array )
      else
        init_str = init.eval_const2(cell.get_join_list,@name_list)
      end

      if f_get_str then
        return "#{init_str}"
      else
        f.print "    " * indent
        f.printf( "%-40s /* %s */\n", "#{init_str},", identifier )
      end
#      if f_get_str then
#        return "#{init.eval_const2(nil)}"
#      else
#        f.print "    " * indent
#        f.printf( "%-40s /* %s */\n", "#{init.eval_const2(nil)},", identifier )
#      end
    elsif type.kind_of?( IntType ) then
      if init.instance_of?( C_EXP ) then
        init_str = subst_name( init.get_c_exp_string, name_array )
      else
        init_str = init.eval_const2(cell.get_join_list,@name_list)
      end

      if f_get_str then
        return "#{init_str}"
      else
        f.print "    " * indent
        f.printf( "%-40s /* %s */\n", "#{init_str},", identifier )
      end
    elsif type.kind_of?( FloatType ) then
      # mikan C_EXP for FloatType
      if f_get_str then
        return "#{init.eval_const2(cell.get_join_list,@name_list)}"
      else
        f.print "    " * indent
        f.printf( "%-40s /* %s */\n", "#{init.eval_const2(cell.get_join_list,@name_list)},", identifier )
      end
    elsif type.kind_of?( EnumType ) then
      # mikan C_EXP for EnumType
      if f_get_str then
        return "#{init.eval_const2(cell.get_join_list,@name_list)}"
      else
        f.print "    " * indent
        f.printf( "%-40s /* %s */\n", "#{init.eval_const2(cell.get_join_list,@name_list)},", identifier )
      end
    elsif type.kind_of?( ArrayType ) then
      if type.get_subscript
        len = type.get_subscript.eval_const(cell.get_join_list,@name_list)
      else
        len = init.length
      end

      at = type.get_type
      i = 0
      if f_get_str then
        str = "{ " 
      else
        f.print "    " * indent
        f.print( "{\n" )
      end

      len.times {
        next if ! init[i]        # mikan ���ν��֤�Ŭ�ڡ�
        if f_get_str then
          str += gen_cell_cb_init( f, cell, name_array, at, init[i], "#{identifier}[#{i}]", indent + 1, f_get_str )
          str += ', '
        else
          gen_cell_cb_init( f, cell, name_array, at, init[i], "#{identifier}[#{i}]", indent + 1, f_get_str )
        end
        i += 1
      }

      if f_get_str then
         str += "}"
      else
        f.print "    " * indent
        f.print( "},\n" )
      end

    elsif type.kind_of?( StructType ) then
      i = 0
      decls = type.get_members_decl.get_items
      if f_get_str then
        str = "{ "
      else
        f.print "    " * indent
        f.print( "{                                        /* #{identifier} */\n" )
      end

      decls.each{ |d|
        # p "#{d.get_identifier}: #{init}"
        next if ! init[i]

        if f_get_str then
          str += gen_cell_cb_init( f, cell, name_array, d.get_type, init[i], d.get_identifier, indent + 1, f_get_str )
          str += ', '
        else
          gen_cell_cb_init( f, cell, name_array, d.get_type, init[i], d.get_identifier, indent + 1, f_get_str )
        end
        i += 1
      }
      if f_get_str then
        str += "}"
      else
        f.print "    " * indent
        f.print( "},\n" )
      end

    elsif type.kind_of?( PtrType ) then

      if init.instance_of?( Array ) then
        if f_get_str then
          return "#{cell_CB_INIT}_#{identifier}_INIT"
        else
          f.print "    " * indent
          f.printf( "%-40s /* %s */\n", "#{cell_CB_INIT}_#{identifier}_INIT,", identifier )
        end
      elsif init.instance_of?( C_EXP ) then
        init_str = subst_name( init.get_c_exp_string, name_array )

        if f_get_str then
          return "#{init_str}"
        else
          f.print "    " * indent
          f.printf( "%-40s /* %s */\n", "#{init_str},", identifier )
        end

      else
        if f_get_str then
          return "#{init.eval_const2(cell.get_join_list,@name_list)}"
        else
          f.print "    " * indent
# p init.eval_const2(cell.get_join_list,@name_list).class
# p init.eval_const2(cell.get_join_list,@name_list)
# p identifier
          f.printf( "%-40s /* %s */\n", "#{init.eval_const2(cell.get_join_list,@name_list)},", identifier )

        end
      end
    else
      raise "UnknownType"
    end
  end

  #=== �������ǥ�������ץ������������
  def gen_cell_ep_des f
    if @n_cell_gen >0 then
      f.printf( TECSMsg.get( :EPD_comment ),  "#_EPD_#" )
    end

    index = 0
    @ordered_cell_list.each{ |c|

      next if ! c.is_generate?

      ct = c.get_celltype
      jl = c.get_join_list

      port = ct.get_port_list
      if port.length != 0 then
        port.each{ |p|
          next if p.get_port_type != :ENTRY
          if p.is_skelton_useless?       # ��������Ŭ��n ep_opt
            f.print( "/* #{p.get_name} : omitted by entry port optimize */\n" )
            next
          end

          len = p.get_array_size
          if len == "[]" then
            len = c.get_entry_port_max_subscript(p) + 1
          end

          if len != nil then
            # ����������ξ��
            i = 0
            while i < len
              f.print "const struct tag_#{@global_name}_#{p.get_name}_DES"
              # f.print " #{c.get_name}_#{p.get_name}_des#{i} = {\n"
              f.print " #{c.get_global_name}_#{p.get_name}_des#{i} = {\n"
              if p.is_VMT_useless? then
                f.print "    0,\n"
              else
                f.print "    &#{@global_name}_#{p.get_name}_MT,\n"
              end
              if( @idx_is_id )then
                f.print "    #{c.get_id},           /* ID */\n"
              else
                if has_CB? then
                  if @singleton then
                    f.print "    &#{@global_name}_SINGLE_CELL_CB,        /* CB */\n"
                  else
                    # f.print "    &#{@global_name}_#{c.get_name}_CB,\n"
                    f.print "    &#{@global_name}_CB_tab[#{index}],      /* CB */\n"
                  end
                elsif has_INIB? then
                  if @singleton then
                    f.print "    &#{@global_name}_SINGLE_CELL_INIB,      /* INIB */\n"
                  else
                    f.print "    &#{@global_name}_INIB_tab[#{index}],    /* INIB */\n"
                  end
                else
                  f.print "    0,\n"
                end
              end
              f.print "    #{i}\n"
              f.print "};\n"
              i += 1
            end
          else
            f.print "const struct tag_#{@global_name}_#{p.get_name}_DES"
            # f.print " #{c.get_name}_#{p.get_name}_des = {\n"
            f.print " #{c.get_global_name}_#{p.get_name}_des = {\n"
            if p.is_VMT_useless? then
              f.print "    0,\n"
            else
              f.print "    &#{@global_name}_#{p.get_name}_MT,\n"
            end
            if @idx_is_id then
              f.print "    #{c.get_id},     /* ID */\n"
            else
              if has_CB? then
                if @singleton then
                  f.print "    &#{@global_name}_SINGLE_CELL_CB,       /* CB */\n"
                else
                  f.print "    &#{@global_name}_CB_tab[#{index}],     /* CB */\n"
                  # f.print "    &#{@global_name}_#{c.get_name}_CB,\n"
                end
              elsif has_INIB? then
                if @singleton then
                  f.print "    &#{@global_name}_SINGLE_CELL_INIB,     /* INIB */\n"
                else
                  f.print "    &#{@global_name}_INIB_tab[#{index}],   /* INIB */\n"
                end
              else
                f.print "    0,\n"
              end
            end
            f.print "};\n"
          end
        }
      end
      index += 1
    }
  end

  def generate_template_code

    return if is_all_entry_inline?
    return if @b_reuse && ! $generate_all_template
    if ! ( @plugin && @plugin.gen_ep_func? ) then
      return if $generate_no_template     # $generate_all_template ���ͥ�褵���

      # ���ͤȤ��ƽ��Ϥ���ƥ�ץ졼�ȥե�����Ǥ��뤳�Ȥ򼨤������ "_templ" ���ղä���
      fname = "#{$gen}/#{@global_name}_templ.c"
    else
      # Plugin �ˤ���������줿���륿���פˤĤ��Ƥϡ���§Ū�˥ƥ�ץ졼�ȤǤϤʤ���
      # �������פʥ��륿���פμ��������ɤ��������롥
      # ���Τ��ᡢ�ե�����̾�� _temp ���ղä��ʤ�
      fname = "#{$gen}/#{@global_name}.c"
    end

    f = AppFile.open(fname)

    unless ( @plugin && @plugin.gen_ep_func? ) then
      f.printf( TECSMsg.get( :template_note ), @name, @name )
    else
      print_note( f, true )
    end

    f.print TECSMsg.get( :preamble_note )
    gen_template_attr_access f
    gen_template_cp_fun f
    # gen_template_types f     # 0805503 �ɲä��Ƥߤ�������äѤ����
    f.print( " *\n * #[</PREAMBLE>]# */\n\n" )
    f.printf TECSMsg.get( :PAC_comment ), "#_PAC_#"

    gen_template_private_header f
    if ( @plugin ) then
      # ���Υ᥽�åɤΰ����� plugin.rb �������򸫤�
      @plugin.gen_preamble( f, @singleton, @name, @global_name )
    end

    gen_template_ep_fun f

    f.print TECSMsg.get( :postamble_note )

    if ( @plugin ) then
      # ���Υ᥽�åɤΰ����� plugin.rb �������򸫤�
      @plugin.gen_postamble( f, @singleton, @name, @global_name )
    end

    f.close
  end

#####  celltype template

  def gen_template_private_header f
    f.print "#include \"#{@global_name}_tecsgen.h\"\n\n"
    f.print <<EOT
#ifndef E_OK
#define	E_OK	0		/* success */
#define	E_ID	(-18)	/* illegal ID */
#endif

EOT
  end

  def gen_template_attr_access f

    if @n_attribute_rw > 0 || @n_attribute_ro > 0 || @n_var > 0 then
      f.printf( TECSMsg.get( :CAAM_comment ), "#_CAAM_#" )
    end

    @attribute.each { |a|

      next if a.is_omit?

      f.printf( " * %-16s %-16s %-16s\n", a.get_name, "#{a.get_type.get_type_str} #{a.get_type.get_type_str_post}", "ATTR_#{a.get_name}" )

    }

    @var.each { |v|

      next if v.is_omit?

      f.printf( " * %-16s %-16s %-16s\n", v.get_name, "#{v.get_type.get_type_str} #{v.get_type.get_type_str_post}", "VAR_#{v.get_name}" )
    }

  end

  def gen_template_types f
    f.printf( TECSMsg.get( :TYP_comment ), "#_TYP_#", "#{@global_name}_CB", "#{@name}_IDX" )
  end

  def gen_template_cp_fun f
    if @n_call_port >0 then
      f.print " *\n"
      f.printf( TECSMsg.get( :TCPF_comment ), "#_TCPF_#" )
    end

    @port.each { |p|
      next if p.get_port_type != :CALL

      sig_name = p.get_signature.get_global_name
      con_tmp = p.get_signature.get_context
      if con_tmp then
        context = "context: #{con_tmp}"
      else
        context = ""
      end

      if p.is_allocator_port? then
        f.print " * allocator port for #{p.get_port_type.to_s.downcase} port: #{p.get_allocator_port.get_name} func: #{p.get_allocator_func_decl.get_name} param: #{p.get_allocator_param_decl.get_name}\n"
      elsif ! p.is_require? then
        f.print " * call port : #{p.get_name}  signature: #{sig_name} #{context}\n"
      else
        f.print " * require port : signature: #{sig_name} #{context}\n"
      end

      p.get_signature.get_function_head_array.each{ |fun|
        
        ft = fun.get_declarator.get_type

        f.printf( " *   %-14s ", ft.get_type.get_type_str )
        if ! p.is_require? || p.has_name? then
          f.print( "#{p.get_name}_#{fun.get_name}(" )
        else
          f.print( "#{fun.get_name}(" )
        end
        delim = ""

#        if ! @singleton then
#          f.print( "#{delim} p_that" )
#          delim = ","
#        end

        if p.get_array_size then
          f.print( "#{delim} subscript" )
          delim = ","
        end

        ft.get_paramlist.get_items.each{ |param|
          f.print( "#{delim} #{param.get_type.get_type_str}" )
          f.print( " #{param.get_name}#{param.get_type.get_type_str_post}" )
          delim = ","
	}
        f.print( " );\n" )

#        subsc = ""
#        subsc = "[subscript]" if p.get_array_size
#
#        if @singleton then
#          f.print( " *        #{@global_name}_#{p.get_name}" )
#        else
#          f.print( " *        (p_that)->#{p.get_name}" )
#        end
#        f.print( "#{subsc}->VMT->#{fun.get_name}(" )
#        f.print( " (p_that)->#{p.get_name}#{subsc}" )
#        ft.get_paramlist.get_items.each{ |param|
#          f.print( ", (#{param.get_name})" )
#        }
#        f.print( " )\n" )

      }

      if p.get_array_size then
        f.print " *       subscript:  0...(NCP_#{p.get_name}-1)\n"
      end

    }

  end

  def gen_template_ep_fun( f, b_inline = false )

    if @n_entry_port >0 then
      f.printf( TECSMsg.get( :TEPF_comment ), "#_TEPF_#" )
    end

    @port.each { |p|
      next if p.get_port_type != :ENTRY
      next if b_inline && ! p.is_inline?  # inline �ݡ���
      next if ! b_inline && p.is_inline?  # �� inline �ݡ���

      inline_prefix = ""
      nCELLIDX = "CELLIDX"
      nCELLCB = "CELLCB"
      nVALID_IDX = "VALID_IDX"
      nGET_CELLCB = "GET_CELLCB"

      f.print <<EOT
/* #[<ENTRY_PORT>]# #{p.get_name}
 * entry port: #{p.get_name}
 * signature:  #{p.get_signature.get_global_name}
 * context:    #{p.get_signature.get_context}
EOT

      if p.get_array_size != nil then
        f.print <<EOT
 * entry port array size:  NEP_#{p.get_name}
EOT
      end

      f.print <<EOT
 * #[</ENTRY_PORT>]# */

EOT

      p.get_signature.get_function_head_array.each{ |fun|
        f.print <<EOT
/* #[<ENTRY_FUNC>]# #{p.get_name}_#{fun.get_name}
 * name:         #{p.get_name}_#{fun.get_name}
 * global_name:  #{@global_name}_#{p.get_name}_#{fun.get_name}
 * oneway:       #{fun.is_oneway?}
 * #[</ENTRY_FUNC>]# */
EOT

        if b_inline then
          f.print "Inline "
        end
        functype = fun.get_declarator.get_type
        f.printf "%s\n", functype.get_type_str
        f.print "#{inline_prefix}#{p.get_name}_#{fun.get_name}("
        if @singleton then
          delim = ""
        else
          f.print "#{nCELLIDX} idx"
          delim = ", "
        end

        if p.get_array_size then
          f.print "#{delim}int_t subscript"
          delim = ", "
        end

        if functype.get_paramlist then
          items = functype.get_paramlist.get_items
          len = items.length
        else
          # ������ nil �ˤʤ�Τϡ������ʤ��λ��� void ���ʤ��ä����
          items = []
          len = 0
        end

        i = 0
        items.each{ |param|
          f.print "#{delim}"
          delim = ", "
          f.print param.get_type.get_type_str
          f.print " "
          f.print param.get_name
          f.print param.get_type.get_type_str_post
          i += 1
        }
        f.print ")\n"

        f.print "{\n"

        if ( @plugin && @plugin.gen_ep_func? ) then
          # ���Υ᥽�åɤΰ����� plugin.rb �������򸫤�
          @plugin.gen_ep_func_body( f, @singleton, @name, @global_name, p.get_signature.get_global_name, p.get_name, fun.get_name, "#{@global_name}_#{p.get_name}_#{fun.get_name}", functype, items )

        else
          if ! @singleton then
            if functype.get_type.kind_of?( DefinedType ) && ( functype.get_type.get_type_str == "ER" || functype.get_type.get_type_str == "ER_UINT" ) then
              if ! fun.is_oneway? then
                f.print "	ER\t\tercd = E_OK;\n"
                er_cd = "return(E_ID);"
                ret_cd = "return(ercd);"
              else
                er_cd = "#{TECSMsg.get(:oneway_ercd_note)}\n		return(E_OK);"
                ret_cd = "#{TECSMsg.get(:oneway_ercd_note)}\n	return(E_OK);"
              end
            else
              er_cd = "#{TECSMsg.get(:ercd_note)}"
              ret_cd = nil
            end
            f.print <<EOT
	#{nCELLCB}	*p_cellcb;
	if (#{nVALID_IDX}(idx)) {
		p_cellcb = #{nGET_CELLCB}(idx);
	}
	else {
		#{er_cd}
	} /* end if #{nVALID_IDX}(idx) */

EOT
            f.printf( TECSMsg.get( :TEFB_comment ), "#_TEFB_#" )
            f.printf( "\n" )

            if ret_cd then
              f.print "	#{ret_cd}\n"
            end
          else
          end # ! @singleton
        end # @plugin

        f.print "}\n\n"
      }
    }
  end

  def generate_inline_template_code
    return if @n_entry_port_inline == 0
    if ! ( @plugin && @plugin.gen_ep_func? ) then
      return if @b_reuse && ! $generate_all_template
      return if $generate_no_template     # $generate_all_template ���ͥ�褵���

      # ���ͤȤ��ƽ��Ϥ���ƥ�ץ졼�ȥե�����Ǥ��뤳�Ȥ򼨤������ "_templ" ���ղä���
      fname = "#{$gen}/#{@global_name}_inline_templ.h"
    else
      # Plugin �ˤ���������줿���륿���פˤĤ��Ƥϡ���§Ū�˥ƥ�ץ졼�ȤǤϤʤ���
      # �������פʥ��륿���פμ��������ɤ��������롥
      # ���Τ��ᡢ�ե�����̾�� _temp ���ղä��ʤ�
      fname = "#{$gen}/#{@global_name}_inline.h"
    end
    f = AppFile.open(fname)

    unless ( @plugin && @plugin.gen_ep_func? ) then
      f.printf( TECSMsg.get( :inline_template_note ), @name, @name )
    else
      print_note( f, true )
    end

    f.print TECSMsg.get( :preamble_note )
    gen_template_attr_access f
    f.print( " *\n * #[</PREAMBLE>]# */\n\n" )

    gen_template_ep_fun( f, true )

    f.print TECSMsg.get( :postamble_note )

    if ( @plugin ) then
      # ���Υ᥽�åɤΰ����� plugin.rb �������򸫤�
      @plugin.gen_postamble( f, @singleton, @name, @global_name )
    end

    f.close
  end


##### generate tecsgen.cfg

  def generate_celltype_factory_code

    @ct_factory_list.each { |fa|
      if fa.get_name == :write then

        # ����� " �������
        # file_name = fa.get_file_name.sub( /^\"(.*)\"$/, "\\1" )
        file_name = CDLString.remove_dquote fa.get_file_name
        format = CDLString.remove_dquote fa.get_format
        # format    = fa.get_format.sub( /^\"(.*)/, "\\1" )        # ���� " �������
        # format    = format.sub( /(.*)\"\z/, "\\1" )              # ��� " �������
        format    = format.gsub( /\\\n/, "\n" )                  # \\\n => \n


        # mikan �ʲ��� subst_name ���ִ�����褦���ѹ����٤�
        file_name = file_name.gsub( /(^|[^\$])\$ct\$/, "\\1#{@name}" )   # $ct$ �򥻥륿����̾���ִ�
        file_name = file_name.gsub( /(^|[^\$])\$ct_global\$/, "\\1#{@global_name}" )   # $ct$ �򥻥륿����̾���ִ�
        format    = format.gsub( /(^|[^\$])\$ct\$/, "\\1#{@name}" )   # $ct$ �򥻥륿����̾���ִ�
        format    = format.gsub( /(^|[^\$])\$ct_global\$/, "\\1#{@global_name}" )   # $ct$ �򥻥륿����̾���ִ�
        format    = format.gsub( /\$\$/, "\$" )                # $$ �� $ ���ִ�

        if file_name[0] != ?/ then
          file_name = "#{$gen}/#{file_name}"
        end

        begin
          cfg_file = AppFile.open( file_name )
          if $debug then
            print "'#{@name}' : celltype factory format: "
            puts( format )
          end
          # format ��� \n, \r, \t, \f �� \" �ʤɤ��ִ�
          fmt = CDLString.escape format
          cfg_file.print( fmt )
          cfg_file.puts( "\n" )
          cfg_file.close()
        rescue => evar
          cdl_error( "H1004 \'$1\' : write error while writing factory (specify -t to get more info)" , file_name )
          print_exception( evar )
        end
      end
    }
  end

  def generate_cell_factory_code

    @ordered_cell_list.each{ |c|

      # cell �Υץ�ȥ���������ʤ�̵��
      next if ! c.is_generate?

      name_array = get_name_array( c )

      @factory_list.each { |fa|

        if fa.get_name == :write then

          # ����� " �������
          # file_name = fa.get_file_name.sub( /^\"(.*)\"$/, "\\1" )
          file_name = CDLString.remove_dquote fa.get_file_name
          file_name = subst_name( file_name, name_array )
          # format    = fa.get_format.sub( /^\"(.*)\"$/, "\\1" )        # ����� "" �������
          format    = CDLString.remove_dquote fa.get_format
          # format    = fa.get_format.sub( /^\"(.*)/, "\\1" )        # ���� " �������
          # format    = format.sub( /(.*)\"\z/, "\\1" )              # ��� " �������
          format    = format.gsub( /\\\n/, "\n" )                  # \\\n => \n

          format    = subst_name( format, name_array )

          arg_list  = fa.get_arg_list

          if file_name[0] != ?/ then
            file_name = "#{$gen}/#{file_name}"
          end

          na = []     # ����ܥ�� attribute ���ͤ��֤���������ΰ���
          if arg_list then
            arg_list.each { |a|
              case a[0]
              when :STRING_LITERAL   # ʸ�������
                # s = a[1].sub( /^\"(.*)\"$/, "\\1" )            # ����� "" �������
                s = CDLString.remove_dquote a[1]
                s = subst_name( s, name_array )
                # s = subst_name( a[1], name_array )

                na << s
              when :IDENTIFIER
                param_name = a[1]    # ���̻ҡ�°����̾����
                attr = self.find( param_name )
                init = attr.get_initializer      # celltype �ǻ��ꤵ�줿�����

                # cell �� join �Υꥹ�Ȥ���̾����õ��
                j = c.get_join_list.get_item( param_name )
                if j then    # param_name �� cell �Υ��祤�󤬤��뤫
                  init = j.get_rhs                    # cell �ǻ��ꤵ�줿����ͤ�ͥ��
                end

                str = gen_cell_cb_init( nil, c,    name_array, attr.get_type, init, attr.get_identifier, 0,   true )
                                      # file,cell, name_array, type,          init, identifier,       indent, f_get_str

                # str = str.sub( /^\"(.*)\"$/, "\\1" )            # ����� "" ������� mikan �������ִ��Ǥ褤��
                str = CDLString.remove_dquote str
                na << str
              end
            }
          end

          begin
            cfg_file = AppFile.open( file_name )

            if $debug then
              print "'#{c.get_name}' : factory format: "
              print( format )
              print( " arg: " )
              na.each { |n| print "'#{n}' " }
              print( "\n" )
            end

            # format ��� \n, \r, \t, \f �� \" �ʤɤ��ִ�
            fmt = CDLString.escape format
            cfg_file.printf( fmt, *na )
            cfg_file.puts( "\n" )
            cfg_file.close()
          rescue => evar
            cdl_error( "H1005 \'$1\' : write error while writing factory (specify -t to get more info)" , file_name )
            print_exception( evar )
          end
        end
      }
    }

  end

  def generate_makefile
    generate_makefile_template
    generate_makefile_depend
  end

  def generate_makefile_template

    return if $generate_no_template

    # Makefile.templ ���������ɵ���

    f = AppFile.open( "#{$gen}/Makefile.templ" )
    f.print <<EOT
$(_TECS_OBJ_DIR)#{@global_name}.o : #{@global_name}.c
	$(CC) -c $(CFLAGS) -o $@ $<
 
EOT
# ����������§��2���ǰ�̣���ʤ�
#  ��$(GEN_DIR) �� .o ����������롼�뤬�ʤ�
#  ���ƥ�ץ졼�ȥ����ɤ򤽤Τޤޥӥ�ɤ���Τ�ʶ��路��
# # Celltype: #{@name}
# $(GEN_DIR)/#{@global_name}_tecsgen.o : $(GEN_DIR)/#{@global_name}_tecsgen.c
# 	$(CC) -c $(CFLAGS) -o $@ $<
# 
# $(GEN_DIR)/#{@global_name}_templ.o : $(GEN_DIR)/#{@global_name}_templ.c
# 	$(CC) -c $(CFLAGS) -o $@ $<
# 
    f.close

  end

  def generate_makefile_depend

    headers = [ "$(GEN_DIR)/#{@global_name}_tecsgen.h", "$(GEN_DIR)/#{@global_name}_factory.h", "$(GEN_DIR)/global_tecsgen.h" ]

    # inline ����������Ĥ���
    if @n_entry_port_inline > 0 then
      headers << "#{@global_name}_inline.h"
    end

    # �ƤӸ��ޤ��ϼ������Υ����˥���Υإå�
    @port.each { |p|
      headers << "$(GEN_DIR)/#{p.get_signature.get_global_name}_tecsgen.h"
    }

    headers += get_depend_header_list
    headers.sort!
    headers.uniq!
    headers = headers.join " "

    f = AppFile.open( "#{$gen}/Makefile.depend" )

#    print_Makefile_note f

    f.print <<EOT
# Celltype: #{@name}  #_MDEP_#
$(_TECS_OBJ_DIR)#{@global_name}_tecsgen.o : #{@global_name}_tecsgen.c #{headers}
$(_TECS_OBJ_DIR)#{@global_name}_templ.o : #{@global_name}_templ.c #{headers}
$(_TECS_OBJ_DIR)#{@global_name}.o : #{@global_name}.c #{headers}

EOT
    f.close
  end

  #=== decl �Ѥ� dealloc �����ɤ�����
  #b_reset:: Bool:  �ꥻ�å��Ѥ� dealloc �����ɤ����� (NULL �ݥ��󥿤ξ�� dealloc ���ʤ�)
  # mikan string �������줿�ݥ��󥿤���˥ݥ��󥿤���ʤ��Ȳ��ꡣ�ݥ��󥿷�����Ĺ�¤�Τβ�ǽ�����ӽ����Ƥ��ʤ�
  # ���Υ᥽�åɤǤϡ��Ԥ���Ϥ���ľ���� " \\\n" ����Ϥ��������ǲ���ʸ������Ϥ��ʤ�
  def gen_dealloc_code_for_type( f, type, dealloc_func_name, pre, name, post, level, b_reset, count_str = nil )
    type = type.get_original_type
    indent = "	" + "  " * (level+1)
    if ! type.has_pointer?
      return
    elsif type.kind_of?( ArrayType ) then
      if type.get_type.has_pointer?
        loop_str = "i#{level}__"
        count_str = "#{type.get_subscript.eval_const(nil)}"
        f.print " \\\n"
        f.print "#{indent}{ int_t  #{loop_str};"
        f.print " \\\n"
        f.print "#{indent}  for( #{loop_str} = 0; #{loop_str} < #{count_str}; #{loop_str}++ ){ "
        
        gen_dealloc_code_for_type( f, type.get_type, dealloc_func_name, pre, name, "#{post}[#{loop_str}]", level+2, b_reset )

        f.print " \\\n"
        f.print "#{indent}  }"
        f.print " \\\n"
        f.print "#{indent}}"
      end
    elsif type.kind_of?( StructType ) then
      members_decl = type.get_members_decl
      members_decl.get_items.each { |md|
        pre2 = pre + name.to_s + post + "."
        name2 = md.get_name
        post2 = ""
        type2 = md.get_type.get_original_type
        if type2.kind_of? PtrType then   # mikan typedef ���줿��
          if type2.get_count then
            count_str = type2.get_count.to_str( members_decl, pre2, post2 )
          elsif type2.get_size then
            count_str = type2.get_size.to_str( members_decl, pre2, post2 )
          else
            count_str = nil
          end
        else
            count_str = nil
        end
        gen_dealloc_code_for_type( f, md.get_type, dealloc_func_name, pre2, name2, post2, level, b_reset, count_str )
      }

    elsif type.kind_of?( PtrType ) then

      if b_reset then
        level2 = level + 1
        indent2 = indent + "  "
        f.print " \\\n"
        f.print "#{indent}if( #{pre}#{name}#{post} ){ "
      else
        level2 = level
        indent2 = indent
      end

      if type.get_type.has_pointer?
        if count_str then
          loop_str = "i#{level}__"
          f.print " \\\n"
          f.print "#{indent2}{ int_t  #{loop_str};"
          f.print " \\\n"
          f.print "#{indent2}  for( #{loop_str} = 0; #{loop_str} < #{count_str}; #{loop_str}++ ){ "

          gen_dealloc_code_for_type( f, type.get_type, dealloc_func_name, pre, name, "#{post}[#{loop_str}]", level2+2, b_reset )

          f.print " \\\n"
          f.print "#{indent2}  }"
          f.print " \\\n"
          f.print "#{indent2}}"
        else
          gen_dealloc_code_for_type( f, type.get_type, dealloc_func_name, "(*#{pre}", name, "#{post})", level2, b_reset )
        end
      end
      f.print " \\\n"
      f.print "#{indent2}#{dealloc_func_name}( #{pre}#{name}#{post} ); "

      if b_reset then
        f.print " \\\n"
        f.print "#{indent}}"
      end
    else
      raise "UnknownType"
    end
  end

  def get_depend_header_list
    get_depend_header_list_( [] )
  end

  def get_depend_header_list_( celltype_list )
    headers = []

    if celltype_list.include? self then
      return headers
    else
      celltype_list << self
    end

    # �ƤӸ��η����Υ��륿���פΥإå��ʺ�Ŭ���ξ��Τߡ�
    # �����μ������� inline �ξ�硢inline �إå���
    @port.each { |p|
      next if p.get_port_type != :CALL

      if p.is_skelton_useless? || p.is_cell_unique? || p.is_VMT_useless? then
        # ��Ŭ�������� (optimize) # ������ȥ����פʤ�
        p2 = p.get_real_callee_port
        if p2 then
          ct = p2.get_celltype
          headers << " $(GEN_DIR)/#{ct.get_global_name}_tecsgen.h"
          if p2.is_inline? then
            headers << " #{ct.get_global_name}_inline.h"
          end
          headers += ct.get_depend_header_list_( celltype_list )
        #else
        #  optional ��̤���  
        end
      end
    }
    return headers
  end


  #=== $id$, $ct$, $cb$, $idx$ �ִ�
  #
  #  str �˰ʲ����ִ���Ԥ�
  #-   $ct$ �� ���륿����̾(ct)
  #-   $cell$ �� ����̾(cell)   cell �� nil �ʤ��3�Ĥ��ִ��ϹԤ��ʤ�
  #-   $cb$ �� CB �� C ����̾(cb)
  #-   $cbp$ �� CB �ؤΥݥ���(cbp)
  #-   $cb_proto$ �� CB �� C ����̾�ץ�ȥ����������(cb_proto)
  #-   $id$ �� ct_cell
  #-   $idx$ �� idx
  #-   $ID$ �� id (�������ֹ�)
  #-   $ct_global$ �� ���륿����̾(ct)
  #-   $cell_global$ �� ����̾(cell)   cell �� nil �ʤ��3�Ĥ��ִ��ϹԤ��ʤ�
  #-   $$   �� $
  def subst_name( str, name_array )
    ct   = name_array[0]    # celltype name
    cell = name_array[1]    # cell name
    cb   = name_array[2]    # cell CB name
    cb_init = name_array[3] # cell CB INIT, ������ִ��˻Ȥ��ʤ�
    cb_proto = name_array[4] # cell CB name for prototype
    id   = name_array[6]    # cell ID
    idx  = name_array[7]    # cell CB name for prototype
    cbp  = name_array[8]    # cell CB pointer
    ct_global = name_array[9]    # cell CB pointer
    cell_global  = name_array[10]    # cell CB pointer

    str = str.gsub( /(^|[^\$])\$ct\$/, "\\1#{ct}" )
    if cell then
      str = str.gsub( /(^|[^\$])\$cell\$/, "\\1#{cell}" )
      str = str.gsub( /(^|[^\$])\$cb\$/, "\\1#{cb}" )
      str = str.gsub( /(^|[^\$])\$id\$/, "\\1#{ct}_#{cell}" )
      str = str.gsub( /(^|[^\$])\$cb_proto\$/, "\\1#{cb_proto}" )
      str = str.gsub( /(^|[^\$])\$ID\$/, "\\1#{id}" )
      str = str.gsub( /(^|[^\$])\$idx\$/, "\\1#{idx}" )
      str = str.gsub( /(^|[^\$])\$cbp\$/, "\\1#{cbp}" )
      str = str.gsub( /(^|[^\$])\$ct_global\$/, "\\1#{ct_global}" )
      str = str.gsub( /(^|[^\$])\$cell_global\$/, "\\1#{cell_global}" )
    end
    str = str.gsub( /\$\$/, "\$" )                       # $$ �� $ ���ִ�

    return str
  end

end

# Appendable File���ɵ���ǽ�ե������
class AppFile
  # �������ե�����Υꥹ��
  @@file_name_list = {}

  def self.open( name )
    if $force_overwrite
      real_name = name
    else
      real_name = name+".tmp"
    end

#2.0
    if $b_no_kcode then 
      mode = ":" + $Ruby19_File_Encode
    else
      mode = ""
    end

    # ���˳����Ƥ��뤫��
    if @@file_name_list[ name ] then
#2.0
      mode = "a" + mode
      # �ɵ��⡼�ɤǳ���
      file = File.open( real_name, mode )
    else
#2.0
      mode = "w" + mode
      # �����⡼�ɤǳ����ʴ��ˤ���С��������򣰤ˤ����
      file = File.open( real_name, mode )
      @@file_name_list[ name ] = true
    end
    # File ���饹�Υ��֥������Ȥ��֤�
    return file
  end

  def self.update
    if $force_overwrite
      return
    end

    @@file_name_list.each{ |name,boo|
      b_identical = false
      if File.readable? name
        old_lines = File.readlines name
        new_lines = File.readlines name + ".tmp"
        if old_lines.length == new_lines.length then
          i = 0
          len = old_lines.length
          while i < len
            if old_lines[i] != new_lines[i]
              break
            end
            i += 1
          end
          if i == len
            b_identical = true
          end
        end
      end
      if b_identical == false then
        if $verbose then
          print "#{name} updated\n"
          print "renaming '#{name}.tmp' => '#{name}'\n"
        end
        File.rename name+".tmp", name
      else
        if $verbose then
          print "#{name} not updated\n"
        end
        File.delete name+".tmp"
      end
    }
  end
end


class Region

  def gen_region_str_pre f
    nest = 1
    while nest < @family_line.length
      f.print "  " * ( nest-1 )
      f.print "region #{@family_line[ nest ].get_name}{\n"
      nest += 1
    end
    return nest - 1
  end

  def gen_region_str_post f
    nest = @family_line.length - 1
    while nest >= 1
      f.print "  " * ( nest-1 )
      f.print "};\n"
      nest -= 1
    end
    return nest - 1
  end
end
