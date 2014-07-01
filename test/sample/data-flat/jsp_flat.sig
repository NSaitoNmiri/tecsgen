#include "jsp_def.h"
/**/

#ifdef _SH3_MS7727CP01_GNUDEV_
typedef int32_t   INT;
typedef uint32_t  UINT;
typedef int32_t   VP_INT;
typedef	uint64_t  UD;	/* ���̵��64�ӥå����� */

typedef uint32_t  size_t;

/* ��ITRON4.0����(Ver. 4.02.00) �Υ���������ɥץ��ե�����Ǥʤ���ΤΤ�����*/
/* TOPPERS/JSP���������åȰ�¸���ǥ��ݡ��Ȥ����Ρ�*/
/* config/sh3/cpu_defs.h */

typedef	UINT		INTNO;		/* ������ֹ� */

/*
 * ����ߥޥ����η��ȳ���ߥޥ������ѹ�/����
 */
typedef	UINT		IPM;		/* ����ߥޥ��� */

/* config/sh3/cpu_defs.h */
typedef	UD  SYSUTIM;	       /* ��ǽɾ���ѥ����ƥ���� */


#endif

/**/


/*    enum32 OBJECT_ATTR { TA_NULL=0u } */

    ENUM OBJECT_ATTR { TA_NULL = 0 }; 

    ENUM RETURN_VALUE { TRUE=1 , FALSE=0, E_OK=0 }   ;

    ENUM ERROR_CODE { 
	E_SYS=-5 			/* �����ƥ२�顼 */ 
,	E_NOSPT=-9  			/* ̤���ݡ��ȵ�ǽ */
,	E_RSFN		= (-10)		/* ͽ��ǽ������ */
,	E_RSATR		= (-11)		/* ͽ��°�� */
,	E_PAR		= (-17)		/* �ѥ�᡼�����顼 */
,	E_ID		= (-18)		/* ����ID�ֹ� */
,	E_CTX		= (-25)		/* ����ƥ����ȥ��顼 */
,	E_MACV		= (-26)		/* ���ꥢ��������ȿ */
,	E_OACV		= (-27)		/* ���֥������ȥ���������ȿ */
,	E_ILUSE		= (-28)		/* �����ӥ��������������� */
,	E_NOMEM		= (-33)		/* ������­ */
,	E_NOID		= (-34)		/* ID�ֹ���­ */
,	E_OBJ		= (-41)		/* ���֥������Ⱦ��֥��顼 */
,	E_NOEXS		= (-42)		/* ���֥�������̤���� */
,	E_QOVR		= (-43)		/* ���塼���󥰥����С��ե��� */
,	E_RLWAI		= (-49)		/* �Ԥ����֤ζ������ */
,	E_TMOUT		= (-50)		/* �ݡ���󥰼��Ԥޤ��ϥ����ॢ���� */
,	E_DLT		= (-51)		/* �Ԥ����֥������Ȥκ�� */
,	E_CLS		= (-52)		/* �Ԥ����֥������Ȥξ����Ѳ� */
,	E_WBLK		= (-57)		/* �Υ�֥��å��󥰼��դ� */ ,
	E_BOVR		= -58		/* �Хåե������С��ե��� */
};

/*
 *  �����ॢ���Ȼ���
 */
    ENUM TIME_OUT {
    	TMO_POL    =	0		/* �ݡ���� */
      , TMO_FEVR   =	(-1)		/* �ʵ��Ԥ� */
      , TMO_NBLK   =	(-2)		/* �Υ�֥��å��� */
    };

/*
 *  ���֥�������°�������
 */
    ENUM OBJECT_ATTR {
/*  	  TA_HLNG	=0x00u */
  	  TA_HLNG	=0		/* �������ѥ��󥿥ե����� */
 	, TA_ASM	=1		/* ������֥�����ѥ��󥿥ե����� */
    };

    ENUM TASK_WAIT_QUEUE_ATTR {
	  TA_TFIFO	=0		/* ���������Ԥ������FIFO��� */
	, TA_TPRI	=1		/* ���������Ԥ������ͥ���ٽ�� */
    };

    ENUM MSG_QUEUE_ATTR {
	  TA_MFIFO	=0		/* ��å��������塼��FIFO��� */
	, TA_MPRI	=2		/* ��å��������塼��ͥ���ٽ�� */
    };
    ENUM TASK_STATE_ATTR {
	   TA_ACT	=2		/* ��������ư���줿���֤����� */
    };
    ENUM EVENT_FLG_ATTR {
	  TA_WSGL	=0		/* ���٥�ȥե饰���Ԥ���������1�Ĥ� */
	, TA_CLR	=4		/* ���٥�ȥե饰�Υ��ꥢ���� */
    };
    ENUM CYC_HDR_ATTR {
 	  TA_STA	= 2		/* �����ϥ�ɥ��ư����֤����� */
    };
/*
 *  �����ӥ��������ư��⡼�ɤ����
 */
    ENUM EVENT_FLG_OP_MODE {
	TWF_ANDW	= 0		/* ���٥�ȥե饰��AND�Ԥ� */
,	TWF_ORW		= 1		/* ���٥�ȥե饰��OR�Ԥ� */
    };
/*
 *  ����¾����������
 */
    ENUM MISC_CONST {
	TSK_SELF	= 0		/* ������������ */
,	TSK_NONE	= 0		/* �������륿�������ʤ� */
,	TPRI_SELF	= 0		/* ���������Υ١���ͥ���٤λ��� */
,	TPRI_INI	= 0		/* �������ε�ư��ͥ���٤λ��� */
    };

/* �ʲ���ITRON4.0���ͤǻ��ꤵ�줿���� */
/* enum�ǻ��ꤹ����ϡ�enum�Υ������ϰ�¸���ˤ����ꤵ��� */

ENUM OBJECT_ATTR {
/*  	  TA_HLNG	=0x00u */
  	  TA_HLNG	=0		/* �������ѥ��󥿥ե����� */
 	, TA_ASM	=1		/* ������֥�����ѥ��󥿥ե����� */
};

#define TA_HLNG (0)
#define TA_ASM	(1)		/* ������֥�����ѥ��󥿥ե����� */

/* �ʲ��ϥ��ץꥱ��������ͭ���� */



/* �ʲ��ˤϥ����ӥ�������Υ��󥿥ե���������˻��Ѥ��뤿��η���������� */

    typedef UINT    	UW;
    typedef INT 	ER;
    typedef INT 	ER_BOOL;
    typedef INT 	ER_ID;
    typedef INT 	ER_UINT;
    typedef INT 	ID;
    typedef INT 	PRI;
    typedef bool_t 	BOOL;
    typedef void        *VP;
    /* , _bool_ int */
    typedef UINT 	MODE;
    /* typedef _vp_int_ VP_INT */
    typedef int         EXCNO;
    typedef UINT	ATR;		/* ���֥������Ȥ�°�� */

    typedef size_t      SIZE;

    typedef INT 	TMO;
    typedef UINT        RELTIM;
    typedef UW          SYSTIM;         

    /**/
    /* kernel.h����� */
    typedef UINT TEXPTN;
    typedef UINT FLGPTN;

����typedef void (*FP)(void);

    typedef struct t_msg {  /* �᡼��ܥå����Υ�å������إå� */
            struct t_msg    *next;
    } T_MSG;
    
    typedef struct t_msg_pri {              /* ͥ�����դ���å������إå� */
            T_MSG           msgque;         /* ��å������إå� */
            PRI             msgpri;         /* ��å�����ͥ���� */
    } T_MSG_PRI;
        
/* ��ITRON4.0����(Ver. 4.02.00) �Υ���������ɥץ��ե�����Ǥʤ���ΤΤ�����*/
/* TOPPERS/JSP�������ȼ����󶡤��륫���ͥ�Υ����ӥ�������Τ�����*/
/* TOPPERS/JSP�����¸���ǥ��ݡ��Ȥ����Ρ�*/
/* #define TMAX_LOGINFO	6 */

    typedef struct {
		UINT	logtype;		/* ��������μ��� */
		SYSTIM	logtim;			/* �������� */
		VP_INT	loginfo[TMAX_LOGINFO];	/* ����¾�Υ������� */
    } SYSLOG;

/* TOPPERS/JSP�������ȼ����󶡤��륫���ͥ�Υ����ӥ�������Τ�����*/
/* TOPPERS/JSP���������åȰ�¸���ǥ��ݡ��Ȥ����Ρ�*/


/* TOPPERS/JSP�������ȼ����󶡤��륵���ӥ�������Τ�����*/
/* ���󥿡��ե������β�᤬�������åȰ�¸�Ǥ����Ρ�*/
    typedef struct {
	UINT	reacnt;		/* �����Хåե����ʸ���� */
	UINT	wricnt;		/* �����Хåե����ʸ���� */
    } T_SERIAL_RPOR;

    /* ITRON4.0���ͥ���������ɥץ��ե�������Υ����ӥ��������signature */
    signature sKernel {
	/* �ʲ��ϥ���������ƥ������� */
    	ER act_tsk ( [in] ID tskid );
    	ER_UINT can_act ( [in] ID tskid );
    	void ext_tsk ( void );
    	ER ter_tsk ( [in] ID tskid );
    	ER chg_pri ( [in] ID tskid , [in] PRI tskpri );
    	ER get_pri ( [in] ID tskid , [out] PRI * p_tskpri );
    	ER slp_tsk ( void );
    	ER tslp_tsk ( [in] TMO tmout );
    	ER wup_tsk ( [in] ID tskid );
        ER_UINT can_wup ( [in] ID tskid );
        ER rel_wai  ( [in] ID tskid );
        ER sus_tsk  ( [in] ID tskid );
        ER rsm_tsk  ( [in] ID tskid );
        ER frsm_tsk ( [in] ID tskid );
        ER dly_tsk  ( [in] RELTIM dlytim );
        ER ras_tex  ( [in] ID tskid , [in] TEXPTN rasptn );
        ER dis_tex  ( void );
        ER ena_tex  ( void );
        ER sig_sem  ( [in] ID semid );
        ER wai_sem  ( [in] ID semid );
        ER pol_sem  ( [in] ID semid );
        ER twai_sem ( [in] ID semid , [in] TMO tmout );
        ER set_flg  ( [in] ID flgid , [in] FLGPTN setptn );
        ER clr_flg  ( [in] ID flgid , [in] FLGPTN clrptn );
        ER wai_flg  ( [in] ID flgid , [in] FLGPTN waiptn , [in] MODE wfmode , [out] FLGPTN * p_flgptn );
        ER pol_flg  ( [in] ID flgid , [in] FLGPTN waiptn , [in] MODE wfmode , [out] FLGPTN * p_flgptn );
        ER twai_flg ( [in] ID flgid , [in] FLGPTN waiptn , [in] MODE wfmode , [out] FLGPTN * p_flgptn , [in] TMO tmout );
        ER snd_dtq  ( [in] ID dtqid , [in] VP_INT data );
        ER psnd_dtq ( [in] ID dtqid , [in] VP_INT data );
        ER tsnd_dtq ( [in] ID dtqid , [in] VP_INT data , [in] TMO tmout );
        ER fsnd_dtq ( [in] ID dtqid , [in] VP_INT data );
        ER rcv_dtq  ( [in] ID dtqid , [out] VP_INT *p_data );
        ER prcv_dtq ( [in] ID dtqid , [out] VP_INT *p_data );
        ER trcv_dtq ( [in] ID dtqid , [out] VP_INT *p_data , [in] TMO tmout );
        ER snd_mbx  ( [in] ID mbxid ,  [send(sigAlloc)] T_MSG * pk_msg );
        ER rcv_mbx  ( [in] ID mbxid  , [receive(sigAlloc)] T_MSG * * ppk_msg);
        ER prcv_mbx ( [in] ID mbxid , [receive(sigAlloc)] T_MSG * * ppk_msg , int msgsize );
        ER trcv_mbx ( [in] ID mbxid , [receive(sigAlloc)] T_MSG * * ppk_msg , [in] TMO tmout , int msgsize );
        ER get_mpf  ( [in] ID mpfid , [receive(sigAlloc)] VP * p_blk , int msgsize );
        ER pget_mpf ( [in] ID mpfid , [receive(sigAlloc)] VP * p_blk , int msgsize );
        ER tget_mpf ( [in] ID mpfid , [out , receive(sigAlloc) , size_is(msgsize) ] VP * p_blk , [in] TMO tmout , int msgsize );
        ER rel_mpf ( [in] ID mpfid , [send(sigAlloc)] VP blk );
        ER set_tim ( [in] SYSTIM * p_systim );
        ER get_tim ( [out] SYSTIM * p_systim );
        ER sta_cyc ( [in] ID cycid );
        ER stp_cyc ( [in] ID cycid );
        ER rot_rdq ( [in] PRI tskpri );
        ER get_tid ( [out] ID * p_tskid );
        ER loc_cpu ( void );
        ER unl_cpu ( void );
        ER dis_dsp ( void );
        ER ena_dsp ( void );

	/* �ʲ����󥿥�������ƥ������� */
        ER iact_tsk ( [in] ID tskid );
        ER iwup_tsk ( [in] ID tskid );
        ER irel_wai ( [in] ID tskid );
        ER iras_tex ( [in] ID tskid , [in] TEXPTN rasptn );
        ER isig_sem ( [in] ID semid );
        ER iset_flg ( [in] ID flgid , [in] FLGPTN setptn );
        ER ipsnd_dtq ( [in] ID dtqid , [in] VP_INT data );
        ER ifsnd_dtq ( [in] ID dtqid , [in] VP_INT data );
        ER isig_tim ( void );
        ER irot_rdq ( [in] PRI tskpri );
        ER iget_tid ( [out] ID * p_tskid );
        ER iloc_cpu ( void );
        ER iunl_cpu ( void );

	/* �ʲ��ϥ���������ƥ����ȤǤ��󥿥�������ƥ����ȤǤ�ƤӽФ��� */
        BOOL sns_tex ( void );
        BOOL sns_ctx ( void );
        BOOL sns_loc ( void );
        BOOL sns_dsp ( void );
        BOOL sns_dpn ( void );


/* ��ITRON4.0����(Ver. 4.02.00) �Υ���������ɥץ��ե�����Ǥʤ���ΤΤ�����*/
/* TOPPERS/JSP���������åȰ�¸���ǥ��ݡ��Ȥ����Ρ�*/
	ER	dis_int( [in] INTNO intno);
	ER	ena_int( [in] INTNO intno);
	ER	chg_ipm( [in] IPM ipm);
	ER	get_ipm( [in] IPM *p_ipm);

/* TOPPERS/JSP�������ȼ����󶡤��륫���ͥ�Υ����ӥ�������Τ�����*/
/* TOPPERS/JSP�����¸���ǥ��ݡ��Ȥ����Ρ�*/
	BOOL vxsns_ctx( [in] VP p_excinf);
    	BOOL vxsns_loc( [in] VP p_excinf);
    	BOOL vxsns_dsp( [in] VP p_excinf);
    	BOOL vxsns_dpn( [in] VP p_excinf);
    	BOOL vxsns_tex( [in] VP p_excinf);
	BOOL vsns_ini(void);
	ER vwri_log( [in] UINT prio, [in] SYSLOG *p_log);
	ER_UINT vrea_log( [out] SYSLOG *p_log);
	ER vmsk_log( [in] UINT logmask, [in] UINT lowmask);

/* TOPPERS/JSP�������ȼ����󶡤��륫���ͥ�Υ����ӥ�������Τ�����*/
/* TOPPERS/JSP���������åȰ�¸���ǥ��ݡ��Ȥ����Ρ�*/
/*	 ER	vxget_tim(SYSUTIM *p_sysutim) throw(); */
	 ER	vxget_tim( [out] SYSUTIM *p_sysutim);

/* TOPPERS/JSP�������ȼ����󶡤��륵���ӥ�������Τ�����*/
/* ���󥿡��ե������β�᤬�������åȰ�¸�Ǥ����Ρ�*/
	ER serial_opn_por( [in] ID portid);
	ER serial_cls_por( [in] ID portid);
	/* ER_UINT serial_rea_dat(ID portid, char *buf, UINT len) */
	ER_UINT serial_rea_dat( [in] ID portid, [in] UINT len , [out , size_is(len)] char *buf);

/* ���ξ��ϡ����顼�ˤʤ�Ϥ�
	ER_UINT serial_rea_dat( [in] ID portid, [out] UINT len , [out , size_is(len)] char *buf);
*/
/* ���ξ��ϡ����顼�ˤʤ�Ϥ�
	ER_UINT serial_rea_dat( [in] ID portid, [in] UINT len , [out , count_is(len)] char *buf);
*/
	/* ER_UINT serial_wri_dat(ID portid, char *buf, UINT len) */
	ER_UINT serial_wri_dat( [in] ID portid,  [in] UINT len, [out , size_is(len)] char *buf);
	ER serial_ctl_por( [in] ID portid, [in]UINT ioctl);
	ER serial_ref_por( [in] ID portid, [out]T_SERIAL_RPOR *pk_rpor);

/* TOPPERS/JSP�������ȼ����󶡤���饤�֥�ꡡ*/
/* �ؿ��η���const�����Ǥ��ʤ� 
	const char *itron_strerror([in]ER ercd);
*/
/* �ؿ��η��˥ݥ��󥿷������Ǥ��ʤ�
	char *itron_strerror([in]ER ercd); 
*/
	char itron_strerror([in]ER ercd);
/* �ؿ��ΰ����η���const�����Ǥ��ʤ�
	void t_perror([in]UINT prio, [in]const char *file, [in]int line, [in]const char *expr, [in]ER ercd); 
*/
	void t_perror([in]UINT prio, [in] char *file, [in]int line, [in] char *expr, [in]ER ercd);

    };
/*}; */
