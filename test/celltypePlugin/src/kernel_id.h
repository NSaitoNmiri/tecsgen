
/*
 * ���Υե�����ϡ�����ѥ��롢��󥯤�������̤����Ȥ�������Ū�Ȥ�����
 * ����줿��ΤǤ��롣ư�����Τˤ����Ω���ʤ���
 */
#define	DeclareTask( Task )
#define	TASK( t )	void tTask_##t()

#define DeclareResource( Resource )
#define ISR( i )	void tISR_##i()

#define	DeclareAlarm( Alarm1 )
#define	ALARMCALLBACK( SampleCallback )	void tAlarm_##SampleCallback()
