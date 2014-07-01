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
#   $Id: TracePlugin.rb 1925 2013-01-20 05:55:58Z okuma-top $
#++

# mikan through plugin: namespace ����θ����Ƥ��ʤ�
class TracePlugin < ThroughPlugin
#@cellEntry_list::[ "Cell.eEntry", "Cell2.eEntry2", ... ]
#@b_generate::bool  : true : TracePlugin ����������ɬ�פ�����

  #=== TracePlugin �� initialize
  #  ������ ThroughPlugin (plugin.rb) �򻲾�
  def initialize( cell_name, plugin_arg, next_cell, next_cell_port_name, signature, celltype, caller_cell )

    @maxArrayDisplay = 16
    @cellEntry_list  = []
    @probeName       = ""
    @b_generate      = false
    @b_displayTime   = false
    @kernelCelltype  = :"tKernel"
    @syslogCelltype  = :"tSysLog"

    super
    @plugin_arg_check_proc_tab = TracePluginArgProc
    parse_plugin_arg

    if @cellEntry_list.length > 0 then
      @cellEntry_list.each{ |ce|
        if "#{next_cell.get_name}.#{next_cell_port_name}".to_sym == ce.to_sym
          @b_generate = true
        end
      }
    else
      @b_generate = true
    end

    if @b_generate == false then
      # �����ƤӽФ�����˷�礹���ΤȤ���
      @entry_port_name = next_cell_port_name
      @cell_name = next_cell.get_name
    end
  end

  #===  ��������ɤ�����
  #      typedef, signature, celltype �ʤɡ�cell �ʳ��ˤΥ����ɤ�����
  #          ��ʣ�����������ƤϤʤ�ʤ��ʤ��Ǥ���������Ƥ�����Ͻ��Ϥ��ʤ����ȡ�
  #file::        FILE       ��������ե�����
  def gen_plugin_decl_code( file )

    # ���Υ��륿���ס�Ʊ�������˥���ˤϴ�����������Ƥ��뤫��
    if @@generated_celltype[ @ct_name ] == nil then
      @@generated_celltype[ @ct_name ] = [ self ]
    else
      @@generated_celltype[ @ct_name ] << self
      return
    end

    file2 = CFile.open( "#{$gen}/#{@ct_name}.cdl", "w" )

    send_receive = []
    if @signature != nil then
      @signature.each_param{ |fd,param|
        dir =param.get_direction
        case dir
        when :SEND, :RECEIVE
          send_receive << [ dir, fd, param ]
        end
      }
    end

    file2.print <<EOT
celltype #{@ct_name} {
EOT

    if send_receive.length > 0 then
      file2.print "  [ allocator(\n"
      delim = ""
      send_receive.each { |a|
        file2.print "#{delim}\t#{a[1].get_name}.#{a[2].get_name}<=#{@call_port_name}.#{a[1].get_name}.#{a[2].get_name}"
        delim = ",\n"
      }
      file2.print "\n  )]\n"
    end

    file2.print <<EOT
  entry #{@signature.get_namespace_path} #{@entry_port_name};
  call  #{@signature.get_namespace_path} #{@call_port_name};
  attr{
    char_t   *probeName_str      = "";
    char_t   *from_str           = "";
  };
  require  #{@syslogCelltype}.eSysLog;
  require  #{@kernelCelltype}.eKernel;
};
EOT
#    char_t   *cell_port_name_str = "";

    file2.close

    file.print "import( \"#{$gen}/#{@ct_name}.cdl\" );\n"
  end

  def gen_through_cell_code( file )

    gen_plugin_decl_code( file )

    if @b_generate != false then
      nest = @region.gen_region_str_pre file
      indent_str =  "  " * nest

      if @probeName then
        probeName_str = "#{indent_str}  probeName_str = \"" + @probeName + ": \";\n"
      else
        probeName_str = ""
      end
      if @caller_cell then
        caller_cell_str = "#{indent_str}  from_str = \"#{@caller_cell.get_name}\";\n"
      else
        caller_cell_str = ""
      end

      file.print <<EOT
#{indent_str}cell #{@ct_name} #{@cell_name} {
#{indent_str}  #{@call_port_name} = #{@next_cell.get_namespace_path.get_path_str}.#{@next_cell_port_name};
#{probeName_str}#{caller_cell_str}#{indent_str}};
EOT
#  cell_port_name_str = \"#{@next_cell.get_name}.#{@next_cell_port_name}\";
      @region.gen_region_str_post file
    end

  end

  def gen_ep_func_body( file, b_singleton, ct_name, global_ct_name, sig_name, ep_name, func_name, func_global_name, func_type, params )

    if ! func_type.get_type.is_void? then
      file.print( "\t#{func_type.get_type_str}\tretval;\n" )
    end

    file.print( "\tSYSUTM\tutime;\n" )

    if ! b_singleton then

      file.print <<EOT
\t#{ct_name}_CB *p_cellcb;
\tif( VALID_IDX( idx ) ){
\t\tp_cellcb = #{global_ct_name}_GET_CELLCB(idx);
\t}else{
\t\t/* ���顼���������ɤ򤳤��˵��� */
\t}

EOT
    end

#    p "celltype_name, sig_name, func_name, func_global_name"
#    p "#{ct_name}, #{sig_name}, #{func_name}, #{func_global_name}"


    file.print <<EOT
\tgetMicroTime( &utime );
\tsyslog( LOG_INFO, \"Enter: %sTime=%d: #{@next_cell.get_name}.#{@next_cell_port_name}.#{func_name} calledFrom: %s\", ATTR_probeName_str, utime, ATTR_from_str );
EOT

    print_params( params, file, 0, :IN )

    delim = ""
    if ! func_type.get_type.is_void? then
      file.print( "\tretval = " )
    else
      file.print( "\t" )
    end

    file.print( "#{@call_port_name}_#{func_name}(" )

    params.each{ |param|
      file.printf( "#{delim} #{param.get_name}" )
      delim = ","
    }
    file.print( " );\n" )

    file.print <<EOT
\tgetMicroTime( &utime );
\tsyslog( LOG_INFO, \"Leave: %sTime=%d: #{@next_cell.get_name}.#{@next_cell_port_name}.#{func_name}\", ATTR_probeName_str, utime );
EOT

    print_params( params, file, 0, :OUT )

    if( ! func_type.get_type.is_void? ) then
      print_param( "retval", func_type.get_type, file, 0, :RETURN, func_type.get_type.get_type_str, nil, nil)
      file.print( "\treturn retval;\n" )
    end

  end

  def print_params( params, file, nest, direction )
    params.each{ |param|
      dir = param.get_direction
      if( direction == :IN )then
        case dir
        when :IN, :INOUT, :SEND
          print_param( param.get_name, param.get_type, file, nest, dir, param.get_type.get_type_str, nil, nil )
        end
      else
        case dir
        when :OUT, :INOUT
          print_param( param.get_name, param.get_type, file, nest, dir, param.get_type.get_type_str, nil, nil )
        when  :RECEIVE
          outer = "*"
          outer2 = nil
          print_param( param.get_name, param.get_type.get_referto, file, nest, dir,
                       param.get_type.get_referto.get_type_str, outer, outer2 )
        end
      end
    }
  end

  def print_param( name, type, file, nest, direction, type_str, outer, outer2, name_list = nil )
    indent = "    " * ( nest + 1 )

    case type
    when DefinedType
      print_param( name, type.get_type, file, nest, direction, type_str, outer, outer2, name_list )
    when VoidType
    when BoolType
      file.print( "#{indent}syslog( LOG_INFO, \"#{indent}[#{direction}]#{type_str} #{outer}#{name}#{outer2} = %d;\", #{outer}#{name}#{outer2} );\n" )
    when IntType
      file.print <<EOT
#{indent}if( sizeof(#{outer}#{name}#{outer2}) > sizeof(int_t) )
#{indent}\tsyslog( LOG_INFO, \"#{indent}[#{direction}]#{type_str} #{outer}#{name}#{outer2} = %ld;\", (long)#{outer}#{name}#{outer2} );
#{indent}else
#{indent}\tsyslog( LOG_INFO, \"#{indent}[#{direction}]#{type_str} #{outer}#{name}#{outer2} = %d;\", #{outer}#{name}#{outer2} );
EOT
#      file.print( "#{indent}syslog( LOG_INFO, \"#{indent}[#{direction}]#{type_str} #{outer}#{name}#{outer2} = %ld;\", (long)#{outer}#{name}#{outer2} );\n" )
    when FloatType
      file.print( "#{indent}syslog( LOG_INFO, \"#{indent}[#{direction}]#{type_str} #{outer}#{name}#{outer2} = %g;\", (double)#{outer}#{name}#{outer2} );\n" )
    when EnumType  # mikan EnumType

    when StructType
      members_decl =type.get_members_decl
      if outer || outer2
        outer = "(#{outer}#{name}#{outer2})."
      else
        outer = "#{name}."
      end
      members_decl.get_items.each { |m|
        print_param( m.get_name, m.get_type, file, nest+1, direction, m.get_type.get_type_str, outer, nil, members_decl )
      }
    when FuncType  # mikan FuncType
    when ArrayType # mikan ArrayType
    when PtrType

      se = type.get_size
      ce = type.get_count
      max_loop = @maxArrayDisplay
      loop_count = nil

      if se then
        loop_count = "(((#{se.to_str( name_list, outer, outer2 )})>#{max_loop}) ? #{max_loop} : (#{se.to_str( name_list, outer, outer2 )}))"
        file.print( "#{indent}syslog( LOG_INFO, \"#{indent}size_is(#{se.to_str( name_list, outer, outer2 )})=%d\", #{se.to_str( name_list, outer, outer2 )} );\n" )
        size = "#{se.to_str( name_list, outer, outer2 )}"
      elsif ce then
        loop_count = "(((#{ce.to_str( name_list, outer, outer2 )})>#{max_loop}) ? #{max_loop} : (#{ce.to_str( name_list, outer, outer2 )})) "
        file.print( "#{indent}syslog( LOG_INFO, \"#{indent}count_is(#{ce.to_str( name_list, outer, outer2 )})=%d\", #{ce.to_str( name_list, outer, outer2 )} );\n" )
        size = "#{ce.to_str( name_list, outer, outer2 )}"
      end

      # mikan PtrType: string

      referto = type.get_referto
      type = referto
      type_str = type.get_type_str
      if type.kind_of?( DefinedType ) then
        type = type.get_original_type
      end

      if loop_count == nil then
        case type
        when StructType
          members = type.get_members_decl
          if outer || outer2
            outer = "(#{outer}#{name}#{outer2})->"
          else
            outer = "#{name}->"
          end
          outer2 = nil
          members.get_items.each { |m|
            print_param( m.get_name, m.get_type, file, nest+1, direction, m.get_type.get_type_str, outer, outer2, members )
          }
        when FuncType  # mikan FuncType
        when ArrayType # mikan ArrayType
        when BoolType, IntType, FloatType, EnumType, PtrType
          outer = "*#{outer}"
          outer2 = "#{outer2}"
          print_param( name, type, file, nest+1, direction, type_str, outer, outer2 )
        end
      else # loop_count != nil
        if type.kind_of?( PtrType ) || type.kind_of?( StructType ) then
          num_per_loop = 1
        else
          num_per_loop = 4
        end

          file.print <<EOT
#{indent}{
#{indent}\tint i__#{nest}, loop_count__ = #{loop_count};
#{indent}\tfor( i__#{nest} = 0; i__#{nest} < loop_count__; i__#{nest}+=#{num_per_loop} ){
EOT

        case type
        when StructType
          members = type.get_members_decl
          if outer || outer2
            outer = "(#{outer}#{name}#{outer2})[i__#{nest}]."
          else
            outer = "#{name}[i__#{nest}]."
          end
          members.get_items.each { |m|
            print_param( m.get_name, m.get_type, file, nest + 1, direction, m.get_type.get_type_str, outer, nil, members )
          }
        when FuncType  # mikan FuncType
        when ArrayType # mikan ArrayType

        when BoolType, FloatType
          if outer || outer2
            outer = "(#{outer}"
            outer2 = "#{outer2})"
          end

          file.print <<EOT
#{indent}\t\tsyslog( LOG_INFO, \"#{indent}[#{direction}]#{type_str} #{name}[%d]: %d %d %d %d\",
#{indent}\t\t\t\ti__#{nest}, #{outer}#{name}#{outer2}[i__#{nest}], #{outer}#{name}#{outer2}[i__#{nest}+1], #{outer}#{name}#{outer2}[i__#{nest}+2], #{outer}#{name}#{outer2}[i__#{nest}+3] );
EOT
        when IntType
          if outer || outer2
            outer = "(#{outer}"
            outer2 = "#{outer2})"
          end

          file.print <<EOT
#{indent}\t\tif( sizeof(#{outer}#{name}#{outer2}) > sizeof(int_t) )
#{indent}\t\t\tsyslog( LOG_INFO, \"#{indent}[#{direction}]#{type_str} #{name}[%d]: %02x %02x %02x %02x\",
#{indent}\t\t\t\t\ti__#{nest}, #{outer}#{name}#{outer2}[i__#{nest}], #{outer}#{name}#{outer2}[i__#{nest}+1], #{outer}#{name}#{outer2}[i__#{nest}+2], #{outer}#{name}#{outer2}[i__#{nest}+3] );
#{indent}\t\telse
#{indent}\t\t\tsyslog( LOG_INFO, \"#{indent}[#{direction}]#{type_str} #{name}[%d]: %02lx %02lx %02lx %02lx\",
#{indent}\t\t\t\t\ti__#{nest}, #{outer}#{name}#{outer2}[i__#{nest}], #{outer}#{name}#{outer2}[i__#{nest}+1], #{outer}#{name}#{outer2}[i__#{nest}+2], #{outer}#{name}#{outer2}[i__#{nest}+3] );
EOT

        when PtrType
          # type = type.get_referto
          if outer || outer2
            outer = "(#{outer}"
            outer2 = "#{outer2})[i__#{nest}]"
          else
            outer = ""
            outer2 = "[i__#{nest}]"
          end
          print_param( name, type, file, nest + 1, direction, type_str, outer, outer2 )
        end

        file.print <<EOT
#{indent}\t} /* for ( i__#{nest} ) */
#{indent}\tif( i__#{nest} < #{size} )
#{indent}\t\tsyslog( LOG_INFO, \"#{indent}(%d elements are omitted)\", #{size} - i__#{nest} );
#{indent}\telse if( i__#{nest} > #{size} )
#{indent}\t\tsyslog( LOG_INFO, \"#{indent}(last %d elements are void)\", i__#{nest} - #{size} );
#{indent}}
EOT
      end # loop_count == nil
    end
  end

  # �ץ饰�������̾�� Proc
  TracePluginArgProc = {
    "maxArrayDisplay"    => Proc.new { |obj,rhs| obj.set_maxArrayDisplay rhs },
    "cellEntry"          => Proc.new { |obj,rhs| obj.set_cellEntry rhs },
    "probeName"          => Proc.new { |obj,rhs| obj.set_probeName rhs },
    "displayTime"        => Proc.new { |obj,rhs| obj.set_displayTime rhs },
    "kernelCelltype"     => Proc.new { |obj,rhs| obj.set_kernelCelltype rhs },
    "syslogCelltype"     => Proc.new { |obj,rhs| obj.set_syslogCelltype rhs },
  }

  def set_maxArrayDisplay rhs
    @maxArrayDisplay = rhs
  end

  def set_cellEntry rhs
    ces = rhs.to_s.split /\s*,\s*/
    ces.each{ |ce|
      if ce =~ /^[A-Za-z_]\w*\.[A-Za-z_]\w*$/ then
        # OK
      else
        cdl_error( "#{ce}: TracePlugin arg not in \"symbol.symbol\" form" )
      end
    }
    @cellEntry_list.concat ces
  end

  def set_probeName rhs
    @probeName = rhs.to_s
  end

  def set_displayTime rhs
    if rhs.to_s == "true"
      @b_diplayTime = true
    elsif rhs.to_s == "false"
      @b_diplayTime = false
    else
      cdl_error( "displayTime : #{rhs} unsuitable: specify true or false" )
    end
  end

  #=== �ץ饰������� tKernel �Υ����å�
  def set_kernelCelltype( rhs )
    @kernelCelltype = rhs.to_sym
    nsp = NamespacePath.analyze( @kernelCelltype.to_s )
    obj = Namespace.find( nsp )
    if ! obj.instance_of?( Celltype ) && ! obj.instance_of?( CompositeCelltype ) then
      cdl_error( "TracePlugin: kernelCelltype '#{rhs}' not celltype or not defined" )
    end
  end

  #=== �ץ饰������� tSyslog �Υ����å�
  def set_syslogCelltype( rhs )
    @syslogCelltype = rhs.to_sym
    nsp = NamespacePath.analyze( @syslogCelltype.to_s )
    obj = Namespace.find( nsp )
    if ! obj.instance_of?( Celltype ) && ! obj.instance_of?( CompositeCelltype ) then
      cdl_error( "TracePlugin: syslogCelltype '#{rhs}' not celltype or not defined" )
    end
  end

end


