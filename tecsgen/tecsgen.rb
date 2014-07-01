#!/usr/bin/env ruby
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
#   $Id: tecsgen.rb 1943 2013-04-30 01:37:51Z okuma-top $
#++

#= tecsgen  : TECS �Υ����ͥ졼��
#
#Authors::   �绳 ���
#Version::   
#Copyright:: Copyright (C) TOPPERS Project, 2008-2013. All rights reserved.
#License::   TOPPERS �饤���󥹤˽��

###
#= Array  initializer �� '{', '}' �ǰϤޤ줿���
# mikan AggregateInitializer �ʤɡ����饹���ѹ����٤��Ǥ���
class Array
  #=== CDL ��ʸ�������������
  def to_CDL_str
    str = '{ '
    delim = ''
    self.each{ |v|
      str += delim + v.to_CDL_str
      delim = ', '
    }
    str += ' }'
    return str
  end

  def show_tree( indent )
    indent.times{ print "  " }
    print( "Array\n" )
    self.each{ |m|
      m.show_tree( indent+1 )
    }
  end
end

#=== RUBY �饤�֥�����ɤ���
#
# -L, $RUBYLIB, �����ƥ�(/usr/lib/rub..�ʤ�) �ν�˥��������Ԥ���
# exerb �б��Τ��ᡢ�嵭�ѥ��˥ե����뤬���Ĥ���ʤ���� require ��¹Ԥ��Ƥߤ�
#
# �ץ饰����ξ��� b_fatal = false ����ꡣ�ե����뤬�ʤ��Ƥ⥨�顼���ϸ塢����³��
# b_fatal = false �ξ�� tecslib/core ���������ѥ����ɲä����
#RETURN::Bool   : true=������ false=����   ���Ԥ�����硢Generator.error �ϸƤӸ��ǽ��Ϥ���
def require_tecsgen_lib( fname, b_fatal = true )
  dbgPrint( "require_lib: #{fname}\n")
  set_kcode $KCODE_TECSGEN
  begin  
    b_require = false
    b_exception = false

    # -L �� $RUBYLIB �ǻ��ꤵ�줿�ѥ�����ӥ����ƥ�Υѥ����饵����
    #   exerb �Ǥ� $LOAD_PATH �� ["."] �Τ����äƤ���褦��
    ($library_path+$LOAD_PATH).each{ |path|
      [ "", "tecslib/plugin/" ].each { |lp|
        lib = File.expand_path( path ) + '/' + lp + fname

        if File.exist? lib then  # �ե�����¸�ݤ�¾�Υ��顼����̤��뤿��¸�߳�ǧ�򤹤�
          begin
            require( lib )
            b_require = true
          rescue Exception => evar
            b_exception = true
            print_exception( evar )

          end
          break
        end
      }
      if b_require then
        break
      end
    }

    if b_require == false && b_exception == false then
      # exerb �б� "." �򥵡����ѥ��κǽ�˲ä���
      #   "tecslib/" �� RPCPlugin.rb, TracePlugin.rb �Τ�����Ѱդ��Ƥ���
      #   RPCPlugin.rb, TracePlugin.rb �� tecslib ���Ǥʤ�������פˤʤ뤬�����Τ褦�ˤ��Ƥ���
      ["","tecslib/plugin/"].each{ |lp|
        path = lp + fname
        begin
          require path
          return true
        rescue LoadError => e
          # p "LoadError to load #{fname}"
        rescue Exception => e
          b_exception = true
          # ʸˡ���顼�ʤɤ�ȯ��
          print_exception( e )
          break
        end
      }
    end

    if b_require == false then
      # ���Ĥ���ʤ��ä�
      if b_exception == false then
        STDERR << "tecsgen: Fail to load #{fname}. Check $RUBYLIB environment variable or -L option\n"
      end
      # tecsgen ��������ե�����ξ�����ߤ���
      if b_fatal then
        STDERR << "tecsgen: Exit because of unrecoverble error\n"
        exit 1
      end
      return false
    end
    return true
  ensure
    # $KCODE �� CDL ��ʸ�������ɤ��ᤷ�Ƥ���
    set_kcode $KCODE_CDL
  end
end

#=== �㳰��ɽ��
#evar:: Exception
def print_exception( evar )
  # �⤷�����å��ȥ졼�����Ф�ޤǤ����֤�������褦�ʤ�С����򥳥��ȥ����Ȥ��Ƥߤ�٤�
  puts( evar.to_s )

  if $debug then
    puts "#### stack trace ####"
    pp evar.backtrace
  end
end

def dbgPrint( str )
  if $debug then
    print str
  end
end

def dbgPrintf( *param )
  if $debug then
    printf *param
  end
end

#=== ���顼����ӷٹ�Υ�ݡ���
def print_report
  msg = nil

  if Generator.get_n_error != 0 then
    msg = "#{Generator.get_n_error} error"
    msg = "#{msg}s" if Generator.get_n_error >= 2
  end

  if Generator.get_n_warning != 0 then
    msg = "#{msg}  " if msg
    msg = "#{msg}#{Generator.get_n_warning} warning"
    msg = "#{msg}s" if Generator.get_n_warning >= 2
  end

  puts msg if msg
end

#=== $KCODE ������
def set_kcode kcode
  if ! $b_no_kcode then
    $KCODE = kcode
  end
end

###

require 'optparse'
#2.0 require 'runit/assert.rb'
require 'kconv'
$b_no_kcode = RUBY_VERSION >= "1.9.0" ? true : false
                       # Use Ruby 1.9 M17N code (use Ruby 1.8 code if false).
if ! $b_no_kcode then
  require 'jcode'
end
require 'pp'
# include RUNIT::Assert

### �����Х��ѿ���� ###

# ���ޥ�ɥ饤������� (Makefile.templ �ؽ���)
$arguments = ""
ARGV.each { |a| $arguments += " " + a }

$unopt     = false     # bool:   disable optimizing
$gen_base  = "gen"     # string: folder path to place generated files
$gen       = $gen_base # string: folder path to place generated files
$generate_all_template = false   # bool:   generarete template files for all celltypes (if non cell exist or system celltypes)
$generate_no_template = false    # bool:   generarete no template file (neither celltype code nor Makefile)
$idx_is_id = false     # bool:   all components are idx_is_id
$unique_id = false     # bool:   assign unique id to each cell (otherwise begin from 1 for each celltype)
$debug     = false     # bool:   tecsgen debug message
$dryrun    = false     # bool:   dryrun mode: syntax is checked, but not generate any files
$show_tree = false     # bool:   show parsing tree
$verbose   = false     # bool:   verbose mode: show some messages
$yydebug   = false     # bool:   yydebug: parser debug mode (need bnf-deb.tab.rb)
$import_path = [ "." ] # string array : import/import_C path
$library_path = [ "" ] # string array : path to dir where tecsgen.rb placed
$define    = [ ]       # string array : define
$ram_initializer = false # bool: generate ram initializer
$region_list = {}      #string array : region path which is generated
$generating_region = nil # Region:  Region to optimisze & generate code   # ���ޥ�ɥ饤�󥪥ץ����ǤϤʤ�
                         #           Cell#is_generate? �ˤƻ��Ȥ����
$unit_test = false     # bool:   unit test verification
$kcode     = nil       # nil | String: Kanji code type "euc"|"sjis"|"none"|"utf8"
$force_overwrite = false # bool:  force overwrite all files if file contents not differ
$no_banner = false     # bool:   not print banner
$print_version = false # bool:   print version
$target    = "tecs"    # String: target name, ARGV[0] ��������ꤹ���"tecs" �ϲ��Υ������å�)
$no_default_import_path = false  # bool: no default import path

if ENV['TECSGEN_DEFAULT_RAM'] then
  rom_ram_defalult = "ram"
else
  rom_ram_defalult = "rom"
end
if rom_ram_defalult == "rom" then
  $rom       = true      # bool:   ROM support : generate CB separately
else
  $rom       = false     # bool:   ROM support : generate CB separately
end
if $cpp == nil then
  $cpp       = "gcc -E -DTECS"
end
if ENV[ 'TECS_CPP' ]then
  $cpp = ENV[ 'TECS_CPP' ]
end
if ENV[ 'TECSPATH' ] then
  $tecspath = ENV[ 'TECSPATH' ]
else
  $tecspath = "."
end

# # ʸ�������ɤ�����
if $IN_EXERB then
  # KCODE_CDL, $KCONV_CDL �򲾤����ꤹ�� (tecs_lang.rb �Ǥ����˺����ꤵ���)
  $KCODE_CDL = "SJIS"          # string: "EUC" | "SJIS" | "NONE" | "UTF8"
  $KCONV_CDL = Kconv::SJIS     # const: NONE �ˤ� ASCII ���б�������
else
  $KCODE_CDL = "EUC"           # string: "EUC" | "SJIS" | "NONE" | "UTF8"
  $KCONV_CDL = Kconv::EUC      # const: NONE �ˤ� ASCII ���б�������
end
$KCODE_TECSGEN = "EUC"       # string: "EUC"  ���Υե������ʸ�������ɡʥ��ץ����ǤϤʤ������
$KCONV_TECSGEN = Kconv::EUC  # const: 
set_kcode( $KCODE_TECSGEN )  # ���Υե������ʸ�������ɤ�����


###  tecsgen ���ޥ�ɥ��ץ�������  ###
ARGV.options {|parser|
  parser.banner = "Usage: tecsgen [options] files"
  parser.on('-D', '--define=def', 'define cpp symbol for import_C') { |define|
    $define << define
  }
  parser.on('-G', '--generate-region=path', 'generate region') { |path|
    if path =~ /^::/ then
      gen_path = path
    else
      gen_path = "::" + path
    end
    $region_list[ gen_path ] = true
  }
  parser.on('-I', '--improt-path=path', 'imoprt/import_C path') { |path|
    $import_path << path
  }
  parser.on('-L', '--library-path=path', 'path to dir where tecsgen.rb') { |path|
    $library_path << path
  }
  parser.on('-R', '--RAM-initializer',   'generate RAM initializer' ){
    $ram_initializer = true
  }
  parser.on('-U', '--unoptimize', 'unoptimize') {
    $unopt = true
  }
  parser.on('-c', '--cpp=cpp_cmd', 'C pre-processor command used import_C (default: gcc -E -D TECS), you can also specify by environment variable TECS_CPP' ){
    |arg|
    $cpp = arg
  }
  parser.on('-d', '--dryrun',      'dryrun' ){
    $dryrun = true
  }
  parser.on('-f', '--force-overwrite', 'force overwrite all files') {
    $force_overwrite = true
  }
  parser.on('-g', '--gen=dir',     'generate dir') { |dir|
    $gen = $gen_base = dir
  }
  parser.on('-i', '--idx_is_id',   'set idx_is_id to all celltypes') {
    $idx_is_id = true
  }
#  parser.on('-k', '--kcode=code',  'set kanji code: euc|sjis|none|utf8, none is default') { |code|
  parser.on('-k', '--kcode=code',  "set kanji code: euc|sjis|none|utf8") { |code|
    $kcode = code
  }
#  old_mode �� V1.0.C.22 ���ѻ�
#  parser.on('-o', '--old-mode',    'old mode' ){
#    $old_mode = true
#  }
  parser.on('-r', '--ram',     'RAM only' ){
    $rom = false
  }
  parser.on('-s', '--show-tree',   'show parsing tree' ){
    $show_tree = true
  }
  parser.on('-t', '--generator-debug', 'generator debug' ){
    $debug = true
    $verbose = true
  }
  parser.on('-u', '--unique-id', 'assign unique id for each cell' ){
    $unique_id = true
  }
  parser.on('-v', '--verbose',     'verbose mode' ){
    $verbose = true
  }
  parser.on('-y', '--yydebug',     'yydebug' ){
    $yydebug = true
  }
  parser.on( '--no-banner', 'not display banner') {
    $no_banner = true
  }
  parser.on( '--version', 'print version') {
    $print_version = true
  }
  parser.on( '--unit-test', 'unit verification (test tecsgen itself)') {
    $unit_test = true
  }
  parser.on( '--generate-all-template', 'generate all celltypes\' templates') {
    $generate_all_template = true
  }
  parser.on( '--generate-no-template',  'generate no template') {
    $generate_no_template = true
  }
  parser.on( '--no-default-import-path', 'no default import path' ){
    $no_default_import_path = true
  }
#  parser.on(  '--include_path_opt_format',  'cpp include path option format, default: "-I %s"' ){
#  }
  parser.version = #{$version}
  parser.release = nil
  parser.parse!
}
if ARGV.empty? && ! $print_version && ! $unit_test
  ARGV.options{|parser|
    puts parser.help
    exit 1
  }
end

### tecsgen �⥸�塼��Υ��� ####
# -L �ǥѥ������ǽ�Ȥ������ᡢ����������ɤ򳫻Ϥ���

#  tecsgen �С������ե�����Υ���
# �����¹Ԥ���ޤ� tecsgen �ΥС�������ɽ���Ǥ��ʤ�
# ���Υե�������ä��ɤ߹���ȡ��ۤʤ�С������̾��ɽ�����Ƥ��ޤ�
require_tecsgen_lib 'tecslib/version.rb'
if ! $no_banner || $print_version
  STDERR << "tecsgen  version #{$version}  copyright(c) 2008-2013, TOPPERS project\n"
end
if $verbose then
  STDERR << "ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE} patchlevel #{RUBY_PATCHLEVEL}) [#{RUBY_PLATFORM}]\n"
end
if $print_version && ARGV.empty?
  exit
end

# ʸ�������ɷ���Τ���ǽ���ɤߤ���
require_tecsgen_lib 'tecslib/core/tecs_lang.rb'

unless $yydebug then
  require_tecsgen_lib 'tecslib/core/bnf.tab.rb'
else
  require_tecsgen_lib 'tecslib/core/bnf-deb.tab.rb'
end

# syntaxobj.rb �ˤ� Node ���������Ƥ���Τǡ��ᤤ�ʳ��� require 
require_tecsgen_lib 'tecslib/core/syntaxobj.rb'
require_tecsgen_lib 'tecslib/core/pluginModule.rb'
require_tecsgen_lib 'tecslib/core/plugin.rb'
require_tecsgen_lib 'tecslib/core/messages.rb'
require_tecsgen_lib 'tecslib/core/types.rb'
require_tecsgen_lib 'tecslib/core/value.rb'
require_tecsgen_lib 'tecslib/core/componentobj.rb'
require_tecsgen_lib 'tecslib/core/expression.rb'
require_tecsgen_lib 'tecslib/core/optimize.rb'
require_tecsgen_lib 'tecslib/core/tecsgen.rb'
require_tecsgen_lib 'tecslib/core/generate.rb'
require_tecsgen_lib 'tecslib/core/gen_xml.rb'
require_tecsgen_lib 'tecslib/plugin/CelltypePlugin.rb'
require_tecsgen_lib 'tecslib/plugin/CellPlugin.rb'
require_tecsgen_lib 'tecslib/plugin/SignaturePlugin.rb'
require_tecsgen_lib 'tecslib/plugin/ThroughPlugin.rb'

# C ����ѡ���
require_tecsgen_lib 'tecslib/core/C_parser.tab.rb'
require_tecsgen_lib 'tecslib/core/ctypes.rb'

if $unit_test then
  exit 1
end

# $import_path, $tecspath ��Ĵ��
TECSGEN.adjust_exerb_path

# $import_path �˴Ķ��ѿ� $TECSGEN ����Ӥ���ľ�����ɲ�
if $no_default_import_path == false then
  # $TECSGEN ����ӡ�����ľ���Υǥ��쥯�ȥ��ѥ����ɲ�
  if $tecspath != "." then
    TECSGEN.add_import_path $tecspath
    dir = nil
    begin
      Dir.foreach( $tecspath ){ |f|
        if f != "." && f != ".." && File.directory?( $tecspath + '/' + f ) then
          TECSGEN.add_import_path( $tecspath + '/' + f )
        end
      }
    rescue
      # ̵��
    end
  end
end

# $target ������
$target = ARGV[0]
pos = $target.rindex( /[:\\\/]/ )
if pos then
  $target = $target[pos+1..-1]  # �ǥ��쥯�ȥ���ڤ�������ʸ����
end
pos = $target.rindex( /\./ )
if pos then
  $target = $target[0..pos-1]   # ��ĥ�Ҥ��������ʸ����
end

# gen �ǥ��쥯�ȥ�κ���
begin
  if ! File.directory?( $gen_base ) then
    Dir.mkdir( $gen_base )
  end
rescue
  print( "Cannot mkdir #{$gen_base}. If the path has hierarchy, please create directory by manual.\n" )
  exit 1
end

# �롼�� namespace (region) ������
root_namespace = Region.new("::")

####  ��ʸ���� (post �����ɤ����) ####
# ���٤Ƥ� cdl �� import ����
ARGV.each{ |f|
  dbgPrint( "## Import: #{f}\n")
  Import.new( f, false, false )
}

# ���٤Ƥι�ʸ��᤬��λ�������Ȥ����
#   �ºݤˤϡ��夫��ץ饰������������� CDL �Υѡ������Ԥ���
#   ���顼�Կ��η�����ˡ���ѹ��Τ���˹Ԥ�
Generator.end_all_parse
dbgPrint( "## End all parse (except Post Code)\n")

####  ��̣���ϣ� (post �����ɤ����) ####
#0 set_definition_join ��2��ƤӽФ�����1���ܡ�
dbgPrint( "## Checking all join\n")
root_namespace.set_definition_join
# root_namespace.set_require_join                   ### ���ä��󸫹�碌����ʣ���顼��ƨ��
# through �ץ饰������������줿����ˤ� require �������Ǥ��� (set_definition_join �θ��Ǽ»�)

####  post �����ɤ������ȹ�ʸ���� ####
# �������ʤ���С��ץ饰����Υݥ��ȥ����ɤ���Ϥ��ʤ�
if ARGV.length > 0 then
  dbgPrint( "## Generating Post Code\n")
  # �ץ饰����Υݥ��ȥ����ɤν��Ϥ� import
  tmp_file_name = "#{$gen}/tmp_plugin_post_code.cdl"
  file = nil
  begin
    file = CFile.open( tmp_file_name, "w" )
  rescue
    Generator.error( "G9999 fail to create #{tmp_file_name}" )
  end

  if file then
    # through �ץ饰����Υݥ��ȥ���������
    PluginModule.gen_plugin_post_code file

    begin
      file.close
    rescue
      Generator.error( "G9999 fail to close #{tmp_file_name}" )
    end
    dbgPrint( "## Import Post Code\n")
    Import.new( "#{tmp_file_name}" )
  end
end

####  ��̣���ϣ� (post ������) ####
# Join �����������ȥ����å�
#0 # ���������б�
#0 set_definition_join ��2��ƤӽФ�����2���ܡ�  post_code ���������줿
dbgPrint( "## Checking all join (for cells generated by Post Code\n")
root_namespace.set_definition_join

dbgPrint( "## Set require join\n")
root_namespace.set_require_join   # mikan post �����ˤ�
# �ݥ��ȥ����ɤ��������줿����� require ��join ������
# mikan require �� through ��Ŭ�Ѥ���ơ��ݥ��ȥ����ɤ�ɬ�פȤʤäƤ���Ϥ���ʤ�

####  ��̣���ϣ� ####
Cell.make_cell_list2
dbgPrint( "## Set fixed join\n")
Cell.create_reverse_require_join
# create_reverse_require_join �� set_detinition_join �������ळ�Ȥ��Ǥ��ʤ�
    # namespace �˰�¸���ʤ��и���ǹԤ�
    # mikan through �ץ饰����Ŭ�Ѥ���ݥ��ȥ����ɤ˱ƶ���Ϳ�����礬��θ�Ǥ��Ƥ��ʤ�
    # mikan post code �˱ƶ��Τ����ΤǤ���С��᤯�� reverse_require_join �η�礬ɬ��
dbgPrint( "## Setting port reference count\n")
root_namespace.set_port_reference_count

dbgPrint( "## Checking all join\n")
root_namespace.check_join

# mikan �ץ饰������������줿����ݡ��ͥ�Ȥ� set_def_and_check_join

dbgPrint( "## Checking referenced but undefined cell\n")
root_namespace.check_ref_but_undef

#### Region link root ���Ȥ˥��ץƥ��ޥ������������ ####
Region.get_link_roots.each { |region|

  n_cells = region.get_n_cells

  dbgPrint "#{region.get_name} has #{n_cells} cells\n"
  if $verbose
    print "=====================================\n"
    print "=== Region.path_str: #{region.get_namespace_path.get_path_str}\n"
    print "=====================================\n"
  else
    dbgPrint "Region.path_str: #{region.get_namespace_path.get_path_str}\n"
  end

  if $region_list.length > 0 then
    if $region_list[ region.get_namespace_path.get_path_str ] then
      $region_list[ region.get_namespace_path.get_path_str ] = false
    else
      next
    end
  end

  # ���뤬��Ĥ�ʤ�����������ʤ�
  # ������������ʤ����
  if region.get_n_cells == 0 then
    if $region_list.length > 0 then
      Generator.warning( "W9999 $1: specified to generate but has no cell", region.get_name )
    end
    if region != root_namespace then
      next
    end
  end

  $generating_region = region
  if Region.get_link_roots.length > 1 then
    if region.get_name == "::" then
      $gen = $gen_base
    else
      $gen = $gen_base + "/" + region.get_global_name.to_s
      begin
        if ! File.directory?( $gen ) then
          Dir.mkdir( $gen )
        end
      rescue
        print( "Cannot mkdir #{$gen}\n" )
        exit 1
      end
    end
  else
    $gen = $gen_base
  end

  dbgPrint( "## Unset optimize variables\n")
  root_namespace.reset_optimize   # ��Ŭ����ꥻ�åȤ���
  dbgPrint( "## Set cell id\n")
  root_namespace.set_cell_id      # ����� ID �������linkunit ���0����Ĥ����

  if Generator.get_n_error == 0 then
    # ���顼��ȯ�����Ƥ����顢��Ŭ���ϼ»ܤ��ʤ�
    if ! $unopt then
      dbgPrint( "## Optimizing: Link Region=#{root_namespace.get_name}\n")
      root_namespace.optimize
    end
  end

  if $show_tree then
    # ���顼��ȯ�����Ƥ��Ƥ�ɽ���ʥ��顼ȯ�����Ϻ�Ŭ������Ƥ��ʤ��Τ���ա�
    print "##### show_tree LinkRegion=#{region.get_name} #####\n"
    root_namespace.show_tree(0)
    print "##### END       LinkRegion=#{region.get_name} #####\n\n"
  end

  # ��ʸ��ᡢ��̣���Ϥǥ��顼ȯ�����Ƥ����顢�����������򤷤ʤ�
  if Generator.get_n_error != 0 then
    print_report
    exit 1
  end

  #### ���������� ####
  begin
    dbgPrint( "## Generating: Link Region=#{root_namespace.get_name}\n")
    root_namespace.generate
    dbgPrint( "## Generating Post: Link Region=#{root_namespace.get_name}\n")
    root_namespace.generate_post
  rescue
    # �̾盧���ؤ���ʤ� (generate, generate_post �ǽ��֤����)
    Generator.error( "G9999 fail to generate" )
  end
}

dbgPrint( "## Generating XML\n")
# Region.gen_xml root_namespace
Namespace.gen_XML  root_namespace

$region_list.each{ |region_path_str, val|
  if val == true then
    Generator.warning( "W9999 $1: not link root, -G ignored", region_path_str )
  end
}

# update ����
# APPFile ���������줿�ե�����ϡ��⤷�Ѳ�������С������ǹ�������
# �����������ʳ��ǥ��顼��ȯ������С��������ʤ�
# CFile ���������줿��Τϡ���������Ƥ���
if Generator.get_n_error == 0 then
  begin
    AppFile.update
  rescue => evar
    Generator.error( "G9999 Fail to update. (error occurred while renaming generated files)" )
    print_exception( evar )
  end
end

print_report
if Generator.get_n_error != 0 then
  STDERR.print "error occurred while generating. some file can be corrupt in #{$gen_base}\n"
  exit 1
end

