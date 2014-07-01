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


module TECSGEN

  #=== import �ѥ� (-I) ���������ɲ�
  # ������Ͽ�ѤߤǤ���С��ɲä��ʤ�
  def self.add_import_path path
    if $import_path.index( path ) == nil then
      dbgPrint "add_import_path: '#{path}'\n"
      $import_path << path
    end
  end

  #=== EXEB �ǤΥѥ���Ĵ��
  # �Ķ��ѿ� TECSPATH �� cygwin ����������ȡ�exerb �ǤǤϰ����ʤ�
  # $import_path �� $TECSPATH ��Ĵ������
  def self.adjust_exerb_path
    if $IN_EXERB then
      new_tecspath = cygpath( $tecspath, $tecspath )
      pattern = /\A#{$tecspath}/
      paths = []
      $import_path.each{ |path|
        # cygpath �� '..' ����󤷤Ƥ��ޤ��Τǡ�new_tecspath ���ִ�����
        # paths << cygpath( path, path )
        paths << path.sub( pattern, new_tecspath )
      }
      $import_path = paths
      $tecspath = new_tecspath
    else
      return
    end
  end

  #=== $(TECSPATH) �ؤ��ִ�
  #path::String   : ENV[ 'TECSPATH' ] �˰��פ�����ʬ������С� "$(TECSPATH)" ���ִ�
  #b_global::Bool : true �ʤ� gsub ���ִ���false �ʤ� sub ���ִ�
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

  #=== path �����Хѥ���?
  #path:: String   :
  # '/' �ޤ��� '$' �ǻϤޤ��硢���Хѥ���Ƚ�ꤹ��
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
  #== Makefile.templ �ν������Ƥ��ɲá��ѹ����뤿������
  module Makefile
    @@objs = []
    @@vars = { }
    @@var_comments = { }
    @@ldflags = []
    @@search_path = []
    @@pre_tecsgen_target = []
    @@post_tecsgen_target = []

    #=== OTHER_OBJS ���ɲä���
    def self.add_obj obj
      @@objs << obj
    end
    #=== �ɲä����ѿ�
    def self.add_var( var, val, comment = nil )
      if @@vars[ var.to_sym ] then
        @@vars[ var.to_sym ] << val
        @@var_comments[ var.to_sym ] << comment
      else
        @@vars[ var.to_sym ] = [ val ]
        @@var_comments[ var.to_sym ] = [ comment]
      end
    end
    #=== LDFLAGS ���ɲä���
    def self.add_ldflag ldflag
      @@ldflags << ldflag
    end
    #=== �������ѥ����ɲä���
    # CFLAGS, vpath ���ɲä���
    def self.add_search_path path
      @@search_path << path
    end
    #=== PRE_TECSGEN_TARGET ���ɲä���
    # PRE_TECSGEN_TARGET �� target ���ɲä���
    def self.add_pre_tecsgen_target target
      @@pre_tecsgen_target << pre_tecsgen_target
    end
    #=== POST_TECSGEN_TARGET ���ɲä���
    # POST_TECSGEN_TARGET �� target ���ɲä���
    def self.add_pre_tecsgen_target target
      @@post_tecsgen_target << pre_tecsgen_target
    end

    def self.get_objs  # Array ���֤�
      return @@objs.uniq
    end
    def self.get_vars  # Hash ���֤�
      return @@vars
    end
    def self.get_var_comments  # Hash ���֤�
      return @@var_comments
    end
    def self.get_ldflags  # Array ���֤�
      return @@ldflags.uniq
    end
    def self.get_search_path  # Array ���֤�
      return @@search_path.uniq
    end
    def self.get_pre_tecsgen_target  # Array ���֤�
      return @@pre_tecsgen_target.uniq
    end
    def self.get_post_tecsgen_target  # Array ���֤�
      return @@post_tecsgen_target.uniq
    end
  end
end
