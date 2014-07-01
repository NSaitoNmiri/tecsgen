#!/usr/bin/env ruby
# -*- coding: euc-jp -*-

#
#  TECS Generator
#      Generator for TOPPERS Embedded Component System
#  
#   Copyright (C) 2008-2013 by TOPPERS Project
#--
#   上記著作権者は，以下の(1)〜(4)の条件を満たす場合に限り，本ソフトウェ
#   ア（本ソフトウェアを改変したものを含む．以下同じ）を使用・複製・改
#   変・再配布（以下，利用と呼ぶ）することを無償で許諾する．
#   (1) 本ソフトウェアをソースコードの形で利用する場合には，上記の著作
#       権表示，この利用条件および下記の無保証規定が，そのままの形でソー
#       スコード中に含まれていること．
#   (2) 本ソフトウェアを，ライブラリ形式など，他のソフトウェア開発に使
#       用できる形で再配布する場合には，再配布に伴うドキュメント（利用
#       者マニュアルなど）に，上記の著作権表示，この利用条件および下記
#       の無保証規定を掲載すること．
#   (3) 本ソフトウェアを，機器に組み込むなど，他のソフトウェア開発に使
#       用できない形で再配布する場合には，次のいずれかの条件を満たすこ
#       と．
#     (a) 再配布に伴うドキュメント（利用者マニュアルなど）に，上記の著
#         作権表示，この利用条件および下記の無保証規定を掲載すること．
#     (b) 再配布の形態を，別に定める方法によって，TOPPERSプロジェクトに
#         報告すること．
#   (4) 本ソフトウェアの利用により直接的または間接的に生じるいかなる損
#       害からも，上記著作権者およびTOPPERSプロジェクトを免責すること．
#       また，本ソフトウェアのユーザまたはエンドユーザからのいかなる理
#       由に基づく請求からも，上記著作権者およびTOPPERSプロジェクトを
#       免責すること．
#  
#   本ソフトウェアは，無保証で提供されているものである．上記著作権者お
#   よびTOPPERSプロジェクトは，本ソフトウェアに関して，特定の使用目的
#   に対する適合性も含めて，いかなる保証も行わない．また，本ソフトウェ
#   アの利用により直接的または間接的に生じたいかなる損害に関しても，そ
#   の責任を負わない．
#  
#   $Id: tecsgen.rb 1943 2013-04-30 01:37:51Z okuma-top $
#++

#= tecsgen  : TECS のジェネレータ
#
#Authors::   大山 博司
#Version::   
#Copyright:: Copyright (C) TOPPERS Project, 2008-2013. All rights reserved.
#License::   TOPPERS ライセンスに準拠

###
#= Array  initializer の '{', '}' で囲まれた場合
# mikan AggregateInitializer など、クラスを変更すべきである
class Array
  #=== CDL の文字列を生成する
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

#=== RUBY ライブラリをロードする
#
# -L, $RUBYLIB, システム(/usr/lib/rub..など) の順にサーチが行われる
# exerb 対応のため、上記パスにファイルが見つからない場合 require を実行してみる
#
# プラグインの場合は b_fatal = false を指定。ファイルがなくてもエラー出力後、処理続行
# b_fatal = false の場合 tecslib/core がサーチパスに追加される
#RETURN::Bool   : true=成功、 false=失敗   失敗した場合、Generator.error は呼び元で出力する
def require_tecsgen_lib( fname, b_fatal = true )
  dbgPrint( "require_lib: #{fname}\n")
  set_kcode $KCODE_TECSGEN
  begin  
    b_require = false
    b_exception = false

    # -L 、 $RUBYLIB で指定されたパスおよびシステムのパスからサーチ
    #   exerb では $LOAD_PATH は ["."] のみ入っているようだ
    ($library_path+$LOAD_PATH).each{ |path|
      [ "", "tecslib/plugin/" ].each { |lp|
        lib = File.expand_path( path ) + '/' + lp + fname

        if File.exist? lib then  # ファイル存否と他のエラーを区別するため存在確認をする
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
      # exerb 対応 "." をサーチパスの最初に加える
      #   "tecslib/" は RPCPlugin.rb, TracePlugin.rb のために用意してある
      #   RPCPlugin.rb, TracePlugin.rb が tecslib 下でなければ不要になるが、このようにしておく
      ["","tecslib/plugin/"].each{ |lp|
        path = lp + fname
        begin
          require path
          return true
        rescue LoadError => e
          # p "LoadError to load #{fname}"
        rescue Exception => e
          b_exception = true
          # 文法エラーなどが発生
          print_exception( e )
          break
        end
      }
    end

    if b_require == false then
      # 見つからなかった
      if b_exception == false then
        STDERR << "tecsgen: Fail to load #{fname}. Check $RUBYLIB environment variable or -L option\n"
      end
      # tecsgen を構成するファイルの場合は中止する
      if b_fatal then
        STDERR << "tecsgen: Exit because of unrecoverble error\n"
        exit 1
      end
      return false
    end
    return true
  ensure
    # $KCODE を CDL の文字コードに戻しておく
    set_kcode $KCODE_CDL
  end
end

#=== 例外の表示
#evar:: Exception
def print_exception( evar )
  # もしスタックトレースが出るまでい時間がかかるようならば、次をコメントアウトしてみるべし
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

#=== エラーおよび警告のレポート
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

#=== $KCODE を設定
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

### グローバル変数定義 ###

# コマンドライン引数　 (Makefile.templ へ出力)
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
$generating_region = nil # Region:  Region to optimisze & generate code   # コマンドラインオプションではない
                         #           Cell#is_generate? にて参照される
$unit_test = false     # bool:   unit test verification
$kcode     = nil       # nil | String: Kanji code type "euc"|"sjis"|"none"|"utf8"
$force_overwrite = false # bool:  force overwrite all files if file contents not differ
$no_banner = false     # bool:   not print banner
$print_version = false # bool:   print version
$target    = "tecs"    # String: target name, ARGV[0] から再設定する（"tecs" は仮のターゲット)
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

# # 文字コードの設定
if $IN_EXERB then
  # KCODE_CDL, $KCONV_CDL を仮に設定する (tecs_lang.rb ですぐに再設定される)
  $KCODE_CDL = "SJIS"          # string: "EUC" | "SJIS" | "NONE" | "UTF8"
  $KCONV_CDL = Kconv::SJIS     # const: NONE には ASCII を対応させる
else
  $KCODE_CDL = "EUC"           # string: "EUC" | "SJIS" | "NONE" | "UTF8"
  $KCONV_CDL = Kconv::EUC      # const: NONE には ASCII を対応させる
end
$KCODE_TECSGEN = "EUC"       # string: "EUC"  このファイルの文字コード（オプションではなく定数）
$KCONV_TECSGEN = Kconv::EUC  # const: 
set_kcode( $KCODE_TECSGEN )  # このファイルの文字コードを設定


###  tecsgen コマンドオプション解析  ###
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
#  old_mode は V1.0.C.22 で廃止
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

### tecsgen モジュールのロード ####
# -L でパス指定可能としたため、ここからロードを開始する

#  tecsgen バージョンファイルのロード
# これを実行するまで tecsgen のバージョンを表示できない
# このファイルを誤って読み込むと、異なるバージョン名を表示してしまう
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

# 文字コード決定のため最初に読みこむ
require_tecsgen_lib 'tecslib/core/tecs_lang.rb'

unless $yydebug then
  require_tecsgen_lib 'tecslib/core/bnf.tab.rb'
else
  require_tecsgen_lib 'tecslib/core/bnf-deb.tab.rb'
end

# syntaxobj.rb には Node が定義されているので、早い段階で require 
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

# C 言語パーサ
require_tecsgen_lib 'tecslib/core/C_parser.tab.rb'
require_tecsgen_lib 'tecslib/core/ctypes.rb'

if $unit_test then
  exit 1
end

# $import_path, $tecspath を調整
TECSGEN.adjust_exerb_path

# $import_path に環境変数 $TECSGEN およびその直下を追加
if $no_default_import_path == false then
  # $TECSGEN および、その直下のディレクトリをパスに追加
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
      # 無視
    end
  end
end

# $target の設定
$target = ARGV[0]
pos = $target.rindex( /[:\\\/]/ )
if pos then
  $target = $target[pos+1..-1]  # ディレクトリ区切りを除いた文字列
end
pos = $target.rindex( /\./ )
if pos then
  $target = $target[0..pos-1]   # 拡張子を取り除いた文字列
end

# gen ディレクトリの作成
begin
  if ! File.directory?( $gen_base ) then
    Dir.mkdir( $gen_base )
  end
rescue
  print( "Cannot mkdir #{$gen_base}. If the path has hierarchy, please create directory by manual.\n" )
  exit 1
end

# ルート namespace (region) を生成
root_namespace = Region.new("::")

####  構文解析 (post コードを除く) ####
# すべての cdl を import する
ARGV.each{ |f|
  dbgPrint( "## Import: #{f}\n")
  Import.new( f, false, false )
}

# すべての構文解釈が完了したことの報告
#   実際には、後からプラグインの生成する CDL のパースが行われる
#   エラー行数の決定方法の変更のために行う
Generator.end_all_parse
dbgPrint( "## End all parse (except Post Code)\n")

####  意味解析１ (post コードを除く) ####
#0 set_definition_join は2回呼び出される（1回目）
dbgPrint( "## Checking all join\n")
root_namespace.set_definition_join
# root_namespace.set_require_join                   ### いったん見合わせ。重複エラーを見逃す
# through プラグインで生成されたセルにも require も生成できる (set_definition_join の後ろで実施)

####  post コードの生成と構文解析 ####
# 引数がなければ、プラグインのポストコードを出力しない
if ARGV.length > 0 then
  dbgPrint( "## Generating Post Code\n")
  # プラグインのポストコードの出力と import
  tmp_file_name = "#{$gen}/tmp_plugin_post_code.cdl"
  file = nil
  begin
    file = CFile.open( tmp_file_name, "w" )
  rescue
    Generator.error( "G9999 fail to create #{tmp_file_name}" )
  end

  if file then
    # through プラグインのポストコード生成
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

####  意味解析１ (post コード) ####
# Join の定義の設定とチェック
#0 # 前方参照対応
#0 set_definition_join は2回呼び出される（2回目）  post_code で生成された
dbgPrint( "## Checking all join (for cells generated by Post Code\n")
root_namespace.set_definition_join

dbgPrint( "## Set require join\n")
root_namespace.set_require_join   # mikan post の前にも
# ポストコードで生成されたセルの require のjoin を生成
# mikan require で through が適用されて、ポストコードが必要となっても出力されない

####  意味解析２ ####
Cell.make_cell_list2
dbgPrint( "## Set fixed join\n")
Cell.create_reverse_require_join
# create_reverse_require_join は set_detinition_join に埋め込むことができない
    # namespace に依存しない出現順で行う
    # mikan through プラグインが適用されポストコードに影響を与える場合が考慮できていない
    # mikan post code に影響のあるものであれば、早くに reverse_require_join の結合が必要
dbgPrint( "## Setting port reference count\n")
root_namespace.set_port_reference_count

dbgPrint( "## Checking all join\n")
root_namespace.check_join

# mikan プラグインで生成されたコンポーネントの set_def_and_check_join

dbgPrint( "## Checking referenced but undefined cell\n")
root_namespace.check_ref_but_undef

#### Region link root ごとにオプティマイズおよび生成 ####
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

  # セルが一つもなければ生成しない
  # セルの生成がない場合
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
  root_namespace.reset_optimize   # 最適化をリセットする
  dbgPrint( "## Set cell id\n")
  root_namespace.set_cell_id      # セルの ID を設定（linkunit 毎に0からつける）

  if Generator.get_n_error == 0 then
    # エラーが発生していたら、最適化は実施しない
    if ! $unopt then
      dbgPrint( "## Optimizing: Link Region=#{root_namespace.get_name}\n")
      root_namespace.optimize
    end
  end

  if $show_tree then
    # エラーが発生していても表示（エラー発生時は最適化されていないので注意）
    print "##### show_tree LinkRegion=#{region.get_name} #####\n"
    root_namespace.show_tree(0)
    print "##### END       LinkRegion=#{region.get_name} #####\n\n"
  end

  # 構文解釈、意味解析でエラー発生していたら、コード生成をしない
  if Generator.get_n_error != 0 then
    print_report
    exit 1
  end

  #### コード生成 ####
  begin
    dbgPrint( "## Generating: Link Region=#{root_namespace.get_name}\n")
    root_namespace.generate
    dbgPrint( "## Generating Post: Link Region=#{root_namespace.get_name}\n")
    root_namespace.generate_post
  rescue
    # 通常ここへは来ない (generate, generate_post で処置される)
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

# update する
# APPFile で生成されたファイルは、もし変化があれば、ここで更新する
# コード生成段階でエラーが発生すれば、更新しない
# CFile で生成されたものは、更新されている
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

