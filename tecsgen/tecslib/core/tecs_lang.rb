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
#   $Id: tecs_lang.rb 1926 2013-02-02 06:16:04Z okuma-top $
#++

#== ����˴ؤ����ѿ�������
# ��å������ե�������ɤ߹��ߤ�Ԥ� (�ɤ߹��ߤ˼��Ԥ�����硢�ǥե���Ȥ�ʸ�������ɤ��ѹ�����)
class TECS_LANG
  # �ϥå���Υ����� case insensitive �Τ��ᡢ��ʸ����ʸ����Ȥ���
  CHARSET_ALIAS = {
    "UJIS" => :eucJP,
    "UTF-8" => :utf8,
    "EUCJP" => :eucJP,   # �ʲ� case insensitive �ˤ��뤿��
    "SJIS" => :sjis,
    "UTF8" => :utf8,
    "ISO8859-1" => :"iso8859-1"
  }
  LANG_ALIAS = {
    "C" => :en_US,
    "EN_US" => :en_US,   # �ʲ� case insensitive �ˤ��뤿��
    "JA_JP" => :ja_JP
  }
  SUITABLE_CHARSET = {
    :ja_JP => [ :eucJP, :sjis, :utf8 ],
    :en_US => [ :"iso8859-1", :utf8, nil ]
  }

  #=== LANG �Υѡ���
  #lang::String  "ja_JP.eucJP@cjknarrow", "C" �ʤ�
  #RETURN:: [ :ja_JP, :eucJP, :cjknarrow ]
  def self.parse_lang( lang )
    lang =~ /([^\.@]*)(\.([^@]*))?(@(.*))?/

    lang_terri = $1.to_sym if $1 != nil && $1 != ""
    # set_kcode_binary �ˤ�ꡢC.UTF-8 �Τߤ����̰�������ɬ�פ��ʤ��ʤä�
    # if lang_terri == :C then    # LANG=C.* �ϡ����٤� 1 byte ʸ�������ɤȤ��ư���
    #  codeset = nil
    #  modifier = nil
    # else
      codeset = $3.to_sym if $3 != nil && $3 != ""
      modifier = $5.to_sym if $5 != nil && $5 != ""
    # end
    [ lang_terri, codeset, modifier ]
  end

  #=== lang, charset ��������褪����������Υ����å�
  #lang::Symbol    : :en_US, :ja_JP �ʤ�
  #charset::Symbol : :eucJP, :utf8 �ʤ�
  #RETURN:
  #  [ lang, charset, result ]::����result = false �ξ�� lang, charset ����Ŭ��
  def self.resolve_alias_and_check( lang, charset )
    if LANG_ALIAS[ lang.to_s.upcase ] then
      ln = LANG_ALIAS[ lang.to_s.upcase ]
    else
      ln = lang
    end

    if CHARSET_ALIAS[ charset.to_s.upcase ] then
      cs = CHARSET_ALIAS[ charset.to_s.upcase ]
    else
      cs = charset
    end

    if SUITABLE_CHARSET[ ln ] == nil || SUITABLE_CHARSET[ ln ].index( cs ) == nil
      res = false
    else
      res = true
    end

    # p ln, cs, res
    [ ln, cs, res ]
  end

  #=== codepage ����Ф�
  #codepage ��3��5��������Ȥ��Ʋ���
  def self.get_win_codepage
    cmd_pipe = IO.popen('cmd /c chcp','r')
    cmd_pipe.read =~ /([0-9]{3,5})/
    cp = $1
    cmd_pipe.close
    return cp
  end

  #=== codepage ���� LANG ������ʸ������Ѵ�
  def self.codepage_to_lang cp
    if cp == "932" then
      "ja_JP.sjis"
    else
      "en_US"
    end
  end

  #=== ���졢ʸ�������ɤ˴ؤ����ѿ�������
  # �ʲ��ν�˥����å����졢���ֺǸ�����ꤵ�줿�ͤ����Ѥ����
  #   ���ǥե����
  #   ��codepage  (exerb �Ǥ� TERM ̤����ޤ��� TERM=cygwin �ξ��Τ�)
  #   ��LANG �Ķ��ѿ�
  #   ��TECSGEN_LANG �Ķ��ѿ�
  #   ��TECSGEN_FILE_LANG �Ķ��ѿ� (�ե������ʸ�������ɤΤ�)
  #   ��-k ���ץ���� (�ե������ʸ�������ɤΤ�)
  def self.set_lang_var

    if $IN_EXERB && ( ENV[ 'TERM' ] == nil || ENV[ 'TERM' ] == "cygwin" ) then
      # exerb �Ǥ�ü�� cygwin �λ��� codepage �Τߤ򸫤�
      cp = get_win_codepage
      lang = codepage_to_lang cp
      $LANG_FILE, $CHARSET_FILE, *dum = self.parse_lang( lang )
      $LANG_CONSOLE = $LANG_FILE
      $CHARSET_CONSOLE = $CHARSET_FILE

    elsif ENV[ 'LANG' ]then
      # �� exerb �ǤǤ� LANG �Ķ��ѿ��򸫤�
      # cygwin console �Ǥ� codepage �˽��äƽ��Ϥ�������ʿ�¤ʤ���

      $LANG_FILE, $CHARSET_FILE, *dum = self.parse_lang( ENV[ 'LANG' ] )
      $LANG_CONSOLE = $LANG_FILE
      $CHARSET_CONSOLE = $CHARSET_FILE
    end

    if ENV[ 'TECSGEN_LANG' ]then
      $LANG_FILE, $CHARSET_FILE, *dum = self.parse_lang( ENV[ 'TECSGEN_LANG' ] )
      $LANG_CONSOLE = $LANG_FILE
      $CHARSET_CONSOLE = $CHARSET_FILE
    end

    if ENV[ 'TECSGEN_FILE_LANG' ]then
      $LANG_FILE, $CHARSET_FILE, *dum = self.parse_lang( ENV[ 'TECSGEN_FILE_LANG' ] )
    end

    self.set_lang_by_option
  end

  #=== -k ���ץ���󤫤�ե������Ѥθ��졢ʸ���������ѿ�������
  def self.set_lang_by_option
    if $kcode == nil
      return
    end

    code = $kcode
    found = false
    res = $CODE_TYPE_ARRAY.index( code )
    if res == nil then
      print "-k: illegal kcode type #{code}. (#{$CODE_TYPE_ARRAY.join(", ")})\n"
      exit 1
    end

    case $kcode
    when "euc"
      $CHARSET_FILE = :eucJP
      $LANG_FILE = :ja_JP
    when "sjis"
      $CHARSET_FILE = :sjis
      $LANG_FILE = :ja_JP
    when "utf8"
      $CHARSET_FILE = :utf8
    when "none"
      $CHARSET_FILE = nil
      $LANG_FILE = "en_US"
    end
  end

  #=== Kconv ���饹�Ѥ��ѿ�������
  # ������󤫤� Kconv �˴ؤ����ѿ�������
  def self.set_kconv_var

    # ʸ�������ɤ�����
    case $CHARSET_FILE           # string: "EUC" | "SJIS" | "NONE" | "UTF8"
    when :eucJP
      $KCODE_CDL = "EUC"
      $KCONV_CDL = Kconv::EUC
      $Ruby19_File_Encode = "ASCII-8BIT"
    when :sjis
      $KCODE_CDL = "SJIS"
      $KCONV_CDL = Kconv::SJIS
      $Ruby19_File_Encode = "Shift_JIS"
    when :utf8
      $KCODE_CDL = "UTF8"
      $KCONV_CDL = Kconv::UTF8
      $Ruby19_File_Encode = "ASCII-8BIT"
    else
      $KCODE_CDL = "BINARY"
      $KCONV_CDL = Kconv::BINARY
      $Ruby19_File_Encode = "ASCII-8BIT"
    end

    case $CHARSET_CONSOLE
    when :eucJP
      $KCODE_CONSOLE = "EUC"
      $KCONV_CONSOLE = Kconv::EUC
    when :sjis
      $KCODE_CONSOLE = "SJIS"
      $KCONV_CONSOLE = Kconv::SJIS
    when :utf8
      $KCODE_CONSOLE = "UTF8"
      $KCONV_CONSOLE = Kconv::UTF8
    else
      $KCODE_CONSOLE = "BINARY"
      $KCONV_CONSOLE = Kconv::BINARY
    end

    $KCODE_TECSGEN = "EUC"       # string: "EUC"  ���Υե������ʸ�������ɡʥ��ץ����ǤϤʤ������
    $KCONV_TECSGEN = Kconv::EUC  # const: 
    set_kcode $KCODE_TECSGEN     # ���Υե������ʸ�������ɤ�����
  end

  #=== ���Ū�� KCODE �� BINARY ���ѹ�����
  # EUC �� UTF8 ���ɤ߹��������ʸ�����ڤ����������б�
  # �����Ȥ��ɤ����Ф�������������
  # ��������SJIS �ξ��ϡ�����������ʸ�������꤬���뤿�ᡢ�ѹ����ʤ�
  def self.set_kcode_binary

    #2.0
    if $b_no_kcode then
      return
    end

    $KCODE_BACK = $KCODE
    if $KCODE != "SJIS" then
      set_kcode "BINARY"
    end
  end

  #=== ���Ū�ʤ� KCODE ���ѹ��򸵤��᤹
  def self.reset_kcode
    set_kcode $KCODE_BACK
  end

  #####
  # $LANG_FILE        ���� (C �� en_US ���Ѵ������)
  # $LANG_CONSOLE     ���� (C �� en_US ���Ѵ������)
  # $CHARSET_FILE     �ե������ʸ��������
  # $CHARSET_CONSOLE  ���󥽡���ʸ��������

  # �ǥե���Ȥ�������������ѤߤΤ��ȡ�
  $LANG_FILE_DEFAULT  = :en_US
  $CHARSET_FILE_DEFAULT = nil
  $LANG_CONSOLE_DEFAULT = :en_US
  $CHARSET_CONSOLE_DEFAULT = nil

  $LANG_FILE = $LANG_FILE_DEFAULT
  $CHARSET_FILE = $CHARSET_FILE_DEFAULT
  $LANG_CONSOLE = $LANG_CONSOLE_DEFAULT
  $CHARSET_CONSOLE = $CHARSET_CONSOLE_DEFAULT

  # -k �ǻ����ǽ�ʥ�����
  $CODE_TYPE_ARRAY = [ "euc", "sjis", "none", "utf8" ]

  # �������ꤹ��
  self.set_lang_var

  # ���졢�����ɤΥ����å���������
  lang_file, charset_file, res =
    self.resolve_alias_and_check( $LANG_FILE, $CHARSET_FILE )
  if res == false then
    # lang_file, charset_file = lang_file_default, charset_file_default
    lang_file, charset_file = $LANG_FILE_DEFAULT, $CHARSET_FILE_DEFAULT
  end
  lang_console, charset_console, res =
    self.resolve_alias_and_check( $LANG_CONSOLE, $CHARSET_CONSOLE )
  if res == false then
    # lang_console, charset_console = lang_console_default, charset_console_default
    lang_console, charset_console = $LANG_CONSOLE_DEFAULT, $CHARSET_CONSOLE_DEFAULT
  end

  # ��å������⥸�塼������
  if require_tecsgen_lib( "tecslib/messages/messages_console_#{lang_console}.rb", false ) == false then
    require_tecsgen_lib( "tecslib/messages/messages_console_#{$LANG_CONSOLE_DEFAULT}.rb" )
    $LANG_CONSOLE, $CHARSET_CONSOLE = $LANG_CONSOLE_DEFAULT, $CHARSET_CONSOLE_DEFAULT
  else
    $LANG_CONSOLE, $CHARSET_CONSOLE = lang_console, charset_console
  end
  if require_tecsgen_lib( "tecslib/messages/messages_file_#{lang_file}.rb", false ) == false then
    require_tecsgen_lib( "tecslib/messages/messages_file_#{$LANG_FILE_DEFAULT}.rb" )
    $LANG_FILE, $CHARSET_FILE = $LANG_FILE_DEFAULT, $CHARSET_FILE_DEFAULT
  else
    $LANG_FILE, $CHARSET_FILE = lang_file, charset_file
  end

  # Kconv ���饹�Τ�����ѿ�������
  self.set_kconv_var 

  dbgPrint "LANG_FILE=#{$LANG_FILE}.#{$CHARSET_FILE}, LANG_CONSOLE=#{$LANG_CONSOLE}.#{$CHARSET_CONSOLE}\n"
  dbgPrint "KCODE_CDL=#{$KCODE_CDL}(#{$KCONV_CDL}) KCODE_CONSOLE=#{$KCODE_CONSOLE}(#{$KCONV_CONSOLE})\n"
  dbgPrint "Ruby19_File_Encode=#{$Ruby19_File_Encode}\n"

  #=== ñ�Υƥ��ȼ¹�
  if $unit_test then
    print "unit test: set_lang_var\n"
    require "kconv"
    self.set_lang_var
    print "#{$LANG_FILE} #{$LANG_CONSOLE}\n"
    print "#{$CHARSET_FILE} #{$CHARSET_CONSOLE}\n"

    $LANG_FILE, $CHARSET_FILE, res = self.resolve_alias_and_check( $LANG_FILE, $CHARSET_FILE )
    print "#{$LANG_FILE} #{$CHARSET_FILE}, #{res}\n"
  end
end

#= Console ���饹
# ʸ�������ɤ��Ѵ�����
class Console
  def self.print str
    if $b_no_kcode && $KCONV_CONSOLE == Kconv::BINARY then 
      STDOUT.print str
    else
      STDOUT.print str.kconv( $KCONV_CONSOLE, $KCONV_TECSGEN )
    end
  end
  def self.puts str
    if $b_no_kcode && $KCONV_CONSOLE == Kconv::BINARY then 
      STDOUT.puts str
    else
      STDOUT.puts str.kconv( $KCONV_CONSOLE, $KCONV_TECSGEN )
    end
  end
end
