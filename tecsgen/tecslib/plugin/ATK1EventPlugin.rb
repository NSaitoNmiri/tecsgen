# -*- coding: euc-jp -*-
#
#  TECS Generator Cell-type plugin
#      for TOPPERS Embedded Component System
#  
#   Copyright (C) 2008-2013 by TOPPERS Project TECS-WG
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
#   $Id
#++

#== ATK1 Event celltype �ץ饰���󥯥饹
class ATK1EventPlugin < CelltypePlugin
#@@instancies:: []     :������η�
@@instancies = []

  #===  �����
  #      ���ƤΥ���μ��Τ��̣���ϸ�˻��Ȥ���ɬ�פ����뤿���
  #      ��������� singleton �� instancies �˳�Ǽ����
  #signature::     Celltype        �����˥���ʥ��󥹥��󥹡�
  def initialize( celltype, option )
    super
    @@instancies << self
  end

  #===  cell������
  def new_cell cell
  end

  #===  ��̣���ϼ¹Ը�Υ���������
  def self.gen_post_code file

    @@instancies.each { |inst|
      inst.gen_oil_code file
    }

  end

  #===  OIL�ե��������
  def gen_oil_code file

    file2 = CFile.open( "#{$gen}/EVENT_tecsgen.oil", "w" )

    whole_mask = 0

    # EVENT
    @celltype.get_cell_list.each { |cell|

#      if cell.is_generate?
        join = cell.get_join_list.get_item( :mask )

        # AUTO type search and change to zero
        if join then
          #mask_bit = join.get_rhs.to_s.eval_cnst( nil )
          mask_bit = join.get_rhs.to_s.to_i
          mask_str = join.get_rhs.to_s
          if mask_str == "AUTO" then
            new_rhs = Expression.create_integer_constant( 32, @locale )
            join.change_rhs new_rhs
          else
            mask_pattern = 1 << mask_bit
            whole_mask |= mask_pattern
          end
        else
          new_rhs = Expression.create_integer_constant( 32, @locale )
          join = Join.new( :mask, nil, new_rhs )
          cell.new_join(join)
        end

#        file2.print "\t /* working #{join.get_rhs.to_s} */\n"
#      end

    }

    mask_count = 0;
    mask_place = 0;

    @celltype.get_cell_list.each { |cell|

#      if cell.is_generate?
        # bit place to mask pattern
        file2.print "\tEVENT #{cell.get_name} {\n"
        join = cell.get_join_list.get_item( :mask )
        if join then
          mask_bit = join.get_rhs.to_s.to_i
          if mask_bit == 32 then
            while 1
    p("mask_count, current_mask")
    p mask_count
              current_mask = (1 << mask_count)
    p current_mask
              if 0 == whole_mask & current_mask
                new_rhs = Expression.create_integer_constant( current_mask, @locale )
                join.change_rhs new_rhs
                whole_mask = whole_mask | current_mask
                mask_place = mask_count
                break
              end
              if current_mask >= 0x8000
                mask_place = 0
                break
              end
              mask_count = mask_count + 1
            end
          else
            mask_place = join.get_rhs.to_s.to_i
            current_mask = 1 << mask_place
            new_rhs = Expression.create_integer_constant( current_mask, @locale )
            join.change_rhs new_rhs
          end
          file2.print "\t\tMASK = #{mask_place.to_s};\n"
        end

        file2.print "\t};\n"
        file2.print "\n"

#      end

    }

    file2.close

  end

end

