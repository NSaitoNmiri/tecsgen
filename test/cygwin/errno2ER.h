#ifndef __errno2ER_h_
#define __errno2ER_h_

/* POSIX errno �� ITRON,TOPPERS/ASP ER �ɕϊ� */
Inline
ER errno2ER( int err_no )
{
	ER	er;

	switch( err_no ){
	case EWOULDBLOCK: /* EAGAIN �Ɠ��� */
		er = E_WBLK;
		break;
	case ENOMEM:
		er = E_NOMEM;
		break;
	case EBADF:
		er = E_NOEXS;
		break;
	case EPIPE:
		er = E_CLS;
		break;
	default:
		er = E_OBJ;		/* �Ƃ肠���� E_OBJ �Ƃ��� */
		break;
	}

	return er;
}

#endif /* __errno2ER_h_ */

