# -*- coding: euc-jp -*-

class RTMBridgePlugin < SignaturePlugin

  def initialize( signature, option )
    super
    signature.each_param{ |func_decl, param_decl|
      case param_decl.get_direction
      when :SEND, :RECEIVE
      end
      if param_decl.get_size
      elsif param_decl.get_count
      elsif param_decl.get_string
      end
    }
    print "RTMBridgePlugin: signature:#{signature.get_name}  option: #{option}\n"
  end

  #===  CDL �ե����������
  #      typedef, signature, celltype, cell �����ɤ�����
  #file::        FILE       ��������ե�����
  def gen_cdl_file(file)

    # �֥�å����륿���פ�����
    file.print <<EOT
// #833 �Υƥ���
import( <a.cdl> );

/// RTM �� TECS �֥�å����륿���� ///
celltype tRTM#{@signature.get_name}Bridge {
    call #{@signature.get_name} cTECS;
};
EOT

    # RTM �Ѥ� IDL �ե����������
    # ����� tecsgen.idl �˽��Ϥ���
    fname = "#{$gen}/tecsgen.idl"

    begin
      file2 = CFile.open( fname, "w" )
    rescue
      Generator.error( "#{fname}: file open error")
      return
    end

    begin
      file2.print "interface TECS#{@signature.get_name} {\n"
      @signature.get_function_head_array.each { |fh|  # fh: FuncHead
        fd = fh.get_declarator                   # fd: Decl
        if fd.is_function?                       # ���顼���кѤ�
          ft = fd.get_type                       # ft: FuncType
          file2.printf( "\t%s %s( ",
                        ft.get_type_str,
                        fd.get_name )
          ft.get_paramlist.get_items.each { |p| # p:  ParamDecl
            # size_is, count_is, string, send, receive �ˤ��б����ʤ�
            pd = p.get_declarator                # pd: Decl
            file2.printf( "%s %s %s%s",
                          p.get_direction.to_s.downcase,
                          pd.get_type.get_type_str,
                          pd.get_name,
                          pd.get_type.get_type_str_post )
            file2.print( " );\n" )
          }
        end
      }
      file2.print( "};\n" )

    rescue Exception => evar
      Generator.error( "#{fname}: file writing")
      print "#{evar}\n"
      if $debug then
        print "stack trace\n"
        p evar.backtrace
      end
    ensure
      file2.close
    end
  end
  
  #file::        FILE       ��������ե�����
  #===  �������ؿ��� postamble (C����)����������
  def gen_postamble( file, b_singleton, ct_name, global_ct_name )

    @signature.get_function_head_array.each { |fh|  # fh: FuncHead
      fd = fh.get_declarator                 # fd: Decl (������ fd ���ؿ��ʳ��Τ��ȤϤʤ�)
      ft = fd.get_type                       # ft: FuncType
      ret_type = ft.get_type
      file.printf( "%s\nRTM_%s( ",
                   ft.get_type_str,
                   fd.get_name )
      delim = ""
      ft.get_paramlist.get_items.each { |p| # p:  ParamDecl
        # size_is, count_is, string, send, receive �ˤ��б����ʤ�
        pd = p.get_declarator                # pd: Decl
        file.printf( "%s%s %s%s",
                     delim,
                     pd.get_type.get_type_str,
                     pd.get_name,
                     pd.get_type.get_type_str_post )
        delim = ", "
      }
      file.print( " )\n{\n" )

      if ret_type.get_original_type.kind_of? VoidType
        retval = ""
      else
        file.printf( "\t%s\tretval%s;\n", ft.get_type.get_type_str, ft.get_type.get_type_str_post )
        retval = "retval = "
      end
      file.printf( "\t%scTECS_%s( ", retval, fd.get_name )
      delim = ""
      ft.get_paramlist.get_items.each { |p| # p:  ParamDecl
        # size_is, count_is, string, send, receive �ˤ��б����ʤ�
        pd = p.get_declarator                # pd: Decl
        file.printf( "%s%s", delim, pd.get_name )
        delim = ", "
      }
      file.print( " );\n" )
      if ! ret_type.get_original_type.kind_of? VoidType
        file.print( "\treturn\tretval;\n")
      end
      file.print( "}\n\n" )
    }

  end

end