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


module TECSGEN

  #=== import パス (-I) を末尾に追加
  # 既に登録済みであれば、追加しない
  def self.add_import_path path
    if $import_path.index( path ) == nil then
      dbgPrint "add_import_path: '#{path}'\n"
      $import_path << path
    end
  end

  #=== EXEB 版のパスの調整
  # 環境変数 TECSPATH が cygwin スタイルだと、exerb 版では扱えない
  # $import_path と $TECSPATH を調整する
  def self.adjust_exerb_path
    if $IN_EXERB then
      new_tecspath = cygpath( $tecspath, $tecspath )
      pattern = /\A#{$tecspath}/
      paths = []
      $import_path.each{ |path|
        # cygpath は '..' を簡約してしまうので、new_tecspath で置換する
        # paths << cygpath( path, path )
        paths << path.sub( pattern, new_tecspath )
      }
      $import_path = paths
      $tecspath = new_tecspath
    else
      return
    end
  end

  #=== $(TECSPATH) への置換
  #path::String   : ENV[ 'TECSPATH' ] に一致する部分があれば、 "$(TECSPATH)" に置換
  #b_global::Bool : true なら gsub で置換。false なら sub で置換
  def self.subst_tecspath( path, b_global = false )
    tp = $tecspath.dup
    tp.gsub!( /\\/, "\\\\\\\\" )
    pattern = /#{tp}/
      substr = "$(TECSPATH)"
    if b_global then
      str =  path.gsub( pattern, substr )
    else
      str = path.sub( pattern, substr )
    end
    dbgPrint "subst_tecspath #{path}, #{str}\n"
    return str
  end

  #=== path は絶対パスか?
  #path:: String   :
  # '/' または '$' で始まる場合、絶対パスと判定する
  def self.is_absolute_path?( path )
    pa = path[0..0]; pa2 = path[0..1]
    if pa == '/' || pa == '$' || pa2 =~ /[A-Za-z]:/ then
      res = true
    else
      res = false
    end
    dbgPrint "is_absolute( #{path} ) = #{res}  #{path[0]}\n"
    return res
  end

  ###
  #== Makefile.templ の出力内容を追加、変更するための操作
  module Makefile
    @@objs = []
    @@vars = { }
    @@var_comments = { }
    @@ldflags = []
    @@search_path = []
    @@pre_tecsgen_target = []
    @@post_tecsgen_target = []

    #=== OTHER_OBJS に追加する
    def self.add_obj obj
      @@objs << obj
    end
    #=== 追加する変数
    def self.add_var( var, val, comment = nil )
      if @@vars[ var.to_sym ] then
        @@vars[ var.to_sym ] << val
        @@var_comments[ var.to_sym ] << comment
      else
        @@vars[ var.to_sym ] = [ val ]
        @@var_comments[ var.to_sym ] = [ comment]
      end
    end
    #=== LDFLAGS に追加する
    def self.add_ldflag ldflag
      @@ldflags << ldflag
    end
    #=== サーチパスを追加する
    # CFLAGS, vpath に追加する
    def self.add_search_path path
      @@search_path << path
    end
    #=== PRE_TECSGEN_TARGET に追加する
    # PRE_TECSGEN_TARGET に target を追加する
    def self.add_pre_tecsgen_target target
      @@pre_tecsgen_target << pre_tecsgen_target
    end
    #=== POST_TECSGEN_TARGET に追加する
    # POST_TECSGEN_TARGET に target を追加する
    def self.add_pre_tecsgen_target target
      @@post_tecsgen_target << pre_tecsgen_target
    end

    def self.get_objs  # Array を返す
      return @@objs.uniq
    end
    def self.get_vars  # Hash を返す
      return @@vars
    end
    def self.get_var_comments  # Hash を返す
      return @@var_comments
    end
    def self.get_ldflags  # Array を返す
      return @@ldflags.uniq
    end
    def self.get_search_path  # Array を返す
      return @@search_path.uniq
    end
    def self.get_pre_tecsgen_target  # Array を返す
      return @@pre_tecsgen_target.uniq
    end
    def self.get_post_tecsgen_target  # Array を返す
      return @@post_tecsgen_target.uniq
    end
  end
end
