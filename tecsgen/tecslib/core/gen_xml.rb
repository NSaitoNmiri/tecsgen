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
#   $Id: gen_xml.rb 1932 2013-03-26 07:35:41Z okuma-top $
#++

XML_INDENT = "    "

class Namespace
  def self.gen_XML root_namespace
    begin
      file_name = $gen_base + "/" + $target + ".xml"
      dbgPrint "generating XML file:#{file_name}\n"
      file = AppFile.open( file_name )

      file.print <<EOT
<?xml version="1.0" encoding="UTF-8"?>
<GUI_Tool xmlns="http://www.toppers.jp/tecs.html">
EOT
      root_namespace.gen_XML file, 1

      file.print <<EOT
</GUI_Tool>
EOT

      file.close
    rescue => evar
      Generator.error( "T9999 fail to create XML file #{file_name}")
      print_exception( evar )
    end
  end

  def gen_XML( file, nest )
    # signature �Υ����ɤ�����
    @signature_list.each { |s|
      s.gen_XML file, nest
    }

    # celltype �Υ����ɤ�����
    @celltype_list.each { |t|
      t.gen_XML( file, nest )
    }

    # cell �Υ����ɤ�����
    @cell_list.each { |t|
      t.gen_XML( file, nest )
    }

    # ���֥͡��ॹ�ڡ����Υ����ɤ�����
    @namespace_list.each { |n|
      kind = n.instance_of?( Namespace ) ? "namespace" : "region"
      file.print <<EOT
#{XML_INDENT * nest}<#{kind}>
#{XML_INDENT * (nest+1)}<name> #{n.get_name} </name>
EOT
      n.gen_XML( file, nest + 1 )
      file.print <<EOT
#{XML_INDENT * nest}</#{kind}>
EOT
    }
  end
end

class Signature
  def gen_XML file, nest
    indent = XML_INDENT * nest
    if is_imported? then
      file.print <<EOT
#{indent}<import path='#{@import.get_cdl_name}'>
EOT
      nest += 1
      indent = XML_INDENT * nest
    end

    file.print <<EOT
#{indent}<signature>
#{indent}#{XML_INDENT}<name> #{@name} </name>
EOT
    @function_head_list.get_items.each{ |fh|
      file.print <<EOT
#{indent}#{XML_INDENT}<func>
#{indent}#{XML_INDENT}#{XML_INDENT}<name> #{fh.get_name} </name>
#{indent}#{XML_INDENT}#{XML_INDENT}<rettype> #{fh.get_return_type.get_type_str}#{fh.get_return_type.get_type_str_post} </rettype>
EOT
      fh.get_paramlist.get_items.each{ |pd|
        file.print <<EOT
#{indent}#{XML_INDENT}#{XML_INDENT}<param>
#{indent}#{XML_INDENT}#{XML_INDENT}#{XML_INDENT}<name> #{pd.get_name} </name>
#{indent}#{XML_INDENT}#{XML_INDENT}#{XML_INDENT}<type> #{pd.get_type.get_type_str}#{pd.get_type.get_type_str_post} </type>
#{indent}#{XML_INDENT}#{XML_INDENT}</param>
EOT
      }
      file.print <<EOT
#{indent}#{XML_INDENT}</func>
EOT
    }
    file.print <<EOT
#{indent}</signature>
EOT
    if is_imported? then
      nest -= 1
      indent = XML_INDENT * nest
      file.print <<EOT
#{indent}</import>
EOT
    end
  end
end

class Celltype
  def gen_XML file, nest
    indent = XML_INDENT * nest
    if is_imported? then
      file.print <<EOT
#{indent}<import path='#{@import.get_cdl_name}'>
EOT
      nest += 1
      indent = XML_INDENT * nest
    end

    file.print <<EOT
#{indent}<celltype>
#{indent}#{XML_INDENT}<name> #{@name} </name>
EOT
    if @active then
      file.print <<EOT
#{indent}#{XML_INDENT}<active />
EOT
    end
    if @singleton then
      file.print <<EOT
#{indent}#{XML_INDENT}<singleton />
EOT
    end

    @attribute.each{ |attr|
      file.print <<EOT
#{indent}#{XML_INDENT}<attr>
#{indent}#{XML_INDENT}#{XML_INDENT}<name> #{attr.get_name} </name>
#{indent}#{XML_INDENT}#{XML_INDENT}<type> #{attr.get_type.get_type_str}#{attr.get_type.get_type_str_post} </type>
EOT
      if attr.get_initializer then
        file.print <<EOT
#{indent}#{XML_INDENT}#{XML_INDENT}<initializer> #{attr.get_initializer.to_CDL_str} </initializer>
EOT
      end
      file.print <<EOT
#{indent}#{XML_INDENT}</attr>
EOT
    }
    @port.each{ |port|
      port_type = port.get_port_type == :CALL ? "call" : "entry"
      file.print <<EOT
#{indent}#{XML_INDENT}<#{port_type}>
#{indent}#{XML_INDENT}#{XML_INDENT}<name> #{port.get_name} </name>
#{indent}#{XML_INDENT}#{XML_INDENT}<signame> #{port.get_signature.get_name} </signame>
EOT
      if port.get_array_size then
        file.print <<EOT
#{indent}#{XML_INDENT}#{XML_INDENT}<subscript> #{port.get_array_size} </subscript>
EOT
      end
      file.print <<EOT
#{indent}#{XML_INDENT}</#{port_type}>
EOT
    }
    file.print <<EOT
#{indent}</celltype>
EOT
    if is_imported? then
      nest -= 1
      indent = XML_INDENT * nest
      file.print <<EOT
#{indent}</import>
EOT
    end
  end

end

class Cell
  def gen_XML file, nest
    indent = XML_INDENT * nest

    if is_imported? then
      file.print <<EOT
#{indent}<import path='#{@import.get_cdl_name}'>
EOT
      nest += 1
      indent = XML_INDENT * nest
    end

    file.print <<EOT
#{indent}<cell>
#{indent}#{XML_INDENT}<name> #{@name} </name>
EOT
    @join_list.get_items.each{ |join|
      if join.get_definition.kind_of? Port then
        kind = "call_join"
      elsif join.get_definition.kind_of? Decl then
        kind = "attr_join"
      else
        raise "Unknown"
      end
      if join.get_array_member2 then
        join.get_array_member2.each { |j2|
          file.print <<EOT
#{indent}#{XML_INDENT}<#{kind}>
#{indent}#{XML_INDENT}#{XML_INDENT}<name> #{join.get_name} </name>
#{indent}#{XML_INDENT}#{XML_INDENT}<subscript> #{join.get_subscript} </subscript>
#{indent}#{XML_INDENT}#{XML_INDENT}<rhs> #{join.get_rhs.to_CDL_str} </rhs>
#{indent}#{XML_INDENT}</#{kind}>
EOT
        }
      else
        file.print <<EOT
#{indent}#{XML_INDENT}<#{kind}>
#{indent}#{XML_INDENT}#{XML_INDENT}<name> #{join.get_name} </name>
#{indent}#{XML_INDENT}#{XML_INDENT}<rhs> #{join.get_rhs.to_CDL_str} </rhs>
#{indent}#{XML_INDENT}</#{kind}>
EOT
      end
    }
    file.print <<EOT
#{indent}</cell>
EOT
    if is_imported? then
      nest -= 1
      indent = XML_INDENT * nest
      file.print <<EOT
#{indent}</import>
EOT
    end
  end
end
