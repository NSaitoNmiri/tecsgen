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
#   $Id: in_exerb.rb 1943 2013-04-30 01:37:51Z okuma-top $
#++

# exerb �ǤǺǽ���ɤߤ��ޤ��ե�����
# ���Υե����뤫�� generate.rb ���ɤߤ��ޤ��

$IN_EXERB=true

# �����ѿ��� exerb �ǤΤ�
$path = ENV[ 'PATH' ]

#=== cygwin �Υѥ��� Windows �ѥ����Ѵ�
# cygpath ���ޥ�ɤ�õ���ơ����Ĥ�����Ѵ�����
# �Ѵ��Ǥ��ʤ��ä����ޤ����Ѵ���Υѥ������Ĥ���ʤ���硢default ���֤�
def cygpath( path, default = nil )
  if ! $IN_EXERB then
    return default
  end
  if File.exist? path then
    return default
  end

  found = false
  $path.split( ";" ).each{ |path2|
    cygpath_path = "#{path2}\\cygpath.exe"
    if File.exist?( cygpath_path )  then
      path3 = nil
      dbgPrint "in_exerb: cygpath: found\n"
      IO.popen( "cygpath -m #{path}", "r"){ |io|
        path3 = io.gets.chomp!
      }
      dbgPrint "in_exerb: cygpath: '#{path}' => '#{path3}'\n"
      File.stat( path3.to_s )

      if File.exist?( path3 )
        dbgPrint "in_exerb: cygpath: '#{path3}' found\n"
        return path3
      else
        break
      end
    end
  }
  dbgPrint "cygpath '#{path}' not found\n"
  return default
end

# gcc �Υѥ������ꤹ��
#  cygwin �Τ���С������Ǥ� gcc �� gcc-3.exe �ޤ��� gcc-4.exe �ؤΥ���ܥ�å���󥯤ȤʤäƤ���
#  exerb �ǤǤϥ���ܥ�å���󥯤�é��ʤ����� gcc �� exe ��õ��
#  cygwin �Υ�󥯤ϡ������ƥ�°�����դ���졢���ޥ�ɥץ��ץȾ�Ǥ� dir /A:S ����ꤷ�ʤ���ɽ������ʤ�
#  (cygwin �ΥС������Ǽ������ۤʤ뤫�⤷��ʤ�)
#  �ե��������Ƭ2�Х��Ȥ��ɽФ� PE �ե����ޥåȤΥޥ��å��˰��פ��뤫Ĵ�٤�
$gcc = "gcc"
$path.split( ";" ).each{ |path|
  found = false
  [ "gcc.exe", "gcc-3.exe", "gcc-4.exe" ].each{ |gcc|
    gcc_path = "#{path}\\#{gcc}"
    if File.exist?( gcc_path )  then
      begin
        magic = File.read( gcc_path, 2 )
        if magic == "MZ"                  # �ޥ��å�������å�
          $gcc = gcc
          found = true
          break
        end
      rescue
        # magic ���ɽФ��˼��ԡ�̵��
      end
    end
  }
  break if found
}

# cpp ���ޥ�ɤ����ꤹ��
$cpp = "#{$gcc} -E -D TECS"

# exerb �� TECS �����ͥ졼���μ¹Ԥ򳫻�
require "tecsgen.rb"
