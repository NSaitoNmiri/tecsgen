/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * ���Υե������ tecsgen �ˤ��ƥ�ץ졼�ȤȤ��Ƽ�ư��������ޤ���
 * ���Υե�������Խ����ƻ��Ѥ��뤳�Ȥ��տޤ���Ƥ��ޤ���
 * tecsgen �κƼ¹Ԥˤ���񤭤���Ƥ��ޤ����ᡢ�̾�
 *   gen/tAllocator_template.c => src/tAllocator.c
 * �Τ褦��̾��, �ե�������ѹ����Ƥ��齤�����ޤ�
 *
 * #[</PREAMBLE>]# */

#include "tAllocator_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* ���ｪλ */
#define	E_ID	(-18)	/* ����ID�ֹ� */
#endif

/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# eAlloc
 * entry port: eAlloc
 * signature:  sAllocator
 * context:    task
 * params: 
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eAlloc_allocate
 * name:         eAlloc_allocate
 * global_name:  tAllocator_eAlloc_allocate
 * oneway:       
 * #[/ENTRY_FUNC>]# */
ER
eAlloc_allocate(int32_t size, void** m)
{
}

/* #[<ENTRY_FUNC>]# eAlloc_deallocate
 * name:         eAlloc_deallocate
 * global_name:  tAllocator_eAlloc_deallocate
 * oneway:       
 * #[/ENTRY_FUNC>]# */
ER
eAlloc_deallocate(void* m)
{
}

