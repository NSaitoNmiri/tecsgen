#ifndef __errno2ER_h_
#define __errno2ER_h_

/* POSIX errno ‚ð ITRON,TOPPERS/ASP ER ‚É•ÏŠ· */
Inline
ER errno2ER( int err_no )
{
	ER	er;

	switch( err_no ){
	case EWOULDBLOCK: /* EAGAIN ‚Æ“¯‚¶ */
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
		er = E_OBJ;		/* ‚Æ‚è‚ ‚¦‚¸ E_OBJ ‚Æ‚·‚é */
		break;
	}

	return er;
}

#endif /* __errno2ER_h_ */

