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
#   $Id: GenParamCopy.rb 1926 2013-02-02 06:16:04Z okuma-top $
#++

#= ParamCopy
#
# �ѥ�᡼�����ԡ�����ޡ�����顿����ޡ�����饳���ɤ���������᥽�å� print_param ���󶡤��롥
# RPCPlugin, OpaqueRPCPlugin �� include ����롥
# RPCPlugin (�ȥ�󥹥ڥ�����) �Ǥϡ�oneway �ؿ��� in �Υݥ��󥿰����ξ��˸¤ä� print_param ���Ѥ����롥
#
module  GenParamCopy

  #=== ������ž�������ɤ�����

  def print_param( name, type, file, nest, dir, outer, outer2, b_get, alloc_cp = nil, alloc_cp_extra = nil, name_list = nil )
    if type.get_original_type.kind_of?( ArrayType ) && b_get && dir != :OUT then
      indent = "	" * nest
      subsc = type.get_subscript
      if subsc == nil
        raise "Unsubscripted Array Not Supported"
      else        
        size_str = subsc.to_str( name_list, outer, outer2 )
        file.print <<EOT
#{indent}if((ercd_=#{alloc_cp}(sizeof(#{type.get_type.get_type_str}#{type.get_type.get_type_str_post})*(#{size_str}),(void **)&#{outer}#{name}#{outer2}#{alloc_cp_extra}))!=E_OK)\t/* GenParamCopy 1 */
#{indent}	goto error_reset;
EOT
        if ( dir == :SEND || dir == :RECEIVE ) && type.get_type.has_pointer? then
          # send, receive �ξ��ϡ����顼�ꥻ�åȤ����� NULL �ˤ���
          file.print <<EOT
#{indent}memset( (void *)#{outer}#{name}#{outer2}#{alloc_cp_extra}, 0, sizeof(#{type.get_type.get_type_str}#{type.get_type.get_type_str_post})*(#{size_str});   /* GenParamCopy Alloc1 */
EOT
        end
      end
    end
    print_param0( name, type, file, nest, dir, outer, outer2, b_get, alloc_cp, alloc_cp_extra, name_list )
  end

  def print_param0( name, type, file, nest, dir, outer, outer2, b_get, alloc_cp = nil, alloc_cp_extra = nil, name_list = nil )
    indent = "	" * nest

    case type
    when DefinedType
      print_param0( name, type.get_type, file, nest, dir, outer, outer2, b_get, alloc_cp, alloc_cp_extra )
    when BoolType, IntType, FloatType
      case type
      when BoolType
        type_str = "Int8"
      when IntType
        bit_size = type.get_bit_size
        case type.get_sign
        when :UNSIGNED
          sign = "U"
        when :SIGNED
          if bit_size == -1 || bit_size == -11 then
            sign = "S"   # signed char �ξ��Τ� S ���Ĥ�
          else
            sign = ""
          end
        else
          sign = ""
        end

        case bit_size
        when -1, -11  # -1: char_t, -11: char
          type_str = "#{sign}Char"
        when -2
          type_str = "#{sign}Short"
        when -3
          type_str = "#{sign}Int"
        when -4
          type_str = "#{sign}Long"
        when -5
          type_str = "Intptr"
        when 8, 16, 32, 64, 128
          type_str = "#{sign}Int#{bit_size}"
        else
          raise "unknown bit_size '#{bit_size}' for int type "
        end

      when FloatType
        bit_size = type.get_bit_size
        if bit_size == 32 then
          type_str = "Float32"
        else
          type_str = "Double64"
        end

      end

      if( b_get )then
        file.print indent
        file.print "if( ( ercd_ = cTDR_get#{type_str}( &(#{outer}#{name}#{outer2}) ) ) != E_OK )\t/* GenParamCopy 2 */\n"
        file.print indent
        file.print "	goto error_reset;\n"
      else
        file.print indent
        file.print "if( ( ercd_ = cTDR_put#{type_str}( #{outer}#{name}#{outer2} ) ) != E_OK )\t/* GenParamCopy 3 */\n"
        file.print indent
        file.print "	goto error_reset;\n"
      end

    when PtrType

      count = type.get_count; size = type.get_size; string = type.get_string
      if count || size || string then
        loop_counter_type = IntType.new(32)   # mikan ���� size_is, count_is �ΰ����η��Ȥ���
        file.print "#{indent}{\t/* GenParamCopy 4 */\n"
        file.print "#{indent}	#{loop_counter_type.get_type_str}  i__#{nest}, length__#{nest};\n"

        if size || count then
          if size then
            size_str = size.to_str( name_list, outer, outer2 )
          end

          if count then
            count_str = count.to_str( name_list, outer, outer2 )
          else
            # size_is ��ɬ��. count_is �ϥ��ץ����
            count_str = size_str
          end
          file.print "#{indent}	length__#{nest} = #{count_str};\t/* GenParamCopy 5 */\n"

          # size_is �� max ���꤬�����硢length �� max ��Ķ���Ƥ��뤫�����å����륳���ɤ�����
              # alloc_cp == nil �ΤȤ� dir �� INOUT, OUT �ΤϤ� (��郎��Ĺ)���������äƤ���Τǡ�����ľ�����˳���
          if b_get && type.get_max != nil && ! ( ( dir == :INOUT || dir == :OUT ) && alloc_cp == nil ) then
            file.print "#{indent}	if( length__#{nest} > #{type.get_max.to_s} ){\t/* GenParamCopy max check 1 */\n"
            file.print "#{indent}		ercd_ = E_PAR;\n"
            file.print "#{indent}		goto error_reset;\n"
            file.print "#{indent}	}\n"
          end

        else # if string then
          case type.get_type.get_bit_size
          when -1              # char_t
            b_size = 8
          when 8, 16, 32, 64   # intN_t, uintN_t
            b_size = type.get_type.get_bit_size
          else
            cdl_error( "R9999 $1: string specifier cannot be specified to '$2' in current implementation",
                       name, type.get_type.get_type_str + type.get_type.get_type_str_post )
          end
          if ! b_get then
            if  string.instance_of? Expression then
              len = string.to_str( name_list, outer, outer2 )
              file.print "#{indent}	length__#{nest} = STRNLEN#{b_size}(#{outer}#{name}#{outer2},(#{len}-1))+1;\t/* GenParamCopy 6 */\n"
              file.print "#{indent}	if( length__#{nest} < #{len})\tlength__#{nest} += 1;\n"
            else
              file.print "#{indent}	length__#{nest} = STRLEN#{b_size}(#{outer}#{name}#{outer2})+1;\t/* GenParamCopy 7 */\n"
            end
            size_str = "length__#{nest}"     # string �ξ�硢strnlen �ʾ���ΰ����ݤ��ʤ�
          else
            if ( dir == :INOUT ) then
              if ( string.instance_of? Expression ) then
                len = string.to_str( name_list, outer, outer2 )
                size_str = "#{len}"              # string(len) �ξ�� len ����ݤ���
              else
                raise "unsuscripted string used for inout parameter #{name}"
              end
            else
              size_str = "length__#{nest}"     # string �ξ�硢strnlen �ʾ���ΰ����ݤ��ʤ�
            end
          end
          print_param0( "length__#{nest}", loop_counter_type, file, nest + 1, dir, nil, nil, b_get )
        end

        if b_get && ( dir == :IN || dir == :INOUT || dir == :SEND || dir == :RECEIVE ) && alloc_cp then
          file.print <<EOT
#{indent}	if((ercd_=#{alloc_cp}(sizeof(#{type.get_type.get_type_str}#{type.get_type.get_type_str_post})*(#{size_str}),(void **)&#{outer}#{name}#{outer2}#{alloc_cp_extra}))!=E_OK)\t/* GenParamCopy 8 */
#{indent}		goto error_reset;
EOT
          if ( dir == :SEND || dir == :RECEIVE ) && type.get_type.has_pointer? then
            # send, receive �ξ��ϡ����顼�ꥻ�åȤ����� NULL �ˤ���
            file.print <<EOT
#{indent}	memset( (void *)#{outer}#{name}#{outer2}#{alloc_cp_extra}, 0, sizeof(#{type.get_type.get_type_str}#{type.get_type.get_type_str_post})*(#{size_str}) );   /* GenParamCopy Alloc2 */
EOT
          end
        end
        file.print "#{indent}	for( i__#{nest} = 0; i__#{nest} < length__#{nest}; i__#{nest}++ ){\t/* GenParamCopy 9 */\n"

        print_param0( name, type.get_type, file, nest + 2, dir, outer, "#{outer2}[i__#{nest}]", b_get, alloc_cp, alloc_cp_extra )
        file.print "#{indent}	}\n"
        file.print "#{indent}}\n"
      else
        if b_get && ( dir == :IN || dir == :INOUT || dir == :SEND || dir == :RECEIVE ) && alloc_cp then
          file.print <<EOT
#{indent}if((ercd_=#{alloc_cp}(sizeof(#{type.get_type.get_type_str}#{type.get_type.get_type_str_post}),(void **)&#{outer}#{name}#{outer2}#{alloc_cp_extra}))!=E_OK)\t/* GenParamCopy 10 */
#{indent}	 goto error_reset;
EOT
          if ( dir == :SEND || dir == :RECEIVE ) && type.get_type.has_pointer? then
            # send, receive �ξ��ϡ����顼�ꥻ�åȤ����� NULL �ˤ���
            file.print <<EOT
#{indent}memset( (void *)#{outer}#{name}#{outer2}#{alloc_cp_extra}, 0, sizeof(#{type.get_type.get_type_str}#{type.get_type.get_type_str_post}) );   /* GenParamCopy Alloc3 */
EOT
          end
        end
        print_param0( name, type.get_type, file, nest, dir, "(*#{outer}", "#{outer2})", b_get, alloc_cp, alloc_cp_extra )
      end

    when StructType
      members_decl =type.get_members_decl
      members_decl.get_items.each { |m|
        if m.is_referenced?
          print_param0( m.get_name, m.get_type, file, nest, dir, "#{outer}#{name}#{outer2}.", nil, b_get, alloc_cp, alloc_cp_extra, members_decl )
        end
      }
      members_decl.get_items.each { |m|
        if ! m.is_referenced?
          print_param0( m.get_name, m.get_type, file, nest, dir, "#{outer}#{name}#{outer2}.", nil, b_get, alloc_cp, alloc_cp_extra, members_decl )
        end
      }

    when VoidType
    when EnumType  # mikan EnumType
    when FuncType  # mikan FuncType
    when ArrayType # mikan ArrayType
      subsc = type.get_subscript
      if subsc == nil
        raise "Unsubscripted Array Not Supported"
      else        
        size_str = subsc.to_str( name_list, outer, outer2 )

        loop_counter_type = IntType.new(32)   # mikan ���� size_is, count_is �ΰ����η��Ȥ���
        file.print "#{indent}{\t/* GenParamCopy 11 */\n"
        file.print "#{indent}	#{loop_counter_type.get_type_str}  i__#{nest}, length__#{nest} = #{size_str};\n"

        file.print "#{indent}	for( i__#{nest} = 0; i__#{nest} < length__#{nest}; i__#{nest}++ ){\n"
        print_param0( name, type.get_type, file, nest + 2, dir, outer, "#{outer2}[i__#{nest}]", b_get, alloc_cp, alloc_cp_extra )
        file.print "#{indent}	}\n"
        file.print "#{indent}}\n"
      end
    end
  end

end
