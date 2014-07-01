#! /usr/bin/env ruby
# -*- coding: euc-jp -*-

#
#  TECS merger
#      Merger for TECS generated templates
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
#   $Id: tecsmerge.rb 1925 2013-01-20 05:55:58Z okuma-top $
#++

#= tecsgen  : TECS �Υޡ�����
#
#Authors::   �绳 ���
#Version::   
#Copyright:: Copyright (C) TOPPERS Project, 2008-2013. All rights reserved.
#License::   TOPPERS �饤���󥹤˽��

=begin
tecsmerge �ϥƥ�ץ졼�ȥե�����򸵤˺������줿���륿���ץ����ɡʴޥ���饤��ؿ��򵭽Ҥ������륿���ץ���饤��إå��ˤ��ݼ餹���ΤǤ��롣
���륿���פ˰ʲ��β��Ѥ��ä���줿�����б����롣
���������ؿ���������
����������̾�����ѹ����줿
���������ؿ���̾�����ѹ����줿

% tecsmerge source_dir   dest_dir
% tecsmerge source_files dest_dir

% tecsmerge -p port_name -f old_name:new_name source_file dest_dir
% tecsmerge -p old_name:new_name source_file dest_dir

source_file ��̾���� _teml.c, _templ.h �ǽ���äƤ��ʤ��ƤϤʤ�ʤ�
dest_file �� source_file �� _templ ���������̾���Ǥʤ��ƤϤʤ�ʤ�
dest_file ��¸�ߤ��ʤ���硢_templ ���������̾���ǥ��ԡ���������Ǥ���

�ʲ��Υ�����ɤ� �ޤ�Ԥ�õ��

0) ��Ƭ
1) /* #[<PREAMBLE>]#,
2)  * #[</PREAMBLE>]#
3) /* #[<ENTRY_PORT>]#
4)  * #[</ENTRY_PORT>]#
5) /* #[<ENTRY_FUNC>]#
6)  * #[/<ENTRY_FUNC>]#
    * #[/ENTRY_FUNC>]#     # for Bug compatibility
7) /* #[<POSTAMBLE>]#
8)  * #[</POSTAMBLE>]#
9) �����

�嵭�Τ��� 1), 3), 5), 7) �򳫻ϥ�����ɤȸƤ֡�
�ʤ����ä��Ǥ�Τʤ���硢9) �Ⳬ�ϥ�����ɤ˴ޤࡣ

̾�����ѹ�

a) ������̾���ѹ�

  -p old_port_name:new_port_name

b) �������ؿ�̾���ѹ�

  -f old_port_name:new_port_name

 old_port_name, new_port_name �ϡ����η����Ǥʤ��ƤϤʤ�ʤ���

  ������̾ + '_' + �ؿ�̾


i) �إå���

  0) �ȳ��ϥ�����ɤδ�

ii) �إå���

  1) �ȳ��ϥ�����ɤδ�

�̾���줬ʣ��¸�ߤ��뤳�ȤϤʤ�����ʣ��¸�ߤ�����硢���٤ƥե�����
����Ƭ�˽��Ϥ���롣

iii) �������إå�

  3) �ȳ��ϥ�����ɤδ�

�������إå��ϡ���³�μ������ؿ��μ�������ɽ����ΤȲ��ꤵ��롣
�������إå��ϡ����פǤϤʤ���

iv) �������ؿ�

  5) �ȳ��ϥ�����ɤδ�

=end

require 'optparse'
$n_err   = 0
$b_show  = false
$b_exist = false            # ���ԡ���˥ե����뤬������Τߥޡ���
$old_mode = false           # old_mode (�ؿ����ΤȤ��� /<ENTRY_FUNC> ������� '{' ��Ȥ�

#2.0
def write_array( file, array )
  array.each{ |line|
    file.write line
  }
end

class PortRenamer
  @@port_renamer_list = {}
  @@port_renamer_current = nil

  def initialize( old_port_name, new_port_name )
    old_port_name = old_port_name.to_sym
    if new_port_name then
      new_port_name = new_port_name.to_sym
    end
    # p "port_renamer: #{old_port_name}"
    @@port_renamer_list[old_port_name] = self
    @@port_renamer_current = self
    @old_port_name = old_port_name
    @new_port_name = new_port_name
    @func_renamer_list = {}
  end

  def self.add_func( old_name, new_name )
    # p "add_func: #{old_name}"
    if @@port_renamer_current == nil then
      STDERR.puts( "error: #{old_name}: specify -p before -f" )
      n_err += 1
    else
      @@port_renamer_current.add_func( old_name, new_name )
    end
  end

  def add_func( old_name, new_name )
    old_name = old_name.to_sym
    new_name = new_name.to_sym
    if @func_renamer_list[old_name] then
      STDERR.puts( "error: #{old_name}: duplicate in port #{@old_port_name}" )
      $n_err += 1
    elsif old_name == new_name then
      STDERR.puts( "error: #{old_name}: old and new are the same name" )
      $n_err += 1
    end
    @func_renamer_list[old_name] = new_name
  end

  def self.show
    if @@port_renamer_list then
      @@port_renamer_list.each { |pr,pc|
        pc.show
      }
    end
  end

  def self.get_list
    @@port_renamer_list
  end

  attr_accessor  :old_port_name, :new_port_name, :func_renamer_list

  def show
    print "port: #{@old_port_name}"
    if @new_port_name then
      print " => #{@new_port_name}"
    end
    puts ""

    @func_renamer_list.each { |old,new|
      print "  func: #{old} => #{new}\n"
    }
  end
end


class CDLContents
  #@head::             [string]
  #@preamble_comment:: [string]
  #@preamble_body::    [string]
  #@entry_port::       {ep_name=>CDLEntryPort}
  #@entry_port_array:: [CDLEntryPort]
  #@postamble_comment::[string]
  #@postamble_body::   [string]

  @@DELIMITERS = {
    # state             => [ regexp_original,                 [previous states]                   , Regexp ]
    :HEAD               => [ "#[<BeginingOfFile>]#",          []                       ],
    :PREAMBLE_COMMENT   => [ "/* #[<PREAMBLE>]#",             [:HEAD]                  ],
    :PREAMBLE_BODY      => [ " * #[</PREAMBLE>]#",            [:PREAMBLE_COMMENT]      ],
    :ENTRY_COMMENT      => [ "/* #[<ENTRY_PORT>]# PORT_NAME", [:PREAMBLE_BODY, :ENTRY_FUNC_BODY, :ENTRY_FUNC_BODY2] ],
    :ENTRY_BODY         => [ " * #[</ENTRY_PORT>]#",          [:ENTRY_COMMENT]         ],
    :ENTRY_FUNC_COMMENT => [ "/* #[<ENTRY_FUNC>]# FUNC_NAME", [:ENTRY_BODY, :ENTRY_FUNC_BODY, :ENTRY_FUNC_BODY2]    ],
    :POSTAMBLE_COMMENT  => [ "/* #[<POSTAMBLE>]#",            [:ENTRY_FUNC_BODY, :ENTRY_FUNC_BODY2, :PREAMBLE_BODY] ],
    :POSTAMBLE_BODY     => [ " * #[</POSTAMBLE>]#",           [:POSTAMBLE_COMMENT]     ],
    :EOF                => [ "#[</EndOfFile>]#",              [:POSTAMBLE_BODY,:ENTRY_FUNC_BODY, :ENTRY_FUNC_BODY2, :PREAMBLE_BODY]  ],
  }

  @@DELIMITERS_FUNC_BY_COMMENT = {
    :ENTRY_FUNC_BODY    => [ " * #[</ENTRY_FUNC>]#",          [:ENTRY_FUNC_COMMENT]    ],
    :ENTRY_FUNC_BODY2   => [ " * #[/ENTRY_FUNC>]#",           [:ENTRY_FUNC_COMMENT]    ],  # for Bug compatibility
  }

  @@DELIMITERS_FUNC_BY_BRACKET = {
    :ENTRY_FUNC_BODY    => [ "\\\{",                          [:ENTRY_FUNC_COMMENT]    ],
  }

  def self.rewrite_DELIMITERS  delimiters
    delimiters.each{ |stat, stat_info|
      s = stat_info[0].gsub( /([\*\[\]])/, "\\\\\\1" )   # *, [, ] ������ \\ ������
      s.gsub!( /\s*\w*_NAME/, "\\s*(\\w*)" )             # ..._NAME �� (w*) ���ѹ�
      s = "^" + s                                        # ^ ����Ƭ������
      stat_info[2] = Regexp.new( s )
      # p stat_info[2]
    }
  end

  rewrite_DELIMITERS @@DELIMITERS
  rewrite_DELIMITERS @@DELIMITERS_FUNC_BY_COMMENT
  rewrite_DELIMITERS @@DELIMITERS_FUNC_BY_BRACKET

  #=== �⡼�ɤ˽��� DELIMITERS �� DELIMITERS_FUNC_BY_* ��ޡ�������
  # mode :OLD_FUNC_BODY, :NEW_FUNC_BODY
  def self.merge_DELIMITERS mode
    case 
    when :OLD_FUNC_BODY
      @@DELIMITERS.merge! @@DELIMITERS_FUNC_BY_COMMENT
    when :NEW_FUNC_BODY
      @@DELIMITERS.merge! @@DELIMITERS_FUNC_BY_BRACKET
    else
      raise "unknown mode"
    end
  end

  #all_contents:: [string,...]
  def initialize all_contents
    part = []
    line_no = 0
    stat = :HEAD
    arg = nil
    port_name = nil
    func_name = nil

    @entry_port = {}
    @entry_port_array = []

    (all_contents+[nil]).each{ |line|  # nil: EOF
      line_no += 1
      # p "L: #{line}"
      b_delim = false        # �ǥ�ߥ�������ɤι�
      @@DELIMITERS.each { |next_stat,stat_info|

        next if next_stat == :HEAD || ( next_stat == :EOF && line != nil )

        # p "R: #{stat_info[0]}"
        if stat_info[2] =~ line || ( line == nil && next_stat == :EOF ) then
          # p "D: #{line}: #{stat}"
          b_delim = true

          found = false
          stat_info[1].each{ |prev_stat|
            if stat == prev_stat then
              found = true
            end
          }
          if ! found then
            STDERR.puts "error #{line_no}: unsuitable previous keyword"
            STDERR.puts "error #{line_no}:   previous:  \"#{@@DELIMITERS[stat][0]}\""
            STDERR.puts "error #{line_no}:   current:   \"#{@@DELIMITERS[next_stat][0]}\""
            expect = ""; delim = ""
            stat_info[1].each{ |prev_stat| expect = "#{expect+delim}\"#{@@DELIMITERS[prev_stat][0]}\""; delim = ", " }
            STDERR.puts "error #{line_no}:   suitable previous: #{expect}"
            $n_err += 1
          end

          case stat
          when :PREAMBLE_COMMENT, :ENTRY_COMMENT, :ENTRY_FUNC_COMMENT, :POSTAMBLE_COMMENT
            part << line
          end

          case stat   # ���ξ���
          when :HEAD
            @head = part
          when :PREAMBLE_COMMENT
            @preamble_comment = part
          when :PREAMBLE_BODY
            @preamble_body = part
          when :ENTRY_COMMENT
            port_name = arg.to_sym
            @entry_port[ port_name ] = CDLEntryPort.new
            @entry_port_array << port_name
            @entry_port[ port_name ].entry_comment = part
          when :ENTRY_BODY
            @entry_port[ port_name ].entry_body = part
          when :ENTRY_FUNC_COMMENT
            func_name = arg.to_sym
            if @entry_port[ port_name ] then   # nil �ʤ���˥��顼
              @entry_port[ port_name ].entry_func_comment[ func_name ] = part
              @entry_port[ port_name ].entry_func_array << func_name
            end
          when :ENTRY_FUNC_BODY, :ENTRY_FUNC_BODY2
            if @entry_port[ port_name ] then   # nil �ʤ���˥��顼
              @entry_port[ port_name ].entry_func_body[ func_name ] = part
            end
          when :POSTAMBLE_COMMENT
            @postamble_comment = part
          when :POSTAMBLE_BODY
            @postamble_body = part
          else
            raise "Unknown state #{stat}"
          end

          case next_stat
          when :PREAMBLE_COMMENT, :ENTRY_COMMENT, :ENTRY_FUNC_COMMENT, :POSTAMBLE_COMMENT
            part = [ line ]
          else
            part = []
          end

          stat = next_stat
          arg = $1     # arg �˼�äƤ���
          # p stat, arg
          break
        end
      }

      if ! b_delim then
        part << line
      end
    }
      
  end

  def check template
    # template �ˤʤ���Τ�����å�
    @entry_port.each{ |port_name, entry_port|
      temp_entry_port = template.entry_port[port_name]
      if temp_entry_port == nil then
        STDERR.puts "info: #{port_name} is deleted port"
        next
      end
      # temp_entry_port.entry_func_body.each{ |f,b|  p f }
      entry_port.entry_func_body.each{ |func_name, func_body|
        if temp_entry_port.entry_func_body[func_name] == nil then
          STDERR.puts "info: #{func_name} is deleted function"
        end
      }
    }
  end

  def rename

    renamed_entry_port = {}
    PortRenamer.get_list.each{ |pon,pr|

      # �оݼ��������ܤ�
      ep = @entry_port[pon]
      if ep == nil then
        STDERR.puts "warning: #{pon}: renaming port not found"
        next
      end

      # �ݡ��Ȥ� rename
      pnn = pr.new_port_name    # �ִ����̾��
      if pnn then
        # �ִ�����̾��������С���Ͽ���ʤ���
        renamed_entry_port[pnn] = @entry_port[pon]
        @entry_port.delete pon
      end

      # ���ꤵ�줿�ؿ����ִ�
      renamed_func_comment = {}
      renamed_func_body = {}
      pr.func_renamer_list.each{ |old,new|
        ofn = "#{pon}_#{old}".to_sym
        nfn = "#{pon}_#{new}".to_sym
        # p "fnn: #{ofn} #{nfn} #{pon}"
        if ep.entry_func_comment[ofn] == nil then
          STDERR.puts "warning: #{old}: renaming function not found"
          next
        end
        ep.entry_func_array.map! { |fn|
          # p fn, nfn, ofn, fn==ofn ? nfn : fn
          fn==ofn ? nfn : fn
        }
        renamed_func_comment[nfn] = ep.entry_func_comment[ofn]
        renamed_func_body[nfn]    = ep.entry_func_body[ofn]
        ep.entry_func_comment.delete ofn
        ep.entry_func_body.delete    ofn
      }
      ep.entry_func_comment.merge! renamed_func_comment
      ep.entry_func_body.merge!    renamed_func_body

      # �ݡ���̾���ѹ��ˤ��ؿ�̾���ִ�
      renamed_func_comment = {}
      renamed_func_body = {}
      if pnn then
        ep.entry_func_array.map! { |ofn|
          nfn = ofn.to_s.sub( /#{pon.to_s}/, pnn.to_s ).to_sym
          # p "pnn: #{ofn} #{nfn} #{pon}  #{pnn}"
          if nfn != ofn then
            renamed_func_comment[nfn] = ep.entry_func_comment[ofn]
            renamed_func_body[nfn]    = ep.entry_func_body[ofn]
            ep.entry_func_comment.delete ofn
            ep.entry_func_body.delete    ofn
            nfn
          else
            ofn
          end
        }
        ep.entry_func_comment.merge! renamed_func_comment
        ep.entry_func_body.merge!    renamed_func_body

        # ep.entry_func_comment.each { |f,e| p "FF: #{f}" }
        # ep.entry_func_array.each { |f,e| p "FA: #{f}" }
      end
    }
    # p renamed_entry_port
    @entry_port.merge! renamed_entry_port
  end

  def merge src
    @head = src.head
    @preamble_body = src.preamble_body
    @postamble_body = src.postamble_body

    @entry_port_array.each{ |port_name|
      # p "merging #{port_name}"
      entry_port = @entry_port[ port_name ]
      src_entry_port = src.entry_port[port_name]
      if src_entry_port == nil then
        print "port merged:   #{port_name}\n"
        next
      end
      entry_port.entry_body = src_entry_port.entry_body
      entry_port.entry_func_array.each{ |func_name|
        # p "merging #{func_name}"
        func_body = entry_port.entry_func_body[ func_name ]
        if src_entry_port.entry_func_body[func_name] == nil then
          print "func merged:   #{func_name}\n"
          next
        end
        print "func remained: #{func_name}\n"
        # entry_port.entry_func_comment[func_name] = src_entry_port.entry_func_comment[func_name]
        entry_port.entry_func_body[func_name]    = src_entry_port.entry_func_body[func_name]
      }
    }
  end

  def write file
#2.0    file.write @head
    write_array( file, @head )
#2.0    file.write @preamble_comment
    write_array( file, @preamble_comment )
#2.0    file.write @preamble_body
    write_array( file, @preamble_body )
    @entry_port_array.each{ |port_name| @entry_port[port_name].write file }
#2.0    file.write @postamble_comment
    write_array( file, @postamble_comment )
#2.0    file.write @postamble_body
    write_array( file, @postamble_body )
  end

  attr_accessor :head, :preamble_comment, :preamble_body, :entry_port, :postamble_body
end

class CDLEntryPort
  #@entry_comment::      [string]
  #@entry_body::         [string]
  #@entry_func_comment:: {ep_func_name=>string}
  #@entry_func_body::    {ep_func_name=>string}
  #@entry_func_array::   [string]

  def initialize
    @entry_comment = []
    @entry_body = []
    @entry_func_comment = {}
    @entry_func_body = {}
    @entry_func_array = []
  end

  def write file
#2.0    file.write @entry_comment
    write_array( file, @entry_comment )
#2.0    file.write @entry_body
    write_array( file, @entry_body )
    @entry_func_array.each{ |fnm|
      # p @entry_func_comment[fnm][0]

#2.0      file.write @entry_func_comment[fnm]
      write_array( file, @entry_func_comment[fnm] )
#2.0      file.write @entry_func_body[fnm]
      write_array( file, @entry_func_body[fnm] )
    }
  end

  attr_accessor :entry_comment, :entry_body, :entry_func_comment, :entry_func_body, :entry_func_array
end

def merge( src_file, dst_dir )
  unless src_file =~ /(.*)_templ(.[ch])$/ then
    STDERR.puts( "error: #{src_file}: not end with _templ.c/h" )
    exit 1
  end

  fname = "#{$1}#{$2}"
  dst_file = "#{dst_dir}/#{File.basename fname}"
  if FileTest.file?( dst_file ) then
    print( "merging #{src_file} to #{dst_file}\n" )
    # dst_file ���ɹ���
    begin
      dst = open( dst_file )
#2.0
      set_encoding dst
      old_contents = dst.readlines
    rescue
      STDERR.puts "error: cannot open #{dst_file}"
      $n_err += 1
      exit 1
    ensure
      dst.close
    end
    old = CDLContents.new( old_contents )

    # template ���ɹ���
    begin
      src = open( src_file )
#2.0
      set_encoding src
      new_contents = src.readlines
    rescue
      STDERR.puts "error: cannot open #{src_file}"
      $n_err += 1
      exit 1
    ensure
      src.close
    end
    templ = CDLContents.new( new_contents )

    old.rename
    error_check dst_file, 1

    old.check templ
    error_check dst_file, 2

    templ.merge old
    error_check dst_file, 3

    bkup_file = rename_dst( dst_file )

    begin
      dst = open( dst_file, "w" )
#2.0
      set_encoding dst
      templ.write dst
    ensure
      dst.close
    end

  elsif $b_exist == false then
    # src_file �� dst_file �إ��ԡ�
    begin
      src = File.open( src_file )
#2.0
      set_encoding src
      contents = src.readlines
    rescue
      print "#{src_file}: fail to read\n"
    ensure
      src.close
    end

    begin
      dst = File.open( dst_file, "w" )
      set_encoding dst
#2.0      dst.write( contents )
      contents.each{ |line|
        dst.print line
      }
    rescue
      print "#{dst_file}: fail to write\n"
    ensure
      dst.close
    end
  else
    print "info: #{dst_file} skipped\n"
  end
end

def error_check dst_file, level
  if $n_err > 0 then
    STDERR.puts "=== #{dst_file} not generated because of error ==="
    exit level
  end
end


#=== �ե�����Υ��󥳡��ǥ��󥰤� ASCII-8BIT ���ѹ�
# Ruby 1.9 �ʾ�ξ����ѹ�
def set_encoding file
  if RUBY_VERSION >= "1.9.0" then
    file.set_encoding "ASCII-8BIT"
  end
end

#=== rename_dst
# dst_file �ΥХå����åץե�����̾����ꤷ����͡��ह��
# ��������С���͡����Υե�����̾���֤�
# dst_file ��¸�ߤ��ʤ���Сʥ�͡���ϹԤ�줺��nil ���֤���
def rename_dst( dst_file )
  begin
    File.stat dst_file
  rescue
    STDERR.puts( "info: backup not generated for #{dst_file}" )
    # �ʤ���н����
    return nil
  end

  i = 0
  found = true
  while found == true
    begin
      i = i + 1
      bkup_file = "#{dst_file}_#{i}"
      File.stat bkup_file
    rescue
      found = false
    end
  end

  begin
    File.rename( dst_file, bkup_file )
    STDERR.puts( "info: backup generated for #{dst_file} to #{bkup_file}" )
    return bkup_file
  rescue
    STDERR.puts( "error: fail to rename backup file: #{bkup_file}" )
    exit 1
  end

  return nil
end

ARGV.options {|parser|
  parser.banner =<<EOT
Usage: tecsmerge [options] files_templ.c   src_dir
       tecsmerge [options] gen_dir         src_dir
EOT
  parser.on('-e', '--exist-only',  "merge if exist in destination directory") { |fs|
    $b_exist = true
  }
  parser.on('-p', '--port=old_name:new_name',  "specify entry port name change") { |ps|
    p = ps.split( ':' )
    PortRenamer.new( p[0], p[1] )
  }
  parser.on('-f', '--func=old_name:new_name',  "specify entry function name change") { |fs|
    f = fs.split( ':' )
    PortRenamer.add_func( f[0], f[1] )
  }
  parser.on('-s', '--show_change_set',  "show change set. all substitute") {
    $b_show = true
  }
  parser.on('-o', '--old-mode',  "old mode (function head not substituted)") { |fs|
    $old_mode = true
  }
  parser.version = #{$version}
  parser.release = nil
  parser.parse!
#  if ARGV.empty?
  if ARGV.length < 2 then
    puts parser.help
    exit 1
  end
}

if $b_show then
  PortRenamer.show
end

if $old_mode then
  CDLContents.merge_DELIMITERS :OLD_FUNC_BODY
else
  CDLContents.merge_DELIMITERS :NEW_FUNC_BODY
end

if $n_err > 0 then
  STDERR.puts( "#{$n_err} errors" )
  exit 1
end

src = ARGV[0,ARGV.length-1]
dst = ARGV[-1]

begin
  stat = File.stat dst
rescue
  STDERR.puts( "error: #{dst}: not found" )
  exit 1
ensure
  if stat && ! stat.directory? then
    STDERR.puts( "error: #{dst}: not directory" )
    exit 1
  end
end

src.each { |s|
  begin
    stat = File.stat s
  rescue
    STDERR.puts( "error: #{s}: not found or cannot access" )
    exit 1
  end

  if stat.directory? then
    Dir.foreach(s) {|file|
      if file =~ /_templ.[ch]$/ then
        merge( "#{s}/#{file}", dst )
      end
    }
  elsif stat.file? then
    merge( s, dst )
  end
}
