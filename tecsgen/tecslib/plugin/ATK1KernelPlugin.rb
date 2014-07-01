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

#== celltype �ץ饰����ζ��̤οƥ��饹
class ATK1KernelPlugin < CelltypePlugin
#@celltype:: Celltype
#@option:: String     :���ץ����ʸ����
  @@cell_list = []

  #signature::     Celltype        �����˥���ʥ��󥹥��󥹡�
  def initialize( celltype, option )
    super
  end

  #===  CDL �ե����������
  #      typedef, signature, celltype, cell �Υ����ɤ�����
  #      ��ʣ�����������ƤϤʤ�ʤ�
  #      ���Ǥ���������Ƥ�����Ͻ��Ϥ��ʤ����ȡ�
  #      �⤷����Ʊ̾�� import �ˤ�ꡢ��ʣ���򤱤뤳�ȡ�
  #file::        FILE       ��������ե�����
#  def gen_cdl_file file
#  end

  def new_cell cell
#    join_list = cell.get_join_list
#    a = join_list.get_item( :resource )
#    if a == nil
#     Generator.error( "resource: must be initialized")
#    elsif ! a.get_rhs.instance_of? Array
#      Generator.error( "resource: initializer must be in format of '{val1, val2 ...}'")
#    end
  @@cell_list << cell
  end

  #===  �������ؿ�������(C����)����������
  #     ���Υ᥽�åɤ�̤����ξ�硢�����ͥ졼���ϼ������ؿ��Υƥ�ץ졼�Ȥ���������
  #     ���Υ᥽�åɤ�����Ѥߤξ�硢�ʥƥ�ץ졼�ȤǤϤʤ����ѹ�����ɬ�פΤʤ��˥��륿���ץ����ɤ���������
  #file::           FILE        ������ե�����
  #b_singleton::    bool        true if singleton
  #ct_name::        Symbol
  #global_ct_name:: string
  #sig_name::       string
  #ep_name::        string
  #func_name::      string
  #func_global_name:: string
  #func_type::      class derived from Type
#  def gen_ep_func_body( file, b_singleton, ct_name, global_ct_name, sig_name, ep_name, func_name, func_global_name, func_type, params )
#  end

  def gen_factory file

    file2 = CFile.open( "#{$gen}/Kernel_tecsgen.oil", "w" )

    # Kernel
    @celltype.get_cell_list.each { |cell|

      if cell.is_generate?

        file2.print "\tOS #{cell.get_name} {\n"

        # STATUS
        join = cell.get_join_list.get_item( :status )
        if join then
          str = join.get_rhs.to_s.gsub(/^"(.*)"$/, '\1')
          file2.print "\t\tSTATUS = #{str};\n"
        end

        # STARTUPHOOK
        join = cell.get_join_list.get_item( :useStartupHook )
        if join then
          str = join.get_rhs.to_s
          file2.print "\t\tSTARTUPHOOK = #{str};\n"
        end

        # ERRORHOOK
        join = cell.get_join_list.get_item( :useErrorHook )
        if join then
          str = join.get_rhs.to_s
          file2.print "\t\tERRORHOOK = #{str};\n"
        end

        # SHUTDOWNHOOK
        join = cell.get_join_list.get_item( :useShutdownHook )
        if join then
          str = join.get_rhs.to_s
          file2.print "\t\tSHUTDOWNHOOK = #{str};\n"
        end

        # PRETASKHOOK
        join = cell.get_join_list.get_item( :usePreTaskHook )
        if join then
          str = join.get_rhs.to_s
          file2.print "\t\tPRETASKHOOK = #{str};\n"
        end

        # POSTASKHOOK
        join = cell.get_join_list.get_item( :usePostTaskHook )
        if join then
          str = join.get_rhs.to_s
          file2.print "\t\tPOSTTASKHOOK = #{str};\n"
        end

        # USEGETSERVICEID
        join = cell.get_join_list.get_item( :useGetServiceId )
        if join then
          str = join.get_rhs.to_s
          file2.print "\t\tUSEGETSERVICEID = #{str};\n"
        end

        # USEPARAMETERACCESS
        join = cell.get_join_list.get_item( :useParameterAccess )
        if join then
          str = join.get_rhs.to_s
          file2.print "\t\tUSEPARAMETERACCESS = #{str};\n"
        end

        # USERESSCHEDULER
        join = cell.get_join_list.get_item( :useResourceScheduler )
        if join then
          str = join.get_rhs.to_s
          file2.print "\t\tUSERESSCHEDULER = #{str};\n"
        end

        file2.print "\t};\n\n"

      end

    }

    file2.close

    # �ɵ����뤿��� AppFile ��Ȥ���ʸ���������Ѵ�����ʤ���
    file2 = AppFile.open( "#{$gen}/tKernel_tecsgen.c" )
    file2.print "\n/* Generated by ATK1KernelPlugin */\n\n"
    @celltype.get_cell_list.each { |cell|
      if cell.is_generate?
        name_array = @celltype.get_name_array( cell )

        join = cell.get_join_list.get_item( :useStartupHook )
        if join then
          str = join.get_rhs.to_s
          if str == "TRUE" then
            file2.print <<EOT
#ifdef USE_STARTUPHOOK
void StartupHook(void)
{
/*    CELLCB *p_cellcb = #{name_array[8]}; */
    INT32 i;
    for(i = 0; i < N_CP_cStartupHookBody; i++){
        cStartupHookBody_main(i);
    }
}
#endif /* USE_STARTUPHOOK */
EOT
          end
        end

        join = cell.get_join_list.get_item( :useErrorHook )
        if join then
          str = join.get_rhs.to_s
          if str == "TRUE" then
            file2.print <<EOT
#ifdef USE_ERRORHOOK
void ErrorHook(StatusType ercd)
{
/*    CELLCB *p_cellcb = #{name_array[8]}; */
    cErrorHookBody_main( ercd );
}
#endif /* USE_ERRORHOOK */

EOT
          end
        end

        join = cell.get_join_list.get_item( :useShutdownHook )
        if join then
          str = join.get_rhs.to_s
          if str == "TRUE" then
            file2.print <<EOT
#ifdef USE_SHUTDOWNHOOK
void ShutdownHook(StatusType ercd)
{
/*    CELLCB *p_cellcb = #{name_array[8]}; */
    INT32 i;
    for(i = 0; i < N_CP_cShutdownHookBody; i++){
        cShutdownHookBody_main( i, ercd );
    }
}
#endif /* USE_SHUTDOWNHOOK */

EOT
          end
        end

        join = cell.get_join_list.get_item( :usePreTaskHook )
        if join then
          str = join.get_rhs.to_s
          if str == "TRUE" then
            file2.print <<EOT
#ifdef USE_PRETASKHOOK
void PreTaskHook(void)
{
/*    CELLCB *p_cellcb = #{name_array[8]}; */
    cPreTaskHookBody_main();
}
#endif /* USE_PRETASKHOOK */

EOT
          end
        end

        join = cell.get_join_list.get_item( :usePostTaskHook )
        if join then
          str = join.get_rhs.to_s
          if str == "TRUE" then
            file2.print <<EOT
#ifdef USE_POSTTASKHOOK
void PostTaskHook(void)
{
/*    CELLCB *p_cellcb = #{name_array[8]}; */
    cPostTaskHookBody_main();
}
#endif /* USE_POSTTASKHOOK */

EOT
          end
        end

      end
    }

    file2.close

  end

  def self.gen_post_code file

  @@cell_list.each { |cell|
    join =  cell.get_join_list.get_item( :useResourceScheduler )
    if join then
      flag = join.get_rhs.to_s
      if flag == "TRUE" then
        file.print <<EOT
cell tResource RES_SCHEDULER {
	property = "STANDARD";
};
EOT
      else
        file.print <<EOT
EOT
      end
    end
  }
  
  end

end

